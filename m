Return-Path: <B31939@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0187.outbound.messaging.microsoft.com [213.199.154.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0DEEF2C009E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 22:23:51 +1000 (EST)
Received: from mail32-db8 (localhost [127.0.0.1])	by mail32-db8-R.bigfish.com
 (Postfix) with ESMTP id EE8BA6C0211	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,
 19 Aug 2013 12:23:45 +0000 (UTC)
Received: from DB8EHSMHS027.bigfish.com (unknown [10.174.8.247])	by
 mail32-db8.bigfish.com (Postfix) with ESMTP id D2CDF58023C	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 12:22:33 +0000 (UTC)
From: Minghuan Lian <Minghuan.Lian@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH][RFC] pci: fsl: rework PCIe driver compatible with Layerscape
Date: Mon, 19 Aug 2013 20:23:31 +0800
Message-ID: <1376915011-31467-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>,
 Minghuan Lian <Minghuan.Lian@freescale.com>,
 Zang Roy-R61911 <r61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Freescale's Layerscape series processors will use ARM cores.
The LS1's PCIe controllers is the same as T4240's. So it's better
the PCIe controller driver can support PowerPC and ARM
simultaneously. This patch is for this purpose. It derives
the common functions from arch/powerpc/sysdev/fsl_pci.c to
drivers/pci/host/pcie-fsl.c and leaves several platform-dependent
functions which should be implemented in platform files.

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
Based on upstream master 3.11-rc6
The function has been tested  on P5020DS and P3041DS and T4240QDS boards 
For mpc83xx and mpc86xx, I only did compile test.

 arch/powerpc/Kconfig          |   1 +
 arch/powerpc/sysdev/fsl_pci.c | 591 ++++++----------------------------
 arch/powerpc/sysdev/fsl_pci.h |  91 ------
 drivers/edac/mpc85xx_edac.c   |  10 -
 drivers/pci/host/Kconfig      |   4 +
 drivers/pci/host/Makefile     |   1 +
 drivers/pci/host/pcie-fsl.c   | 734 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/fsl/fsl-pcie.h  | 176 ++++++++++
 8 files changed, 1008 insertions(+), 600 deletions(-)
 create mode 100644 drivers/pci/host/pcie-fsl.c
 create mode 100644 include/linux/fsl/fsl-pcie.h

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index dbd9d3c..66b51a8 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -671,6 +671,7 @@ config FSL_SOC
 
 config FSL_PCI
  	bool
+	select PCIE_FSL if FSL_SOC_BOOKE || PPC_86xx
 	select PPC_INDIRECT_PCI
 	select PCI_QUIRKS
 
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 46ac1dd..a05a9e1 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -1,7 +1,7 @@
 /*
  * MPC83xx/85xx/86xx PCI/PCIE support routing.
  *
- * Copyright 2007-2012 Freescale Semiconductor, Inc.
+ * Copyright 2007-2013 Freescale Semiconductor, Inc.
  * Copyright 2008-2009 MontaVista Software, Inc.
  *
  * Initial author: Xianghua Xiao <x.xiao@freescale.com>
@@ -26,6 +26,7 @@
 #include <linux/memblock.h>
 #include <linux/log2.h>
 #include <linux/slab.h>
+#include <linux/fsl/fsl-pcie.h>
 
 #include <asm/io.h>
 #include <asm/prom.h>
@@ -54,60 +55,17 @@ static void quirk_fsl_pcie_header(struct pci_dev *dev)
 	return;
 }
 
-static int fsl_indirect_read_config(struct pci_bus *, unsigned int,
-				    int, int, u32 *);
-
-static int fsl_pcie_check_link(struct pci_controller *hose)
-{
-	u32 val = 0;
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID, quirk_fsl_pcie_header);
 
-	if (hose->indirect_type & PPC_INDIRECT_TYPE_FSL_CFG_REG_LINK) {
-		if (hose->ops->read == fsl_indirect_read_config) {
-			struct pci_bus bus;
-			bus.number = 0;
-			bus.sysdata = hose;
-			bus.ops = hose->ops;
-			indirect_read_config(&bus, 0, PCIE_LTSSM, 4, &val);
-		} else
-			early_read_config_dword(hose, 0, 0, PCIE_LTSSM, &val);
-		if (val < PCIE_LTSSM_L0)
-			return 1;
-	} else {
-		struct ccsr_pci __iomem *pci = hose->private_data;
-		/* for PCIe IP rev 3.0 or greater use CSR0 for link state */
-		val = (in_be32(&pci->pex_csr0) & PEX_CSR0_LTSSM_MASK)
-				>> PEX_CSR0_LTSSM_SHIFT;
-		if (val != PEX_CSR0_LTSSM_L0)
-			return 1;
-	}
+#if defined(CONFIG_FSL_SOC_BOOKE) || defined(CONFIG_PPC_86xx)
 
-	return 0;
-}
+#define MAX_PHYS_ADDR_BITS	40
 
-static int fsl_indirect_read_config(struct pci_bus *bus, unsigned int devfn,
-				    int offset, int len, u32 *val)
+u64 fsl_pci64_dma_offset(void)
 {
-	struct pci_controller *hose = pci_bus_to_host(bus);
-
-	if (fsl_pcie_check_link(hose))
-		hose->indirect_type |= PPC_INDIRECT_TYPE_NO_PCIE_LINK;
-	else
-		hose->indirect_type &= ~PPC_INDIRECT_TYPE_NO_PCIE_LINK;
-
-	return indirect_read_config(bus, devfn, offset, len, val);
+	return 1ull << MAX_PHYS_ADDR_BITS;
 }
 
-#if defined(CONFIG_FSL_SOC_BOOKE) || defined(CONFIG_PPC_86xx)
-
-static struct pci_ops fsl_indirect_pcie_ops =
-{
-	.read = fsl_indirect_read_config,
-	.write = indirect_write_config,
-};
-
-#define MAX_PHYS_ADDR_BITS	40
-static u64 pci64_dma_offset = 1ull << MAX_PHYS_ADDR_BITS;
-
 static int fsl_pci_dma_set_mask(struct device *dev, u64 dma_mask)
 {
 	if (!dev->dma_mask || !dma_supported(dev, dma_mask))
@@ -121,300 +79,36 @@ static int fsl_pci_dma_set_mask(struct device *dev, u64 dma_mask)
 	if ((dev->bus == &pci_bus_type) &&
 	    dma_mask >= DMA_BIT_MASK(MAX_PHYS_ADDR_BITS)) {
 		set_dma_ops(dev, &dma_direct_ops);
-		set_dma_offset(dev, pci64_dma_offset);
+		set_dma_offset(dev, fsl_pci64_dma_offset());
 	}
 
 	*dev->dma_mask = dma_mask;
 	return 0;
 }
 
-static int setup_one_atmu(struct ccsr_pci __iomem *pci,
-	unsigned int index, const struct resource *res,
-	resource_size_t offset)
+struct fsl_pcie *fsl_sys_to_pcie(void *hose)
 {
-	resource_size_t pci_addr = res->start - offset;
-	resource_size_t phys_addr = res->start;
-	resource_size_t size = resource_size(res);
-	u32 flags = 0x80044000; /* enable & mem R/W */
-	unsigned int i;
-
-	pr_debug("PCI MEM resource start 0x%016llx, size 0x%016llx.\n",
-		(u64)res->start, (u64)size);
-
-	if (res->flags & IORESOURCE_PREFETCH)
-		flags |= 0x10000000; /* enable relaxed ordering */
-
-	for (i = 0; size > 0; i++) {
-		unsigned int bits = min(ilog2(size),
-					__ffs(pci_addr | phys_addr));
-
-		if (index + i >= 5)
-			return -1;
-
-		out_be32(&pci->pow[index + i].potar, pci_addr >> 12);
-		out_be32(&pci->pow[index + i].potear, (u64)pci_addr >> 44);
-		out_be32(&pci->pow[index + i].powbar, phys_addr >> 12);
-		out_be32(&pci->pow[index + i].powar, flags | (bits - 1));
-
-		pci_addr += (resource_size_t)1U << bits;
-		phys_addr += (resource_size_t)1U << bits;
-		size -= (resource_size_t)1U << bits;
-	}
-
-	return i;
+	return ((struct pci_controller *)hose)->private_data;
 }
 
