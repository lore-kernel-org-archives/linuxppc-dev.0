Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [83.169.36.222])
 by lists.ozlabs.org (Postfix) with ESMTP id 3s464f0qfGzDqWP
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2016 18:41:54 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH kernel 08/15] powerpc/vfio_spapr_tce: Add reference counting
 to iommu_table
Date: Wed,  3 Aug 2016 18:40:49 +1000
Message-Id: <1470213656-1042-9-git-send-email-aik@ozlabs.ru>
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

So far iommu_table obejcts were only used in virtual mode and had
a single owner. We are going to change by implementing in-kernel
acceleration of DMA mapping requests, including real mode.

This adds a kref to iommu_table and defines new helpers to update it.
This replaces iommu_free_table() with iommu_table_put() and makes
iommu_free_table() static. iommu_table_get() is not used in this patch
but will be in the following one.

While we are here, this removes @node_name parameter as it has never been
really useful on powernv and carrying it for the pseries platform code to
iommu_free_table() seems to be quite useless too.

This should cause no behavioral change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/iommu.h          |  5 +++--
 arch/powerpc/kernel/iommu.c               | 24 +++++++++++++++++++-----
 arch/powerpc/kernel/vio.c                 |  2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c | 14 +++++++-------
 arch/powerpc/platforms/powernv/pci.c      |  1 +
 arch/powerpc/platforms/pseries/iommu.c    |  3 ++-
 drivers/vfio/vfio_iommu_spapr_tce.c       |  2 +-
 7 files changed, 34 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index f49a72a..cd4df44 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -114,6 +114,7 @@ struct iommu_table {
 	struct list_head it_group_list;/* List of iommu_table_group_link */
 	unsigned long *it_userspace; /* userspace view of the table */
 	struct iommu_table_ops *it_ops;
+	struct kref    it_kref;
 };
 
 #define IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry) \
@@ -146,8 +147,8 @@ static inline void *get_iommu_table_base(struct device *dev)
 
 extern int dma_iommu_dma_supported(struct device *dev, u64 mask);
 
-/* Frees table for an individual device node */
-extern void iommu_free_table(struct iommu_table *tbl, const char *node_name);
+extern void iommu_table_get(struct iommu_table *tbl);
+extern void iommu_table_put(struct iommu_table *tbl);
 
 /* Initializes an iommu_table based in values set in the passed-in
  * structure
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 13263b0..a8f017a 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -710,13 +710,13 @@ struct iommu_table *iommu_init_table(struct iommu_table *tbl, int nid)
 	return tbl;
 }
 
-void iommu_free_table(struct iommu_table *tbl, const char *node_name)
+static void iommu_table_free(struct kref *kref)
 {
 	unsigned long bitmap_sz;
 	unsigned int order;
+	struct iommu_table *tbl;
 
-	if (!tbl)
-		return;
+	tbl = container_of(kref, struct iommu_table, it_kref);
 
 	if (tbl->it_ops->free)
 		tbl->it_ops->free(tbl);
@@ -735,7 +735,7 @@ void iommu_free_table(struct iommu_table *tbl, const char *node_name)
 
 	/* verify that table contains no entries */
 	if (!bitmap_empty(tbl->it_map, tbl->it_size))
-		pr_warn("%s: Unexpected TCEs for %s\n", __func__, node_name);
+		pr_warn("%s: Unexpected TCEs\n", __func__);
 
 	/* calculate bitmap size in bytes */
 	bitmap_sz = BITS_TO_LONGS(tbl->it_size) * sizeof(unsigned long);
@@ -747,7 +747,21 @@ void iommu_free_table(struct iommu_table *tbl, const char *node_name)
 	/* free table */
 	kfree(tbl);
 }
