Return-Path: <SRS0=S6eX=NK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B642EC2BC61
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 11:03:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C99720827
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 11:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C99720827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=popple.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42kpVz0nFbzDrNW
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 22:03:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=popple.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42kpSy5VS9zDrNW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 22:02:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=popple.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42kpSx6Szgz9s7h;
 Tue, 30 Oct 2018 22:02:09 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=popple.id.au
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/npu-dma: Remove NPU DMA ops
Date: Tue, 30 Oct 2018 22:02:03 +1100
Message-Id: <20181030110203.27257-1-alistair@popple.id.au>
X-Mailer: git-send-email 2.11.0
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Alistair Popple <alistair@popple.id.au>, hch@lst.de,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The NPU IOMMU is setup to mirror the parent PCIe device IOMMU
setup. Therefore it does not make sense to call dma operations such as
dma_map_page, etc. directly on these devices. The existing dma-ops
simply print a warning if they are ever called, however this is
unnecessary and the warnings are likely to go unnoticed.

It is instead simpler to remove these operations and let the generic
DMA code print warnings (eg. via a NULL pointer deref) in cases of
buggy drivers attempting dma operations on NVLink devices.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 arch/powerpc/platforms/powernv/npu-dma.c | 64 ++------------------------------
 1 file changed, 4 insertions(+), 60 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index 6f60e0931922..75b935252981 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -102,63 +102,6 @@ struct pci_dev *pnv_pci_get_npu_dev(struct pci_dev *gpdev, int index)
 }
 EXPORT_SYMBOL(pnv_pci_get_npu_dev);

-#define NPU_DMA_OP_UNSUPPORTED()					\
-	dev_err_once(dev, "%s operation unsupported for NVLink devices\n", \
-		__func__)
-
-static void *dma_npu_alloc(struct device *dev, size_t size,
-			   dma_addr_t *dma_handle, gfp_t flag,
-			   unsigned long attrs)
-{
-	NPU_DMA_OP_UNSUPPORTED();
-	return NULL;
-}
-
-static void dma_npu_free(struct device *dev, size_t size,
-			 void *vaddr, dma_addr_t dma_handle,
-			 unsigned long attrs)
-{
-	NPU_DMA_OP_UNSUPPORTED();
-}
-
-static dma_addr_t dma_npu_map_page(struct device *dev, struct page *page,
-				   unsigned long offset, size_t size,
-				   enum dma_data_direction direction,
-				   unsigned long attrs)
-{
-	NPU_DMA_OP_UNSUPPORTED();
-	return 0;
-}
-
-static int dma_npu_map_sg(struct device *dev, struct scatterlist *sglist,
-			  int nelems, enum dma_data_direction direction,
-			  unsigned long attrs)
-{
-	NPU_DMA_OP_UNSUPPORTED();
-	return 0;
-}
-
-static int dma_npu_dma_supported(struct device *dev, u64 mask)
-{
-	NPU_DMA_OP_UNSUPPORTED();
-	return 0;
-}
-
-static u64 dma_npu_get_required_mask(struct device *dev)
-{
-	NPU_DMA_OP_UNSUPPORTED();
-	return 0;
-}
-
-static const struct dma_map_ops dma_npu_ops = {
-	.map_page		= dma_npu_map_page,
-	.map_sg			= dma_npu_map_sg,
-	.alloc			= dma_npu_alloc,
-	.free			= dma_npu_free,
-	.dma_supported		= dma_npu_dma_supported,
-	.get_required_mask	= dma_npu_get_required_mask,
-};
-
 /*
  * Returns the PE assoicated with the PCI device of the given
  * NPU. Returns the linked pci device if pci_dev != NULL.
@@ -270,10 +213,11 @@ static void pnv_npu_dma_set_32(struct pnv_ioda_pe *npe)
 	rc = pnv_npu_set_window(npe, 0, gpe->table_group.tables[0]);

 	/*
-	 * We don't initialise npu_pe->tce32_table as we always use
-	 * dma_npu_ops which are nops.
+	 * NVLink devices use the same TCE table configuration as
+	 * their parent device so drivers shouldn't be doing DMA
+	 * operations directly on these devices.
 	 */
-	set_dma_ops(&npe->pdev->dev, &dma_npu_ops);
+	set_dma_ops(&npe->pdev->dev, NULL);
 }

 /*
--
2.11.0
