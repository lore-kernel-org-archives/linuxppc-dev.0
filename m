Return-Path: <SRS0=3oxj=QS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E283C169C4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 14:12:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C23D222B7
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 14:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W2vhLnN1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C23D222B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ynmJ4t3XzDqP5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 01:12:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+9b1dcb6e3a5668f89bb7+5650+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="W2vhLnN1"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ymzG5SY0zDqSc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 00:36:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OU67UmqExT5dbDLu8bHDE6+Vl9G4BxqLG7kR2YT5wQI=; b=W2vhLnN19Nu13V50GW9LM4h7SK
 TAIijLeI2Oav5IYscoHoMxfCTZ1eJafL2K8N8c0nf5WlQrhJtdQNo1hhJWTVog/04KdDQ7e3mTLTr
 VUdnY810D7Xw0twecT62CXUjUV6k7PvHiLROOb0/z8708ETxYZxS285f+3KgHZV/AE0vr0JQuRCGy
 vGoec7KOGC/J78VJg6/9kE3/RXatw345O1ck6ub9EN4lanHAnVYwRzwcnvWpVOR1tby1LxMNrqLE8
 zwVeeDoG8obcLKv40FcmXYAFqveX6d8i7+FhePlUk+/+hmpi/iM0Sa9r9DEHBFZ1a+pMLNyYFzyLS
 A5gDB3uw==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtBl7-0000Nh-SH; Mon, 11 Feb 2019 13:36:30 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 11/12] dma-mapping: handle per-device coherent memory mmap in
 common code
Date: Mon, 11 Feb 2019 14:35:53 +0100
Message-Id: <20190211133554.30055-12-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211133554.30055-1-hch@lst.de>
References: <20190211133554.30055-1-hch@lst.de>
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
Cc: linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
 linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 x86@kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-snps-arc@lists.infradead.org, Lee Jones <lee.jones@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

We handle allocation and freeing in common code, so we should handle
mmap the same way.  Also all users of per-device coherent memory are
exclusive, that is if we can't allocate from the per-device pool we
can't use the system memory either.  Unfold the current
dma_mmap_from_dev_coherent implementation and always use the
per-device pool if it exists.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/mm/dma-mapping-nommu.c |  7 ++--
 arch/arm/mm/dma-mapping.c       |  3 --
 arch/arm64/mm/dma-mapping.c     |  3 --
 include/linux/dma-mapping.h     | 11 ++-----
 kernel/dma/coherent.c           | 58 ++++++++-------------------------
 kernel/dma/internal.h           |  2 ++
 kernel/dma/mapping.c            |  8 ++---
 7 files changed, 24 insertions(+), 68 deletions(-)

diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-mapping-nommu.c
index c72f024f1e82..4eeb7e5d9c07 100644
--- a/arch/arm/mm/dma-mapping-nommu.c
+++ b/arch/arm/mm/dma-mapping-nommu.c
@@ -80,11 +80,8 @@ static int arm_nommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 			      void *cpu_addr, dma_addr_t dma_addr, size_t size,
 			      unsigned long attrs)
 {
-	int ret;
-
-	if (dma_mmap_from_global_coherent(vma, cpu_addr, size, &ret))
-		return ret;
-
+	if (!(attrs & DMA_ATTR_NON_CONSISTENT))
+		return dma_mmap_from_global_coherent(vma, cpu_addr, size);
 	return dma_common_mmap(dev, vma, cpu_addr, dma_addr, size, attrs);
 }
 
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 3c8534904209..e2993e5a7166 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -830,9 +830,6 @@ static int __arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 	unsigned long pfn = dma_to_pfn(dev, dma_addr);
 	unsigned long off = vma->vm_pgoff;
 
