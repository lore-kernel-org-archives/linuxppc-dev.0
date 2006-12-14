Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 4E94167C8A
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 12:04:16 +1100 (EST)
Date: Wed, 13 Dec 2006 19:04:08 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: consolidate mpc83xx platform files
Message-Id: <20061213190408.1d4ddd93.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Eliminate platforms/83xx code redundancy. Common mpc83xx code cleaned up
and merged into setup.c. Each board maintains its own machine definition
and corresponding probe fn in its own file. Kconfig modified to allow for
multiple board selection in a single kernel image.

This patch also utilizes of_platform_bus_probe() in lieu of manually
calling of_platform_device_create for each ucc_geth device
(consequently, the QE is added to of_default_bus_ids).

The loops_per_jiffy assignment is removed since udelay now uses the timebase.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 arch/powerpc/kernel/of_platform.c         |    1 +
 arch/powerpc/platforms/83xx/Kconfig       |    6 -
 arch/powerpc/platforms/83xx/Makefile      |    2 +-
 arch/powerpc/platforms/83xx/mpc832x_mds.c |  176 +----------------------------
 arch/powerpc/platforms/83xx/mpc832x_mds.h |   19 ---
 arch/powerpc/platforms/83xx/mpc834x_itx.c |   92 +++------------
 arch/powerpc/platforms/83xx/mpc834x_itx.h |   23 ----
 arch/powerpc/platforms/83xx/mpc834x_sys.c |  111 +++---------------
 arch/powerpc/platforms/83xx/mpc834x_sys.h |   23 ----
 arch/powerpc/platforms/83xx/mpc8360e_pb.c |  175 +----------------------------
 arch/powerpc/platforms/83xx/mpc83xx.h     |    2 +
 arch/powerpc/platforms/83xx/setup.c       |  176 +++++++++++++++++++++++++++++
 12 files changed, 220 insertions(+), 586 deletions(-)

diff --git a/arch/powerpc/kernel/of_platform.c b/arch/powerpc/kernel/of_platform.c
index 3002ea3..72da78b 100644
--- a/arch/powerpc/kernel/of_platform.c
+++ b/arch/powerpc/kernel/of_platform.c
@@ -50,6 +50,7 @@ static struct of_device_id of_default_bu
 	{ .type = "plb5", },
 	{ .type = "plb4", },
 	{ .type = "opb", },
+	{ .type = "qe", },
 	{},
 };
 
diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/platforms/83xx/Kconfig
index edcd5b8..c236dff 100644
--- a/arch/powerpc/platforms/83xx/Kconfig
+++ b/arch/powerpc/platforms/83xx/Kconfig
@@ -1,10 +1,6 @@
 menu "Platform support"
 	depends on PPC_83xx
 
-choice
-	prompt "Machine Type"
-	default MPC834x_SYS
-
 config MPC832x_MDS
 	bool "Freescale MPC832x MDS"
 	select DEFAULT_UIMAGE
@@ -39,8 +35,6 @@ config MPC8360E_PB
 	help
 	  This option enables support for the MPC836x EMDS Processor Board.
 
-endchoice
-
 config PPC_MPC832x
 	bool
 	select PPC_UDBG_16550
diff --git a/arch/powerpc/platforms/83xx/Makefile b/arch/powerpc/platforms/83xx/Makefile
index f1aa7e2..07db146 100644
--- a/arch/powerpc/platforms/83xx/Makefile
+++ b/arch/powerpc/platforms/83xx/Makefile
@@ -1,7 +1,7 @@
 #
 # Makefile for the PowerPC 83xx linux kernel.
 #
-obj-y				:= misc.o
+obj-y				:= setup.o misc.o
 obj-$(CONFIG_PCI)		+= pci.o
 obj-$(CONFIG_MPC834x_SYS)	+= mpc834x_sys.o
 obj-$(CONFIG_MPC834x_ITX)	+= mpc834x_itx.o
diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.c b/arch/powerpc/platforms/83xx/mpc832x_mds.c
index f58c978..37b334c 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
@@ -14,33 +14,15 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/errno.h>
-#include <linux/reboot.h>
-#include <linux/pci.h>
-#include <linux/kdev_t.h>
-#include <linux/major.h>
-#include <linux/console.h>
-#include <linux/delay.h>
-#include <linux/seq_file.h>
-#include <linux/root_dev.h>
-#include <linux/initrd.h>
 
