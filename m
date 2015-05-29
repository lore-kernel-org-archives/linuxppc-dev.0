Return-Path: <aik@ozlabs.ru>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0E0271A097B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:47:14 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 29 May 2015 18:47:13 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 64A753578052
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:47:12 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4T8jn1764815226
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:45:57 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4T8jOe2004130
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:45:25 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH kernel v11 02/34] powerpc/iommu/powernv: Get rid of
 set_iommu_table_base_and_group
Date: Fri, 29 May 2015 18:44:26 +1000
Message-Id: <1432889098-22924-3-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1432889098-22924-1-git-send-email-aik@ozlabs.ru>
References: <1432889098-22924-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The set_iommu_table_base_and_group() name suggests that the function
sets table base and add a device to an IOMMU group.

The actual purpose for table base setting is to put some reference
into a device so later iommu_add_device() can get the IOMMU group
reference and the device to the group.

At the moment a group cannot be explicitly passed to iommu_add_device()
as we want it to work from the bus notifier, we can fix it later and
remove confusing calls of set_iommu_table_base().

This replaces set_iommu_table_base_and_group() with a couple of
set_iommu_table_base() + iommu_add_device() which makes reading the code
easier.

This adds few comments why set_iommu_table_base() and iommu_add_device()
are called where they are called.

For IODA1/2, this essentially removes iommu_add_device() call from
the pnv_pci_ioda_dma_dev_setup() as it will always fail at this particular
place:
- for physical PE, the device is already attached by iommu_add_device()
in pnv_pci_ioda_setup_dma_pe();
- for virtual PE, the sysfs entries are not ready to create all symlinks
so actual adding is happening in tce_iommu_bus_notifier.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
Changes:
v10:
* new to the series
---
 arch/powerpc/include/asm/iommu.h            |  7 -------
 arch/powerpc/platforms/powernv/pci-ioda.c   | 27 +++++++++++++++++++++++----
 arch/powerpc/platforms/powernv/pci-p5ioc2.c |  3 ++-
 arch/powerpc/platforms/pseries/iommu.c      | 15 ++++++++-------
 4 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index 1e27d63..8353c86 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -140,13 +140,6 @@ static inline int __init tce_iommu_bus_notifier_init(void)
 }
 #endif /* !CONFIG_IOMMU_API */
 
