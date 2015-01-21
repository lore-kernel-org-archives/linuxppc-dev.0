Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0101.outbound.protection.outlook.com [207.46.100.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 79D121A0DAA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 21:17:22 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@Freescale.com>,
 <mturquette@linaro.org>, <haokexin@gmail.com>, <yuantian.tang@Freescale.com>
Subject: [PATCH v2 06/10] clk: qoriq: Replace kzalloc() with kmalloc()
Date: Wed, 21 Jan 2015 04:03:28 -0600
Message-ID: <1421834611-9656-7-git-send-email-Emilian.Medve@Freescale.com>
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

Where the memset() is not necessary

Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
---
 drivers/clk/clk-qoriq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index 07936a3..4b44825 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -193,7 +193,7 @@ static void __init core_pll_init(struct device_node *np)
 	if (!subclks)
 		goto err_map;
 
-	onecell_data = kzalloc(sizeof(*onecell_data), GFP_KERNEL);
+	onecell_data = kmalloc(sizeof(*onecell_data), GFP_KERNEL);
 	if (!onecell_data)
 		goto err_clks;
 
-- 
2.2.1
