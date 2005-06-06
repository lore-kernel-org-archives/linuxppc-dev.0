Return-Path: <mporter@kernel.crashing.org>
Received: from zipcode.az.mvista.com (rav-az.mvista.com [65.200.49.157])
	by ozlabs.org (Postfix) with ESMTP id BFF54679FB
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Jun 2005 09:52:28 +1000 (EST)
In-Reply-To: <11181019442621@foobar.com>
Date: Mon, 6 Jun 2005 16:52:24 -0700
Message-Id: <11181019443007@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: akpm@osdl.org
From: Matt Porter <mporter@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH][RIO] -mm: rionet updates
Reply-To: Matt Porter <mporter@kernel.crashing.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Cleanups, eliminate unused paths, and add LLTX support.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

commit d651f0979ebfb203624159507a2b04ac896844ab
tree c9dffe54b25b6992025f074de1fe9901adc8d6ef
parent 7cfb63a2fce0dbb82507bb6035352df1718624f2
author Matt Porter <mporter@kernel.crashing.org> Mon, 06 Jun 2005 13:57:52 =
-0700
committer Matt Porter <mporter@kernel.crashing.org> Mon, 06 Jun 2005 13:57:=
52 -0700

 drivers/net/rionet.c |   73 ++++++++++++++++------------------------------=
----
 1 files changed, 24 insertions(+), 49 deletions(-)

diff --git a/drivers/net/rionet.c b/drivers/net/rionet.c
--- a/drivers/net/rionet.c
+++ b/drivers/net/rionet.c
@@ -42,7 +42,7 @@ MODULE_LICENSE("GPL");
 #define RIONET_TX_RING_SIZE	CONFIG_RIONET_TX_SIZE
 #define RIONET_RX_RING_SIZE	CONFIG_RIONET_RX_SIZE