-static inline void set_iommu_table_base_and_group(struct device *dev,
-						  void *base)
-{
-	set_iommu_table_base(dev, base);
-	iommu_add_device(dev);
-}
-
 extern int ppc_iommu_map_sg(struct device *dev, struct iommu_table *tbl,
 			    struct scatterlist *sglist, int nelems,
 			    unsigned long mask,
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 2f092bb..9a77f3c 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1598,7 +1598,13 @@ static void pnv_pci_ioda_dma_dev_setup(struct pnv_phb *phb, struct pci_dev *pdev
 
 	pe = &phb->ioda.pe_array[pdn->pe_number];
 	WARN_ON(get_dma_ops(&pdev->dev) != &dma_iommu_ops);
-	set_iommu_table_base_and_group(&pdev->dev, pe->tce32_table);
+	set_iommu_table_base(&pdev->dev, pe->tce32_table);
+	/*
+	 * Note: iommu_add_device() will fail here as
+	 * for physical PE: the device is already added by now;
+	 * for virtual PE: sysfs entries are not ready yet and
+	 * tce_iommu_bus_notifier will add the device to a group later.
+	 */
 }
 
 static int pnv_pci_ioda_dma_set_mask(struct pnv_phb *phb,
@@ -1659,7 +1665,8 @@ static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe,
 	struct pci_dev *dev;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
-		set_iommu_table_base_and_group(&dev->dev, pe->tce32_table);
+		set_iommu_table_base(&dev->dev, pe->tce32_table);
+		iommu_add_device(&dev->dev);
 
 		if (dev->subordinate)
 			pnv_ioda_setup_bus_dma(pe, dev->subordinate);
@@ -1835,7 +1842,13 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 	if (pe->flags & PNV_IODA_PE_DEV) {
 		iommu_register_group(tbl, phb->hose->global_number,
 				     pe->pe_number);
-		set_iommu_table_base_and_group(&pe->pdev->dev, tbl);
+		/*
+		 * Setting table base here only for carrying iommu_group
+		 * further down to let iommu_add_device() do the job.
+		 * pnv_pci_ioda_dma_dev_setup will override it later anyway.
+		 */
+		set_iommu_table_base(&pe->pdev->dev, tbl);
+		iommu_add_device(&pe->pdev->dev);
 	} else if (pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL)) {
 		iommu_register_group(tbl, phb->hose->global_number,
 				     pe->pe_number);
@@ -1963,7 +1976,13 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 	if (pe->flags & PNV_IODA_PE_DEV) {
 		iommu_register_group(tbl, phb->hose->global_number,
 				     pe->pe_number);
-		set_iommu_table_base_and_group(&pe->pdev->dev, tbl);
+		/*
+		 * Setting table base here only for carrying iommu_group
+		 * further down to let iommu_add_device() do the job.
+		 * pnv_pci_ioda_dma_dev_setup will override it later anyway.
+		 */
+		set_iommu_table_base(&pe->pdev->dev, tbl);
+		iommu_add_device(&pe->pdev->dev);
 	} else if (pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL)) {
 		iommu_register_group(tbl, phb->hose->global_number,
 				     pe->pe_number);
diff --git a/arch/powerpc/platforms/powernv/pci-p5ioc2.c b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
index 4729ca7..b17d93615 100644
--- a/arch/powerpc/platforms/powernv/pci-p5ioc2.c
+++ b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
@@ -92,7 +92,8 @@ static void pnv_pci_p5ioc2_dma_dev_setup(struct pnv_phb *phb,
 				pci_domain_nr(phb->hose->bus), phb->opal_id);
 	}
 
-	set_iommu_table_base_and_group(&pdev->dev, &phb->p5ioc2.iommu_table);
+	set_iommu_table_base(&pdev->dev, &phb->p5ioc2.iommu_table);
+	iommu_add_device(&pdev->dev);
 }
 
 static void __init pnv_pci_init_p5ioc2_phb(struct device_node *np, u64 hub_id,
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 61d5a17..05ab06d 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -688,8 +688,8 @@ static void pci_dma_dev_setup_pSeries(struct pci_dev *dev)
 		iommu_table_setparms(phb, dn, tbl);
 		PCI_DN(dn)->iommu_table = iommu_init_table(tbl, phb->node);
 		iommu_register_group(tbl, pci_domain_nr(phb->bus), 0);
-		set_iommu_table_base_and_group(&dev->dev,
-					       PCI_DN(dn)->iommu_table);
+		set_iommu_table_base(&dev->dev, tbl);
+		iommu_add_device(&dev->dev);
 		return;
 	}
 
@@ -700,10 +700,10 @@ static void pci_dma_dev_setup_pSeries(struct pci_dev *dev)
 	while (dn && PCI_DN(dn) && PCI_DN(dn)->iommu_table == NULL)
 		dn = dn->parent;
 
-	if (dn && PCI_DN(dn))
-		set_iommu_table_base_and_group(&dev->dev,
-					       PCI_DN(dn)->iommu_table);
-	else
+	if (dn && PCI_DN(dn)) {
+		set_iommu_table_base(&dev->dev, PCI_DN(dn)->iommu_table);
+		iommu_add_device(&dev->dev);
+	} else
 		printk(KERN_WARNING "iommu: Device %s has no iommu table\n",
 		       pci_name(dev));
 }
@@ -1115,7 +1115,8 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 		pr_debug("  found DMA window, table: %p\n", pci->iommu_table);
 	}
 
-	set_iommu_table_base_and_group(&dev->dev, pci->iommu_table);
+	set_iommu_table_base(&dev->dev, pci->iommu_table);
+	iommu_add_device(&dev->dev);
 }
 
 static int dma_set_mask_pSeriesLP(struct device *dev, u64 dma_mask)
-- 
2.4.0.rc3.8.gfb3e7d5
