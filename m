Return-Path: <joe@perches.com>
Received: from labridge.com (perches-mx.perches.com [206.117.179.246])
 (using SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D068A2C0162
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Apr 2013 16:03:46 +1000 (EST)
From: Joe Perches <joe@perches.com>
To: netdev@vger.kernel.org
Subject: [PATCH 2/3] gianfar: Use netdev_<level> when possible
Date: Sat, 13 Apr 2013 22:03:18 -0700
Message-Id: <e26dff17039c6c07cad3c19e3d9af6dee7d66471.1365915548.git.joe@perches.com>
In-Reply-To: <cover.1365915548.git.joe@perches.com>
References: <cover.1365915548.git.joe@perches.com>
Cc: linuxppc-dev@lists.ozlabs.org, Richard Cochran <richardcochran@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use a more current logging style.

Convert pr_<level> to netdev_<level> when a struct net_device is
available.  Add pr_fmt and neaten other formats too.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/net/ethernet/freescale/gianfar_ethtool.c | 24 +++++++++++++-----------
 drivers/net/ethernet/freescale/gianfar_ptp.c     |  3 +++
 drivers/net/ethernet/freescale/gianfar_sysfs.c   |  2 +-
 3 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/freescale/gianfar_ethtool.c b/drivers/net/ethernet/freescale/gianfar_ethtool.c
index 4e7118f..083603f 100644
--- a/drivers/net/ethernet/freescale/gianfar_ethtool.c
+++ b/drivers/net/ethernet/freescale/gianfar_ethtool.c
@@ -389,14 +389,14 @@ static int gfar_scoalesce(struct net_device *dev,
 
 	/* Check the bounds of the values */
 	if (cvals->rx_coalesce_usecs > GFAR_MAX_COAL_USECS) {
-		pr_info("Coalescing is limited to %d microseconds\n",
-			GFAR_MAX_COAL_USECS);
+		netdev_info(dev, "Coalescing is limited to %d microseconds\n",
+			    GFAR_MAX_COAL_USECS);
 		return -EINVAL;
 	}
 
 	if (cvals->rx_max_coalesced_frames > GFAR_MAX_COAL_FRAMES) {
-		pr_info("Coalescing is limited to %d frames\n",
-			GFAR_MAX_COAL_FRAMES);
+		netdev_info(dev, "Coalescing is limited to %d frames\n",
+			    GFAR_MAX_COAL_FRAMES);
 		return -EINVAL;
 	}
 
@@ -418,14 +418,14 @@ static int gfar_scoalesce(struct net_device *dev,
 
 	/* Check the bounds of the values */
 	if (cvals->tx_coalesce_usecs > GFAR_MAX_COAL_USECS) {
-		pr_info("Coalescing is limited to %d microseconds\n",
-			GFAR_MAX_COAL_USECS);
+		netdev_info(dev, "Coalescing is limited to %d microseconds\n",
+			    GFAR_MAX_COAL_USECS);
 		return -EINVAL;
 	}
 
 	if (cvals->tx_max_coalesced_frames > GFAR_MAX_COAL_FRAMES) {
-		pr_info("Coalescing is limited to %d frames\n",
-			GFAR_MAX_COAL_FRAMES);
+		netdev_info(dev, "Coalescing is limited to %d frames\n",
+			    GFAR_MAX_COAL_FRAMES);
 		return -EINVAL;
 	}
 
@@ -735,7 +735,8 @@ static int gfar_ethflow_to_filer_table(struct gfar_private *priv, u64 ethflow,
 		cmp_rqfpr = RQFPR_IPV6 |RQFPR_UDP;
 		break;
 	default:
-		pr_err("Right now this class is not supported\n");
+		netdev_err(priv->ndev,
+			   "Right now this class is not supported\n");
 		ret = 0;
 		goto err;
 	}
@@ -751,7 +752,8 @@ static int gfar_ethflow_to_filer_table(struct gfar_private *priv, u64 ethflow,
 	}
 
 	if (i == MAX_FILER_IDX + 1) {
-		pr_err("No parse rule found, can't create hash rules\n");
+		netdev_err(priv->ndev,
+			   "No parse rule found, can't create hash rules\n");
 		ret = 0;
 		goto err;
 	}
@@ -1568,7 +1570,7 @@ static int gfar_process_filer_changes(struct gfar_private *priv)
 	gfar_cluster_filer(tab);
 	gfar_optimize_filer_masks(tab);
 
-	pr_debug("\n\tSummary:\n"
+	pr_debug("\tSummary:\n"
 		 "\tData on hardware: %d\n"
 		 "\tCompression rate: %d%%\n",
 		 tab->index, 100 - (100 * tab->index) / i);
diff --git a/drivers/net/ethernet/freescale/gianfar_ptp.c b/drivers/net/ethernet/freescale/gianfar_ptp.c
index 2e5daee..fe8e9e5 100644
--- a/drivers/net/ethernet/freescale/gianfar_ptp.c
+++ b/drivers/net/ethernet/freescale/gianfar_ptp.c
@@ -17,6 +17,9 @@
  *  along with this program; if not, write to the Free Software
  *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/device.h>
 #include <linux/hrtimer.h>
 #include <linux/init.h>
diff --git a/drivers/net/ethernet/freescale/gianfar_sysfs.c b/drivers/net/ethernet/freescale/gianfar_sysfs.c
index cd14a4d..acb55af 100644
--- a/drivers/net/ethernet/freescale/gianfar_sysfs.c
+++ b/drivers/net/ethernet/freescale/gianfar_sysfs.c
@@ -337,5 +337,5 @@ void gfar_init_sysfs(struct net_device *dev)
 	rc |= device_create_file(&dev->dev, &dev_attr_fifo_starve);
 	rc |= device_create_file(&dev->dev, &dev_attr_fifo_starve_off);
 	if (rc)
-		dev_err(&dev->dev, "Error creating gianfar sysfs files.\n");
+		dev_err(&dev->dev, "Error creating gianfar sysfs files\n");
 }
-- 
1.8.1.2.459.gbcd45b4.dirty
