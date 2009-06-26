Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 76CBAB72D0
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 27 Jun 2009 08:29:54 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 08EACDDD04
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jun 2009 08:29:54 +1000 (EST)
Date: Sat, 27 Jun 2009 02:29:52 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Miller <davem@davemloft.net>
Subject: [PATCH 4/4] fs_enet: Revive fixed link support
Message-ID: <20090626222952.GD32487@oksana.dev.rtsoft.ru>
References: <20090626222900.GA14594@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20090626222900.GA14594@oksana.dev.rtsoft.ru>
Cc: netdev@vger.kernel.org, Li Yang <leoli@freescale.com>,
	Andy Fleming <afleming@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since commit aa73832c5a80d6c52c69b18af858d88fa595dd3c ("Rework
fs_enet driver to use of_mdio infrastructure") the fixed-link support
is broken in the fs_enet driver.

This patch fixes the support by removing a check for phy_node, today
of_phy_connect() tries to find fixed PHY if phy_node appears to be
NULL.

Also set netdev parent device via SET_NETDEV_DEV() call, this is needed
so that OF MDIO core could find a node pointer for a device.

Plus, fix "if (IS_ERR(phydev))" check, in case of errors,
of_phy_connect() returns NULL, not ERR_PTR as phy_connect().

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/net/fs_enet/fs_enet-main.c |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/net/fs_enet/fs_enet-main.c b/drivers/net/fs_enet/fs_enet-main.c
index b892c3a..1fea39e 100644
--- a/drivers/net/fs_enet/fs_enet-main.c
+++ b/drivers/net/fs_enet/fs_enet-main.c
@@ -754,15 +754,10 @@ static int fs_init_phy(struct net_device *dev)
 	fep->oldlink = 0;
 	fep->oldspeed = 0;
 	fep->oldduplex = -1;
-	if(fep->fpi->phy_node)
-		phydev = of_phy_connect(dev, fep->fpi->phy_node,
-					&fs_adjust_link, 0,
-					PHY_INTERFACE_MODE_MII);
-	else {
-		printk("No phy bus ID specified in BSP code\n");
-		return -EINVAL;
-	}
-	if (IS_ERR(phydev)) {
+
+	phydev = of_phy_connect(dev, fep->fpi->phy_node, &fs_adjust_link, 0,
+				PHY_INTERFACE_MODE_MII);
+	if (!phydev) {
 		printk(KERN_ERR "%s: Could not attach to PHY\n", dev->name);
 		return PTR_ERR(phydev);
 	}
@@ -1005,6 +1000,7 @@ static int __devinit fs_enet_probe(struct of_device *ofdev,
 		goto out_free_fpi;
 	}
 
+	SET_NETDEV_DEV(ndev, &ofdev->dev);
 	dev_set_drvdata(&ofdev->dev, ndev);
 
 	fep = netdev_priv(ndev);
-- 
1.6.3.1
