Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DBD90DE04B
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2007 11:17:12 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 08/15] [POWERPC] Remove PCI-e errata for MPC8641 silicon ver
	1.0
Date: Tue, 26 Jun 2007 20:16:38 -0500
Message-Id: <1182907015126-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1182907014549-git-send-email-galak@kernel.crashing.org>
References: <11829070051484-git-send-email-galak@kernel.crashing.org>
	<11829070063989-git-send-email-galak@kernel.crashing.org>
	<11829070073637-git-send-email-galak@kernel.crashing.org>
	<11829070091056-git-send-email-galak@kernel.crashing.org>
	<11829070102887-git-send-email-galak@kernel.crashing.org>
	<11829070111239-git-send-email-galak@kernel.crashing.org>
	<1182907013252-git-send-email-galak@kernel.crashing.org>
	<1182907014549-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Zhang Wei <wei.zhang@freescale.com>

Remove errata for PCI-e support of Rev 1.0 of MPC8641 since its considered
obselete and is not production level silicon from Freescale.

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
Acked-by: Roy Zang <tie-fei.zang@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/Kconfig                       |    4 -
 arch/powerpc/boot/dts/mpc8641_hpcn.dts     |    2 +-
 arch/powerpc/platforms/86xx/mpc86xx.h      |    6 -
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    2 -
 arch/powerpc/platforms/86xx/pci.c          |   18 +---
 arch/powerpc/platforms/Kconfig             |    1 -
 arch/powerpc/sysdev/Makefile               |    1 -
 arch/powerpc/sysdev/fsl_pcie.c             |  171 ----------------------------
 8 files changed, 3 insertions(+), 202 deletions(-)
 delete mode 100644 arch/powerpc/sysdev/fsl_pcie.c

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 6324abd..b79256a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -424,10 +424,6 @@ config SBUS
 config FSL_SOC
 	bool
 
-config FSL_PCIE
-	bool
-	depends on PPC_86xx
-
 # Yes MCA RS/6000s exist but Linux-PPC does not currently support any
 config MCA
 	bool
diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
index 260b264..748f7b9 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -186,7 +186,7 @@
 			#size-cells = <2>;
 			#address-cells = <3>;
 			reg = <8000 1000>;
-			bus-range = <0 fe>;
+			bus-range = <0 ff>;
 			ranges = <02000000 0 80000000 80000000 0 20000000
 				  01000000 0 00000000 e2000000 0 00100000>;
 			clock-frequency = <1fca055>;
diff --git a/arch/powerpc/platforms/86xx/mpc86xx.h b/arch/powerpc/platforms/86xx/mpc86xx.h
index 4c2789d..23f7ed2 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx.h
+++ b/arch/powerpc/platforms/86xx/mpc86xx.h
@@ -20,12 +20,6 @@ extern int mpc86xx_add_bridge(struct device_node *dev);
 extern int mpc86xx_exclude_device(struct pci_controller *hose,
 				  u_char bus, u_char devfn);
 
-extern void setup_indirect_pcie(struct pci_controller *hose,
-				       u32 cfg_addr, u32 cfg_data);
-extern void setup_indirect_pcie_nomap(struct pci_controller *hose,
-					     void __iomem *cfg_addr,
-					     void __iomem *cfg_data);
-
 extern void __init mpc86xx_smp_init(void);
 
 #endif	/* __MPC86XX_H__ */
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index 042dbce..afa8237 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -358,8 +358,6 @@ mpc86xx_hpcn_setup_arch(void)
 #ifdef CONFIG_PCI
 	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
 		mpc86xx_add_bridge(np);
-
-	ppc_md.pci_exclude_device = mpc86xx_exclude_device;
 #endif
 
 	printk("MPC86xx HPCN board from Freescale Semiconductor\n");
diff --git a/arch/powerpc/platforms/86xx/pci.c b/arch/powerpc/platforms/86xx/pci.c
index 7659259..0db51e8 100644
--- a/arch/powerpc/platforms/86xx/pci.c
+++ b/arch/powerpc/platforms/86xx/pci.c
@@ -133,19 +133,6 @@ mpc86xx_setup_pcie(struct pci_controller *hose, u32 pcie_offset, u32 pcie_size)
 	early_write_config_word(hose, 0, 0, PCI_COMMAND, cmd);
 
 	early_write_config_byte(hose, 0, 0, PCI_LATENCY_TIMER, 0x80);
