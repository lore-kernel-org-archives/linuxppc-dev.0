Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z0lBJ0jQczDrcj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 02:21:43 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBIFJvSr138906
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 10:21:41 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2exd8d93u6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 10:21:41 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Mon, 18 Dec 2017 15:21:38 -0000
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, mpe@ellerman.id.au,
 andrew.donnellan@au1.ibm.com, alastair@au1.ibm.com
Subject: [PATCH 01/13] powerpc/powernv: Introduce new PHB type for opencapi
 links
Date: Mon, 18 Dec 2017 16:21:14 +0100
In-Reply-To: <cover.1513608243.git.fbarrat@linux.vnet.ibm.com>
References: <cover.1513608243.git.fbarrat@linux.vnet.ibm.com>
In-Reply-To: <cover.1513608243.git.fbarrat@linux.vnet.ibm.com>
References: <cover.1513608243.git.fbarrat@linux.vnet.ibm.com>
Message-Id: <6870a754d346e7d8a47325e5ba4327853aea9226.1513608243.git.fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The NPU was already abstracted by opal as a virtual PHB for nvlink,
but it helps to be able to differentiate between a nvlink or opencapi
PHB, as it's not completely transparent to linux. In particular, PE
assignment differs and we'll also need the information in later
patches.

So rename existing PNV_PHB_NPU type to PNV_PHB_NPU_NVLINK and add a
new type PNV_PHB_NPU_OCAPI.

Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
---
 arch/powerpc/platforms/powernv/npu-dma.c  |  2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c | 46 +++++++++++++++++++++++--------
 arch/powerpc/platforms/powernv/pci.c      |  4 +++
 arch/powerpc/platforms/powernv/pci.h      |  8 ++++--
 4 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index f6cbc1a71472..c5899c107d59 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -277,7 +277,7 @@ static int pnv_npu_dma_set_bypass(struct pnv_ioda_pe *npe)
 	int64_t rc = 0;
 	phys_addr_t top = memblock_end_of_DRAM();
 
-	if (phb->type != PNV_PHB_NPU || !npe->pdev)
+	if (phb->type != PNV_PHB_NPU_NVLINK || !npe->pdev)
 		return -EINVAL;
 
 	rc = pnv_npu_unset_window(npe, 0);
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 749055553064..c37b5d288f9c 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -54,7 +54,8 @@
 #define POWERNV_IOMMU_DEFAULT_LEVELS	1
 #define POWERNV_IOMMU_MAX_LEVELS	5
 
-static const char * const pnv_phb_names[] = { "IODA1", "IODA2", "NPU" };
+static const char * const pnv_phb_names[] = { "IODA1", "IODA2", "NPU_NVLINK",
+					      "NPU_OCAPI" };
 static void pnv_pci_ioda2_table_free_pages(struct iommu_table *tbl);
 
 void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
@@ -924,7 +925,7 @@ static int pnv_ioda_configure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
 	 * Configure PELTV. NPUs don't have a PELTV table so skip
 	 * configuration on them.
 	 */
-	if (phb->type != PNV_PHB_NPU)
+	if (phb->type != PNV_PHB_NPU_NVLINK && phb->type != PNV_PHB_NPU_OCAPI)
 		pnv_ioda_set_peltv(phb, pe, true);
 
 	/* Setup reverse map */
@@ -1260,12 +1261,13 @@ static struct pnv_ioda_pe *pnv_ioda_setup_npu_PE(struct pci_dev *npu_pdev)
 		return pe;
 }
 
-static void pnv_ioda_setup_npu_PEs(struct pci_bus *bus)
+static void pnv_ioda_setup_npu_PEs(struct pci_bus *bus,
+			    struct pnv_ioda_pe *fn(struct pci_dev *npu_pdev))
 {
 	struct pci_dev *pdev;
 
 	list_for_each_entry(pdev, &bus->devices, bus_list)
-		pnv_ioda_setup_npu_PE(pdev);
+		fn(pdev);
 }
 
 static void pnv_pci_ioda_setup_PEs(void)
@@ -1275,13 +1277,18 @@ static void pnv_pci_ioda_setup_PEs(void)
 
 	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
 		phb = hose->private_data;
-		if (phb->type == PNV_PHB_NPU) {
+		if (phb->type == PNV_PHB_NPU_NVLINK) {
 			/* PE#0 is needed for error reporting */
 			pnv_ioda_reserve_pe(phb, 0);
-			pnv_ioda_setup_npu_PEs(hose->bus);
+			pnv_ioda_setup_npu_PEs(hose->bus,
+					pnv_ioda_setup_npu_PE);
 			if (phb->model == PNV_PHB_MODEL_NPU2)
 				pnv_npu2_init(phb);
 		}
+		if (phb->type == PNV_PHB_NPU_OCAPI) {
+			pnv_ioda_setup_npu_PEs(hose->bus,
+					pnv_ioda_setup_dev_PE);
+		}
 	}
 }
 
