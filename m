Return-Path: <alistair@popple.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 097EA1A0272
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2015 13:31:25 +1100 (AEDT)
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@ozlabs.org
Cc: benh@kernel.crashing.org, gwshan@linux.vnet.ibm.com,
 Alistair Popple <alistair@popple.id.au>
Subject: [PATCH v2] platforms/powernv: Add support for Nvlink NPUs
Date: Tue, 10 Nov 2015 13:28:11 +1100
Message-Id: <1447122491-27573-1-git-send-email-alistair@popple.id.au>
In-Reply-To: <1446008402-24892-3-git-send-email-alistair@popple.id.au>
References: <1446008402-24892-3-git-send-email-alistair@popple.id.au>
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

This patch includes the following changes from v1:
 - Minor variable name updates and code refactors suggested by Gavin
 - Fixes for an issue with TCE cache invalidation

 arch/powerpc/include/asm/pci.h            |   4 +
 arch/powerpc/platforms/powernv/Makefile   |   2 +-
 arch/powerpc/platforms/powernv/npu-dma.c  | 339 ++++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/pci-ioda.c | 132 +++++++++++-
 arch/powerpc/platforms/powernv/pci.c      |   4 +
 arch/powerpc/platforms/powernv/pci.h      |  19 ++
 6 files changed, 488 insertions(+), 12 deletions(-)
 create mode 100644 arch/powerpc/platforms/powernv/npu-dma.c

diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index 3453bd8..6f8065a 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -149,4 +149,8 @@ extern void pcibios_setup_phb_io_space(struct pci_controller *hose);
 extern void pcibios_scan_phb(struct pci_controller *hose);

 #endif	/* __KERNEL__ */