-
-	/* PCIE Bus, Fix the MPC8641D host bridge's location to bus 0xFF. */
-	early_read_config_dword(hose, 0, 0, PCI_PRIMARY_BUS, &temps);
-	temps = (temps & 0xff000000) | (0xff) | (0x0 << 8) | (0xfe << 16);
-	early_write_config_dword(hose, 0, 0, PCI_PRIMARY_BUS, temps);
-}
-
-int mpc86xx_exclude_device(struct pci_controller *hose, u_char bus, u_char devfn)
-{
-	if (bus == 0 && PCI_SLOT(devfn) == 0)
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	return PCIBIOS_SUCCESSFUL;
 }
 
 int __init mpc86xx_add_bridge(struct device_node *dev)
@@ -173,11 +160,10 @@ int __init mpc86xx_add_bridge(struct device_node *dev)
 		return -ENOMEM;
 	hose->arch_data = dev;
 
-	/* last_busno = 0xfe cause by MPC8641 PCIE bug */
 	hose->first_busno = bus_range ? bus_range[0] : 0x0;
-	hose->last_busno = bus_range ? bus_range[1] : 0xfe;
+	hose->last_busno = bus_range ? bus_range[1] : 0xff;
 
-	setup_indirect_pcie(hose, rsrc.start, rsrc.start + 0x4);
+	setup_indirect_pci(hose, rsrc.start, rsrc.start + 0x4);
 
 	/* Setup the PCIE host controller. */
 	mpc86xx_setup_pcie(hose, rsrc.start, rsrc.end - rsrc.start + 1);
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index df67ff5..33545d3 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -31,7 +31,6 @@ config PPC_86xx
 	bool "Freescale 86xx"
 	depends on 6xx
 	select FSL_SOC
-	select FSL_PCIE
 	select ALTIVEC
 	help
 	  The Freescale E600 SoCs have 74xx cores.
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 43fd7e0..b991b78 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -12,7 +12,6 @@ obj-$(CONFIG_PPC_PMI)		+= pmi.o
 obj-$(CONFIG_U3_DART)		+= dart_iommu.o
 obj-$(CONFIG_MMIO_NVRAM)	+= mmio_nvram.o
 obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o
-obj-$(CONFIG_FSL_PCIE)		+= fsl_pcie.o
 obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pci.o tsi108_dev.o
 obj-$(CONFIG_QUICC_ENGINE)	+= qe_lib/
 mv64x60-$(CONFIG_PCI)		+= mv64x60_pci.o
