Return-Path: <SRS0=t5Ns=QU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFF2C282CE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 07:12:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 828F6222C0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 07:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X2PWMVAE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 828F6222C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zrM44631zDqQs
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 18:12:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+b68490c3fe13e616ccfb+5652+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="X2PWMVAE"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zr725js9zDqHK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 18:02:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=J/hKGnFPZE+pud0QnoTm2VkrxpPTwI7lVWncSLQR168=; b=X2PWMVAE6XcffDAQ+dTS1wyVZe
 2PtUIUcryMShdv6SjUp0TeiYYlk2+JSdArB0uNZVWXff2zavLmgJGcZtAfrOi+9zgHR/4e0ZK0zbY
 dV2yx90KSJ1JNYd4O8RtYlhtb2lgHrtQnqpBYdMgbpzF8ohNi1M7xpuSW668KfXvvEr3oHs3CGEyO
 wm8SiELKtpAXSBjVGHvyq68b3Ir0KnKFOx7XIOYoe5otjHPi3/qj79nlyZybaolUNWrDwBKHjbhRE
 VAVayFeHDsw1KDBd2sJu4z/GQx63FtqP9gAbhlT096U6z+tBEZccqzZAVzD971VfuwESA+x1i+PBC
 RXCN8fXw==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtoYC-0000G6-2t; Wed, 13 Feb 2019 07:01:44 +0000
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Olof Johansson <olof@lixom.net>
Subject: [PATCH 04/32] powerpc/dma: handle iommu bypass in dma_iommu_ops
Date: Wed, 13 Feb 2019 08:01:05 +0100
Message-Id: <20190213070133.11259-5-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213070133.11259-1-hch@lst.de>
References: <20190213070133.11259-1-hch@lst.de>
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
Cc: iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Christian Zigotzky <chzigotzky@xenosoft.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Add a new iommu_bypass flag to struct dev_archdata so that the dma_iommu
implementation can handle the direct mapping transparently instead of
switiching ops around.  Setting of this flag is controlled by new
pci_controller_ops method.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
---
 arch/powerpc/include/asm/device.h      |  5 ++
 arch/powerpc/include/asm/dma-mapping.h |  8 +++
 arch/powerpc/include/asm/pci-bridge.h  |  2 +
 arch/powerpc/kernel/dma-iommu.c        | 70 +++++++++++++++++++++++---
 arch/powerpc/kernel/dma.c              | 19 +++----
 5 files changed, 87 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/include/asm/device.h b/arch/powerpc/include/asm/device.h
