Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [66.118.10.122])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5D43567B9E
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Jun 2006 08:52:54 +1000 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.44)
	id 1Frjeq-0004P5-Hn
	for linuxppc-dev@ozlabs.org; Sat, 17 Jun 2006 17:52:51 -0500
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 6/9 v3] Add mpc8641hpcn PCI/PCI-Express platform files.
Date: Sat, 17 Jun 2006 17:52:48 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1Frjeq-0004P5-Hn@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Xianghua Xiao <x.xiao@freescale.com>
Signed-off-by: Wei Zhang <Wei.Zhang@freescale.com>
Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
Signed-off-by: Jon Loeliger <jdl@freescale.com>

---

 arch/powerpc/platforms/86xx/mpc86xx_pcie.c |  173 +++++++++++++++
 arch/powerpc/platforms/86xx/pci.c          |  325 ++++++++++++++++++++++++++++
 2 files changed, 498 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/mpc86xx_pcie.c b/arch/powerpc/platforms/86xx/mpc86xx_pcie.c
new file mode 100644
index 0000000..a2f4f73
--- /dev/null
+++ b/arch/powerpc/platforms/86xx/mpc86xx_pcie.c
@@ -0,0 +1,173 @@
+/*
+ * Support for indirect PCI bridges.
+ *
+ * Copyright (C) 1998 Gabriel Paubert.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * "Temporary" MPC8548 Errata file -
+ * The standard indirect_pci code should work with future silicon versions.
+ */
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/string.h>
+#include <linux/init.h>
+#include <linux/bootmem.h>
+
+#include <asm/io.h>
+#include <asm/prom.h>
+#include <asm/pci-bridge.h>
+#include <asm/machdep.h>
+
+#include "mpc86xx.h"
+
+#define PCI_CFG_OUT out_be32
+
+/* ERRATA PCI-Ex 14 PCIE Controller timeout */
+#define PCIE_FIX		out_be32(hose->cfg_addr+0x4, 0x0400ffff)
+
+
+static int
+indirect_read_config_pcie(struct pci_bus *bus, unsigned int devfn, int offset,
+		     int len, u32 *val)
+{
+	struct pci_controller *hose = bus->sysdata;
+	volatile void __iomem *cfg_data;
+	u32 temp;
+
+	if (ppc_md.pci_exclude_device)
+		if (ppc_md.pci_exclude_device(bus->number, devfn))
+			return PCIBIOS_DEVICE_NOT_FOUND;
+
+	/* Possible artifact of CDCpp50937 needs further investigation */
+	if (devfn != 0x0 && bus->number == 0xff)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	PCIE_FIX;
+	if (bus->number == 0xff) {
+		PCI_CFG_OUT(hose->cfg_addr,
+			    (0x80000000 | ((offset & 0xf00) << 16) |
+			     ((bus->number - hose->bus_offset) << 16)
+			     | (devfn << 8) | ((offset & 0xfc) )));
+	} else {
+		PCI_CFG_OUT(hose->cfg_addr,
+			    (0x80000001 | ((offset & 0xf00) << 16) |
+			     ((bus->number - hose->bus_offset) << 16)
+			     | (devfn << 8) | ((offset & 0xfc) )));
+	}
+
+	/*
+	 * Note: the caller has already checked that offset is
+	 * suitably aligned and that len is 1, 2 or 4.
+	 */
+	/* ERRATA PCI-Ex 12 - Configuration Address/Data Alignment */
+	cfg_data = hose->cfg_data;
+	PCIE_FIX;
+	temp = in_le32(cfg_data);
+	switch (len) {
+	case 1:
+		*val = (temp >> (((offset & 3))*8)) & 0xff;
+		break;
+	case 2:
+		*val = (temp >> (((offset & 3))*8)) & 0xffff;
+		break;
+	default:
+		*val = temp;
+		break;
+	}
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int
+indirect_write_config_pcie(struct pci_bus *bus, unsigned int devfn, int offset,
+		      int len, u32 val)
+{
+	struct pci_controller *hose = bus->sysdata;
+	volatile void __iomem *cfg_data;
+	u32 temp;
+
+	if (ppc_md.pci_exclude_device)
+		if (ppc_md.pci_exclude_device(bus->number, devfn))
+			return PCIBIOS_DEVICE_NOT_FOUND;
+
+	/* Possible artifact of CDCpp50937 needs further investigation */
+	if (devfn != 0x0 && bus->number == 0xff)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	PCIE_FIX;
+	if (bus->number == 0xff) {
+		PCI_CFG_OUT(hose->cfg_addr,
+			    (0x80000000 | ((offset & 0xf00) << 16) |
+			     ((bus->number - hose->bus_offset) << 16)
+			     | (devfn << 8) | ((offset & 0xfc) )));
+	} else {
+		PCI_CFG_OUT(hose->cfg_addr,
+			    (0x80000001 | ((offset & 0xf00) << 16) |
+			     ((bus->number - hose->bus_offset) << 16)
+			     | (devfn << 8) | ((offset & 0xfc) )));
+        }
+
+	/*
+	 * Note: the caller has already checked that offset is
+	 * suitably aligned and that len is 1, 2 or 4.
+	 */
+	/* ERRATA PCI-Ex 12 - Configuration Address/Data Alignment */
+	cfg_data = hose->cfg_data;
+	switch (len) {
+	case 1:
+		PCIE_FIX;
+		temp = in_le32(cfg_data);
+		temp = (temp & ~(0xff << ((offset & 3) * 8))) |
+			(val << ((offset & 3) * 8));
+		PCIE_FIX;
+		out_le32(cfg_data, temp);
+		break;
+	case 2:
+		PCIE_FIX;
+		temp = in_le32(cfg_data);
+		temp = (temp & ~(0xffff << ((offset & 3) * 8)));
+		temp |= (val << ((offset & 3) * 8)) ;
+		PCIE_FIX;
+		out_le32(cfg_data, temp);
+		break;
+	default:
+		PCIE_FIX;
+		out_le32(cfg_data, val);
+		break;
+	}
+	PCIE_FIX;
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static struct pci_ops indirect_pcie_ops = {
+	indirect_read_config_pcie,
+	indirect_write_config_pcie
+};
+
+void __init
+setup_indirect_pcie_nomap(struct pci_controller* hose, void __iomem * cfg_addr,
+	void __iomem * cfg_data)
+{
+	hose->cfg_addr = cfg_addr;
+	hose->cfg_data = cfg_data;
+	hose->ops = &indirect_pcie_ops;
+}
+
+void __init
+setup_indirect_pcie(struct pci_controller* hose, u32 cfg_addr, u32 cfg_data)
+{
+	unsigned long base = cfg_addr & PAGE_MASK;
+	void __iomem *mbase, *addr, *data;
+
+	mbase = ioremap(base, PAGE_SIZE);
+	addr = mbase + (cfg_addr & ~PAGE_MASK);
+	if ((cfg_data & PAGE_MASK) != base)
+		mbase = ioremap(cfg_data & PAGE_MASK, PAGE_SIZE);
+	data = mbase + (cfg_data & ~PAGE_MASK);
+	setup_indirect_pcie_nomap(hose, addr, data);
+}
diff --git a/arch/powerpc/platforms/86xx/pci.c b/arch/powerpc/platforms/86xx/pci.c
new file mode 100644
index 0000000..5180df7
--- /dev/null
+++ b/arch/powerpc/platforms/86xx/pci.c
@@ -0,0 +1,325 @@
+/*
+ * MPC86XX pci setup code
+ *
+ * Recode: ZHANG WEI <wei.zhang@freescale.com>
+ * Initial author: Xianghua Xiao <x.xiao@freescale.com>
+ *
+ * Copyright 2006 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/serial.h>
+
+#include <asm/system.h>
+#include <asm/atomic.h>
+#include <asm/io.h>
+#include <asm/prom.h>
+#include <asm/immap_86xx.h>
+#include <asm/pci-bridge.h>
+#include <sysdev/fsl_soc.h>
+
+#include "mpc86xx.h"
+
+#undef DEBUG
+
+#ifdef DEBUG
+#define DBG(fmt, args...) printk(KERN_ERR "%s: " fmt, __FUNCTION__, ## args)
+#else
+#define DBG(fmt, args...)
+#endif
+
+struct pcie_outbound_window_regs {
+	uint    pexotar;               /* 0x.0 - PCI Express outbound translation address register */
+	uint    pexotear;              /* 0x.4 - PCI Express outbound translation extended address register */
+	uint    pexowbar;              /* 0x.8 - PCI Express outbound window base address register */
+	char    res1[4];
+	uint    pexowar;               /* 0x.10 - PCI Express outbound window attributes register */
+	char    res2[12];
+};
+
+struct pcie_inbound_window_regs {
+	uint    pexitar;               /* 0x.0 - PCI Express inbound translation address register */
+	char    res1[4];
+	uint    pexiwbar;              /* 0x.8 - PCI Express inbound window base address register */
+	uint    pexiwbear;             /* 0x.c - PCI Express inbound window base extended address register */
+	uint    pexiwar;               /* 0x.10 - PCI Express inbound window attributes register */
+	char    res2[12];
+};
+
+static void __init setup_pcie_atmu(struct pci_controller *hose, struct resource *rsrc)
+{
+	volatile struct ccsr_pex *pcie;
+	volatile struct pcie_outbound_window_regs *pcieow;
+	volatile struct pcie_inbound_window_regs *pcieiw;
+	int i = 0;
+
+	DBG("PCIE memory map start 0x%x, size 0x%x\n", rsrc->start,
+			rsrc->end - rsrc->start + 1);
+	pcie = ioremap(rsrc->start, rsrc->end - rsrc->start + 1);
+
+	/* Disable all windows (except pexowar0 since its ignored) */
+	pcie->pexowar1 = 0;
+	pcie->pexowar2 = 0;
+ 	pcie->pexowar3 = 0;
+ 	pcie->pexowar4 = 0;
+ 	pcie->pexiwar1 = 0;
+ 	pcie->pexiwar2 = 0;
+ 	pcie->pexiwar3 = 0;
+
+ 	pcieow = (struct pcie_outbound_window_regs *)&pcie->pexotar1;
+ 	pcieiw = (struct pcie_inbound_window_regs *)&pcie->pexitar1;
+
+ 	/* Setup outbound MEM window */
+ 	for(i = 0; i < 3; i++)
+ 		if (hose->mem_resources[i].flags & IORESOURCE_MEM){
+ 			DBG("PCIE MEM resource start 0x%08x, size 0x%08x.\n",
+ 				hose->mem_resources[i].start,
+ 				hose->mem_resources[i].end
+ 				  - hose->mem_resources[i].start + 1);
+ 			pcieow->pexotar = (hose->mem_resources[i].start) >> 12
+ 				& 0x000fffff;
+ 			pcieow->pexotear = 0;
+ 			pcieow->pexowbar = (hose->mem_resources[i].start) >> 12
+ 				& 0x000fffff;
+ 			/* Enable, Mem R/W */
+ 			pcieow->pexowar = 0x80044000 |
+ 				(__ilog2(hose->mem_resources[i].end
+ 					 - hose->mem_resources[i].start + 1)
+ 				 - 1);
+ 			pcieow++;
+ 		}
+
+ 	/* Setup outbound IO window */
+ 	if (hose->io_resource.flags & IORESOURCE_IO){
+ 		DBG("PCIE IO resource start 0x%08x, size 0x%08x, phy base 0x%08x.\n",
+ 			hose->io_resource.start,
+ 			hose->io_resource.end - hose->io_resource.start + 1,
+ 			hose->io_base_phys);
+ 		pcieow->pexotar = (hose->io_resource.start) >> 12 & 0x000fffff;
+ 		pcieow->pexotear = 0;
+ 		pcieow->pexowbar = (hose->io_base_phys) >> 12 & 0x000fffff;
+ 		/* Enable, IO R/W */
+ 		pcieow->pexowar = 0x80088000 | (__ilog2(hose->io_resource.end
+ 					- hose->io_resource.start + 1) - 1);
+ 	}
+
+ 	/* Setup 2G inbound Memory Window @ 0 */
+ 	pcieiw->pexitar = 0x00000000;
+ 	pcieiw->pexiwbar = 0x00000000;
+ 	/* Enable, Prefetch, Local Mem, Snoop R/W, 2G */
+ 	pcieiw->pexiwar = 0xa0f5501e;
+}
+
+static void __init
+mpc86xx_setup_pcie(struct pci_controller *hose, u32 pcie_offset, u32 pcie_size)
+{
+	volatile struct ccsr_pex *pcie;
+	u16 cmd;
+	unsigned int temps;
+
+	DBG("PCIE host controller register offset 0x%08x, size 0x%08x.\n",
+			pcie_offset, pcie_size);
+
+	pcie = ioremap(pcie_offset, pcie_size);
+
+	early_read_config_word(hose, 0, 0, PCI_COMMAND, &cmd);
+	cmd |= PCI_COMMAND_SERR | PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY
+	    | PCI_COMMAND_IO;
+	early_write_config_word(hose, 0, 0, PCI_COMMAND, cmd);
+
+	early_write_config_byte(hose, 0, 0, PCI_LATENCY_TIMER, 0x80);
+
+	/* PCIE Bus, Fix the MPC8641D host bridge's location to bus 0xFF. */
+	early_read_config_dword(hose, 0, 0, PCI_PRIMARY_BUS, &temps);
+	temps = (temps & 0xff000000) | (0xff) | (0x0 << 8) | (0xfe << 16);
+	early_write_config_dword(hose, 0, 0, PCI_PRIMARY_BUS, temps);
+}
+
+int __init add_bridge(struct device_node *dev)
+{
+	int len;
+	struct pci_controller *hose;
+	struct resource rsrc;
+	int *bus_range;
+	int has_address = 0;
+	int primary = 0;
+
+	DBG("Adding PCIE host bridge %s\n", dev->full_name);
+
+	/* Fetch host bridge registers address */
+	has_address = (of_address_to_resource(dev, 0, &rsrc) == 0);
+
+	/* Get bus range if any */
+	bus_range = (int *) get_property(dev, "bus-range", &len);
+	if (bus_range == NULL || len < 2 * sizeof(int))
+		printk(KERN_WARNING "Can't get bus-range for %s, assume"
+		       " bus 0\n", dev->full_name);
+
+	hose = pcibios_alloc_controller();
+	if (!hose)
+		return -ENOMEM;
+	hose->arch_data = dev;
+	hose->set_cfg_type = 1;
+
+	/* last_busno = 0xfe cause by MPC8641 PCIE bug */
+	hose->first_busno = bus_range ? bus_range[0] : 0x0;
+	hose->last_busno = bus_range ? bus_range[1] : 0xfe;
+
+	setup_indirect_pcie(hose, rsrc.start, rsrc.start + 0x4);
+
+	/* Setup the PCIE host controller. */
+	mpc86xx_setup_pcie(hose, rsrc.start, rsrc.end - rsrc.start + 1);
+
+	if ((rsrc.start & 0xfffff) == 0x8000)
+		primary = 1;
+
+	printk(KERN_INFO "Found MPC86xx PCIE host bridge at 0x%08lx. "
+	       "Firmware bus number: %d->%d\n",
+		rsrc.start, hose->first_busno, hose->last_busno);
+
+	DBG(" ->Hose at 0x%p, cfg_addr=0x%p,cfg_data=0x%p\n",
+		hose, hose->cfg_addr, hose->cfg_data);
+
+	/* Interpret the "ranges" property */
+	/* This also maps the I/O region and sets isa_io/mem_base */
+	pci_process_bridge_OF_ranges(hose, dev, primary);
+
+	/* Setup PEX window registers */
+	setup_pcie_atmu(hose, &rsrc);
+
+	return 0;
+}
+
+static void __devinit quirk_ali1575(struct pci_dev *dev)
+{
+	unsigned short temp;
+
+	/*
+	 * ALI1575 interrupts route table setup:
+	 *
+	 * IRQ pin   IRQ#
+	 * PIRQA ---- 3
+	 * PIRQB ---- 4
+	 * PIRQC ---- 5
+	 * PIRQD ---- 6
+	 * PIRQE ---- 9
+	 * PIRQF ---- 10
+	 * PIRQG ---- 11
+	 * PIRQH ---- 12
+	 *
+	 * interrupts for PCI slot0 -- PIRQA / PIRQB / PIRQC / PIRQD
+	 *                PCI slot1 -- PIRQB / PIRQC / PIRQD / PIRQA
+	 */
+	pci_write_config_dword(dev, 0x48, 0xb9317542);
+
+	/* USB 1.1 OHCI controller 1, interrupt: PIRQE */
+	pci_write_config_byte(dev, 0x86, 0x0c);
+
+	/* USB 1.1 OHCI controller 2, interrupt: PIRQF */
+	pci_write_config_byte(dev, 0x87, 0x0d);
+
+	/* USB 1.1 OHCI controller 3, interrupt: PIRQH */
+	pci_write_config_byte(dev, 0x88, 0x0f);
+
+	/* USB 2.0 controller, interrupt: PIRQ7 */
+	pci_write_config_byte(dev, 0x74, 0x06);
+
+	/* Audio controller, interrupt: PIRQE */
+	pci_write_config_byte(dev, 0x8a, 0x0c);
+
+	/* Modem controller, interrupt: PIRQF */
+	pci_write_config_byte(dev, 0x8b, 0x0d);
+
+	/* HD audio controller, interrupt: PIRQG */
+	pci_write_config_byte(dev, 0x8c, 0x0e);
+
+	/* Serial ATA interrupt: PIRQD */
+	pci_write_config_byte(dev, 0x8d, 0x0b);
+
+	/* SMB interrupt: PIRQH */
+	pci_write_config_byte(dev, 0x8e, 0x0f);
+
+	/* PMU ACPI SCI interrupt: PIRQH */
+	pci_write_config_byte(dev, 0x8f, 0x0f);
+
+	/* Primary PATA IDE IRQ: 14
+	 * Secondary PATA IDE IRQ: 15
+	 */
+	pci_write_config_byte(dev, 0x44, 0x3d);
+	pci_write_config_byte(dev, 0x75, 0x0f);
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
+}
+
+static void __devinit quirk_uli5288(struct pci_dev *dev)
+{
+	unsigned char c;
+
+	pci_read_config_byte(dev,0x83,&c);
+	c |= 0x80;
+	pci_write_config_byte(dev, 0x83, c);
+
+	pci_write_config_byte(dev, 0x09, 0x01);
+	pci_write_config_byte(dev, 0x0a, 0x06);
+
+	pci_read_config_byte(dev,0x83,&c);
+	c &= 0x7f;
+	pci_write_config_byte(dev, 0x83, c);
+
+	pci_read_config_byte(dev,0x84,&c);
+	c |= 0x01;
+	pci_write_config_byte(dev, 0x84, c);
+}
+
+static void __devinit quirk_uli5229(struct pci_dev *dev)
+{
+	unsigned short temp;
+	pci_write_config_word(dev, 0x04, 0x0405);
+	pci_read_config_word(dev, 0x4a, &temp);
+	temp |= 0x1000;
+	pci_write_config_word(dev, 0x4a, temp);
+}
+
+static void __devinit early_uli5249(struct pci_dev *dev)
+{
+	unsigned char temp;
+	pci_write_config_word(dev, 0x04, 0x0007);
+	pci_read_config_byte(dev, 0x7c, &temp);
+	pci_write_config_byte(dev, 0x7c, 0x80);
+	pci_write_config_byte(dev, 0x09, 0x01);
+	pci_write_config_byte(dev, 0x7c, temp);
+	dev->class |= 0x1;
+}
+
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x1575, quirk_ali1575);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5288, quirk_uli5288);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5229, quirk_uli5229);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AL, 0x5249, early_uli5249);
