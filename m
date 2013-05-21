Return-Path: <sebastian.hesselbarth@gmail.com>
Received: from mail-ea0-x22e.google.com (mail-ea0-x22e.google.com
 [IPv6:2a00:1450:4013:c01::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4F8C22C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2013 02:42:19 +1000 (EST)
Received: by mail-ea0-f174.google.com with SMTP id z7so553306eaf.33
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 May 2013 09:42:16 -0700 (PDT)
From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [PATCH v4 04/12] net: mv643xx_eth: use of_phy_connect if phy_node
 present
Date: Tue, 21 May 2013 18:41:42 +0200
Message-Id: <1369154510-4927-5-git-send-email-sebastian.hesselbarth@gmail.com>
In-Reply-To: <1369154510-4927-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1367854420-8006-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1369154510-4927-1-git-send-email-sebastian.hesselbarth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 David Miller <davem@davemloft.net>, Lennert Buytenhek <buytenh@wantstofly.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This connects to a phy node passed to the port device instead of probing
the phy by phy_addr.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: David Miller <davem@davemloft.net>
Cc: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org       
---
 drivers/net/ethernet/marvell/mv643xx_eth.c |   25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index e658ebd..0f5c3c2 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -60,6 +60,7 @@
 #include <linux/types.h>
 #include <linux/slab.h>
 #include <linux/clk.h>
+#include <linux/of_mdio.h>
 
 static char mv643xx_eth_driver_name[] = "mv643xx_eth";
 static char mv643xx_eth_driver_version[] = "1.4";
@@ -2715,17 +2716,27 @@ static int mv643xx_eth_probe(struct platform_device *pdev)
 	netif_set_real_num_tx_queues(dev, mp->txq_count);
 	netif_set_real_num_rx_queues(dev, mp->rxq_count);
 
-	if (pd->phy_addr != MV643XX_ETH_PHY_NONE) {
+	err = 0;
+	if (pd->phy_node) {
+		mp->phy = of_phy_connect(mp->dev, pd->phy_node,
+					 mv643xx_eth_adjust_link, 0,
+					 PHY_INTERFACE_MODE_GMII);
+		if (!mp->phy)
+			err = -ENODEV;
+	} else if (pd->phy_addr != MV643XX_ETH_PHY_NONE) {
 		mp->phy = phy_scan(mp, pd->phy_addr);
 
-		if (IS_ERR(mp->phy)) {
+		if (IS_ERR(mp->phy))
 			err = PTR_ERR(mp->phy);
-			if (err == -ENODEV)
-				err = -EPROBE_DEFER;
-			goto out;
-		}
-		phy_init(mp, pd->speed, pd->duplex);
+		else
+			phy_init(mp, pd->speed, pd->duplex);
 	}
+	if (err == -ENODEV) {
+		err = -EPROBE_DEFER;
+		goto out;
+	}
+	if (err)
+		goto out;
 
 	SET_ETHTOOL_OPS(dev, &mv643xx_eth_ethtool_ops);
 
-- 
1.7.10.4