+
+extern struct pci_dev *pnv_pci_get_gpu_dev(struct pci_dev *npdev);
+extern struct pci_dev *pnv_pci_get_npu_dev(struct pci_dev *gpdev, int index);
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
index 0000000..a1e5ba5
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -0,0 +1,339 @@
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
+struct pci_dev *pnv_pci_get_gpu_dev(struct pci_dev *npdev)
+{
+	struct device_node *dn;
+	struct pci_dev *gpdev;
+
+	/* Get assoicated PCI device */
+	dn = of_parse_phandle(npdev->dev.of_node, "ibm,gpu", 0);
+	if (!dn)
+		return NULL;
+
+	gpdev = get_pci_dev(dn);
+	of_node_put(dn);
+
+	return gpdev;
+}
+EXPORT_SYMBOL(pnv_pci_get_gpu_dev);
+
+/* Given the real PCI device get a linked NPU device. */
+struct pci_dev *pnv_pci_get_npu_dev(struct pci_dev *gpdev, int index)
+{
+	struct device_node *dn;
+	struct pci_dev *npdev;
+
+	/* Get assoicated PCI device */
+	dn = of_parse_phandle(gpdev->dev.of_node, "ibm,npu", index);
+	if (!dn)
+		return NULL;
+
+	npdev = get_pci_dev(dn);
+	of_node_put(dn);
+
+	return npdev;
+}
+EXPORT_SYMBOL(pnv_pci_get_npu_dev);
+
+#define NPU_DMA_OP_UNSUPPORTED()					\
+	dev_err_once(dev, "%s operation unsupported for Nvlink devices\n", \
+		__func__)
+
+static void *dma_npu_alloc(struct device *dev, size_t size,
+			   dma_addr_t *dma_handle, gfp_t flag,
+			   struct dma_attrs *attrs)
+{
+	NPU_DMA_OP_UNSUPPORTED();
+	return NULL;
+}
+
+static void dma_npu_free(struct device *dev, size_t size,
+			 void *vaddr, dma_addr_t dma_handle,
+			 struct dma_attrs *attrs)
+{
+	NPU_DMA_OP_UNSUPPORTED();
+}
+
+static dma_addr_t dma_npu_map_page(struct device *dev, struct page *page,
+				   unsigned long offset, size_t size,
+				   enum dma_data_direction direction,
+				   struct dma_attrs *attrs)
+{
+	NPU_DMA_OP_UNSUPPORTED();
+	return 0;
+}
+
+static int dma_npu_map_sg(struct device *dev, struct scatterlist *sglist,
+			  int nelems, enum dma_data_direction direction,
+			  struct dma_attrs *attrs)
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
+static struct pnv_ioda_pe *get_gpu_pci_dev_and_pe(struct pnv_ioda_pe *npe,
+						  struct pci_dev **gpdev)
+{
+	struct pnv_phb *phb;
+	struct pci_controller *hose;
+	struct pci_dev *pdev;
+	struct pnv_ioda_pe *pe;
+	struct pci_dn *pdn;
+
+	if (npe->flags & PNV_IODA_PE_PEER) {
+		pe = npe->peers[0];
+		pdev = pe->pdev;
+	} else {
+		pdev = pnv_pci_get_gpu_dev(npe->pdev);
+		if (!pdev)
+			return NULL;
+
+		pdn = pci_get_pdn(pdev);
+		if (WARN_ON(!pdn || pdn->pe_number == IODA_INVALID_PE))
+			return NULL;
+
+		hose = pci_bus_to_host(pdev->bus);
+		phb = hose->private_data;
+		pe = &phb->ioda.pe_array[pdn->pe_number];
+	}
+
+	if (gpdev)
+		*gpdev = pdev;
+
+	return pe;
+}
+
+void pnv_npu_tce_invalidate_entire(struct pnv_ioda_pe *npe)
+{
+	struct pnv_phb *phb = npe->phb;
+
+	/* We can only invalidate the whole cache on NPU */
+	unsigned long val = (0x8ull << 60);
+
+	if (phb->type != PNV_PHB_NPU ||
+	    !phb->ioda.tce_inval_reg ||
+	    !(npe->flags & PNV_IODA_PE_DEV))
+		return;
+
+	mb(); /* Ensure above stores are visible */
+	__raw_writeq(cpu_to_be64(val), phb->ioda.tce_inval_reg);
+}
+
+void pnv_npu_tce_invalidate(struct pnv_ioda_pe *npe,
+				struct iommu_table *tbl,
+				unsigned long index,
+				unsigned long npages,
+				bool rm)
+{
+	struct pnv_phb *phb = npe->phb;
+
+	/* We can only invalidate the whole cache on NPU */
+	unsigned long val = (0x8ull << 60);
+
+	if (phb->type != PNV_PHB_NPU ||
+	    !phb->ioda.tce_inval_reg ||
+	    !(npe->flags & PNV_IODA_PE_DEV))
+		return;
+
+	mb();
+	if (rm)
+		__asm__ __volatile__("stdcix %0,0,%1" : :
+				"r"(cpu_to_be64(val)),
+				"r" (phb->ioda.tce_inval_reg_phys) :
+				"memory");
+	else
+		__raw_writeq(cpu_to_be64(val),
+			phb->ioda.tce_inval_reg);
+}
+
+void pnv_npu_init_dma_pe(struct pnv_ioda_pe *npe)
+{
+	struct pnv_ioda_pe *gpe;
+	struct pci_dev *gpdev;
+	int i, avail = -1;
+
+	if (!npe->pdev || !(npe->flags & PNV_IODA_PE_DEV))
+		return;
+
+	gpe = get_gpu_pci_dev_and_pe(npe, &gpdev);
+	if (!gpe)
+		return;
+
+	/* Nothing to do if the PEs are already connected */
+	for (i = 0; i < PNV_IODA_MAX_PEER_PES; i++) {
+		if (avail < 0 && !gpe->peers[i])
+			avail = i;
+
+		if (gpe->peers[i] == npe)
+			return;
+	}
+
+	if (WARN_ON(avail < 0))
+		return;
+
+	gpe->peers[avail] = npe;
+	gpe->flags |= PNV_IODA_PE_PEER;
+
+	/* We assume that the NPU devices only have a single peer PE
+	 * (the GPU PCIe device PE). */
+	npe->peers[0] = gpe;
+	npe->flags |= PNV_IODA_PE_PEER;
+}
+
+/* For the NPU we want to point the TCE table at the same table as the
+ * real PCI device.
+ */
+static void pnv_npu_disable_bypass(struct pnv_ioda_pe *npe)
+{
+	struct pnv_phb *phb = npe->phb;
+	struct pci_dev *gpdev;
+	struct pnv_ioda_pe *gpe;
+	void *addr;
+	unsigned int size;
+	int64_t rc;
+
+	/* Find the assoicated PCI devices and get the dma window
+	 * information from there.
+	 */
+	if (!npe->pdev || !(npe->flags & PNV_IODA_PE_DEV))
+		return;
+
+	gpe = get_gpu_pci_dev_and_pe(npe, &gpdev);
+	if (!gpe)
+		return;
+
+	addr = (void *)gpe->table_group.tables[0]->it_base;
+	size = gpe->table_group.tables[0]->it_size << 3;
+	rc = opal_pci_map_pe_dma_window(phb->opal_id, npe->pe_number,
+					npe->pe_number, 1, __pa(addr),
+					size, 0x1000);
+	if (rc != OPAL_SUCCESS)
+		pr_warn("%s: Error %lld setting DMA window on PHB#%d-PE#%d\n",
+			__func__, rc, phb->hose->global_number, npe->pe_number);
+
+	/* We don't initialise npu_pe->tce32_table as we always use
+	 * dma_npu_ops which are nops.
+	 */
+	set_dma_ops(&npe->pdev->dev, &dma_npu_ops);
+}
+
+/* Enable/disable bypass mode on the NPU. The NPU only supports one
+ * window per brick, so bypass needs to be explicity enabled or
+ * disabled. Unlike for a PHB3 bypass and non-bypass modes can't be
+ * active at the same time.
+ */
+int pnv_npu_dma_set_bypass(struct pnv_ioda_pe *npe, bool enabled)
+{
+	struct pnv_phb *phb = npe->phb;
+	int64_t rc = 0;
+
+	if (phb->type != PNV_PHB_NPU || !npe->pdev)
+		return -EINVAL;
+
+	if (enabled) {
+		/* Enable the bypass window */
+		phys_addr_t top = memblock_end_of_DRAM();
+
+		npe->tce_bypass_base = 0;
+		top = roundup_pow_of_two(top);
+		dev_info(&npe->pdev->dev, "Enabling bypass for PE %d\n",
+			 npe->pe_number);
+		rc = opal_pci_map_pe_dma_window_real(phb->opal_id,
+					npe->pe_number, npe->pe_number,
+					npe->tce_bypass_base, top);
+	} else {
+		/* Disable the bypass window by replacing it with the
+		 * TCE32 window.
+		 */
+		pnv_npu_disable_bypass(npe);
+	}
+
+	return rc;
+}
+
+int pnv_npu_dma_set_mask(struct pci_dev *npdev, u64 dma_mask)
+{
+	struct pci_controller *hose = pci_bus_to_host(npdev->bus);
+	struct pnv_phb *phb = hose->private_data;
+	struct pci_dn *pdn = pci_get_pdn(npdev);
+	struct pnv_ioda_pe *npe, *gpe;
+	struct pci_dev *gpdev;
+	uint64_t top;
+	bool bypass = false;
+
+	if (WARN_ON(!pdn || pdn->pe_number == IODA_INVALID_PE))
+		return -ENXIO;
+
+	/* We only do bypass if it's enabled on the linked device */
+	npe = &phb->ioda.pe_array[pdn->pe_number];
+	gpe = get_gpu_pci_dev_and_pe(npe, &gpdev);
+	if (!gpe)
+		return -ENODEV;
+
+	if (gpe->tce_bypass_enabled) {
+		top = gpe->tce_bypass_base + memblock_end_of_DRAM() - 1;
+		bypass = (dma_mask >= top);
+	}
+
+	if (bypass)
+		dev_info(&npdev->dev, "Using 64-bit DMA iommu bypass\n");
+	else
+		dev_info(&npdev->dev, "Using 32-bit DMA via iommu\n");
+
+	pnv_npu_dma_set_bypass(npe, bypass);
+	*npdev->dev.dma_mask = dma_mask;
+
+	return 0;
+}
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 42b4bb2..8bed20d 100644
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
@@ -1597,6 +1615,15 @@ static int pnv_pci_ioda_dma_set_mask(struct pci_dev *pdev, u64 dma_mask)
 		set_dma_ops(&pdev->dev, &dma_iommu_ops);
 	}
 	*pdev->dev.dma_mask = dma_mask;
