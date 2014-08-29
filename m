Return-Path: <jingchang.lu@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0145.outbound.protection.outlook.com [207.46.163.145])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E14CF1A2508
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Aug 2014 19:26:51 +1000 (EST)
From: Jingchang Lu <jingchang.lu@freescale.com>
To: <mturquette@linaro.org>
Subject: [PATCHv2] clk: ppc-corenet: rename to ppc-qoriq and add
 CLK_OF_DECLARE support
Date: Fri, 29 Aug 2014 16:35:54 +0800
Message-ID: <1409301354-13699-1-git-send-email-jingchang.lu@freescale.com>
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

The IP is shared on PPC and ARM, this rename it to qoriq for better
represention, and this also add the CLK_OF_DECLARE support for being
initialized by of_clk_init() on ARM.

Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
---
changes in v2:
 rename the driver name to ppc-qoriq.c for shared on PPC and ARM.

 drivers/clk/Kconfig           |   9 +-
 drivers/clk/Makefile          |   2 +-
 drivers/clk/clk-ppc-corenet.c | 307 -----------------------------------------
 drivers/clk/clk-qoriq.c       | 312 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 318 insertions(+), 312 deletions(-)
 delete mode 100644 drivers/clk/clk-ppc-corenet.c
 create mode 100644 drivers/clk/clk-qoriq.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index cfd3af7..d7892b9 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -81,12 +81,13 @@ config COMMON_CLK_AXI_CLKGEN
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
index 312742c..c8f1f52 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -23,7 +23,7 @@ obj-$(CONFIG_ARCH_MOXART)		+= clk-moxart.o
 obj-$(CONFIG_ARCH_NOMADIK)		+= clk-nomadik.o
 obj-$(CONFIG_ARCH_NSPIRE)		+= clk-nspire.o
 obj-$(CONFIG_COMMON_CLK_PALMAS)		+= clk-palmas.o
-obj-$(CONFIG_CLK_PPC_CORENET)		+= clk-ppc-corenet.o
+obj-$(CONFIG_CLK_QORIQ)			+= clk-qoriq.o
 obj-$(CONFIG_COMMON_CLK_S2MPS11)	+= clk-s2mps11.o
 obj-$(CONFIG_COMMON_CLK_SI5351)		+= clk-si5351.o
 obj-$(CONFIG_COMMON_CLK_SI570)		+= clk-si570.o
