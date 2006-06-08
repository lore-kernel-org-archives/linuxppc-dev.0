Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 0BE6467C42
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jun 2006 08:01:49 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k58MMXrp028308
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Jun 2006 15:22:33 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k58M1lAB020793
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Jun 2006 17:01:47 -0500 (CDT)
Subject: [PATCH 3/10 v2] Add MPC8641 HPCN PCI and PCI-Express files.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1149803866.23938.280.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Thu, 08 Jun 2006 16:57:46 -0500
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

 arch/powerpc/platforms/86xx/pci.c |  213 +++++++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/86xx/pex.c |  173 ++++++++++++++++++++++++++++++
 2 files changed, 386 insertions(+), 0 deletions(-)


diff --git a/arch/powerpc/platforms/86xx/pci.c b/arch/powerpc/platforms/86xx/pci.c
new file mode 100644
index 0000000..eff6f28
--- /dev/null
+++ b/arch/powerpc/platforms/86xx/pci.c
@@ -0,0 +1,213 @@
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
+
+#ifdef CONFIG_PEX
+static void __init
+mpc86xx_setup_pex(struct pci_controller *hose)
+{
+	volatile struct ccsr_pex *pex;
+	u16 cmd;
+	unsigned int temps;
+	phys_addr_t immr;
+
+	immr = get_immrbase();
+
+	pex = ioremap(immr + MPC86xx_PEX_OFFSET, MPC86xx_PEX_SIZE);
+
+	early_read_config_word(hose, 0, 0, PCI_COMMAND, &cmd);
+	cmd |= PCI_COMMAND_SERR | PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY
+	    | PCI_COMMAND_IO;
+	early_write_config_word(hose, 0, 0, PCI_COMMAND, cmd);
+
+	early_write_config_byte(hose, 0, 0, PCI_LATENCY_TIMER, 0x80);
+
+	/* PEX Bus, Fix the MPC8641D host bridge's location to bus 0xFF. */
+	early_read_config_dword(hose, 0, 0, PCI_PRIMARY_BUS, &temps);
+	temps = (temps & 0xff000000) | (0xff) | (0x0 << 8) | (0xfe << 16);
+	early_write_config_dword(hose, 0, 0, PCI_PRIMARY_BUS, temps);
+
+	/* Disable all windows (except pexowar0 since its ignored) */
+	pex->pexowar1 = 0;
+	pex->pexowar2 = 0;
+	pex->pexowar3 = 0;
+	pex->pexowar4 = 0;
+	pex->pexiwar1 = 0;
+	pex->pexiwar2 = 0;
+	pex->pexiwar3 = 0;
+
+	/* Setup Phys:PEX 1:1 outbound mem window @ MPC86XX_PEX_LOWER_MEM */
+	pex->pexotar1 = (MPC86XX_PEX_LOWER_MEM >> 12) & 0x000fffff;
+	pex->pexotear1 = 0x00000000;
+	pex->pexowbar1 = (MPC86XX_PEX_LOWER_MEM >> 12) & 0x000fffff;
+	/* Enable, Mem R/W */
+	pex->pexowar1 = 0x80044000 |
+		(__ilog2(MPC86XX_PEX_UPPER_MEM - MPC86XX_PEX_LOWER_MEM + 1) - 1);
+
+	/* Setup outboud IO windows @ MPC86XX_PEX_IO_BASE */
+	pex->pexotar2 = (MPC86XX_PEX_LOWER_IO >> 12) & 0x000fffff;
+	pex->pexotear2 = 0x00000000;
+	pex->pexowbar2 = (MPC86XX_PEX_IO_BASE >> 12) & 0x000fffff;
+	/* Enable, IO R/W */
+	pex->pexowar2 = 0x80088000 | (__ilog2(MPC86XX_PEX_IO_SIZE) - 1);
+
+	/* Setup 2G inbound Memory Window @ 0 */
+	pex->pexitar1 = 0x00000000;
+	pex->pexiwbar1 = 0x00000000;
+	/* Enable, Prefetch, Local Mem, Snoop R/W, 2G */
+	pex->pexiwar1 = 0xa0f5501e;
+}
+
+int __init add_bridge(struct device_node *dev)
+{
+	int len;
+	struct pci_controller *hose;
+	struct resource rsrc;
+	int *bus_range;
+	int has_address = 0;
+
+	pr_debug("Adding PEX host bridge %s\n", dev->full_name);
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
+	/* last_busno = 0xfe cause by PEX bug */
+	hose->first_busno = bus_range ? bus_range[0] : 0x0;
+	hose->last_busno = bus_range ? bus_range[1] : 0xfe;
+
+	setup_indirect_pex(hose, rsrc.start, rsrc.start + 0x4);
+
+	/* Setup the first PEX controller. */
+	if ((rsrc.start & 0xfffff) == 0x8000)
+		mpc86xx_setup_pex(hose);
+
+	printk(KERN_INFO "Found MPC86xx PEX host bridge at 0x%08lx. "
+	       "Firmware bus number: %d->%d\n",
+		rsrc.start, hose->first_busno, hose->last_busno);
+
+	pr_debug(" ->Hose at 0x%p, cfg_addr=0x%p,cfg_data=0x%p\n",
+		hose, hose->cfg_addr, hose->cfg_data);
+
+	/* Interpret the "ranges" property */
+	/* This also maps the I/O region and sets isa_io/mem_base */
+	pci_process_bridge_OF_ranges(hose, dev, 1);
+
+	return 0;
+}
+#endif /* CONFIG_PEX */
+
+static void __devinit quirk_ali1575(struct pci_dev *dev)
+{
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
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x1575, quirk_ali1575);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5288, quirk_uli5288);
+
diff --git a/arch/powerpc/platforms/86xx/pex.c b/arch/powerpc/platforms/86xx/pex.c
new file mode 100644
index 0000000..2624d3c
--- /dev/null
+++ b/arch/powerpc/platforms/86xx/pex.c
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
+/* ERRATA PCI-Ex 14 PEX Controller timeout */
+#define PEX_FIX		out_be32(hose->cfg_addr+0x4, 0x0400ffff)
+
+
+static int
+indirect_read_config_pex(struct pci_bus *bus, unsigned int devfn, int offset,
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
+	PEX_FIX;
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
+	PEX_FIX;
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
+indirect_write_config_pex(struct pci_bus *bus, unsigned int devfn, int offset,
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
+	PEX_FIX;
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
+		PEX_FIX;
+		temp = in_le32(cfg_data);
+		temp = (temp & ~(0xff << ((offset & 3) * 8))) |
+			(val << ((offset & 3) * 8));
+		PEX_FIX;
+		out_le32(cfg_data, temp);
+		break;
+	case 2:
+		PEX_FIX;
+		temp = in_le32(cfg_data);
+		temp = (temp & ~(0xffff << ((offset & 3) * 8)));
+		temp |= (val << ((offset & 3) * 8)) ;
+		PEX_FIX;
+		out_le32(cfg_data, temp);
+		break;
+	default:
+		PEX_FIX;
+		out_le32(cfg_data, val);
+		break;
+	}
+	PEX_FIX;
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static struct pci_ops indirect_pex_ops = {
+	indirect_read_config_pex,
+	indirect_write_config_pex
+};
+
+void __init
+setup_indirect_pex_nomap(struct pci_controller* hose, void __iomem * cfg_addr,
+	void __iomem * cfg_data)
+{
+	hose->cfg_addr = cfg_addr;
+	hose->cfg_data = cfg_data;
+	hose->ops = &indirect_pex_ops;
+}
+
+void __init
+setup_indirect_pex(struct pci_controller* hose, u32 cfg_addr, u32 cfg_data)
+{
+	unsigned long base = cfg_addr & PAGE_MASK;
+	void __iomem *mbase, *addr, *data;
+
+	mbase = ioremap(base, PAGE_SIZE);
+	addr = mbase + (cfg_addr & ~PAGE_MASK);
+	if ((cfg_data & PAGE_MASK) != base)
+		mbase = ioremap(cfg_data & PAGE_MASK, PAGE_SIZE);
+	data = mbase + (cfg_data & ~PAGE_MASK);
+	setup_indirect_pex_nomap(hose, addr, data);
+}
