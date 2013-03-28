Return-Path: <B29983@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BC0E22C0087
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2013 21:34:05 +1100 (EST)
From: <Yuantian.Tang@freescale.com>
To: <galak@kernel.crashing.org>
Subject: [PATCH 1/2 V2] clk: add PowerPC corenet clock driver support
Date: Thu, 28 Mar 2013 17:57:19 +0800
Message-ID: <1364464639-29813-1-git-send-email-Yuantian.Tang@freescale.com>
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

This adds the clock driver for Freescale PowerPC corenet
series SoCs using common clock infrastructure.

Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
v2: add the document for device tree clock bindings

 .../bindings/clock/freescale-corenet-clock.txt     |  67 +++++
 arch/powerpc/platforms/Kconfig.cputype             |   1 +
 drivers/clk/Kconfig                                |   7 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-ppc-corenet.c                      | 285 +++++++++++++++++++++
 5 files changed, 361 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/freescale-corenet-clock.txt
 create mode 100644 drivers/clk/clk-ppc-corenet.c

diff --git a/Documentation/devicetree/bindings/clock/freescale-corenet-clock.txt b/Documentation/devicetree/bindings/clock/freescale-corenet-clock.txt
new file mode 100644
index 0000000..696c85f
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/freescale-corenet-clock.txt
@@ -0,0 +1,67 @@
+Device Tree Clock bindings for Freescale PowerPC corenet platform
+
+This binding uses the common clock binding[1].
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Required properties:
+- compatible : shall be one of the following:
+	"fsl,core-pll-clock" - for a core PLL clock
+	"fsl,core-mux-clock" - for a core multiplexer clock. Divided from the
+		core PLL clock
+	"fixed-clock" - from common clock binding; should be output clock
+		of oscillator
+- reg : shall be the control register offset from clock block base address.
+- clocks : shall be the input parent clock phandle for the clock.
+- #clock-cells : from common clock binding; shall be set to 0 or 1.
+- clock-names : from common clock binding
+- clock-output-names : from common clock binding
+
+Example SoC include file:
+
+/ {
+	clockgen: global-utilities@e1000 {
+		compatible = "fsl,p5020-clockgen", "fsl,qoriq-clockgen-1.0",
+				   "fixed-clock";
+		reg = <0xe1000 0x1000>;
+		clock-frequency = <0>;
+		clock-output-names = "sysclk";
+		#clock-cells = <0>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pll0: pll0@800 {
+			#clock-cells = <1>;
+			reg = <0x800>;
+			compatible = "fsl,core-pll-clock";
+			clocks = <&clockgen>;
+			clock-output-names = "pll0", "pll0-div2", "pll0-div4";
+		};
+		pll1: pll1@820 {
+			#clock-cells = <1>;
+			reg = <0x820>;
+			compatible = "fsl,core-pll-clock";
+			clocks = <&clockgen>;
+			clock-output-names = "pll1", "pll1-div2", "pll1-div4";
+		};
+		mux0: mux0@0 {
+			#clock-cells = <0>;
+			reg = <0x0>;
+			compatible = "fsl,core-mux-clock";
+			clocks = <&pll0 0>, <&pll0 1>, <&pll0 2>,
+				 <&pll1 0>, <&pll1 1>, <&pll1 2>;
+			clock-names = "pll0_0", "pll0_1", "pll0_2",
+				"pll1_0", "pll1_1", "pll1_2";
+			clock-output-names = "cmux0";
+		};
+		mux1: mux1@20 {
+			#clock-cells = <0>;
+			reg = <0x20>;
+			compatible = "fsl,core-mux-clock";
+			clocks = <&pll0 0>, <&pll0 1>, <&pll0 2>,
+				 <&pll1 0>, <&pll1 1>, <&pll1 2>;
+			clock-names = "pll0_0", "pll0_1", "pll0_2",
+				"pll1_0", "pll1_1", "pll1_2";
+			clock-output-names = "cmux1";
+		};
+	};
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 18e3b76..cf065b8 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -158,6 +158,7 @@ config E500
 config PPC_E500MC
 	bool "e500mc Support"
 	select PPC_FPU
