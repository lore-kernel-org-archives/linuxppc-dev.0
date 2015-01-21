Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0143.outbound.protection.outlook.com [65.55.169.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 701E01A0DA5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 21:17:22 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@Freescale.com>,
 <mturquette@linaro.org>, <haokexin@gmail.com>, <yuantian.tang@Freescale.com>
Subject: [PATCH v2 02/10] clk: qoriq: Fix checkpatch type ALLOC_WITH_MULTIPLY
Date: Wed, 21 Jan 2015 04:03:24 -0600
Message-ID: <1421834611-9656-3-git-send-email-Emilian.Medve@Freescale.com>
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

WARNING:ALLOC_WITH_MULTIPLY: Prefer kcalloc over kzalloc with multiply
+       subclks = kzalloc(sizeof(struct clk *) * count, GFP_KERNEL);

Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
---
 drivers/clk/clk-qoriq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index 90ff685..475ce1c 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -85,7 +85,7 @@ static void __init core_mux_init(struct device_node *np)
 		pr_err("%s: get clock count error\n", np->name);
 		return;
 	}
-	parent_names = kzalloc((sizeof(char *) * count), GFP_KERNEL);
+	parent_names = kcalloc(count, sizeof(char *), GFP_KERNEL);
 	if (!parent_names) {
 		pr_err("%s: could not allocate parent_names\n", __func__);
 		return;
@@ -192,7 +192,7 @@ static void __init core_pll_init(struct device_node *np)
 		goto err_map;
 	}
 
-	subclks = kzalloc(sizeof(struct clk *) * count, GFP_KERNEL);
+	subclks = kcalloc(count, sizeof(struct clk *), GFP_KERNEL);
 	if (!subclks) {
 		pr_err("%s: could not allocate subclks\n", __func__);
 		goto err_map;
-- 
2.2.1
