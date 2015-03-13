Return-Path: <aik@ozlabs.ru>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B81361A08FF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 19:09:05 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 13 Mar 2015 18:09:05 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id CC4FC3578055
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 19:09:02 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2D88smf34799740
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 19:09:02 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2D88ThZ014036
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 19:08:29 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v6 13/29] powerpc/spapr: vfio: Switch from iommu_table
 to new iommu_table_group
Date: Fri, 13 Mar 2015 19:07:21 +1100
Message-Id: <1426234057-16165-14-git-send-email-aik@ozlabs.ru>
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

Modern IBM POWERPC systems support multiple (currently two) TCE tables
per IOMMU group (a.k.a. PE). This adds a iommu_table_group container
for TCE tables. Right now just one table is supported.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/iommu.h            |  18 +++--
 arch/powerpc/kernel/iommu.c                 |  34 ++++----
 arch/powerpc/platforms/powernv/pci-ioda.c   |  38 +++++----
 arch/powerpc/platforms/powernv/pci-p5ioc2.c |  17 ++--
 arch/powerpc/platforms/powernv/pci.c        |   2 +-
 arch/powerpc/platforms/powernv/pci.h        |   4 +-
 arch/powerpc/platforms/pseries/iommu.c      |   9 ++-
 drivers/vfio/vfio_iommu_spapr_tce.c         | 120 ++++++++++++++++++++--------
 8 files changed, 160 insertions(+), 82 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index eb75726..667aa1a 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -90,9 +90,7 @@ struct iommu_table {
 	struct iommu_pool pools[IOMMU_NR_POOLS];
 	unsigned long *it_map;       /* A simple allocation bitmap for now */
 	unsigned long  it_page_shift;/* table iommu page size */
-#ifdef CONFIG_IOMMU_API
-	struct iommu_group *it_group;
-#endif
+	struct iommu_table_group *it_group;
 	struct iommu_table_ops *it_ops;
 	void (*set_bypass)(struct iommu_table *tbl, bool enable);
 };
@@ -126,14 +124,24 @@ extern void iommu_free_table(struct iommu_table *tbl, const char *node_name);
  */
 extern struct iommu_table *iommu_init_table(struct iommu_table * tbl,
 					    int nid);