+
+	/* Update peer npu devices */
+	if (pe->flags & PNV_IODA_PE_PEER)
+		for (i = 0; pe->peers[i]; i++) {
+			linked_npu_dev = pe->peers[i]->pdev;
+			if (dma_get_mask(&linked_npu_dev->dev) != dma_mask)
+				dma_set_mask(&linked_npu_dev->dev, dma_mask);
+		}
+
 	return 0;
 }

@@ -1741,12 +1768,23 @@ static inline void pnv_pci_ioda2_tce_invalidate_entire(struct pnv_ioda_pe *pe)
 	/* 01xb - invalidate TCEs that match the specified PE# */
 	unsigned long val = (0x4ull << 60) | (pe->pe_number & 0xFF);
 	struct pnv_phb *phb = pe->phb;
+	struct pnv_ioda_pe *npe;
+	int i;

 	if (!phb->ioda.tce_inval_reg)
 		return;

 	mb(); /* Ensure above stores are visible */
 	__raw_writeq(cpu_to_be64(val), phb->ioda.tce_inval_reg);
+
+	if (pe->flags & PNV_IODA_PE_PEER)
+		for (i = 0; i < PNV_IODA_MAX_PEER_PES; i++) {
+			npe = pe->peers[i];
+			if (!npe || npe->phb->type != PNV_PHB_NPU)
+				continue;
+
+			pnv_npu_tce_invalidate_entire(npe);
+		}
 }

 static void pnv_pci_ioda2_do_tce_invalidate(unsigned pe_number, bool rm,
@@ -1781,15 +1819,28 @@ static void pnv_pci_ioda2_tce_invalidate(struct iommu_table *tbl,
 	struct iommu_table_group_link *tgl;

 	list_for_each_entry_rcu(tgl, &tbl->it_group_list, next) {
+		struct pnv_ioda_pe *npe;
 		struct pnv_ioda_pe *pe = container_of(tgl->table_group,
 				struct pnv_ioda_pe, table_group);
 		__be64 __iomem *invalidate = rm ?
 			(__be64 __iomem *)pe->phb->ioda.tce_inval_reg_phys :
 			pe->phb->ioda.tce_inval_reg;
+		int i;

 		pnv_pci_ioda2_do_tce_invalidate(pe->pe_number, rm,
 			invalidate, tbl->it_page_shift,
 			index, npages);
+
+		if (pe->flags & PNV_IODA_PE_PEER)
+			/* Invalidate PEs using the same TCE table */
+			for (i = 0; i < PNV_IODA_MAX_PEER_PES; i++) {
+				npe = pe->peers[i];
+				if (!npe || npe->phb->type != PNV_PHB_NPU)
+					continue;
+
+				pnv_npu_tce_invalidate(npe, tbl, index,
+							npages, rm);
+			}
 	}
 }

@@ -2437,10 +2488,16 @@ static void pnv_ioda_setup_dma(struct pnv_phb *phb)
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
@@ -2882,6 +2939,11 @@ static void pnv_pci_ioda_setup_seg(void)

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
@@ -2921,6 +2983,27 @@ static void pnv_pci_ioda_create_dbgfs(void)
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
+			pnv_npu_init_dma_pe(pe);
+			pnv_npu_dma_set_bypass(pe, enable_bypass);
+		}
+	}
+}
+
 static void pnv_pci_ioda_fixup(void)
 {
 	pnv_pci_ioda_setup_PEs();
@@ -2933,6 +3016,9 @@ static void pnv_pci_ioda_fixup(void)
 	eeh_init();
 	eeh_addr_cache_build();
 #endif
+
+	/* Link NPU IODA tables to their PCI devices. */
+	pnv_npu_ioda_fixup();
 }

 /*
@@ -3047,6 +3133,19 @@ static const struct pci_controller_ops pnv_pci_ioda_controller_ops = {
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
@@ -3102,6 +3201,8 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 		phb->model = PNV_PHB_MODEL_P7IOC;
 	else if (of_device_is_compatible(np, "ibm,power8-pciex"))
 		phb->model = PNV_PHB_MODEL_PHB3;
+	else if (of_device_is_compatible(np, "ibm,power8-npu-pciex"))
+		phb->model = PNV_PHB_MODEL_NPU;
 	else
 		phb->model = PNV_PHB_MODEL_UNKNOWN;

@@ -3202,7 +3303,11 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
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
@@ -3237,6 +3342,11 @@ void __init pnv_pci_init_ioda2_phb(struct device_node *np)
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
index c8ff50e..7f56313 100644
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
@@ -24,6 +26,7 @@ enum pnv_phb_model {
 #define PNV_IODA_PE_MASTER	(1 << 3)	/* Master PE in compound case	*/
 #define PNV_IODA_PE_SLAVE	(1 << 4)	/* Slave PE in compound case	*/
 #define PNV_IODA_PE_VF		(1 << 5)	/* PE for one VF 		*/
