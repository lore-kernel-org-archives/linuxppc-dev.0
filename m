Return-Path: <aik@ozlabs.ru>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0FE052C0079
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Nov 2013 17:30:40 +1100 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Wed, 13 Nov 2013 16:30:37 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 5533D2CE8053
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Nov 2013 17:30:30 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rAD6CoZc38731882
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Nov 2013 17:12:51 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rAD6USm8003180
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Nov 2013 17:30:28 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v9] PPC: POWERNV: move iommu_add_device earlier
Date: Wed, 13 Nov 2013 17:30:20 +1100
Message-Id: <1384324220-30109-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Alex Graf <agraf@suse.de>,
 Bharat Bhushan <bharat.bhushan@freescale.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The current implementation of IOMMU on sPAPR does not use iommu_ops
and therefore does not call IOMMU API's bus_set_iommu() which
1) sets iommu_ops for a bus
2) registers a bus notifier
Instead, PCI devices are added to IOMMU groups from
subsys_initcall_sync(tce_iommu_init) which does basically the same
thing without using iommu_ops callbacks.

However Freescale PAMU driver (https://lkml.org/lkml/2013/7/1/158)
implements iommu_ops and when tce_iommu_init is called, every PCI device
is already added to some group so there is a conflict.

This patch does 2 things:
1. removes the loop in which PCI devices were added to groups and
adds explicit iommu_add_device() calls to add devices as soon as they get
the iommu_table pointer assigned to them.
2. moves a bus notifier to powernv code in order to avoid conflict with
the notifier from Freescale driver.

iommu_add_device() and iommu_del_device() are public now.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v9:
* removed "KVM" from the subject as it is not really a KVM patch so
PPC mainainter (hi Ben!) can review/include it into his tree

v8:
* added the check for iommu_group!=NULL before removing device from a group
as suggested by Wei Yang <weiyang@linux.vnet.ibm.com>

v2:
* added a helper - set_iommu_table_base_and_group - which does
set_iommu_table_base() and iommu_add_device()
---
 arch/powerpc/include/asm/iommu.h            |  9 +++++++
 arch/powerpc/kernel/iommu.c                 | 41 +++--------------------------
 arch/powerpc/platforms/powernv/pci-ioda.c   |  8 +++---
 arch/powerpc/platforms/powernv/pci-p5ioc2.c |  2 +-
 arch/powerpc/platforms/powernv/pci.c        | 33 ++++++++++++++++++++++-
 arch/powerpc/platforms/pseries/iommu.c      |  8 +++---
 6 files changed, 55 insertions(+), 46 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index c34656a..19ad77f 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -103,6 +103,15 @@ extern struct iommu_table *iommu_init_table(struct iommu_table * tbl,
 					    int nid);
 extern void iommu_register_group(struct iommu_table *tbl,
 				 int pci_domain_number, unsigned long pe_num);
+extern int iommu_add_device(struct device *dev);
+extern void iommu_del_device(struct device *dev);
+
+static inline void set_iommu_table_base_and_group(struct device *dev,
+						  void *base)
+{
+	set_iommu_table_base(dev, base);
+	iommu_add_device(dev);
+}
 
 extern int iommu_map_sg(struct device *dev, struct iommu_table *tbl,
 			struct scatterlist *sglist, int nelems,
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 572bb5b..ecbf468 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -1105,7 +1105,7 @@ void iommu_release_ownership(struct iommu_table *tbl)
 }
 EXPORT_SYMBOL_GPL(iommu_release_ownership);
 
-static int iommu_add_device(struct device *dev)
+int iommu_add_device(struct device *dev)
 {
 	struct iommu_table *tbl;
 	int ret = 0;
@@ -1134,46 +1134,13 @@ static int iommu_add_device(struct device *dev)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(iommu_add_device);
 
-static void iommu_del_device(struct device *dev)
+void iommu_del_device(struct device *dev)
 {
 	iommu_group_remove_device(dev);
 }
-
-static int iommu_bus_notifier(struct notifier_block *nb,
-			      unsigned long action, void *data)
-{
-	struct device *dev = data;
-
-	switch (action) {
-	case BUS_NOTIFY_ADD_DEVICE:
-		return iommu_add_device(dev);
-	case BUS_NOTIFY_DEL_DEVICE:
-		iommu_del_device(dev);
-		return 0;
-	default:
-		return 0;
-	}
-}
-
-static struct notifier_block tce_iommu_bus_nb = {
-	.notifier_call = iommu_bus_notifier,
-};
-
-static int __init tce_iommu_init(void)
-{
-	struct pci_dev *pdev = NULL;
-
-	BUILD_BUG_ON(PAGE_SIZE < IOMMU_PAGE_SIZE);
-
-	for_each_pci_dev(pdev)
-		iommu_add_device(&pdev->dev);
-
-	bus_register_notifier(&pci_bus_type, &tce_iommu_bus_nb);
-	return 0;
-}
-
-subsys_initcall_sync(tce_iommu_init);
+EXPORT_SYMBOL_GPL(iommu_del_device);
 
 #else
 
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 084cdfa..614356c 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -460,7 +460,7 @@ static void pnv_pci_ioda_dma_dev_setup(struct pnv_phb *phb, struct pci_dev *pdev
 		return;
 
 	pe = &phb->ioda.pe_array[pdn->pe_number];
-	set_iommu_table_base(&pdev->dev, &pe->tce32_table);
+	set_iommu_table_base_and_group(&pdev->dev, &pe->tce32_table);
 }
 
 static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe, struct pci_bus *bus)
@@ -468,7 +468,7 @@ static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe, struct pci_bus *bus)
 	struct pci_dev *dev;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
