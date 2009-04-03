Return-Path: <gjb@semihalf.com>
Received: from semihalf.com (semihalf.com [206.130.101.55])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ADA1FDDDA2
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Apr 2009 01:30:09 +1100 (EST)
From: Grzegorz Bernacki <gjb@semihalf.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] fec fix: Use OF 'ethernet' device as a provider of dma ops.
Date: Fri,  3 Apr 2009 16:16:59 +0200
Message-Id: <12387682193290-git-send-email-gjb@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Commit 4ae0ff6 "powerpc: expect all devices calling dma
ops to have archdata set" assumes that all devices use
correct dma ops. However FEC uses dma ops from 'eth'
device which doesn't have proper archdata. This patch
makes FEC use dma operation from OF 'ethernet' device,
similarly to what other drivers (like gianfar) do. 

Signed-off-by: Grzegorz Bernacki <gjb@semihalf.com>
---
This is fix for not working FEC. Mounting root
filesystem via NFS ends up with:

Kernel BUG at c021b788 [verbose debug info unavailable]
Oops: Exception in kernel mode, sig: 5 [#1]
mpc5200-simple-platform
Modules linked in:
NIP: c021b788 LR: c021b758 CTR: 00000000
REGS: c3825d40 TRAP: 0700   Not tainted  (2.6.29-07103-gd0b70e8)
MSR: 00029032 <EE,ME,CE,IR,DR>  CR: 42008048  XER: 20000000
TASK = c3820000[1] 'swapper' THREAD: c3824000
[...]

 drivers/net/fec_mpc52xx.c |   31 +++++++++++++++++++++----------
 1 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/net/fec_mpc52xx.c b/drivers/net/fec_mpc52xx.c
index cd8e98b..960b239 100644
--- a/drivers/net/fec_mpc52xx.c
+++ b/drivers/net/fec_mpc52xx.c
@@ -58,6 +58,8 @@ struct mpc52xx_fec_priv {
 	spinlock_t lock;
 	int msg_enable;
 
+	struct of_device *ofdev;
+
 	/* MDIO link details */
 	int phy_addr;
 	unsigned int phy_speed;
@@ -124,18 +126,23 @@ static int mpc52xx_fec_set_mac_address(struct net_device *dev, void *addr)
 
 static void mpc52xx_fec_free_rx_buffers(struct net_device *dev, struct bcom_task *s)
 {
+	struct mpc52xx_fec_priv *priv = netdev_priv(dev);
+
 	while (!bcom_queue_empty(s)) {
 		struct bcom_fec_bd *bd;
 		struct sk_buff *skb;
 
 		skb = bcom_retrieve_buffer(s, NULL, (struct bcom_bd **)&bd);
-		dma_unmap_single(&dev->dev, bd->skb_pa, skb->len, DMA_FROM_DEVICE);
+		dma_unmap_single(&priv->ofdev->dev, bd->skb_pa, skb->len,
+							DMA_FROM_DEVICE);
 		kfree_skb(skb);
 	}
 }
 
 static int mpc52xx_fec_alloc_rx_buffers(struct net_device *dev, struct bcom_task *rxtsk)
 {
+	struct mpc52xx_fec_priv *priv = netdev_priv(dev);
+
 	while (!bcom_queue_full(rxtsk)) {
 		struct sk_buff *skb;
 		struct bcom_fec_bd *bd;
@@ -150,8 +157,8 @@ static int mpc52xx_fec_alloc_rx_buffers(struct net_device *dev, struct bcom_task
 		bd = (struct bcom_fec_bd *)bcom_prepare_next_buffer(rxtsk);
 
 		bd->status = FEC_RX_BUFFER_SIZE;
-		bd->skb_pa = dma_map_single(&dev->dev, skb->data,
-				FEC_RX_BUFFER_SIZE, DMA_FROM_DEVICE);
+		bd->skb_pa = dma_map_single(&priv->ofdev->dev, skb->data,
+					FEC_RX_BUFFER_SIZE, DMA_FROM_DEVICE);
 
 		bcom_submit_next_buffer(rxtsk, skb);
 	}
@@ -388,7 +395,8 @@ static int mpc52xx_fec_hard_start_xmit(struct sk_buff *skb, struct net_device *d
 		bcom_prepare_next_buffer(priv->tx_dmatsk);
 
 	bd->status = skb->len | BCOM_FEC_TX_BD_TFD | BCOM_FEC_TX_BD_TC;
-	bd->skb_pa = dma_map_single(&dev->dev, skb->data, skb->len, DMA_TO_DEVICE);
+	bd->skb_pa = dma_map_single(&priv->ofdev->dev, skb->data,
+						skb->len, DMA_TO_DEVICE);
 
 	bcom_submit_next_buffer(priv->tx_dmatsk, skb);
 
@@ -430,7 +438,8 @@ static irqreturn_t mpc52xx_fec_tx_interrupt(int irq, void *dev_id)
 		struct bcom_fec_bd *bd;
 		skb = bcom_retrieve_buffer(priv->tx_dmatsk, NULL,
 				(struct bcom_bd **)&bd);
-		dma_unmap_single(&dev->dev, bd->skb_pa, skb->len, DMA_TO_DEVICE);
+		dma_unmap_single(&priv->ofdev->dev, bd->skb_pa, skb->len,
+							DMA_TO_DEVICE);
 
 		dev_kfree_skb_irq(skb);
 	}
@@ -455,7 +464,8 @@ static irqreturn_t mpc52xx_fec_rx_interrupt(int irq, void *dev_id)
 
 		rskb = bcom_retrieve_buffer(priv->rx_dmatsk, &status,
 				(struct bcom_bd **)&bd);
-		dma_unmap_single(&dev->dev, bd->skb_pa, rskb->len, DMA_FROM_DEVICE);
+		dma_unmap_single(&priv->ofdev->dev, bd->skb_pa, rskb->len,
+							DMA_FROM_DEVICE);
 
 		/* Test for errors in received frame */
 		if (status & BCOM_FEC_RX_BD_ERRORS) {
@@ -464,8 +474,9 @@ static irqreturn_t mpc52xx_fec_rx_interrupt(int irq, void *dev_id)
 				bcom_prepare_next_buffer(priv->rx_dmatsk);
 
 			bd->status = FEC_RX_BUFFER_SIZE;
-			bd->skb_pa = dma_map_single(&dev->dev, rskb->data,
-					FEC_RX_BUFFER_SIZE, DMA_FROM_DEVICE);
+			bd->skb_pa = dma_map_single(&priv->ofdev->dev,
+					rskb->data, FEC_RX_BUFFER_SIZE,
+					DMA_FROM_DEVICE);
 
 			bcom_submit_next_buffer(priv->rx_dmatsk, rskb);
 
@@ -499,7 +510,7 @@ static irqreturn_t mpc52xx_fec_rx_interrupt(int irq, void *dev_id)
 			bcom_prepare_next_buffer(priv->rx_dmatsk);
 
 		bd->status = FEC_RX_BUFFER_SIZE;
-		bd->skb_pa = dma_map_single(&dev->dev, skb->data,
+		bd->skb_pa = dma_map_single(&priv->ofdev->dev, skb->data,
 				FEC_RX_BUFFER_SIZE, DMA_FROM_DEVICE);
 
 		bcom_submit_next_buffer(priv->rx_dmatsk, skb);
@@ -910,7 +921,7 @@ mpc52xx_fec_probe(struct of_device *op, const struct of_device_id *match)
 		return -ENOMEM;
 
 	priv = netdev_priv(ndev);
-
+	priv->ofdev = op;
 	/* Reserve FEC control zone */
 	rv = of_address_to_resource(op->node, 0, &mem);
 	if (rv) {
-- 
1.5.2.2
