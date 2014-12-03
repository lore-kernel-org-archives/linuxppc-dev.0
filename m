Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-x233.google.com (mail-pa0-x233.google.com
 [IPv6:2607:f8b0:400e:c03::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 95D3C1A0C55
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Dec 2014 19:56:15 +1100 (AEDT)
Received: by mail-pa0-f51.google.com with SMTP id ey11so15478936pad.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Dec 2014 00:56:13 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 3/3] clk: ppc-corenet: fix section mismatch warning
Date: Wed,  3 Dec 2014 16:53:53 +0800
Message-Id: <1417596833-31456-4-git-send-email-haokexin@gmail.com>
In-Reply-To: <1417596833-31456-1-git-send-email-haokexin@gmail.com>
References: <1417596833-31456-1-git-send-email-haokexin@gmail.com>
Cc: Mike Turquette <mturquette@linaro.org>, Gerhard Sittig <gsi@denx.de>,
 Yuantian Tang <Yuantian.Tang@freescale.com>,
 Jingchang Lu <jingchang.lu@freescale.com>,
 Scott Wood <scottwood@freescale.com>
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
Acked-by: Scott Wood <scottwood@freescale.com>
Acked-by: Michael Turquette <mturquette@linaro.org>
---
v3: Rebase on next and add ack.

v2: Avoid to invoke of_clk_init() in a board specific file.

 drivers/clk/clk-ppc-corenet.c | 43 ++++++-------------------------------------
 1 file changed, 6 insertions(+), 37 deletions(-)

diff --git a/drivers/clk/clk-ppc-corenet.c b/drivers/clk/clk-ppc-corenet.c
index 0a47d6f49cd6..57a2de47d2cb 100644
--- a/drivers/clk/clk-ppc-corenet.c
+++ b/drivers/clk/clk-ppc-corenet.c
@@ -267,40 +267,9 @@ static void __init sysclk_init(struct device_node *node)
 	if (!IS_ERR(clk))
 		of_clk_add_provider(np, of_clk_src_simple_get, clk);
 }
-
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
