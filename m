Return-Path: <abounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EF5291007D4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Dec 2011 09:48:57 +1100 (EST)
From: Alexandre Bounine <alexandre.bounine@idt.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] rapidio/tsi721: switch to dma_zalloc_coherent
Date: Mon,  5 Dec 2011 17:33:45 -0500
Message-Id: <1323124425-24808-1-git-send-email-alexandre.bounine@idt.com>
Cc: Alexandre Bounine <alexandre.bounine@idt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Replaces pair dma_alloc_coherent()+memset() with new dma_zalloc_coherent()
added by Andrew Morton for kernel version 3.2

Signed-off-by: Alexandre Bounine <alexandre.bounine@idt.com>
---
 drivers/rapidio/devices/tsi721.c |   17 ++++-------------
 1 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/rapidio/devices/tsi721.c b/drivers/rapidio/devices/tsi721.c
index 5225930..514c28c 100644
--- a/drivers/rapidio/devices/tsi721.c
+++ b/drivers/rapidio/devices/tsi721.c
@@ -851,14 +851,12 @@ static int tsi721_doorbell_init(struct tsi721_device *priv)
 	INIT_WORK(&priv->idb_work, tsi721_db_dpc);
 
 	/* Allocate buffer for inbound doorbells queue */
-	priv->idb_base = dma_alloc_coherent(&priv->pdev->dev,
+	priv->idb_base = dma_zalloc_coherent(&priv->pdev->dev,
 				IDB_QSIZE * TSI721_IDB_ENTRY_SIZE,
 				&priv->idb_dma, GFP_KERNEL);
 	if (!priv->idb_base)
 		return -ENOMEM;
 
-	memset(priv->idb_base, 0, IDB_QSIZE * TSI721_IDB_ENTRY_SIZE);
-
 	dev_dbg(&priv->pdev->dev, "Allocated IDB buffer @ %p (phys = %llx)\n",
 		priv->idb_base, (unsigned long long)priv->idb_dma);
 
@@ -904,7 +902,7 @@ static int tsi721_bdma_ch_init(struct tsi721_device *priv, int chnum)
 	 */
 
 	/* Allocate space for DMA descriptors */
-	bd_ptr = dma_alloc_coherent(&priv->pdev->dev,
+	bd_ptr = dma_zalloc_coherent(&priv->pdev->dev,
 					bd_num * sizeof(struct tsi721_dma_desc),
 					&bd_phys, GFP_KERNEL);
 	if (!bd_ptr)
@@ -913,8 +911,6 @@ static int tsi721_bdma_ch_init(struct tsi721_device *priv, int chnum)
 	priv->bdma[chnum].bd_phys = bd_phys;
 	priv->bdma[chnum].bd_base = bd_ptr;
 
-	memset(bd_ptr, 0, bd_num * sizeof(struct tsi721_dma_desc));
-
 	dev_dbg(&priv->pdev->dev, "DMA descriptors @ %p (phys = %llx)\n",
 		bd_ptr, (unsigned long long)bd_phys);
 
@@ -922,7 +918,7 @@ static int tsi721_bdma_ch_init(struct tsi721_device *priv, int chnum)
 	sts_size = (bd_num >= TSI721_DMA_MINSTSSZ) ?
 					bd_num : TSI721_DMA_MINSTSSZ;
 	sts_size = roundup_pow_of_two(sts_size);
-	sts_ptr = dma_alloc_coherent(&priv->pdev->dev,
+	sts_ptr = dma_zalloc_coherent(&priv->pdev->dev,
 				     sts_size * sizeof(struct tsi721_dma_sts),
 				     &sts_phys, GFP_KERNEL);
 	if (!sts_ptr) {
@@ -938,8 +934,6 @@ static int tsi721_bdma_ch_init(struct tsi721_device *priv, int chnum)
 	priv->bdma[chnum].sts_base = sts_ptr;
 	priv->bdma[chnum].sts_size = sts_size;
 
-	memset(sts_ptr, 0, sts_size);
-
 	dev_dbg(&priv->pdev->dev,
 		"desc status FIFO @ %p (phys = %llx) size=0x%x\n",
 		sts_ptr, (unsigned long long)sts_phys, sts_size);
@@ -1400,7 +1394,7 @@ static int tsi721_open_outb_mbox(struct rio_mport *mport, void *dev_id,
 
 	/* Outbound message descriptor status FIFO allocation */
 	priv->omsg_ring[mbox].sts_size = roundup_pow_of_two(entries + 1);
-	priv->omsg_ring[mbox].sts_base = dma_alloc_coherent(&priv->pdev->dev,
+	priv->omsg_ring[mbox].sts_base = dma_zalloc_coherent(&priv->pdev->dev,
 			priv->omsg_ring[mbox].sts_size *
 						sizeof(struct tsi721_dma_sts),
 			&priv->omsg_ring[mbox].sts_phys, GFP_KERNEL);
@@ -1412,9 +1406,6 @@ static int tsi721_open_outb_mbox(struct rio_mport *mport, void *dev_id,
 		goto out_desc;
 	}
 
-	memset(priv->omsg_ring[mbox].sts_base, 0,
-		entries * sizeof(struct tsi721_dma_sts));
-
 	/*
 	 * Configure Outbound Messaging Engine
 	 */
-- 
1.7.6
