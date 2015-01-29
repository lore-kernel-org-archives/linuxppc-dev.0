Return-Path: <aik@ozlabs.ru>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 093AC1A0C2F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2015 20:23:09 +1100 (AEDT)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Thu, 29 Jan 2015 19:23:07 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 8AC992CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2015 20:23:05 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0T9Mvq248496722
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2015 20:23:05 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0T9MVw9003482
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2015 20:22:32 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 01/24] vfio: powerpc/spapr: Move page pinning from arch
 code to VFIO IOMMU driver
Date: Thu, 29 Jan 2015 20:21:42 +1100
Message-Id: <1422523325-1389-2-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1422523325-1389-1-git-send-email-aik@ozlabs.ru>
References: <1422523325-1389-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Alexander Gordeev <agordeev@redhat.com>, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This moves page pinning (get_user_pages_fast()/put_page()) code out of
the platform IOMMU code and puts it to VFIO IOMMU driver where it belongs
to as the platform code does not deal with page pinning.

This makes iommu_take_ownership()/iommu_release_ownership() deal with
the IOMMU table bitmap only.

This removes page unpinning from iommu_take_ownership() as the actual
TCE table might contain garbage and doing put_page() on it is undefined
behaviour.

Besides the last part, the rest of the patch is mechanical.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/iommu.h    |  6 ---
 arch/powerpc/kernel/iommu.c         | 68 ---------------------------
 drivers/vfio/vfio_iommu_spapr_tce.c | 91 +++++++++++++++++++++++++++++++------
 3 files changed, 78 insertions(+), 87 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index 9cfa370..45b07f6 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -191,16 +191,10 @@ extern int iommu_tce_build(struct iommu_table *tbl, unsigned long entry,
 		unsigned long hwaddr, enum dma_data_direction direction);
 extern unsigned long iommu_clear_tce(struct iommu_table *tbl,
 		unsigned long entry);
-extern int iommu_clear_tces_and_put_pages(struct iommu_table *tbl,
-		unsigned long entry, unsigned long pages);
-extern int iommu_put_tce_user_mode(struct iommu_table *tbl,
-		unsigned long entry, unsigned long tce);
 
 extern void iommu_flush_tce(struct iommu_table *tbl);
 extern int iommu_take_ownership(struct iommu_table *tbl);
 extern void iommu_release_ownership(struct iommu_table *tbl);
 
-extern enum dma_data_direction iommu_tce_direction(unsigned long tce);
-
 #endif /* __KERNEL__ */
 #endif /* _ASM_IOMMU_H */
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 5d3968c..456acb1 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -903,19 +903,6 @@ void iommu_register_group(struct iommu_table *tbl,
 	kfree(name);
 }
 
-enum dma_data_direction iommu_tce_direction(unsigned long tce)
-{
-	if ((tce & TCE_PCI_READ) && (tce & TCE_PCI_WRITE))
-		return DMA_BIDIRECTIONAL;
-	else if (tce & TCE_PCI_READ)
-		return DMA_TO_DEVICE;
-	else if (tce & TCE_PCI_WRITE)
-		return DMA_FROM_DEVICE;
-	else
-		return DMA_NONE;
-}
-EXPORT_SYMBOL_GPL(iommu_tce_direction);
-
 void iommu_flush_tce(struct iommu_table *tbl)
 {
 	/* Flush/invalidate TLB caches if necessary */
@@ -991,30 +978,6 @@ unsigned long iommu_clear_tce(struct iommu_table *tbl, unsigned long entry)
 }
 EXPORT_SYMBOL_GPL(iommu_clear_tce);
 
