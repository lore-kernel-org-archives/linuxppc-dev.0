Return-Path: <rongkai.zhan@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id EB954DDE2D
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 06:14:02 +1000 (EST)
Message-ID: <469B3401.9030602@windriver.com>
Date: Mon, 16 Jul 2007 17:01:53 +0800
From: Mark Zhan <rongkai.zhan@windriver.com>
MIME-Version: 1.0
To: paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 3/3] 82xx: SBCPQ2 board platform support
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch addes the powerpc support to Wind River SBC PowerQUICCII 82xx board.

Signed-off-by: Mark Zhan <rongkai.zhan@windriver.com>
---
  arch/powerpc/boot/dts/sbcpq2.dts      |  191 +++++++
  arch/powerpc/configs/sbcpq2_defconfig |  917 ++++++++++++++++++++++++++++++++++
  arch/powerpc/platforms/82xx/Kconfig   |   10
  arch/powerpc/platforms/82xx/Makefile  |    5
  arch/powerpc/platforms/82xx/sbcpq2.c  |  306 +++++++++++
  arch/powerpc/platforms/82xx/sbcpq2.h  |  118 ++++
  include/asm-powerpc/mpc8260.h         |    4
  7 files changed, 1549 insertions(+), 2 deletions(-)

Index: linux-powerpc-2.6.x/arch/powerpc/platforms/82xx/Kconfig
===================================================================
--- linux-powerpc-2.6.x.orig/arch/powerpc/platforms/82xx/Kconfig	2007-07-16 16:25:11.000000000 +0800
+++ linux-powerpc-2.6.x/arch/powerpc/platforms/82xx/Kconfig	2007-07-16 16:25:16.000000000 +0800
@@ -13,6 +13,16 @@
  	help
  	This option enables support for the MPC8272 ADS board

+config SBCPQ2
+	bool "Wind River SBC PowerQUICCII 82xx"
+	select DEFAULT_UIMAGE
+	select 8260
+	select CPM2
+	select FSL_SOC
+	help
+	  This option enables support for Wind River SBC PowerQUICCII 82xx,
+	  which is a single-board computer with MPC82xx CPU.
+
  endchoice

  config PQ2ADS
Index: linux-powerpc-2.6.x/arch/powerpc/platforms/82xx/Makefile
===================================================================
--- linux-powerpc-2.6.x.orig/arch/powerpc/platforms/82xx/Makefile	2007-07-16 16:25:11.000000000 +0800
+++ linux-powerpc-2.6.x/arch/powerpc/platforms/82xx/Makefile	2007-07-16 16:25:16.000000000 +0800
@@ -1,5 +1,6 @@
  #
  # Makefile for the PowerPC 82xx linux kernel.
  #
