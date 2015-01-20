Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0105.outbound.protection.outlook.com [157.56.111.105])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7F6D31A083B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 21:27:58 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@Freescale.com>,
 <mturquette@linaro.org>, <haokexin@gmail.com>, <yuantian.tang@Freescale.com>
Subject: [PATCH 4/8] clk: ppc-corenet: Fix checkpatch type OOM_MESSAGE
Date: Tue, 20 Jan 2015 04:09:26 -0600
Message-ID: <1421748570-14282-5-git-send-email-Emilian.Medve@Freescale.com>
In-Reply-To: <1421748570-14282-1-git-send-email-Emilian.Medve@Freescale.com>
References: <1421748570-14282-1-git-send-email-Emilian.Medve@Freescale.com>
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

WARNING:OOM_MESSAGE: Possible unnecessary 'out of memory' message
+       if (!parent_names) {
+               pr_err("%s: could not allocate parent_names\n", __func__);

WARNING:OOM_MESSAGE: Possible unnecessary 'out of memory' message
+       if (!cmux_clk) {
+               pr_err("%s: could not allocate cmux_clk\n", __func__);

WARNING:OOM_MESSAGE: Possible unnecessary 'out of memory' message
+       if (!subclks) {
+               pr_err("%s: could not allocate subclks\n", __func__);

WARNING:OOM_MESSAGE: Possible unnecessary 'out of memory' message
+       if (!onecell_data) {
+               pr_err("%s: could not allocate onecell_data\n", __func__);

Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
---
 drivers/clk/clk-ppc-corenet.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/clk-ppc-corenet.c b/drivers/clk/clk-ppc-corenet.c
index a439f52..6a9dbaa 100644
--- a/drivers/clk/clk-ppc-corenet.c
+++ b/drivers/clk/clk-ppc-corenet.c
@@ -86,19 +86,16 @@ static void __init core_mux_init(struct device_node *np)
 		return;
 	}
 	parent_names = kcalloc(count, sizeof(char *), GFP_KERNEL);
-	if (!parent_names) {
-		pr_err("%s: could not allocate parent_names\n", __func__);
+	if (!parent_names)
 		return;
-	}
 
 	for (i = 0; i < count; i++)
 		parent_names[i] = of_clk_get_parent_name(np, i);
 
 	cmux_clk = kzalloc(sizeof(*cmux_clk), GFP_KERNEL);
-	if (!cmux_clk) {
-		pr_err("%s: could not allocate cmux_clk\n", __func__);
+	if (!cmux_clk)
 		goto err_name;
-	}
+
 	cmux_clk->reg = of_iomap(np, 0);
 	if (!cmux_clk->reg) {
 		pr_err("%s: could not map register\n", __func__);
@@ -185,16 +182,12 @@ static void __init core_pll_init(struct device_node *np)
 	clocks_per_pll = count;
 
 	subclks = kcalloc(count, sizeof(struct clk *), GFP_KERNEL);
-	if (!subclks) {
-		pr_err("%s: could not allocate subclks\n", __func__);
+	if (!subclks)
 		goto err_map;
-	}
 
 	onecell_data = kzalloc(sizeof(*onecell_data), GFP_KERNEL);
-	if (!onecell_data) {
-		pr_err("%s: could not allocate onecell_data\n", __func__);
+	if (!onecell_data)
 		goto err_clks;
-	}
 
 	for (i = 0; i < count; i++) {
 		rc = of_property_read_string_index(np, "clock-output-names",
-- 
2.2.2
