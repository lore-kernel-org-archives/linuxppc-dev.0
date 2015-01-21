Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0101.outbound.protection.outlook.com [157.56.111.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7B4401A0DAF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 21:17:22 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@Freescale.com>,
 <mturquette@linaro.org>, <haokexin@gmail.com>, <yuantian.tang@Freescale.com>
Subject: [PATCH v2 09/10] clk: qoriq: Add support for the platform PLL
Date: Wed, 21 Jan 2015 04:03:31 -0600
Message-ID: <1421834611-9656-10-git-send-email-Emilian.Medve@Freescale.com>
In-Reply-To: <1421834611-9656-1-git-send-email-Emilian.Medve@Freescale.com>
References: <1421834611-9656-1-git-send-email-Emilian.Medve@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Emil Medve <Emilian.Medve@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Change-Id: Iac11ed95f274485a86d2c11f32a3dc502bcd020f
Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
---
 drivers/clk/clk-qoriq.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index 07bdfc5..cda90a9 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -271,9 +271,92 @@ static void __init sysclk_init(struct device_node *node)
 	if (!IS_ERR(clk))
 		of_clk_add_provider(np, of_clk_src_simple_get, clk);
 }
+
+static void __init pltfrm_pll_init(struct device_node *np)
+{
+	void __iomem *base;
+	uint32_t mult;
+	const char *parent_name, *clk_name;
+	int i, _errno;
+	struct clk_onecell_data *cod;
+
+	base = of_iomap(np, 0);
+	if (!base) {
+		pr_err("%s(): %s: of_iomap() failed\n", __func__, np->name);
+		return;
+	}
+
+	/* Get the multiple of PLL */
+	mult = ioread32be(base);
+
+	iounmap(base);
+
+	/* Check if this PLL is disabled */
+	if (mult & PLL_KILL) {
+		pr_debug("%s(): %s: Disabled\n", __func__, np->name);
+		return;
+	}
+	mult = (mult & GENMASK(6, 1)) >> 1;
+
+	parent_name = of_clk_get_parent_name(np, 0);
+	if (!parent_name) {
+		pr_err("%s(): %s: of_clk_get_parent_name() failed\n",
+		       __func__, np->name);
+		return;
+	}
+
+	i = of_property_count_strings(np, "clock-output-names");
+	if (i < 0) {
+		pr_err("%s(): %s: of_property_count_strings(clock-output-names) = %d\n",
+		       __func__, np->name, i);
+		return;
+	}
+
+	cod = kmalloc(sizeof(*cod) + i * sizeof(struct clk *), GFP_KERNEL);
+	if (!cod)
+		return;
+	cod->clks = (struct clk **)(cod + 1);
+	cod->clk_num = i;
+
+	for (i = 0; i < cod->clk_num; i++) {
+		_errno = of_property_read_string_index(np, "clock-output-names",
+						       i, &clk_name);
+		if (_errno < 0) {
+			pr_err("%s(): %s: of_property_read_string_index(clock-output-names) = %d\n",
+			       __func__, np->name, _errno);
+			goto return_clk_unregister;
+		}
+
+		cod->clks[i] = clk_register_fixed_factor(NULL, clk_name,
+					       parent_name, 0, mult, 1 + i);
+		if (IS_ERR(cod->clks[i])) {
+			pr_err("%s(): %s: clk_register_fixed_factor(%s) = %ld\n",
+			       __func__, np->name,
+			       clk_name, PTR_ERR(cod->clks[i]));
+			goto return_clk_unregister;
+		}
+	}
+
+	_errno = of_clk_add_provider(np, of_clk_src_onecell_get, cod);
+	if (_errno < 0) {
+		pr_err("%s(): %s: of_clk_add_provider() = %d\n",
+		       __func__, np->name, _errno);
+		goto return_clk_unregister;
+	}
+
+	return;
+
+return_clk_unregister:
+	while (--i >= 0)
+		clk_unregister(cod->clks[i]);
+	kfree(cod);
+}
+
 CLK_OF_DECLARE(qoriq_sysclk_1, "fsl,qoriq-sysclk-1.0", sysclk_init);
 CLK_OF_DECLARE(qoriq_sysclk_2, "fsl,qoriq-sysclk-2.0", sysclk_init);
 CLK_OF_DECLARE(qoriq_core_pll_1, "fsl,qoriq-core-pll-1.0", core_pll_init);
 CLK_OF_DECLARE(qoriq_core_pll_2, "fsl,qoriq-core-pll-2.0", core_pll_init);
 CLK_OF_DECLARE(qoriq_core_mux_1, "fsl,qoriq-core-mux-1.0", core_mux_init);
 CLK_OF_DECLARE(qoriq_core_mux_2, "fsl,qoriq-core-mux-2.0", core_mux_init);
+CLK_OF_DECLARE(qoriq_pltfrm_pll_1, "fsl,qoriq-platform-pll-1.0", pltfrm_pll_init);
+CLK_OF_DECLARE(qoriq_pltfrm_pll_2, "fsl,qoriq-platform-pll-2.0", pltfrm_pll_init);
-- 
2.2.1
