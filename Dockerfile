FROM debian:wheezy
MAINTAINER yohan <783b8c87@scimetis.net>
ENV DEBIAN_FRONTEND noninteractive
RUN echo "deb http://http.debian.net/debian wheezy-backports main" >> /etc/apt/sources.list
RUN apt-get update && apt-get -y install dovecot-core dovecot-imapd dovecot-managesieved dovecot-sieve dovecot-solr dovecot-antispam dovecot-lmtpd
# IMAPS
EXPOSE 993
# MANAGESIEVE
EXPOSE 4190
# LMTP
#EXPOSE 24
COPY 10-master.conf /etc/dovecot/conf.d/
COPY 10-logging.conf /etc/dovecot/conf.d/
COPY 10-auth.conf /etc/dovecot/conf.d/
COPY 15-lda.conf /etc/dovecot/conf.d/
COPY 20-lmtp.conf /etc/dovecot/conf.d/
COPY users /etc/dovecot/
RUN mkdir /home/yohan
RUN chown -R 1000:1000 /home/yohan
ENTRYPOINT ["/usr/sbin/dovecot", "-F", "-c", "/etc/dovecot/dovecot.conf"]