=20
-LIST_HEAD(rionet_peers);
+static LIST_HEAD(rionet_peers);
=20
 struct rionet_private {
 	struct rio_mport *mport;
@@ -54,6 +54,7 @@ struct rionet_private {
 	int tx_cnt;
 	int ack_slot;
 	spinlock_t lock;
+	spinlock_t tx_lock;
 	u32 msg_enable;
 };
=20
@@ -112,9 +113,9 @@ static int rionet_rx_clean(struct net_de
=20
 		rnet->rx_skb[i]->data =3D data;
 		skb_put(rnet->rx_skb[i], RIO_MAX_MSG_SIZE);
-		rnet->rx_skb[i]->dev =3D sndev;
+		rnet->rx_skb[i]->dev =3D ndev;
 		rnet->rx_skb[i]->protocol =3D
-		    eth_type_trans(rnet->rx_skb[i], sndev);
+		    eth_type_trans(rnet->rx_skb[i], ndev);
 		error =3D netif_rx(rnet->rx_skb[i]);
=20
 		if (error =3D=3D NET_RX_DROP) {
@@ -183,13 +184,20 @@ static int rionet_start_xmit(struct sk_b
 	struct rionet_private *rnet =3D ndev->priv;
 	struct ethhdr *eth =3D (struct ethhdr *)skb->data;
 	u16 destid;
+	unsigned long flags;
=20
-	spin_lock_irq(&rnet->lock);
-
+	local_irq_save(flags);
+	if (!spin_trylock(&rnet->tx_lock)) {
+		local_irq_restore(flags);
+		return NETDEV_TX_LOCKED;
+	}
+=09
 	if ((rnet->tx_cnt + 1) > RIONET_TX_RING_SIZE) {
 		netif_stop_queue(ndev);
-		spin_unlock_irq(&rnet->lock);
-		return -EBUSY;
+		spin_unlock_irqrestore(&rnet->tx_lock, flags);
+		printk(KERN_ERR "%s: BUG! Tx Ring full when queue awake!\n",
+		       ndev->name);
+		return NETDEV_TX_BUSY;
 	}
=20
 	if (eth->h_dest[0] & 0x01) {
@@ -211,7 +219,7 @@ static int rionet_start_xmit(struct sk_b
 			rionet_queue_tx_msg(skb, ndev, rionet_active[destid]);
 	}
=20
-	spin_unlock_irq(&rnet->lock);
+	spin_unlock_irqrestore(&rnet->tx_lock, flags);
=20
 	return 0;
 }
@@ -228,27 +236,6 @@ static int rionet_set_mac_address(struct
 	return 0;
 }
=20
-static int rionet_change_mtu(struct net_device *ndev, int new_mtu)
-{
-	struct rionet_private *rnet =3D ndev->priv;
-
-	if (netif_msg_drv(rnet))
-		printk(KERN_WARNING
-		       "%s: rionet_change_mtu(): not implemented\n", DRV_NAME);
-
-	return 0;
-}
-
-static void rionet_set_multicast_list(struct net_device *ndev)
-{
-	struct rionet_private *rnet =3D ndev->priv;
-
-	if (netif_msg_drv(rnet))
-		printk(KERN_WARNING
-		       "%s: rionet_set_multicast_list(): not implemented\n",
-		       DRV_NAME);
-}
-
 static void rionet_dbell_event(struct rio_mport *mport, u16 sid, u16 tid,
 			       u16 info)
 {
@@ -358,10 +345,6 @@ static int rionet_open(struct net_device
 	rnet->tx_cnt =3D 0;
 	rnet->ack_slot =3D 0;
=20
-	spin_lock_init(&rnet->lock);
-
-	rnet->msg_enable =3D RIONET_DEFAULT_MSGLEVEL;
-
 	netif_carrier_on(ndev);
 	netif_start_queue(ndev);
=20
@@ -434,11 +417,6 @@ static void rionet_remove(struct rio_dev
 	}
 }
=20
-static int rionet_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
-{
-	return -EOPNOTSUPP;
-}
-
 static void rionet_get_drvinfo(struct net_device *ndev,
 			       struct ethtool_drvinfo *info)
 {
@@ -464,16 +442,11 @@ static void rionet_set_msglevel(struct n
 	rnet->msg_enable =3D value;
 }
=20
-static u32 rionet_get_link(struct net_device *ndev)
-{
-	return netif_carrier_ok(ndev);
-}
-
 static struct ethtool_ops rionet_ethtool_ops =3D {
 	.get_drvinfo =3D rionet_get_drvinfo,
 	.get_msglevel =3D rionet_get_msglevel,
 	.set_msglevel =3D rionet_set_msglevel,
-	.get_link =3D rionet_get_link,
+	.get_link =3D ethtool_op_get_link,
 };
=20
 static int rionet_setup_netdev(struct rio_mport *mport)
@@ -517,16 +490,18 @@ static int rionet_setup_netdev(struct ri
 	ndev->hard_start_xmit =3D &rionet_start_xmit;
 	ndev->stop =3D &rionet_close;
 	ndev->get_stats =3D &rionet_stats;
-	ndev->change_mtu =3D &rionet_change_mtu;
 	ndev->set_mac_address =3D &rionet_set_mac_address;
-	ndev->set_multicast_list =3D &rionet_set_multicast_list;
-	ndev->do_ioctl =3D &rionet_ioctl;
-	SET_ETHTOOL_OPS(ndev, &rionet_ethtool_ops);
-
 	ndev->mtu =3D RIO_MAX_MSG_SIZE - 14;
+	ndev->features =3D NETIF_F_LLTX;
+	SET_ETHTOOL_OPS(ndev, &rionet_ethtool_ops);
=20
 	SET_MODULE_OWNER(ndev);
=20
+	spin_lock_init(&rnet->lock);
+	spin_lock_init(&rnet->tx_lock);
+
+	rnet->msg_enable =3D RIONET_DEFAULT_MSGLEVEL;
+
 	rc =3D register_netdev(ndev);
 	if (rc !=3D 0)
 		goto out;
