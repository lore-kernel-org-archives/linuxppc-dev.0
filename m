From: linas@austin.ibm.com
Date: Fri, 12 Sep 2003 12:00:37 -0500
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] ppc64 kernel 2.6 ide-related patches (revised)
Message-ID: <20030912120037.A26892@forte.austin.ibm.com>
References: <20030911112823.A27066@forte.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030911112823.A27066@forte.austin.ibm.com>; from linas@austin.ibm.com on Thu, Sep 11, 2003 at 11:28:23AM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The patch below, against the kernel-2.5 ppc64 bk of 28 august, allows
the IDE code to compile and work with ide disks & cdrom's.

I tested with a 30GB hard drive, and am able to mount, create and copy
files around.  I verified that the endianess of the data on the disk
is compatible by physically taking the disk to an i386 machine, and
examining it there.

Note, however, the following caveats:

-- the current code does *not* auto-negotiate itself up into the
   highest possible performance mode.  (i.e. 32 bit transfers, dma on,
   etc.)  This appears to be due to the fact that this task is normally
   done by i386 BIOS, and the ppc open firmware doesn't do anything
   analogous, and there's nothing in the kernel (that I know of) to
   make up for this.

-- My machine hung when I did hdparm -T -t on the disk.  I don't know why.
   It doesn't hang when I use 2.4 kernels.  Will try to investigate.

Please apply these patches soon!

--linas

--- arch/ppc64/kernel/misc.S.orig	2003-09-11 17:08:52.000000000 -0500
+++ arch/ppc64/kernel/misc.S	2003-09-11 17:09:47.000000000 -0500
@@ -359,7 +359,7 @@ _GLOBAL(_outsl)
 	bdnz	00b
 	blr

-_GLOBAL(ide_insw)
+/* _GLOBAL(ide_insw) now in drivers/ide/ide-iops.c */
 _GLOBAL(_insw_ns)
 	cmpwi	0,r5,0
 	mtctr	r5
@@ -371,7 +371,7 @@ _GLOBAL(_insw_ns)
 	bdnz	00b
 	blr

-_GLOBAL(ide_outsw)
+/* _GLOBAL(ide_outsw) now in drivers/ide/ide-iops.c */
 _GLOBAL(_outsw_ns)
 	cmpwi	0,r5,0
 	mtctr	r5

--- include/asm-ppc64/io.h.orig	2003-09-11 17:04:15.000000000 -0500
+++ include/asm-ppc64/io.h	2003-09-12 11:22:37.000000000 -0500
@@ -17,6 +17,12 @@
 #include <asm/memory.h>
 #include <asm/delay.h>

+#define __ide_mm_insw(p, a, c) _insw_ns((volatile u16 *)(p), (a), (c))
+#define __ide_mm_insl(p, a, c) _insl_ns((volatile u32 *)(p), (a), (c))
+#define __ide_mm_outsw(p, a, c) _outsw_ns((volatile u16 *)(p), (a), (c))
+#define __ide_mm_outsl(p, a, c) _outsl_ns((volatile u32 *)(p), (a), (c))
+
+
 #define SIO_CONFIG_RA	0x398
 #define SIO_CONFIG_RD	0x399

@@ -93,7 +99,7 @@ extern void _outsl_ns(volatile u32 *port
 #define inw_p(port)             inw(port)
 #define outw_p(val, port)       (udelay(1), outw((val), (port)))
 #define inl_p(port)             inl(port)
-#define outl_p(val, port)       (udelay(1), outl((val, (port)))
+#define outl_p(val, port)       (udelay(1), outl((val), (port)))

 /*
  * The *_ns versions below don't do byte-swapping.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
