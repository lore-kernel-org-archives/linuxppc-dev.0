Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AFCD11A0F77
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jan 2015 12:56:33 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Subject: [PATCH 1/2] powerpc: Add 64bit optimised memcmp
Date: Fri,  9 Jan 2015 12:56:30 +1100
Message-Id: <1420768591-6831-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I noticed ksm spending quite a lot of time in memcmp on a large
KVM box. The current memcmp loop is very unoptimised - byte at a
time compares with no loop unrolling. We can do much much better.

Optimise the loop in a few ways:

- Unroll the byte at a time loop

- For large (at least 32 byte) comparisons that are also 8 byte
  aligned, use an unrolled modulo scheduled loop using 8 byte
  loads. This is similar to our glibc memcmp.

A simple microbenchmark testing 10000000 iterations of an 8192 byte
memcmp was used to measure the performance:

baseline:	29.93 s

modified:	 1.70 s

Just over 17x faster.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/lib/Makefile    |   3 +-
 arch/powerpc/lib/memcmp_64.S | 233 +++++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/lib/string.S    |   2 +
 3 files changed, 237 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/lib/memcmp_64.S

diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 1b01159..5526156 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -15,7 +15,8 @@ obj-$(CONFIG_PPC32)	+= div64.o copy_32.o
 
 obj-$(CONFIG_PPC64)	+= copypage_64.o copyuser_64.o \
 			   usercopy_64.o mem_64.o hweight_64.o \
-			   copyuser_power7.o string_64.o copypage_power7.o
+			   copyuser_power7.o string_64.o copypage_power7.o \
+			   memcmp_64.o
 ifeq ($(CONFIG_GENERIC_CSUM),)
 obj-y			+= checksum_$(CONFIG_WORD_SIZE).o
 obj-$(CONFIG_PPC64)	+= checksum_wrappers_64.o
