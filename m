Return-Path: <alistair@popple.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7F8EE1A026D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 16:03:01 +1100 (AEDT)
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@ozlabs.org
Cc: gwshan@linux.vnet.ibm.com, benh@kernel.crashing.org,
 Alistair Popple <alistair@popple.id.au>
Subject: [PATCH 2/2] platforms/powernv: Add support for Nvlink NPUs
Date: Wed, 28 Oct 2015 16:00:02 +1100
Message-Id: <1446008402-24892-3-git-send-email-alistair@popple.id.au>
In-Reply-To: <1446008402-24892-1-git-send-email-alistair@popple.id.au>
References: <1446008402-24892-1-git-send-email-alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

NV-Link is a high speed interconnect that is used in conjunction with
a PCI-E connection to create an interface between CPU and GPU that
provides very high data bandwidth. A PCI-E connection to a GPU is used
as the control path to initiate and report status of large data
transfers sent via the NV-Link.

On IBM Power systems the NV-Link hardware interface is very similar to
the existing PHB3. This patch adds support for this new NPU PHB
type. DMA operations on the NPU are not supported as this patch sets
the TCE translation tables to be the same as the related GPU PCIe
device for each Nvlink. Therefore all DMA operations are setup and
controlled via the PCIe device.

EEH is not presently supported for the NPU devices, although it may be
added in future.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pci.h            |   4 +
 arch/powerpc/platforms/powernv/Makefile   |   2 +-
 arch/powerpc/platforms/powernv/npu-dma.c  | 267 ++++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/pci-ioda.c | 104 ++++++++++--
 arch/powerpc/platforms/powernv/pci.c      |   4 +
 arch/powerpc/platforms/powernv/pci.h      |  10 ++
 6 files changed, 379 insertions(+), 12 deletions(-)
 create mode 100644 arch/powerpc/platforms/powernv/npu-dma.c

diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index 3453bd8..4409ca9 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -149,4 +149,8 @@ extern void pcibios_setup_phb_io_space(struct pci_controller *hose);
 extern void pcibios_scan_phb(struct pci_controller *hose);
 
 #endif	/* __KERNEL__ */
+
+extern struct pci_dev *pnv_get_nvl_pci_dev(struct pci_dev *nvl_dev);
+extern struct pci_dev *pnv_get_pci_nvl_dev(struct pci_dev *pci_dev, int index);
+
 #endif /* __ASM_POWERPC_PCI_H */
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index 1c8cdb6..ee774e8 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -4,7 +4,7 @@ obj-y			+= rng.o opal-elog.o opal-dump.o opal-sysparam.o opal-sensor.o
 obj-y			+= opal-msglog.o opal-hmi.o opal-power.o opal-irqchip.o
 
 obj-$(CONFIG_SMP)	+= smp.o subcore.o subcore-asm.o
-obj-$(CONFIG_PCI)	+= pci.o pci-p5ioc2.o pci-ioda.o
+obj-$(CONFIG_PCI)	+= pci.o pci-p5ioc2.o pci-ioda.o npu-dma.o
 obj-$(CONFIG_EEH)	+= eeh-powernv.o
 obj-$(CONFIG_PPC_SCOM)	+= opal-xscom.o
 obj-$(CONFIG_MEMORY_FAILURE)	+= opal-memory-errors.o
diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
new file mode 100644
index 0000000..4f8ec18
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -0,0 +1,267 @@
+/*
+ * This file implements the DMA operations for Nvlink devices. The NPU
+ * devices all point to the same iommu table as the parent PCI device.
+ *
+ * Copyright Alistair Popple, IBM Corporation 2015.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/export.h>
+#include <linux/pci.h>
+#include <linux/memblock.h>
+
+#include <asm/iommu.h>
+#include <asm/pnv-pci.h>
+#include <asm/msi_bitmap.h>
+#include <asm/opal.h>
+
+#include "powernv.h"
+#include "pci.h"
+
+static struct pci_dev *get_pci_dev(struct device_node *dn)
+{
+	return PCI_DN(dn)->pcidev;
+}
+
+/* Given a NPU device get the associated PCI device. */
+struct pci_dev *pnv_get_nvl_pci_dev(struct pci_dev *nvl_dev)
+{
+	struct device_node *dn;
+	struct pci_dev *pci_dev;
+
+	/* Get assoicated PCI device */
+	dn = of_parse_phandle(nvl_dev->dev.of_node, "ibm,gpu", 0);
+	if (!dn)
+		return NULL;
+
+	pci_dev = get_pci_dev(dn);
+	of_node_put(dn);
+
+	return pci_dev;
+}
+EXPORT_SYMBOL(pnv_get_nvl_pci_dev);
+
+/* Given the real PCI device get a linked NPU device. */
+struct pci_dev *pnv_get_pci_nvl_dev(struct pci_dev *pci_dev, int index)
+{
+	struct device_node *dn;
+	struct pci_dev *nvl_dev;
+
+	/* Get assoicated PCI device */
+	dn = of_parse_phandle(pci_dev->dev.of_node, "ibm,npu", index);
+	if (!dn)
+		return NULL;
+
+	nvl_dev = get_pci_dev(dn);
+	of_node_put(dn);
+
+	return nvl_dev;
+}
+EXPORT_SYMBOL(pnv_get_pci_nvl_dev);
+
+const struct dma_map_ops *get_linked_pci_dma_map_ops(struct device *dev,
+					struct pci_dev **pci_dev)
+{
+	*pci_dev = pnv_get_nvl_pci_dev(to_pci_dev(dev));
+	if (!*pci_dev)
+		return NULL;
+
+	return get_dma_ops(&(*pci_dev)->dev);
+}
+
+#define NPU_DMA_OP_UNSUPPORTED()					\
+	dev_err_once(dev, "%s operation unsupported for Nvlink devices\n", \
+		__func__)
+
+static void *dma_npu_alloc(struct device *dev, size_t size,
+				      dma_addr_t *dma_handle, gfp_t flag,
+				      struct dma_attrs *attrs)
+{
+	NPU_DMA_OP_UNSUPPORTED();
+	return NULL;
+}
+
+static void dma_npu_free(struct device *dev, size_t size,
+				    void *vaddr, dma_addr_t dma_handle,
+				    struct dma_attrs *attrs)
+{
+	NPU_DMA_OP_UNSUPPORTED();
+}
+
+static dma_addr_t dma_npu_map_page(struct device *dev, struct page *page,
+				     unsigned long offset, size_t size,
+				     enum dma_data_direction direction,
+				     struct dma_attrs *attrs)
+{
+	NPU_DMA_OP_UNSUPPORTED();
+	return 0;
+}
+
+static int dma_npu_map_sg(struct device *dev, struct scatterlist *sglist,
+			    int nelems, enum dma_data_direction direction,
+			    struct dma_attrs *attrs)
+{
+	NPU_DMA_OP_UNSUPPORTED();
+	return 0;
+}
+
+static int dma_npu_dma_supported(struct device *dev, u64 mask)
+{
+	NPU_DMA_OP_UNSUPPORTED();
+	return 0;
+}
+
+static u64 dma_npu_get_required_mask(struct device *dev)
+{
+	NPU_DMA_OP_UNSUPPORTED();
+	return 0;
+}
+
+struct dma_map_ops dma_npu_ops = {
+	.map_page		= dma_npu_map_page,
+	.map_sg			= dma_npu_map_sg,
+	.alloc			= dma_npu_alloc,
+	.free			= dma_npu_free,
+	.dma_supported		= dma_npu_dma_supported,
+	.get_required_mask	= dma_npu_get_required_mask,
+};
+
+/* Returns the PE assoicated with the PCI device of the given
+ * NPU. Returns the linked pci device if pci_dev != NULL.
+ */
+static struct pnv_ioda_pe *get_linked_pci_pe(struct pci_dev *npu_dev,
+					struct pci_dev **pci_dev)
+{
+	struct pci_dev *linked_pci_dev;
+	struct pci_controller *pci_hose;
+	struct pnv_phb *pci_phb;
+	struct pnv_ioda_pe *linked_pe;
+	unsigned long pe_num;
+
+	linked_pci_dev = pnv_get_nvl_pci_dev(npu_dev);
+	if (!linked_pci_dev)
+		return NULL;
+
+	pci_hose = pci_bus_to_host(linked_pci_dev->bus);
+	pci_phb = pci_hose->private_data;
+	pe_num = pci_get_pdn(linked_pci_dev)->pe_number;
+	if (pe_num == IODA_INVALID_PE)
+		return NULL;
+
+	linked_pe = &pci_phb->ioda.pe_array[pe_num];
+	if (pci_dev)
+		*pci_dev = linked_pci_dev;
+
+	return linked_pe;
+}
+
+/* For the NPU we want to point the TCE table at the same table as the
+ * real PCI device.
+ */
+void pnv_pci_npu_setup_dma_pe(struct pnv_phb *npu,
+			struct pnv_ioda_pe *npu_pe)
+{
+	void *addr;
+	struct pci_dev *pci_dev;
+	struct pnv_ioda_pe *pci_pe;
+	unsigned int tce_table_size;
+	int rc;
+
+	/* Find the assoicated PCI devices and get the dma window
+	 * information from there.
+	 */
+	if (!npu_pe->pdev || !(npu_pe->flags & PNV_IODA_PE_DEV))
+		return;
+
+	pci_pe = get_linked_pci_pe(npu_pe->pdev, &pci_dev);
+	if (!pci_pe)
+		return;
+
+	addr = (void *) pci_pe->table_group.tables[0]->it_base;
+	tce_table_size = pci_pe->table_group.tables[0]->it_size << 3;
+	rc = opal_pci_map_pe_dma_window(npu->opal_id, npu_pe->pe_number,
+					npu_pe->pe_number, 1, __pa(addr),
+					tce_table_size, 0x1000);
+	WARN_ON(rc != OPAL_SUCCESS);
+
+	/* We don't initialise npu_pe->tce32_table as we always use
+	 * dma_npu_ops which redirects to the actual pci device dma op
+	 * functions.
+	 */
+	set_dma_ops(&npu_pe->pdev->dev, &dma_npu_ops);
+}
+
+/* Enable/disable bypass mode on the NPU. The NPU only supports one
+ * window per brick, so bypass needs to be explicity enabled or
+ * disabled. Unlike for a PHB3 bypass and non-bypass modes can't be
+ * active at the same time.
+ */
+int pnv_pci_npu_dma_set_bypass(struct pnv_phb *npu,
+			struct pnv_ioda_pe *npu_pe, bool enabled)
+{
+	int rc = 0;
+
+	if (npu->type != PNV_PHB_NPU)
+		return -EINVAL;
+
+	if (enabled) {
+		/* Enable the bypass window */
+		phys_addr_t top = memblock_end_of_DRAM();
+
+		npu_pe->tce_bypass_base = 0;
+		top = roundup_pow_of_two(top);
+		dev_info(&npu_pe->pdev->dev, "Enabling bypass for PE %d\n",
+			npu_pe->pe_number);
+		rc = opal_pci_map_pe_dma_window_real(npu->opal_id,
+						     npu_pe->pe_number,
+						     npu_pe->pe_number,
+						     npu_pe->tce_bypass_base,
+						     top);
+	} else
+		/* Disable the bypass window by replacing it with the
+		 * TCE32 window.
+		 */
+		pnv_pci_npu_setup_dma_pe(npu, npu_pe);
+
+	return rc;
+}
+
+int pnv_npu_dma_set_mask(struct pci_dev *pdev, u64 dma_mask)
+{
+	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
+	struct pnv_phb *phb = hose->private_data;
+	struct pci_dn *pdn = pci_get_pdn(pdev);
+	struct pnv_ioda_pe *pe, *linked_pe;
+	struct pci_dev *linked_pci_dev;
+	uint64_t top;
+	bool bypass = false;
+
+	if (WARN_ON(!pdn || pdn->pe_number == IODA_INVALID_PE))
+		return -ENODEV;
+
+
+	/* We only do bypass if it's enabled on the linked device */
+	linked_pe = get_linked_pci_pe(pdev, &linked_pci_dev);
+	if (!linked_pe)
+		return -ENODEV;
+
+	if (linked_pe->tce_bypass_enabled) {
+		top = linked_pe->tce_bypass_base + memblock_end_of_DRAM() - 1;
+		bypass = (dma_mask >= top);
+	}
+
+	if (bypass)
+		dev_info(&pdev->dev, "Using 64-bit DMA iommu bypass\n");
+	else
+		dev_info(&pdev->dev, "Using 32-bit DMA via iommu\n");
+
+	pe = &phb->ioda.pe_array[pdn->pe_number];
+	pnv_pci_npu_dma_set_bypass(phb, pe, bypass);
+	*pdev->dev.dma_mask = dma_mask;
+
+	return 0;
+}
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 42b4bb2..72b6ced 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -781,7 +781,8 @@ static int pnv_ioda_configure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
 	}
 
 	/* Configure PELTV */
