Return-Path: <anton@samba.org>
Date: Mon, 28 May 2012 15:54:03 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, michael@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: 64bit optimised __clear_user
Message-ID: <20120528155403.5822b8a0@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


I noticed __clear_user high up in a profile of one of my RAID stress
tests. The testcase was doing a dd from /dev/zero which ends up
calling __clear_user.

__clear_user is basically a loop with a single 4 byte store which
is horribly slow. We can do much better by aligning the desination
and doing 32 bytes of 8 byte stores in a loop.

The following testcase was used to verify the patch:

http://ozlabs.org/~anton/junkcode/stress_clear_user.c

To show the improvement in performance I ran a dd from /dev/zero
to /dev/null on a POWER7 box:

Before:

# dd if=/dev/zero of=/dev/null bs=1M count=10000
10485760000 bytes (10 GB) copied, 3.72379 s, 2.8 GB/s

After:

# time dd if=/dev/zero of=/dev/null bs=1M count=10000
10485760000 bytes (10 GB) copied, 0.728318 s, 14.4 GB/s

Over 5x faster.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Interestingly, it picked up an issue with the old clear_user which
fails when we are less than 4 bytes to the end of a page and the
next page is unmapped:

offset 4094 length 526 expected 2 got -1
expected 0x00 at offset 4094, got 0xff
expected 0x00 at offset 4095, got 0xff

We should fix that.

Index: linux-build/arch/powerpc/lib/Makefile
===================================================================
--- linux-build.orig/arch/powerpc/lib/Makefile	2012-05-28 10:59:09.281806751 +1000
+++ linux-build/arch/powerpc/lib/Makefile	2012-05-28 11:02:35.017452778 +1000
@@ -17,7 +17,7 @@ obj-$(CONFIG_HAS_IOMEM)	+= devres.o
 obj-$(CONFIG_PPC64)	+= copypage_64.o copyuser_64.o \
 			   memcpy_64.o usercopy_64.o mem_64.o string.o \
 			   checksum_wrappers_64.o hweight_64.o \
-			   copyuser_power7.o
+			   copyuser_power7.o string_64.o
 obj-$(CONFIG_XMON)	+= sstep.o ldstfp.o
 obj-$(CONFIG_KPROBES)	+= sstep.o ldstfp.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= sstep.o ldstfp.o
Index: linux-build/arch/powerpc/lib/string_64.S
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-build/arch/powerpc/lib/string_64.S	2012-05-28 14:56:03.937833406 +1000
@@ -0,0 +1,141 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright (C) IBM Corporation, 2012
+ *
+ * Author: Anton Blanchard <anton@au.ibm.com>
+ */
+
+#include <asm/ppc_asm.h>
+
+/**
+ * __clear_user: - Zero a block of memory in user space, with less checking.
+ * @to:   Destination address, in user space.
+ * @n:    Number of bytes to zero.
+ *
+ * Zero a block of memory in user space.  Caller must check
+ * the specified block with access_ok() before calling this function.
+ *
+ * Returns number of bytes that could not be cleared.
+ * On success, this will be zero.
+ */
+
+	.macro err1
+100:
+	.section __ex_table,"a"
+	.align 3
+	.llong 100b,.Ldo_err1
+	.previous
+	.endm
+
+	.macro err2
+200:
+	.section __ex_table,"a"
+	.align 3
+	.llong 200b,.Ldo_err2
+	.previous
+	.endm
+
+	.macro err3
+300:
+	.section __ex_table,"a"
+	.align 3
+	.llong 300b,.Ldo_err3
+	.previous
+	.endm
+
+.Ldo_err1:
+	mr	r3,r8
+
+.Ldo_err2:
+	mtctr	r4
+1:
+err3;	stb	r0,0(r3)
+	addi	r3,r3,1
+	addi	r4,r4,-1
+	bdnz	1b
+
+.Ldo_err3:
+	mr	r3,r4
+	blr
+
+_GLOBAL(__clear_user)
+	cmpdi	r4,32
+	neg	r6,r3
+	li	r0,0
+	blt	.Lshort_clear
+	mr	r8,r3
+	mtocrf	0x01,r6
+	clrldi	r6,r6,(64-3)
+
+	/* Get the destination 8 byte aligned */
+	bf	cr7*4+3,1f
+err1;	stb	r0,0(r3)
+	addi	r3,r3,1
+
+1:	bf	cr7*4+2,2f
+err1;	sth	r0,0(r3)
+	addi	r3,r3,2
+
+2:	bf	cr7*4+1,3f
+err1;	stw	r0,0(r3)
+	addi	r3,r3,4
+
+3:	sub	r4,r4,r6
+	srdi	r6,r4,5
+	cmpdi	r4,32
+	blt	.Lshort_clear
+	mtctr	r6
+
+	/* Do 32 byte chunks */
+4:
+err2;	std	r0,0(r3)
+err2;	std	r0,8(r3)
+err2;	std	r0,16(r3)
+err2;	std	r0,24(r3)
+	addi	r3,r3,32
+	addi	r4,r4,-32
+	bdnz	4b
+
+.Lshort_clear:
+	/* up to 31 bytes to go */
+	cmpdi	r4,16
+	blt	6f
+err2;	std	r0,0(r3)
+err2;	std	r0,8(r3)
+	addi	r3,r3,16
+	addi	r4,r4,-16
+
+	/* Up to 15 bytes to go */
+6:	mr	r8,r3
+	clrldi	r4,r4,(64-4)
+	mtocrf	0x01,r4
+	bf	cr7*4+0,7f
+err1;	std	r0,0(r3)
+	addi	r3,r3,8
+
+7:	bf	cr7*4+1,8f
+err1;	stw	r0,0(r3)
+	addi	r3,r3,4
+
+8:	bf	cr7*4+2,9f
+err1;	sth	r0,0(r3)
+	addi	r3,r3,2
+
+9:	bf	cr7*4+3,10f
+err1;	stb	r0,0(r3)
+
+10:	li	r3,0
+	blr
Index: linux-build/arch/powerpc/lib/string.S
===================================================================
--- linux-build.orig/arch/powerpc/lib/string.S	2011-09-07 15:15:49.146459439 +1000
+++ linux-build/arch/powerpc/lib/string.S	2012-05-28 11:01:28.728249934 +1000
@@ -119,6 +119,7 @@ _GLOBAL(memchr)
 2:	li	r3,0
 	blr
 
+#ifdef CONFIG_PPC32
 _GLOBAL(__clear_user)
 	addi	r6,r3,-4
 	li	r3,0
@@ -160,6 +161,7 @@ _GLOBAL(__clear_user)
 	PPC_LONG	1b,91b
 	PPC_LONG	8b,92b
 	.text
+#endif
 
 _GLOBAL(__strncpy_from_user)
 	addi	r6,r3,-1
