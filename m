Return-Path: <Igal.Liberman@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0112.outbound.protection.outlook.com [157.56.110.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 64BE61A0176
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 01:24:30 +1000 (AEST)
From: Igal.Liberman <igal.liberman@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [v3] clk: qoriq: Add support for the FMan clock
Date: Tue, 14 Apr 2015 14:15:22 +0300
Message-ID: <1429010123-24764-1-git-send-email-igal.liberman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, sboyd@codeaurora.org, mturquette@linaro.org,
 Igal Liberman <Igal.Liberman@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Igal Liberman <Igal.Liberman@freescale.com>

This patch depends on the following patches:
	https://patchwork.ozlabs.org/patch/461151/
	https://patchwork.ozlabs.org/patch/461155/

This patche is described by the following binding document update:
	https://patchwork.ozlabs.org/patch/461166/

v3:	Updated commit message

v2:	- Added clock maintainers
	- Cached FMan clock parent during initialization
	- Register the clock after checking if the hardware exists
	- updated error messages

Signed-off-by: Igal Liberman <Igal.Liberman@freescale.com>
---
 drivers/clk/clk-qoriq.c |  208 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 208 insertions(+)

diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index cda90a9..d588e90 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -19,6 +19,8 @@
 #include <linux/of.h>
 #include <linux/slab.h>
 
+#include <asm/fsl_guts.h>
+
 struct cmux_clk {
 	struct clk_hw hw;
 	void __iomem *reg;
@@ -155,6 +157,211 @@ err_name:
 	kfree(parent_names);
 }
 
+/* Table for matching compatible strings, for device tree
+ * guts node, for QorIQ SOCs.
+ * "fsl,qoriq-device-config-2.0" corresponds to T4 & B4
+ * SOCs. For the older SOCs "fsl,qoriq-device-config-1.0"
+ * string would be used.
+ */
+
+static const struct of_device_id guts_device_ids[] = {
+	{ .compatible = "fsl,qoriq-device-config-1.0", },
+	{ .compatible = "fsl,qoriq-device-config-2.0", },
+	{}
+};
+
+/* P2, P3, P4, P5 */
+#define FM1_CLK_SEL_SHIFT		30
+#define FM1_CLK_SEL			BIT(FM1_CLK_SEL_SHIFT)
+#define FM2_CLK_SEL_SHIFT		29
+#define FM2_CLK_SEL			BIT(FM2_CLK_SEL_SHIFT)
+#define HWA_ASYNC_DIV_SHIFT		26
+#define HWA_ASYNC_DIV			BIT(HWA_ASYNC_DIV_SHIFT)
+
+/* B4, T2 */
+#define HWA_CGA_M1_CLK_SEL_SHIFT	29
+#define HWA_CGA_M1_CLK_SEL		(BIT(HWA_CGA_M1_CLK_SEL_SHIFT + 2) |\
+					 BIT(HWA_CGA_M1_CLK_SEL_SHIFT + 1) |\
+					 BIT(HWA_CGA_M1_CLK_SEL_SHIFT))
+
+/* T4240 */
+#define HWA_CGB_M1_CLK_SEL_SHIFT	26
+#define HWA_CGB_M1_CLK_SEL		(BIT(HWA_CGB_M1_CLK_SEL_SHIFT + 2) |\
+					 BIT(HWA_CGB_M1_CLK_SEL_SHIFT + 1) |\
+					 BIT(HWA_CGB_M1_CLK_SEL_SHIFT))
+#define HWA_CGB_M2_CLK_SEL_SHIFT	3
+#define HWA_CGB_M2_CLK_SEL		(BIT(HWA_CGB_M2_CLK_SEL_SHIFT + 2) |\
+					 BIT(HWA_CGB_M2_CLK_SEL_SHIFT + 1) |\
+					 BIT(HWA_CGB_M2_CLK_SEL_SHIFT))
+
+static u8 get_fm_clk_parent(struct clk_hw *hw)
+{
+	return hw->init->flags;
+}
+
+static const struct clk_ops fm_clk_ops = {
+	.get_parent = get_fm_clk_parent,
+};
+
+static int get_fm_clk_idx(int fm_id, int *fm_clk_idx)
+{
+	struct ccsr_guts __iomem *guts_regs = NULL;
+	struct device_node *guts;
+	uint32_t reg = 0;
+	int clk_src = 0;
+
+	guts = of_find_matching_node(NULL, guts_device_ids);
+	if (!guts) {
+		pr_err("could not find GUTS node\n");
+		return -ENODEV;
+	}
+
+	guts_regs = of_iomap(guts, 0);
+	of_node_put(guts);
+	if (!guts_regs) {
+		pr_err("ioremap of GUTS node failed\n");
+		return -ENODEV;
+	}
+
+	if (of_device_is_compatible(guts, "fsl,p1023-guts") ||
+	    of_device_is_compatible(guts, "fsl,t1040-device-config")) {
+		/* P1023 and T1040 have only one optional clock source */
+		*fm_clk_idx = 0;
+	} else if (of_device_is_compatible(guts, "fsl,p2041-device-config") ||
+		   of_device_is_compatible(guts, "fsl,p3041-device-config") ||
+		   of_device_is_compatible(guts, "fsl,p4080-device-config")) {
+		/* Read RCW*/
+		reg = ioread32be(&guts_regs->rcwsr[7]);
+
+		if (fm_id == 0)
+			*fm_clk_idx = (reg & FM1_CLK_SEL) >>
+							FM1_CLK_SEL_SHIFT;
+		else
+			*fm_clk_idx = (reg & FM2_CLK_SEL) >>
+							FM2_CLK_SEL_SHIFT;
+	} else if (of_device_is_compatible(guts, "fsl,p5020-device-config") ||
+		   of_device_is_compatible(guts, "fsl,p5040-device-config")) {
+		/* Read RCW */
+		reg = ioread32be(&guts_regs->rcwsr[7]);
+
+		if (fm_id == 0)
+			clk_src = (reg & FM1_CLK_SEL) >> FM1_CLK_SEL_SHIFT;
+		else
+			clk_src = (reg & FM2_CLK_SEL) >> FM2_CLK_SEL_SHIFT;
+
+		if (clk_src == 0) {
+			*fm_clk_idx = 0;
+		} else {
+			clk_src = (reg & HWA_ASYNC_DIV) >> HWA_ASYNC_DIV_SHIFT;
+			*fm_clk_idx = clk_src + 1;
+		}
+	} else if (of_device_is_compatible(guts, "fsl,b4-device-config") ||
+		   of_device_is_compatible(guts, "fsl,t2080-device-config")) {
+		/* Read RCW */
+		reg = ioread32be(&guts_regs->rcwsr[7]);
+
+		clk_src = (reg & HWA_CGA_M1_CLK_SEL) >>
+						HWA_CGA_M1_CLK_SEL_SHIFT;
+		*fm_clk_idx = clk_src - 1;
+	} else if (of_device_is_compatible(guts, "fsl,t4240-device-config")) {
+		if (fm_id == 0) {
+			reg = ioread32be(&guts_regs->rcwsr[7]);
+			clk_src = (reg & HWA_CGB_M1_CLK_SEL) >>
+						HWA_CGB_M1_CLK_SEL_SHIFT;
+		} else {
+			reg = ioread32be(&guts_regs->rcwsr[15]);
+			clk_src = (reg & HWA_CGB_M2_CLK_SEL) >>
+						HWA_CGB_M2_CLK_SEL_SHIFT;
+		}
+		*fm_clk_idx = clk_src - 2;
+	} else {
+		pr_err("Unsupported device! Can't determine FM clk source!\n");
+		iounmap(guts_regs);
+		return -ENODEV;
+	}
+
+	iounmap(guts_regs);
+
+	return 0;
+
+}
+
+static void __init fm_mux_init(struct device_node *np)
+{
+	struct clk_init_data *init;
+	struct clk_hw *hw;
+	int count, i, ret, fm_id = 0, fm_clk_idx;
+	struct clk *clk;
+
+	init = kmalloc((sizeof(struct clk_init_data)), GFP_KERNEL);
+	if (!init)
+		return;
+
+	/* get the input clock source count */
+	count = of_property_count_strings(np, "clock-names");
+	if (count < 0) {
+		pr_err("%s: get clock count error\n", np->name);
+		goto err_init;
+	}
+
+	init->parent_names = kmalloc((sizeof(char *) * count), GFP_KERNEL);
+	if (!init->parent_names)
+		goto err_init;
+
+	for (i = 0; i < count; i++)
+		init->parent_names[i] = of_clk_get_parent_name(np, i);
+
+	hw = kzalloc(sizeof(*hw), GFP_KERNEL);
+	if (!hw)
+		goto err_name;
+
+	ret = of_property_read_string_index(np, "clock-output-names", 0,
+					    &init->name);
+	if (ret) {
+		pr_err("%s: read clock names error\n", np->name);
+		goto err_clk_hw;
+	}
+
+	if (!strcmp(np->name, "fm1-clk-mux"))
+		fm_id = 1;
+
+	ret = get_fm_clk_idx(fm_id, &fm_clk_idx);
+	if (ret)
+		goto err_clk_hw;
+
+	init->ops = &fm_clk_ops;
+	init->num_parents = count;
+	/* Save clock source index */
+	init->flags = fm_clk_idx;
+	hw->init = init;
+
+	clk = clk_register(NULL, hw);
+	if (IS_ERR(clk)) {
+		pr_err("%s: could not register clock\n", init->name);
+		goto err_clk_hw;
+	}
+
+	ret = of_clk_add_provider(np, of_clk_src_simple_get, clk);
+	if (ret) {
+		pr_err("Could not register clock provider for node: %s\n",
+		       np->name);
+		clk_unregister(clk);
+		goto err_clk_hw;
+	}
+
+	/* Free parent_names because they are reallocated when registered */
+	kfree(init->parent_names);
+
+	return;
+
+err_clk_hw:
+	kfree(hw);
+err_name:
+	kfree(init->parent_names);
+err_init:
+	kfree(init);
+}
+
 static void __init core_pll_init(struct device_node *np)
 {
 	u32 mult;
@@ -360,3 +567,4 @@ CLK_OF_DECLARE(qoriq_core_mux_1, "fsl,qoriq-core-mux-1.0", core_mux_init);
 CLK_OF_DECLARE(qoriq_core_mux_2, "fsl,qoriq-core-mux-2.0", core_mux_init);
 CLK_OF_DECLARE(qoriq_pltfrm_pll_1, "fsl,qoriq-platform-pll-1.0", pltfrm_pll_init);
 CLK_OF_DECLARE(qoriq_pltfrm_pll_2, "fsl,qoriq-platform-pll-2.0", pltfrm_pll_init);
+CLK_OF_DECLARE(qoriq_fm_mux, "fsl,fman-clk-mux", fm_mux_init);
-- 
1.7.9.5
