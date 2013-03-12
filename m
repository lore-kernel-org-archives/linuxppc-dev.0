Return-Path: <B29983@freescale.com>
From: <Yuantian.Tang@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/2][RFC] clk: add PowerPC corenet clock support
Date: Tue, 12 Mar 2013 15:07:33 +0800
Message-ID: <1363072053-32736-2-git-send-email-Yuantian.Tang@freescale.com>
In-Reply-To: <1363072053-32736-1-git-send-email-Yuantian.Tang@freescale.com>
References: <1363072053-32736-1-git-send-email-Yuantian.Tang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Tang Yuantian <Yuantian.Tang@freescale.com>,
 devicetree-discuss@lists.ozlabs.org, R58472@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tang Yuantian <Yuantian.Tang@freescale.com>

This adds the clock driver support for Freescale E500MC, E5500,
E6500 series SoCs using common clock framework.

Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
---
 arch/powerpc/platforms/Kconfig.cputype |    1 +
 drivers/clk/Kconfig                    |    7 +
 drivers/clk/Makefile                   |    1 +
 drivers/clk/clk-ppc-corenet.c          |  262 ++++++++++++++++++++++++++++++++
 4 files changed, 271 insertions(+), 0 deletions(-)
 create mode 100644 drivers/clk/clk-ppc-corenet.c

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 72afd28..dc3a56b 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -159,6 +159,7 @@ config E500
 config PPC_E500MC
 	bool "e500mc Support"
 	select PPC_FPU
+	select COMMON_CLK
 	depends on E500
 	help
 	  This must be enabled for running on e500mc (and derivatives
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index a47e6ee..ecb663d 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -63,6 +63,13 @@ config CLK_TWL6040
 	  McPDM. McPDM module is using the external bit clock on the McPDM bus
 	  as functional clock.
 
+config CLK_PPC_CORENET
+	bool "Clock driver for PowerPC corenet platforms"
+	depends on PPC_E500MC
+	---help---
+      This adds the clock driver support for Freescale PowerPC corenet
+	  platforms using common clock framework.
+
 endmenu
 
 source "drivers/clk/mvebu/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index ee90e87..9e7750c 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_ARCH_U8500)	+= ux500/
 obj-$(CONFIG_ARCH_VT8500)	+= clk-vt8500.o
 obj-$(CONFIG_ARCH_SUNXI)	+= clk-sunxi.o
 obj-$(CONFIG_ARCH_ZYNQ)		+= clk-zynq.o
+obj-$(CONFIG_CLK_PPC_CORENET)	+= clk-ppc-corenet.o
 
 # Chip specific
 obj-$(CONFIG_COMMON_CLK_WM831X) += clk-wm831x.o
diff --git a/drivers/clk/clk-ppc-corenet.c b/drivers/clk/clk-ppc-corenet.c
new file mode 100644
index 0000000..a7bfb02
--- /dev/null
+++ b/drivers/clk/clk-ppc-corenet.c
@@ -0,0 +1,262 @@
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
+};
+
+#define PLL_KILL				(1 << 31)
+#define	CLKSEL_SHIFT			27
+
+#define to_cmux_clk(p) container_of(p, struct cmux_clk, hw)
+
+static const int idx_val[9] = {0, 1, 2, 4, 5, 6, 8, 9, 10};
+static const int val_idx[12] = {0, 1, 2, 0, 3, 4, 5, 0, 6, 7, 8, 0};
+
+static void __iomem *base;
+
+static int cmux_set_parent(struct clk_hw *hw, u8 idx)
+{
+	struct cmux_clk *clk = to_cmux_clk(hw);
+	u32 clksel;
+
+	clksel = (idx_val[idx] & 0xf) << CLKSEL_SHIFT;
+	iowrite32be(clksel, clk->reg);
+
+	return 0;
+}
+
+static u8 cmux_get_parent(struct clk_hw *hw)
+{
+	struct cmux_clk *clk = to_cmux_clk(hw);
+	u32 val;
+
+	val = ioread32be(clk->reg);
+	val = (val >> CLKSEL_SHIFT) & 0xf;
+
+	return val_idx[val];
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
+	rc = of_property_read_string_index(np, "clock-output-names",
+			0, &clk_name);
+	if (rc) {
+		pr_err("%s: read clock names error\n", np->name);
+		goto err_clk;
+	}
+
+	init.name = clk_name;
+	init.ops = &cmux_ops;
+	init.flags = 0;
+	init.parent_names = parent_names;
+	init.num_parents = count;
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
+static const struct of_device_id ppc_corenet_clk_ids[] __initconst = {
+	{ .compatible = "fsl,qoriq-clockgen-1.0", },
+	{ .compatible = "fsl,qoriq-clockgen-2", },
+	{}
+};
+
+static struct platform_driver ppc_corenet_clk_driver = {
+	.driver = {
+		.name = "ppc_corenet_clock",
+		.owner = THIS_MODULE,
+		.of_match_table = ppc_corenet_clk_ids,
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
+MODULE_LICENSE("GPL");
-- 
1.7.0.4
