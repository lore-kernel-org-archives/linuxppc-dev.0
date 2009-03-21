Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.169])
	by ozlabs.org (Postfix) with ESMTP id 47111DDF9E
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Mar 2009 09:28:27 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so1928968wfg.15
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Mar 2009 15:28:26 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH v2 01/13] net: fix fec_mpc52xx driver to use net_device_ops
To: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, olof@lixom.net
Date: Sat, 21 Mar 2009 16:28:16 -0600
Message-ID: <20090321222815.20493.68683.stgit@localhost.localdomain>
In-Reply-To: <20090321222047.20493.87335.stgit@localhost.localdomain>
References: <20090321222047.20493.87335.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: afleming@freescale.com, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Henk Stegeman <henk.stegeman@gmail.com>

Fix fec_mpc52xx driver to use net_device_ops and to be careful not to
dereference phy_device if a phy has not yet been connected.

Waiting for a signed-off-by line from Henk on this one

CC: Henk Stegeman <henk.stegeman@gmail.com>
---

 drivers/net/fec_mpc52xx.c |   47 ++++++++++++++++++++++++++++++++++-----------
 1 files changed, 36 insertions(+), 11 deletions(-)


diff --git a/drivers/net/fec_mpc52xx.c b/drivers/net/fec_mpc52xx.c
index 049b0a7..3d55f9a 100644
--- a/drivers/net/fec_mpc52xx.c
+++ b/drivers/net/fec_mpc52xx.c
@@ -847,24 +847,40 @@ static void mpc52xx_fec_get_drvinfo(struct net_device *dev,
 static int mpc52xx_fec_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
 {
 	struct mpc52xx_fec_priv *priv = netdev_priv(dev);
+
+	if (!priv->phydev)
+		return -ENODEV;
+
 	return phy_ethtool_gset(priv->phydev, cmd);
 }
 
 static int mpc52xx_fec_set_settings(struct net_device *dev, struct ethtool_cmd *cmd)
 {
 	struct mpc52xx_fec_priv *priv = netdev_priv(dev);
+
+	if (!priv->phydev)
+		return -ENODEV;
+
 	return phy_ethtool_sset(priv->phydev, cmd);
 }
 
 static u32 mpc52xx_fec_get_msglevel(struct net_device *dev)
 {
 	struct mpc52xx_fec_priv *priv = netdev_priv(dev);
+	
+	if (!priv->phydev)
+		return 0;
+
 	return priv->msg_enable;
 }
 
 static void mpc52xx_fec_set_msglevel(struct net_device *dev, u32 level)
 {
 	struct mpc52xx_fec_priv *priv = netdev_priv(dev);
+
+	if (!priv->phydev)
+		return;
+
 	priv->msg_enable = level;
 }
 
@@ -882,12 +898,31 @@ static int mpc52xx_fec_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
 	struct mpc52xx_fec_priv *priv = netdev_priv(dev);
 
+	if (!priv->phydev)
+		return -ENODEV;
+
 	return mpc52xx_fec_phy_mii_ioctl(priv, if_mii(rq), cmd);
 }
 
 /* ======================================================================== */
 /* OF Driver                                                                */
 /* ======================================================================== */
+static const struct net_device_ops mpc52xx_fec_netdev_ops = {
+	.ndo_open               = mpc52xx_fec_open,
+	.ndo_stop               = mpc52xx_fec_close,
+	.ndo_start_xmit         = mpc52xx_fec_hard_start_xmit,
+	.ndo_tx_timeout         = mpc52xx_fec_tx_timeout,
+	.ndo_get_stats          = mpc52xx_fec_get_stats,
+	.ndo_set_multicast_list = mpc52xx_fec_set_multicast_list,
+	.ndo_validate_addr      = eth_validate_addr,
+	.ndo_set_mac_address    = mpc52xx_fec_set_mac_address,
+	.ndo_do_ioctl           = mpc52xx_fec_ioctl,
+
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	.ndo_poll_controller     = mpc52xx_fec_poll_controller,
+#endif
+};
+
 
 static int __devinit
 mpc52xx_fec_probe(struct of_device *op, const struct of_device_id *match)
@@ -929,20 +964,10 @@ mpc52xx_fec_probe(struct of_device *op, const struct of_device_id *match)
 		return -EBUSY;
 
 	/* Init ether ndev with what we have */
-	ndev->open		= mpc52xx_fec_open;
-	ndev->stop		= mpc52xx_fec_close;
-	ndev->hard_start_xmit	= mpc52xx_fec_hard_start_xmit;
-	ndev->do_ioctl		= mpc52xx_fec_ioctl;
 	ndev->ethtool_ops	= &mpc52xx_fec_ethtool_ops;
-	ndev->get_stats		= mpc52xx_fec_get_stats;
-	ndev->set_mac_address	= mpc52xx_fec_set_mac_address;
-	ndev->set_multicast_list = mpc52xx_fec_set_multicast_list;
-	ndev->tx_timeout	= mpc52xx_fec_tx_timeout;
 	ndev->watchdog_timeo	= FEC_WATCHDOG_TIMEOUT;
 	ndev->base_addr		= mem.start;
-#ifdef CONFIG_NET_POLL_CONTROLLER
-	ndev->poll_controller = mpc52xx_fec_poll_controller;
-#endif
+	ndev->netdev_ops = &mpc52xx_fec_netdev_ops;
 
 	priv->t_irq = priv->r_irq = ndev->irq = NO_IRQ; /* IRQ are free for now */
 
