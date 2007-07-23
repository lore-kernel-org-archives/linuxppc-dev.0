Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 79040DDF35
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 06:50:57 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH 08/25] [POWERPC] Use Freescale pci/pcie common code for 85xx
	boards
Date: Mon, 23 Jul 2007 15:49:55 -0500
Message-Id: <11852238241475-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <11852238233066-git-send-email-galak@kernel.crashing.org>
References: <11852238122538-git-send-email-galak@kernel.crashing.org>
	<1185223813693-git-send-email-galak@kernel.crashing.org>
	<11852238151983-git-send-email-galak@kernel.crashing.org>
	<11852238161546-git-send-email-galak@kernel.crashing.org>
	<1185223818821-git-send-email-galak@kernel.crashing.org>
	<11852238193371-git-send-email-galak@kernel.crashing.org>
	<1185223821183-git-send-email-galak@kernel.crashing.org>
	<11852238233066-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Roy Zang <tie-fei.zang@freescale.com>

Switch the 85xx platform over to using the FSL generic PCI code.  This
gets ups PCIe support in addition to base PCI support.

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/85xx/Kconfig       |    5 +-
 arch/powerpc/platforms/85xx/Makefile      |    2 +-
 arch/powerpc/platforms/85xx/mpc85xx.h     |    1 -
 arch/powerpc/platforms/85xx/mpc85xx_ads.c |    3 +-
 arch/powerpc/platforms/85xx/mpc85xx_cds.c |   14 +++--
 arch/powerpc/platforms/85xx/mpc85xx_mds.c |    6 +-
 arch/powerpc/platforms/85xx/pci.c         |   91 -----------------------------
 arch/powerpc/sysdev/fsl_pci.c             |    7 ++
 8 files changed, 25 insertions(+), 104 deletions(-)
 delete mode 100644 arch/powerpc/platforms/85xx/pci.c

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 629926e..526ddde 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -50,9 +50,10 @@ config MPC8560
 config MPC85xx
 	bool
 	select PPC_UDBG_16550
-	select PPC_INDIRECT_PCI
-	select PPC_INDIRECT_PCI_BE
+	select PPC_INDIRECT_PCI if PCI
+	select PPC_INDIRECT_PCI_BE if PCI
 	select MPIC
+	select FSL_PCI if PCI
 	select SERIAL_8250_SHARE_IRQ if SERIAL_8250
 	default y if MPC8540_ADS || MPC85xx_CDS || MPC8560_ADS \
 		|| MPC85xx_MDS || MPC8544_DS
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index 4e02cbb..d70f2d0 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -1,7 +1,7 @@
 #
 # Makefile for the PowerPC 85xx linux kernel.
 #
-obj-$(CONFIG_PPC_85xx)	+= misc.o pci.o
+obj-$(CONFIG_PPC_85xx)	+= misc.o
 obj-$(CONFIG_MPC8540_ADS) += mpc85xx_ads.o
 obj-$(CONFIG_MPC8560_ADS) += mpc85xx_ads.o
 obj-$(CONFIG_MPC85xx_CDS) += mpc85xx_cds.o
diff --git a/arch/powerpc/platforms/85xx/mpc85xx.h b/arch/powerpc/platforms/85xx/mpc85xx.h
index 7286ffa..5b34dee 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx.h
+++ b/arch/powerpc/platforms/85xx/mpc85xx.h
@@ -15,4 +15,3 @@
  */
 
 extern void mpc85xx_restart(char *);
-extern int mpc85xx_add_bridge(struct device_node *dev);
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index 7235f70..40a8286 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -29,6 +29,7 @@
 #include <asm/udbg.h>
 
 #include <sysdev/fsl_soc.h>
+#include <sysdev/fsl_pci.h>
 #include "mpc85xx.h"
 
 #ifdef CONFIG_CPM2
@@ -217,7 +218,7 @@ static void __init mpc85xx_ads_setup_arch(void)
 
 #ifdef CONFIG_PCI
 	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
-		mpc85xx_add_bridge(np);
+		fsl_add_bridge(np, 1);
 	ppc_md.pci_exclude_device = mpc85xx_exclude_device;
 #endif
 }
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index 50c8d64..2539bb5 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -45,6 +45,7 @@
 #include <asm/i8259.h>
 
 #include <sysdev/fsl_soc.h>
+#include <sysdev/fsl_pci.h>
 #include "mpc85xx.h"
 
 static int cds_pci_slot = 2;
@@ -58,8 +59,6 @@ static volatile u8 *cadmus;
 static int mpc85xx_exclude_device(struct pci_controller *hose,
 				  u_char bus, u_char devfn)
 {
-	if ((bus == hose->first_busno) && PCI_SLOT(devfn) == 0)
-		return PCIBIOS_DEVICE_NOT_FOUND;
 	/* We explicitly do not go past the Tundra 320 Bridge */
 	if ((bus == 1) && (PCI_SLOT(devfn) == ARCADIA_2ND_BRIDGE_IDSEL))
 		return PCIBIOS_DEVICE_NOT_FOUND;
@@ -218,9 +217,14 @@ static void __init mpc85xx_cds_setup_arch(void)
 	}
 
 #ifdef CONFIG_PCI
