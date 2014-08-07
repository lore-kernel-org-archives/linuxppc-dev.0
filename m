Return-Path: <ukl@pengutronix.de>
Received: from metis.ext.pengutronix.de (unknown
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2AC1F1A0875
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Aug 2014 07:24:50 +1000 (EST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH] net: fs_enet: fix reference counting for phy_node
Date: Thu,  7 Aug 2014 23:06:00 +0200
Message-Id: <1407445560-20500-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kernel@pengutronix.de, Vitaly Bordug <vbordug@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make sure that fs_enet_probe is left with a reference to the phy node.
In the presence of a phy handle this is already the case as
of_parse_phandle returns a reference. In the fixed phy case a call to
of_node_get is necessary. Otherwise the error path and remove function
drop a reference the driver isn't holding.

Fixes: bb74d9a4a87b ("fs_enet: use the new fixed PHY helpers")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
index cfaf17b70f3f..748fd24d3d9e 100644
--- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
+++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
@@ -1033,7 +1033,7 @@ static int fs_enet_probe(struct platform_device *ofdev)
 		/* In the case of a fixed PHY, the DT node associated
 		 * to the PHY is the Ethernet MAC DT node.
 		 */
-		fpi->phy_node = ofdev->dev.of_node;
+		fpi->phy_node = of_node_get(ofdev->dev.of_node);
 	}
 
 	if (of_device_is_compatible(ofdev->dev.of_node, "fsl,mpc5125-fec")) {
-- 
2.0.1