@@ -2640,7 +2647,7 @@ static int gpe_table_group_to_npe_cb(struct device *dev, void *opaque)
 
 	hose = pci_bus_to_host(pdev->bus);
 	phb = hose->private_data;
-	if (phb->type != PNV_PHB_NPU)
+	if (phb->type != PNV_PHB_NPU_NVLINK)
 		return 0;
 
 	*ptmppe = &phb->ioda.pe_array[pdn->pe_number];
@@ -2724,7 +2731,7 @@ static void pnv_pci_ioda_setup_iommu_api(void)
 	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
 		phb = hose->private_data;
 
-		if (phb->type != PNV_PHB_NPU)
+		if (phb->type != PNV_PHB_NPU_NVLINK)
 			continue;
 
 		list_for_each_entry(pe, &phb->ioda.pe_list, list) {
@@ -3774,6 +3781,13 @@ static const struct pci_controller_ops pnv_npu_ioda_controller_ops = {
 	.shutdown		= pnv_pci_ioda_shutdown,
 };
 
+static const struct pci_controller_ops pnv_npu_ocapi_ioda_controller_ops = {
+	.enable_device_hook	= pnv_pci_enable_device_hook,
+	.window_alignment	= pnv_pci_window_alignment,
+	.reset_secondary_bus	= pnv_pci_reset_secondary_bus,
+	.shutdown		= pnv_pci_ioda_shutdown,
+};
+
 #ifdef CONFIG_CXL_BASE
 const struct pci_controller_ops pnv_cxl_cx4_ioda_controller_ops = {
 	.dma_dev_setup		= pnv_pci_dma_dev_setup,
@@ -4007,9 +4021,14 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	 */
 	ppc_md.pcibios_fixup = pnv_pci_ioda_fixup;
 
-	if (phb->type == PNV_PHB_NPU) {
+	switch (phb->type) {
+	case PNV_PHB_NPU_NVLINK:
 		hose->controller_ops = pnv_npu_ioda_controller_ops;
-	} else {
+		break;
+	case PNV_PHB_NPU_OCAPI:
+		hose->controller_ops = pnv_npu_ocapi_ioda_controller_ops;
+		break;
+	default:
 		phb->dma_dev_setup = pnv_pci_ioda_dma_dev_setup;
 		hose->controller_ops = pnv_pci_ioda_controller_ops;
 	}
@@ -4052,7 +4071,12 @@ void __init pnv_pci_init_ioda2_phb(struct device_node *np)
 
 void __init pnv_pci_init_npu_phb(struct device_node *np)
 {
-	pnv_pci_init_ioda_phb(np, 0, PNV_PHB_NPU);
+	pnv_pci_init_ioda_phb(np, 0, PNV_PHB_NPU_NVLINK);
+}
+
+void __init pnv_pci_init_npu2_opencapi_phb(struct device_node *np)
+{
+	pnv_pci_init_ioda_phb(np, 0, PNV_PHB_NPU_OCAPI);
 }
 
 void __init pnv_pci_init_ioda_hub(struct device_node *np)
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 5422f4a6317c..69d102cbf48f 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -1142,6 +1142,10 @@ void __init pnv_pci_init(void)
 	for_each_compatible_node(np, NULL, "ibm,ioda2-npu2-phb")
 		pnv_pci_init_npu_phb(np);
 
+	/* Look for NPU2 OpenCAPI PHBs */
+	for_each_compatible_node(np, NULL, "ibm,ioda2-npu2-opencapi-phb")
+		pnv_pci_init_npu2_opencapi_phb(np);
+
 	/* Configure IOMMU DMA hooks */
 	set_pci_dma_ops(&dma_iommu_ops);
 }
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index b772d7473896..eada4b6068cb 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -12,9 +12,10 @@ struct pci_dn;
 #define NV_NMMU_ATSD_REGS 8
 
 enum pnv_phb_type {
-	PNV_PHB_IODA1	= 0,
-	PNV_PHB_IODA2	= 1,
-	PNV_PHB_NPU	= 2,
+	PNV_PHB_IODA1		= 0,
+	PNV_PHB_IODA2		= 1,
+	PNV_PHB_NPU_NVLINK	= 2,
+	PNV_PHB_NPU_OCAPI	= 3,
 };
 
 /* Precise PHB model for error management */
@@ -227,6 +228,7 @@ extern void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
 extern void pnv_pci_init_ioda_hub(struct device_node *np);
 extern void pnv_pci_init_ioda2_phb(struct device_node *np);
 extern void pnv_pci_init_npu_phb(struct device_node *np);
+extern void pnv_pci_init_npu2_opencapi_phb(struct device_node *np);
 extern void pnv_pci_reset_secondary_bus(struct pci_dev *dev);
 extern int pnv_eeh_phb_reset(struct pci_controller *hose, int option);
 
-- 
2.14.1
