Return-Path: <B40534@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CC3DD2C011F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Aug 2013 18:44:11 +1000 (EST)
From: Dongsheng Wang <dongsheng.wang@freescale.com>
To: <scottwood@freescale.com>, <galak@kernel.crashing.org>
Subject: [PATCH v2 2/3] powerpc/85xx: add hardware automatically enter altivec
 idle state
Date: Tue, 27 Aug 2013 16:41:39 +0800
Message-ID: <1377592900-5020-2-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1377592900-5020-1-git-send-email-dongsheng.wang@freescale.com>
References: <1377592900-5020-1-git-send-email-dongsheng.wang@freescale.com>
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
*v2:
Remove:
delete setup_idle_hw_governor function.
delete "Fix erratum" for rev1.

Move:
move setup_* into __setup/restore_cpu_e6500.

diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
index 86ede76..8364bbe 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -217,6 +217,9 @@
 #define	CCR1_DPC	0x00000100 /* Disable L1 I-Cache/D-Cache parity checking */
 #define	CCR1_TCS	0x00000080 /* Timer Clock Select */
 
+/* Bit definitions for PWRMGTCR0. */
+#define PWRMGTCR0_ALTIVEC_IDLE	(1 << 22) /* Altivec idle enable */
+
 /* Bit definitions for the MCSR. */
 #define MCSR_MCS	0x80000000 /* Machine Check Summary */
 #define MCSR_IB		0x40000000 /* Instruction PLB Error */
diff --git a/arch/powerpc/kernel/cpu_setup_fsl_booke.S b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
index bfb18c7..90bbb46 100644
--- a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
+++ b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
@@ -58,6 +58,7 @@ _GLOBAL(__setup_cpu_e6500)
 #ifdef CONFIG_PPC64
 	bl	.setup_altivec_ivors
 #endif
+	bl	setup_altivec_idle
 	bl	__setup_cpu_e5500
 	mtlr	r6
 	blr
@@ -119,6 +120,7 @@ _GLOBAL(__setup_cpu_e5500)
 _GLOBAL(__restore_cpu_e6500)
 	mflr	r5
 	bl	.setup_altivec_ivors
+	bl	setup_altivec_idle
 	bl	__restore_cpu_e5500
 	mtlr	r5
 	blr
diff --git a/arch/powerpc/platforms/85xx/common.c b/arch/powerpc/platforms/85xx/common.c
index d0861a0..93b563b 100644
--- a/arch/powerpc/platforms/85xx/common.c
+++ b/arch/powerpc/platforms/85xx/common.c
@@ -11,6 +11,16 @@
 
 #include "mpc85xx.h"
 
+#define MAX_BIT				64
+
+#define ALTIVEC_COUNT_OFFSET		16
+#define ALTIVEC_IDLE_COUNT_MASK		0x003f0000
+
+/*
+ * FIXME - We don't know the AltiVec application scenarios.
+ */
+#define ALTIVEC_IDLE_TIME_BIT	14 /* 1ms */
+
 static struct of_device_id __initdata mpc85xx_common_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
@@ -80,3 +90,38 @@ void __init mpc85xx_cpm2_pic_init(void)
 	irq_set_chained_handler(irq, cpm2_cascade);
 }
 #endif
+
+static bool has_pw20_altivec_idle(void)
+{
+	u32 pvr;
+
+	pvr = mfspr(SPRN_PVR);
+
+	/* PW20 & AltiVec idle feature only exists for E6500 */
+	if (PVR_VER(pvr) != PVR_VER_E6500)
+		return false;
+
+	return true;
+}
+
+void setup_altivec_idle(void)
+{
+	u32 altivec_idle;
+
+	if (!has_pw20_altivec_idle())
+		return;
+
+	/* Enable Altivec Idle */
+	altivec_idle = mfspr(SPRN_PWRMGTCR0);
+	altivec_idle |= PWRMGTCR0_ALTIVEC_IDLE;
+
+	/* Set Automatic AltiVec Idle Count */
+	/* clear count */
+	altivec_idle &= ~ALTIVEC_IDLE_COUNT_MASK;
+
+	/* set count */
+	altivec_idle |=
+		((MAX_BIT - ALTIVEC_IDLE_TIME_BIT) << ALTIVEC_COUNT_OFFSET);
+
+	mtspr(SPRN_PWRMGTCR0, altivec_idle);
+}
-- 
1.8.0
