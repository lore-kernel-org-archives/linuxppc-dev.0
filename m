Return-Path: <B31939@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 00AEC2C039B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Sep 2013 20:06:39 +1000 (EST)
From: Minghuan Lian <Minghuan.Lian@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/2][RFC][v3] pci: fsl: rework PCI driver compatible with
 Layerscape
Date: Thu, 12 Sep 2013 18:07:18 +0800
Message-ID: <1378980438-29888-2-git-send-email-Minghuan.Lian@freescale.com>
In-Reply-To: <1378980438-29888-1-git-send-email-Minghuan.Lian@freescale.com>
References: <1378980438-29888-1-git-send-email-Minghuan.Lian@freescale.com>
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

The Freescale's Layerscape series processors will use the same PCI
controller but change cores from PowerPC to ARM. This patch is to
rework FSL PCI driver to support PowerPC and ARM simultaneously.
PowerPC uses structure pci_controller to describe PCI controller,
but arm uses structure hw_pci and pci_sys_data. They also have
different architecture implementation and initialization flow.
The architecture-dependent driver will bridge the gap, get the
settings from the common driver and initialize the corresponding
structure and call the related interface to register PCI controller.
The common driver pci-fsl.c removes all the architecture-specific
code and provides structure fsl_pci to store all the controller
settings and the common functionalities that include reading/writing
PCI configuration space, parsing dts node and getting the MEM/IO and
bus number ranges, setting ATMU and check link status.

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
Based on upstream master
The function has been tested on MPC8315ERDB MPC8572DS P5020DS P3041DS
and T4240QDS boards 

Change log:
v3:
1. use 'fsl_arch' as function name prefix of all the
   architecture-specific hooks.
2. Move PCI compatible definitions from arch/powerpc/sysdev/fsl_pci.c
   to driver/pci/host/pci-fsl.c 

v2:
1. Use 'pci' instead of 'pcie' in new file name and file contents. 
2. Use iowrite32be()/iowrite32() instead of out_be32/le32()
3. Fix ppc_md.dma_set_mask setting
4. Synchronizes host->first_busno and pci->first_busno.
5. Fix PCI IO space settings
6. Some small changes according to Scott's comments.


 arch/powerpc/Kconfig          |   1 +
 arch/powerpc/sysdev/fsl_pci.c | 150 +++++++++-
 drivers/edac/mpc85xx_edac.c   |   9 -
 drivers/pci/host/Kconfig      |   4 +
 drivers/pci/host/Makefile     |   1 +
 drivers/pci/host/pci-fsl.c    | 656 +++++++++++++++++++++++++++---------------
 include/linux/fsl/pci.h       |  69 +++++
 7 files changed, 648 insertions(+), 242 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 6b7530f..657d90f 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -691,6 +691,7 @@ config FSL_SOC
 
 config FSL_PCI
  	bool
+	select PCI_FSL if FSL_SOC_BOOKE || PPC_86xx
 	select PPC_INDIRECT_PCI
 	select PCI_QUIRKS
 
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index a189ff0..4cb12e8 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -62,7 +62,11 @@ static void quirk_fsl_pcie_header(struct pci_dev *dev)
 #if defined(CONFIG_FSL_SOC_BOOKE) || defined(CONFIG_PPC_86xx)
 
 #define MAX_PHYS_ADDR_BITS	40
-static u64 pci64_dma_offset = 1ull << MAX_PHYS_ADDR_BITS;
+
+u64 fsl_arch_pci64_dma_offset(void)
+{
+	return 1ull << MAX_PHYS_ADDR_BITS;
+}
 
 static int fsl_pci_dma_set_mask(struct device *dev, u64 dma_mask)
 {
@@ -77,17 +81,43 @@ static int fsl_pci_dma_set_mask(struct device *dev, u64 dma_mask)
 	if ((dev->bus == &pci_bus_type) &&
 	    dma_mask >= DMA_BIT_MASK(MAX_PHYS_ADDR_BITS)) {
 		set_dma_ops(dev, &dma_direct_ops);
-		set_dma_offset(dev, pci64_dma_offset);
+		set_dma_offset(dev, fsl_arch_pci64_dma_offset());
 	}
 
 	*dev->dma_mask = dma_mask;
 	return 0;
 }
 
+struct fsl_pci *fsl_arch_sys_to_pci(void *sys)
+{
+	struct pci_controller *hose = sys;
+	struct fsl_pci *pci = hose->private_data;
+
+	/* Update the first bus number */
+	if (pci->first_busno != hose->first_busno)
+		pci->first_busno = hose->first_busno;
+
+	return pci;
+}
+
+struct pci_bus *fsl_arch_fake_pci_bus(struct fsl_pci *pci, int busnr)
+{
+	static struct pci_bus bus;
+	static struct pci_controller hose;
+
+	bus.number = busnr;
+	bus.sysdata = &hose;
+	hose.private_data = pci;
+	bus.ops = pci->ops;
+
+	return &bus;
+}
+
 void fsl_pcibios_fixup_bus(struct pci_bus *bus)
 {
 	struct pci_controller *hose = pci_bus_to_host(bus);
-	int i, is_pcie = 0, no_link;
+	int i, is_pcie, no_link;
+	struct fsl_pci *pci = fsl_arch_sys_to_pci(hose);
 
 	/* The root complex bridge comes up with bogus resources,
 	 * we copy the PHB ones in.
@@ -97,9 +127,8 @@ void fsl_pcibios_fixup_bus(struct pci_bus *bus)
 	 * tricky.
 	 */
 
-	if (fsl_pcie_bus_fixup)
-		is_pcie = early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP);
-	no_link = !!(hose->indirect_type & PPC_INDIRECT_TYPE_NO_PCIE_LINK);
+	is_pcie = pci->is_pcie;
+	no_link = fsl_pci_check_link(pci);
 
 	if (bus->parent == hose->bus && (is_pcie || no_link)) {
 		for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; ++i) {
@@ -121,6 +150,94 @@ void fsl_pcibios_fixup_bus(struct pci_bus *bus)
 	}
 }
 
