Return-Path: <jrigby@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E38F4DFD28
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 03:08:17 +1000 (EST)
From: John Rigby <jrigby@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 2/2] powerpc: Move mpc83xx_add_bridge to fsl_pci.c [rev2]
Date: Thu, 26 Jun 2008 11:07:57 -0600
Message-Id: <1214500077-9254-3-git-send-email-jrigby@freescale.com>
In-Reply-To: <1214500077-9254-2-git-send-email-jrigby@freescale.com>
References: <1214500077-9254-1-git-send-email-jrigby@freescale.com>
	<1214500077-9254-2-git-send-email-jrigby@freescale.com>
Cc: linuxppc-dev@ozlabs.org, John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This allows other platforms with the same pci
block like MPC5121 to use it.

Signed-off-by: John Rigby <jrigby@freescale.com>
---
 arch/powerpc/platforms/83xx/Kconfig       |    2 +-
 arch/powerpc/platforms/83xx/Makefile      |    1 -
 arch/powerpc/platforms/83xx/mpc831x_rdb.c |    1 +
 arch/powerpc/platforms/83xx/mpc832x_mds.c |    1 +
 arch/powerpc/platforms/83xx/mpc832x_rdb.c |    1 +
 arch/powerpc/platforms/83xx/mpc834x_itx.c |    1 +
 arch/powerpc/platforms/83xx/mpc834x_mds.c |    1 +
 arch/powerpc/platforms/83xx/mpc836x_mds.c |    1 +
 arch/powerpc/platforms/83xx/mpc837x_mds.c |    1 +
 arch/powerpc/platforms/83xx/mpc837x_rdb.c |    1 +
 arch/powerpc/platforms/83xx/mpc83xx.h     |    1 -
 arch/powerpc/platforms/83xx/pci.c         |   91 -----------------------------
 arch/powerpc/platforms/83xx/sbc834x.c     |    1 +
 arch/powerpc/sysdev/fsl_pci.c             |   61 +++++++++++++++++++
 arch/powerpc/sysdev/fsl_pci.h             |    1 +
 15 files changed, 72 insertions(+), 94 deletions(-)
 delete mode 100644 arch/powerpc/platforms/83xx/pci.c

diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/platforms/83xx/Kconfig
index 0a306eb..ca2c149 100644
--- a/arch/powerpc/platforms/83xx/Kconfig
+++ b/arch/powerpc/platforms/83xx/Kconfig
@@ -3,7 +3,7 @@ menuconfig MPC83xx
 	depends on PPC_83xx
 	select PPC_UDBG_16550
 	select PPC_PCI_CHOICE
-	select PPC_INDIRECT_PCI
+	select FSL_PCI if PCI
 
 if MPC83xx
 
diff --git a/arch/powerpc/platforms/83xx/Makefile b/arch/powerpc/platforms/83xx/Makefile
index 76494be..59c413c 100644
--- a/arch/powerpc/platforms/83xx/Makefile
+++ b/arch/powerpc/platforms/83xx/Makefile
@@ -2,7 +2,6 @@
 # Makefile for the PowerPC 83xx linux kernel.
 #
 obj-y				:= misc.o usb.o
-obj-$(CONFIG_PCI)		+= pci.o
 obj-$(CONFIG_MPC831x_RDB)	+= mpc831x_rdb.o
 obj-$(CONFIG_MPC832x_RDB)	+= mpc832x_rdb.o
 obj-$(CONFIG_MPC834x_MDS)	+= mpc834x_mds.o
diff --git a/arch/powerpc/platforms/83xx/mpc831x_rdb.c b/arch/powerpc/platforms/83xx/mpc831x_rdb.c
index c4db517..a428f8d 100644
--- a/arch/powerpc/platforms/83xx/mpc831x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc831x_rdb.c
@@ -19,6 +19,7 @@
 #include <asm/time.h>
 #include <asm/ipic.h>
 #include <asm/udbg.h>
+#include <sysdev/fsl_pci.h>
 
 #include "mpc83xx.h"
 
diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.c b/arch/powerpc/platforms/83xx/mpc832x_mds.c
index 6dbc6ea..dd4be4a 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
@@ -36,6 +36,7 @@
 #include <asm/prom.h>
 #include <asm/udbg.h>
 #include <sysdev/fsl_soc.h>
