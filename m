Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C3A1B1A0A01
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 14:34:20 +1000 (AEST)
Received: from mail-pa0-x22b.google.com (mail-pa0-x22b.google.com
 [IPv6:2607:f8b0:400e:c03::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 09A441402AE
 for <linuxppc-dev@ozlabs.org>; Tue, 14 Apr 2015 14:34:20 +1000 (AEST)
Received: by pabsx10 with SMTP id sx10so124941067pab.3
 for <linuxppc-dev@ozlabs.org>; Mon, 13 Apr 2015 21:34:18 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org,
	benh@kernel.crashing.org,
	mpe@ellerman.id.au
Subject: [RFC PATCH 1/2] powerpc: Add pci_controller.generic_ops and move
 pci_controller.ops in
Date: Tue, 14 Apr 2015 14:34:00 +1000
Message-Id: <1428986041-25657-2-git-send-email-dja@axtens.net>
In-Reply-To: <1428986041-25657-1-git-send-email-dja@axtens.net>
References: <1428986041-25657-1-git-send-email-dja@axtens.net>
Cc: Yijing Wang <wangyijing@huawei.com>, Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Recent patches have created a pci_host_bridge_ops structure, which is
generic across architectures. This is the first step to making PowerPC
take full advantage of it.

1) Remove the PowerPC-wide generic ops structure in pci-common.c,
   replacing it with 'struct pci_host_bridge_ops generic_ops' to
   pci_controller.  This allows each controller/host bridge to have
   its own generic ops, which will be useful for cxl or if a machine
   has multiple different PHBs.

   The PowerPC-wide generic struct had default ops, so code has been
   added in pci-common.c to populate the controller struct with those
   default ops before passing it to the PCI subsystem. (This goes away
   later in the series.)

2) Remove the pci_ops pointer from pci_controller in favour of the
   pci_ops pointer within pci_host_ops.

Signed-off-by: Daniel Axtens <dja@axtens.net>

---

I'm not super happy with the name 'generic_ops'. I'd call it 'phb_ops', but
that makes distinguishing phb_ops and controller_ops unnecessarily hard.
We do eventually want controller_ops to become arch specific ops (arch_ops perhaps?),
but renaming it now would be very misleading. Suggestions welcome.
---
 arch/powerpc/include/asm/pci-bridge.h       |  2 +-
 arch/powerpc/kernel/pci-common.c            | 17 +++++++++--------
 arch/powerpc/kernel/rtas_pci.c              |  2 +-
 arch/powerpc/platforms/52xx/efika.c         |  2 +-
 arch/powerpc/platforms/52xx/mpc52xx_pci.c   |  2 +-
 arch/powerpc/platforms/chrp/pci.c           |  6 +++---
 arch/powerpc/platforms/maple/pci.c          |  6 +++---
 arch/powerpc/platforms/pasemi/pci.c         |  2 +-
 arch/powerpc/platforms/powermac/pci.c       | 12 ++++++------
 arch/powerpc/platforms/powernv/pci-ioda.c   |  2 +-
 arch/powerpc/platforms/powernv/pci-p5ioc2.c |  2 +-
 arch/powerpc/sysdev/fsl_pci.c               |  6 +++---
 arch/powerpc/sysdev/indirect_pci.c          |  2 +-
 arch/powerpc/sysdev/ppc4xx_pci.c            |  2 +-
 arch/powerpc/sysdev/tsi108_pci.c            |  2 +-
 15 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 4f39ef9..06f072a 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -64,8 +64,8 @@ struct pci_controller {
 	resource_size_t	isa_mem_phys;
 	resource_size_t	isa_mem_size;
 
+	struct pci_host_bridge_ops generic_ops;
 	struct pci_controller_ops controller_ops;
-	struct pci_ops *ops;
 	unsigned int __iomem *cfg_addr;
 	void __iomem *cfg_data;
 
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index ffff706..326d848 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1577,7 +1577,7 @@ fake_pci_bus(struct pci_controller *hose, int busnr)
 	}
 	bus.number = busnr;
 	bus.sysdata = hose;
