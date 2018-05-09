Return-Path: <BATV+e0efdd19ce80d487e3da+5372+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40gyfq3wnvzF2PN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2018 00:00:16 +1000 (AEST)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Ed L. Cashin" <ed.cashin@acm.org>, Geoff Levand <geoff@infradead.org>,
 Maxim Levitsky <maximlevitsky@gmail.com>, linux-block@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org,
 sparclinux@vger.kernel.org
Subject: [PATCH 1/7] mtip32xx: don't use block layer bounce buffers
Date: Wed,  9 May 2018 15:59:42 +0200
Message-Id: <20180509135948.20329-2-hch@lst.de>
In-Reply-To: <20180509135948.20329-1-hch@lst.de>
References: <20180509135948.20329-1-hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

mtip32xx just sets the block bounce limit to the dma mask, which means
that the iommu or swiotlb already take care of the bounce buffering,
and the block bouncing can be removed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/mtip32xx/mtip32xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 769c551e3d71..b03bb27dcc58 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3862,7 +3862,6 @@ static int mtip_block_initialize(struct driver_data *dd)
 	blk_queue_max_hw_sectors(dd->queue, 0xffff);
 	blk_queue_max_segment_size(dd->queue, 0x400000);
 	blk_queue_io_min(dd->queue, 4096);
-	blk_queue_bounce_limit(dd->queue, dd->pdev->dma_mask);
 
 	/* Signal trim support */
 	if (dd->trim_supp == true) {
-- 
2.17.0
