Return-Path: <aik@ozlabs.ru>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C5F161A0490
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:16:26 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Sat, 25 Apr 2015 22:16:26 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 702AC3578048
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:16:22 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3PCGEWQ36241452
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:16:22 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3PCFmZ5030061
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:15:49 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v9 12/32] powerpc/spapr: vfio: Switch from iommu_table
 to new iommu_table_group
Date: Sat, 25 Apr 2015 22:14:36 +1000
Message-Id: <1429964096-11524-13-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
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

For P5IOC2 and IODA, iommu_table_group is embedded into PE struct
(pnv_ioda_pe and pnv_phb) and does not require iommu_free_table(), only .
iommu_reset_table().

For pSeries, this replaces multiple calls of kzalloc_node() with a new
iommu_pseries_group_alloc() helper and stores the table group struct
pointer into the pci_dn struct. For release, a iommu_table_group_free()
helper is added.

This should cause no behavioural change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
[aw: for the vfio related changes]
Acked-by: Alex Williamson <alex.williamson@redhat.com>
---
Changes:
v9:
* s/it_group/it_table_group/
* added and used iommu_table_group_free(), from now iommu_free_table()
is only used for VIO
* added iommu_pseries_group_alloc()
* squashed "powerpc/iommu: Introduce iommu_table_alloc() helper" into this
---
 arch/powerpc/include/asm/iommu.h            |  18 +++--
 arch/powerpc/include/asm/pci-bridge.h       |   2 +-
 arch/powerpc/kernel/eeh.c                   |   2 +-
 arch/powerpc/kernel/iommu.c                 |  24 +++---
 arch/powerpc/platforms/powernv/pci-ioda.c   |  46 ++++++-----
 arch/powerpc/platforms/powernv/pci-p5ioc2.c |  19 +++--
 arch/powerpc/platforms/powernv/pci.h        |   4 +-
 arch/powerpc/platforms/pseries/iommu.c      | 104 +++++++++++++++++--------
 drivers/vfio/vfio_iommu_spapr_tce.c         | 114 ++++++++++++++++++++--------
 9 files changed, 222 insertions(+), 111 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index f0cab49..fa37519 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -91,9 +91,7 @@ struct iommu_table {
 	struct iommu_pool pools[IOMMU_NR_POOLS];
 	unsigned long *it_map;       /* A simple allocation bitmap for now */
 	unsigned long  it_page_shift;/* table iommu page size */
-#ifdef CONFIG_IOMMU_API
-	struct iommu_group *it_group;
-#endif
+	struct iommu_table_group *it_table_group;
 	struct iommu_table_ops *it_ops;
 	void (*set_bypass)(struct iommu_table *tbl, bool enable);
 };
@@ -127,14 +125,24 @@ extern void iommu_free_table(struct iommu_table *tbl, const char *node_name);
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
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index a4c62eb..6bab695 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1407,7 +1407,7 @@ static int dev_has_iommu_table(struct device *dev, void *data)
 		return 0;
 
 	tbl = get_iommu_table_base(dev);