-/* atmu setup for fsl pci/pcie controller */
-static void setup_pci_atmu(struct pci_controller *hose)
+struct pci_bus *fsl_fake_pci_bus(struct fsl_pcie *pcie, int busnr)
 {
-	struct ccsr_pci __iomem *pci = hose->private_data;
-	int i, j, n, mem_log, win_idx = 3, start_idx = 1, end_idx = 4;
-	u64 mem, sz, paddr_hi = 0;
-	u64 offset = 0, paddr_lo = ULLONG_MAX;
-	u32 pcicsrbar = 0, pcicsrbar_sz;
-	u32 piwar = PIWAR_EN | PIWAR_PF | PIWAR_TGI_LOCAL |
-			PIWAR_READ_SNOOP | PIWAR_WRITE_SNOOP;
-	const char *name = hose->dn->full_name;
-	const u64 *reg;
-	int len;
-
-	if (early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) {
-		if (in_be32(&pci->block_rev1) >= PCIE_IP_REV_2_2) {
-			win_idx = 2;
-			start_idx = 0;
-			end_idx = 3;
-		}
-	}
+	static struct pci_bus bus;
+	static struct pci_controller hose;
 
-	/* Disable all windows (except powar0 since it's ignored) */
-	for(i = 1; i < 5; i++)
-		out_be32(&pci->pow[i].powar, 0);
-	for (i = start_idx; i < end_idx; i++)
-		out_be32(&pci->piw[i].piwar, 0);
-
-	/* Setup outbound MEM window */
-	for(i = 0, j = 1; i < 3; i++) {
-		if (!(hose->mem_resources[i].flags & IORESOURCE_MEM))
-			continue;
-
-		paddr_lo = min(paddr_lo, (u64)hose->mem_resources[i].start);
-		paddr_hi = max(paddr_hi, (u64)hose->mem_resources[i].end);
-
-		/* We assume all memory resources have the same offset */
-		offset = hose->mem_offset[i];
-		n = setup_one_atmu(pci, j, &hose->mem_resources[i], offset);
-
-		if (n < 0 || j >= 5) {
-			pr_err("Ran out of outbound PCI ATMUs for resource %d!\n", i);
-			hose->mem_resources[i].flags |= IORESOURCE_DISABLED;
-		} else
-			j += n;
-	}
-
-	/* Setup outbound IO window */
-	if (hose->io_resource.flags & IORESOURCE_IO) {
-		if (j >= 5) {
-			pr_err("Ran out of outbound PCI ATMUs for IO resource\n");
-		} else {
-			pr_debug("PCI IO resource start 0x%016llx, size 0x%016llx, "
-				 "phy base 0x%016llx.\n",
-				 (u64)hose->io_resource.start,
-				 (u64)resource_size(&hose->io_resource),
-				 (u64)hose->io_base_phys);
-			out_be32(&pci->pow[j].potar, (hose->io_resource.start >> 12));
-			out_be32(&pci->pow[j].potear, 0);
-			out_be32(&pci->pow[j].powbar, (hose->io_base_phys >> 12));
-			/* Enable, IO R/W */
-			out_be32(&pci->pow[j].powar, 0x80088000
-				| (ilog2(hose->io_resource.end
-				- hose->io_resource.start + 1) - 1));
-		}
-	}
-
-	/* convert to pci address space */
-	paddr_hi -= offset;
-	paddr_lo -= offset;
-
-	if (paddr_hi == paddr_lo) {
-		pr_err("%s: No outbound window space\n", name);
-		return;
-	}
-
-	if (paddr_lo == 0) {
-		pr_err("%s: No space for inbound window\n", name);
-		return;
-	}
+	bus.number = busnr;
+	bus.sysdata = &hose;
+	hose.private_data = pcie;
+	bus.ops = pcie->ops;
 
-	/* setup PCSRBAR/PEXCSRBAR */
-	early_write_config_dword(hose, 0, 0, PCI_BASE_ADDRESS_0, 0xffffffff);
-	early_read_config_dword(hose, 0, 0, PCI_BASE_ADDRESS_0, &pcicsrbar_sz);
-	pcicsrbar_sz = ~pcicsrbar_sz + 1;
-
-	if (paddr_hi < (0x100000000ull - pcicsrbar_sz) ||
-		(paddr_lo > 0x100000000ull))
-		pcicsrbar = 0x100000000ull - pcicsrbar_sz;
-	else
-		pcicsrbar = (paddr_lo - pcicsrbar_sz) & -pcicsrbar_sz;
-	early_write_config_dword(hose, 0, 0, PCI_BASE_ADDRESS_0, pcicsrbar);
-
-	paddr_lo = min(paddr_lo, (u64)pcicsrbar);
-
-	pr_info("%s: PCICSRBAR @ 0x%x\n", name, pcicsrbar);
-
-	/* Setup inbound mem window */
-	mem = memblock_end_of_DRAM();
-
-	/*
-	 * The msi-address-64 property, if it exists, indicates the physical
-	 * address of the MSIIR register.  Normally, this register is located
-	 * inside CCSR, so the ATMU that covers all of CCSR is used. But if
-	 * this property exists, then we normally need to create a new ATMU
-	 * for it.  For now, however, we cheat.  The only entity that creates
-	 * this property is the Freescale hypervisor, and the address is
-	 * specified in the partition configuration.  Typically, the address
-	 * is located in the page immediately after the end of DDR.  If so, we
-	 * can avoid allocating a new ATMU by extending the DDR ATMU by one
-	 * page.
-	 */
-	reg = of_get_property(hose->dn, "msi-address-64", &len);
-	if (reg && (len == sizeof(u64))) {
-		u64 address = be64_to_cpup(reg);
-
-		if ((address >= mem) && (address < (mem + PAGE_SIZE))) {
-			pr_info("%s: extending DDR ATMU to cover MSIIR", name);
-			mem += PAGE_SIZE;
-		} else {
-			/* TODO: Create a new ATMU for MSIIR */
-			pr_warn("%s: msi-address-64 address of %llx is "
-				"unsupported\n", name, address);
-		}
-	}
-
-	sz = min(mem, paddr_lo);
-	mem_log = ilog2(sz);
-
-	/* PCIe can overmap inbound & outbound since RX & TX are separated */
-	if (early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) {
-		/* Size window to exact size if power-of-two or one size up */
-		if ((1ull << mem_log) != mem) {
-			if ((1ull << mem_log) > mem)
-				pr_info("%s: Setting PCI inbound window "
-					"greater than memory size\n", name);
-			mem_log++;
-		}
-
-		piwar |= ((mem_log - 1) & PIWAR_SZ_MASK);
-
-		/* Setup inbound memory window */
-		out_be32(&pci->piw[win_idx].pitar,  0x00000000);
-		out_be32(&pci->piw[win_idx].piwbar, 0x00000000);
-		out_be32(&pci->piw[win_idx].piwar,  piwar);
-		win_idx--;
-
-		hose->dma_window_base_cur = 0x00000000;
-		hose->dma_window_size = (resource_size_t)sz;
-
-		/*
-		 * if we have >4G of memory setup second PCI inbound window to
-		 * let devices that are 64-bit address capable to work w/o
-		 * SWIOTLB and access the full range of memory
-		 */
-		if (sz != mem) {
-			mem_log = ilog2(mem);
-
-			/* Size window up if we dont fit in exact power-of-2 */
-			if ((1ull << mem_log) != mem)
-				mem_log++;
-
-			piwar = (piwar & ~PIWAR_SZ_MASK) | (mem_log - 1);
-
-			/* Setup inbound memory window */
-			out_be32(&pci->piw[win_idx].pitar,  0x00000000);
-			out_be32(&pci->piw[win_idx].piwbear,
-					pci64_dma_offset >> 44);
-			out_be32(&pci->piw[win_idx].piwbar,
-					pci64_dma_offset >> 12);
-			out_be32(&pci->piw[win_idx].piwar,  piwar);
-
-			/*
-			 * install our own dma_set_mask handler to fixup dma_ops
-			 * and dma_offset
-			 */
-			ppc_md.dma_set_mask = fsl_pci_dma_set_mask;
-
-			pr_info("%s: Setup 64-bit PCI DMA window\n", name);
-		}
-	} else {
-		u64 paddr = 0;
-
-		/* Setup inbound memory window */
-		out_be32(&pci->piw[win_idx].pitar,  paddr >> 12);
-		out_be32(&pci->piw[win_idx].piwbar, paddr >> 12);
-		out_be32(&pci->piw[win_idx].piwar,  (piwar | (mem_log - 1)));
-		win_idx--;
-
-		paddr += 1ull << mem_log;
-		sz -= 1ull << mem_log;
-
-		if (sz) {
-			mem_log = ilog2(sz);
-			piwar |= (mem_log - 1);
-
-			out_be32(&pci->piw[win_idx].pitar,  paddr >> 12);
-			out_be32(&pci->piw[win_idx].piwbar, paddr >> 12);
-			out_be32(&pci->piw[win_idx].piwar,  piwar);
-			win_idx--;
-
-			paddr += 1ull << mem_log;
-		}
-
-		hose->dma_window_base_cur = 0x00000000;
-		hose->dma_window_size = (resource_size_t)paddr;
-	}
-
-	if (hose->dma_window_size < mem) {
-#ifndef CONFIG_SWIOTLB
-		pr_err("%s: ERROR: Memory size exceeds PCI ATMU ability to "
-			"map - enable CONFIG_SWIOTLB to avoid dma errors.\n",
-			 name);
-#endif
-		/* adjusting outbound windows could reclaim space in mem map */
-		if (paddr_hi < 0xffffffffull)
-			pr_warning("%s: WARNING: Outbound window cfg leaves "
-				"gaps in memory map. Adjusting the memory map "
-				"could reduce unnecessary bounce buffering.\n",
-				name);
-
-		pr_info("%s: DMA window size is 0x%llx\n", name,
-			(u64)hose->dma_window_size);
-	}
-}
-
-static void __init setup_pci_cmd(struct pci_controller *hose)
-{
-	u16 cmd;
-	int cap_x;
-
-	early_read_config_word(hose, 0, 0, PCI_COMMAND, &cmd);
-	cmd |= PCI_COMMAND_SERR | PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY
-		| PCI_COMMAND_IO;
-	early_write_config_word(hose, 0, 0, PCI_COMMAND, cmd);
-
-	cap_x = early_find_capability(hose, 0, 0, PCI_CAP_ID_PCIX);
-	if (cap_x) {
-		int pci_x_cmd = cap_x + PCI_X_CMD;
-		cmd = PCI_X_CMD_MAX_SPLIT | PCI_X_CMD_MAX_READ
-			| PCI_X_CMD_ERO | PCI_X_CMD_DPERR_E;
-		early_write_config_word(hose, 0, 0, pci_x_cmd, cmd);
-	} else {
-		early_write_config_byte(hose, 0, 0, PCI_LATENCY_TIMER, 0x80);
-	}
+	return &bus;
 }
 
 void fsl_pcibios_fixup_bus(struct pci_bus *bus)
 {
 	struct pci_controller *hose = pci_bus_to_host(bus);
-	int i, is_pcie = 0, no_link;
+	int i, is_pcie, no_link;
+	struct fsl_pcie *pcie = fsl_sys_to_pcie(hose);
 
 	/* The root complex bridge comes up with bogus resources,
 	 * we copy the PHB ones in.
@@ -424,9 +118,8 @@ void fsl_pcibios_fixup_bus(struct pci_bus *bus)
 	 * tricky.
 	 */
 
-	if (fsl_pcie_bus_fixup)
-		is_pcie = early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP);
-	no_link = !!(hose->indirect_type & PPC_INDIRECT_TYPE_NO_PCIE_LINK);
+	is_pcie = pcie->is_pcie;
+	no_link = fsl_pcie_check_link(pcie);
 
 	if (bus->parent == hose->bus && (is_pcie || no_link)) {
 		for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; ++i) {
@@ -448,115 +141,79 @@ void fsl_pcibios_fixup_bus(struct pci_bus *bus)
 	}
 }
 
