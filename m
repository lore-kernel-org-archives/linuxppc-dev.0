Message-ID: <DB0585C9F6F9D411BE8F00D0B7896A4CC0601E@SNCMAIL>
From: James Don <JDon@spacebridge.com>
To: James Don <JDon@spacebridge.com>,
	"'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: SELF: compile of util-linux
Date: Thu, 9 Jan 2003 20:43:52 -0500 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Scratch question 2 ...
I thin the answer is that "patch" basically buts in the files necessary to
build a cross compiled version of "util-linux" .... after I patch I think
this will mean that the SED command will find some matches ...

I didn't need the "patch part" to build busy box (0.60.5) when I tried ...
so I thought I could skip it ...

I think anyways,
Jim

-----Original Message-----
From: James Don
Sent: Thursday, January 09, 2003 8:36 PM
To: linuxppc-embedded@lists.linuxppc.org
Subject: SELF: compile of util-linux

Hi,

I am just browsing through the SELF code ... and trying for kicks to make
"my own version" as an exercise to learn more about packages required for a
running embedded Linux system ...

So far I have ...

1.) Built uclibc
2.) Built busybox with uclibc gcc wrappers
3.) Built insmod with uclibc gcc wrappers

I am reading the compile of util-linux (see below item 1) ... I am
relatively new to linux so I have some questions (most of which are probably
stupid seeing as just started looking at this)...

1.) The "patch" part of the compile ... is it to add kernel support for what
I am compiling? If I managed to get a pre-built image to run on an unpatched
kernel what am I missing?

2.) When you run the "sed -e 's/XXX-powerpc-linux-/$(CROSS_PREFIX)/" I
assume this should go into the make sysyem and put the cross compiler in the
build ? ... sorry never used "sed" just skimmed the man page

3.) For kicks I have taken the tar ball I downloaded of util-linux (version
2.11y) and tried to compile it with the uclibc gcc wrappers (see item 2
below) ... now this does when I get to the "make part" ... it seems to die
because "configure" was not called ... but its not called from SELF's make
file either ??? If I call make from the util-linux directory it calls
configure ... but then uses my local 'cc' ...

Any tips would be great ;-) In the mean time I will keep digging and
hopefully see what's wrong with my script ;-)

Best regards,
Jim



item 1
============
$(LOGIN)/login-utils/login: $(LOGIN)/.patch
	$(MAKE) -C $(LOGIN)/lib
	$(MAKE) -C $(LOGIN)/login-utils login

$(LOGIN)/.patch: $(CONFIGURATION) \
		$(TARBALLS)/util-linux-$(LOGIN_VERSION).tar.gz \
		$(PATCHES)/util-linux-$(LOGIN_VERSION)-cross.$(P_SUFF) \

$(PATCHES)/util-linux-$(LOGIN_VERSION)-nosetproctitle.$(P_SUFF) \
		$(CONFIG)/config.mk
	rm -fr $(LOGIN)
	cd $(BUILD) && \
	gzip -cd $(TARBALLS)/util-linux-$(LOGIN_VERSION).tar.gz | tar xf -
	cd $(LOGIN) && \
	sed -e 's/XXX-powerpc-linux-/$(CROSS_PREFIX)/' \

$(PATCHES)/util-linux-$(LOGIN_VERSION)-cross.$(P_SUFF) | \
		patch -p1 -b -z.cross && \
	patch -p1 -b -z.no_sp
<$(PATCHES)/util-linux-$(LOGIN_VERSION)-nosetproctitle.$(P_SUFF) && \
	touch .patch

item 2
==============
#!/usr/bin/bash

LOGIN_UTIL_VERSION=2.11y
LOGIN_BUILD_DIR=$HOME/ppcLoginUtil/

CROSS=powerper-uclibc-

echo LOGIN_BUILD_DIR=$LOGIN_BUILD_DIR

rm -fr $LOGIN_BUILD_DIR/util-linux-$LOGIN_UTIL_VERSION
tar xvfz $LOGIN_BUILD_DIR/util-linux-$LOGIN_UTIL_VERSION.tar.gz
cd $LOGIN_BUILD_DIR/util-linux-$LOGIN_UTIL_VERSION

sed -e 's/XXX-powerpc-linux-/$CROSS/' *

make -C $LOGIN_BUILD_DIR/util-linux-$LOGIN_UTIL_VERSION/lib
make -C $LOGIN_BUILD_DIR/util-linux-$LOGIN_UTIL_VERSION/login-utils login

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