-#include <asm/of_device.h>
+#include <asm/of_platform.h>
 #include <asm/system.h>
-#include <asm/atomic.h>
 #include <asm/time.h>
-#include <asm/io.h>
 #include <asm/machdep.h>
 #include <asm/ipic.h>
-#include <asm/bootinfo.h>
-#include <asm/irq.h>
-#include <asm/prom.h>
 #include <asm/udbg.h>
-#include <sysdev/fsl_soc.h>
-#include <asm/qe.h>
-#include <asm/qe_ic.h>
 
 #include "mpc83xx.h"
-#include "mpc832x_mds.h"
 
 #undef DEBUG
 #ifdef DEBUG
@@ -49,158 +31,6 @@
 #define DBG(fmt...)
 #endif
 
-#ifndef CONFIG_PCI
-unsigned long isa_io_base = 0;
-unsigned long isa_mem_base = 0;
-#endif
-
-static u8 *bcsr_regs = NULL;
-
-u8 *get_bcsr(void)
-{
-	return bcsr_regs;
-}
-
-/* ************************************************************************
- *
- * Setup the architecture
- *
- */
-static void __init mpc832x_sys_setup_arch(void)
-{
-	struct device_node *np;
-
-	if (ppc_md.progress)
-		ppc_md.progress("mpc832x_sys_setup_arch()", 0);
-
-	np = of_find_node_by_type(NULL, "cpu");
-	if (np != 0) {
-		unsigned int *fp =
-		    (int *)get_property(np, "clock-frequency", NULL);
-		if (fp != 0)
-			loops_per_jiffy = *fp / HZ;
-		else
-			loops_per_jiffy = 50000000 / HZ;
-		of_node_put(np);
-	}
-
-	/* Map BCSR area */
-	np = of_find_node_by_name(NULL, "bcsr");
-	if (np != 0) {
-		struct resource res;
-
-		of_address_to_resource(np, 0, &res);
-		bcsr_regs = ioremap(res.start, res.end - res.start +1);
-		of_node_put(np);
-	}
-
-#ifdef CONFIG_PCI
-	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
-		add_bridge(np);
-	ppc_md.pci_exclude_device = mpc83xx_exclude_device;
-#endif
-
-#ifdef CONFIG_QUICC_ENGINE
-	qe_reset();
-
-	if ((np = of_find_node_by_name(np, "par_io")) != NULL) {
-		par_io_init(np);
-		of_node_put(np);
-
-		for (np = NULL; (np = of_find_node_by_name(np, "ucc")) != NULL;)
-			par_io_of_config(np);
-	}
-
-	if ((np = of_find_compatible_node(NULL, "network", "ucc_geth"))
-			!= NULL){
-		/* Reset the Ethernet PHY */
-		bcsr_regs[9] &= ~0x20;
-		udelay(1000);
-		bcsr_regs[9] |= 0x20;
-		iounmap(bcsr_regs);
-		of_node_put(np);
-	}
-
-#endif				/* CONFIG_QUICC_ENGINE */
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	if (initrd_start)
-		ROOT_DEV = Root_RAM0;
-	else
-#endif
-#ifdef  CONFIG_ROOT_NFS
-		ROOT_DEV = Root_NFS;
-#else
-		ROOT_DEV = Root_HDA1;
-#endif
-}
-
-static int __init mpc832x_declare_of_platform_devices(void)
-{
-	struct device_node *np;
-
-	for (np = NULL; (np = of_find_compatible_node(np, "network",
-					"ucc_geth")) != NULL;) {
-		int ucc_num;
-		char bus_id[BUS_ID_SIZE];
-
-		ucc_num = *((uint *) get_property(np, "device-id", NULL)) - 1;
-		snprintf(bus_id, BUS_ID_SIZE, "ucc_geth.%u", ucc_num);
-		of_platform_device_create(np, bus_id, NULL);
-	}
-
-	return 0;
-}
-device_initcall(mpc832x_declare_of_platform_devices);
-
-void __init mpc832x_sys_init_IRQ(void)
-{
-
-	struct device_node *np;
-
-	np = of_find_node_by_type(NULL, "ipic");
-	if (!np)
-		return;
-
-	ipic_init(np, 0);
-
-	/* Initialize the default interrupt mapping priorities,
-	 * in case the boot rom changed something on us.
-	 */
-	ipic_set_default_priority();
-	of_node_put(np);
-
-#ifdef CONFIG_QUICC_ENGINE
-	np = of_find_node_by_type(NULL, "qeic");
-	if (!np)
-		return;
-
-	qe_ic_init(np, 0);
-	of_node_put(np);
-#endif				/* CONFIG_QUICC_ENGINE */
-}
-
-#if defined(CONFIG_I2C_MPC) && defined(CONFIG_SENSORS_DS1374)
-extern ulong ds1374_get_rtc_time(void);
-extern int ds1374_set_rtc_time(ulong);
-
-static int __init mpc832x_rtc_hookup(void)
-{
-	struct timespec tv;
-
-	ppc_md.get_rtc_time = ds1374_get_rtc_time;
-	ppc_md.set_rtc_time = ds1374_set_rtc_time;
-
-	tv.tv_nsec = 0;
-	tv.tv_sec = (ppc_md.get_rtc_time) ();
-	do_settimeofday(&tv);
-
-	return 0;
-}
-
-late_initcall(mpc832x_rtc_hookup);
-#endif
-
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
  */
