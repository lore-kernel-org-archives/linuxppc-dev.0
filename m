Return-Path: <anton@ozlabs.org>
Date: Tue, 3 Aug 2010 16:09:52 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 2/3] powerpc: Optimise 64bit csum_partial_copy_generic and
	add csum_and_copy_from_user
Message-ID: <20100803060952.GA31448@kryten>
References: <20100803060834.GK29316@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100803060834.GK29316@kryten>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


We use the same core loop as the new csum_partial, adding in the
stores and exception handling code. To keep things simple we do all the
exception fixup in csum_and_copy_from_user. This wrapper function is
modelled on the generic checksum code and is careful to always calculate
a complete checksum even if we only copied part of the data to userspace.

To test this I forced checksumming on over loopback and ran socklib (a
simple TCP benchmark). On a POWER6 575 throughput improved by 19% with
this patch. If I forced both the sender and receiver onto the same cpu
(with the hope of shifting the benchmark from being cache bandwidth limited
to cpu limited), adding this patch improved performance by 55%

Signed-off-by: Anton Blanchard <anton@samba.org>
--

Index: powerpc.git/arch/powerpc/lib/checksum_64.S
===================================================================
--- powerpc.git.orig/arch/powerpc/lib/checksum_64.S	2010-08-03 15:16:59.600753385 +1000
+++ powerpc.git/arch/powerpc/lib/checksum_64.S	2010-08-03 16:00:32.030741261 +1000
@@ -228,115 +228,230 @@ _GLOBAL(csum_partial)
 	srdi	r3,r3,32
 	blr
 
+
+	.macro source
+100:
+	.section __ex_table,"a"
+	.align 3
+	.llong 100b,.Lsrc_error
+	.previous
+	.endm
+
+	.macro dest
+200:
+	.section __ex_table,"a"
+	.align 3
+	.llong 200b,.Ldest_error
+	.previous
+	.endm
+
 /*
  * Computes the checksum of a memory block at src, length len,
  * and adds in "sum" (32-bit), while copying the block to dst.
  * If an access exception occurs on src or dst, it stores -EFAULT
- * to *src_err or *dst_err respectively, and (for an error on
- * src) zeroes the rest of dst.
- *
- * This code needs to be reworked to take advantage of 64 bit sum+copy.
- * However, due to tokenring halfword alignment problems this will be very
- * tricky.  For now we'll leave it until we instrument it somehow.
+ * to *src_err or *dst_err respectively. The caller must take any action
+ * required in this case (zeroing memory, recalculating partial checksum etc).
  *
  * csum_partial_copy_generic(r3=src, r4=dst, r5=len, r6=sum, r7=src_err, r8=dst_err)
  */
 _GLOBAL(csum_partial_copy_generic)
-	addic	r0,r6,0
-	subi	r3,r3,4
-	subi	r4,r4,4
-	srwi.	r6,r5,2
-	beq	3f		/* if we're doing < 4 bytes */
-	andi.	r9,r4,2		/* Align dst to longword boundary */
-	beq+	1f
-81:	lhz	r6,4(r3)	/* do 2 bytes to get aligned */
-	addi	r3,r3,2
+	addic	r0,r6,0			/* clear carry */
+
+	srdi.	r6,r5,3			/* less than 8 bytes? */
+	beq	.Lcopy_tail_word
+
+	/*
+	 * If only halfword aligned, align to a double word. Since odd
+	 * aligned addresses should be rare and they would require more
+	 * work to calculate the correct checksum, we ignore that case
+	 * and take the potential slowdown of unaligned loads.
+	 *
+	 * If the source and destination are relatively unaligned we only
+	 * align the source. This keeps things simple.
+	 */
+	rldicl. r6,r3,64-1,64-2		/* r6 = (r3 & 0x3) >> 1 */
+	beq	.Lcopy_aligned
+
+	li	r7,4
+	sub	r6,r7,r6
+	mtctr	r6
+
+1:
+source;	lhz	r6,0(r3)		/* align to doubleword */
 	subi	r5,r5,2
