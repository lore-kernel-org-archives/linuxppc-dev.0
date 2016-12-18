Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [83.169.36.222])
 by lists.ozlabs.org (Postfix) with ESMTP id 3th60F08QxzDw6j
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Dec 2016 12:29:16 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH kernel v2 02/11] powerpc/iommu: Cleanup iommu_table disposal
Date: Sun, 18 Dec 2016 12:28:51 +1100
Message-Id: <20161218012900.18142-3-aik@ozlabs.ru>
In-Reply-To: <20161218012900.18142-1-aik@ozlabs.ru>
References: <20161218012900.18142-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At the moment iommu_table can be disposed by either calling
iommu_table_free() directly or it_ops::free(); the only implementation
of free() is in IODA2 - pnv_ioda2_table_free() - and it calls
iommu_table_free() anyway.

As we are going to have reference counting on tables, we need an unified
way of disposing tables.

This moves it_ops::free() call into iommu_free_table() and makes use
of the latter. The free() callback now handles only platform-specific
data.

This should cause no behavioral change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/kernel/iommu.c               | 4 ++++
 arch/powerpc/platforms/powernv/pci-ioda.c | 6 ++----
 drivers/vfio/vfio_iommu_spapr_tce.c       | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 5f202a566ec5..6744a2771769 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -719,6 +719,9 @@ void iommu_free_table(struct iommu_table *tbl, const char *node_name)
 	if (!tbl)
 		return;
 
+	if (tbl->it_ops->free)
+		tbl->it_ops->free(tbl);
+
 	if (!tbl->it_map) {
 		kfree(tbl);
 		return;
@@ -745,6 +748,7 @@ void iommu_free_table(struct iommu_table *tbl, const char *node_name)
 	/* free table */
 	kfree(tbl);
 }
+EXPORT_SYMBOL_GPL(iommu_free_table);
 
 /* Creates TCEs for a user provided buffer.  The user buffer must be
  * contiguous real kernel storage (not vmalloc).  The address passed here
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 5fcae29107e1..c4f9e812ca6c 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1422,7 +1422,6 @@ static void pnv_pci_ioda2_release_dma_pe(struct pci_dev *dev, struct pnv_ioda_pe
 		iommu_group_put(pe->table_group.group);
 		BUG_ON(pe->table_group.group);
 	}
-	pnv_pci_ioda2_table_free_pages(tbl);
 	iommu_free_table(tbl, of_node_full_name(dev->dev.of_node));
 }
 
@@ -2013,7 +2012,6 @@ static void pnv_ioda2_tce_free(struct iommu_table *tbl, long index,
 static void pnv_ioda2_table_free(struct iommu_table *tbl)
 {
 	pnv_pci_ioda2_table_free_pages(tbl);
-	iommu_free_table(tbl, "pnv");
 }
 
 static struct iommu_table_ops pnv_ioda2_iommu_ops = {
@@ -2339,7 +2337,7 @@ static long pnv_pci_ioda2_setup_default_config(struct pnv_ioda_pe *pe)
 	if (rc) {
 		pe_err(pe, "Failed to configure 32-bit TCE table, err %ld\n",
 				rc);
-		pnv_ioda2_table_free(tbl);
+		iommu_free_table(tbl, "");
 		return rc;
 	}
 
@@ -2425,7 +2423,7 @@ static void pnv_ioda2_take_ownership(struct iommu_table_group *table_group)
 
 	pnv_pci_ioda2_set_bypass(pe, false);
 	pnv_pci_ioda2_unset_window(&pe->table_group, 0);
-	pnv_ioda2_table_free(tbl);
+	iommu_free_table(tbl, "pnv");
 }
 
 static void pnv_ioda2_release_ownership(struct iommu_table_group *table_group)
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index c8823578a1b2..cbac08af400e 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -677,7 +677,7 @@ static void tce_iommu_free_table(struct tce_container *container,
 	unsigned long pages = tbl->it_allocated_size >> PAGE_SHIFT;
 
 	tce_iommu_userspace_view_free(tbl, container->mm);
-	tbl->it_ops->free(tbl);
+	iommu_free_table(tbl, "");
 	decrement_locked_vm(container->mm, pages);
 }
 
-- 
2.11.0
