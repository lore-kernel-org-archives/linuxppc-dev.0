Return-Path: <aik@ozlabs.ru>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B1D9F1A038D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 01:40:49 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 12 May 2015 01:40:48 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 980372CE805A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 01:40:46 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4BFecVu44630028
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 01:40:46 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4BFeDAq002044
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 01:40:14 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v10 17/34] powerpc/spapr: vfio: Switch from iommu_table
 to new iommu_table_group
Date: Tue, 12 May 2015 01:39:06 +1000
Message-Id: <1431358763-24371-18-git-send-email-aik@ozlabs.ru>
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

Modern IBM POWERPC systems support multiple (currently two) TCE tables
per IOMMU group (a.k.a. PE). This adds a iommu_table_group container
for TCE tables. Right now just one table is supported.

For IODA, instead of embedding iommu_table, the new iommu_table_group
keeps pointers to those. The iommu_table structs are allocated
dynamically now by a pnv_pci_table_alloc() helper as PCI hotplug
code (for EEH recovery) and SRIOV are supported there.

For P5IOC2, both iommu_table_group and iommu_table are embedded into
PE struct. As there is no EEH and SRIOV support for P5IOC2,
iommu_free_table() should not be called on iommu_table struct pointers
so we can keep it embedded in pnv_phb::p5ioc2.

For pSeries, this replaces multiple calls of kzalloc_node() with a new
iommu_pseries_group_alloc() helper and stores the table group struct
pointer into the pci_dn struct. For release, a iommu_table_group_free()
helper is added.

This moves iommu_table struct allocation from SR-IOV code to
the generic DMA initialization code in pnv_pci_ioda2_setup_dma_pe.

This replaces a single pointer to iommu_group with a list of
iommu_table_group structs. For now it is just a single iommu_table_group
in this list but later with TCE table sharing enabled, the list will
keep all the IOMMU groups which use the particular table. The list
uses iommu_table_group_link structs rather than iommu_table_group::next
as a VFIO container may have 2 IOMMU tables, each will have its own list
head pointer as it is mainly for TCE invalidation code which should
walk through all attached groups and invalidate TCE cache so
the table has to keep the list head pointer. The other option would
be storing list head in a VFIO container but it would not work as
the platform code (which does TCE table update and invalidation) has
no idea about VFIO.

This should cause no behavioural change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
[aw: for the vfio related changes]
Acked-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
Changes:
v10:
* iommu_table is not embedded into iommu_table_group but allocated
dynamically
* iommu_table allocation is moved to a single place for IODA2's
pnv_pci_ioda_setup_dma_pe where it belongs to
* added list of groups into iommu_table; most of the code just looks at
the first item to keep the patch simpler

