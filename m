Return-Path: <jotken@softadvances.com>
Received: from smtpauth07.mail.atl.earthlink.net
	(smtpauth07.mail.atl.earthlink.net [209.86.89.67])
	by ozlabs.org (Postfix) with ESMTP id E5D7968916
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Jan 2006 11:58:52 +1100 (EST)
Message-ID: <43CC3CD6.2080505@softadvances.com>
Date: Mon, 16 Jan 2006 18:39:50 -0600
From: John Otken <jotken@softadvances.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: [Patch 1/3] Support AMCC Yosemite 440EP and Yellowstone 440GR (v3)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This updated patch adds support for AMCC 440EP Yosemite
and 440GR Yellowstone evaluation boards.

I tested it against the 2.6.15 kernel on both boards using
gcc 4.0.0 (ELDK 4.0).

The Yosemite platform files are based on Wade Farnsworth's
Bamboo code.  There is only a single board name macro that
depends on CONFIG_YOSEMITE vs CONFIG_YELLOWSTONE so I
didn't create an otherwise identical yellowstone.c/h.

The defconfig files are in parts 2 and 3.

This patch supersedes "Patch: [PATCH 1/3] Support AMCC
Yosemite 440EP and Yellowstone 440GR (v2)" from 9-03:
http://patchwork.ozlabs.org/linuxppc/patch?id=2240

This patch has Stefan Roese's YOSEMITE_PCI_IO_BASE bug fix.

440EP USB support requires Wade Farnsworth's patches:

Sep19  W Farnsworth  Add support for the AMCC 440EP to the
                      PowerPC OHCI USB host driver
Sep19  W Farnsworth  Add support for the USB Device interfaces
                      on the AMCC 440EP
Sep20  W Farnsworth  Add support for USB to 440EP platform files
http://patchwork.ozlabs.org/linuxppc//patch?id=2481

Comments are welcome.

Signed-off-by: John Otken <jotken@softadvances.com>



diff -uprN a/arch/ppc/platforms/4xx/Kconfig c/arch/ppc/platforms/4xx/Kconfig
--- a/arch/ppc/platforms/4xx/Kconfig	2006-01-02 21:21:10.000000000 -0600
+++ c/arch/ppc/platforms/4xx/Kconfig	2006-01-16 11:23:57.679417517 -0600
@@ -94,6 +94,18 @@ config OCOTEA
  	help
  	  This option enables support for the IBM PPC440GX evaluation board.

+config YELLOWSTONE
+	bool "Yellowstone"
+	select WANT_EARLY_SERIAL
+	help
+	  This option enables support for the AMCC PPC440GR evaluation board.
+
+config YOSEMITE
+	bool "Yosemite"
+	select WANT_EARLY_SERIAL
+	help
+	  This option enables support for the AMCC PPC440EP evaluation board.
+
  endchoice

  config EP405PC
@@ -111,7 +123,7 @@ config NP405H

  config 440EP
  	bool
-	depends on BAMBOO
+	depends on BAMBOO || YOSEMITE
  	select PPC_FPU
  	default y

@@ -120,6 +132,11 @@ config 440GP
  	depends on EBONY
  	default y

+config 440GR
+	bool
+	depends on YELLOWSTONE
+	default y
+
  config 440GX
  	bool
  	depends on OCOTEA
@@ -137,7 +154,7 @@ config 440SPE

  config 440
  	bool
-	depends on 440GP || 440SP || 440SPE || 440EP
+	depends on 440GP || 440SP || 440SPE || 440EP || 440GR
  	default y

  config 440A
@@ -147,7 +164,7 @@ config 440A

  config IBM440EP_ERR42
  	bool
-	depends on 440EP
+	depends on 440EP || 440GR
  	default y

  # All 405-based cores up until the 405GPR and 405EP have this errata.
@@ -169,7 +186,7 @@ config BOOKE

  config IBM_OCP
  	bool
