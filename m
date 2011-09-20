Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 06ED2101133
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Sep 2011 13:46:19 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 18/20] powerpc/powernv: Add support for p5ioc2 PCI-X and PCIe
Date: Tue, 20 Sep 2011 13:45:05 +1000
Message-Id: <1316490307-28030-18-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1316490307-28030-1-git-send-email-benh@kernel.crashing.org>
References: <1316490307-28030-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds support for PCI-X and PCIe on the p5ioc2 IO hub using
OPAL. This includes allocating & setting up TCE tables and config
space access routines.

This also supports fallbacks via RTAS when OPAL is absent, using
legacy TCE format pre-allocated via the device-tree (BML style)

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/powernv/Makefile     |    2 +
 arch/powerpc/platforms/powernv/pci-p5ioc2.c |  185 +++++++++++++++++
 arch/powerpc/platforms/powernv/pci.c        |  286 +++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/pci.h        |   38 ++++
 arch/powerpc/platforms/powernv/powernv.h    |    6 +
 arch/powerpc/platforms/powernv/setup.c      |    3 +-
 6 files changed, 519 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/platforms/powernv/pci-p5ioc2.c
 create mode 100644 arch/powerpc/platforms/powernv/pci.c
 create mode 100644 arch/powerpc/platforms/powernv/pci.h

diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index 618ad83..cf9dec8 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -2,3 +2,5 @@ obj-y			+= setup.o opal-takeover.o opal-wrappers.o opal.o
 obj-y			+= opal-rtc.o opal-nvram.o
 
 obj-$(CONFIG_SMP)	+= smp.o
