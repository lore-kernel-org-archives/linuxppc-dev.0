Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id B0E8EDDECA
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 14:02:50 +1000 (EST)
Date: Mon, 22 Oct 2007 23:09:48 -0500
From: Olof Johansson <olof@lixom.net>
To: Jens Axboe <jens.axboe@oracle.com>
Subject: powerpc: Fix fallout from sg_page() changes
Message-ID: <20071023040948.GA19699@lixom.net>
References: <1193076664-13652-1-git-send-email-jens.axboe@oracle.com>
	<1193076664-13652-10-git-send-email-jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1193076664-13652-10-git-send-email-jens.axboe@oracle.com>
Cc: linuxppc-dev@ozlabs.org, mingo@elte.hu, torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix fallout from 18dabf473e15850c0dbc8ff13ac1e2806d542c15:

In file included from include/linux/dma-mapping.h:52,
                 from drivers/base/dma-mapping.c:10:
include/asm/dma-mapping.h: In function 'dma_map_sg':
include/asm/dma-mapping.h:288: error: 'struct scatterlist' has no member named 'page'
include/asm/dma-mapping.h:288: error: 'struct scatterlist' has no member named 'page'
include/asm/dma-mapping.h:288: error: 'struct scatterlist' has no member named 'page'
include/asm/dma-mapping.h:289: error: 'struct scatterlist' has no member named 'page'
include/asm/dma-mapping.h:290: error: 'struct scatterlist' has no member named 'page'
include/asm/dma-mapping.h: In function 'dma_sync_sg_for_cpu':
include/asm/dma-mapping.h:331: error: 'struct scatterlist' has no member named 'page'

drivers/scsi/ps3rom.c: In function 'fetch_to_dev_buffer':
drivers/scsi/ps3rom.c:150: error: 'struct scatterlist' has no member named 'page'



Signed-off-by: Olof Johansson <olof@lixom.net>

diff --git a/include/asm-powerpc/dma-mapping.h b/include/asm-powerpc/dma-mapping.h
index 65be95d..ff52013 100644
--- a/include/asm-powerpc/dma-mapping.h
+++ b/include/asm-powerpc/dma-mapping.h
@@ -285,9 +285,9 @@ dma_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 	BUG_ON(direction == DMA_NONE);
 
 	for_each_sg(sgl, sg, nents, i) {
-		BUG_ON(!sg->page);
-		__dma_sync_page(sg->page, sg->offset, sg->length, direction);
-		sg->dma_address = page_to_bus(sg->page) + sg->offset;
+		BUG_ON(!sg_page(sg));
+		__dma_sync_page(sg_page(sg), sg->offset, sg->length, direction);
+		sg->dma_address = page_to_bus(sg_page(sg)) + sg->offset;
 	}
 
 	return nents;
@@ -328,7 +328,7 @@ static inline void dma_sync_sg_for_cpu(struct device *dev,
 	BUG_ON(direction == DMA_NONE);
 
 	for_each_sg(sgl, sg, nents, i)
-		__dma_sync_page(sg->page, sg->offset, sg->length, direction);
+		__dma_sync_page(sg_page(sg), sg->offset, sg->length, direction);
 }
 
 static inline void dma_sync_sg_for_device(struct device *dev,
@@ -341,7 +341,7 @@ static inline void dma_sync_sg_for_device(struct device *dev,
 	BUG_ON(direction == DMA_NONE);
 
 	for_each_sg(sgl, sg, nents, i)
-		__dma_sync_page(sg->page, sg->offset, sg->length, direction);
+		__dma_sync_page(sg_page(sg), sg->offset, sg->length, direction);
 }
 
 static inline int dma_mapping_error(dma_addr_t dma_addr)
diff --git a/drivers/scsi/ps3rom.c b/drivers/scsi/ps3rom.c
index 03f19b8..17b4a7c 100644
--- a/drivers/scsi/ps3rom.c
+++ b/drivers/scsi/ps3rom.c
@@ -147,7 +147,7 @@ static int fetch_to_dev_buffer(struct scsi_cmnd *cmd, void *buf)
 
 	req_len = fin = 0;
 	scsi_for_each_sg(cmd, sgpnt, scsi_sg_count(cmd), k) {
-		kaddr = kmap_atomic(sg_page(sgpnt->page), KM_IRQ0);
+		kaddr = kmap_atomic(sg_page(sgpnt), KM_IRQ0);
 		len = sgpnt->length;
 		if ((req_len + len) > buflen) {
 			len = buflen - req_len;
