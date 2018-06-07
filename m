Return-Path: <yangbo.lu@nxp.com>
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 411WBV2TL0zF324
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 13:25:06 +1000 (AEST)
From: Yangbo Lu <yangbo.lu@nxp.com>
To: netdev@vger.kernel.org, madalin.bucur@nxp.com,
 Richard Cochran <richardcochran@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 "David S . Miller" <davem@davemloft.net>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Yangbo Lu <yangbo.lu@nxp.com>
Subject: [v2, 10/10] dpaa_eth: add the get_ts_info interface for ethtool
Date: Thu,  7 Jun 2018 11:22:56 +0800
Message-Id: <20180607032256.39802-11-yangbo.lu@nxp.com>
In-Reply-To: <20180607032256.39802-1-yangbo.lu@nxp.com>
References: <20180607032256.39802-1-yangbo.lu@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Added the get_ts_info interface for ethtool to check
the timestamping capability.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v2:
	- Removed ifdef for hw timestamp.
---
 drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c |   39 ++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
index 2f933b6..3184c8f 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
@@ -32,6 +32,9 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/string.h>
+#include <linux/of_platform.h>
+#include <linux/net_tstamp.h>
+#include <linux/fsl/ptp_qoriq.h>
 
 #include "dpaa_eth.h"
 #include "mac.h"
@@ -515,6 +518,41 @@ static int dpaa_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
 	return ret;
 }
 
+static int dpaa_get_ts_info(struct net_device *net_dev,
+			    struct ethtool_ts_info *info)
+{
+	struct device *dev = net_dev->dev.parent;
+	struct device_node *mac_node = dev->of_node;
+	struct device_node *fman_node = NULL, *ptp_node = NULL;
+	struct platform_device *ptp_dev = NULL;
+	struct qoriq_ptp *ptp = NULL;
+
+	info->phc_index = -1;
+
+	fman_node = of_get_parent(mac_node);
+	if (fman_node)
+		ptp_node = of_parse_phandle(fman_node, "ptimer-handle", 0);
+
+	if (ptp_node)
+		ptp_dev = of_find_device_by_node(ptp_node);
+
+	if (ptp_dev)
+		ptp = platform_get_drvdata(ptp_dev);
+
+	if (ptp)
+		info->phc_index = ptp->phc_index;
+
+	info->so_timestamping = SOF_TIMESTAMPING_TX_HARDWARE |
+				SOF_TIMESTAMPING_RX_HARDWARE |
+				SOF_TIMESTAMPING_RAW_HARDWARE;
+	info->tx_types = (1 << HWTSTAMP_TX_OFF) |
+			 (1 << HWTSTAMP_TX_ON);
+	info->rx_filters = (1 << HWTSTAMP_FILTER_NONE) |
+			   (1 << HWTSTAMP_FILTER_ALL);
+
+	return 0;
+}
+
 const struct ethtool_ops dpaa_ethtool_ops = {
 	.get_drvinfo = dpaa_get_drvinfo,
 	.get_msglevel = dpaa_get_msglevel,
@@ -530,4 +568,5 @@ static int dpaa_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
 	.set_link_ksettings = dpaa_set_link_ksettings,
 	.get_rxnfc = dpaa_get_rxnfc,
 	.set_rxnfc = dpaa_set_rxnfc,
+	.get_ts_info = dpaa_get_ts_info,
 };
-- 
1.7.1