v9:
* s/it_group/it_table_group/
* added and used iommu_table_group_free(), from now iommu_free_table()
is only used for VIO
* added iommu_pseries_group_alloc()
* squashed "powerpc/iommu: Introduce iommu_table_alloc() helper" into this
---
 arch/powerpc/include/asm/iommu.h            |   8 +-
 arch/powerpc/kernel/iommu.c                 |   9 +-
 arch/powerpc/platforms/powernv/pci-ioda.c   |  45 ++++++----
 arch/powerpc/platforms/powernv/pci-p5ioc2.c |   3 +
 arch/powerpc/platforms/powernv/pci.c        |  73 +++++++++++++++++
 arch/powerpc/platforms/powernv/pci.h        |   7 ++
 arch/powerpc/platforms/pseries/iommu.c      |  36 ++++++--
 drivers/vfio/vfio_iommu_spapr_tce.c         | 122 ++++++++++++++++++++--------
 8 files changed, 241 insertions(+), 62 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index 61bde1a..664beeb 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -92,7 +92,7 @@ struct iommu_table {
 	unsigned long *it_map;       /* A simple allocation bitmap for now */
 	unsigned long  it_page_shift;/* table iommu page size */
 #ifdef CONFIG_IOMMU_API
-	struct iommu_table_group *it_table_group;
+	struct list_head it_group_list;/* List of iommu_table_group_link */
 #endif
 	struct iommu_table_ops *it_ops;
 	void (*set_bypass)(struct iommu_table *tbl, bool enable);
@@ -130,6 +130,12 @@ extern struct iommu_table *iommu_init_table(struct iommu_table * tbl,
 
 #define IOMMU_TABLE_GROUP_MAX_TABLES	1
 
+struct iommu_table_group_link {
+	struct list_head next;
+	struct rcu_head rcu;
+	struct iommu_table_group *table_group;
+};
+
 struct iommu_table_group {
 	struct iommu_group *group;
 	struct iommu_table *tables[IOMMU_TABLE_GROUP_MAX_TABLES];
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 79e8b43..bdf19c6 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -1075,6 +1075,7 @@ EXPORT_SYMBOL_GPL(iommu_release_ownership);
 int iommu_add_device(struct device *dev)
 {
 	struct iommu_table *tbl;
+	struct iommu_table_group_link *tgl;
 
 	/*
 	 * The sysfs entries should be populated before
@@ -1092,15 +1093,17 @@ int iommu_add_device(struct device *dev)
 	}
 
 	tbl = get_iommu_table_base(dev);
-	if (!tbl || !tbl->it_table_group || !tbl->it_table_group->group) {
+	if (!tbl || list_empty(&tbl->it_group_list)) {
 		pr_debug("%s: Skipping device %s with no tbl\n",
 			 __func__, dev_name(dev));
 		return 0;
 	}
 
+	tgl = list_first_entry_or_null(&tbl->it_group_list,
+			struct iommu_table_group_link, next);
 	pr_debug("%s: Adding %s to iommu group %d\n",
 		 __func__, dev_name(dev),
-		 iommu_group_id(tbl->it_table_group->group));
+		 iommu_group_id(tgl->table_group->group));
 
 	if (PAGE_SIZE < IOMMU_PAGE_SIZE(tbl)) {
 		pr_err("%s: Invalid IOMMU page size %lx (%lx) on %s\n",
@@ -1109,7 +1112,7 @@ int iommu_add_device(struct device *dev)
 		return -EINVAL;
 	}
 
-	return iommu_group_add_device(tbl->it_table_group->group, dev);
+	return iommu_group_add_device(tgl->table_group->group, dev);
 }
 EXPORT_SYMBOL_GPL(iommu_add_device);
 
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 02ed448..53bf242b 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1288,7 +1288,6 @@ static void pnv_pci_ioda2_release_dma_pe(struct pci_dev *dev, struct pnv_ioda_pe
 	struct iommu_table    *tbl;
 	unsigned long         addr;
 	int64_t               rc;
-	struct iommu_table_group *table_group;
 
 	bus = dev->bus;
 	hose = pci_bus_to_host(bus);
@@ -1308,14 +1307,13 @@ static void pnv_pci_ioda2_release_dma_pe(struct pci_dev *dev, struct pnv_ioda_pe
 	if (rc)
 		pe_warn(pe, "OPAL error %ld release DMA window\n", rc);
 
-	table_group = tbl->it_table_group;
-	if (table_group->group) {
-		iommu_group_put(table_group->group);
-		BUG_ON(table_group->group);
+	pnv_pci_unlink_table_and_group(tbl, &pe->table_group);
+	if (pe->table_group.group) {
+		iommu_group_put(pe->table_group.group);
+		BUG_ON(pe->table_group.group);
 	}
 	iommu_free_table(tbl, of_node_full_name(dev->dev.of_node));
 	free_pages(addr, get_order(TCE32_TABLE_SIZE));
-	pe->table_group.tables[0] = NULL;
 }
 
 static void pnv_ioda_release_vf_PE(struct pci_dev *pdev, u16 num_vfs)
@@ -1675,7 +1673,10 @@ static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe,
 static void pnv_pci_ioda1_tce_invalidate(struct iommu_table *tbl,
 		unsigned long index, unsigned long npages, bool rm)
 {
-	struct pnv_ioda_pe *pe = container_of(tbl->it_table_group,
+	struct iommu_table_group_link *tgl = list_first_entry_or_null(
+			&tbl->it_group_list, struct iommu_table_group_link,
+			next);
+	struct pnv_ioda_pe *pe = container_of(tgl->table_group,
 			struct pnv_ioda_pe, table_group);
 	__be64 __iomem *invalidate = rm ?
 		(__be64 __iomem *)pe->tce_inval_reg_phys :
@@ -1753,7 +1754,10 @@ static struct iommu_table_ops pnv_ioda1_iommu_ops = {
 static void pnv_pci_ioda2_tce_invalidate(struct iommu_table *tbl,
 		unsigned long index, unsigned long npages, bool rm)
 {
-	struct pnv_ioda_pe *pe = container_of(tbl->it_table_group,
+	struct iommu_table_group_link *tgl = list_first_entry_or_null(
+			&tbl->it_group_list, struct iommu_table_group_link,
+			next);
+	struct pnv_ioda_pe *pe = container_of(tgl->table_group,
 			struct pnv_ioda_pe, table_group);
 	unsigned long start, end, inc;
 	__be64 __iomem *invalidate = rm ?
@@ -1830,12 +1834,10 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 	if (WARN_ON(pe->tce32_seg >= 0))
 		return;
 
-	tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
-			phb->hose->node);
-	tbl->it_table_group = &pe->table_group;
-	pe->table_group.tables[0] = tbl;
+	tbl = pnv_pci_table_alloc(phb->hose->node);
 	iommu_register_group(&pe->table_group, phb->hose->global_number,
 			pe->pe_number);
+	pnv_pci_link_table_and_group(phb->hose->node, 0, tbl, &pe->table_group);
 
 	/* Grab a 32-bit TCE table */
 	pe->tce32_seg = base;
@@ -1910,11 +1912,18 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 		pe->tce32_seg = -1;
 	if (tce_mem)
 		__free_pages(tce_mem, get_order(TCE32_TABLE_SIZE * segs));
+	if (tbl) {
+		pnv_pci_unlink_table_and_group(tbl, &pe->table_group);
+		iommu_free_table(tbl, "pnv");
+	}
 }
 
 static void pnv_pci_ioda2_set_bypass(struct iommu_table *tbl, bool enable)
 {
-	struct pnv_ioda_pe *pe = container_of(tbl->it_table_group,
+	struct iommu_table_group_link *tgl = list_first_entry_or_null(
+			&tbl->it_group_list, struct iommu_table_group_link,
+			next);
+	struct pnv_ioda_pe *pe = container_of(tgl->table_group,
 			struct pnv_ioda_pe, table_group);
 	uint16_t window_id = (pe->pe_number << 1 ) + 1;
 	int64_t rc;
@@ -1969,12 +1978,10 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 	if (WARN_ON(pe->tce32_seg >= 0))
 		return;
 
-	tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
-			phb->hose->node);
-	tbl->it_table_group = &pe->table_group;
-	pe->table_group.tables[0] = tbl;
+	tbl = pnv_pci_table_alloc(phb->hose->node);
 	iommu_register_group(&pe->table_group, phb->hose->global_number,
 			pe->pe_number);
+	pnv_pci_link_table_and_group(phb->hose->node, 0, tbl, &pe->table_group);
 
 	/* The PE will reserve all possible 32-bits space */
 	pe->tce32_seg = 0;
@@ -2047,6 +2054,10 @@ fail:
 		pe->tce32_seg = -1;
 	if (tce_mem)
 		__free_pages(tce_mem, get_order(tce_table_size));
+	if (tbl) {
+		pnv_pci_unlink_table_and_group(tbl, &pe->table_group);
+		iommu_free_table(tbl, "pnv");
+	}
 }
 
 static void pnv_ioda_setup_dma(struct pnv_phb *phb)
diff --git a/arch/powerpc/platforms/powernv/pci-p5ioc2.c b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
index 4ea9def..b524b17 100644
--- a/arch/powerpc/platforms/powernv/pci-p5ioc2.c
+++ b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
@@ -99,6 +99,9 @@ static void pnv_pci_p5ioc2_dma_dev_setup(struct pnv_phb *phb,
 		iommu_init_table(tbl, phb->hose->node);
 		iommu_register_group(&phb->p5ioc2.table_group,
 				pci_domain_nr(phb->hose->bus), phb->opal_id);
+		INIT_LIST_HEAD_RCU(&tbl->it_group_list);
+		pnv_pci_link_table_and_group(phb->hose->node, 0,
+				tbl, &phb->p5ioc2.table_group);
 	}
 
 	set_iommu_table_base(&pdev->dev, tbl);
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 84b4ea4..ed7de7b 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -606,6 +606,79 @@ unsigned long pnv_tce_get(struct iommu_table *tbl, long index)
 	return ((u64 *)tbl->it_base)[index - tbl->it_offset];
 }
 
+struct iommu_table *pnv_pci_table_alloc(int nid)
+{
+	struct iommu_table *tbl;
+
+	tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL, nid);
+	INIT_LIST_HEAD_RCU(&tbl->it_group_list);
+
+	return tbl;
+}
+
+long pnv_pci_link_table_and_group(int node, int num,
+		struct iommu_table *tbl,
+		struct iommu_table_group *table_group)
+{
+	struct iommu_table_group_link *tgl = NULL;
+
+	BUG_ON(!tbl);
+	BUG_ON(!table_group);
+	BUG_ON(!table_group->group);
+
+	tgl = kzalloc_node(sizeof(struct iommu_table_group_link), GFP_KERNEL,
+			node);
+	if (!tgl)
+		return -ENOMEM;
+
+	tgl->table_group = table_group;
+	list_add_rcu(&tgl->next, &tbl->it_group_list);
+
+	table_group->tables[num] = tbl;
+
+	return 0;
+}
+
+static void pnv_iommu_table_group_link_free(struct rcu_head *head)
+{
+	struct iommu_table_group_link *tgl = container_of(head,
+			struct iommu_table_group_link, rcu);
+
+	kfree(tgl);
+}
+
+void pnv_pci_unlink_table_and_group(struct iommu_table *tbl,
+		struct iommu_table_group *table_group)
+{
+	long i;
+	bool found;
+	struct iommu_table_group_link *tgl;
+
+	/* Remove link to a group from table's list of attached groups */
+	found = false;
+	list_for_each_entry_rcu(tgl, &tbl->it_group_list, next) {
+		if (tgl->table_group == table_group) {
+			list_del_rcu(&tgl->next);
+			call_rcu(&tgl->rcu, pnv_iommu_table_group_link_free);
+			found = true;
+			break;
+		}
+	}
+	if (WARN_ON(!found))
+		return;
+
+	/* Clean a pointer to iommu_table in iommu_table_group::tables[] */
+	found = false;
+	for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
+		if (table_group->tables[i] == tbl) {
+			table_group->tables[i] = NULL;
+			found = true;
+			break;
+		}
+	}
+	WARN_ON(!found);
+}
+
 void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
 			       void *tce_mem, u64 tce_size,
 			       u64 dma_offset, unsigned page_shift)
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 720cc99..87bdd4f 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -213,6 +213,13 @@ int pnv_pci_cfg_read(struct pci_dn *pdn,
 		     int where, int size, u32 *val);
 int pnv_pci_cfg_write(struct pci_dn *pdn,
 		      int where, int size, u32 val);
