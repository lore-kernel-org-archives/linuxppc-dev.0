Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 00626DE708
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 01:52:53 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l6AFqlfL002013
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 08:52:47 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6AFqker019969
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 10:52:46 -0500 (CDT)
Subject: [patch 4/6] User Freescale pci/pcie common routing for
	83xx/85xx/86xx boards
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Message-Id: <1184082753.20129.189.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 10 Jul 2007 23:52:34 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Roy Zang <tie-fei.zang@freescale.com>

User Freescale pci/pcie common routing for 83xx/85xx/86xx
boards.

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---
 arch/powerpc/Kconfig                       |    2 +-
 arch/powerpc/platforms/83xx/Kconfig        |    4 +
 arch/powerpc/platforms/83xx/mpc8313_rdb.c  |    2 +-
 arch/powerpc/platforms/83xx/mpc832x_mds.c  |    2 +-
 arch/powerpc/platforms/83xx/mpc832x_rdb.c  |    2 +-
 arch/powerpc/platforms/83xx/mpc834x_itx.c  |   11 +++-
 arch/powerpc/platforms/83xx/mpc834x_mds.c  |   11 +++-
 arch/powerpc/platforms/83xx/mpc836x_mds.c  |    2 +-
 arch/powerpc/platforms/83xx/mpc83xx.h      |    2 +-
 arch/powerpc/platforms/83xx/pci.c          |   57 -----------------
 arch/powerpc/platforms/85xx/Kconfig        |    1 +
 arch/powerpc/platforms/85xx/Makefile       |    2 +-
 arch/powerpc/platforms/85xx/mpc85xx.h      |    1 -
 arch/powerpc/platforms/85xx/mpc85xx_ads.c  |    3 +-
 arch/powerpc/platforms/85xx/mpc85xx_cds.c  |   14 +++--
 arch/powerpc/platforms/85xx/mpc85xx_mds.c  |    6 +-
 arch/powerpc/platforms/85xx/pci.c          |   91 ----------------------------
 arch/powerpc/platforms/86xx/mpc86xx.h      |    2 -
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |   11 +++-
 19 files changed, 51 insertions(+), 175 deletions(-)
 delete mode 100644 arch/powerpc/platforms/85xx/pci.c

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 8c780bf..20f7a34 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -421,7 +421,7 @@ config FSL_SOC
 
 config FSL_PCI
  	bool
-	depends on PPC_86xx
+	depends on PPC_85xx || PPC_86xx || PPC_83xx
 
 # Yes MCA RS/6000s exist but Linux-PPC does not currently support any
 config MCA
diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/platforms/83xx/Kconfig
index ec305f1..d60a431 100644
--- a/arch/powerpc/platforms/83xx/Kconfig
+++ b/arch/powerpc/platforms/83xx/Kconfig
@@ -55,23 +55,27 @@ endchoice
 config PPC_MPC831x
 	bool
 	select PPC_UDBG_16550
+	select FSL_PCI
 	select PPC_INDIRECT_PCI
 	default y if MPC8313_RDB
 
 config PPC_MPC832x
 	bool
 	select PPC_UDBG_16550
+	select FSL_PCI
 	select PPC_INDIRECT_PCI
 	default y if MPC832x_MDS || MPC832x_RDB
 
 config MPC834x
 	bool
 	select PPC_UDBG_16550
+	select FSL_PCI
 	select PPC_INDIRECT_PCI
 	default y if MPC834x_MDS || MPC834x_ITX
 
 config PPC_MPC836x
 	bool
 	select PPC_UDBG_16550
+	select FSL_PCI
 	select PPC_INDIRECT_PCI
 	default y if MPC836x_MDS
diff --git a/arch/powerpc/platforms/83xx/mpc8313_rdb.c b/arch/powerpc/platforms/83xx/mpc8313_rdb.c
index 3edfe17..41f4988 100644
--- a/arch/powerpc/platforms/83xx/mpc8313_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc8313_rdb.c
@@ -44,7 +44,7 @@ static void __init mpc8313_rdb_setup_arch(void)
 
 #ifdef CONFIG_PCI
 	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
