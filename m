Return-Path: <Yuantian.Tang@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0130.outbound.protection.outlook.com [65.55.169.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AED4A1A0C76
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 17:06:05 +1100 (AEDT)
From: <Yuantian.Tang@freescale.com>
To: <mturquette@linaro.org>
Subject: [PATCH 1/2] clock: redefine variable clocks_per_pll as a struct member
Date: Thu, 15 Jan 2015 14:03:40 +0800
Message-ID: <1421301821-18917-1-git-send-email-Yuantian.Tang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: b07421@freescale.com, linuxppc-dev@lists.ozlabs.org,
 Tang Yuantian <Yuantian.Tang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tang Yuantian <Yuantian.Tang@freescale.com>

redefine variable clocks_per_pll as a struct member

If there are multiple PLL clock nodes, this variable will
get overwritten. Redefining it as a struct member can avoid that.

Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
---
These patches are based on following three patches which are acked
by Scott wood <scottwood@freescale.com>:
	1. http://patchwork.ozlabs.org/patch/417292/
		Revert "clk: ppc-corenet: Fix Section mismatch warning"
	2. http://patchwork.ozlabs.org/patch/417295/
		powerpc: call of_clk_init() from time_init()
	3. http://patchwork.ozlabs.org/patch/417297/
		clk: ppc-corenet: fix section mismatch warning

 drivers/clk/clk-ppc-corenet.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/clk-ppc-corenet.c b/drivers/clk/clk-ppc-corenet.c
index 57a2de4..5e9bb18 100644
--- a/drivers/clk/clk-ppc-corenet.c
+++ b/drivers/clk/clk-ppc-corenet.c
@@ -19,6 +19,7 @@
 struct cmux_clk {
 	struct clk_hw hw;
 	void __iomem *reg;
+	unsigned int clk_per_pll;
 	u32 flags;
 };
 
@@ -27,14 +28,12 @@ struct cmux_clk {
 #define CLKSEL_ADJUST		BIT(0)
 #define to_cmux_clk(p)		container_of(p, struct cmux_clk, hw)
 
-static unsigned int clocks_per_pll;
-
 static int cmux_set_parent(struct clk_hw *hw, u8 idx)
 {
 	struct cmux_clk *clk = to_cmux_clk(hw);
 	u32 clksel;
 
-	clksel = ((idx / clocks_per_pll) << 2) + idx % clocks_per_pll;
+	clksel = ((idx / clk->clk_per_pll) << 2) + idx % clk->clk_per_pll;
 	if (clk->flags & CLKSEL_ADJUST)
 		clksel += 8;
 	clksel = (clksel & 0xf) << CLKSEL_SHIFT;
@@ -52,7 +51,7 @@ static u8 cmux_get_parent(struct clk_hw *hw)
 	clksel = (clksel >> CLKSEL_SHIFT) & 0xf;
 	if (clk->flags & CLKSEL_ADJUST)
 		clksel -= 8;
-	clksel = (clksel >> 2) * clocks_per_pll + clksel % 4;
+	clksel = (clksel >> 2) * clk->clk_per_pll + clksel % 4;
 
 	return clksel;
 }
@@ -72,6 +71,7 @@ static void __init core_mux_init(struct device_node *np)
 	u32	offset;
 	const char *clk_name;
 	const char **parent_names;
+	struct of_phandle_args clkspec;
 
 	rc = of_property_read_u32(np, "reg", &offset);
 	if (rc) {
@@ -105,6 +105,17 @@ static void __init core_mux_init(struct device_node *np)
 		goto err_clk;
 	}
 
+	rc = of_parse_phandle_with_args(np, "clocks", "#clock-cells", 0,
+					&clkspec);
+	if (rc) {
+		pr_err("%s: parse clock node error\n", __func__);
+		goto err_clk;
+	}
+
+	cmux_clk->clk_per_pll = of_property_count_strings(clkspec.np,
+			"clock-output-names");
+	of_node_put(clkspec.np);
+
 	node = of_find_compatible_node(NULL, NULL, "fsl,p4080-clockgen");
 	if (node && (offset >= 0x80))
 		cmux_clk->flags = CLKSEL_ADJUST;
@@ -181,9 +192,6 @@ static void __init core_pll_init(struct device_node *np)
 		goto err_map;
 	}
 
-	/* output clock number per PLL */
-	clocks_per_pll = count;
-
 	subclks = kzalloc(sizeof(struct clk *) * count, GFP_KERNEL);
 	if (!subclks) {
 		pr_err("%s: could not allocate subclks\n", __func__);
-- 
2.1.0.27.g96db324
