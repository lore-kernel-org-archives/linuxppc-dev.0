Return-Path: <haokexin@gmail.com>
Received: from mail-pd0-x231.google.com (mail-pd0-x231.google.com
 [IPv6:2607:f8b0:400e:c02::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A995E1A060E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 22:20:11 +1100 (AEDT)
Received: by mail-pd0-f177.google.com with SMTP id v10so3036517pde.8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 04:20:09 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] clk: ppc-corenet: don't use platform_driver to init the
 clock device
Date: Thu, 16 Oct 2014 19:18:41 +0800
Message-Id: <1413458321-23880-3-git-send-email-haokexin@gmail.com>
In-Reply-To: <1413458321-23880-1-git-send-email-haokexin@gmail.com>
References: <1413458321-23880-1-git-send-email-haokexin@gmail.com>
Cc: Scott Wood <scottwood@freescale.com>,
 Mike Turquette <mturquette@linaro.org>,
 Jingchang Lu <jingchang.lu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit da788acb2838 ("clk: ppc-corenet: Fix Section mismatch
warning"), we put the ppc_corenet_clk_driver struct to init section
in order to fix section mismatch warning. This is definitely wrong
because the kernel would free the memories occupied by
ppc_corenet_clk_driver after boot while this driver is still registered
in the driver core. The kernel would panic when accessing this driver
struct. So choose to use CLK_OF_DECLARE to scan and init the clock devices.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/platforms/85xx/corenet_generic.c |  7 +++++
 drivers/clk/clk-ppc-corenet.c                 | 43 ++++-----------------------
 2 files changed, 13 insertions(+), 37 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index e56b89a792ed..7677cfecb787 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -16,6 +16,7 @@
 #include <linux/kdev_t.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/clk-provider.h>
 
 #include <asm/time.h>
 #include <asm/machdep.h>
@@ -188,11 +189,17 @@ static int __init corenet_generic_probe(void)
 	return 0;
 }
 
+static void __init corenet_gen_init(void)
+{
+	of_clk_init(NULL);
+}
+
 define_machine(corenet_generic) {
 	.name			= "CoreNet Generic",
 	.probe			= corenet_generic_probe,
 	.setup_arch		= corenet_gen_setup_arch,
 	.init_IRQ		= corenet_gen_pic_init,
+	.init			= corenet_gen_init,
 #ifdef CONFIG_PCI
 	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
diff --git a/drivers/clk/clk-ppc-corenet.c b/drivers/clk/clk-ppc-corenet.c
index 8e58edfeeb37..bf0fe565ce4e 100644
--- a/drivers/clk/clk-ppc-corenet.c
+++ b/drivers/clk/clk-ppc-corenet.c
@@ -268,40 +268,9 @@ static void __init sysclk_init(struct device_node *node)
 		of_clk_add_provider(np, of_clk_src_simple_get, clk);
 }
 
-static const struct of_device_id clk_match[] __initconst = {
-	{ .compatible = "fsl,qoriq-sysclk-1.0", .data = sysclk_init, },
-	{ .compatible = "fsl,qoriq-sysclk-2.0", .data = sysclk_init, },
-	{ .compatible = "fsl,qoriq-core-pll-1.0", .data = core_pll_init, },
-	{ .compatible = "fsl,qoriq-core-pll-2.0", .data = core_pll_init, },
-	{ .compatible = "fsl,qoriq-core-mux-1.0", .data = core_mux_init, },
-	{ .compatible = "fsl,qoriq-core-mux-2.0", .data = core_mux_init, },
-	{}
-};
-
-static int __init ppc_corenet_clk_probe(struct platform_device *pdev)
-{
-	of_clk_init(clk_match);
-
-	return 0;
-}
-
-static const struct of_device_id ppc_clk_ids[] __initconst = {
-	{ .compatible = "fsl,qoriq-clockgen-1.0", },
-	{ .compatible = "fsl,qoriq-clockgen-2.0", },
-	{}
-};
-
-static struct platform_driver ppc_corenet_clk_driver __initdata = {
-	.driver = {
-		.name = "ppc_corenet_clock",
-		.owner = THIS_MODULE,
-		.of_match_table = ppc_clk_ids,
-	},
-	.probe = ppc_corenet_clk_probe,
-};
-
-static int __init ppc_corenet_clk_init(void)
-{
-	return platform_driver_register(&ppc_corenet_clk_driver);
-}
-subsys_initcall(ppc_corenet_clk_init);
+CLK_OF_DECLARE(qoriq_sysclk_1, "fsl,qoriq-sysclk-1.0", sysclk_init);
+CLK_OF_DECLARE(qoriq_sysclk_2, "fsl,qoriq-sysclk-2.0", sysclk_init);
+CLK_OF_DECLARE(qoriq_core_pll_1, "fsl,qoriq-core-pll-1.0", core_pll_init);
+CLK_OF_DECLARE(qoriq_core_pll_2, "fsl,qoriq-core-pll-2.0", core_pll_init);
+CLK_OF_DECLARE(qoriq_core_mux_1, "fsl,qoriq-core-mux-1.0", core_mux_init);
+CLK_OF_DECLARE(qoriq_core_mux_2, "fsl,qoriq-core-mux-2.0", core_mux_init);
-- 
1.9.3
