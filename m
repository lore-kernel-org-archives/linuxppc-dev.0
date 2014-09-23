Return-Path: <jingchang.lu@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0126.outbound.protection.outlook.com [65.55.169.126])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3CF431A0121
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Sep 2014 18:13:32 +1000 (EST)
From: Jingchang Lu <jingchang.lu@freescale.com>
To: <mturquette@linaro.org>
Subject: [PATCHv4] clk: ppc-corenet: rename to ppc-qoriq and add
 CLK_OF_DECLARE support
Date: Tue, 23 Sep 2014 14:46:46 +0800
Message-ID: <1411454806-8214-1-git-send-email-jingchang.lu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Jingchang Lu <jingchang.lu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The IP is shared by PPC and ARM, this renames it to qoriq for better
represention, and this also adds the CLK_OF_DECLARE support for being
initialized by of_clk_init() on ARM.

Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
---
changes in v4:
 remove "corenet" literals omitted in v3 remove.

changes in v3:
 generate the patch with -M -C option

changes in v2:
 rename the driver name to ppc-qoriq.c for shared on PPC and ARM.

 drivers/clk/Kconfig                            |  9 +++++----
 drivers/clk/Makefile                           |  2 +-
 drivers/clk/{clk-ppc-corenet.c => clk-qoriq.c} | 27 +++++++++++++++-----------
 3 files changed, 22 insertions(+), 16 deletions(-)
 rename drivers/clk/{clk-ppc-corenet.c => clk-qoriq.c} (89%)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 85131ae..f5f76cb 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -92,12 +92,13 @@ config COMMON_CLK_AXI_CLKGEN
 	  Support for the Analog Devices axi-clkgen pcore clock generator for Xilinx
 	  FPGAs. It is commonly used in Analog Devices' reference designs.
 
-config CLK_PPC_CORENET
-	bool "Clock driver for PowerPC corenet platforms"
-	depends on PPC_E500MC && OF
+config CLK_QORIQ
+	bool "Clock driver for PowerPC corenet and compatible ARM-based platforms"
+	depends on (PPC_E500MC || ARM) && OF
 	---help---
 	  This adds the clock driver support for Freescale PowerPC corenet
-	  platforms using common clock framework.
+	  platforms and compatible Freescale ARM based platforms using common
+	  clock framework.
 
 config COMMON_CLK_XGENE
 	bool "Clock driver for APM XGene SoC"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 27c542b..20f42e9 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -29,7 +29,7 @@ obj-$(CONFIG_ARCH_MOXART)		+= clk-moxart.o
 obj-$(CONFIG_ARCH_NOMADIK)		+= clk-nomadik.o
 obj-$(CONFIG_ARCH_NSPIRE)		+= clk-nspire.o
 obj-$(CONFIG_COMMON_CLK_PALMAS)		+= clk-palmas.o
-obj-$(CONFIG_CLK_PPC_CORENET)		+= clk-ppc-corenet.o
+obj-$(CONFIG_CLK_QORIQ)			+= clk-qoriq.o
 obj-$(CONFIG_COMMON_CLK_S2MPS11)	+= clk-s2mps11.o
 obj-$(CONFIG_COMMON_CLK_SI5351)		+= clk-si5351.o
 obj-$(CONFIG_COMMON_CLK_SI570)		+= clk-si570.o
diff --git a/drivers/clk/clk-ppc-corenet.c b/drivers/clk/clk-qoriq.c
similarity index 89%
rename from drivers/clk/clk-ppc-corenet.c
rename to drivers/clk/clk-qoriq.c
index 8e58edf..cba8abe 100644
--- a/drivers/clk/clk-ppc-corenet.c
+++ b/drivers/clk/clk-qoriq.c
@@ -155,7 +155,7 @@ static void __init core_pll_init(struct device_node *np)
 
 	base = of_iomap(np, 0);
 	if (!base) {
-		pr_err("clk-ppc: iomap error\n");
+		pr_err("clk-qoriq: iomap error\n");
 		return;
 	}
 
@@ -252,7 +252,7 @@ static void __init sysclk_init(struct device_node *node)
 	u32 rate;
 
 	if (!np) {
-		pr_err("ppc-clk: could not get parent node\n");
+		pr_err("qoriq-clk: could not get parent node\n");
 		return;
 	}
 
@@ -278,30 +278,35 @@ static const struct of_device_id clk_match[] __initconst = {
 	{}
 };
 
-static int __init ppc_corenet_clk_probe(struct platform_device *pdev)
+static int __init qoriq_clk_probe(struct platform_device *pdev)
 {
 	of_clk_init(clk_match);
 
 	return 0;
 }
 
-static const struct of_device_id ppc_clk_ids[] __initconst = {
+static const struct of_device_id qoriq_clk_ids[] __initconst = {
 	{ .compatible = "fsl,qoriq-clockgen-1.0", },
 	{ .compatible = "fsl,qoriq-clockgen-2.0", },
 	{}
 };
 
-static struct platform_driver ppc_corenet_clk_driver __initdata = {
+static struct platform_driver qoriq_clk_driver __initdata = {
 	.driver = {
-		.name = "ppc_corenet_clock",
+		.name = "qoriq_clock",
 		.owner = THIS_MODULE,
-		.of_match_table = ppc_clk_ids,
+		.of_match_table = qoriq_clk_ids,
 	},
-	.probe = ppc_corenet_clk_probe,
+	.probe = qoriq_clk_probe,
 };
 
-static int __init ppc_corenet_clk_init(void)
+static int __init qoriq_clk_init(void)
 {
-	return platform_driver_register(&ppc_corenet_clk_driver);
+	return platform_driver_register(&qoriq_clk_driver);
 }
-subsys_initcall(ppc_corenet_clk_init);
+subsys_initcall(qoriq_clk_init);
+
+CLK_OF_DECLARE(qoriq_core_pll_v1, "fsl,qoriq-core-pll-1.0", core_pll_init);
+CLK_OF_DECLARE(qoriq_core_pll_v2, "fsl,qoriq-core-pll-2.0", core_pll_init);
+CLK_OF_DECLARE(qoriq_core_mux_v1, "fsl,qoriq-core-mux-1.0", core_mux_init);
+CLK_OF_DECLARE(qoriq_core_mux_v2, "fsl,qoriq-core-mux-2.0", core_mux_init);
-- 
1.8.0