-int __init fsl_add_bridge(struct platform_device *pdev, int is_primary)
+int fsl_pci_exclude_device(struct fsl_pcie *pcie, u8 bus, u8 devfn)
 {
-	int len;
-	struct pci_controller *hose;
-	struct resource rsrc;
-	const int *bus_range;
-	u8 hdr_type, progif;
-	struct device_node *dev;
-	struct ccsr_pci __iomem *pci;
-
-	dev = pdev->dev.of_node;
+	struct pci_controller *hose = pcie->sys;
 
-	if (!of_device_is_available(dev)) {
-		pr_warning("%s: disabled\n", dev->full_name);
-		return -ENODEV;
-	}
+	if (!hose)
+		return PCIBIOS_SUCCESSFUL;
 
-	pr_debug("Adding PCI host bridge %s\n", dev->full_name);
+	if (ppc_md.pci_exclude_device)
+		if (ppc_md.pci_exclude_device(hose, bus, devfn))
+				return PCIBIOS_DEVICE_NOT_FOUND;
 
-	/* Fetch host bridge registers address */
-	if (of_address_to_resource(dev, 0, &rsrc)) {
-		printk(KERN_WARNING "Can't get pci register base!");
-		return -ENOMEM;
-	}
+	return PCIBIOS_SUCCESSFUL;
+}
 
-	/* Get bus range if any */
-	bus_range = of_get_property(dev, "bus-range", &len);
-	if (bus_range == NULL || len < 2 * sizeof(int))
-		printk(KERN_WARNING "Can't get bus-range for %s, assume"
-			" bus 0\n", dev->full_name);
+int fsl_pcie_sys_register(struct fsl_pcie *pcie)
+{
+	struct pci_controller *hose;
 
 	pci_add_flags(PCI_REASSIGN_ALL_BUS);
-	hose = pcibios_alloc_controller(dev);
+	hose = pcibios_alloc_controller(pcie->dn);
 	if (!hose)
 		return -ENOMEM;
 
 	/* set platform device as the parent */
-	hose->parent = &pdev->dev;
-	hose->first_busno = bus_range ? bus_range[0] : 0x0;
-	hose->last_busno = bus_range ? bus_range[1] : 0xff;
-
-	pr_debug("PCI memory map start 0x%016llx, size 0x%016llx\n",
-		 (u64)rsrc.start, (u64)resource_size(&rsrc));
-
-	pci = hose->private_data = ioremap(rsrc.start, resource_size(&rsrc));
-	if (!hose->private_data)
-		goto no_bridge;
-
-	setup_indirect_pci(hose, rsrc.start, rsrc.start + 0x4,
-			   PPC_INDIRECT_TYPE_BIG_ENDIAN);
-
-	if (in_be32(&pci->block_rev1) < PCIE_IP_REV_3_0)
-		hose->indirect_type |= PPC_INDIRECT_TYPE_FSL_CFG_REG_LINK;
-
-	if (early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) {
-		/* use fsl_indirect_read_config for PCIe */
-		hose->ops = &fsl_indirect_pcie_ops;
-		/* For PCIE read HEADER_TYPE to identify controler mode */
-		early_read_config_byte(hose, 0, 0, PCI_HEADER_TYPE, &hdr_type);
-		if ((hdr_type & 0x7f) != PCI_HEADER_TYPE_BRIDGE)
-			goto no_bridge;
-
-	} else {
-		/* For PCI read PROG to identify controller mode */
-		early_read_config_byte(hose, 0, 0, PCI_CLASS_PROG, &progif);
-		if ((progif & 1) == 1)
-			goto no_bridge;
-	}
-
-	setup_pci_cmd(hose);
-
-	/* check PCI express link status */
-	if (early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) {
-		hose->indirect_type |= PPC_INDIRECT_TYPE_EXT_REG |
-			PPC_INDIRECT_TYPE_SURPRESS_PRIMARY_BUS;
-		if (fsl_pcie_check_link(hose))
-			hose->indirect_type |= PPC_INDIRECT_TYPE_NO_PCIE_LINK;
-	}
+	hose->private_data = pcie;
+	hose->parent = pcie->dev;
+	hose->first_busno = pcie->first_busno;
+	hose->last_busno = pcie->last_busno;
+	hose->ops = pcie->ops;
+
+	hose->pci_io_size = pcie->pci_io_size;
+	hose->io_base_phys = pcie->io_base_phys;
+	hose->io_resource = pcie->io_resource;
+	memcpy(hose->mem_offset, pcie->mem_offset, sizeof(hose->mem_offset));
+	memcpy(hose->mem_resources, pcie->mem_resources,
+		sizeof(hose->mem_resources));
+	hose->dma_window_base_cur = pcie->dma_window_base_cur;
+	hose->dma_window_size = pcie->dma_window_size;
+	pcie->sys = hose;
 
-	printk(KERN_INFO "Found FSL PCI host bridge at 0x%016llx. "
-		"Firmware bus number: %d->%d\n",
-		(unsigned long long)rsrc.start, hose->first_busno,
-		hose->last_busno);
+	/*
+	 * Install our own dma_set_mask handler to fixup dma_ops
+	 * and dma_offset
+	 */
+	if (pcie->is_pcie)
+		ppc_md.dma_set_mask = fsl_pci_dma_set_mask;
 
-	pr_debug(" ->Hose at 0x%p, cfg_addr=0x%p,cfg_data=0x%p\n",
-		hose, hose->cfg_addr, hose->cfg_data);
+#ifdef CONFIG_SWIOTLB
+	/*
+	 * if we couldn't map all of DRAM via the dma windows
+	 * we need SWIOTLB to handle buffers located outside of
+	 * dma capable memory region
+	 */
+	if (memblock_end_of_DRAM() - 1 > hose->dma_window_base_cur +
+			hose->dma_window_size)
+		ppc_swiotlb_enable = 1;
+#endif
 
-	/* Interpret the "ranges" property */
-	/* This also maps the I/O region and sets isa_io/mem_base */
-	pci_process_bridge_OF_ranges(hose, dev, is_primary);
+	mpc85xx_pci_err_probe(to_platform_device(pcie->dev));
+	return 0;
+}
 
-	/* Setup PEX window registers */
-	setup_pci_atmu(hose);
+void fsl_pcie_sys_remove(struct fsl_pcie *pcie)
+{
+	struct pci_controller *hose = pcie->sys;
 
-	return 0;
+	if (!hose)
+		return;
 
-no_bridge:
-	iounmap(hose->private_data);
-	/* unmap cfg_data & cfg_addr separately if not on same page */
-	if (((unsigned long)hose->cfg_data & PAGE_MASK) !=
-	    ((unsigned long)hose->cfg_addr & PAGE_MASK))
-		iounmap(hose->cfg_data);
-	iounmap(hose->cfg_addr);
 	pcibios_free_controller(hose);
-	return -ENODEV;
 }
