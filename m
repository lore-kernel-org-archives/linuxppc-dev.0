Return-Path: <jrigby@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 96941DE015
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jun 2008 02:58:52 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m5KGwkY5024115
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 09:58:46 -0700 (MST)
From: John Rigby <jrigby@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/6] MPC5121 Add PCI support
Date: Fri, 20 Jun 2008 10:58:38 -0600
Message-Id: <1213981119-1979-6-git-send-email-jrigby@freescale.com>
In-Reply-To: <1213981119-1979-5-git-send-email-jrigby@freescale.com>
References: <1213981119-1979-1-git-send-email-jrigby@freescale.com>
	<1213981119-1979-2-git-send-email-jrigby@freescale.com>
	<1213981119-1979-3-git-send-email-jrigby@freescale.com>
	<1213981119-1979-4-git-send-email-jrigby@freescale.com>
	<1213981119-1979-5-git-send-email-jrigby@freescale.com>
Cc: John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Copied from 83xx minus support for two busses.

Signed-off-by: John Rigby <jrigby@freescale.com>
---
 arch/powerpc/Kconfig                      |    2 +-
 arch/powerpc/platforms/512x/Kconfig       |    1 +
 arch/powerpc/platforms/512x/Makefile      |    1 +
 arch/powerpc/platforms/512x/mpc5121_ads.c |   10 ++++
 arch/powerpc/platforms/512x/mpc512x.h     |    1 +
 arch/powerpc/platforms/512x/pci.c         |   84 +++++++++++++++++++++++++++++
 6 files changed, 98 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/platforms/512x/pci.c

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 3934e26..5a467a1 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -545,7 +545,7 @@ config MCA
 config PCI
 	bool "PCI support" if 40x || CPM2 || PPC_83xx || PPC_85xx || PPC_86xx \
 		|| PPC_MPC52xx || (EMBEDDED && (PPC_PSERIES || PPC_ISERIES)) \
-		|| PPC_PS3 || 44x
+		|| PPC_PS3 || 44x || PPC_MPC512x
 	default y if !40x && !CPM2 && !8xx && !PPC_MPC512x && !PPC_83xx \
 		&& !PPC_85xx && !PPC_86xx
 	default PCI_PERMEDIA if !4xx && !CPM2 && !8xx
diff --git a/arch/powerpc/platforms/512x/Kconfig b/arch/powerpc/platforms/512x/Kconfig
index 0fd3b00..a0eae56 100644
--- a/arch/powerpc/platforms/512x/Kconfig
+++ b/arch/powerpc/platforms/512x/Kconfig
@@ -2,6 +2,7 @@ config PPC_MPC512x
 	bool
 	select FSL_SOC
 	select IPIC
+	select PPC_INDIRECT_PCI
 
 config PPC_MPC5121
 	bool
diff --git a/arch/powerpc/platforms/512x/Makefile b/arch/powerpc/platforms/512x/Makefile
index aaa934b..3292b44 100644
--- a/arch/powerpc/platforms/512x/Makefile
+++ b/arch/powerpc/platforms/512x/Makefile
@@ -4,3 +4,4 @@
 obj-y				:= clock.o mpc512x_shared.o
 obj-$(CONFIG_MPC5121_ADS)	+= mpc5121_ads.o mpc5121_ads_cpld.o
 obj-$(CONFIG_MPC5121_GENERIC)	+= mpc5121_generic.o
+obj-$(CONFIG_PCI)		+= pci.o
diff --git a/arch/powerpc/platforms/512x/mpc5121_ads.c b/arch/powerpc/platforms/512x/mpc5121_ads.c
index 36805fd..dd533ff 100644
--- a/arch/powerpc/platforms/512x/mpc5121_ads.c
+++ b/arch/powerpc/platforms/512x/mpc5121_ads.c
@@ -22,16 +22,26 @@
 #include <asm/prom.h>
 #include <asm/time.h>
 
+#include <sysdev/fsl_soc.h>
+
 #include "mpc512x.h"
 #include "mpc5121_ads.h"
 
 static void __init mpc5121_ads_setup_arch(void)
 {
+#ifdef CONFIG_PCI
+	struct device_node *np;
+#endif
 	printk(KERN_INFO "MPC5121 ADS board from Freescale Semiconductor\n");
 	/*
 	 * cpld regs are needed early
 	 */
 	mpc5121_ads_cpld_map();
+
+#ifdef CONFIG_PCI
+	for_each_compatible_node(np, "pci", "fsl,mpc5121-pci")
+		mpc512x_add_bridge(np);
+#endif
 }
 
 static struct of_device_id __initdata of_bus_ids[] = {
diff --git a/arch/powerpc/platforms/512x/mpc512x.h b/arch/powerpc/platforms/512x/mpc512x.h
index 789b817..be30915 100644
--- a/arch/powerpc/platforms/512x/mpc512x.h
+++ b/arch/powerpc/platforms/512x/mpc512x.h
@@ -11,4 +11,5 @@
 #define __MPC512X_H__
 extern unsigned long mpc512x_find_ips_freq(struct device_node *node);
 extern void __init mpc512x_init_IRQ(void);
+extern int mpc512x_add_bridge(struct device_node *dev);
 #endif				/* __MPC512X_H__ */
diff --git a/arch/powerpc/platforms/512x/pci.c b/arch/powerpc/platforms/512x/pci.c
new file mode 100644
index 0000000..7ed9b34
--- /dev/null
+++ b/arch/powerpc/platforms/512x/pci.c
@@ -0,0 +1,84 @@
+/*
+ * Copyright (C) 2008 Freescale Semiconductor, Inc. All rights reserved.
+ *
+ * Original copied from 83xx/pci.c:
+ *
+ *     FSL SoC setup code
+ *
+ *     Maintained by Kumar Gala (see MAINTAINERS for contact information)
+ *
+ *     This program is free software; you can redistribute  it and/or modify it
+ *     under  the terms of  the GNU General  Public License as published by the
+ *     Free Software Foundation;  either version 2 of the  License, or (at your
+ *     option) any later version.
+ */
+
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/io.h>
+
+#include <asm/system.h>
+#include <asm/atomic.h>
+#include <asm/pci-bridge.h>
+#include <asm/prom.h>
+#include <sysdev/fsl_soc.h>
+
+#undef DEBUG
+
+#ifdef DEBUG
+#define DBG(x...) printk(x)
+#else
+#define DBG(x...)
+#endif
+
+int __init mpc512x_add_bridge(struct device_node *dev)
+{
+	int len;
+	struct pci_controller *hose;
+	struct resource rsrc;
+	const int *bus_range;
+	int has_address = 0;
+	phys_addr_t immr = get_immrbase();
+
+	DBG("Adding PCI host bridge %s\n", dev->full_name);
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
+	setup_indirect_pci(hose, immr + 0x8300, immr + 0x8304, 0);
+
+	printk(KERN_INFO "Found MPC512x PCI host bridge at 0x%016llx. "
+	       "Firmware bus number: %d->%d\n",
+	       (unsigned long long)rsrc.start, hose->first_busno,
+	       hose->last_busno);
+
+	DBG(" ->Hose at 0x%p, cfg_addr=0x%p,cfg_data=0x%p\n",
+	    hose, hose->cfg_addr, hose->cfg_data);
+
+	/* Interpret the "ranges" property */
+	/* This also maps the I/O region and sets isa_io/mem_base */
+	pci_process_bridge_OF_ranges(hose, dev, 1);
+
+	return 0;
+}
-- 
1.5.6.rc0.46.gd2b3
