Return-Path: <asierllano@gmail.com>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.149])
	by ozlabs.org (Postfix) with ESMTP id 79ACBB7BBF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 16 Oct 2009 23:00:49 +1100 (EST)
Received: by ey-out-1920.google.com with SMTP id 3so370385eyh.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 16 Oct 2009 05:00:46 -0700 (PDT)
Subject: [PATCH] Found skb leak in mpc5200 fec on rxfifo error
From: Asier Llano Palacios <asierllano@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, Grant Likely <grant.likely@secretlab.ca>
Content-Type: text/plain
Date: Fri, 16 Oct 2009 14:01:37 +0200
Message-Id: <1255694497.4683.163.camel@allano>
Mime-Version: 1.0
Cc: a.arzuaga@ziv.es
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(I'm sorry about my previous message with a legal notice, this time
I resent it with another mail server that doesn't include the legal
notice for me)

Hi all,

I finally found why in my mpc5200 based system (and in the lite5200) I
had leaks of skbs when receiving ethernet traffic at 100 Mbit/s so that
we generated an rxfifo error (to be able to get it I even reduced the
speed of the CPU using the PLL jumpers).

The problem was:

The reception packets are handled in the interrupt handler:
mpc52xx_fec_rx_interrupt. So this interrupt is being handled all the
time because we are receiving packets continuously.

The reception fifo errors are handled in the interrupt handler:
mpc52xx_fec_interrupt. This interruption is being handled very often
because we are receiving more packets that what we can handle, and that
generates a fifo reception error.

So it is very usual that the mpc52xx_fec_interrupt handler is executed
at the middle of the mpc52xx_fec_rx_interrupt handler. And I think that
it is not designed for that purpose.

The mpc52xx_fec_rx_interrupt uses bcom_retrieve_buffer and
bcom_submit_next_buffer. The mpc52xx_fec_interrupt calls to
mpc52xx_fec_reset which calls to mpc52xx_fec_free_rx_buffers and
mpc52xx_fec_alloc_rx_buffers, which at the end call bcom_retrieve_buffer
and bcom_submit_next_buffer.

Then we have two problems because of the same origin:
 - bcom_retrieve_buffer and bcom_submit_next_buffer doesn't seem to be
   atomic, so they cannot be called from one interrupt nested from
   another one being executing those functions.
 - Even if they were atomic, the mpc52xx_fec_rx_interrupt and the
   mpc52xx_fec_reset functions are not intended to be called at the
   same time.

Patch I managed to do:
 I've managed to perform a patch that avoids the leak disabling the
 irqs, but I have a remaining problem: The last  packet to be transmited
 is waiting for a packet to be received in order to egress (I don't know
 why but I detected it experimentaly).
 
Anyone with more experience can tell me what's wrong in this patch?

Thank you in advance,
Asier

Signed-off-by: Asier Llano <a.llano@ziv.es>
---
 drivers/net/fec_mpc52xx.c |   23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff -urpN linux-2.6.31.2/drivers/net/fec_mpc52xx.c
linux-2.6.31.2-fec_mpc52xx_skb_leak/drivers/net/fec_mpc52xx.c
================================================================
--- linux-2.6.31.2/drivers/net/fec_mpc52xx.c
+++ linux-2.6.31.2-fec_mpc52xx_skb_leak/drivers/net/fec_mpc52xx.c
@@ -85,13 +85,20 @@ MODULE_PARM_DESC(debug, "debugging messa
 
 static void mpc52xx_fec_tx_timeout(struct net_device *dev)
 {
+	struct mpc52xx_fec_priv *priv = netdev_priv(dev);
+	unsigned long flags;
+
 	dev_warn(&dev->dev, "transmit timed out\n");
 
+	spin_lock_irqsave(&priv->lock, flags);
+
 	mpc52xx_fec_reset(dev);
 
 	dev->stats.tx_errors++;
 
 	netif_wake_queue(dev);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
 }
 
 static void mpc52xx_fec_set_paddr(struct net_device *dev, u8 *mac)
@@ -359,8 +366,9 @@ static irqreturn_t mpc52xx_fec_tx_interr
 {
 	struct net_device *dev = dev_id;
 	struct mpc52xx_fec_priv *priv = netdev_priv(dev);
+	unsigned long flags;
 
-	spin_lock(&priv->lock);
+	spin_lock_irqsave(&priv->lock, flags);
 
 	while (bcom_buffer_done(priv->tx_dmatsk)) {
 		struct sk_buff *skb;
@@ -375,7 +383,7 @@ static irqreturn_t mpc52xx_fec_tx_interr
 
 	netif_wake_queue(dev);
 
-	spin_unlock(&priv->lock);
+	spin_unlock_irqrestore(&priv->lock, flags);
 
 	return IRQ_HANDLED;
 }
@@ -384,6 +392,9 @@ static irqreturn_t mpc52xx_fec_rx_interr
 {
 	struct net_device *dev = dev_id;
 	struct mpc52xx_fec_priv *priv = netdev_priv(dev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
 
 	while (bcom_buffer_done(priv->rx_dmatsk)) {
 		struct sk_buff *skb;
@@ -445,6 +456,8 @@ static irqreturn_t mpc52xx_fec_rx_interr
 		bcom_submit_next_buffer(priv->rx_dmatsk, skb);
 	}
 
+	spin_unlock_irqrestore(&priv->lock, flags);
+
 	return IRQ_HANDLED;
 }
 
@@ -454,6 +467,7 @@ static irqreturn_t mpc52xx_fec_interrupt
 	struct mpc52xx_fec_priv *priv = netdev_priv(dev);
 	struct mpc52xx_fec __iomem *fec = priv->fec;
 	u32 ievent;
+	unsigned long flags;
 
 	ievent = in_be32(&fec->ievent);
 
@@ -471,9 +485,14 @@ static irqreturn_t mpc52xx_fec_interrupt
 		if (net_ratelimit() && (ievent & FEC_IEVENT_XFIFO_ERROR))
 			dev_warn(&dev->dev, "FEC_IEVENT_XFIFO_ERROR\n");
 
+		spin_lock_irqsave(&priv->lock, flags);
+
 		mpc52xx_fec_reset(dev);
 
 		netif_wake_queue(dev);
+
+		spin_unlock_irqrestore(&priv->lock, flags);
+
 		return IRQ_HANDLED;
 	}
 
