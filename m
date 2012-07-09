Return-Path: <varuns@nmglablinux27.zin33.ap.freescale.net>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AE44C2C0200
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2012 22:56:54 +1000 (EST)
Received: from mail11-ch1 (localhost [127.0.0.1])	by mail11-ch1-R.bigfish.com
 (Postfix) with ESMTP id 4ED501401B0	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Jul 2012 12:54:33 +0000 (UTC)
Received: from CH1EHSMHS011.bigfish.com (snatpool2.int.messaging.microsoft.com
 [10.43.68.237])	by mail11-ch1.bigfish.com (Postfix) with ESMTP id
 24252400048
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2012 12:54:30 +0000 (UTC)
Received: from nmglablinux27.zin33.ap.freescale.net ([10.213.130.145])	by
 az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id q69CufsT008132	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Jul 2012 05:56:42 -0700
From: Varun Sethi <Varun.Sethi@freescale.com>
To: <agraf@suse.de>, <galak@kernel.crashing.org>, <benh@kernel.crashing.org>,
 <linuxppc-dev@lists.ozlabs.org>, <kvm-ppc@vger.kernel.org>
Subject: [PATCH 1/4] powepc/booke: Separate out E.HV check and ivor setup code.
Date: Mon, 9 Jul 2012 18:25:31 +0530
Message-ID: <1341838531-17023-1-git-send-email-Varun.Sethi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Varun Sethi <Varun.Sethi@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move the E.HV check and CPU_FTR_EMB_HV flag manipulation to the cpu setup code.
Create a separate routine for E.HV ivors setup.

Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
---
 arch/powerpc/kernel/cpu_setup_fsl_booke.S |   29 ++++++++++++++++++++++++++---
 arch/powerpc/kernel/head_fsl_booke.S      |   18 ++++--------------
 2 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/kernel/cpu_setup_fsl_booke.S b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
index 69fdd23..a55d028 100644
--- a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
+++ b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
@@ -16,6 +16,8 @@
 #include <asm/processor.h>
 #include <asm/cputable.h>
 #include <asm/ppc_asm.h>
+#include <asm/mmu-book3e.h>
+#include <asm/asm-offsets.h>
 
 _GLOBAL(__e500_icache_setup)
 	mfspr	r0, SPRN_L1CSR1
@@ -73,12 +75,33 @@ _GLOBAL(__setup_cpu_e500v2)
 	mtlr	r4
 	blr
 _GLOBAL(__setup_cpu_e500mc)
-	mr	r5, r4
-	mflr	r4
+	mflr	r5
 	bl	__e500_icache_setup
 	bl	__e500_dcache_setup
 	bl	__setup_e500mc_ivors
-	mtlr	r4
+	/*
+	 * We only want to touch IVOR38-41 if we're running on hardware
+	 * that supports category E.HV.  The architectural way to determine
+	 * this is MMUCFG[LPIDSIZE].
+	 */
+	mfspr	r3, SPRN_MMUCFG
+	rlwinm.	r3, r3, 0, MMUCFG_LPIDSIZE
+	beq	1f
+	bl	__setup_ehv_ivors
+	b	2f
+1:
+	lwz	r3, CPU_SPEC_FEATURES(r4)
+	/* We need this check as cpu_setup is also called for
+	 * the secondary cores. So, if we have already cleared
+	 * the feature on the primary core, avoid doing it on the
+	 * secondary core.
+	 */
+	andis.	r6, r3, CPU_FTR_EMB_HV@h
+	beq	2f
+	rlwinm	r3, r3, 0, ~CPU_FTR_EMB_HV
+	stw	r3, CPU_SPEC_FEATURES(r4)
+2:
+	mtlr	r5
 	blr
 #endif
 /* Right now, restore and setup are the same thing */
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 1f4434a..76c84c4 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -906,15 +906,11 @@ _GLOBAL(__setup_e500mc_ivors)
 	mtspr	SPRN_IVOR36,r3
 	li	r3,CriticalDoorbell@l
 	mtspr	SPRN_IVOR37,r3
+	sync
+	blr
 
-	/*
-	 * We only want to touch IVOR38-41 if we're running on hardware
-	 * that supports category E.HV.  The architectural way to determine
-	 * this is MMUCFG[LPIDSIZE].
-	 */
-	mfspr	r3, SPRN_MMUCFG
-	andis.	r3, r3, MMUCFG_LPIDSIZE@h
-	beq	no_hv
+/* setup ehv ivors for */
+_GLOBAL(__setup_ehv_ivors)
 	li	r3,GuestDoorbell@l
 	mtspr	SPRN_IVOR38,r3
 	li	r3,CriticalGuestDoorbell@l
@@ -923,14 +919,8 @@ _GLOBAL(__setup_e500mc_ivors)
 	mtspr	SPRN_IVOR40,r3
 	li	r3,Ehvpriv@l
 	mtspr	SPRN_IVOR41,r3
-skip_hv_ivors:
 	sync
 	blr
-no_hv:
-	lwz	r3, CPU_SPEC_FEATURES(r5)
-	rlwinm	r3, r3, 0, ~CPU_FTR_EMB_HV
-	stw	r3, CPU_SPEC_FEATURES(r5)
-	b	skip_hv_ivors
 
 #ifdef CONFIG_SPE
 /*
-- 
1.7.4.1
