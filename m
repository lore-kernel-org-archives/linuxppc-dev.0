Return-Path: <wg@grandegger.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id BFEA3B7069
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jul 2009 19:16:46 +1000 (EST)
Message-ID: <4A5706F8.5090501@grandegger.com>
Date: Fri, 10 Jul 2009 11:16:40 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Bestcomm trouble with NAPI for MPC5200 FEC
References: <4A565423.6010207@grandegger.com>
	<fa686aa40907091422v3e93fc50j5fc30f99077a8df6@mail.gmail.com>
In-Reply-To: <fa686aa40907091422v3e93fc50j5fc30f99077a8df6@mail.gmail.com>
Content-Type: multipart/mixed; boundary="------------060301090504000909090200"
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060301090504000909090200
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Grant Likely wrote:
> On Thu, Jul 9, 2009 at 2:33 PM, Wolfgang Grandegger<wg@grandegger.com> wrote:
>> Hello,
>>
>> I'm currently trying to implement NAPI for the FEC on the MPC5200 to
>> solve the well known problem, that network packet storms can cause
>> interrupt flooding, which may totally block the system.
> 
> Good to hear it!  Thanks for this work.
> 
>> The NAPI
>> implementation, in principle, is straight forward and works
>> well under normal and moderate network load. It just calls disable_irq()
>> in the receive interrupt handler to defer packet processing to the NAPI
>> poll callback, which calls enable_irq() when it has processed all
>> packets. Unfortunately, under heavy network load (packet storm),
>> problems show up:
>>
>> - With DENX 2.4.25, the Bestcomm RX task gets and remains stopped after
>>  a while under additional system load. I have no idea how and when
>>  Bestcom tasks are stopped. In the auto-start mode, the firmware should
>>  poll forever for the next free descriptor block.
>>
>> - With 2.6.31-rc2, the RFIFO error occurs quickly which does reset the
>>  FEC and Bestcomm (unfortunately, this does trigger an oops because
>>  it's called from the interrupt context, but that's another issue).
>>
>> I'm realized that working with Bestcomm is a pain :-( but so far I have
>> little knowledge of the Bestcomm limitations and quirks. Any idea what
>> might go wrong or how to implement NAPI for that FEC properly.
> 
> Yes, I have a few ideas.  First, I suspect that the FEC rx queue isn't
> big enough and I wouldn't be surprised if the RFIFO error is occurring
> because Bestcomm gets overrun.  This scenario needs to be handled more
> gracefully.

First some words concerning NAPI. NAPI is mainly used to improve network
performance by processing network packets in the process context while
reducing interrupt load at the same time. Thereby it also solves the
problem of interrupt flooding, which may totally block the system. Most
(maybe all?) Gigabit Ethernet drivers use NAPI, e.g. ucc_geth. Below I
have attached my preliminary (and not yet complete or even correct)
patch, which should demonstrate how NAPI is supposed to work. The old NAPI
implementation of 2.4 is documented here:

http://lxr.linux.no/linux-old+v2.4.31/Documentation/networking/NAPI_HOWTO.txt.

As the NAPI polling competes with other task/processes, it's clear that
a bigger queue only helps partially.

Wolfgang.


---
 drivers/net/Kconfig       |    7 ++++
 drivers/net/fec_mpc52xx.c |   76 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)

Index: linux-2.6-denx/drivers/net/Kconfig
===================================================================
--- linux-2.6-denx.orig/drivers/net/Kconfig
+++ linux-2.6-denx/drivers/net/Kconfig
@@ -1896,6 +1896,13 @@ config FEC_MPC52xx
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
Index: linux-2.6-denx/drivers/net/fec_mpc52xx.c
===================================================================
--- linux-2.6-denx.orig/drivers/net/fec_mpc52xx.c
+++ linux-2.6-denx/drivers/net/fec_mpc52xx.c
@@ -44,6 +44,8 @@
 
 #define DRIVER_NAME "mpc52xx-fec"
 
