Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 85F3ADDDF7
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Dec 2007 17:01:46 +1100 (EST)
Received: from pd2mr5so.prod.shaw.ca (pd2mr5so-qfe3.prod.shaw.ca [10.0.141.8])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JSE004W4RDMGX40@l-daemon> for linuxppc-dev@ozlabs.org;
	Sat, 01 Dec 2007 23:00:58 -0700 (MST)
Received: from pn2ml2so.prod.shaw.ca ([10.0.121.146])
	by pd2mr5so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JSE00BRWRDMLS40@pd2mr5so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Sat, 01 Dec 2007 23:00:59 -0700 (MST)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun Java System Messaging Server 6.2-7.05 (built Sep 5
	2006))
	with ESMTP id <0JSE00E9ORDL1A30@l-daemon> for linuxppc-dev@ozlabs.org;
	Sat, 01 Dec 2007 23:00:58 -0700 (MST)
Date: Sat, 01 Dec 2007 23:00:57 -0700
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] Fix buglets in mpc5200 FEC code that are corrupting memory.
To: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, jonsmirl@gmail.com,
	jgarzik@pobox.com
Message-id: <20071202055937.20940.38500.stgit@trillian.secretlab.ca>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Cc: dwmw2@infradead.org, domen.puncer@telargo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Jon Smirl <jonsmirl@gmail.com>

This is the reason I couldn't get user space started or connect to my
nfs server. Patch is against current linus git.

mpc5200 fec driver is corrupting memory. This patch fixes two bugs
where the wrong skb buffer was being referenced.

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
Acked-by: Domen Puncer <domen.puncer@telargo.com>
Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

Jeff, this one hasn't been picked up for 2.6.24 yet and in needs to go in.

Thanks,
g.

 drivers/net/fec_mpc52xx.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/fec_mpc52xx.c b/drivers/net/fec_mpc52xx.c
index a8a0ee2..ddfcc0b 100644
--- a/drivers/net/fec_mpc52xx.c
+++ b/drivers/net/fec_mpc52xx.c
@@ -422,7 +422,7 @@ static irqreturn_t mpc52xx_fec_rx_interrupt(int irq, void *dev_id)
 
 		rskb = bcom_retrieve_buffer(priv->rx_dmatsk, &status,
 				(struct bcom_bd **)&bd);
-		dma_unmap_single(&dev->dev, bd->skb_pa, skb->len, DMA_FROM_DEVICE);
+		dma_unmap_single(&dev->dev, bd->skb_pa, rskb->len, DMA_FROM_DEVICE);
 
 		/* Test for errors in received frame */
 		if (status & BCOM_FEC_RX_BD_ERRORS) {
@@ -467,7 +467,7 @@ static irqreturn_t mpc52xx_fec_rx_interrupt(int irq, void *dev_id)
 			bcom_prepare_next_buffer(priv->rx_dmatsk);
 
 		bd->status = FEC_RX_BUFFER_SIZE;
-		bd->skb_pa = dma_map_single(&dev->dev, rskb->data,
+		bd->skb_pa = dma_map_single(&dev->dev, skb->data,
 				FEC_RX_BUFFER_SIZE, DMA_FROM_DEVICE);
 
 		bcom_submit_next_buffer(priv->rx_dmatsk, skb);
