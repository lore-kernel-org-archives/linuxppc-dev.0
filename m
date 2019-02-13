Return-Path: <SRS0=t5Ns=QU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47137C282C2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 07:19:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B61B9222C2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 07:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F3fUKv4n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B61B9222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zrVr4p2VzDqHd
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 18:19:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+b68490c3fe13e616ccfb+5652+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="F3fUKv4n"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zr7D1TZKzDqNk
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 18:02:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=a5MW6EskJb0fo8Oz85xGfrcphxbsNTCJZMFr1kNjs50=; b=F3fUKv4n9qcUvp6/qBSEklTEIa
 hFkKKyFTDei3c/rrl+dGlp85JhaJJpPUCcuJXxkauIUz8gMT5hsrYmibHCu3vtQ3vGCCLmNuSPWtT
 8E7u7FHDB0pXhnytkog0RciosrBsukRZzh3SFUcVjBdR4ZoprTJFko5K6kpqIAbqdmQB6R436KXvg
 Pfgn5k/zFX3va3hmJGe8Tj9cI7CIRnaYDGqiolU4hn9Tz3tmkNiYEymyQ1IAaBdVStUYKDTA0Nipr
 vReyuegBDq98wtdz+rSllqb8O6GTRS1+56ej26HTaJRCbSNOkvyGgyllYxcP2HKAmQIObLP2CsNwL
 Sjc7CdMA==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtoYL-0000HV-KV; Wed, 13 Feb 2019 07:01:54 +0000
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Olof Johansson <olof@lixom.net>
Subject: [PATCH 08/32] powerpc/cell: use the generic iommu bypass code
Date: Wed, 13 Feb 2019 08:01:09 +0100
Message-Id: <20190213070133.11259-9-hch@lst.de>
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
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This gets rid of a lot of clumsy code and finally allows us to mark
dma_iommu_ops const.

Includes fixes from Michael Ellerman.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/include/asm/dma-mapping.h |   2 +-
 arch/powerpc/include/asm/iommu.h       |   6 ++
 arch/powerpc/kernel/dma-iommu.c        |   7 +-
 arch/powerpc/platforms/cell/iommu.c    | 140 ++-----------------------
 4 files changed, 20 insertions(+), 135 deletions(-)

diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index ff86b863eceb..1d80174db8a4 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -74,7 +74,7 @@ static inline unsigned long device_to_mask(struct device *dev)
  * Available generic sets of operations
  */
 #ifdef CONFIG_PPC64
-extern struct dma_map_ops dma_iommu_ops;
+extern const struct dma_map_ops dma_iommu_ops;
 #endif
 extern const struct dma_map_ops dma_nommu_ops;
 
diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index bd069a6542ab..6f00a892ebdf 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -319,5 +319,11 @@ extern void iommu_release_ownership(struct iommu_table *tbl);
 extern enum dma_data_direction iommu_tce_direction(unsigned long tce);
 extern unsigned long iommu_direction_to_tce_perm(enum dma_data_direction dir);
 
+#ifdef CONFIG_PPC_CELL_NATIVE
+extern bool iommu_fixed_is_weak;
+#else
+#define iommu_fixed_is_weak false
+#endif
+
 #endif /* __KERNEL__ */
 #endif /* _ASM_IOMMU_H */
diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
index fda92156b194..5a0b5e863b08 100644
--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -20,14 +20,15 @@
  */
 static inline bool dma_iommu_alloc_bypass(struct device *dev)
 {
-	return dev->archdata.iommu_bypass &&
+	return dev->archdata.iommu_bypass && !iommu_fixed_is_weak &&
 		dma_nommu_dma_supported(dev, dev->coherent_dma_mask);
 }
 
 static inline bool dma_iommu_map_bypass(struct device *dev,
 		unsigned long attrs)
 {
-	return dev->archdata.iommu_bypass;
+	return dev->archdata.iommu_bypass &&
+		(!iommu_fixed_is_weak || (attrs & DMA_ATTR_WEAK_ORDERING));
 }
 
 /* Allocates a contiguous real buffer and creates mappings over it.
@@ -163,7 +164,7 @@ u64 dma_iommu_get_required_mask(struct device *dev)
 	return mask;
 }
 
-struct dma_map_ops dma_iommu_ops = {
+const struct dma_map_ops dma_iommu_ops = {
 	.alloc			= dma_iommu_alloc_coherent,
 	.free			= dma_iommu_free_coherent,
 	.mmap			= dma_nommu_mmap_coherent,
diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index 4c609c0db5af..6663cd3e6bb6 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -546,7 +546,7 @@ static unsigned long cell_dma_nommu_offset;
 static unsigned long dma_iommu_fixed_base;
 
 /* iommu_fixed_is_weak is set if booted with iommu_fixed=weak */