-EXPORT_SYMBOL_GPL(iommu_free_table);
+
+void iommu_table_get(struct iommu_table *tbl)
+{
+	kref_get(&tbl->it_kref);
+}
+EXPORT_SYMBOL_GPL(iommu_table_get);
+
+void iommu_table_put(struct iommu_table *tbl)
+{
+	if (!tbl)
+		return;
+
+	kref_put(&tbl->it_kref, iommu_table_free);
+}
+EXPORT_SYMBOL_GPL(iommu_table_put);
 
 /* Creates TCEs for a user provided buffer.  The user buffer must be
  * contiguous real kernel storage (not vmalloc).  The address passed here
diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index 8d7358f..188f452 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -1318,7 +1318,7 @@ static void vio_dev_release(struct device *dev)
 	struct iommu_table *tbl = get_iommu_table_base(dev);
 
 	if (tbl)
-		iommu_free_table(tbl, of_node_full_name(dev->of_node));
+		iommu_table_put(tbl);
 	of_node_put(dev->of_node);
 	kfree(to_vio_dev(dev));
 }
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 74ab8382..c04afd2 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1394,7 +1394,7 @@ static void pnv_pci_ioda2_release_dma_pe(struct pci_dev *dev, struct pnv_ioda_pe
 		iommu_group_put(pe->table_group.group);
 		BUG_ON(pe->table_group.group);
 	}
-	iommu_free_table(tbl, of_node_full_name(dev->dev.of_node));
+	iommu_table_put(tbl);
 }
 
 static void pnv_ioda_release_vf_PE(struct pci_dev *pdev)
@@ -2171,7 +2171,7 @@ found:
 		__free_pages(tce_mem, get_order(tce32_segsz * segs));
 	if (tbl) {
 		pnv_pci_unlink_table_and_group(tbl, &pe->table_group);
-		iommu_free_table(tbl, "pnv");
+		iommu_table_put(tbl);
 	}
 }
 
@@ -2265,7 +2265,7 @@ static long pnv_pci_ioda2_create_table(struct iommu_table_group *table_group,
 			bus_offset, page_shift, window_size,
 			levels, tbl);
 	if (ret) {
-		iommu_free_table(tbl, "pnv");
+		iommu_table_put(tbl);
 		return ret;
 	}
 
@@ -2311,7 +2311,7 @@ static long pnv_pci_ioda2_setup_default_config(struct pnv_ioda_pe *pe)
 	if (rc) {
 		pe_err(pe, "Failed to configure 32-bit TCE table, err %ld\n",
 				rc);
-		iommu_free_table(tbl, "");
+		iommu_table_put(tbl);
 		return rc;
 	}
 
@@ -2397,7 +2397,7 @@ static void pnv_ioda2_take_ownership(struct iommu_table_group *table_group)
 
 	pnv_pci_ioda2_set_bypass(pe, false);
 	pnv_pci_ioda2_unset_window(&pe->table_group, 0);
-	iommu_free_table(tbl, "pnv");
+	iommu_table_put(tbl);
 }
 
 static void pnv_ioda2_release_ownership(struct iommu_table_group *table_group)
@@ -3311,7 +3311,7 @@ static void pnv_pci_ioda1_release_pe_dma(struct pnv_ioda_pe *pe)
 	}
 
 	free_pages(tbl->it_base, get_order(tbl->it_size << 3));
-	iommu_free_table(tbl, "pnv");
+	iommu_table_put(tbl);
 }
 
 static void pnv_pci_ioda2_release_pe_dma(struct pnv_ioda_pe *pe)
@@ -3338,7 +3338,7 @@ static void pnv_pci_ioda2_release_pe_dma(struct pnv_ioda_pe *pe)
 	}
 
 	pnv_pci_ioda2_table_free_pages(tbl);
-	iommu_free_table(tbl, "pnv");
+	iommu_table_put(tbl);
 }
 
 static void pnv_ioda_free_pe_seg(struct pnv_ioda_pe *pe,
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 6701dd5..5917439 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -767,6 +767,7 @@ struct iommu_table *pnv_pci_table_alloc(int nid)
 
 	tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL, nid);
 	INIT_LIST_HEAD_RCU(&tbl->it_group_list);
+	kref_init(&tbl->it_kref);
 
 	return tbl;
 }
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 0056856..da29518 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -74,6 +74,7 @@ static struct iommu_table_group *iommu_pseries_alloc_group(int node)
 		goto fail_exit;
 
 	INIT_LIST_HEAD_RCU(&tbl->it_group_list);
+	kref_init(&tbl->it_kref);
 	tgl->table_group = table_group;
 	list_add_rcu(&tgl->next, &tbl->it_group_list);
 
@@ -115,7 +116,7 @@ static void iommu_pseries_free_group(struct iommu_table_group *table_group,
 		BUG_ON(table_group->group);
 	}
 #endif
-	iommu_free_table(tbl, node_name);
+	iommu_table_put(tbl);
 
 	kfree(table_group);
 }
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 79f26c7..3594ad3 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -660,7 +660,7 @@ static void tce_iommu_free_table(struct iommu_table *tbl)
 	unsigned long pages = tbl->it_allocated_size >> PAGE_SHIFT;
 
 	tce_iommu_userspace_view_free(tbl);
-	iommu_free_table(tbl, "");
+	iommu_table_put(tbl);
 	decrement_locked_vm(pages);
 }
 
-- 
2.5.0.rc3
