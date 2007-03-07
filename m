Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id C25D2DE150
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Mar 2007 08:14:23 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l27LEJum022206
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Mar 2007 14:14:19 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l27LEIaZ001469
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Mar 2007 15:14:18 -0600 (CST)
Subject: [RFC 1/3] MPC8544DS Basic Port
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1173302058.23776.183.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Wed, 07 Mar 2007 15:14:18 -0600
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 arch/powerpc/platforms/85xx/Kconfig      |   18 +
 arch/powerpc/platforms/85xx/Makefile     |    1
 arch/powerpc/platforms/85xx/mpc8544_ds.c |  424 ++++++++++++++++++++++++++++++
 3 files changed, 442 insertions(+), 1 deletions(-)



diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index eb661cc..5221664 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -20,6 +20,8 @@ config MPC8560_ADS
 config MPC85xx_CDS
 	bool "Freescale MPC85xx CDS"
 	select DEFAULT_UIMAGE
+	select FSL_PCIE
+	select PPC_I8259
 	help
 	  This option enables support for the MPC85xx CDS board
 
@@ -30,6 +32,14 @@ config MPC85xx_MDS
 	help
 	  This option enables support for the MPC85xx MDS board
 
+config MPC8544_DS
+	bool "Freescale MPC8544/MPC8533 DS"
+	select PPC_I8259
+	select DEFAULT_UIMAGE
+	select FSL_PCIE
+	help
+	  This option enables support for the MPC8544/MPC8533 DS board
+
 endchoice
 
 config MPC8540
@@ -43,11 +53,17 @@ config MPC8560
 	select PPC_INDIRECT_PCI
 	default y if MPC8560_ADS
 
+config MPC8544
+	bool
+	select SERIAL_8250_SHARE_IRQ
+	default y if MPC8544_DS
+
 config MPC85xx
 	bool
 	select PPC_UDBG_16550
 	select PPC_INDIRECT_PCI
-	default y if MPC8540_ADS || MPC85xx_CDS || MPC8560_ADS || MPC85xx_MDS
+	default y if MPC8540_ADS || MPC85xx_CDS || MPC8560_ADS \
+		|| MPC85xx_MDS || MPC8544_DS
 
 config PPC_INDIRECT_PCI_BE
 	bool
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index 4e63917..4e02cbb 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -5,4 +5,5 @@ obj-$(CONFIG_PPC_85xx)	+= misc.o pci.o
 obj-$(CONFIG_MPC8540_ADS) += mpc85xx_ads.o
 obj-$(CONFIG_MPC8560_ADS) += mpc85xx_ads.o
 obj-$(CONFIG_MPC85xx_CDS) += mpc85xx_cds.o
+obj-$(CONFIG_MPC8544_DS)  += mpc8544_ds.o
 obj-$(CONFIG_MPC85xx_MDS) += mpc85xx_mds.o
