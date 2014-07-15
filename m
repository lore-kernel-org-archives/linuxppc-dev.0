Return-Path: <aik@ozlabs.ru>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9E67E1A02DA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:21 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 15 Jul 2014 19:25:21 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 94DB32CE8047
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:18 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6F98WVd131550
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:08:32 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6F9PHS6021891
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:18 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 1/7] powerpc/iommu: Change prototypes for realmode support
Date: Tue, 15 Jul 2014 19:25:05 +1000
Message-Id: <1405416311-12429-2-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1405416311-12429-1-git-send-email-aik@ozlabs.ru>
References: <1405416311-12429-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a mechanical patch to add an extra "realmode" parameter to
iommu_clear_tces_and_put_pages() and iommu_tce_build() helpers.

This changes iommu_tce_build() to receive multiple page addresses at once
as in the future we want to save on locks and TCE flushes in realmode.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/iommu.h          |  5 +++--
 arch/powerpc/kernel/iommu.c               | 15 +++++++++------
 arch/powerpc/platforms/powernv/pci-ioda.c |  3 ++-
 drivers/vfio/vfio_iommu_spapr_tce.c       |  6 ++++--
 4 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index 00205cb..1c9b346 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -194,11 +194,12 @@ extern int iommu_tce_clear_param_check(struct iommu_table *tbl,
 extern int iommu_tce_put_param_check(struct iommu_table *tbl,
 		unsigned long ioba, unsigned long tce);
 extern int iommu_tce_build(struct iommu_table *tbl, unsigned long entry,
-		unsigned long hwaddr, enum dma_data_direction direction);
+		unsigned long *hpas, unsigned long npages, bool realmode);
 extern unsigned long iommu_clear_tce(struct iommu_table *tbl,
 		unsigned long entry);
 extern int iommu_clear_tces_and_put_pages(struct iommu_table *tbl,
-		unsigned long entry, unsigned long pages);
+		unsigned long entry, unsigned long pages,
+		bool realmode);
 extern int iommu_put_tce_user_mode(struct iommu_table *tbl,
 		unsigned long entry, unsigned long tce);
 
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 25fda58..8771b73 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -1018,7 +1018,8 @@ unsigned long iommu_clear_tce(struct iommu_table *tbl, unsigned long entry)
 EXPORT_SYMBOL_GPL(iommu_clear_tce);
 
 int iommu_clear_tces_and_put_pages(struct iommu_table *tbl,
-		unsigned long entry, unsigned long pages)
+		unsigned long entry, unsigned long pages,
+		bool realmode)
 {
 	unsigned long oldtce;
 	struct page *page;
@@ -1046,15 +1047,16 @@ EXPORT_SYMBOL_GPL(iommu_clear_tces_and_put_pages);
  * tce_build converts it to a physical address.
  */
 int iommu_tce_build(struct iommu_table *tbl, unsigned long entry,
-		unsigned long hwaddr, enum dma_data_direction direction)
+		unsigned long *hpas, unsigned long npages, bool realmode)
 {
 	int ret = -EBUSY;
 	unsigned long oldtce;
 	struct iommu_pool *pool = get_pool(tbl, entry);
+	enum dma_data_direction direction = iommu_tce_direction(*hpas);
 
 	spin_lock(&(pool->lock));
 
-	ret = ppc_md.tce_build(tbl, entry, 1, hwaddr, &oldtce,
+	ret = ppc_md.tce_build(tbl, entry, 1, *hpas, &oldtce,
 			direction, NULL);
 
 	if (oldtce & (TCE_PCI_WRITE | TCE_PCI_READ))
@@ -1089,7 +1091,7 @@ int iommu_put_tce_user_mode(struct iommu_table *tbl, unsigned long entry,
 	hwaddr = (unsigned long) page_address(page) + offset;
 	hwaddr |= tce & (TCE_PCI_READ | TCE_PCI_WRITE);
 
-	ret = iommu_tce_build(tbl, entry, hwaddr, direction);
+	ret = iommu_tce_build(tbl, entry, &hwaddr, 1, direction);
 	if (ret)
 		put_page(page);
 
@@ -1124,7 +1126,7 @@ int iommu_take_ownership(struct iommu_table *tbl)
 
 	if (!ret)
 		iommu_clear_tces_and_put_pages(tbl, tbl->it_offset,
-				tbl->it_size);
+				tbl->it_size, false);
 
 	for (i = 0; i < tbl->nr_pools; i++)
 		spin_unlock(&tbl->pools[i].lock);
@@ -1138,7 +1140,8 @@ void iommu_release_ownership(struct iommu_table *tbl)
 {
 	unsigned long flags, i, sz = (tbl->it_size + 7) >> 3;
 
-	iommu_clear_tces_and_put_pages(tbl, tbl->it_offset, tbl->it_size);
+	iommu_clear_tces_and_put_pages(tbl, tbl->it_offset, tbl->it_size,
+			false);
 
 	spin_lock_irqsave(&tbl->large_pool.lock, flags);
 	for (i = 0; i < tbl->nr_pools; i++)
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 63aa697..2d65a7d 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -895,7 +895,8 @@ static long pnv_pci_ioda2_ddw_remove(struct spapr_tce_iommu_group *data,
 
 	pr_info("Removing huge 64bit DMA window\n");
 
-	iommu_clear_tces_and_put_pages(tbl, tbl->it_offset, tbl->it_size);
+	iommu_clear_tces_and_put_pages(tbl, tbl->it_offset, tbl->it_size,
+			false);
 
 	pe->tce64_active = false;
 
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 8f992de..ff1b29e 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -283,7 +283,8 @@ static long tce_iommu_ioctl(void *iommu_data,
 		}
 		if (ret)
 			iommu_clear_tces_and_put_pages(tbl,
-					param.iova >> tbl->it_page_shift, i);
+					param.iova >> tbl->it_page_shift, i,
+					false);
 
 		iommu_flush_tce(tbl);
 
@@ -330,7 +331,8 @@ static long tce_iommu_ioctl(void *iommu_data,
 
 		ret = iommu_clear_tces_and_put_pages(tbl,
 				param.iova >> tbl->it_page_shift,
-				param.size >> tbl->it_page_shift);
+				param.size >> tbl->it_page_shift,
+				false);
 		iommu_flush_tce(tbl);
 
 		return ret;
-- 
2.0.0
