Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3708DDDE34
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  4 Nov 2007 06:23:06 +1100 (EST)
Message-ID: <472CCA98.4000808@scram.de>
Date: Sat, 03 Nov 2007 20:23:04 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
Subject: [RFC] [POWERPC] Add support for PHY-less fs_enet operation
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: Jeff Garzik <jeff@garzik.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

this patch implements PHY-less operation for fs-enet.
Is this the way it should be done or is the preferred way to have some configuration in the deveice tree and using the fixed PHY instead?
What is your opinion on this?

Thanks,
Jochen

---
 drivers/net/fs_enet/fs_enet-main.c |   40 ++++++++++++++++++++++++-----------
 drivers/net/fs_enet/mac-scc.c      |    2 +-
 2 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/net/fs_enet/fs_enet-main.c b/drivers/net/fs_enet/fs_enet-main.c
index f2a4d39..e142eff 100644
--- a/drivers/net/fs_enet/fs_enet-main.c
+++ b/drivers/net/fs_enet/fs_enet-main.c
@@ -702,13 +702,16 @@ static void fs_timeout(struct net_device *dev)
 	spin_lock_irqsave(&fep->lock, flags);
 
 	if (dev->flags & IFF_UP) {
-		phy_stop(fep->phydev);
+		if (fep->phydev)
+			phy_stop(fep->phydev);
 		(*fep->ops->stop)(dev);
 		(*fep->ops->restart)(dev);
-		phy_start(fep->phydev);
+		if (fep->phydev)
+			phy_start(fep->phydev);
 	}
 
-	phy_start(fep->phydev);
+	if (fep->phydev)
+		phy_start(fep->phydev);
 	wake = fep->tx_free && !(CBDR_SC(fep->cur_tx) & BD_ENET_TX_READY);
 	spin_unlock_irqrestore(&fep->lock, flags);
 
@@ -784,12 +787,12 @@ static int fs_init_phy(struct net_device *dev)
 	fep->oldlink = 0;
 	fep->oldspeed = 0;
 	fep->oldduplex = -1;
-	if(fep->fpi->bus_id)
+	if(fep->fpi->bus_id && fep->fpi->bus_id[0])
 		phydev = phy_connect(dev, fep->fpi->bus_id, &fs_adjust_link, 0,
 				PHY_INTERFACE_MODE_MII);
 	else {
 		printk("No phy bus ID specified in BSP code\n");
-		return -EINVAL;
+		return 0;
 	}
 	if (IS_ERR(phydev)) {
 		printk(KERN_ERR "%s: Could not attach to PHY\n", dev->name);
@@ -826,7 +829,14 @@ static int fs_enet_open(struct net_device *dev)
 			napi_disable(&fep->napi);
 		return err;
 	}
-	phy_start(fep->phydev);
+	if (fep->phydev)
+		phy_start(fep->phydev);
+	else {
+		fep->ops->restart(dev);
+		netif_schedule(dev);
+		netif_carrier_on(dev);
+		netif_start_queue(dev);
+	}
 
 	return 0;
 }
@@ -839,7 +849,8 @@ static int fs_enet_close(struct net_device *dev)
 	netif_stop_queue(dev);
 	netif_carrier_off(dev);
 	napi_disable(&fep->napi);
-	phy_stop(fep->phydev);
+	if (fep->phydev)
+		phy_stop(fep->phydev);
 
 	spin_lock_irqsave(&fep->lock, flags);
 	spin_lock(&fep->tx_lock);
@@ -848,7 +859,8 @@ static int fs_enet_close(struct net_device *dev)
 	spin_unlock_irqrestore(&fep->lock, flags);
 
 	/* release any irqs */
-	phy_disconnect(fep->phydev);
+	if (fep->phydev)
+		phy_disconnect(fep->phydev);
 	fep->phydev = NULL;
 	fs_free_irq(dev, fep->interrupt);
 
@@ -897,13 +909,17 @@ static void fs_get_regs(struct net_device *dev, struct ethtool_regs *regs,
 static int fs_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
 {
 	struct fs_enet_private *fep = netdev_priv(dev);
-	return phy_ethtool_gset(fep->phydev, cmd);
+	if (fep->phydev)
+		return phy_ethtool_gset(fep->phydev, cmd);
+	else
+		return 0;
 }
 
 static int fs_set_settings(struct net_device *dev, struct ethtool_cmd *cmd)
 {
 	struct fs_enet_private *fep = netdev_priv(dev);
-	phy_ethtool_sset(fep->phydev, cmd);
+	if (fep->phydev)
+		phy_ethtool_sset(fep->phydev, cmd);
 	return 0;
 }
 
@@ -1238,9 +1254,7 @@ static int __devinit fs_enet_probe(struct of_device *ofdev,
 	fpi->use_napi = 1;
 	fpi->napi_weight = 17;
 
-	ret = find_phy(ofdev->node, fpi);
-	if (ret)
-		goto out_free_fpi;
+	find_phy(ofdev->node, fpi);
 
 	privsize = sizeof(*fep) +
 	           sizeof(struct sk_buff **) *
diff --git a/drivers/net/fs_enet/mac-scc.c b/drivers/net/fs_enet/mac-scc.c
index 48f2f30..018f876 100644
--- a/drivers/net/fs_enet/mac-scc.c
+++ b/drivers/net/fs_enet/mac-scc.c
@@ -389,7 +389,7 @@ static void restart(struct net_device *dev)
 	W16(sccp, scc_psmr, SCC_PSMR_ENCRC | SCC_PSMR_NIB22);
 
 	/* Set full duplex mode if needed */
-	if (fep->phydev->duplex)
+	if ((fep->phydev) && (fep->phydev->duplex))
 		S16(sccp, scc_psmr, SCC_PSMR_LPB | SCC_PSMR_FDE);
 
 	S32(sccp, scc_gsmrl, SCC_GSMRL_ENR | SCC_GSMRL_ENT);
-- 
1.5.3.4
