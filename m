Return-Path: <aik@ozlabs.ru>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8FFAB1A02FA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 21:07:47 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Mon, 16 Feb 2015 20:07:46 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id A66B52BB005F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 21:07:44 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1GA7aSk44892262
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 21:07:44 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1GA7BXB013606
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 21:07:11 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 07/28] vfio: powerpc/spapr: Moving pinning/unpinning to
 helpers
Date: Mon, 16 Feb 2015 21:05:59 +1100
Message-Id: <1424081180-4494-8-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1424081180-4494-1-git-send-email-aik@ozlabs.ru>
References: <1424081180-4494-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>,
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

This is a pretty mechanical patch to make next patches simpler.

New tce_iommu_unuse_page() helper does put_page() now but it might skip
that after the memory registering patch applied.

As we are here, this removes unnecessary checks for a value returned
by pfn_to_page() as it cannot possibly return NULL.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 drivers/vfio/vfio_iommu_spapr_tce.c | 59 +++++++++++++++++++++++++++----------
 1 file changed, 44 insertions(+), 15 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 67ea392..7fd60f9 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -217,25 +217,34 @@ static void tce_iommu_release(void *iommu_data)
 	kfree(container);
 }
 
+static void tce_iommu_unuse_page(struct tce_container *container,
+		unsigned long oldtce)
+{
+	struct page *page;
+
+	if (!(oldtce & (TCE_PCI_READ | TCE_PCI_WRITE)))
+		return;
+
+	page = pfn_to_page(__pa(oldtce) >> PAGE_SHIFT);
+
+	if (oldtce & TCE_PCI_WRITE)
+		SetPageDirty(page);
+
+	put_page(page);
+}
+
 static int tce_iommu_clear(struct tce_container *container,
 		struct iommu_table *tbl,
 		unsigned long entry, unsigned long pages)
 {
 	unsigned long oldtce;
-	struct page *page;
 
 	for ( ; pages; --pages, ++entry) {
 		oldtce = iommu_clear_tce(tbl, entry);
 		if (!oldtce)
 			continue;
 
-		page = pfn_to_page(oldtce >> PAGE_SHIFT);
-		WARN_ON(!page);
-		if (page) {
-			if (oldtce & TCE_PCI_WRITE)
-				SetPageDirty(page);
-			put_page(page);
-		}
+		tce_iommu_unuse_page(container, (unsigned long) __va(oldtce));
 	}
 
 	return 0;
@@ -253,34 +262,54 @@ static enum dma_data_direction tce_iommu_direction(unsigned long tce)
 		return DMA_NONE;
 }
 
+static unsigned long tce_get_hva(struct tce_container *container,
+		unsigned page_shift, unsigned long tce)
+{
+	long ret;
+	struct page *page = NULL;
+	unsigned long hva;
+	enum dma_data_direction direction = tce_iommu_direction(tce);
+
+	ret = get_user_pages_fast(tce & PAGE_MASK, 1,
+			direction != DMA_TO_DEVICE, &page);
+	if (unlikely(ret != 1))
+		return -1;
+
+	hva = (unsigned long) page_address(page);
+
+	return hva;
+}
+
 static long tce_iommu_build(struct tce_container *container,
 		struct iommu_table *tbl,
 		unsigned long entry, unsigned long tce, unsigned long pages)
 {
 	long i, ret = 0;
-	struct page *page = NULL;
+	struct page *page;
 	unsigned long hva;
 	enum dma_data_direction direction = tce_iommu_direction(tce);
 
 	for (i = 0; i < pages; ++i) {
-		ret = get_user_pages_fast(tce & PAGE_MASK, 1,
-				direction != DMA_TO_DEVICE, &page);
-		if (unlikely(ret != 1)) {
+		hva = tce_get_hva(container, tbl->it_page_shift, tce);
+		if (hva == -1) {
 			ret = -EFAULT;
 			break;
 		}
 
+		page = pfn_to_page(__pa(hva) >> PAGE_SHIFT);
 		if (!tce_page_is_contained(page, tbl->it_page_shift)) {
 			ret = -EPERM;
 			break;
 		}
 
-		hva = (unsigned long) page_address(page) +
-			(tce & IOMMU_PAGE_MASK(tbl) & ~PAGE_MASK);
+		/* Preserve offset within IOMMU page */
+		hva |= tce & IOMMU_PAGE_MASK(tbl) & ~PAGE_MASK;
+		/* Preserve permission bits */
+		hva |= tce & (TCE_PCI_READ | TCE_PCI_WRITE);
 
 		ret = iommu_tce_build(tbl, entry + i, hva, direction);
 		if (ret) {
-			put_page(page);
+			tce_iommu_unuse_page(container, hva);
 			pr_err("iommu_tce: %s failed ioba=%lx, tce=%lx, ret=%ld\n",
 					__func__, entry << tbl->it_page_shift,
 					tce, ret);
-- 
2.0.0
