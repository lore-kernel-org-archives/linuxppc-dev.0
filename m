Return-Path: <aik@ozlabs.ru>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9116B1A0904
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 19:09:04 +1100 (AEDT)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 13 Mar 2015 18:09:04 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 2709B2BB0068
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 19:09:01 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2D88r1U7078004
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 19:09:01 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2D88Rer020971
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 19:08:27 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v6 07/29] vfio: powerpc/spapr: Moving pinning/unpinning
 to helpers
Date: Fri, 13 Mar 2015 19:07:15 +1100
Message-Id: <1426234057-16165-8-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1426234057-16165-1-git-send-email-aik@ozlabs.ru>
References: <1426234057-16165-1-git-send-email-aik@ozlabs.ru>
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>
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

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v6:
* tce_get_hva() returns hva via a pointer
---
 drivers/vfio/vfio_iommu_spapr_tce.c | 69 +++++++++++++++++++++++++++----------
 1 file changed, 51 insertions(+), 18 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 8a667cb..be693ca 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -198,7 +198,6 @@ static void tce_iommu_release(void *iommu_data)
 	struct iommu_table *tbl = container->tbl;
 
 	WARN_ON(tbl && !tbl->it_group);
-	tce_iommu_disable(container);
 
 	if (tbl) {
 		tce_iommu_clear(container, tbl,	tbl->it_offset, tbl->it_size);
@@ -206,63 +205,97 @@ static void tce_iommu_release(void *iommu_data)
 		if (tbl->it_group)
 			tce_iommu_detach_group(iommu_data, tbl->it_group);
 	}
+
+	tce_iommu_disable(container);
+
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
+	/*
+	 * VFIO cannot map/unmap when a container is not enabled so
+	 * we would not need this check but KVM could map/unmap and if
+	 * this happened, we must not put pages as KVM does not get them as
+	 * it expects memory pre-registation to do this part.
+	 */
+	if (!container->enabled)
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
 }
 
+static int tce_get_hva(struct tce_container *container,
+		unsigned page_shift, unsigned long tce, unsigned long *hva)
+{
+	struct page *page = NULL;
+	enum dma_data_direction direction = iommu_tce_direction(tce);
+
+	if (get_user_pages_fast(tce & PAGE_MASK, 1,
+			direction != DMA_TO_DEVICE, &page) != 1)
+		return -EFAULT;
+
+	*hva = (unsigned long) page_address(page);
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
+	struct page *page;
 	unsigned long hva;
 	enum dma_data_direction direction = iommu_tce_direction(tce);
 
 	for (i = 0; i < pages; ++i) {
-		ret = get_user_pages_fast(tce & PAGE_MASK, 1,
-				direction != DMA_TO_DEVICE, &page);
-		if (unlikely(ret != 1)) {
-			ret = -EFAULT;
+		ret = tce_get_hva(container, tbl->it_page_shift, tce, &hva);
+		if (ret)
 			break;
-		}
 
+		page = pfn_to_page(__pa(hva) >> PAGE_SHIFT);
 		if (!tce_page_is_contained(page, tbl->it_page_shift)) {
 			ret = -EPERM;
 			break;
 		}
 
-		hva = (unsigned long) page_address(page) +
-			(tce & IOMMU_PAGE_MASK(tbl) & ~PAGE_MASK);
+		/* Preserve offset within IOMMU page */
+		hva |= tce & IOMMU_PAGE_MASK(tbl) & ~PAGE_MASK;
 
 		ret = iommu_tce_build(tbl, entry + i, hva, direction);
 		if (ret) {
-			put_page(page);
+			tce_iommu_unuse_page(container, hva);
 			pr_err("iommu_tce: %s failed ioba=%lx, tce=%lx, ret=%ld\n",
 					__func__, entry << tbl->it_page_shift,
 					tce, ret);
-- 
2.0.0