-static int iommu_fixed_is_weak;
+bool iommu_fixed_is_weak;
 
 static struct iommu_table *cell_get_iommu_table(struct device *dev)
 {
@@ -568,94 +568,6 @@ static struct iommu_table *cell_get_iommu_table(struct device *dev)
 	return &window->table;
 }
 
-/* A coherent allocation implies strong ordering */
-
-static void *dma_fixed_alloc_coherent(struct device *dev, size_t size,
-				      dma_addr_t *dma_handle, gfp_t flag,
-				      unsigned long attrs)
-{
-	if (iommu_fixed_is_weak)
-		return iommu_alloc_coherent(dev, cell_get_iommu_table(dev),
-					    size, dma_handle,
-					    device_to_mask(dev), flag,
-					    dev_to_node(dev));
-	else
-		return dma_nommu_ops.alloc(dev, size, dma_handle, flag,
-					    attrs);
-}
-
-static void dma_fixed_free_coherent(struct device *dev, size_t size,
-				    void *vaddr, dma_addr_t dma_handle,
-				    unsigned long attrs)
-{
-	if (iommu_fixed_is_weak)
-		iommu_free_coherent(cell_get_iommu_table(dev), size, vaddr,
-				    dma_handle);
-	else
-		dma_nommu_ops.free(dev, size, vaddr, dma_handle, attrs);
-}
-
-static dma_addr_t dma_fixed_map_page(struct device *dev, struct page *page,
-				     unsigned long offset, size_t size,
-				     enum dma_data_direction direction,
-				     unsigned long attrs)
-{
-	if (iommu_fixed_is_weak == (attrs & DMA_ATTR_WEAK_ORDERING))
-		return dma_nommu_ops.map_page(dev, page, offset, size,
-					       direction, attrs);
-	else
-		return iommu_map_page(dev, cell_get_iommu_table(dev), page,
-				      offset, size, device_to_mask(dev),
-				      direction, attrs);
-}
-
-static void dma_fixed_unmap_page(struct device *dev, dma_addr_t dma_addr,
-				 size_t size, enum dma_data_direction direction,
-				 unsigned long attrs)
-{
-	if (iommu_fixed_is_weak == (attrs & DMA_ATTR_WEAK_ORDERING))
-		dma_nommu_ops.unmap_page(dev, dma_addr, size, direction,
-					  attrs);
-	else
-		iommu_unmap_page(cell_get_iommu_table(dev), dma_addr, size,
-				 direction, attrs);
-}
-
-static int dma_fixed_map_sg(struct device *dev, struct scatterlist *sg,
-			   int nents, enum dma_data_direction direction,
-			   unsigned long attrs)
-{
-	if (iommu_fixed_is_weak == (attrs & DMA_ATTR_WEAK_ORDERING))
-		return dma_nommu_ops.map_sg(dev, sg, nents, direction, attrs);
-	else
-		return ppc_iommu_map_sg(dev, cell_get_iommu_table(dev), sg,
-					nents, device_to_mask(dev),
-					direction, attrs);
-}
-
-static void dma_fixed_unmap_sg(struct device *dev, struct scatterlist *sg,
-			       int nents, enum dma_data_direction direction,
-			       unsigned long attrs)
-{
-	if (iommu_fixed_is_weak == (attrs & DMA_ATTR_WEAK_ORDERING))
-		dma_nommu_ops.unmap_sg(dev, sg, nents, direction, attrs);
-	else
-		ppc_iommu_unmap_sg(cell_get_iommu_table(dev), sg, nents,
-				   direction, attrs);
-}
-
-static int dma_suported_and_switch(struct device *dev, u64 dma_mask);
-
-static const struct dma_map_ops dma_iommu_fixed_ops = {
-	.alloc          = dma_fixed_alloc_coherent,
-	.free           = dma_fixed_free_coherent,
-	.map_sg         = dma_fixed_map_sg,
-	.unmap_sg       = dma_fixed_unmap_sg,
-	.dma_supported  = dma_suported_and_switch,
-	.map_page       = dma_fixed_map_page,
-	.unmap_page     = dma_fixed_unmap_page,
-};
-
 static u64 cell_iommu_get_fixed_address(struct device *dev);
 
 static void cell_dma_dev_setup(struct device *dev)
