Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0108.outbound.protection.outlook.com [207.46.100.108])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7AF541A06DC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 21:13:25 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@Freescale.com>,
 <mturquette@linaro.org>, <haokexin@gmail.com>, <yuantian.tang@Freescale.com>
Subject: [PATCH 2/8] clk: ppc-corenet: Fix checkpatch type ALLOC_WITH_MULTIPLY
Date: Tue, 20 Jan 2015 04:09:24 -0600
Message-ID: <1421748570-14282-3-git-send-email-Emilian.Medve@Freescale.com>
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

WARNING:ALLOC_WITH_MULTIPLY: Prefer kcalloc over kzalloc with multiply
+       subclks = kzalloc(sizeof(struct clk *) * count, GFP_KERNEL);

Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
---
 drivers/clk/clk-ppc-corenet.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-ppc-corenet.c b/drivers/clk/clk-ppc-corenet.c
index 7cb8f23..efa74aa 100644
--- a/drivers/clk/clk-ppc-corenet.c
+++ b/drivers/clk/clk-ppc-corenet.c
@@ -85,7 +85,7 @@ static void __init core_mux_init(struct device_node *np)
 		pr_err("%s: get clock count error\n", np->name);
 		return;
 	}
-	parent_names = kzalloc((sizeof(char *) * count), GFP_KERNEL);
+	parent_names = kcalloc(count, sizeof(char *), GFP_KERNEL);
 	if (!parent_names) {
 		pr_err("%s: could not allocate parent_names\n", __func__);
 		return;
@@ -184,7 +184,7 @@ static void __init core_pll_init(struct device_node *np)
 	/* output clock number per PLL */
 	clocks_per_pll = count;
 
-	subclks = kzalloc(sizeof(struct clk *) * count, GFP_KERNEL);
+	subclks = kcalloc(count, sizeof(struct clk *), GFP_KERNEL);
 	if (!subclks) {
 		pr_err("%s: could not allocate subclks\n", __func__);
 		goto err_map;
-- 
2.2.2