-		set_iommu_table_base(&dev->dev, &pe->tce32_table);
+		set_iommu_table_base_and_group(&dev->dev, &pe->tce32_table);
 		if (dev->subordinate)
 			pnv_ioda_setup_bus_dma(pe, dev->subordinate);
 	}
@@ -644,7 +644,7 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 	iommu_register_group(tbl, pci_domain_nr(pe->pbus), pe->pe_number);
 
 	if (pe->pdev)
-		set_iommu_table_base(&pe->pdev->dev, tbl);
+		set_iommu_table_base_and_group(&pe->pdev->dev, tbl);
 	else
 		pnv_ioda_setup_bus_dma(pe, pe->pbus);
 
@@ -722,7 +722,7 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 	iommu_init_table(tbl, phb->hose->node);
 
 	if (pe->pdev)
-		set_iommu_table_base(&pe->pdev->dev, tbl);
+		set_iommu_table_base_and_group(&pe->pdev->dev, tbl);
 	else
 		pnv_ioda_setup_bus_dma(pe, pe->pbus);
 
diff --git a/arch/powerpc/platforms/powernv/pci-p5ioc2.c b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
index f8b4bd8..e3807d6 100644
--- a/arch/powerpc/platforms/powernv/pci-p5ioc2.c
+++ b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
@@ -92,7 +92,7 @@ static void pnv_pci_p5ioc2_dma_dev_setup(struct pnv_phb *phb,
 				pci_domain_nr(phb->hose->bus), phb->opal_id);
 	}
 
-	set_iommu_table_base(&pdev->dev, &phb->p5ioc2.iommu_table);
+	set_iommu_table_base_and_group(&pdev->dev, &phb->p5ioc2.iommu_table);
 }
 
 static void __init pnv_pci_init_p5ioc2_phb(struct device_node *np, u64 hub_id,
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 4eb33a9..6f3d49c 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -536,7 +536,7 @@ static void pnv_pci_dma_fallback_setup(struct pci_controller *hose,
 		pdn->iommu_table = pnv_pci_setup_bml_iommu(hose);
 	if (!pdn->iommu_table)
 		return;
-	set_iommu_table_base(&pdev->dev, pdn->iommu_table);
+	set_iommu_table_base_and_group(&pdev->dev, pdn->iommu_table);
 }
 
 static void pnv_pci_dma_dev_setup(struct pci_dev *pdev)
@@ -657,3 +657,34 @@ void __init pnv_pci_init(void)
 	ppc_md.teardown_msi_irqs = pnv_teardown_msi_irqs;
 #endif
 }
+
+static int tce_iommu_bus_notifier(struct notifier_block *nb,
+		unsigned long action, void *data)
+{
+	struct device *dev = data;
+
+	switch (action) {
+	case BUS_NOTIFY_ADD_DEVICE:
+		return iommu_add_device(dev);
+	case BUS_NOTIFY_DEL_DEVICE:
+		if (dev->iommu_group)
+			iommu_del_device(dev);
+		return 0;
+	default:
+		return 0;
+	}
+}
+
+static struct notifier_block tce_iommu_bus_nb = {
+	.notifier_call = tce_iommu_bus_notifier,
+};
+
+static int __init tce_iommu_bus_notifier_init(void)
+{
+	BUILD_BUG_ON(PAGE_SIZE < IOMMU_PAGE_SIZE);
+
+	bus_register_notifier(&pci_bus_type, &tce_iommu_bus_nb);
+	return 0;
+}
+
+subsys_initcall_sync(tce_iommu_bus_notifier_init);
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index f253361..a80af6c 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -687,7 +687,8 @@ static void pci_dma_dev_setup_pSeries(struct pci_dev *dev)
 		iommu_table_setparms(phb, dn, tbl);
 		PCI_DN(dn)->iommu_table = iommu_init_table(tbl, phb->node);
 		iommu_register_group(tbl, pci_domain_nr(phb->bus), 0);
-		set_iommu_table_base(&dev->dev, PCI_DN(dn)->iommu_table);
+		set_iommu_table_base_and_group(&dev->dev,
+					       PCI_DN(dn)->iommu_table);
 		return;
 	}
 
@@ -699,7 +700,8 @@ static void pci_dma_dev_setup_pSeries(struct pci_dev *dev)
 		dn = dn->parent;
 
 	if (dn && PCI_DN(dn))
-		set_iommu_table_base(&dev->dev, PCI_DN(dn)->iommu_table);
+		set_iommu_table_base_and_group(&dev->dev,
+					       PCI_DN(dn)->iommu_table);
 	else
 		printk(KERN_WARNING "iommu: Device %s has no iommu table\n",
 		       pci_name(dev));
@@ -1193,7 +1195,7 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 		pr_debug("  found DMA window, table: %p\n", pci->iommu_table);
 	}
 
-	set_iommu_table_base(&dev->dev, pci->iommu_table);
+	set_iommu_table_base_and_group(&dev->dev, pci->iommu_table);
 }
 
 static int dma_set_mask_pSeriesLP(struct device *dev, u64 dma_mask)
-- 
1.8.4.rc4
