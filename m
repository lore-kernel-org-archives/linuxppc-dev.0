Return-Path: <B35336@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id C0BF2B72A2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Dec 2011 22:43:29 +1100 (EST)
Received: from mail143-ch1 (localhost [127.0.0.1])	by
 mail143-ch1-R.bigfish.com (Postfix) with ESMTP id 46A711C02E8	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Dec 2011 11:43:48 +0000 (UTC)
Received: from CH1EHSMHS010.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.247])	by mail143-ch1.bigfish.com (Postfix) with ESMTP id
 1BE8E680042	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Dec 2011 11:43:48
 +0000 (UTC)
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v3 3/4] fsl_pmc: Add API to enable device as wakeup event
 source
Date: Thu, 22 Dec 2011 19:43:33 +0800
Message-ID: <1324554214-19502-3-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1324554214-19502-1-git-send-email-chenhui.zhao@freescale.com>
References: <1324554214-19502-1-git-send-email-chenhui.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add APIs for setting wakeup source and lossless Ethernet in low power modes.
These APIs can be used by wake-on-packet feature.

Signed-off-by: Dave Liu <daveliu@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Jin Qing <b24347@freescale.com>
Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
---
 arch/powerpc/sysdev/fsl_pmc.c |   70 ++++++++++++++++++++++++++++++++++++++++-
 arch/powerpc/sysdev/fsl_soc.h |    9 +++++
 2 files changed, 78 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pmc.c b/arch/powerpc/sysdev/fsl_pmc.c
index 618a52c..0c99591 100644
--- a/arch/powerpc/sysdev/fsl_pmc.c
+++ b/arch/powerpc/sysdev/fsl_pmc.c
@@ -32,6 +32,7 @@ struct pmc_regs {
 	__be32 powmgtcsr;
 #define POWMGTCSR_SLP_MASK	0x00020000
 #define POWMGTCSR_DPSLP_MASK    0x00100000
+#define POWMGTCSR_LOSSLESS_MASK	0x00400000
 	__be32 res3[2];
 	__be32 pmcdr;
 };
@@ -41,6 +42,73 @@ static unsigned int pmc_flag;
 
 #define PMC_SLEEP	0x1
 #define PMC_DEEP_SLEEP	0x2
+#define PMC_LOSSLESS	0x4
+
+/**
+ * mpc85xx_pmc_set_wake - enable devices as wakeup event source
+ * @pdev: platform device affected
+ * @enable: True to enable event generation; false to disable
+ *
+ * This enables the device as a wakeup event source, or disables it.
+ *
+ * RETURN VALUE:
+ * 0 is returned on success
+ * -EINVAL is returned if device is not supposed to wake up the system
+ * Error code depending on the platform is returned if both the platform and
+ * the native mechanism fail to enable the generation of wake-up events
+ */
+int mpc85xx_pmc_set_wake(struct platform_device *pdev, bool enable)
+{
+	int ret = 0;
+	struct device_node *clk_np;
+	u32 pmcdr_mask;
+
+	if (!pmc_regs) {
+		pr_err("%s: PMC is unavailable\n", __func__);
+		return -ENODEV;
+	}
+
+	if (enable && !device_may_wakeup(&pdev->dev))
+		return -EINVAL;
+
+	clk_np = of_parse_phandle(pdev->dev.of_node, "clk-handle", 0);
+	if (!clk_np)
+		return -EINVAL;
+
+	if (of_property_read_u32(clk_np, "fsl,pmcdr-mask", &pmcdr_mask)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (enable)
+		/* clear to enable clock in low power mode */
+		clrbits32(&pmc_regs->pmcdr, pmcdr_mask);
+	else
+		setbits32(&pmc_regs->pmcdr, pmcdr_mask);
+
+out:
+	of_node_put(clk_np);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mpc85xx_pmc_set_wake);
+
+/**
+ * mpc85xx_pmc_set_lossless_ethernet - enable lossless ethernet
+ * in (deep) sleep mode
+ * @enable: True to enable event generation; false to disable
+ */
+void mpc85xx_pmc_set_lossless_ethernet(int enable)
+{
+	if (pmc_flag & PMC_LOSSLESS) {
+		if (enable)
+			setbits32(&pmc_regs->powmgtcsr,
+					POWMGTCSR_LOSSLESS_MASK);
+		else
+			clrbits32(&pmc_regs->powmgtcsr,
+					POWMGTCSR_LOSSLESS_MASK);
+	}
+}
+EXPORT_SYMBOL_GPL(mpc85xx_pmc_set_lossless_ethernet);
 
 static int pmc_suspend_enter(suspend_state_t state)
 {
@@ -117,7 +185,7 @@ static int pmc_probe(struct platform_device *pdev)
 		pmc_flag |= PMC_DEEP_SLEEP;
 
 	if (of_device_is_compatible(np, "fsl,p1022-pmc"))
-		pmc_flag |= PMC_DEEP_SLEEP;
+		pmc_flag |= PMC_DEEP_SLEEP | PMC_LOSSLESS;
 
 	suspend_set_ops(&pmc_suspend_ops);
 
diff --git a/arch/powerpc/sysdev/fsl_soc.h b/arch/powerpc/sysdev/fsl_soc.h
index 949377d..29a87ee 100644
--- a/arch/powerpc/sysdev/fsl_soc.h
+++ b/arch/powerpc/sysdev/fsl_soc.h
@@ -3,6 +3,7 @@
 #ifdef __KERNEL__
 
 #include <asm/mmu.h>
+#include <linux/platform_device.h>
 
 struct spi_device;
 
@@ -21,6 +22,14 @@ struct device_node;
 
 extern void fsl_rstcr_restart(char *cmd);
 
+#ifdef CONFIG_FSL_PMC
+int mpc85xx_pmc_set_wake(struct platform_device *pdev, bool enable);
+void mpc85xx_pmc_set_lossless_ethernet(int enable);
+#else
+#define mpc85xx_pmc_set_wake(pdev, enable)
+#define mpc85xx_pmc_set_lossless_ethernet(enable)
+#endif
+
 #if defined(CONFIG_FB_FSL_DIU) || defined(CONFIG_FB_FSL_DIU_MODULE)
 
 /* The different ports that the DIU can be connected to */
-- 
1.6.4.1