-		mpc83xx_add_bridge(np);
+		fsl_add_bridge(np, 1);
 
 	ppc_md.pci_exclude_device = mpc83xx_exclude_device;
 #endif
diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.c b/arch/powerpc/platforms/83xx/mpc832x_mds.c
index b39cb52..6ef2acf 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
@@ -75,7 +75,7 @@ static void __init mpc832x_sys_setup_arch(void)
 
 #ifdef CONFIG_PCI
 	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
-		mpc83xx_add_bridge(np);
+		fsl_add_bridge(np, 1);
 	ppc_md.pci_exclude_device = mpc83xx_exclude_device;
 #endif
 
diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
index b2b28a4..0acc670 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
@@ -48,7 +48,7 @@ static void __init mpc832x_rdb_setup_arch(void)
 
 #ifdef CONFIG_PCI
 	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
-		mpc83xx_add_bridge(np);
+		fsl_add_bridge(np, 1);
 
 	ppc_md.pci_exclude_device = mpc83xx_exclude_device;
 #endif
diff --git a/arch/powerpc/platforms/83xx/mpc834x_itx.c b/arch/powerpc/platforms/83xx/mpc834x_itx.c
index 47ba544..defde26 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_itx.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_itx.c
@@ -53,9 +53,14 @@ static void __init mpc834x_itx_setup_arch(void)
 		ppc_md.progress("mpc834x_itx_setup_arch()", 0);
 
 #ifdef CONFIG_PCI
-	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
-		mpc83xx_add_bridge(np);
-
+	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;) {
+		struct resource rsrc;
+		of_address_to_resource(np, 0, &rsrc);
+		if ((rsrc.start & 0xfffff) == 0x8500)
+			fsl_add_bridge(np, 1);
+		else
+			fsl_add_bridge(np, 0);
+	}
 	ppc_md.pci_exclude_device = mpc83xx_exclude_device;
 #endif
 
diff --git a/arch/powerpc/platforms/83xx/mpc834x_mds.c b/arch/powerpc/platforms/83xx/mpc834x_mds.c
index 4c9ff9c..dbbf8b0 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_mds.c
@@ -84,9 +84,14 @@ static void __init mpc834x_mds_setup_arch(void)
 		ppc_md.progress("mpc834x_mds_setup_arch()", 0);
 
 #ifdef CONFIG_PCI
-	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
-		mpc83xx_add_bridge(np);
-
+	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;) {
+		struct resource rsrc;
+		of_address_to_resource(np, 0, &rsrc);
+		if ((rsrc.start & 0xfffff) == 0x8500)
+			fsl_add_bridge(np, 1);
+		else
+			fsl_add_bridge(np, 0);
+	}
 	ppc_md.pci_exclude_device = mpc83xx_exclude_device;
 #endif
 
diff --git a/arch/powerpc/platforms/83xx/mpc836x_mds.c b/arch/powerpc/platforms/83xx/mpc836x_mds.c
index 0e615fd..9f39941 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_mds.c
@@ -81,7 +81,7 @@ static void __init mpc836x_mds_setup_arch(void)
 
 #ifdef CONFIG_PCI
 	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
-		mpc83xx_add_bridge(np);
+		fsl_add_bridge(np, 1);
 	ppc_md.pci_exclude_device = mpc83xx_exclude_device;
 #endif
 
diff --git a/arch/powerpc/platforms/83xx/mpc83xx.h b/arch/powerpc/platforms/83xx/mpc83xx.h
index 589ee55..dd1315e 100644
--- a/arch/powerpc/platforms/83xx/mpc83xx.h
+++ b/arch/powerpc/platforms/83xx/mpc83xx.h
@@ -48,7 +48,7 @@
  * mpc83xx_* files. Mostly for use by mpc83xx_setup
  */
 
