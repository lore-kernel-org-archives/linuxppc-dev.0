Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6372C474C2
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jan 2009 01:33:57 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n08EXrj8001015
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Jan 2009 08:33:54 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/e500mc: Minor tweaks to init/exception code for e500mc
Date: Thu,  8 Jan 2009 08:33:53 -0600
Message-Id: <1231425233-6392-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* PID1/PID2 don't exist on e500mc so we should write them
* Doorbell exceptions need to be taken w/EE still disabled since we use
  them for things like IPIs

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/head_fsl_booke.S |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 2f32720..6319973 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -103,7 +103,7 @@ invstr:	mflr	r6				/* Make it accessible */
 	or	r7,r7,r4
 	mtspr	SPRN_MAS6,r7
 	tlbsx	0,r6				/* search MSR[IS], SPID=PID0 */
-#ifndef CONFIG_E200
+#if !defined(CONFIG_E200) && !defined(CONFIG_PPC_E500MC)
 	mfspr	r7,SPRN_MAS1
 	andis.	r7,r7,MAS1_VALID@h
 	bne	match_TLB
@@ -216,7 +216,7 @@ skpinv:	addi	r6,r6,1				/* Increment */
 /* 4. Clear out PIDs & Search info */
 	li	r6,0
 	mtspr	SPRN_PID0,r6
-#ifndef CONFIG_E200
+#if !defined(CONFIG_E200) && !defined(CONFIG_PPC_E500MC)
 	mtspr	SPRN_PID1,r6
 	mtspr	SPRN_PID2,r6
 #endif
@@ -707,7 +707,7 @@ interrupt_base:
 	EXCEPTION(0x2060, PerformanceMonitor, performance_monitor_exception, EXC_XFER_STD)
 
 #ifdef CONFIG_PPC_E500MC
-	EXCEPTION(0x2070, Doorbell, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x2070, Doorbell, unknown_exception, EXC_XFER_STD)
 #endif
 
 	/* Debug Interrupt */
-- 
1.5.6.5