+
+#define IOMMU_TABLE_GROUP_MAX_TABLES	1
+
+struct iommu_table_group {
 #ifdef CONFIG_IOMMU_API
-extern void iommu_register_group(struct iommu_table *tbl,
+	struct iommu_group *group;
+#endif
+	struct iommu_table tables[IOMMU_TABLE_GROUP_MAX_TABLES];
+};
+
+#ifdef CONFIG_IOMMU_API
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
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index dbc5d8d..7794dce 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -712,17 +712,20 @@ struct iommu_table *iommu_init_table(struct iommu_table *tbl, int nid)
 
 struct iommu_table *iommu_table_alloc(int node)
 {
-	struct iommu_table *tbl;
+	struct iommu_table_group *table_group;
 
-	tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL, node);
+	table_group = kzalloc_node(sizeof(struct iommu_table_group), GFP_KERNEL,
+			   node);
+	table_group->tables[0].it_group = table_group;
 
-	return tbl;
+	return &table_group->tables[0];
 }
 
 void iommu_free_table(struct iommu_table *tbl, const char *node_name)
 {
 	unsigned long bitmap_sz;
 	unsigned int order;
+	struct iommu_table_group *table_group = tbl->it_group;
 
 	if (!tbl || !tbl->it_map) {
 		printk(KERN_ERR "%s: expected TCE map for %s\n", __func__,
@@ -738,9 +741,9 @@ void iommu_free_table(struct iommu_table *tbl, const char *node_name)
 		clear_bit(0, tbl->it_map);
 
 #ifdef CONFIG_IOMMU_API
-	if (tbl->it_group) {
-		iommu_group_put(tbl->it_group);
-		BUG_ON(tbl->it_group);
+	if (table_group->group) {
+		iommu_group_put(table_group->group);
+		BUG_ON(table_group->group);
 	}
 #endif
 
@@ -756,7 +759,7 @@ void iommu_free_table(struct iommu_table *tbl, const char *node_name)
 	free_pages((unsigned long) tbl->it_map, order);
 
 	/* free table */
-	kfree(tbl);
+	kfree(table_group);
 }
 
 /* Creates TCEs for a user provided buffer.  The user buffer must be
@@ -888,11 +891,12 @@ void iommu_free_coherent(struct iommu_table *tbl, size_t size,
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
@@ -904,8 +908,8 @@ void iommu_register_group(struct iommu_table *tbl,
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
@@ -1108,7 +1112,7 @@ int iommu_add_device(struct device *dev)
 	}
 
 	tbl = get_iommu_table_base(dev);
-	if (!tbl || !tbl->it_group) {
+	if (!tbl || !tbl->it_group || !tbl->it_group->group) {
 		pr_debug("%s: Skipping device %s with no tbl\n",
 			 __func__, dev_name(dev));
 		return 0;
@@ -1116,7 +1120,7 @@ int iommu_add_device(struct device *dev)
 
 	pr_debug("%s: Adding %s to iommu group %d\n",
 		 __func__, dev_name(dev),
-		 iommu_group_id(tbl->it_group));
+		 iommu_group_id(tbl->it_group->group));
 
 	if (PAGE_SIZE < IOMMU_PAGE_SIZE(tbl)) {
 		pr_err("%s: Invalid IOMMU page size %lx (%lx) on %s\n",
@@ -1125,7 +1129,7 @@ int iommu_add_device(struct device *dev)
 		return -EINVAL;
 	}
 
-	return iommu_group_add_device(tbl->it_group, dev);
+	return iommu_group_add_device(tbl->it_group->group, dev);
 }
 EXPORT_SYMBOL_GPL(iommu_add_device);
 
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 85e64a5..a964c50 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -23,6 +23,7 @@
 #include <linux/io.h>
 #include <linux/msi.h>
 #include <linux/memblock.h>
+#include <linux/iommu.h>
 
 #include <asm/sections.h>
 #include <asm/io.h>
@@ -989,7 +990,7 @@ static void pnv_pci_ioda_dma_dev_setup(struct pnv_phb *phb, struct pci_dev *pdev
 
 	pe = &phb->ioda.pe_array[pdn->pe_number];
 	WARN_ON(get_dma_ops(&pdev->dev) != &dma_iommu_ops);
-	set_iommu_table_base_and_group(&pdev->dev, &pe->tce32_table);
+	set_iommu_table_base_and_group(&pdev->dev, &pe->table_group.tables[0]);
 }
 
 static int pnv_pci_ioda_dma_set_mask(struct pnv_phb *phb,
@@ -1016,7 +1017,7 @@ static int pnv_pci_ioda_dma_set_mask(struct pnv_phb *phb,
 	} else {
 		dev_info(&pdev->dev, "Using 32-bit DMA via iommu\n");
 		set_dma_ops(&pdev->dev, &dma_iommu_ops);
-		set_iommu_table_base(&pdev->dev, &pe->tce32_table);
+		set_iommu_table_base(&pdev->dev, &pe->table_group.tables[0]);
 	}
 	*pdev->dev.dma_mask = dma_mask;
 	return 0;
@@ -1053,9 +1054,10 @@ static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe,
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		if (add_to_iommu_group)
 			set_iommu_table_base_and_group(&dev->dev,
-						       &pe->tce32_table);
+					&pe->table_group.tables[0]);
 		else
-			set_iommu_table_base(&dev->dev, &pe->tce32_table);
+			set_iommu_table_base(&dev->dev,
+					&pe->table_group.tables[0]);
 
 		if (dev->subordinate)
 			pnv_ioda_setup_bus_dma(pe, dev->subordinate,
@@ -1145,8 +1147,8 @@ static void pnv_pci_ioda2_tce_invalidate(struct pnv_ioda_pe *pe,
 void pnv_pci_ioda_tce_invalidate(struct iommu_table *tbl,
 				 __be64 *startp, __be64 *endp, bool rm)
 {
-	struct pnv_ioda_pe *pe = container_of(tbl, struct pnv_ioda_pe,
-					      tce32_table);
+	struct pnv_ioda_pe *pe = container_of(tbl->it_group, struct pnv_ioda_pe,
+					      table_group);
 	struct pnv_phb *phb = pe->phb;
 
 	if (phb->type == PNV_PHB_IODA1)
@@ -1211,8 +1213,11 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 		}
 	}
 
+	/* Setup iommu */
+	pe->table_group.tables[0].it_group = &pe->table_group;
+
 	/* Setup linux iommu table */
-	tbl = &pe->tce32_table;
+	tbl = &pe->table_group.tables[0];
 	pnv_pci_setup_iommu_table(tbl, addr, TCE32_TABLE_SIZE * segs,
 				  base << 28, IOMMU_PAGE_SHIFT_4K);
 
@@ -1233,7 +1238,8 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 	}
 	tbl->it_ops = &pnv_iommu_ops;
 	iommu_init_table(tbl, phb->hose->node);
-	iommu_register_group(tbl, phb->hose->global_number, pe->pe_number);
+	iommu_register_group(&pe->table_group, phb->hose->global_number,
+			pe->pe_number);
 
 	if (pe->pdev)
 		set_iommu_table_base_and_group(&pe->pdev->dev, tbl);
@@ -1251,8 +1257,8 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 
 static void pnv_pci_ioda2_set_bypass(struct iommu_table *tbl, bool enable)
 {
-	struct pnv_ioda_pe *pe = container_of(tbl, struct pnv_ioda_pe,
-					      tce32_table);
+	struct pnv_ioda_pe *pe = container_of(tbl->it_group, struct pnv_ioda_pe,
+					      table_group);
 	uint16_t window_id = (pe->pe_number << 1 ) + 1;
 	int64_t rc;
 
@@ -1297,10 +1303,10 @@ static void pnv_pci_ioda2_setup_bypass_pe(struct pnv_phb *phb,
 	pe->tce_bypass_base = 1ull << 59;
 
 	/* Install set_bypass callback for VFIO */
-	pe->tce32_table.set_bypass = pnv_pci_ioda2_set_bypass;
+	pe->table_group.tables[0].set_bypass = pnv_pci_ioda2_set_bypass;
 
 	/* Enable bypass by default */
-	pnv_pci_ioda2_set_bypass(&pe->tce32_table, true);
+	pnv_pci_ioda2_set_bypass(&pe->table_group.tables[0], true);
 }
 
 static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
@@ -1347,8 +1353,11 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 		goto fail;
 	}
 
+	/* Setup iommu */
+	pe->table_group.tables[0].it_group = &pe->table_group;
+
 	/* Setup linux iommu table */
-	tbl = &pe->tce32_table;
+	tbl = &pe->table_group.tables[0];
 	pnv_pci_setup_iommu_table(tbl, addr, tce_table_size, 0,
 			IOMMU_PAGE_SHIFT_4K);
 
@@ -1367,7 +1376,8 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 	}
 	tbl->it_ops = &pnv_iommu_ops;
 	iommu_init_table(tbl, phb->hose->node);
-	iommu_register_group(tbl, phb->hose->global_number, pe->pe_number);
+	iommu_register_group(&pe->table_group, phb->hose->global_number,
+			pe->pe_number);
 
 	if (pe->pdev)
 		set_iommu_table_base_and_group(&pe->pdev->dev, tbl);
diff --git a/arch/powerpc/platforms/powernv/pci-p5ioc2.c b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
index 0256fcc..ff68cac 100644
--- a/arch/powerpc/platforms/powernv/pci-p5ioc2.c
+++ b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
@@ -86,14 +86,16 @@ static void pnv_pci_init_p5ioc2_msis(struct pnv_phb *phb) { }
 static void pnv_pci_p5ioc2_dma_dev_setup(struct pnv_phb *phb,
 					 struct pci_dev *pdev)
 {
-	if (phb->p5ioc2.iommu_table.it_map == NULL) {
-		phb->p5ioc2.iommu_table.it_ops = &pnv_iommu_ops;
-		iommu_init_table(&phb->p5ioc2.iommu_table, phb->hose->node);
-		iommu_register_group(&phb->p5ioc2.iommu_table,
+	if (phb->p5ioc2.table_group.tables[0].it_map == NULL) {
+		phb->p5ioc2.table_group.tables[0].it_ops = &pnv_iommu_ops;
+		iommu_init_table(&phb->p5ioc2.table_group.tables[0],
+				phb->hose->node);
+		iommu_register_group(&phb->p5ioc2.table_group,
 				pci_domain_nr(phb->hose->bus), phb->opal_id);
 	}
 
-	set_iommu_table_base_and_group(&pdev->dev, &phb->p5ioc2.iommu_table);
+	set_iommu_table_base_and_group(&pdev->dev,
+			&phb->p5ioc2.table_group.tables[0]);
 }
 
 static void __init pnv_pci_init_p5ioc2_phb(struct device_node *np, u64 hub_id,
@@ -167,9 +169,12 @@ static void __init pnv_pci_init_p5ioc2_phb(struct device_node *np, u64 hub_id,
 	/* Setup MSI support */
 	pnv_pci_init_p5ioc2_msis(phb);
 
+	/* Setup iommu */
+	phb->p5ioc2.table_group.tables[0].it_group = &phb->p5ioc2.table_group;
+
 	/* Setup TCEs */
 	phb->dma_dev_setup = pnv_pci_p5ioc2_dma_dev_setup;
-	pnv_pci_setup_iommu_table(&phb->p5ioc2.iommu_table,
+	pnv_pci_setup_iommu_table(&phb->p5ioc2.table_group.tables[0],
 				  tce_mem, tce_size, 0,
 				  IOMMU_PAGE_SHIFT_4K);
 }
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 1c31ac8..3050cc8 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -687,7 +687,7 @@ static struct iommu_table *pnv_pci_setup_bml_iommu(struct pci_controller *hose)
 				  be32_to_cpup(sizep), 0, IOMMU_PAGE_SHIFT_4K);
 	tbl->it_ops = &pnv_iommu_ops;
 	iommu_init_table(tbl, hose->node);
-	iommu_register_group(tbl, pci_domain_nr(hose->bus), 0);
+	iommu_register_group(tbl->it_group, pci_domain_nr(hose->bus), 0);
 
 	/* Deal with SW invalidated TCEs when needed (BML way) */
 	swinvp = of_get_property(hose->dn, "linux,tce-sw-invalidate-info",
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index f726700..762d906 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -53,7 +53,7 @@ struct pnv_ioda_pe {
 	/* "Base" iommu table, ie, 4K TCEs, 32-bit DMA */
 	int			tce32_seg;
 	int			tce32_segcount;
-	struct iommu_table	tce32_table;
+	struct iommu_table_group table_group;
 	phys_addr_t		tce_inval_reg_phys;
 
 	/* 64-bit TCE bypass region */
@@ -138,7 +138,7 @@ struct pnv_phb {
 
 	union {
 		struct {
-			struct iommu_table iommu_table;
+			struct iommu_table_group table_group;
 		} p5ioc2;
 
 		struct {
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 41a8b14..75ea581 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -622,7 +622,7 @@ static void pci_dma_bus_setup_pSeries(struct pci_bus *bus)
 	iommu_table_setparms(pci->phb, dn, tbl);
 	tbl->it_ops = &iommu_table_pseries_ops;
 	pci->iommu_table = iommu_init_table(tbl, pci->phb->node);
-	iommu_register_group(tbl, pci_domain_nr(bus), 0);
+	iommu_register_group(tbl->it_group, pci_domain_nr(bus), 0);
 
 	/* Divide the rest (1.75GB) among the children */
 	pci->phb->dma_window_size = 0x80000000ul;
@@ -672,7 +672,7 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
 		iommu_table_setparms_lpar(ppci->phb, pdn, tbl, dma_window);
 		tbl->it_ops = &iommu_table_lpar_multi_ops;
 		ppci->iommu_table = iommu_init_table(tbl, ppci->phb->node);
-		iommu_register_group(tbl, pci_domain_nr(bus), 0);
+		iommu_register_group(tbl->it_group, pci_domain_nr(bus), 0);
 		pr_debug("  created table: %p\n", ppci->iommu_table);
 	}
 }
@@ -699,7 +699,7 @@ static void pci_dma_dev_setup_pSeries(struct pci_dev *dev)
 		iommu_table_setparms(phb, dn, tbl);
 		tbl->it_ops = &iommu_table_pseries_ops;
 		PCI_DN(dn)->iommu_table = iommu_init_table(tbl, phb->node);
-		iommu_register_group(tbl, pci_domain_nr(phb->bus), 0);
+		iommu_register_group(tbl->it_group, pci_domain_nr(phb->bus), 0);
 		set_iommu_table_base_and_group(&dev->dev,
 					       PCI_DN(dn)->iommu_table);
 		return;
@@ -1121,7 +1121,8 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 		iommu_table_setparms_lpar(pci->phb, pdn, tbl, dma_window);
 		tbl->it_ops = &iommu_table_lpar_multi_ops;
 		pci->iommu_table = iommu_init_table(tbl, pci->phb->node);
-		iommu_register_group(tbl, pci_domain_nr(pci->phb->bus), 0);
+		iommu_register_group(tbl->it_group,
+				pci_domain_nr(pci->phb->bus), 0);
 		pr_debug("  created table: %p\n", pci->iommu_table);
 	} else {
 		pr_debug("  found DMA window, table: %p\n", pci->iommu_table);
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 353d2d5..bfbe8bb 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -91,7 +91,7 @@ static void decrement_locked_vm(long npages)
  */
 struct tce_container {
 	struct mutex lock;
-	struct iommu_table *tbl;
+	struct iommu_group *grp;
 	bool enabled;
 	unsigned long locked_pages;
 	struct list_head mem_list;
@@ -294,13 +294,41 @@ static bool tce_page_is_contained(struct page *page, unsigned page_shift)
 	return (PAGE_SHIFT + compound_order(compound_head(page))) >= page_shift;
 }
 
+static struct iommu_table *spapr_tce_find_table(
+		struct tce_container *container,
+		phys_addr_t ioba)
+{
+	long i;
+	struct iommu_table *ret = NULL;
+	struct iommu_table_group *table_group;
+
+	table_group = iommu_group_get_iommudata(container->grp);
+	if (!table_group)
+		return NULL;
+
+	for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
+		struct iommu_table *tbl = &table_group->tables[i];
+		unsigned long entry = ioba >> tbl->it_page_shift;
+		unsigned long start = tbl->it_offset;
+		unsigned long end = start + tbl->it_size;
+
+		if ((start <= entry) && (entry < end)) {
+			ret = tbl;
+			break;
+		}
+	}
+
+	return ret;
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
@@ -335,6 +363,11 @@ static int tce_iommu_enable(struct tce_container *container)
 	 * KVM agnostic.
 	 */
 	if (!tce_preregistered(container)) {
+		table_group = iommu_group_get_iommudata(container->grp);
+		if (!table_group)
+			return -ENODEV;
+
+		tbl = &table_group->tables[0];
 		locked = (tbl->it_size << tbl->it_page_shift) >> PAGE_SHIFT;
 		ret = try_increment_locked_vm(locked);
 		if (ret)
@@ -387,15 +420,17 @@ static int tce_iommu_clear(struct tce_container *container,
 static void tce_iommu_release(void *iommu_data)
 {
 	struct tce_container *container = iommu_data;
-	struct iommu_table *tbl = container->tbl;
+	struct iommu_table *tbl;
+	struct iommu_table_group *table_group;
 
-	WARN_ON(tbl && !tbl->it_group);
+	WARN_ON(container->grp);
 
-	if (tbl) {
+	if (container->grp) {
+		table_group = iommu_group_get_iommudata(container->grp);
+		tbl = &table_group->tables[0];
 		tce_iommu_clear(container, tbl,	tbl->it_offset, tbl->it_size);
 
-		if (tbl->it_group)
-			tce_iommu_detach_group(iommu_data, tbl->it_group);
+		tce_iommu_detach_group(iommu_data, container->grp);
 	}
 
 	tce_mem_unregister_all(container);
@@ -551,9 +586,16 @@ static long tce_iommu_ioctl(void *iommu_data,
 
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
+		tbl = &table_group->tables[0];
+		if (WARN_ON_ONCE(!tbl))
 			return -ENXIO;
 
 		minsz = offsetofend(struct vfio_iommu_spapr_tce_info,
@@ -576,17 +618,12 @@ static long tce_iommu_ioctl(void *iommu_data,
 	}
 	case VFIO_IOMMU_MAP_DMA: {
 		struct vfio_iommu_type1_dma_map param;
-		struct iommu_table *tbl = container->tbl;
+		struct iommu_table *tbl;
 		unsigned long tce;
 
 		if (!container->enabled)
 			return -EPERM;
 
-		if (!tbl)
-			return -ENXIO;
-
-		BUG_ON(!tbl->it_group);
-
 		minsz = offsetofend(struct vfio_iommu_type1_dma_map, size);
 
 		if (copy_from_user(&param, (void __user *)arg, minsz))
@@ -599,6 +636,10 @@ static long tce_iommu_ioctl(void *iommu_data,
 				VFIO_DMA_MAP_FLAG_WRITE))
 			return -EINVAL;
 
+		tbl = spapr_tce_find_table(container, param.iova);
+		if (!tbl)
+			return -ENXIO;
+
 		if ((param.size & ~IOMMU_PAGE_MASK(tbl)) ||
 				(param.vaddr & ~IOMMU_PAGE_MASK(tbl)))
 			return -EINVAL;
@@ -624,14 +665,11 @@ static long tce_iommu_ioctl(void *iommu_data,
 	}
 	case VFIO_IOMMU_UNMAP_DMA: {
 		struct vfio_iommu_type1_dma_unmap param;
-		struct iommu_table *tbl = container->tbl;
+		struct iommu_table *tbl;
 
 		if (!container->enabled)
 			return -EPERM;
 
-		if (WARN_ON(!tbl))
-			return -ENXIO;
-
 		minsz = offsetofend(struct vfio_iommu_type1_dma_unmap,
 				size);
 
@@ -645,6 +683,10 @@ static long tce_iommu_ioctl(void *iommu_data,
 		if (param.flags)
 			return -EINVAL;
 
+		tbl = spapr_tce_find_table(container, param.iova);
+		if (!tbl)
+			return -ENXIO;
+
 		if (param.size & ~IOMMU_PAGE_MASK(tbl))
 			return -EINVAL;
 
@@ -717,10 +759,10 @@ static long tce_iommu_ioctl(void *iommu_data,
 		mutex_unlock(&container->lock);
 		return 0;
 	case VFIO_EEH_PE_OP:
-		if (!container->tbl || !container->tbl->it_group)
+		if (!container->grp)
 			return -ENODEV;
 
-		return vfio_spapr_iommu_eeh_ioctl(container->tbl->it_group,
+		return vfio_spapr_iommu_eeh_ioctl(container->grp,
 						  cmd, arg);
 	}
 
@@ -732,16 +774,15 @@ static int tce_iommu_attach_group(void *iommu_data,
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
-				iommu_group_id(container->tbl->it_group),
+				iommu_group_id(container->grp),
 				iommu_group_id(iommu_group));
 		ret = -EBUSY;
 		goto unlock_exit;
@@ -754,9 +795,15 @@ static int tce_iommu_attach_group(void *iommu_data,
 		goto unlock_exit;
 	}
 
-	ret = iommu_take_ownership(tbl);
+	table_group = iommu_group_get_iommudata(iommu_group);
+	if (!table_group) {
+		ret = -ENXIO;
+		goto unlock_exit;
+	}
+
+	ret = iommu_take_ownership(&table_group->tables[0]);
 	if (!ret)
-		container->tbl = tbl;
+		container->grp = iommu_group;
 
 unlock_exit:
 	mutex_unlock(&container->lock);
@@ -768,27 +815,30 @@ static void tce_iommu_detach_group(void *iommu_data,
 		struct iommu_group *iommu_group)
 {
 	struct tce_container *container = iommu_data;
-	struct iommu_table *tbl = iommu_group_get_iommudata(iommu_group);
+	struct iommu_table_group *table_group;
 
-	BUG_ON(!tbl);
 	mutex_lock(&container->lock);
-	if (tbl != container->tbl) {
+	if (iommu_group != container->grp) {
 		pr_warn("tce_vfio: detaching group #%u, expected group is #%u\n",
 				iommu_group_id(iommu_group),
-				iommu_group_id(tbl->it_group));
+				iommu_group_id(container->grp));
 		goto unlock_exit;
 	}
 
 	if (container->enabled) {
 		pr_warn("tce_vfio: detaching group #%u from enabled container, forcing disable\n",
-				iommu_group_id(tbl->it_group));
+				iommu_group_id(container->grp));
 		tce_iommu_disable(container);
 	}
 
 	/* pr_debug("tce_vfio: detaching group #%u from iommu %p\n",
 	   iommu_group_id(iommu_group), iommu_group); */
-	container->tbl = NULL;
-	iommu_release_ownership(tbl);
+	container->grp = NULL;
+
+	table_group = iommu_group_get_iommudata(iommu_group);
+	BUG_ON(!table_group);
+
+	iommu_release_ownership(&table_group->tables[0]);
 
 unlock_exit:
 	mutex_unlock(&container->lock);
-- 
2.0.0