-	depends on ASH || BAMBOO || BUBINGA || CPCI405 || EBONY || EP405 || LUAN || YUCCA || OCOTEA || REDWOOD_5 || REDWOOD_6 || SYCAMORE || WALNUT
+	depends on ASH || BAMBOO || BUBINGA || CPCI405 || EBONY || EP405 || LUAN || YUCCA || OCOTEA || REDWOOD_5 || REDWOOD_6 || SYCAMORE || WALNUT || YELLOWSTONE || YOSEMITE
  	default y

  config XILINX_OCP
diff -uprN a/arch/ppc/platforms/4xx/Makefile c/arch/ppc/platforms/4xx/Makefile
--- a/arch/ppc/platforms/4xx/Makefile	2006-01-02 21:21:10.000000000 -0600
+++ c/arch/ppc/platforms/4xx/Makefile	2006-01-13 10:09:21.000000000 -0600
@@ -14,12 +14,15 @@ obj-$(CONFIG_REDWOOD_6)		+= redwood6.o
  obj-$(CONFIG_SYCAMORE)		+= sycamore.o
  obj-$(CONFIG_WALNUT)		+= walnut.o
  obj-$(CONFIG_XILINX_ML300)	+= xilinx_ml300.o
+obj-$(CONFIG_YELLOWSTONE)	+= yosemite.o
+obj-$(CONFIG_YOSEMITE)		+= yosemite.o

  obj-$(CONFIG_405GP)		+= ibm405gp.o
  obj-$(CONFIG_REDWOOD_5)		+= ibmstb4.o
  obj-$(CONFIG_NP405H)		+= ibmnp405h.o
  obj-$(CONFIG_REDWOOD_6)		+= ibmstbx25.o
  obj-$(CONFIG_440EP)		+= ibm440ep.o
+obj-$(CONFIG_440GR)		+= ibm440ep.o
  obj-$(CONFIG_440GP)		+= ibm440gp.o
  obj-$(CONFIG_440GX)		+= ibm440gx.o
  obj-$(CONFIG_440SP)		+= ibm440sp.o
