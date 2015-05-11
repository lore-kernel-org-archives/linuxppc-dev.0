Return-Path: <aik@ozlabs.ru>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 317BE1A03E5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 01:41:14 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 12 May 2015 01:41:13 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id DC7E1357805A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 01:41:10 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4BFf2x826476614
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 01:41:10 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4BFeclR011797
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 01:40:38 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v10 16/34] powerpc/spapr: vfio: Replace iommu_table
 with iommu_table_group
Date: Tue, 12 May 2015 01:39:05 +1000
Message-Id: <1431358763-24371-17-git-send-email-aik@ozlabs.ru>
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

This defines iommu_table_group struct which stores pointers to
iommu_group and iommu_table(s). This replaces iommu_table with
iommu_table_group where iommu_table was used to identify a group:
- iommu_register_group();
- iommudata of generic iommu_group;

This removes @data from iommu_table as it_table_group provides
same access to pnv_ioda_pe.

For IODA, instead of embedding iommu_table, the new iommu_table_group
keeps pointers to those. The iommu_table structs are allocated
dynamically.

For P5IOC2, both iommu_table_group and iommu_table are embedded into
PE struct. As there is no EEH and SRIOV support for P5IOC2,
iommu_free_table() should not be called on iommu_table struct pointers
so we can keep it embedded in pnv_phb::p5ioc2.

For pSeries, this replaces multiple calls of kzalloc_node() with a new
iommu_pseries_alloc_group() helper and stores the table group struct
pointer into the pci_dn struct. For release, a iommu_table_free_group()
helper is added.

This moves iommu_table struct allocation from SR-IOV code to
the generic DMA initialization code in pnv_pci_ioda_setup_dma_pe and
pnv_pci_ioda2_setup_dma_pe as this is where DMA is actually initialized.
This change is here because those lines had to be changed anyway.

This should cause no behavioural change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v10:
* new to the series, separated from
"powerpc/spapr: vfio: Switch from iommu_table to new iommu_table_group"
* iommu_table is not embedded into iommu_table_group but allocated
dynamically in most cases
* iommu_table allocation is moved to a single place for IODA2's
pnv_pci_ioda_setup_dma_pe where it belongs to
* added list of groups into iommu_table; most of the code just looks at
the first item to keep the patch simpler
---
 arch/powerpc/include/asm/iommu.h            |  17 +++--
 arch/powerpc/include/asm/pci-bridge.h       |   2 +-
 arch/powerpc/kernel/iommu.c                 |  17 ++---
 arch/powerpc/platforms/powernv/pci-ioda.c   |  55 +++++++-------
 arch/powerpc/platforms/powernv/pci-p5ioc2.c |  18 +++--
 arch/powerpc/platforms/powernv/pci.h        |   3 +-
 arch/powerpc/platforms/pseries/iommu.c      | 107 +++++++++++++++++++---------
 drivers/vfio/vfio_iommu_spapr_tce.c         |  23 +++---
 8 files changed, 152 insertions(+), 90 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index e2a45c3..61bde1a 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -92,13 +92,10 @@ struct iommu_table {
 	unsigned long *it_map;       /* A simple allocation bitmap for now */
 	unsigned long  it_page_shift;/* table iommu page size */
 #ifdef CONFIG_IOMMU_API
-	struct iommu_group *it_group;
+	struct iommu_table_group *it_table_group;
 #endif
 	struct iommu_table_ops *it_ops;
 	void (*set_bypass)(struct iommu_table *tbl, bool enable);
-#ifdef CONFIG_PPC_POWERNV
-	void           *data;
-#endif
 };
 
 /* Pure 2^n version of get_order */
@@ -130,13 +127,21 @@ extern void iommu_free_table(struct iommu_table *tbl, const char *node_name);
 extern struct iommu_table *iommu_init_table(struct iommu_table * tbl,
 					    int nid);
 #ifdef CONFIG_IOMMU_API