+#define PNV_IODA_PE_PEER	(1 << 6)	/* PE has peers			*/

 /* Data associated with a PE, including IOMMU tracking etc.. */
 struct pnv_phb;
@@ -31,6 +34,9 @@ struct pnv_ioda_pe {
 	unsigned long		flags;
 	struct pnv_phb		*phb;

+#define PNV_IODA_MAX_PEER_PES	8
+	struct pnv_ioda_pe	*peers[PNV_IODA_MAX_PEER_PES];
+
 	/* A PE can be associated with a single device or an
 	 * entire bus (& children). In the former case, pdev
 	 * is populated, in the later case, pbus is.
@@ -229,6 +235,7 @@ extern void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
 extern void pnv_pci_init_p5ioc2_hub(struct device_node *np);
 extern void pnv_pci_init_ioda_hub(struct device_node *np);
 extern void pnv_pci_init_ioda2_phb(struct device_node *np);
+extern void pnv_pci_init_npu_phb(struct device_node *np);
 extern void pnv_pci_ioda_tce_invalidate(struct iommu_table *tbl,
 					__be64 *startp, __be64 *endp, bool rm);
 extern void pnv_pci_reset_secondary_bus(struct pci_dev *dev);
@@ -238,4 +245,16 @@ extern void pnv_pci_dma_dev_setup(struct pci_dev *pdev);
 extern int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type);
 extern void pnv_teardown_msi_irqs(struct pci_dev *pdev);

+/* Nvlink functions */
+extern void pnv_npu_tce_invalidate_entire(struct pnv_ioda_pe *npe);
+extern void pnv_npu_tce_invalidate(struct pnv_ioda_pe *npe,
+				       struct iommu_table *tbl,
+				       unsigned long index,
+				       unsigned long npages,
+				       bool rm);
+extern void pnv_npu_init_dma_pe(struct pnv_ioda_pe *npe);
+extern void pnv_npu_setup_dma_pe(struct pnv_ioda_pe *npe);
+extern int pnv_npu_dma_set_bypass(struct pnv_ioda_pe *npe, bool enabled);
+extern int pnv_npu_dma_set_mask(struct pci_dev *npdev, u64 dma_mask);
+
 #endif /* __POWERNV_PCI_H */
--
2.1.4
