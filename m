Return-Path: <richardcochran@gmail.com>
Date: Tue, 15 Jun 2010 18:07:46 +0200
From: Richard Cochran <richardcochran@gmail.com>
To: netdev@vger.kernel.org
Subject: [PATCH 02/12] phylib: do not filter phy_mii_ioctl()
Message-ID: <4cd127a2aa2c40a1b573e079e0624f10d1d94867.1276615626.git.richard.cochran@omicron.at>
References: <cover.1276615626.git.richard.cochran@omicron.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1276615626.git.richard.cochran@omicron.at>
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, Krzysztof Halasa <khc@pm.waw.pl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Two maverick drivers filter the ioctl commands passed to phy_mii_ioctl().
This is unnecessary since phylib will check the command in any case.

Signed-off-by: Richard Cochran <richard.cochran@omicron.at>
---
 drivers/net/cpmac.c              |    5 +----
 drivers/net/stmmac/stmmac_main.c |   22 ++++++++--------------
 2 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/net/cpmac.c b/drivers/net/cpmac.c
index d4c5ca4..0e47ca1 100644
--- a/drivers/net/cpmac.c
+++ b/drivers/net/cpmac.c
@@ -846,11 +846,8 @@ static int cpmac_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 		return -EINVAL;
 	if (!priv->phy)
 		return -EINVAL;
-	if ((cmd == SIOCGMIIPHY) || (cmd == SIOCGMIIREG) ||
-	    (cmd == SIOCSMIIREG))
-		return phy_mii_ioctl(priv->phy, ifr, cmd);
 
-	return -EOPNOTSUPP;
+	return phy_mii_ioctl(priv->phy, ifr, cmd);
 }
 
 static int cpmac_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
diff --git a/drivers/net/stmmac/stmmac_main.c b/drivers/net/stmmac/stmmac_main.c
index 6af7471..acf0616 100644
--- a/drivers/net/stmmac/stmmac_main.c
+++ b/drivers/net/stmmac/stmmac_main.c
@@ -1437,24 +1437,18 @@ static void stmmac_poll_controller(struct net_device *dev)
 static int stmmac_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
-	int ret = -EOPNOTSUPP;
+	int ret;
 
 	if (!netif_running(dev))
 		return -EINVAL;
 
-	switch (cmd) {
-	case SIOCGMIIPHY:
-	case SIOCGMIIREG:
-	case SIOCSMIIREG:
-		if (!priv->phydev)
-			return -EINVAL;
-
-		spin_lock(&priv->lock);
-		ret = phy_mii_ioctl(priv->phydev, rq, cmd);
-		spin_unlock(&priv->lock);
-	default:
-		break;
-	}
+	if (!priv->phydev)
+		return -EINVAL;
+
+	spin_lock(&priv->lock);
+	ret = phy_mii_ioctl(priv->phydev, rq, cmd);
+	spin_unlock(&priv->lock);
+
 	return ret;
 }
 
-- 
1.6.3.3