@@ -956,22 +868,10 @@ static u64 cell_iommu_get_fixed_address(struct device *dev)
 	return dev_addr;
 }
 
-static int dma_suported_and_switch(struct device *dev, u64 dma_mask)
+static bool cell_pci_iommu_bypass_supported(struct pci_dev *pdev, u64 mask)
 {
-	if (dma_mask == DMA_BIT_MASK(64) &&
-	    cell_iommu_get_fixed_address(dev) != OF_BAD_ADDR) {
-		dev_dbg(dev, "iommu: 64-bit OK, using fixed ops\n");
-		set_dma_ops(dev, &dma_iommu_fixed_ops);
-		return 1;
-	}
-
-	if (dma_iommu_dma_supported(dev, dma_mask)) {
-		dev_dbg(dev, "iommu: not 64-bit, using default ops\n");
-		set_dma_ops(dev, &dma_iommu_ops);
-		return 1;
-	}
-
-	return 0;
+	return mask == DMA_BIT_MASK(64) &&
+		cell_iommu_get_fixed_address(&pdev->dev) != OF_BAD_ADDR;
 }
 
 static void insert_16M_pte(unsigned long addr, unsigned long *ptab,
@@ -1125,9 +1025,8 @@ static int __init cell_iommu_fixed_mapping_init(void)
 		cell_iommu_setup_window(iommu, np, dbase, dsize, 0);
 	}
 
-	dma_iommu_ops.dma_supported = dma_suported_and_switch;
-	set_pci_dma_ops(&dma_iommu_ops);
-
+	cell_pci_controller_ops.iommu_bypass_supported =
+		cell_pci_iommu_bypass_supported;
 	return 0;
 }
 
@@ -1148,7 +1047,7 @@ static int __init setup_iommu_fixed(char *str)
 	pciep = of_find_node_by_type(NULL, "pcie-endpoint");
 
 	if (strcmp(str, "weak") == 0 || (pciep && strcmp(str, "strong") != 0))
-		iommu_fixed_is_weak = DMA_ATTR_WEAK_ORDERING;
+		iommu_fixed_is_weak = true;
 
 	of_node_put(pciep);
 
@@ -1156,26 +1055,6 @@ static int __init setup_iommu_fixed(char *str)
 }
 __setup("iommu_fixed=", setup_iommu_fixed);
 
-static u64 cell_dma_get_required_mask(struct device *dev)
-{
-	const struct dma_map_ops *dma_ops;
-
-	if (!dev->dma_mask)
-		return 0;
-
-	if (!iommu_fixed_disabled &&
-			cell_iommu_get_fixed_address(dev) != OF_BAD_ADDR)
-		return DMA_BIT_MASK(64);
-
-	dma_ops = get_dma_ops(dev);
-	if (dma_ops->get_required_mask)
-		return dma_ops->get_required_mask(dev);
-
-	WARN_ONCE(1, "no get_required_mask in %p ops", dma_ops);
-
-	return DMA_BIT_MASK(64);
-}
-
 static int __init cell_iommu_init(void)
 {
 	struct device_node *np;
@@ -1192,10 +1071,9 @@ static int __init cell_iommu_init(void)
 
 	/* Setup various callbacks */
 	cell_pci_controller_ops.dma_dev_setup = cell_pci_dma_dev_setup;
-	ppc_md.dma_get_required_mask = cell_dma_get_required_mask;
 
 	if (!iommu_fixed_disabled && cell_iommu_fixed_mapping_init() == 0)
-		goto bail;
+		goto done;
 
 	/* Create an iommu for each /axon node.  */
 	for_each_node_by_name(np, "axon") {
@@ -1212,7 +1090,7 @@ static int __init cell_iommu_init(void)
 			continue;
 		cell_iommu_init_one(np, SPIDER_DMA_OFFSET);
 	}
-
+ done:
 	/* Setup default PCI iommu ops */
 	set_pci_dma_ops(&dma_iommu_ops);
 
-- 
2.20.1