-obj-$(CONFIG_PPC_82xx) += mpc82xx.o
-obj-$(CONFIG_MPC82xx_ADS) += mpc82xx_ads.o
+obj-$(CONFIG_PPC_82xx)		+= mpc82xx.o
+obj-$(CONFIG_MPC82xx_ADS)	+= mpc82xx_ads.o
+obj-$(CONFIG_SBCPQ2)		+= sbcpq2.o
Index: linux-powerpc-2.6.x/arch/powerpc/platforms/82xx/sbcpq2.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-powerpc-2.6.x/arch/powerpc/platforms/82xx/sbcpq2.c	2007-07-16 16:29:55.000000000 +0800
@@ -0,0 +1,306 @@
+/*
+ * sbcpq2.c: The platform support for Wind River SBC PowerQUICCII 82xx
+ *
+ * Copyright 2007, Wind River Systems, Inc.
+ *
+ * Author: Mark Zhan <rongkai.zhan@windriver.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/reboot.h>
+#include <linux/pci.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/rtc.h>
+#include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/seq_file.h>
+#include <linux/fsl_devices.h>
+#include <linux/fs_uart_pd.h>
+#include <linux/fs_enet_pd.h>
+
+#include <asm/prom.h>
+#include <asm/machdep.h>
+#include <asm/pci-bridge.h>
+#include <asm/mpc8260.h>
+#include <asm/cpm2.h>
+#include <sysdev/cpm2_pic.h>
+#include <asm/udbg.h>
+#include <asm/i8259.h>
+#include <asm/fs_pd.h>
+
+static struct resource m48t59_resources[] = {
+	{
+		.start	= SBCPQ2_RTC_BASE,
+		.end	= SBCPQ2_RTC_BASE + SBCPQ2_RTC_SIZE - 1,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= SBCPQ2_M48T59_IRQ,
+		.end	= SBCPQ2_M48T59_IRQ,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{ },
+};
+
+static struct platform_device m48t59_rtc = {
+	.name		= "rtc-m48t59",
+	.id 		= 0,
+	.num_resources	= 2,
+	.resource	= m48t59_resources,
+};
+
+static struct platform_device *sbcpq2_devices[] __initdata = {
+	&m48t59_rtc,
+};
+
+/**
+ * sbcpq2_pdev_init - Register the platform device for sbcpq2 board
+ */
+static int __init sbcpq2_platdev_init(void)
+{
+	struct irq_desc *desc = irq_desc + SBCPQ2_M48T59_IRQ;
+
+	/* Install a dummy irq chip for M48T59 RTC irq */
+	if (desc->chip == &no_irq_chip)
+		set_irq_handler(SBCPQ2_M48T59_IRQ, desc->handle_irq);
+
+	/* Register all platform devices for sbcpq2 */
+	platform_add_devices(sbcpq2_devices, ARRAY_SIZE(sbcpq2_devices));
+	return 0;
+}
+arch_initcall(sbcpq2_platdev_init);
+
+/*
+ * For SBCPQ2 board, the interrupt of M48T59 RTC chip
+ * will generate a machine check exception. We use a
+ * fake irq to give the platform machine_check_exception() hook
+ * a chance to call the driver ISR. If IRQ_HANDLED is returned,
+ * then we will survive from the machine check exception.
+ */
+static int sbcpq2_mach_check(struct pt_regs *regs)
+{
+	int recover = 0;
+	struct irq_desc *desc = irq_desc + SBCPQ2_M48T59_IRQ;
+	struct irqaction *action = desc->action;
+
+	while (action && (action->dev_id != &m48t59_rtc))
+		action = action->next;
+
+	/* Try to call m48t59 RTC driver ISR */
+	if (action && action->handler)
+		recover = action->handler(SBCPQ2_M48T59_IRQ, &m48t59_rtc);
+
+	return recover;
+}
+
+void init_fcc_ioports(struct fs_platform_info *fpi)
+{
+	iop_cpm2_t *iop;
+	int fcc_no, target;
+	unsigned int tempval;
+
+	iop = &cpm2_immr->im_ioport;
+	fcc_no = fs_get_fcc_index(fpi->fs_no);
+	switch (fcc_no) {
+	case 0:
+		/* Configure port A and C pins for FCC1 Ethernet. */
+		tempval = in_be32(&iop->iop_pdira);
+		tempval &= ~PA1_DIRA0;
+		tempval |= PA1_DIRA1;
+		out_be32(&iop->iop_pdira, tempval);
+
+		tempval = in_be32(&iop->iop_psora);
+		tempval &= ~PA1_PSORA0;
+		tempval |= PA1_PSORA1;
+		out_be32(&iop->iop_psora, tempval);
+
+		setbits32(&iop->iop_ppara, (PA1_DIRA0 | PA1_DIRA1));
+		target = CPM_CLK_FCC1;
+		break;
+	case 1:
+		/* Configure port B and C pins for FCC Ethernet. */
+		tempval = in_be32(&iop->iop_pdirb);
+		tempval &= ~PB2_DIRB0;
+		tempval |= PB2_DIRB1;
+		out_be32(&iop->iop_pdirb, tempval);
+
+		tempval = in_be32(&iop->iop_psorb);
+		tempval &= ~PB2_PSORB0;
+		tempval |= PB2_PSORB1;
+		out_be32(&iop->iop_psorb, tempval);
+
+		setbits32(&iop->iop_pparb, (PB2_DIRB0 | PB2_DIRB1));
+		target = CPM_CLK_FCC2;
+		break;
+	case 2:
+		/* Configure port B and C pins for FCC Ethernet. */
+		tempval = in_be32(&iop->iop_pdirb);
+		tempval &= ~PB3_DIRB0;
+		tempval |= PB3_DIRB1;
+		out_be32(&iop->iop_pdirb, tempval);
+
+		tempval = in_be32(&iop->iop_psorb);
+		tempval &= ~PB3_PSORB0;
+		tempval |= PB3_PSORB1;
+		out_be32(&iop->iop_psorb, tempval);
+
+		setbits32(&iop->iop_pparb, (PB3_DIRB0 | PB3_DIRB1));
+
+		tempval = in_be32(&iop->iop_pdirc);
+		tempval |= PC3_TXDAT;
+		out_be32(&iop->iop_pdirc, tempval);
+
+		tempval = in_be32(&iop->iop_psorc);
+		tempval &= ~PC3_TXDAT;
+		out_be32(&iop->iop_psorc, tempval);
+
+		setbits32(&iop->iop_pparc, PC3_TXDAT);
+		target = CPM_CLK_FCC3;
+		break;
+	default:
+		printk(KERN_DEBUG "Invalid FCC number %d\n", fcc_no);
+		return;
+	} /* switch (fcc_no) */
+
+	/* Alter clocks of port C */
+	tempval = PC_CLK(fpi->clk_rx - 8) | PC_CLK(fpi->clk_tx - 8);
+	clrbits32(&iop->iop_psorc, tempval);
+	clrbits32(&iop->iop_pdirc, tempval);
+	setbits32(&iop->iop_pparc, tempval);
+
+	/* configure clock routining */
+	cpm2_clk_setup(target, fpi->clk_rx, CPM_CLK_RX);
+	cpm2_clk_setup(target, fpi->clk_tx, CPM_CLK_TX);
+}
+
+static void __init sbcpq2_init_IRQ(void)
+{
+	struct device_node *np;
+	struct resource res;
+
+	np = of_find_compatible_node(NULL, "cpm-pic", "CPM2");
+	if (np == NULL) {
+		printk(KERN_ERR "PIC init: can not find cpm-pic node\n");
+		return;
+	}
+	if (of_address_to_resource(np, 0, &res)) {
+		printk(KERN_ERR "PIC init: invalid resource\n");
+		of_node_put(np);
+		return;
+	}
+
+	/* Init CPM2 interrupt controller */
+	cpm2_pic_init(np);
+
+	/* Initialize the default interrupt mapping priorities,
+	 * in case the boot rom changed something on us.
+	 */
+	cpm2_immr->im_intctl.ic_siprr = 0x05309770;
+
+	of_node_put(np);
+}
+
+/**
+ * sbcpq2_setup_arch - the board-level setup routine
+ */
+static void __init sbcpq2_setup_arch(void)
+{
+	struct device_node *np;
+	volatile memctl_cpm2_t *mc;
+	unsigned char * eeprom_base;
+	int i = 0;
+
+#ifdef CONFIG_CPM2
+	cpm2_reset();
+#endif
+
+	/*
+	 * Make sure that we have the right CS# setting
+	 */
+	mc = &cpm2_immr->im_memctl;
+
+	/* Boot Flash is the on-board flash */
+	mc->memc_br0 = (SBCPQ2_BOOT_FLASH_BASE & 0xFFFF8000) | 0x0801;
+	mc->memc_or0 = 0xFFE00896;
+
+	/* CS5 for EEPROM, visionPORT, User Swith, Status, i8259 and LED */
+	mc->memc_br5 = (SBCPQ2_EEPROM_BASE & 0xFFFF8000) | 0x0801;
+	mc->memc_or5 = 0xFFFF0856;
+
+	/* CS11 for RTC */
+	mc->memc_br11 = (SBCPQ2_RTC_BASE & 0xFFFF8000) | 0x0801;
+	mc->memc_or11 = 0xFFFF8836;
+
+	/*
+	 * Fixup the MAC address in DevTree Blob, with the MAC address
+	 * in EEPROM.
+	 */
+	eeprom_base = ioremap(SBCPQ2_EEPROM_BASE, SBCPQ2_EEPROM_SIZE);
+	if (eeprom_base == NULL)
+		return;
+
+	for (np = NULL, i = 0;
+	    (np = of_find_compatible_node(np, "network", "fs_enet")) != NULL;
+	    i++) {
+		char *model, *macaddr;
+		const unsigned int *id;
+		int j = 0, eeprom_ofs = 0;
+
+		model = (char *)of_get_property(np, "model", NULL);
+		if (!model)
+			continue;
+
+		id = of_get_property(np, "device-id", NULL);
+		if (!id)
+			continue;
+
+		macaddr = (unsigned char *)of_get_mac_address(np);
+		if (!macaddr)
+			continue;
+
+		if (strstr(model, "FCC"))
+			eeprom_ofs = SBCPQ2_FCC1_MACADDR_OFS;
+		else if (strstr(model, "SCC"))
+			eeprom_ofs = SBCPQ2_SCC1_MACADDR_OFS;
+		eeprom_ofs += ((*id) - 1) * 6;
+
+		for (j = 0; j < 6; j++)
+			*(macaddr + j) = *(eeprom_base + eeprom_ofs + j);
+	}
+	iounmap(eeprom_base);
+}
+
+/*
+ * Called very early, device-tree isn't unflattened
+ */
+static int __init sbcpq2_probe(void)
+{
+	/* We always match for now, eventually we should look at
+	 * the flat dev tree to ensure this is the board we are
+	 * supposed to run on
+	 */
+	return 1;
+}
+
+define_machine(sbcpq2)
+{
+	.name		= CPUINFO_MACHINE,
+	.probe		= sbcpq2_probe,
+	.setup_arch	= sbcpq2_setup_arch,
+	.init_IRQ	= sbcpq2_init_IRQ,
+	.show_cpuinfo	= mpc82xx_show_cpuinfo,
+	.get_irq	= cpm2_get_irq,
+	.calibrate_decr	= mpc82xx_calibrate_decr,
+	.restart	= mpc82xx_restart,
+	.halt		= mpc82xx_halt,
+	.machine_check_exception = sbcpq2_mach_check,
+};
Index: linux-powerpc-2.6.x/arch/powerpc/platforms/82xx/sbcpq2.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-powerpc-2.6.x/arch/powerpc/platforms/82xx/sbcpq2.h	2007-07-16 16:25:16.000000000 +0800
@@ -0,0 +1,118 @@
+/*
+ * sbcpq2.h: the header file for Wind River SBC PowerQUICCII 82xx
+ *
+ * Copyright (C) 2007, Wind River Systems, Inc.
+ * Mark Zhan, <rongkai.zhan@windriver.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __MACH_SBCPQ2_H
+#define __MACH_SBCPQ2_H
+
+#include <asm/ppcboot.h>
+
+/* For our show_cpuinfo hooks. */
+#define CPUINFO_VENDOR		"Wind River"
+#define CPUINFO_MACHINE		"SBC PowerQUICCII 82xx"
+
+/*
+ * Wind River SBC PowerQUICCII 82xx Physical Memory Map (CS0 for OnBoard Flash)
+ *
+ *   0x00000000 - 0x07FFFFFF	CS2, 128 MB DIMM SDRAM
+ *   0x08000000 - 0x0FFFFFFF	CS3, 128 MB DIMM SDRAM
+ *   0x12000000 - 0x12100000	CS8, ATM
+ *   0x20000000 - 0x20FFFFFF	CS4, 16 MB Local Bus SDRAM
+ *   0x21000000 - 0x21001FFF	CS7, Control EPLD
+ *   0x22000000 - 0x22001FFF	CS5, 8KB EEPROM
+ *   0x22002000 - 0x22003FFF	CS5, visionPORT
+ *   0x22004000 - 0x22005FFF	CS5, User Switches
+ *   0x22006000 - 0x22007FFF	CS5, STATUS
+ *   0x22008000 - 0x22009FFF	CS5, i8259 interrupt controller
+ *   0x2200A000 - 0x2200BFFF	CS5, LED (Seven Segment Display)
+ *   0x80000000 - 0x80001FFF	CS11, RTC
+ *   0xE0000000 - 0xE3FFFFFF	CS6, 64 MB DIMM Flash
+ *   0xE4000000 - 0xE7FFFFFF	CS1, 64 MB DIMM Flash
+ *   0xFE000000 - 0xFFFFFFFF	CS0, 2 MB Boot Flash
+ *   0xF0000000 - 0xF0020000	MPC82xx Internal Registers Space
+ */
+#define SBCPQ2_SDRAM_BASE		0x00000000
+#define SBCPQ2_SDRAM_SIZE		0x10000000
+
+#define SBCPQ2_LOCAL_SDRAM_BASE		0x20000000
+#define SBCPQ2_LOCAL_SDRAM_SIZE		0x1000000
+
+#define SBCPQ2_EPLD_BASE		0x21000000
+#define SBCPQ2_EPLD_SIZE		0x2000
+
+#define SBCPQ2_EEPROM_BASE		0x22000000
+#define SBCPQ2_EEPROM_SIZE		0x2000
+
+/* User Switches SW5 */
+#define SBCPQ2_USER_SW_BASE		0x22004000
+#define SBCPQ2_USER_SW_SIZE		0x2000
+
+#define SBCPQ2_STATUS_BASE		0x22006000
+#define SBCPQ2_STATUS_SIZE		0x2000
+
+#define SBCPQ2_I8259_BASE		0x22008000
+#define SBCPQ2_I8259_SIZE		0x2000
+
+/* Seven Segment Display LED D46 */
+#define SBCPQ2_LED_BASE			0x2200A000
+#define SBCPQ2_LED_SIZE			0x2000
+
+#define SBCPQ2_RTC_BASE			0x80000000
+#define SBCPQ2_RTC_SIZE			0x2000
+
+#define SBCPQ2_BOOT_FLASH_BASE		0xFE000000
+#define SBCPQ2_BOOT_FLASH_SIZE		0x00200000
+
+#define SBCPQ2_DIMM_FLASH_BASE		0xE0000000
+#define SBCPQ2_DIMM_FLASH_SIZE		0x04000000
+
+#define CPM_MAP_ADDR			0xF0000000
+#define CPM_IRQ_OFFSET			0
+
+/*
+ * The offset of ethernet MAC addr within EEPROM
+ */
+#define SBCPQ2_FCC1_MACADDR_OFS		0x60
+#define SBCPQ2_FCC2_MACADDR_OFS		0x66
+#define SBCPQ2_FCC3_MACADDR_OFS		0x72
+#define SBCPQ2_SCC1_MACADDR_OFS		0x78
+
+/*
+ * The interrupt of M48T59 RTC chip will generate
+ * a machine check exception. We use a fake irq
+ * to get the platform machine_check_exception() hook
+ * have a chance to call the driver ISR.
+ */
+#define SBCPQ2_M48T59_IRQ		(NR_IRQS-1)
+
+/*
+ * The following IRQs are routed to i8259 PIC.
+ *
+ * NOTE: i8259 PIC is cascaded to SIU_INT_IRQ6 of CPM2 interrupt controller
+ */
+#define SBCPQ2_PC_IRQA		(NR_SIU_INTS+0)
+#define SBCPQ2_PC_IRQB		(NR_SIU_INTS+1)
+#define SBCPQ2_MPC185_IRQ	(NR_SIU_INTS+2)
+#define SBCPQ2_ATM_IRQ		(NR_SIU_INTS+3)
+#define SBCPQ2_PIRQA		(NR_SIU_INTS+4)
+#define SBCPQ2_PIRQB		(NR_SIU_INTS+5)
+#define SBCPQ2_PIRQC		(NR_SIU_INTS+6)
+#define SBCPQ2_PIRQD		(NR_SIU_INTS+7)
+
+/* cpm serial driver works with constants below */
+#define SIU_INT_SMC1		((uint)0x04+CPM_IRQ_OFFSET)
+#define SIU_INT_SMC2		((uint)0x05+CPM_IRQ_OFFSET)
+#define SIU_INT_SCC1		((uint)0x28+CPM_IRQ_OFFSET)
+#define SIU_INT_SCC2		((uint)0x29+CPM_IRQ_OFFSET)
+#define SIU_INT_SCC3		((uint)0x2a+CPM_IRQ_OFFSET)
+#define SIU_INT_SCC4		((uint)0x2b+CPM_IRQ_OFFSET)
+
+#endif /* __MACH_SBCPQ2_H */
Index: linux-powerpc-2.6.x/include/asm-powerpc/mpc8260.h
===================================================================
--- linux-powerpc-2.6.x.orig/include/asm-powerpc/mpc8260.h	2007-07-16 16:25:11.000000000 +0800
+++ linux-powerpc-2.6.x/include/asm-powerpc/mpc8260.h	2007-07-16 16:25:16.000000000 +0800
@@ -15,6 +15,10 @@
  #include <platforms/82xx/pq2ads.h>
  #endif

