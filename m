From: brian.auld@adic.com
Message-ID: <995FF289C9D69747A09E42992644595405B23656@penguin.adic.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Kernel build: not recognizing 'tlbre' instruction
Date: Fri, 7 Feb 2003 08:23:43 -0800 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Using ELDK to run embedded linux on 440GP eval board.

After getting the above running, I decided to test the waters with a custom
kernel another group in our company has used on a custom 440GP board
(Ultimately, the directive from mgmt is to leverage the work done on this
other custom board). This group used a Mac as their development server as
opposed to cross-developing on an x86.

When I try to build this 'custom kernel', I get the following error:

...
Unrecognized opcode: 'tlbre' in the file arch/ppc/kernel/misc.S
...

I diffed the custom kernel against the kernel I'm successfully running on
ebony (ELDK kernel), and have attached it below. It seems the the previous
version of misc.S (1.76) had a smattering of 'tlbre' commands, but in 1.77
they are gone.

Any thoughts or background? I read some background info on the mailing list
about the use of mcpu=403/405 for ppc_4xx. I also read the documentation for
the 405 and compared it to the 440GP, and they both support the tlbre
opcode.

Why is the ELDK not recognizing this opcode? I also tried cross-compiling
this kernel with a backup 'made by hand' gnu tool-chain and I got the same
error.

General question: Is there a way to get previous versions of
linuxppc_2_4_devel kernels?

==========================================================================
--- linuxppc/arch/ppc/kernel/misc.S	2003-02-04 10:02:50.000000000 -0500
+++ custom-kernel/arch/ppc/kernel/misc.S	2003-02-06
06:56:16.000000000 -0500
@@ -1,5 +1,5 @@
 /*
- * BK Id: SCCS/s.misc.S 1.77 10/09/02 10:47:02 paulus
+ * BK Id: SCCS/s.misc.S 1.76 09/20/02 07:53:45 trini
  */
 /*
  * This file contains miscellaneous low-level functions.
@@ -478,6 +478,42 @@
 #endif /* CONFIG_40x */
 	blr

+
+/*
+ * invalidate_dcache_range(unsigned long start, unsigned long stop)
+ */
+_GLOBAL(invalidate_icache_range)
+	li	r5,L1_CACHE_LINE_SIZE-1
+	andc	r3,r3,r5
+	subf	r4,r3,r4
+	add	r4,r4,r5
+	srwi.	r4,r4,LG_L1_CACHE_LINE_SIZE
+	beqlr
+	mtctr	r4
+
+1:	icbi	0,r3
+	addi	r3,r3,L1_CACHE_LINE_SIZE
+	bdnz	1b
+	sync				/* wait for icbi's to get to ram */
+	blr
+
+
+/*
+ * void get_tlb(int* entry, int index)
+ */
+_GLOBAL(get_tlb)
+        tlbre	r0, r4, 0
+	stw	r0, 4(r3)
+	mfspr	r0, SPRN_MMUCR
+	andi.	r0, r0, PPC440_MMUCR_TID
+	stw	r0, 0(r3)
+        tlbre	r0, r4, 1
+	stw	r0, 8(r3)
+        tlbre	r0, r4, 2
+	stw	r0, 12(r3)
+	blr
+
+
 /*
  * Flush instruction cache.
  * This is a no-op on the 601.
============================================================================

Thanks

-- Brian

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