-extern int mpc83xx_add_bridge(struct device_node *dev);
+extern int fsl_add_bridge(struct device_node *dev, int is_primary);
 extern int mpc83xx_exclude_device(struct pci_controller *hose,
 				  u_char bus, u_char devfn);
 extern void mpc83xx_restart(char *cmd);
diff --git a/arch/powerpc/platforms/83xx/pci.c b/arch/powerpc/platforms/83xx/pci.c
index c0e2b89..1fae915 100644
--- a/arch/powerpc/platforms/83xx/pci.c
+++ b/arch/powerpc/platforms/83xx/pci.c
@@ -39,60 +39,3 @@ int mpc83xx_exclude_device(struct pci_controller *hose, u_char bus, u_char devfn
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	return PCIBIOS_SUCCESSFUL;
 }
-
-int __init mpc83xx_add_bridge(struct device_node *dev)
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
-	/* MPC83xx supports up to two host controllers one at 0x8500 from immrbar
-	 * the other at 0x8600, we consider the 0x8500 the primary controller
-	 */
-	/* PCI 1 */
-	if ((rsrc.start & 0xfffff) == 0x8500) {
-		setup_indirect_pci(hose, immr + 0x8300, immr + 0x8304);
-	}
-	/* PCI 2 */
-	if ((rsrc.start & 0xfffff) == 0x8600) {
-		setup_indirect_pci(hose, immr + 0x8380, immr + 0x8384);
-		primary = 0;
-	}
-
-	printk(KERN_INFO "Found MPC83xx PCI host bridge at 0x%016llx. "
-	       "Firmware bus number: %d->%d\n",
-	       (unsigned long long)rsrc.start, hose->first_busno,
-	       hose->last_busno);
-
-	DBG(" ->Hose at 0x%p, cfg_addr=0x%p,cfg_data=0x%p\n",
-	    hose, hose->cfg_addr, hose->cfg_data);
-
-	/* Interpret the "ranges" property */
-	/* This also maps the I/O region and sets isa_io/mem_base */
-	pci_process_bridge_OF_ranges(hose, dev, primary);
-
-	return 0;
-}
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 629926e..112e5c6 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -53,6 +53,7 @@ config MPC85xx
 	select PPC_INDIRECT_PCI
 	select PPC_INDIRECT_PCI_BE
 	select MPIC
+	select FSL_PCI
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
diff --git a/arch/powerpc/platforms/86xx/mpc86xx.h b/arch/powerpc/platforms/86xx/mpc86xx.h
index 23f7ed2..fdb192b 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx.h
+++ b/arch/powerpc/platforms/86xx/mpc86xx.h
@@ -15,8 +15,6 @@
  * mpc86xx_* files. Mostly for use by mpc86xx_setup().
  */
 
-extern int mpc86xx_add_bridge(struct device_node *dev);
-
 extern int mpc86xx_exclude_device(struct pci_controller *hose,
 				  u_char bus, u_char devfn);
 
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index 5b01ec7..dab016e 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -32,6 +32,7 @@
 #include <asm/mpic.h>
 
 #include <sysdev/fsl_soc.h>
+#include <sysdev/fsl_pci.h>
 
 #include "mpc86xx.h"
 #include "mpc8641_hpcn.h"
@@ -344,8 +345,14 @@ mpc86xx_hpcn_setup_arch(void)
 	}
 
 #ifdef CONFIG_PCI
-	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
-		mpc86xx_add_bridge(np);
+	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;) {
+		struct resource rsrc;
+		of_address_to_resource(np, 0, &rsrc);
+		if ((rsrc.start & 0xfffff) == 0x8000)
+			fsl_add_bridge(np, 1);
+		else
+			fsl_add_bridge(np, 0);
+	}
 #endif
 
 	printk("MPC86xx HPCN board from Freescale Semiconductor\n");
-- 
1.5.1