+extern struct iommu_table *pnv_pci_table_alloc(int nid);
+
+extern long pnv_pci_link_table_and_group(int node, int num,
+		struct iommu_table *tbl,
+		struct iommu_table_group *table_group);
+extern void pnv_pci_unlink_table_and_group(struct iommu_table *tbl,
+		struct iommu_table_group *table_group);
 extern void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
 				      void *tce_mem, u64 tce_size,
 				      u64 dma_offset, unsigned page_shift);
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index ad5ac6d..040fd45 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -37,6 +37,7 @@
 #include <linux/memory.h>
 #include <linux/of.h>
 #include <linux/iommu.h>
+#include <linux/rculist.h>
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/rtas.h>
@@ -56,6 +57,7 @@ static struct iommu_table_group *iommu_pseries_alloc_group(int node)
 {
 	struct iommu_table_group *table_group = NULL;
 	struct iommu_table *tbl = NULL;
+	struct iommu_table_group_link *tgl = NULL;
 
 	table_group = kzalloc_node(sizeof(struct iommu_table_group), GFP_KERNEL,
 			   node);
@@ -66,12 +68,21 @@ static struct iommu_table_group *iommu_pseries_alloc_group(int node)
 	if (!tbl)
 		goto fail_exit;
 
-	tbl->it_table_group = table_group;
+	tgl = kzalloc_node(sizeof(struct iommu_table_group_link), GFP_KERNEL,
+			node);
+	if (!tgl)
+		goto fail_exit;
+
+	INIT_LIST_HEAD_RCU(&tbl->it_group_list);
+	tgl->table_group = table_group;
+	list_add_rcu(&tgl->next, &tbl->it_group_list);
+
 	table_group->tables[0] = tbl;
 
 	return table_group;
 
 fail_exit:
+	kfree(tgl);
 	kfree(table_group);
 	kfree(tbl);
 
@@ -82,18 +93,33 @@ static void iommu_pseries_free_group(struct iommu_table_group *table_group,
 		const char *node_name)
 {
 	struct iommu_table *tbl;
+	long i;
 
 	if (!table_group)
 		return;
 
+	for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
+		tbl = table_group->tables[i];
+
+		if (tbl) {
+#ifdef CONFIG_IOMMU_API
+			struct iommu_table_group_link *tgl, *tmp;
+
+			list_for_each_entry_safe(tgl, tmp, &tbl->it_group_list,
+					next) {
+				list_del_rcu(&tgl->next);
+				kfree(tgl);
+			}
+#endif
+			iommu_free_table(tbl, node_name);
+		}
+	}
+#ifdef CONFIG_IOMMU_API
 	if (table_group->group) {
 		iommu_group_put(table_group->group);
 		BUG_ON(table_group->group);
 	}
-
-	tbl = table_group->tables[0];
-	iommu_free_table(tbl, node_name);
-
+#endif
 	kfree(table_group);
 }
 
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index bd87e46..ed3310b 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -88,7 +88,7 @@ static void decrement_locked_vm(long npages)
  */
 struct tce_container {
 	struct mutex lock;
-	struct iommu_table *tbl;
+	struct iommu_group *grp;
 	bool enabled;
 	unsigned long locked_pages;
 };