-	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
-		return ret;
-
 	if (off < nr_pages && nr_vma_pages <= (nr_pages - off)) {
 		ret = remap_pfn_range(vma, vma->vm_start,
 				      pfn + off,
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 78c0a72f822c..a55be91c1d1a 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -246,9 +246,6 @@ static int __iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 
 	vma->vm_page_prot = arch_dma_mmap_pgprot(dev, vma->vm_page_prot, attrs);
 
-	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
-		return ret;
-
 	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
 		/*
 		 * DMA_ATTR_FORCE_CONTIGUOUS allocations are always remapped,
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 018e37a0870e..ae6fe66f97b7 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -158,17 +158,12 @@ static inline int is_device_dma_capable(struct device *dev)
  * These three functions are only for dma allocator.
  * Don't use them in device drivers.
  */
-int dma_mmap_from_dev_coherent(struct device *dev, struct vm_area_struct *vma,
-			    void *cpu_addr, size_t size, int *ret);
-
 void *dma_alloc_from_global_coherent(size_t size, dma_addr_t *dma_handle);
 void dma_release_from_global_coherent(size_t size, void *vaddr);
 int dma_mmap_from_global_coherent(struct vm_area_struct *vma, void *cpu_addr,
-				  size_t size, int *ret);
+				  size_t size);
 
 #else
-#define dma_mmap_from_dev_coherent(dev, vma, vaddr, order, ret) (0)
-
 static inline void *dma_alloc_from_global_coherent(size_t size,
 						   dma_addr_t *dma_handle)
 {
@@ -177,12 +172,10 @@ static inline void *dma_alloc_from_global_coherent(size_t size,
 
 static inline void dma_release_from_global_coherent(size_t size, void *vaddr)
 {
-	return 0;
 }
 
 static inline int dma_mmap_from_global_coherent(struct vm_area_struct *vma,
-						void *cpu_addr, size_t size,
-						int *ret)
+						void *cpu_addr, size_t size)
 {
 	return 0;
 }
diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index d1da1048e470..d7a27008f228 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -197,60 +197,30 @@ void dma_release_from_global_coherent(size_t size, void *vaddr)
 	__dma_release_from_coherent(dma_coherent_default_memory, size, vaddr);
 }
 
-static int __dma_mmap_from_coherent(struct dma_coherent_mem *mem,
-		struct vm_area_struct *vma, void *vaddr, size_t size, int *ret)
+int __dma_mmap_from_coherent(struct dma_coherent_mem *mem,
+		struct vm_area_struct *vma, void *vaddr, size_t size)
 {
-	if (mem && vaddr >= mem->virt_base && vaddr + size <=
-		   (mem->virt_base + (mem->size << PAGE_SHIFT))) {
-		unsigned long off = vma->vm_pgoff;
-		int start = (vaddr - mem->virt_base) >> PAGE_SHIFT;
-		int user_count = vma_pages(vma);
-		int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-
-		*ret = -ENXIO;
-		if (off < count && user_count <= count - off) {
-			unsigned long pfn = mem->pfn_base + start + off;
-			*ret = remap_pfn_range(vma, vma->vm_start, pfn,
-					       user_count << PAGE_SHIFT,
-					       vma->vm_page_prot);
-		}
-		return 1;
-	}
-	return 0;
-}
+	unsigned long off = vma->vm_pgoff;
+	int start = (vaddr - mem->virt_base) >> PAGE_SHIFT;
+	int user_count = vma_pages(vma);
+	int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 
-/**
- * dma_mmap_from_dev_coherent() - mmap memory from the device coherent pool
- * @dev:	device from which the memory was allocated
- * @vma:	vm_area for the userspace memory
- * @vaddr:	cpu address returned by dma_alloc_from_dev_coherent
- * @size:	size of the memory buffer allocated
- * @ret:	result from remap_pfn_range()
- *
- * This checks whether the memory was allocated from the per-device
- * coherent memory pool and if so, maps that memory to the provided vma.
- *
- * Returns 1 if @vaddr belongs to the device coherent pool and the caller
- * should return @ret, or 0 if they should proceed with mapping memory from
- * generic areas.
- */
-int dma_mmap_from_dev_coherent(struct device *dev, struct vm_area_struct *vma,
-			   void *vaddr, size_t size, int *ret)
-{
-	struct dma_coherent_mem *mem = dev_get_coherent_memory(dev);
-
-	return __dma_mmap_from_coherent(mem, vma, vaddr, size, ret);
+	if (WARN_ON_ONCE(!dma_in_coherent_range(mem, size, vaddr)))
+		return -ENXIO;
+	if (off >= count || user_count > count - off)
+		return -ENXIO;
+	return remap_pfn_range(vma, vma->vm_start, mem->pfn_base + start + off,
+			user_count << PAGE_SHIFT, vma->vm_page_prot);
 }
-EXPORT_SYMBOL(dma_mmap_from_dev_coherent);
 
 int dma_mmap_from_global_coherent(struct vm_area_struct *vma, void *vaddr,
-				   size_t size, int *ret)
+				   size_t size)
 {
 	if (!dma_coherent_default_memory)
 		return 0;
 
 	return __dma_mmap_from_coherent(dma_coherent_default_memory, vma,
-					vaddr, size, ret);
+					vaddr, size);
 }
 
 /*
diff --git a/kernel/dma/internal.h b/kernel/dma/internal.h
index 48a0a71487b1..651a0991777f 100644
--- a/kernel/dma/internal.h
+++ b/kernel/dma/internal.h
@@ -15,5 +15,7 @@ void *__dma_alloc_from_coherent(struct dma_coherent_mem *mem, size_t size,
 		dma_addr_t *dma_handle);
 void __dma_release_from_coherent(struct dma_coherent_mem *mem, size_t size,
 		void *vaddr);
+int __dma_mmap_from_coherent(struct dma_coherent_mem *mem,
+		struct vm_area_struct *vma, void *vaddr, size_t size);
 
 #endif /* _DMA_INTERNAL_H */
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index d3c4363b2143..5f28dc8f9bf4 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -158,13 +158,9 @@ int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
 	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	unsigned long off = vma->vm_pgoff;
 	unsigned long pfn;
-	int ret = -ENXIO;
 
 	vma->vm_page_prot = arch_dma_mmap_pgprot(dev, vma->vm_page_prot, attrs);
 
-	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
-		return ret;
-
 	if (off >= count || user_count > count - off)
 		return -ENXIO;
 
@@ -201,6 +197,10 @@ int dma_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 		unsigned long attrs)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
+	struct dma_coherent_mem *mem = dev_get_coherent_memory(dev);
+
+	if (mem)
+		return __dma_mmap_from_coherent(mem, vma, cpu_addr, size);
 
 	if (!dma_is_direct(ops) && ops->mmap)
 		return ops->mmap(dev, vma, cpu_addr, dma_addr, size, attrs);
-- 
2.20.1

