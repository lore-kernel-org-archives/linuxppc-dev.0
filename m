Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0106.outbound.protection.outlook.com [65.55.169.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AF18C1A05B9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 21:32:14 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@Freescale.com>,
 <mturquette@linaro.org>, <haokexin@gmail.com>, <yuantian.tang@Freescale.com>
Subject: [PATCH v2 03/10] clk: qoriq: Fix checkpatch type ALLOC_SIZEOF_STRUCT
Date: Wed, 21 Jan 2015 04:03:25 -0600
Message-ID: <1421834611-9656-4-git-send-email-Emilian.Medve@Freescale.com>
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

CHECK:ALLOC_SIZEOF_STRUCT: Prefer kzalloc(sizeof(*cmux_clk)...) over kzalloc(sizeof(struct cmux_clk)...)
+       cmux_clk = kzalloc(sizeof(struct cmux_clk), GFP_KERNEL);

CHECK:ALLOC_SIZEOF_STRUCT: Prefer kzalloc(sizeof(*onecell_data)...) over kzalloc(sizeof(struct clk_onecell_data)...)
+       onecell_data = kzalloc(sizeof(struct clk_onecell_data), GFP_KERNEL);

Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
---
 drivers/clk/clk-qoriq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index 475ce1c..a1cd137 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -94,7 +94,7 @@ static void __init core_mux_init(struct device_node *np)
 	for (i = 0; i < count; i++)
 		parent_names[i] = of_clk_get_parent_name(np, i);
 
-	cmux_clk = kzalloc(sizeof(struct cmux_clk), GFP_KERNEL);
+	cmux_clk = kzalloc(sizeof(*cmux_clk), GFP_KERNEL);
 	if (!cmux_clk) {
 		pr_err("%s: could not allocate cmux_clk\n", __func__);
 		goto err_name;
@@ -198,7 +198,7 @@ static void __init core_pll_init(struct device_node *np)
 		goto err_map;
 	}
 
-	onecell_data = kzalloc(sizeof(struct clk_onecell_data), GFP_KERNEL);
+	onecell_data = kzalloc(sizeof(*onecell_data), GFP_KERNEL);
 	if (!onecell_data) {
 		pr_err("%s: could not allocate onecell_data\n", __func__);
 		goto err_clks;
-- 
2.2.1
