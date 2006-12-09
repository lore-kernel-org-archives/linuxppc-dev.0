Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 7466267B99
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Dec 2006 12:08:05 +1100 (EST)
Date: Fri, 8 Dec 2006 19:07:58 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: consolidate mpc83xx platform files
Message-Id: <20061208190758.6cee088f.kim.phillips@freescale.com>
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

Eliminate code redundancy.  mpc83[246]x_{mds,itx,sys,pb} files merged
into a single setup.c.  machine_probe, instead of using the model property,
checks the compatible property for "MPC83xx" (dts files updated appropriately).
This patch also utilizes of_platform_bus_probe() in lieu of manually
calling of_platform_device_create for each ucc_geth device.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 arch/powerpc/boot/dts/mpc8349emds.dts     |    2 +-
 arch/powerpc/boot/dts/mpc8349emitx.dts    |    2 +-
 arch/powerpc/kernel/of_platform.c         |    1 +
 arch/powerpc/platforms/83xx/Makefile      |    6 +-
 arch/powerpc/platforms/83xx/mpc832x_mds.c |  232 ----------------------------
 arch/powerpc/platforms/83xx/mpc832x_mds.h |   19 ---
 arch/powerpc/platforms/83xx/mpc834x_itx.c |  121 ---------------
 arch/powerpc/platforms/83xx/mpc834x_itx.h |   23 ---
 arch/powerpc/platforms/83xx/mpc834x_sys.c |  140 -----------------
 arch/powerpc/platforms/83xx/mpc834x_sys.h |   23 ---
 arch/powerpc/platforms/83xx/mpc8360e_pb.c |  236 -----------------------------
 arch/powerpc/platforms/83xx/setup.c       |  215 ++++++++++++++++++++++++++
 12 files changed, 219 insertions(+), 801 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8349emds.dts b/arch/powerpc/boot/dts/mpc8349emds.dts
