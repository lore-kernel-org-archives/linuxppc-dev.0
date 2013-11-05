Return-Path: <jgunthorpe@obsidianresearch.com>
Received: from quartz.orcorp.ca (quartz.orcorp.ca [184.70.90.242])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7BC6D2C0092
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Nov 2013 11:27:44 +1100 (EST)
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [PATCH] net: mv643xx_eth: Add missing phy_addr_set in DT mode
Date: Mon,  4 Nov 2013 17:27:19 -0700
Message-Id: <1383611239-14556-1-git-send-email-jgunthorpe@obsidianresearch.com>
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

Commit cc9d4598 'net: mv643xx_eth: use of_phy_connect if phy_node
present' made the call to phy_scan optional, if the DT has a link to
the phy node.

However phy_scan has the side effect of calling phy_addr_set, which
writes the phy MDIO address to the ethernet controller. If phy_addr_set
is not called, and the bootloader has not set the correct address then
the driver will fail to function.

Tested on Kirkwood.

Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
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
 drivers/net/ethernet/marvell/mv643xx_eth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index 2c210ec..00e43b5 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -2890,6 +2890,7 @@ static int mv643xx_eth_probe(struct platform_device *pdev)
 					 PHY_INTERFACE_MODE_GMII);
 		if (!mp->phy)
 			err = -ENODEV;
+		phy_addr_set(mp, mp->phy->addr);
 	} else if (pd->phy_addr != MV643XX_ETH_PHY_NONE) {
 		mp->phy = phy_scan(mp, pd->phy_addr);
 
-- 
1.8.1.2