+#include <sysdev/fsl_pci.h>
 #include <asm/qe.h>
 #include <asm/qe_ic.h>
 
diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
index e7f706b..f049d69 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
@@ -27,6 +27,7 @@
 #include <asm/qe.h>
 #include <asm/qe_ic.h>
 #include <sysdev/fsl_soc.h>
+#include <sysdev/fsl_pci.h>
 
 #include "mpc83xx.h"
 
diff --git a/arch/powerpc/platforms/83xx/mpc834x_itx.c b/arch/powerpc/platforms/83xx/mpc834x_itx.c
index 50e8f63..7301d77 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_itx.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_itx.c
@@ -35,6 +35,7 @@
 #include <asm/prom.h>
 #include <asm/udbg.h>
 #include <sysdev/fsl_soc.h>
+#include <sysdev/fsl_pci.h>
 
 #include "mpc83xx.h"
 
diff --git a/arch/powerpc/platforms/83xx/mpc834x_mds.c b/arch/powerpc/platforms/83xx/mpc834x_mds.c
index 2b8a0a3..30d509a 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_mds.c
@@ -35,6 +35,7 @@
 #include <asm/prom.h>
 #include <asm/udbg.h>
 #include <sysdev/fsl_soc.h>
+#include <sysdev/fsl_pci.h>
 
 #include "mpc83xx.h"
 
diff --git a/arch/powerpc/platforms/83xx/mpc836x_mds.c b/arch/powerpc/platforms/83xx/mpc836x_mds.c
index c2e5de6..75b80e8 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_mds.c
@@ -42,6 +42,7 @@
 #include <asm/prom.h>
 #include <asm/udbg.h>
 #include <sysdev/fsl_soc.h>
+#include <sysdev/fsl_pci.h>
 #include <asm/qe.h>
 #include <asm/qe_ic.h>
 
diff --git a/arch/powerpc/platforms/83xx/mpc837x_mds.c b/arch/powerpc/platforms/83xx/mpc837x_mds.c
index 64d17b0..be62de2 100644
--- a/arch/powerpc/platforms/83xx/mpc837x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc837x_mds.c
@@ -19,6 +19,7 @@
 #include <asm/ipic.h>
 #include <asm/udbg.h>
 #include <asm/prom.h>
+#include <sysdev/fsl_pci.h>
 
 #include "mpc83xx.h"
 
diff --git a/arch/powerpc/platforms/83xx/mpc837x_rdb.c b/arch/powerpc/platforms/83xx/mpc837x_rdb.c
index c00356b..da030af 100644
--- a/arch/powerpc/platforms/83xx/mpc837x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc837x_rdb.c
@@ -17,6 +17,7 @@
 #include <asm/time.h>
 #include <asm/ipic.h>
 #include <asm/udbg.h>
+#include <sysdev/fsl_pci.h>
 
 #include "mpc83xx.h"
 
diff --git a/arch/powerpc/platforms/83xx/mpc83xx.h b/arch/powerpc/platforms/83xx/mpc83xx.h
index 88a3b5c..393dfec 100644
--- a/arch/powerpc/platforms/83xx/mpc83xx.h
+++ b/arch/powerpc/platforms/83xx/mpc83xx.h
@@ -55,7 +55,6 @@
  * mpc83xx_* files. Mostly for use by mpc83xx_setup
  */
 
-extern int mpc83xx_add_bridge(struct device_node *dev);
 extern void mpc83xx_restart(char *cmd);
 extern long mpc83xx_time_init(void);
 extern int mpc834x_usb_cfg(void);