diff -uprN a/arch/ppc/platforms/4xx/yosemite.c c/arch/ppc/platforms/4xx/yosemite.c
--- a/arch/ppc/platforms/4xx/yosemite.c	1969-12-31 17:00:00.000000000 -0700
+++ c/arch/ppc/platforms/4xx/yosemite.c	2006-01-15 12:17:15.000000000 -0600
@@ -0,0 +1,351 @@
+/*
+ * arch/ppc/platforms/4xx/yosemite.c
+ *
+ * Yosemite and Yellowstone board specific routines
+ *
+ * Wade Farnsworth <wfarnsworth@mvista.com>
+ * Copyright 2004 MontaVista Software Inc.
+ *
+ * John Otken <jotken@softadvances.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+#include <linux/delay.h>
+#include <linux/initrd.h>
+#include <linux/irq.h>
+#include <linux/root_dev.h>
+#include <linux/tty.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+
+#include <asm/machdep.h>
+#include <asm/ocp.h>
+#include <asm/bootinfo.h>
+#include <asm/ppcboot.h>
+
+#include <syslib/ibm440gx_common.h>
+
+/*
+ * The AMCC Yosemite and Yellowstones boards share the same PC board.
+ * The Yosemite has a 440EP and USB support.  The Yellowstone has a
+ * 440GR and no USB hardware.  The 440EP and 440GR have the same PVR.
+ */
+#ifdef CONFIG_YELLOWSTONE
+#define BOARDNAME  "440GR Yellowstone"
+#else
+#define BOARDNAME  "440EP Yosemite"
+#endif
+
+
+extern bd_t __res;
+
+static struct ibm44x_clocks clocks __initdata;
+
+
+/*
+ * Yosemite external IRQ triggering/polarity settings
+ */
+unsigned char ppc4xx_uic_ext_irq_cfg[] __initdata = {
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), /* IRQ0: ETH0 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), /* IRQ1: ETH1 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), /* IRQ2: PCI_INTA */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), /* IRQ3: STTM_ALERT */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), /* IRQ4: GPIO44 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), /* IRQ5: GND */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), /* IRQ6: GPIO45 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), /* IRQ7: GPIO46 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), /* IRQ8: GPIO47 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), /* IRQ9: GPIO48 */
+};
+
+
+static void __init
+yosemite_calibrate_decr(void)
+{
+	unsigned int freq;
+
+	if (mfspr(SPRN_CCR1) & CCR1_TCS)
+		freq = YOSEMITE_TMRCLK;
+	else
+		freq = clocks.cpu;
+
+	ibm44x_calibrate_decr(freq);
+}
+
+static int
+yosemite_show_cpuinfo(struct seq_file *m)
+{
+	seq_printf(m, "vendor\t\t: AMCC\n");
+	seq_printf(m, "machine\t\t: PPC" BOARDNAME "\n");
+
+	return 0;
+}
+
+static inline int
+yosemite_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
+{
+	static char pci_irq_table[][4] =
+	/*
+	 *	PCI IDSEL/INTPIN->INTLINE
+	 * 	   A   B   C   D
+	 */
+	{
+		{ 25, 25, 25, 25 },	/* IDSEL 1 - PCI Slot 0 */
+	};
+
+	const long min_idsel = 12, max_idsel = 12, irqs_per_slot = 4;
+	return PCI_IRQ_TABLE_LOOKUP;
+}
+
+static void __init yosemite_set_emacdata(void)
+{
+	struct ocp_def *def;
+	struct ocp_func_emac_data *emacdata;
+
+	/* Set mac_addr and phy mode for each EMAC */
+
+	def = ocp_get_one_device(OCP_VENDOR_IBM, OCP_FUNC_EMAC, 0);
+	emacdata = def->additions;
+	memcpy(emacdata->mac_addr, __res.bi_enetaddr, 6);
+	emacdata->phy_mode = PHY_MODE_RMII;
+
+	def = ocp_get_one_device(OCP_VENDOR_IBM, OCP_FUNC_EMAC, 1);
+	emacdata = def->additions;
+	memcpy(emacdata->mac_addr, __res.bi_enet1addr, 6);
+	emacdata->phy_mode = PHY_MODE_RMII;
+}
+
+static int
+yosemite_exclude_device(unsigned char bus, unsigned char devfn)
+{
+	return (bus == 0 && devfn == 0);
+}
+
+#define PCI_READW(offset) \
+        (readw((void *)((u32)pci_reg_base+offset)))
+
+#define PCI_WRITEW(value, offset) \
+	(writew(value, (void *)((u32)pci_reg_base+offset)))
+
+#define PCI_WRITEL(value, offset) \
+	(writel(value, (void *)((u32)pci_reg_base+offset)))
+
+static void __init
+yosemite_setup_pci(void)
+{
+	void *pci_reg_base;
+	unsigned long memory_size;
+	memory_size = ppc_md.find_end_of_memory();
+
+	pci_reg_base = ioremap64(YOSEMITE_PCIL0_BASE, YOSEMITE_PCIL0_SIZE);
+
+	/* Enable PCI I/O, Mem, and Busmaster cycles */
+	PCI_WRITEW(PCI_READW(PCI_COMMAND) |
+		   PCI_COMMAND_MEMORY |
+		   PCI_COMMAND_MASTER, PCI_COMMAND);
+
+	/* Disable region first */
+	PCI_WRITEL(0, YOSEMITE_PCIL0_PMM0MA);
+
+	/* PLB starting addr: 0x00000000A0000000 */
+	PCI_WRITEL(YOSEMITE_PCI_PHY_MEM_BASE, YOSEMITE_PCIL0_PMM0LA);
+
+	/* PCI start addr, 0xA0000000 (PCI Address) */
+	PCI_WRITEL(YOSEMITE_PCI_MEM_BASE, YOSEMITE_PCIL0_PMM0PCILA);
+	PCI_WRITEL(0, YOSEMITE_PCIL0_PMM0PCIHA);
+
+	/* Enable no pre-fetch, enable region */
+	PCI_WRITEL(((0xffffffff -
+		     (YOSEMITE_PCI_UPPER_MEM - YOSEMITE_PCI_MEM_BASE)) | 0x01),
+		      YOSEMITE_PCIL0_PMM0MA);
+
+	/* Disable region one */
+	PCI_WRITEL(0, YOSEMITE_PCIL0_PMM1MA);
+	PCI_WRITEL(0, YOSEMITE_PCIL0_PMM1LA);
+	PCI_WRITEL(0, YOSEMITE_PCIL0_PMM1PCILA);
+	PCI_WRITEL(0, YOSEMITE_PCIL0_PMM1PCIHA);
+	PCI_WRITEL(0, YOSEMITE_PCIL0_PMM1MA);
+
+	/* Disable region two */
+	PCI_WRITEL(0, YOSEMITE_PCIL0_PMM2MA);
+	PCI_WRITEL(0, YOSEMITE_PCIL0_PMM2LA);
+	PCI_WRITEL(0, YOSEMITE_PCIL0_PMM2PCILA);
+	PCI_WRITEL(0, YOSEMITE_PCIL0_PMM2PCIHA);
+	PCI_WRITEL(0, YOSEMITE_PCIL0_PMM2MA);
+
+	/* Now configure the PCI->PLB windows, we only use PTM1
+	 *
+	 * For Inbound flow, set the window size to all available memory
+	 * This is required because if size is smaller,
+	 * then Eth/PCI DD would fail as PCI card not able to access
+	 * the memory allocated by DD.
+	 */
+
+	PCI_WRITEL(0, YOSEMITE_PCIL0_PTM1MS);	/* disabled region 1 */
+	PCI_WRITEL(0, YOSEMITE_PCIL0_PTM1LA);	/* begin of address map */
+
+	memory_size = 1 << fls(memory_size - 1);
+
+	/* Size low + Enabled */
+	PCI_WRITEL((0xffffffff - (memory_size - 1)) | 0x1, YOSEMITE_PCIL0_PTM1MS);
+
+	eieio();
+	iounmap(pci_reg_base);
+}
+
+static void __init
+yosemite_setup_hose(void)
+{
+	unsigned int bar_response, bar;
+	struct pci_controller *hose;
+
+	yosemite_setup_pci();
+
+	hose = pcibios_alloc_controller();
+
+	if (!hose)
+		return;
+
+	hose->first_busno = 0;
+	hose->last_busno = 0xff;
+
+	hose->pci_mem_offset = YOSEMITE_PCI_MEM_OFFSET;
+
+	pci_init_resource(&hose->io_resource,
+			  YOSEMITE_PCI_LOWER_IO,
+			  YOSEMITE_PCI_UPPER_IO,
+			  IORESOURCE_IO,
+			  "PCI host bridge");
+
+	pci_init_resource(&hose->mem_resources[0],
+			  YOSEMITE_PCI_LOWER_MEM,
+			  YOSEMITE_PCI_UPPER_MEM,
+			  IORESOURCE_MEM,
+			  "PCI host bridge");
+
+	ppc_md.pci_exclude_device = yosemite_exclude_device;
+
+	hose->io_space.start = YOSEMITE_PCI_LOWER_IO;
+	hose->io_space.end = YOSEMITE_PCI_UPPER_IO;
+	hose->mem_space.start = YOSEMITE_PCI_LOWER_MEM;
+	hose->mem_space.end = YOSEMITE_PCI_UPPER_MEM;
+	isa_io_base =
+		(unsigned long)ioremap64(YOSEMITE_PCI_IO_BASE, YOSEMITE_PCI_IO_SIZE);
+	hose->io_base_virt = (void *)isa_io_base;
+
+	setup_indirect_pci(hose,
+			   YOSEMITE_PCI_CFGA_PLB32,
+			   YOSEMITE_PCI_CFGD_PLB32);
+	hose->set_cfg_type = 1;
+
+	/* Zero config bars */
+	for (bar = PCI_BASE_ADDRESS_1; bar <= PCI_BASE_ADDRESS_2; bar += 4) {
+		early_write_config_dword(hose, hose->first_busno,
+					 PCI_FUNC(hose->first_busno), bar,
+					 0x00000000);
+		early_read_config_dword(hose, hose->first_busno,
+					PCI_FUNC(hose->first_busno), bar,
+					&bar_response);
+	}
+
+	hose->last_busno = pciauto_bus_scan(hose, hose->first_busno);
+
+	ppc_md.pci_swizzle = common_swizzle;
+	ppc_md.pci_map_irq = yosemite_map_irq;
+}
+
+static void __init
+yosemite_early_serial_map(void)
+{
+	struct uart_port port;
+
+	/* Setup ioremapped serial port access */
+	memset(&port, 0, sizeof(port));
+	port.membase = ioremap64(PPC440EP_UART0_ADDR, 8);
+	port.irq = 0;
+	port.uartclk = clocks.uart0;
+	port.regshift = 0;
+	port.iotype = SERIAL_IO_MEM;
+	port.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
+	port.line = 0;
+
+	if (early_serial_setup(&port) != 0) {
+		printk("Early serial init of port 0 failed\n");
+	}
+
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+	/* Configure debug serial access */
+	gen550_init(0, &port);
+#endif
+
+	port.membase = ioremap64(PPC440EP_UART1_ADDR, 8);
+	port.irq = 1;
+	port.uartclk = clocks.uart1;
+	port.line = 1;
+
+	if (early_serial_setup(&port) != 0) {
+		printk("Early serial init of port 1 failed\n");
+	}
+
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+	/* Configure debug serial access */
+	gen550_init(1, &port);
+#endif
+}
+
+static void __init
+yosemite_setup_arch(void)
+{
+	yosemite_set_emacdata();
+
+	ibm440gx_get_clocks(&clocks, YOSEMITE_SYSCLK, 6 * 1843200);
+	ocp_sys_info.opb_bus_freq = clocks.opb;
+
+	/* init to some ~sane value until calibrate_delay() runs */
+        loops_per_jiffy = 50000000/HZ;
+
+	/* Setup PCI host bridge */
+	yosemite_setup_hose();
+
+#ifdef CONFIG_BLK_DEV_INITRD
+	if (initrd_start)
+		ROOT_DEV = Root_RAM0;
+	else
+#endif
+#ifdef CONFIG_ROOT_NFS
+		ROOT_DEV = Root_NFS;
+#else
+		ROOT_DEV = Root_HDA1;
+#endif
+
+	yosemite_early_serial_map();
+
+	/* Identify the system */
+	printk( "AMCC PowerPC " BOARDNAME " Platform\n" );
+}
+
+void __init platform_init(unsigned long r3, unsigned long r4,
+			  unsigned long r5, unsigned long r6, unsigned long r7)
+{
+	ibm44x_platform_init(r3, r4, r5, r6, r7);
+
+	ppc_md.setup_arch = yosemite_setup_arch;
+	ppc_md.show_cpuinfo = yosemite_show_cpuinfo;
+	ppc_md.get_irq = NULL;		/* Set in ppc4xx_pic_init() */
+
+	ppc_md.calibrate_decr = yosemite_calibrate_decr;
+
+#ifdef CONFIG_KGDB
+	ppc_md.early_serial_map = yosemite_early_serial_map;
+#endif
+}
diff -uprN a/arch/ppc/platforms/4xx/yosemite.h c/arch/ppc/platforms/4xx/yosemite.h
--- a/arch/ppc/platforms/4xx/yosemite.h	1969-12-31 17:00:00.000000000 -0700
+++ c/arch/ppc/platforms/4xx/yosemite.h	2006-01-15 07:38:56.000000000 -0600
@@ -0,0 +1,86 @@
+/*
+ * arch/ppc/platforms/4xx/yosemite.h
+ *
+ * Yosemite and Yellowstone board definitions
+ *
+ * Wade Farnsworth <wfarnsworth@mvista.com>
+ * Copyright 2004 MontaVista Software Inc.
+ *
+ * John Otken <jotken@softadvances.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifdef __KERNEL__
+#ifndef __ASM_YOSEMITE_H__
+#define __ASM_YOSEMITE_H__
+
+#include <linux/config.h>
+#include <platforms/4xx/ibm440ep.h>
+
+/* Default clock rate */
+#define YOSEMITE_TMRCLK			50000000
+#define YOSEMITE_SYSCLK			66666666
+
+/*
+ * Serial port defines
+ */
+#define RS_TABLE_SIZE			2
+
+#define UART0_IO_BASE			0xEF600300
+#define UART1_IO_BASE			0xEF600400
+
+#define BASE_BAUD			33177600/3/16
+#define UART0_INT			0
+#define UART1_INT			1
+
+#define STD_UART_OP(num)					\
+	{ 0, BASE_BAUD, 0, UART##num##_INT,			\
+		(ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST),	\
+		iomem_base: UART##num##_IO_BASE,		\
+		io_type: SERIAL_IO_MEM},
+
+#define SERIAL_PORT_DFNS	\
+	STD_UART_OP(0)		\
+	STD_UART_OP(1)
+
+/* PCI support */
+#define YOSEMITE_PCI_CFGA_PLB32		0xeec00000
+#define YOSEMITE_PCI_CFGD_PLB32		0xeec00004
+
+#define YOSEMITE_PCI_IO_BASE		0x00000000e8000000ULL
+#define YOSEMITE_PCI_IO_SIZE		0x00010000
+#define YOSEMITE_PCI_MEM_OFFSET		0x00000000
+#define YOSEMITE_PCI_PHY_MEM_BASE	0x00000000a0000000ULL
+
+#define YOSEMITE_PCI_LOWER_IO		0x00000000
+#define YOSEMITE_PCI_UPPER_IO		0x0000ffff
+#define YOSEMITE_PCI_LOWER_MEM		0xa0000000
+#define YOSEMITE_PCI_UPPER_MEM		0xafffffff
+#define YOSEMITE_PCI_MEM_BASE		0xa0000000
+
+#define YOSEMITE_PCIL0_BASE		0x00000000ef400000ULL
+#define YOSEMITE_PCIL0_SIZE		0x40
+
+#define YOSEMITE_PCIL0_PMM0LA		0x000
+#define YOSEMITE_PCIL0_PMM0MA		0x004
+#define YOSEMITE_PCIL0_PMM0PCILA	0x008
+#define YOSEMITE_PCIL0_PMM0PCIHA	0x00C
+#define YOSEMITE_PCIL0_PMM1LA		0x010
+#define YOSEMITE_PCIL0_PMM1MA		0x014
+#define YOSEMITE_PCIL0_PMM1PCILA	0x018
+#define YOSEMITE_PCIL0_PMM1PCIHA	0x01C
+#define YOSEMITE_PCIL0_PMM2LA		0x020
+#define YOSEMITE_PCIL0_PMM2MA		0x024
+#define YOSEMITE_PCIL0_PMM2PCILA	0x028
+#define YOSEMITE_PCIL0_PMM2PCIHA	0x02C
+#define YOSEMITE_PCIL0_PTM1MS		0x030
+#define YOSEMITE_PCIL0_PTM1LA		0x034
+#define YOSEMITE_PCIL0_PTM2MS		0x038
+#define YOSEMITE_PCIL0_PTM2LA		0x03C
+
+#endif                          /* __ASM_YOSEMITE_H__ */
+#endif                          /* __KERNEL__ */
diff -uprN a/arch/ppc/syslib/ibm440gx_common.c c/arch/ppc/syslib/ibm440gx_common.c
--- a/arch/ppc/syslib/ibm440gx_common.c	2006-01-02 21:21:10.000000000 -0600
+++ c/arch/ppc/syslib/ibm440gx_common.c	2006-01-13 10:09:21.000000000 -0600
@@ -34,7 +34,7 @@ void __init ibm440gx_get_clocks(struct i
  	u32 plld  = CPR_READ(DCRN_CPR_PLLD);
  	u32 uart0 = SDR_READ(DCRN_SDR_UART0);
  	u32 uart1 = SDR_READ(DCRN_SDR_UART1);
-#ifdef CONFIG_440EP
+#if defined(CONFIG_440EP) || defined(CONFIG_440GR)
  	u32 uart2 = SDR_READ(DCRN_SDR_UART2);
  	u32 uart3 = SDR_READ(DCRN_SDR_UART3);
  #endif
@@ -100,7 +100,7 @@ bypass:
  		p->uart1 = ser_clk;
  	else
  		p->uart1 = p->plb / __fix_zero(uart1 & 0xff, 256);
-#ifdef CONFIG_440EP
+#if defined(CONFIG_440EP) || defined(CONFIG_440GR)
  	if (uart2 & 0x00800000)
  		p->uart2 = ser_clk;
  	else
diff -uprN a/arch/ppc/syslib/ibm44x_common.h c/arch/ppc/syslib/ibm44x_common.h
--- a/arch/ppc/syslib/ibm44x_common.h	2006-01-02 21:21:10.000000000 -0600
+++ c/arch/ppc/syslib/ibm44x_common.h	2006-01-13 10:09:21.000000000 -0600
@@ -29,7 +29,7 @@ struct ibm44x_clocks {
  	unsigned int ebc;	/* PerClk */
  	unsigned int uart0;
  	unsigned int uart1;
-#ifdef CONFIG_440EP
+#if defined(CONFIG_440EP) || defined(CONFIG_440GR)
  	unsigned int uart2;
  	unsigned int uart3;
  #endif
diff -uprN a/arch/ppc/syslib/Makefile c/arch/ppc/syslib/Makefile
--- a/arch/ppc/syslib/Makefile	2006-01-02 21:21:10.000000000 -0600
+++ c/arch/ppc/syslib/Makefile	2006-01-13 10:09:21.000000000 -0600
@@ -12,6 +12,7 @@ obj-$(CONFIG_PPC_OCP)		+= ocp.o
  obj-$(CONFIG_IBM_OCP)		+= ibm_ocp.o
  obj-$(CONFIG_44x)		+= ibm44x_common.o
  obj-$(CONFIG_440EP)		+= ibm440gx_common.o
+obj-$(CONFIG_440GR)		+= ibm440gx_common.o
  obj-$(CONFIG_440GP)		+= ibm440gp_common.o
  obj-$(CONFIG_440GX)		+= ibm440gx_common.o
  obj-$(CONFIG_440SP)		+= ibm440gx_common.o ibm440sp_common.o
@@ -74,6 +75,8 @@ obj-$(CONFIG_SANDPOINT)		+= pci_auto.o t
  obj-$(CONFIG_SBC82xx)		+= todc_time.o
  obj-$(CONFIG_SPRUCE)		+= cpc700_pic.o pci_auto.o \
  				   todc_time.o
+obj-$(CONFIG_YELLOWSTONE)	+= pci_auto.o
+obj-$(CONFIG_YOSEMITE)		+= pci_auto.o
  obj-$(CONFIG_8260)		+= m8260_setup.o pq2_devices.o pq2_sys.o \
  				   ppc_sys.o
  obj-$(CONFIG_PCI_8260)		+= m82xx_pci.o pci_auto.o
diff -uprN a/include/asm-ppc/ibm44x.h c/include/asm-ppc/ibm44x.h
--- a/include/asm-ppc/ibm44x.h	2006-01-02 21:21:10.000000000 -0600
+++ c/include/asm-ppc/ibm44x.h	2006-01-13 10:09:21.000000000 -0600
@@ -44,7 +44,7 @@
  #elif defined(CONFIG_440SPE)
  #define UART0_PHYS_ERPN		4
  #define UART0_PHYS_IO_BASE	0xf0000200
-#elif defined(CONFIG_440EP)
+#elif defined(CONFIG_440EP) || defined(CONFIG_440GR)
  #define UART0_PHYS_IO_BASE	0xe0000000
  #else
  #define UART0_PHYS_ERPN		1
@@ -69,7 +69,7 @@
  #define	PPC44x_PCICFG_PAGE	0x0000000c00000000ULL
  #define	PPC44x_PCIIO_PAGE	PPC44x_PCICFG_PAGE
  #define	PPC44x_PCIMEM_PAGE	0x0000000d00000000ULL
-#elif defined(CONFIG_440EP)
+#elif defined(CONFIG_440EP) || defined(CONFIG_440GR)
  #define PPC44x_IO_PAGE		0x0000000000000000ULL
  #define PPC44x_PCICFG_PAGE	0x0000000000000000ULL
  #define PPC44x_PCIIO_PAGE	PPC44x_PCICFG_PAGE
@@ -95,7 +95,7 @@
  #define PPC44x_PCI2CFG_HI	0x2ec00007UL
  #define PPC44x_PCIMEM_LO	0x80000000UL
  #define PPC44x_PCIMEM_HI	0xdfffffffUL
-#elif defined(CONFIG_440EP)
+#elif defined(CONFIG_440EP) || defined(CONFIG_440GR)
  #define PPC44x_IO_LO		0xef500000UL
  #define PPC44x_IO_HI		0xefffffffUL
  #define PPC44x_PCI0CFG_LO	0xeec00000UL
@@ -179,7 +179,7 @@
  #define DCRN_SDR_UART0		0x0120
  #define DCRN_SDR_UART1		0x0121

-#ifdef CONFIG_440EP
+#if defined(CONFIG_440EP) || defined(CONFIG_440GR)
  #define DCRN_SDR_UART2		0x0122
  #define DCRN_SDR_UART3		0x0123
  #define DCRN_SDR_CUST0		0x4000
@@ -202,7 +202,7 @@
  #define DCRNCAP_DMA_SG		1	/* have DMA scatter/gather capability */
  #define DCRN_MAL_BASE		0x180

-#ifdef CONFIG_440EP
+#if defined(CONFIG_440EP) || defined(CONFIG_440GR)
  #define DCRN_DMA2P40_BASE	0x300
  #define DCRN_DMA2P41_BASE	0x308
  #define DCRN_DMA2P42_BASE	0x310
diff -uprN a/include/asm-ppc/ibm4xx.h c/include/asm-ppc/ibm4xx.h
--- a/include/asm-ppc/ibm4xx.h	2006-01-02 21:21:10.000000000 -0600
+++ c/include/asm-ppc/ibm4xx.h	2006-01-13 10:09:21.000000000 -0600
@@ -105,6 +105,10 @@ void ppc4xx_init(unsigned long r3, unsig
  #include <platforms/4xx/ocotea.h>
  #endif

+#if defined(CONFIG_YELLOWSTONE) || defined(CONFIG_YOSEMITE)
+#include <platforms/4xx/yosemite.h>
+#endif
+
  #ifndef __ASSEMBLY__
  #ifdef CONFIG_40x
  /*
