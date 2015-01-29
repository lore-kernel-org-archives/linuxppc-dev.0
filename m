Return-Path: <aik@ozlabs.ru>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A96F61A0C2A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2015 20:22:31 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Thu, 29 Jan 2015 19:22:21 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 716EF2BB005C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2015 20:22:14 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0T9ME4A47972518
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2015 20:22:14 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0T9MCDO022813
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2015 20:22:13 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 07/24] powerpc/iommu: Introduce iommu_table_alloc() helper
Date: Thu, 29 Jan 2015 20:21:48 +1100
Message-Id: <1422523325-1389-8-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1422523325-1389-1-git-send-email-aik@ozlabs.ru>
References: <1422523325-1389-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Alexander Gordeev <agordeev@redhat.com>, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
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
later it will be modified to allocate a powerpc_iommu struct with
a single iommu_table in it.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/iommu.h       |  1 +
 arch/powerpc/kernel/iommu.c            |  9 +++++++++
 arch/powerpc/platforms/powernv/pci.c   |  2 +-
 arch/powerpc/platforms/pseries/iommu.c | 12 ++++--------
 4 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index eb5822d..335e3d4 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -117,6 +117,7 @@ static inline void *get_iommu_table_base(struct device *dev)
 	return dev->archdata.dma_data.iommu_table_base;
 }
 
+extern struct iommu_table *iommu_table_alloc(int node);
 /* Frees table for an individual device node */
 extern void iommu_free_table(struct iommu_table *tbl, const char *node_name);
 
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index c51ad3e..2f7e92b 100644
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
index c4782b1..bbe529b 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -693,7 +693,7 @@ static struct iommu_table *pnv_pci_setup_bml_iommu(struct pci_controller *hose)
 		       hose->dn->full_name);
 		return NULL;
 	}
-	tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL, hose->node);
+	tbl = iommu_table_alloc(hose->node);
 	if (WARN_ON(!tbl))
 		return NULL;
 	pnv_pci_setup_iommu_table(tbl, __va(be64_to_cpup(basep)),
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 1aa1815..bc14299 100644
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