-	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
-		mpc85xx_add_bridge(np);
-
+	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;) {
+		struct resource rsrc;
+		of_address_to_resource(np, 0, &rsrc);
+		if ((rsrc.start & 0xfffff) == 0x9000)
+			fsl_add_bridge(np, 0);
+		else
+			fsl_add_bridge(np, 1);
+	}
 	ppc_md.pci_irq_fixup = mpc85xx_cds_pci_irq_fixup;
 	ppc_md.pci_exclude_device = mpc85xx_exclude_device;
 #endif
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 004b80b..9aa96f0 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -46,6 +46,7 @@
 #include <asm/prom.h>
 #include <asm/udbg.h>
 #include <sysdev/fsl_soc.h>
+#include <sysdev/fsl_pci.h>
 #include <asm/qe.h>
 #include <asm/qe_ic.h>
 #include <asm/mpic.h>
@@ -94,9 +95,8 @@ static void __init mpc85xx_mds_setup_arch(void)
 	}
 
 #ifdef CONFIG_PCI
-	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;) {
-		mpc85xx_add_bridge(np);
-	}
+	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
+		fsl_add_bridge(np, 1);
 	of_node_put(np);
 #endif
 
diff --git a/arch/powerpc/platforms/85xx/pci.c b/arch/powerpc/platforms/85xx/pci.c
deleted file mode 100644
index 8118417..0000000
--- a/arch/powerpc/platforms/85xx/pci.c
+++ /dev/null
@@ -1,91 +0,0 @@
-/*
- * FSL SoC setup code
- *
- * Maintained by Kumar Gala (see MAINTAINERS for contact information)
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#include <linux/stddef.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/errno.h>
-#include <linux/pci.h>
-#include <linux/delay.h>
-#include <linux/irq.h>
-#include <linux/module.h>
-
-#include <asm/system.h>
-#include <asm/atomic.h>
-#include <asm/io.h>
-#include <asm/pci-bridge.h>
-#include <asm/prom.h>
-#include <sysdev/fsl_soc.h>
-
-#undef DEBUG
-
-#ifdef DEBUG
-#define DBG(x...) printk(x)
-#else
-#define DBG(x...)
-#endif
-
-#ifdef CONFIG_PCI
-int __init mpc85xx_add_bridge(struct device_node *dev)
-{
-	int len;
-	struct pci_controller *hose;
-	struct resource rsrc;
-	const int *bus_range;
-	int primary = 1, has_address = 0;
-	phys_addr_t immr = get_immrbase();
-
-	DBG("Adding PCI host bridge %s\n", dev->full_name);
-
-	/* Fetch host bridge registers address */
-	has_address = (of_address_to_resource(dev, 0, &rsrc) == 0);
-
-	/* Get bus range if any */
-	bus_range = of_get_property(dev, "bus-range", &len);
-	if (bus_range == NULL || len < 2 * sizeof(int)) {
-		printk(KERN_WARNING "Can't get bus-range for %s, assume"
-		       " bus 0\n", dev->full_name);
-	}
-
-	pci_assign_all_buses = 1;
-	hose = pcibios_alloc_controller(dev);
-	if (!hose)
-		return -ENOMEM;
-
-	hose->first_busno = bus_range ? bus_range[0] : 0;
-	hose->last_busno = bus_range ? bus_range[1] : 0xff;
-
-	/* PCI 1 */
-	if ((rsrc.start & 0xfffff) == 0x8000) {
-		setup_indirect_pci(hose, immr + 0x8000, immr + 0x8004);
-	}
-	/* PCI 2 */
-	if ((rsrc.start & 0xfffff) == 0x9000) {
-		setup_indirect_pci(hose, immr + 0x9000, immr + 0x9004);
-		primary = 0;
-	}
-
-	printk(KERN_INFO "Found MPC85xx PCI host bridge at 0x%016llx. "
-	       "Firmware bus number: %d->%d\n",
-		(unsigned long long)rsrc.start, hose->first_busno,
-		hose->last_busno);
-
-	DBG(" ->Hose at 0x%p, cfg_addr=0x%p,cfg_data=0x%p\n",
-		hose, hose->cfg_addr, hose->cfg_data);
-
-	/* Interpret the "ranges" property */
-	/* This also maps the I/O region and sets isa_io/mem_base */
-	pci_process_bridge_OF_ranges(hose, dev, primary);
-
-	return 0;
-}
-
-#endif
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 69d3c6e..2eefcde 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -200,5 +200,12 @@ int __init fsl_add_bridge(struct device_node *dev, int is_primary)
 	return 0;
 }
 
+DECLARE_PCI_FIXUP_EARLY(0x1957, 0x0012, quirk_fsl_pcie_transparent);
+DECLARE_PCI_FIXUP_EARLY(0x1957, 0x0013, quirk_fsl_pcie_transparent);
+DECLARE_PCI_FIXUP_EARLY(0x1957, 0x0014, quirk_fsl_pcie_transparent);
+DECLARE_PCI_FIXUP_EARLY(0x1957, 0x0015, quirk_fsl_pcie_transparent);
+DECLARE_PCI_FIXUP_EARLY(0x1957, 0x0018, quirk_fsl_pcie_transparent);
+DECLARE_PCI_FIXUP_EARLY(0x1957, 0x0019, quirk_fsl_pcie_transparent);
+DECLARE_PCI_FIXUP_EARLY(0x1957, 0x001a, quirk_fsl_pcie_transparent);
 DECLARE_PCI_FIXUP_EARLY(0x1957, 0x7010, quirk_fsl_pcie_transparent);
 DECLARE_PCI_FIXUP_EARLY(0x1957, 0x7011, quirk_fsl_pcie_transparent);
-- 
1.5.2.2
