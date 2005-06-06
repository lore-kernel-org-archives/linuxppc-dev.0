Return-Path: <mporter@kernel.crashing.org>
Received: from zipcode.az.mvista.com (rav-az.mvista.com [65.200.49.157])
	by ozlabs.org (Postfix) with ESMTP id B4D7967A2C
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Jun 2005 09:12:56 +1000 (EST)
In-Reply-To: <11180976151080@foobar.com>
Date: Mon, 6 Jun 2005 15:40:15 -0700
Message-Id: <1118097615222@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: linux-kernel@vger.kernel.org
From: Matt Porter <mporter@kernel.crashing.org>
Cc: netdev@oss.sgi.com, shemminger@osdl.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH][5/5] RapidIO support: net driver
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

Adds an "Ethernet" driver which sends Ethernet packets over the
standard RapidIO messaging. This depends on the core RIO
patch for mailbox/doorbell access.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -2185,6 +2185,20 @@ config ISERIES_VETH
 	tristate "iSeries Virtual Ethernet driver support"
 	depends on NETDEVICES && PPC_ISERIES
=20
+config RIONET
+	tristate "RapidIO Ethernet over messaging driver support"
+	depends on NETDEVICES && RAPIDIO
+
+config RIONET_TX_SIZE
+	int "Number of outbound queue entries"
+	depends on RIONET
+	default "128"
+
+config RIONET_RX_SIZE
+	int "Number of inbound queue entries"
+	depends on RIONET
+	default "128"
+
 config FDDI
 	bool "FDDI driver support"
 	depends on NETDEVICES && (PCI || EISA)
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -58,6 +58,7 @@ obj-$(CONFIG_SKFP) +=3D skfp/
 obj-$(CONFIG_VIA_RHINE) +=3D via-rhine.o
 obj-$(CONFIG_VIA_VELOCITY) +=3D via-velocity.o
 obj-$(CONFIG_ADAPTEC_STARFIRE) +=3D starfire.o
+obj-$(CONFIG_RIONET) +=3D rionet.o
=20
 #
 # end link order section