-	if (tbl && tbl->it_group) {
+	if (tbl && tbl->it_table_group) {
 		*ppdev = pdev;
 		return 1;
 	}
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index e289f91..005146b 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -749,12 +749,8 @@ void iommu_free_table(struct iommu_table *tbl, const char *node_name)
 
 	iommu_reset_table(tbl, node_name);
 
-#ifdef CONFIG_IOMMU_API
-	if (tbl->it_group) {
-		iommu_group_put(tbl->it_group);
-		BUG_ON(tbl->it_group);
-	}
-#endif
+	/* iommu_free_table() is only used by VIO so no groups expected here */
+	BUG_ON(tbl->it_table_group);
 
 	/* free table */
 	kfree(tbl);
@@ -904,11 +900,11 @@ EXPORT_SYMBOL_GPL(iommu_direction_to_tce_perm);
  */
 static void group_release(void *iommu_data)
 {
-	struct iommu_table *tbl = iommu_data;
-	tbl->it_group = NULL;
+	struct iommu_table_group *table_group = iommu_data;
+	table_group->group = NULL;
 }
 
-void iommu_register_group(struct iommu_table *tbl,
+void iommu_register_group(struct iommu_table_group *table_group,
 		int pci_domain_number, unsigned long pe_num)
 {
 	struct iommu_group *grp;
@@ -920,8 +916,8 @@ void iommu_register_group(struct iommu_table *tbl,
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
@@ -1109,7 +1105,7 @@ int iommu_add_device(struct device *dev)
 	}
 
 	tbl = get_iommu_table_base(dev);
-	if (!tbl || !tbl->it_group) {
+	if (!tbl || !tbl->it_table_group || !tbl->it_table_group->group) {
 		pr_debug("%s: Skipping device %s with no tbl\n",
 			 __func__, dev_name(dev));
 		return 0;
@@ -1117,7 +1113,7 @@ int iommu_add_device(struct device *dev)
 
 	pr_debug("%s: Adding %s to iommu group %d\n",
 		 __func__, dev_name(dev),
-		 iommu_group_id(tbl->it_group));
+		 iommu_group_id(tbl->it_table_group->group));
 
 	if (PAGE_SIZE < IOMMU_PAGE_SIZE(tbl)) {
 		pr_err("%s: Invalid IOMMU page size %lx (%lx) on %s\n",
@@ -1126,7 +1122,7 @@ int iommu_add_device(struct device *dev)
 		return -EINVAL;
 	}
 
-	return iommu_group_add_device(tbl->it_group, dev);
+	return iommu_group_add_device(tbl->it_table_group->group, dev);
 }
 EXPORT_SYMBOL_GPL(iommu_add_device);
 
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 7a9137a..88472cb 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -23,6 +23,7 @@
 #include <linux/io.h>
 #include <linux/msi.h>
 #include <linux/memblock.h>
+#include <linux/iommu.h>
 
 #include <asm/sections.h>
 #include <asm/io.h>
@@ -1291,7 +1292,7 @@ static void pnv_pci_ioda2_release_dma_pe(struct pci_dev *dev, struct pnv_ioda_pe
 	bus = dev->bus;
 	hose = pci_bus_to_host(bus);
 	phb = hose->private_data;
-	tbl = &pe->tce32_table;
+	tbl = &pe->table_group.tables[0];
 	addr = tbl->it_base;
 
 	opal_pci_map_pe_dma_window(phb->opal_id, pe->pe_number,
@@ -1589,7 +1590,7 @@ static void pnv_pci_ioda_dma_dev_setup(struct pnv_phb *phb, struct pci_dev *pdev
 
 	pe = &phb->ioda.pe_array[pdn->pe_number];
 	WARN_ON(get_dma_ops(&pdev->dev) != &dma_iommu_ops);
-	set_iommu_table_base_and_group(&pdev->dev, &pe->tce32_table);
+	set_iommu_table_base_and_group(&pdev->dev, &pe->table_group.tables[0]);
 }
 
 static int pnv_pci_ioda_dma_set_mask(struct pnv_phb *phb,
@@ -1616,7 +1617,7 @@ static int pnv_pci_ioda_dma_set_mask(struct pnv_phb *phb,
 	} else {
 		dev_info(&pdev->dev, "Using 32-bit DMA via iommu\n");
 		set_dma_ops(&pdev->dev, &dma_iommu_ops);
-		set_iommu_table_base(&pdev->dev, &pe->tce32_table);
+		set_iommu_table_base(&pdev->dev, &pe->table_group.tables[0]);
 	}
 	*pdev->dev.dma_mask = dma_mask;
 	return 0;
@@ -1653,9 +1654,10 @@ static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe,
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
@@ -1751,8 +1753,8 @@ static void pnv_pci_ioda2_tce_invalidate(struct pnv_ioda_pe *pe,
 void pnv_pci_ioda_tce_invalidate(struct iommu_table *tbl,
 				 __be64 *startp, __be64 *endp, bool rm)
 {
-	struct pnv_ioda_pe *pe = container_of(tbl, struct pnv_ioda_pe,
-					      tce32_table);
+	struct pnv_ioda_pe *pe = container_of(tbl->it_table_group,
+			struct pnv_ioda_pe, table_group);
 	struct pnv_phb *phb = pe->phb;
 
 	if (phb->type == PNV_PHB_IODA1)
@@ -1820,8 +1822,11 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 		}
 	}
 
+	/* Setup iommu */
+	pe->table_group.tables[0].it_table_group = &pe->table_group;
+
 	/* Setup linux iommu table */
-	tbl = &pe->tce32_table;
+	tbl = &pe->table_group.tables[0];
 	pnv_pci_setup_iommu_table(tbl, addr, TCE32_TABLE_SIZE * segs,
 				  base << 28, IOMMU_PAGE_SHIFT_4K);
 
@@ -1844,15 +1849,15 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 	iommu_init_table(tbl, phb->hose->node);
 
 	if (pe->flags & PNV_IODA_PE_DEV) {
-		iommu_register_group(tbl, phb->hose->global_number,
+		iommu_register_group(&pe->table_group, phb->hose->global_number,
 				     pe->pe_number);
 		set_iommu_table_base_and_group(&pe->pdev->dev, tbl);
 	} else if (pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL)) {
-		iommu_register_group(tbl, phb->hose->global_number,
+		iommu_register_group(&pe->table_group, phb->hose->global_number,
 				     pe->pe_number);
 		pnv_ioda_setup_bus_dma(pe, pe->pbus, true);
 	} else if (pe->flags & PNV_IODA_PE_VF) {
-		iommu_register_group(tbl, phb->hose->global_number,
+		iommu_register_group(&pe->table_group, phb->hose->global_number,
 				     pe->pe_number);
 	}
 
@@ -1867,8 +1872,8 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 
 static void pnv_pci_ioda2_set_bypass(struct iommu_table *tbl, bool enable)
 {
-	struct pnv_ioda_pe *pe = container_of(tbl, struct pnv_ioda_pe,
-					      tce32_table);
+	struct pnv_ioda_pe *pe = container_of(tbl->it_table_group,
+			struct pnv_ioda_pe, table_group);
 	uint16_t window_id = (pe->pe_number << 1 ) + 1;
 	int64_t rc;
 
@@ -1913,10 +1918,10 @@ static void pnv_pci_ioda2_setup_bypass_pe(struct pnv_phb *phb,
 	pe->tce_bypass_base = 1ull << 59;
 
 	/* Install set_bypass callback for VFIO */
-	pe->tce32_table.set_bypass = pnv_pci_ioda2_set_bypass;
+	pe->table_group.tables[0].set_bypass = pnv_pci_ioda2_set_bypass;
 
 	/* Enable bypass by default */
-	pnv_pci_ioda2_set_bypass(&pe->tce32_table, true);
+	pnv_pci_ioda2_set_bypass(&pe->table_group.tables[0], true);
 }
 
 static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
@@ -1963,8 +1968,11 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 		goto fail;
 	}
 
+	/* Setup iommu */
+	pe->table_group.tables[0].it_table_group = &pe->table_group;
+
 	/* Setup linux iommu table */
-	tbl = &pe->tce32_table;
+	tbl = &pe->table_group.tables[0];
 	pnv_pci_setup_iommu_table(tbl, addr, tce_table_size, 0,
 			IOMMU_PAGE_SHIFT_4K);
 
@@ -1985,15 +1993,15 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 	iommu_init_table(tbl, phb->hose->node);
 
 	if (pe->flags & PNV_IODA_PE_DEV) {
-		iommu_register_group(tbl, phb->hose->global_number,
+		iommu_register_group(&pe->table_group, phb->hose->global_number,
 				     pe->pe_number);
 		set_iommu_table_base_and_group(&pe->pdev->dev, tbl);
 	} else if (pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL)) {
-		iommu_register_group(tbl, phb->hose->global_number,
+		iommu_register_group(&pe->table_group, phb->hose->global_number,
 				     pe->pe_number);
 		pnv_ioda_setup_bus_dma(pe, pe->pbus, true);
 	} else if (pe->flags & PNV_IODA_PE_VF) {
-		iommu_register_group(tbl, phb->hose->global_number,
+		iommu_register_group(&pe->table_group, phb->hose->global_number,
 				     pe->pe_number);
 	}
 
diff --git a/arch/powerpc/platforms/powernv/pci-p5ioc2.c b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
index f05057e..a073af0 100644
--- a/arch/powerpc/platforms/powernv/pci-p5ioc2.c
+++ b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
@@ -92,14 +92,17 @@ static struct iommu_table_ops pnv_p5ioc2_iommu_ops = {
 static void pnv_pci_p5ioc2_dma_dev_setup(struct pnv_phb *phb,
 					 struct pci_dev *pdev)
 {
-	if (phb->p5ioc2.iommu_table.it_map == NULL) {
-		phb->p5ioc2.iommu_table.it_ops = &pnv_p5ioc2_iommu_ops;
-		iommu_init_table(&phb->p5ioc2.iommu_table, phb->hose->node);
-		iommu_register_group(&phb->p5ioc2.iommu_table,
+	if (phb->p5ioc2.table_group.tables[0].it_map == NULL) {
+		phb->p5ioc2.table_group.tables[0].it_ops =
+				&pnv_p5ioc2_iommu_ops;
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
@@ -174,9 +177,13 @@ static void __init pnv_pci_init_p5ioc2_phb(struct device_node *np, u64 hub_id,
 	/* Setup MSI support */
 	pnv_pci_init_p5ioc2_msis(phb);
 
+	/* Setup iommu */
+	phb->p5ioc2.table_group.tables[0].it_table_group =
+			&phb->p5ioc2.table_group;
+
 	/* Setup TCEs */
 	phb->dma_dev_setup = pnv_pci_p5ioc2_dma_dev_setup;
-	pnv_pci_setup_iommu_table(&phb->p5ioc2.iommu_table,
+	pnv_pci_setup_iommu_table(&phb->p5ioc2.table_group.tables[0],
 				  tce_mem, tce_size, 0,
 				  IOMMU_PAGE_SHIFT_4K);
 }
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 7eb6076..368d4ed 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -57,7 +57,7 @@ struct pnv_ioda_pe {
 	/* "Base" iommu table, ie, 4K TCEs, 32-bit DMA */
 	int			tce32_seg;
 	int			tce32_segcount;
-	struct iommu_table	tce32_table;
+	struct iommu_table_group table_group;
 	phys_addr_t		tce_inval_reg_phys;
 
 	/* 64-bit TCE bypass region */
@@ -122,7 +122,7 @@ struct pnv_phb {
 
 	union {
 		struct {
-			struct iommu_table iommu_table;
+			struct iommu_table_group table_group;
 		} p5ioc2;
 
 		struct {
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index e379acf..8c29919 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -36,6 +36,7 @@
 #include <linux/crash_dump.h>
 #include <linux/memory.h>
 #include <linux/of.h>
+#include <linux/iommu.h>
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/rtas.h>
@@ -51,6 +52,42 @@
 
 #include "pseries.h"
 
+static struct iommu_table_group *iommu_pseries_group_alloc(int node)
+{
+	struct iommu_table_group *table_group;
+
+	table_group = kzalloc_node(sizeof(struct iommu_table_group), GFP_KERNEL,
+			   node);
+	if (!table_group) {
+		pr_debug("%s failed\n", __func__);
+		return NULL;
+	}
+	table_group->tables[0].it_table_group = table_group;
+
+	return table_group;
+}
+
+static void iommu_table_group_free(struct iommu_table_group *table_group)
+{
+	long i;
+
+	if (!table_group)
+		return;
+
+	for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i)
+		iommu_reset_table(&table_group->tables[i], "noname");
+
+#ifdef CONFIG_IOMMU_API
+	if (table_group->group) {
+		iommu_group_put(table_group->group);
+		BUG_ON(table_group->group);
+	}
+#endif
+
+	/* free table group */
+	kfree(table_group);
+}
+
 static void tce_invalidate_pSeries_sw(struct iommu_table *tbl,
 				      __be64 *startp, __be64 *endp)
 {
@@ -618,13 +655,13 @@ static void pci_dma_bus_setup_pSeries(struct pci_bus *bus)
 	pci->phb->dma_window_size = 0x8000000ul;
 	pci->phb->dma_window_base_cur = 0x8000000ul;
 
-	tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
-			   pci->phb->node);
+	pci->table_group = iommu_pseries_group_alloc(pci->phb->node);
+	tbl = &pci->table_group->tables[0];
 
 	iommu_table_setparms(pci->phb, dn, tbl);
 	tbl->it_ops = &iommu_table_pseries_ops;
-	pci->iommu_table = iommu_init_table(tbl, pci->phb->node);
-	iommu_register_group(tbl, pci_domain_nr(bus), 0);
+	iommu_init_table(tbl, pci->phb->node);
+	iommu_register_group(pci->table_group, pci_domain_nr(bus), 0);
 
 	/* Divide the rest (1.75GB) among the children */
 	pci->phb->dma_window_size = 0x80000000ul;
@@ -667,16 +704,17 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
 	ppci = PCI_DN(pdn);
 
 	pr_debug("  parent is %s, iommu_table: 0x%p\n",
-		 pdn->full_name, ppci->iommu_table);
+		 pdn->full_name, ppci->table_group);
 
-	if (!ppci->iommu_table) {
-		tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
-				   ppci->phb->node);
+	if (!ppci->table_group) {
+		ppci->table_group = iommu_pseries_group_alloc(ppci->phb->node);
+		tbl = &ppci->table_group->tables[0];
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
 
@@ -698,14 +736,16 @@ static void pci_dma_dev_setup_pSeries(struct pci_dev *dev)
 		struct pci_controller *phb = PCI_DN(dn)->phb;
 
 		pr_debug(" --> first child, no bridge. Allocating iommu table.\n");
-		tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
-				   phb->node);
+		PCI_DN(dn)->table_group = iommu_pseries_group_alloc(phb->node);
+		tbl = &PCI_DN(dn)->table_group->tables[0];
 		iommu_table_setparms(phb, dn, tbl);
 		tbl->it_ops = &iommu_table_pseries_ops;
-		PCI_DN(dn)->iommu_table = iommu_init_table(tbl, phb->node);
-		iommu_register_group(tbl, pci_domain_nr(phb->bus), 0);
+		iommu_init_table(tbl, phb->node);
+		iommu_register_group(PCI_DN(dn)->table_group,
+				pci_domain_nr(phb->bus), 0);
 		set_iommu_table_base_and_group(&dev->dev,
-					       PCI_DN(dn)->iommu_table);
+					       &PCI_DN(dn)->
+					       table_group->tables[0]);
 		return;
 	}
 
@@ -713,12 +753,13 @@ static void pci_dma_dev_setup_pSeries(struct pci_dev *dev)
 	 * an already allocated iommu table is found and use that.
 	 */
 
-	while (dn && PCI_DN(dn) && PCI_DN(dn)->iommu_table == NULL)
+	while (dn && PCI_DN(dn) && PCI_DN(dn)->table_group == NULL)
 		dn = dn->parent;
 
 	if (dn && PCI_DN(dn))
 		set_iommu_table_base_and_group(&dev->dev,
-					       PCI_DN(dn)->iommu_table);
+					       &PCI_DN(dn)->
+					       table_group->tables[0]);
 	else
 		printk(KERN_WARNING "iommu: Device %s has no iommu table\n",
 		       pci_name(dev));
@@ -1104,7 +1145,7 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 	dn = pci_device_to_OF_node(dev);
 	pr_debug("  node is %s\n", dn->full_name);
 
-	for (pdn = dn; pdn && PCI_DN(pdn) && !PCI_DN(pdn)->iommu_table;
+	for (pdn = dn; pdn && PCI_DN(pdn) && !PCI_DN(pdn)->table_group;
 	     pdn = pdn->parent) {
 		dma_window = of_get_property(pdn, "ibm,dma-window", NULL);
 		if (dma_window)
@@ -1120,19 +1161,20 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 	pr_debug("  parent is %s\n", pdn->full_name);
 
 	pci = PCI_DN(pdn);
-	if (!pci->iommu_table) {
-		tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
-				   pci->phb->node);
+	if (!pci->table_group) {
+		pci->table_group = iommu_pseries_group_alloc(pci->phb->node);
+		tbl = &pci->table_group->tables[0];
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
 
-	set_iommu_table_base_and_group(&dev->dev, pci->iommu_table);
+	set_iommu_table_base_and_group(&dev->dev, &pci->table_group->tables[0]);
 }
 
 static int dma_set_mask_pSeriesLP(struct device *dev, u64 dma_mask)
@@ -1162,7 +1204,7 @@ static int dma_set_mask_pSeriesLP(struct device *dev, u64 dma_mask)
 		 * search upwards in the tree until we either hit a dma-window
 		 * property, OR find a parent with a table already allocated.
 		 */
-		for (pdn = dn; pdn && PCI_DN(pdn) && !PCI_DN(pdn)->iommu_table;
+		for (pdn = dn; pdn && PCI_DN(pdn) && !PCI_DN(pdn)->table_group;
 				pdn = pdn->parent) {
 			dma_window = of_get_property(pdn, "ibm,dma-window", NULL);
 			if (dma_window)
@@ -1206,7 +1248,7 @@ static u64 dma_get_required_mask_pSeriesLP(struct device *dev)
 		dn = pci_device_to_OF_node(pdev);
 
 		/* search upwards for ibm,dma-window */
-		for (; dn && PCI_DN(dn) && !PCI_DN(dn)->iommu_table;
+		for (; dn && PCI_DN(dn) && !PCI_DN(dn)->table_group;
 				dn = dn->parent)
 			if (of_get_property(dn, "ibm,dma-window", NULL))
 				break;
@@ -1286,8 +1328,8 @@ static int iommu_reconfig_notifier(struct notifier_block *nb, unsigned long acti
 		 * the device node.
 		 */
 		remove_ddw(np, false);
-		if (pci && pci->iommu_table)
-			iommu_free_table(pci->iommu_table, np->full_name);
+		if (pci && pci->table_group)
+			iommu_table_group_free(pci->table_group);
 
 		spin_lock(&direct_window_list_lock);
 		list_for_each_entry(window, &direct_window_list, list) {
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 0fbe03e..17e884a 100644
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
@@ -103,13 +103,41 @@ static bool tce_page_is_contained(struct page *page, unsigned page_shift)
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
@@ -143,6 +171,11 @@ static int tce_iommu_enable(struct tce_container *container)
 	 * as this information is only available from KVM and VFIO is
 	 * KVM agnostic.
 	 */
+	table_group = iommu_group_get_iommudata(container->grp);
+	if (!table_group)
+		return -ENODEV;
+
+	tbl = &table_group->tables[0];
 	locked = (tbl->it_size << tbl->it_page_shift) >> PAGE_SHIFT;
 	ret = try_increment_locked_vm(locked);
 	if (ret)
@@ -190,10 +223,10 @@ static void tce_iommu_release(void *iommu_data)
 {
 	struct tce_container *container = iommu_data;
 
-	WARN_ON(container->tbl && !container->tbl->it_group);
+	WARN_ON(container->grp);
 
-	if (container->tbl && container->tbl->it_group)
-		tce_iommu_detach_group(iommu_data, container->tbl->it_group);
+	if (container->grp)
+		tce_iommu_detach_group(iommu_data, container->grp);
 
 	tce_iommu_disable(container);
 	mutex_destroy(&container->lock);
@@ -311,9 +344,16 @@ static long tce_iommu_ioctl(void *iommu_data,
 
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
@@ -336,17 +376,12 @@ static long tce_iommu_ioctl(void *iommu_data,
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
@@ -359,6 +394,10 @@ static long tce_iommu_ioctl(void *iommu_data,
 				VFIO_DMA_MAP_FLAG_WRITE))
 			return -EINVAL;
 
+		tbl = spapr_tce_find_table(container, param.iova);
+		if (!tbl)
+			return -ENXIO;
+
 		if ((param.size & ~IOMMU_PAGE_MASK(tbl)) ||
 				(param.vaddr & ~IOMMU_PAGE_MASK(tbl)))
 			return -EINVAL;
@@ -384,14 +423,11 @@ static long tce_iommu_ioctl(void *iommu_data,
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
 
@@ -405,6 +441,10 @@ static long tce_iommu_ioctl(void *iommu_data,
 		if (param.flags)
 			return -EINVAL;
 
+		tbl = spapr_tce_find_table(container, param.iova);
+		if (!tbl)
+			return -ENXIO;
+
 		if (param.size & ~IOMMU_PAGE_MASK(tbl))
 			return -EINVAL;
 
@@ -433,10 +473,10 @@ static long tce_iommu_ioctl(void *iommu_data,
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
 
@@ -448,16 +488,15 @@ static int tce_iommu_attach_group(void *iommu_data,
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
@@ -470,9 +509,15 @@ static int tce_iommu_attach_group(void *iommu_data,
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
@@ -484,26 +529,31 @@ static void tce_iommu_detach_group(void *iommu_data,
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
+	container->grp = NULL;
+
+	table_group = iommu_group_get_iommudata(iommu_group);
+	BUG_ON(!table_group);
+
+	tbl = &table_group->tables[0];
 	tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
 	iommu_release_ownership(tbl);
 
-- 
2.0.0
