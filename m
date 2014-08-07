Return-Path: <ukl@pengutronix.de>
Received: from metis.ext.pengutronix.de (unknown
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3C3981A0A4B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Aug 2014 07:48:57 +1000 (EST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Li Yang <leoli@freescale.com>
Subject: [PATCH 3/3] net: ucc_geth: Don't use the MAC as PHY without a fixed
 link
Date: Thu,  7 Aug 2014 23:48:26 +0200
Message-Id: <1407448106-1819-3-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1407448106-1819-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1407448106-1819-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: netdev@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, kernel@pengutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This matches what the other drivers using fixed-link support do and
restores the behaviour before commit 87009814cdbb ("ucc_geth: use the
new fixed PHY helpers") for the affected device trees (i.e. no
phy-handle and no fixed-link).

Fixes: 87009814cdbb ("ucc_geth: use the new fixed PHY helpers")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/net/ethernet/freescale/ucc_geth.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index a22ff770f9e5..07415a0df88c 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -3787,15 +3787,14 @@ static int ucc_geth_probe(struct platform_device* ofdev)
 	ug_info->uf_info.irq = irq_of_parse_and_map(np, 0);
 
 	ug_info->phy_node = of_parse_phandle(np, "phy-handle", 0);
-	if (!ug_info->phy_node) {
-		/* In the case of a fixed PHY, the DT node associated
+	if (!ug_info->phy_node && of_phy_is_fixed_link(np)) {
+		/*
+		 * In the case of a fixed PHY, the DT node associated
 		 * to the PHY is the Ethernet MAC DT node.
 		 */
-		if (of_phy_is_fixed_link(np)) {
-			err = of_phy_register_fixed_link(np);
-			if (err)
-				return err;
-		}
+		err = of_phy_register_fixed_link(np);
+		if (err)
+			return err;
 		ug_info->phy_node = of_node_get(np);
 	}
 
-- 
2.0.1
