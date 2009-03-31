Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by ozlabs.org (Postfix) with ESMTP id 0F0CEDDE19
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 19:27:01 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id j37so1472031waf.9
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 01:27:01 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 03/14] net/fec_mpc52xx: Don't dereference phy_device if it is
	NULL
To: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
Date: Tue, 31 Mar 2009 02:26:59 -0600
Message-ID: <20090331082659.1427.83509.stgit@localhost.localdomain>
In-Reply-To: <20090331075537.1427.7819.stgit@localhost.localdomain>
References: <20090331075537.1427.7819.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: olof@lixom.net, afleming@freescale.com,
	Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

The FEC Ethernet device isn't always attached to a phy.  Be careful
not to dereference phy_device if it is NULL.

Reported-by: Henk Stegeman <henk.stegeman@gmail.com>
Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/net/fec_mpc52xx.c |   22 ++++++++++++----------
 1 files changed, 12 insertions(+), 10 deletions(-)


diff --git a/drivers/net/fec_mpc52xx.c b/drivers/net/fec_mpc52xx.c
index 75d0569..e10eb2c 100644
--- a/drivers/net/fec_mpc52xx.c
+++ b/drivers/net/fec_mpc52xx.c
@@ -271,15 +271,6 @@ static void mpc52xx_fec_phy_stop(struct net_device *dev)
 	phy_write(priv->phydev, MII_BMCR, BMCR_PDOWN);
 }
 
-static int mpc52xx_fec_phy_mii_ioctl(struct mpc52xx_fec_priv *priv,
-		struct mii_ioctl_data *mii_data, int cmd)
-{
-	if (!priv->phydev)
-		return -ENOTSUPP;
-
-	return phy_mii_ioctl(priv->phydev, mii_data, cmd);
-}
-
 static void mpc52xx_fec_phy_hw_init(struct mpc52xx_fec_priv *priv)
 {
 	struct mpc52xx_fec __iomem *fec = priv->fec;
@@ -852,12 +843,20 @@ static void mpc52xx_fec_get_drvinfo(struct net_device *dev,
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
 
@@ -887,7 +886,10 @@ static int mpc52xx_fec_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
 	struct mpc52xx_fec_priv *priv = netdev_priv(dev);
 
-	return mpc52xx_fec_phy_mii_ioctl(priv, if_mii(rq), cmd);
+	if (!priv->phydev)
+		return -ENOTSUPP;
+
+	return phy_mii_ioctl(priv->phydev, if_mii(rq), cmd);
 }
 
 static const struct net_device_ops mpc52xx_fec_netdev_ops = {