+obj-$(CONFIG_PCI)	+= pci.o pci-p5ioc2.o
+
diff --git a/arch/powerpc/platforms/powernv/pci-p5ioc2.c b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
new file mode 100644
index 0000000..afabc2b
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
@@ -0,0 +1,185 @@
+/*
+ * Support PCI/PCIe on PowerNV platforms
+ *
+ * Currently supports only P5IOC2
+ *
+ * Copyright 2011 Benjamin Herrenschmidt, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/string.h>
+#include <linux/init.h>
+#include <linux/bootmem.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+
+#include <asm/sections.h>
+#include <asm/io.h>
+#include <asm/prom.h>
+#include <asm/pci-bridge.h>
+#include <asm/machdep.h>
+#include <asm/ppc-pci.h>
+#include <asm/opal.h>
+#include <asm/iommu.h>
+#include <asm/tce.h>
+#include <asm/abs_addr.h>
+
+#include "powernv.h"
+#include "pci.h"
+
+/* For now, use a fixed amount of TCE memory for each p5ioc2
+ * hub, 16M will do
+ */
+#define P5IOC2_TCE_MEMORY	0x01000000
+
+static void __devinit pnv_pci_p5ioc2_dma_dev_setup(struct pnv_phb *phb,
+						   struct pci_dev *pdev)
+{
+	if (phb->p5ioc2.iommu_table.it_map == NULL)
+		iommu_init_table(&phb->p5ioc2.iommu_table, phb->hose->node);
+
+	set_iommu_table_base(&pdev->dev, &phb->p5ioc2.iommu_table);
+}
+
+static void __init pnv_pci_init_p5ioc2_phb(struct device_node *np,
+					   void *tce_mem, u64 tce_size)
+{
+	struct pnv_phb *phb;
+	const u64 *prop64;
+	u64 phb_id;
+	int64_t rc;
+	static int primary = 1;
+
+	pr_info(" Initializing p5ioc2 PHB %s\n", np->full_name);
+
+	prop64 = of_get_property(np, "ibm,opal-phbid", NULL);
+	if (!prop64) {
+		pr_err("  Missing \"ibm,opal-phbid\" property !\n");
+		return;
+	}
+	phb_id = be64_to_cpup(prop64);
+	pr_devel("  PHB-ID  : 0x%016llx\n", phb_id);
+	pr_devel("  TCE AT  : 0x%016lx\n", __pa(tce_mem));
+	pr_devel("  TCE SZ  : 0x%016llx\n", tce_size);
+
+	rc = opal_pci_set_phb_tce_memory(phb_id, __pa(tce_mem), tce_size);
+	if (rc != OPAL_SUCCESS) {
+		pr_err("  Failed to set TCE memory, OPAL error %lld\n", rc);
+		return;
+	}
+
+	phb = alloc_bootmem(sizeof(struct pnv_phb));
+	if (phb) {
+		memset(phb, 0, sizeof(struct pnv_phb));
+		phb->hose = pcibios_alloc_controller(np);
+	}
+	if (!phb || !phb->hose) {
+		pr_err("  Failed to allocate PCI controller\n");
+		return;
+	}
+
+	spin_lock_init(&phb->lock);
+	phb->hose->first_busno = 0;
+	phb->hose->last_busno = 0xff;
+	phb->hose->private_data = phb;
+	phb->opal_id = phb_id;
+	phb->type = PNV_PHB_P5IOC2;
+
+	phb->regs = of_iomap(np, 0);
+
+	if (phb->regs == NULL)
+		pr_err("  Failed to map registers !\n");
+	else {
+		pr_devel("  P_BUID     = 0x%08x\n", in_be32(phb->regs + 0x100));
+		pr_devel("  P_IOSZ     = 0x%08x\n", in_be32(phb->regs + 0x1b0));
+		pr_devel("  P_IO_ST    = 0x%08x\n", in_be32(phb->regs + 0x1e0));
+		pr_devel("  P_MEM1_H   = 0x%08x\n", in_be32(phb->regs + 0x1a0));
+		pr_devel("  P_MEM1_L   = 0x%08x\n", in_be32(phb->regs + 0x190));
+		pr_devel("  P_MSZ1_L   = 0x%08x\n", in_be32(phb->regs + 0x1c0));
+		pr_devel("  P_MEM_ST   = 0x%08x\n", in_be32(phb->regs + 0x1d0));
+		pr_devel("  P_MEM2_H   = 0x%08x\n", in_be32(phb->regs + 0x2c0));
+		pr_devel("  P_MEM2_L   = 0x%08x\n", in_be32(phb->regs + 0x2b0));
+		pr_devel("  P_MSZ2_H   = 0x%08x\n", in_be32(phb->regs + 0x2d0));
+		pr_devel("  P_MSZ2_L   = 0x%08x\n", in_be32(phb->regs + 0x2e0));
+	}
+
+	/* Interpret the "ranges" property */
+	/* This also maps the I/O region and sets isa_io/mem_base */
+	pci_process_bridge_OF_ranges(phb->hose, np, primary);
+	primary = 0;
+
+	phb->hose->ops = &pnv_pci_ops;
+
+	/* Setup TCEs */
+	phb->dma_dev_setup = pnv_pci_p5ioc2_dma_dev_setup;
+	pnv_pci_setup_iommu_table(&phb->p5ioc2.iommu_table,
+				  tce_mem, tce_size, 0);
+}
+
+void __init pnv_pci_init_p5ioc2_hub(struct device_node *np)
+{
+	struct device_node *phbn;
+	const u64 *prop64;
+	u64 hub_id;
+	void *tce_mem;
+	uint64_t tce_per_phb;
+	int64_t rc;
+	int phb_count = 0;
+
+	pr_info("Probing p5ioc2 IO-Hub %s\n", np->full_name);
+
+	prop64 = of_get_property(np, "ibm,opal-hubid", NULL);
+	if (!prop64) {
+		pr_err(" Missing \"ibm,opal-hubid\" property !\n");
+		return;
+	}
+	hub_id = be64_to_cpup(prop64);
+	pr_info(" HUB-ID : 0x%016llx\n", hub_id);
+
+	/* Currently allocate 16M of TCE memory for every Hub
+	 *
+	 * XXX TODO: Make it chip local if possible
+	 */
+	tce_mem = __alloc_bootmem(P5IOC2_TCE_MEMORY, P5IOC2_TCE_MEMORY,
+				  __pa(MAX_DMA_ADDRESS));
+	if (!tce_mem) {
+		pr_err(" Failed to allocate TCE Memory !\n");
+		return;
+	}
+	pr_debug(" TCE    : 0x%016lx..0x%016lx\n",
+		__pa(tce_mem), __pa(tce_mem) + P5IOC2_TCE_MEMORY - 1);
+	rc = opal_pci_set_hub_tce_memory(hub_id, __pa(tce_mem),
+					P5IOC2_TCE_MEMORY);
+	if (rc != OPAL_SUCCESS) {
+		pr_err(" Failed to allocate TCE memory, OPAL error %lld\n", rc);
+		return;
+	}
+
+	/* Count child PHBs */
+	for_each_child_of_node(np, phbn) {
+		if (of_device_is_compatible(phbn, "ibm,p5ioc2-pcix") ||
+		    of_device_is_compatible(phbn, "ibm,p5ioc2-pciex"))
+			phb_count++;
+	}
+
+	/* Calculate how much TCE space we can give per PHB */
+	tce_per_phb = __rounddown_pow_of_two(P5IOC2_TCE_MEMORY / phb_count);
+	pr_info(" Allocating %lld MB of TCE memory per PHB\n",
+		tce_per_phb >> 20);
+
+	/* Initialize PHBs */
+	for_each_child_of_node(np, phbn) {
+		if (of_device_is_compatible(phbn, "ibm,p5ioc2-pcix") ||
+		    of_device_is_compatible(phbn, "ibm,p5ioc2-pciex")) {
+			pnv_pci_init_p5ioc2_phb(phbn, tce_mem, tce_per_phb);
+			tce_mem += tce_per_phb;
+		}
+	}
+}
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
new file mode 100644
index 0000000..b512489
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -0,0 +1,286 @@
+/*
+ * Support PCI/PCIe on PowerNV platforms
+ *
+ * Currently supports only P5IOC2
+ *
+ * Copyright 2011 Benjamin Herrenschmidt, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/string.h>
+#include <linux/init.h>
+#include <linux/bootmem.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+
+#include <asm/sections.h>
+#include <asm/io.h>
+#include <asm/prom.h>
+#include <asm/pci-bridge.h>
+#include <asm/machdep.h>
+#include <asm/ppc-pci.h>
+#include <asm/opal.h>
+#include <asm/iommu.h>
+#include <asm/tce.h>
+#include <asm/abs_addr.h>
+
+#include "powernv.h"
+#include "pci.h"
+
+
+#define cfg_dbg(fmt...)	do { } while(0)
+//#define cfg_dbg(fmt...)	printk(fmt)
+
+
+static void pnv_pci_config_check_eeh(struct pnv_phb *phb, struct pci_bus *bus,
+				     u32 bdfn)
+{
+	s64	rc;
+	u8	fstate;
+	u16	pcierr;
+	u32	pe_no;
+
+	/* Get PE# if we support IODA */
+	pe_no = phb->bdfn_to_pe ? phb->bdfn_to_pe(phb, bus, bdfn & 0xff) : 0;
+
+	/* Read freeze status */
+	rc = opal_pci_eeh_freeze_status(phb->opal_id, pe_no, &fstate, &pcierr, 
+					NULL);
+	if (rc) {
+		pr_warning("PCI %d: Failed to read EEH status for PE#%d,"
+			   " err %lld\n", phb->hose->global_number, pe_no, rc);
+		return;
+	}
+	cfg_dbg(" -> EEH check, bdfn=%04x PE%d fstate=%x\n",
+		bdfn, pe_no, fstate);
+	if (fstate != 0) {		
+		rc = opal_pci_eeh_freeze_clear(phb->opal_id, pe_no,
+					      OPAL_EEH_ACTION_CLEAR_FREEZE_ALL);
+		if (rc) {
+			pr_warning("PCI %d: Failed to clear EEH freeze state"
+				   " for PE#%d, err %lld\n",
+				   phb->hose->global_number, pe_no, rc);
+		}
+	}
+}
+
+static int pnv_pci_read_config(struct pci_bus *bus,
+			       unsigned int devfn,
+			       int where, int size, u32 *val)
+{
+	struct pci_controller *hose = pci_bus_to_host(bus);
+	struct pnv_phb *phb = hose->private_data;
+	u32 bdfn = (((uint64_t)bus->number) << 8) | devfn;
+	s64 rc;
+
+	if (hose == NULL)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	switch (size) {
+	case 1: {
+		u8 v8;
+		rc = opal_pci_config_read_byte(phb->opal_id, bdfn, where, &v8);
+		*val = (rc == OPAL_SUCCESS) ? v8 : 0xff;
+		break;
+	}
+	case 2: {
+		u16 v16;
+		rc = opal_pci_config_read_half_word(phb->opal_id, bdfn, where,
+						   &v16);
+		*val = (rc == OPAL_SUCCESS) ? v16 : 0xffff;
+		break;
+	}
+	case 4: {
+		u32 v32;
+		rc = opal_pci_config_read_word(phb->opal_id, bdfn, where, &v32);
+		*val = (rc == OPAL_SUCCESS) ? v32 : 0xffffffff;
+		break;
+	}
+	default:
+		return PCIBIOS_FUNC_NOT_SUPPORTED;
+	}
+	cfg_dbg("pnv_pci_read_config bus: %x devfn: %x +%x/%x -> %08x\n",
+		bus->number, devfn, where, size, *val);
+
+	/* Check if the PHB got frozen due to an error (no response) */
+	pnv_pci_config_check_eeh(phb, bus, bdfn);
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int pnv_pci_write_config(struct pci_bus *bus,
+				unsigned int devfn,
+				int where, int size, u32 val)
+{
+	struct pci_controller *hose = pci_bus_to_host(bus);
+	struct pnv_phb *phb = hose->private_data;
+	u32 bdfn = (((uint64_t)bus->number) << 8) | devfn;
+
+	if (hose == NULL)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	cfg_dbg("pnv_pci_write_config bus: %x devfn: %x +%x/%x -> %08x\n",
+		bus->number, devfn, where, size, val);
+	switch (size) {
+	case 1:
+		opal_pci_config_write_byte(phb->opal_id, bdfn, where, val);
+		break;
+	case 2:
+		opal_pci_config_write_half_word(phb->opal_id, bdfn, where, val);
+		break;
+	case 4:
+		opal_pci_config_write_word(phb->opal_id, bdfn, where, val);
+		break;
+	default:
+		return PCIBIOS_FUNC_NOT_SUPPORTED;
+	}
+	/* Check if the PHB got frozen due to an error (no response) */
+	pnv_pci_config_check_eeh(phb, bus, bdfn);
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+struct pci_ops pnv_pci_ops = {
+	.read = pnv_pci_read_config,
+	.write = pnv_pci_write_config,
+};
+
+static int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
+			 unsigned long uaddr, enum dma_data_direction direction,
+			 struct dma_attrs *attrs)
+{
+	u64 proto_tce;
+	u64 *tcep;
+	u64 rpn;
+
+	proto_tce = TCE_PCI_READ; // Read allowed
+
+	if (direction != DMA_TO_DEVICE)
+		proto_tce |= TCE_PCI_WRITE;
+
+	tcep = ((u64 *)tbl->it_base) + index;
+
+	while (npages--) {
+		/* can't move this out since we might cross LMB boundary */
+		rpn = (virt_to_abs(uaddr)) >> TCE_SHIFT;
+		*tcep = proto_tce | (rpn & TCE_RPN_MASK) << TCE_RPN_SHIFT;
+
+		uaddr += TCE_PAGE_SIZE;
+		tcep++;
+	}
+	return 0;
+}
+
+static void pnv_tce_free(struct iommu_table *tbl, long index, long npages)
+{
+	u64 *tcep = ((u64 *)tbl->it_base) + index;
+
+	while (npages--)
+		*(tcep++) = 0;
+}
+
+void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
+			       void *tce_mem, u64 tce_size,
+			       u64 dma_offset)
+{
+	tbl->it_blocksize = 16;
+	tbl->it_base = (unsigned long)tce_mem;
+	tbl->it_offset = dma_offset >> IOMMU_PAGE_SHIFT;
+	tbl->it_index = 0;
+	tbl->it_size = tce_size >> 3;
+	tbl->it_busno = 0;
+	tbl->it_type = TCE_PCI;
+}
+
+static struct iommu_table * __devinit
+pnv_pci_setup_bml_iommu(struct pci_controller *hose)
+{
+	struct iommu_table *tbl;
+	const __be64 *basep;
+	const __be32 *sizep;
+
+	basep = of_get_property(hose->dn, "linux,tce-base", NULL);
+	sizep = of_get_property(hose->dn, "linux,tce-size", NULL);
+	if (basep == NULL || sizep == NULL) {
+		pr_err("PCI: %s has missing tce entries !\n", hose->dn->full_name);
+		return NULL;
+	}
+	tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL, hose->node);
+	if (WARN_ON(!tbl))
+		return NULL;
+	pnv_pci_setup_iommu_table(tbl, __va(be64_to_cpup(basep)),
+				  be32_to_cpup(sizep), 0);
+	iommu_init_table(tbl, hose->node);
+	return tbl;
+}
+
+static void __devinit pnv_pci_dma_fallback_setup(struct pci_controller *hose,
+						 struct pci_dev *pdev)
+{
+	struct device_node *np = pci_bus_to_OF_node(hose->bus);
+	struct pci_dn *pdn;
+
+	if (np == NULL)
+		return;
+	pdn = PCI_DN(np);
+	if (!pdn->iommu_table)
+		pdn->iommu_table = pnv_pci_setup_bml_iommu(hose);
+	if (!pdn->iommu_table)
+		return;
+	set_iommu_table_base(&pdev->dev, pdn->iommu_table);
+}
+
+static void __devinit pnv_pci_dma_dev_setup(struct pci_dev *pdev)
+{
+	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
+	struct pnv_phb *phb = hose->private_data;
+
+	/* If we have no phb structure, try to setup a fallback based on
+	 * the device-tree (RTAS PCI for example)
+	 */
+	if (phb && phb->dma_dev_setup)
+		phb->dma_dev_setup(phb, pdev);
+	else
+		pnv_pci_dma_fallback_setup(hose, pdev);
+}
+
+void __init pnv_pci_init(void)
+{
+	struct device_node *np;
+
+	pci_set_flags(PCI_CAN_SKIP_ISA_ALIGN);
+
+	/* We do not want to just probe */
+	pci_probe_only = 0;
+
+	/* OPAL absent, try POPAL first then RTAS detection of PHBs */
+	if (!firmware_has_feature(FW_FEATURE_OPAL)) {
+#ifdef CONFIG_PPC_POWERNV_RTAS
+		init_pci_config_tokens();
+		find_and_init_phbs();
+#endif /* CONFIG_PPC_POWERNV_RTAS */
+	} else {
+		/* OPAL is here, do our normal stuff */
+
+		/* Look for p5ioc2 IO-Hubs */
+		for_each_compatible_node(np, NULL, "ibm,p5ioc2")
+			pnv_pci_init_p5ioc2_hub(np);
+	}
+
+	/* Setup the linkage between OF nodes and PHBs */
+	pci_devs_phb_init();
+
+	/* Configure IOMMU DMA hooks */
+	ppc_md.pci_dma_dev_setup = pnv_pci_dma_dev_setup;
+	ppc_md.tce_build = pnv_tce_build;
+	ppc_md.tce_free = pnv_tce_free;
+	set_pci_dma_ops(&dma_iommu_ops);
+
+}
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
new file mode 100644
index 0000000..b8be721
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -0,0 +1,38 @@
+#ifndef __POWERNV_PCI_H
+#define __POWERNV_PCI_H
+
+struct pci_dn;
+
+enum pnv_phb_type {
+	PNV_PHB_P5IOC2,
+	PNV_PHB_IODA1,
+	PNV_PHB_IODA2,
+};
+
+struct pnv_phb {
+	struct pci_controller	*hose;
+	enum pnv_phb_type	type;
+	u64			opal_id;
+	void __iomem		*regs;
+	spinlock_t		lock;
+
+	void (*dma_dev_setup)(struct pnv_phb *phb, struct pci_dev *pdev);
+	void (*fixup_phb)(struct pci_controller *hose);
+	u32 (*bdfn_to_pe)(struct pnv_phb *phb, struct pci_bus *bus, u32 devfn);
+	
+	union {
+		struct {
+			struct iommu_table iommu_table;
+		} p5ioc2;
+	};
+};
+
+extern struct pci_ops pnv_pci_ops;
+
+extern void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
+				      void *tce_mem, u64 tce_size,
+				      u64 dma_offset);
+extern void pnv_pci_init_p5ioc2_hub(struct device_node *np);
+
+
+#endif /* __POWERNV_PCI_H */
diff --git a/arch/powerpc/platforms/powernv/powernv.h b/arch/powerpc/platforms/powernv/powernv.h
index 35b7160..8a9df7f 100644
--- a/arch/powerpc/platforms/powernv/powernv.h
+++ b/arch/powerpc/platforms/powernv/powernv.h
@@ -7,4 +7,10 @@ extern void pnv_smp_init(void);
 static inline void pnv_smp_init(void) { }
 #endif
 
+#ifdef CONFIG_PCI
+extern void pnv_pci_init(void);
+#else
+static inline void pnv_pci_init(void) { }
+#endif
+
 #endif /* _POWERNV_H */
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index f0242f3..467bd4a 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -40,7 +40,8 @@ static void __init pnv_setup_arch(void)
 	/* Initialize SMP */
 	pnv_smp_init();
 
-	/* XXX PCI */
+	/* Setup PCI */
+	pnv_pci_init();
 
 	/* Setup RTC and NVRAM callbacks */
 	if (firmware_has_feature(FW_FEATURE_OPAL))
-- 
1.7.4.1
