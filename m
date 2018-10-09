Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E64EC64EB8
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 15:14:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6875213A2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 15:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s9heitGh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6875213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42V0ss4zdRzF37v
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 02:05:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="s9heitGh";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+39c443e67938b060f200+5525+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="s9heitGh"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Tz2g534mzDrMC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 00:43:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1Tr53rfJav7zdbLlOHDxxRmJt13SOgc6G8e+yA/ZzXg=; b=s9heitGhgfyQTY10/J4RDtoSTw
 m2mE5+9yvK9ZeVOtBbMrT4kUDD2Y/Fs9vKb5RYZOKvGec9wz7tYjR3YrjY+y0IqDDa6PBdSIqeNwP
 KlKxUp5zl8mfwGAa0r96pi+64gOmv6yt+jAl5aiMJUNqHEglg5vMondBQQm2qO29ibrAnNlyV/JaN
 EofNDQn2P9XjIlp+ijSoDOBs2Z16Y6dZ3zsF0nLjEo7Fc8+fo7ZJWqADH3MrMZDFCvVGIlHLpfh4R
 J7CfzS0+VnDe5VzO9RH2b5H8EIDBqGbeQ/6e3N8ydrOJjvOllpx8xcODugO2FjXyM73PMWzOYdaum
 a8Z7Z49g==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g9s0k-00018r-T9; Tue, 09 Oct 2018 13:25:19 +0000
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 07/33] powerpc/dma: untangle vio_dma_mapping_ops from
 dma_iommu_ops
Date: Tue,  9 Oct 2018 15:24:34 +0200
Message-Id: <20181009132500.17643-8-hch@lst.de>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181009132500.17643-1-hch@lst.de>
References: <20181009132500.17643-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

vio_dma_mapping_ops currently does a lot of indirect calls through
dma_iommu_ops, which not only make the code harder to follow but are
also expensive in the post-spectre world.  Unwind the indirect calls
by calling the ppc_iommu_* or iommu_* APIs directly applicable, or
just use the dma_iommu_* methods directly where we can.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/include/asm/iommu.h     |  1 +
 arch/powerpc/kernel/dma-iommu.c      |  2 +-
 arch/powerpc/platforms/pseries/vio.c | 87 ++++++++++++----------------
 3 files changed, 38 insertions(+), 52 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index ab3a4fba38e3..26b7cc176a99 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -244,6 +244,7 @@ static inline int __init tce_iommu_bus_notifier_init(void)
 }
 #endif /* !CONFIG_IOMMU_API */
 
+u64 dma_iommu_get_required_mask(struct device *dev);
 int dma_iommu_mapping_error(struct device *dev, dma_addr_t dma_addr);
 
 #else
diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
index 2ca6cfaebf65..0613278abf9f 100644
--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -92,7 +92,7 @@ int dma_iommu_dma_supported(struct device *dev, u64 mask)
 		return 1;
 }
 