+	select COMMON_CLK
 	depends on E500
 	help
 	  This must be enabled for running on e500mc (and derivatives
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index a47e6ee..6e2fd9c 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -63,6 +63,13 @@ config CLK_TWL6040
 	  McPDM. McPDM module is using the external bit clock on the McPDM bus
 	  as functional clock.
 
+config CLK_PPC_CORENET
+	bool "Clock driver for PowerPC corenet platforms"
+	depends on PPC_E500MC && OF
+	---help---
+	  This adds the clock driver support for Freescale PowerPC corenet
+	  platforms using common clock framework.
+
 endmenu
 
 source "drivers/clk/mvebu/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 300d477..6720319 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -34,3 +34,4 @@ obj-$(CONFIG_X86)		+= x86/
 obj-$(CONFIG_COMMON_CLK_WM831X) += clk-wm831x.o
 obj-$(CONFIG_COMMON_CLK_MAX77686) += clk-max77686.o
 obj-$(CONFIG_CLK_TWL6040)	+= clk-twl6040.o
+obj-$(CONFIG_CLK_PPC_CORENET)	+= clk-ppc-corenet.o
diff --git a/drivers/clk/clk-ppc-corenet.c b/drivers/clk/clk-ppc-corenet.c
new file mode 100644
index 0000000..6811e03
--- /dev/null
+++ b/drivers/clk/clk-ppc-corenet.c
@@ -0,0 +1,285 @@
+/*
+ * Copyright 2013 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * clock driver for Freescale PowerPC corenet SoCs.
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/clk-provider.h>
+#include <linux/of_platform.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+
+struct cmux_clk {
+	struct clk_hw	hw;
+	void __iomem	*reg;
+	u32		flags;
+};
+
+#define PLL_KILL				BIT(31)
+#define CLKSEL_SHIFT			27
+#define CLKSEL_ADJUST			BIT(0)
+
+#define to_cmux_clk(p) container_of(p, struct cmux_clk, hw)
+
+static void __iomem *base;
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
+	cmux_clk->reg = base + offset;
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
+	u32 offset, mult;
+	int i, rc, count;
+	const char *clk_name, *parent_name;
+	struct clk_onecell_data *onecell_data;
+	struct clk      **subclks;
+
+	rc = of_property_read_u32(np, "reg", &offset);
+	if (rc) {
+		pr_err("%s: could not get reg property\n", np->name);
+		return;
+	}
+
+	/* get the multiple of PLL */
+	mult = ioread32be(base + offset);
+
+	/* check if this PLL is disabled */
+	if (mult & PLL_KILL) {
+		pr_debug("PLL:%s is disabled\n", np->name);
+		return;
+	}
+	mult = (mult >> 1) & 0x3f;
+
+	parent_name = of_clk_get_parent_name(np, 0);
+	if (!parent_name) {
+		pr_err("PLL: %s must have a parent\n", np->name);
+		return;
+	}
+
+	count = of_property_count_strings(np, "clock-output-names");
+	if (count < 0 || count > 4) {
+		pr_err("%s: clock is not supported\n", np->name);
+		return;
+	}
+
+	/* output clock number per PLL */
+	clocks_per_pll = count;
+
+	subclks = kzalloc(sizeof(struct clk *) * count, GFP_KERNEL);
+	if (!subclks) {
+		pr_err("%s: could not allocate subclks\n", __func__);
+		return;
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
+	return;
+err_cell:
+	kfree(onecell_data);
+err_clks:
+	kfree(subclks);
+}
+
+static const struct of_device_id clk_match[] __initconst = {
+	{ .compatible = "fixed-clock", .data = of_fixed_clk_setup, },
+	{ .compatible = "fsl,core-pll-clock", .data = core_pll_init, },
+	{ .compatible = "fsl,core-mux-clock", .data = core_mux_init, },
+	{}
+};
+
+static int __init ppc_corenet_clk_probe(struct platform_device *pdev)
+{
+	struct device_node *np;
+
+	np = pdev->dev.of_node;
+	base = of_iomap(np, 0);
+	if (!base) {
+		dev_err(&pdev->dev, "iomap error\n");
+		return -ENOMEM;
+	}
+	of_clk_init(clk_match);
+
+	return 0;
+}
+
+static const struct of_device_id ppc_clk_ids[] __initconst = {
+	{ .compatible = "fsl,qoriq-clockgen-1.0", },
+	{ .compatible = "fsl,qoriq-clockgen-2", },
+	{}
+};
+
+static struct platform_driver ppc_corenet_clk_driver = {
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
+MODULE_AUTHOR("Tang Yuantian: <Yuantian.Tang@freescale.com>");
+MODULE_DESCRIPTION("Clock Driver for Freescale PowerPC Corenet Platform");
+MODULE_LICENSE("GPL V2");
-- 
1.8.0