-	pnv_ioda_set_peltv(phb, pe, true);
+	if (phb->type != PNV_PHB_NPU)
+		pnv_ioda_set_peltv(phb, pe, true);
 
 	/* Setup reverse map */
 	for (rid = pe->rid; rid < rid_end; rid++)
@@ -924,7 +925,6 @@ static int pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
 }
 #endif /* CONFIG_PCI_IOV */
 
-#if 0
 static struct pnv_ioda_pe *pnv_ioda_setup_dev_PE(struct pci_dev *dev)
 {
 	struct pci_controller *hose = pci_bus_to_host(dev->bus);
@@ -941,11 +941,7 @@ static struct pnv_ioda_pe *pnv_ioda_setup_dev_PE(struct pci_dev *dev)
 	if (pdn->pe_number != IODA_INVALID_PE)
 		return NULL;
 
-	/* PE#0 has been pre-set */
-	if (dev->bus->number == 0)
-		pe_num = 0;
-	else
-		pe_num = pnv_ioda_alloc_pe(phb);
+	pe_num = pnv_ioda_alloc_pe(phb);
 	if (pe_num == IODA_INVALID_PE) {
 		pr_warning("%s: Not enough PE# available, disabling device\n",
 			   pci_name(dev));
@@ -963,6 +959,7 @@ static struct pnv_ioda_pe *pnv_ioda_setup_dev_PE(struct pci_dev *dev)
 	pci_dev_get(dev);
 	pdn->pcidev = dev;
 	pdn->pe_number = pe_num;
+	pe->flags = PNV_IODA_PE_DEV;
 	pe->pdev = dev;
 	pe->pbus = NULL;
 	pe->tce32_seg = -1;
@@ -993,7 +990,6 @@ static struct pnv_ioda_pe *pnv_ioda_setup_dev_PE(struct pci_dev *dev)
 
 	return pe;
 }
-#endif /* Useful for SRIOV case */
 
 static void pnv_ioda_setup_same_PE(struct pci_bus *bus, struct pnv_ioda_pe *pe)
 {
@@ -1084,6 +1080,18 @@ static void pnv_ioda_setup_bus_PE(struct pci_bus *bus, bool all)
 	pnv_ioda_link_pe_by_weight(phb, pe);
 }
 
+static void pnv_ioda_setup_dev_PEs(struct pci_bus *bus)
+{
+	struct pci_bus *child;
+	struct pci_dev *pdev;
+
+	list_for_each_entry(pdev, &bus->devices, bus_list)
+		pnv_ioda_setup_dev_PE(pdev);
+
+	list_for_each_entry(child, &bus->children, node)
+		pnv_ioda_setup_dev_PEs(child);
+}
+
 static void pnv_ioda_setup_PEs(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
@@ -1120,7 +1128,15 @@ static void pnv_pci_ioda_setup_PEs(void)
 		if (phb->reserve_m64_pe)
 			phb->reserve_m64_pe(hose->bus, NULL, true);
 
-		pnv_ioda_setup_PEs(hose->bus);
+		/*
+		 * On NPU PHB, we expect separate PEs for individual PCI
+		 * functions. PCI bus dependent PEs are required for the
+		 * remaining types of PHBs.
+		 */
+		if (phb->type == PNV_PHB_NPU)
+			pnv_ioda_setup_dev_PEs(hose->bus);
+		else
+			pnv_ioda_setup_PEs(hose->bus);
 	}
 }
 
