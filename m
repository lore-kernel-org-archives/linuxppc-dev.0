Return-Path: <B40534@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0186.outbound.messaging.microsoft.com [213.199.154.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9DFFC2C03C6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Sep 2013 16:00:49 +1000 (EST)
From: Dongsheng Wang <dongsheng.wang@freescale.com>
To: <scottwood@freescale.com>
Subject: [PATCH v3 3/4] powerpc/85xx: add hardware automatically enter pw20
 state
Date: Wed, 11 Sep 2013 13:56:43 +0800
Message-ID: <1378879004-2446-3-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1378879004-2446-1-git-send-email-dongsheng.wang@freescale.com>
References: <1378879004-2446-1-git-send-email-dongsheng.wang@freescale.com>
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

 arch/powerpc/kernel/cpu_setup_fsl_booke.S | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/powerpc/kernel/cpu_setup_fsl_booke.S b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
index 3c03c109..7389d49 100644
--- a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
+++ b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
@@ -54,6 +54,27 @@ _GLOBAL(__e500_dcache_setup)
 	blr

 /*
+ * FIXME - We don't know, what time should we let the core into PW20 state.
+ * because we don't know the current state of the cpu load. And threads are
+ * independent, so we can not know the state of different thread has been
+ * idle.
+ */
+#define PW20_WAIT_IDLE_BIT		50 /* 1ms, TB frequency is 41.66MHZ */
+_GLOBAL(setup_pw20_idle)
+	mfspr	r3, SPRN_PWRMGTCR0
+
+	/* Set PW20_WAIT bit, enable pw20 state*/
+	ori	r3, r3, PWRMGTCR0_PW20_WAIT
+	li	r4, PW20_WAIT_IDLE_BIT
+
+	/* Set Automatic PW20 Core Idle Count */
+	rlwimi	r3, r4, PWRMGTCR0_PW20_ENT_SHIFT, PWRMGTCR0_PW20_ENT
+
+	mtspr	SPRN_PWRMGTCR0, r3
+
+	blr
+
+/*
  * FIXME - We don't know the AltiVec application scenarios.
  */
 #define AV_WAIT_IDLE_BIT		50 /* 1ms, TB frequency is 41.66MHZ */
@@ -76,6 +97,7 @@ _GLOBAL(__setup_cpu_e6500)
 #ifdef CONFIG_PPC64
 	bl	.setup_altivec_ivors
 #endif
+	bl	.setup_pw20_idle
 	bl	.setup_altivec_idle
 	bl	__setup_cpu_e5500
 	mtlr	r6
@@ -138,6 +160,7 @@ _GLOBAL(__setup_cpu_e5500)
 _GLOBAL(__restore_cpu_e6500)
 	mflr	r5
 	bl	.setup_altivec_ivors
+	bl	.setup_pw20_idle
 	bl	.setup_altivec_idle
 	bl	__restore_cpu_e5500
 	mtlr	r5
--
1.8.0
