Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0237.outbound.protection.outlook.com [207.46.163.237])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40ADF2C0084
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jan 2014 09:38:03 +1100 (EST)
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/fsl-booke: Use SPRN_SPRGn rather than mfsprg/mtsprg
Date: Thu, 2 Jan 2014 16:37:50 -0600
Message-ID: <1388702270-21550-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>,
 Anton Vorontsov <avorontsov@mvista.com>, linuxppc-dev@lists.ozlabs.org,
 Dongsheng Wang <dongsheng.wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This fixes a build break that was probably introduced with the removal
of -Wa,-me500 (commit f49596a4cf4753d13951608f24f939a59fdcc653), where
the assembler refuses to recognize SPRG4-7 with a generic PPC target.

Signed-off-by: Scott Wood <scottwood@freescale.com>
Cc: Dongsheng Wang <dongsheng.wang@freescale.com>
Cc: Anton Vorontsov <avorontsov@mvista.com>
---
Dongsheng, please test.
---
 arch/powerpc/kernel/swsusp_booke.S | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/kernel/swsusp_booke.S b/arch/powerpc/kernel/swsusp_booke.S
index 0f20405..553c140 100644
--- a/arch/powerpc/kernel/swsusp_booke.S
+++ b/arch/powerpc/kernel/swsusp_booke.S
@@ -74,21 +74,21 @@ _GLOBAL(swsusp_arch_suspend)
 	bne	1b
 
 	/* Save SPRGs */
-	mfsprg	r4,0
+	mfspr	r4,SPRN_SPRG0
 	stw	r4,SL_SPRG0(r11)
-	mfsprg	r4,1
+	mfspr	r4,SPRN_SPRG1
 	stw	r4,SL_SPRG1(r11)
-	mfsprg	r4,2
+	mfspr	r4,SPRN_SPRG2
 	stw	r4,SL_SPRG2(r11)
-	mfsprg	r4,3
+	mfspr	r4,SPRN_SPRG3
 	stw	r4,SL_SPRG3(r11)
-	mfsprg	r4,4
+	mfspr	r4,SPRN_SPRG4
 	stw	r4,SL_SPRG4(r11)
-	mfsprg	r4,5
+	mfspr	r4,SPRN_SPRG5
 	stw	r4,SL_SPRG5(r11)
-	mfsprg	r4,6
+	mfspr	r4,SPRN_SPRG6
 	stw	r4,SL_SPRG6(r11)
-	mfsprg	r4,7
+	mfspr	r4,SPRN_SPRG7
 	stw	r4,SL_SPRG7(r11)
 
 	/* Call the low level suspend stuff (we should probably have made
@@ -150,21 +150,21 @@ _GLOBAL(swsusp_arch_resume)
 	bl	_tlbil_all
 
 	lwz	r4,SL_SPRG0(r11)
-	mtsprg	0,r4
+	mtspr	SPRN_SPRG0,r4
 	lwz	r4,SL_SPRG1(r11)
-	mtsprg	1,r4
+	mtspr	SPRN_SPRG1,r4
 	lwz	r4,SL_SPRG2(r11)
-	mtsprg	2,r4
+	mtspr	SPRN_SPRG2,r4
 	lwz	r4,SL_SPRG3(r11)
-	mtsprg	3,r4
+	mtspr	SPRN_SPRG3,r4
 	lwz	r4,SL_SPRG4(r11)
-	mtsprg	4,r4
+	mtspr	SPRN_SPRG4,r4
 	lwz	r4,SL_SPRG5(r11)
-	mtsprg	5,r4
+	mtspr	SPRN_SPRG5,r4
 	lwz	r4,SL_SPRG6(r11)
-	mtsprg	6,r4
+	mtspr	SPRN_SPRG6,r4
 	lwz	r4,SL_SPRG7(r11)
-	mtsprg	7,r4
+	mtspr	SPRN_SPRG7,r4
 
 	/* restore the MSR */
 	lwz	r3,SL_MSR(r11)
-- 
1.8.3.2
