Return-Path: <wg@grandegger.com>
Message-ID: <4BB32038.3060200@grandegger.com>
Date: Wed, 31 Mar 2010 12:13:12 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: [RFC-PATCH] fec_mpc52xx: add NAPI support
Content-Type: text/plain; charset=ISO-8859-1
Cc: Roman Fietze <roman.fietze@telemotive.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds NAPI support to the MPC52xx FEC network driver. The main
reason for using NAPI is to solve the problem of system hangs under
heavy packet storms causing interrupt flooding. While NAPI support is
straight-forward, recovering from RX FIFO errors is more delicate.
Actually, under packet storms, the RX FIFO error is triggered, requiring
a full reset of the FEC and the Bestcom tasks. Furthermore, the link
goes down and the only way to recover is to reset the phy as well. To
handle the reset properly, it's performed by a work queue task. The
reset does not really harm because the packets can not be digested
(processed) by the system at that rate anyhow. NAPI can be enabled via
Kconfig parameter CONFIG_FEC_MPC52xx_NAPI. Throughput measurements with
netperf showed almost the same results with and without NAPI.

Signed-off-by: Wolfgang Grandegger <wg@denx.de>
---
 drivers/net/Kconfig           |    7 +++
 drivers/net/fec_mpc52xx.c     |  121 ++++++++++++++++++++++++++++++++++++++++-
 drivers/net/fec_mpc52xx_phy.c |    4 +-
 3 files changed, 127 insertions(+), 5 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 0ba5b8e..b973e28 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -1938,6 +1938,13 @@ config FEC_MPC52xx
 	  Fast Ethernet Controller
 	  If compiled as module, it will be called fec_mpc52xx.
 
+config FEC_MPC52xx_NAPI
+	bool "Use NAPI for MPC52xx FEC driver"
+	depends on FEC_MPC52xx
+	---help---
+	  This option enables NAPI support for the MPC5200's on-chip
+	  Fast Ethernet Controller driver.
+
 config FEC_MPC52xx_MDIO
 	bool "MPC52xx FEC MDIO bus driver"
 	depends on FEC_MPC52xx
diff --git a/drivers/net/fec_mpc52xx.c b/drivers/net/fec_mpc52xx.c
index 0dbd721..bb64a72 100644
--- a/drivers/net/fec_mpc52xx.c
+++ b/drivers/net/fec_mpc52xx.c
@@ -27,6 +27,7 @@
 #include <linux/of_device.h>
 #include <linux/of_mdio.h>
 #include <linux/of_platform.h>
+#include <linux/workqueue.h>
 
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
@@ -44,6 +45,8 @@
 
 #define DRIVER_NAME "mpc52xx-fec"
 
+#define FEC_MPC52xx_NAPI_WEIGHT 64
+
 /* Private driver data structure */
 struct mpc52xx_fec_priv {
 	struct net_device *ndev;
@@ -63,6 +66,10 @@ struct mpc52xx_fec_priv {
 	struct phy_device *phydev;
 	enum phy_state link;
 	int seven_wire_mode;
+#ifdef CONFIG_FEC_MPC52xx_NAPI
+	struct work_struct reset_task;
+	struct napi_struct napi;
+#endif
 };
 
 
@@ -234,6 +241,10 @@ static int mpc52xx_fec_open(struct net_device *dev)
 		phy_start(priv->phydev);
 	}
 
+#ifdef CONFIG_FEC_MPC52xx_NAPI
+	napi_enable(&priv->napi);
+#endif
+
 	if (request_irq(dev->irq, mpc52xx_fec_interrupt, IRQF_SHARED,
 	                DRIVER_NAME "_ctrl", dev)) {
 		dev_err(&dev->dev, "ctrl interrupt request failed\n");
@@ -281,6 +292,9 @@ static int mpc52xx_fec_open(struct net_device *dev)
 		priv->phydev = NULL;
 	}
 
+#ifdef CONFIG_FEC_MPC52xx_NAPI
+	napi_disable(&priv->napi);
+#endif
 	return err;
 }
 
