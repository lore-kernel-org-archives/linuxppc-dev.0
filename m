Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0135.outbound.protection.outlook.com [207.46.100.135])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E29F81A06A7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 21:13:24 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@Freescale.com>,
 <mturquette@linaro.org>, <haokexin@gmail.com>, <yuantian.tang@Freescale.com>
Subject: [PATCH 3/8] clk: ppc-corenet: Fix checkpatch type ALLOC_SIZEOF_STRUCT
Date: Tue, 20 Jan 2015 04:09:25 -0600
Message-ID: <1421748570-14282-4-git-send-email-Emilian.Medve@Freescale.com>
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

CHECK:ALLOC_SIZEOF_STRUCT: Prefer kzalloc(sizeof(*cmux_clk)...) over kzalloc(sizeof(struct cmux_clk)...)
+       cmux_clk = kzalloc(sizeof(struct cmux_clk), GFP_KERNEL);

CHECK:ALLOC_SIZEOF_STRUCT: Prefer kzalloc(sizeof(*onecell_data)...) over kzalloc(sizeof(struct clk_onecell_data)...)
+       onecell_data = kzalloc(sizeof(struct clk_onecell_data), GFP_KERNEL);

Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
---
 drivers/clk/clk-ppc-corenet.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-ppc-corenet.c b/drivers/clk/clk-ppc-corenet.c
index efa74aa..a439f52 100644
--- a/drivers/clk/clk-ppc-corenet.c
+++ b/drivers/clk/clk-ppc-corenet.c
@@ -94,7 +94,7 @@ static void __init core_mux_init(struct device_node *np)
 	for (i = 0; i < count; i++)
 		parent_names[i] = of_clk_get_parent_name(np, i);
 
-	cmux_clk = kzalloc(sizeof(struct cmux_clk), GFP_KERNEL);
+	cmux_clk = kzalloc(sizeof(*cmux_clk), GFP_KERNEL);
 	if (!cmux_clk) {
 		pr_err("%s: could not allocate cmux_clk\n", __func__);
 		goto err_name;
@@ -190,7 +190,7 @@ static void __init core_pll_init(struct device_node *np)
 		goto err_map;
 	}
 
-	onecell_data = kzalloc(sizeof(struct clk_onecell_data), GFP_KERNEL);
+	onecell_data = kzalloc(sizeof(*onecell_data), GFP_KERNEL);
 	if (!onecell_data) {
 		pr_err("%s: could not allocate onecell_data\n", __func__);
 		goto err_clks;
-- 
2.2.2
