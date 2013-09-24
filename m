Return-Path: <B40534@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2BA022C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Sep 2013 19:34:25 +1000 (EST)
From: Dongsheng Wang <dongsheng.wang@freescale.com>
To: <scottwood@freescale.com>
Subject: [PATCH v4 2/4] powerpc/85xx: add hardware automatically enter altivec
 idle state
Date: Tue, 24 Sep 2013 17:28:43 +0800
Message-ID: <1380014925-23300-2-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org,
 Wang Dongsheng <dongsheng.wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wang Dongsheng <dongsheng.wang@freescale.com>

Each core's AltiVec unit may be placed into a power savings mode
by turning off power to the unit. Core hardware will automatically
power down the AltiVec unit after no AltiVec instructions have
executed in N cycles. The AltiVec power-control is triggered by hardware.

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
---
*v3:
Assembly code instead of C code.

*v2:
Remove:
delete setup_idle_hw_governor function.
delete "Fix erratum" for rev1.

Move:
move setup_* into __setup/restore_cpu_e6500.

 arch/powerpc/kernel/cpu_setup_fsl_booke.S | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/powerpc/kernel/cpu_setup_fsl_booke.S b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
index bfb18c7..4789056 100644
--- a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
+++ b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
@@ -53,11 +53,31 @@ _GLOBAL(__e500_dcache_setup)
 	isync
 	blr
 
+/*
+ * FIXME - we haven't yet done testing to determine a reasonable default
+ * value for AV_WAIT_IDLE_BIT.
+ */
+#define AV_WAIT_IDLE_BIT		50 /* 1ms, TB frequency is 41.66MHZ */
+_GLOBAL(setup_altivec_idle)
+	mfspr	r3, SPRN_PWRMGTCR0
+
+	/* Enable Altivec Idle */
+	oris	r3, r3, PWRMGTCR0_AV_IDLE_PD_EN@h
+	li	r11, AV_WAIT_IDLE_BIT
+
+	/* Set Automatic AltiVec Idle Count */
+	rlwimi	r3, r11, PWRMGTCR0_AV_IDLE_CNT_SHIFT, PWRMGTCR0_AV_IDLE_CNT
+
+	mtspr	SPRN_PWRMGTCR0, r3
+
+	blr
+
 _GLOBAL(__setup_cpu_e6500)
 	mflr	r6
 #ifdef CONFIG_PPC64
 	bl	.setup_altivec_ivors
 #endif
+	bl	setup_altivec_idle
 	bl	__setup_cpu_e5500
 	mtlr	r6
 	blr
@@ -119,6 +139,7 @@ _GLOBAL(__setup_cpu_e5500)
 _GLOBAL(__restore_cpu_e6500)
 	mflr	r5
 	bl	.setup_altivec_ivors
+	bl	.setup_altivec_idle
 	bl	__restore_cpu_e5500
 	mtlr	r5
 	blr
-- 
1.8.0
