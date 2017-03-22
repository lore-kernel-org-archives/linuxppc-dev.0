Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vnxNy1X4dzDqZs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 15:22:42 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH kernel v11 04/10] powerpc/vfio_spapr_tce: Add reference
 counting to iommu_table
Date: Wed, 22 Mar 2017 15:21:50 +1100
Message-Id: <20170322042156.11756-5-aik@ozlabs.ru>
In-Reply-To: <20170322042156.11756-1-aik@ozlabs.ru>
References: <20170322042156.11756-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

So far iommu_table obejcts were only used in virtual mode and had
a single owner. We are going to change this by implementing in-kernel
acceleration of DMA mapping requests. The proposed acceleration
will handle requests in real mode and KVM will keep references to tables.

This adds a kref to iommu_table and defines new helpers to update it.
This replaces iommu_free_table() with iommu_tce_table_put() and makes
iommu_free_table() static. iommu_tce_table_get() is not used in this patch
but it will be in the following patch.

Since this touches prototypes, this also removes @node_name parameter as
it has never been really useful on powernv and carrying it for
the pseries platform code to iommu_free_table() seems to be quite
useless as well.

This should cause no behavioral change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
Changes:
v10:
* iommu_tce_table_get() can fail now if a table is being destroyed, will be
used in 10/10
* iommu_tce_table_put() returns what kref_put() returned
* iommu_tce_table_put() got WARN_ON(!tbl) as the callers already check
for it and do not call _put() when tbl==NULL

v9:
* s/iommu_table_get/iommu_tce_table_get/ and
s/iommu_table_put/iommu_tce_table_put/ -- so I removed r-b/a-b
---
 arch/powerpc/include/asm/iommu.h          |  5 +++--
 arch/powerpc/kernel/iommu.c               | 27 ++++++++++++++++++++++-----
 arch/powerpc/platforms/powernv/pci-ioda.c | 14 +++++++-------
 arch/powerpc/platforms/powernv/pci.c      |  1 +
 arch/powerpc/platforms/pseries/iommu.c    |  3 ++-
 arch/powerpc/platforms/pseries/vio.c      |  2 +-
 drivers/vfio/vfio_iommu_spapr_tce.c       |  2 +-
 7 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index 4554699aec02..d96142572e6d 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -119,6 +119,7 @@ struct iommu_table {
 	struct list_head it_group_list;/* List of iommu_table_group_link */
 	unsigned long *it_userspace; /* userspace view of the table */
 	struct iommu_table_ops *it_ops;
+	struct kref    it_kref;
 };
 
 #define IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry) \
@@ -151,8 +152,8 @@ static inline void *get_iommu_table_base(struct device *dev)
 
 extern int dma_iommu_dma_supported(struct device *dev, u64 mask);
 
-/* Frees table for an individual device node */
-extern void iommu_free_table(struct iommu_table *tbl, const char *node_name);
+extern struct iommu_table *iommu_tce_table_get(struct iommu_table *tbl);
+extern int iommu_tce_table_put(struct iommu_table *tbl);
 
 /* Initializes an iommu_table based in values set in the passed-in
  * structure
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index bc142d87130f..af915da5e03a 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -711,13 +711,13 @@ struct iommu_table *iommu_init_table(struct iommu_table *tbl, int nid)
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
@@ -736,7 +736,7 @@ void iommu_free_table(struct iommu_table *tbl, const char *node_name)
 
 	/* verify that table contains no entries */
 	if (!bitmap_empty(tbl->it_map, tbl->it_size))
-		pr_warn("%s: Unexpected TCEs for %s\n", __func__, node_name);
+		pr_warn("%s: Unexpected TCEs\n", __func__);
 
 	/* calculate bitmap size in bytes */
 	bitmap_sz = BITS_TO_LONGS(tbl->it_size) * sizeof(unsigned long);
@@ -748,7 +748,24 @@ void iommu_free_table(struct iommu_table *tbl, const char *node_name)
 	/* free table */
 	kfree(tbl);
 }
