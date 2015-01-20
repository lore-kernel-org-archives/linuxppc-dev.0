Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0106.outbound.protection.outlook.com [157.56.111.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D6C951A132A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 21:28:22 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@Freescale.com>,
 <mturquette@linaro.org>, <haokexin@gmail.com>, <yuantian.tang@Freescale.com>
Subject: [PATCH 1/8] clk: ppc-corenet: Fix checkpatch type
 PARENTHESIS_ALIGNMENT
Date: Tue, 20 Jan 2015 04:09:23 -0600
Message-ID: <1421748570-14282-2-git-send-email-Emilian.Medve@Freescale.com>
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

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
+       rc = of_property_read_string_index(np, "clock-output-names",
+                       0, &clk_name);

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
+               pr_err("Could not register clock provider for node:%s\n",
+                        np->name);

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
+               rc = of_property_read_string_index(np, "clock-output-names",
+                               i, &clk_name);

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
+               pr_err("Could not register clk provider for node:%s\n",
+                        np->name);

Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
---
 drivers/clk/clk-ppc-corenet.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk-ppc-corenet.c b/drivers/clk/clk-ppc-corenet.c
index bf0fe56..7cb8f23 100644
--- a/drivers/clk/clk-ppc-corenet.c
+++ b/drivers/clk/clk-ppc-corenet.c
@@ -110,7 +110,7 @@ static void __init core_mux_init(struct device_node *np)
 		cmux_clk->flags = CLKSEL_ADJUST;
 
 	rc = of_property_read_string_index(np, "clock-output-names",
-			0, &clk_name);
+					   0, &clk_name);
 	if (rc) {
 		pr_err("%s: read clock names error\n", np->name);
 		goto err_clk;
@@ -132,7 +132,7 @@ static void __init core_mux_init(struct device_node *np)
 	rc = of_clk_add_provider(np, of_clk_src_simple_get, clk);
 	if (rc) {
 		pr_err("Could not register clock provider for node:%s\n",
-			 np->name);
+		       np->name);
 		goto err_clk;
 	}
 	goto err_name;
@@ -198,7 +198,7 @@ static void __init core_pll_init(struct device_node *np)
 
 	for (i = 0; i < count; i++) {
 		rc = of_property_read_string_index(np, "clock-output-names",
-				i, &clk_name);
+						   i, &clk_name);
 		if (rc) {
 			pr_err("%s: could not get clock names\n", np->name);
 			goto err_cell;
@@ -230,7 +230,7 @@ static void __init core_pll_init(struct device_node *np)
 	rc = of_clk_add_provider(np, of_clk_src_onecell_get, onecell_data);
 	if (rc) {
 		pr_err("Could not register clk provider for node:%s\n",
-			 np->name);
+		       np->name);
 		goto err_cell;
 	}
 
-- 
2.2.2