diff --git a/arch/powerpc/platforms/83xx/pci.c b/arch/powerpc/platforms/83xx/pci.c
deleted file mode 100644
index 14f1080..0000000
--- a/arch/powerpc/platforms/83xx/pci.c
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
-	ppc_pci_flags |= PPC_PCI_REASSIGN_ALL_BUS;
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
-		setup_indirect_pci(hose, immr + 0x8300, immr + 0x8304, 0);
-	}
-	/* PCI 2 */
-	if ((rsrc.start & 0xfffff) == 0x8600) {
-		setup_indirect_pci(hose, immr + 0x8380, immr + 0x8384, 0);
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
diff --git a/arch/powerpc/platforms/83xx/sbc834x.c b/arch/powerpc/platforms/83xx/sbc834x.c
index cf38247..fc21f5c 100644
--- a/arch/powerpc/platforms/83xx/sbc834x.c
+++ b/arch/powerpc/platforms/83xx/sbc834x.c
@@ -37,6 +37,7 @@
 #include <asm/prom.h>
 #include <asm/udbg.h>
 #include <sysdev/fsl_soc.h>
+#include <sysdev/fsl_pci.h>
 
 #include "mpc83xx.h"
 
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 489ca5a..68583f6 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -27,6 +27,7 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
+#if defined(CONFIG_PPC_85xx) || defined(CONFIG_PPC_86xx)
 /* atmu setup for fsl pci/pcie controller */
 void __init setup_pci_atmu(struct pci_controller *hose, struct resource *rsrc)
 {
@@ -246,3 +247,63 @@ DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8572, quirk_fsl_pcie_header);
 DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8641, quirk_fsl_pcie_header);
 DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8641D, quirk_fsl_pcie_header);
 DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8610, quirk_fsl_pcie_header);
+#endif /* CONFIG_PPC_85xx || CONFIG_PPC_86xx */
+
+#if defined(CONFIG_PPC_83xx)
+int __init mpc83xx_add_bridge(struct device_node *dev)
+{
+	int len;
+	struct pci_controller *hose;
+	struct resource rsrc;
+	const int *bus_range;
+	int primary = 1, has_address = 0;
+	phys_addr_t immr = get_immrbase();
+
+	pr_debug("Adding PCI host bridge %s\n", dev->full_name);
+
+	/* Fetch host bridge registers address */
+	has_address = (of_address_to_resource(dev, 0, &rsrc) == 0);
+
+	/* Get bus range if any */
+	bus_range = of_get_property(dev, "bus-range", &len);
+	if (bus_range == NULL || len < 2 * sizeof(int)) {
+		printk(KERN_WARNING "Can't get bus-range for %s, assume"
+		       " bus 0\n", dev->full_name);
+	}
+
+	ppc_pci_flags |= PPC_PCI_REASSIGN_ALL_BUS;
+	hose = pcibios_alloc_controller(dev);
+	if (!hose)
+		return -ENOMEM;
+
+	hose->first_busno = bus_range ? bus_range[0] : 0;
+	hose->last_busno = bus_range ? bus_range[1] : 0xff;
+
+	/* MPC83xx supports up to two host controllers one at 0x8500 from immrbar
+	 * the other at 0x8600, we consider the 0x8500 the primary controller
+	 */
+	/* PCI 1 */
+	if ((rsrc.start & 0xfffff) == 0x8500) {
+		setup_indirect_pci(hose, immr + 0x8300, immr + 0x8304, 0);
+	}
+	/* PCI 2 */
+	if ((rsrc.start & 0xfffff) == 0x8600) {
+		setup_indirect_pci(hose, immr + 0x8380, immr + 0x8384, 0);
+		primary = 0;
+	}
+
+	printk(KERN_INFO "Found MPC83xx PCI host bridge at 0x%016llx. "
+	       "Firmware bus number: %d->%d\n",
+	       (unsigned long long)rsrc.start, hose->first_busno,
+	       hose->last_busno);
+
+	pr_debug(" ->Hose at 0x%p, cfg_addr=0x%p,cfg_data=0x%p\n",
+	    hose, hose->cfg_addr, hose->cfg_data);
+
+	/* Interpret the "ranges" property */
+	/* This also maps the I/O region and sets isa_io/mem_base */
+	pci_process_bridge_OF_ranges(hose, dev, primary);
+
+	return 0;
+}
+#endif /* CONFIG_PPC_83xx */
diff --git a/arch/powerpc/sysdev/fsl_pci.h b/arch/powerpc/sysdev/fsl_pci.h
index 37b04ad..13f30c2 100644
--- a/arch/powerpc/sysdev/fsl_pci.h
+++ b/arch/powerpc/sysdev/fsl_pci.h
@@ -83,6 +83,7 @@ struct ccsr_pci {
 
 extern int fsl_add_bridge(struct device_node *dev, int is_primary);
 extern void fsl_pcibios_fixup_bus(struct pci_bus *bus);
+extern int mpc83xx_add_bridge(struct device_node *dev);
 
 #endif /* __POWERPC_FSL_PCI_H */
 #endif /* __KERNEL__ */
-- 
1.5.6.rc0.46.gd2b3