-int iommu_clear_tces_and_put_pages(struct iommu_table *tbl,
-		unsigned long entry, unsigned long pages)
-{
-	unsigned long oldtce;
-	struct page *page;
-
-	for ( ; pages; --pages, ++entry) {
-		oldtce = iommu_clear_tce(tbl, entry);
-		if (!oldtce)
-			continue;
-
-		page = pfn_to_page(oldtce >> PAGE_SHIFT);
-		WARN_ON(!page);
-		if (page) {
-			if (oldtce & TCE_PCI_WRITE)
-				SetPageDirty(page);
-			put_page(page);
-		}
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(iommu_clear_tces_and_put_pages);
-
 /*
  * hwaddr is a kernel virtual address here (0xc... bazillion),
  * tce_build converts it to a physical address.
@@ -1044,35 +1007,6 @@ int iommu_tce_build(struct iommu_table *tbl, unsigned long entry,
 }
 EXPORT_SYMBOL_GPL(iommu_tce_build);
 
-int iommu_put_tce_user_mode(struct iommu_table *tbl, unsigned long entry,
-		unsigned long tce)
-{
-	int ret;
-	struct page *page = NULL;
-	unsigned long hwaddr, offset = tce & IOMMU_PAGE_MASK(tbl) & ~PAGE_MASK;
-	enum dma_data_direction direction = iommu_tce_direction(tce);
-
-	ret = get_user_pages_fast(tce & PAGE_MASK, 1,
-			direction != DMA_TO_DEVICE, &page);
-	if (unlikely(ret != 1)) {
-		/* pr_err("iommu_tce: get_user_pages_fast failed tce=%lx ioba=%lx ret=%d\n",
-				tce, entry << tbl->it_page_shift, ret); */
-		return -EFAULT;
-	}
-	hwaddr = (unsigned long) page_address(page) + offset;
-
-	ret = iommu_tce_build(tbl, entry, hwaddr, direction);
-	if (ret)
-		put_page(page);
-
-	if (ret < 0)
-		pr_err("iommu_tce: %s failed ioba=%lx, tce=%lx, ret=%d\n",
-			__func__, entry << tbl->it_page_shift, tce, ret);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(iommu_put_tce_user_mode);
-
 int iommu_take_ownership(struct iommu_table *tbl)
 {
 	unsigned long sz = (tbl->it_size + 7) >> 3;
@@ -1086,7 +1020,6 @@ int iommu_take_ownership(struct iommu_table *tbl)
 	}
 
 	memset(tbl->it_map, 0xff, sz);
-	iommu_clear_tces_and_put_pages(tbl, tbl->it_offset, tbl->it_size);
 
 	/*
 	 * Disable iommu bypass, otherwise the user can DMA to all of
@@ -1104,7 +1037,6 @@ void iommu_release_ownership(struct iommu_table *tbl)
 {
 	unsigned long sz = (tbl->it_size + 7) >> 3;
 
-	iommu_clear_tces_and_put_pages(tbl, tbl->it_offset, tbl->it_size);
 	memset(tbl->it_map, 0, sz);
 
 	/* Restore bit#0 set by iommu_init_table() */
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 730b4ef..dc4a886 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -147,6 +147,78 @@ static void tce_iommu_release(void *iommu_data)
 	kfree(container);
 }
 
