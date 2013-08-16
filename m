Return-Path: <B40534@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0189.outbound.messaging.microsoft.com [213.199.154.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2303A2C007E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Aug 2013 18:17:44 +1000 (EST)
Received: from mail27-db8 (localhost [127.0.0.1])	by mail27-db8-R.bigfish.com
 (Postfix) with ESMTP id 62D44DE01C8	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,
 16 Aug 2013 08:17:39 +0000 (UTC)
Received: from DB8EHSMHS018.bigfish.com (unknown [10.174.8.236])	by
 mail27-db8.bigfish.com (Postfix) with ESMTP id E03FB14C0046	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Aug 2013 08:17:36 +0000 (UTC)
From: Dongsheng Wang <dongsheng.wang@freescale.com>
To: <scottwood@freescale.com>
Subject: [PATCH 1/2] powerpc/85xx: add hardware automatically enter altivec
 idle state
Date: Fri, 16 Aug 2013 15:23:08 +0800
Message-ID: <1376637789-27330-1-git-send-email-dongsheng.wang@freescale.com>
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

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 5d7d9c2..5c7a7ba 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1053,6 +1053,8 @@
 #define PVR_8560	0x80200000
 #define PVR_VER_E500V1	0x8020
 #define PVR_VER_E500V2	0x8021
+#define PVR_VER_E6500	0x8040
+
 /*
  * For the 8xx processors, all of them report the same PVR family for
  * the PowerPC core. The various versions of these processors must be
diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
index b417de3..c047e08 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -170,6 +170,7 @@
 #define SPRN_L2CSR1	0x3FA	/* L2 Data Cache Control and Status Register 1 */
 #define SPRN_DCCR	0x3FA	/* Data Cache Cacheability Register */
 #define SPRN_ICCR	0x3FB	/* Instruction Cache Cacheability Register */
+#define SPRN_PWRMGTCR0	0x3FB	/* Power management control register 0 */
 #define SPRN_SVR	0x3FF	/* System Version Register */
 
 /*
@@ -216,6 +217,9 @@
 #define	CCR1_DPC	0x00000100 /* Disable L1 I-Cache/D-Cache parity checking */
 #define	CCR1_TCS	0x00000080 /* Timer Clock Select */
 
+/* Bit definitions for PWRMGTCR0. */
+#define PWRMGTCR0_ALTIVEC_IDLE	(1 << 22) /* Altivec idle enable */
+
 /* Bit definitions for the MCSR. */
 #define MCSR_MCS	0x80000000 /* Machine Check Summary */
 #define MCSR_IB		0x40000000 /* Instruction PLB Error */
diff --git a/arch/powerpc/platforms/85xx/common.c b/arch/powerpc/platforms/85xx/common.c
index d0861a0..dbbbc24 100644
--- a/arch/powerpc/platforms/85xx/common.c
+++ b/arch/powerpc/platforms/85xx/common.c
@@ -7,10 +7,22 @@
  */
 #include <linux/of_platform.h>
 
+#include <asm/time.h>
+
 #include <sysdev/cpm2_pic.h>
 
 #include "mpc85xx.h"
 
+#define MAX_BIT				64
+
+#define ALTIVEC_COUNT_OFFSET		16
+#define ALTIVEC_IDLE_COUNT_MASK		0x003f0000
+
+/*
+ * FIXME - We don't know the AltiVec application scenarios.
+ */
+#define ALTIVEC_IDLE_TIME	1000 /* 1ms */
+
 static struct of_device_id __initdata mpc85xx_common_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
@@ -80,3 +92,63 @@ void __init mpc85xx_cpm2_pic_init(void)
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
+	/* Fix erratum, e6500 rev1 does not support PW20 & AltiVec idle */
+	if (PVR_REV(pvr) < 0x20)
+		return false;
+
+	return true;
+}
+
+static unsigned int get_idle_ticks_bit(unsigned int us)
+{
+	unsigned int cycle;
+
+	/*
+	 * The time control by TB turn over bit, so we need
+	 * to be divided by 2.
+	 */
+	cycle = (us / 2) * tb_ticks_per_usec;
+
+	return ilog2(cycle) + 1;
+}
+
+static void setup_altivec_idle(void *unused)
+{
+	u32 altivec_idle, bit;
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
+	bit = get_idle_ticks_bit(ALTIVEC_IDLE_TIME);
+	altivec_idle |= ((MAX_BIT - bit) << ALTIVEC_COUNT_OFFSET);
+
+	mtspr(SPRN_PWRMGTCR0, altivec_idle);
+}
+
+static int __init setup_idle_hw_governor(void)
+{
+	on_each_cpu(setup_altivec_idle, NULL, 1);
+
+	return 0;
+}
+late_initcall(setup_idle_hw_governor);
-- 
1.8.0
