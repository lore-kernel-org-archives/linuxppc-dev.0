Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02138C64EAD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 13:36:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ED4E2087D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 13:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hoBvi551"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ED4E2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42TytP2HkCzF38h
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 00:36:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="hoBvi551";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+39c443e67938b060f200+5525+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42TyfQ2pm6zF38X
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 00:25:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JhfAI7+Q5zQfe4nU3Z7X/NaCUXxeqE67+vUNnRaT5wk=; b=hoBvi551yWbQrBhyCC05HtCkxi
 0nWk7SCLEUlZoNRoiHPAnHHlCGv0MBbCSF7B4q52VGHjc9n8s+FuDLVRLtgGi2OYIlzL5I4jW8tuy
 XVMc4bi5MyqVqSMBiAAVaqB9eMrTegx43PuaRDNSNdrX+nxNIjcbNlHfkWtR8ZOfpuiiXP1TeU4Kr
 S3cBTkZ5Ha/Hqvd47bftzt7+I+7btEQbq4BAWNec8VQme/LLDFm8npYph8wvZSWswFJy7SJPTN708
 Y56MS5ir1qT+JfhqB7+sREezfC2Qi7EPwM94BANpbaY7yEAFdB0JDV4Qahv0QtlYHCtMQ33pDy9G6
 9glo0dwQ==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g9s0n-000199-Ab; Tue, 09 Oct 2018 13:25:21 +0000
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 08/33] powerpc/dma: handle iommu bypass in dma_iommu_ops
Date: Tue,  9 Oct 2018 15:24:35 +0200
Message-Id: <20181009132500.17643-9-hch@lst.de>
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

Add a new iommu_bypass flag to struct dev_archdata so that the dma_iommu
implementation can handle the direct mapping transparently instead of
switiching ops around.  Setting of this flag is controlled by new
pci_controller_ops method.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/include/asm/device.h      |  5 ++
 arch/powerpc/include/asm/dma-mapping.h |  7 +++
 arch/powerpc/include/asm/pci-bridge.h  |  2 +
 arch/powerpc/kernel/dma-iommu.c        | 70 +++++++++++++++++++++++---
 arch/powerpc/kernel/dma.c              | 17 +++----
 5 files changed, 85 insertions(+), 16 deletions(-)

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
index dacd0f93f2b2..27283eb68c50 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -29,6 +29,13 @@ extern int dma_nommu_mmap_coherent(struct device *dev,
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
 
 #ifdef CONFIG_NOT_COHERENT_CACHE
 /*
diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 94d449031b18..5c7a1e7ffc8a 100644
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
index 0613278abf9f..c865e15ad024 100644
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
+		u64 bypass_mask = dma_direct_get_required_mask(dev);
+
+		if (dma_iommu_bypass_supported(dev, bypass_mask))
+			return bypass_mask;
+	}
+
 	mask = 1ULL < (fls_long(tbl->it_offset + tbl->it_size) - 1);
 	mask += mask - 1;
 
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 7078d72baec2..716b7eab3ee7 100644
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
@@ -177,9 +177,9 @@ int dma_nommu_mmap_coherent(struct device *dev, struct vm_area_struct *vma,
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
@@ -209,12 +209,9 @@ static u64 dma_nommu_get_required_mask(struct device *dev)
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
2.19.0