-91:	sth	r6,4(r4)
-	addi	r4,r4,2
-	addc	r0,r0,r6
-	srwi.	r6,r5,2		/* # words to do */
-	beq	3f
-1:	mtctr	r6
-82:	lwzu	r6,4(r3)	/* the bdnz has zero overhead, so it should */
-92:	stwu	r6,4(r4)	/* be unnecessary to unroll this loop */
-	adde	r0,r0,r6
-	bdnz	82b
-	andi.	r5,r5,3
-3:	cmpwi	0,r5,2
-	blt+	4f
-83:	lhz	r6,4(r3)
 	addi	r3,r3,2
-	subi	r5,r5,2
-93:	sth	r6,4(r4)
+	adde	r0,r0,r6
+dest;	sth	r6,0(r4)
 	addi	r4,r4,2
+	bdnz	1b
+
+.Lcopy_aligned:
+	/*
+	 * We unroll the loop such that each iteration is 64 bytes with an
+	 * entry and exit limb of 64 bytes, meaning a minimum size of
+	 * 128 bytes.
+	 */
+	srdi.	r6,r5,7
+	beq	.Lcopy_tail_doublewords		/* len < 128 */
+
+	srdi	r6,r5,6
+	subi	r6,r6,1
+	mtctr	r6
+
+	stdu	r1,-STACKFRAMESIZE(r1)
+	std	r14,STK_REG(r14)(r1)
+	std	r15,STK_REG(r15)(r1)
+	std	r16,STK_REG(r16)(r1)
+
+source;	ld	r6,0(r3)
+source;	ld	r9,8(r3)
+
+source;	ld	r10,16(r3)
+source;	ld	r11,24(r3)
+
+	/*
+	 * On POWER6 and POWER7 back to back addes take 2 cycles because of
+	 * the XER dependency. This means the fastest this loop can go is
+	 * 16 cycles per iteration. The scheduling of the loop below has
+	 * been shown to hit this on both POWER6 and POWER7.
+	 */
+	.align 5
+2:
 	adde	r0,r0,r6
-4:	cmpwi	0,r5,1
-	bne+	5f
-84:	lbz	r6,4(r3)
-94:	stb	r6,4(r4)
-	slwi	r6,r6,8		/* Upper byte of word */
-	adde	r0,r0,r6
-5:	addze	r3,r0		/* add in final carry (unlikely with 64-bit regs) */
-        rldicl  r4,r3,32,0      /* fold 64 bit value */
-        add     r3,r4,r3
-        srdi    r3,r3,32
-	blr
+source;	ld	r12,32(r3)
+source;	ld	r14,40(r3)
 
-/* These shouldn't go in the fixup section, since that would
-   cause the ex_table addresses to get out of order. */
+	adde	r0,r0,r9
+source;	ld	r15,48(r3)
+source;	ld	r16,56(r3)
+	addi	r3,r3,64
+
+	adde	r0,r0,r10
+dest;	std	r6,0(r4)
+dest;	std	r9,8(r4)
+
+	adde	r0,r0,r11
+dest;	std	r10,16(r4)
+dest;	std	r11,24(r4)
+
+	adde	r0,r0,r12
+dest;	std	r12,32(r4)
+dest;	std	r14,40(r4)
+
+	adde	r0,r0,r14
+dest;	std	r15,48(r4)
+dest;	std	r16,56(r4)
+	addi	r4,r4,64
+
+	adde	r0,r0,r15
+source;	ld	r6,0(r3)
+source;	ld	r9,8(r3)
+
+	adde	r0,r0,r16
+source;	ld	r10,16(r3)
+source;	ld	r11,24(r3)
+	bdnz	2b
+
+
+	adde	r0,r0,r6
+source;	ld	r12,32(r3)
+source;	ld	r14,40(r3)
+
+	adde	r0,r0,r9
+source;	ld	r15,48(r3)
+source;	ld	r16,56(r3)
+	addi	r3,r3,64
+
+	adde	r0,r0,r10
+dest;	std	r6,0(r4)
+dest;	std	r9,8(r4)
+
+	adde	r0,r0,r11
+dest;	std	r10,16(r4)
+dest;	std	r11,24(r4)
+
+	adde	r0,r0,r12
+dest;	std	r12,32(r4)
+dest;	std	r14,40(r4)
+
+	adde	r0,r0,r14
+dest;	std	r15,48(r4)
+dest;	std	r16,56(r4)
+	addi	r4,r4,64
+
+	adde	r0,r0,r15
+	adde	r0,r0,r16
+
+	ld	r14,STK_REG(r14)(r1)
+	ld	r15,STK_REG(r15)(r1)
+	ld	r16,STK_REG(r16)(r1)
+	addi	r1,r1,STACKFRAMESIZE
+
+	andi.	r5,r5,63
+
+.Lcopy_tail_doublewords:		/* Up to 127 bytes to go */
+	srdi.	r6,r5,3
+	beq	.Lcopy_tail_word
 