@@ -1579,6 +1595,8 @@ static int pnv_pci_ioda_dma_set_mask(struct pci_dev *pdev, u64 dma_mask)
 	struct pnv_ioda_pe *pe;
 	uint64_t top;
 	bool bypass = false;
+	struct pci_dev *linked_npu_dev;
+	int i;
 
 	if (WARN_ON(!pdn || pdn->pe_number == IODA_INVALID_PE))
 		return -ENODEV;;
@@ -1597,6 +1615,12 @@ static int pnv_pci_ioda_dma_set_mask(struct pci_dev *pdev, u64 dma_mask)
 		set_dma_ops(&pdev->dev, &dma_iommu_ops);
 	}
 	*pdev->dev.dma_mask = dma_mask;
+
+	/* Update all associated npu devices */
+	for (i = 0; (linked_npu_dev = pnv_get_pci_nvl_dev(pdev, i)); i++)
+		if (dma_get_mask(&linked_npu_dev->dev) != dma_mask)
+			dma_set_mask(&linked_npu_dev->dev, dma_mask);
+
 	return 0;
 }
 
@@ -2437,10 +2461,16 @@ static void pnv_ioda_setup_dma(struct pnv_phb *phb)
 			pe_info(pe, "DMA weight %d, assigned %d DMA32 segments\n",
 				pe->dma_weight, segs);
 			pnv_pci_ioda_setup_dma_pe(phb, pe, base, segs);
