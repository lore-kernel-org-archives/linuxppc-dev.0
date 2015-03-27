Return-Path: <aik@ozlabs.ru>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 15AE41A02F6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2015 01:56:57 +1100 (AEDT)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Sat, 28 Mar 2015 00:56:56 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 926782CE8059
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2015 01:56:54 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2REuke215270062
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2015 01:56:54 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2REuKlg025898
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2015 01:56:21 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v7 11/31] powerpc/iommu: Introduce iommu_table_alloc()
 helper
Date: Sat, 28 Mar 2015 01:54:55 +1100
Message-Id: <1427468115-2224-12-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1427468115-2224-1-git-send-email-aik@ozlabs.ru>
References: <1427468115-2224-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This replaces multiple calls of kzalloc_node() with a new
iommu_table_alloc() helper. Right now it calls kzalloc_node() but
later it will be modified to allocate a iommu_table_group struct with
a single iommu_table in it.

Later the helper will allocate a iommu_table_group struct which embeds
the iommu table(s).

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/iommu.h       |  1 +
 arch/powerpc/kernel/iommu.c            |  9 +++++++++
 arch/powerpc/platforms/powernv/pci.c   |  2 +-
 arch/powerpc/platforms/pseries/iommu.c | 12 ++++--------
 4 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index d909e2a..eb75726 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -117,6 +117,7 @@ static inline void *get_iommu_table_base(struct device *dev)
 	return dev->archdata.dma_data.iommu_table_base;
 }
 
+extern struct iommu_table *iommu_table_alloc(int node);
 /* Frees table for an individual device node */
 extern void iommu_free_table(struct iommu_table *tbl, const char *node_name);
 
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index eceb214..b39d00a 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -710,6 +710,15 @@ struct iommu_table *iommu_init_table(struct iommu_table *tbl, int nid)
 	return tbl;
 }
 
+struct iommu_table *iommu_table_alloc(int node)
+{
+	struct iommu_table *tbl;
+
+	tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL, node);
+
+	return tbl;
+}
+
 void iommu_free_table(struct iommu_table *tbl, const char *node_name)
 {
 	unsigned long bitmap_sz;
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index c619ec6..1c31ac8 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -680,7 +680,7 @@ static struct iommu_table *pnv_pci_setup_bml_iommu(struct pci_controller *hose)
 		       hose->dn->full_name);
 		return NULL;
 	}
-	tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL, hose->node);
+	tbl = iommu_table_alloc(hose->node);
 	if (WARN_ON(!tbl))
 		return NULL;
 	pnv_pci_setup_iommu_table(tbl, __va(be64_to_cpup(basep)),
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 48d1fde..41a8b14 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -617,8 +617,7 @@ static void pci_dma_bus_setup_pSeries(struct pci_bus *bus)
 	pci->phb->dma_window_size = 0x8000000ul;
 	pci->phb->dma_window_base_cur = 0x8000000ul;
 
-	tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
-			   pci->phb->node);
+	tbl = iommu_table_alloc(pci->phb->node);
 
 	iommu_table_setparms(pci->phb, dn, tbl);
 	tbl->it_ops = &iommu_table_pseries_ops;
@@ -669,8 +668,7 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
 		 pdn->full_name, ppci->iommu_table);
 
 	if (!ppci->iommu_table) {
-		tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
-				   ppci->phb->node);
+		tbl = iommu_table_alloc(ppci->phb->node);
 		iommu_table_setparms_lpar(ppci->phb, pdn, tbl, dma_window);
 		tbl->it_ops = &iommu_table_lpar_multi_ops;
 		ppci->iommu_table = iommu_init_table(tbl, ppci->phb->node);
@@ -697,8 +695,7 @@ static void pci_dma_dev_setup_pSeries(struct pci_dev *dev)
 		struct pci_controller *phb = PCI_DN(dn)->phb;
 
 		pr_debug(" --> first child, no bridge. Allocating iommu table.\n");
-		tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
-				   phb->node);
+		tbl = iommu_table_alloc(phb->node);
 		iommu_table_setparms(phb, dn, tbl);
 		tbl->it_ops = &iommu_table_pseries_ops;
 		PCI_DN(dn)->iommu_table = iommu_init_table(tbl, phb->node);
@@ -1120,8 +1117,7 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 
 	pci = PCI_DN(pdn);
 	if (!pci->iommu_table) {
-		tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
-				   pci->phb->node);
+		tbl = iommu_table_alloc(pci->phb->node);
 		iommu_table_setparms_lpar(pci->phb, pdn, tbl, dma_window);
 		tbl->it_ops = &iommu_table_lpar_multi_ops;
 		pci->iommu_table = iommu_init_table(tbl, pci->phb->node);
-- 
2.0.0
