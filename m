Return-Path: <R65777@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 437A3B6FA3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2012 15:24:03 +1000 (EST)
From: Bharat Bhushan <r65777@freescale.com>
To: <linux-crypto@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <kim.phillips@freescale.com>
Subject: [PATCH] Using alloc_coherent for caam job rings
Date: Wed, 27 Jun 2012 10:58:32 +0530
Message-ID: <1340774912-19042-1-git-send-email-bharat.bhushan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Bharat Bhushan <bharat.bhushan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Bharat Bhushan <Bharat.Bhushan@freescale.com>

The caam job rings (input/output job ring) are allocated using
dma_map_single(). These job rings can be visualized as the ring
buffers in which the jobs are en-queued/de-queued. The s/w enqueues
the jobs in input job ring which h/w dequeues and after processing
it copies the jobs in output job ring. Software then de-queues the
job from output ring. Using dma_map/unmap_single() is not preferred
way to allocate memory for this type of requirements because this
adds un-necessary complexity.

Example, if bounce buffer (SWIOTLB) will get used then to make any
change visible in this memory to other processing unit requires
dmap_unmap_single() or dma_sync_single_for_cpu/device(). The
dma_unmap_single() can not be used as this will free the bounce
buffer, this will require changing the job rings on running system
and I seriously doubt that it will be not possible or very complex
to implement. Also using dma_sync_single_for_cpu/device() will also
add unnecessary complexity.

The simple and preferred way is using dma_alloc_coherent() for these
type of memory requirements.

This resolves the Linux boot crash issue when "swiotlb=force" is set
in bootargs on systems which have memory more than 4G.

Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
---
This patch is based on "git://git.freescale.com/crypto/cryptodev.git master" 
which have Kim Phillip's "[PATCH 00/20] crypto: caam - driver updates"
patches, which are already sent uptream.

 drivers/crypto/caam/jr.c |   45 +++++++++------------------------------------
 1 files changed, 9 insertions(+), 36 deletions(-)

diff --git a/drivers/crypto/caam/jr.c b/drivers/crypto/caam/jr.c
index 7074a1a..53c8c51 100644
--- a/drivers/crypto/caam/jr.c
+++ b/drivers/crypto/caam/jr.c
@@ -339,10 +339,11 @@ static int caam_jr_init(struct device *dev)
 	if (error)
 		return error;
 
-	jrp->inpring = kzalloc(sizeof(dma_addr_t) * JOBR_DEPTH,
-			       GFP_KERNEL | GFP_DMA);
-	jrp->outring = kzalloc(sizeof(struct jr_outentry) *
-			       JOBR_DEPTH, GFP_KERNEL | GFP_DMA);
+	jrp->inpring = dma_alloc_coherent(dev, sizeof(dma_addr_t) * JOBR_DEPTH,
+					  &inpbusaddr, GFP_KERNEL);
+
+	jrp->outring = dma_alloc_coherent(dev, sizeof(struct jr_outentry) *
+					  JOBR_DEPTH, &outbusaddr, GFP_KERNEL);
 
 	jrp->entinfo = kzalloc(sizeof(struct caam_jrentry_info) * JOBR_DEPTH,
 			       GFP_KERNEL);
@@ -358,31 +359,6 @@ static int caam_jr_init(struct device *dev)
 		jrp->entinfo[i].desc_addr_dma = !0;
 
 	/* Setup rings */
-	inpbusaddr = dma_map_single(dev, jrp->inpring,
-				    sizeof(dma_addr_t) * JOBR_DEPTH,
-				    DMA_BIDIRECTIONAL);
-	if (dma_mapping_error(dev, inpbusaddr)) {
-		dev_err(dev, "caam_jr_init(): can't map input ring\n");
-		kfree(jrp->inpring);
-		kfree(jrp->outring);
-		kfree(jrp->entinfo);
-		return -EIO;
-	}
-
-	outbusaddr = dma_map_single(dev, jrp->outring,
-				    sizeof(struct jr_outentry) * JOBR_DEPTH,
-				    DMA_BIDIRECTIONAL);
-	if (dma_mapping_error(dev, outbusaddr)) {
-		dev_err(dev, "caam_jr_init(): can't map output ring\n");
-		dma_unmap_single(dev, inpbusaddr,
-				 sizeof(dma_addr_t) * JOBR_DEPTH,
-				 DMA_BIDIRECTIONAL);
-		kfree(jrp->inpring);
-		kfree(jrp->outring);
-		kfree(jrp->entinfo);
-		return -EIO;
-	}
-
 	jrp->inp_ring_write_index = 0;
 	jrp->out_ring_read_index = 0;
 	jrp->head = 0;
@@ -426,13 +402,10 @@ int caam_jr_shutdown(struct device *dev)
 	/* Free rings */
 	inpbusaddr = rd_reg64(&jrp->rregs->inpring_base);
 	outbusaddr = rd_reg64(&jrp->rregs->outring_base);
-	dma_unmap_single(dev, outbusaddr,
-			 sizeof(struct jr_outentry) * JOBR_DEPTH,
-			 DMA_BIDIRECTIONAL);
-	dma_unmap_single(dev, inpbusaddr, sizeof(dma_addr_t) * JOBR_DEPTH,
-			 DMA_BIDIRECTIONAL);
-	kfree(jrp->outring);
-	kfree(jrp->inpring);
+	dma_free_coherent(dev, sizeof(dma_addr_t) * JOBR_DEPTH,
+			  jrp->inpring, inpbusaddr);
+	dma_free_coherent(dev, sizeof(struct jr_outentry) * JOBR_DEPTH,
+			  jrp->outring, outbusaddr);
 	kfree(jrp->entinfo);
 
 	return ret;
-- 
1.7.0.4