@@ -103,13 +103,42 @@ static bool tce_page_is_contained(struct page *page, unsigned page_shift)
 	return (PAGE_SHIFT + compound_order(compound_head(page))) >= page_shift;
 }
 
+static long tce_iommu_find_table(struct tce_container *container,
+		phys_addr_t ioba, struct iommu_table **ptbl)
+{
+	long i;
+	struct iommu_table_group *table_group;
+
+	table_group = iommu_group_get_iommudata(container->grp);
+	if (!table_group)
+		return -1;
+
+	for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
+		struct iommu_table *tbl = table_group->tables[i];
+
+		if (tbl) {
+			unsigned long entry = ioba >> tbl->it_page_shift;
+			unsigned long start = tbl->it_offset;
+			unsigned long end = start + tbl->it_size;
+
+			if ((start <= entry) && (entry < end)) {
+				*ptbl = tbl;
+				return i;
+			}
+		}
+	}
+
+	return -1;
+}
+
 static int tce_iommu_enable(struct tce_container *container)
 {
 	int ret = 0;
 	unsigned long locked;
-	struct iommu_table *tbl = container->tbl;
+	struct iommu_table *tbl;
+	struct iommu_table_group *table_group;
 
-	if (!container->tbl)
+	if (!container->grp)
 		return -ENXIO;
 
 	if (!current->mm)
@@ -143,6 +172,11 @@ static int tce_iommu_enable(struct tce_container *container)
 	 * as this information is only available from KVM and VFIO is
 	 * KVM agnostic.
 	 */
+	table_group = iommu_group_get_iommudata(container->grp);
+	if (!table_group)
+		return -ENODEV;
+
+	tbl = table_group->tables[0];
 	locked = (tbl->it_size << tbl->it_page_shift) >> PAGE_SHIFT;
 	ret = try_increment_locked_vm(locked);
 	if (ret)
@@ -190,11 +224,10 @@ static void tce_iommu_release(void *iommu_data)
 {
 	struct tce_container *container = iommu_data;
 
-	WARN_ON(container->tbl && !container->tbl->it_table_group->group);
+	WARN_ON(container->grp);
 
-	if (container->tbl && container->tbl->it_table_group->group)
-		tce_iommu_detach_group(iommu_data,
-				container->tbl->it_table_group->group);
+	if (container->grp)
+		tce_iommu_detach_group(iommu_data, container->grp);
 
 	tce_iommu_disable(container);
 	mutex_destroy(&container->lock);
@@ -312,9 +345,16 @@ static long tce_iommu_ioctl(void *iommu_data,
 
 	case VFIO_IOMMU_SPAPR_TCE_GET_INFO: {
 		struct vfio_iommu_spapr_tce_info info;
-		struct iommu_table *tbl = container->tbl;
+		struct iommu_table *tbl;
+		struct iommu_table_group *table_group;
 
-		if (WARN_ON(!tbl))
+		if (WARN_ON(!container->grp))
+			return -ENXIO;
+
+		table_group = iommu_group_get_iommudata(container->grp);
+
+		tbl = table_group->tables[0];
+		if (WARN_ON_ONCE(!tbl))
 			return -ENXIO;
 
 		minsz = offsetofend(struct vfio_iommu_spapr_tce_info,
@@ -337,17 +377,13 @@ static long tce_iommu_ioctl(void *iommu_data,
 	}
 	case VFIO_IOMMU_MAP_DMA: {
 		struct vfio_iommu_type1_dma_map param;
-		struct iommu_table *tbl = container->tbl;
+		struct iommu_table *tbl = NULL;
 		unsigned long tce;
+		long num;
 
 		if (!container->enabled)
 			return -EPERM;
 
-		if (!tbl)
-			return -ENXIO;
-
-		BUG_ON(!tbl->it_table_group->group);
-
 		minsz = offsetofend(struct vfio_iommu_type1_dma_map, size);
 
 		if (copy_from_user(&param, (void __user *)arg, minsz))
@@ -360,6 +396,10 @@ static long tce_iommu_ioctl(void *iommu_data,
 				VFIO_DMA_MAP_FLAG_WRITE))
 			return -EINVAL;
 
+		num = tce_iommu_find_table(container, param.iova, &tbl);
+		if (num < 0)
+			return -ENXIO;
+
 		if ((param.size & ~IOMMU_PAGE_MASK(tbl)) ||
 				(param.vaddr & ~IOMMU_PAGE_MASK(tbl)))
 			return -EINVAL;
@@ -385,14 +425,12 @@ static long tce_iommu_ioctl(void *iommu_data,
 	}
 	case VFIO_IOMMU_UNMAP_DMA: {
 		struct vfio_iommu_type1_dma_unmap param;
-		struct iommu_table *tbl = container->tbl;
+		struct iommu_table *tbl = NULL;
+		long num;
 
 		if (!container->enabled)
 			return -EPERM;
 
-		if (WARN_ON(!tbl))
-			return -ENXIO;
-
 		minsz = offsetofend(struct vfio_iommu_type1_dma_unmap,
 				size);
 
@@ -406,6 +444,10 @@ static long tce_iommu_ioctl(void *iommu_data,
 		if (param.flags)
 			return -EINVAL;
 
+		num = tce_iommu_find_table(container, param.iova, &tbl);
+		if (num < 0)
+			return -ENXIO;
+
 		if (param.size & ~IOMMU_PAGE_MASK(tbl))
 			return -EINVAL;
 
@@ -434,12 +476,11 @@ static long tce_iommu_ioctl(void *iommu_data,
 		mutex_unlock(&container->lock);
 		return 0;
 	case VFIO_EEH_PE_OP:
-		if (!container->tbl || !container->tbl->it_table_group->group)
+		if (!container->grp)
 			return -ENODEV;
 
-		return vfio_spapr_iommu_eeh_ioctl(
-				container->tbl->it_table_group->group,
-				cmd, arg);
+		return vfio_spapr_iommu_eeh_ioctl(container->grp,
+						  cmd, arg);
 	}
 
 	return -ENOTTY;
@@ -450,17 +491,15 @@ static int tce_iommu_attach_group(void *iommu_data,
 {
 	int ret;
 	struct tce_container *container = iommu_data;
-	struct iommu_table *tbl = iommu_group_get_iommudata(iommu_group);
+	struct iommu_table_group *table_group;
 
-	BUG_ON(!tbl);
 	mutex_lock(&container->lock);
 
 	/* pr_debug("tce_vfio: Attaching group #%u to iommu %p\n",
 			iommu_group_id(iommu_group), iommu_group); */
-	if (container->tbl) {
+	if (container->grp) {
 		pr_warn("tce_vfio: Only one group per IOMMU container is allowed, existing id=%d, attaching id=%d\n",
-				iommu_group_id(container->tbl->
-						it_table_group->group),
+				iommu_group_id(container->grp),
 				iommu_group_id(iommu_group));
 		ret = -EBUSY;
 		goto unlock_exit;
@@ -473,9 +512,15 @@ static int tce_iommu_attach_group(void *iommu_data,
 		goto unlock_exit;
 	}
 
-	ret = iommu_take_ownership(tbl);
+	table_group = iommu_group_get_iommudata(iommu_group);
+	if (!table_group) {
+		ret = -ENXIO;
+		goto unlock_exit;
+	}
+
+	ret = iommu_take_ownership(table_group->tables[0]);
 	if (!ret)
-		container->tbl = tbl;
+		container->grp = iommu_group;
 
 unlock_exit:
 	mutex_unlock(&container->lock);
@@ -487,26 +532,31 @@ static void tce_iommu_detach_group(void *iommu_data,
 		struct iommu_group *iommu_group)
 {
 	struct tce_container *container = iommu_data;
-	struct iommu_table *tbl = iommu_group_get_iommudata(iommu_group);
+	struct iommu_table_group *table_group;
+	struct iommu_table *tbl;
 
-	BUG_ON(!tbl);
 	mutex_lock(&container->lock);
-	if (tbl != container->tbl) {
+	if (iommu_group != container->grp) {
 		pr_warn("tce_vfio: detaching group #%u, expected group is #%u\n",
 				iommu_group_id(iommu_group),
-				iommu_group_id(tbl->it_table_group->group));
+				iommu_group_id(container->grp));
 		goto unlock_exit;
 	}
 
 	if (container->enabled) {
 		pr_warn("tce_vfio: detaching group #%u from enabled container, forcing disable\n",
-				iommu_group_id(tbl->it_table_group->group));
+				iommu_group_id(container->grp));
 		tce_iommu_disable(container);
 	}
 
 	/* pr_debug("tce_vfio: detaching group #%u from iommu %p\n",
 	   iommu_group_id(iommu_group), iommu_group); */
-	container->tbl = NULL;
+	container->grp = NULL;
+
+	table_group = iommu_group_get_iommudata(iommu_group);
+	BUG_ON(!table_group);
+
+	tbl = table_group->tables[0];
 	tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
 	iommu_release_ownership(tbl);
 
-- 
2.4.0.rc3.8.gfb3e7d5
