Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 43800B70D4
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Jan 2011 08:38:10 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: Willy Tarreau <w@1wt.eu>, Scott Wood <scottwood@freescale.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 01/13] 8xx: Use a macro to simpliy CPU6 errata code.
Date: Mon, 10 Jan 2011 22:37:47 +0100
Message-Id: <1294695479-344-2-git-send-email-Joakim.Tjernlund@transmode.se>
In-Reply-To: <1294695479-344-1-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1294695479-344-1-git-send-email-Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
 arch/ppc/kernel/head_8xx.S |   84 +++++++++++--------------------------------
 1 files changed, 22 insertions(+), 62 deletions(-)

diff --git a/arch/ppc/kernel/head_8xx.S b/arch/ppc/kernel/head_8xx.S
index f9a30f3..ba05a57 100644
--- a/arch/ppc/kernel/head_8xx.S
+++ b/arch/ppc/kernel/head_8xx.S
@@ -31,6 +31,15 @@
 #include <asm/ppc_asm.h>
 #include "ppc_defs.h"
 
+/* Macro to make the code more readable. */
+#ifdef CONFIG_8xx_CPU6
+  #define DO_8xx_CPU6(val, reg) \
+	li	reg, val; \
+	stw	reg, 12(r0); \
+	lwz	reg, 12(r0);
+#else
+  #define DO_8xx_CPU6(val, reg)
+#endif
 	.text
 	.globl	_stext
 _stext:
@@ -310,20 +319,14 @@ SystemCall:
 InstructionTLBMiss:
 #ifdef CONFIG_8xx_CPU6
 	stw	r3, 8(r0)
-	li	r3, 0x3f80
-	stw	r3, 12(r0)
-	lwz	r3, 12(r0)
 #endif
+	DO_8xx_CPU6(0x3f80, r3)
 	mtspr	M_TW, r20	/* Save a couple of working registers */
 	mfcr	r20
 	stw	r20, 0(r0)
 	stw	r21, 4(r0)
 	mfspr	r20, SRR0	/* Get effective address of fault */
-#ifdef CONFIG_8xx_CPU6
-	li	r3, 0x3780
-	stw	r3, 12(r0)
-	lwz	r3, 12(r0)
-#endif
+	DO_8xx_CPU6(0x3780, r3)
 	mtspr	MD_EPN, r20	/* Have to use MD_EPN for walk, MI_EPN can't */
 	mfspr	r20, M_TWB	/* Get level 1 table entry address */
 
@@ -345,17 +348,9 @@ InstructionTLBMiss:
 	tophys(r21,r21)
 	ori	r21,r21,1		/* Set valid bit */
 	beq-	2f			/* If zero, don't try to find a pte */
-#ifdef CONFIG_8xx_CPU6
-	li	r3, 0x2b80
-	stw	r3, 12(r0)
-	lwz	r3, 12(r0)
-#endif
+	DO_8xx_CPU6(0x2b80, r3)
 	mtspr	MI_TWC, r21	/* Set segment attributes */
-#ifdef CONFIG_8xx_CPU6
-	li	r3, 0x3b80
-	stw	r3, 12(r0)
-	lwz	r3, 12(r0)
-#endif
+	DO_8xx_CPU6(0x3b80, r3)
 	mtspr	MD_TWC, r21	/* Load pte table base address */
 	mfspr	r21, MD_TWC	/* ....and get the pte address */
 	lwz	r20, 0(r21)	/* Get the pte */
@@ -371,12 +366,7 @@ InstructionTLBMiss:
 	 */
 2:	li	r21, 0x00f0
 	rlwimi	r20, r21, 0, 24, 28	/* Set 24-27, clear 28 */
-
-#ifdef CONFIG_8xx_CPU6
-	li	r3, 0x2d80
-	stw	r3, 12(r0)
-	lwz	r3, 12(r0)
-#endif
+	DO_8xx_CPU6(0x2d80, r3)
 	mtspr	MI_RPN, r20	/* Update TLB entry */
 
 	mfspr	r20, M_TW	/* Restore registers */
@@ -392,10 +382,8 @@ InstructionTLBMiss:
 DataStoreTLBMiss:
 #ifdef CONFIG_8xx_CPU6
 	stw	r3, 8(r0)
-	li	r3, 0x3f80
-	stw	r3, 12(r0)
-	lwz	r3, 12(r0)
 #endif
