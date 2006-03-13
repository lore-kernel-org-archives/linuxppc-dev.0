Return-Path: <antonio.dibacco@aruba.it>
Received: from smtpa4.aruba.it (smtpa4.aruba.it [62.149.128.201])
	by ozlabs.org (Postfix) with SMTP id 80CF5679EA
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Mar 2006 08:29:21 +1100 (EST)
From: Antonio Di Bacco <antonio.dibacco@aruba.it>
To: linuxppc-embedded@ozlabs.org
Subject: Re: pppd in eldk
Date: Mon, 13 Mar 2006 22:33:03 +0100
References: <20060313000630.5056C353A57@atlas.denx.de>
In-Reply-To: <20060313000630.5056C353A57@atlas.denx.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_PUeFESFvB2kmRlx"
Message-Id: <200603132233.03442.antonio.dibacco@aruba.it>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--Boundary-00=_PUeFESFvB2kmRlx
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I compiled pppd 2.4.3 slightly modifying the Makefile (attached). Now I want 
to use it to connect two segments of the same LAN. I'm working.

Bye,
Antonio.

On Monday 13 March 2006 01:06, Wolfgang Denk wrote:
> In message <200603121913.56832.antonio.dibacco@aruba.it> you wrote:
> > I didn't find the ppp package in denx eldk, I tried to cross compile the
>
> It's not included so far.
>
> > sources (from sourceforge) but I received some errors (pcap_t
> > undeclared). Before I continue I would investigate if someone was already
> > successful with ppp on ppc.
>
> We built it once for some of our  customers  (for  ARM  and  ppc_8xx,
> IIRC); I can't remember of any specific problems.
>
> If cross compiling is too time-consuming  you  can  also  compile  it
> natively  on the target system - this may take more machine time, but
> less developer's time ;-)
>
> Best regards,
>
> Wolfgang Denk

--Boundary-00=_PUeFESFvB2kmRlx
Content-Type: text/x-makefile;
  charset="iso-8859-1";
  name="Makefile"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Makefile"

#
# pppd makefile for Linux
# $Id: Makefile.linux,v 1.66 2004/11/13 12:02:22 paulus Exp $
#

ROOTDIR = /opt/eldk/ppc_8xx/

# Default installation locations
DESTDIR = $(ROOTDIR)usr/local
BINDIR = $(DESTDIR)/sbin
MANDIR = $(DESTDIR)/share/man/man8
INCDIR = $(DESTDIR)/include



TARGETS = pppd

PPPDSRCS = main.c magic.c fsm.c lcp.c ipcp.c upap.c chap-new.c md5.c ccp.c \
	   ecp.c ipxcp.c auth.c options.c sys-linux.c md4.c chap_ms.c \
	   demand.c utils.c tty.c eap.c chap-md5.c

HEADERS = ccp.h chap-new.h ecp.h fsm.h ipcp.h \
	ipxcp.h lcp.h magic.h md5.h patchlevel.h pathnames.h pppd.h \
	upap.h eap.h

MANPAGES = pppd.8
PPPDOBJS = main.o magic.o fsm.o lcp.o ipcp.o upap.o chap-new.o md5.o ccp.o \
	   ecp.o auth.o options.o demand.o utils.o sys-linux.o  tty.o \
	   eap.o chap-md5.o

#
# include dependencies if present
ifeq (.depend,$(wildcard .depend))
include .depend
endif

CC = ${CROSS_COMPILE}gcc
LD = ${CROSS_COMPILE}ld
AS = ${CROSS_COMPILE}as
#
COPTS = -O2 -pipe -Wall -g
LIBS =

# Uncomment the next 2 lines to include support for Microsoft's
# MS-CHAP authentication protocol.  Also, edit plugins/radius/Makefile.linux.
#CHAPMS=y
#USE_CRYPT=y
# Don't use MSLANMAN unless you really know what you're doing.
#MSLANMAN=y
# Uncomment the next line to include support for MPPE.  CHAPMS (above) must
# also be enabled.  Also, edit plugins/radius/Makefile.linux.
#MPPE=y

# Uncomment the next line to include support for PPP packet filtering.
# This requires that the libpcap library and headers be installed
# and that the kernel driver support PPP packet filtering.
#FILTER=y

# Uncomment the next line to enable multilink PPP (enabled by default)
# Linux distributions: Please leave multilink ENABLED in your builds
# of pppd!
#HAVE_MULTILINK=y

# Uncomment the next line to enable the TDB database (enabled by default.)
# If you enable multilink, then TDB is automatically enabled also.
# Linux distributions: Please leave TDB ENABLED in your builds.
#USE_TDB=y

#HAS_SHADOW=y
#USE_PAM=y
#HAVE_INET6=y

# Enable plugins
#PLUGIN=y

# Enable Microsoft proprietary Callback Control Protocol
#CBCP=y

# Enable EAP SRP-SHA1 authentication (requires libsrp)
#USE_SRP=y

MAXOCTETS=y

INCLUDE_DIRS= -I../include

