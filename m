Return-Path: <aik@ozlabs.ru>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 858441A03B3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 16:32:25 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 10 Apr 2015 16:32:23 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 756C52BB004D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 16:32:19 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3A6WAHG41091074
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 16:32:19 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3A6ViSZ022352
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 16:31:45 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v8 01/31] vfio: powerpc/spapr: Move page pinning from
 arch code to VFIO IOMMU driver
Date: Fri, 10 Apr 2015 16:30:43 +1000
Message-Id: <1428647473-11738-2-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1428647473-11738-1-git-send-email-aik@ozlabs.ru>
References: <1428647473-11738-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
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
Changes:
v4:
* s/iommu_tce_build(tbl, entry + 1/iommu_tce_build(tbl, entry + i/
---
 arch/powerpc/include/asm/iommu.h    |  4 --
 arch/powerpc/kernel/iommu.c         | 55 --------------------------
 drivers/vfio/vfio_iommu_spapr_tce.c | 78 ++++++++++++++++++++++++++++++-------
 3 files changed, 65 insertions(+), 72 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index f1ea597..ed69b7d 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -197,10 +197,6 @@ extern int iommu_tce_build(struct iommu_table *tbl, unsigned long entry,
 		unsigned long hwaddr, enum dma_data_direction direction);
 extern unsigned long iommu_clear_tce(struct iommu_table *tbl,
 		unsigned long entry);
-extern int iommu_clear_tces_and_put_pages(struct iommu_table *tbl,
-		unsigned long entry, unsigned long pages);
-extern int iommu_put_tce_user_mode(struct iommu_table *tbl,
-		unsigned long entry, unsigned long tce);
 
 extern void iommu_flush_tce(struct iommu_table *tbl);
 extern int iommu_take_ownership(struct iommu_table *tbl);
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index b054f33..1b4a178 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -991,30 +991,6 @@ unsigned long iommu_clear_tce(struct iommu_table *tbl, unsigned long entry)
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
@@ -1044,35 +1020,6 @@ int iommu_tce_build(struct iommu_table *tbl, unsigned long entry,
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
@@ -1086,7 +1033,6 @@ int iommu_take_ownership(struct iommu_table *tbl)
 	}
 
 	memset(tbl->it_map, 0xff, sz);
-	iommu_clear_tces_and_put_pages(tbl, tbl->it_offset, tbl->it_size);
 
 	/*
 	 * Disable iommu bypass, otherwise the user can DMA to all of
@@ -1104,7 +1050,6 @@ void iommu_release_ownership(struct iommu_table *tbl)
 {
 	unsigned long sz = (tbl->it_size + 7) >> 3;
 
-	iommu_clear_tces_and_put_pages(tbl, tbl->it_offset, tbl->it_size);
 	memset(tbl->it_map, 0, sz);
 
 	/* Restore bit#0 set by iommu_init_table() */
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 730b4ef..cefaf05 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -147,6 +147,66 @@ static void tce_iommu_release(void *iommu_data)
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
+static long tce_iommu_build(struct tce_container *container,
+		struct iommu_table *tbl,
+		unsigned long entry, unsigned long tce, unsigned long pages)
+{
+	long i, ret = 0;
+	struct page *page = NULL;
+	unsigned long hva;
+	enum dma_data_direction direction = iommu_tce_direction(tce);
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
+		ret = iommu_tce_build(tbl, entry + i, hva, direction);
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
@@ -195,7 +255,7 @@ static long tce_iommu_ioctl(void *iommu_data,
 	case VFIO_IOMMU_MAP_DMA: {
 		struct vfio_iommu_type1_dma_map param;
 		struct iommu_table *tbl = container->tbl;
-		unsigned long tce, i;
+		unsigned long tce;
 
 		if (!tbl)
 			return -ENXIO;
@@ -229,17 +289,9 @@ static long tce_iommu_ioctl(void *iommu_data,
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
 
@@ -273,7 +325,7 @@ static long tce_iommu_ioctl(void *iommu_data,
 		if (ret)
 			return ret;
 
-		ret = iommu_clear_tces_and_put_pages(tbl,
+		ret = tce_iommu_clear(container, tbl,
 				param.iova >> IOMMU_PAGE_SHIFT_4K,
 				param.size >> IOMMU_PAGE_SHIFT_4K);
 		iommu_flush_tce(tbl);
-- 
2.0.0