-		} else {
+		} else if (phb->type == PNV_PHB_IODA2) {
 			pe_info(pe, "Assign DMA32 space\n");
 			segs = 0;
 			pnv_pci_ioda2_setup_dma_pe(phb, pe);
+		} else if (phb->type == PNV_PHB_NPU) {
+			/* We initialise the DMA space for an NPU PHB
+			 * after setup of the PHB is complete as we
+			 * point the NPU TVT to the the same location
+			 * as the PHB3 TVT.
+			 */
 		}
 
 		remaining -= segs;
@@ -2882,6 +2912,11 @@ static void pnv_pci_ioda_setup_seg(void)
 
 	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
 		phb = hose->private_data;
+
+		/* NPU PHB does not support IO or MMIO segmentation */
+		if (phb->type == PNV_PHB_NPU)
+			continue;
+
 		list_for_each_entry(pe, &phb->ioda.pe_list, list) {
 			pnv_ioda_setup_pe_seg(hose, pe);
 		}
@@ -2921,6 +2956,26 @@ static void pnv_pci_ioda_create_dbgfs(void)
 #endif /* CONFIG_DEBUG_FS */
 }
 
+static void pnv_npu_ioda_fixup(void)
+{
+	bool enable_bypass;
+	struct pci_controller *hose, *tmp;
+	struct pnv_phb *phb;
+	struct pnv_ioda_pe *pe;
+
+	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
+		phb = hose->private_data;
+		if (phb->type != PNV_PHB_NPU)
+			continue;
+
+		list_for_each_entry(pe, &phb->ioda.pe_dma_list, dma_link) {
+			enable_bypass = dma_get_mask(&pe->pdev->dev) ==
+				DMA_BIT_MASK(64);
+			pnv_pci_npu_dma_set_bypass(phb, pe, enable_bypass);
+		}
+	}
+}
+
 static void pnv_pci_ioda_fixup(void)
 {
 	pnv_pci_ioda_setup_PEs();
@@ -2933,6 +2988,9 @@ static void pnv_pci_ioda_fixup(void)
 	eeh_init();
 	eeh_addr_cache_build();
 #endif
+
+	/* Link NPU IODA tables to their PCI devices. */
+	pnv_npu_ioda_fixup();
 }
 
 /*
@@ -3047,6 +3105,19 @@ static const struct pci_controller_ops pnv_pci_ioda_controller_ops = {
        .shutdown = pnv_pci_ioda_shutdown,
 };
 
+static const struct pci_controller_ops pnv_npu_ioda_controller_ops = {
+	.dma_dev_setup = pnv_pci_dma_dev_setup,
+#ifdef CONFIG_PCI_MSI
+	.setup_msi_irqs = pnv_setup_msi_irqs,
+	.teardown_msi_irqs = pnv_teardown_msi_irqs,
+#endif
+	.enable_device_hook = pnv_pci_enable_device_hook,
+	.window_alignment = pnv_pci_window_alignment,
+	.reset_secondary_bus = pnv_pci_reset_secondary_bus,
+	.dma_set_mask = pnv_npu_dma_set_mask,
+	.shutdown = pnv_pci_ioda_shutdown,
+};
+
 static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 					 u64 hub_id, int ioda_type)
 {
@@ -3102,6 +3173,8 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 		phb->model = PNV_PHB_MODEL_P7IOC;
 	else if (of_device_is_compatible(np, "ibm,power8-pciex"))
 		phb->model = PNV_PHB_MODEL_PHB3;
+	else if (of_device_is_compatible(np, "ibm,power8-npu-pciex"))
+		phb->model = PNV_PHB_MODEL_NPU;
 	else
 		phb->model = PNV_PHB_MODEL_UNKNOWN;
 
@@ -3202,7 +3275,11 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	 * the child P2P bridges) can form individual PE.
 	 */
 	ppc_md.pcibios_fixup = pnv_pci_ioda_fixup;