diff --git a/drivers/clk/clk-ppc-corenet.c b/drivers/clk/clk-ppc-corenet.c
deleted file mode 100644
index 8e58edf..0000000
--- a/drivers/clk/clk-ppc-corenet.c
+++ /dev/null
@@ -1,307 +0,0 @@
-/*
- * Copyright 2013 Freescale Semiconductor, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * clock driver for Freescale PowerPC corenet SoCs.
- */
-#include <linux/clk-provider.h>
-#include <linux/io.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/of_address.h>
-#include <linux/of_platform.h>
-#include <linux/of.h>
-#include <linux/slab.h>
-
-struct cmux_clk {
-	struct clk_hw hw;
-	void __iomem *reg;
-	u32 flags;
-};
-
-#define PLL_KILL			BIT(31)
-#define	CLKSEL_SHIFT		27
-#define CLKSEL_ADJUST		BIT(0)
-#define to_cmux_clk(p)		container_of(p, struct cmux_clk, hw)
-
-static unsigned int clocks_per_pll;
-
-static int cmux_set_parent(struct clk_hw *hw, u8 idx)
-{
-	struct cmux_clk *clk = to_cmux_clk(hw);
-	u32 clksel;
-
-	clksel = ((idx / clocks_per_pll) << 2) + idx % clocks_per_pll;
-	if (clk->flags & CLKSEL_ADJUST)
-		clksel += 8;
-	clksel = (clksel & 0xf) << CLKSEL_SHIFT;
-	iowrite32be(clksel, clk->reg);
-
-	return 0;
-}
-
-static u8 cmux_get_parent(struct clk_hw *hw)
-{
-	struct cmux_clk *clk = to_cmux_clk(hw);
-	u32 clksel;
-
-	clksel = ioread32be(clk->reg);
-	clksel = (clksel >> CLKSEL_SHIFT) & 0xf;
-	if (clk->flags & CLKSEL_ADJUST)
-		clksel -= 8;
-	clksel = (clksel >> 2) * clocks_per_pll + clksel % 4;
-
-	return clksel;
-}
-
-const struct clk_ops cmux_ops = {
-	.get_parent = cmux_get_parent,
-	.set_parent = cmux_set_parent,
-};
-
-static void __init core_mux_init(struct device_node *np)
-{
-	struct clk *clk;
-	struct clk_init_data init;
-	struct cmux_clk *cmux_clk;
-	struct device_node *node;
-	int rc, count, i;
-	u32	offset;
-	const char *clk_name;
-	const char **parent_names;
-
-	rc = of_property_read_u32(np, "reg", &offset);
-	if (rc) {
-		pr_err("%s: could not get reg property\n", np->name);
-		return;
-	}
-
-	/* get the input clock source count */
-	count = of_property_count_strings(np, "clock-names");
-	if (count < 0) {
-		pr_err("%s: get clock count error\n", np->name);
-		return;
-	}
-	parent_names = kzalloc((sizeof(char *) * count), GFP_KERNEL);
-	if (!parent_names) {
-		pr_err("%s: could not allocate parent_names\n", __func__);
-		return;
-	}
-
-	for (i = 0; i < count; i++)
-		parent_names[i] = of_clk_get_parent_name(np, i);
-
-	cmux_clk = kzalloc(sizeof(struct cmux_clk), GFP_KERNEL);
-	if (!cmux_clk) {
-		pr_err("%s: could not allocate cmux_clk\n", __func__);
-		goto err_name;
-	}
-	cmux_clk->reg = of_iomap(np, 0);
-	if (!cmux_clk->reg) {
-		pr_err("%s: could not map register\n", __func__);
-		goto err_clk;
-	}
-
-	node = of_find_compatible_node(NULL, NULL, "fsl,p4080-clockgen");
-	if (node && (offset >= 0x80))
-		cmux_clk->flags = CLKSEL_ADJUST;
-
-	rc = of_property_read_string_index(np, "clock-output-names",
-			0, &clk_name);
-	if (rc) {
-		pr_err("%s: read clock names error\n", np->name);
-		goto err_clk;
-	}
-
-	init.name = clk_name;
-	init.ops = &cmux_ops;
-	init.parent_names = parent_names;
-	init.num_parents = count;
-	init.flags = 0;
-	cmux_clk->hw.init = &init;
-
-	clk = clk_register(NULL, &cmux_clk->hw);
-	if (IS_ERR(clk)) {
-		pr_err("%s: could not register clock\n", clk_name);
-		goto err_clk;
-	}
-
-	rc = of_clk_add_provider(np, of_clk_src_simple_get, clk);
-	if (rc) {
-		pr_err("Could not register clock provider for node:%s\n",
-			 np->name);
-		goto err_clk;
-	}
-	goto err_name;
-
-err_clk:
-	kfree(cmux_clk);
-err_name:
-	/* free *_names because they are reallocated when registered */
-	kfree(parent_names);
-}
-
-static void __init core_pll_init(struct device_node *np)
-{
-	u32 mult;
-	int i, rc, count;
-	const char *clk_name, *parent_name;
-	struct clk_onecell_data *onecell_data;
-	struct clk      **subclks;
-	void __iomem *base;
-
-	base = of_iomap(np, 0);
-	if (!base) {
-		pr_err("clk-ppc: iomap error\n");
-		return;
-	}
-
-	/* get the multiple of PLL */
-	mult = ioread32be(base);
-
-	/* check if this PLL is disabled */
-	if (mult & PLL_KILL) {
-		pr_debug("PLL:%s is disabled\n", np->name);
-		goto err_map;
-	}
-	mult = (mult >> 1) & 0x3f;
-
-	parent_name = of_clk_get_parent_name(np, 0);
-	if (!parent_name) {
-		pr_err("PLL: %s must have a parent\n", np->name);
-		goto err_map;
-	}
-
-	count = of_property_count_strings(np, "clock-output-names");
-	if (count < 0 || count > 4) {
-		pr_err("%s: clock is not supported\n", np->name);
-		goto err_map;
-	}
-
-	/* output clock number per PLL */
-	clocks_per_pll = count;
-
-	subclks = kzalloc(sizeof(struct clk *) * count, GFP_KERNEL);
-	if (!subclks) {
-		pr_err("%s: could not allocate subclks\n", __func__);
-		goto err_map;
-	}
-
-	onecell_data = kzalloc(sizeof(struct clk_onecell_data), GFP_KERNEL);
-	if (!onecell_data) {
-		pr_err("%s: could not allocate onecell_data\n", __func__);
-		goto err_clks;
-	}
-
-	for (i = 0; i < count; i++) {
-		rc = of_property_read_string_index(np, "clock-output-names",
-				i, &clk_name);
-		if (rc) {
-			pr_err("%s: could not get clock names\n", np->name);
-			goto err_cell;
-		}
-
-		/*
-		 * when count == 4, there are 4 output clocks:
-		 * /1, /2, /3, /4 respectively
-		 * when count < 4, there are at least 2 output clocks:
-		 * /1, /2, (/4, if count == 3) respectively.
-		 */
-		if (count == 4)
-			subclks[i] = clk_register_fixed_factor(NULL, clk_name,
-					parent_name, 0, mult, 1 + i);
-		else
-
-			subclks[i] = clk_register_fixed_factor(NULL, clk_name,
-					parent_name, 0, mult, 1 << i);
-
-		if (IS_ERR(subclks[i])) {
-			pr_err("%s: could not register clock\n", clk_name);
-			goto err_cell;
-		}
-	}
-
-	onecell_data->clks = subclks;
-	onecell_data->clk_num = count;
-
-	rc = of_clk_add_provider(np, of_clk_src_onecell_get, onecell_data);
-	if (rc) {
-		pr_err("Could not register clk provider for node:%s\n",
-			 np->name);
-		goto err_cell;
-	}
-
-	iounmap(base);
-	return;
-err_cell:
-	kfree(onecell_data);
-err_clks:
-	kfree(subclks);
-err_map:
-	iounmap(base);
-}
-
-static void __init sysclk_init(struct device_node *node)
-{
-	struct clk *clk;
-	const char *clk_name = node->name;
-	struct device_node *np = of_get_parent(node);
-	u32 rate;
-
-	if (!np) {
-		pr_err("ppc-clk: could not get parent node\n");
-		return;
-	}
-
-	if (of_property_read_u32(np, "clock-frequency", &rate)) {
-		of_node_put(node);
-		return;
-	}
-
-	of_property_read_string(np, "clock-output-names", &clk_name);
-
-	clk = clk_register_fixed_rate(NULL, clk_name, NULL, CLK_IS_ROOT, rate);
-	if (!IS_ERR(clk))
-		of_clk_add_provider(np, of_clk_src_simple_get, clk);
-}
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
diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
new file mode 100644
index 0000000..7692cac
--- /dev/null
+++ b/drivers/clk/clk-qoriq.c
@@ -0,0 +1,312 @@
+/*
+ * Copyright 2013 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * clock driver for Freescale PowerPC corenet SoCs.
+ */
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+
+struct cmux_clk {
+	struct clk_hw hw;
+	void __iomem *reg;
+	u32 flags;
+};
+
+#define PLL_KILL			BIT(31)
+#define	CLKSEL_SHIFT		27
+#define CLKSEL_ADJUST		BIT(0)
+#define to_cmux_clk(p)		container_of(p, struct cmux_clk, hw)
+
+static unsigned int clocks_per_pll;
+
+static int cmux_set_parent(struct clk_hw *hw, u8 idx)
+{
+	struct cmux_clk *clk = to_cmux_clk(hw);
+	u32 clksel;
+
+	clksel = ((idx / clocks_per_pll) << 2) + idx % clocks_per_pll;
+	if (clk->flags & CLKSEL_ADJUST)
+		clksel += 8;
+	clksel = (clksel & 0xf) << CLKSEL_SHIFT;
+	iowrite32be(clksel, clk->reg);
+
+	return 0;
+}
+
+static u8 cmux_get_parent(struct clk_hw *hw)
+{
+	struct cmux_clk *clk = to_cmux_clk(hw);
+	u32 clksel;
+
+	clksel = ioread32be(clk->reg);
+	clksel = (clksel >> CLKSEL_SHIFT) & 0xf;
+	if (clk->flags & CLKSEL_ADJUST)
+		clksel -= 8;
+	clksel = (clksel >> 2) * clocks_per_pll + clksel % 4;
+
+	return clksel;
+}
+
+const struct clk_ops cmux_ops = {
+	.get_parent = cmux_get_parent,
+	.set_parent = cmux_set_parent,
+};
+
+static void __init core_mux_init(struct device_node *np)
+{
+	struct clk *clk;
+	struct clk_init_data init;
+	struct cmux_clk *cmux_clk;
+	struct device_node *node;
+	int rc, count, i;
+	u32	offset;
+	const char *clk_name;
+	const char **parent_names;
+
+	rc = of_property_read_u32(np, "reg", &offset);
+	if (rc) {
+		pr_err("%s: could not get reg property\n", np->name);
+		return;
+	}
+
+	/* get the input clock source count */
+	count = of_property_count_strings(np, "clock-names");
+	if (count < 0) {
+		pr_err("%s: get clock count error\n", np->name);
+		return;
+	}
+	parent_names = kzalloc((sizeof(char *) * count), GFP_KERNEL);
+	if (!parent_names) {
+		pr_err("%s: could not allocate parent_names\n", __func__);
+		return;
+	}
+
+	for (i = 0; i < count; i++)
+		parent_names[i] = of_clk_get_parent_name(np, i);
+
+	cmux_clk = kzalloc(sizeof(struct cmux_clk), GFP_KERNEL);
+	if (!cmux_clk) {
+		pr_err("%s: could not allocate cmux_clk\n", __func__);
+		goto err_name;
+	}
+	cmux_clk->reg = of_iomap(np, 0);
+	if (!cmux_clk->reg) {
+		pr_err("%s: could not map register\n", __func__);
+		goto err_clk;
+	}
+
+	node = of_find_compatible_node(NULL, NULL, "fsl,p4080-clockgen");
+	if (node && (offset >= 0x80))
+		cmux_clk->flags = CLKSEL_ADJUST;
+
+	rc = of_property_read_string_index(np, "clock-output-names",
+			0, &clk_name);
+	if (rc) {
+		pr_err("%s: read clock names error\n", np->name);
+		goto err_clk;
+	}
+
+	init.name = clk_name;
+	init.ops = &cmux_ops;
+	init.parent_names = parent_names;
+	init.num_parents = count;
+	init.flags = 0;
+	cmux_clk->hw.init = &init;
+
+	clk = clk_register(NULL, &cmux_clk->hw);
+	if (IS_ERR(clk)) {
+		pr_err("%s: could not register clock\n", clk_name);
+		goto err_clk;
+	}
+
+	rc = of_clk_add_provider(np, of_clk_src_simple_get, clk);
+	if (rc) {
+		pr_err("Could not register clock provider for node:%s\n",
+			 np->name);
+		goto err_clk;
+	}
+	goto err_name;
+
+err_clk:
+	kfree(cmux_clk);
+err_name:
+	/* free *_names because they are reallocated when registered */
+	kfree(parent_names);
+}
+
+static void __init core_pll_init(struct device_node *np)
+{
+	u32 mult;
+	int i, rc, count;
+	const char *clk_name, *parent_name;
+	struct clk_onecell_data *onecell_data;
+	struct clk      **subclks;
+	void __iomem *base;
+
+	base = of_iomap(np, 0);
+	if (!base) {
+		pr_err("clk-ppc: iomap error\n");
+		return;
+	}
+
+	/* get the multiple of PLL */
+	mult = ioread32be(base);
+
+	/* check if this PLL is disabled */
+	if (mult & PLL_KILL) {
+		pr_debug("PLL:%s is disabled\n", np->name);
+		goto err_map;
+	}
+	mult = (mult >> 1) & 0x3f;
+
+	parent_name = of_clk_get_parent_name(np, 0);
+	if (!parent_name) {
+		pr_err("PLL: %s must have a parent\n", np->name);
+		goto err_map;
+	}
+
+	count = of_property_count_strings(np, "clock-output-names");
+	if (count < 0 || count > 4) {
+		pr_err("%s: clock is not supported\n", np->name);
+		goto err_map;
+	}
+
+	/* output clock number per PLL */
+	clocks_per_pll = count;
+
+	subclks = kzalloc(sizeof(struct clk *) * count, GFP_KERNEL);
+	if (!subclks) {
+		pr_err("%s: could not allocate subclks\n", __func__);
+		goto err_map;
+	}
+
+	onecell_data = kzalloc(sizeof(struct clk_onecell_data), GFP_KERNEL);
+	if (!onecell_data) {
+		pr_err("%s: could not allocate onecell_data\n", __func__);
+		goto err_clks;
+	}
+
+	for (i = 0; i < count; i++) {
+		rc = of_property_read_string_index(np, "clock-output-names",
+				i, &clk_name);
+		if (rc) {
+			pr_err("%s: could not get clock names\n", np->name);
+			goto err_cell;
+		}
+
+		/*
+		 * when count == 4, there are 4 output clocks:
+		 * /1, /2, /3, /4 respectively
+		 * when count < 4, there are at least 2 output clocks:
+		 * /1, /2, (/4, if count == 3) respectively.
+		 */
+		if (count == 4)
+			subclks[i] = clk_register_fixed_factor(NULL, clk_name,
+					parent_name, 0, mult, 1 + i);
+		else
+
+			subclks[i] = clk_register_fixed_factor(NULL, clk_name,
+					parent_name, 0, mult, 1 << i);
+
+		if (IS_ERR(subclks[i])) {
+			pr_err("%s: could not register clock\n", clk_name);
+			goto err_cell;
+		}
+	}
+
+	onecell_data->clks = subclks;
+	onecell_data->clk_num = count;
+
+	rc = of_clk_add_provider(np, of_clk_src_onecell_get, onecell_data);
+	if (rc) {
+		pr_err("Could not register clk provider for node:%s\n",
+			 np->name);
+		goto err_cell;
+	}
+
+	iounmap(base);
+	return;
+err_cell:
+	kfree(onecell_data);
+err_clks:
+	kfree(subclks);
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
+}
+
+static const struct of_device_id clk_match[] __initconst = {
+	{ .compatible = "fsl,qoriq-sysclk-1.0", .data = sysclk_init, },
+	{ .compatible = "fsl,qoriq-sysclk-2.0", .data = sysclk_init, },
+	{ .compatible = "fsl,qoriq-core-pll-1.0", .data = core_pll_init, },
+	{ .compatible = "fsl,qoriq-core-pll-2.0", .data = core_pll_init, },
+	{ .compatible = "fsl,qoriq-core-mux-1.0", .data = core_mux_init, },
+	{ .compatible = "fsl,qoriq-core-mux-2.0", .data = core_mux_init, },
+	{}
+};
+
+static int __init ppc_corenet_clk_probe(struct platform_device *pdev)
+{
+	of_clk_init(clk_match);
+
+	return 0;
+}
+
+static const struct of_device_id ppc_clk_ids[] __initconst = {
+	{ .compatible = "fsl,qoriq-clockgen-1.0", },
+	{ .compatible = "fsl,qoriq-clockgen-2.0", },
+	{}
+};
+
+static struct platform_driver ppc_corenet_clk_driver __initdata = {
+	.driver = {
+		.name = "ppc_corenet_clock",
+		.owner = THIS_MODULE,
+		.of_match_table = ppc_clk_ids,
+	},
+	.probe = ppc_corenet_clk_probe,
+};
+
+static int __init ppc_corenet_clk_init(void)
+{
+	return platform_driver_register(&ppc_corenet_clk_driver);
+}
+subsys_initcall(ppc_corenet_clk_init);
+
+CLK_OF_DECLARE(ppc_core_pll_v1, "fsl,qoriq-core-pll-1.0", core_pll_init);
+CLK_OF_DECLARE(ppc_core_pll_v2, "fsl,qoriq-core-pll-2.0", core_pll_init);
+CLK_OF_DECLARE(ppc_core_mux_v1, "fsl,qoriq-core-mux-1.0", core_mux_init);
+CLK_OF_DECLARE(ppc_core_mux_v2, "fsl,qoriq-core-mux-2.0", core_mux_init);
-- 
1.8.0