-#endif /* CONFIG_FSL_SOC_BOOKE || CONFIG_PPC_86xx */
 
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID, quirk_fsl_pcie_header);
+#endif
 
 #if defined(CONFIG_PPC_83xx) || defined(CONFIG_PPC_MPC512x)
 struct mpc83xx_pcie_priv {
@@ -693,6 +350,19 @@ static struct pci_ops mpc83xx_pcie_ops = {
 	.write = mpc83xx_pcie_write_config,
 };
 
+static int mpc83xx_pcie_check_link(struct pci_controller *hose)
+{
+	u32 val = 0;
+
+#define PCIE_LTSSM	0x0404		/* PCIE Link Training and Status */
+#define PCIE_LTSSM_L0	0x16		/* L0 state */
+
+	early_read_config_dword(hose, 0, 0, PCIE_LTSSM, &val);
+	if (val < PCIE_LTSSM_L0)
+		return 1;
+	return 0;
+}
+
 static int __init mpc83xx_pcie_setup(struct pci_controller *hose,
 				     struct resource *reg)
 {
@@ -727,7 +397,7 @@ static int __init mpc83xx_pcie_setup(struct pci_controller *hose,
 	out_le32(pcie->cfg_type0 + PEX_OUTWIN0_TAH, 0);
 	out_le32(pcie->cfg_type0 + PEX_OUTWIN0_TAL, 0);
 
-	if (fsl_pcie_check_link(hose))
+	if (mpc83xx_pcie_check_link(hose))
 		hose->indirect_type |= PPC_INDIRECT_TYPE_NO_PCIE_LINK;
 
 	return 0;
@@ -869,7 +539,7 @@ u64 fsl_pci_immrbar_base(struct pci_controller *hose)
 }
 
 #if defined(CONFIG_FSL_SOC_BOOKE) || defined(CONFIG_PPC_86xx)
-static const struct of_device_id pci_ids[] = {
+const struct of_device_id fsl_pci_ids[] = {
 	{ .compatible = "fsl,mpc8540-pci", },
 	{ .compatible = "fsl,mpc8548-pcie", },
 	{ .compatible = "fsl,mpc8610-pci", },
@@ -906,7 +576,7 @@ void fsl_pci_assign_primary(void)
 		of_node_put(np);
 		np = fsl_pci_primary;
 
-		if (of_match_node(pci_ids, np) && of_device_is_available(np))
+		if (of_match_node(fsl_pci_ids, np) && of_device_is_available(np))
 			return;
 	}
 
@@ -915,7 +585,7 @@ void fsl_pci_assign_primary(void)
 	 * designate one as primary.  This can go away once
 	 * various bugs with primary-less systems are fixed.
 	 */
-	for_each_matching_node(np, pci_ids) {
+	for_each_matching_node(np, fsl_pci_ids) {
 		if (of_device_is_available(np)) {
 			fsl_pci_primary = np;
 			of_node_put(np);
@@ -924,81 +594,4 @@ void fsl_pci_assign_primary(void)
 	}
 }
 
-static int fsl_pci_probe(struct platform_device *pdev)
-{
-	int ret;
-	struct device_node *node;
-#ifdef CONFIG_SWIOTLB
-	struct pci_controller *hose;
-#endif
-
-	node = pdev->dev.of_node;
-	ret = fsl_add_bridge(pdev, fsl_pci_primary == node);
-
-#ifdef CONFIG_SWIOTLB
-	if (ret == 0) {
-		hose = pci_find_hose_for_OF_device(pdev->dev.of_node);
-
-		/*
-		 * if we couldn't map all of DRAM via the dma windows
-		 * we need SWIOTLB to handle buffers located outside of
-		 * dma capable memory region
-		 */
-		if (memblock_end_of_DRAM() - 1 > hose->dma_window_base_cur +
-				hose->dma_window_size)
-			ppc_swiotlb_enable = 1;
-	}
-#endif
-
-	mpc85xx_pci_err_probe(pdev);
-
-	return 0;
-}
-
-#ifdef CONFIG_PM
-static int fsl_pci_resume(struct device *dev)
-{
-	struct pci_controller *hose;
-	struct resource pci_rsrc;
-
-	hose = pci_find_hose_for_OF_device(dev->of_node);
-	if (!hose)
-		return -ENODEV;
-
-	if (of_address_to_resource(dev->of_node, 0, &pci_rsrc)) {
-		dev_err(dev, "Get pci register base failed.");
-		return -ENODEV;
-	}
-
-	setup_pci_atmu(hose);
-
-	return 0;
-}
-
-static const struct dev_pm_ops pci_pm_ops = {
-	.resume = fsl_pci_resume,
-};
-
-#define PCI_PM_OPS (&pci_pm_ops)
-
-#else
-
-#define PCI_PM_OPS NULL
-
-#endif
-
-static struct platform_driver fsl_pci_driver = {
-	.driver = {
-		.name = "fsl-pci",
-		.pm = PCI_PM_OPS,
-		.of_match_table = pci_ids,
-	},
-	.probe = fsl_pci_probe,
-};
-
-static int __init fsl_pci_init(void)
-{
-	return platform_driver_register(&fsl_pci_driver);
-}
-arch_initcall(fsl_pci_init);
 #endif
diff --git a/arch/powerpc/sysdev/fsl_pci.h b/arch/powerpc/sysdev/fsl_pci.h
index 72b5625..42f3ab6 100644
--- a/arch/powerpc/sysdev/fsl_pci.h
+++ b/arch/powerpc/sysdev/fsl_pci.h
@@ -14,97 +14,6 @@
 #ifndef __POWERPC_FSL_PCI_H
 #define __POWERPC_FSL_PCI_H
 
-struct platform_device;
-
-#define PCIE_LTSSM	0x0404		/* PCIE Link Training and Status */
-#define PCIE_LTSSM_L0	0x16		/* L0 state */
-#define PCIE_IP_REV_2_2		0x02080202 /* PCIE IP block version Rev2.2 */
-#define PCIE_IP_REV_3_0		0x02080300 /* PCIE IP block version Rev3.0 */
-#define PIWAR_EN		0x80000000	/* Enable */
-#define PIWAR_PF		0x20000000	/* prefetch */
-#define PIWAR_TGI_LOCAL		0x00f00000	/* target - local memory */
-#define PIWAR_READ_SNOOP	0x00050000
-#define PIWAR_WRITE_SNOOP	0x00005000
-#define PIWAR_SZ_MASK          0x0000003f
-
-/* PCI/PCI Express outbound window reg */
-struct pci_outbound_window_regs {
-	__be32	potar;	/* 0x.0 - Outbound translation address register */
-	__be32	potear;	/* 0x.4 - Outbound translation extended address register */
-	__be32	powbar;	/* 0x.8 - Outbound window base address register */
-	u8	res1[4];
-	__be32	powar;	/* 0x.10 - Outbound window attributes register */
-	u8	res2[12];
-};
-
-/* PCI/PCI Express inbound window reg */
-struct pci_inbound_window_regs {
-	__be32	pitar;	/* 0x.0 - Inbound translation address register */
-	u8	res1[4];
-	__be32	piwbar;	/* 0x.8 - Inbound window base address register */
-	__be32	piwbear;	/* 0x.c - Inbound window base extended address register */
-	__be32	piwar;	/* 0x.10 - Inbound window attributes register */
-	u8	res2[12];
-};
-
-/* PCI/PCI Express IO block registers for 85xx/86xx */
-struct ccsr_pci {
-	__be32	config_addr;		/* 0x.000 - PCI/PCIE Configuration Address Register */
-	__be32	config_data;		/* 0x.004 - PCI/PCIE Configuration Data Register */
-	__be32	int_ack;		/* 0x.008 - PCI Interrupt Acknowledge Register */
-	__be32	pex_otb_cpl_tor;	/* 0x.00c - PCIE Outbound completion timeout register */
-	__be32	pex_conf_tor;		/* 0x.010 - PCIE configuration timeout register */
-	__be32	pex_config;		/* 0x.014 - PCIE CONFIG Register */
-	__be32	pex_int_status;		/* 0x.018 - PCIE interrupt status */
-	u8	res2[4];
-	__be32	pex_pme_mes_dr;		/* 0x.020 - PCIE PME and message detect register */
-	__be32	pex_pme_mes_disr;	/* 0x.024 - PCIE PME and message disable register */
-	__be32	pex_pme_mes_ier;	/* 0x.028 - PCIE PME and message interrupt enable register */
-	__be32	pex_pmcr;		/* 0x.02c - PCIE power management command register */
-	u8	res3[3016];
-	__be32	block_rev1;	/* 0x.bf8 - PCIE Block Revision register 1 */
-	__be32	block_rev2;	/* 0x.bfc - PCIE Block Revision register 2 */
-
-/* PCI/PCI Express outbound window 0-4
- * Window 0 is the default window and is the only window enabled upon reset.
- * The default outbound register set is used when a transaction misses
- * in all of the other outbound windows.
- */
-	struct pci_outbound_window_regs pow[5];
-	u8	res14[96];
-	struct pci_inbound_window_regs	pmit;	/* 0xd00 - 0xd9c Inbound MSI */
-	u8	res6[96];
-/* PCI/PCI Express inbound window 3-0
- * inbound window 1 supports only a 32-bit base address and does not
- * define an inbound window base extended address register.
- */
-	struct pci_inbound_window_regs piw[4];
-
-	__be32	pex_err_dr;		/* 0x.e00 - PCI/PCIE error detect register */
-	u8	res21[4];
-	__be32	pex_err_en;		/* 0x.e08 - PCI/PCIE error interrupt enable register */
-	u8	res22[4];
-	__be32	pex_err_disr;		/* 0x.e10 - PCI/PCIE error disable register */
-	u8	res23[12];
-	__be32	pex_err_cap_stat;	/* 0x.e20 - PCI/PCIE error capture status register */
-	u8	res24[4];
-	__be32	pex_err_cap_r0;		/* 0x.e28 - PCIE error capture register 0 */
-	__be32	pex_err_cap_r1;		/* 0x.e2c - PCIE error capture register 0 */
-	__be32	pex_err_cap_r2;		/* 0x.e30 - PCIE error capture register 0 */
-	__be32	pex_err_cap_r3;		/* 0x.e34 - PCIE error capture register 0 */
-	u8	res_e38[200];
-	__be32	pdb_stat;		/* 0x.f00 - PCIE Debug Status */
-	u8	res_f04[16];
-	__be32	pex_csr0;		/* 0x.f14 - PEX Control/Status register 0*/
-#define PEX_CSR0_LTSSM_MASK	0xFC
-#define PEX_CSR0_LTSSM_SHIFT	2
-#define PEX_CSR0_LTSSM_L0	0x11
-	__be32	pex_csr1;		/* 0x.f18 - PEX Control/Status register 1*/
-	u8	res_f1c[228];
-
-};
-
-extern int fsl_add_bridge(struct platform_device *pdev, int is_primary);
 extern void fsl_pcibios_fixup_bus(struct pci_bus *bus);
 extern int mpc83xx_add_bridge(struct device_node *dev);
 u64 fsl_pci_immrbar_base(struct pci_controller *hose);
diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
index 3eb32f6..ae603c1 100644
--- a/drivers/edac/mpc85xx_edac.c
+++ b/drivers/edac/mpc85xx_edac.c
@@ -239,7 +239,6 @@ int mpc85xx_pci_err_probe(struct platform_device *op)
 	pdata = pci->pvt_info;
 	pdata->name = "mpc85xx_pci_err";
 	pdata->irq = NO_IRQ;
-	dev_set_drvdata(&op->dev, pci);
 	pci->dev = &op->dev;
 	pci->mod_name = EDAC_MOD_STR;
 	pci->ctl_name = pdata->name;
@@ -259,15 +258,6 @@ int mpc85xx_pci_err_probe(struct platform_device *op)
 
 	/* we only need the error registers */
 	r.start += 0xe00;
-
-	if (!devm_request_mem_region(&op->dev, r.start, resource_size(&r),
-					pdata->name)) {
-		printk(KERN_ERR "%s: Error while requesting mem region\n",
-		       __func__);
-		res = -EBUSY;
-		goto err;
-	}
-
 	pdata->pci_vbase = devm_ioremap(&op->dev, r.start, resource_size(&r));
 	if (!pdata->pci_vbase) {
 		printk(KERN_ERR "%s: Unable to setup PCI err regs\n", __func__);
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 1184ff6..952567e 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -14,4 +14,8 @@ config PCI_EXYNOS
 	select PCIEPORTBUS
 	select PCIE_DW
 
+config PCIE_FSL
+	bool "Freescale PCIe controller"
+	depends on FSL_SOC_BOOKE || PPC_86xx
+
 endmenu
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index 086d850..cd18fd04 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
 obj-$(CONFIG_PCIE_DW) += pcie-designware.o
+obj-$(CONFIG_PCIE_FSL) += pcie-fsl.o
diff --git a/drivers/pci/host/pcie-fsl.c b/drivers/pci/host/pcie-fsl.c
new file mode 100644
index 0000000..6e767d4
--- /dev/null
+++ b/drivers/pci/host/pcie-fsl.c
@@ -0,0 +1,734 @@
+/*
+ * 85xx/86xx/LS PCI/PCIE common driver support
+ *
+ * Copyright 2013 Freescale Semiconductor, Inc.
+ *
+ * Moved from arch/power/fsl_pci.c
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/string.h>
+#include <linux/init.h>
+#include <linux/log2.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_pci.h>
+#include <linux/pci_regs.h>
+#include <linux/platform_device.h>
+#include <linux/resource.h>
+#include <linux/types.h>
+#include <linux/memblock.h>
+#include <linux/fsl/fsl-pcie.h>
+
+/* Indirect type */
+#define INDIRECT_TYPE_EXT_REG			0x00000002
+#define INDIRECT_TYPE_SURPRESS_PRIMARY_BUS	0x00000004
+#define INDIRECT_TYPE_NO_PCIE_LINK		0x00000008
+#define INDIRECT_TYPE_BIG_ENDIAN		0x00000010
+#define INDIRECT_TYPE_FSL_CFG_REG_LINK		0x00000040
+
+u64 __weak fsl_pci64_dma_offset(void)
+{
+	return 0;
+}
+
+struct fsl_pcie * __weak fsl_sys_to_pcie(void *sys)
+{
+	return NULL;
+}
+
+struct pci_bus * __weak fsl_fake_pci_bus(struct fsl_pcie *pcie, int busnr)
+{
+	return NULL;
+}
+
+int __weak fsl_pci_exclude_device(struct fsl_pcie *pcie, u8 bus, u8 devfn)
+{
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int fsl_pcie_read_config(struct fsl_pcie *pcie, int bus, int devfn,
+				int offset, int len, u32 *val)
+{
+	u32 bus_no, reg, data;
+
+	if (pcie->indirect_type & INDIRECT_TYPE_NO_PCIE_LINK) {
+		if (bus != pcie->first_busno)
+			return PCIBIOS_DEVICE_NOT_FOUND;
+		if (devfn != 0)
+			return PCIBIOS_DEVICE_NOT_FOUND;
+	}
+
+	if (fsl_pci_exclude_device(pcie, bus, devfn))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	bus_no = (bus == pcie->first_busno) ? pcie->self_busno : bus;
+
+	if (pcie->indirect_type & INDIRECT_TYPE_EXT_REG)
+		reg = ((offset & 0xf00) << 16) | (offset & 0xfc);
+	else
+		reg = offset & 0xfc;
+
+	if (pcie->indirect_type & INDIRECT_TYPE_BIG_ENDIAN)
+		out_be32(&pcie->regs->config_addr,
+			 (0x80000000 | (bus_no << 16) |
+			 (devfn << 8) | reg));
+	else
+		out_le32(&pcie->regs->config_addr,
+			 (0x80000000 | (bus_no << 16) |
+			 (devfn << 8) | reg));
+
+	/*
+	 * Note: the caller has already checked that offset is
+	 * suitably aligned and that len is 1, 2 or 4.
+	 */
+	data = in_le32(&pcie->regs->config_data);
+	switch (len) {
+	case 1:
+		*val = (data >> (8 * (offset & 3))) & 0xff;
+		break;
+	case 2:
+		*val = (data >> (8 * (offset & 3))) & 0xffff;
+		break;
+	default:
+		*val = data;
+		break;
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int fsl_pcie_write_config(struct fsl_pcie *pcie, int bus, int devfn,
+				 int offset, int len, u32 val)
+{
+	void __iomem *cfg_data;
+	u32 bus_no, reg;
+
+	if (pcie->indirect_type & INDIRECT_TYPE_NO_PCIE_LINK) {
+		if (bus != pcie->first_busno)
+			return PCIBIOS_DEVICE_NOT_FOUND;
+		if (devfn != 0)
+			return PCIBIOS_DEVICE_NOT_FOUND;
+	}
+
+	if (fsl_pci_exclude_device(pcie, bus, devfn))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	bus_no = (bus == pcie->first_busno) ?
+			pcie->self_busno : bus;
+
+	if (pcie->indirect_type & INDIRECT_TYPE_EXT_REG)
+		reg = ((offset & 0xf00) << 16) | (offset & 0xfc);
+	else
+		reg = offset & 0xfc;
+
+	if (pcie->indirect_type & INDIRECT_TYPE_BIG_ENDIAN)
+		out_be32(&pcie->regs->config_addr,
+			 (0x80000000 | (bus_no << 16) | (devfn << 8) | reg));
+	else
+		out_le32(&pcie->regs->config_addr,
+			 (0x80000000 | (bus_no << 16) | (devfn << 8) | reg));
+
+	/* suppress setting of PCI_PRIMARY_BUS */
+	if (pcie->indirect_type & INDIRECT_TYPE_SURPRESS_PRIMARY_BUS)
+		if ((offset == PCI_PRIMARY_BUS) &&
+		    (bus == pcie->first_busno))
+			val &= 0xffffff00;
+
+	/*
+	 * Note: the caller has already checked that offset is
+	 * suitably aligned and that len is 1, 2 or 4.
+	 */
+	cfg_data = ((void *) &(pcie->regs->config_data)) + (offset & 3);
+	switch (len) {
+	case 1:
+		out_8(cfg_data, val);
+		break;
+	case 2:
+		out_le16(cfg_data, val);
+		break;
+	default:
+		out_le32(cfg_data, val);
+		break;
+	}
+	return PCIBIOS_SUCCESSFUL;
+}
+
+int fsl_pcie_check_link(struct fsl_pcie *pcie)
+{
+	u32 val = 0;
+
+	if (pcie->indirect_type & INDIRECT_TYPE_FSL_CFG_REG_LINK) {
+		fsl_pcie_read_config(pcie, 0, 0, PCIE_LTSSM, 4, &val);
+		if (val < PCIE_LTSSM_L0)
+			return 1;
+	} else {
+		/* for PCIe IP rev 3.0 or greater use CSR0 for link state */
+		val = (in_be32(&pcie->regs->pex_csr0) & PEX_CSR0_LTSSM_MASK)
+				>> PEX_CSR0_LTSSM_SHIFT;
+		if (val != PEX_CSR0_LTSSM_L0)
+			return 1;
+	}
+
+	return 0;
+}
+
+static int fsl_indirect_read_config(struct pci_bus *bus, unsigned int devfn,
+				    int offset, int len, u32 *val)
+{
+	struct fsl_pcie *pcie = fsl_sys_to_pcie(bus->sysdata);
+
+	if (!pcie)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	if (fsl_pcie_check_link(pcie))
+		pcie->indirect_type |= INDIRECT_TYPE_NO_PCIE_LINK;
+	else
+		pcie->indirect_type &= ~INDIRECT_TYPE_NO_PCIE_LINK;
+
+	return fsl_pcie_read_config(pcie, bus->number, devfn, offset, len, val);
+}
+
+static int fsl_indirect_write_config(struct pci_bus *bus, unsigned int devfn,
+				     int offset, int len, u32 val)
+{
+	struct fsl_pcie *pcie = fsl_sys_to_pcie(bus->sysdata);
+
+	if (!pcie)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	return fsl_pcie_write_config(pcie, bus->number, devfn,
+				     offset, len, val);
+}
+
+static struct pci_ops fsl_indirect_pci_ops = {
+	.read = fsl_indirect_read_config,
+	.write = fsl_indirect_write_config,
+};
+
+#define EARLY_FSL_PCI_OP(rw, size, type)				\
+int early_fsl_##rw##_config_##size(struct fsl_pcie *pcie, int bus,	\
+				   int devfn, int offset, type value)	\
+{									\
+	return pci_bus_##rw##_config_##size(fsl_fake_pci_bus(pcie, bus),\
+					    devfn, offset, value);	\
+}
+
+EARLY_FSL_PCI_OP(read, byte, u8 *)
+EARLY_FSL_PCI_OP(read, word, u16 *)
+EARLY_FSL_PCI_OP(read, dword, u32 *)
+EARLY_FSL_PCI_OP(write, byte, u8)
+EARLY_FSL_PCI_OP(write, word, u16)
+EARLY_FSL_PCI_OP(write, dword, u32)
+
+static int early_fsl_find_capability(struct fsl_pcie *pcie,
+				     int busnr, int devfn, int cap)
+{
+	struct pci_bus *bus = fsl_fake_pci_bus(pcie, busnr);
+
+	if (!bus)
+		return 0;
+
+	return pci_bus_find_capability(bus, devfn, cap);
+}
+
+static int setup_one_atmu(struct ccsr_pci __iomem *pci,
+			  unsigned int index, const struct resource *res,
+			  resource_size_t offset)
+{
+	resource_size_t pci_addr = res->start - offset;
+	resource_size_t phys_addr = res->start;
+	resource_size_t size = resource_size(res);
+	u32 flags = 0x80044000; /* enable & mem R/W */
+	unsigned int i;
+
+	pr_debug("PCI MEM resource start 0x%016llx, size 0x%016llx.\n",
+		(u64)res->start, (u64)size);
+
+	if (res->flags & IORESOURCE_PREFETCH)
+		flags |= 0x10000000; /* enable relaxed ordering */
+
+	for (i = 0; size > 0; i++) {
+		unsigned int bits = min(ilog2(size),
+					__ffs(pci_addr | phys_addr));
+
+		if (index + i >= 5)
+			return -1;
+
+		out_be32(&pci->pow[index + i].potar, pci_addr >> 12);
+		out_be32(&pci->pow[index + i].potear, (u64)pci_addr >> 44);
+		out_be32(&pci->pow[index + i].powbar, phys_addr >> 12);
+		out_be32(&pci->pow[index + i].powar, flags | (bits - 1));
+
+		pci_addr += (resource_size_t)1U << bits;
+		phys_addr += (resource_size_t)1U << bits;
+		size -= (resource_size_t)1U << bits;
+	}
+
+	return i;
+}
+
+/* atmu setup for fsl pci/pcie controller */
+static void setup_pci_atmu(struct fsl_pcie *pcie)
+{
+	int i, j, n, mem_log, win_idx = 3, start_idx = 1, end_idx = 4;
+	u64 mem, sz, paddr_hi = 0;
+	u64 offset = 0, paddr_lo = ULLONG_MAX;
+	u32 pcicsrbar = 0, pcicsrbar_sz;
+	u32 piwar = PIWAR_EN | PIWAR_PF | PIWAR_TGI_LOCAL |
+			PIWAR_READ_SNOOP | PIWAR_WRITE_SNOOP;
+	const u64 *reg;
+	int len;
+
+	if (pcie->is_pcie) {
+		if (in_be32(&pcie->regs->block_rev1) >= PCIE_IP_REV_2_2) {
+			win_idx = 2;
+			start_idx = 0;
+			end_idx = 3;
+		}
+	}
+
+	/* Disable all windows (except powar0 since it's ignored) */
+	for (i = 1; i < 5; i++)
+		out_be32(&pcie->regs->pow[i].powar, 0);
+	for (i = start_idx; i < end_idx; i++)
+		out_be32(&pcie->regs->piw[i].piwar, 0);
+
+	/* Setup outbound MEM window */
+	for (i = 0, j = 1; i < 3; i++) {
+		if (!(pcie->mem_resources[i].flags & IORESOURCE_MEM))
+			continue;
+
+		paddr_lo = min_t(u64, paddr_lo, pcie->mem_resources[i].start);
+		paddr_hi = max_t(u64, paddr_hi, pcie->mem_resources[i].end);
+
+		/* We assume all memory resources have the same offset */
+		offset = pcie->mem_offset[i];
+		n = setup_one_atmu(pcie->regs, j, &pcie->mem_resources[i],
+				   offset);
+
+		if (n < 0 || j >= 5) {
+			dev_err(pcie->dev, "Ran out of outbound PCI ATMUs"
+				" for resource %d!\n", i);
+			pcie->mem_resources[i].flags |= IORESOURCE_DISABLED;
+		} else
+			j += n;
+	}
+
+	/* Setup outbound IO window */
+	if (pcie->io_resource.flags & IORESOURCE_IO) {
+		if (j >= 5)
+			dev_err(pcie->dev,
+				"Ran out of outbound PCI ATMUs for IO resource\n");
+		else {
+			dev_dbg(pcie->dev,
+				 "PCI IO resource start 0x%016llx,"
+				 "size 0x%016llx, phy base 0x%016llx.\n",
+				 (u64)pcie->io_resource.start,
+				 (u64)resource_size(&pcie->io_resource),
+				 (u64)pcie->io_base_phys);
+			out_be32(&pcie->regs->pow[j].potar,
+				 (pcie->io_resource.start >> 12));
+			out_be32(&pcie->regs->pow[j].potear, 0);
+			out_be32(&pcie->regs->pow[j].powbar,
+				 (pcie->io_base_phys >> 12));
+			/* Enable, IO R/W */
+			out_be32(&pcie->regs->pow[j].powar, 0x80088000 |
+			      (ilog2(resource_size(&pcie->io_resource)) - 1));
+		}
+	}
+
+	/* convert to pci address space */
+	paddr_hi -= offset;
+	paddr_lo -= offset;
+
+	if (paddr_hi == paddr_lo) {
+		dev_err(pcie->dev, "No outbound window space\n");
+		return;
+	}
+
+	if (paddr_lo == 0) {
+		dev_err(pcie->dev, "No space for inbound window\n");
+		return;
+	}
+
+	/* setup PCSRBAR/PEXCSRBAR */
+	early_fsl_write_config_dword(pcie, 0, 0, PCI_BASE_ADDRESS_0,
+				     0xffffffff);
+	early_fsl_read_config_dword(pcie, 0, 0, PCI_BASE_ADDRESS_0,
+				    &pcicsrbar_sz);
+	pcicsrbar_sz = ~pcicsrbar_sz + 1;
+
+	if (paddr_hi < (0x100000000ull - pcicsrbar_sz) ||
+	    (paddr_lo > 0x100000000ull))
+		pcicsrbar = 0x100000000ull - pcicsrbar_sz;
+	else
+		pcicsrbar = (paddr_lo - pcicsrbar_sz) & -pcicsrbar_sz;
+	early_fsl_write_config_dword(pcie, 0, 0, PCI_BASE_ADDRESS_0,
+				     pcicsrbar);
+
+	paddr_lo = min_t(u64, paddr_lo, pcicsrbar);
+
+	dev_info(pcie->dev, "PCICSRBAR @ 0x%x\n", pcicsrbar);
+
+	/* Setup inbound mem window */
+	mem = memblock_end_of_DRAM();
+
+	/*
+	 * The msi-address-64 property, if it exists, indicates the physical
+	 * address of the MSIIR register.  Normally, this register is located
+	 * inside CCSR, so the ATMU that covers all of CCSR is used. But if
+	 * this property exists, then we normally need to create a new ATMU
+	 * for it.  For now, however, we cheat.  The only entity that creates
+	 * this property is the Freescale hypervisor, and the address is
+	 * specified in the partition configuration.  Typically, the address
+	 * is located in the page immediately after the end of DDR.  If so, we
+	 * can avoid allocating a new ATMU by extending the DDR ATMU by one
+	 * page.
+	 */
+	reg = of_get_property(pcie->dn, "msi-address-64", &len);
+	if (reg && (len == sizeof(u64))) {
+		u64 address = be64_to_cpup(reg);
+
+		if ((address >= mem) && (address < (mem + PAGE_SIZE))) {
+			dev_info(pcie->dev,
+				 "extending DDR ATMU to cover MSIIR\n");
+			mem += PAGE_SIZE;
+		} else {
+			/* TODO: Create a new ATMU for MSIIR */
+			dev_warn(pcie->dev,
+				 "msi-address-64 address of %llx is "
+				 "unsupported\n", address);
+		}
+	}
+
+	sz = min(mem, paddr_lo);
+	mem_log = ilog2(sz);
+
+	/* PCIe can overmap inbound & outbound since RX & TX are separated */
+	if (pcie->is_pcie) {
+		/* Size window to exact size if power-of-two or one size up */
+		if ((1ull << mem_log) != mem) {
+			if ((1ull << mem_log) > mem)
+				dev_info(pcie->dev, "Setting PCI inbound window"
+					 "greater than memory size\n");
+			mem_log++;
+		}
+
+		piwar |= ((mem_log - 1) & PIWAR_SZ_MASK);
+
+		/* Setup inbound memory window */
+		out_be32(&pcie->regs->piw[win_idx].pitar,  0x00000000);
+		out_be32(&pcie->regs->piw[win_idx].piwbar, 0x00000000);
+		out_be32(&pcie->regs->piw[win_idx].piwar,  piwar);
+		win_idx--;
+
+		pcie->dma_window_base_cur = 0x00000000;
+		pcie->dma_window_size = (resource_size_t)sz;
+
+		/*
+		 * if we have >4G of memory setup second PCI inbound window to
+		 * let devices that are 64-bit address capable to work w/o
+		 * SWIOTLB and access the full range of memory
+		 */
+		if (sz != mem) {
+			mem_log = ilog2(mem);
+
+			/* Size window up if we dont fit in exact power-of-2 */
+			if ((1ull << mem_log) != mem)
+				mem_log++;
+
+				piwar = (piwar & ~PIWAR_SZ_MASK) |
+					(mem_log - 1);
+
+				/* Setup inbound memory window */
+				out_be32(&pcie->regs->piw[win_idx].pitar,  0);
+				out_be32(&pcie->regs->piw[win_idx].piwbear,
+					 fsl_pci64_dma_offset() >> 44);
+				out_be32(&pcie->regs->piw[win_idx].piwbar,
+					 fsl_pci64_dma_offset() >> 12);
+				out_be32(&pcie->regs->piw[win_idx].piwar,
+					 piwar);
+		}
+	} else {
+		u64 paddr = 0;
+
+		/* Setup inbound memory window */
+		out_be32(&pcie->regs->piw[win_idx].pitar, paddr >> 12);
+		out_be32(&pcie->regs->piw[win_idx].piwbar, paddr >> 12);
+		out_be32(&pcie->regs->piw[win_idx].piwar,
+			 (piwar | (mem_log - 1)));
+		win_idx--;
+
+		paddr += 1ull << mem_log;
+		sz -= 1ull << mem_log;
+
+		if (sz) {
+			mem_log = ilog2(sz);
+			piwar |= (mem_log - 1);
+
+			out_be32(&pcie->regs->piw[win_idx].pitar,  paddr >> 12);
+			out_be32(&pcie->regs->piw[win_idx].piwbar, paddr >> 12);
+			out_be32(&pcie->regs->piw[win_idx].piwar,  piwar);
+			win_idx--;
+
+			paddr += 1ull << mem_log;
+		}
+
+		pcie->dma_window_base_cur = 0x00000000;
+		pcie->dma_window_size = (resource_size_t)paddr;
+	}
+
+	if (pcie->dma_window_size < mem) {
+#ifndef CONFIG_SWIOTLB
+		dev_err(pcie->dev, "Memory size exceeds PCI ATMU ability to "
+			"map - enable CONFIG_SWIOTLB to avoid dma errors.\n");
+#endif
+		/* adjusting outbound windows could reclaim space in mem map */
+		if (paddr_hi < 0xffffffffull)
+			dev_warn(pcie->dev, "Outbound window cfg leaves "
+				"gaps in memory map. Adjusting the memory map "
+				"could reduce unnecessary bounce buffering.\n");
+
+		dev_info(pcie->dev, "DMA window size is 0x%llx\n",
+			 (u64)pcie->dma_window_size);
+	}
+}
+
+static void __init setup_pci_cmd(struct fsl_pcie *pcie)
+{
+	u16 cmd;
+	int cap_x;
+
+	early_fsl_read_config_word(pcie, 0, 0, PCI_COMMAND, &cmd);
+	cmd |= PCI_COMMAND_SERR | PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY
+		| PCI_COMMAND_IO;
+	early_fsl_write_config_word(pcie, 0, 0, PCI_COMMAND, cmd);
+
+	cap_x = early_fsl_find_capability(pcie, 0, 0, PCI_CAP_ID_PCIX);
+	if (cap_x) {
+		int pci_x_cmd = cap_x + PCI_X_CMD;
+		cmd = PCI_X_CMD_MAX_SPLIT | PCI_X_CMD_MAX_READ
+			| PCI_X_CMD_ERO | PCI_X_CMD_DPERR_E;
+		early_fsl_write_config_word(pcie, 0, 0, pci_x_cmd, cmd);
+	} else
+		early_fsl_write_config_byte(pcie, 0, 0, PCI_LATENCY_TIMER,
+					    0x80);
+}
+
+static int __init
+fsl_pcie_setup(struct platform_device *pdev, struct fsl_pcie *pcie)
+{
+	struct resource *rsrc;
+	u8 hdr_type, progif;
+	struct device_node *dn;
+	struct of_pci_range range;
+	struct of_pci_range_parser parser;
+	int mem = 0;
+
+	dn = pdev->dev.of_node;
+	pcie->dn = dn;
+	pcie->dev = &pdev->dev;
+
+	dev_info(&pdev->dev, "Find controller %s\n", dn->full_name);
+
+	/* Fetch host bridge registers address */
+	rsrc = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!rsrc) {
+		dev_err(&pdev->dev, "Can't get pci register base!");
+		return -EINVAL;
+	}
+	dev_info(&pdev->dev, "REG 0x%016llx..0x%016llx\n",
+		 (u64)rsrc->start, (u64)rsrc->end);
+
+	/* Parse pci range resources from device tree */
+	if (of_pci_range_parser_init(&parser, dn)) {
+		dev_err(&pdev->dev, "missing ranges property\n");
+		return -EINVAL;
+	}
+
+	/* Get the I/O and memory ranges from device tree */
+	for_each_of_pci_range(&parser, &range) {
+		unsigned long restype = range.flags & IORESOURCE_TYPE_BITS;
+		if (restype == IORESOURCE_IO) {
+			of_pci_range_to_resource(&range, dn,
+						 &pcie->io_resource);
+			pcie->io_resource.name = "I/O";
+			pcie->io_resource.start = range.pci_addr;
+			pcie->io_resource.end = range.pci_addr + range.size - 1;
+			pcie->pci_io_size = range.size;
+			pcie->io_base_phys = range.cpu_addr - range.pci_addr;
+			dev_info(&pdev->dev,
+				 " IO 0x%016llx..0x%016llx -> 0x%016llx\n",
+				 range.cpu_addr,
+				 range.cpu_addr + range.size - 1,
+				 range.pci_addr);
+		}
+		if (restype == IORESOURCE_MEM) {
+			if (mem >= 3)
+				continue;
+			of_pci_range_to_resource(&range, dn,
+						 &pcie->mem_resources[mem]);
+			pcie->mem_resources[mem].name = "MEM";
+			pcie->mem_offset[mem] = range.cpu_addr - range.pci_addr;
+			dev_info(&pdev->dev,
+				 "MEM 0x%016llx..0x%016llx -> 0x%016llx\n",
+				 (u64)pcie->mem_resources[mem].start,
+				 (u64)pcie->mem_resources[mem].end,
+				 range.pci_addr);
+		}
+	}
+
+	/* Get bus range */
+	if (of_pci_parse_bus_range(dn, &pcie->busn)) {
+		dev_err(&pdev->dev, "failed to parse bus-range property\n");
+		pcie->first_busno = 0x0;
+		pcie->last_busno = 0xff;
+	} else {
+		pcie->first_busno = pcie->busn.start;
+		pcie->last_busno = pcie->busn.end;
+	}
+	dev_info(&pdev->dev, "Firmware bus number %d->%d\n",
+		 pcie->first_busno, pcie->last_busno);
+
+	pcie->regs = devm_ioremap_resource(&pdev->dev, rsrc);
+	if (IS_ERR(pcie->regs))
+		return PTR_ERR(pcie->regs);
+
+	pcie->ops = &fsl_indirect_pci_ops;
+	pcie->indirect_type = INDIRECT_TYPE_BIG_ENDIAN;
+
+	if (in_be32(&pcie->regs->block_rev1) < PCIE_IP_REV_3_0)
+		pcie->indirect_type |= INDIRECT_TYPE_FSL_CFG_REG_LINK;
+
+	pcie->is_pcie = early_fsl_find_capability(pcie, 0, 0, PCI_CAP_ID_EXP);
+	if (pcie->is_pcie) {
+		/* For PCIE read HEADER_TYPE to identify controller mode */
+		early_fsl_read_config_byte(pcie, 0, 0, PCI_HEADER_TYPE,
+					   &hdr_type);
+		if ((hdr_type & 0x7f) == PCI_HEADER_TYPE_NORMAL)
+			goto ep_mode;
+	} else {
+		/* For PCI read PROG to identify controller mode */
+		early_fsl_read_config_byte(pcie, 0, 0, PCI_CLASS_PROG, &progif);
+		if ((progif & 1) == 1)
+			goto ep_mode;
+	}
+
+	setup_pci_cmd(pcie);
+
+	/* check PCI express link status */
+	if (pcie->is_pcie) {
+		pcie->indirect_type |= INDIRECT_TYPE_EXT_REG |
+				       INDIRECT_TYPE_SURPRESS_PRIMARY_BUS;
+		if (fsl_pcie_check_link(pcie))
+			pcie->indirect_type |= INDIRECT_TYPE_NO_PCIE_LINK;
+	}
+
+	/* Setup PEX window registers */
+	setup_pci_atmu(pcie);
+
+	platform_set_drvdata(pdev, pcie);
+
+	return 0;
+
+ep_mode:
+	dev_info(&pdev->dev, "It works as EP mode\n");
+	return -EPERM;
+}
+
+static int __init fsl_pcie_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct fsl_pcie *pcie;
+
+	if (!of_device_is_available(pdev->dev.of_node)) {
+		dev_err(&pdev->dev, "disabled\n");
+		return -ENODEV;
+	}
+
+	if (!fsl_pcie_sys_register) {
+		dev_err(&pdev->dev,
+			"no fsl_pcie_sys_register implementation\n");
+		return -EPERM;
+	}
+
+	pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
+	if (!pcie) {
+		dev_err(&pdev->dev, "no memory for fsl_pcie\n");
+		return -ENOMEM;
+	}
+
+	ret = fsl_pcie_setup(pdev, pcie);
+	if (ret)
+		return ret;
+
+	ret = fsl_pcie_sys_register(pcie);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register pcie to soc\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int __exit fsl_pcie_remove(struct platform_device *pdev)
+{
+	struct fsl_pcie *pcie = platform_get_drvdata(pdev);
+
+	if (!pcie)
+		return -ENODEV;
+
+	if (fsl_pcie_sys_remove)
+		fsl_pcie_sys_remove(pcie);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int fsl_pci_resume(struct device *dev)
+{
+	struct fsl_pcie *pcie = dev_get_drvdata(dev);
+
+	if (!pcie)
+		return -ENODEV;
+
+	setup_pci_atmu(pcie);
+
+	return 0;
+}
+
+static const struct dev_pm_ops pci_pm_ops = {
+	.resume = fsl_pci_resume,
+};
+
+#define PCI_PM_OPS (&pci_pm_ops)
+
+#else
+
+#define PCI_PM_OPS NULL
+
+#endif
+
+static struct platform_driver fsl_pcie_driver = {
+	.driver = {
+		.name = "fsl-pcie",
+		.pm = PCI_PM_OPS,
+		.of_match_table = fsl_pci_ids,
+	},
+	.probe = fsl_pcie_probe,
+	.remove = fsl_pcie_remove,
+};
+
+static int __init fsl_pcie_init(void)
+{
+	return platform_driver_register(&fsl_pcie_driver);
+}
+
+arch_initcall(fsl_pcie_init);
diff --git a/include/linux/fsl/fsl-pcie.h b/include/linux/fsl/fsl-pcie.h
new file mode 100644
index 0000000..21c94d8
--- /dev/null
+++ b/include/linux/fsl/fsl-pcie.h
@@ -0,0 +1,176 @@
+/*
+ * MPC85xx/86xx/LS PCI Express structure define
+ *
+ * Copyright 2013 Freescale Semiconductor, Inc
+ *
+ * Moved from arch/powerpc/sysdev/fsl_pci.h
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+
+#ifdef __KERNEL__
+#ifndef __FSL_PCIE_H
+#define __FSL_PCIE_H
+
+#define PCIE_LTSSM		0x0404	   /* PCIE Link Training and Status */
+#define PCIE_LTSSM_L0		0x16	   /* L0 state */
+#define PCIE_IP_REV_2_2		0x02080202 /* PCIE IP block version Rev2.2 */
+#define PCIE_IP_REV_3_0		0x02080300 /* PCIE IP block version Rev3.0 */
+#define PIWAR_EN		0x80000000 /* Enable */
+#define PIWAR_PF		0x20000000 /* prefetch */
+#define PIWAR_TGI_LOCAL		0x00f00000 /* target - local memory */
+#define PIWAR_READ_SNOOP	0x00050000
+#define PIWAR_WRITE_SNOOP	0x00005000
+#define PIWAR_SZ_MASK		0x0000003f
+
+/* PCI/PCI Express outbound window reg */
+struct pci_outbound_window_regs {
+	__be32	potar;	/* 0x.0 - Outbound translation address register */
+	__be32	potear;	/* 0x.4 - Outbound translation extended address register */
+	__be32	powbar;	/* 0x.8 - Outbound window base address register */
+	u8	res1[4];
+	__be32	powar;	/* 0x.10 - Outbound window attributes register */
+	u8	res2[12];
+};
+
+/* PCI/PCI Express inbound window reg */
+struct pci_inbound_window_regs {
+	__be32	pitar;	/* 0x.0 - Inbound translation address register */
+	u8	res1[4];
+	__be32	piwbar;	/* 0x.8 - Inbound window base address register */
+	__be32	piwbear;	/* 0x.c - Inbound window base extended address register */
+	__be32	piwar;	/* 0x.10 - Inbound window attributes register */
+	u8	res2[12];
+};
+
+/* PCI/PCI Express IO block registers for 85xx/86xx/LS */
+struct ccsr_pci {
+	__be32	config_addr;		/* 0x.000 - PCI/PCIE Configuration Address Register */
+	__be32	config_data;		/* 0x.004 - PCI/PCIE Configuration Data Register */
+	__be32	int_ack;		/* 0x.008 - PCI Interrupt Acknowledge Register */
+	__be32	pex_otb_cpl_tor;	/* 0x.00c - PCIE Outbound completion timeout register */
+	__be32	pex_conf_tor;		/* 0x.010 - PCIE configuration timeout register */
+	__be32	pex_config;		/* 0x.014 - PCIE CONFIG Register */
+	__be32	pex_int_status;		/* 0x.018 - PCIE interrupt status */
+	u8	res2[4];
+	__be32	pex_pme_mes_dr;		/* 0x.020 - PCIE PME and message detect register */
+	__be32	pex_pme_mes_disr;	/* 0x.024 - PCIE PME and message disable register */
+	__be32	pex_pme_mes_ier;	/* 0x.028 - PCIE PME and message interrupt enable register */
+	__be32	pex_pmcr;		/* 0x.02c - PCIE power management command register */
+	u8	res3[3016];
+	__be32	block_rev1;	/* 0x.bf8 - PCIE Block Revision register 1 */
+	__be32	block_rev2;	/* 0x.bfc - PCIE Block Revision register 2 */
+
+/*
+ * PCI/PCI Express outbound window 0-4
+ * Window 0 is the default window and is the only window enabled upon reset.
+ * The default outbound register set is used when a transaction misses
+ * in all of the other outbound windows.
+ */
+	struct pci_outbound_window_regs pow[5];
+	u8	res14[96];
+	struct pci_inbound_window_regs	pmit;	/* 0xd00 - 0xd9c Inbound MSI */
+	u8	res6[96];
+/*
+ * PCI/PCI Express inbound window 3-0
+ * inbound window 1 supports only a 32-bit base address and does not
+ * define an inbound window base extended address register.
+ */
+	struct pci_inbound_window_regs piw[4];
+
+	__be32	pex_err_dr;		/* 0x.e00 - PCI/PCIE error detect register */
+	u8	res21[4];
+	__be32	pex_err_en;		/* 0x.e08 - PCI/PCIE error interrupt enable register */
+	u8	res22[4];
+	__be32	pex_err_disr;		/* 0x.e10 - PCI/PCIE error disable register */
+	u8	res23[12];
+	__be32	pex_err_cap_stat;	/* 0x.e20 - PCI/PCIE error capture status register */
+	u8	res24[4];
+	__be32	pex_err_cap_r0;		/* 0x.e28 - PCIE error capture register 0 */
+	__be32	pex_err_cap_r1;		/* 0x.e2c - PCIE error capture register 0 */
+	__be32	pex_err_cap_r2;		/* 0x.e30 - PCIE error capture register 0 */
+	__be32	pex_err_cap_r3;		/* 0x.e34 - PCIE error capture register 0 */
+	u8	res_e38[200];
+	__be32	pdb_stat;		/* 0x.f00 - PCIE Debug Status */
+	u8	res_f04[16];
+	__be32	pex_csr0;		/* 0x.f14 - PEX Control/Status register 0*/
+#define PEX_CSR0_LTSSM_MASK	0xFC
+#define PEX_CSR0_LTSSM_SHIFT	2
+#define PEX_CSR0_LTSSM_L0	0x11
+	__be32	pex_csr1;		/* 0x.f18 - PEX Control/Status register 1*/
+	u8	res_f1c[228];
+
+};
+
+/*
+ * Structure of a PCI controller (host bridge)
+ */
+struct fsl_pcie {
+	struct list_head node;
+	int is_pcie;
+	struct device_node *dn;
+	struct device *dev;
+
+	int first_busno;
+	int last_busno;
+	int self_busno;
+	struct resource busn;
+
+	struct pci_ops *ops;
+	struct ccsr_pci __iomem *regs;
+
+	u32 indirect_type;
+
+	struct resource io_resource;
+	resource_size_t io_base_phys;
+	resource_size_t pci_io_size;
+
+	struct resource mem_resources[3];
+	resource_size_t mem_offset[3];
+
+	int global_number;	/* PCI domain number */
+
+	resource_size_t dma_window_base_cur;
+	resource_size_t dma_window_size;
+
+	void *sys;
+};
+
+/* Return link status 0-> link, 1-> no link*/
+int fsl_pcie_check_link(struct fsl_pcie *pcie);
+
+/*
+ * PCI dts node compatible is platform dependent.
+ * So, ids should be defined in platform files.
+ */
+extern const struct of_device_id fsl_pci_ids[];
+
+/*
+ * Convert platform-dependent pci controller structure to fsl_pcie
+ * PowerPC uses structure pci_controller and ARM uses structure pci_sys_data
+ * to describe pci controller.
+ */
+extern struct fsl_pcie *fsl_sys_to_pcie(void *sys);
+
+/*
+ * To fake a PCI bus
+ * it is called by early_fsl_*(), at that time the platform-dependent
+ * pci controller and pci bus have not been created.
+ */
+extern struct pci_bus *fsl_fake_pci_bus(struct fsl_pcie *pcie, int busnr);
+
+/* To avoid touching specified devices */
+extern int fsl_pci_exclude_device(struct fsl_pcie *pcie, u8 bus, u8 devfn);
+
+/* Register PCIe controller to platform */
+extern int __weak fsl_pcie_sys_register(struct fsl_pcie *pcie);
+
+/* Remove PCIe controller from platform */
+extern void __weak fsl_pcie_sys_remove(struct fsl_pcie *pcie);
+
+#endif /* __FSL_PCIE_H */
+#endif /* __KERNEL__ */
-- 
1.8.1.2