diff --git a/arch/powerpc/sysdev/fsl_pcie.c b/arch/powerpc/sysdev/fsl_pcie.c
deleted file mode 100644
index ea3ec6b..0000000
--- a/arch/powerpc/sysdev/fsl_pcie.c
+++ /dev/null
@@ -1,171 +0,0 @@
-/*
- * Support for indirect PCI bridges.
- *
- * Copyright (C) 1998 Gabriel Paubert.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- *
- * "Temporary" MPC8548 Errata file -
- * The standard indirect_pci code should work with future silicon versions.
- */
-
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/delay.h>
-#include <linux/string.h>
-#include <linux/init.h>
-#include <linux/bootmem.h>
-
-#include <asm/io.h>
-#include <asm/prom.h>
-#include <asm/pci-bridge.h>
-#include <asm/machdep.h>
-
-#define PCI_CFG_OUT out_be32
-
-/* ERRATA PCI-Ex 14 PCIE Controller timeout */
-#define PCIE_FIX		out_be32(hose->cfg_addr+0x4, 0x0400ffff)
-
-
-static int
-indirect_read_config_pcie(struct pci_bus *bus, unsigned int devfn, int offset,
-		     int len, u32 *val)
-{
-	struct pci_controller *hose = bus->sysdata;
-	volatile void __iomem *cfg_data;
-	u32 temp;
-
-	if (ppc_md.pci_exclude_device)
-		if (ppc_md.pci_exclude_device(hose, bus->number, devfn))
-			return PCIBIOS_DEVICE_NOT_FOUND;
-
-	/* Possible artifact of CDCpp50937 needs further investigation */
-	if (devfn != 0x0 && bus->number == 0xff)
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	PCIE_FIX;
-	if (bus->number == 0xff) {
-		PCI_CFG_OUT(hose->cfg_addr,
-			    (0x80000000 | ((offset & 0xf00) << 16) |
-			     (bus->number<< 16)
-			     | (devfn << 8) | ((offset & 0xfc) )));
-	} else {
-		PCI_CFG_OUT(hose->cfg_addr,
-			    (0x80000001 | ((offset & 0xf00) << 16) |
-			     (bus->number<< 16)
-			     | (devfn << 8) | ((offset & 0xfc) )));
-	}
-
-	/*
-	 * Note: the caller has already checked that offset is
-	 * suitably aligned and that len is 1, 2 or 4.
-	 */
-	/* ERRATA PCI-Ex 12 - Configuration Address/Data Alignment */
-	cfg_data = hose->cfg_data;
-	PCIE_FIX;
-	temp = in_le32(cfg_data);
-	switch (len) {
-	case 1:
-		*val = (temp >> (((offset & 3))*8)) & 0xff;
-		break;
-	case 2:
-		*val = (temp >> (((offset & 3))*8)) & 0xffff;
-		break;
-	default:
-		*val = temp;
-		break;
-	}
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int
-indirect_write_config_pcie(struct pci_bus *bus, unsigned int devfn, int offset,
-		      int len, u32 val)
-{
-	struct pci_controller *hose = bus->sysdata;
-	volatile void __iomem *cfg_data;
-	u32 temp;
-
-	if (ppc_md.pci_exclude_device)
-		if (ppc_md.pci_exclude_device(hose, bus->number, devfn))
-			return PCIBIOS_DEVICE_NOT_FOUND;
-
-	/* Possible artifact of CDCpp50937 needs further investigation */
-	if (devfn != 0x0 && bus->number == 0xff)
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	PCIE_FIX;
-	if (bus->number == 0xff) {
-		PCI_CFG_OUT(hose->cfg_addr,
-			    (0x80000000 | ((offset & 0xf00) << 16) |
-			     (bus->number << 16)
-			     | (devfn << 8) | ((offset & 0xfc) )));
-	} else {
-		PCI_CFG_OUT(hose->cfg_addr,
-			    (0x80000001 | ((offset & 0xf00) << 16) |
-			     (bus->number << 16)
-			     | (devfn << 8) | ((offset & 0xfc) )));
-        }
-
-	/*
-	 * Note: the caller has already checked that offset is
-	 * suitably aligned and that len is 1, 2 or 4.
-	 */
-	/* ERRATA PCI-Ex 12 - Configuration Address/Data Alignment */
-	cfg_data = hose->cfg_data;
-	switch (len) {
-	case 1:
-		PCIE_FIX;
-		temp = in_le32(cfg_data);
-		temp = (temp & ~(0xff << ((offset & 3) * 8))) |
-			(val << ((offset & 3) * 8));
-		PCIE_FIX;
-		out_le32(cfg_data, temp);
-		break;
-	case 2:
-		PCIE_FIX;
-		temp = in_le32(cfg_data);
-		temp = (temp & ~(0xffff << ((offset & 3) * 8)));
-		temp |= (val << ((offset & 3) * 8)) ;
-		PCIE_FIX;
-		out_le32(cfg_data, temp);
-		break;
-	default:
-		PCIE_FIX;
-		out_le32(cfg_data, val);
-		break;
-	}
-	PCIE_FIX;
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static struct pci_ops indirect_pcie_ops = {
-	indirect_read_config_pcie,
-	indirect_write_config_pcie
-};
-
-void __init
-setup_indirect_pcie_nomap(struct pci_controller* hose, void __iomem * cfg_addr,
-	void __iomem * cfg_data)
-{
-	hose->cfg_addr = cfg_addr;
-	hose->cfg_data = cfg_data;
-	hose->ops = &indirect_pcie_ops;
-}
-
-void __init
-setup_indirect_pcie(struct pci_controller* hose, u32 cfg_addr, u32 cfg_data)
-{
-	unsigned long base = cfg_addr & PAGE_MASK;
-	void __iomem *mbase, *addr, *data;
-
-	mbase = ioremap(base, PAGE_SIZE);
-	addr = mbase + (cfg_addr & ~PAGE_MASK);
-	if ((cfg_data & PAGE_MASK) != base)
-		mbase = ioremap(cfg_data & PAGE_MASK, PAGE_SIZE);
-	data = mbase + (cfg_data & ~PAGE_MASK);
-	setup_indirect_pcie_nomap(hose, addr, data);
-}
-- 
1.5.2.1
