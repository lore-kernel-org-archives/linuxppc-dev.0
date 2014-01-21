Return-Path: <Yuantian.Tang@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 15DF72C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2014 13:31:12 +1100 (EST)
From: Tang Yuantian <Yuantian.Tang@freescale.com>
To: <mturquette@linaro.org>
Subject: [PATCH] clk: mpc85xx: Update the driver to align to new clock bindings
Date: Tue, 21 Jan 2014 09:32:45 +0800
Message-ID: <1390267965-22408-1-git-send-email-Yuantian.Tang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Tang Yuantian <Yuantian.Tang@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tang Yuantian <yuantian.tang@freescale.com>

The clock bindings for Freescale CoreNet platform are updated.
So, the driver needs to be updated accordingly.
The main changes include:
	- Added a new node to present the input system clock
	- Changed PLL and MUX's compatible string

Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
---
 drivers/clk/clk-ppc-corenet.c | 70 +++++++++++++++++++++++++++++--------------
 1 file changed, 48 insertions(+), 22 deletions(-)

diff --git a/drivers/clk/clk-ppc-corenet.c b/drivers/clk/clk-ppc-corenet.c
index c4f76ed..8b284be 100644
--- a/drivers/clk/clk-ppc-corenet.c
+++ b/drivers/clk/clk-ppc-corenet.c
@@ -27,7 +27,6 @@ struct cmux_clk {
 #define CLKSEL_ADJUST		BIT(0)
 #define to_cmux_clk(p)		container_of(p, struct cmux_clk, hw)
 
-static void __iomem *base;
 static unsigned int clocks_per_pll;
 
 static int cmux_set_parent(struct clk_hw *hw, u8 idx)
@@ -100,7 +99,11 @@ static void __init core_mux_init(struct device_node *np)
 		pr_err("%s: could not allocate cmux_clk\n", __func__);
 		goto err_name;
 	}
-	cmux_clk->reg = base + offset;
+	cmux_clk->reg = of_iomap(np, 0);
+	if (!cmux_clk->reg) {
+		pr_err("%s: could not map register\n", __func__);
+		goto err_clk;
+	}
 
 	node = of_find_compatible_node(NULL, NULL, "fsl,p4080-clockgen");
 	if (node && (offset >= 0x80))
@@ -143,38 +146,39 @@ err_name:
 
 static void __init core_pll_init(struct device_node *np)
 {
-	u32 offset, mult;
+	u32 mult;
 	int i, rc, count;
 	const char *clk_name, *parent_name;
 	struct clk_onecell_data *onecell_data;
 	struct clk      **subclks;
+	void __iomem *base;
 
-	rc = of_property_read_u32(np, "reg", &offset);
-	if (rc) {
-		pr_err("%s: could not get reg property\n", np->name);
+	base = of_iomap(np, 0);
+	if (!base) {
+		pr_err("clk-ppc: iomap error\n");
 		return;
 	}
 
 	/* get the multiple of PLL */
-	mult = ioread32be(base + offset);
+	mult = ioread32be(base);
 
 	/* check if this PLL is disabled */
 	if (mult & PLL_KILL) {
 		pr_debug("PLL:%s is disabled\n", np->name);
-		return;
+		goto err_map;
 	}
 	mult = (mult >> 1) & 0x3f;
 
 	parent_name = of_clk_get_parent_name(np, 0);
 	if (!parent_name) {
 		pr_err("PLL: %s must have a parent\n", np->name);
-		return;
+		goto err_map;
 	}
 
 	count = of_property_count_strings(np, "clock-output-names");
 	if (count < 0 || count > 4) {
 		pr_err("%s: clock is not supported\n", np->name);
-		return;
+		goto err_map;
 	}
 
 	/* output clock number per PLL */
@@ -183,7 +187,7 @@ static void __init core_pll_init(struct device_node *np)
 	subclks = kzalloc(sizeof(struct clk *) * count, GFP_KERNEL);
 	if (!subclks) {
 		pr_err("%s: could not allocate subclks\n", __func__);
-		return;
+		goto err_map;
 	}
 
 	onecell_data = kzalloc(sizeof(struct clk_onecell_data), GFP_KERNEL);
@@ -230,30 +234,52 @@ static void __init core_pll_init(struct device_node *np)
 		goto err_cell;
 	}
 
+	iounmap(base);
 	return;
 err_cell:
 	kfree(onecell_data);
 err_clks:
 	kfree(subclks);
+err_map:
+	iounmap(base);
+}
+
+static void __init sysclk_init(struct device_node *node)
+{
+	struct clk *clk;
+	const char *clk_name = node->name;
+	struct device_node *np = of_get_parent(node);
+	u32 rate;
+
+	if (!np) {
+		pr_err("ppc-clk: could not get parent node\n");
+		return;
+	}
+
+	if (of_property_read_u32(np, "clock-frequency", &rate)) {
+		of_node_put(node);
+		return;
+	}
+
+	of_property_read_string(np, "clock-output-names", &clk_name);
+
+	clk = clk_register_fixed_rate(NULL, clk_name, NULL, CLK_IS_ROOT, rate);
+	if (!IS_ERR(clk))
+		of_clk_add_provider(np, of_clk_src_simple_get, clk);
 }
 
 static const struct of_device_id clk_match[] __initconst = {
-	{ .compatible = "fixed-clock", .data = of_fixed_clk_setup, },
-	{ .compatible = "fsl,core-pll-clock", .data = core_pll_init, },
-	{ .compatible = "fsl,core-mux-clock", .data = core_mux_init, },
+	{ .compatible = "fsl,qoriq-sysclk-1.0", .data = sysclk_init, },
+	{ .compatible = "fsl,qoriq-sysclk-2.0", .data = sysclk_init, },
+	{ .compatible = "fsl,qoriq-core-pll-1.0", .data = core_pll_init, },
+	{ .compatible = "fsl,qoriq-core-pll-2.0", .data = core_pll_init, },
+	{ .compatible = "fsl,qoriq-core-mux-1.0", .data = core_mux_init, },
+	{ .compatible = "fsl,qoriq-core-mux-2.0", .data = core_mux_init, },
 	{}
 };
 
 static int __init ppc_corenet_clk_probe(struct platform_device *pdev)
 {
-	struct device_node *np;
-
-	np = pdev->dev.of_node;
-	base = of_iomap(np, 0);
-	if (!base) {
-		dev_err(&pdev->dev, "iomap error\n");
-		return -ENOMEM;
-	}
 	of_clk_init(clk_match);
 
 	return 0;
-- 
1.8.0
