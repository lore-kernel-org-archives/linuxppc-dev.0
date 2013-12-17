Return-Path: <Dongsheng.Wang@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5EA412C0305
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Dec 2013 19:19:58 +1100 (EST)
Received: from mail169-co1 (localhost [127.0.0.1])	by
 mail169-co1-R.bigfish.com (Postfix) with ESMTP id 417349C03D5	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Dec 2013 08:19:54 +0000 (UTC)
From: Dongsheng Wang <dongsheng.wang@freescale.com>
To: <scottwood@freescale.com>, <Bharat.Bhushan@freescale.com>
Subject: [PATCH v6 3/4] powerpc/85xx: add hardware automatically enter pw20
 state
Date: Tue, 17 Dec 2013 16:17:01 +0800
Message-ID: <1387268222-9703-3-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1387268222-9703-1-git-send-email-dongsheng.wang@freescale.com>
References: <1387268222-9703-1-git-send-email-dongsheng.wang@freescale.com>
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

Using hardware features make core automatically enter PW20 state.
Set a TB count to hardware, the effective count begins when PW10
is entered. When the effective period has expired, the core will
proceed from PW10 to PW20 if no exit conditions have occurred during
the period.

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
index 4789056..49e738e 100644
--- a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
+++ b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
@@ -55,6 +55,25 @@ _GLOBAL(__e500_dcache_setup)
 
 /*
  * FIXME - we haven't yet done testing to determine a reasonable default
+ * value for PW20_WAIT_IDLE_BIT.
+ */
+#define PW20_WAIT_IDLE_BIT		50 /* 1ms, TB frequency is 41.66MHZ */
+_GLOBAL(setup_pw20_idle)
+	mfspr	r3, SPRN_PWRMGTCR0
+
+	/* Set PW20_WAIT bit, enable pw20 state*/
+	ori	r3, r3, PWRMGTCR0_PW20_WAIT
+	li	r11, PW20_WAIT_IDLE_BIT
+
+	/* Set Automatic PW20 Core Idle Count */
+	rlwimi	r3, r11, PWRMGTCR0_PW20_ENT_SHIFT, PWRMGTCR0_PW20_ENT
+
+	mtspr	SPRN_PWRMGTCR0, r3
+
+	blr
+
+/*
+ * FIXME - we haven't yet done testing to determine a reasonable default
  * value for AV_WAIT_IDLE_BIT.
  */
 #define AV_WAIT_IDLE_BIT		50 /* 1ms, TB frequency is 41.66MHZ */
@@ -77,6 +96,7 @@ _GLOBAL(__setup_cpu_e6500)
 #ifdef CONFIG_PPC64
 	bl	.setup_altivec_ivors
 #endif
+	bl	setup_pw20_idle
 	bl	setup_altivec_idle
 	bl	__setup_cpu_e5500
 	mtlr	r6
@@ -139,6 +159,7 @@ _GLOBAL(__setup_cpu_e5500)
 _GLOBAL(__restore_cpu_e6500)
 	mflr	r5
 	bl	.setup_altivec_ivors
+	bl	.setup_pw20_idle
 	bl	.setup_altivec_idle
 	bl	__restore_cpu_e5500
 	mtlr	r5
-- 
1.8.0