index efceb34..5ad91a2 100644
--- a/arch/powerpc/boot/dts/mpc8349emds.dts
+++ b/arch/powerpc/boot/dts/mpc8349emds.dts
@@ -11,7 +11,7 @@
 
 / {
 	model = "MPC8349EMDS";
-	compatible = "MPC834xMDS";
+	compatible = "MPC83xx\0MPC834xMDS";
 	#address-cells = <1>;
 	#size-cells = <1>;
 
diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index 27807fc..f2ba63e 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -10,7 +10,7 @@
  */
 / {
 	model = "MPC8349EMITX";
-	compatible = "MPC834xMITX";
+	compatible = "MPC83xx\0MPC834xMITX";
 	#address-cells = <1>;
 	#size-cells = <1>;
 
diff --git a/arch/powerpc/kernel/of_platform.c b/arch/powerpc/kernel/of_platform.c
index b3189d0..2ad0386 100644
--- a/arch/powerpc/kernel/of_platform.c
+++ b/arch/powerpc/kernel/of_platform.c
@@ -50,6 +50,7 @@ static struct of_device_id of_default_bu
 	{ .type = "plb5", },
 	{ .type = "plb4", },
 	{ .type = "opb", },
+	{ .type = "qe", },
 	{},
 };
 
diff --git a/arch/powerpc/platforms/83xx/Makefile b/arch/powerpc/platforms/83xx/Makefile
index f1aa7e2..478c2a9 100644
--- a/arch/powerpc/platforms/83xx/Makefile
+++ b/arch/powerpc/platforms/83xx/Makefile
@@ -1,9 +1,5 @@
 #
 # Makefile for the PowerPC 83xx linux kernel.
 #
-obj-y				:= misc.o
+obj-y				:= setup.o misc.o
 obj-$(CONFIG_PCI)		+= pci.o
-obj-$(CONFIG_MPC834x_SYS)	+= mpc834x_sys.o
-obj-$(CONFIG_MPC834x_ITX)	+= mpc834x_itx.o
-obj-$(CONFIG_MPC8360E_PB)	+= mpc8360e_pb.o
-obj-$(CONFIG_MPC832x_MDS)	+= mpc832x_mds.o
diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.c b/arch/powerpc/platforms/83xx/mpc832x_mds.c
deleted file mode 100644
index f58c978..0000000
--- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
+++ /dev/null
@@ -1,232 +0,0 @@
-/*
- * Copyright (C) Freescale Semicondutor, Inc. 2006. All rights reserved.
- *
- * Description:
- * MPC832xE MDS board specific routines.
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
-#include <linux/reboot.h>
-#include <linux/pci.h>
-#include <linux/kdev_t.h>
-#include <linux/major.h>
-#include <linux/console.h>
-#include <linux/delay.h>
-#include <linux/seq_file.h>
-#include <linux/root_dev.h>
-#include <linux/initrd.h>
-
-#include <asm/of_device.h>
-#include <asm/system.h>
-#include <asm/atomic.h>
-#include <asm/time.h>
-#include <asm/io.h>
-#include <asm/machdep.h>
-#include <asm/ipic.h>
-#include <asm/bootinfo.h>
-#include <asm/irq.h>
-#include <asm/prom.h>
-#include <asm/udbg.h>
-#include <sysdev/fsl_soc.h>
-#include <asm/qe.h>
-#include <asm/qe_ic.h>
-
-#include "mpc83xx.h"
-#include "mpc832x_mds.h"
-
-#undef DEBUG
-#ifdef DEBUG
-#define DBG(fmt...) udbg_printf(fmt)
-#else
-#define DBG(fmt...)
-#endif
-
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
-/*
- * Called very early, MMU is off, device-tree isn't unflattened
- */
-static int __init mpc832x_sys_probe(void)
-{
-	char *model = of_get_flat_dt_prop(of_get_flat_dt_root(),
-					  "model", NULL);
-
-	if (model == NULL)
-		return 0;
-	if (strcmp(model, "MPC8323EMDS"))
-		return 0;
-
-	DBG("%s found\n", model);
-
-	return 1;
-}
-
-define_machine(mpc832x_mds) {
-	.name 		= "MPC832x MDS",
-	.probe 		= mpc832x_sys_probe,
-	.setup_arch 	= mpc832x_sys_setup_arch,
-	.init_IRQ 	= mpc832x_sys_init_IRQ,
-	.get_irq 	= ipic_get_irq,
-	.restart 	= mpc83xx_restart,
-	.time_init 	= mpc83xx_time_init,
-	.calibrate_decr	= generic_calibrate_decr,
-	.progress 	= udbg_progress,
-};
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
deleted file mode 100644
index 314c42a..0000000
--- a/arch/powerpc/platforms/83xx/mpc834x_itx.c
+++ /dev/null
@@ -1,121 +0,0 @@
-/*
- * arch/powerpc/platforms/83xx/mpc834x_itx.c
- *
- * MPC834x ITX board specific routines
- *
- * Maintainer: Kumar Gala <galak@kernel.crashing.org>
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
-#include <linux/reboot.h>
-#include <linux/pci.h>
-#include <linux/kdev_t.h>
-#include <linux/major.h>
-#include <linux/console.h>
-#include <linux/delay.h>
-#include <linux/seq_file.h>
-#include <linux/root_dev.h>
-
-#include <asm/system.h>
-#include <asm/atomic.h>
-#include <asm/time.h>
-#include <asm/io.h>
-#include <asm/machdep.h>
-#include <asm/ipic.h>
-#include <asm/bootinfo.h>
-#include <asm/irq.h>
-#include <asm/prom.h>
-#include <asm/udbg.h>
-#include <sysdev/fsl_soc.h>
-
-#include "mpc83xx.h"
-
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
-#else
-	ROOT_DEV = Root_HDA1;
-#endif
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
-
-/*
- * Called very early, MMU is off, device-tree isn't unflattened
- */
-static int __init mpc834x_itx_probe(void)
-{
-	/* We always match for now, eventually we should look at the flat
-	   dev tree to ensure this is the board we are suppose to run on
-	*/
-	return 1;
-}
-
-define_machine(mpc834x_itx) {
-	.name			= "MPC834x ITX",
-	.probe			= mpc834x_itx_probe,
-	.setup_arch		= mpc834x_itx_setup_arch,
-	.init_IRQ		= mpc834x_itx_init_IRQ,
-	.get_irq		= ipic_get_irq,
-	.restart		= mpc83xx_restart,
-	.time_init		= mpc83xx_time_init,
-	.calibrate_decr		= generic_calibrate_decr,
-	.progress		= udbg_progress,
-};
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
deleted file mode 100644
index 80b735a..0000000
--- a/arch/powerpc/platforms/83xx/mpc834x_sys.c
+++ /dev/null
@@ -1,140 +0,0 @@
-/*
- * arch/powerpc/platforms/83xx/mpc834x_sys.c
- *
- * MPC834x SYS board specific routines
- *
- * Maintainer: Kumar Gala <galak@kernel.crashing.org>
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
-#include <linux/reboot.h>
-#include <linux/pci.h>
-#include <linux/kdev_t.h>
-#include <linux/major.h>
-#include <linux/console.h>
-#include <linux/delay.h>
-#include <linux/seq_file.h>
-#include <linux/root_dev.h>
-
-#include <asm/system.h>
-#include <asm/atomic.h>
-#include <asm/time.h>
-#include <asm/io.h>
-#include <asm/machdep.h>
-#include <asm/ipic.h>
-#include <asm/bootinfo.h>
-#include <asm/irq.h>
-#include <asm/prom.h>
-#include <asm/udbg.h>
-#include <sysdev/fsl_soc.h>
-
-#include "mpc83xx.h"
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
-#else
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
-#endif
-
-/*
- * Called very early, MMU is off, device-tree isn't unflattened
- */
-static int __init mpc834x_sys_probe(void)
-{
-	/* We always match for now, eventually we should look at the flat
-	   dev tree to ensure this is the board we are suppose to run on
-	*/
-	return 1;
-}
-
-define_machine(mpc834x_sys) {
-	.name			= "MPC834x SYS",
-	.probe			= mpc834x_sys_probe,
-	.setup_arch		= mpc834x_sys_setup_arch,
-	.init_IRQ		= mpc834x_sys_init_IRQ,
-	.get_irq		= ipic_get_irq,
-	.restart		= mpc83xx_restart,
-	.time_init		= mpc83xx_time_init,
-	.calibrate_decr		= generic_calibrate_decr,
-	.progress		= udbg_progress,
-};
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
deleted file mode 100644
index 7bfd47a..0000000
--- a/arch/powerpc/platforms/83xx/mpc8360e_pb.c
+++ /dev/null
@@ -1,236 +0,0 @@
-/*
- * Copyright (C) Freescale Semicondutor, Inc. 2006. All rights reserved.
- *
- * Author: Li Yang <LeoLi@freescale.com>
- *	   Yin Olivia <Hong-hua.Yin@freescale.com>
- *
- * Description:
- * MPC8360E MDS PB board specific routines.
- *
- * Changelog:
- * Jun 21, 2006	Initial version
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
-#include <linux/reboot.h>
-#include <linux/pci.h>
-#include <linux/kdev_t.h>
-#include <linux/major.h>
-#include <linux/console.h>
-#include <linux/delay.h>
-#include <linux/seq_file.h>
-#include <linux/root_dev.h>
-#include <linux/initrd.h>
-
-#include <asm/of_device.h>
-#include <asm/system.h>
-#include <asm/atomic.h>
-#include <asm/time.h>
-#include <asm/io.h>
-#include <asm/machdep.h>
-#include <asm/ipic.h>
-#include <asm/bootinfo.h>
-#include <asm/irq.h>
-#include <asm/prom.h>
-#include <asm/udbg.h>
-#include <sysdev/fsl_soc.h>
-#include <asm/qe.h>
-#include <asm/qe_ic.h>
-
-#include "mpc83xx.h"
-
-#undef DEBUG
-#ifdef DEBUG
-#define DBG(fmt...) udbg_printf(fmt)
-#else
-#define DBG(fmt...)
-#endif
-
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
-/*
- * Called very early, MMU is off, device-tree isn't unflattened
- */
-static int __init mpc8360_sys_probe(void)
-{
-	char *model = of_get_flat_dt_prop(of_get_flat_dt_root(),
-					  "model", NULL);
-	if (model == NULL)
-		return 0;
-	if (strcmp(model, "MPC8360EPB"))
-		return 0;
-
-	DBG("MPC8360EMDS-PB found\n");
-
-	return 1;
-}
-
-define_machine(mpc8360_sys) {
-	.name 		= "MPC8360E PB",
-	.probe 		= mpc8360_sys_probe,
-	.setup_arch 	= mpc8360_sys_setup_arch,
-	.init_IRQ 	= mpc8360_sys_init_IRQ,
-	.get_irq 	= ipic_get_irq,
-	.restart 	= mpc83xx_restart,
-	.time_init 	= mpc83xx_time_init,
-	.calibrate_decr	= generic_calibrate_decr,
-	.progress 	= udbg_progress,
-};
diff --git a/arch/powerpc/platforms/83xx/setup.c b/arch/powerpc/platforms/83xx/setup.c
new file mode 100644
index 0000000..614bab2
--- /dev/null
+++ b/arch/powerpc/platforms/83xx/setup.c
@@ -0,0 +1,215 @@
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
+#define DEBUG
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
+static void __init mpc83xx_setup_arch(void)
+{
+	struct device_node *np;
+
+	if (ppc_md.progress)
+		ppc_md.progress("mpc83xx_setup_arch()", 0);
+
+	np = of_find_node_by_type(NULL, "cpu");
+	if (np != 0) {
+		const unsigned int *fp =
+		    get_property(np, "clock-frequency", NULL);
+		if (fp != 0)
+			loops_per_jiffy = *fp / HZ;
+		else
+			loops_per_jiffy = 50000000 / HZ;
+		of_node_put(np);
+	}
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
+
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
+
+/*
+ * Called very early, MMU is off, device-tree isn't unflattened
+ */
+static int __init mpc83xx_probe(void)
+{
+        unsigned long root = of_get_flat_dt_root();
+
+        if (!of_flat_dt_is_compatible(root, "MPC83xx"))
+                return 0;
+
+	DBG("MPC83xx compatible found\n");
+
+	return 1;
+}
+
+define_machine(mpc83xx) {
+	.name 		= "MPC83xx",
+	.probe 		= mpc83xx_probe,
+	.setup_arch 	= mpc83xx_setup_arch,
+	.init_IRQ 	= mpc83xx_init_IRQ,
+	.get_irq 	= ipic_get_irq,
+	.restart 	= mpc83xx_restart,
+	.time_init 	= mpc83xx_time_init,
+	.calibrate_decr	= generic_calibrate_decr,
+	.progress 	= udbg_progress,
+};
-- 
1.4.4
