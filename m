Return-Path: <haokexin@gmail.com>
Received: from mail-pd0-x230.google.com (mail-pd0-x230.google.com
 [IPv6:2607:f8b0:400e:c02::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 722211A1966
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Oct 2014 17:12:54 +1100 (AEDT)
Received: by mail-pd0-f176.google.com with SMTP id fp1so3050453pdb.21
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Oct 2014 23:12:52 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 3/3] clk: ppc-corenet: fix section mismatch warning
Date: Sun, 19 Oct 2014 14:11:39 +0800
Message-Id: <1413699099-25743-4-git-send-email-haokexin@gmail.com>
In-Reply-To: <1413699099-25743-1-git-send-email-haokexin@gmail.com>
References: <1413699099-25743-1-git-send-email-haokexin@gmail.com>
Cc: Scott Wood <scottwood@freescale.com>, Gerhard Sittig <gsi@denx.de>,
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

In order to fix the following section mismatch warning:
  WARNING: drivers/clk/built-in.o(.data+0xe4): Section mismatch in reference from the variable ppc_corenet_clk_driver to the function .init.text:ppc_corenet_clk_probe()
  The variable ppc_corenet_clk_driver references
  the function __init ppc_corenet_clk_probe()
  If the reference is valid then annotate the
  variable with __init* or __refdata (see linux/init.h) or name the variable:
  *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

  WARNING: drivers/clk/built-in.o(.data+0x10c): Section mismatch in reference from the variable ppc_corenet_clk_driver to the variable .init.rodata:ppc_clk_ids
  The variable ppc_corenet_clk_driver references
  the variable __initconst ppc_clk_ids
  If the reference is valid then annotate the
  variable with __init* or __refdata (see linux/init.h) or name the variable:
  *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

We can't just add the __init annotation to ppc_corenet_clk_driver or
remove the __init from ppc_corenet_clk_probe() and ppc_clk_ids.
So choose to use CLK_OF_DECLARE to scan and init the clock devices.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
v2: Avoid to invoke of_clk_init() in a board specific file.

 drivers/clk/clk-ppc-corenet.c | 43 ++++++-------------------------------------
 1 file changed, 6 insertions(+), 37 deletions(-)

diff --git a/drivers/clk/clk-ppc-corenet.c b/drivers/clk/clk-ppc-corenet.c
index 8b284be4efa4..bf0fe565ce4e 100644
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
-static struct platform_driver ppc_corenet_clk_driver = {
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
