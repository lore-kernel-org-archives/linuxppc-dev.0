Message-Id: <200001132334.AAA20102@denx.local.net>
To: "Linux PPC Embedded" <linuxppc-embedded@lists.linuxppc.org>,
        "Linux PPC Dev" <linuxppc-dev@lists.linuxppc.org>
Cc: greyham@research.canon.com.au (Graham Stoney),
        rene.pachernegg@apus.co.at (Reni Pachernegg),
        "Dan Dickey" <ddickey@charter.net>, kd@flaga.is
Subject: [ANNOUNCE] Build Scripts for MPC8xx Cross Development Tools
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Date: Fri, 14 Jan 2000 00:34:01 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Summary: I've put the scripts I'm using to build the PPC Cross
Development Kit for the MPC8xx CPUs on

	ftp://ftp.denx.de/pub/LinuxPPC/usr/src/CDK.tar.gz



Every few days the same topic comes  up:  somebody  is  running  into
trouble  while trying to build the cross development tools to compile
code for (embedded) PowerPC systems using Linux  on  an  Intel  PC...
It's a waste of time when everybody has to re-invent the wheel...

So I decided to put my scripts on a FTP server:

What I tried to create is a  working,  reproducable  build  procedure
that enables you to add individual patches for certain configurations
or problems.

Contents of CDK.tar.gz:

ENVIRONMENT:
        This file is used to  control  the  whole  build  environment
        (path  names,  versions of packages to be used) - this should
        be the only file you need to adapt to your filesystem layout.

Makefile:
        Central  Makefile.  Type  "make  EGCS"  to  build   binutils,
        egcs-core, Linux (zImage), and the final egcs (C and C++).

patches:
        Collection of misc patches against the original source
        tarballs; this includes:
	- patch to glibc to use soft-float
	- patch to Linux to support the TQM8xxL systems
        - patch to Linux to support the TQM8xxL on-board FLASH memory
          as character device
        - patch to Linux for FLASH Translation Layer on TQM8xxL
          (gives you full filesystem capability on the on-board
          FLASH)
	- patch to Linux for standalone shell

Not included in this tarball are the original source packages that  I
used;to make sure everybody has the same starting point here the list
or URL where I got the sources from:

ftp://ftp.valinux.com/pub/support/hjl/binutils/binutils-2.9.5.0.22.tar.bz2
ftp://ftp.sunet.se/pub/gnu/egcs/releases/gcc-2.95.2/gcc-core-2.95.2.tar.bz2
ftp://ftp.sunet.se/pub/gnu/egcs/releases/gcc-2.95.2/gcc-2.95.2.tar.bz2
ftp://ftp.sunet.se/pub/gnu/glibc/glibc-2.1.2.tar.gz
ftp://ftp.gwdg.de/pub/linux/glibc/2.1.2/glibc-crypt-2.1.2.tar.gz
ftp://ftp.sunet.se/pub/gnu/glibc/glibc-linuxthreads-2.1.2.tar.gz
ftp://linuxppc.cs.nmt.edu/pub/mirror/PPC/embedded/mpc8xx-2.2.13.tgz
	(renamed to linux-2.2.13.tar.gz)

My method of applying a set of individual patches against the  origi-
nal  sources (rather than providing a pre-patched "working" solution)
has several reasons: it allows to add or remove specific patches,  it
makes  it  possible  to  switch  to  other  versions  of the original
sources, and you can take the scripts another step and build RPM's.

[There is basicly no dependency checking in the Makefiles;  when  you
type  "make target" you will always remove the existing files and run
the whole build process for this target from the very  beginning.  If
you don't like this, then fix it.]


NOTE: I do not claim that everything is  working  perfectly,  but  it
works for me, and a copule of my customers.

I'm using this environment in several projects running  Linux  2.2.13
on  MPC8xx  systems, mostly on the mini-modules by TQ Systems (MPC8xx
with up to 64 MB RAM, 8MB FLASH, 4 x RS232, TP Ethernet, USB, CAN  on
54x44  mm²  =  less  than  half  the  size  of  a  credit  card!  see
http://www.tqs.de/HTM_Files/TQM8xx_Serie.htm)



ALL type of feedback is welcome,  especially  all  contributions  for
improvement.

Wolfgang

- -- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
All these theories, diverse as they are, have two things  in  common:
they explain the observed facts, and they are completeley and utterly
wrong.                       - Terry Pratchett, _The Light Fantastic_

------- End of Unsent Draft

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