+#define FEC_MPC52xx_NAPI_WEIGHT 64
+
 /* Private driver data structure */
 struct mpc52xx_fec_priv {
 	struct net_device *ndev;
@@ -63,6 +65,9 @@ struct mpc52xx_fec_priv {
 	struct phy_device *phydev;
 	enum phy_state link;
 	int seven_wire_mode;
+#ifdef CONFIG_FEC_MPC52xx_NAPI
+	struct napi_struct napi;
+#endif
 };
 
 
@@ -226,6 +231,10 @@ static int mpc52xx_fec_open(struct net_d
 		phy_start(priv->phydev);
 	}
 
+#ifdef CONFIG_FEC_MPC52xx_NAPI
+	napi_enable(&priv->napi);
+#endif
+
 	if (request_irq(dev->irq, &mpc52xx_fec_interrupt, IRQF_SHARED,
 	                DRIVER_NAME "_ctrl", dev)) {
 		dev_err(&dev->dev, "ctrl interrupt request failed\n");
@@ -273,6 +282,9 @@ static int mpc52xx_fec_open(struct net_d
 		priv->phydev = NULL;
 	}
 
+#ifdef CONFIG_FEC_MPC52xx_NAPI
+	napi_disable(&priv->napi);
+#endif
 	return err;
 }
 
@@ -280,6 +292,10 @@ static int mpc52xx_fec_close(struct net_
 {
 	struct mpc52xx_fec_priv *priv = netdev_priv(dev);
 
+#ifdef CONFIG_FEC_MPC52xx_NAPI
+	napi_disable(&priv->napi);
+#endif
+
 	netif_stop_queue(dev);
 
 	mpc52xx_fec_stop(dev);
@@ -379,17 +395,48 @@ static irqreturn_t mpc52xx_fec_tx_interr
 	return IRQ_HANDLED;
 }
 
+#ifdef CONFIG_FEC_MPC52xx_NAPI
 static irqreturn_t mpc52xx_fec_rx_interrupt(int irq, void *dev_id)
 {
 	struct net_device *dev = dev_id;
 	struct mpc52xx_fec_priv *priv = netdev_priv(dev);
 
+	/* Disable the RX interrupt */
+	if (napi_schedule_prep(&priv->napi)) {
+		disable_irq_nosync(irq);
+		__napi_schedule(&priv->napi);
+	} else {
+		dev_err(dev->dev.parent, "FEC BUG: interrupt while in poll\n");
+	}
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
+
 	while (bcom_buffer_done(priv->rx_dmatsk)) {
 		struct sk_buff *skb;
 		struct sk_buff *rskb;
 		struct bcom_fec_bd *bd;
 		u32 status;
 
+#ifdef CONFIG_FEC_MPC52xx_NAPI
+		pkt_received++;
+#endif
 		rskb = bcom_retrieve_buffer(priv->rx_dmatsk, &status,
 				(struct bcom_bd **)&bd);
 		dma_unmap_single(dev->dev.parent, bd->skb_pa, rskb->len,
@@ -410,6 +457,10 @@ static irqreturn_t mpc52xx_fec_rx_interr
 
 			dev->stats.rx_dropped++;
 
+#ifdef CONFIG_FEC_MPC52xx_NAPI
+			if (pkt_received >= budget)
+				break;
+#endif
 			continue;
 		}
 
@@ -425,7 +476,11 @@ static irqreturn_t mpc52xx_fec_rx_interr
 			rskb->dev = dev;
 			rskb->protocol = eth_type_trans(rskb, dev);
 
+#ifdef CONFIG_FEC_MPC52xx_NAPI
+			netif_receive_skb(rskb);
+#else
 			netif_rx(rskb);
+#endif
 		} else {
 			/* Can't get a new one : reuse the same & drop pkt */
 			dev_notice(&dev->dev, "Memory squeeze, dropping packet.\n");
@@ -442,9 +497,23 @@ static irqreturn_t mpc52xx_fec_rx_interr
 				FEC_RX_BUFFER_SIZE, DMA_FROM_DEVICE);
 
 		bcom_submit_next_buffer(priv->rx_dmatsk, skb);
+
+#ifdef CONFIG_FEC_MPC52xx_NAPI
+		if (pkt_received >= budget)
+			break;
+#endif
+	}
+
+#ifdef CONFIG_FEC_MPC52xx_NAPI
+	if (pkt_received < budget) {
+		napi_complete(napi);
+		enable_irq(priv->r_irq);
 	}
 
+	return pkt_received;
+#else
 	return IRQ_HANDLED;
+#endif
 }
 
 static irqreturn_t mpc52xx_fec_interrupt(int irq, void *dev_id)
@@ -950,6 +1019,13 @@ mpc52xx_fec_probe(struct of_device *op, 
 	priv->duplex = DUPLEX_HALF;
 	priv->mdio_speed = ((mpc5xxx_get_bus_frequency(op->node) >> 20) / 5) << 1;
 
+#ifdef CONFIG_FEC_MPC52xx_NAPI
+	netif_napi_add(ndev, &priv->napi, mpc52xx_fec_rx_poll,
+		       FEC_MPC52xx_NAPI_WEIGHT);
+	dev_info(&op->dev, "using NAPI with weigth %d\n",
+		 FEC_MPC52xx_NAPI_WEIGHT);
+#endif
+
 	/* The current speed preconfigures the speed of the MII link */
 	prop = of_get_property(op->node, "current-speed", &prop_size);
 	if (prop && (prop_size >= sizeof(u32) * 2)) {

--------------060301090504000909090200
Content-Type: text/x-diff;
 name="mpc52xx-fec-napi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mpc52xx-fec-napi.patch"

---
 drivers/net/Kconfig       |    7 ++++
 drivers/net/fec_mpc52xx.c |   76 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)

Index: linux-2.6-denx/drivers/net/Kconfig
===================================================================
--- linux-2.6-denx.orig/drivers/net/Kconfig
+++ linux-2.6-denx/drivers/net/Kconfig
@@ -1896,6 +1896,13 @@ config FEC_MPC52xx
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
Index: linux-2.6-denx/drivers/net/fec_mpc52xx.c
===================================================================
--- linux-2.6-denx.orig/drivers/net/fec_mpc52xx.c
+++ linux-2.6-denx/drivers/net/fec_mpc52xx.c
@@ -44,6 +44,8 @@
 
 #define DRIVER_NAME "mpc52xx-fec"
 
+#define FEC_MPC52xx_NAPI_WEIGHT 64
+
 /* Private driver data structure */
 struct mpc52xx_fec_priv {
 	struct net_device *ndev;
@@ -63,6 +65,9 @@ struct mpc52xx_fec_priv {
 	struct phy_device *phydev;
 	enum phy_state link;
 	int seven_wire_mode;
+#ifdef CONFIG_FEC_MPC52xx_NAPI
+	struct napi_struct napi;
+#endif
 };
 
 
@@ -226,6 +231,10 @@ static int mpc52xx_fec_open(struct net_d
 		phy_start(priv->phydev);
 	}
 
+#ifdef CONFIG_FEC_MPC52xx_NAPI
+	napi_enable(&priv->napi);
+#endif
+
 	if (request_irq(dev->irq, &mpc52xx_fec_interrupt, IRQF_SHARED,
 	                DRIVER_NAME "_ctrl", dev)) {
 		dev_err(&dev->dev, "ctrl interrupt request failed\n");
@@ -273,6 +282,9 @@ static int mpc52xx_fec_open(struct net_d
 		priv->phydev = NULL;
 	}
 
+#ifdef CONFIG_FEC_MPC52xx_NAPI
+	napi_disable(&priv->napi);
+#endif
 	return err;
 }
 
@@ -280,6 +292,10 @@ static int mpc52xx_fec_close(struct net_
 {
 	struct mpc52xx_fec_priv *priv = netdev_priv(dev);
 
+#ifdef CONFIG_FEC_MPC52xx_NAPI
+	napi_disable(&priv->napi);
+#endif
+
 	netif_stop_queue(dev);
 
 	mpc52xx_fec_stop(dev);
@@ -379,17 +395,48 @@ static irqreturn_t mpc52xx_fec_tx_interr
 	return IRQ_HANDLED;
 }
 
+#ifdef CONFIG_FEC_MPC52xx_NAPI
 static irqreturn_t mpc52xx_fec_rx_interrupt(int irq, void *dev_id)
 {
 	struct net_device *dev = dev_id;
 	struct mpc52xx_fec_priv *priv = netdev_priv(dev);
 
+	/* Disable the RX interrupt */
+	if (napi_schedule_prep(&priv->napi)) {
+		disable_irq_nosync(irq);
+		__napi_schedule(&priv->napi);
+	} else {
+		dev_err(dev->dev.parent, "FEC BUG: interrupt while in poll\n");
+	}
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
+
 	while (bcom_buffer_done(priv->rx_dmatsk)) {
 		struct sk_buff *skb;
 		struct sk_buff *rskb;
 		struct bcom_fec_bd *bd;
 		u32 status;
 
+#ifdef CONFIG_FEC_MPC52xx_NAPI
+		pkt_received++;
+#endif
 		rskb = bcom_retrieve_buffer(priv->rx_dmatsk, &status,
 				(struct bcom_bd **)&bd);
 		dma_unmap_single(dev->dev.parent, bd->skb_pa, rskb->len,
@@ -410,6 +457,10 @@ static irqreturn_t mpc52xx_fec_rx_interr
 
 			dev->stats.rx_dropped++;
 
+#ifdef CONFIG_FEC_MPC52xx_NAPI
+			if (pkt_received >= budget)
+				break;
+#endif
 			continue;
 		}
 
@@ -425,7 +476,11 @@ static irqreturn_t mpc52xx_fec_rx_interr
 			rskb->dev = dev;
 			rskb->protocol = eth_type_trans(rskb, dev);
 
+#ifdef CONFIG_FEC_MPC52xx_NAPI
+			netif_receive_skb(rskb);
+#else
 			netif_rx(rskb);
+#endif
 		} else {
 			/* Can't get a new one : reuse the same & drop pkt */
 			dev_notice(&dev->dev, "Memory squeeze, dropping packet.\n");
@@ -442,9 +497,23 @@ static irqreturn_t mpc52xx_fec_rx_interr
 				FEC_RX_BUFFER_SIZE, DMA_FROM_DEVICE);
 
 		bcom_submit_next_buffer(priv->rx_dmatsk, skb);
+
+#ifdef CONFIG_FEC_MPC52xx_NAPI
+		if (pkt_received >= budget)
+			break;
+#endif
+	}
+
+#ifdef CONFIG_FEC_MPC52xx_NAPI
+	if (pkt_received < budget) {
+		napi_complete(napi);
+		enable_irq(priv->r_irq);
 	}
 
+	return pkt_received;
+#else
 	return IRQ_HANDLED;
+#endif
 }
 
 static irqreturn_t mpc52xx_fec_interrupt(int irq, void *dev_id)
@@ -950,6 +1019,13 @@ mpc52xx_fec_probe(struct of_device *op, 
 	priv->duplex = DUPLEX_HALF;
 	priv->mdio_speed = ((mpc5xxx_get_bus_frequency(op->node) >> 20) / 5) << 1;
 
+#ifdef CONFIG_FEC_MPC52xx_NAPI
+	netif_napi_add(ndev, &priv->napi, mpc52xx_fec_rx_poll,
+		       FEC_MPC52xx_NAPI_WEIGHT);
+	dev_info(&op->dev, "using NAPI with weigth %d\n",
+		 FEC_MPC52xx_NAPI_WEIGHT);
+#endif
+
 	/* The current speed preconfigures the speed of the MII link */
 	prop = of_get_property(op->node, "current-speed", &prop_size);
 	if (prop && (prop_size >= sizeof(u32) * 2)) {

--------------060301090504000909090200--