@@ -222,8 +52,8 @@ static int __init mpc832x_sys_probe(void
 define_machine(mpc832x_mds) {
 	.name 		= "MPC832x MDS",
 	.probe 		= mpc832x_sys_probe,
-	.setup_arch 	= mpc832x_sys_setup_arch,
-	.init_IRQ 	= mpc832x_sys_init_IRQ,
+	.setup_arch 	= mpc83xx_setup_arch,
+	.init_IRQ 	= mpc83xx_init_IRQ,
 	.get_irq 	= ipic_get_irq,
 	.restart 	= mpc83xx_restart,
 	.time_init 	= mpc83xx_time_init,
diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.h b/arch/powerpc/platforms/83xx/mpc832x_mds.h
deleted file mode 100644
index a495889..0000000
--- a/arch/powerpc/platforms/83xx/mpc832x_mds.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * Copyright (C) Freescale Semicondutor, Inc. 2006. All rights reserved.
- *
- * Description:
- * MPC832x MDS board specific header.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- *
- */
-
-#ifndef __MACH_MPC832x_MDS_H__
-#define __MACH_MPC832x_MDS_H__
-
-extern u8 *get_bcsr(void);
-
-#endif				/* __MACH_MPC832x_MDS_H__ */
diff --git a/arch/powerpc/platforms/83xx/mpc834x_itx.c b/arch/powerpc/platforms/83xx/mpc834x_itx.c
index 314c42a..5add670 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_itx.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_itx.c
@@ -15,104 +15,46 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/errno.h>
-#include <linux/reboot.h>
-#include <linux/pci.h>
-#include <linux/kdev_t.h>
-#include <linux/major.h>
-#include <linux/console.h>
-#include <linux/delay.h>
-#include <linux/seq_file.h>
-#include <linux/root_dev.h>
 
+#include <asm/of_platform.h>
 #include <asm/system.h>
-#include <asm/atomic.h>
 #include <asm/time.h>
-#include <asm/io.h>
 #include <asm/machdep.h>
 #include <asm/ipic.h>
-#include <asm/bootinfo.h>
-#include <asm/irq.h>
-#include <asm/prom.h>
 #include <asm/udbg.h>
-#include <sysdev/fsl_soc.h>
 
 #include "mpc83xx.h"
 
-#include <platforms/83xx/mpc834x_sys.h>
-
-#ifndef CONFIG_PCI
-unsigned long isa_io_base = 0;
-unsigned long isa_mem_base = 0;
-#endif
-
-/* ************************************************************************
- *
- * Setup the architecture
- *
- */
-static void __init mpc834x_itx_setup_arch(void)
-{
-	struct device_node *np;
-
-	if (ppc_md.progress)
-		ppc_md.progress("mpc834x_itx_setup_arch()", 0);
-
-	np = of_find_node_by_type(NULL, "cpu");
-	if (np != 0) {
-		const unsigned int *fp =
-			get_property(np, "clock-frequency", NULL);
-		if (fp != 0)
-			loops_per_jiffy = *fp / HZ;
-		else
-			loops_per_jiffy = 50000000 / HZ;
-		of_node_put(np);
-	}
-#ifdef CONFIG_PCI
-	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
-		add_bridge(np);
-
-	ppc_md.pci_exclude_device = mpc83xx_exclude_device;
-#endif
-
-#ifdef  CONFIG_ROOT_NFS
-	ROOT_DEV = Root_NFS;
+#undef DEBUG
+#ifdef DEBUG
+#define DBG(fmt...) udbg_printf(fmt)
 #else
-	ROOT_DEV = Root_HDA1;
+#define DBG(fmt...)
 #endif
-}
-
-void __init mpc834x_itx_init_IRQ(void)
-{
-	struct device_node *np;
-
-	np = of_find_node_by_type(NULL, "ipic");
-	if (!np)
-		return;
-
-	ipic_init(np, 0);
-
-	/* Initialize the default interrupt mapping priorities,
-	 * in case the boot rom changed something on us.
-	 */
-	ipic_set_default_priority();
-}
 
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
  */
 static int __init mpc834x_itx_probe(void)
 {
-	/* We always match for now, eventually we should look at the flat
-	   dev tree to ensure this is the board we are suppose to run on
-	*/
+        char *model = of_get_flat_dt_prop(of_get_flat_dt_root(),
+                                          "model", NULL);
+
+        if (model == NULL)
+                return 0;
+        if (strcmp(model, "MPC8349EMITX"))
+                return 0;
+
+        DBG("%s found\n", model);
+
 	return 1;
 }
 
 define_machine(mpc834x_itx) {
 	.name			= "MPC834x ITX",
 	.probe			= mpc834x_itx_probe,
-	.setup_arch		= mpc834x_itx_setup_arch,
-	.init_IRQ		= mpc834x_itx_init_IRQ,
+	.setup_arch		= mpc83xx_setup_arch,
+	.init_IRQ		= mpc83xx_init_IRQ,
 	.get_irq		= ipic_get_irq,
 	.restart		= mpc83xx_restart,
 	.time_init		= mpc83xx_time_init,
diff --git a/arch/powerpc/platforms/83xx/mpc834x_itx.h b/arch/powerpc/platforms/83xx/mpc834x_itx.h
deleted file mode 100644
index 174ca4e..0000000
--- a/arch/powerpc/platforms/83xx/mpc834x_itx.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/*
- * arch/powerpc/platforms/83xx/mpc834x_itx.h
- *
- * MPC834X ITX common board definitions
- *
- * Maintainer: Kumar Gala <galak@kernel.crashing.org>
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- *
- */
-
-#ifndef __MACH_MPC83XX_ITX_H__
-#define __MACH_MPC83XX_ITX_H__
-
-#define PIRQA	MPC83xx_IRQ_EXT4
-#define PIRQB	MPC83xx_IRQ_EXT5
-#define PIRQC	MPC83xx_IRQ_EXT6
-#define PIRQD	MPC83xx_IRQ_EXT7
-
-#endif				/* __MACH_MPC83XX_ITX_H__ */
diff --git a/arch/powerpc/platforms/83xx/mpc834x_sys.c b/arch/powerpc/platforms/83xx/mpc834x_sys.c
index 80b735a..93df3ef 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_sys.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_sys.c
@@ -15,105 +15,21 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/errno.h>
-#include <linux/reboot.h>
-#include <linux/pci.h>
-#include <linux/kdev_t.h>
-#include <linux/major.h>
-#include <linux/console.h>
-#include <linux/delay.h>
-#include <linux/seq_file.h>
-#include <linux/root_dev.h>
 
+#include <asm/of_platform.h>
 #include <asm/system.h>
-#include <asm/atomic.h>
 #include <asm/time.h>
-#include <asm/io.h>
 #include <asm/machdep.h>
 #include <asm/ipic.h>
-#include <asm/bootinfo.h>
-#include <asm/irq.h>
-#include <asm/prom.h>
 #include <asm/udbg.h>
-#include <sysdev/fsl_soc.h>
 
 #include "mpc83xx.h"
 
-#ifndef CONFIG_PCI
-unsigned long isa_io_base = 0;
-unsigned long isa_mem_base = 0;
-#endif
-
-/* ************************************************************************
- *
- * Setup the architecture
- *
- */
-static void __init mpc834x_sys_setup_arch(void)
-{
-	struct device_node *np;
-
-	if (ppc_md.progress)
-		ppc_md.progress("mpc834x_sys_setup_arch()", 0);
-
-	np = of_find_node_by_type(NULL, "cpu");
-	if (np != 0) {
-		const unsigned int *fp =
-			get_property(np, "clock-frequency", NULL);
-		if (fp != 0)
-			loops_per_jiffy = *fp / HZ;
-		else
-			loops_per_jiffy = 50000000 / HZ;
-		of_node_put(np);
-	}
-#ifdef CONFIG_PCI
-	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
-		add_bridge(np);
-
-	ppc_md.pci_exclude_device = mpc83xx_exclude_device;
-#endif
-
-#ifdef  CONFIG_ROOT_NFS
-	ROOT_DEV = Root_NFS;
+#undef DEBUG
+#ifdef DEBUG
+#define DBG(fmt...) udbg_printf(fmt)
 #else
-	ROOT_DEV = Root_HDA1;
-#endif
-}
-
-void __init mpc834x_sys_init_IRQ(void)
-{
-	struct device_node *np;
-
-	np = of_find_node_by_type(NULL, "ipic");
-	if (!np)
-		return;
-
-	ipic_init(np, 0);
-
-	/* Initialize the default interrupt mapping priorities,
-	 * in case the boot rom changed something on us.
-	 */
-	ipic_set_default_priority();
-}
-
-#if defined(CONFIG_I2C_MPC) && defined(CONFIG_SENSORS_DS1374)
-extern ulong ds1374_get_rtc_time(void);
-extern int ds1374_set_rtc_time(ulong);
-
-static int __init mpc834x_rtc_hookup(void)
-{
-	struct timespec tv;
-
-	ppc_md.get_rtc_time = ds1374_get_rtc_time;
-	ppc_md.set_rtc_time = ds1374_set_rtc_time;
-
-	tv.tv_nsec = 0;
-	tv.tv_sec = (ppc_md.get_rtc_time) ();
-	do_settimeofday(&tv);
-
-	return 0;
-}
-
-late_initcall(mpc834x_rtc_hookup);
+#define DBG(fmt...)
 #endif
 
 /*
@@ -121,17 +37,24 @@ late_initcall(mpc834x_rtc_hookup);
  */
 static int __init mpc834x_sys_probe(void)
 {
-	/* We always match for now, eventually we should look at the flat
-	   dev tree to ensure this is the board we are suppose to run on
-	*/
+        char *model = of_get_flat_dt_prop(of_get_flat_dt_root(),
+                                          "model", NULL);
+
+        if (model == NULL)
+                return 0;
+        if (strcmp(model, "MPC8349EMDS"))
+                return 0;
+
+        DBG("%s found\n", model);
+
 	return 1;
 }
 
 define_machine(mpc834x_sys) {
 	.name			= "MPC834x SYS",
 	.probe			= mpc834x_sys_probe,
-	.setup_arch		= mpc834x_sys_setup_arch,
-	.init_IRQ		= mpc834x_sys_init_IRQ,
+	.setup_arch		= mpc83xx_setup_arch,
+	.init_IRQ		= mpc83xx_init_IRQ,
 	.get_irq		= ipic_get_irq,
 	.restart		= mpc83xx_restart,
 	.time_init		= mpc83xx_time_init,
diff --git a/arch/powerpc/platforms/83xx/mpc834x_sys.h b/arch/powerpc/platforms/83xx/mpc834x_sys.h
deleted file mode 100644
index 7d5bbef..0000000
--- a/arch/powerpc/platforms/83xx/mpc834x_sys.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/*
- * arch/powerpc/platforms/83xx/mpc834x_sys.h
- *
- * MPC834X SYS common board definitions
- *
- * Maintainer: Kumar Gala <galak@kernel.crashing.org>
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- *
- */
-
-#ifndef __MACH_MPC83XX_SYS_H__
-#define __MACH_MPC83XX_SYS_H__
-
-#define PIRQA	MPC83xx_IRQ_EXT4
-#define PIRQB	MPC83xx_IRQ_EXT5
-#define PIRQC	MPC83xx_IRQ_EXT6
-#define PIRQD	MPC83xx_IRQ_EXT7
-
-#endif				/* __MACH_MPC83XX_SYS_H__ */
diff --git a/arch/powerpc/platforms/83xx/mpc8360e_pb.c b/arch/powerpc/platforms/83xx/mpc8360e_pb.c
index 7bfd47a..f6e9b6a 100644
--- a/arch/powerpc/platforms/83xx/mpc8360e_pb.c
+++ b/arch/powerpc/platforms/83xx/mpc8360e_pb.c
@@ -20,30 +20,13 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/errno.h>
-#include <linux/reboot.h>
-#include <linux/pci.h>
-#include <linux/kdev_t.h>
-#include <linux/major.h>
-#include <linux/console.h>
-#include <linux/delay.h>
-#include <linux/seq_file.h>
-#include <linux/root_dev.h>
-#include <linux/initrd.h>
 
-#include <asm/of_device.h>
+#include <asm/of_platform.h>
 #include <asm/system.h>
-#include <asm/atomic.h>
 #include <asm/time.h>
-#include <asm/io.h>
 #include <asm/machdep.h>
 #include <asm/ipic.h>
-#include <asm/bootinfo.h>
-#include <asm/irq.h>
-#include <asm/prom.h>
 #include <asm/udbg.h>
-#include <sysdev/fsl_soc.h>
-#include <asm/qe.h>
-#include <asm/qe_ic.h>
 
 #include "mpc83xx.h"
 
@@ -54,158 +37,6 @@
 #define DBG(fmt...)
 #endif
 
-#ifndef CONFIG_PCI
-unsigned long isa_io_base = 0;
-unsigned long isa_mem_base = 0;
-#endif
-
-static u8 *bcsr_regs = NULL;
-
-u8 *get_bcsr(void)
-{
-	return bcsr_regs;
-}
-
-/* ************************************************************************
- *
- * Setup the architecture
- *
- */
-static void __init mpc8360_sys_setup_arch(void)
-{
-	struct device_node *np;
-
-	if (ppc_md.progress)
-		ppc_md.progress("mpc8360_sys_setup_arch()", 0);
-
-	np = of_find_node_by_type(NULL, "cpu");
-	if (np != 0) {
-		const unsigned int *fp =
-		    get_property(np, "clock-frequency", NULL);
-		if (fp != 0)
-			loops_per_jiffy = *fp / HZ;
-		else
-			loops_per_jiffy = 50000000 / HZ;
-		of_node_put(np);
-	}
-
-	/* Map BCSR area */
-	np = of_find_node_by_name(NULL, "bcsr");
-	if (np != 0) {
-		struct resource res;
-
-		of_address_to_resource(np, 0, &res);
-		bcsr_regs = ioremap(res.start, res.end - res.start +1);
-		of_node_put(np);
-	}
-
-#ifdef CONFIG_PCI
-	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
-		add_bridge(np);
-	ppc_md.pci_exclude_device = mpc83xx_exclude_device;
-#endif
-
-#ifdef CONFIG_QUICC_ENGINE
-	qe_reset();
-
-	if ((np = of_find_node_by_name(np, "par_io")) != NULL) {
-		par_io_init(np);
-		of_node_put(np);
-
-		for (np = NULL; (np = of_find_node_by_name(np, "ucc")) != NULL;)
-			par_io_of_config(np);
-	}
-
-	if ((np = of_find_compatible_node(NULL, "network", "ucc_geth"))
-			!= NULL){
-		/* Reset the Ethernet PHY */
-		bcsr_regs[9] &= ~0x20;
-		udelay(1000);
-		bcsr_regs[9] |= 0x20;
-		iounmap(bcsr_regs);
-		of_node_put(np);
-	}
-
-#endif				/* CONFIG_QUICC_ENGINE */
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	if (initrd_start)
-		ROOT_DEV = Root_RAM0;
-	else
-#endif
-#ifdef  CONFIG_ROOT_NFS
-		ROOT_DEV = Root_NFS;
-#else
-		ROOT_DEV = Root_HDA1;
-#endif
-}
-
-static int __init mpc8360_declare_of_platform_devices(void)
-{
-	struct device_node *np;
-
-	for (np = NULL; (np = of_find_compatible_node(np, "network",
-					"ucc_geth")) != NULL;) {
-		int ucc_num;
-		char bus_id[BUS_ID_SIZE];
-
-		ucc_num = *((uint *) get_property(np, "device-id", NULL)) - 1;
-		snprintf(bus_id, BUS_ID_SIZE, "ucc_geth.%u", ucc_num);
-		of_platform_device_create(np, bus_id, NULL);
-	}
-
-	return 0;
-}
-device_initcall(mpc8360_declare_of_platform_devices);
-
-void __init mpc8360_sys_init_IRQ(void)
-{
-
-	struct device_node *np;
-
-	np = of_find_node_by_type(NULL, "ipic");
-	if (!np)
-		return;
-
-	ipic_init(np, 0);
-
-	/* Initialize the default interrupt mapping priorities,
-	 * in case the boot rom changed something on us.
-	 */
-	ipic_set_default_priority();
-	of_node_put(np);
-
-#ifdef CONFIG_QUICC_ENGINE
-	np = of_find_node_by_type(NULL, "qeic");
-	if (!np)
-		return;
-
-	qe_ic_init(np, 0);
-	of_node_put(np);
-#endif				/* CONFIG_QUICC_ENGINE */
-}
-
-#if defined(CONFIG_I2C_MPC) && defined(CONFIG_SENSORS_DS1374)
-extern ulong ds1374_get_rtc_time(void);
-extern int ds1374_set_rtc_time(ulong);
-
-static int __init mpc8360_rtc_hookup(void)
-{
-	struct timespec tv;
-
-	ppc_md.get_rtc_time = ds1374_get_rtc_time;
-	ppc_md.set_rtc_time = ds1374_set_rtc_time;
-
-	tv.tv_nsec = 0;
-	tv.tv_sec = (ppc_md.get_rtc_time) ();
-	do_settimeofday(&tv);
-
-	return 0;
-}
-
-late_initcall(mpc8360_rtc_hookup);
-#endif
-
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
  */
@@ -226,8 +57,8 @@ static int __init mpc8360_sys_probe(void
 define_machine(mpc8360_sys) {
 	.name 		= "MPC8360E PB",
 	.probe 		= mpc8360_sys_probe,
-	.setup_arch 	= mpc8360_sys_setup_arch,
-	.init_IRQ 	= mpc8360_sys_init_IRQ,
+	.setup_arch 	= mpc83xx_setup_arch,
+	.init_IRQ 	= mpc83xx_init_IRQ,
 	.get_irq 	= ipic_get_irq,
 	.restart 	= mpc83xx_restart,
 	.time_init 	= mpc83xx_time_init,
diff --git a/arch/powerpc/platforms/83xx/mpc83xx.h b/arch/powerpc/platforms/83xx/mpc83xx.h
index 01cae10..7419db4 100644
--- a/arch/powerpc/platforms/83xx/mpc83xx.h
+++ b/arch/powerpc/platforms/83xx/mpc83xx.h
@@ -13,5 +13,7 @@ extern int add_bridge(struct device_node
 extern int mpc83xx_exclude_device(u_char bus, u_char devfn);
 extern void mpc83xx_restart(char *cmd);
 extern long mpc83xx_time_init(void);
+extern void __init mpc83xx_setup_arch(void);
+extern void __init mpc83xx_init_IRQ(void);
 
 #endif				/* __MPC83XX_H__ */
diff --git a/arch/powerpc/platforms/83xx/setup.c b/arch/powerpc/platforms/83xx/setup.c
new file mode 100644
index 0000000..4d59aa0
--- /dev/null
+++ b/arch/powerpc/platforms/83xx/setup.c
@@ -0,0 +1,176 @@
+/*
+ * Copyright (C) Freescale Semicondutor, Inc. 2006. All rights reserved.
+ *
+ * Author: Li Yang <LeoLi@freescale.com>
+ *	   Yin Olivia <Hong-hua.Yin@freescale.com>
+ *
+ * Description:
+ * MPC83xx board routines.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/reboot.h>
+#include <linux/pci.h>
+#include <linux/kdev_t.h>
+#include <linux/major.h>
+#include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/seq_file.h>
+#include <linux/root_dev.h>
+#include <linux/initrd.h>
+
+#include <asm/of_device.h>
+#include <asm/of_platform.h>
+#include <asm/system.h>
+#include <asm/atomic.h>
+#include <asm/time.h>
+#include <asm/io.h>
+#include <asm/machdep.h>
+#include <asm/ipic.h>
+#include <asm/bootinfo.h>
+#include <asm/irq.h>
+#include <asm/prom.h>
+#include <asm/udbg.h>
+#include <sysdev/fsl_soc.h>
+#include <asm/qe.h>
+#include <asm/qe_ic.h>
+
+#include "mpc83xx.h"
+
+#undef DEBUG
+#ifdef DEBUG
+#define DBG(fmt...) udbg_printf(fmt)
+#else
+#define DBG(fmt...)
+#endif
+
+#ifndef CONFIG_PCI
+unsigned long isa_io_base = 0;
+unsigned long isa_mem_base = 0;
+#endif
+
+static u8 __iomem *bcsr_regs = NULL;
+
+u8 *get_bcsr(void)
+{
+	return bcsr_regs;
+}
+
+/* ************************************************************************
+ *
+ * Setup the architecture
+ *
+ */
+void __init mpc83xx_setup_arch(void)
+{
+	struct device_node *np;
+
+	if (ppc_md.progress)
+		ppc_md.progress("mpc83xx_setup_arch()", 0);
+
+	/* Map BCSR area */
+	np = of_find_node_by_name(NULL, "bcsr");
+	if (np != 0) {
+		struct resource res;
+
+		of_address_to_resource(np, 0, &res);
+		bcsr_regs = ioremap(res.start, res.end - res.start + 1);
+		of_node_put(np);
+	}
+
+#ifdef CONFIG_PCI
+	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
+		add_bridge(np);
+	ppc_md.pci_exclude_device = mpc83xx_exclude_device;
+#endif
+
+#ifdef CONFIG_QUICC_ENGINE
+	if ((np = of_find_node_by_type(NULL, "qe")) != NULL) {
+		qe_reset();
+		of_node_put(np);
+	}
+
+	if ((np = of_find_node_by_name(np, "par_io")) != NULL) {
+		par_io_init(np);
+		of_node_put(np);
+
+		for (np = NULL; (np = of_find_node_by_name(np, "ucc")) != NULL;)
+			par_io_of_config(np);
+	}
+
+	if ((np = of_find_compatible_node(NULL, "network", "ucc_geth"))
+			!= NULL){
+		/* Reset the Ethernet PHY */
+		bcsr_regs[9] &= ~0x20;
+		udelay(1000);
+		bcsr_regs[9] |= 0x20;
+		iounmap(bcsr_regs);
+		of_node_put(np);
+	}
+
+#endif				/* CONFIG_QUICC_ENGINE */
+}
+
+static int __init mpc83xx_publish_devices(void)
+{
+	if (machine_is(mpc83xx))
+		of_platform_bus_probe(NULL, NULL, NULL);
+
+	return 0;
+}
+device_initcall(mpc83xx_publish_devices);
+
+void __init mpc83xx_init_IRQ(void)
+{
+	struct device_node *np;
+
+	np = of_find_node_by_type(NULL, "ipic");
+	if (!np)
+		return;
+
+	ipic_init(np, 0);
+
+	/* Initialize the default interrupt mapping priorities,
+	 * in case the boot rom changed something on us.
+	 */
+	ipic_set_default_priority();
+	of_node_put(np);
+
+#ifdef CONFIG_QUICC_ENGINE
+	np = of_find_node_by_type(NULL, "qeic");
+	if (!np)
+		return;
+
+	qe_ic_init(np, 0);
+	of_node_put(np);
+#endif				/* CONFIG_QUICC_ENGINE */
+}
+
+#if defined(CONFIG_I2C_MPC) && defined(CONFIG_SENSORS_DS1374)
+extern ulong ds1374_get_rtc_time(void);
+extern int ds1374_set_rtc_time(ulong);
+
+static int __init mpc83xx_rtc_hookup(void)
+{
+	struct timespec tv;
+
+	ppc_md.get_rtc_time = ds1374_get_rtc_time;
+	ppc_md.set_rtc_time = ds1374_set_rtc_time;
+
+	tv.tv_nsec = 0;
+	tv.tv_sec = (ppc_md.get_rtc_time) ();
+	do_settimeofday(&tv);
+
+	return 0;
+}
+
+late_initcall(mpc83xx_rtc_hookup);
+#endif
-- 
1.4.4
