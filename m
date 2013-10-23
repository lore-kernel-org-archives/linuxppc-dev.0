Return-Path: <B31939@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe001.messaging.microsoft.com [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AE5A32C04D5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Oct 2013 21:42:13 +1100 (EST)
From: Minghuan Lian <Minghuan.Lian@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 08/12][v3] pci: fsl: add PowerPC PCI driver
Date: Wed, 23 Oct 2013 18:41:30 +0800
Message-ID: <1382524894-15164-8-git-send-email-Minghuan.Lian@freescale.com>
In-Reply-To: <1382524894-15164-1-git-send-email-Minghuan.Lian@freescale.com>
References: <1382524894-15164-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Minghuan Lian <Minghuan.Lian@freescale.com>, linux-pci@vger.kernel.org,
 Zang Roy-R61911 <r61911@freescale.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

1. Implement fsl_arch_pci64_dma_offset() to return PowerPC PCI64
DMA offset
2. Implement fsl_arch_sys_to_pci() to convert pci_controller
to fsl_pci
3. Implement fsl_arch_fake_pci_bus() to fake pci_controller
and PCI bus.
4. Implement fsl_arch_pci_exclude_device() to call
ppc_md.pci_exclude_device()
5. Implement fsl_arch_pci_sys_register() to initialize pci_controller
according to fsl_pci, add register PCI controller to PowerPC PCI
subsystem.
6. Implement fsl_arch_pci_sys_remove() to remove PCI controller from
PowerPC PCI subsystem.
7. Add mpc83xx_pcie_check_link() because pci-fsl-common dose not
support mpc83xx.

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
change log:
v1-v3:
Derived from http://patchwork.ozlabs.org/patch/278965/

Based on upstream master.
Based on the discussion of RFC version here
http://patchwork.ozlabs.org/patch/274487/

 arch/powerpc/sysdev/fsl_pci.c | 142 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 135 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 26039e3..0a0c240 100644
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
@@ -77,17 +81,44 @@ static int fsl_pci_dma_set_mask(struct device *dev, u64 dma_mask)
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
+	bool is_pcie, no_link;
+	int i;
+	struct fsl_pci *pci = fsl_arch_sys_to_pci(hose);
 
 	/* The root complex bridge comes up with bogus resources,
 	 * we copy the PHB ones in.
@@ -97,9 +128,8 @@ void fsl_pcibios_fixup_bus(struct pci_bus *bus)
 	 * tricky.
 	 */
 
-	if (fsl_pcie_bus_fixup)
-		is_pcie = early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP);
-	no_link = !!(hose->indirect_type & PPC_INDIRECT_TYPE_NO_PCIE_LINK);
+	is_pcie = pci->is_pcie;
+	no_link = !fsl_pci_check_link(pci);
 
 	if (bus->parent == hose->bus && (is_pcie || no_link)) {
 		for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; ++i) {
@@ -121,6 +151,94 @@ void fsl_pcibios_fixup_bus(struct pci_bus *bus)
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
@@ -260,6 +378,16 @@ static struct pci_ops mpc83xx_pcie_ops = {
 	.write = mpc83xx_pcie_write_config,
 };
 
+static int mpc83xx_pcie_check_link(struct pci_controller *hose)
+{
+	u32 val = 0;
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
@@ -294,7 +422,7 @@ static int __init mpc83xx_pcie_setup(struct pci_controller *hose,
 	out_le32(pcie->cfg_type0 + PEX_OUTWIN0_TAH, 0);
 	out_le32(pcie->cfg_type0 + PEX_OUTWIN0_TAL, 0);
 
-	if (fsl_pcie_check_link(hose))
+	if (mpc83xx_pcie_check_link(hose))
 		hose->indirect_type |= PPC_INDIRECT_TYPE_NO_PCIE_LINK;
 
 	return 0;
-- 
1.8.1.2