+	DO_8xx_CPU6(0x3f80, r3)
 	mtspr	M_TW, r20	/* Save a couple of working registers */
 	mfcr	r20
 	stw	r20, 0(r0)
@@ -419,11 +407,7 @@ DataStoreTLBMiss:
 	tophys(r21, r21)
 	ori	r21, r21, 1	/* Set valid bit in physical L2 page */
 	beq-	2f		/* If zero, don't try to find a pte */
-#ifdef CONFIG_8xx_CPU6
-	li	r3, 0x3b80
-	stw	r3, 12(r0)
-	lwz	r3, 12(r0)
-#endif
+	DO_8xx_CPU6(0x3b80, r3)
 	mtspr	MD_TWC, r21	/* Load pte table base address */
 	mfspr	r20, MD_TWC	/* ....and get the pte address */
 	lwz	r20, 0(r20)	/* Get the pte */
@@ -435,11 +419,7 @@ DataStoreTLBMiss:
 	 * above.
 	 */
 	rlwimi	r21, r20, 0, 27, 27
-#ifdef CONFIG_8xx_CPU6
-	li	r3, 0x3b80
-	stw	r3, 12(r0)
-	lwz	r3, 12(r0)
-#endif
+	DO_8xx_CPU6(0x3b80, r3)
 	mtspr	MD_TWC, r21
 
 	mfspr	r21, MD_TWC	/* get the pte address again */
@@ -454,12 +434,7 @@ DataStoreTLBMiss:
 	 */
 2:	li	r21, 0x00f0
 	rlwimi	r20, r21, 0, 24, 28	/* Set 24-27, clear 28 */
-
-#ifdef CONFIG_8xx_CPU6
-	li	r3, 0x3d80
-	stw	r3, 12(r0)
-	lwz	r3, 12(r0)
-#endif
+	DO_8xx_CPU6(0x3d80, r3)
 	mtspr	MD_RPN, r20	/* Update TLB entry */
 
 	mfspr	r20, M_TW	/* Restore registers */
@@ -491,10 +466,8 @@ InstructionTLBError:
 DataTLBError:
 #ifdef CONFIG_8xx_CPU6
 	stw	r3, 8(r0)
-	li	r3, 0x3f80
-	stw	r3, 12(r0)
-	lwz	r3, 12(r0)
 #endif
+	DO_8xx_CPU6(0x3f80, r3)
 	mtspr	M_TW, r20	/* Save a couple of working registers */
 	mfcr	r20
 	stw	r20, 0(r0)
@@ -527,11 +500,7 @@ DataTLBError:
 	ori	r21, r21, MD_EVALID
 	mfspr	r20, M_CASID
 	rlwimi	r21, r20, 0, 28, 31
-#ifdef CONFIG_8xx_CPU6
-	li	r3, 0x3780
-	stw	r3, 12(r0)
-	lwz	r3, 12(r0)
-#endif
+	DO_8xx_CPU6(0x3780, r3)
 	mtspr	MD_EPN, r21
 
 	mfspr	r20, M_TWB	/* Get level 1 table entry address */
@@ -553,11 +522,7 @@ DataTLBError:
 	 */
 	tophys(r21, r21)
 	ori	r21, r21, 1		/* Set valid bit in physical L2 page */
-#ifdef CONFIG_8xx_CPU6
-	li	r3, 0x3b80
-	stw	r3, 12(r0)
-	lwz	r3, 12(r0)
-#endif
+	DO_8xx_CPU6(0x3b80, r3)
 	mtspr	MD_TWC, r21		/* Load pte table base address */
 	mfspr	r21, MD_TWC		/* ....and get the pte address */
 	lwz	r20, 0(r21)		/* Get the pte */
@@ -579,12 +544,7 @@ DataTLBError:
 	 */
 	li	r21, 0x00f0
 	rlwimi	r20, r21, 0, 24, 28	/* Set 24-27, clear 28 */
-
-#ifdef CONFIG_8xx_CPU6
-	li	r3, 0x3d80
-	stw	r3, 12(r0)
-	lwz	r3, 12(r0)
-#endif
+	DO_8xx_CPU6(0x3d80, r3)
 	mtspr	MD_RPN, r20	/* Update TLB entry */
 
 	mfspr	r20, M_TW	/* Restore registers */
-- 
1.7.3.4