+static int tce_iommu_clear(struct tce_container *container,
+		struct iommu_table *tbl,
+		unsigned long entry, unsigned long pages)
+{
+	unsigned long oldtce;
+	struct page *page;
+
+	for ( ; pages; --pages, ++entry) {
+		oldtce = iommu_clear_tce(tbl, entry);
+		if (!oldtce)
+			continue;
+
+		page = pfn_to_page(oldtce >> PAGE_SHIFT);
+		WARN_ON(!page);
+		if (page) {
+			if (oldtce & TCE_PCI_WRITE)
+				SetPageDirty(page);
+			put_page(page);
+		}
+	}
+
+	return 0;
+}
+
+static enum dma_data_direction tce_iommu_direction(unsigned long tce)
+{
+	if ((tce & TCE_PCI_READ) && (tce & TCE_PCI_WRITE))
+		return DMA_BIDIRECTIONAL;
+	else if (tce & TCE_PCI_READ)
+		return DMA_TO_DEVICE;
+	else if (tce & TCE_PCI_WRITE)
+		return DMA_FROM_DEVICE;
+	else
+		return DMA_NONE;
+}
+
+static long tce_iommu_build(struct tce_container *container,
+		struct iommu_table *tbl,
+		unsigned long entry, unsigned long tce, unsigned long pages)
+{
+	long i, ret = 0;
+	struct page *page = NULL;
+	unsigned long hva;
+	enum dma_data_direction direction = tce_iommu_direction(tce);
+
+	for (i = 0; i < pages; ++i) {
+		ret = get_user_pages_fast(tce & PAGE_MASK, 1,
+				direction != DMA_TO_DEVICE, &page);
+		if (unlikely(ret != 1)) {
+			ret = -EFAULT;
+			break;
+		}
+		hva = (unsigned long) page_address(page) +
+			(tce & IOMMU_PAGE_MASK(tbl) & ~PAGE_MASK);
+
+		ret = iommu_tce_build(tbl, entry + 1, hva, direction);
+		if (ret) {
+			put_page(page);
+			pr_err("iommu_tce: %s failed ioba=%lx, tce=%lx, ret=%ld\n",
+					__func__, entry << tbl->it_page_shift,
+					tce, ret);
+			break;
+		}
+		tce += IOMMU_PAGE_SIZE_4K;
+	}
+
+	if (ret)
+		tce_iommu_clear(container, tbl, entry, i);
+
+	return ret;
+}
+
 static long tce_iommu_ioctl(void *iommu_data,
 				 unsigned int cmd, unsigned long arg)
 {
@@ -195,7 +267,7 @@ static long tce_iommu_ioctl(void *iommu_data,
 	case VFIO_IOMMU_MAP_DMA: {
 		struct vfio_iommu_type1_dma_map param;
 		struct iommu_table *tbl = container->tbl;
-		unsigned long tce, i;
+		unsigned long tce;
 
 		if (!tbl)
 			return -ENXIO;
@@ -229,17 +301,9 @@ static long tce_iommu_ioctl(void *iommu_data,
 		if (ret)
 			return ret;
 
-		for (i = 0; i < (param.size >> IOMMU_PAGE_SHIFT_4K); ++i) {
-			ret = iommu_put_tce_user_mode(tbl,
-					(param.iova >> IOMMU_PAGE_SHIFT_4K) + i,
-					tce);
-			if (ret)
-				break;
-			tce += IOMMU_PAGE_SIZE_4K;
-		}
-		if (ret)
-			iommu_clear_tces_and_put_pages(tbl,
-					param.iova >> IOMMU_PAGE_SHIFT_4K, i);
+		ret = tce_iommu_build(container, tbl,
+				param.iova >> IOMMU_PAGE_SHIFT_4K,
+				tce, param.size >> IOMMU_PAGE_SHIFT_4K);
 
 		iommu_flush_tce(tbl);
 
@@ -273,7 +337,7 @@ static long tce_iommu_ioctl(void *iommu_data,
 		if (ret)
 			return ret;
 
-		ret = iommu_clear_tces_and_put_pages(tbl,
+		ret = tce_iommu_clear(container, tbl,
 				param.iova >> IOMMU_PAGE_SHIFT_4K,
 				param.size >> IOMMU_PAGE_SHIFT_4K);
 		iommu_flush_tce(tbl);
@@ -357,6 +421,7 @@ static void tce_iommu_detach_group(void *iommu_data,
 		/* pr_debug("tce_vfio: detaching group #%u from iommu %p\n",
 				iommu_group_id(iommu_group), iommu_group); */
 		container->tbl = NULL;
+		tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
 		iommu_release_ownership(tbl);
 	}
 	mutex_unlock(&container->lock);
-- 
2.0.0
