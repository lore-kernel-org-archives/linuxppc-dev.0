Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 23FB0DDE10
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 20:05:26 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l6DA5KQl003905
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 03:05:20 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l6DA5Jqf022787
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 05:05:19 -0500 (CDT)
Subject: [PATCH 1/2] Add basic PCI /PCI Express support for 8544DS board
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Message-Id: <1184321107.30789.42.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 13 Jul 2007 18:05:08 +0800
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

Add basic PCI/PCI Express support for 8544DS board.

Signed-off-by: York Sun <yorksun@freescale.com>
Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---
 arch/powerpc/platforms/85xx/Kconfig      |    1 +
 arch/powerpc/platforms/85xx/mpc8544_ds.c |  252 ++++++++++++++++++++++++++++++
 2 files changed, 253 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 526ddde..6729e12 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -30,6 +30,7 @@ config MPC85xx_MDS
 
 config MPC8544_DS
 	bool "Freescale MPC8544 DS"
+	select PPC_I8259
 	select DEFAULT_UIMAGE
 	help
 	  This option enables support for the MPC8544 DS board
diff --git a/arch/powerpc/platforms/85xx/mpc8544_ds.c b/arch/powerpc/platforms/85xx/mpc8544_ds.c
index 6fb90aa..e5ec8dd 100644
--- a/arch/powerpc/platforms/85xx/mpc8544_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc8544_ds.c
@@ -2,6 +2,8 @@
  * MPC8544 DS Board Setup
  *
  * Author Xianghua Xiao (x.xiao@freescale.com)
+ * Roy Zang <tie-fei.zang@freescale.com>
+ * 	- Add PCI/PCI Exprees support
  * Copyright 2007 Freescale Semiconductor Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
@@ -12,13 +14,16 @@
 
 #include <linux/stddef.h>
 #include <linux/kernel.h>
+#include <linux/pci.h>
 #include <linux/kdev_t.h>
 #include <linux/delay.h>
 #include <linux/seq_file.h>
+#include <linux/interrupt.h>
 
 #include <asm/system.h>
 #include <asm/time.h>
 #include <asm/machdep.h>
+#include <asm/pci-bridge.h>
 #include <asm/mpc85xx.h>
 #include <mm/mmu_decl.h>
 #include <asm/prom.h>
@@ -27,6 +32,7 @@
 #include <asm/i8259.h>
 
 #include <sysdev/fsl_soc.h>
+#include <sysdev/fsl_pci.h>
 #include "mpc85xx.h"
 
 #undef DEBUG
@@ -37,6 +43,17 @@
 #define DBG(fmt, args...)
 #endif
 
+#ifdef CONFIG_PPC_I8259
+static void mpc8544_8259_cascade(unsigned int irq, struct irq_desc *desc)
+{
+	unsigned int cascade_irq = i8259_irq();
+
+	if (cascade_irq != NO_IRQ) {
+		generic_handle_irq(cascade_irq);
+	}
+	desc->chip->eoi(irq);
+}
+#endif	/* CONFIG_PPC_I8259 */
 
 void __init mpc8544_ds_pic_init(void)
 {
@@ -96,18 +113,252 @@ void __init mpc8544_ds_pic_init(void)
 #endif	/* CONFIG_PPC_I8259 */
 }
 
