Return-Path: <rongkai.zhan@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 87597DDFBC
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2007 19:08:35 +1000 (EST)
Subject: [PATCH 5/6]: 82xx: Add the support of Wind River SBC PowerQUICCII 82xx
From: Mark Zhan <rongkai.zhan@windriver.com>
To: "paulus@samba.org" <paulus@samba.org>
Content-Type: text/plain
Date: Fri, 08 Jun 2007 16:57:22 +0800
Message-Id: <1181293043.11341.19.camel@mark>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds the powerpc support to Wind River SBC PowerQUICCII 82xx
board.

Signed-off-by: Mark Zhan <rongkai.zhan@windriver.com>
---
 b/arch/powerpc/boot/dts/sbcpq2.dts     |  191 ++++++++++++++++++++
 b/arch/powerpc/platforms/82xx/Kconfig  |   10 +
 b/arch/powerpc/platforms/82xx/Makefile |    5 
 b/arch/powerpc/platforms/82xx/sbcpq2.c |  306
+++++++++++++++++++++++++++++++++
 b/arch/powerpc/platforms/82xx/sbcpq2.h |  118 ++++++++++++
 b/drivers/mtd/maps/Kconfig             |    2 
 b/include/asm-powerpc/mpc8260.h        |    4 
 7 files changed, 633 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/82xx/Kconfig
b/arch/powerpc/platforms/82xx/Kconfig
index de7fce9..74322f1 100644
--- a/arch/powerpc/platforms/82xx/Kconfig
+++ b/arch/powerpc/platforms/82xx/Kconfig
@@ -13,6 +13,16 @@ config MPC82xx_ADS
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
diff --git a/arch/powerpc/platforms/82xx/Makefile
b/arch/powerpc/platforms/82xx/Makefile
index d9fd4c8..d75181c 100644
--- a/arch/powerpc/platforms/82xx/Makefile
+++ b/arch/powerpc/platforms/82xx/Makefile
@@ -1,5 +1,6 @@
 #
 # Makefile for the PowerPC 82xx linux kernel.
 #
