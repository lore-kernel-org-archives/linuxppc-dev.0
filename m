Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 506C4B70B3
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Jan 2011 17:35:30 +1100 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id p0L6ZOu8015776
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jan 2011 00:35:25 -0600
Subject: [PATCH] powerpc: Fix some 6xx/7xxx CPU setup functions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 21 Jan 2011 17:35:23 +1100
Message-ID: <1295591723.2148.281.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some of those functions try to adjust the CPU features, for example
to remove NAP support on some revisions. However, they seem to use
r5 as an index into the CPU table entry, which might have been right
a long time ago but no longer is. r4 is the right register to use.

This probably caused some off behaviours on some PowerMac variants
using 750cx or 7455 processor revisions.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Can somebody with one of these PowerMacs test this ? I only managed to
find a 7448 which not directly affected...

In absence of good testing I would appreciate a close inspection of the patch
by different pairs of eyes :-)

Cheers,
Ben.

diff --git a/arch/powerpc/kernel/cpu_setup_6xx.S b/arch/powerpc/kernel/cpu_setup_6xx.S
index 55cba4a..f8cd9fb 100644
--- a/arch/powerpc/kernel/cpu_setup_6xx.S
+++ b/arch/powerpc/kernel/cpu_setup_6xx.S
@@ -18,7 +18,7 @@
 #include <asm/mmu.h>
 
 _GLOBAL(__setup_cpu_603)
-	mflr	r4
+	mflr	r5
 BEGIN_MMU_FTR_SECTION
 	li	r10,0
 	mtspr	SPRN_SPRG_603_LRU,r10		/* init SW LRU tracking */
@@ -27,60 +27,60 @@ BEGIN_FTR_SECTION
 	bl	__init_fpu_registers
 END_FTR_SECTION_IFCLR(CPU_FTR_FPU_UNAVAILABLE)
 	bl	setup_common_caches
-	mtlr	r4
+	mtlr	r5
 	blr
 _GLOBAL(__setup_cpu_604)
-	mflr	r4
+	mflr	r5
 	bl	setup_common_caches
 	bl	setup_604_hid0
-	mtlr	r4
+	mtlr	r5
 	blr
 _GLOBAL(__setup_cpu_750)
-	mflr	r4
+	mflr	r5
 	bl	__init_fpu_registers
 	bl	setup_common_caches
 	bl	setup_750_7400_hid0
-	mtlr	r4
+	mtlr	r5
 	blr
 _GLOBAL(__setup_cpu_750cx)
-	mflr	r4
+	mflr	r5
 	bl	__init_fpu_registers
 	bl	setup_common_caches
 	bl	setup_750_7400_hid0
 	bl	setup_750cx
-	mtlr	r4
+	mtlr	r5
 	blr
 _GLOBAL(__setup_cpu_750fx)
-	mflr	r4
+	mflr	r5
 	bl	__init_fpu_registers
 	bl	setup_common_caches
 	bl	setup_750_7400_hid0
 	bl	setup_750fx
-	mtlr	r4
+	mtlr	r5
 	blr
 _GLOBAL(__setup_cpu_7400)
-	mflr	r4
+	mflr	r5
 	bl	__init_fpu_registers
 	bl	setup_7400_workarounds
 	bl	setup_common_caches
 	bl	setup_750_7400_hid0
-	mtlr	r4
+	mtlr	r5
 	blr
 _GLOBAL(__setup_cpu_7410)
-	mflr	r4
+	mflr	r5
 	bl	__init_fpu_registers
 	bl	setup_7410_workarounds
 	bl	setup_common_caches
 	bl	setup_750_7400_hid0
 	li	r3,0
 	mtspr	SPRN_L2CR2,r3
-	mtlr	r4
+	mtlr	r5
 	blr
 _GLOBAL(__setup_cpu_745x)
-	mflr	r4
+	mflr	r5
 	bl	setup_common_caches
 	bl	setup_745x_specifics
-	mtlr	r4
+	mtlr	r5
 	blr
 
 /* Enable caches for 603's, 604, 750 & 7400 */
@@ -194,10 +194,10 @@ setup_750cx:
 	cror	4*cr0+eq,4*cr0+eq,4*cr1+eq
 	cror	4*cr0+eq,4*cr0+eq,4*cr2+eq
 	bnelr
-	lwz	r6,CPU_SPEC_FEATURES(r5)
+	lwz	r6,CPU_SPEC_FEATURES(r4)
 	li	r7,CPU_FTR_CAN_NAP
 	andc	r6,r6,r7
-	stw	r6,CPU_SPEC_FEATURES(r5)
+	stw	r6,CPU_SPEC_FEATURES(r4)
 	blr
 
 /* 750fx specific
@@ -225,12 +225,12 @@ BEGIN_FTR_SECTION
 	andis.	r11,r11,L3CR_L3E@h
 	beq	1f
 END_FTR_SECTION_IFSET(CPU_FTR_L3CR)
-	lwz	r6,CPU_SPEC_FEATURES(r5)
+	lwz	r6,CPU_SPEC_FEATURES(r4)
 	andi.	r0,r6,CPU_FTR_L3_DISABLE_NAP
 	beq	1f
 	li	r7,CPU_FTR_CAN_NAP
 	andc	r6,r6,r7
-	stw	r6,CPU_SPEC_FEATURES(r5)
+	stw	r6,CPU_SPEC_FEATURES(r4)
 1:
 	mfspr	r11,SPRN_HID0
 
