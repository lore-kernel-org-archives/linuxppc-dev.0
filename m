Return-Path: <sebastian.hesselbarth@gmail.com>
Received: from mail-ea0-x22e.google.com (mail-ea0-x22e.google.com
 [IPv6:2a00:1450:4013:c01::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 17D952C00B9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2013 02:42:18 +1000 (EST)
Received: by mail-ea0-f174.google.com with SMTP id z7so553287eaf.33
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 May 2013 09:42:14 -0700 (PDT)
From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [PATCH v4 01/12] net: mv643xx_eth: use phy_disconnect instead of
 phy_detach
Date: Tue, 21 May 2013 18:41:39 +0200
Message-Id: <1369154510-4927-2-git-send-email-sebastian.hesselbarth@gmail.com>
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

Using a separated mdio bus driver with mvmdio, phy_detach on network device
removal will not stop the phy and finally lead to NULL pointer dereference
in mvmdio due to non-existent network device. Use phy_disconnect instead
to properly stop phy device from accessing network device prior removal of
the network device.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Note: I observed this behavior when removing a modular mv643xx_eth driver
after attaching it to a phy handled by (also modular) mvmdio. The mvmdio
conversion has been done in

commit c3a07134e6aa5b93a37f72ffa3d11fadf72bf757
 ("mv643xx_eth: convert to use the Marvell Orion MDIO driver")

and should go back any -stable version with that commit (propably only 3.9)

@David: I am not sure if the above description is sufficient for a -stable
patch, if you need more, like actual kernel failure, I am sure I can reproduce
it.

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
 drivers/net/ethernet/marvell/mv643xx_eth.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index d0afeea..ef3454c 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -2805,7 +2805,7 @@ static int mv643xx_eth_remove(struct platform_device *pdev)
 
 	unregister_netdev(mp->dev);
 	if (mp->phy != NULL)
-		phy_detach(mp->phy);
+		phy_disconnect(mp->phy);
 	cancel_work_sync(&mp->tx_timeout_task);
 
 	if (!IS_ERR(mp->clk))
-- 
1.7.10.4
