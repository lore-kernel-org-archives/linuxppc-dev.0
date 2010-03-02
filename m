Return-Path: <joakim.tjernlund@transmode.com>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7CD5AB7DCC
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Mar 2010 02:37:24 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: linuxppc-dev@ozlabs.org, Scott Wood <scottwood@freescale.com>
Subject: [PATCH 4/4] 8xx: Use SPRG2 and DAR registers to stash r11 and cr.
Date: Tue, 2 Mar 2010 16:37:12 +0100
Message-Id: <1267544232-14784-5-git-send-email-Joakim.Tjernlund@transmode.se>
In-Reply-To: <1267544232-14784-4-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1267544232-14784-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1267544232-14784-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1267544232-14784-3-git-send-email-Joakim.Tjernlund@transmode.se>
	<1267544232-14784-4-git-send-email-Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This avoids storing these registers in memory.
CPU6 errata will still use the old way.
Remove some G2 leftover accesses from 2.4

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
 arch/powerpc/kernel/head_8xx.S |   49 +++++++++++++++++++++++++++++----------
 1 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 6478a96..1f1a04b 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -71,9 +71,6 @@ _ENTRY(_start);
  * in the first level table, but that would require many changes to the
  * Linux page directory/table functions that I don't want to do right now.
  *
- * I used to use SPRG2 for a temporary register in the TLB handler, but it
- * has since been put to other uses.  I now use a hack to save a register
- * and the CCR at memory location 0.....Someday I'll fix this.....
  *	-- Dan
  */
 	.globl	__start
@@ -302,8 +299,13 @@ InstructionTLBMiss:
 	DO_8xx_CPU6(0x3f80, r3)
 	mtspr	SPRN_M_TW, r10	/* Save a couple of working registers */
 	mfcr	r10
+#ifdef CONFIG_8xx_CPU6
 	stw	r10, 0(r0)
 	stw	r11, 4(r0)
+#else
+	mtspr	SPRN_DAR, r10
+	mtspr	SPRN_SPRG2, r11
+#endif
 	mfspr	r10, SPRN_SRR0	/* Get effective address of fault */
 #ifdef CONFIG_8xx_CPU15
 	addi	r11, r10, 0x1000
@@ -359,13 +361,19 @@ InstructionTLBMiss:
 	DO_8xx_CPU6(0x2d80, r3)
 	mtspr	SPRN_MI_RPN, r10	/* Update TLB entry */
 
-	mfspr	r10, SPRN_M_TW	/* Restore registers */
+	/* Restore registers */
+#ifndef CONFIG_8xx_CPU6
+	mfspr	r10, SPRN_DAR
+	mtcr	r10
+	mtspr	SPRN_DAR, r11	/* Tag DAR */
+	mfspr	r11, SPRN_SPRG2
+#else
 	lwz	r11, 0(r0)
 	mtcr	r11
 	lwz	r11, 4(r0)
-#ifdef CONFIG_8xx_CPU6
 	lwz	r3, 8(r0)
 #endif
+	mfspr	r10, SPRN_M_TW
 	rfi
 2:
 	mfspr	r11, SPRN_SRR1
@@ -375,13 +383,20 @@ InstructionTLBMiss:
 	rlwinm	r11, r11, 0, 0xffff
 	mtspr	SPRN_SRR1, r11
 
-	mfspr	r10, SPRN_M_TW	/* Restore registers */
+	/* Restore registers */
+#ifndef CONFIG_8xx_CPU6
+	mfspr	r10, SPRN_DAR
+	mtcr	r10
+	li	r11, 0x00f0
+	mtspr	SPRN_DAR, r11	/* Tag DAR */
+	mfspr	r11, SPRN_SPRG2
+#else
 	lwz	r11, 0(r0)
 	mtcr	r11
 	lwz	r11, 4(r0)
-#ifdef CONFIG_8xx_CPU6
 	lwz	r3, 8(r0)
 #endif
+	mfspr	r10, SPRN_M_TW
 	b	InstructionAccess
 
 	. = 0x1200
@@ -392,8 +407,13 @@ DataStoreTLBMiss:
 	DO_8xx_CPU6(0x3f80, r3)
 	mtspr	SPRN_M_TW, r10	/* Save a couple of working registers */
 	mfcr	r10
+#ifdef CONFIG_8xx_CPU6
 	stw	r10, 0(r0)
 	stw	r11, 4(r0)
+#else
+	mtspr	SPRN_DAR, r10
+	mtspr	SPRN_SPRG2, r11
+#endif
 	mfspr	r10, SPRN_M_TWB	/* Get level 1 table entry address */
 
 	/* If we are faulting a kernel address, we have to use the
@@ -461,18 +481,24 @@ DataStoreTLBMiss:
 	 * of the MMU.
 	 */
 2:	li	r11, 0x00f0
-	mtspr	SPRN_DAR,r11	/* Tag DAR */
 	rlwimi	r10, r11, 0, 24, 28	/* Set 24-27, clear 28 */
 	DO_8xx_CPU6(0x3d80, r3)
 	mtspr	SPRN_MD_RPN, r10	/* Update TLB entry */
 
-	mfspr	r10, SPRN_M_TW	/* Restore registers */
+	/* Restore registers */
+#ifndef CONFIG_8xx_CPU6
+	mfspr	r10, SPRN_DAR
+	mtcr	r10
+	mtspr	SPRN_DAR, r11	/* Tag DAR */
+	mfspr	r11, SPRN_SPRG2
+#else
+	mtspr	SPRN_DAR, r11	/* Tag DAR */
 	lwz	r11, 0(r0)
 	mtcr	r11
 	lwz	r11, 4(r0)
-#ifdef CONFIG_8xx_CPU6
 	lwz	r3, 8(r0)
 #endif
+	mfspr	r10, SPRN_M_TW
 	rfi
 
 /* This is an instruction TLB error on the MPC8xx.  This could be due
@@ -684,9 +710,6 @@ start_here:
 	tophys(r4,r2)
 	addi	r4,r4,THREAD	/* init task's THREAD */
 	mtspr	SPRN_SPRG_THREAD,r4
-	li	r3,0
-	/* XXX What is that for ? SPRG2 appears otherwise unused on 8xx */
-	mtspr	SPRN_SPRG2,r3	/* 0 => r1 has kernel sp */
 
 	/* stack */
 	lis	r1,init_thread_union@ha
-- 
1.6.4.4