-extern void iommu_register_group(struct iommu_table *tbl,
+
+#define IOMMU_TABLE_GROUP_MAX_TABLES	1
+
+struct iommu_table_group {
+	struct iommu_group *group;
+	struct iommu_table *tables[IOMMU_TABLE_GROUP_MAX_TABLES];
+};
+
+extern void iommu_register_group(struct iommu_table_group *table_group,
 				 int pci_domain_number, unsigned long pe_num);
 extern int iommu_add_device(struct device *dev);
 extern void iommu_del_device(struct device *dev);
 extern int __init tce_iommu_bus_notifier_init(void);
 #else
-static inline void iommu_register_group(struct iommu_table *tbl,
+static inline void iommu_register_group(struct iommu_table_group *table_group,
 					int pci_domain_number,
 					unsigned long pe_num)
 {
diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 1811c44..e2d7479 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -185,7 +185,7 @@ struct pci_dn {
 
 	struct  pci_dn *parent;
 	struct  pci_controller *phb;	/* for pci devices */
-	struct	iommu_table *iommu_table;	/* for phb's or bridges */
+	struct	iommu_table_group *table_group;	/* for phb's or bridges */
 	struct	device_node *node;	/* back-pointer to the device_node */
 
 	int	pci_ext_config_space;	/* for pci devices */
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 16be6aa..79e8b43 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -886,11 +886,12 @@ EXPORT_SYMBOL_GPL(iommu_direction_to_tce_perm);
  */
 static void group_release(void *iommu_data)
 {
-	struct iommu_table *tbl = iommu_data;
-	tbl->it_group = NULL;
+	struct iommu_table_group *table_group = iommu_data;
+
+	table_group->group = NULL;
 }
 
-void iommu_register_group(struct iommu_table *tbl,
+void iommu_register_group(struct iommu_table_group *table_group,
 		int pci_domain_number, unsigned long pe_num)
 {
 	struct iommu_group *grp;
@@ -902,8 +903,8 @@ void iommu_register_group(struct iommu_table *tbl,
 				PTR_ERR(grp));
 		return;
 	}
-	tbl->it_group = grp;
-	iommu_group_set_iommudata(grp, tbl, group_release);
+	table_group->group = grp;
+	iommu_group_set_iommudata(grp, table_group, group_release);
 	name = kasprintf(GFP_KERNEL, "domain%d-pe%lx",
 			pci_domain_number, pe_num);
 	if (!name)
@@ -1091,7 +1092,7 @@ int iommu_add_device(struct device *dev)
 	}
 
 	tbl = get_iommu_table_base(dev);
-	if (!tbl || !tbl->it_group) {
+	if (!tbl || !tbl->it_table_group || !tbl->it_table_group->group) {
 		pr_debug("%s: Skipping device %s with no tbl\n",
 			 __func__, dev_name(dev));
 		return 0;
@@ -1099,7 +1100,7 @@ int iommu_add_device(struct device *dev)
 
 	pr_debug("%s: Adding %s to iommu group %d\n",
 		 __func__, dev_name(dev),
-		 iommu_group_id(tbl->it_group));
+		 iommu_group_id(tbl->it_table_group->group));
 
 	if (PAGE_SIZE < IOMMU_PAGE_SIZE(tbl)) {
 		pr_err("%s: Invalid IOMMU page size %lx (%lx) on %s\n",
@@ -1108,7 +1109,7 @@ int iommu_add_device(struct device *dev)
 		return -EINVAL;
 	}
 
-	return iommu_group_add_device(tbl->it_group, dev);
+	return iommu_group_add_device(tbl->it_table_group->group, dev);
 }
 EXPORT_SYMBOL_GPL(iommu_add_device);
 
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 1b43e25..02ed448 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1087,10 +1087,6 @@ static void pnv_ioda_setup_bus_PE(struct pci_bus *bus, int all)
 		return;
 	}
 
-	pe->tce32_table = kzalloc_node(sizeof(struct iommu_table),
-			GFP_KERNEL, hose->node);
-	pe->tce32_table->data = pe;
-
 	/* Associate it with all child devices */
 	pnv_ioda_setup_same_PE(bus, pe);
 
@@ -1292,11 +1288,12 @@ static void pnv_pci_ioda2_release_dma_pe(struct pci_dev *dev, struct pnv_ioda_pe
 	struct iommu_table    *tbl;
 	unsigned long         addr;
 	int64_t               rc;
+	struct iommu_table_group *table_group;
 
 	bus = dev->bus;
 	hose = pci_bus_to_host(bus);
 	phb = hose->private_data;
-	tbl = pe->tce32_table;
+	tbl = pe->table_group.tables[0];
 	addr = tbl->it_base;
 
 	opal_pci_map_pe_dma_window(phb->opal_id, pe->pe_number,
@@ -1311,13 +1308,14 @@ static void pnv_pci_ioda2_release_dma_pe(struct pci_dev *dev, struct pnv_ioda_pe
 	if (rc)
 		pe_warn(pe, "OPAL error %ld release DMA window\n", rc);
 
-	if (tbl->it_group) {
-		iommu_group_put(tbl->it_group);
-		BUG_ON(tbl->it_group);
+	table_group = tbl->it_table_group;
+	if (table_group->group) {
+		iommu_group_put(table_group->group);
+		BUG_ON(table_group->group);
 	}
 	iommu_free_table(tbl, of_node_full_name(dev->dev.of_node));
 	free_pages(addr, get_order(TCE32_TABLE_SIZE));
-	pe->tce32_table = NULL;
+	pe->table_group.tables[0] = NULL;
 }
 
 static void pnv_ioda_release_vf_PE(struct pci_dev *pdev, u16 num_vfs)
@@ -1465,10 +1463,6 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
 			continue;
 		}
 
-		pe->tce32_table = kzalloc_node(sizeof(struct iommu_table),
-				GFP_KERNEL, hose->node);
-		pe->tce32_table->data = pe;
-
 		/* Put PE to the list */
 		mutex_lock(&phb->ioda.pe_list_mutex);
 		list_add_tail(&pe->list, &phb->ioda.pe_list);
@@ -1603,7 +1597,7 @@ static void pnv_pci_ioda_dma_dev_setup(struct pnv_phb *phb, struct pci_dev *pdev
 
 	pe = &phb->ioda.pe_array[pdn->pe_number];
 	WARN_ON(get_dma_ops(&pdev->dev) != &dma_iommu_ops);
-	set_iommu_table_base(&pdev->dev, pe->tce32_table);
+	set_iommu_table_base(&pdev->dev, pe->table_group.tables[0]);
 	/*
 	 * Note: iommu_add_device() will fail here as
 	 * for physical PE: the device is already added by now;
@@ -1636,7 +1630,7 @@ static int pnv_pci_ioda_dma_set_mask(struct pnv_phb *phb,
 	} else {
 		dev_info(&pdev->dev, "Using 32-bit DMA via iommu\n");
 		set_dma_ops(&pdev->dev, &dma_iommu_ops);
-		set_iommu_table_base(&pdev->dev, pe->tce32_table);
+		set_iommu_table_base(&pdev->dev, pe->table_group.tables[0]);
 	}
 	*pdev->dev.dma_mask = dma_mask;
 	return 0;
@@ -1670,7 +1664,7 @@ static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe,
 	struct pci_dev *dev;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
-		set_iommu_table_base(&dev->dev, pe->tce32_table);
+		set_iommu_table_base(&dev->dev, pe->table_group.tables[0]);
 		iommu_add_device(&dev->dev);
 
 		if (dev->subordinate)
@@ -1681,7 +1675,8 @@ static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe,
 static void pnv_pci_ioda1_tce_invalidate(struct iommu_table *tbl,
 		unsigned long index, unsigned long npages, bool rm)
 {
-	struct pnv_ioda_pe *pe = tbl->data;
+	struct pnv_ioda_pe *pe = container_of(tbl->it_table_group,
+			struct pnv_ioda_pe, table_group);
 	__be64 __iomem *invalidate = rm ?
 		(__be64 __iomem *)pe->tce_inval_reg_phys :
 		(__be64 __iomem *)tbl->it_index;
@@ -1758,7 +1753,8 @@ static struct iommu_table_ops pnv_ioda1_iommu_ops = {
 static void pnv_pci_ioda2_tce_invalidate(struct iommu_table *tbl,
 		unsigned long index, unsigned long npages, bool rm)
 {
-	struct pnv_ioda_pe *pe = tbl->data;
+	struct pnv_ioda_pe *pe = container_of(tbl->it_table_group,
+			struct pnv_ioda_pe, table_group);
 	unsigned long start, end, inc;
 	__be64 __iomem *invalidate = rm ?
 		(__be64 __iomem *)pe->tce_inval_reg_phys :
@@ -1834,8 +1830,12 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 	if (WARN_ON(pe->tce32_seg >= 0))
 		return;
 
-	tbl = pe->tce32_table;
-	iommu_register_group(tbl, phb->hose->global_number, pe->pe_number);
+	tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
+			phb->hose->node);
+	tbl->it_table_group = &pe->table_group;
+	pe->table_group.tables[0] = tbl;
+	iommu_register_group(&pe->table_group, phb->hose->global_number,
+			pe->pe_number);
 
 	/* Grab a 32-bit TCE table */
 	pe->tce32_seg = base;
@@ -1914,7 +1914,8 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 
 static void pnv_pci_ioda2_set_bypass(struct iommu_table *tbl, bool enable)
 {
-	struct pnv_ioda_pe *pe = tbl->data;
+	struct pnv_ioda_pe *pe = container_of(tbl->it_table_group,
+			struct pnv_ioda_pe, table_group);
 	uint16_t window_id = (pe->pe_number << 1 ) + 1;
 	int64_t rc;
 
@@ -1948,10 +1949,10 @@ static void pnv_pci_ioda2_setup_bypass_pe(struct pnv_phb *phb,
 	pe->tce_bypass_base = 1ull << 59;
 
 	/* Install set_bypass callback for VFIO */
-	pe->tce32_table->set_bypass = pnv_pci_ioda2_set_bypass;
+	pe->table_group.tables[0]->set_bypass = pnv_pci_ioda2_set_bypass;
 
 	/* Enable bypass by default */
-	pnv_pci_ioda2_set_bypass(pe->tce32_table, true);
+	pnv_pci_ioda2_set_bypass(pe->table_group.tables[0], true);
 }
 
 static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
@@ -1968,8 +1969,12 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 	if (WARN_ON(pe->tce32_seg >= 0))
 		return;
 
-	tbl = pe->tce32_table;
-	iommu_register_group(tbl, phb->hose->global_number, pe->pe_number);
+	tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
+			phb->hose->node);
+	tbl->it_table_group = &pe->table_group;
+	pe->table_group.tables[0] = tbl;
+	iommu_register_group(&pe->table_group, phb->hose->global_number,
+			pe->pe_number);
 
 	/* The PE will reserve all possible 32-bits space */
 	pe->tce32_seg = 0;
diff --git a/arch/powerpc/platforms/powernv/pci-p5ioc2.c b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
index 2722c1a..4ea9def 100644
--- a/arch/powerpc/platforms/powernv/pci-p5ioc2.c
+++ b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
@@ -92,14 +92,16 @@ static struct iommu_table_ops pnv_p5ioc2_iommu_ops = {
 static void pnv_pci_p5ioc2_dma_dev_setup(struct pnv_phb *phb,
 					 struct pci_dev *pdev)
 {
-	if (phb->p5ioc2.iommu_table.it_map == NULL) {
-		phb->p5ioc2.iommu_table.it_ops = &pnv_p5ioc2_iommu_ops;
-		iommu_init_table(&phb->p5ioc2.iommu_table, phb->hose->node);
-		iommu_register_group(&phb->p5ioc2.iommu_table,
+	struct iommu_table *tbl = phb->p5ioc2.table_group.tables[0];
+
+	if (!tbl->it_map) {
+		tbl->it_ops = &pnv_p5ioc2_iommu_ops;
+		iommu_init_table(tbl, phb->hose->node);
+		iommu_register_group(&phb->p5ioc2.table_group,
 				pci_domain_nr(phb->hose->bus), phb->opal_id);
 	}
 
-	set_iommu_table_base(&pdev->dev, &phb->p5ioc2.iommu_table);
+	set_iommu_table_base(&pdev->dev, tbl);
 	iommu_add_device(&pdev->dev);
 }
 
@@ -180,6 +182,12 @@ static void __init pnv_pci_init_p5ioc2_phb(struct device_node *np, u64 hub_id,
 	pnv_pci_setup_iommu_table(&phb->p5ioc2.iommu_table,
 				  tce_mem, tce_size, 0,
 				  IOMMU_PAGE_SHIFT_4K);
+	/*
+	 * We do not allocate iommu_table as we do not support
+	 * hotplug or SRIOV on P5IOC2 and therefore iommu_free_table()
+	 * should not be called for phb->p5ioc2.table_group.tables[0] ever.
+	 */
+	phb->p5ioc2.table_group.tables[0] = &phb->p5ioc2.iommu_table;
 }
 
 void __init pnv_pci_init_p5ioc2_hub(struct device_node *np)
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index ec26afd..720cc99 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -57,7 +57,7 @@ struct pnv_ioda_pe {
 	/* "Base" iommu table, ie, 4K TCEs, 32-bit DMA */
 	int			tce32_seg;
 	int			tce32_segcount;
-	struct iommu_table	*tce32_table;
+	struct iommu_table_group table_group;
 	phys_addr_t		tce_inval_reg_phys;
 
 	/* 64-bit TCE bypass region */
@@ -123,6 +123,7 @@ struct pnv_phb {
 	union {
 		struct {
 			struct iommu_table iommu_table;
+			struct iommu_table_group table_group;
 		} p5ioc2;
 
 		struct {
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 4f2ab90..ad5ac6d 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -52,14 +52,49 @@
 
 #include "pseries.h"
 
-static void iommu_pseries_free_table(struct iommu_table *tbl,
+static struct iommu_table_group *iommu_pseries_alloc_group(int node)
+{
+	struct iommu_table_group *table_group = NULL;
+	struct iommu_table *tbl = NULL;
+
+	table_group = kzalloc_node(sizeof(struct iommu_table_group), GFP_KERNEL,
+			   node);
+	if (!table_group)
+		goto fail_exit;
+
+	tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL, node);
+	if (!tbl)
+		goto fail_exit;
+
+	tbl->it_table_group = table_group;
+	table_group->tables[0] = tbl;
+
+	return table_group;
+
+fail_exit:
+	kfree(table_group);
+	kfree(tbl);
+
+	return NULL;
+}
+
+static void iommu_pseries_free_group(struct iommu_table_group *table_group,
 		const char *node_name)
 {
-	if (tbl->it_group) {
-		iommu_group_put(tbl->it_group);
-		BUG_ON(tbl->it_group);
+	struct iommu_table *tbl;
+
+	if (!table_group)
+		return;
+
+	if (table_group->group) {
+		iommu_group_put(table_group->group);
+		BUG_ON(table_group->group);
 	}
+
+	tbl = table_group->tables[0];
 	iommu_free_table(tbl, node_name);
+
+	kfree(table_group);
 }
 
 static void tce_invalidate_pSeries_sw(struct iommu_table *tbl,
@@ -629,13 +664,13 @@ static void pci_dma_bus_setup_pSeries(struct pci_bus *bus)
 	pci->phb->dma_window_size = 0x8000000ul;
 	pci->phb->dma_window_base_cur = 0x8000000ul;
 
-	tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
-			   pci->phb->node);
+	pci->table_group = iommu_pseries_alloc_group(pci->phb->node);
+	tbl = pci->table_group->tables[0];
 
 	iommu_table_setparms(pci->phb, dn, tbl);
 	tbl->it_ops = &iommu_table_pseries_ops;
-	pci->iommu_table = iommu_init_table(tbl, pci->phb->node);
-	iommu_register_group(tbl, pci_domain_nr(bus), 0);
+	iommu_init_table(tbl, pci->phb->node);
+	iommu_register_group(pci->table_group, pci_domain_nr(bus), 0);
 
 	/* Divide the rest (1.75GB) among the children */
 	pci->phb->dma_window_size = 0x80000000ul;
@@ -678,16 +713,17 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
 	ppci = PCI_DN(pdn);
 
 	pr_debug("  parent is %s, iommu_table: 0x%p\n",
-		 pdn->full_name, ppci->iommu_table);
+		 pdn->full_name, ppci->table_group);
 
-	if (!ppci->iommu_table) {
-		tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
-				   ppci->phb->node);
+	if (!ppci->table_group) {
+		ppci->table_group = iommu_pseries_alloc_group(ppci->phb->node);
+		tbl = ppci->table_group->tables[0];
 		iommu_table_setparms_lpar(ppci->phb, pdn, tbl, dma_window);
 		tbl->it_ops = &iommu_table_lpar_multi_ops;
-		ppci->iommu_table = iommu_init_table(tbl, ppci->phb->node);
-		iommu_register_group(tbl, pci_domain_nr(bus), 0);
-		pr_debug("  created table: %p\n", ppci->iommu_table);
+		iommu_init_table(tbl, ppci->phb->node);
+		iommu_register_group(ppci->table_group,
+				pci_domain_nr(bus), 0);
+		pr_debug("  created table: %p\n", ppci->table_group);
 	}
 }
 
@@ -709,12 +745,13 @@ static void pci_dma_dev_setup_pSeries(struct pci_dev *dev)
 		struct pci_controller *phb = PCI_DN(dn)->phb;
 
 		pr_debug(" --> first child, no bridge. Allocating iommu table.\n");
-		tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
-				   phb->node);
+		PCI_DN(dn)->table_group = iommu_pseries_alloc_group(phb->node);
+		tbl = PCI_DN(dn)->table_group->tables[0];
 		iommu_table_setparms(phb, dn, tbl);
 		tbl->it_ops = &iommu_table_pseries_ops;
-		PCI_DN(dn)->iommu_table = iommu_init_table(tbl, phb->node);
-		iommu_register_group(tbl, pci_domain_nr(phb->bus), 0);
+		iommu_init_table(tbl, phb->node);
+		iommu_register_group(PCI_DN(dn)->table_group,
+				pci_domain_nr(phb->bus), 0);
 		set_iommu_table_base(&dev->dev, tbl);
 		iommu_add_device(&dev->dev);
 		return;
@@ -724,11 +761,12 @@ static void pci_dma_dev_setup_pSeries(struct pci_dev *dev)
 	 * an already allocated iommu table is found and use that.
 	 */
 
-	while (dn && PCI_DN(dn) && PCI_DN(dn)->iommu_table == NULL)
+	while (dn && PCI_DN(dn) && PCI_DN(dn)->table_group == NULL)
 		dn = dn->parent;
 
 	if (dn && PCI_DN(dn)) {
-		set_iommu_table_base(&dev->dev, PCI_DN(dn)->iommu_table);
+		set_iommu_table_base(&dev->dev,
+				PCI_DN(dn)->table_group->tables[0]);
 		iommu_add_device(&dev->dev);
 	} else
 		printk(KERN_WARNING "iommu: Device %s has no iommu table\n",
@@ -1115,7 +1153,7 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 	dn = pci_device_to_OF_node(dev);
 	pr_debug("  node is %s\n", dn->full_name);
 
-	for (pdn = dn; pdn && PCI_DN(pdn) && !PCI_DN(pdn)->iommu_table;
+	for (pdn = dn; pdn && PCI_DN(pdn) && !PCI_DN(pdn)->table_group;
 	     pdn = pdn->parent) {
 		dma_window = of_get_property(pdn, "ibm,dma-window", NULL);
 		if (dma_window)
@@ -1131,19 +1169,20 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 	pr_debug("  parent is %s\n", pdn->full_name);
 
 	pci = PCI_DN(pdn);
-	if (!pci->iommu_table) {
-		tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
-				   pci->phb->node);
+	if (!pci->table_group) {
+		pci->table_group = iommu_pseries_alloc_group(pci->phb->node);
+		tbl = pci->table_group->tables[0];
 		iommu_table_setparms_lpar(pci->phb, pdn, tbl, dma_window);
 		tbl->it_ops = &iommu_table_lpar_multi_ops;
-		pci->iommu_table = iommu_init_table(tbl, pci->phb->node);
-		iommu_register_group(tbl, pci_domain_nr(pci->phb->bus), 0);
-		pr_debug("  created table: %p\n", pci->iommu_table);
+		iommu_init_table(tbl, pci->phb->node);
+		iommu_register_group(pci->table_group,
+				pci_domain_nr(pci->phb->bus), 0);
+		pr_debug("  created table: %p\n", pci->table_group);
 	} else {
-		pr_debug("  found DMA window, table: %p\n", pci->iommu_table);
+		pr_debug("  found DMA window, table: %p\n", pci->table_group);
 	}
 
-	set_iommu_table_base(&dev->dev, pci->iommu_table);
+	set_iommu_table_base(&dev->dev, pci->table_group->tables[0]);
 	iommu_add_device(&dev->dev);
 }
 
@@ -1174,7 +1213,7 @@ static int dma_set_mask_pSeriesLP(struct device *dev, u64 dma_mask)
 		 * search upwards in the tree until we either hit a dma-window
 		 * property, OR find a parent with a table already allocated.
 		 */
-		for (pdn = dn; pdn && PCI_DN(pdn) && !PCI_DN(pdn)->iommu_table;
+		for (pdn = dn; pdn && PCI_DN(pdn) && !PCI_DN(pdn)->table_group;
 				pdn = pdn->parent) {
 			dma_window = of_get_property(pdn, "ibm,dma-window", NULL);
 			if (dma_window)
@@ -1218,7 +1257,7 @@ static u64 dma_get_required_mask_pSeriesLP(struct device *dev)
 		dn = pci_device_to_OF_node(pdev);
 
 		/* search upwards for ibm,dma-window */
-		for (; dn && PCI_DN(dn) && !PCI_DN(dn)->iommu_table;
+		for (; dn && PCI_DN(dn) && !PCI_DN(dn)->table_group;
 				dn = dn->parent)
 			if (of_get_property(dn, "ibm,dma-window", NULL))
 				break;
@@ -1298,8 +1337,8 @@ static int iommu_reconfig_notifier(struct notifier_block *nb, unsigned long acti
 		 * the device node.
 		 */
 		remove_ddw(np, false);
-		if (pci && pci->iommu_table)
-			iommu_pseries_free_table(pci->iommu_table,
+		if (pci && pci->table_group)
+			iommu_pseries_free_group(pci->table_group,
 					np->full_name);
 
 		spin_lock(&direct_window_list_lock);
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 0fbe03e..bd87e46 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -190,10 +190,11 @@ static void tce_iommu_release(void *iommu_data)
 {
 	struct tce_container *container = iommu_data;
 
-	WARN_ON(container->tbl && !container->tbl->it_group);
+	WARN_ON(container->tbl && !container->tbl->it_table_group->group);
 
-	if (container->tbl && container->tbl->it_group)
-		tce_iommu_detach_group(iommu_data, container->tbl->it_group);
+	if (container->tbl && container->tbl->it_table_group->group)
+		tce_iommu_detach_group(iommu_data,
+				container->tbl->it_table_group->group);
 
 	tce_iommu_disable(container);
 	mutex_destroy(&container->lock);
@@ -345,7 +346,7 @@ static long tce_iommu_ioctl(void *iommu_data,
 		if (!tbl)
 			return -ENXIO;
 
-		BUG_ON(!tbl->it_group);
+		BUG_ON(!tbl->it_table_group->group);
 
 		minsz = offsetofend(struct vfio_iommu_type1_dma_map, size);
 
@@ -433,11 +434,12 @@ static long tce_iommu_ioctl(void *iommu_data,
 		mutex_unlock(&container->lock);
 		return 0;
 	case VFIO_EEH_PE_OP:
-		if (!container->tbl || !container->tbl->it_group)
+		if (!container->tbl || !container->tbl->it_table_group->group)
 			return -ENODEV;
 
-		return vfio_spapr_iommu_eeh_ioctl(container->tbl->it_group,
-						  cmd, arg);
+		return vfio_spapr_iommu_eeh_ioctl(
+				container->tbl->it_table_group->group,
+				cmd, arg);
 	}
 
 	return -ENOTTY;
@@ -457,7 +459,8 @@ static int tce_iommu_attach_group(void *iommu_data,
 			iommu_group_id(iommu_group), iommu_group); */
 	if (container->tbl) {
 		pr_warn("tce_vfio: Only one group per IOMMU container is allowed, existing id=%d, attaching id=%d\n",
-				iommu_group_id(container->tbl->it_group),
+				iommu_group_id(container->tbl->
+						it_table_group->group),
 				iommu_group_id(iommu_group));
 		ret = -EBUSY;
 		goto unlock_exit;
@@ -491,13 +494,13 @@ static void tce_iommu_detach_group(void *iommu_data,
 	if (tbl != container->tbl) {
 		pr_warn("tce_vfio: detaching group #%u, expected group is #%u\n",
 				iommu_group_id(iommu_group),
-				iommu_group_id(tbl->it_group));
+				iommu_group_id(tbl->it_table_group->group));
 		goto unlock_exit;
 	}
 
 	if (container->enabled) {
 		pr_warn("tce_vfio: detaching group #%u from enabled container, forcing disable\n",
-				iommu_group_id(tbl->it_group));
+				iommu_group_id(tbl->it_table_group->group));
 		tce_iommu_disable(container);
 	}
 
-- 
2.4.0.rc3.8.gfb3e7d5
