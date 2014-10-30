Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0117.outbound.protection.outlook.com [157.56.110.117])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BB6071A0054
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Oct 2014 10:12:26 +1100 (AEDT)
Message-ID: <1414710720.23458.169.camel@snotra.buserror.net>
Subject: Re: [PATCHv5] clk: ppc-corenet: rename to qoriq and add
 CLK_OF_DECLARE support
From: Scott Wood <scottwood@freescale.com>
To: Lu Jingchang-B35083 <jingchang.lu@freescale.com>
Date: Thu, 30 Oct 2014 18:12:00 -0500
In-Reply-To: <ccb7de6dc94e4493bbf8685c4d8b3421@BL2PR03MB467.namprd03.prod.outlook.com>
References: <1412932497-27995-1-git-send-email-jingchang.lu@freescale.com>
 <ccb7de6dc94e4493bbf8685c4d8b3421@BL2PR03MB467.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "mturquette@linaro.org" <mturquette@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The CLK_OF_DECLARE part is addressed by:
http://patchwork.ozlabs.org/patch/400740/
http://patchwork.ozlabs.org/patch/400741/
http://patchwork.ozlabs.org/patch/400742/

...which does what I was asking earlier, getting rid of the (currently
broken due to a misguided attempt to remove an __init warning) platform
driver part rather than maintaining both approaches.

I suggest sending a rename patch that applies after those patches.

-Scott