diff --git a/arch/powerpc/platforms/85xx/mpc8544_ds.c b/arch/powerpc/platforms/85xx/mpc8544_ds.c
new file mode 100644
index 0000000..035a762
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/mpc8544_ds.c
@@ -0,0 +1,424 @@
+/*
+ * MPC8544 DS Board Setup
+ *
+ * Author Xianghua Xiao (x.xiao@freescale.com)
+ * Copyright 2007 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/kdev_t.h>
+#include <linux/delay.h>
+#include <linux/seq_file.h>
+
+#include <asm/system.h>
+#include <asm/time.h>
+#include <asm/machdep.h>
+#include <asm/pci-bridge.h>
+#include <asm/mpc85xx.h>
+#include <mm/mmu_decl.h>
+#include <asm/prom.h>
+#include <asm/udbg.h>
+#include <asm/mpic.h>
+#include <asm/i8259.h>
+
+#include <sysdev/fsl_soc.h>
+#include "mpc85xx.h"
+
+#undef DEBUG
+
+#ifdef DEBUG
+#define DBG(fmt, args...) printk(KERN_ERR "%s: " fmt, __FUNCTION__, ## args)
+#else
+#define DBG(fmt, args...)
+#endif
+
+#ifndef CONFIG_PCI
+unsigned long isa_io_base = 0;
+unsigned long isa_mem_base = 0;
+unsigned long pci_dram_offset = 0;
+#endif
+
+#ifdef CONFIG_PCI
+int mpc85xx_exclude_device(u_char bus, u_char devfn)
+{
+	if (bus == 2 && PCI_SLOT(devfn) == 0x1d)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	else
+		return PCIBIOS_SUCCESSFUL;
+}
+
+static void mpc8544_8259_cascade(unsigned int irq, struct irq_desc *desc)
+{
+	unsigned int cascade_irq = i8259_irq();
+	if (cascade_irq != NO_IRQ)
+		generic_handle_irq(cascade_irq);
+	desc->chip->eoi(irq);
+}
+#endif				/* CONFIG_PCI */
+
+void __init mpc8544_ds_pic_init(void)
+{
+	struct mpic *mpic;
+	struct resource r;
+	struct device_node *np = NULL;
+#ifdef CONFIG_PPC_I8259
+	struct device_node *cascade_node = NULL;
+	int cascade_irq;
+#endif
+
+	np = of_find_node_by_type(np, "open-pic");
+
+	if (np == NULL) {
+		printk(KERN_ERR "Could not find open-pic node\n");
+		return;
+	}
+
+	if (of_address_to_resource(np, 0, &r)) {
+		printk(KERN_ERR "Failed to map mpic register space\n");
+		of_node_put(np);
+		return;
+	}
+
+	/* Alloc mpic structure and per isu has 16 INT entries. */
+	mpic = mpic_alloc(np, r.start,
+			  MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
+			  16, NR_IRQS - 10, " OPENPIC     ");
+	BUG_ON(mpic == NULL);
+
+	/* Return the mpic node */
+
+	mpic_assign_isu(mpic, 0, r.start + 0x10000);
+
+	/* 48 Internal Interrupts */
+	mpic_assign_isu(mpic, 1, r.start + 0x10200);
+	mpic_assign_isu(mpic, 2, r.start + 0x10400);
+	mpic_assign_isu(mpic, 3, r.start + 0x10600);
+
+	/* 16 External interrupts
+	 * Moving them from [0 - 15] to [64 - 79]
+	 */
+	mpic_assign_isu(mpic, 4, r.start + 0x10000);
+
+	mpic_init(mpic);
+
+#ifdef CONFIG_PPC_I8259
+	/* Initialize the i8259 controller */
+	for_each_node_by_type(np, "interrupt-controller")
+	    if (device_is_compatible(np, "chrp,iic")) {
+		cascade_node = np;
+		break;
+	}
+
+	if (cascade_node == NULL) {
+		printk(KERN_DEBUG "Could not find i8259 PIC\n");
+		return;
+	}
+
+	cascade_irq = irq_of_parse_and_map(cascade_node, 0);
+	if (cascade_irq == NO_IRQ) {
+		printk(KERN_ERR "Failed to map cascade interrupt\n");
+		return;
+	}
+
+	DBG("mpc8544ds: cascade mapped to irq %d\n", cascade_irq);
+
+	i8259_init(cascade_node, 0);
+	of_node_put(cascade_node);
+
+	set_irq_chained_handler(cascade_irq, mpc8544_8259_cascade);
+#endif	/* CONFIG_PPC_I8259 */
+}
+
+#ifdef CONFIG_PCI
+enum pirq { PIRQA = 8, PIRQB, PIRQC, PIRQD, PIRQE, PIRQF, PIRQG, PIRQH };
+const unsigned char uli1575_irq_route_table[16] = {
+/* Value in  table -- IRQ number */
+	0,			/* 0: Reserved */
+	0x8,			/* 1: 0b1000 */
+	0,			/* 2: Reserved */
+	0x2,			/* 3: 0b0010 */
+	0x4,			/* 4: 0b0100 */
+	0x5,			/* 5: 0b0101 */
+	0x7,			/* 6: 0b0111 */
+	0x6,			/* 7: 0b0110 */
+	0,			/* 8: Reserved */
+	0x1,			/* 9: 0b0001 */
+	0x3,			/* 10: 0b0011 */
+	0x9,			/* 11: 0b1001 */
+	0xb,			/* 12: 0b1011 */
+	0,			/* 13: Reserved */
+	0xd,			/* 14, 0b1101 */
+	0xf,			/* 15, 0b1111 */
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
+	/* ULI1575 IRQ mapping conf register default value is 0xb9317542 */
+	DBG("Setup ULI1575 IRQ mapping configuration register value = 0x%x\n",
+	    pirq_map_word);
+	pci_write_config_dword(dev, 0x48, pirq_map_word);
+
+#define ULI1575_SET_DEV_IRQ(slot, pin, reg)                             \
+	do {                                                            \
+		int irq;                                                \
+		irq = get_pci_irq_from_of(hose, slot, pin);             \
+		if (irq > 0 && irq < 16) {                              \
+			pci_write_config_byte(dev, reg, irq2pin[irq]);  \
+		}							\
+		else                                                    \
+			printk(KERN_WARNING "ULI1575 device"            \
+				"(slot %d, pin %d) irq %d is invalid.\n",   \
+				slot, pin, irq);                            \
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
+	pci_write_config_byte(dev, 0x09, 0x8a);
+	dev->class &= ~0x5;
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
+
+/*
+ * Setup the architecture
+ */
+static void __init mpc8544_ds_setup_arch(void)
+{
+#ifdef CONFIG_PCI
+	struct device_node *np;
+#endif
+
+	if (ppc_md.progress)
+		ppc_md.progress("mpc8544_ds_setup_arch()", 0);
+
+#ifdef CONFIG_PCI
+	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
+		add_bridge(np);
+	ppc_md.pci_exclude_device = mpc85xx_exclude_device;
+#endif
+
+	printk("MPC8544 DS board from Freescale Semiconductor\n");
+}
+
+void __init mpc8544_ds_pcibios_fixup_bus(struct pci_bus *bus)
+{
+	if (bus->self && bus->self->vendor == 0x10b9
+	    && bus->self->device == 0x5249) {
+		bus->parent->resource[0]->end = bus->parent->resource[0]->start
+		    + 0xffff;
+		if (bus->resource[1] && bus->parent->resource[1])
+			bus->parent->resource[1]->end +=
+			    bus->resource[1]->end + 1 + 0x100000
+			    - bus->resource[1]->start;
+	}
+}
+
+void mpc8544_ds_show_cpuinfo(struct seq_file *m)
+{
+	struct device_node *root;
+	uint memsize = total_memory;
+	const char *model = "";
+	uint svid = mfspr(SPRN_SVR);
+
+	seq_printf(m, "Vendor\t\t: Freescale Semiconductor\n");
+
+	root = of_find_node_by_path("/");
+	if (root)
+		model = get_property(root, "model", NULL);
+	seq_printf(m, "Machine\t\t: %s\n", model);
+	of_node_put(root);
+
+	seq_printf(m, "SVR\t\t: 0x%x\n", svid);
+	seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024));
+}
+
+/*
+ * Called very early, device-tree isn't unflattened
+ */
+static int __init mpc8544_ds_probe(void)
+{
+	char *model = of_get_flat_dt_prop(of_get_flat_dt_root(),
+					  "model", NULL);
+	if (model == NULL)
+		return 0;
+	if (strcmp(model, "MPC8544DS"))
+		return 0;
+
+	DBG("MPC8544DS found\n");
+
+	return 1;
+}
+
+define_machine(mpc8544_ds) {
+	.name			= "MPC8544 DS",
+	.probe			= mpc8544_ds_probe,
+	.setup_arch		= mpc8544_ds_setup_arch,
+	.init_IRQ		= mpc8544_ds_pic_init,
+	.show_cpuinfo		= mpc8544_ds_show_cpuinfo,
+	.pcibios_fixup_bus	= mpc8544_ds_pcibios_fixup_bus,
+	.get_irq		= mpic_get_irq,
+	.restart		= mpc85xx_restart,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+};
