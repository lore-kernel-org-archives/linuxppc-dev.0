From: "Jeffrey D. Kowing" <jeffrey.d.kowing1@jsc.nasa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15456.16854.183292.343027@igor.jsc.nasa.gov>
Date: Tue, 5 Feb 2002 14:34:30 -0600
To: linuxppc-dev@lists.linuxppc.org
Subject: io.h and I/O port access from user space
Reply-To: jeffrey.d.kowing1@jsc.nasa.gov
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This question concerns ISA ioport access from user space and
<sys/io.h>.  I know there has been several discussions on this in the
mailing lists, e.g.

  http://lists.linuxppc.org/linuxppc-dev/200003/msg00076.html

By the way, when attempting to consult the FAQ,
http://penguinppc.org/projects/faq.shtml,
it seemed to be a dead link.

I was trying to compile (actually cross-compile) the isapnptools
utilities.  The program accesses ISA io ports using inb/outb from user
space.  When compiling, I got errors because it could not find
<sys/io.h> which, when I look on my i386 platform, defines the
inb/outb functions and is part of glibc (although cleary it is
platform dependent).

The powerpc glibc does not install this file, at least for both
yellowdog 2.1 and on the MontaVista Journeyman 2.1 distributions.

I foolishly simply linked <asm/io.h> to <sys/io.h> (I'm talking about
my powerpc system include files of course) but that does not work, if,
for no other reason, that the asm-ppc/io.h file is protected from user
space programs with #ifdef __KERNEL__.

So, I guess my questions are as follows:

Is there suppose to be a <sys/io.h> for powerpc platforms ?

What include file should I use to get inb/outb defined for a user
space program.  (This is a linuxppc 2.4.x kernel I'm working with.)

I guess it is still the case for the linuxppc-2.4.x series that I need
to mmap /dev/mem first as per Geert's advice in
http://lists.linuxppc.org/linuxppc-dev/200003/msg00076.html advice?

Has anyone in powerpc land used the isapnptools ?

Thanks.  I really appreciate this excellent list and all the folks
that make Linux/PPC possible!

--
Jeff Kowing
jeffrey.d.kowing1@jsc.nasa.gov

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
