Message-ID: <21A8AE56EBB6D411A4520060973D360101A9F70C@PEPINTERCOM>
From: Claus Gindhart <Claus.Gindhart@kontron.com>
To: "'BREUVART Jean-Charles'" <jean-charles.breuvart@airbus.com>,
	"'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: pb compiling cross gcc, binutils, glibc and so on ...
Date: Thu, 19 Dec 2002 16:14:29 +0100
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


A good and stable binary package of a complete gcc cross toolchain
is supplied with SuSE Linux 8.0.

This is the version:
----
claugi@claugi-wnt:~> /opt/cross/bin/powerpc-linux-gcc --version
2.95.3
---
I used with cross-toolchain succesfully on various PowerPC platforms.
It is no problem to install a SuSE RPM on a redhat system, if you
have no fear to do a "rpm -i --nodeps".

Unfortunatley these funny guys decided to remove this package in
their new 8.1 package; but maybe they have it still available for
download, or You can purchase a 8.0 version.

-----Original Message-----
From: BREUVART Jean-Charles [mailto:jean-charles.breuvart@airbus.com]
Sent: Donnerstag, 19. Dezember 2002 15:52
To: 'linuxppc-embedded@lists.linuxppc.org'
Subject: pb compiling cross gcc, binutils, glibc and so on ...



Hello world !

I'm trying to create a cdk, the host is a PIII runnning RedHat 8.0 (kernel
2.4.18), and the target is GNU kernel 2.4.20 running on a PPC755B
proprietary board. I've read lots of HOWTOs but I haven't succeeded yet !!!

RedHat 8.0 comes with gcc 3.2, binutils 2.13.90.0.2, make 3.79.1, I don't
know how to get the libc version ...

One told me that gcc 3.2 wasn't a nice version to create a cross-compiler
(actually, I've tried and this seems to be true), so I've downloaded from
www.gnu.org the following :

 - gcc-2.95.3.tar.gz and gcc-core-2.95.3.tar.gz
 - binutils-2.13.90.0.4.tar.gz and binutils-2.12.90.0.7.tar.gz
 - glibc-2.3.tar.gz and glibc-linuxthreads-2.3.tar.gz
 - make-3.80.tar.gz
 - linux-src-2.4.20.tar.gz

I' succeeded in building a native gcc 2.95.3 and make 3.8, and used them to
create the famous Hello world C program, actually all that stuff works. But
I still remain to encounter pb while creating the cdk !!!

here is what I did :

 1. restrict $PATH to /sbin:/bin:/usr/sbin:/usr/bin
 2. build a native gcc core 2.95.3 from scratch in /usr/src/gcc-2.95.3/ dir,
and install it in /usr/local/ (the default) :
      - cd /usr/src/gcc-2.95.3/
      - make clean
      - make distclean
      - ./configure --enable-languages=c,c++ ; this uses my RedHat
distribution's cc, which link to gcc
      - make bootstrap
      - make install
 3 build make 3.80 in /usr/src/make-3.80/ dir, and install it in /usr/local/
(the default) :
      - cd /usr/src/make-3.80/
      - make clean
      - make distclean
      - CC=/usr/local/bin/gcc ./configure (I don't know if it's better to
use gcc 2.95.3 or gcc 3.2, however, this uses RedHat distribution's binutils
!)
      - make
      - make install
 4. build binutils 2.12.90.0.7 for powerpc cross compile, and install it in
/opt/powerpc-linux/ :
      - cd /usr/src/binutils
      - make clean
      - make distclean
      - CC=/usr/local/bin/gcc ./configure --target=powerpc-linux
--enable-shared --with-newlib --prefix=/opt/powerpc-linux (I still don't
know if it's better to use gcc 2.95.3 or gcc 3.2)
      - make
      - make install
5. build gcc core 2.95.3 for powerpc cross compile, and install it in
/opt/powerpc-linux/ :
      - cd /usr/src/gcc-2.95.3/
      - make clean
      - make distclean
      - CC=/usr/local/bin/gcc ./configure --target=powerpc-linux
--enable-shared --enable-languages=c --with-newlib
--prefix=/opt/powerpc-linux
      - add /opt/powerpc-linux at the end of $PATH, otherwise make doesn't
find powerpc-linux-as, powerpc-linux-ld and so on
      - make

Here is the trouble :

choose-temp.c:29: stdio.h: Aucun fichier ou r?pertoire de ce type
choose-temp.c:30: sys/types.h: Aucun fichier ou r?pertoire de ce type
choose-temp.c:32: unistd.h: Aucun fichier ou r?pertoire de ce type
choose-temp.c:35: stdlib.h: Aucun fichier ou r?pertoire de ce type
choose-temp.c:38: sys/file.h: Aucun fichier ou r?pertoire de ce type

there aren't any of those in /opt/powerpc-linux/ or its subdirs

this the same trouble I had when I tried to build directly a cross gcc
2.95.2 for powerpc-linux with my RedHat distribution's gcc and binutils ...

So here are my questions :

 - did anyone do that before ?
 - does a pre-compiled version of such a cross dev toolsets already exists
for x86-pc-linux or sparc-sun ? I heard about "ELDK"
by Wolfgang Denk
 - is what I did wrong ?
 - where should the cross gcc build process search for those headers ? How
to indicate it ?
 - must I use native binutils or cross binutils to build a cross gcc ?
 - to build the bin utilities, including binutils, for the embedded linux
kernel's filesystem that will run on the PPC755B, I think I'll use the cross
gcc to build them from their source code ? I think that the one build in 4.
won't run, they only run on my host ?

if needed, I can change my host and use a Sun Workstation runnning SunOS
5.5.1 ...

So thanks in advance.

Regards,

Jean-Charles Breuvart

This e-mail is intended only for the above addressee. It may contain
privileged information. If you are not the addressee you must not copy,
distribute, disclose or use any of the information in it. If you have
received it in error please delete it and immediately notify the sender.
Security Notice: all e-mail, sent to or from this address, may be
accessed by someone other than the recipient, for system management and
security reasons. This access is controlled under Regulation of
Investigatory Powers Act 2000, Lawful Business Practises.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
