From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Subject: [PATCH] clean up CPU6 #ifdefs in head_8xx.S
Date: Mon, 7 Jun 2004 18:54:12 +0200
Message-ID: <JPEALJAFNGDDLOPNDIEEOEDMCJAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom,
as discussed on IRC, here is a patch to clean up the ugly #ifdefs
for the CPU6 errata workaround in the TLB handlers. Against linuxppc-2.5

 Jocke


===== arch/ppc/kernel/head_8xx.S 1.22 vs edited =====
--- 1.22/arch/ppc/kernel/head_8xx.S	2004-05-29 00:11:11 +02:00
+++ edited/arch/ppc/kernel/head_8xx.S	2004-06-07 18:41:34 +02:00
@@ -32,6 +32,15 @@
 #include <asm/ppc_asm.h>
 #include <asm/offsets.h>

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
@@ -300,20 +309,14 @@
 InstructionTLBMiss:
 #ifdef CONFIG_8xx_CPU6
 	stw	r3, 8(r0)
-	li	r3, 0x3f80
-	stw	r3, 12(r0)
-	lwz	r3, 12(r0)
 #endif
+	DO_8xx_CPU6(0x3f80, r3)
 	mtspr	M_TW, r10	/* Save a couple of working registers */
 	mfcr	r10
 	stw	r10, 0(r0)
 	stw	r11, 4(r0)
 	mfspr	r10, SRR0	/* Get effective address of fault */
-#ifdef CONFIG_8xx_CPU6
-	li	r3, 0x3780
-	stw	r3, 12(r0)
-	lwz	r3, 12(r0)
-#endif
+	DO_8xx_CPU6(0x3780, r3)
 	mtspr	MD_EPN, r10	/* Have to use MD_EPN for walk, MI_EPN can't */
 	mfspr	r10, M_TWB	/* Get level 1 table entry address */

@@ -334,17 +337,9 @@
 	 * for this "segment."
 	 */
 	ori	r11,r11,1		/* Set valid bit */
-#ifdef CONFIG_8xx_CPU6
-	li	r3, 0x2b80
-	stw	r3, 12(r0)
-	lwz	r3, 12(r0)
-#endif
+	DO_8xx_CPU6(0x2b80, r3)
 	mtspr	MI_TWC, r11	/* Set segment attributes */
-#ifdef CONFIG_8xx_CPU6
-	li	r3, 0x3b80
-	stw	r3, 12(r0)
-	lwz	r3, 12(r0)
-#endif
+	DO_8xx_CPU6(0x3b80, r3)
 	mtspr	MD_TWC, r11	/* Load pte table base address */
 	mfspr	r11, MD_TWC	/* ....and get the pte address */
 	lwz	r10, 0(r11)	/* Get the pte */
@@ -360,12 +355,7 @@
 	 */
 	li	r11, 0x00f0
 	rlwimi	r10, r11, 0, 24, 28	/* Set 24-27, clear 28 */
-
-#ifdef CONFIG_8xx_CPU6
-	li	r3, 0x2d80
-	stw	r3, 12(r0)
-	lwz	r3, 12(r0)
-#endif
+	DO_8xx_CPU6(0x2d80, r3)
 	mtspr	MI_RPN, r10	/* Update TLB entry */

 	mfspr	r10, M_TW	/* Restore registers */
@@ -390,10 +380,8 @@
 DataStoreTLBMiss:
 #ifdef CONFIG_8xx_CPU6
 	stw	r3, 8(r0)
-	li	r3, 0x3f80
-	stw	r3, 12(r0)
-	lwz	r3, 12(r0)
 #endif
+	DO_8xx_CPU6(0x3f80, r3)
 	mtspr	M_TW, r10	/* Save a couple of working registers */
 	mfcr	r10
 	stw	r10, 0(r0)
@@ -416,11 +404,7 @@
 	/* We have a pte table, so load fetch the pte from the table.
 	 */
 	ori	r11, r11, 1	/* Set valid bit in physical L2 page */
-#ifdef CONFIG_8xx_CPU6
-	li	r3, 0x3b80
-	stw	r3, 12(r0)
-	lwz	r3, 12(r0)
-#endif
+	DO_8xx_CPU6(0x3b80, r3)
 	mtspr	MD_TWC, r11	/* Load pte table base address */
 	mfspr	r10, MD_TWC	/* ....and get the pte address */
 	lwz	r10, 0(r10)	/* Get the pte */
@@ -432,11 +416,7 @@
 	 * above.
 	 */
 	rlwimi	r11, r10, 0, 27, 27
-#ifdef CONFIG_8xx_CPU6
-	li	r3, 0x3b80
-	stw	r3, 12(r0)
-	lwz	r3, 12(r0)
-#endif
+	DO_8xx_CPU6(0x3b80, r3)
 	mtspr	MD_TWC, r11

 	mfspr	r11, MD_TWC	/* get the pte address again */
@@ -451,12 +431,7 @@
 	 */
 	li	r11, 0x00f0
 	rlwimi	r10, r11, 0, 24, 28	/* Set 24-27, clear 28 */
-
-#ifdef CONFIG_8xx_CPU6
-	li	r3, 0x3d80
-	stw	r3, 12(r0)
-	lwz	r3, 12(r0)
-#endif
+	DO_8xx_CPU6(0x3d80, r3)
 	mtspr	MD_RPN, r10	/* Update TLB entry */

 	mfspr	r10, M_TW	/* Restore registers */
@@ -497,10 +472,8 @@
 DataTLBError:
 #ifdef CONFIG_8xx_CPU6
 	stw	r3, 8(r0)
-	li	r3, 0x3f80
-	stw	r3, 12(r0)
-	lwz	r3, 12(r0)
 #endif
+	DO_8xx_CPU6(0x3f80, r3)
 	mtspr	M_TW, r10	/* Save a couple of working registers */
 	mfcr	r10
 	stw	r10, 0(r0)
@@ -533,11 +506,7 @@
 	ori	r11, r11, MD_EVALID
 	mfspr	r10, M_CASID
 	rlwimi	r11, r10, 0, 28, 31
-#ifdef CONFIG_8xx_CPU6
-	li	r3, 0x3780
-	stw	r3, 12(r0)
-	lwz	r3, 12(r0)
-#endif
+	DO_8xx_CPU6(0x3780, r3)
 	mtspr	MD_EPN, r11

 	mfspr	r10, M_TWB	/* Get level 1 table entry address */
@@ -558,11 +527,7 @@
 	/* We have a pte table, so fetch the pte from the table.
 	 */
 	ori	r11, r11, 1		/* Set valid bit in physical L2 page */
-#ifdef CONFIG_8xx_CPU6
-	li	r3, 0x3b80
-	stw	r3, 12(r0)
-	lwz	r3, 12(r0)
-#endif
+	DO_8xx_CPU6(0x3b80, r3)
 	mtspr	MD_TWC, r11		/* Load pte table base address */
 	mfspr	r11, MD_TWC		/* ....and get the pte address */
 	lwz	r10, 0(r11)		/* Get the pte */
@@ -584,12 +549,7 @@
 	 */
 	li	r11, 0x00f0
 	rlwimi	r10, r11, 0, 24, 28	/* Set 24-27, clear 28 */
-
-#ifdef CONFIG_8xx_CPU6
-	li	r3, 0x3d80
-	stw	r3, 12(r0)
-	lwz	r3, 12(r0)
-#endif
+	DO_8xx_CPU6(0x3d80, r3)
 	mtspr	MD_RPN, r10	/* Update TLB entry */

 	mfspr	r10, M_TW	/* Restore registers */


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
