Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id ECBFB1A162B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Aug 2014 19:32:07 +1000 (EST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v2 16/19] powerpc/8xx: Better readibility of ERRATA CPU6
 handling
Message-Id: <20140829091440.3F7BE1ABD65@localhost.localdomain>
Date: Fri, 29 Aug 2014 11:14:40 +0200 (CEST)
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

This patch hiddes that SPR address needed for CPU6 ERRATA handling in the macro.
Then we don't have to worry about this address directly in the code.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
 arch/powerpc/kernel/head_8xx.S |   29 ++++++++++++++++-------------
 1 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 4dd6be0..a7af26e 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -33,12 +33,19 @@
 
 /* Macro to make the code more readable. */
 #ifdef CONFIG_8xx_CPU6
-#define DO_8xx_CPU6(val, reg)	\
-	li	reg, val;	\
-	stw	reg, 12(r0);	\
-	lwz	reg, 12(r0);
+#define SPRN_MI_TWC_ADDR	0x2b80
+#define SPRN_MI_RPN_ADDR	0x2d80
+#define SPRN_MD_TWC_ADDR	0x3b80
+#define SPRN_MD_RPN_ADDR	0x3d80
+
+#define MTSPR_CPU6(spr, reg, treg)	\
+	li	treg, spr##_ADDR;	\
+	stw	treg, 12(r0);		\
+	lwz	treg, 12(r0);		\
+	mtspr	spr, reg
 #else
-#define DO_8xx_CPU6(val, reg)
+#define MTSPR_CPU6(spr, reg, treg)	\
+	mtspr	spr, reg
 #endif
 
 /*
@@ -334,8 +341,7 @@ InstructionTLBMiss:
 	 * for this "segment."
 	 */
 	ori	r11,r11,1		/* Set valid bit */
-	DO_8xx_CPU6(0x2b80, r3)
-	mtspr	SPRN_MI_TWC, r11	/* Set segment attributes */
+	MTSPR_CPU6(SPRN_MI_TWC, r11, r3)	/* Set segment attributes */
 	mfspr	r11, SPRN_SRR0	/* Get effective address of fault */
 	/* Extract level 2 index */
 	rlwinm	r11, r11, 32 - (PAGE_SHIFT - 2), 32 - PAGE_SHIFT, 29
@@ -354,8 +360,7 @@ InstructionTLBMiss:
 	 */
 	li	r11, RPN_PATTERN
 	rlwimi	r10, r11, 0, 0x07f8	/* Set 24-27, clear 21-23,28 */
-	DO_8xx_CPU6(0x2d80, r3)
-	mtspr	SPRN_MI_RPN, r10	/* Update TLB entry */
+	MTSPR_CPU6(SPRN_MI_RPN, r10, r3)	/* Update TLB entry */
 
 	/* Restore registers */
 #ifdef CONFIG_8xx_CPU6
@@ -424,8 +429,7 @@ DataStoreTLBMiss:
 	 * It is bit 25 in the Linux PTE and bit 30 in the TWC
 	 */
 	rlwimi	r11, r10, 32-5, 30, 30
-	DO_8xx_CPU6(0x3b80, r3)
-	mtspr	SPRN_MD_TWC, r11
+	MTSPR_CPU6(SPRN_MD_TWC, r11, r3)
 
 	/* Both _PAGE_ACCESSED and _PAGE_PRESENT has to be set.
 	 * We also need to know if the insn is a load/store, so:
@@ -458,8 +462,7 @@ DataStoreTLBMiss:
 	 */
 2:	li	r11, RPN_PATTERN
 	rlwimi	r10, r11, 0, 24, 28	/* Set 24-27, clear 28 */
-	DO_8xx_CPU6(0x3d80, r3)
-	mtspr	SPRN_MD_RPN, r10	/* Update TLB entry */
+	MTSPR_CPU6(SPRN_MD_RPN, r10, r3)	/* Update TLB entry */
 
 	/* Restore registers */
 #ifdef CONFIG_8xx_CPU6
-- 
1.7.1