diff --git a/drivers/net/rionet.c b/drivers/net/rionet.c
new file mode 100644
--- /dev/null
+++ b/drivers/net/rionet.c
@@ -0,0 +1,597 @@
+/*
+ * rionet - Ethernet driver over RapidIO messaging services
+ *
+ * Copyright 2005 MontaVista Software, Inc.
+ * Matt Porter <mporter@kernel.crashing.org>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/dma-mapping.h>
+#include <linux/delay.h>
+#include <linux/rio.h>
+#include <linux/rio_drv.h>
+#include <linux/rio_ids.h>
+
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/skbuff.h>
+#include <linux/crc32.h>
+#include <linux/ethtool.h>
+
+#define DRV_NAME        "rionet"
+#define DRV_VERSION     "0.1"
+#define DRV_AUTHOR      "Matt Porter <mporter@kernel.crashing.org>"
+#define DRV_DESC        "Ethernet over RapidIO"
+
+MODULE_AUTHOR(DRV_AUTHOR);
+MODULE_DESCRIPTION(DRV_DESC);
+MODULE_LICENSE("GPL");
+
+#define RIONET_DEFAULT_MSGLEVEL	0
+#define RIONET_DOORBELL_JOIN	0x1000
+#define RIONET_DOORBELL_LEAVE	0x1001
+
+#define RIONET_MAILBOX		0
+
+#define RIONET_TX_RING_SIZE	CONFIG_RIONET_TX_SIZE
+#define RIONET_RX_RING_SIZE	CONFIG_RIONET_RX_SIZE
+
+static LIST_HEAD(rionet_peers);
+
+struct rionet_private {
+	struct rio_mport *mport;
+	struct sk_buff *rx_skb[RIONET_RX_RING_SIZE];
+	struct sk_buff *tx_skb[RIONET_TX_RING_SIZE];
+	struct net_device_stats stats;
+	int rx_slot;
+	int tx_slot;
+	int tx_cnt;
+	int ack_slot;
+	spinlock_t lock;
+	spinlock_t tx_lock;
+	u32 msg_enable;
+};
+
+struct rionet_peer {
+	struct list_head node;
+	struct rio_dev *rdev;
+	struct resource *res;
+};
+
+static int rionet_check =3D 0;
+static int rionet_capable =3D 1;
+static struct net_device *sndev =3D NULL;
+
+/*
+ * This is a fast lookup table for for translating TX
+ * Ethernet packets into a destination RIO device. It
+ * could be made into a hash table to save memory depending
+ * on system trade-offs.
+ */
+static struct rio_dev *rionet_active[RIO_MAX_ROUTE_ENTRIES];
+
+#define is_rionet_capable(pef, src_ops, dst_ops)		\
+			((pef & RIO_PEF_INB_MBOX) &&		\
+			 (pef & RIO_PEF_INB_DOORBELL) &&	\
+			 (src_ops & RIO_SRC_OPS_DOORBELL) &&	\
+			 (dst_ops & RIO_DST_OPS_DOORBELL))
+#define dev_rionet_capable(dev) \
+	is_rionet_capable(dev->pef, dev->src_ops, dev->dst_ops)
+
+#define RIONET_MAC_MATCH(x)	(*(u32 *)x =3D=3D 0x00010001)
+#define RIONET_GET_DESTID(x)	(*(u16 *)(x + 4))
+
+static struct net_device_stats *rionet_stats(struct net_device *ndev)
+{
+	struct rionet_private *rnet =3D ndev->priv;
+	return &rnet->stats;
+}
+
+static int rionet_rx_clean(struct net_device *ndev)
+{
+	int i;
+	int error =3D 0;
+	struct rionet_private *rnet =3D ndev->priv;
+	void *data;
+
+	i =3D rnet->rx_slot;
+
+	do {
+		if (!rnet->rx_skb[i]) {
+			rnet->stats.rx_dropped++;
+			continue;
+		}
+
+		if (!(data =3D rio_get_inb_message(rnet->mport, RIONET_MAILBOX)))
+			break;
+
+		rnet->rx_skb[i]->data =3D data;
+		skb_put(rnet->rx_skb[i], RIO_MAX_MSG_SIZE);
+		rnet->rx_skb[i]->dev =3D ndev;
+		rnet->rx_skb[i]->protocol =3D
+		    eth_type_trans(rnet->rx_skb[i], ndev);
+		error =3D netif_rx(rnet->rx_skb[i]);
+
+		if (error =3D=3D NET_RX_DROP) {
+			rnet->stats.rx_dropped++;
+		} else if (error =3D=3D NET_RX_BAD) {
+			if (netif_msg_rx_err(rnet))
+				printk(KERN_WARNING "%s: bad rx packet\n",
+				       DRV_NAME);
+			rnet->stats.rx_errors++;
+		} else {
+			rnet->stats.rx_packets++;
+			rnet->stats.rx_bytes +=3D RIO_MAX_MSG_SIZE;
+		}
+
+	} while ((i =3D (i + 1) % RIONET_RX_RING_SIZE) !=3D rnet->rx_slot);
+
+	return i;
+}
+
+static void rionet_rx_fill(struct net_device *ndev, int end)
+{
+	int i;
+	struct rionet_private *rnet =3D ndev->priv;
+
+	i =3D rnet->rx_slot;
+	do {
+		rnet->rx_skb[i] =3D dev_alloc_skb(RIO_MAX_MSG_SIZE);
+
+		if (!rnet->rx_skb[i])
+			break;
+
+		rio_add_inb_buffer(rnet->mport, RIONET_MAILBOX,
+				   rnet->rx_skb[i]->data);
+	} while ((i =3D (i + 1) % RIONET_RX_RING_SIZE) !=3D end);
+
+	rnet->rx_slot =3D i;
+}
+
+static int rionet_queue_tx_msg(struct sk_buff *skb, struct net_device *nde=
v,
+			       struct rio_dev *rdev)
+{
+	struct rionet_private *rnet =3D ndev->priv;
+
+	rio_add_outb_message(rnet->mport, rdev, 0, skb->data, skb->len);
+	rnet->tx_skb[rnet->tx_slot] =3D skb;
+
+	rnet->stats.tx_packets++;
+	rnet->stats.tx_bytes +=3D skb->len;
+
+	if (++rnet->tx_cnt =3D=3D RIONET_TX_RING_SIZE)
+		netif_stop_queue(ndev);
+
+	if (++rnet->tx_slot =3D=3D RIONET_TX_RING_SIZE)
+		rnet->tx_slot =3D 0;
+
+	if (netif_msg_tx_queued(rnet))
+		printk(KERN_INFO "%s: queued skb %8.8x len %8.8x\n", DRV_NAME,
+		       (u32) skb, skb->len);
+
+	return 0;
+}
+
+static int rionet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+{
+	int i;
+	struct rionet_private *rnet =3D ndev->priv;
+	struct ethhdr *eth =3D (struct ethhdr *)skb->data;
+	u16 destid;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	if (!spin_trylock(&rnet->tx_lock)) {
+		local_irq_restore(flags);
+		return NETDEV_TX_LOCKED;
+	}
+=09
+	if ((rnet->tx_cnt + 1) > RIONET_TX_RING_SIZE) {
+		netif_stop_queue(ndev);
+		spin_unlock_irqrestore(&rnet->tx_lock, flags);
+		printk(KERN_ERR "%s: BUG! Tx Ring full when queue awake!\n",
+		       ndev->name);
+		return NETDEV_TX_BUSY;
+	}
+
+	if (eth->h_dest[0] & 0x01) {
+		/*
+		 * XXX Need to delay queuing if ring max is reached,
+		 * flush additional packets in tx_event() before
+		 * awakening the queue. We can easily exceed ring
+		 * size with a large number of nodes or even a
+		 * small number where the ring is relatively full
+		 * on entrance to hard_start_xmit.
+		 */
+		for (i =3D 0; i < RIO_MAX_ROUTE_ENTRIES; i++)
+			if (rionet_active[i])
+				rionet_queue_tx_msg(skb, ndev,
+						    rionet_active[i]);
+	} else if (RIONET_MAC_MATCH(eth->h_dest)) {
+		destid =3D RIONET_GET_DESTID(eth->h_dest);
+		if (rionet_active[destid])
+			rionet_queue_tx_msg(skb, ndev, rionet_active[destid]);
+	}
+
+	spin_unlock_irqrestore(&rnet->tx_lock, flags);
+
+	return 0;
+}
+
+static int rionet_set_mac_address(struct net_device *ndev, void *p)
+{
+	struct sockaddr *addr =3D p;
+
+	if (!is_valid_ether_addr(addr->sa_data))
+		return -EADDRNOTAVAIL;
+
+	memcpy(ndev->dev_addr, addr->sa_data, ndev->addr_len);
+
+	return 0;
+}
+
+static void rionet_dbell_event(struct rio_mport *mport, u16 sid, u16 tid,
+			       u16 info)
+{
+	struct net_device *ndev =3D sndev;
+	struct rionet_private *rnet =3D ndev->priv;
+	struct rionet_peer *peer;
+
+	if (netif_msg_intr(rnet))
+		printk(KERN_INFO "%s: doorbell sid %4.4x tid %4.4x info %4.4x",
+		       DRV_NAME, sid, tid, info);
+	if (info =3D=3D RIONET_DOORBELL_JOIN) {
+		if (!rionet_active[sid]) {
+			list_for_each_entry(peer, &rionet_peers, node) {
+				if (peer->rdev->destid =3D=3D sid)
+					rionet_active[sid] =3D peer->rdev;
+			}
+			rio_mport_send_doorbell(mport, sid,
+						RIONET_DOORBELL_JOIN);
+		}
+	} else if (info =3D=3D RIONET_DOORBELL_LEAVE) {
+		rionet_active[sid] =3D NULL;
+	} else {
+		if (netif_msg_intr(rnet))
+			printk(KERN_WARNING "%s: unhandled doorbell\n",
+			       DRV_NAME);
+	}
+}
+
+static void rionet_inb_msg_event(struct rio_mport *mport, int mbox, int sl=
ot)
+{
+	int n;
+	struct net_device *ndev =3D sndev;
+	struct rionet_private *rnet =3D (struct rionet_private *)ndev->priv;
+
+	if (netif_msg_intr(rnet))
+		printk(KERN_INFO "%s: inbound message event, mbox %d slot %d\n",
+		       DRV_NAME, mbox, slot);
+
+	spin_lock(&rnet->lock);
+	if ((n =3D rionet_rx_clean(ndev)) !=3D rnet->rx_slot)
+		rionet_rx_fill(ndev, n);
+	spin_unlock(&rnet->lock);
+}
+
+static void rionet_outb_msg_event(struct rio_mport *mport, int mbox, int s=
lot)
+{
+	struct net_device *ndev =3D sndev;
+	struct rionet_private *rnet =3D ndev->priv;
+
+	spin_lock(&rnet->lock);
+
+	if (netif_msg_intr(rnet))
+		printk(KERN_INFO
+		       "%s: outbound message event, mbox %d slot %d\n",
+		       DRV_NAME, mbox, slot);
+
+	while (rnet->tx_cnt && (rnet->ack_slot !=3D slot)) {
+		/* dma unmap single */
+		dev_kfree_skb_irq(rnet->tx_skb[rnet->ack_slot]);
+		rnet->tx_skb[rnet->ack_slot] =3D NULL;
+		if (++rnet->ack_slot =3D=3D RIONET_TX_RING_SIZE)
+			rnet->ack_slot =3D 0;
+		rnet->tx_cnt--;
+	}
+
+	if (rnet->tx_cnt < RIONET_TX_RING_SIZE)
+		netif_wake_queue(ndev);
+
+	spin_unlock(&rnet->lock);
+}
+
+static int rionet_open(struct net_device *ndev)
+{
+	int i, rc =3D 0;
+	struct rionet_peer *peer, *tmp;
+	u32 pwdcsr;
+	struct rionet_private *rnet =3D ndev->priv;
+
+	if (netif_msg_ifup(rnet))
+		printk(KERN_INFO "%s: open\n", DRV_NAME);
+
+	if ((rc =3D rio_request_inb_dbell(rnet->mport,
+					RIONET_DOORBELL_JOIN,
+					RIONET_DOORBELL_LEAVE,
+					rionet_dbell_event)) < 0)
+		goto out;
+
+	if ((rc =3D rio_request_inb_mbox(rnet->mport,
+				       RIONET_MAILBOX,
+				       RIONET_RX_RING_SIZE,
+				       rionet_inb_msg_event)) < 0)
+		goto out;
+
+	if ((rc =3D rio_request_outb_mbox(rnet->mport,
+					RIONET_MAILBOX,
+					RIONET_TX_RING_SIZE,
+					rionet_outb_msg_event)) < 0)
+		goto out;
+
+	/* Initialize inbound message ring */
+	for (i =3D 0; i < RIONET_RX_RING_SIZE; i++)
+		rnet->rx_skb[i] =3D NULL;
+	rnet->rx_slot =3D 0;
+	rionet_rx_fill(ndev, 0);
+
+	rnet->tx_slot =3D 0;
+	rnet->tx_cnt =3D 0;
+	rnet->ack_slot =3D 0;
+
+	netif_carrier_on(ndev);
+	netif_start_queue(ndev);
+
+	list_for_each_entry_safe(peer, tmp, &rionet_peers, node) {
+		if (!(peer->res =3D rio_request_outb_dbell(peer->rdev,
+							 RIONET_DOORBELL_JOIN,
+							 RIONET_DOORBELL_LEAVE)))
+		{
+			printk(KERN_ERR "%s: error requesting doorbells\n",
+			       DRV_NAME);
+			continue;
+		}
+
+		/*
+		 * If device has initialized inbound doorbells,
+		 * send a join message
+		 */
+		rio_read_config_32(peer->rdev, RIO_WRITE_PORT_CSR, &pwdcsr);
+		if (pwdcsr & RIO_DOORBELL_AVAIL)
+			rio_send_doorbell(peer->rdev, RIONET_DOORBELL_JOIN);
+	}
+
+      out:
+	return rc;
+}
+
+static int rionet_close(struct net_device *ndev)
+{
+	struct rionet_private *rnet =3D (struct rionet_private *)ndev->priv;
+	struct rionet_peer *peer, *tmp;
+	int i;
+
+	if (netif_msg_ifup(rnet))
+		printk(KERN_INFO "%s: close\n", DRV_NAME);
+
+	netif_stop_queue(ndev);
+	netif_carrier_off(ndev);
+
+	for (i =3D 0; i < RIONET_RX_RING_SIZE; i++)
+		if (rnet->rx_skb[i])
+			kfree_skb(rnet->rx_skb[i]);
+
+	list_for_each_entry_safe(peer, tmp, &rionet_peers, node) {
+		if (rionet_active[peer->rdev->destid]) {
+			rio_send_doorbell(peer->rdev, RIONET_DOORBELL_LEAVE);
+			rionet_active[peer->rdev->destid] =3D NULL;
+		}
+		rio_release_outb_dbell(peer->rdev, peer->res);
+	}
+
+	rio_release_inb_dbell(rnet->mport, RIONET_DOORBELL_JOIN,
+			      RIONET_DOORBELL_LEAVE);
+	rio_release_inb_mbox(rnet->mport, RIONET_MAILBOX);
+	rio_release_outb_mbox(rnet->mport, RIONET_MAILBOX);
+
+	return 0;
+}
+
+static void rionet_remove(struct rio_dev *rdev)
+{
+	struct net_device *ndev =3D NULL;
+	struct rionet_peer *peer, *tmp;
+
+	unregister_netdev(ndev);
+	kfree(ndev);
+
+	list_for_each_entry_safe(peer, tmp, &rionet_peers, node) {
+		list_del(&peer->node);
+		kfree(peer);
+	}
+}
+
+static void rionet_get_drvinfo(struct net_device *ndev,
+			       struct ethtool_drvinfo *info)
+{
+	struct rionet_private *rnet =3D ndev->priv;
+
+	strcpy(info->driver, DRV_NAME);
+	strcpy(info->version, DRV_VERSION);
+	strcpy(info->fw_version, "n/a");
+	sprintf(info->bus_info, "RIO master port %d", rnet->mport->id);
+}
+
+static u32 rionet_get_msglevel(struct net_device *ndev)
+{
+	struct rionet_private *rnet =3D ndev->priv;
+
+	return rnet->msg_enable;
+}
+
+static void rionet_set_msglevel(struct net_device *ndev, u32 value)
+{
+	struct rionet_private *rnet =3D ndev->priv;
+
+	rnet->msg_enable =3D value;
+}
+
+static struct ethtool_ops rionet_ethtool_ops =3D {
+	.get_drvinfo =3D rionet_get_drvinfo,
+	.get_msglevel =3D rionet_get_msglevel,
+	.set_msglevel =3D rionet_set_msglevel,
+	.get_link =3D ethtool_op_get_link,
+};
+
+static int rionet_setup_netdev(struct rio_mport *mport)
+{
+	int rc =3D 0;
+	struct net_device *ndev =3D NULL;
+	struct rionet_private *rnet;
+	u16 device_id;
+
+	/* Allocate our net_device structure */
+	ndev =3D alloc_etherdev(sizeof(struct rionet_private));
+	if (ndev =3D=3D NULL) {
+		printk(KERN_INFO "%s: could not allocate ethernet device.\n",
+		       DRV_NAME);
+		rc =3D -ENOMEM;
+		goto out;
+	}
+
+	/*
+	 * XXX hack, store point a static at ndev so we can get it...
+	 * Perhaps need an array of these that the handler can
+	 * index via the mbox number.
+	 */
+	sndev =3D ndev;
+
+	/* Set up private area */
+	rnet =3D (struct rionet_private *)ndev->priv;
+	rnet->mport =3D mport;
+
+	/* Set the default MAC address */
+	device_id =3D rio_local_get_device_id(mport);
+	ndev->dev_addr[0] =3D 0x00;
+	ndev->dev_addr[1] =3D 0x01;
+	ndev->dev_addr[2] =3D 0x00;
+	ndev->dev_addr[3] =3D 0x01;
+	ndev->dev_addr[4] =3D device_id >> 8;
+	ndev->dev_addr[5] =3D device_id & 0xff;
+
+	/* Fill in the driver function table */
+	ndev->open =3D &rionet_open;
+	ndev->hard_start_xmit =3D &rionet_start_xmit;
+	ndev->stop =3D &rionet_close;
+	ndev->get_stats =3D &rionet_stats;
+	ndev->set_mac_address =3D &rionet_set_mac_address;
+	ndev->mtu =3D RIO_MAX_MSG_SIZE - 14;
+	ndev->features =3D NETIF_F_LLTX;
+	SET_ETHTOOL_OPS(ndev, &rionet_ethtool_ops);
+
+	SET_MODULE_OWNER(ndev);
+
+	spin_lock_init(&rnet->lock);
+	spin_lock_init(&rnet->tx_lock);
+
+	rnet->msg_enable =3D RIONET_DEFAULT_MSGLEVEL;
+
+	rc =3D register_netdev(ndev);
+	if (rc !=3D 0)
+		goto out;
+
+	printk("%s: %s %s Version %s, MAC %02x:%02x:%02x:%02x:%02x:%02x\n",
+	       ndev->name,
+	       DRV_NAME,
+	       DRV_DESC,
+	       DRV_VERSION,
+	       ndev->dev_addr[0], ndev->dev_addr[1], ndev->dev_addr[2],
+	       ndev->dev_addr[3], ndev->dev_addr[4], ndev->dev_addr[5]);
+
+      out:
+	return rc;
+}
+
+/*
+ * XXX Make multi-net safe
+ */
+static int rionet_probe(struct rio_dev *rdev, const struct rio_device_id *=
id)
+{
+	int rc =3D -ENODEV;
+	u32 lpef, lsrc_ops, ldst_ops;
+	struct rionet_peer *peer;
+
+	/* If local device is not rionet capable, give up quickly */
+	if (!rionet_capable)
+		goto out;
+
+	/*
+	 * First time through, make sure local device is rionet
+	 * capable, setup netdev,  and set flags so this is skipped
+	 * on later probes
+	 */
+	if (!rionet_check) {
+		rio_local_read_config_32(rdev->net->hport, RIO_PEF_CAR, &lpef);
+		rio_local_read_config_32(rdev->net->hport, RIO_SRC_OPS_CAR,
+					 &lsrc_ops);
+		rio_local_read_config_32(rdev->net->hport, RIO_DST_OPS_CAR,
+					 &ldst_ops);
+		if (!is_rionet_capable(lpef, lsrc_ops, ldst_ops)) {
+			printk(KERN_ERR
+			       "%s: local device is not network capable\n",
+			       DRV_NAME);
+			rionet_check =3D 1;
+			rionet_capable =3D 0;
+			goto out;
+		}
+
+		rc =3D rionet_setup_netdev(rdev->net->hport);
+		rionet_check =3D 1;
+	}
+
+	/*
+	 * If the remote device has mailbox/doorbell capabilities,
+	 * add it to the peer list.
+	 */
+	if (dev_rionet_capable(rdev)) {
+		if (!(peer =3D kmalloc(sizeof(struct rionet_peer), GFP_KERNEL))) {
+			rc =3D -ENOMEM;
+			goto out;
+		}
+		peer->rdev =3D rdev;
+		list_add_tail(&peer->node, &rionet_peers);
+	}
+
+      out:
+	return rc;
+}
+
+static struct rio_device_id rionet_id_table[] =3D {
+	{RIO_DEVICE(RIO_ANY_ID, RIO_ANY_ID)}
+};
+
+static struct rio_driver rionet_driver =3D {
+	.name =3D "rionet",
+	.id_table =3D rionet_id_table,
+	.probe =3D rionet_probe,
+	.remove =3D rionet_remove,
+};
+
+static int __init rionet_init(void)
+{
+	return rio_register_driver(&rionet_driver);
+}
+
+static void __exit rionet_exit(void)
+{
+	rio_unregister_driver(&rionet_driver);
+}
+
+module_init(rionet_init);
+module_exit(rionet_exit);
