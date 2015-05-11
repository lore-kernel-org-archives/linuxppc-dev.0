Return-Path: <aik@ozlabs.ru>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5D4111A012A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 01:40:52 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 12 May 2015 01:40:52 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 624B53578054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 01:40:48 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4BFeeSZ39715016
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 01:40:48 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4BFeF56026171
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 01:40:16 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v10 11/34] vfio: powerpc/spapr: Moving
 pinning/unpinning to helpers
Date: Tue, 12 May 2015 01:39:00 +1000
Message-Id: <1431358763-24371-12-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1431358763-24371-1-git-send-email-aik@ozlabs.ru>
References: <1431358763-24371-1-git-send-email-aik@ozlabs.ru>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, David Gibson <david@gibson.dropbear.id.au>
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

This moves tce_iommu_disable() later to let tce_iommu_clear() know if
the container has been enabled because if it has not been, then
put_page() must not be called on TCEs from the TCE table. This situation
is not yet possible but it will after KVM acceleration patchset is
applied.

This changes code to work with physical addresses rather than linear
mapping addresses for better code readability. Following patches will
add an xchg() callback for an IOMMU table which will accept/return
physical addresses (unlike current tce_build()) which will eliminate
redundant conversions.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
[aw: for the vfio related changes]
Acked-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
Changes:
v9:
* changed helpers to work with physical addresses rather than linear
(for simplicity - later ::xchg() will receive physical and avoid
additional convertions)

v6:
* tce_get_hva() returns hva via a pointer
---
 drivers/vfio/vfio_iommu_spapr_tce.c | 61 +++++++++++++++++++++++++------------
 1 file changed, 41 insertions(+), 20 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index e21479c..115d5e6 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -191,69 +191,90 @@ static void tce_iommu_release(void *iommu_data)
 	struct tce_container *container = iommu_data;
 
 	WARN_ON(container->tbl && !container->tbl->it_group);
-	tce_iommu_disable(container);
 
 	if (container->tbl && container->tbl->it_group)
 		tce_iommu_detach_group(iommu_data, container->tbl->it_group);
 
+	tce_iommu_disable(container);
 	mutex_destroy(&container->lock);
 
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
+	page = pfn_to_page(oldtce >> PAGE_SHIFT);
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
+		tce_iommu_unuse_page(container, oldtce);
 	}
 
 	return 0;
 }
 
+static int tce_iommu_use_page(unsigned long tce, unsigned long *hpa)
+{
+	struct page *page = NULL;
+	enum dma_data_direction direction = iommu_tce_direction(tce);
+
+	if (get_user_pages_fast(tce & PAGE_MASK, 1,
+			direction != DMA_TO_DEVICE, &page) != 1)
+		return -EFAULT;
+
+	*hpa = __pa((unsigned long) page_address(page));
+
+	return 0;
+}
+
 static long tce_iommu_build(struct tce_container *container,
 		struct iommu_table *tbl,
 		unsigned long entry, unsigned long tce, unsigned long pages)
 {
 	long i, ret = 0;
-	struct page *page = NULL;
-	unsigned long hva;
+	struct page *page;
+	unsigned long hpa;
 	enum dma_data_direction direction = iommu_tce_direction(tce);
 
 	for (i = 0; i < pages; ++i) {
 		unsigned long offset = tce & IOMMU_PAGE_MASK(tbl) & ~PAGE_MASK;
 
-		ret = get_user_pages_fast(tce & PAGE_MASK, 1,
-				direction != DMA_TO_DEVICE, &page);
-		if (unlikely(ret != 1)) {
-			ret = -EFAULT;
+		ret = tce_iommu_use_page(tce, &hpa);
+		if (ret)
 			break;
-		}
 
+		page = pfn_to_page(hpa >> PAGE_SHIFT);
 		if (!tce_page_is_contained(page, tbl->it_page_shift)) {
 			ret = -EPERM;
 			break;
 		}
 
-		hva = (unsigned long) page_address(page) + offset;
-
-		ret = iommu_tce_build(tbl, entry + i, hva, direction);
+		hpa |= offset;
+		ret = iommu_tce_build(tbl, entry + i, (unsigned long) __va(hpa),
+				direction);
 		if (ret) {
-			put_page(page);
+			tce_iommu_unuse_page(container, hpa);
 			pr_err("iommu_tce: %s failed ioba=%lx, tce=%lx, ret=%ld\n",
 					__func__, entry << tbl->it_page_shift,
 					tce, ret);
-- 
2.4.0.rc3.8.gfb3e7d5
