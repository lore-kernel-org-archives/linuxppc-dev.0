Date: Fri, 30 Apr 1999 11:42:34 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Frodo Looijaard <frodol@dds.nl>
cc: lm78@stimpy.netroedge.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: Support for Hydra i2c
In-Reply-To: <199904281409.QAA01267@arda.frodo.local>
Message-ID: <Pine.LNX.4.10.9904301131290.30345-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 28 Apr 1999, Frodo Looijaard wrote:
> Geert Uytterhoeven wrote:
> > The attached patch adds support for the i2c interface on the Apple `Hydra' Mac
> > I/O, found on CHRP PPC motherboards. The patch is relative to the anon CVS
> > version of yesterday evening.
> 
> Congratulations! You are the first to add support for a non-Intel 
> architecture. I am very excited by your contribution! To be honest, I did
> not even know the PPC architecture had an I2C interface. Very nice indeed!
> 
> I will merge your code in later today, and if necessary I will send you some
> feedback on it. You may want CVS write access; it will make maintaining 

You seem to have missed these:

Index: doc/modules
===================================================================
RCS file: /home/cvs/lm_sensors2/doc/modules,v
retrieving revision 1.11
diff -u -r1.11 modules
--- doc/modules	1999/04/22 13:06:24	1.11
+++ doc/modules	1999/04/30 09:36:58
@@ -67,6 +67,9 @@
   SMBus emulation on i2c busses. Base algorithm, on which SMBus-only adapters
   rely.
 
+(src/busses) i2c-hydra: algo-bit i2c-core
+  Apple Hydra Mac I/O bus access on CHRP motherboards.
+
 (src/busses) i2c-isa: i2c-core
   Defines the ISA bus as being a I2C adapter. It isn't, of course; but this is
   often used by sensor client modules, to keep the code small and simple.
Index: prog/dump/isadump.c
===================================================================
RCS file: /home/cvs/lm_sensors2/prog/dump/isadump.c,v
retrieving revision 1.3
diff -u -r1.3 isadump.c
--- prog/dump/isadump.c	1999/04/28 18:18:12	1.3
+++ prog/dump/isadump.c	1999/04/30 09:36:59
@@ -99,7 +99,7 @@
   sleep(5);
 
 #ifndef __powerpc__
-  if ((datareg < 0x400) && (datareg < 0x400)) {
+  if ((datareg < 0x400) && (addrreg < 0x400)) {
     if(ioperm(datareg,1,1)) {
       fprintf(stderr,"Error: Could not ioperm() data register!\n");
       exit(1);

The last one is a typo, I assume. BTW, the ISA stuff doesn't work anyway,
because on PPC the macros inb() and outb() rely on isa_io_base pointed to the
mmap()ed ISA IO space. But I don't think that matters much: this was the `quick
fix', just removing isadump from the compile list on PPC seemed to be more
difficult :-)

A datasheet for the Hydra used to be available on the web, cfr.
include/asm-ppc/hydra.h:

 *  This file is based on the following documentation:
 *
 *      Macintosh Technology in the Common Hardware Reference Platform
 *      Apple Computer, Inc.
 *
 *      © Copyright 1995 Apple Computer, Inc. All rights reserved.
 *
 *  It's available online from http://chrp.apple.com/MacTech.pdf.
 *  You can obtain paper copies of this book from computer bookstores or by
 *  writing Morgan Kaufmann Publishers, Inc., 340 Pine Street, Sixth Floor, San
 *  Francisco, CA 94104. Reference ISBN 1-55860-393-X.

but Apple removed the DNS A record for chrp.apple.com :-( Fortunately I still
have the doc on CD.

BTW, doc/busses/i2c-hydra and kernel/busses/i2c-hydra.c contain carriage
returns now.

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