diff --git a/arch/powerpc/lib/memcmp_64.S b/arch/powerpc/lib/memcmp_64.S
new file mode 100644
index 0000000..d71880b
--- /dev/null
+++ b/arch/powerpc/lib/memcmp_64.S
@@ -0,0 +1,233 @@
+/*
+ * Author: Author: Anton Blanchard <anton@au.ibm.com>
+ * Copyright 2015 IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <asm/ppc_asm.h>
+
+#define off8	r6
+#define off16	r7
+#define off24	r8
+
+#define rA	r9
+#define rB	r10
+#define rC	r11
+#define rD	r27
+#define rE	r28
+#define rF	r29
+#define rG	r30
+#define rH	r31
+
+#ifdef __LITTLE_ENDIAN__
+#define LD	ldbrx
+#else
+#define LD	ldx
+#endif
+
+_GLOBAL(memcmp)
+	cmpdi	cr1,r5,0
+
+	/* Use the short loop if both strings are not 8B aligned */
+	or	r6,r3,r4
+	rldicl.	r6,r6,0,(64-3)
+
+	/* Use the short loop if length is less than 32B */
+	cmpdi	cr5,r5,31
+
+	beq	cr1,.Lzero
+	bne	.Lshort
+	bgt	cr5,.Llong
+
+.Lshort:
+	mtctr	r5
+
+1:	lbz	rA,0(r3)
+	lbz	rB,0(r4)
+	subf.	rC,rB,rA
+	bne	.Lnon_zero
+	bdz	.Lzero
+
+	lbz	rA,1(r3)
+	lbz	rB,1(r4)
+	subf.	rC,rB,rA
+	bne	.Lnon_zero
+	bdz	.Lzero
+
+	lbz	rA,2(r3)
+	lbz	rB,2(r4)
+	subf.	rC,rB,rA
+	bne	.Lnon_zero
+	bdz	.Lzero
+
+	lbz	rA,3(r3)
+	lbz	rB,3(r4)
+	subf.	rC,rB,rA
+	bne	.Lnon_zero
+
+	addi	r3,r3,4
+	addi	r4,r4,4
+
+	bdnzt	eq,1b
+
+.Lzero:
+	li	r3,0
+	blr
+
+.Lnon_zero:
+	mr	r3,rC
+	blr
+
+.Llong:
+	li	off8,8
+	li	off16,16
+	li	off24,24
+
+	std	r31,-8(r1)
+	std	r30,-16(r1)
+	std	r29,-24(r1)
+	std	r28,-32(r1)
+	std	r27,-40(r1)
+
+	srdi	r0,r5,5
+	mtctr	r0
+	andi.	r5,r5,31
+
+	LD	rA,0,r3
+	LD	rB,0,r4
+
+	LD	rC,off8,r3
+	LD	rD,off8,r4
+
+	LD	rE,off16,r3
+	LD	rF,off16,r4
+
+	LD	rG,off24,r3
+	LD	rH,off24,r4
+	cmpld	cr0,rA,rB
+
+	addi	r3,r3,32
+	addi	r4,r4,32
+
+	bdz	.Lfirst32
+
+	LD	rA,0,r3
+	LD	rB,0,r4
+	cmpld	cr1,rC,rD
+
+	LD	rC,off8,r3
+	LD	rD,off8,r4
+	cmpld	cr5,rE,rF
+
+	LD	rE,off16,r3
+	LD	rF,off16,r4
+	cmpld	cr6,rG,rH
+	bne	cr0,.LcmpAB
+
+	LD	rG,off24,r3
+	LD	rH,off24,r4
+	cmpld	cr0,rA,rB
+	bne	cr1,.LcmpCD
+
+	addi	r3,r3,32
+	addi	r4,r4,32
+
+	bdz	.Lsecond32
+
+	.balign	16
+
+1:	LD	rA,0,r3
+	LD	rB,0,r4
+	cmpld	cr1,rC,rD
+	bne	cr5,.LcmpEF
+
+	LD	rC,off8,r3
+	LD	rD,off8,r4
+	cmpld	cr5,rE,rF
+	bne	cr6,.LcmpGH
+
+	LD	rE,off16,r3
+	LD	rF,off16,r4
+	cmpld	cr6,rG,rH
+	bne	cr0,.LcmpAB
+
+	LD	rG,off24,r3
+	LD	rH,off24,r4
+	cmpld	cr0,rA,rB
+	bne	cr1,.LcmpCD
+
+	addi	r3,r3,32
+	addi	r4,r4,32
+
+	bdnz	1b
+
+.Lsecond32:
+	cmpld	cr1,rC,rD
+	bne	cr5,.LcmpEF
+
+	cmpld	cr5,rE,rF
+	bne	cr6,.LcmpGH
+
+	cmpld	cr6,rG,rH
+	bne	cr0,.LcmpAB
+
+	bne	cr1,.LcmpCD
+	bne	cr5,.LcmpEF
+	bne	cr6,.LcmpGH
+
+.Ltail:
+	ld	r31,-8(r1)
+	ld	r30,-16(r1)
+	ld	r29,-24(r1)
+	ld	r28,-32(r1)
+	ld	r27,-40(r1)
+
+	cmpdi	r5,0
+	beq	.Lzero
+	b	.Lshort
+
+.Lfirst32:
+	cmpld	cr1,rC,rD
+	cmpld	cr5,rE,rF
+	cmpld	cr6,rG,rH
+
+	bne	cr0,.LcmpAB
+	bne	cr1,.LcmpCD
+	bne	cr5,.LcmpEF
+	bne	cr6,.LcmpGH
+
+	b	.Ltail
+
+.LcmpAB:
+	li	r3,1
+	bgt	cr0,.Lout
+	li	r3,-1
+	b	.Lout
+
+.LcmpCD:
+	li	r3,1
+	bgt	cr1,.Lout
+	li	r3,-1
+	b	.Lout
+
+.LcmpEF:
+	li	r3,1
+	bgt	cr5,.Lout
+	li	r3,-1
+	b	.Lout
+
+.LcmpGH:
+	li	r3,1
+	bgt	cr6,.Lout
+	li	r3,-1
+
+.Lout:
+	ld	r31,-8(r1)
+	ld	r30,-16(r1)
+	ld	r29,-24(r1)
+	ld	r28,-32(r1)
+	ld	r27,-40(r1)
+	blr
diff --git a/arch/powerpc/lib/string.S b/arch/powerpc/lib/string.S
index 1b5a0a0..c80fb49 100644
--- a/arch/powerpc/lib/string.S
+++ b/arch/powerpc/lib/string.S
@@ -93,6 +93,7 @@ _GLOBAL(strlen)
 	subf	r3,r3,r4
 	blr
 
+#ifdef CONFIG_PPC32
 _GLOBAL(memcmp)
 	PPC_LCMPI 0,r5,0
 	beq-	2f
@@ -106,6 +107,7 @@ _GLOBAL(memcmp)
 	blr
 2:	li	r3,0
 	blr
+#endif
 
 _GLOBAL(memchr)
 	PPC_LCMPI 0,r5,0
-- 
2.1.0