-	bus.ops = hose? hose->ops: &null_pci_ops;
+	bus.ops = hose ? hose->generic_ops.pci_ops: &null_pci_ops;
 	return &bus;
 }
 
@@ -1609,11 +1609,6 @@ struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus)
 	return of_node_get(hose->dn);
 }
 
-static struct pci_host_bridge_ops pci_host_ops = {
-	.set_root_bus_speed = pcibios_set_root_bus_speed,
-	.scan_bus = pci_host_scan_bus,
-};
-
 /**
  * pci_scan_phb - Given a pci_controller, setup and scan the PCI bus
  * @hose: Pointer to the PCI host controller instance structure
@@ -1637,10 +1632,16 @@ void pcibios_scan_phb(struct pci_controller *hose)
 	hose->busn.flags = IORESOURCE_BUS;
 	pci_add_resource(&resources, &hose->busn);
 
-	pci_host_ops.pci_ops = hose->ops;
+	/* Populate generic ops with defaults */
+	if (!hose->generic_ops.scan_bus)
+		hose->generic_ops.scan_bus = pci_host_scan_bus;
+	if (!hose->generic_ops.set_root_bus_speed)
+		hose->generic_ops.set_root_bus_speed = pcibios_set_root_bus_speed;
+	
 	/* Create an empty bus for the toplevel */
 	host = pci_scan_host_bridge(hose->parent, hose->global_number,
-			hose->first_busno, hose, &resources, &pci_host_ops);
+			hose->first_busno, hose, &resources,
+			&hose->generic_ops);
 	if (host == NULL) {
 		pr_err("Failed to create host bridge for pci%04x:%02x\n",
 			hose->global_number, hose->first_busno);
diff --git a/arch/powerpc/kernel/rtas_pci.c b/arch/powerpc/kernel/rtas_pci.c
index 42db314..71dfe22 100644
--- a/arch/powerpc/kernel/rtas_pci.c
+++ b/arch/powerpc/kernel/rtas_pci.c
@@ -272,7 +272,7 @@ int rtas_setup_phb(struct pci_controller *phb)
 	if (phb_set_bus_ranges(dev, phb))
 		return 1;
 
-	phb->ops = &rtas_pci_ops;
+	phb->generic_ops.pci_ops = &rtas_pci_ops;
 	phb->buid = get_phb_buid(dev);
 
 	return 0;
diff --git a/arch/powerpc/platforms/52xx/efika.c b/arch/powerpc/platforms/52xx/efika.c
index 6af651e..14b7978 100644
--- a/arch/powerpc/platforms/52xx/efika.c
+++ b/arch/powerpc/platforms/52xx/efika.c
@@ -122,7 +122,7 @@ static void __init efika_pcisetup(void)
 
 	hose->first_busno = bus_range[0];
 	hose->last_busno = bus_range[1];
-	hose->ops = &rtas_pci_ops;
+	hose->generic_ops.pci_ops = &rtas_pci_ops;
 
 	pci_process_bridge_OF_ranges(hose, pcictrl, 0);
 	return;
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pci.c b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
index e2d401a..d4bd6f5 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pci.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
@@ -400,7 +400,7 @@ mpc52xx_add_bridge(struct device_node *node)
 	hose->first_busno = bus_range ? bus_range[0] : 0;
 	hose->last_busno = bus_range ? bus_range[1] : 0xff;
 
-	hose->ops = &mpc52xx_pci_ops;
+	hose->generic_ops.pci_ops = &mpc52xx_pci_ops;
 
 	pci_regs = ioremap(rsrc.start, resource_size(&rsrc));
 	if (!pci_regs)
diff --git a/arch/powerpc/platforms/chrp/pci.c b/arch/powerpc/platforms/chrp/pci.c
index 1b87e19..8ce5fd6 100644
--- a/arch/powerpc/platforms/chrp/pci.c
+++ b/arch/powerpc/platforms/chrp/pci.c
@@ -193,7 +193,7 @@ static void __init setup_peg2(struct pci_controller *hose, struct device_node *d
 
 	rtas = of_find_node_by_name (root, "rtas");
 	if (rtas) {
-		hose->ops = &rtas_pci_ops;
+		hose->generic_ops.pci_ops = &rtas_pci_ops;
 		of_node_put(rtas);
 	} else {
 		printk ("RTAS supporting Pegasos OF not found, please upgrade"
@@ -274,7 +274,7 @@ chrp_find_bridges(void)
 			setup_grackle(hose);
 		} else if (is_longtrail) {
 			void __iomem *p = ioremap(GG2_PCI_CONFIG_BASE, 0x80000);
-			hose->ops = &gg2_pci_ops;
+			hose->generic_ops.pci_ops = &gg2_pci_ops;
 			hose->cfg_data = p;
 			gg2_pci_config_base = p;
 		} else if (is_pegasos == 1) {
@@ -299,7 +299,7 @@ chrp_find_bridges(void)
 		} else {
 			printk("No methods for %s (model %s), using RTAS\n",
 			       dev->full_name, model);
-			hose->ops = &rtas_pci_ops;
+			hose->generic_ops.pci_ops = &rtas_pci_ops;
 		}
 
 		pci_process_bridge_OF_ranges(hose, dev, index == 0);
diff --git a/arch/powerpc/platforms/maple/pci.c b/arch/powerpc/platforms/maple/pci.c
index a923230..435462c6c 100644
--- a/arch/powerpc/platforms/maple/pci.c
+++ b/arch/powerpc/platforms/maple/pci.c
@@ -453,7 +453,7 @@ static void __init setup_u3_agp(struct pci_controller* hose)
 	 */
 	hose->first_busno = 0xf0;
 	hose->last_busno = 0xff;
-	hose->ops = &u3_agp_pci_ops;
+	hose->generic_ops.pci_ops = &u3_agp_pci_ops;
 	hose->cfg_addr = ioremap(0xf0000000 + 0x800000, 0x1000);
 	hose->cfg_data = ioremap(0xf0000000 + 0xc00000, 0x1000);
 
@@ -465,7 +465,7 @@ static void __init setup_u4_pcie(struct pci_controller* hose)
         /* We currently only implement the "non-atomic" config space, to
          * be optimised later.
          */
-        hose->ops = &u4_pcie_pci_ops;
+        hose->generic_ops.pci_ops = &u4_pcie_pci_ops;
         hose->cfg_addr = ioremap(0xf0000000 + 0x800000, 0x1000);
         hose->cfg_data = ioremap(0xf0000000 + 0xc00000, 0x1000);
 
@@ -474,7 +474,7 @@ static void __init setup_u4_pcie(struct pci_controller* hose)
 
 static void __init setup_u3_ht(struct pci_controller* hose)
 {
-	hose->ops = &u3_ht_pci_ops;
+	hose->generic_ops.pci_ops = &u3_ht_pci_ops;
 
 	/* We hard code the address because of the different size of
 	 * the reg address cell, we shall fix that by killing struct
diff --git a/arch/powerpc/platforms/pasemi/pci.c b/arch/powerpc/platforms/pasemi/pci.c
index f3a68a0..6c3c9af 100644
--- a/arch/powerpc/platforms/pasemi/pci.c
+++ b/arch/powerpc/platforms/pasemi/pci.c
@@ -185,7 +185,7 @@ static struct pci_ops pa_pxp_ops = {
 
 static void __init setup_pa_pxp(struct pci_controller *hose)
 {
-	hose->ops = &pa_pxp_ops;
+	hose->generic_ops.pci_ops = &pa_pxp_ops;
 	hose->cfg_data = ioremap(0xe0000000, 0x10000000);
 }
 
diff --git a/arch/powerpc/platforms/powermac/pci.c b/arch/powerpc/platforms/powermac/pci.c
index 59ab16f..5fbd9fb 100644
--- a/arch/powerpc/platforms/powermac/pci.c
+++ b/arch/powerpc/platforms/powermac/pci.c
@@ -208,7 +208,7 @@ static void __init setup_chaos(struct pci_controller *hose,
 			       struct resource *addr)
 {
 	/* assume a `chaos' bridge */
-	hose->ops = &chaos_pci_ops;
+	hose->generic_ops.pci_ops = &chaos_pci_ops;
 	hose->cfg_addr = ioremap(addr->start + 0x800000, 0x1000);
 	hose->cfg_data = ioremap(addr->start + 0xc00000, 0x1000);
 }
@@ -607,7 +607,7 @@ static void __init fixup_nec_usb2(void)
 static void __init setup_bandit(struct pci_controller *hose,
 				struct resource *addr)
 {
-	hose->ops = &macrisc_pci_ops;
+	hose->generic_ops.pci_ops = &macrisc_pci_ops;
 	hose->cfg_addr = ioremap(addr->start + 0x800000, 0x1000);
 	hose->cfg_data = ioremap(addr->start + 0xc00000, 0x1000);
 	init_bandit(hose);
@@ -618,7 +618,7 @@ static int __init setup_uninorth(struct pci_controller *hose,
 {
 	pci_add_flags(PCI_REASSIGN_ALL_BUS);
 	has_uninorth = 1;
-	hose->ops = &macrisc_pci_ops;
+	hose->generic_ops.pci_ops = &macrisc_pci_ops;
 	hose->cfg_addr = ioremap(addr->start + 0x800000, 0x1000);
 	hose->cfg_data = ioremap(addr->start + 0xc00000, 0x1000);
 	/* We "know" that the bridge at f2000000 has the PCI slots. */
@@ -641,7 +641,7 @@ static void __init setup_u3_agp(struct pci_controller* hose)
 	hose->first_busno = 0xf0;
 	hose->last_busno = 0xff;
 	has_uninorth = 1;
-	hose->ops = &macrisc_pci_ops;
+	hose->generic_ops.pci_ops = &macrisc_pci_ops;
 	hose->cfg_addr = ioremap(0xf0000000 + 0x800000, 0x1000);
 	hose->cfg_data = ioremap(0xf0000000 + 0xc00000, 0x1000);
 	u3_agp = hose;
@@ -652,7 +652,7 @@ static void __init setup_u4_pcie(struct pci_controller* hose)
 	/* We currently only implement the "non-atomic" config space, to
 	 * be optimised later.
 	 */
-	hose->ops = &u4_pcie_pci_ops;
+	hose->generic_ops.pci_ops = &u4_pcie_pci_ops;
 	hose->cfg_addr = ioremap(0xf0000000 + 0x800000, 0x1000);
 	hose->cfg_data = ioremap(0xf0000000 + 0xc00000, 0x1000);
 
@@ -710,7 +710,7 @@ static void __init setup_u3_ht(struct pci_controller* hose)
 	struct resource cfg_res, self_res;
 	u32 decode;
 
-	hose->ops = &u3_ht_pci_ops;
+	hose->generic_ops.pci_ops = &u3_ht_pci_ops;
 
 	/* Get base addresses from OF tree
 	 */
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index b4e46bf..586f089 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2075,7 +2075,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 			phb->ioda.io_size, phb->ioda.io_segsize);
 
 
-	phb->hose->ops = &pnv_pci_ops;
+	phb->hose->generic_ops.pci_ops = &pnv_pci_ops;
 	phb->get_pe_state = pnv_ioda_get_pe_state;
 	phb->freeze_pe = pnv_ioda_freeze_pe;
 	phb->unfreeze_pe = pnv_ioda_unfreeze_pe;
diff --git a/arch/powerpc/platforms/powernv/pci-p5ioc2.c b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
index 4729ca7..2e12494 100644
--- a/arch/powerpc/platforms/powernv/pci-p5ioc2.c
+++ b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
@@ -162,7 +162,7 @@ static void __init pnv_pci_init_p5ioc2_phb(struct device_node *np, u64 hub_id,
 	pci_process_bridge_OF_ranges(phb->hose, np, primary);
 	primary = 0;
 
-	phb->hose->ops = &pnv_pci_ops;
+	phb->hose->generic_ops.pci_ops = &pnv_pci_ops;
 
 	/* Setup MSI support */
 	pnv_pci_init_p5ioc2_msis(phb);
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 9a8fcf0..05790423 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -68,7 +68,7 @@ static int fsl_pcie_check_link(struct pci_controller *hose)
 	u32 val = 0;
 
 	if (hose->indirect_type & PPC_INDIRECT_TYPE_FSL_CFG_REG_LINK) {
-		if (hose->ops->read == fsl_indirect_read_config)
+		if (hose->generic_ops.pci_ops->read == fsl_indirect_read_config)
 			__indirect_read_config(hose, hose->first_busno, 0,
 					       PCIE_LTSSM, 4, &val);
 		else
@@ -521,7 +521,7 @@ int fsl_add_bridge(struct platform_device *pdev, int is_primary)
 
 	if (early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) {
 		/* use fsl_indirect_read_config for PCIe */
-		hose->ops = &fsl_indirect_pcie_ops;
+		hose->generic_ops.pci_ops = &fsl_indirect_pcie_ops;
 		/* For PCIE read HEADER_TYPE to identify controler mode */
 		early_read_config_byte(hose, 0, 0, PCI_HEADER_TYPE, &hdr_type);
 		if ((hdr_type & 0x7f) != PCI_HEADER_TYPE_BRIDGE)
@@ -703,7 +703,7 @@ static int __init mpc83xx_pcie_setup(struct pci_controller *hose,
 
 	WARN_ON(hose->dn->data);
 	hose->dn->data = pcie;
-	hose->ops = &mpc83xx_pcie_ops;
+	hose->generic_ops.pci_ops = &mpc83xx_pcie_ops;
 	hose->indirect_type |= PPC_INDIRECT_TYPE_FSL_CFG_REG_LINK;
 
 	out_le32(pcie->cfg_type0 + PEX_OUTWIN0_TAH, 0);
diff --git a/arch/powerpc/sysdev/indirect_pci.c b/arch/powerpc/sysdev/indirect_pci.c
index 692de9d..8787695 100644
--- a/arch/powerpc/sysdev/indirect_pci.c
+++ b/arch/powerpc/sysdev/indirect_pci.c
@@ -172,6 +172,6 @@ void setup_indirect_pci(struct pci_controller *hose, resource_size_t cfg_addr,
 	if ((cfg_data & PAGE_MASK) != base)
 		mbase = ioremap(cfg_data & PAGE_MASK, PAGE_SIZE);
 	hose->cfg_data = mbase + (cfg_data & ~PAGE_MASK);
-	hose->ops = &indirect_pci_ops;
+	hose->generic_ops.pci_ops = &indirect_pci_ops;
 	hose->indirect_type = flags;
 }
diff --git a/arch/powerpc/sysdev/ppc4xx_pci.c b/arch/powerpc/sysdev/ppc4xx_pci.c
index 086aca6..9c8b4c5 100644
--- a/arch/powerpc/sysdev/ppc4xx_pci.c
+++ b/arch/powerpc/sysdev/ppc4xx_pci.c
@@ -1994,7 +1994,7 @@ static void __init ppc4xx_pciex_port_setup_hose(struct ppc4xx_pciex_port *port)
 		 hose->cfg_addr, hose->cfg_data);
 
 	/* Setup config space */
-	hose->ops = &ppc4xx_pciex_pci_ops;
+	hose->generic_ops.pci_ops = &ppc4xx_pciex_pci_ops;
 	port->hose = hose;
 	mbase = (void __iomem *)hose->cfg_addr;
 
diff --git a/arch/powerpc/sysdev/tsi108_pci.c b/arch/powerpc/sysdev/tsi108_pci.c
index 188012c..4dd9dae 100644
--- a/arch/powerpc/sysdev/tsi108_pci.c
+++ b/arch/powerpc/sysdev/tsi108_pci.c
@@ -229,7 +229,7 @@ int __init tsi108_setup_pci(struct device_node *dev, u32 cfg_phys, int primary)
 	hose->first_busno = bus_range ? bus_range[0] : 0;
 	hose->last_busno = bus_range ? bus_range[1] : 0xff;
 
-	(hose)->ops = &tsi108_direct_pci_ops;
+	hose->generic_ops.pci_ops = &tsi108_direct_pci_ops;
 
 	printk(KERN_INFO "Found tsi108 PCI host bridge at 0x%08x. "
 	       "Firmware bus number: %d->%d\n",
-- 
2.1.4