-static u64 dma_iommu_get_required_mask(struct device *dev)
+u64 dma_iommu_get_required_mask(struct device *dev)
 {
 	struct iommu_table *tbl = get_iommu_table_base(dev);
 	u64 mask;
diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platforms/pseries/vio.c
index 49e04ec19238..1dfff53ebd7f 100644
--- a/arch/powerpc/platforms/pseries/vio.c
+++ b/arch/powerpc/platforms/pseries/vio.c
@@ -492,7 +492,9 @@ static void *vio_dma_iommu_alloc_coherent(struct device *dev, size_t size,
 		return NULL;
 	}
 
-	ret = dma_iommu_ops.alloc(dev, size, dma_handle, flag, attrs);
+	ret = iommu_alloc_coherent(dev, get_iommu_table_base(dev), size,
+				    dma_handle, dev->coherent_dma_mask, flag,
+				    dev_to_node(dev));
 	if (unlikely(ret == NULL)) {
 		vio_cmo_dealloc(viodev, roundup(size, PAGE_SIZE));
 		atomic_inc(&viodev->cmo.allocs_failed);
@@ -507,8 +509,7 @@ static void vio_dma_iommu_free_coherent(struct device *dev, size_t size,
 {
 	struct vio_dev *viodev = to_vio_dev(dev);
 
-	dma_iommu_ops.free(dev, size, vaddr, dma_handle, attrs);
-
+	iommu_free_coherent(get_iommu_table_base(dev), size, vaddr, dma_handle);
 	vio_cmo_dealloc(viodev, roundup(size, PAGE_SIZE));
 }
 
@@ -518,22 +519,22 @@ static dma_addr_t vio_dma_iommu_map_page(struct device *dev, struct page *page,
                                          unsigned long attrs)
 {
 	struct vio_dev *viodev = to_vio_dev(dev);
-	struct iommu_table *tbl;
+	struct iommu_table *tbl = get_iommu_table_base(dev);
 	dma_addr_t ret = IOMMU_MAPPING_ERROR;
 
-	tbl = get_iommu_table_base(dev);
-	if (vio_cmo_alloc(viodev, roundup(size, IOMMU_PAGE_SIZE(tbl)))) {
-		atomic_inc(&viodev->cmo.allocs_failed);
-		return ret;
-	}
-
-	ret = dma_iommu_ops.map_page(dev, page, offset, size, direction, attrs);
-	if (unlikely(dma_mapping_error(dev, ret))) {
-		vio_cmo_dealloc(viodev, roundup(size, IOMMU_PAGE_SIZE(tbl)));
-		atomic_inc(&viodev->cmo.allocs_failed);
-	}
-
+	if (vio_cmo_alloc(viodev, roundup(size, IOMMU_PAGE_SIZE(tbl))))
+		goto out_fail;
+	ret = iommu_map_page(dev, tbl, page, offset, size, device_to_mask(dev),
+			direction, attrs);
+	if (unlikely(ret == IOMMU_MAPPING_ERROR))
+		goto out_deallocate;
 	return ret;
+
+out_deallocate:
+	vio_cmo_dealloc(viodev, roundup(size, IOMMU_PAGE_SIZE(tbl)));
+out_fail:
+	atomic_inc(&viodev->cmo.allocs_failed);
+	return IOMMU_MAPPING_ERROR;
 }
 
 static void vio_dma_iommu_unmap_page(struct device *dev, dma_addr_t dma_handle,
@@ -542,11 +543,9 @@ static void vio_dma_iommu_unmap_page(struct device *dev, dma_addr_t dma_handle,
 				     unsigned long attrs)
 {
 	struct vio_dev *viodev = to_vio_dev(dev);
-	struct iommu_table *tbl;
-
-	tbl = get_iommu_table_base(dev);
-	dma_iommu_ops.unmap_page(dev, dma_handle, size, direction, attrs);
+	struct iommu_table *tbl = get_iommu_table_base(dev);
 
+	iommu_unmap_page(tbl, dma_handle, size, direction, attrs);
 	vio_cmo_dealloc(viodev, roundup(size, IOMMU_PAGE_SIZE(tbl)));
 }
 
@@ -555,34 +554,32 @@ static int vio_dma_iommu_map_sg(struct device *dev, struct scatterlist *sglist,
                                 unsigned long attrs)
 {
 	struct vio_dev *viodev = to_vio_dev(dev);
-	struct iommu_table *tbl;
+	struct iommu_table *tbl = get_iommu_table_base(dev);
 	struct scatterlist *sgl;
 	int ret, count;
 	size_t alloc_size = 0;
 
-	tbl = get_iommu_table_base(dev);
 	for_each_sg(sglist, sgl, nelems, count)
 		alloc_size += roundup(sgl->length, IOMMU_PAGE_SIZE(tbl));
 
-	if (vio_cmo_alloc(viodev, alloc_size)) {
-		atomic_inc(&viodev->cmo.allocs_failed);
-		return 0;
-	}
-
-	ret = dma_iommu_ops.map_sg(dev, sglist, nelems, direction, attrs);
-
-	if (unlikely(!ret)) {
-		vio_cmo_dealloc(viodev, alloc_size);
-		atomic_inc(&viodev->cmo.allocs_failed);
-		return ret;
-	}
+	if (vio_cmo_alloc(viodev, alloc_size))
+		goto out_fail;
+	ret = ppc_iommu_map_sg(dev, tbl, sglist, nelems, device_to_mask(dev),
+			direction, attrs);
+	if (unlikely(!ret))
+		goto out_deallocate;
 
 	for_each_sg(sglist, sgl, ret, count)
 		alloc_size -= roundup(sgl->dma_length, IOMMU_PAGE_SIZE(tbl));
 	if (alloc_size)
 		vio_cmo_dealloc(viodev, alloc_size);
-
 	return ret;
+
+out_deallocate:
+	vio_cmo_dealloc(viodev, alloc_size);
+out_fail:
+	atomic_inc(&viodev->cmo.allocs_failed);
+	return 0;
 }
 
 static void vio_dma_iommu_unmap_sg(struct device *dev,
@@ -591,30 +588,18 @@ static void vio_dma_iommu_unmap_sg(struct device *dev,
 		unsigned long attrs)
 {
 	struct vio_dev *viodev = to_vio_dev(dev);
-	struct iommu_table *tbl;
+	struct iommu_table *tbl = get_iommu_table_base(dev);
 	struct scatterlist *sgl;
 	size_t alloc_size = 0;
 	int count;
 
-	tbl = get_iommu_table_base(dev);
 	for_each_sg(sglist, sgl, nelems, count)
 		alloc_size += roundup(sgl->dma_length, IOMMU_PAGE_SIZE(tbl));
 
-	dma_iommu_ops.unmap_sg(dev, sglist, nelems, direction, attrs);
-
+	ppc_iommu_unmap_sg(tbl, sglist, nelems, direction, attrs);
 	vio_cmo_dealloc(viodev, alloc_size);
 }
 
-static int vio_dma_iommu_dma_supported(struct device *dev, u64 mask)
-{
-        return dma_iommu_ops.dma_supported(dev, mask);
-}
-
-static u64 vio_dma_get_required_mask(struct device *dev)
-{
-        return dma_iommu_ops.get_required_mask(dev);
-}
-
 static const struct dma_map_ops vio_dma_mapping_ops = {
 	.alloc             = vio_dma_iommu_alloc_coherent,
 	.free              = vio_dma_iommu_free_coherent,
@@ -623,8 +608,8 @@ static const struct dma_map_ops vio_dma_mapping_ops = {
 	.unmap_sg          = vio_dma_iommu_unmap_sg,
 	.map_page          = vio_dma_iommu_map_page,
 	.unmap_page        = vio_dma_iommu_unmap_page,
-	.dma_supported     = vio_dma_iommu_dma_supported,
-	.get_required_mask = vio_dma_get_required_mask,
+	.dma_supported     = dma_iommu_mapping_error,
+	.get_required_mask = dma_iommu_get_required_mask,
 	.mapping_error	   = dma_iommu_mapping_error,
 };
 
-- 
2.19.0