On Tue, 2014-10-14 at 05:32 -0500, Lu Jingchang-B35083 wrote:
> Hi, Scott and Mike,
>   
>   Could you please help review this patch. Thanks.
> 
> Best Regards,
> Jingchang
> 
> >-----Original Message-----
> >From: Jingchang Lu [mailto:jingchang.lu@freescale.com]
> >Sent: Friday, October 10, 2014 5:15 PM
> >To: mturquette@linaro.org
> >Cc: Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org; linux-
> >kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Lu
> >Jingchang-B35083
> >Subject: [PATCHv5] clk: ppc-corenet: rename to qoriq and add
> >CLK_OF_DECLARE support
> >
> >The IP is shared by PPC and ARM, this renames it to qoriq for better
> >represention, and this also adds the CLK_OF_DECLARE support for being
> >initialized by of_clk_init() on ARM.
> >
> >Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
> >---
> >changes in v5:
> > update drivers/cpufreq/Kconfig.powerpc to slect the renamed config option.
> >
> >changes in v4:
> > remove "corenet" literals omitted in v3 remove.
> >
> >changes in v3:
> > generate the patch with -M -C option
> >
> >changes in v2:
> > rename the driver name to ppc-qoriq.c for shared on PPC and ARM.
> >
> > drivers/clk/Kconfig                            | 10 ++++-----
> > drivers/clk/Makefile                           |  2 +-
> > drivers/clk/{clk-ppc-corenet.c => clk-qoriq.c} | 29 +++++++++++++++------
> >-----
> > drivers/cpufreq/Kconfig.powerpc                |  2 +-
> > 4 files changed, 24 insertions(+), 19 deletions(-)  rename
> >drivers/clk/{clk-ppc-corenet.c => clk-qoriq.c} (89%)
> >
> >diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig index
> >455fd17..4706a9f 100644
> >--- a/drivers/clk/Kconfig
> >+++ b/drivers/clk/Kconfig
> >@@ -101,12 +101,12 @@ config COMMON_CLK_AXI_CLKGEN
> > 	  Support for the Analog Devices axi-clkgen pcore clock generator
> >for Xilinx
> > 	  FPGAs. It is commonly used in Analog Devices' reference designs.
> >
> >-config CLK_PPC_CORENET
> >-	bool "Clock driver for PowerPC corenet platforms"
> >-	depends on PPC_E500MC && OF
> >+config CLK_QORIQ
> >+	bool "Clock driver for Freescale QorIQ platforms"
> >+	depends on (PPC_E500MC || ARM) && OF
> > 	---help---
> >-	  This adds the clock driver support for Freescale PowerPC corenet
> >-	  platforms using common clock framework.
> >+	  This adds the clock driver support for Freescale QorIQ platforms
> >+	  using common clock framework.
> >
> > config COMMON_CLK_XGENE
> > 	bool "Clock driver for APM XGene SoC"
> >diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile index
> >d5fba5b..4ff94cd 100644
> >--- a/drivers/clk/Makefile
> >+++ b/drivers/clk/Makefile
> >@@ -30,7 +30,7 @@ obj-$(CONFIG_ARCH_MOXART)		+= clk-moxart.o
> > obj-$(CONFIG_ARCH_NOMADIK)		+= clk-nomadik.o
> > obj-$(CONFIG_ARCH_NSPIRE)		+= clk-nspire.o
> > obj-$(CONFIG_COMMON_CLK_PALMAS)		+= clk-palmas.o
> >-obj-$(CONFIG_CLK_PPC_CORENET)		+= clk-ppc-corenet.o
> >+obj-$(CONFIG_CLK_QORIQ)			+= clk-qoriq.o
> > obj-$(CONFIG_COMMON_CLK_RK808)		+= clk-rk808.o
> > obj-$(CONFIG_COMMON_CLK_S2MPS11)	+= clk-s2mps11.o
> > obj-$(CONFIG_COMMON_CLK_SI5351)		+= clk-si5351.o
> >diff --git a/drivers/clk/clk-ppc-corenet.c b/drivers/clk/clk-qoriq.c
> >similarity index 89% rename from drivers/clk/clk-ppc-corenet.c rename to
> >drivers/clk/clk-qoriq.c index 8e58edf..48cb923 100644
> >--- a/drivers/clk/clk-ppc-corenet.c
> >+++ b/drivers/clk/clk-qoriq.c
> >@@ -5,7 +5,7 @@
> >  * it under the terms of the GNU General Public License version 2 as
> >  * published by the Free Software Foundation.
> >  *
> >- * clock driver for Freescale PowerPC corenet SoCs.
> >+ * clock driver for Freescale QorIQ SoCs.
> >  */
> > #include <linux/clk-provider.h>
> > #include <linux/io.h>
> >@@ -155,7 +155,7 @@ static void __init core_pll_init(struct device_node
> >*np)
> >
> > 	base = of_iomap(np, 0);
> > 	if (!base) {
> >-		pr_err("clk-ppc: iomap error\n");
> >+		pr_err("clk-qoriq: iomap error\n");
> > 		return;
> > 	}
> >
> >@@ -252,7 +252,7 @@ static void __init sysclk_init(struct device_node
> >*node)
> > 	u32 rate;
> >
> > 	if (!np) {
> >-		pr_err("ppc-clk: could not get parent node\n");
> >+		pr_err("qoriq-clk: could not get parent node\n");
> > 		return;
> > 	}
> >
> >@@ -278,30 +278,35 @@ static const struct of_device_id clk_match[]
> >__initconst = {
> > 	{}
> > };
> >
> >-static int __init ppc_corenet_clk_probe(struct platform_device *pdev)
> >+static int __init qoriq_clk_probe(struct platform_device *pdev)
> > {
> > 	of_clk_init(clk_match);
> >
> > 	return 0;
> > }
> >
> >-static const struct of_device_id ppc_clk_ids[] __initconst = {
> >+static const struct of_device_id qoriq_clk_ids[] __initconst = {
> > 	{ .compatible = "fsl,qoriq-clockgen-1.0", },
> > 	{ .compatible = "fsl,qoriq-clockgen-2.0", },
> > 	{}
> > };
> >
> >-static struct platform_driver ppc_corenet_clk_driver __initdata = {
> >+static struct platform_driver qoriq_clk_driver __initdata = {
> > 	.driver = {
> >-		.name = "ppc_corenet_clock",
> >+		.name = "qoriq_clock",
> > 		.owner = THIS_MODULE,
> >-		.of_match_table = ppc_clk_ids,
> >+		.of_match_table = qoriq_clk_ids,
> > 	},
> >-	.probe = ppc_corenet_clk_probe,
> >+	.probe = qoriq_clk_probe,
> > };
> >
> >-static int __init ppc_corenet_clk_init(void)
> >+static int __init qoriq_clk_init(void)
> > {
> >-	return platform_driver_register(&ppc_corenet_clk_driver);
> >+	return platform_driver_register(&qoriq_clk_driver);
> > }
> >-subsys_initcall(ppc_corenet_clk_init);
> >+subsys_initcall(qoriq_clk_init);
> >+
> >+CLK_OF_DECLARE(qoriq_core_pll_v1, "fsl,qoriq-core-pll-1.0",
> >+core_pll_init); CLK_OF_DECLARE(qoriq_core_pll_v2,
> >+"fsl,qoriq-core-pll-2.0", core_pll_init);
> >+CLK_OF_DECLARE(qoriq_core_mux_v1, "fsl,qoriq-core-mux-1.0",
> >+core_mux_init); CLK_OF_DECLARE(qoriq_core_mux_v2,
> >+"fsl,qoriq-core-mux-2.0", core_mux_init);
> >diff --git a/drivers/cpufreq/Kconfig.powerpc
> >b/drivers/cpufreq/Kconfig.powerpc index 72564b7..7ea2441 100644
> >--- a/drivers/cpufreq/Kconfig.powerpc
> >+++ b/drivers/cpufreq/Kconfig.powerpc
> >@@ -26,7 +26,7 @@ config CPU_FREQ_MAPLE
> > config PPC_CORENET_CPUFREQ
> > 	tristate "CPU frequency scaling driver for Freescale E500MC SoCs"
> > 	depends on PPC_E500MC && OF && COMMON_CLK
> >-	select CLK_PPC_CORENET
> >+	select CLK_QORIQ
> > 	help
> > 	  This adds the CPUFreq driver support for Freescale e500mc,
> > 	  e5500 and e6500 series SoCs which are capable of changing
> >--
> >1.8.0
> 