-	hose->controller_ops = pnv_pci_ioda_controller_ops;
+
+	if (phb->type == PNV_PHB_NPU)
+		hose->controller_ops = pnv_npu_ioda_controller_ops;
+	else
+		hose->controller_ops = pnv_pci_ioda_controller_ops;
 
 #ifdef CONFIG_PCI_IOV
 	ppc_md.pcibios_fixup_sriov = pnv_pci_ioda_fixup_iov_resources;
@@ -3237,6 +3314,11 @@ void __init pnv_pci_init_ioda2_phb(struct device_node *np)
 	pnv_pci_init_ioda_phb(np, 0, PNV_PHB_IODA2);
 }
 
+void __init pnv_pci_init_npu_phb(struct device_node *np)
+{
+	pnv_pci_init_ioda_phb(np, 0, PNV_PHB_NPU);
+}
+
 void __init pnv_pci_init_ioda_hub(struct device_node *np)
 {
 	struct device_node *phbn;
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index f2dd772..ff4e42d 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -807,6 +807,10 @@ void __init pnv_pci_init(void)
 	for_each_compatible_node(np, NULL, "ibm,ioda2-phb")
 		pnv_pci_init_ioda2_phb(np);
 
+	/* Look for NPU PHBs */
+	for_each_compatible_node(np, NULL, "ibm,ioda2-npu-phb")
+		pnv_pci_init_npu_phb(np);
+
 	/* Setup the linkage between OF nodes and PHBs */
 	pci_devs_phb_init();
 
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index c8ff50e..31e0f7e 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -7,6 +7,7 @@ enum pnv_phb_type {
 	PNV_PHB_P5IOC2	= 0,
 	PNV_PHB_IODA1	= 1,
 	PNV_PHB_IODA2	= 2,
+	PNV_PHB_NPU	= 3,
 };
 
 /* Precise PHB model for error management */
@@ -15,6 +16,7 @@ enum pnv_phb_model {
 	PNV_PHB_MODEL_P5IOC2,
 	PNV_PHB_MODEL_P7IOC,
 	PNV_PHB_MODEL_PHB3,
+	PNV_PHB_MODEL_NPU,
 };
 
 #define PNV_PCI_DIAG_BUF_SIZE	8192
@@ -229,6 +231,7 @@ extern void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
 extern void pnv_pci_init_p5ioc2_hub(struct device_node *np);
 extern void pnv_pci_init_ioda_hub(struct device_node *np);
 extern void pnv_pci_init_ioda2_phb(struct device_node *np);
+extern void pnv_pci_init_npu_phb(struct device_node *np);
 extern void pnv_pci_ioda_tce_invalidate(struct iommu_table *tbl,
 					__be64 *startp, __be64 *endp, bool rm);
 extern void pnv_pci_reset_secondary_bus(struct pci_dev *dev);
@@ -238,4 +241,11 @@ extern void pnv_pci_dma_dev_setup(struct pci_dev *pdev);
 extern int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type);
 extern void pnv_teardown_msi_irqs(struct pci_dev *pdev);
 
+/* Nvlink functions */
+extern void pnv_pci_npu_setup_dma_pe(struct pnv_phb *npu,
+				struct pnv_ioda_pe *npu_pe);
+extern int pnv_pci_npu_dma_set_bypass(struct pnv_phb *npu,
+				struct pnv_ioda_pe *npu_pe, bool enabled);
+extern int pnv_npu_dma_set_mask(struct pci_dev *pdev, u64 dma_mask);
+
 #endif /* __POWERNV_PCI_H */
-- 
2.1.4