-EXPORT_SYMBOL_GPL(iommu_free_table);
+
+struct iommu_table *iommu_tce_table_get(struct iommu_table *tbl)
+{
+	if (kref_get_unless_zero(&tbl->it_kref))
+		return tbl;
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(iommu_tce_table_get);
+
+int iommu_tce_table_put(struct iommu_table *tbl)
+{
+	if (WARN_ON(!tbl))
+		return 0;
+
+	return kref_put(&tbl->it_kref, iommu_table_free);
+}
+EXPORT_SYMBOL_GPL(iommu_tce_table_put);
 
 /* Creates TCEs for a user provided buffer.  The user buffer must be
  * contiguous real kernel storage (not vmalloc).  The address passed here
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 5dae54cb11e3..ee4cdb5b893f 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1424,7 +1424,7 @@ static void pnv_pci_ioda2_release_dma_pe(struct pci_dev *dev, struct pnv_ioda_pe
 		iommu_group_put(pe->table_group.group);
 		BUG_ON(pe->table_group.group);
 	}
-	iommu_free_table(tbl, of_node_full_name(dev->dev.of_node));
+	iommu_tce_table_put(tbl);
 }
 
 static void pnv_ioda_release_vf_PE(struct pci_dev *pdev)
@@ -2225,7 +2225,7 @@ static void pnv_pci_ioda1_setup_dma_pe(struct pnv_phb *phb,
 		__free_pages(tce_mem, get_order(tce32_segsz * segs));
 	if (tbl) {
 		pnv_pci_unlink_table_and_group(tbl, &pe->table_group);
-		iommu_free_table(tbl, "pnv");
+		iommu_tce_table_put(tbl);
 	}
 }
 
@@ -2321,7 +2321,7 @@ static long pnv_pci_ioda2_create_table(struct iommu_table_group *table_group,
 			bus_offset, page_shift, window_size,
 			levels, tbl);
 	if (ret) {
-		iommu_free_table(tbl, "pnv");
+		iommu_tce_table_put(tbl);
 		return ret;
 	}
 
@@ -2365,7 +2365,7 @@ static long pnv_pci_ioda2_setup_default_config(struct pnv_ioda_pe *pe)
 	if (rc) {
 		pe_err(pe, "Failed to configure 32-bit TCE table, err %ld\n",
 				rc);
-		iommu_free_table(tbl, "");
+		iommu_tce_table_put(tbl);
 		return rc;
 	}
 
@@ -2453,7 +2453,7 @@ static void pnv_ioda2_take_ownership(struct iommu_table_group *table_group)
 	pnv_pci_ioda2_unset_window(&pe->table_group, 0);
 	if (pe->pbus)
 		pnv_ioda_setup_bus_dma(pe, pe->pbus, false);
-	iommu_free_table(tbl, "pnv");
+	iommu_tce_table_put(tbl);
 }
 
 static void pnv_ioda2_release_ownership(struct iommu_table_group *table_group)
@@ -3428,7 +3428,7 @@ static void pnv_pci_ioda1_release_pe_dma(struct pnv_ioda_pe *pe)
 	}
 
 	free_pages(tbl->it_base, get_order(tbl->it_size << 3));
-	iommu_free_table(tbl, "pnv");
+	iommu_tce_table_put(tbl);
 }
 
 static void pnv_pci_ioda2_release_pe_dma(struct pnv_ioda_pe *pe)
@@ -3455,7 +3455,7 @@ static void pnv_pci_ioda2_release_pe_dma(struct pnv_ioda_pe *pe)
 	}
 
 	pnv_pci_ioda2_table_free_pages(tbl);
-	iommu_free_table(tbl, "pnv");
+	iommu_tce_table_put(tbl);
 }
 
 static void pnv_ioda_free_pe_seg(struct pnv_ioda_pe *pe,
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index eb835e977e33..204a829ff506 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -767,6 +767,7 @@ struct iommu_table *pnv_pci_table_alloc(int nid)
 
 	tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL, nid);
 	INIT_LIST_HEAD_RCU(&tbl->it_group_list);
+	kref_init(&tbl->it_kref);
 
 	return tbl;
 }
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 4d757eaa46bf..7ce5db209abf 100644
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
+	iommu_tce_table_put(tbl);
 
 	kfree(table_group);
 }
diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platforms/pseries/vio.c
index 720493932486..28b09fd797ec 100644
--- a/arch/powerpc/platforms/pseries/vio.c
+++ b/arch/powerpc/platforms/pseries/vio.c
@@ -1318,7 +1318,7 @@ static void vio_dev_release(struct device *dev)
 	struct iommu_table *tbl = get_iommu_table_base(dev);
 
 	if (tbl)
-		iommu_free_table(tbl, of_node_full_name(dev->of_node));
+		iommu_tce_table_put(tbl);
 	of_node_put(dev->of_node);
 	kfree(to_vio_dev(dev));
 }
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index fbec7348a7e5..8031d3a55a17 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -680,7 +680,7 @@ static void tce_iommu_free_table(struct tce_container *container,
 	unsigned long pages = tbl->it_allocated_size >> PAGE_SHIFT;
 
 	tce_iommu_userspace_view_free(tbl, container->mm);
-	iommu_free_table(tbl, "");
+	iommu_tce_table_put(tbl);
 	decrement_locked_vm(container->mm, pages);
 }
 
-- 
2.11.0