COMPILE_FLAGS= -DHAVE_PATHS_H -DHAVE_MMAP

CFLAGS= $(COPTS) $(COMPILE_FLAGS) $(INCLUDE_DIRS)

ifdef CHAPMS
CFLAGS   += -DCHAPMS=1
NEEDDES=y
PPPDOBJS += md4.o chap_ms.o
HEADERS	+= md4.h chap_ms.h
ifdef MSLANMAN
CFLAGS   += -DMSLANMAN=1
endif
ifdef MPPE
CFLAGS   += -DMPPE=1
endif
endif

# EAP SRP-SHA1
ifdef USE_SRP
CFLAGS	+= -DUSE_SRP -DOPENSSL -I$(ROOTDIR)usr/local/ssl/include
LIBS	+= -lsrp -L$(ROOTDIR)usr/local/ssl/lib -lcrypto
TARGETS	+= srp-entry
EXTRAINSTALL = $(INSTALL) -s -c -m 555 srp-entry $(BINDIR)/srp-entry
MANPAGES += srp-entry.8
EXTRACLEAN += srp-entry.o
NEEDDES=y
else
# OpenSSL has an integrated version of SHA-1, and its implementation
# is incompatible with this local SHA-1 implementation.  We must use
# one or the other, not both.
PPPDSRCS += sha1.c
HEADERS += sha1.h
PPPDOBJS += sha1.o
endif

ifdef HAS_SHADOW
CFLAGS   += -DHAS_SHADOW
#LIBS     += -lshadow $(LIBS)
endif

ifneq ($(wildcard $(ROOTDIR)usr/include/crypt.h),)
CFLAGS   += -DHAVE_CRYPT_H=1
endif
ifneq ($(wildcard $(ROOTDIR)usr/lib/libcrypt.*),)
LIBS	+= -lcrypt
endif

ifdef NEEDDES
ifndef USE_CRYPT
LIBS     += -ldes $(LIBS)
else
CFLAGS   += -DUSE_CRYPT=1
endif
PPPDOBJS += pppcrypt.o
HEADERS += pppcrypt.h
endif

# For "Pluggable Authentication Modules", see ftp.redhat.com:/pub/pam/.
ifdef USE_PAM
CFLAGS   += -DUSE_PAM
LIBS     += -lpam -ldl
endif

# Multi-linnk
ifdef HAVE_MULTILINK
	# Multilink implies the use of TDB
	USE_TDB=y

	CFLAGS += -DHAVE_MULTILINK
	PPPDSRCS += multilink.c
	PPPDOBJS += multilink.o
endif

# TDB
ifdef USE_TDB
	CFLAGS += -DUSE_TDB=1
	PPPDSRCS += tdb.c spinlock.c
	PPPDOBJS += tdb.o spinlock.o
	HEADERS += tdb.h spinlock.h
endif

# Lock library binary for Linux is included in 'linux' subdirectory.
ifdef LOCKLIB
LIBS     += -llock
CFLAGS   += -DLOCKLIB=1
endif

ifdef PLUGIN
CFLAGS	+= -DPLUGIN
LDFLAGS	+= -Wl,-E
LIBS	+= -ldl
endif

ifdef FILTER
ifneq ($(wildcard $(ROOTDIR)usr/include/pcap-bpf.h),)
LIBS    += -lpcap
CFLAGS  += -DPPP_FILTER
endif
endif

ifdef HAVE_INET6
     PPPDSRCS += ipv6cp.c eui64.c
     HEADERS  += ipv6cp.h eui64.h
     PPPDOBJS += ipv6cp.o eui64.o
     CFLAGS   += -DINET6=1
endif

ifdef CBCP
     PPPDSRCS += cbcp.c
     PPPDOBJS += cbcp.o
     CFLAGS += -DCBCP_SUPPORT
     HEADERS += cbcp.h
endif

ifdef MAXOCTETS
     CFLAGS += -DMAXOCTETS
endif

INSTALL= install

all: $(TARGETS)

install: pppd
	mkdir -p $(BINDIR) $(MANDIR)
	$(EXTRAINSTALL)
	$(INSTALL) -s -c -m 555 pppd $(BINDIR)/pppd
	if chgrp pppusers $(BINDIR)/pppd 2>/dev/null; then \
	  chmod o-rx,u+s $(BINDIR)/pppd; fi
	$(INSTALL) -c -m 444 pppd.8 $(MANDIR)

pppd: $(PPPDOBJS)
	$(CC) $(CFLAGS) $(LDFLAGS) -o pppd $(PPPDOBJS) $(LIBS)

srp-entry:	srp-entry.c
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ srp-entry.c $(LIBS)

install-devel:
	mkdir -p $(INCDIR)/pppd
	$(INSTALL) -c -m 644 $(HEADERS) $(INCDIR)/pppd

clean:
	rm -f $(PPPDOBJS) $(EXTRACLEAN) $(TARGETS) *~ #* core

depend:
	$(CPP) -M $(CFLAGS) $(PPPDSRCS) >.depend

--Boundary-00=_PUeFESFvB2kmRlx--
