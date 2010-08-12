Return-Path: <anton@ozlabs.org>
Date: Thu, 12 Aug 2010 12:42:48 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc: Fix bogus it_blocksize in VIO iommu code
Message-ID: <20100812024248.GX29316@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


When looking at some issues with the virtual ethernet driver I noticed
that TCE allocation was following a very strange pattern:

address 00e9000 length 2048
address 0409000 length 2048 <-----
address 0429000 length 2048
address 0449000 length 2048
address 0469000 length 2048
address 0489000 length 2048
address 04a9000 length 2048
address 04c9000 length 2048
address 04e9000 length 2048
address 4009000 length 2048 <-----
address 4029000 length 2048

Huge unexplained gaps in what should be an empty TCE table. It turns out
it_blocksize, the amount we want to align the next allocation to, was
c0000000fe903b20. Completely bogus.

Initialise it to something reasonable in the VIO IOMMU code, and use kzalloc
everywhere to protect against this when we next add a non compulsary
field to iommu code and forget to initialise it.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: powerpc.git/arch/powerpc/kernel/vio.c
===================================================================
--- powerpc.git.orig/arch/powerpc/kernel/vio.c	2010-08-12 12:27:58.674490962 +1000
+++ powerpc.git/arch/powerpc/kernel/vio.c	2010-08-12 12:28:18.660741428 +1000
@@ -1059,7 +1059,7 @@ static struct iommu_table *vio_build_iom
 	if (!dma_window)
 		return NULL;
 
-	tbl = kmalloc(sizeof(*tbl), GFP_KERNEL);
+	tbl = kzalloc(sizeof(*tbl), GFP_KERNEL);
 	if (tbl == NULL)
 		return NULL;
 
@@ -1072,6 +1072,7 @@ static struct iommu_table *vio_build_iom
 	tbl->it_offset = offset >> IOMMU_PAGE_SHIFT;
 	tbl->it_busno = 0;
 	tbl->it_type = TCE_VB;
+	tbl->it_blocksize = 16;
 
 	return iommu_init_table(tbl, -1);
 }
Index: powerpc.git/arch/powerpc/platforms/iseries/iommu.c
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/iseries/iommu.c	2010-08-12 12:29:35.473241172 +1000
+++ powerpc.git/arch/powerpc/platforms/iseries/iommu.c	2010-08-12 12:29:50.190890563 +1000
@@ -184,7 +184,7 @@ static void pci_dma_dev_setup_iseries(st
 
 	BUG_ON(lsn == NULL);
 
-	tbl = kmalloc(sizeof(struct iommu_table), GFP_KERNEL);
+	tbl = kzalloc(sizeof(struct iommu_table), GFP_KERNEL);
 
 	iommu_table_getparms_iSeries(pdn->busno, *lsn, 0, tbl);
 
Index: powerpc.git/arch/powerpc/platforms/pseries/iommu.c
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/pseries/iommu.c	2010-08-12 12:28:45.340756738 +1000
+++ powerpc.git/arch/powerpc/platforms/pseries/iommu.c	2010-08-12 12:29:15.401118951 +1000
@@ -403,7 +403,7 @@ static void pci_dma_bus_setup_pSeries(st
 	pci->phb->dma_window_size = 0x8000000ul;
 	pci->phb->dma_window_base_cur = 0x8000000ul;
 
-	tbl = kmalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
+	tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
 			   pci->phb->node);
 
 	iommu_table_setparms(pci->phb, dn, tbl);
@@ -448,7 +448,7 @@ static void pci_dma_bus_setup_pSeriesLP(
 		 pdn->full_name, ppci->iommu_table);
 
 	if (!ppci->iommu_table) {
-		tbl = kmalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
+		tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
 				   ppci->phb->node);
 		iommu_table_setparms_lpar(ppci->phb, pdn, tbl, dma_window,
 			bus->number);
@@ -478,7 +478,7 @@ static void pci_dma_dev_setup_pSeries(st
 		struct pci_controller *phb = PCI_DN(dn)->phb;
 
 		pr_debug(" --> first child, no bridge. Allocating iommu table.\n");
-		tbl = kmalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
+		tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
 				   phb->node);
 		iommu_table_setparms(phb, dn, tbl);
 		PCI_DN(dn)->iommu_table = iommu_init_table(tbl, phb->node);
@@ -544,7 +544,7 @@ static void pci_dma_dev_setup_pSeriesLP(
 
 	pci = PCI_DN(pdn);
 	if (!pci->iommu_table) {
-		tbl = kmalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
+		tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
 				   pci->phb->node);
 		iommu_table_setparms_lpar(pci->phb, pdn, tbl, dma_window,
 			pci->phb->bus->number);
Index: powerpc.git/arch/powerpc/platforms/cell/iommu.c
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/cell/iommu.c	2010-08-12 12:31:27.040741891 +1000
+++ powerpc.git/arch/powerpc/platforms/cell/iommu.c	2010-08-12 12:31:34.641324320 +1000
@@ -477,7 +477,7 @@ cell_iommu_setup_window(struct cbe_iommu
 
 	ioid = cell_iommu_get_ioid(np);
 
-	window = kmalloc_node(sizeof(*window), GFP_KERNEL, iommu->nid);
+	window = kzalloc_node(sizeof(*window), GFP_KERNEL, iommu->nid);
 	BUG_ON(window == NULL);
 
 	window->offset = offset;