-obj-$(CONFIG_PPC_82xx) += mpc82xx.o
-obj-$(CONFIG_MPC82xx_ADS) += mpc82xx_ads.o
+obj-$(CONFIG_PPC_82xx)		+= mpc82xx.o
+obj-$(CONFIG_MPC82xx_ADS)	+= mpc82xx_ads.o
+obj-$(CONFIG_SBCPQ2)		+= sbcpq2.o
diff --git a/arch/powerpc/platforms/82xx/sbcpq2.c
b/arch/powerpc/platforms/82xx/sbcpq2.c
new file mode 100644
index 0000000..c459be4
--- /dev/null
+++ b/arch/powerpc/platforms/82xx/sbcpq2.c
@@ -0,0 +1,306 @@
+/*
+ * sbcpq2.c: The platform support for Wind River SBC PowerQUICCII 82xx
+ *
+ * Copyright 2007, Wind River Systems, Inc.
+ *
+ * Author: Mark Zhan <rongkai.zhan@windriver.com>
+ *
+ * This program is free software; you can redistribute  it and/or
modify it
+ * under  the terms of  the GNU General  Public License as published by
the
+ * Free Software Foundation;  either version 2 of the  License, or (at
your
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
+#include <asm/io.h>
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
diff --git a/arch/powerpc/platforms/82xx/sbcpq2.h
b/arch/powerpc/platforms/82xx/sbcpq2.h
new file mode 100644
index 0000000..77b7ca6
--- /dev/null
+++ b/arch/powerpc/platforms/82xx/sbcpq2.h
@@ -0,0 +1,118 @@
+/*
+ * sbcpq2.h: the header file for Wind River SBC PowerQUICCII 82xx
+ *
+ * Copyright (C) 2007, Wind River Systems, Inc.
+ * Mark Zhan, <rongkai.zhan@windriver.com>
+ *
+ * This program is free software; you can redistribute  it and/or
modify it
+ * under  the terms of  the GNU General  Public License as published by
the
+ * Free Software Foundation;  either version 2 of the  License, or (at
your
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
+ * Wind River SBC PowerQUICCII 82xx Physical Memory Map (CS0 for
OnBoard Flash)
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
+ * NOTE: i8259 PIC is cascaded to SIU_INT_IRQ6 of CPM2 interrupt
controller
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
diff --git a/arch/powerpc/boot/dts/sbcpq2.dts
b/arch/powerpc/boot/dts/sbcpq2.dts
new file mode 100644
index 0000000..cdcf780
--- /dev/null
+++ b/arch/powerpc/boot/dts/sbcpq2.dts
@@ -0,0 +1,191 @@
+/*
+ * Wind River SBC PowerQUICCII 82xx Device Tree Source
+ *
+ * Copyright 2007, Wind River Systems, Inc.
+ * Mark Zhan <rongkai.zhan@windriver.com>
+ *
+ * This program is free software; you can redistribute  it and/or
modify it
+ * under  the terms of  the GNU General  Public License as published by
the
+ * Free Software Foundation;  either version 2 of the  License, or (at
your
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
+				interrupt-parent = <10c00>;
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
+				interrupt-parent = <10c00>;
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
+				interrupt-parent = <10c00>;
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
+				interrupt-parent = <10c00>;
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
+				interrupt-parent = <10c00>;
+				phy-handle = <2452002>;
+				rx-clock = <17>; /* CPM_CLK15 = 0x17 */
+				tx-clock = <18>; /* CPM_CLK16 = 0x18 */
+			};
+				
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
+				interrupt-parent = <10c00>;
+				interrupts = <17 2>;
+				reg = <0>;
+				/* MDIO: PC9, MDC: PC10, delay 1 usec */
+				bitbang = [ 09 09 0a 02 02 01 ];
+				device_type = "ethernet-phy";
+			};
+
+			ethernet-phy@1 {
+				linux,phandle = <2452001>;
+				interrupt-parent = <10c00>;
+				interrupts = <17 2>;
+				bitbang = [ 09 09 0a 02 02 01 ];
+				reg = <1>;
+				device_type = "ethernet-phy";
+			};
+			
+			ethernet-phy@2 {
+				linux,phandle = <2452002>;
+				interrupt-parent = <10c00>;
+				interrupts = <17 2>;
+				bitbang = [ 09 09 0a 02 02 01 ];
+				reg = <2>;
+				device_type = "ethernet-phy";
+			};
+		};
+
+		interrupt-controller@10c00 {
+			linux,phandle = <10c00>;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			reg = <10c00 80>;
+			built-in;
+			device_type = "cpm-pic";
+			compatible = "CPM2";
+		};
+	};
+};
diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
index b665e4a..90feeeb 100644
--- a/drivers/mtd/maps/Kconfig
+++ b/drivers/mtd/maps/Kconfig
@@ -566,7 +566,7 @@ config MTD_UCLINUX
 
 config MTD_WRSBC8260
 	tristate "Map driver for WindRiver PowerQUICC II MPC82xx board"
-	depends on (SBC82xx || SBC8560)
+	depends on (SBC82xx || SBC8560 || SBCPQ2)
 	select MTD_PARTITIONS
 	select MTD_MAP_BANK_WIDTH_4
 	select MTD_MAP_BANK_WIDTH_1
diff --git a/include/asm-powerpc/mpc8260.h
b/include/asm-powerpc/mpc8260.h
index e058e9e..097ddf4 100644
--- a/include/asm-powerpc/mpc8260.h
+++ b/include/asm-powerpc/mpc8260.h
@@ -15,6 +15,10 @@ #if defined(CONFIG_PQ2ADS) || defined (C
 #include <platforms/82xx/pq2ads.h>
 #endif
 
+#ifdef CONFIG_SBCPQ2
+#include <platforms/82xx/sbcpq2.h>
+#endif
+
 #ifdef CONFIG_PCI_8260
 #include <platforms/82xx/m82xx_pci.h>
 #endif
