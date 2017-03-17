Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vkth15JjwzDqcd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 16:10:09 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH kernel v10 03/10] powerpc/iommu/vfio_spapr_tce: Cleanup
 iommu_table disposal
Date: Fri, 17 Mar 2017 16:09:52 +1100
Message-Id: <20170317050959.37312-4-aik@ozlabs.ru>
In-Reply-To: <20170317050959.37312-1-aik@ozlabs.ru>
References: <20170317050959.37312-1-aik@ozlabs.ru>
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

As from now on the iommu_free_table() calls it_ops->free(), we need
to have it_ops initialized before calling iommu_free_table() so this
moves this initialization in pnv_pci_ioda2_create_table().

This should cause no behavioral change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Acked-by: Alex Williamson <alex.williamson@redhat.com>
---
Changes:
v5:
* moved "tbl->it_ops = &pnv_ioda2_iommu_ops" earlier and updated
the commit log
---
 arch/powerpc/kernel/iommu.c               |  4 ++++
 arch/powerpc/platforms/powernv/pci-ioda.c | 10 ++++------
 drivers/vfio/vfio_iommu_spapr_tce.c       |  2 +-
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 9bace5df05d5..bc142d87130f 100644
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
index 572e9c9f1ea0..5dae54cb11e3 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1424,7 +1424,6 @@ static void pnv_pci_ioda2_release_dma_pe(struct pci_dev *dev, struct pnv_ioda_pe
 		iommu_group_put(pe->table_group.group);
 		BUG_ON(pe->table_group.group);
 	}
-	pnv_pci_ioda2_table_free_pages(tbl);
 	iommu_free_table(tbl, of_node_full_name(dev->dev.of_node));
 }
 
@@ -2040,7 +2039,6 @@ static void pnv_ioda2_tce_free(struct iommu_table *tbl, long index,
 static void pnv_ioda2_table_free(struct iommu_table *tbl)
 {
 	pnv_pci_ioda2_table_free_pages(tbl);
-	iommu_free_table(tbl, "pnv");
 }
 
 static struct iommu_table_ops pnv_ioda2_iommu_ops = {
@@ -2317,6 +2315,8 @@ static long pnv_pci_ioda2_create_table(struct iommu_table_group *table_group,
 	if (!tbl)
 		return -ENOMEM;
 
+	tbl->it_ops = &pnv_ioda2_iommu_ops;
+
 	ret = pnv_pci_ioda2_table_alloc_pages(nid,
 			bus_offset, page_shift, window_size,
 			levels, tbl);
@@ -2325,8 +2325,6 @@ static long pnv_pci_ioda2_create_table(struct iommu_table_group *table_group,
 		return ret;
 	}
 
-	tbl->it_ops = &pnv_ioda2_iommu_ops;
-
 	*ptbl = tbl;
 
 	return 0;
@@ -2367,7 +2365,7 @@ static long pnv_pci_ioda2_setup_default_config(struct pnv_ioda_pe *pe)
 	if (rc) {
 		pe_err(pe, "Failed to configure 32-bit TCE table, err %ld\n",
 				rc);
-		pnv_ioda2_table_free(tbl);
+		iommu_free_table(tbl, "");
 		return rc;
 	}
 
@@ -2455,7 +2453,7 @@ static void pnv_ioda2_take_ownership(struct iommu_table_group *table_group)
 	pnv_pci_ioda2_unset_window(&pe->table_group, 0);
 	if (pe->pbus)
 		pnv_ioda_setup_bus_dma(pe, pe->pbus, false);
-	pnv_ioda2_table_free(tbl);
+	iommu_free_table(tbl, "pnv");
 }
 
 static void pnv_ioda2_release_ownership(struct iommu_table_group *table_group)
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index cf3de91fbfe7..fbec7348a7e5 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -680,7 +680,7 @@ static void tce_iommu_free_table(struct tce_container *container,
 	unsigned long pages = tbl->it_allocated_size >> PAGE_SHIFT;
 
 	tce_iommu_userspace_view_free(tbl, container->mm);
-	tbl->it_ops->free(tbl);
+	iommu_free_table(tbl, "");
 	decrement_locked_vm(container->mm, pages);
 }
 
-- 
2.11.0
