Return-Path: <varuns@nmglablinux27.zin33.ap.freescale.net>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 587582C0201
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2012 23:03:14 +1000 (EST)
Received: from mail8-co1 (localhost [127.0.0.1])	by mail8-co1-R.bigfish.com
 (Postfix) with ESMTP id 8EC1DB40304	for <linuxppc-dev@lists.ozlabs.org>; Mon,
 9 Jul 2012 13:00:53 +0000 (UTC)
Received: from CO1EHSMHS007.bigfish.com (unknown [10.243.78.251])	by
 mail8-co1.bigfish.com (Postfix) with ESMTP id AEACE88004A	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2012 13:00:50 +0000 (UTC)
Received: from nmglablinux27.zin33.ap.freescale.net ([10.213.130.145])	by
 tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id q69D33Id012985	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Jul 2012 06:03:04 -0700
From: Varun Sethi <Varun.Sethi@freescale.com>
To: <agraf@suse.de>, <galak@kernel.crashing.org>, <benh@kernel.crashing.org>,
 <linuxppc-dev@lists.ozlabs.org>, <kvm-ppc@vger.kernel.org>
Subject: [PATCH 3/4] powerpc/booke: Separate out restore_e5500/setup_e5500
 routines.
Date: Mon, 9 Jul 2012 18:31:51 +0530
Message-ID: <1341838911-17157-1-git-send-email-Varun.Sethi@freescale.com>
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

For the 64 bit case separate out e5500 cpu_setup and cpu_restore functions.
The cpu_setup function (for the primary core) is passed the cpu_spec pointer,
which is not there in case of the cpu_restore function. Also, in our case
we will have to manipulate the CPU_FTR_EMB_HV flag on the the primary core.  

Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
---
 arch/powerpc/kernel/cpu_setup_fsl_booke.S |   38 ++++++++++++++++++++++++----
 arch/powerpc/kernel/exceptions-64e.S      |   18 +------------
 2 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/kernel/cpu_setup_fsl_booke.S b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
index 5e87737..1345e1b 100644
--- a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
+++ b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
@@ -105,19 +105,45 @@ _GLOBAL(__setup_cpu_e5500)
 	mtlr	r5
 	blr
 #endif
-/* Right now, restore and setup are the same thing */
+
+#ifdef CONFIG_PPC_BOOK3E_64
 _GLOBAL(__restore_cpu_e5500)
-_GLOBAL(__setup_cpu_e5500)
 	mflr	r4
 	bl	__e500_icache_setup
 	bl	__e500_dcache_setup
-#ifdef CONFIG_PPC_BOOK3E_64
 	bl	.__setup_base_ivors
 	bl	.setup_perfmon_ivor
 	bl	.setup_doorbell_ivors
+	/*
+	 * We only want to touch IVOR38-41 if we're running on hardware
+	 * that supports category E.HV.  The architectural way to determine
+	 * this is MMUCFG[LPIDSIZE].
+	 */
+	mfspr	r10,SPRN_MMUCFG
+	rlwinm.	r10,r10,0,MMUCFG_LPIDSIZE
+	beq	1f
 	bl	.setup_ehv_ivors
-#else
-	bl	__setup_e500mc_ivors
-#endif
+1:
 	mtlr	r4
 	blr
+
+_GLOBAL(__setup_cpu_e5500)
+	mflr	r5
+	bl	__e500_icache_setup
+	bl	__e500_dcache_setup
+	bl	.__setup_base_ivors
+	bl	.setup_perfmon_ivor
+	bl	.setup_doorbell_ivors
+	/*
+	 * We only want to touch IVOR38-41 if we're running on hardware
+	 * that supports category E.HV.  The architectural way to determine
+	 * this is MMUCFG[LPIDSIZE].
+	 */
+	mfspr	r10,SPRN_MMUCFG
+	rlwinm.	r10,r10,0,MMUCFG_LPIDSIZE
+	beq	1f
+	bl	.setup_ehv_ivors
+1:
+	mtlr	r5
+	blr
+#endif
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 7215cc2..5f9ef1b 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -1302,25 +1302,11 @@ _GLOBAL(setup_perfmon_ivor)
 _GLOBAL(setup_doorbell_ivors)
 	SET_IVOR(36, 0x280) /* Processor Doorbell */
 	SET_IVOR(37, 0x2a0) /* Processor Doorbell Crit */
-
-	/* Check MMUCFG[LPIDSIZE] to determine if we have category E.HV */
-	mfspr	r10,SPRN_MMUCFG
-	rlwinm.	r10,r10,0,MMUCFG_LPIDSIZE
-	beqlr
-
-	SET_IVOR(38, 0x2c0) /* Guest Processor Doorbell */
-	SET_IVOR(39, 0x2e0) /* Guest Processor Doorbell Crit/MC */
 	blr
 
 _GLOBAL(setup_ehv_ivors)
-	/*
-	 * We may be running as a guest and lack E.HV even on a chip
-	 * that normally has it.
-	 */
-	mfspr	r10,SPRN_MMUCFG
-	rlwinm.	r10,r10,0,MMUCFG_LPIDSIZE
-	beqlr
-
 	SET_IVOR(40, 0x300) /* Embedded Hypervisor System Call */
 	SET_IVOR(41, 0x320) /* Embedded Hypervisor Privilege */
+	SET_IVOR(38, 0x2c0) /* Guest Processor Doorbell */
+	SET_IVOR(39, 0x2e0) /* Guest Processor Doorbell Crit/MC */
 	blr
-- 
1.7.4.1