index 0245bfcaac32..1aa53318b4bc 100644
--- a/arch/powerpc/include/asm/device.h
+++ b/arch/powerpc/include/asm/device.h
@@ -19,6 +19,11 @@ struct iommu_table;
  * drivers/macintosh/macio_asic.c
  */
 struct dev_archdata {
+	/*
+	 * Set to %true if the dma_iommu_ops are requested to use a direct
+	 * window instead of dynamically mapping memory.
+	 */
+	bool			iommu_bypass : 1;
 	/*
 	 * These two used to be a union. However, with the hybrid ops we need
 	 * both so here we store both a DMA offset for direct mappings and
diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index ebf66809f2d3..ff86b863eceb 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -29,6 +29,14 @@ extern int dma_nommu_mmap_coherent(struct device *dev,
 				    struct vm_area_struct *vma,
 				    void *cpu_addr, dma_addr_t handle,
 				    size_t size, unsigned long attrs);
+int dma_nommu_map_sg(struct device *dev, struct scatterlist *sgl,
+		int nents, enum dma_data_direction direction,
+		unsigned long attrs);
+dma_addr_t dma_nommu_map_page(struct device *dev, struct page *page,
+		unsigned long offset, size_t size,
+		enum dma_data_direction dir, unsigned long attrs);
+int dma_nommu_dma_supported(struct device *dev, u64 mask);
+u64 dma_nommu_get_required_mask(struct device *dev);
 
 #ifdef CONFIG_NOT_COHERENT_CACHE
 /*
diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index aee4fcc24990..d7492dca6599 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -19,6 +19,8 @@ struct device_node;
 struct pci_controller_ops {
 	void		(*dma_dev_setup)(struct pci_dev *pdev);
 	void		(*dma_bus_setup)(struct pci_bus *bus);
+	bool		(*iommu_bypass_supported)(struct pci_dev *pdev,
+				u64 mask);
 
 	int		(*probe_mode)(struct pci_bus *bus);
 
diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
index dd8601cd20df..fda92156b194 100644
--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -6,12 +6,30 @@
  * busses using the iommu infrastructure
  */
 
+#include <linux/dma-direct.h>
+#include <linux/pci.h>
 #include <asm/iommu.h>
 
 /*
  * Generic iommu implementation
  */
 
+/*
+ * The coherent mask may be smaller than the real mask, check if we can
+ * really use a direct window.
+ */
+static inline bool dma_iommu_alloc_bypass(struct device *dev)
+{
+	return dev->archdata.iommu_bypass &&
+		dma_nommu_dma_supported(dev, dev->coherent_dma_mask);
+}
+
+static inline bool dma_iommu_map_bypass(struct device *dev,
+		unsigned long attrs)
+{
+	return dev->archdata.iommu_bypass;
+}
+
 /* Allocates a contiguous real buffer and creates mappings over it.
  * Returns the virtual address of the buffer and sets dma_handle
  * to the dma address (mapping) of the first page.
@@ -20,6 +38,9 @@ static void *dma_iommu_alloc_coherent(struct device *dev, size_t size,
 				      dma_addr_t *dma_handle, gfp_t flag,
 				      unsigned long attrs)
 {
+	if (dma_iommu_alloc_bypass(dev))
+		return __dma_nommu_alloc_coherent(dev, size, dma_handle, flag,
+				attrs);
 	return iommu_alloc_coherent(dev, get_iommu_table_base(dev), size,
 				    dma_handle, dev->coherent_dma_mask, flag,
 				    dev_to_node(dev));
@@ -29,7 +50,11 @@ static void dma_iommu_free_coherent(struct device *dev, size_t size,
 				    void *vaddr, dma_addr_t dma_handle,
 				    unsigned long attrs)
 {
-	iommu_free_coherent(get_iommu_table_base(dev), size, vaddr, dma_handle);
+	if (dma_iommu_alloc_bypass(dev))
+		__dma_nommu_free_coherent(dev, size, vaddr, dma_handle, attrs);
+	else
+		iommu_free_coherent(get_iommu_table_base(dev), size, vaddr,
+				dma_handle);
 }
 
 /* Creates TCEs for a user provided buffer.  The user buffer must be
@@ -42,6 +67,9 @@ static dma_addr_t dma_iommu_map_page(struct device *dev, struct page *page,
 				     enum dma_data_direction direction,
 				     unsigned long attrs)
 {
+	if (dma_iommu_map_bypass(dev, attrs))
+		return dma_nommu_map_page(dev, page, offset, size, direction,
+				attrs);
 	return iommu_map_page(dev, get_iommu_table_base(dev), page, offset,
 			      size, device_to_mask(dev), direction, attrs);
 }
@@ -51,8 +79,9 @@ static void dma_iommu_unmap_page(struct device *dev, dma_addr_t dma_handle,
 				 size_t size, enum dma_data_direction direction,
 				 unsigned long attrs)
 {
-	iommu_unmap_page(get_iommu_table_base(dev), dma_handle, size, direction,
-			 attrs);
+	if (!dma_iommu_map_bypass(dev, attrs))
+		iommu_unmap_page(get_iommu_table_base(dev), dma_handle, size,
+				direction,  attrs);
 }
 
 
@@ -60,6 +89,8 @@ static int dma_iommu_map_sg(struct device *dev, struct scatterlist *sglist,
 			    int nelems, enum dma_data_direction direction,
 			    unsigned long attrs)
 {
+	if (dma_iommu_map_bypass(dev, attrs))
+		return dma_nommu_map_sg(dev, sglist, nelems, direction, attrs);
 	return ppc_iommu_map_sg(dev, get_iommu_table_base(dev), sglist, nelems,
 				device_to_mask(dev), direction, attrs);
 }
@@ -68,10 +99,20 @@ static void dma_iommu_unmap_sg(struct device *dev, struct scatterlist *sglist,
 		int nelems, enum dma_data_direction direction,
 		unsigned long attrs)
 {
-	ppc_iommu_unmap_sg(get_iommu_table_base(dev), sglist, nelems,
+	if (!dma_iommu_map_bypass(dev, attrs))
+		ppc_iommu_unmap_sg(get_iommu_table_base(dev), sglist, nelems,
 			   direction, attrs);
 }
 
+static bool dma_iommu_bypass_supported(struct device *dev, u64 mask)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_controller *phb = pci_bus_to_host(pdev->bus);
+
+	return phb->controller_ops.iommu_bypass_supported &&
+		phb->controller_ops.iommu_bypass_supported(pdev, mask);
+}
+
 /* We support DMA to/from any memory page via the iommu */
 int dma_iommu_dma_supported(struct device *dev, u64 mask)
 {
@@ -83,22 +124,39 @@ int dma_iommu_dma_supported(struct device *dev, u64 mask)
 		return 0;
 	}
 
+	if (dev_is_pci(dev) && dma_iommu_bypass_supported(dev, mask)) {
+		dev->archdata.iommu_bypass = true;
+		dev_dbg(dev, "iommu: 64-bit OK, using fixed ops\n");
+		return 1;
+	}
+
 	if (tbl->it_offset > (mask >> tbl->it_page_shift)) {
 		dev_info(dev, "Warning: IOMMU offset too big for device mask\n");
 		dev_info(dev, "mask: 0x%08llx, table offset: 0x%08lx\n",
 				mask, tbl->it_offset << tbl->it_page_shift);
 		return 0;
-	} else
-		return 1;
+	}
+
+	dev_dbg(dev, "iommu: not 64-bit, using default ops\n");
+	dev->archdata.iommu_bypass = false;
+	return 1;
 }
 
 u64 dma_iommu_get_required_mask(struct device *dev)
 {
 	struct iommu_table *tbl = get_iommu_table_base(dev);
 	u64 mask;
+
 	if (!tbl)
 		return 0;
 
+	if (dev_is_pci(dev)) {
+		u64 bypass_mask = dma_nommu_get_required_mask(dev);
+
+		if (dma_iommu_bypass_supported(dev, bypass_mask))
+			return bypass_mask;
+	}
+
 	mask = 1ULL < (fls_long(tbl->it_offset + tbl->it_size) - 1);
 	mask += mask - 1;
 
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index b1903ebb2e9c..e5db4d3f8bea 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -40,7 +40,7 @@ static u64 __maybe_unused get_pfn_limit(struct device *dev)
 	return pfn;
 }
 