-	.globl src_error_1
-src_error_1:
-	li	r6,0
-	subi	r5,r5,2
-95:	sth	r6,4(r4)
-	addi	r4,r4,2
-	srwi.	r6,r5,2
-	beq	3f
 	mtctr	r6
-	.globl src_error_2
-src_error_2:
-	li	r6,0
-96:	stwu	r6,4(r4)
-	bdnz	96b
-3:	andi.	r5,r5,3
-	beq	src_error
-	.globl src_error_3
-src_error_3:
-	li	r6,0
-	mtctr	r5
-	addi	r4,r4,3
-97:	stbu	r6,1(r4)
-	bdnz	97b
-	.globl src_error
-src_error:
+3:
+source;	ld	r6,0(r3)
+	addi	r3,r3,8
+	adde	r0,r0,r6
+dest;	std	r6,0(r4)
+	addi	r4,r4,8
+	bdnz	3b
+
+	andi.	r5,r5,7
+
+.Lcopy_tail_word:			/* Up to 7 bytes to go */
+	srdi.	r6,r5,2
+	beq	.Lcopy_tail_halfword
+
+source;	lwz	r6,0(r3)
+	addi	r3,r3,4
+	adde	r0,r0,r6
+dest;	stw	r6,0(r4)
+	addi	r4,r4,4
+	subi	r5,r5,4
+
+.Lcopy_tail_halfword:			/* Up to 3 bytes to go */
+	srdi.	r6,r5,1
+	beq	.Lcopy_tail_byte
+
+source;	lhz	r6,0(r3)
+	addi	r3,r3,2
+	adde	r0,r0,r6
+dest;	sth	r6,0(r4)
+	addi	r4,r4,2
+	subi	r5,r5,2
+
+.Lcopy_tail_byte:			/* Up to 1 byte to go */
+	andi.	r6,r5,1
+	beq	.Lcopy_finish
+
+source;	lbz	r6,0(r3)
+	sldi	r9,r6,8			/* Pad the byte out to 16 bits */
+	adde	r0,r0,r9
+dest;	stb	r6,0(r4)
+
+.Lcopy_finish:
+	addze	r0,r0			/* add in final carry */
+	rldicl	r4,r0,32,0		/* fold two 32 bit halves together */
+	add	r3,r4,r0
+	srdi	r3,r3,32
+	blr
+
+.Lsrc_error:
 	cmpdi	0,r7,0
-	beq	1f
+	beqlr
 	li	r6,-EFAULT
 	stw	r6,0(r7)
-1:	addze	r3,r0
 	blr
 
-	.globl dst_error
-dst_error:
+.Ldest_error:
 	cmpdi	0,r8,0
-	beq	1f
+	beqlr
 	li	r6,-EFAULT
 	stw	r6,0(r8)
-1:	addze	r3,r0
 	blr
