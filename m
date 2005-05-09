Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id 247CE67B1C
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  9 May 2005 22:01:13 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id j49C5kKV006933
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 9 May 2005 15:05:51 +0300 (EEST)
Message-ID: <427F4D3B.6060403@intracom.gr>
Date: Mon, 09 May 2005 14:44:59 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>, Kumar Gala <kumar.gala@freescale.com>,
	Eugene Surovegin <ebs@ebshome.net>, Vitaly Bordug <vbordug@ru.mvista.com>,
	Tom Rini <trini@kernel.crashing.org>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Jason McMullan <jason.mcmullan@timesys.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Content-Type: multipart/mixed; boundary="------------070101010002090404010806"
Subject: [PATCH  02/04] Freescale Ethernet combined driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------070101010002090404010806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi

The following patch is a combined FCC/FEC ethernet driver
for the Freescale line of PowerQUICCs.

FECs on 8xx and FCCs on 82xx are supported.

This part of the patch contains the core driver.

Regards

Pantelis

Signed-off-by: Pantelis Antoniou <panto@intracom.gr>

--------------070101010002090404010806
Content-Type: text/x-patch;
 name="fs_enet-02.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fs_enet-02.patch"

--- /dev/null
+++ linux-2.6.11.7-fs_enet/drivers/net/fs_enet/fs_enet-main.c
@@ -0,0 +1,1161 @@
+/*
+ * Fast Ethernet Controller (FEC) driver for Motorola MPC8xx.
+ *
+ * Copyright (c) 2003 Intracom S.A. 
+ *  by Pantelis Antoniou <panto@intracom.gr>
+ *
+ * Heavily based on original FEC driver by Dan Malek <dan@embeddededge.com>
+ * and modifications by Joakim Tjernlund <joakim.tjernlund@lumentis.se>
+ *
+ * Released under the GPL
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/sched.h>
+#include <linux/string.h>
+#include <linux/ptrace.h>
+#include <linux/errno.h>
+#include <linux/ioport.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/skbuff.h>
+#include <linux/spinlock.h>
+#include <linux/mii.h>
+#include <linux/ethtool.h>
+#include <linux/bitops.h>
+#include <linux/fs.h>
+
+#include <asm/pgtable.h>
+#include <asm/irq.h>
+#include <asm/uaccess.h>
+
+#include "fs_enet.h"
+
+/*************************************************/
+
+static char version[] __devinitdata =
+    DRV_MODULE_NAME ".c:v" DRV_MODULE_VERSION " (" DRV_MODULE_RELDATE ")" "\n";
+
+MODULE_AUTHOR("Pantelis Antoniou <panto@intracom.gr>");
+MODULE_DESCRIPTION("Freescale Ethernet Driver");
+MODULE_LICENSE("GPL");
+
+MODULE_PARM(fs_enet_debug, "i");
+MODULE_PARM_DESC(fs_enet_debug,
+		 "Freescale bitmapped debugging message enable value");
+
+int fs_enet_debug = -1;		/* -1 == use FS_ENET_DEF_MSG_ENABLE as value */
+
+static void fs_set_multicast_list(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	struct dev_mc_list *pmc;
+
+	if ((dev->flags & IFF_PROMISC) == 0) {
+		(*fep->ops->set_multicast_start)(dev);
+		for (pmc = dev->mc_list; pmc != NULL; pmc = pmc->next)
+			(*fep->ops->set_multicast_one)(dev, pmc->dmi_addr);
+		(*fep->ops->set_multicast_finish)(dev);
+	} else
+		(*fep->ops->set_promiscuous_mode)(dev);
+}
+
+static int fs_set_mac_address(struct net_device *dev, void *addr)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	struct sockaddr *mac = addr;
+	int i;
+
+	/* Get pointer to SCC area in parameter RAM. */
+	for (i = 0; i < 6; i++)
+		dev->dev_addr[i] = mac->sa_data[i];
+
+	(*fep->ops->set_mac_address)(dev);
+	return 0;
+}
+
+void fs_restart(struct net_device *dev, int duplex, int speed)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&fep->lock, flags);
+	(*fep->ops->restart)(dev, duplex, speed);
+	spin_unlock_irqrestore(&fep->lock, flags);
+}
+
+void fs_stop(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&fep->lock, flags);
+	(*fep->ops->stop)(dev);
+	spin_unlock_irqrestore(&fep->lock, flags);
+}
+
+/* common receive function */
+static int fs_enet_rx_common(struct net_device *dev, int *budget)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	const struct fs_platform_info *fpi = fep->fpi;
+	cbd_t *bdp;
+	struct sk_buff *skb, *skbn, *skbt;
+	int received = 0;
+	__u16 pkt_len, sc;
+	int curidx;
+	int rx_work_limit = 0;	/* pacify gcc */
+
+	if (fpi->use_napi) {
+		rx_work_limit = min(dev->quota, *budget);
+
+		if (!netif_running(dev))
+			return 0;
+	}
+
+	/*
+	 * First, grab all of the stats for the incoming packet.
+	 * These get messed up if we get called due to a busy condition.
+	 */
+	bdp = fep->cur_rx;
+
+	/* clear RX status bits for napi*/
+	if (fpi->use_napi)
+		(*fep->ops->napi_clear_rx_event)(dev);
+
+	while (((sc = CBDR_SC(bdp)) & BD_ENET_RX_EMPTY) == 0) {
+
+		curidx = bdp - fep->rx_bd_base;
+
+		/*
+		 * Since we have allocated space to hold a complete frame,
+		 * the last indicator should be set.
+		 */
+		if ((sc & BD_ENET_RX_LAST) == 0)
+			printk(KERN_WARNING DRV_MODULE_NAME
+			       ": %s rcv is not +last\n",
+			       dev->name);
+
+		/*
+		 * Check for errors. 
+		 */
+		if (sc & (BD_ENET_RX_LG | BD_ENET_RX_SH | BD_ENET_RX_CL |
+			  BD_ENET_RX_NO | BD_ENET_RX_CR | BD_ENET_RX_OV)) {
+			fep->stats.rx_errors++;
+			/* Frame too long or too short. */
+			if (sc & (BD_ENET_RX_LG | BD_ENET_RX_SH))
+				fep->stats.rx_length_errors++;
+			/* Frame alignment */
+			if (sc & (BD_ENET_RX_NO | BD_ENET_RX_CL))
+				fep->stats.rx_frame_errors++;
+			/* CRC Error */
+			if (sc & BD_ENET_RX_CR)
+				fep->stats.rx_crc_errors++;
+			/* FIFO overrun */
+			if (sc & BD_ENET_RX_OV)
+				fep->stats.rx_crc_errors++;
+
+			skbn = fep->rx_skbuff[curidx];
+			BUG_ON(skbn == NULL);
+
+		} else {
+
+			/* napi, got packet but no quota */
+			if (fpi->use_napi && --rx_work_limit < 0)
+				break;
+
+			skb = fep->rx_skbuff[curidx];
+			BUG_ON(skb == NULL);
+
+			/*
+			 * Process the incoming frame.
+			 */
+			fep->stats.rx_packets++;
+			pkt_len = CBDR_DATLEN(bdp) - 4;	/* remove CRC */
+			fep->stats.rx_bytes += pkt_len + 4;
+
+			if (pkt_len <= fpi->rx_copybreak) {
+				/* +2 to make IP header L1 cache aligned */
+				skbn = dev_alloc_skb(pkt_len + 2);
+				if (skbn != NULL) {
+					skb_reserve(skbn, 2);	/* align IP header */
+					memcpy(skbn->data, skb->data, pkt_len);
+					/* swap */
+					skbt = skb;
+					skb = skbn;
+					skbn = skbt;
+				}
+			} else
+				skbn = dev_alloc_skb(ENET_RX_FRSIZE);
+
+			if (skbn != NULL) {
+				skb->dev = dev;
+				skb_put(skb, pkt_len);	/* Make room */
+				skb->protocol = eth_type_trans(skb, dev);
+				received++;
+				if (!fpi->use_napi)
+					netif_rx(skb);
+				else
+					netif_receive_skb(skb);
+			} else {
+				printk(KERN_WARNING DRV_MODULE_NAME
+				       ": %s Memory squeeze, dropping packet.\n",
+				       dev->name);
+				fep->stats.rx_dropped++;
+				skbn = skb;
+			}
+		}
+
+		fep->rx_skbuff[curidx] = skbn;
+		CBDW_BUFADDR(bdp, fs_dma_from(fep, skbn->data,
+			     L1_CACHE_ALIGN(PKT_MAXBUF_SIZE)));
+		CBDW_DATLEN(bdp, 0);
+		CBDW_SC(bdp, (sc & ~BD_ENET_RX_STATS) | BD_ENET_RX_EMPTY);
+
+		/*
+		 * Update BD pointer to next entry. 
+		 */
+		if ((sc & BD_ENET_RX_WRAP) == 0)
+			bdp++;
+		else
+			bdp = fep->rx_bd_base;
+
+		(*fep->ops->rx_bd_done)(dev);
+	}
+
+	fep->cur_rx = bdp;
+
+	if (fpi->use_napi) {
+		dev->quota -= received;
+		*budget -= received;
+
+		if (rx_work_limit < 0)
+			return 1;	/* not done */
+
+		/* done */
+		netif_rx_complete(dev);
+
+		(*fep->ops->napi_enable_rx)(dev);
+	}
+
+	return 0;
+}
+
+static void fs_enet_tx(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	cbd_t *bdp;
+	struct sk_buff *skb;
+	int dirtyidx, do_wake, do_restart;
+	__u16 sc;
+
+	spin_lock(&fep->lock);
+	bdp = fep->dirty_tx;
+
+	do_wake = do_restart = 0;
+	while (((sc = CBDR_SC(bdp)) & BD_ENET_TX_READY) == 0) {
+
+		dirtyidx = bdp - fep->tx_bd_base;
+
+		if (fep->tx_free == fep->tx_ring)
+			break;
+
+		skb = fep->tx_skbuff[dirtyidx];
+
+		/*
+		 * Check for errors. 
+		 */
+		if (sc & (BD_ENET_TX_HB | BD_ENET_TX_LC |
+			  BD_ENET_TX_RL | BD_ENET_TX_UN | BD_ENET_TX_CSL)) {
+
+			if (sc & BD_ENET_TX_HB)	/* No heartbeat */
+				fep->stats.tx_heartbeat_errors++;
+			if (sc & BD_ENET_TX_LC)	/* Late collision */
+				fep->stats.tx_window_errors++;
+			if (sc & BD_ENET_TX_RL)	/* Retrans limit */
+				fep->stats.tx_aborted_errors++;
+			if (sc & BD_ENET_TX_UN)	/* Underrun */
+				fep->stats.tx_fifo_errors++;
+			if (sc & BD_ENET_TX_CSL)	/* Carrier lost */
+				fep->stats.tx_carrier_errors++;
+
+			if (sc & (BD_ENET_TX_LC | BD_ENET_TX_RL | BD_ENET_TX_UN)) {
+				fep->stats.tx_errors++;
+				do_restart = 1;
+			}
+		} else
+			fep->stats.tx_packets++;
+
+		if (sc & BD_ENET_TX_READY)
+			printk(KERN_WARNING DRV_MODULE_NAME
+			       ": %s HEY! Enet xmit interrupt and TX_READY.\n",
+			       dev->name);
+
+		/*
+		 * Deferred means some collisions occurred during transmit,
+		 * but we eventually sent the packet OK.
+		 */
+		if (sc & BD_ENET_TX_DEF)
+			fep->stats.collisions++;
+
+		/*
+		 * Free the sk buffer associated with this last transmit. 
+		 */
+		dev_kfree_skb_irq(skb);
+		fep->tx_skbuff[dirtyidx] = NULL;
+
+		/*
+		 * Update pointer to next buffer descriptor to be transmitted. 
+		 */
+		if ((sc & BD_ENET_TX_WRAP) == 0)
+			bdp++;
+		else
+			bdp = fep->tx_bd_base;
+
+		/*
+		 * Since we have freed up a buffer, the ring is no longer
+		 * full.
+		 */
+		if (!fep->tx_free++)
+			do_wake = 1;
+	}
+
+	fep->dirty_tx = bdp;
+
+	if (do_restart)
+		(*fep->ops->tx_restart)(dev);
+
+	spin_unlock(&fep->lock);
+
+	if (do_wake && netif_queue_stopped(dev))
+		netif_wake_queue(dev);
+}
+
+/*
+ * The interrupt handler.
+ * This is called from the MPC core interrupt.
+ */
+static irqreturn_t
+fs_enet_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	struct net_device *dev = dev_id;
+	struct fs_enet_private *fep;
+	const struct fs_platform_info *fpi;
+	__u32 int_events;
+	__u32 int_clr_events;
+
+	if (unlikely(dev == NULL))
+		return IRQ_NONE;
+
+	fep = netdev_priv(dev);
+	fpi = fep->fpi;
+
+	/*
+	 * Get the interrupt events that caused us to be here.
+	 */
+	while ((int_events = (*fep->ops->get_int_events)(dev)) != 0) {
+
+		int_clr_events = int_events;
+		if (fpi->use_napi)
+			int_clr_events &= ~fep->ev_napi_rx;
+
+		(*fep->ops->clear_int_events)(dev, int_clr_events);
+
+		if ((int_events & fep->ev_err) != 0)
+			(*fep->ops->ev_error)(dev, int_events);
+
+		if ((int_events & fep->ev_rx) != 0) {
+			if (!fpi->use_napi)
+				fs_enet_rx_common(dev, NULL);
+			else {
+				if (netif_rx_schedule_prep(dev)) {
+					(*fep->ops->napi_disable_rx)(dev);
+					__netif_rx_schedule(dev);
+				} else {
+					printk(KERN_ERR DRV_MODULE_NAME
+					       ": %s driver bug! interrupt while in poll!\n",
+					       dev->name);
+					(*fep->ops->napi_disable_rx)(dev);
+				}
+			}
+		}
+
+		if ((int_events & fep->ev_tx) != 0)
+			fs_enet_tx(dev);
+	}
+
+	return IRQ_HANDLED;
+}
+
+void fs_init_bds(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	cbd_t *bdp;
+	struct sk_buff *skb;
+	int i;
+
+	fep->dirty_tx = fep->cur_tx = fep->tx_bd_base;
+	fep->tx_free = fep->tx_ring;
+	fep->cur_rx = fep->rx_bd_base;
+
+	/*
+	 * Reset SKB receive buffers 
+	 */
+	for (i = 0; i < fep->rx_ring; i++) {
+		if ((skb = fep->rx_skbuff[i]) == NULL)
+			continue;
+		fep->rx_skbuff[i] = NULL;
+		dev_kfree_skb(skb);
+	}
+
+	/*
+	 * Initialize the receive buffer descriptors. 
+	 */
+	for (i = 0, bdp = fep->rx_bd_base; i < fep->rx_ring; i++, bdp++) {
+		skb = dev_alloc_skb(ENET_RX_FRSIZE);
+		if (skb == NULL) {
+			printk(KERN_WARNING DRV_MODULE_NAME
+			       ": %s Memory squeeze, unable to allocate skb\n",
+			       dev->name);
+			fep->stats.rx_dropped++;
+			break;
+		}
+		fep->rx_skbuff[i] = skb;
+		skb->dev = dev;
+		CBDW_BUFADDR(bdp,
+			fs_dma_from(fep, skb->data,
+				L1_CACHE_ALIGN(PKT_MAXBUF_SIZE)));
+		CBDW_DATLEN(bdp, 0);	/* zero */
+		CBDW_SC(bdp, BD_ENET_RX_EMPTY |
+			((i < fep->rx_ring - 1) ? 0 : BD_SC_WRAP));
+	}
+	/*
+	 * if we failed, fillup remainder 
+	 */
+	for (; i < fep->rx_ring; i++, bdp++) {
+		fep->rx_skbuff[i] = NULL;
+		CBDW_SC(bdp, (i < fep->rx_ring - 1) ? 0 : BD_SC_WRAP);
+	}
+
+	/*
+	 * Reset SKB transmit buffers.  
+	 */
+	for (i = 0; i < fep->tx_ring; i++) {
+		if ((skb = fep->tx_skbuff[i]) == NULL)
+			continue;
+		fep->tx_skbuff[i] = NULL;
+		dev_kfree_skb(skb);
+	}
+
+	/*
+	 * ...and the same for transmit.  
+	 */
+	for (i = 0, bdp = fep->tx_bd_base; i < fep->tx_ring; i++, bdp++) {
+		fep->tx_skbuff[i] = NULL;
+		CBDW_BUFADDR(bdp, virt_to_bus(NULL));
+		CBDW_DATLEN(bdp, 0);
+		CBDW_SC(bdp, (i < fep->tx_ring - 1) ? 0 : BD_SC_WRAP);
+	}
+}
+
+void fs_cleanup_bds(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	struct sk_buff *skb;
+	int i;
+
+	/*
+	 * Reset SKB transmit buffers.  
+	 */
+	for (i = 0; i < fep->tx_ring; i++) {
+		if ((skb = fep->tx_skbuff[i]) == NULL)
+			continue;
+		fep->tx_skbuff[i] = NULL;
+		dev_kfree_skb(skb);
+	}
+
+	/*
+	 * Reset SKB receive buffers 
+	 */
+	for (i = 0; i < fep->rx_ring; i++) {
+		if ((skb = fep->rx_skbuff[i]) == NULL)
+			continue;
+		fep->rx_skbuff[i] = NULL;
+		dev_kfree_skb(skb);
+	}
+}
+
+/**********************************************************************************/
+
+static int fs_enet_start_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	cbd_t *bdp;
+	int curidx;
+	__u16 sc;
+	unsigned long flags;
+
+	spin_lock_irqsave(&fep->tx_lock, flags);
+
+	/*
+	 * Fill in a Tx ring entry 
+	 */
+	bdp = fep->cur_tx;
+
+	if (!fep->tx_free || (CBDR_SC(bdp) & BD_ENET_TX_READY)) {
+		netif_stop_queue(dev);
+		spin_unlock_irqrestore(&fep->tx_lock, flags);
+
+		/*
+		 * Ooops.  All transmit buffers are full.  Bail out.
+		 * This should not happen, since the tx queue should be stopped.
+		 */
+		printk(KERN_WARNING DRV_MODULE_NAME
+		       ": %s tx queue full!.\n", dev->name);
+		return 1;
+	}
+
+	curidx = bdp - fep->tx_bd_base;
+	/*
+	 * Clear all of the status flags. 
+	 */
+	CBDC_SC(bdp, BD_ENET_TX_STATS);
+
+	/*
+	 * Save skb pointer. 
+	 */
+	fep->tx_skbuff[curidx] = skb;
+
+	fep->stats.tx_bytes += skb->len;
+
+	/*
+	 * Push the data cache so the CPM does not get stale memory data. 
+	 */
+	CBDW_BUFADDR(bdp, fs_dma_to(fep, skb->data, skb->len));
+	CBDW_DATLEN(bdp, skb->len);
+
+	dev->trans_start = jiffies;
+
+	/*
+	 * If this was the last BD in the ring, start at the beginning again. 
+	 */
+	if ((CBDR_SC(bdp) & BD_ENET_TX_WRAP) == 0)
+		fep->cur_tx++;
+	else
+		fep->cur_tx = fep->tx_bd_base;
+
+	if (!--fep->tx_free)
+		netif_stop_queue(dev);
+
+	/* Trigger transmission start */
+	sc = BD_ENET_TX_READY | BD_ENET_TX_INTR |
+	     BD_ENET_TX_LAST | BD_ENET_TX_TC;
+
+	/* note that while FEC does not have this bit
+	 * it marks it as available for software use
+	 * yay for hw reuse :) */
+	if (skb->len <= 60)
+		sc |= BD_ENET_TX_PAD;
+	CBDS_SC(bdp, sc);
+
+	(*fep->ops->tx_kickstart)(dev);
+
+	spin_unlock_irqrestore(&fep->tx_lock, flags);
+
+	return 0;
+}
+
+static int fs_request_irq(struct net_device *dev, int irq, const char *name,
+		irqreturn_t (*irqf)(int irq, void *dev_id, struct pt_regs *regs))
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+
+	(*fep->ops->pre_request_irq)(dev, irq);
+	return request_irq(irq, irqf, 0, name, dev);
+}
+
+static void fs_free_irq(struct net_device *dev, int irq)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+
+	free_irq(irq, dev);
+	(*fep->ops->post_free_irq)(dev, irq);
+}
+
+/**********************************************************************************/
+
+/* This interrupt occurs when the PHY detects a link change. */
+static irqreturn_t
+fs_mii_link_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	struct net_device *dev = dev_id;
+	struct fs_enet_private *fep;
+	const struct fs_platform_info *fpi;
+
+	if (unlikely(dev == NULL))
+		return IRQ_NONE;
+
+	fep = netdev_priv(dev);
+	fpi = fep->fpi;
+
+	/*
+	 * Acknowledge the interrupt if possible. If we have not
+	 * found the PHY yet we can't process or acknowledge the
+	 * interrupt now. Instead we ignore this interrupt for now,
+	 * which we can do since it is edge triggered. It will be
+	 * acknowledged later by fs_enet_open().
+	 */
+	if (!fep->phy)
+		return IRQ_NONE;
+
+	fs_mii_ack_int(dev);
+	fs_mii_link_status_change_check(dev, 0);
+
+	return IRQ_HANDLED;
+}
+
+static void fs_timeout(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+
+	fep->stats.tx_errors++;
+
+	if (fep->tx_free)
+		netif_wake_queue(dev);
+
+	/* check link status again */
+	fs_mii_link_status_change_check(dev, 0);
+}
+
+static int fs_enet_open(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	const struct fs_platform_info *fpi = fep->fpi;
+	int r;
+
+	/* Install our interrupt handler. */
+	r = fs_request_irq(dev, fpi->fs_irq, "fs_enet-mac", fs_enet_interrupt);
+	if (r != 0) {
+		printk(KERN_ERR DRV_MODULE_NAME
+		       ": %s Could not allocate FEC IRQ!", dev->name);
+		return -EINVAL;
+	}
+
+	/* Install our phy interrupt handler */
+	if (fpi->phy_irq != -1) {
+
+		r = fs_request_irq(dev, fpi->phy_irq, "fs_enet-phy", fs_mii_link_interrupt);
+		if (r != 0) {
+			printk(KERN_ERR DRV_MODULE_NAME
+			       ": %s Could not allocate PHY IRQ!", dev->name);
+			fs_free_irq(dev, fpi->fs_irq);
+			return -EINVAL;
+		}
+	}
+
+	fs_mii_startup(dev);
+	netif_carrier_off(dev);
+	fs_mii_link_status_change_check(dev, 1);
+
+	return 0;
+}
+
+static int fs_enet_close(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	const struct fs_platform_info *fpi = fep->fpi;
+	unsigned long flags;
+
+	netif_stop_queue(dev);
+	netif_carrier_off(dev);
+
+	fs_mii_shutdown(dev);
+
+	spin_lock_irqsave(&fep->lock, flags);
+	(*fep->ops->stop)(dev);
+	spin_unlock_irqrestore(&fep->lock, flags);
+
+	/* release any irqs */
+	if (fpi->phy_irq != -1)
+		fs_free_irq(dev, fpi->phy_irq);
+	fs_free_irq(dev, fpi->fs_irq);
+
+	return 0;
+}
+
+static struct net_device_stats *fs_enet_get_stats(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	return &fep->stats;
+}
+
+static int fs_enet_poll(struct net_device *dev, int *budget)
+{
+	return fs_enet_rx_common(dev, budget);
+}
+
+/*************************************************************************/
+
+static void fs_get_drvinfo(struct net_device *dev,
+			    struct ethtool_drvinfo *info)
+{
+	strcpy(info->driver, DRV_MODULE_NAME);
+	strcpy(info->version, DRV_MODULE_VERSION);
+}
+
+static int fs_get_regs_len(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+
+	return (*fep->ops->get_regs_len)(dev);
+}
+
+static void fs_get_regs(struct net_device *dev, struct ethtool_regs *regs,
+			 void *p)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	unsigned long flags;
+	int r, len;
+
+	len = regs->len;
+
+	spin_lock_irqsave(&fep->lock, flags);
+	r = (*fep->ops->get_regs)(dev, p, &len);
+	spin_unlock_irqrestore(&fep->lock, flags);
+
+	if (r == 0)
+		regs->version = 0;
+}
+
+static int fs_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	unsigned long flags;
+	int rc;
+
+	spin_lock_irqsave(&fep->lock, flags);
+	rc = mii_ethtool_gset(&fep->mii_if, cmd);
+	spin_unlock_irqrestore(&fep->lock, flags);
+
+	return rc;
+}
+
+static int fs_set_settings(struct net_device *dev, struct ethtool_cmd *cmd)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	unsigned long flags;
+	int rc;
+
+	spin_lock_irqsave(&fep->lock, flags);
+	rc = mii_ethtool_sset(&fep->mii_if, cmd);
+	spin_unlock_irqrestore(&fep->lock, flags);
+
+	return rc;
+}
+
+static int fs_nway_reset(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	return mii_nway_restart(&fep->mii_if);
+}
+
+static __u32 fs_get_msglevel(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	return fep->msg_enable;
+}
+
+static void fs_set_msglevel(struct net_device *dev, __u32 value)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	fep->msg_enable = value;
+}
+
+static struct ethtool_ops fs_ethtool_ops = {
+	.get_drvinfo = fs_get_drvinfo,
+	.get_regs_len = fs_get_regs_len,
+	.get_settings = fs_get_settings,
+	.set_settings = fs_set_settings,
+	.nway_reset = fs_nway_reset,
+	.get_link = ethtool_op_get_link,
+	.get_msglevel = fs_get_msglevel,
+	.set_msglevel = fs_set_msglevel,
+	.get_tx_csum = ethtool_op_get_tx_csum,
+	.set_tx_csum = ethtool_op_set_tx_csum,	/* local! */
+	.get_sg = ethtool_op_get_sg,
+	.set_sg = ethtool_op_set_sg,
+	.get_regs = fs_get_regs,
+};
+
+static int fs_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	struct mii_ioctl_data *mii = (struct mii_ioctl_data *)&rq->ifr_data;
+	unsigned long flags;
+	int rc;
+
+	if (!netif_running(dev))
+		return -EINVAL;
+
+	spin_lock_irqsave(&fep->lock, flags);
+	rc = generic_mii_ioctl(&fep->mii_if, mii, cmd, NULL);
+	spin_unlock_irqrestore(&fep->lock, flags);
+	return rc;
+}
+
+extern int fs_mii_connect(struct net_device *dev);
+extern void fs_mii_disconnect(struct net_device *dev);
+
+static struct net_device *fs_init_instance(
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
+		struct device *dev,
+#endif
+		const struct fs_platform_info *fpi)
+{
+	struct net_device *ndev = NULL;
+	struct fs_enet_private *fep = NULL;
+	int privsize, i, r, err = 0, registered = 0;
+
+	/* guard */
+	if ((unsigned int)fpi->fs_no >= FS_MAX_INDEX)
+		return ERR_PTR(-EINVAL);
+
+	privsize = sizeof(*fep) + (sizeof(struct sk_buff **) *
+			    (fpi->rx_ring + fpi->tx_ring));
+
+	ndev = alloc_etherdev(privsize);
+	if (!ndev) {
+		err = -ENOMEM;
+		goto err;
+	}
+	SET_MODULE_OWNER(ndev);
+
+	fep = netdev_priv(ndev);
+	memset(fep, 0, privsize);	/* clear everything */
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
+	fep->dev = dev;
+	dev_set_drvdata(dev, ndev);
+#endif
+	fep->fpi = fpi;
+
+#ifdef CONFIG_8xx
+	if (fs_get_fec_index(fpi->fs_no) >= 0)
+		fep->ops = &fs_fec_ops;
+#endif
+
+#ifdef CONFIG_8260
+	if (fs_get_fcc_index(fpi->fs_no) >= 0)
+		fep->ops = &fs_fcc_ops;
+#endif
+
+#if 0
+	if (fs_get_scc_index(fpi->fs_no) >= 0)
+		fep->ops = &fs_scc_ops;
+#endif
+	if (fep->ops == NULL) {
+		printk(KERN_ERR DRV_MODULE_NAME
+		       ": %s No matching ops found (%d).\n",
+		       ndev->name, fpi->fs_no);
+		err = -EINVAL;
+		goto err;
+	}
+
+	r = (*fep->ops->setup_data)(ndev);
+	if (r != 0) {
+		printk(KERN_ERR DRV_MODULE_NAME
+		       ": %s setup_data failed\n",
+		       ndev->name);
+		err = r;
+		goto err;
+	}
+
+	/* point rx_skbuff, tx_skbuff */
+	fep->rx_skbuff = (struct sk_buff **)&fep[1];
+	fep->tx_skbuff = fep->rx_skbuff + fpi->rx_ring;
+
+	/* init locks */
+	spin_lock_init(&fep->lock);
+	spin_lock_init(&fep->tx_lock);
+
+	/*
+	 * Set the Ethernet address. 
+	 */
+	for (i = 0; i < 6; i++)
+		ndev->dev_addr[i] = fpi->macaddr[i];
+
+	fep->ring_base = fs_alloc_coherent(fep,
+					    (fpi->tx_ring + fpi->rx_ring) *
+					    sizeof(cbd_t), &fep->ring_mem_addr,
+					    GFP_KERNEL);
+	if (fep->ring_base == NULL) {
+		printk(KERN_ERR DRV_MODULE_NAME
+		       ": %s dma alloc failed.\n", ndev->name);
+		err = -ENOMEM;
+		goto err;
+	}
+
+	/*
+	 * Set receive and transmit descriptor base.
+	 */
+	fep->rx_bd_base = fep->ring_base;
+	fep->tx_bd_base = fep->rx_bd_base + fpi->rx_ring;
+
+	/* initialize ring size variables */
+	fep->tx_ring = fpi->tx_ring;
+	fep->rx_ring = fpi->rx_ring;
+
+	/*
+	 * The FEC Ethernet specific entries in the device structure. 
+	 */
+	ndev->open = fs_enet_open;
+	ndev->hard_start_xmit = fs_enet_start_xmit;
+	ndev->tx_timeout = fs_timeout;
+	ndev->watchdog_timeo = 2 * HZ;
+	ndev->stop = fs_enet_close;
+	ndev->get_stats = fs_enet_get_stats;
+	ndev->set_multicast_list = fs_set_multicast_list;
+	ndev->set_mac_address = fs_set_mac_address;
+	if (fpi->use_napi) {
+		ndev->poll = fs_enet_poll;
+		ndev->weight = fpi->napi_weight;
+	}
+	ndev->ethtool_ops = &fs_ethtool_ops;
+	ndev->do_ioctl = fs_ioctl;
+
+	init_timer(&fep->phy_timer_list);
+
+	netif_carrier_off(ndev);
+
+	err = register_netdev(ndev);
+	if (err != 0) {
+		printk(KERN_ERR DRV_MODULE_NAME
+		       ": %s register_netdev failed.\n", ndev->name);
+		goto err;
+	}
+	registered = 1;
+
+	err = fs_mii_connect(ndev);
+	if (err != 0) {
+		printk(KERN_ERR DRV_MODULE_NAME
+		       ": %s fs_mii_connect failed.\n", ndev->name);
+		goto err;
+	}
+
+	return ndev;
+
+      err:
+	if (ndev != NULL) {
+
+		if (registered)
+			unregister_netdev(ndev);
+
+		if (fep != NULL) {
+			if (fep->ring_base)
+				fs_free_coherent(fep,
+					(fpi->tx_ring + fpi->rx_ring)
+						* sizeof(cbd_t),
+					fep->ring_base,
+					fep->ring_mem_addr);
+
+			(*fep->ops->cleanup_data)(ndev);
+		}
+
+		free_netdev(ndev);
+	}
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
+	dev_set_drvdata(dev, NULL);
+#endif
+
+	return ERR_PTR(err);
+}
+
+static int fs_cleanup_instance(struct net_device *ndev)
+{
+	struct fs_enet_private *fep;
+	const struct fs_platform_info *fpi;
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
+	struct device *dev;
+#endif
+
+	if (ndev == NULL)
+		return -EINVAL;
+
+	fep = netdev_priv(ndev);
+	if (fep == NULL)
+		return -EINVAL;
+
+	fpi = fep->fpi;
+
+	fs_mii_disconnect(ndev);
+
+	unregister_netdev(ndev);
+
+	fs_free_coherent(fep, (fpi->tx_ring + fpi->rx_ring) * sizeof(cbd_t),
+			  fep->ring_base, fep->ring_mem_addr);
+
+	/* reset it */
+	(*fep->ops->cleanup_data)(ndev);
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
+	dev = fep->dev;
+	if (dev != NULL) {
+		dev_set_drvdata(dev, NULL);
+		fep->dev = NULL;
+	}
+#endif
+
+	free_netdev(ndev);
+
+	return 0;
+}
+
+/**************************************************************************************/
+
+/* handy pointer to the immap */
+void *fs_enet_immap = NULL;
+
+static int setup_immap(void)
+{
+	phys_addr_t paddr = 0;
+	unsigned long size = 0;
+
+#ifdef CONFIG_8xx
+	paddr = IMAP_ADDR;
+	size = 0x10000;	/* map 64K */
+#endif
+#ifdef CONFIG_8260
+	paddr = CPM_MAP_ADDR;
+	size = 0x40000;	/* map 256 K */
+#endif
+	fs_enet_immap = ioremap(paddr, size);
+	if (fs_enet_immap == NULL)
+		return -EBADF;	/* XXX ahem; maybe just BUG_ON? */
+
+	return 0;
+}
+
+static void cleanup_immap(void)
+{
+	if (fs_enet_immap != NULL) {
+		iounmap(fs_enet_immap);
+		fs_enet_immap = NULL;
+	}
+}
+
+/**************************************************************************************/
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
+
+static int __devinit fs_enet_probe(struct device *dev)
+{
+	struct net_device *ndev;
+
+	ndev = fs_init_instance(dev, dev->platform_data);
+	if (IS_ERR(ndev))
+		return PTR_ERR(ndev);
+	return 0;
+}
+
+static int fs_enet_remove(struct device *dev)
+{
+	return fs_cleanup_instance(dev_get_drvdata(dev));
+}
+
+static struct device_driver fs_enet_driver = {
+	.name	  	= FS_ENET_NAME,
+	.bus		= &platform_bus_type,
+	.probe		= fs_enet_probe,
+	.remove		= fs_enet_remove,
+#ifdef CONFIG_PM
+/*	.suspend	= fs_enet_suspend,	TODO */
+/*	.resume		= fs_enet_resume,	TODO */
+#endif
+};
+
+static int __init fs_init(void)
+{
+	int r;
+
+	printk(KERN_INFO
+			"%s", version);
+
+	r = setup_immap();
+	if (r != 0)
+		return r;
+
+	r = driver_register(&fs_enet_driver);
+	if (r != 0) {
+		cleanup_immap();
+		return r;
+	}
+
+	return 0;
+}
+
+static void __exit fs_cleanup(void)
+{
+	driver_unregister(&fs_enet_driver);
+	cleanup_immap();
+}
+
+#else
+
+int fs_enet_init_one(const struct fs_platform_info *fpi,
+		     struct net_device **ndevp)
+{
+	struct net_device *ndev;
+
+	ndev = fs_init_instance(fpi);
+	if (IS_ERR(ndev))
+		return PTR_ERR(ndev);
+	*ndevp = ndev;
+	return 0;
+}
+
+int fs_enet_cleanup_one(struct net_device *ndev)
+{
+	return fs_cleanup_instance(ndev);
+}
+
+static int __init fs_init(void)
+{
+	int r;
+
+	printk(KERN_INFO
+			"%s", version);
+
+	r = setup_immap();
+	if (r != 0)
+		return r;
+
+	r =  fs_enet_platform_init();
+	if (r != 0) {
+		cleanup_immap();
+		return r;
+	}
+
+	return 0;
+}
+
+static void __exit fs_cleanup(void)
+{
+	fs_enet_platform_cleanup();
+	cleanup_immap();
+}
+
+#endif
+
+/**************************************************************************************/
+
+module_init(fs_init);
+module_exit(fs_cleanup);
--- /dev/null
+++ linux-2.6.11.7-fs_enet/drivers/net/fs_enet/fs_enet-mii.c
@@ -0,0 +1,434 @@
+/*
+ * Fast Ethernet Controller (FEC) driver for Motorola MPC8xx.
+ *
+ * Copyright (c) 2003 Intracom S.A. 
+ *  by Pantelis Antoniou <panto@intracom.gr>
+ *
+ * Heavily based on original FEC driver by Dan Malek <dan@embeddededge.com>
+ * and modifications by Joakim Tjernlund <joakim.tjernlund@lumentis.se>
+ *
+ * Released under the GPL
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/string.h>
+#include <linux/ptrace.h>
+#include <linux/errno.h>
+#include <linux/ioport.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/skbuff.h>
+#include <linux/spinlock.h>
+#include <linux/mii.h>
+#include <linux/ethtool.h>
+#include <linux/bitops.h>
+
+#include <asm/pgtable.h>
+#include <asm/irq.h>
+#include <asm/uaccess.h>
+
+#include "fs_enet.h"
+
+/*************************************************/
+
+/*
+ * Generic PHY support.
+ * Should work for all PHYs, but link change is detected by polling
+ */
+
+static void generic_timer_callback(unsigned long data)
+{
+	struct net_device *dev = (struct net_device *)data;
+	struct fs_enet_private *fep = netdev_priv(dev);
+
+	fep->phy_timer_list.expires = jiffies + HZ / 2;
+
+	add_timer(&fep->phy_timer_list);
+
+	fs_mii_link_status_change_check(dev, 0);
+}
+
+static void generic_startup(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+
+	fep->phy_timer_list.expires = jiffies + HZ / 2;	/* every 500ms */
+	fep->phy_timer_list.data = (unsigned long)dev;
+	fep->phy_timer_list.function = generic_timer_callback;
+	add_timer(&fep->phy_timer_list);
+}
+
+static void generic_shutdown(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+
+	del_timer_sync(&fep->phy_timer_list);
+}
+
+/* ------------------------------------------------------------------------- */
+/* The Davicom DM9161 is used on the NETTA board			     */
+
+/* register definitions */
+
+#define MII_DM9161_ACR		16	/* Aux. Config Register         */
+#define MII_DM9161_ACSR		17	/* Aux. Config/Status Register  */
+#define MII_DM9161_10TCSR	18	/* 10BaseT Config/Status Reg.   */
+#define MII_DM9161_INTR		21	/* Interrupt Register           */
+#define MII_DM9161_RECR		22	/* Receive Error Counter Reg.   */
+#define MII_DM9161_DISCR	23	/* Disconnect Counter Register  */
+
+static void dm9161_startup(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+
+	fs_mii_write(dev, fep->mii_if.phy_id, MII_DM9161_INTR, 0x0000);
+}
+
+static void dm9161_ack_int(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+
+	fs_mii_read(dev, fep->mii_if.phy_id, MII_DM9161_INTR);
+}
+
+static void dm9161_shutdown(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+
+	fs_mii_write(dev, fep->mii_if.phy_id, MII_DM9161_INTR, 0x0f00);
+}
+
+/**********************************************************************************/
+
+static const struct phy_info phy_info[] = {
+	{
+		.id = 0x00181b88,
+		.name = "DM9161",
+		.startup = dm9161_startup,
+		.ack_int = dm9161_ack_int,
+		.shutdown = dm9161_shutdown,
+	}, {
+		.id = 0,
+		.name = "GENERIC",
+		.startup = generic_startup,
+		.shutdown = generic_shutdown,
+	},
+};
+
+/**********************************************************************************/
+
+static int phy_id_detect(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	const struct fs_platform_info *fpi = fep->fpi;
+	int i, r, start, end, phytype, physubtype;
+	const struct phy_info *phy;
+	int phy_hwid, phy_id;
+
+	phy_hwid = -1;
+	fep->phy = NULL;
+
+	/* auto-detect? */
+	if (fpi->phy_addr == -1) {
+		start = 0;
+		end = 32;
+	} else {		/* direct */
+		start = fpi->phy_addr;
+		end = start + 1;
+	}
+
+	for (phy_id = start; phy_id < end; phy_id++) {
+		r = fs_mii_read(dev, phy_id, MII_PHYSID1);
+		if (r == -1 || (phytype = (r & 0xffff)) == 0xffff)
+			continue;
+		r = fs_mii_read(dev, phy_id, MII_PHYSID2);
+		if (r == -1 || (physubtype = (r & 0xffff)) == 0xffff)
+			continue;
+		phy_hwid = (phytype << 16) | physubtype;
+		if (phy_hwid != -1)
+			break;
+	}
+
+	if (phy_hwid == -1) {
+		printk(KERN_ERR DRV_MODULE_NAME
+		       ": %s No PHY detected!\n", dev->name);
+		return -1;
+	}
+
+	for (i = 0, phy = phy_info; i < sizeof(phy_info) / sizeof(phy_info[0]);
+	     i++, phy++)
+		if (phy->id == (phy_hwid >> 4) || phy->id == 0)
+			break;
+
+	if (i >= sizeof(phy_info) / sizeof(phy_info[0])) {
+		printk(KERN_ERR DRV_MODULE_NAME
+		       ": %s PHY id 0x%08x is not supported!\n",
+		       dev->name, phy_hwid);
+		return -1;
+	}
+
+	fep->phy = phy;
+
+	printk(KERN_INFO DRV_MODULE_NAME
+	       ": %s Phy @ 0x%x, type %s (0x%08x)\n",
+	       dev->name, phy_id, fep->phy->name, phy_hwid);
+
+	return phy_id;
+}
+
+void fs_mii_startup(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+
+	if (fep->phy == NULL)
+		return;
+
+	if (fep->phy->startup == NULL)
+		return;
+
+	(*fep->phy->startup) (dev);
+}
+
+void fs_mii_shutdown(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+
+	if (fep->phy == NULL)
+		return;
+
+	if (fep->phy->shutdown == NULL)
+		return;
+
+	(*fep->phy->shutdown) (dev);
+}
+
+void fs_mii_ack_int(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+
+	if (fep->phy == NULL)
+		return;
+
+	if (fep->phy->ack_int == NULL)
+		return;
+
+	(*fep->phy->ack_int) (dev);
+}
+
+/* helper function */
+static int mii_negotiated(struct mii_if_info *mii)
+{
+	int advert, lpa, val;
+
+	if (!mii_link_ok(mii))
+		return 0;
+
+	val = (*mii->mdio_read) (mii->dev, mii->phy_id, MII_BMSR);
+	if ((val & BMSR_ANEGCOMPLETE) == 0)
+		return 0;
+
+	advert = (*mii->mdio_read) (mii->dev, mii->phy_id, MII_ADVERTISE);
+	lpa = (*mii->mdio_read) (mii->dev, mii->phy_id, MII_LPA);
+
+	return mii_nway_result(advert & lpa);
+}
+
+void fs_mii_link_status_change_check(struct net_device *dev, int init_media)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	unsigned int media;
+
+	if (mii_check_media(&fep->mii_if, netif_msg_link(fep), init_media) == 0)
+		return;
+
+	media = mii_negotiated(&fep->mii_if);
+
+	if (netif_carrier_ok(dev)) {
+		fs_restart(dev, !!(media & ADVERTISE_FULL),
+			    (media & (ADVERTISE_100FULL | ADVERTISE_100HALF)) ?
+			    100 : 10);
+
+		netif_start_queue(dev);
+	} else {
+		netif_stop_queue(dev);
+
+		fs_stop(dev);
+
+	}
+}
+
+/**********************************************************************************/
+
+int fs_mii_read(struct net_device *dev, int phy_id, int location)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	struct fs_enet_mii_bus *bus = fep->mii_bus;
+
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&bus->mii_lock, flags);
+	ret = (*bus->mii_read)(bus, phy_id, location);
+	spin_unlock_irqrestore(&bus->mii_lock, flags);
+
+	return ret;
+}
+
+void fs_mii_write(struct net_device *dev, int phy_id, int location, int value)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	struct fs_enet_mii_bus *bus = fep->mii_bus;
+	unsigned long flags;
+
+	spin_lock_irqsave(&bus->mii_lock, flags);
+	(*bus->mii_write)(bus, phy_id, location, value);
+	spin_unlock_irqrestore(&bus->mii_lock, flags);
+}
+
+/*****************************************************************************/
+
+/* list of all registered mii buses */
+static LIST_HEAD(fs_mii_bus_list);
+
+static struct fs_enet_mii_bus *lookup_bus(int method, int id)
+{
+	struct list_head *ptr;
+	struct fs_enet_mii_bus *bus;
+
+	list_for_each(ptr, &fs_mii_bus_list) {
+		bus = list_entry(ptr, struct fs_enet_mii_bus, list);
+		if (bus->bus_info->method == method &&
+			bus->bus_info->id == id)
+			return bus;
+	}
+	return NULL;
+}
+
+static struct fs_enet_mii_bus *create_bus(const struct fs_mii_bus_info *bi)
+{
+	struct fs_enet_mii_bus *bus;
+	int ret = 0;
+
+	bus = kmalloc(sizeof(*bus), GFP_KERNEL);
+	if (bus == NULL) {
+		ret = -ENOMEM;
+		goto err;
+	}
+	memset(bus, 0, sizeof(*bus));
+	spin_lock_init(&bus->mii_lock);
+	bus->bus_info = bi;
+	bus->refs = 0;
+
+	/* perform initialization */
+	switch (bi->method) {
+
+		case fsmii_fixed:
+			ret = fs_mii_fixed_init(bus);
+			if (ret != 0)
+				goto err;
+			break;
+
+		case fsmii_bitbang:
+			ret = fs_mii_bitbang_init(bus);
+			if (ret != 0)
+				goto err;
+			break;
+#ifdef CONFIG_8xx
+		case fsmii_fec:
+			ret = fs_mii_fec_init(bus);
+			if (ret != 0)
+				goto err;
+			break;
+#endif
+		default:
+			ret = -EINVAL;
+			goto err;
+	}
+
+	list_add(&bus->list, &fs_mii_bus_list);
+
+	return bus;
+
+err:
+	if (bus)
+		kfree(bus);
+	return ERR_PTR(ret);
+}
+
+static void destroy_bus(struct fs_enet_mii_bus *bus)
+{
+	/* remove from bus list */
+	list_del(&bus->list);
+
+	/* nothing more needed */
+	kfree(bus);
+}
+
+int fs_mii_connect(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	const struct fs_platform_info *fpi = fep->fpi;
+	struct fs_enet_mii_bus *bus = NULL;
+
+	/* check method validity */
+	switch (fpi->bus_info->method) {
+		case fsmii_fixed:
+		case fsmii_bitbang:
+			break;
+#ifdef CONFIG_8xx
+		case fsmii_fec:
+			break;
+#endif
+		default:
+			printk(KERN_ERR DRV_MODULE_NAME
+			       ": %s Unknown MII bus method (%d)!\n",
+			       dev->name, fpi->bus_info->method);
+			return -EINVAL; 
+	}
+
+	bus = lookup_bus(fpi->bus_info->method, fpi->bus_info->id);
+
+	/* if not found create new bus */
+	if (bus == NULL) {
+		bus = create_bus(fpi->bus_info);
+		if (IS_ERR(bus)) {
+			printk(KERN_ERR DRV_MODULE_NAME
+			       ": %s MII bus creation failure!\n", dev->name);
+			return PTR_ERR(bus);
+		}
+	}
+
+	bus->refs++;
+
+	fep->mii_bus = bus;
+
+	fep->mii_if.dev = dev;
+	fep->mii_if.phy_id_mask = 0x1f;
+	fep->mii_if.reg_num_mask = 0x1f;
+	fep->mii_if.mdio_read = fs_mii_read;
+	fep->mii_if.mdio_write = fs_mii_write;
+	fep->mii_if.phy_id = phy_id_detect(dev);
+
+	return 0;
+}
+
+void fs_mii_disconnect(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	struct fs_enet_mii_bus *bus = NULL;
+
+	bus = fep->mii_bus;
+	fep->mii_bus = NULL;
+
+	if (--bus->refs <= 0)
+		destroy_bus(bus);
+}
--- /dev/null
+++ linux-2.6.11.7-fs_enet/drivers/net/fs_enet/fs_enet.h
@@ -0,0 +1,378 @@
+#ifndef FEC_8XX_H
+#define FEC_8XX_H
+
+#include <linux/mii.h>
+#include <linux/netdevice.h>
+#include <linux/types.h>
+#include <linux/version.h>
+#include <linux/list.h>
+
+#include <linux/fs_enet_pd.h>
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
+#include <asm/dma-mapping.h>
+#endif
+
+#ifdef CONFIG_8xx
+#include <asm/commproc.h>
+#endif
+
+#ifdef CONFIG_8260
+#include <asm/cpm2.h>
+#endif
+
+/* hw driver ops */
+struct fs_ops {
+	int (*setup_data)(struct net_device *dev);
+	void (*cleanup_data)(struct net_device *dev);
+	void (*set_promiscuous_mode)(struct net_device *dev);
+	void (*set_multicast_start)(struct net_device *dev);
+	void (*set_multicast_one)(struct net_device *dev, const __u8 *mac);
+	void (*set_multicast_finish)(struct net_device *dev);
+	void (*set_mac_address)(struct net_device *dev);
+	void (*restart)(struct net_device *dev, int duplex, int speed);
+	void (*stop)(struct net_device *dev);
+	void (*pre_request_irq)(struct net_device *dev, int irq);
+	void (*post_free_irq)(struct net_device *dev, int irq);
+	void (*napi_clear_rx_event)(struct net_device *dev);
+	void (*napi_enable_rx)(struct net_device *dev);
+	void (*napi_disable_rx)(struct net_device *dev);
+	void (*rx_bd_done)(struct net_device *dev);
+	void (*tx_kickstart)(struct net_device *dev);
+	__u32 (*get_int_events)(struct net_device *dev);
+	void (*clear_int_events)(struct net_device *dev, __u32 int_events);
+	void (*ev_error)(struct net_device *dev, __u32 int_events);
+	int (*get_regs)(struct net_device *dev, void *p, int *sizep);
+	int (*get_regs_len)(struct net_device *dev);
+	void (*tx_restart)(struct net_device *dev);
+};
+
+#define MII_ADVERTISE_HALF	(ADVERTISE_100HALF | \
+				 ADVERTISE_10HALF | ADVERTISE_CSMA)
+#define MII_ADVERTISE_ALL	(ADVERTISE_100FULL | \
+				 ADVERTISE_10FULL | MII_ADVERTISE_HALF)
+
+/* values for MII phy_status */
+
+#define PHY_CONF_ANE	0x0001	/* 1 auto-negotiation enabled     */
+#define PHY_CONF_LOOP	0x0002	/* 1 loopback mode enabled        */
+#define PHY_CONF_SPMASK	0x00f0	/* mask for speed                 */
+#define PHY_CONF_10HDX	0x0010	/* 10 Mbit half duplex supported  */
+#define PHY_CONF_10FDX	0x0020	/* 10 Mbit full duplex supported  */
+#define PHY_CONF_100HDX	0x0040	/* 100 Mbit half duplex supported */
+#define PHY_CONF_100FDX	0x0080	/* 100 Mbit full duplex supported */
+
+#define PHY_STAT_LINK	0x0100	/* 1 up - 0 down                  */
+#define PHY_STAT_FAULT	0x0200	/* 1 remote fault                 */
+#define PHY_STAT_ANC	0x0400	/* 1 auto-negotiation complete    */
+#define PHY_STAT_SPMASK	0xf000	/* mask for speed                 */
+#define PHY_STAT_10HDX	0x1000	/* 10 Mbit half duplex selected   */
+#define PHY_STAT_10FDX	0x2000	/* 10 Mbit full duplex selected   */
+#define PHY_STAT_100HDX	0x4000	/* 100 Mbit half duplex selected  */
+#define PHY_STAT_100FDX	0x8000	/* 100 Mbit full duplex selected  */
+
+struct phy_info {
+	unsigned int id;
+	const char *name;
+	void (*startup) (struct net_device * dev);
+	void (*shutdown) (struct net_device * dev);
+	void (*ack_int) (struct net_device * dev);
+};
+
+/* The FEC stores dest/src/type, data, and checksum for receive packets.
+ */
+#define MAX_MTU 1508		/* Allow fullsized pppoe packets over VLAN */
+#define MIN_MTU 46		/* this is data size */
+#define CRC_LEN 4
+
+#define PKT_MAXBUF_SIZE		(MAX_MTU+ETH_HLEN+CRC_LEN)
+#define PKT_MINBUF_SIZE		(MIN_MTU+ETH_HLEN+CRC_LEN)
+
+/* Must be a multiple of 4 */
+#define PKT_MAXBLR_SIZE		((PKT_MAXBUF_SIZE+3) & ~3)
+/* This is needed so that invalidate_xxx wont invalidate too much */
+#define ENET_RX_FRSIZE		L1_CACHE_ALIGN(PKT_MAXBUF_SIZE)
+
+struct fs_enet_mii_bus {
+	struct list_head list;
+	spinlock_t mii_lock;
+	const struct fs_mii_bus_info *bus_info;
+	int refs;
+
+	int (*mii_read)(struct fs_enet_mii_bus *bus,
+			int phy_id, int location);
+
+	void (*mii_write)(struct fs_enet_mii_bus *bus,
+			int phy_id, int location, int value);
+
+	union {
+		struct {
+			unsigned int mii_speed;
+			void *fsp;
+		} fec;
+
+		struct {
+			/* note that the actual port size may */
+			/* be different; cpm(s) handle it OK  */
+			__u8 mdio_msk;
+			__u8 *mdio_dir;
+			__u8 *mdio_dat;
+			__u8 mdc_msk;
+			__u8 *mdc_dir;
+			__u8 *mdc_dat;
+		} bitbang;
+
+		struct {
+			__u16 lpa;
+		} fixed;
+	};
+};
+
+int fs_mii_bitbang_init(struct fs_enet_mii_bus *bus);
+int fs_mii_fixed_init(struct fs_enet_mii_bus *bus);
+#ifdef CONFIG_8xx
+int fs_mii_fec_init(struct fs_enet_mii_bus *bus);
+#endif
+
+struct fs_enet_private {
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
+	struct device *dev;	/* pointer back to the device (must be initialized first) */
+#endif
+	spinlock_t lock;	/* during all ops except TX pckt processing */
+	spinlock_t tx_lock;	/* during fs_start_xmit and fs_tx         */
+	const struct fs_platform_info *fpi;
+	const struct fs_ops *ops;
+	int rx_ring, tx_ring;
+	dma_addr_t ring_mem_addr;
+	void *ring_base;
+	struct sk_buff **rx_skbuff;
+	struct sk_buff **tx_skbuff;
+	cbd_t *rx_bd_base;	/* Address of Rx and Tx buffers.    */
+	cbd_t *tx_bd_base;
+	cbd_t *dirty_tx;	/* ring entries to be free()ed.     */
+	cbd_t *cur_rx;
+	cbd_t *cur_tx;
+	int tx_free;
+	struct net_device_stats stats;
+	struct timer_list phy_timer_list;
+	const struct phy_info *phy;
+	__u32 msg_enable;
+	struct mii_if_info mii_if;
+	struct fs_enet_mii_bus *mii_bus;
+
+	/* event masks */
+	__u32 ev_napi_rx;	/* mask of NAPI rx events */
+	__u32 ev_rx;		/* rx event mask          */
+	__u32 ev_tx;		/* tx event mask          */
+	__u32 ev_err;		/* error event mask       */
+
+	__u16 bd_rx_empty;	/* mask of BD rx empty	  */
+	__u16 bd_rx_err;	/* mask of BD rx errors   */
+
+	union {
+		struct {
+			int idx;		/* FEC1 = 0, FEC2 = 1  */
+			void *fsp;		/* hw registers        */
+			__u32 hthi, htlo;	/* state for multicast */
+		} fec;
+
+		struct {
+			int idx;		/* FCC1-3 = 0-2	       */
+			void *fccp;		/* hw registers	       */
+			void *ep;		/* parameter ram       */
+			void *fcccp;		/* hw registers cont.  */
+			__u32 gaddrh, gaddrl;	/* group address       */
+		} fcc;
+	};
+};
+
+/***************************************************************************/
+
+void fs_restart(struct net_device *dev, int duplex, int speed);
+void fs_stop(struct net_device *dev);
+
+/***************************************************************************/
+
+int fs_mii_read(struct net_device *dev, int phy_id, int location);
+void fs_mii_write(struct net_device *dev, int phy_id, int location, int value);
+
+void fs_mii_startup(struct net_device *dev);
+void fs_mii_shutdown(struct net_device *dev);
+void fs_mii_ack_int(struct net_device *dev);
+
+void fs_mii_link_status_change_check(struct net_device *dev, int init_media);
+
+void fs_init_bds(struct net_device *dev);
+void fs_cleanup_bds(struct net_device *dev);
+
+/***************************************************************************/
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+
+int fs_enet_init_one(const struct fs_platform_info *fpi,
+		     struct net_device **devp);
+int fs_enet_cleanup_one(struct net_device *dev);
+
+#endif
+
+/***************************************************************************/
+
+#define DRV_MODULE_NAME		"fs_enet"
+#define PFX DRV_MODULE_NAME	": "
+#define DRV_MODULE_VERSION	"0.1"
+#define DRV_MODULE_RELDATE	"May 6, 2005"
+
+/***************************************************************************/
+
+int fs_enet_platform_init(void);
+void fs_enet_platform_cleanup(void);
+
+/***************************************************************************/
+
+/* buffer descriptor access macros */
+
+/* FEC access macros */
+#if defined(CONFIG_8xx)
+/* for a 8xx __raw_xxx's are sufficient */
+#define __cbd_out32(addr, x)	__raw_writel(x, addr)
+#define __cbd_out16(addr, x)	__raw_writew(x, addr)
+#define __cbd_in32(addr)	__raw_readl(addr)
+#define __cbd_in16(addr)	__raw_readw(addr)
+#else
+/* for others play it safe */
+#define __cbd_out32(addr, x)	out_be32(addr, x)
+#define __cbd_out16(addr, x)	out_be16(addr, x)
+#define __cbd_in32(addr)	in_be32(addr)
+#define __cbd_in16(addr)	in_be16(addr)
+#endif
+
+/* write */
+#define CBDW_SC(_cbd, _sc) 		__cbd_out16(&(_cbd)->cbd_sc, (_sc))
+#define CBDW_DATLEN(_cbd, _datlen)	__cbd_out16(&(_cbd)->cbd_datlen, (_datlen))
+#define CBDW_BUFADDR(_cbd, _bufaddr)	__cbd_out32(&(_cbd)->cbd_bufaddr, (_bufaddr))
+
+/* read */
+#define CBDR_SC(_cbd) 			__cbd_in16(&(_cbd)->cbd_sc)
+#define CBDR_DATLEN(_cbd)		__cbd_in16(&(_cbd)->cbd_datlen)
+#define CBDR_BUFADDR(_cbd)		__cbd_in32(&(_cbd)->cbd_bufaddr)
+
+/* set bits */
+#define CBDS_SC(_cbd, _sc) 		CBDW_SC(_cbd, CBDR_SC(_cbd) | (_sc))
+
+/* clear bits */
+#define CBDC_SC(_cbd, _sc) 		CBDW_SC(_cbd, CBDR_SC(_cbd) & ~(_sc))
+
+/***************************************************************************/
+
+/* kernel compatibility shim */
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
+
+static inline void *
+fs_alloc_coherent(struct fs_enet_private *fep, size_t size,
+		   dma_addr_t *dma_handle, int gfp)
+{
+	return dma_alloc_coherent(fep->dev, size, dma_handle, gfp);
+}
+
+static inline void
+fs_free_coherent(struct fs_enet_private *fep, size_t size,
+		  void *vaddr, dma_addr_t dma_handle)
+{
+	dma_free_coherent(fep->dev, size, vaddr, dma_handle);
+}
+
+static inline dma_addr_t
+fs_dma_to(struct fs_enet_private *fep, void *ptr, size_t size)
+{
+	return dma_map_single(fep->dev, ptr, size, DMA_TO_DEVICE);
+}
+
+static inline dma_addr_t
+fs_dma_from(struct fs_enet_private *fep, void *ptr, size_t size)
+{
+	return dma_map_single(fep->dev, ptr, size, DMA_FROM_DEVICE);
+}
+
+#else
+
+#ifdef CONFIG_NOT_COHERENT_CACHE
+
+static inline void *
+fs_alloc_coherent(struct fs_enet_private *fep, size_t size,
+		   dma_addr_t *dma_handle, int gfp)
+{
+	return consistent_alloc(gfp, size, dma_handle);
+}
+
+static inline void
+fs_free_coherent(struct fs_enet_private *fep, size_t size,
+		  void *vaddr, dma_addr_t dma_handle)
+{
+	consistent_free(vaddr);
+}
+
+static inline dma_addr_t
+fs_dma_to(struct fs_enet_private *fep, void *ptr, size_t size)
+{
+	consistent_sync(ptr, size, PCI_DMA_TODEVICE);
+	return (dma_addr_t)__pa(ptr);
+}
+
+static inline dma_addr_t
+fs_dma_from(struct fs_enet_private *fep, void *ptr, size_t size)
+{
+	consistent_sync(ptr, size, PCI_DMA_FROMDEVICE);
+	return (dma_addr_t)__pa(ptr);
+}
+
+#else
+
+static inline void *
+fs_alloc_coherent(struct fs_enet_private *fep, size_t size,
+		   dma_addr_t *dma_handle, int gfp)
+{
+	void *vaddr;
+
+	vaddr = kmalloc(size, gfp);
+	if (vaddr != NULL)
+		*dma_handle = __pa(vaddr);
+	return vaddr;
+}
+
+static inline void
+fs_free_coherent(struct fs_enet_private *fep, size_t size,
+		  void *vaddr, dma_addr_t dma_handle)
+{
+	kfree(vaddr);
+}
+
+static inline dma_addr_t
+fs_dma_to(struct fs_enet_private *fep, void *ptr, size_t size)
+{
+	return (dma_addr_t)__pa(ptr);
+}
+
+static inline dma_addr_t
+fs_dma_from(struct fs_enet_private *fep, void *ptr, size_t size)
+{
+	return (dma_addr_t)__pa(ptr);
+}
+
+#endif
+
+#endif
+
+/*******************************************************************/
+
+extern const struct fs_ops fs_fec_ops;
+extern const struct fs_ops fs_fcc_ops;
+
+/*******************************************************************/
+
+/* handy pointer to the immap */
+extern void *fs_enet_immap;
+
+/*******************************************************************/
+
+#endif
--- /dev/null
+++ linux-2.6.11.7-fs_enet/include/linux/fs_enet_pd.h
@@ -0,0 +1,96 @@
+#ifndef FS_ENET_PD_H
+#define FS_ENET_PD_H
+
+#include <asm/types.h>
+
+#define FS_ENET_NAME	"fs_enet"
+
+enum fs_id {
+	fsid_fec1,
+	fsid_fec2,
+	fsid_fcc1,
+	fsid_fcc2,
+	fsid_fcc3,
+	fsid_scc1,
+	fsid_scc2,
+	fsid_scc3,
+	fsid_scc4,
+};
+
+#define FS_MAX_INDEX	9
+
+static inline int fs_get_fec_index(enum fs_id id)
+{
+	if (id >= fsid_fec1 && id <= fsid_fec2)
+		return id - fsid_fec1;
+	return -1;
+}
+
+static inline int fs_get_fcc_index(enum fs_id id)
+{
+	if (id >= fsid_fcc1 && id <= fsid_fcc3)
+		return id - fsid_fcc1;
+	return -1;
+}
+
+static inline int fs_get_scc_index(enum fs_id id)
+{
+	if (id >= fsid_scc1 && id <= fsid_scc4)
+		return id - fsid_scc1;
+	return -1;
+}
+
+enum fs_mii_method {
+	fsmii_fixed,
+	fsmii_fec,
+	fsmii_bitbang,
+};
+
+enum fs_ioport {
+	fsiop_porta,
+	fsiop_portb,
+	fsiop_portc,
+	fsiop_portd,
+	fsiop_porte,
+};
+
+struct fs_mii_bus_info {
+	int method;		/* mii method                  */
+	int id;			/* the id of the mii_bus       */
+	union {
+		struct {
+			int duplex;
+			int speed;
+		} fixed;
+
+		struct {
+			/* nothing */
+		} fec;
+
+		struct {
+			int mdio_port;	/* port & bit for MDIO */
+			int mdio_bit;
+			int mdc_port;	/* port & bit for MDC  */
+			int mdc_bit;
+			int delay;	/* delay in us         */
+		} bitbang;
+	} i;
+};
+
+struct fs_platform_info {
+	int fs_no;		/* controller index            */
+	int fs_irq;		/* the irq for the controller  */
+				/* (or -1 for default)         */
+	int phy_addr;		/* the phy address (-1 no phy) */
+	int phy_irq;		/* the phy irq (if it exists)  */
+
+	const struct fs_mii_bus_info *bus_info;
+
+	int rx_ring, tx_ring;	/* number of buffers on rx     */
+	__u8 macaddr[6];	/* mac address                 */
+	int rx_copybreak;	/* limit we copy small frames  */
+	int use_napi;		/* use NAPI                    */
+	int napi_weight;	/* NAPI weight                 */
+};
+
+#endif

--------------070101010002090404010806--