@@ -288,6 +302,10 @@ static int mpc52xx_fec_close(struct net_device *dev)
 {
 	struct mpc52xx_fec_priv *priv = netdev_priv(dev);
 
+#ifdef CONFIG_FEC_MPC52xx_NAPI
+	cancel_work_sync(&priv->reset_task);
+	napi_disable(&priv->napi);
+#endif
 	netif_stop_queue(dev);
 
 	mpc52xx_fec_stop(dev);
@@ -386,10 +404,44 @@ static irqreturn_t mpc52xx_fec_tx_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+#ifdef CONFIG_FEC_MPC52xx_NAPI
 static irqreturn_t mpc52xx_fec_rx_interrupt(int irq, void *dev_id)
 {
 	struct net_device *dev = dev_id;
 	struct mpc52xx_fec_priv *priv = netdev_priv(dev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	/* Disable the RX interrupt */
+	if (napi_schedule_prep(&priv->napi)) {
+		disable_irq_nosync(irq);
+		__napi_schedule(&priv->napi);
+	} else {
+		dev_err(dev->dev.parent, "FEC BUG: interrupt while in poll\n");
+	}
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return IRQ_HANDLED;
+}
+#endif
+
+#ifdef CONFIG_FEC_MPC52xx_NAPI
+static int mpc52xx_fec_rx_poll(struct napi_struct *napi, int budget)
+#else
+static irqreturn_t mpc52xx_fec_rx_interrupt(int irq, void *dev_id)
+#endif
+{
+#ifdef CONFIG_FEC_MPC52xx_NAPI
+	struct mpc52xx_fec_priv *priv =
+		container_of(napi, struct mpc52xx_fec_priv, napi);
+	struct net_device *dev = napi->dev;
+	int pkt_received = 0;
+#else
+	struct net_device *dev = dev_id;
+	struct mpc52xx_fec_priv *priv = netdev_priv(dev);
+#endif
 	struct sk_buff *rskb; /* received sk_buff */
 	struct sk_buff *skb;  /* new sk_buff to enqueue in its place */
 	struct bcom_fec_bd *bd;
@@ -400,7 +452,11 @@ static irqreturn_t mpc52xx_fec_rx_interrupt(int irq, void *dev_id)
 	spin_lock_irqsave(&priv->lock, flags);
 
 	while (bcom_buffer_done(priv->rx_dmatsk)) {
-
+#ifdef CONFIG_FEC_MPC52xx_NAPI
+		if (pkt_received >= budget)
+			break;
+		pkt_received++;
+#endif
 		rskb = bcom_retrieve_buffer(priv->rx_dmatsk, &status,
 					    (struct bcom_bd **)&bd);
 		physaddr = bd->skb_pa;
@@ -437,14 +493,29 @@ static irqreturn_t mpc52xx_fec_rx_interrupt(int irq, void *dev_id)
 		skb_put(rskb, length - 4);	/* length without CRC32 */
 		rskb->dev = dev;
 		rskb->protocol = eth_type_trans(rskb, dev);
+#ifdef CONFIG_FEC_MPC52xx_NAPI
+		netif_receive_skb(rskb);
+#else
 		netif_rx(rskb);
+#endif
 
 		spin_lock_irqsave(&priv->lock, flags);
 	}
 
+#ifdef CONFIG_FEC_MPC52xx_NAPI
+	if (pkt_received < budget) {
+		napi_complete(napi);
+		enable_irq(priv->r_irq);
+	}
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return pkt_received;
+#else
 	spin_unlock_irqrestore(&priv->lock, flags);
 
 	return IRQ_HANDLED;
+#endif
 }
 
 static irqreturn_t mpc52xx_fec_interrupt(int irq, void *dev_id)
@@ -472,9 +543,19 @@ static irqreturn_t mpc52xx_fec_interrupt(int irq, void *dev_id)
 			dev_warn(&dev->dev, "FEC_IEVENT_XFIFO_ERROR\n");
 
 		spin_lock_irqsave(&priv->lock, flags);
+
+#ifdef CONFIG_FEC_MPC52xx_NAPI
+		if (ievent & (FEC_IEVENT_RFIFO_ERROR))
+			bcom_disable(priv->rx_dmatsk);
+		if (ievent & (FEC_IEVENT_XFIFO_ERROR))
+			bcom_disable(priv->tx_dmatsk);
+		netif_stop_queue(dev);
+		schedule_work(&priv->reset_task);
+#else
 		mpc52xx_fec_reset(dev);
-		spin_unlock_irqrestore(&priv->lock, flags);
+#endif
 
+		spin_unlock_irqrestore(&priv->lock, flags);
 		return IRQ_HANDLED;
 	}
 
@@ -734,7 +815,8 @@ static void mpc52xx_fec_stop(struct net_device *dev)
 					priv->rx_dmatsk->outdex);
 		}
 #endif