-static int dma_nommu_dma_supported(struct device *dev, u64 mask)
+int dma_nommu_dma_supported(struct device *dev, u64 mask)
 {
 #ifdef CONFIG_PPC64
 	u64 limit = get_dma_offset(dev) + (memblock_end_of_DRAM() - 1);
@@ -178,9 +178,9 @@ int dma_nommu_mmap_coherent(struct device *dev, struct vm_area_struct *vma,
 			       vma->vm_page_prot);
 }
 
-static int dma_nommu_map_sg(struct device *dev, struct scatterlist *sgl,
-			     int nents, enum dma_data_direction direction,
-			     unsigned long attrs)
+int dma_nommu_map_sg(struct device *dev, struct scatterlist *sgl,
+		int nents, enum dma_data_direction direction,
+		unsigned long attrs)
 {
 	struct scatterlist *sg;
 	int i;
@@ -209,7 +209,7 @@ static void dma_nommu_unmap_sg(struct device *dev, struct scatterlist *sgl,
 		__dma_sync_page(sg_page(sg), sg->offset, sg->length, direction);
 }
 
-static u64 dma_nommu_get_required_mask(struct device *dev)
+u64 dma_nommu_get_required_mask(struct device *dev)
 {
 	u64 end, mask;
 
@@ -221,12 +221,9 @@ static u64 dma_nommu_get_required_mask(struct device *dev)
 	return mask;
 }
 
-static inline dma_addr_t dma_nommu_map_page(struct device *dev,
-					     struct page *page,
-					     unsigned long offset,
-					     size_t size,
-					     enum dma_data_direction dir,
-					     unsigned long attrs)
+dma_addr_t dma_nommu_map_page(struct device *dev, struct page *page,
+		unsigned long offset, size_t size,
+		enum dma_data_direction dir, unsigned long attrs)
 {
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		__dma_sync_page(page, offset, size, dir);
-- 
2.20.1