+int fsl_arch_pci_exclude_device(struct fsl_pci *pci, u8 bus, u8 devfn)
+{
+	struct pci_controller *hose = pci->sys;
+
+	if (!hose)
+		return PCIBIOS_SUCCESSFUL;
+
+	if (ppc_md.pci_exclude_device)
+		if (ppc_md.pci_exclude_device(hose, bus, devfn))
+			return PCIBIOS_DEVICE_NOT_FOUND;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+int fsl_arch_pci_sys_register(struct fsl_pci *pci)
+{
+	struct pci_controller *hose;
+
+	pci_add_flags(PCI_REASSIGN_ALL_BUS);
+	hose = pcibios_alloc_controller(pci->dn);
+	if (!hose)
+		return -ENOMEM;
+
+	/* set platform device as the parent */
+	hose->private_data = pci;
+	hose->parent = pci->dev;
+	hose->first_busno = pci->first_busno;
+	hose->last_busno = pci->last_busno;
+	hose->ops = pci->ops;
+
+#ifdef CONFIG_PPC32
+	/* On 32 bits, limit I/O space to 16MB */
+	if (pci->pci_io_size > 0x01000000)
+		pci->pci_io_size = 0x01000000;
+
+	/* 32 bits needs to map IOs here */
+	hose->io_base_virt = ioremap(pci->io_base_phys + pci->io_resource.start,
+				     pci->pci_io_size);
+
+	/* Expect trouble if pci_addr is not 0 */
+	if (fsl_pci_primary == pci->dn)
+		isa_io_base = (unsigned long)hose->io_base_virt;
+#endif /* CONFIG_PPC32 */
+
+	hose->pci_io_size = pci->io_resource.start + pci->pci_io_size;
+	hose->io_base_phys = pci->io_base_phys;
+	hose->io_resource = pci->io_resource;
+
+	memcpy(hose->mem_offset, pci->mem_offset, sizeof(hose->mem_offset));
+	memcpy(hose->mem_resources, pci->mem_resources,
+		sizeof(hose->mem_resources));
+	hose->dma_window_base_cur = pci->dma_window_base_cur;
+	hose->dma_window_size = pci->dma_window_size;
+
+	pci->sys = hose;
+
+	/*
+	 * Install our own dma_set_mask handler to fixup dma_ops
+	 * and dma_offset when memory is more than dma window size
+	 */
+	if (pci->is_pcie && memblock_end_of_DRAM() > hose->dma_window_size)
+		ppc_md.dma_set_mask = fsl_pci_dma_set_mask;
+
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
+
+	mpc85xx_pci_err_probe(to_platform_device(pci->dev));
+	return 0;
+}
+
+void fsl_arch_pci_sys_remove(struct fsl_pci *pci)
+{
+	struct pci_controller *hose = pci->sys;
+
+	if (!hose)
+		return;
+
+	pcibios_free_controller(hose);
+}
+
 #endif /* CONFIG_FSL_SOC_BOOKE || CONFIG_PPC_86xx */
 
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID, quirk_fsl_pcie_header);
@@ -260,6 +377,19 @@ static struct pci_ops mpc83xx_pcie_ops = {
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
@@ -294,7 +424,7 @@ static int __init mpc83xx_pcie_setup(struct pci_controller *hose,
 	out_le32(pcie->cfg_type0 + PEX_OUTWIN0_TAH, 0);
 	out_le32(pcie->cfg_type0 + PEX_OUTWIN0_TAL, 0);
 
-	if (fsl_pcie_check_link(hose))
+	if (mpc83xx_pcie_check_link(hose))
 		hose->indirect_type |= PPC_INDIRECT_TYPE_NO_PCIE_LINK;
 
 	return 0;
@@ -592,6 +722,7 @@ int fsl_pci_mcheck_exception(struct pt_regs *regs)
 #if defined(CONFIG_FSL_SOC_BOOKE) || defined(CONFIG_PPC_86xx)
 
 struct device_node *fsl_pci_primary;
+extern const struct of_device_id fsl_pci_ids[];
 
 void fsl_pci_assign_primary(void)
 {
@@ -607,7 +738,8 @@ void fsl_pci_assign_primary(void)
 		of_node_put(np);
 		np = fsl_pci_primary;
 
-		if (of_match_node(pci_ids, np) && of_device_is_available(np))
+		if (of_match_node(fsl_pci_ids, np) &&
+		    of_device_is_available(np))
 			return;
 	}
 
@@ -616,7 +748,7 @@ void fsl_pci_assign_primary(void)
 	 * designate one as primary.  This can go away once
 	 * various bugs with primary-less systems are fixed.
 	 */
-	for_each_matching_node(np, pci_ids) {
+	for_each_matching_node(np, fsl_pci_ids) {
 		if (of_device_is_available(np)) {
 			fsl_pci_primary = np;
 			of_node_put(np);
diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
index 3eb32f6..93203e3 100644
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
@@ -260,14 +259,6 @@ int mpc85xx_pci_err_probe(struct platform_device *op)
 	/* we only need the error registers */
 	r.start += 0xe00;
 
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
index 3d95048..37d25ae 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -19,4 +19,8 @@ config PCI_TEGRA
 	bool "NVIDIA Tegra PCIe controller"
 	depends on ARCH_TEGRA
 
+config PCI_FSL
+	bool "Freescale PCI/PCIe controller"
+	depends on FSL_SOC_BOOKE || PPC_86xx
+
 endmenu
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index c9a997b..3447a27 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -2,3 +2,4 @@ obj-$(CONFIG_PCIE_DW) += pcie-designware.o
 obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
 obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
 obj-$(CONFIG_PCI_TEGRA) += pci-tegra.o
+obj-$(CONFIG_PCI_FSL) += pci-fsl.o
diff --git a/drivers/pci/host/pci-fsl.c b/drivers/pci/host/pci-fsl.c
index 69d338b..07d553a 100644
--- a/drivers/pci/host/pci-fsl.c
+++ b/drivers/pci/host/pci-fsl.c
@@ -22,38 +22,159 @@
 #include <linux/bootmem.h>
 #include <linux/memblock.h>
 #include <linux/log2.h>
-#include <linux/slab.h>
-#include <linux/uaccess.h>
-
-#include <asm/io.h>
-#include <asm/prom.h>
-#include <asm/pci-bridge.h>
-#include <asm/ppc-pci.h>
-#include <asm/machdep.h>
-#include <asm/disassemble.h>
-#include <asm/ppc-opcode.h>
-#include <sysdev/fsl_soc.h>
-#include <sysdev/fsl_pci.h>
-
-static int fsl_pcie_check_link(struct pci_controller *hose)
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_pci.h>
+#include <linux/pci_regs.h>
+#include <linux/platform_device.h>
+#include <linux/resource.h>
+#include <linux/types.h>
+#include <linux/memblock.h>
+#include <linux/fsl/pci.h>
+
+/* Indirect type */
+#define INDIRECT_TYPE_EXT_REG			0x00000002
+#define INDIRECT_TYPE_SURPRESS_PRIMARY_BUS	0x00000004
+#define INDIRECT_TYPE_NO_PCIE_LINK		0x00000008
+#define INDIRECT_TYPE_BIG_ENDIAN		0x00000010
+#define INDIRECT_TYPE_FSL_CFG_REG_LINK		0x00000040
+
+u64 __weak fsl_arch_pci64_dma_offset(void)
+{
+	return 0;
+}
+
+struct fsl_pci * __weak fsl_arch_sys_to_pci(void *sys)
+{
+	return NULL;
+}
+
+struct pci_bus * __weak fsl_arch_fake_pci_bus(struct fsl_pci *pci, int busnr)
+{
+	return NULL;
+}
+
+int __weak fsl_arch_pci_exclude_device(struct fsl_pci *pci, u8 bus, u8 devfn)
+{
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int fsl_pci_read_config(struct fsl_pci *pci, int bus, int devfn,
+				int offset, int len, u32 *val)
+{
+	u32 bus_no, reg, data;
+
+	if (pci->indirect_type & INDIRECT_TYPE_NO_PCIE_LINK) {
+		if (bus != pci->first_busno)
+			return PCIBIOS_DEVICE_NOT_FOUND;
+		if (devfn != 0)
+			return PCIBIOS_DEVICE_NOT_FOUND;
+	}
+
+	if (fsl_arch_pci_exclude_device(pci, bus, devfn))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	bus_no = (bus == pci->first_busno) ? pci->self_busno : bus;
+
+	if (pci->indirect_type & INDIRECT_TYPE_EXT_REG)
+		reg = ((offset & 0xf00) << 16) | (offset & 0xfc);
+	else
+		reg = offset & 0xfc;
+
+	if (pci->indirect_type & INDIRECT_TYPE_BIG_ENDIAN)
+		iowrite32be(0x80000000 | (bus_no << 16) | (devfn << 8) | reg,
+			    &pci->regs->config_addr);
+	else
+		iowrite32(0x80000000 | (bus_no << 16) | (devfn << 8) | reg,
+			  &pci->regs->config_addr);
+
+	/*
+	 * Note: the caller has already checked that offset is
+	 * suitably aligned and that len is 1, 2 or 4.
+	 */
+	data = ioread32(&pci->regs->config_data);
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
+static int fsl_pci_write_config(struct fsl_pci *pci, int bus, int devfn,
+				 int offset, int len, u32 val)
+{
+	void __iomem *cfg_data;
+	u32 bus_no, reg;
+
+	if (pci->indirect_type & INDIRECT_TYPE_NO_PCIE_LINK) {
+		if (bus != pci->first_busno)
+			return PCIBIOS_DEVICE_NOT_FOUND;
+		if (devfn != 0)
+			return PCIBIOS_DEVICE_NOT_FOUND;
+	}
+
+	if (fsl_arch_pci_exclude_device(pci, bus, devfn))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	bus_no = (bus == pci->first_busno) ?
+			pci->self_busno : bus;
+
+	if (pci->indirect_type & INDIRECT_TYPE_EXT_REG)
+		reg = ((offset & 0xf00) << 16) | (offset & 0xfc);
+	else
+		reg = offset & 0xfc;
+
+	if (pci->indirect_type & INDIRECT_TYPE_BIG_ENDIAN)
+		iowrite32be(0x80000000 | (bus_no << 16) | (devfn << 8) | reg,
+			    &pci->regs->config_addr);
+	else
+		iowrite32(0x80000000 | (bus_no << 16) | (devfn << 8) | reg,
+			  &pci->regs->config_addr);
+
+	/* suppress setting of PCI_PRIMARY_BUS */
+	if (pci->indirect_type & INDIRECT_TYPE_SURPRESS_PRIMARY_BUS)
+		if ((offset == PCI_PRIMARY_BUS) &&
+		    (bus == pci->first_busno))
+			val &= 0xffffff00;
+
+	/*
+	 * Note: the caller has already checked that offset is
+	 * suitably aligned and that len is 1, 2 or 4.
+	 */
+	cfg_data = ((void *) &(pci->regs->config_data)) + (offset & 3);
+	switch (len) {
+	case 1:
+		iowrite8(val, cfg_data);
+		break;
+	case 2:
+		iowrite16(val, cfg_data);
+		break;
+	default:
+		iowrite32(val, cfg_data);
+		break;
+	}
+	return PCIBIOS_SUCCESSFUL;
+}
+
+int fsl_pci_check_link(struct fsl_pci *pci)
 {
 	u32 val = 0;
 
-	if (hose->indirect_type & PPC_INDIRECT_TYPE_FSL_CFG_REG_LINK) {
-		if (hose->ops->read == fsl_indirect_read_config) {
-			struct pci_bus bus;
-			bus.number = hose->first_busno;
-			bus.sysdata = hose;
-			bus.ops = hose->ops;
-			indirect_read_config(&bus, 0, PCIE_LTSSM, 4, &val);
-		} else
-			early_read_config_dword(hose, 0, 0, PCIE_LTSSM, &val);
+	if (pci->indirect_type & INDIRECT_TYPE_FSL_CFG_REG_LINK) {
+		fsl_pci_read_config(pci, 0, 0, PCIE_LTSSM, 4, &val);
 		if (val < PCIE_LTSSM_L0)
 			return 1;
 	} else {
-		struct ccsr_pci __iomem *pci = hose->private_data;
 		/* for PCIe IP rev 3.0 or greater use CSR0 for link state */
-		val = (in_be32(&pci->pex_csr0) & PEX_CSR0_LTSSM_MASK)
+		val = (in_be32(&pci->regs->pex_csr0) & PEX_CSR0_LTSSM_MASK)
 				>> PEX_CSR0_LTSSM_SHIFT;
 		if (val != PEX_CSR0_LTSSM_L0)
 			return 1;
@@ -65,27 +186,65 @@ static int fsl_pcie_check_link(struct pci_controller *hose)
 static int fsl_indirect_read_config(struct pci_bus *bus, unsigned int devfn,
 				    int offset, int len, u32 *val)
 {
-	struct pci_controller *hose = pci_bus_to_host(bus);
+	struct fsl_pci *pci = fsl_arch_sys_to_pci(bus->sysdata);
+
+	if (!pci)
+		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	if (fsl_pcie_check_link(hose))
-		hose->indirect_type |= PPC_INDIRECT_TYPE_NO_PCIE_LINK;
+	if (fsl_pci_check_link(pci))
+		pci->indirect_type |= INDIRECT_TYPE_NO_PCIE_LINK;
 	else
-		hose->indirect_type &= ~PPC_INDIRECT_TYPE_NO_PCIE_LINK;
+		pci->indirect_type &= ~INDIRECT_TYPE_NO_PCIE_LINK;
 
-	return indirect_read_config(bus, devfn, offset, len, val);
+	return fsl_pci_read_config(pci, bus->number, devfn, offset, len, val);
 }
 
-#if defined(CONFIG_FSL_SOC_BOOKE) || defined(CONFIG_PPC_86xx)
-
-static struct pci_ops fsl_indirect_pcie_ops =
+static int fsl_indirect_write_config(struct pci_bus *bus, unsigned int devfn,
+				     int offset, int len, u32 val)
 {
+	struct fsl_pci *pci = fsl_arch_sys_to_pci(bus->sysdata);
+
+	if (!pci)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	return fsl_pci_write_config(pci, bus->number, devfn,
+				     offset, len, val);
+}
+
+static struct pci_ops fsl_indirect_pci_ops = {
 	.read = fsl_indirect_read_config,
-	.write = indirect_write_config,
+	.write = fsl_indirect_write_config,
 };
 
+#define EARLY_FSL_PCI_OP(rw, size, type)				\
+int early_fsl_##rw##_config_##size(struct fsl_pci *pci, int bus,	\
+				   int devfn, int offset, type value)	\
+{									\
+	return pci_bus_##rw##_config_##size(fsl_arch_fake_pci_bus(pci, bus),\
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
+static int early_fsl_find_capability(struct fsl_pci *pci,
+				     int busnr, int devfn, int cap)
+{
+	struct pci_bus *bus = fsl_arch_fake_pci_bus(pci, busnr);
+
+	if (!bus)
+		return 0;
+
+	return pci_bus_find_capability(bus, devfn, cap);
+}
+
 static int setup_one_atmu(struct ccsr_pci __iomem *pci,
-	unsigned int index, const struct resource *res,
-	resource_size_t offset)
+			  unsigned int index, const struct resource *res,
+			  resource_size_t offset)
 {
 	resource_size_t pci_addr = res->start - offset;
 	resource_size_t phys_addr = res->start;
@@ -106,10 +265,10 @@ static int setup_one_atmu(struct ccsr_pci __iomem *pci,
 		if (index + i >= 5)
 			return -1;
 
-		out_be32(&pci->pow[index + i].potar, pci_addr >> 12);
-		out_be32(&pci->pow[index + i].potear, (u64)pci_addr >> 44);
-		out_be32(&pci->pow[index + i].powbar, phys_addr >> 12);
-		out_be32(&pci->pow[index + i].powar, flags | (bits - 1));
+		iowrite32be(pci_addr >> 12, &pci->pow[index + i].potar);
+		iowrite32be((u64)pci_addr >> 44, &pci->pow[index + i].potear);
+		iowrite32be(phys_addr >> 12, &pci->pow[index + i].powbar);
+		iowrite32be(flags | (bits - 1), &pci->pow[index + i].powar);
 
 		pci_addr += (resource_size_t)1U << bits;
 		phys_addr += (resource_size_t)1U << bits;
@@ -120,21 +279,19 @@ static int setup_one_atmu(struct ccsr_pci __iomem *pci,
 }
 
 /* atmu setup for fsl pci/pcie controller */
-static void setup_pci_atmu(struct pci_controller *hose)
+static void setup_pci_atmu(struct fsl_pci *pci)
 {
-	struct ccsr_pci __iomem *pci = hose->private_data;
 	int i, j, n, mem_log, win_idx = 3, start_idx = 1, end_idx = 4;
 	u64 mem, sz, paddr_hi = 0;
 	u64 offset = 0, paddr_lo = ULLONG_MAX;
 	u32 pcicsrbar = 0, pcicsrbar_sz;
 	u32 piwar = PIWAR_EN | PIWAR_PF | PIWAR_TGI_LOCAL |
 			PIWAR_READ_SNOOP | PIWAR_WRITE_SNOOP;
-	const char *name = hose->dn->full_name;
 	const u64 *reg;
 	int len;
 
-	if (early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) {
-		if (in_be32(&pci->block_rev1) >= PCIE_IP_REV_2_2) {
+	if (pci->is_pcie) {
+		if (in_be32(&pci->regs->block_rev1) >= PCIE_IP_REV_2_2) {
 			win_idx = 2;
 			start_idx = 0;
 			end_idx = 3;
@@ -142,47 +299,54 @@ static void setup_pci_atmu(struct pci_controller *hose)
 	}
 
 	/* Disable all windows (except powar0 since it's ignored) */
-	for(i = 1; i < 5; i++)
-		out_be32(&pci->pow[i].powar, 0);
+	for (i = 1; i < 5; i++)
+		iowrite32be(0, &pci->regs->pow[i].powar);
 	for (i = start_idx; i < end_idx; i++)
-		out_be32(&pci->piw[i].piwar, 0);
+		iowrite32be(0, &pci->regs->piw[i].piwar);
 
 	/* Setup outbound MEM window */
-	for(i = 0, j = 1; i < 3; i++) {
-		if (!(hose->mem_resources[i].flags & IORESOURCE_MEM))
+	for (i = 0, j = 1; i < 3; i++) {
+		if (!(pci->mem_resources[i].flags & IORESOURCE_MEM))
 			continue;
 
-		paddr_lo = min(paddr_lo, (u64)hose->mem_resources[i].start);
-		paddr_hi = max(paddr_hi, (u64)hose->mem_resources[i].end);
+		paddr_lo = min_t(u64, paddr_lo, pci->mem_resources[i].start);
+		paddr_hi = max_t(u64, paddr_hi, pci->mem_resources[i].end);
 
 		/* We assume all memory resources have the same offset */
-		offset = hose->mem_offset[i];
-		n = setup_one_atmu(pci, j, &hose->mem_resources[i], offset);
+		offset = pci->mem_offset[i];
+		n = setup_one_atmu(pci->regs, j, &pci->mem_resources[i],
+				   offset);
 
 		if (n < 0 || j >= 5) {
-			pr_err("Ran out of outbound PCI ATMUs for resource %d!\n", i);
-			hose->mem_resources[i].flags |= IORESOURCE_DISABLED;
+			dev_err(pci->dev,
+				"Ran out of outbound PCI ATMUs for resource %d!\n",
+				i);
+			pci->mem_resources[i].flags |= IORESOURCE_DISABLED;
 		} else
 			j += n;
 	}
 
 	/* Setup outbound IO window */
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
+	if (pci->io_resource.flags & IORESOURCE_IO) {
+		if (j >= 5)
+			dev_err(pci->dev,
+				"Ran out of outbound PCI ATMUs for IO resource\n");
+		else {
+			dev_dbg(pci->dev,
+				 "PCI IO resource start 0x%016llx,"
+				 "size 0x%016llx, phy base 0x%016llx.\n",
+				 (u64)pci->io_resource.start,
+				 (u64)resource_size(&pci->io_resource),
+				 (u64)pci->io_base_phys);
+			iowrite32be(pci->io_resource.start >> 12,
+				    &pci->regs->pow[j].potar);
+			iowrite32be(0, &pci->regs->pow[j].potear);
+			iowrite32be(pci->io_base_phys >> 12,
+				    &pci->regs->pow[j].powbar);
 			/* Enable, IO R/W */
-			out_be32(&pci->pow[j].powar, 0x80088000
-				| (ilog2(hose->io_resource.end
-				- hose->io_resource.start + 1) - 1));
+			iowrite32be(0x80088000 |
+				  (ilog2(resource_size(&pci->io_resource)) - 1),
+				  &pci->regs->pow[j].powar);
 		}
 	}
 
@@ -191,18 +355,20 @@ static void setup_pci_atmu(struct pci_controller *hose)
 	paddr_lo -= offset;
 
 	if (paddr_hi == paddr_lo) {
-		pr_err("%s: No outbound window space\n", name);
+		dev_err(pci->dev, "No outbound window space\n");
 		return;
 	}
 
 	if (paddr_lo == 0) {
-		pr_err("%s: No space for inbound window\n", name);
+		dev_err(pci->dev, "No space for inbound window\n");
 		return;
 	}
 
 	/* setup PCSRBAR/PEXCSRBAR */
-	early_write_config_dword(hose, 0, 0, PCI_BASE_ADDRESS_0, 0xffffffff);
-	early_read_config_dword(hose, 0, 0, PCI_BASE_ADDRESS_0, &pcicsrbar_sz);
+	early_fsl_write_config_dword(pci, 0, 0, PCI_BASE_ADDRESS_0,
+				     0xffffffff);
+	early_fsl_read_config_dword(pci, 0, 0, PCI_BASE_ADDRESS_0,
+				    &pcicsrbar_sz);
 	pcicsrbar_sz = ~pcicsrbar_sz + 1;
 
 	if (paddr_hi < (0x100000000ull - pcicsrbar_sz) ||
@@ -210,11 +376,12 @@ static void setup_pci_atmu(struct pci_controller *hose)
 		pcicsrbar = 0x100000000ull - pcicsrbar_sz;
 	else
 		pcicsrbar = (paddr_lo - pcicsrbar_sz) & -pcicsrbar_sz;
-	early_write_config_dword(hose, 0, 0, PCI_BASE_ADDRESS_0, pcicsrbar);
+	early_fsl_write_config_dword(pci, 0, 0, PCI_BASE_ADDRESS_0,
+				     pcicsrbar);
 
-	paddr_lo = min(paddr_lo, (u64)pcicsrbar);
+	paddr_lo = min_t(u64, paddr_lo, pcicsrbar);
 
-	pr_info("%s: PCICSRBAR @ 0x%x\n", name, pcicsrbar);
+	dev_info(pci->dev, "PCICSRBAR @ 0x%x\n", pcicsrbar);
 
 	/* Setup inbound mem window */
 	mem = memblock_end_of_DRAM();
@@ -231,17 +398,19 @@ static void setup_pci_atmu(struct pci_controller *hose)
 	 * can avoid allocating a new ATMU by extending the DDR ATMU by one
 	 * page.
 	 */
-	reg = of_get_property(hose->dn, "msi-address-64", &len);
+	reg = of_get_property(pci->dn, "msi-address-64", &len);
 	if (reg && (len == sizeof(u64))) {
 		u64 address = be64_to_cpup(reg);
 
 		if ((address >= mem) && (address < (mem + PAGE_SIZE))) {
-			pr_info("%s: extending DDR ATMU to cover MSIIR", name);
+			dev_info(pci->dev,
+				 "extending DDR ATMU to cover MSIIR\n");
 			mem += PAGE_SIZE;
 		} else {
 			/* TODO: Create a new ATMU for MSIIR */
-			pr_warn("%s: msi-address-64 address of %llx is "
-				"unsupported\n", name, address);
+			dev_warn(pci->dev,
+				 "msi-address-64 address of %llx is "
+				 "unsupported\n", address);
 		}
 	}
 
@@ -249,25 +418,26 @@ static void setup_pci_atmu(struct pci_controller *hose)
 	mem_log = ilog2(sz);
 
 	/* PCIe can overmap inbound & outbound since RX & TX are separated */
-	if (early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) {
+	if (pci->is_pcie) {
 		/* Size window to exact size if power-of-two or one size up */
 		if ((1ull << mem_log) != mem) {
 			mem_log++;
 			if ((1ull << mem_log) > mem)
-				pr_info("%s: Setting PCI inbound window "
-					"greater than memory size\n", name);
+				dev_info(pci->dev,
+					 "Setting PCI inbound window "
+					 "greater than memory size\n");
 		}
 
 		piwar |= ((mem_log - 1) & PIWAR_SZ_MASK);
 
 		/* Setup inbound memory window */
-		out_be32(&pci->piw[win_idx].pitar,  0x00000000);
-		out_be32(&pci->piw[win_idx].piwbar, 0x00000000);
-		out_be32(&pci->piw[win_idx].piwar,  piwar);
+		iowrite32be(0, &pci->regs->piw[win_idx].pitar);
+		iowrite32be(0, &pci->regs->piw[win_idx].piwbar);
+		iowrite32be(piwar, &pci->regs->piw[win_idx].piwar);
 		win_idx--;
 
-		hose->dma_window_base_cur = 0x00000000;
-		hose->dma_window_size = (resource_size_t)sz;
+		pci->dma_window_base_cur = 0x00000000;
+		pci->dma_window_size = (resource_size_t)sz;
 
 		/*
 		 * if we have >4G of memory setup second PCI inbound window to
@@ -284,28 +454,22 @@ static void setup_pci_atmu(struct pci_controller *hose)
 			piwar = (piwar & ~PIWAR_SZ_MASK) | (mem_log - 1);
 
 			/* Setup inbound memory window */
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
+			iowrite32be(0, &pci->regs->piw[win_idx].pitar);
+			iowrite32be(fsl_arch_pci64_dma_offset() >> 44,
+				    &pci->regs->piw[win_idx].piwbear);
+			iowrite32be(fsl_arch_pci64_dma_offset() >> 12,
+				    &pci->regs->piw[win_idx].piwbar);
+			iowrite32be(piwar,
+				    &pci->regs->piw[win_idx].piwar);
 		}
 	} else {
 		u64 paddr = 0;
 
 		/* Setup inbound memory window */
-		out_be32(&pci->piw[win_idx].pitar,  paddr >> 12);
-		out_be32(&pci->piw[win_idx].piwbar, paddr >> 12);
-		out_be32(&pci->piw[win_idx].piwar,  (piwar | (mem_log - 1)));
+		iowrite32be(paddr >> 12, &pci->regs->piw[win_idx].pitar);
+		iowrite32be(paddr >> 12, &pci->regs->piw[win_idx].piwbar);
+		iowrite32be((piwar | (mem_log - 1)),
+			    &pci->regs->piw[win_idx].piwar);
 		win_idx--;
 
 		paddr += 1ull << mem_log;
@@ -315,167 +479,182 @@ static void setup_pci_atmu(struct pci_controller *hose)
 			mem_log = ilog2(sz);
 			piwar |= (mem_log - 1);
 
-			out_be32(&pci->piw[win_idx].pitar,  paddr >> 12);
-			out_be32(&pci->piw[win_idx].piwbar, paddr >> 12);
-			out_be32(&pci->piw[win_idx].piwar,  piwar);
+			iowrite32be(paddr >> 12,
+				    &pci->regs->piw[win_idx].pitar);
+			iowrite32be(paddr >> 12,
+				    &pci->regs->piw[win_idx].piwbar);
+			iowrite32be(piwar,
+				    &pci->regs->piw[win_idx].piwar);
 			win_idx--;
 
 			paddr += 1ull << mem_log;
 		}
 
-		hose->dma_window_base_cur = 0x00000000;
-		hose->dma_window_size = (resource_size_t)paddr;
+		pci->dma_window_base_cur = 0x00000000;
+		pci->dma_window_size = (resource_size_t)paddr;
 	}
 
-	if (hose->dma_window_size < mem) {
-#ifdef CONFIG_SWIOTLB
-		ppc_swiotlb_enable = 1;
-#else
-		pr_err("%s: ERROR: Memory size exceeds PCI ATMU ability to "
-			"map - enable CONFIG_SWIOTLB to avoid dma errors.\n",
-			 name);
+	if (pci->dma_window_size < mem) {
+#ifndef CONFIG_SWIOTLB
+		dev_err(pci->dev,
+			"Memory size exceeds PCI ATMU ability to "
+			"map - enable CONFIG_SWIOTLB to avoid dma errors.\n");
 #endif
 		/* adjusting outbound windows could reclaim space in mem map */
 		if (paddr_hi < 0xffffffffull)
-			pr_warning("%s: WARNING: Outbound window cfg leaves "
+			dev_warn(pci->dev,
+				 "Outbound window cfg leaves "
 				"gaps in memory map. Adjusting the memory map "
-				"could reduce unnecessary bounce buffering.\n",
-				name);
+				"could reduce unnecessary bounce buffering.\n");
 
-		pr_info("%s: DMA window size is 0x%llx\n", name,
-			(u64)hose->dma_window_size);
+		dev_info(pci->dev, "DMA window size is 0x%llx\n",
+			 (u64)pci->dma_window_size);
 	}
 }
 
-static void __init setup_pci_cmd(struct pci_controller *hose)
+static void __init setup_pci_cmd(struct fsl_pci *pci)
 {
 	u16 cmd;
 	int cap_x;
 
-	early_read_config_word(hose, 0, 0, PCI_COMMAND, &cmd);
+	early_fsl_read_config_word(pci, 0, 0, PCI_COMMAND, &cmd);
 	cmd |= PCI_COMMAND_SERR | PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY
 		| PCI_COMMAND_IO;
-	early_write_config_word(hose, 0, 0, PCI_COMMAND, cmd);
+	early_fsl_write_config_word(pci, 0, 0, PCI_COMMAND, cmd);
 
-	cap_x = early_find_capability(hose, 0, 0, PCI_CAP_ID_PCIX);
+	cap_x = early_fsl_find_capability(pci, 0, 0, PCI_CAP_ID_PCIX);
 	if (cap_x) {
 		int pci_x_cmd = cap_x + PCI_X_CMD;
 		cmd = PCI_X_CMD_MAX_SPLIT | PCI_X_CMD_MAX_READ
 			| PCI_X_CMD_ERO | PCI_X_CMD_DPERR_E;
-		early_write_config_word(hose, 0, 0, pci_x_cmd, cmd);
-	} else {
-		early_write_config_byte(hose, 0, 0, PCI_LATENCY_TIMER, 0x80);
-	}
+		early_fsl_write_config_word(pci, 0, 0, pci_x_cmd, cmd);
+	} else
+		early_fsl_write_config_byte(pci, 0, 0, PCI_LATENCY_TIMER,
+					    0x80);
 }
 
-int __init fsl_add_bridge(struct platform_device *pdev, int is_primary)
+static int __init
+fsl_pci_setup(struct platform_device *pdev, struct fsl_pci *pci)
 {
-	int len;
-	struct pci_controller *hose;
-	struct resource rsrc;
-	const int *bus_range;
+	struct resource *rsrc;
 	u8 hdr_type, progif;
-	struct device_node *dev;
-	struct ccsr_pci __iomem *pci;
+	struct device_node *dn;
+	struct of_pci_range range;
+	struct of_pci_range_parser parser;
+	int mem = 0;
 
-	dev = pdev->dev.of_node;
+	dn = pdev->dev.of_node;
+	pci->dn = dn;
+	pci->dev = &pdev->dev;
 
-	if (!of_device_is_available(dev)) {
-		pr_warning("%s: disabled\n", dev->full_name);
-		return -ENODEV;
-	}
-
-	pr_debug("Adding PCI host bridge %s\n", dev->full_name);
+	dev_info(&pdev->dev, "Find controller %s\n", dn->full_name);
 
 	/* Fetch host bridge registers address */
-	if (of_address_to_resource(dev, 0, &rsrc)) {
-		printk(KERN_WARNING "Can't get pci register base!");
-		return -ENOMEM;
+	rsrc = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!rsrc) {
+		dev_err(&pdev->dev, "Can't get pci register base!");
+		return -EINVAL;
 	}
+	dev_info(&pdev->dev, "REG 0x%016llx..0x%016llx\n",
+		 (u64)rsrc->start, (u64)rsrc->end);
 
-	/* Get bus range if any */
-	bus_range = of_get_property(dev, "bus-range", &len);
-	if (bus_range == NULL || len < 2 * sizeof(int))
-		printk(KERN_WARNING "Can't get bus-range for %s, assume"
-			" bus 0\n", dev->full_name);
-
-	pci_add_flags(PCI_REASSIGN_ALL_BUS);
-	hose = pcibios_alloc_controller(dev);
-	if (!hose)
-		return -ENOMEM;
+	/* Parse pci range resources from device tree */
+	if (of_pci_range_parser_init(&parser, dn)) {
+		dev_err(&pdev->dev, "missing ranges property\n");
+		return -EINVAL;
+	}
 
-	/* set platform device as the parent */
-	hose->parent = &pdev->dev;
-	hose->first_busno = bus_range ? bus_range[0] : 0x0;
-	hose->last_busno = bus_range ? bus_range[1] : 0xff;
+	/* Get the I/O and memory ranges from device tree */
+	for_each_of_pci_range(&parser, &range) {
+		unsigned long restype = range.flags & IORESOURCE_TYPE_BITS;
+		if (restype == IORESOURCE_IO) {
+			of_pci_range_to_resource(&range, dn,
+						 &pci->io_resource);
+			pci->io_resource.name = "I/O";
+			pci->io_resource.start = range.pci_addr;
+			pci->io_resource.end = range.pci_addr + range.size - 1;
+			pci->pci_io_size = range.size;
+			pci->io_base_phys = range.cpu_addr - range.pci_addr;
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
+						 &pci->mem_resources[mem]);
+			pci->mem_resources[mem].name = "MEM";
+			pci->mem_offset[mem] = range.cpu_addr - range.pci_addr;
+			dev_info(&pdev->dev,
+				 "MEM 0x%016llx..0x%016llx -> 0x%016llx\n",
+				 (u64)pci->mem_resources[mem].start,
+				 (u64)pci->mem_resources[mem].end,
+				 range.pci_addr);
+		}
+	}
 
-	pr_debug("PCI memory map start 0x%016llx, size 0x%016llx\n",
-		 (u64)rsrc.start, (u64)resource_size(&rsrc));
+	/* Get bus range */
+	if (of_pci_parse_bus_range(dn, &pci->busn)) {
+		dev_err(&pdev->dev, "failed to parse bus-range property\n");
+		pci->first_busno = 0x0;
+		pci->last_busno = 0xff;
+	} else {
+		pci->first_busno = pci->busn.start;
+		pci->last_busno = pci->busn.end;
+	}
+	dev_info(&pdev->dev, "Firmware bus number %d->%d\n",
+		 pci->first_busno, pci->last_busno);
 
-	pci = hose->private_data = ioremap(rsrc.start, resource_size(&rsrc));
-	if (!hose->private_data)
-		goto no_bridge;
+	pci->regs = devm_ioremap_resource(&pdev->dev, rsrc);
+	if (IS_ERR(pci->regs))
+		return PTR_ERR(pci->regs);
 
-	setup_indirect_pci(hose, rsrc.start, rsrc.start + 0x4,
-			   PPC_INDIRECT_TYPE_BIG_ENDIAN);
+	pci->ops = &fsl_indirect_pci_ops;
+	pci->indirect_type = INDIRECT_TYPE_BIG_ENDIAN;
 
-	if (in_be32(&pci->block_rev1) < PCIE_IP_REV_3_0)
-		hose->indirect_type |= PPC_INDIRECT_TYPE_FSL_CFG_REG_LINK;
+	if (in_be32(&pci->regs->block_rev1) < PCIE_IP_REV_3_0)
+		pci->indirect_type |= INDIRECT_TYPE_FSL_CFG_REG_LINK;
 
-	if (early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) {
-		/* use fsl_indirect_read_config for PCIe */
-		hose->ops = &fsl_indirect_pcie_ops;
-		/* For PCIE read HEADER_TYPE to identify controler mode */
-		early_read_config_byte(hose, 0, 0, PCI_HEADER_TYPE, &hdr_type);
-		if ((hdr_type & 0x7f) != PCI_HEADER_TYPE_BRIDGE)
+	pci->is_pcie = early_fsl_find_capability(pci, 0, 0, PCI_CAP_ID_EXP);
+	if (pci->is_pcie) {
+		/* For PCIE read HEADER_TYPE to identify controller mode */
+		early_fsl_read_config_byte(pci, 0, 0, PCI_HEADER_TYPE,
+					   &hdr_type);
+		if ((hdr_type & 0x7f) == PCI_HEADER_TYPE_NORMAL)
 			goto no_bridge;
-
 	} else {
 		/* For PCI read PROG to identify controller mode */
-		early_read_config_byte(hose, 0, 0, PCI_CLASS_PROG, &progif);
+		early_fsl_read_config_byte(pci, 0, 0, PCI_CLASS_PROG, &progif);
 		if ((progif & 1) == 1)
 			goto no_bridge;
 	}
 
-	setup_pci_cmd(hose);
+	setup_pci_cmd(pci);
 
 	/* check PCI express link status */
-	if (early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) {
-		hose->indirect_type |= PPC_INDIRECT_TYPE_EXT_REG |
-			PPC_INDIRECT_TYPE_SURPRESS_PRIMARY_BUS;
-		if (fsl_pcie_check_link(hose))
-			hose->indirect_type |= PPC_INDIRECT_TYPE_NO_PCIE_LINK;
+	if (pci->is_pcie) {
+		pci->indirect_type |= INDIRECT_TYPE_EXT_REG |
+				       INDIRECT_TYPE_SURPRESS_PRIMARY_BUS;
+		if (fsl_pci_check_link(pci))
+			pci->indirect_type |= INDIRECT_TYPE_NO_PCIE_LINK;
 	}
 
-	printk(KERN_INFO "Found FSL PCI host bridge at 0x%016llx. "
-		"Firmware bus number: %d->%d\n",
-		(unsigned long long)rsrc.start, hose->first_busno,
-		hose->last_busno);
-
-	pr_debug(" ->Hose at 0x%p, cfg_addr=0x%p,cfg_data=0x%p\n",
-		hose, hose->cfg_addr, hose->cfg_data);
-
-	/* Interpret the "ranges" property */
-	/* This also maps the I/O region and sets isa_io/mem_base */
-	pci_process_bridge_OF_ranges(hose, dev, is_primary);
-
 	/* Setup PEX window registers */
-	setup_pci_atmu(hose);
+	setup_pci_atmu(pci);
+
+	platform_set_drvdata(pdev, pci);
 
 	return 0;
 
 no_bridge:
-	iounmap(hose->private_data);
-	/* unmap cfg_data & cfg_addr separately if not on same page */
-	if (((unsigned long)hose->cfg_data & PAGE_MASK) !=
-	    ((unsigned long)hose->cfg_addr & PAGE_MASK))
-		iounmap(hose->cfg_data);
-	iounmap(hose->cfg_addr);
-	pcibios_free_controller(hose);
-	return -ENODEV;
+	dev_info(&pdev->dev, "It works as EP mode\n");
+	return -EPERM;
 }
 
-static const struct of_device_id pci_ids[] = {
+const struct of_device_id fsl_pci_ids[] = {
 	{ .compatible = "fsl,mpc8540-pci", },
 	{ .compatible = "fsl,mpc8548-pcie", },
 	{ .compatible = "fsl,mpc8610-pci", },
@@ -496,35 +675,63 @@ static const struct of_device_id pci_ids[] = {
 	{},
 };
 
-static int fsl_pci_probe(struct platform_device *pdev)
+static int __init fsl_pci_probe(struct platform_device *pdev)
 {
 	int ret;
-	struct device_node *node;
+	struct fsl_pci *pci;
+
+	if (!of_device_is_available(pdev->dev.of_node)) {
+		dev_warn(&pdev->dev, "disabled\n");
+		return -ENODEV;
+	}
+
+	if (!fsl_arch_pci_sys_register) {
+		dev_err(&pdev->dev,
+			"no fsl_arch_pci_sys_register implementation\n");
+		return -EPERM;
+	}
+
+	pci = devm_kzalloc(&pdev->dev, sizeof(*pci), GFP_KERNEL);
+	if (!pci) {
+		dev_err(&pdev->dev, "no memory for fsl_pci\n");
+		return -ENOMEM;
+	}
 
-	node = pdev->dev.of_node;
-	ret = fsl_add_bridge(pdev, fsl_pci_primary == node);
+	ret = fsl_pci_setup(pdev, pci);
+	if (ret)
+		return ret;
 
-	mpc85xx_pci_err_probe(pdev);
+	ret = fsl_arch_pci_sys_register(pci);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register pcie to Arch\n");
+		return ret;
+	}
 
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int fsl_pci_resume(struct device *dev)
+static int __exit fsl_pci_remove(struct platform_device *pdev)
 {
-	struct pci_controller *hose;
-	struct resource pci_rsrc;
+	struct fsl_pci *pci = platform_get_drvdata(pdev);
 
-	hose = pci_find_hose_for_OF_device(dev->of_node);
-	if (!hose)
+	if (!pci)
 		return -ENODEV;
 
-	if (of_address_to_resource(dev->of_node, 0, &pci_rsrc)) {
-		dev_err(dev, "Get pci register base failed.");
+	if (fsl_arch_pci_sys_remove)
+		fsl_arch_pci_sys_remove(pci);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int fsl_pci_resume(struct device *dev)
+{
+	struct fsl_pci *pci = dev_get_drvdata(dev);
+
+	if (!pci)
 		return -ENODEV;
-	}
 
-	setup_pci_atmu(hose);
+	setup_pci_atmu(pci);
 
 	return 0;
 }
@@ -545,9 +752,10 @@ static struct platform_driver fsl_pci_driver = {
 	.driver = {
 		.name = "fsl-pci",
 		.pm = PCI_PM_OPS,
-		.of_match_table = pci_ids,
+		.of_match_table = fsl_pci_ids,
 	},
 	.probe = fsl_pci_probe,
+	.remove = fsl_pci_remove,
 };
 
 static int __init fsl_pci_init(void)
diff --git a/include/linux/fsl/pci.h b/include/linux/fsl/pci.h
index bfc241d..401d840 100644
--- a/include/linux/fsl/pci.h
+++ b/include/linux/fsl/pci.h
@@ -102,5 +102,74 @@ struct ccsr_pci {
 
 };
 
+/*
+ * Structure of a PCI controller (host bridge)
+ */
+struct fsl_pci {
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
+/* Return link status 0-> link, 1-> no link */
+int fsl_pci_check_link(struct fsl_pci *pci);
+
+/*
+ * The fsl_arch_* functions are arch hooks. Those functions are
+ * implemented as weak symbols so that they can be overridden by
+ * architecture specific code if needed.
+ */
+
+/* Return PCI64 DMA offset */
+u64 fsl_arch_pci64_dma_offset(void);
+
+/*
+ * Convert architecture specific pci controller structure to fsl_pci
+ * PowerPC uses structure pci_controller and ARM uses structure pci_sys_data
+ * to describe pci controller.
+ */
+struct fsl_pci *fsl_arch_sys_to_pci(void *sys);
+
+/*
+ * To fake a PCI bus
+ * it is called by early_fsl_*(), at that time the architecture-dependent
+ * pci controller and pci bus have not been created.
+ */
+struct pci_bus *fsl_arch_fake_pci_bus(struct fsl_pci *pci, int busnr);
+
+/* To avoid touching specified devices */
+int fsl_arch_pci_exclude_device(struct fsl_pci *pci, u8 bus, u8 devfn);
+
+/* Register PCI/PCIe controller to architecture system */
+int __weak fsl_arch_pci_sys_register(struct fsl_pci *pci);
+
+/* Remove PCI/PCIe controller from architecture system */
+void __weak fsl_arch_pci_sys_remove(struct fsl_pci *pci);
+
 #endif /* __PCI_H */
 #endif /* __KERNEL__ */
-- 
1.8.1.2
