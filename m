Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0109.outbound.protection.outlook.com [207.46.100.109])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41F4C1A06A7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 21:13:26 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@Freescale.com>,
 <mturquette@linaro.org>, <haokexin@gmail.com>, <yuantian.tang@Freescale.com>
Subject: [PATCH 6/8] clk: ppc-corenet: Replace kzalloc() with kmalloc()
Date: Tue, 20 Jan 2015 04:09:28 -0600
Message-ID: <1421748570-14282-7-git-send-email-Emilian.Medve@Freescale.com>
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

Where the memset() is not necessary

Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
---
 drivers/clk/clk-ppc-corenet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-ppc-corenet.c b/drivers/clk/clk-ppc-corenet.c
index d84a7f0..91816b1 100644
--- a/drivers/clk/clk-ppc-corenet.c
+++ b/drivers/clk/clk-ppc-corenet.c
@@ -185,7 +185,7 @@ static void __init core_pll_init(struct device_node *np)
 	if (!subclks)
 		goto err_map;
 
-	onecell_data = kzalloc(sizeof(*onecell_data), GFP_KERNEL);
+	onecell_data = kmalloc(sizeof(*onecell_data), GFP_KERNEL);
 	if (!onecell_data)
 		goto err_clks;
 
-- 
2.2.2