+#ifdef CONFIG_SBCPQ2
+#include <platforms/82xx/sbcpq2.h>
+#endif
+
  #ifdef CONFIG_PCI_8260
  #include <platforms/82xx/m82xx_pci.h>
  #endif
Index: linux-powerpc-2.6.x/arch/powerpc/boot/dts/sbcpq2.dts
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-powerpc-2.6.x/arch/powerpc/boot/dts/sbcpq2.dts	2007-07-16 16:25:16.000000000 +0800
@@ -0,0 +1,191 @@
+/*
+ * Wind River SBC PowerQUICCII 82xx Device Tree Source
+ *
+ * Copyright 2007, Wind River Systems, Inc.
+ * Mark Zhan <rongkai.zhan@windriver.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * Build with: dtc -f -I dts -O dtb -o sbcpq2.dtb -V 16 sbcpq2.dts
+ */
+
+/ {
+	model = "SBCPQ2";
+	compatible = "mpc82xx";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	linux,phandle = <100>;
+
+	cpus {
+		#cpus = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		linux,phandle = <200>;
+
+		PowerPC,8260@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <20>;       // 32 bytes
+			i-cache-line-size = <20>;       // 32 bytes
+			d-cache-size = <4000>;          // L1, 16K
+			i-cache-size = <4000>;          // L1, 16K
+			timebase-frequency = <0>;	/* = (bus-frequency / 4) */
+			bus-frequency = <0>;		/* = bd->bi_busfreq */
+			clock-frequency = <0>;		/* = bd->bi_intfreq = gd->cpu_clk */
+			32-bit;
+			linux,phandle = <201>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		linux,phandle = <300>;
+		/* 256MB DIMM SDRAM & 16MB Local Bus SDRAM */
+		reg = <00000000 10000000 20000000 01000000>;
+	};
+
+	soc8260@f0000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#interrupt-cells = <2>;
+		device_type = "soc";
+		ranges = <00000000 f0000000 00020000>;
+		reg = <f0000000 00020000>;
+		bus-frequency = <0>; /* from u-boot */
+
+		cpm@f0000000 {
+			linux,phandle = <f0000000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#interrupt-cells = <2>;
+			device_type = "cpm";
+			model = "CPM2";
+			ranges = <00000000 00000000 00020000>;
+			reg = <0 00020000>;
+			command-proc = <0>;	/* from u-boot */
+			brg-frequency = <0>;	/* from u-boot */
+			cpm_clk = <0>;		/* from u-boot */
+
+			smc@11a80 {
+				device_type = "serial";
+				compatible = "cpm_uart";
+				model = "SMC";
+				device-id = <1>;
+				reg = <11a80 10 0 40>;
+				rx-clock = <1>;
+				tx-clock = <1>;
+				interrupts = <4 2>;
+				interrupt-parent = <&cpm2_pic>;
+				current-speed = <1c200>;
+			};
+
+			smc@11a90 {
+				device_type = "serial";
+				compatible = "cpm_uart";
+				model = "SMC";
+				device-id = <2>;
+				reg = <11a90 10 40 40>;
+				rx-clock = <2>;
+				tx-clock = <2>;
+				interrupts = <5 2>;
+				interrupt-parent = <&cpm2_pic>;
+				current-speed = <1c200>;
+			};
+
+			fcc@11300 {
+				device_type = "network";
+				compatible = "fs_enet";
+				model = "FCC";
+				device-id = <1>;
+				reg = <11300 20 8400 100 11380 30>;
+				mac-address = [ 00 11 2F 99 43 54 ];
+				interrupts = <20 2>;
+				interrupt-parent = <&cpm2_pic>;
+				phy-handle = <2452000>;
+				/* should be the index of cpm_clk */
+				rx-clock = <11>; /* CPM_CLK9 = 0x11 */
+				tx-clock = <12>; /* CPM_CLK10 = 0x12 */
+			};
+
+			fcc@11320 {
+				device_type = "network";
+				compatible = "fs_enet";
+				model = "FCC";
+				device-id = <2>;
+				reg = <11320 20 8500 100 113b0 30>;
+				mac-address = [ 00 11 2F 99 43 55 ];
+				interrupts = <21 2>;
+				interrupt-parent = <&cpm2_pic>;
+				phy-handle = <2452001>;
+				rx-clock = <15>; /* CPM_CLK13 = 0x15 */
+				tx-clock = <16>; /* CPM_CLK14 = 0x16 */
+			};
+
+			fcc@11340 {
+				device_type = "network";
+				compatible = "fs_enet";
+				model = "FCC";
+				device-id = <3>;
+				reg = <11340 20 8600 100 113e0 30>;
+				mac-address = [ 00 11 2F 99 43 56 ];
+				interrupts = <22 2>;
+				interrupt-parent = <&cpm2_pic>;
+				phy-handle = <2452002>;
+				rx-clock = <17>; /* CPM_CLK15 = 0x17 */
+				tx-clock = <18>; /* CPM_CLK16 = 0x18 */
+			};
+		};
+
+		mdio@0 {
+			device_type = "mdio";
+			compatible = "fs_enet";
+			reg = <0 0>;
+			linux,phandle = <24520>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			ethernet-phy@0 {
+				linux,phandle = <2452000>;
+				interrupt-parent = <&cpm2_pic>;
+				interrupts = <17 2>;
+				reg = <0>;
+				/* MDIO: PC9, MDC: PC10, delay 1 usec */
+				bitbang = [ 09 09 0a 02 02 01 ];
+				device_type = "ethernet-phy";
+			};
+
+			ethernet-phy@1 {
+				linux,phandle = <2452001>;
+				interrupt-parent = <&cpm2_pic>;
+				interrupts = <17 2>;
+				bitbang = [ 09 09 0a 02 02 01 ];
+				reg = <1>;
+				device_type = "ethernet-phy";
+			};
+
+			ethernet-phy@2 {
+				linux,phandle = <2452002>;
+				interrupt-parent = <&cpm2_pic>;
+				interrupts = <17 2>;
+				bitbang = [ 09 09 0a 02 02 01 ];
+				reg = <2>;
+				device_type = "ethernet-phy";
+			};
+		};
+
+		cpm2_pic: pic@10c00 {
+			linux,phandle = <10c00>;
+			interrupt-controller;
+			clock-frequency = <0>;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <10c00 80>;
+			built-in;
+			device_type = "cpm-pic";
+			compatible = "CPM2";
+		};
+	};
+};
Index: linux-powerpc-2.6.x/arch/powerpc/configs/sbcpq2_defconfig
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-powerpc-2.6.x/arch/powerpc/configs/sbcpq2_defconfig	2007-07-16 16:25:16.000000000 +0800
@@ -0,0 +1,917 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.22-rc3
+# Thu Jun  7 16:15:43 2007
+#
+# CONFIG_PPC64 is not set
+CONFIG_PPC32=y
+CONFIG_PPC_MERGE=y
+CONFIG_MMU=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_IRQ_PER_CPU=y
+CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_ARCH_HAS_ILOG2_U32=y
+CONFIG_GENERIC_HWEIGHT=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_GENERIC_FIND_NEXT_BIT=y
+CONFIG_PPC=y
+CONFIG_EARLY_PRINTK=y
+CONFIG_GENERIC_NVRAM=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
+CONFIG_ARCH_MAY_HAVE_PC_FDC=y
+CONFIG_PPC_OF=y
+# CONFIG_PPC_UDBG_16550 is not set
+# CONFIG_GENERIC_TBSYNC is not set
+CONFIG_AUDIT_ARCH=y
+CONFIG_GENERIC_BUG=y
+CONFIG_DEFAULT_UIMAGE=y
+
+#
+# Processor support
+#
+# CONFIG_CLASSIC32 is not set
+CONFIG_PPC_82xx=y
+# CONFIG_PPC_83xx is not set
+# CONFIG_PPC_85xx is not set
+# CONFIG_PPC_86xx is not set
+# CONFIG_PPC_8xx is not set
+# CONFIG_40x is not set
+# CONFIG_44x is not set
+# CONFIG_E200 is not set
+CONFIG_6xx=y
+CONFIG_PPC_FPU=y
+# CONFIG_PPC_DCR_NATIVE is not set
+# CONFIG_PPC_DCR_MMIO is not set
+CONFIG_PPC_STD_MMU=y
+CONFIG_PPC_STD_MMU_32=y
+# CONFIG_PPC_MM_SLICES is not set
+# CONFIG_SMP is not set
+CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
+
+#
+# Code maturity level options
+#
+CONFIG_EXPERIMENTAL=y
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_LOCK_KERNEL=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+
+#
+# General setup
+#
+CONFIG_LOCALVERSION=""
+CONFIG_LOCALVERSION_AUTO=y
+CONFIG_SWAP=y
+CONFIG_SYSVIPC=y
+# CONFIG_IPC_NS is not set
+CONFIG_SYSVIPC_SYSCTL=y
+# CONFIG_POSIX_MQUEUE is not set
+# CONFIG_BSD_PROCESS_ACCT is not set
+# CONFIG_TASKSTATS is not set
+# CONFIG_UTS_NS is not set
+# CONFIG_AUDIT is not set
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_SYSFS_DEPRECATED=y
+CONFIG_RELAY=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS_SOURCE=""
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SYSCTL=y
+CONFIG_EMBEDDED=y
+CONFIG_SYSCTL_SYSCALL=y
+CONFIG_KALLSYMS=y
+CONFIG_KALLSYMS_ALL=y
+CONFIG_KALLSYMS_EXTRA_PASS=y
+CONFIG_HOTPLUG=y
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_ELF_CORE=y
+CONFIG_BASE_FULL=y
+CONFIG_FUTEX=y
+CONFIG_ANON_INODES=y
+CONFIG_EPOLL=y
+CONFIG_SIGNALFD=y
+CONFIG_TIMERFD=y
+CONFIG_EVENTFD=y
+CONFIG_SHMEM=y
+CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_SLAB=y
+# CONFIG_SLUB is not set
+# CONFIG_SLOB is not set
+CONFIG_RT_MUTEXES=y
+# CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
+
+#
+# Loadable module support
+#
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+# CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
+CONFIG_KMOD=y
+
+#
+# Block layer
+#
+CONFIG_BLOCK=y
+CONFIG_LBD=y
+CONFIG_BLK_DEV_IO_TRACE=y
+CONFIG_LSF=y
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
+CONFIG_DEFAULT_AS=y
+# CONFIG_DEFAULT_DEADLINE is not set
+# CONFIG_DEFAULT_CFQ is not set
+# CONFIG_DEFAULT_NOOP is not set
+CONFIG_DEFAULT_IOSCHED="anticipatory"
+
+#
+# Platform support
+#
+# CONFIG_PPC_MPC52xx is not set
+# CONFIG_PPC_MPC5200 is not set
+# CONFIG_PPC_CELL is not set
+# CONFIG_PPC_CELL_NATIVE is not set
+# CONFIG_MPC82xx_ADS is not set
+CONFIG_SBCPQ2=y
+# CONFIG_PQ2ADS is not set
+CONFIG_8260=y
+# CONFIG_MPIC is not set
+# CONFIG_MPIC_WEIRD is not set
+# CONFIG_PPC_I8259 is not set
+# CONFIG_PPC_RTAS is not set
+# CONFIG_MMIO_NVRAM is not set
+# CONFIG_PPC_MPC106 is not set
+# CONFIG_PPC_970_NAP is not set
+# CONFIG_PPC_INDIRECT_IO is not set
+# CONFIG_GENERIC_IOMAP is not set
+# CONFIG_CPU_FREQ is not set
+CONFIG_CPM2=y
+
+#
+# Kernel options
+#
+# CONFIG_HIGHMEM is not set
+# CONFIG_HZ_100 is not set
+CONFIG_HZ_250=y
+# CONFIG_HZ_300 is not set
+# CONFIG_HZ_1000 is not set
+CONFIG_HZ=250
+# CONFIG_PREEMPT_NONE is not set
+# CONFIG_PREEMPT_VOLUNTARY is not set
+CONFIG_PREEMPT=y
+CONFIG_PREEMPT_BKL=y
+CONFIG_BINFMT_ELF=y
+CONFIG_BINFMT_MISC=y
+CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
+CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_ARCH_POPULATES_NODE_MAP=y
+CONFIG_SELECT_MEMORY_MODEL=y
+CONFIG_FLATMEM_MANUAL=y
+# CONFIG_DISCONTIGMEM_MANUAL is not set
+# CONFIG_SPARSEMEM_MANUAL is not set
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+# CONFIG_SPARSEMEM_STATIC is not set
+CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_RESOURCES_64BIT is not set
+CONFIG_ZONE_DMA_FLAG=1
+CONFIG_PROC_DEVICETREE=y
+# CONFIG_CMDLINE_BOOL is not set
+# CONFIG_PM is not set
+CONFIG_SECCOMP=y
+# CONFIG_WANT_DEVICE_TREE is not set
+CONFIG_ISA_DMA_API=y
+
+#
+# Bus options
+#
+CONFIG_ZONE_DMA=y
+CONFIG_FSL_SOC=y
+# CONFIG_PCI is not set
+# CONFIG_PCI_DOMAINS is not set
+# CONFIG_ARCH_SUPPORTS_MSI is not set
+
+#
+# PCCARD (PCMCIA/CardBus) support
+#
+# CONFIG_PCCARD is not set
+
+#
+# Advanced setup
+#
+# CONFIG_ADVANCED_OPTIONS is not set
+
+#
+# Default settings for advanced configuration options are used
+#
+CONFIG_HIGHMEM_START=0xfe000000
+CONFIG_LOWMEM_SIZE=0x30000000
+CONFIG_KERNEL_START=0xc0000000
+CONFIG_TASK_SIZE=0x80000000
+CONFIG_BOOT_LOAD=0x00400000
+
+#
+# Networking
+#
+CONFIG_NET=y
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+# CONFIG_PACKET_MMAP is not set
+CONFIG_UNIX=y
+CONFIG_XFRM=y
+# CONFIG_XFRM_USER is not set
+# CONFIG_XFRM_SUB_POLICY is not set
+# CONFIG_XFRM_MIGRATE is not set
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_FIB_HASH=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+# CONFIG_IP_PNP_RARP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_IP_MROUTE is not set
+# CONFIG_ARPD is not set
+CONFIG_SYN_COOKIES=y
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_XFRM_TUNNEL is not set
+# CONFIG_INET_TUNNEL is not set
+CONFIG_INET_XFRM_MODE_TRANSPORT=y
+CONFIG_INET_XFRM_MODE_TUNNEL=y
+CONFIG_INET_XFRM_MODE_BEET=y
+CONFIG_INET_DIAG=y
+CONFIG_INET_TCP_DIAG=y
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
+# CONFIG_IP_VS is not set
+# CONFIG_IPV6 is not set
+# CONFIG_INET6_XFRM_TUNNEL is not set
+# CONFIG_INET6_TUNNEL is not set
+# CONFIG_NETWORK_SECMARK is not set
+CONFIG_NETFILTER=y
+# CONFIG_NETFILTER_DEBUG is not set
+
+#
+# Core Netfilter Configuration
+#
+# CONFIG_NETFILTER_NETLINK is not set
+# CONFIG_NF_CONNTRACK_ENABLED is not set
+# CONFIG_NF_CONNTRACK is not set
+# CONFIG_NETFILTER_XTABLES is not set
+
+#
+# IP: Netfilter Configuration
+#
+# CONFIG_IP_NF_QUEUE is not set
+# CONFIG_IP_NF_IPTABLES is not set
+# CONFIG_IP_NF_ARPTABLES is not set
+# CONFIG_IP_DCCP is not set
+# CONFIG_IP_SCTP is not set
+# CONFIG_TIPC is not set
+# CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+
+#
+# QoS and/or fair queueing
+#
+# CONFIG_NET_SCHED is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+# CONFIG_AF_RXRPC is not set
+
+#
+# Wireless
+#
+# CONFIG_CFG80211 is not set
+# CONFIG_WIRELESS_EXT is not set
+# CONFIG_MAC80211 is not set
+# CONFIG_IEEE80211 is not set
+# CONFIG_RFKILL is not set
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+# CONFIG_FW_LOADER is not set
+# CONFIG_DEBUG_DRIVER is not set
+# CONFIG_DEBUG_DEVRES is not set
+# CONFIG_SYS_HYPERVISOR is not set
+
+#
+# Connector - unified userspace <-> kernelspace linker
+#
+# CONFIG_CONNECTOR is not set
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_CONCAT is not set
+CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_REDBOOT_PARTS is not set
+# CONFIG_MTD_CMDLINE_PARTS is not set
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLKDEVS=y
+CONFIG_MTD_BLOCK=y
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+# CONFIG_RFD_FTL is not set
+# CONFIG_SSFDC is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+CONFIG_MTD_CFI=y
+CONFIG_MTD_JEDECPROBE=y
+CONFIG_MTD_GEN_PROBE=y
+# CONFIG_MTD_CFI_ADV_OPTIONS is not set
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+CONFIG_MTD_CFI_I4=y
+# CONFIG_MTD_CFI_I8 is not set
+CONFIG_MTD_CFI_INTELEXT=y
+CONFIG_MTD_CFI_AMDSTD=y
+CONFIG_MTD_CFI_STAA=y
+CONFIG_MTD_CFI_UTIL=y
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+# CONFIG_MTD_PHYSMAP is not set
+# CONFIG_MTD_PHYSMAP_OF is not set
+# CONFIG_MTD_SBC8240 is not set
+CONFIG_MTD_WRSBC8260=y
+# CONFIG_MTD_PLATRAM is not set
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PHRAM is not set
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_MTD_BLOCK2MTD is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
+# CONFIG_MTD_DOC2000 is not set
+# CONFIG_MTD_DOC2001 is not set
+# CONFIG_MTD_DOC2001PLUS is not set
+# CONFIG_MTD_NAND is not set
+# CONFIG_MTD_ONENAND is not set
+
+#
+# UBI - Unsorted block images
+#
+# CONFIG_MTD_UBI is not set
+
+#
+# Parallel port support
+#
+# CONFIG_PARPORT is not set
+
+#
+# Plug and Play support
+#
+# CONFIG_PNPACPI is not set
+
+#
+# Block devices
+#
+# CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
+CONFIG_BLK_DEV_LOOP=y
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_BLK_DEV_RAM_SIZE=4096
+CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
+# CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
+
+#
+# Misc devices
+#
+# CONFIG_BLINK is not set
+# CONFIG_IDE is not set
+
+#
+# SCSI device support
+#
+# CONFIG_RAID_ATTRS is not set
+# CONFIG_SCSI is not set
+# CONFIG_SCSI_NETLINK is not set
+# CONFIG_ATA is not set
+
+#
+# Multi-device support (RAID and LVM)
+#
+# CONFIG_MD is not set
+CONFIG_MACINTOSH_DRIVERS=y
+# CONFIG_MAC_EMUMOUSEBTN is not set
+# CONFIG_WINDFARM is not set
+
+#
+# Network device support
+#
+CONFIG_NETDEVICES=y
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+CONFIG_PHYLIB=y
+
+#
+# MII PHY device drivers
+#
+# CONFIG_MARVELL_PHY is not set
+# CONFIG_DAVICOM_PHY is not set
+# CONFIG_QSEMI_PHY is not set
+# CONFIG_LXT_PHY is not set
+# CONFIG_CICADA_PHY is not set
+# CONFIG_VITESSE_PHY is not set
+# CONFIG_SMSC_PHY is not set
+# CONFIG_BROADCOM_PHY is not set
+# CONFIG_FIXED_PHY is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+CONFIG_FS_ENET=y
+# CONFIG_FS_ENET_HAS_SCC is not set
+CONFIG_FS_ENET_HAS_FCC=y
+CONFIG_NETDEV_1000=y
+CONFIG_NETDEV_10000=y
+
+#
+# Wireless LAN
+#
+# CONFIG_WLAN_PRE80211 is not set
+# CONFIG_WLAN_80211 is not set
+# CONFIG_WAN is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+
+#
+# ISDN subsystem
+#
+# CONFIG_ISDN is not set
+
+#
+# Telephony Support
+#
+# CONFIG_PHONE is not set
+
+#
+# Input device support
+#
+# CONFIG_INPUT is not set
+
+#
+# Hardware I/O ports
+#
+# CONFIG_SERIO is not set
+# CONFIG_GAMEPORT is not set
+
+#
+# Character devices
+#
+# CONFIG_VT is not set
+# CONFIG_SERIAL_NONSTANDARD is not set
+
+#
+# Serial drivers
+#
+# CONFIG_SERIAL_8250 is not set
+
+#
+# Non-8250 serial port support
+#
+# CONFIG_SERIAL_UARTLITE is not set
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_SERIAL_CPM=y
+CONFIG_SERIAL_CPM_CONSOLE=y
+# CONFIG_SERIAL_CPM_SCC1 is not set
+# CONFIG_SERIAL_CPM_SCC2 is not set
+# CONFIG_SERIAL_CPM_SCC3 is not set
+# CONFIG_SERIAL_CPM_SCC4 is not set
+CONFIG_SERIAL_CPM_SMC1=y
+CONFIG_SERIAL_CPM_SMC2=y
+CONFIG_UNIX98_PTYS=y
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
+
+#
+# IPMI
+#
+# CONFIG_IPMI_HANDLER is not set
+# CONFIG_WATCHDOG is not set
+CONFIG_HW_RANDOM=y
+CONFIG_NVRAM=y
+CONFIG_GEN_RTC=y
+# CONFIG_GEN_RTC_X is not set
+# CONFIG_R3964 is not set
+# CONFIG_RAW_DRIVER is not set
+
+#
+# TPM devices
+#
+# CONFIG_TCG_TPM is not set
+# CONFIG_I2C is not set
+
+#
+# SPI support
+#
+# CONFIG_SPI is not set
+# CONFIG_SPI_MASTER is not set
+
+#
+# Dallas's 1-wire bus
+#
+# CONFIG_W1 is not set
+# CONFIG_HWMON is not set
+
+#
+# Multifunction device drivers
+#
+# CONFIG_MFD_SM501 is not set
+
+#
+# Multimedia devices
+#
+# CONFIG_VIDEO_DEV is not set
+# CONFIG_DVB_CORE is not set
+CONFIG_DAB=y
+
+#
+# Graphics support
+#
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+
+#
+# Display device support
+#
+# CONFIG_DISPLAY_SUPPORT is not set
+# CONFIG_VGASTATE is not set
+# CONFIG_FB is not set
+# CONFIG_FB_IBM_GXT4500 is not set
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+
+#
+# USB support
+#
+# CONFIG_USB_ARCH_HAS_HCD is not set
+# CONFIG_USB_ARCH_HAS_OHCI is not set
+# CONFIG_USB_ARCH_HAS_EHCI is not set
+
+#
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
+#
+
+#
+# USB Gadget Support
+#
+CONFIG_USB_GADGET=y
+# CONFIG_USB_GADGET_DEBUG_FILES is not set
+# CONFIG_USB_GADGET_FSL_USB2 is not set
+# CONFIG_USB_GADGET_NET2280 is not set
+# CONFIG_USB_GADGET_PXA2XX is not set
+# CONFIG_USB_GADGET_GOKU is not set
+# CONFIG_USB_GADGET_LH7A40X is not set
+# CONFIG_USB_GADGET_OMAP is not set
+# CONFIG_USB_GADGET_AT91 is not set
+# CONFIG_USB_GADGET_DUMMY_HCD is not set
+# CONFIG_USB_GADGET_DUALSPEED is not set
+# CONFIG_MMC is not set
+
+#
+# LED devices
+#
+# CONFIG_NEW_LEDS is not set
+
+#
+# LED drivers
+#
+
+#
+# LED Triggers
+#
+
+#
+# InfiniBand support
+#
+
+#
+# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
+#
+
+#
+# Real Time Clock
+#
+CONFIG_RTC_LIB=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_HCTOSYS=y
+CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
+# CONFIG_RTC_DEBUG is not set
+
+#
+# RTC interfaces
+#
+CONFIG_RTC_INTF_SYSFS=y
+CONFIG_RTC_INTF_PROC=y
+CONFIG_RTC_INTF_DEV=y
+# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
+# CONFIG_RTC_DRV_TEST is not set
+
+#
+# I2C RTC drivers
+#
+
+#
+# SPI RTC drivers
+#
+
+#
+# Platform RTC drivers
+#
+# CONFIG_RTC_DRV_DS1553 is not set
+# CONFIG_RTC_DRV_DS1742 is not set
+# CONFIG_RTC_DRV_M48T86 is not set
+# CONFIG_RTC_DRV_V3020 is not set
+
+#
+# on-CPU RTC drivers
+#
+CONFIG_RTC_DRV_M48T59=y
+
+#
+# DMA Engine support
+#
+# CONFIG_DMA_ENGINE is not set
+
+#
+# DMA Clients
+#
+
+#
+# DMA Devices
+#
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=y
+# CONFIG_EXT2_FS_XATTR is not set
+# CONFIG_EXT2_FS_XIP is not set
+# CONFIG_EXT3_FS is not set
+# CONFIG_EXT4DEV_FS is not set
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+CONFIG_FS_POSIX_ACL=y
+# CONFIG_XFS_FS is not set
+# CONFIG_GFS2_FS is not set
+# CONFIG_OCFS2_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_ROMFS_FS is not set
+CONFIG_INOTIFY=y
+CONFIG_INOTIFY_USER=y
+# CONFIG_QUOTA is not set
+# CONFIG_DNOTIFY is not set
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
+# CONFIG_FUSE_FS is not set
+
+#
+# CD-ROM/DVD Filesystems
+#
+# CONFIG_ISO9660_FS is not set
+# CONFIG_UDF_FS is not set
+
+#
+# DOS/FAT/NT Filesystems
+#
+# CONFIG_MSDOS_FS is not set
+# CONFIG_VFAT_FS is not set
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_PROC_SYSCTL=y
+CONFIG_SYSFS=y
+CONFIG_TMPFS=y
+# CONFIG_TMPFS_POSIX_ACL is not set
+# CONFIG_HUGETLB_PAGE is not set
+CONFIG_RAMFS=y
+# CONFIG_CONFIGFS_FS is not set
+
+#
+# Miscellaneous filesystems
+#
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BFS_FS is not set
+# CONFIG_EFS_FS is not set
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=0
+CONFIG_JFFS2_FS_WRITEBUFFER=y
+CONFIG_JFFS2_SUMMARY=y
+CONFIG_JFFS2_FS_XATTR=y
+CONFIG_JFFS2_FS_POSIX_ACL=y
+CONFIG_JFFS2_FS_SECURITY=y
+CONFIG_JFFS2_COMPRESSION_OPTIONS=y
+CONFIG_JFFS2_ZLIB=y
+CONFIG_JFFS2_RTIME=y
+# CONFIG_JFFS2_RUBIN is not set
+# CONFIG_JFFS2_CMODE_NONE is not set
+CONFIG_JFFS2_CMODE_PRIORITY=y
+# CONFIG_JFFS2_CMODE_SIZE is not set
+# CONFIG_CRAMFS is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+
+#
+# Network File Systems
+#
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+CONFIG_NFS_V3_ACL=y
+# CONFIG_NFS_V4 is not set
+# CONFIG_NFS_DIRECTIO is not set
+# CONFIG_NFSD is not set
+CONFIG_ROOT_NFS=y
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_NFS_ACL_SUPPORT=y
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
+# CONFIG_SUNRPC_BIND34 is not set
+# CONFIG_RPCSEC_GSS_KRB5 is not set
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
+# CONFIG_SMB_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
+# CONFIG_9P_FS is not set
+
+#
+# Partition Types
+#
+# CONFIG_PARTITION_ADVANCED is not set
+CONFIG_MSDOS_PARTITION=y
+
+#
+# Native Language Support
+#
+# CONFIG_NLS is not set
+
+#
+# Distributed Lock Manager
+#
+# CONFIG_DLM is not set
+# CONFIG_UCC_SLOW is not set
+
+#
+# Library routines
+#
+CONFIG_BITREVERSE=y
+CONFIG_CRC_CCITT=y
+# CONFIG_CRC16 is not set
+# CONFIG_CRC_ITU_T is not set
+CONFIG_CRC32=y
+# CONFIG_LIBCRC32C is not set
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
+CONFIG_PLIST=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
+
+#
+# Instrumentation Support
+#
+# CONFIG_PROFILING is not set
+# CONFIG_KPROBES is not set
+
+#
+# Kernel hacking
+#
+# CONFIG_PRINTK_TIME is not set
+# CONFIG_ENABLE_MUST_CHECK is not set
+# CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_UNUSED_SYMBOLS is not set
+CONFIG_DEBUG_FS=y
+# CONFIG_HEADERS_CHECK is not set
+CONFIG_DEBUG_KERNEL=y
+# CONFIG_DEBUG_SHIRQ is not set
+# CONFIG_DETECT_SOFTLOCKUP is not set
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_TIMER_STATS is not set
+# CONFIG_DEBUG_SLAB is not set
+# CONFIG_DEBUG_RT_MUTEXES is not set
+# CONFIG_RT_MUTEX_TESTER is not set
+# CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_MUTEXES is not set
+# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
+# CONFIG_DEBUG_KOBJECT is not set
+# CONFIG_DEBUG_BUGVERBOSE is not set
+CONFIG_DEBUG_INFO=y
+# CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_LIST is not set
+# CONFIG_FORCED_INLINING is not set
+# CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_FAULT_INJECTION is not set
+# CONFIG_DEBUG_STACKOVERFLOW is not set
+# CONFIG_DEBUG_STACK_USAGE is not set
+# CONFIG_DEBUG_PAGEALLOC is not set
+# CONFIG_DEBUGGER is not set
+# CONFIG_KGDB_CONSOLE is not set
+# CONFIG_BDI_SWITCH is not set
+# CONFIG_BOOTX_TEXT is not set
+# CONFIG_PPC_EARLY_DEBUG is not set
+
+#
+# Security options
+#
+# CONFIG_KEYS is not set
+# CONFIG_SECURITY is not set
+
+#
+# Cryptographic options
+#
+# CONFIG_CRYPTO is not set
