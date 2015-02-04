Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0138.outbound.protection.outlook.com [157.56.111.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3E57F1A09D9
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Feb 2015 18:04:30 +1100 (AEDT)
From: Dongsheng Wang <dongsheng.wang@freescale.com>
To: <scottwood@freescale.com>
Subject: [PATCH] powerpc/fsl: add power_off support for fsl platform
Date: Wed, 4 Feb 2015 14:47:01 +0800
Message-ID: <1423032421-31561-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, hongtao.jia@freescale.com,
 Wang Dongsheng <dongsheng.wang@freescale.com>, jason.jin@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wang Dongsheng <dongsheng.wang@freescale.com>

QIXIS System Logic FPGA support to manage system power. So we
through QIXIS to power off freescale SOC.

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>

diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index 1f309cc..e1a1eb5 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -81,6 +81,8 @@ void __init corenet_gen_setup_arch(void)
 	pr_info("%s board\n", ppc_md.name);
 
 	mpc85xx_qe_init();
+
+	ppc_md_fixup();
 }
 
 static const struct of_device_id of_device_ids[] = {
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 99269c0..6de9f1b 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -215,6 +215,54 @@ void fsl_rstcr_restart(char *cmd)
 }
 #endif
 
+#define QIXIS_PWR_CTL2		0x21
+#define QIXIS_PWR_CTL2_PWR	0x80
+static void fsl_power_off(void)
+{
+	struct device_node *pixis_node;
+	void __iomem *pixis;
+	u32 pwroff_offset, value;
+
+	pixis_node = of_find_compatible_node(NULL, NULL, "fsl,fpga-qixis");
+	if (!pixis_node) {
+		pr_err("%s: Missing pixis node\n", __func__);
+		return;
+	}
+
+	pwroff_offset = QIXIS_PWR_CTL2;
+	value = QIXIS_PWR_CTL2_PWR;
+
+	pixis = of_iomap(pixis_node, 0);
+	of_node_put(pixis_node);
+	if (!pixis) {
+		pr_err("%s: Could not map pixis registers\n", __func__);
+		return;
+	}
+
+	local_irq_disable();
+
+	setbits8(pixis + pwroff_offset, value);
+
+	iounmap(pixis);
+
+	while (1)
+		;
+}
+
+void ppc_md_fixup(void)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,fpga-qixis");
+	if (!np)
+		return;
+
+	of_node_put(np);
+
+	pm_power_off = fsl_power_off;
+	ppc_md.halt = fsl_power_off;
+}
+
 #if defined(CONFIG_FB_FSL_DIU) || defined(CONFIG_FB_FSL_DIU_MODULE)
 struct platform_diu_data_ops diu_ops;
 EXPORT_SYMBOL(diu_ops);
diff --git a/arch/powerpc/sysdev/fsl_soc.h b/arch/powerpc/sysdev/fsl_soc.h
index 4c5a19e..ca90e24 100644
--- a/arch/powerpc/sysdev/fsl_soc.h
+++ b/arch/powerpc/sysdev/fsl_soc.h
@@ -21,6 +21,8 @@ struct device_node;
 
 extern void fsl_rstcr_restart(char *cmd);
 
+void ppc_md_fixup(void);
+
 /* The different ports that the DIU can be connected to */
 enum fsl_diu_monitor_port {
 	FSL_DIU_PORT_DVI,	/* DVI */
-- 
2.1.0.27.g96db324
