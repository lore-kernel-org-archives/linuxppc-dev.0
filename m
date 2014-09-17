Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id ADD511A098A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Sep 2014 02:37:33 +1000 (EST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 20/21] powerpc/8xx: Use DAR to save r3 for CPU6 ERRATA
Message-Id: <20140917163700.EBDDF1AB045@localhost.localdomain>
Date: Wed, 17 Sep 2014 18:37:00 +0200 (CEST)
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As we are not using anymore DAR to save registers, it is now available for
saving the r3 register used for CPU6 ERRATA handling. Therefore we can
remove the major hack which was to use memory location 0 to save r3.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
Changes in v3:
- New

 linux/arch/powerpc/kernel/head_8xx.S | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/linux/arch/powerpc/kernel/head_8xx.S b/linux/arch/powerpc/kernel/head_8xx.S
index e21f0b2..3e8e341 100644
--- a/linux/arch/powerpc/kernel/head_8xx.S
+++ b/linux/arch/powerpc/kernel/head_8xx.S
@@ -83,13 +83,6 @@ _ENTRY(_start);
  * 8M 1:1.  I also mapped an additional I/O space 1:1 so we can get to
  * the "internal" processor registers before MMU_init is called.
  *
- * The TLB code currently contains a major hack.  Since I use the condition
- * code register, I have to save and restore it.  I am out of registers, so
- * I just store it in memory location 0 (the TLB handlers are not reentrant).
- * To avoid making any decisions, I need to use the "segment" valid bit
- * in the first level table, but that would require many changes to the
- * Linux page directory/table functions that I don't want to do right now.
- *
  *	-- Dan
  */
 	.globl	__start
@@ -304,7 +297,7 @@ SystemCall:
  */
 InstructionTLBMiss:
 #ifdef CONFIG_8xx_CPU6
-	stw	r3, 8(r0)
+	mtspr	SPRN_DAR, r3
 #endif
 	EXCEPTION_PROLOG_0
 	mtspr	SPRN_SPRG_SCRATCH2, r10
@@ -349,7 +342,10 @@ InstructionTLBMiss:
 #ifdef CONFIG_SWAP
 	andi.	r11, r10, _PAGE_ACCESSED | _PAGE_PRESENT
 	cmpwi	cr0, r11, _PAGE_ACCESSED | _PAGE_PRESENT
+	li	r11, RPN_PATTERN
 	bne-	cr0, 2f
+#else
+	li	r11, RPN_PATTERN
 #endif
 	/* The Linux PTE won't go exactly into the MMU TLB.
 	 * Software indicator bits 21 and 28 must be clear.
@@ -357,28 +353,29 @@ InstructionTLBMiss:
 	 * set.  All other Linux PTE bits control the behavior
 	 * of the MMU.
 	 */
-	li	r11, RPN_PATTERN
 	rlwimi	r10, r11, 0, 0x07f8	/* Set 24-27, clear 21-23,28 */
 	MTSPR_CPU6(SPRN_MI_RPN, r10, r3)	/* Update TLB entry */
 
 	/* Restore registers */
 #ifdef CONFIG_8xx_CPU6
-	lwz	r3, 8(r0)
+	mfspr	r3, SPRN_DAR
+	mtspr	SPRN_DAR, r11	/* Tag DAR */
 #endif
 	mfspr	r10, SPRN_SPRG_SCRATCH2
 	EXCEPTION_EPILOG_0
 	rfi
 2:
-	mfspr	r11, SPRN_SRR1
+	mfspr	r10, SPRN_SRR1
 	/* clear all error bits as TLB Miss
 	 * sets a few unconditionally
 	*/
-	rlwinm	r11, r11, 0, 0xffff
-	mtspr	SPRN_SRR1, r11
+	rlwinm	r10, r10, 0, 0xffff
+	mtspr	SPRN_SRR1, r10
 
 	/* Restore registers */
 #ifdef CONFIG_8xx_CPU6
-	lwz	r3, 8(r0)
+	mfspr	r3, SPRN_DAR
+	mtspr	SPRN_DAR, r11	/* Tag DAR */
 #endif
 	mfspr	r10, SPRN_SPRG_SCRATCH2
 	b	InstructionTLBError1
@@ -386,7 +383,7 @@ InstructionTLBMiss:
 	. = 0x1200
 DataStoreTLBMiss:
 #ifdef CONFIG_8xx_CPU6
-	stw	r3, 8(r0)
+	mtspr	SPRN_DAR, r3
 #endif
 	EXCEPTION_PROLOG_0
 	mtspr	SPRN_SPRG_SCRATCH2, r10
@@ -457,7 +454,7 @@ DataStoreTLBMiss:
 
 	/* Restore registers */
 #ifdef CONFIG_8xx_CPU6
-	lwz	r3, 8(r0)
+	mfspr	r3, SPRN_DAR
 #endif
 	mtspr	SPRN_DAR, r11	/* Tag DAR */
 	mfspr	r10, SPRN_SPRG_SCRATCH2
@@ -527,7 +524,7 @@ DARFixed:/* Return from dcbx instruction bug workaround */
 #define NO_SELF_MODIFYING_CODE
 FixupDAR:/* Entry point for dcbx workaround. */
 #ifdef CONFIG_8xx_CPU6
-	stw	r3, 8(r0)
+	mtspr	SPRN_DAR, r3
 #endif
 	mtspr	SPRN_SPRG_SCRATCH2, r10
 	/* fetch instruction from memory. */
@@ -546,7 +543,7 @@ FixupDAR:/* Entry point for dcbx workaround. */
 	rlwinm	r11, r11, 32 - (PAGE_SHIFT - 2), 32 - PAGE_SHIFT, 29
 	lwzx	r11, r10, r11	/* Get the pte */
 #ifdef CONFIG_8xx_CPU6
-	lwz	r3, 8(r0)	/* restore r3 from memory */
+	mfspr	r3, SPRN_DAR
 #endif
 	/* concat physical page address(r11) and page offset(r10) */
 	mfspr	r10, SPRN_SRR0
-- 
2.1.0
