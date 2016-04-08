Return-Path: <aik@ozlabs.ru>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qh8sn199pzDqFD
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Apr 2016 16:38:05 +1000 (AEST)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 8 Apr 2016 16:38:03 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 753542CE8059
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Apr 2016 16:37:55 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u386bajd22675640
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Apr 2016 16:37:55 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u386bBx8007150
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Apr 2016 16:37:12 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Daniel Axtens <dja@axtens.net>, David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH kernel 1/2] powerpc/iommu: Get rid of default group_release()
Date: Fri,  8 Apr 2016 16:36:43 +1000
Message-Id: <1460097404-35422-2-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1460097404-35422-1-git-send-email-aik@ozlabs.ru>
References: <1460097404-35422-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

IBM PPC IOMMU API users always set IOMMU data and IOMMU release callback
to an IOMMU group. At the moment the callback clears one pointer in
iommu_table_group and that's it.

The platform code calls iommu_group_put() and counts on _put() being
called last so they check for table_group->group being reset which
is conceptually wrong as there may be another user holding a reference.

This removes the default IOMMU group release() callback and adds it
as a parameter to iommu_register_group(). As we are changing the prototype
anyway, this also changes the function name to more distinctive
iommu_register_table_group().

This should cause no behavioral change as it leaves BUG_ON for IODA2
(where it was reported) and removes BUG_ON for pseries/IODA1 as they
do not support IOV anyway and this BUG_ON has never been reported for
these platforms.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/iommu.h          | 12 +++++++-----
 arch/powerpc/kernel/iommu.c               | 14 ++++----------
 arch/powerpc/platforms/powernv/pci-ioda.c | 15 +++++++++++----
 arch/powerpc/platforms/pseries/iommu.c    | 17 +++++++++--------
 4 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index 7b87bab..d7ba3b4 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -201,17 +201,19 @@ struct iommu_table_group {
 
 #ifdef CONFIG_IOMMU_API
 
-extern void iommu_register_group(struct iommu_table_group *table_group,
-				 int pci_domain_number, unsigned long pe_num);
+extern void iommu_register_table_group(struct iommu_table_group *table_group,
+		int pci_domain_number, unsigned long pe_num,
+		void (*release)(void *iommu_data));
 extern int iommu_add_device(struct device *dev);
 extern void iommu_del_device(struct device *dev);
 extern int __init tce_iommu_bus_notifier_init(void);
 extern long iommu_tce_xchg(struct iommu_table *tbl, unsigned long entry,
 		unsigned long *hpa, enum dma_data_direction *direction);
 #else
-static inline void iommu_register_group(struct iommu_table_group *table_group,
-					int pci_domain_number,
-					unsigned long pe_num)
+static inline void iommu_register_table_group(
+		struct iommu_table_group *table_group,
+		int pci_domain_number, unsigned long pe_num,
+		void (*release)(void *iommu_data))
 {
 }
 
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index a8e3490..8eed2fa 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -887,15 +887,9 @@ EXPORT_SYMBOL_GPL(iommu_direction_to_tce_perm);
 /*
  * SPAPR TCE API
  */
-static void group_release(void *iommu_data)
-{
-	struct iommu_table_group *table_group = iommu_data;
-
-	table_group->group = NULL;
-}
-
-void iommu_register_group(struct iommu_table_group *table_group,
-		int pci_domain_number, unsigned long pe_num)
+void iommu_register_table_group(struct iommu_table_group *table_group,
+		int pci_domain_number, unsigned long pe_num,
+		void (*release)(void *iommu_data))
 {
 	struct iommu_group *grp;
 	char *name;
@@ -907,7 +901,7 @@ void iommu_register_group(struct iommu_table_group *table_group,
 		return;
 	}
 	table_group->group = grp;
-	iommu_group_set_iommudata(grp, table_group, group_release);
+	iommu_group_set_iommudata(grp, table_group, release);
 	name = kasprintf(GFP_KERNEL, "domain%d-pe%lx",
 			pci_domain_number, pe_num);
 	if (!name)
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index c5baaf3..ce9f2bf 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1330,6 +1330,13 @@ static long pnv_pci_ioda2_unset_window(struct iommu_table_group *table_group,
 		int num);
 static void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable);
 
+static void pnv_pci_ioda2_group_release(void *iommu_data)
+{
+	struct iommu_table_group *table_group = iommu_data;
+
+	table_group->group = NULL;
+}
+
 static void pnv_pci_ioda2_release_dma_pe(struct pci_dev *dev, struct pnv_ioda_pe *pe)
 {
 	struct iommu_table    *tbl;
@@ -1965,8 +1972,8 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 		return;
 
 	tbl = pnv_pci_table_alloc(phb->hose->node);
-	iommu_register_group(&pe->table_group, phb->hose->global_number,
-			pe->pe_number);
+	iommu_register_table_group(&pe->table_group, phb->hose->global_number,
+			pe->pe_number, NULL);
 	pnv_pci_link_table_and_group(phb->hose->node, 0, tbl, &pe->table_group);
 
 	/* Grab a 32-bit TCE table */
@@ -2450,8 +2457,8 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 	/* TVE #1 is selected by PCI address bit 59 */
 	pe->tce_bypass_base = 1ull << 59;
 
-	iommu_register_group(&pe->table_group, phb->hose->global_number,
-			pe->pe_number);
+	iommu_register_table_group(&pe->table_group, phb->hose->global_number,
+			pe->pe_number, pnv_pci_ioda2_group_release);
 
 	/* The PE will reserve all possible 32-bits space */
 	pe->tce32_seg = 0;
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index bd98ce2..0f6f06c 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -112,7 +112,7 @@ static void iommu_pseries_free_group(struct iommu_table_group *table_group,
 	}
 	if (table_group->group) {
 		iommu_group_put(table_group->group);
-		BUG_ON(table_group->group);
+		table_group->group = NULL;
 	}
 #endif
 	iommu_free_table(tbl, node_name);
@@ -692,7 +692,8 @@ static void pci_dma_bus_setup_pSeries(struct pci_bus *bus)
 	iommu_table_setparms(pci->phb, dn, tbl);
 	tbl->it_ops = &iommu_table_pseries_ops;
 	iommu_init_table(tbl, pci->phb->node);
-	iommu_register_group(pci->table_group, pci_domain_nr(bus), 0);
+	iommu_register_table_group(pci->table_group, pci_domain_nr(bus), 0,
+			NULL);
 
 	/* Divide the rest (1.75GB) among the children */
 	pci->phb->dma_window_size = 0x80000000ul;
@@ -743,8 +744,8 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
 		iommu_table_setparms_lpar(ppci->phb, pdn, tbl, dma_window);
 		tbl->it_ops = &iommu_table_lpar_multi_ops;
 		iommu_init_table(tbl, ppci->phb->node);
-		iommu_register_group(ppci->table_group,
-				pci_domain_nr(bus), 0);
+		iommu_register_table_group(ppci->table_group,
+				pci_domain_nr(bus), 0, NULL);
 		pr_debug("  created table: %p\n", ppci->table_group);
 	}
 }