+#ifdef CONFIG_PCI
+enum pirq { PIRQA = 8, PIRQB, PIRQC, PIRQD, PIRQE, PIRQF, PIRQG, PIRQH };
+
+/*
+ * Value in  table -- IRQ number
+ */
+const unsigned char uli1575_irq_route_table[16] = {
+	0,		/* 0: Reserved */
+	0x8,
+	0,		/* 2: Reserved */
+	0x2,
+	0x4,
+	0x5,
+	0x7,
+	0x6,
+	0,		/* 8: Reserved */
+	0x1,
+	0x3,
+	0x9,
+	0xb,
+	0,		/* 13: Reserved */
+	0xd,
+	0xf,
+};
+
+static int __devinit
+get_pci_irq_from_of(struct pci_controller *hose, int slot, int pin)
+{
+	struct of_irq oirq;
+	u32 laddr[3];
+	struct device_node *hosenode = hose ? hose->arch_data : NULL;
+
+	if (!hosenode)
+		return -EINVAL;
+
+	laddr[0] = (hose->first_busno << 16) | (PCI_DEVFN(slot, 0) << 8);
+	laddr[1] = laddr[2] = 0;
+	of_irq_map_raw(hosenode, &pin, 1, laddr, &oirq);
+	DBG("mpc8544_ds: pci irq addr %x, slot %d, pin %d, irq %d\n",
+	    laddr[0], slot, pin, oirq.specifier[0]);
+	return oirq.specifier[0];
+}
+
+/*8259*/
+static void __devinit quirk_uli1575(struct pci_dev *dev)
+{
+	unsigned short temp;
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+	unsigned char irq2pin[16];
+	unsigned long pirq_map_word = 0;
+	u32 irq;
+	int i;
+
+	/*
+	 * ULI1575 interrupts route setup
+	 */
+	memset(irq2pin, 0, 16);	/* Initialize default value 0 */
+
+	irq2pin[6]=PIRQA+3;	/* enabled mapping for IRQ6 to PIRQD, used by SATA */
+
+	/*
+	 * PIRQE -> PIRQF mapping set manually
+	 *
+	 * IRQ pin   IRQ#
+	 * PIRQE ---- 9
+	 * PIRQF ---- 10
+	 * PIRQG ---- 11
+	 * PIRQH ---- 12
+	 */
+	for (i = 0; i < 4; i++)
+		irq2pin[i + 9] = PIRQE + i;
+
+	/* Set IRQ-PIRQ Mapping to ULI1575 */
+	for (i = 0; i < 16; i++)
+		if (irq2pin[i])
+			pirq_map_word |= (uli1575_irq_route_table[i] & 0xf)
+			    << ((irq2pin[i] - PIRQA) * 4);
+
+	pirq_map_word |= 1<<26;	/* disable INTx in EP mode*/
+
+	/* ULI1575 IRQ mapping conf register default value is 0xb9317542 */
+	DBG("Setup ULI1575 IRQ mapping configuration register value = 0x%x\n",
+		(int)pirq_map_word);
+	pci_write_config_dword(dev, 0x48, pirq_map_word);
+
+#define ULI1575_SET_DEV_IRQ(slot, pin, reg)				\
+	do {								\
+		int irq;						\
+		irq = get_pci_irq_from_of(hose, slot, pin);		\
+		if (irq > 0 && irq < 16) 				\
+			pci_write_config_byte(dev, reg, irq2pin[irq]);	\
+		else							\
+			printk(KERN_WARNING "ULI1575 device"		\
+				"(slot %d, pin %d) irq %d is invalid.\n", \
+				slot, pin, irq);			\
+	} while(0)
+
+	/* USB 1.1 OHCI controller 1, slot 28, pin 1 */
+	ULI1575_SET_DEV_IRQ(28, 1, 0x86);
+
+	/* USB 1.1 OHCI controller 2, slot 28, pin 2 */
+	ULI1575_SET_DEV_IRQ(28, 2, 0x87);
+
+	/* USB 1.1 OHCI controller 3, slot 28, pin 3 */
+	ULI1575_SET_DEV_IRQ(28, 3, 0x88);
+
+	/* USB 2.0 controller, slot 28, pin 4 */
+	irq = get_pci_irq_from_of(hose, 28, 4);
+	if (irq >= 0 && irq <= 15)
+		pci_write_config_dword(dev, 0x74, uli1575_irq_route_table[irq]);
+
+	/* Audio controller, slot 29, pin 1 */
+	ULI1575_SET_DEV_IRQ(29, 1, 0x8a);
+
+	/* Modem controller, slot 29, pin 2 */
+	ULI1575_SET_DEV_IRQ(29, 2, 0x8b);
+
+	/* HD audio controller, slot 29, pin 3 */
+	ULI1575_SET_DEV_IRQ(29, 3, 0x8c);
+
+	/* SMB interrupt: slot 30, pin 1 */
+	ULI1575_SET_DEV_IRQ(30, 1, 0x8e);
+
+	/* PMU ACPI SCI interrupt: slot 30, pin 2 */
+	ULI1575_SET_DEV_IRQ(30, 2, 0x8f);
+
+	/* Serial ATA interrupt: slot 31, pin 1 */
+	ULI1575_SET_DEV_IRQ(31, 1, 0x8d);
+
+	/* Primary PATA IDE IRQ: 14
+	 * Secondary PATA IDE IRQ: 15
+	 */
+	pci_write_config_byte(dev, 0x44, 0x30 | uli1575_irq_route_table[14]);
+	pci_write_config_byte(dev, 0x75, uli1575_irq_route_table[15]);
+
+	/* Set IRQ14 and IRQ15 to legacy IRQs */
+	pci_read_config_word(dev, 0x46, &temp);
+	temp |= 0xc000;
+	pci_write_config_word(dev, 0x46, temp);
+
+	/* Set i8259 interrupt trigger
+	 * IRQ 3:  Level
+	 * IRQ 4:  Level
+	 * IRQ 5:  Level
+	 * IRQ 6:  Level
+	 * IRQ 7:  Level
+	 * IRQ 9:  Level
+	 * IRQ 10: Level
+	 * IRQ 11: Level
+	 * IRQ 12: Level
+	 * IRQ 14: Edge
+	 * IRQ 15: Edge
+	 */
+	outb(0xfa, 0x4d0);
+	outb(0x1e, 0x4d1);
+
+#undef ULI1575_SET_DEV_IRQ
+}
+
+/* SATA */
+static void __devinit quirk_uli5288(struct pci_dev *dev)
+{
+	unsigned char c;
+
+	pci_read_config_byte(dev, 0x83, &c);
+	c |= 0x80;		/* read/write lock */
+	pci_write_config_byte(dev, 0x83, c);
+
+	pci_write_config_byte(dev, 0x09, 0x01);	/* Base class code: storage */
+	pci_write_config_byte(dev, 0x0a, 0x06);	/* IDE disk */
+
+	pci_read_config_byte(dev, 0x83, &c);
+	c &= 0x7f;
+	pci_write_config_byte(dev, 0x83, c);
+
+	pci_read_config_byte(dev, 0x84, &c);
+	c |= 0x01;				/* emulated PATA mode enabled */
+	pci_write_config_byte(dev, 0x84, c);
+}
+
+/* PATA */
+static void __devinit quirk_uli5229(struct pci_dev *dev)
+{
+	unsigned short temp;
+	pci_write_config_word(dev, 0x04, 0x0405);	/* MEM IO MSI */
+	pci_read_config_word(dev, 0x4a, &temp);
+	temp |= 0x1000;				/* Enable Native IRQ 14/15 */
+	pci_write_config_word(dev, 0x4a, temp);
+}
+
+/*Bridge*/
+static void __devinit early_uli5249(struct pci_dev *dev)
+{
+	unsigned char temp;
+	pci_write_config_word(dev, 0x04, 0x0007);	/* mem access */
+	pci_read_config_byte(dev, 0x7c, &temp);
+	pci_write_config_byte(dev, 0x7c, 0x80);	/* R/W lock control */
+	pci_write_config_byte(dev, 0x09, 0x01);	/* set as pci-pci bridge */
+	pci_write_config_byte(dev, 0x7c, temp);	/* restore pci bus debug control */
+	dev->class |= 0x1;
+}
+
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x1575, quirk_uli1575);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5288, quirk_uli5288);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5229, quirk_uli5229);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AL, 0x5249, early_uli5249);
+#endif	/* CONFIG_PCI */
 
 /*
  * Setup the architecture
  */
 static void __init mpc8544_ds_setup_arch(void)
 {
+#ifdef CONFIG_PCI
+	struct device_node *np;
+#endif
+
 	if (ppc_md.progress)
 		ppc_md.progress("mpc8544_ds_setup_arch()", 0);
 
+#ifdef CONFIG_PCI
+	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;) {
+		struct resource rsrc;
+		of_address_to_resource(np, 0, &rsrc);
+		if ((rsrc.start & 0xfffff) == 0x9000)
+			fsl_add_bridge(np, 0);
+		else
+			fsl_add_bridge(np, 1);
+	}
+#endif
+
 	printk("MPC8544 DS board from Freescale Semiconductor\n");
 }
 
+void __init mpc8544_ds_pcibios_fixup_bus(struct pci_bus *bus)
+{
+	if (bus->self && bus->self->vendor == 0x10b9
+		&& bus->self->device == 0x5249) {
+		bus->parent->resource[0]->end = bus->parent->resource[0]->start
+			+ 0xffff;
+		if (bus->resource[1] && bus->parent->resource[1])
+			bus->parent->resource[1]->end +=
+				bus->resource[1]->end + 1 + 0x100000
+				- bus->resource[1]->start;
+	}
+}
 
 /*
  * Called very early, device-tree isn't unflattened
@@ -124,6 +375,7 @@ define_machine(mpc8544_ds) {
 	.probe			= mpc8544_ds_probe,
 	.setup_arch		= mpc8544_ds_setup_arch,
 	.init_IRQ		= mpc8544_ds_pic_init,
+	.pcibios_fixup_bus	= mpc8544_ds_pcibios_fixup_bus,
 	.get_irq		= mpic_get_irq,
 	.restart		= mpc85xx_restart,
 	.calibrate_decr		= generic_calibrate_decr,
-- 
1.5.1