-	}
+	} else
+		printk("%s: in_interrupt\n", __func__);
 
 	bcom_disable(priv->tx_dmatsk);
 
@@ -742,6 +824,23 @@ static void mpc52xx_fec_stop(struct net_device *dev)
 	out_be32(&fec->ecntrl, in_be32(&fec->ecntrl) & ~FEC_ECNTRL_ETHER_EN);
 }
 
+#ifdef CONFIG_FEC_MPC52xx_NAPI
+static void mpc52xx_fec_reset_task(struct work_struct *work)
+{
+	struct mpc52xx_fec_priv *priv =
+		container_of(work, struct mpc52xx_fec_priv, reset_task);
+	struct net_device *dev = priv->ndev;
+	struct mpc52xx_fec __iomem *fec = priv->fec;
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	mpc52xx_fec_reset(dev);
+	/* Re-enable error counters */
+	out_be32(&fec->mib_control, 0);
+	spin_unlock_irqrestore(&priv->lock, flags);
+}
+#endif
+
 /* reset fec and bestcomm tasks */
 static void mpc52xx_fec_reset(struct net_device *dev)
 {
@@ -757,6 +856,14 @@ static void mpc52xx_fec_reset(struct net_device *dev)
 
 	mpc52xx_fec_hw_init(dev);
 
+#ifdef CONFIG_FEC_MPC52xx_NAPI
+	if (!in_interrupt() && priv->phydev) {
+		phy_stop(priv->phydev);
+		phy_write(priv->phydev, MII_BMCR, BMCR_RESET);
+		phy_start(priv->phydev);
+	}
+#endif
+
 	bcom_fec_rx_reset(priv->rx_dmatsk);
 	bcom_fec_tx_reset(priv->tx_dmatsk);
 
@@ -945,6 +1052,14 @@ mpc52xx_fec_probe(struct of_device *op, const struct of_device_id *match)
 	priv->duplex = DUPLEX_HALF;
 	priv->mdio_speed = ((mpc5xxx_get_bus_frequency(op->node) >> 20) / 5) << 1;
 
+#ifdef CONFIG_FEC_MPC52xx_NAPI
+	INIT_WORK(&priv->reset_task, mpc52xx_fec_reset_task);
+	netif_napi_add(ndev, &priv->napi, mpc52xx_fec_rx_poll,
+		       FEC_MPC52xx_NAPI_WEIGHT);
+	dev_info(&op->dev, "using NAPI with weigth %d\n",
+		 FEC_MPC52xx_NAPI_WEIGHT);
+#endif
+
 	/* The current speed preconfigures the speed of the MII link */
 	prop = of_get_property(op->node, "current-speed", &prop_size);
 	if (prop && (prop_size >= sizeof(u32) * 2)) {
diff --git a/drivers/net/fec_mpc52xx_phy.c b/drivers/net/fec_mpc52xx_phy.c
index ee0f3c6..4f02f8b 100644
--- a/drivers/net/fec_mpc52xx_phy.c
+++ b/drivers/net/fec_mpc52xx_phy.c
@@ -29,7 +29,7 @@ static int mpc52xx_fec_mdio_transfer(struct mii_bus *bus, int phy_id,
 {
 	struct mpc52xx_fec_mdio_priv *priv = bus->priv;
 	struct mpc52xx_fec __iomem *fec;
-	int tries = 3;
+	int tries = 10;
 
 	value |= (phy_id << FEC_MII_DATA_PA_SHIFT) & FEC_MII_DATA_PA_MSK;
 	value |= (reg << FEC_MII_DATA_RA_SHIFT) & FEC_MII_DATA_RA_MSK;
@@ -40,7 +40,7 @@ static int mpc52xx_fec_mdio_transfer(struct mii_bus *bus, int phy_id,
 
 	/* wait for it to finish, this takes about 23 us on lite5200b */
 	while (!(in_be32(&fec->ievent) & FEC_IEVENT_MII) && --tries)
-		msleep(1);
+		udelay(10);
 
 	if (!tries)
 		return -ETIMEDOUT;
-- 
1.6.2.5
