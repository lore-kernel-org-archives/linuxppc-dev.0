Return-Path: <mirq@rere.qmqm.pl>
Received: from rere.qmqm.pl (rere.qmqm.pl [89.167.52.164])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "rere.qmqm.pl", Issuer "rere.qmqm.pl" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id AC823B6F16
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 11 Apr 2011 00:49:59 +1000 (EST)
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH RESENT] net: ps3_gelic: convert to hw_features
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: netdev@vger.kernel.org
In-Reply-To: <20110410144746.A28B11389B@rere.qmqm.pl>
Message-Id: <20110410144955.8620813909@rere.qmqm.pl>
Date: Sun, 10 Apr 2011 16:49:55 +0200 (CEST)
Cc: Geoff Levand <geoff@infradead.org>, cbe-oss-dev@lists.ozlabs.org,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
[untested]
[resent because of broken headers]

 drivers/net/ps3_gelic_net.c      |   26 +++++---------------------
 drivers/net/ps3_gelic_net.h      |    3 ---
 drivers/net/ps3_gelic_wireless.c |    4 ----
 3 files changed, 5 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ps3_gelic_net.c b/drivers/net/ps3_gelic_net.c
index 5ecfa4b..6c83ac6 100644
--- a/drivers/net/ps3_gelic_net.c
+++ b/drivers/net/ps3_gelic_net.c
@@ -951,7 +951,7 @@ static void gelic_net_pass_skb_up(struct gelic_descr *descr,
 	skb->protocol = eth_type_trans(skb, netdev);
 
 	/* checksum offload */
-	if (card->rx_csum) {
+	if (netdev->features & NETIF_F_RXCSUM) {
 		if ((data_status & GELIC_DESCR_DATA_STATUS_CHK_MASK) &&
 		    (!(data_error & GELIC_DESCR_DATA_ERROR_CHK_MASK)))
 			skb->ip_summed = CHECKSUM_UNNECESSARY;
@@ -1312,21 +1312,6 @@ static int gelic_ether_set_settings(struct net_device *netdev,
 	return 0;
 }
 
-u32 gelic_net_get_rx_csum(struct net_device *netdev)
-{
-	struct gelic_card *card = netdev_card(netdev);
-
-	return card->rx_csum;
-}
-
-int gelic_net_set_rx_csum(struct net_device *netdev, u32 data)
-{
-	struct gelic_card *card = netdev_card(netdev);
-
-	card->rx_csum = data;
-	return 0;
-}
-
 static void gelic_net_get_wol(struct net_device *netdev,
 			      struct ethtool_wolinfo *wol)
 {
@@ -1411,10 +1396,6 @@ static const struct ethtool_ops gelic_ether_ethtool_ops = {
 	.get_settings	= gelic_ether_get_settings,
 	.set_settings	= gelic_ether_set_settings,
 	.get_link	= ethtool_op_get_link,
-	.get_tx_csum	= ethtool_op_get_tx_csum,
-	.set_tx_csum	= ethtool_op_set_tx_csum,
-	.get_rx_csum	= gelic_net_get_rx_csum,
-	.set_rx_csum	= gelic_net_set_rx_csum,
 	.get_wol	= gelic_net_get_wol,
 	.set_wol	= gelic_net_set_wol,
 };
@@ -1512,7 +1493,11 @@ int __devinit gelic_net_setup_netdev(struct net_device *netdev,
 	int status;
 	u64 v1, v2;
 
+	netdev->hw_features = NETIF_F_IP_CSUM | NETIF_F_RXCSUM;
+
 	netdev->features = NETIF_F_IP_CSUM;
+	if (GELIC_CARD_RX_CSUM_DEFAULT)
+		netdev->features |= NETIF_F_RXCSUM;
 
 	status = lv1_net_control(bus_id(card), dev_id(card),
 				 GELIC_LV1_GET_MAC_ADDRESS,
@@ -1756,7 +1741,6 @@ static int __devinit ps3_gelic_driver_probe(struct ps3_system_bus_device *dev)
 	/* setup card structure */
 	card->irq_mask = GELIC_CARD_RXINT | GELIC_CARD_TXINT |
 		GELIC_CARD_PORT_STATUS_CHANGED;
-	card->rx_csum = GELIC_CARD_RX_CSUM_DEFAULT;
 
 
 	if (gelic_card_init_chain(card, &card->tx_chain,
diff --git a/drivers/net/ps3_gelic_net.h b/drivers/net/ps3_gelic_net.h
index 32521ae..50d8958 100644
--- a/drivers/net/ps3_gelic_net.h
+++ b/drivers/net/ps3_gelic_net.h
@@ -290,7 +290,6 @@ struct gelic_card {
 	struct gelic_descr_chain tx_chain;
 	struct gelic_descr_chain rx_chain;
 	int rx_dma_restart_required;
-	int rx_csum;
 	/*
 	 * tx_lock guards tx descriptor list and
 	 * tx_dma_progress.
@@ -377,8 +376,6 @@ extern int gelic_net_setup_netdev(struct net_device *netdev,
 /* shared ethtool ops */
 extern void gelic_net_get_drvinfo(struct net_device *netdev,
 				  struct ethtool_drvinfo *info);
-extern u32 gelic_net_get_rx_csum(struct net_device *netdev);
-extern int gelic_net_set_rx_csum(struct net_device *netdev, u32 data);
 extern void gelic_net_poll_controller(struct net_device *netdev);
 
 #endif /* _GELIC_NET_H */
diff --git a/drivers/net/ps3_gelic_wireless.c b/drivers/net/ps3_gelic_wireless.c
index 4a624a2..39a93e8 100644
--- a/drivers/net/ps3_gelic_wireless.c
+++ b/drivers/net/ps3_gelic_wireless.c
@@ -2581,10 +2581,6 @@ static const struct net_device_ops gelic_wl_netdevice_ops = {
 static const struct ethtool_ops gelic_wl_ethtool_ops = {
 	.get_drvinfo	= gelic_net_get_drvinfo,
 	.get_link	= gelic_wl_get_link,
-	.get_tx_csum	= ethtool_op_get_tx_csum,
-	.set_tx_csum	= ethtool_op_set_tx_csum,
-	.get_rx_csum	= gelic_net_get_rx_csum,
-	.set_rx_csum	= gelic_net_set_rx_csum,
 };
 
 static void __devinit gelic_wl_setup_netdev_ops(struct net_device *netdev)
-- 
1.7.2.5