@@ -772,8 +773,8 @@ static void pci_dma_dev_setup_pSeries(struct pci_dev *dev)
 		iommu_table_setparms(phb, dn, tbl);
 		tbl->it_ops = &iommu_table_pseries_ops;
 		iommu_init_table(tbl, phb->node);
-		iommu_register_group(PCI_DN(dn)->table_group,
-				pci_domain_nr(phb->bus), 0);
+		iommu_register_table_group(PCI_DN(dn)->table_group,
+				pci_domain_nr(phb->bus), 0, NULL);
 		set_iommu_table_base(&dev->dev, tbl);
 		iommu_add_device(&dev->dev);
 		return;
@@ -1197,8 +1198,8 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 		iommu_table_setparms_lpar(pci->phb, pdn, tbl, dma_window);
 		tbl->it_ops = &iommu_table_lpar_multi_ops;
 		iommu_init_table(tbl, pci->phb->node);
-		iommu_register_group(pci->table_group,
-				pci_domain_nr(pci->phb->bus), 0);
+		iommu_register_table_group(pci->table_group,
+				pci_domain_nr(pci->phb->bus), 0, NULL);
 		pr_debug("  created table: %p\n", pci->table_group);
 	} else {
 		pr_debug("  found DMA window, table: %p\n", pci->table_group);
-- 
2.5.0.rc3
