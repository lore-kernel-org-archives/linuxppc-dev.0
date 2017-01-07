Return-Path: <tremyfr@gmail.com>
Received: from mail-wm0-x243.google.com (mail-wm0-x243.google.com
 [IPv6:2a00:1450:400c:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3twvpd3XVhzDqTr
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 Jan 2017 08:35:21 +1100 (AEDT)
Received: by mail-wm0-x243.google.com with SMTP id l2so12943463wml.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Jan 2017 13:35:21 -0800 (PST)
From: Philippe Reynes <tremyfr@gmail.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 tlfalcon@linux.vnet.ibm.com, davem@davemloft.net
Cc: linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Philippe Reynes <tremyfr@gmail.com>
Subject: [PATCH] net: ibm: ibmveth: use new api
 ethtool_{get|set}_link_ksettings
Date: Sat,  7 Jan 2017 22:35:13 +0100
Message-Id: <1483824913-6989-1-git-send-email-tremyfr@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The ethtool api {get|set}_settings is deprecated.
We move this driver to new api {get|set}_link_ksettings.

Signed-off-by: Philippe Reynes <tremyfr@gmail.com>
---
 drivers/net/ethernet/ibm/ibmveth.c |   30 ++++++++++++++++++------------
 1 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index a831f94..c6ba75c 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -729,20 +729,26 @@ static int ibmveth_close(struct net_device *netdev)
 	return 0;
 }
 
-static int netdev_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
+static int netdev_get_link_ksettings(struct net_device *dev,
+				     struct ethtool_link_ksettings *cmd)
 {
-	cmd->supported = (SUPPORTED_1000baseT_Full | SUPPORTED_Autoneg |
+	u32 supported, advertising;
+
+	supported = (SUPPORTED_1000baseT_Full | SUPPORTED_Autoneg |
 				SUPPORTED_FIBRE);
-	cmd->advertising = (ADVERTISED_1000baseT_Full | ADVERTISED_Autoneg |
+	advertising = (ADVERTISED_1000baseT_Full | ADVERTISED_Autoneg |
 				ADVERTISED_FIBRE);
-	ethtool_cmd_speed_set(cmd, SPEED_1000);
-	cmd->duplex = DUPLEX_FULL;
-	cmd->port = PORT_FIBRE;
-	cmd->phy_address = 0;
-	cmd->transceiver = XCVR_INTERNAL;
-	cmd->autoneg = AUTONEG_ENABLE;
-	cmd->maxtxpkt = 0;
-	cmd->maxrxpkt = 1;
+	cmd->base.speed = SPEED_1000;
+	cmd->base.duplex = DUPLEX_FULL;
+	cmd->base.port = PORT_FIBRE;
+	cmd->base.phy_address = 0;
+	cmd->base.autoneg = AUTONEG_ENABLE;
+
+	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
+						supported);
+	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
+						advertising);
+
 	return 0;
 }
 
@@ -978,11 +984,11 @@ static void ibmveth_get_ethtool_stats(struct net_device *dev,
 
 static const struct ethtool_ops netdev_ethtool_ops = {
 	.get_drvinfo		= netdev_get_drvinfo,
-	.get_settings		= netdev_get_settings,
 	.get_link		= ethtool_op_get_link,
 	.get_strings		= ibmveth_get_strings,
 	.get_sset_count		= ibmveth_get_sset_count,
 	.get_ethtool_stats	= ibmveth_get_ethtool_stats,
+	.get_link_ksettings	= netdev_get_link_ksettings,
 };
 
 static int ibmveth_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
-- 
1.7.4.4