-
-.section __ex_table,"a"
-	.align  3
-	.llong	81b,src_error_1
-	.llong	91b,dst_error
-	.llong	82b,src_error_2
-	.llong	92b,dst_error
-	.llong	83b,src_error_3
-	.llong	93b,dst_error
-	.llong	84b,src_error_3
-	.llong	94b,dst_error
-	.llong	95b,dst_error
-	.llong	96b,dst_error
-	.llong	97b,dst_error
Index: powerpc.git/arch/powerpc/lib/checksum_wrappers_64.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ powerpc.git/arch/powerpc/lib/checksum_wrappers_64.c	2010-08-03 15:58:43.214492712 +1000
@@ -0,0 +1,65 @@
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
+ * Copyright (C) IBM Corporation, 2010
+ *
+ * Author: Anton Blanchard <anton@au.ibm.com>
+ */
+#include <linux/module.h>
+#include <linux/compiler.h>
+#include <linux/types.h>
+#include <asm/checksum.h>
+#include <asm/uaccess.h>
+
+__wsum csum_and_copy_from_user(const void __user *src, void *dst,
+			       int len, __wsum sum, int *err_ptr)
+{
+	unsigned int csum;
+
+	might_sleep();
+
+	*err_ptr = 0;
+
+	if (!len) {
+		csum = 0;
+		goto out;
+	}
+
+	if (unlikely((len < 0) || !access_ok(VERIFY_READ, src, len))) {
+		*err_ptr = -EFAULT;
+		csum = (__force unsigned int)sum;
+		goto out;
+	}
+
+	csum = csum_partial_copy_generic((void __force *)src, dst,
+					 len, sum, err_ptr, NULL);
+
+	if (unlikely(*err_ptr)) {
+		int missing = __copy_from_user(dst, src, len);
+
+		if (missing) {
+			memset(dst + len - missing, 0, missing);
+			*err_ptr = -EFAULT;
+		} else {
+			*err_ptr = 0;
+		}
+
+		csum = csum_partial(dst, len, sum);
+	}
+
+out:
+	return (__force __wsum)csum;
+}
+EXPORT_SYMBOL(csum_and_copy_from_user);
Index: powerpc.git/arch/powerpc/lib/Makefile
===================================================================
--- powerpc.git.orig/arch/powerpc/lib/Makefile	2010-08-03 15:16:35.310741991 +1000
+++ powerpc.git/arch/powerpc/lib/Makefile	2010-08-03 15:17:58.240742747 +1000
@@ -17,7 +17,8 @@ obj-$(CONFIG_PPC32)	+= div64.o copy_32.o
 obj-$(CONFIG_HAS_IOMEM)	+= devres.o
 
 obj-$(CONFIG_PPC64)	+= copypage_64.o copyuser_64.o \
-			   memcpy_64.o usercopy_64.o mem_64.o string.o
+			   memcpy_64.o usercopy_64.o mem_64.o string.o \
+			   checksum_wrappers_64.o
 obj-$(CONFIG_XMON)	+= sstep.o ldstfp.o
 obj-$(CONFIG_KPROBES)	+= sstep.o ldstfp.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= sstep.o ldstfp.o
Index: powerpc.git/arch/powerpc/include/asm/checksum.h
===================================================================
--- powerpc.git.orig/arch/powerpc/include/asm/checksum.h	2010-08-03 15:16:35.320741299 +1000
+++ powerpc.git/arch/powerpc/include/asm/checksum.h	2010-08-03 15:58:43.234490654 +1000
@@ -52,12 +52,19 @@ extern __wsum csum_partial(const void *b
 extern __wsum csum_partial_copy_generic(const void *src, void *dst,
 					      int len, __wsum sum,
 					      int *src_err, int *dst_err);
+
+#ifdef __powerpc64__
+#define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
+extern __wsum csum_and_copy_from_user(const void __user *src, void *dst,
+				      int len, __wsum sum, int *err_ptr);
+#else
 /*
  * the same as csum_partial, but copies from src to dst while it
  * checksums.
  */
 #define csum_partial_copy_from_user(src, dst, len, sum, errp)   \
         csum_partial_copy_generic((__force const void *)(src), (dst), (len), (sum), (errp), NULL)
+#endif
 
 #define csum_partial_copy_nocheck(src, dst, len, sum)   \
         csum_partial_copy_generic((src), (dst), (len), (sum), NULL, NULL)
