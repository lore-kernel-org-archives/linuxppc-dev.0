Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [83.169.36.222])
 by lists.ozlabs.org (Postfix) with ESMTP id 3s464c4C90zDqV1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2016 18:41:52 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH kernel 07/15] powerpc/iommu: Cleanup iommu_table disposal
Date: Wed,  3 Aug 2016 18:40:48 +1000
Message-Id: <1470213656-1042-8-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1470213656-1042-1-git-send-email-aik@ozlabs.ru>
References: <1470213656-1042-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At the moment iommu_table could be disposed by either calling
iommu_table_free() directly or it_ops::free() which only implementation
for IODA2 calls iommu_table_free() anyway.

As we are going to have reference counting on tables, we need an unified
way of disposing tables.

This moves it_ops::free() call into iommu_free_table() and makes use
of the latter everywhere. The free() callback now handles only
platform-specific data.

This should cause no behavioral change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/kernel/iommu.c               | 4 ++++
 arch/powerpc/platforms/powernv/pci-ioda.c | 6 ++----
 drivers/vfio/vfio_iommu_spapr_tce.c       | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index a8e3490..13263b0 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -718,6 +718,9 @@ void iommu_free_table(struct iommu_table *tbl, const char *node_name)
 	if (!tbl)
 		return;
 
+	if (tbl->it_ops->free)
+		tbl->it_ops->free(tbl);
+
 	if (!tbl->it_map) {
 		kfree(tbl);
 		return;
@@ -744,6 +747,7 @@ void iommu_free_table(struct iommu_table *tbl, const char *node_name)
 	/* free table */
 	kfree(tbl);
 }
+EXPORT_SYMBOL_GPL(iommu_free_table);
 
 /* Creates TCEs for a user provided buffer.  The user buffer must be
  * contiguous real kernel storage (not vmalloc).  The address passed here
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 59c7e7d..74ab8382 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1394,7 +1394,6 @@ static void pnv_pci_ioda2_release_dma_pe(struct pci_dev *dev, struct pnv_ioda_pe
 		iommu_group_put(pe->table_group.group);
 		BUG_ON(pe->table_group.group);
 	}
-	pnv_pci_ioda2_table_free_pages(tbl);
 	iommu_free_table(tbl, of_node_full_name(dev->dev.of_node));
 }
 
@@ -1987,7 +1986,6 @@ static void pnv_ioda2_tce_free(struct iommu_table *tbl, long index,
 static void pnv_ioda2_table_free(struct iommu_table *tbl)
 {
 	pnv_pci_ioda2_table_free_pages(tbl);
-	iommu_free_table(tbl, "pnv");
 }
 
 static struct iommu_table_ops pnv_ioda2_iommu_ops = {
@@ -2313,7 +2311,7 @@ static long pnv_pci_ioda2_setup_default_config(struct pnv_ioda_pe *pe)
 	if (rc) {
 		pe_err(pe, "Failed to configure 32-bit TCE table, err %ld\n",
 				rc);
-		pnv_ioda2_table_free(tbl);
+		iommu_free_table(tbl, "");
 		return rc;
 	}
 
@@ -2399,7 +2397,7 @@ static void pnv_ioda2_take_ownership(struct iommu_table_group *table_group)
 
 	pnv_pci_ioda2_set_bypass(pe, false);
 	pnv_pci_ioda2_unset_window(&pe->table_group, 0);
-	pnv_ioda2_table_free(tbl);
+	iommu_free_table(tbl, "pnv");
 }
 
 static void pnv_ioda2_release_ownership(struct iommu_table_group *table_group)
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 40e71a0..79f26c7 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -660,7 +660,7 @@ static void tce_iommu_free_table(struct iommu_table *tbl)
 	unsigned long pages = tbl->it_allocated_size >> PAGE_SHIFT;
 
 	tce_iommu_userspace_view_free(tbl);
-	tbl->it_ops->free(tbl);
+	iommu_free_table(tbl, "");
 	decrement_locked_vm(pages);
 }
 
-- 
2.5.0.rc3
