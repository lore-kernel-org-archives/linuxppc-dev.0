Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A37BD67D7F
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 13:38:19 +1100 (EST)
Date: Thu, 14 Dec 2006 11:38:14 +0900 (JST)
Message-Id: <200612140238.kBE2cFeU021258@toshiba.co.jp>
Subject: [PATCH 11/19] powerpc: Supporting PCI bus and base of I/O for Celleb
To: paulus@samba.org
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch includes support for pci buses, base of Celleb specific
devices, and etc. It works on of_platform bus.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
---

Index: linux-powerpc-git/arch/powerpc/platforms/celleb/pci.c
diff -u /dev/null linux-powerpc-git/arch/powerpc/platforms/celleb/pci.c:1.8
--- /dev/null	Wed Dec 13 21:32:03 2006
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/pci.c	Wed Dec 13 18:13:44 2006
@@ -0,0 +1,581 @@
+/*
+ * Support for PCI on Celleb platform.
+ *
+ * (C) Copyright 2006 TOSHIBA CORPORATION
+ *
+ * This code is based on arch/powerpc/kernel/rtas_pci.c:
+ * Copyright (C) 2001 Dave Engebretsen, IBM Corporation
+ * Copyright (C) 2003 Anton Blanchard <anton@au.ibm.com>, IBM
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#undef DEBUG
+
+#include <linux/kernel.h>
+#include <linux/threads.h>
+#include <linux/pci.h>
+#include <linux/string.h>
+#include <linux/init.h>
+#include <linux/bootmem.h>
+#include <linux/pci_regs.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/prom.h>
+#include <asm/machdep.h>
+#include <asm/pci-bridge.h>
+#include <asm/ppc-pci.h>
+
+#include "pci.h"
+#include "interrupt.h"
+
+#define MAX_PCI_DEVICES    32
+#define MAX_PCI_FUNCTIONS   8
+#define MAX_PCI_BASE_ADDRS  6
+
+
+/* definition for fake pci configuration area for GbE, .... ,and etc. */
+
+struct celleb_pci_iodata {
+	unsigned long iobase[MAX_PCI_BASE_ADDRS];
+	unsigned long iosize[MAX_PCI_BASE_ADDRS];
+};
+
+struct celleb_pci_private {
+	unsigned char *fake_config[MAX_PCI_DEVICES][MAX_PCI_FUNCTIONS];
+	struct celleb_pci_iodata *iodata[MAX_PCI_DEVICES][MAX_PCI_FUNCTIONS];
+};
+
+static inline u8 celleb_fake_config_readb(void *addr)
+{
+	u8 *p = addr;
+	return *p;
+}
+
+static inline u16 celleb_fake_config_readw(void *addr)
+{
+	u16 *p = addr;
+	return le16_to_cpu(*p);
+}
+
+static inline u32 celleb_fake_config_readl(void *addr)
+{
+	u32 *p = addr;
+	return le32_to_cpu(*p);
+}
+
+static inline void celleb_fake_config_writeb(u32 val, void *addr)
+{
+	u8 *p = addr;
+	*p = val;
+}
+
+static inline void celleb_fake_config_writew(u32 val, void *addr)
+{
+	u16 val16;
+	u16 *p = addr;
+	val16 = cpu_to_le16(val);
+	*p = val16;
+}
+
+static inline void celleb_fake_config_writel(u32 val, void *addr)
+{
+	u32 val32;
+	u32 *p = addr;
+	val32 = cpu_to_le32(val);
+	*p = val32;
+}
+
+static unsigned char *get_fake_config_start(struct pci_controller *hose,
+					    int devno, int fn)
+{
+	struct celleb_pci_private *private = hose->private_data;
+
+	if (private == NULL)
+		return NULL;
+
+	return private->fake_config[devno][fn];
+}
+
+static unsigned long *get_iobase_start(struct pci_controller *hose,
+				       int devno, int fn)
+{
+	struct celleb_pci_private *private = hose->private_data;
+
+	if (private == NULL || private->iodata[devno][fn] == NULL)
+		return NULL;
+
+	return private->iodata[devno][fn]->iobase;
+}
+
+static unsigned long *get_iosize_start(struct pci_controller *hose,
+				       int devno, int fn)
+{
+	struct celleb_pci_private *private = hose->private_data;
+
+	if (private == NULL || private->iodata[devno][fn] == NULL)
+		return NULL;
+
+	return private->iodata[devno][fn]->iosize;
+}
+
+static void celleb_config_read_fake(unsigned char *config, int where,
+				    int size, u32 *val)
+{
+	char *p = config + where;
+
+	switch (size) {
+	case 1:
+		*val = celleb_fake_config_readb(p);
+		break;
+	case 2:
+		*val = celleb_fake_config_readw(p);
+		break;
+	case 4:
+		*val = celleb_fake_config_readl(p);
+		break;
+	}
+
+	return;
+}
+
+static void celleb_config_write_fake(unsigned char *config, int where,
+				     int size, u32 val)
+{
+	char *p = config + where;
+
+	switch (size) {
+	case 1:
+		celleb_fake_config_writeb(val, p);
+		break;
+	case 2:
+		celleb_fake_config_writew(val, p);
+		break;
+	case 4:
+		celleb_fake_config_writel(val, p);
+		break;
+	}
+	return;
+}
+
+static int celleb_fake_pci_read_config(struct pci_bus *bus,
+		unsigned int devfn, int where, int size, u32 *val)
+{
+	char *config;
+	struct device_node *node;
+	struct pci_controller *hose;
+	unsigned int devno = devfn >> 3;
+	unsigned int fn = devfn & 0x7;
+
+	/* allignment check */
+	BUG_ON(where % size);
+
+	pr_debug("    fake read: bus=0x%x, ", bus->number);
+	node = (struct device_node *)bus->sysdata;
+	hose = pci_find_hose_for_OF_device(node);
+	config = get_fake_config_start(hose, devno, fn);
+
+	pr_debug("devno=0x%x, where=0x%x, size=0x%x, ", devno, where, size);
+	if (!config) {
+		pr_debug("failed\n");
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	}
+
+	celleb_config_read_fake(config, where, size, val);
+	pr_debug("val=0x%x\n", *val);
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+
+static int celleb_fake_pci_write_config(struct pci_bus *bus,
+		 unsigned int devfn, int where, int size, u32 val)
+{
+	char *config;
+	struct device_node *node;
+	struct pci_controller *hose;
+	unsigned long *iosize;
+	unsigned int devno = devfn >> 3;
+	unsigned int fn = devfn & 0x7;
+
+	/* allignment check */
+	BUG_ON(where % size);
+
+	node = (struct device_node *)bus->sysdata;
+	hose = pci_find_hose_for_OF_device(node);
+	config = get_fake_config_start(hose, devno, fn);
+
+	if (!config)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	if (val == ~0) {
+		int i = (where - PCI_BASE_ADDRESS_0) >> 3;
+
+		switch (where) {
+		case PCI_BASE_ADDRESS_0:
+		case PCI_BASE_ADDRESS_2:
+			if (size != 4)
+				return PCIBIOS_DEVICE_NOT_FOUND;
+			iosize = get_iosize_start(hose, devno, fn);
+			if (!iosize)
+				return PCIBIOS_DEVICE_NOT_FOUND;
+			celleb_config_write_fake(config, where, size,
+						 iosize[i]);
+			return PCIBIOS_SUCCESSFUL;
+		case PCI_BASE_ADDRESS_1:
+		case PCI_BASE_ADDRESS_3:
+		case PCI_BASE_ADDRESS_4:
+		case PCI_BASE_ADDRESS_5:
+			break;
+		default:
+			break;
+		}
+	}
+
+	celleb_config_write_fake(config, where, size, val);
+	pr_debug("    fake write: where=%x, size=%d, val=%x\n",
+		 where, size, val);
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static struct pci_ops celleb_fake_pci_ops = {
+	celleb_fake_pci_read_config,
+	celleb_fake_pci_write_config
+};
+
+static void celleb_setup_pci_base_addrs(struct pci_controller *hose,
+			unsigned int devno, unsigned int fn,
+			unsigned int num_base_addr)
+{
+	u32 val;
+	unsigned char *config;
+	unsigned long *iobase;
+
+	config = get_fake_config_start(hose, devno, fn);
+	iobase = get_iobase_start(hose, devno, fn);
+
+	if (!config || !iobase)
+		return;
+
+	switch (num_base_addr) {
+	case 3:
+		val = (iobase[2] & 0xfffffff0)
+		    | PCI_BASE_ADDRESS_MEM_TYPE_64;
+		celleb_config_write_fake(config, PCI_BASE_ADDRESS_4, 4,
+					 val);
+		val = iobase[2] >> 32;
+		celleb_config_write_fake(config, PCI_BASE_ADDRESS_5, 4,
+					 val);
+		/* FALLTHROUGH */
+	case 2:
+		val = (iobase[1] & 0xfffffff0)
+		    | PCI_BASE_ADDRESS_MEM_TYPE_64;
+		celleb_config_write_fake(config, PCI_BASE_ADDRESS_2, 4,
+					 val);
+		val = iobase[1] >> 32;
+		celleb_config_write_fake(config, PCI_BASE_ADDRESS_3, 4,
+					 val);
+		/* FALLTHROUGH */
+	case 1:
+		val = (iobase[0] & 0xfffffff0)
+		    | PCI_BASE_ADDRESS_MEM_TYPE_64;
+		celleb_config_write_fake(config, PCI_BASE_ADDRESS_0, 4,
+					 val);
+		val = iobase[0] >> 32;
+		celleb_config_write_fake(config, PCI_BASE_ADDRESS_1, 4,
+					 val);
+		break;
+	}
+
+	val = PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER;
+	celleb_config_write_fake(config, PCI_COMMAND, 2, val);
+}
+
+
+static int __devinit celleb_setup_fake_pci_device(struct device_node *node,
+						  struct pci_controller *hose)
+{
+	unsigned int rlen, num_base_addr;
+	u32 val;
+	const u32 *wi0, *wi1, *wi2, *wi3, *wi4;
+	unsigned int devno, fn;
+	struct celleb_pci_private *private = hose->private_data;
+	unsigned char **config = NULL;
+	struct celleb_pci_iodata **iodata = NULL;
+	unsigned long *iobase, *iosize;
+	const char *name;
+	const unsigned long *li;
+	int size;
+	int i;
+
+	if (private == NULL) {
+		printk(KERN_ERR "PCI: "
+		       "memory space for pci controller is not assigned\n");
+		goto error;
+	}
+
+	name = get_property(node, "model", &rlen);
+	if (!name) {
+		printk(KERN_ERR "PCI: model property not found.\n");
+		goto error;
+	}
+
+	wi4 = get_property(node, "reg", &rlen);
+	if (wi4 == NULL)
+		goto error;
+
+	devno = ((wi4[0] >> 8) & 0xff) >> 3;
+	fn = (wi4[0] >> 8) & 0x7;
+
+	pr_debug("PCI: celleb_setup_fake_pci() %s devno=%x fn=%x\n", name,
+		 devno, fn);
+
+	size = 256;
+	config = &private->fake_config[devno][fn];
+	if (mem_init_done)
+		*config = kzalloc(size, GFP_KERNEL);
+	else
+		*config = alloc_bootmem(size);
+	if (*config == NULL) {
+		printk(KERN_ERR "PCI: "
+		       "not enough memory for fake configuration space\n");
+		goto error;
+	}
+	pr_debug("PCI: fake config area assigned 0x%016lx\n",
+		 (unsigned long)*config);
+
+	size = sizeof(struct celleb_pci_iodata);
+	iodata = &private->iodata[devno][fn];
+	if (mem_init_done)
+		*iodata = kzalloc(size, GFP_KERNEL);
+	else
+		*iodata = alloc_bootmem(size);
+	if (*iodata == NULL) {
+		printk(KERN_ERR
+		       "PCI: not enough memory for iobase data space\n");
+		goto error;
+	}
+	pr_debug("PCI: iodata assigned 0x%016lx\n", (unsigned long)*iodata);
+
+	iobase = get_iobase_start(hose, devno, fn);
+	iosize = get_iosize_start(hose, devno, fn);
+	pr_debug("PCI: "
+		 "iobase info addr = 0x%016lx, iosize info addr=0x%016lx\n",
+		 (unsigned long)iobase, (unsigned long)iosize);
+
+	wi0 = get_property(node, "device-id", NULL);
+	wi1 = get_property(node, "vendor-id", NULL);
+	wi2 = get_property(node, "class-code", NULL);
+	wi3 = get_property(node, "revision-id", NULL);
+
+	celleb_config_write_fake(*config, PCI_DEVICE_ID, 2,
+				 wi0[0] & 0xffff);
+	celleb_config_write_fake(*config, PCI_VENDOR_ID, 2,
+				 wi1[0] & 0xffff);
+	pr_debug("class-code = 0x%08x\n", wi2[0]);
+
+	celleb_config_write_fake(*config, PCI_CLASS_PROG, 1, wi2[0] & 0xff);
+	celleb_config_write_fake(*config, PCI_CLASS_DEVICE, 2,
+				 (wi2[0] >> 8) & 0xffff);
+	celleb_config_write_fake(*config, PCI_REVISION_ID, 1, wi3[0]);
+
+	li = get_property(node, "toshiba,reg", &rlen);
+
+	if (li) {
+		num_base_addr = rlen >> 4;
+
+		if (num_base_addr > 3)
+			num_base_addr = 3;
+		pr_debug("PCI: %s: number of base addresses is %d\n",
+			 name, num_base_addr);
+
+		for (i = 0; i < num_base_addr; i++) {
+			iobase[i] = li[i * 2];
+			iosize[i] = li[i * 2 + 1];
+			pr_debug("PCI: base address %d: 0x%lx-0x%lx\n",
+				 i, li[i * 2], li[i * 2 + 1]);
+		}
+
+	} else {
+		printk(KERN_ERR "PCI: No toshiba,reg property\n");
+		goto error;
+	}
+
+	celleb_setup_pci_base_addrs(hose, devno, fn, num_base_addr);
+
+	li = get_property(node, "interrupts", &rlen);
+	val = li[0];
+	celleb_config_write_fake(*config, PCI_INTERRUPT_PIN, 1, 1);
+	celleb_config_write_fake(*config, PCI_INTERRUPT_LINE, 1, val);
+
+#ifdef DEBUG
+	pr_debug("PCI: %s irq=%ld\n", name, li[0]);
+	for (i = 0; i < 6; i++) {
+		celleb_config_read_fake(*config,
+					PCI_BASE_ADDRESS_0 + 0x4 * i, 4,
+					&val);
+		pr_debug("PCI: %s fn=%d base_address_%d=0x%x\n",
+			 name, fn, i, val);
+	}
+#endif
+
+	celleb_config_write_fake(*config, PCI_HEADER_TYPE, 1,
+				 PCI_HEADER_TYPE_NORMAL);
+
+	return 0;
+
+error:
+	if (mem_init_done) {
+		if (config && *config)
+			kfree(*config);
+		if (iodata && *iodata)
+			kfree(*iodata);
+
+	} else {
+		if (config && *config) {
+			size = 256;
+			free_bootmem((unsigned long)(*config), size);
+		}
+		if (iodata && *iodata) {
+			size = sizeof(struct celleb_pci_iodata);
+			free_bootmem((unsigned long)(*iodata), size);
+		}
+	}
+
+	return 1;
+}
+
+
+void __devinit celleb_pcibios_fixup(void)
+{
+	struct pci_dev *dev = NULL;
+	struct pci_bus *bus;
+	struct list_head *ln;
+
+	for_each_pci_dev(dev) {
+		bus = dev->bus;
+		if (bus && ppc_md.pci_probe_mode(bus) == PCI_PROBE_NORMAL)
+			continue;
+
+		pci_read_irq_line(dev);
+	}
+
+	list_for_each(ln, &pci_root_buses) {
+		bus = pci_bus_b(ln);
+		if (ppc_md.pci_probe_mode(bus) == PCI_PROBE_NORMAL) {
+			dev = NULL;
+
+#if 1				/* XXX: This is for SYSCON workaround */
+			list_for_each_entry(dev, &bus->devices, bus_list) {
+				int i;
+				if ((dev->class >> 8) != PCI_CLASS_BRIDGE_HOST)
+					continue;
+
+				for (i = 0; i < PCI_NUM_RESOURCES; i++) {
+					struct resource *r = NULL;
+					struct resource *root = NULL;
+					r = &dev->resource[i];
+					root = pcibios_select_root(dev, r);
+					if (!(r->flags) || r->parent)
+						continue;
+
+					insert_resource(root, r);
+				}
+			}
+#endif
+			pci_bus_assign_resources(bus);
+			pci_enable_bridges(bus);
+		}
+	}
+
+	return;
+}
+
+static int __devinit phb_set_bus_ranges(struct device_node *dev,
+					struct pci_controller *phb)
+{
+	const int *bus_range;
+	unsigned int len;
+
+	bus_range = get_property(dev, "bus-range", &len);
+	if (bus_range == NULL || len < 2 * sizeof(int))
+		return 1;
+
+	phb->first_busno = bus_range[0];
+	phb->last_busno = bus_range[1];
+
+	return 0;
+}
+
+static void __devinit celleb_alloc_private_mem(struct pci_controller *hose)
+{
+	if (mem_init_done)
+		hose->private_data =
+			kzalloc(sizeof(struct celleb_pci_private), GFP_KERNEL);
+	else
+		hose->private_data =
+			alloc_bootmem(sizeof(struct celleb_pci_private));
+}
+
+int __devinit celleb_setup_phb(struct pci_controller *phb)
+{
+	const char *name;
+	struct device_node *dev = phb->arch_data;
+	struct device_node *node;
+	unsigned int rlen;
+	
+	name = get_property(dev, "name", &rlen);
+	if (!name)
+		return 1;
+
+	pr_debug("PCI: celleb_setup_phb() %s\n", name);
+	phb_set_bus_ranges(dev, phb);
+
+	if (strcmp(name, "epci") == 0) {
+		phb->ops = &celleb_epci_ops;
+		celleb_setup_epci(dev, phb);
+
+	} else if (strcmp(name, "pci-pseudo") == 0) {
+		phb->ops = &celleb_fake_pci_ops;
+		celleb_alloc_private_mem(phb);
+		for (node = of_get_next_child(dev, NULL);
+		     node != NULL; node = of_get_next_child(dev, node))
+			celleb_setup_fake_pci_device(node, phb);
+
+	} else
+		return 1;
+
+	return 0;
+}
+
+/*
+ * To be fixed: watch <n> bit of "reg" property
+ *              -- and set proper property to "reg" via bootloader.
+ */
+int celleb_pci_probe_mode(struct pci_bus *bus)
+{
+	struct device_node *node;
+	const char *name;
+
+	node = (struct device_node *)bus->sysdata;
+	name = get_property(node, "name", NULL);
+
+	if (strcmp(name, "pci-pseudo") == 0)
+		return PCI_PROBE_DEVTREE;
+
+	return PCI_PROBE_NORMAL;
+}
Index: linux-powerpc-git/arch/powerpc/platforms/celleb/pci.h
diff -u /dev/null linux-powerpc-git/arch/powerpc/platforms/celleb/pci.h:1.2
--- /dev/null	Wed Dec 13 21:32:03 2006
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/pci.h	Wed Dec 13 18:37:14 2006
@@ -0,0 +1,36 @@
+/*
+ * pci prototypes for Celleb platform
+ *
+ * (C) Copyright 2006 TOSHIBA CORPORATION
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifndef _CELLEB_PCI_H
+#define _CELLEB_PCI_H
+
+#include <linux/pci.h>
+
+#include <asm/pci-bridge.h>
+#include <asm/prom.h>
+
+extern int celleb_setup_phb(struct pci_controller *);
+extern void celleb_pcibios_fixup(void);
+extern int celleb_pci_probe_mode(struct pci_bus *);
+
+extern struct pci_ops celleb_epci_ops;
+extern int celleb_setup_epci(struct device_node *, struct pci_controller *);
+
+#endif /* _CELLEB_PCI_H */
Index: linux-powerpc-git/arch/powerpc/platforms/celleb/scc_epci.c
diff -u /dev/null linux-powerpc-git/arch/powerpc/platforms/celleb/scc_epci.c:1.6
--- /dev/null	Wed Dec 13 21:32:03 2006
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/scc_epci.c	Wed Dec 13 18:13:44 2006
@@ -0,0 +1,547 @@
+/*
+ * Support for SCC external PCI
+ *
+ * (C) Copyright 2004-2006 TOSHIBA CORPORATION
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#undef DEBUG
+
+#include <linux/kernel.h>
+#include <linux/threads.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/pci_regs.h>
+#include <linux/bootmem.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/prom.h>
+#include <asm/machdep.h>
+#include <asm/pci-bridge.h>
+#include <asm/ppc-pci.h>
+
+#include "scc.h"
+#include "pci.h"
+#include "interrupt.h"
+
+#define MAX_PCI_DEVICES   32
+#define MAX_PCI_FUNCTIONS  8
+
+#define iob()  __asm__ __volatile__("eieio; sync":::"memory")
+
+
+struct celleb_epci_private {
+	unsigned int epci_ext_irq;
+	unsigned int epci_int_irq;
+};
+
+
+#if 0
+static void celleb_epci_dummy_read(struct pci_dev *dev)
+{
+	unsigned long epci_base;
+	struct device_node *node;
+	struct pci_controller *hose;
+	u32 val;
+
+	node = (struct device_node *)dev->bus->sysdata;
+	hose = pci_find_hose_for_OF_device(node);
+
+	if (!hose)
+		return;
+
+	epci_base = (unsigned long)hose->cfg_addr;
+
+	val = in_be32((void *)(epci_base + SCC_EPCI_WATRP));
+	iosync();
+
+	return;
+}
+#endif
+
+static inline void clear_and_disable_master_abort_interrupt(
+					struct pci_controller *hose)
+{
+	unsigned long addr;
+	addr = (unsigned long)hose->cfg_addr + PCI_COMMAND;
+	out_be32((void *)addr,
+		 in_be32((void *)addr) | (PCI_STATUS_REC_MASTER_ABORT << 16));
+}
+
+static int celleb_epci_check_abort(struct pci_controller *hose,
+				   unsigned long addr)
+{
+	unsigned long reg;
+	unsigned long epci_base;
+	u32 val;
+
+	iob();
+	epci_base = (unsigned long)hose->cfg_addr;
+
+	reg = epci_base + PCI_COMMAND;
+	val = in_be32((void *)reg);
+
+	if (val & (PCI_STATUS_REC_MASTER_ABORT << 16)) {
+		out_be32((void *)reg,
+			 (val & 0xffff) | (PCI_STATUS_REC_MASTER_ABORT << 16));
+
+		/* clear PCI Controller error, FRE, PMFE */
+		reg = epci_base + SCC_EPCI_STATUS;
+		out_be32((void *)reg, SCC_EPCI_INT_PAI);
+
+		reg = epci_base + SCC_EPCI_VCSR;
+		val = in_be32((void *)reg) & 0xffff;
+		val |= SCC_EPCI_VCSR_FRE;
+		out_be32((void *)reg, val);
+
+		reg = epci_base + SCC_EPCI_VISTAT;
+		out_be32((void *)reg, SCC_EPCI_VISTAT_PMFE);
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int celleb_epci_subordinate_read_config(struct pci_controller *hose,
+					       int bus, unsigned int devfn,
+					       int where, int size, u32 *val)
+{
+	unsigned long addr;
+
+	if (!hose->cfg_data)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	if (where == PCI_INTERRUPT_LINE) {
+		struct celleb_epci_private *private = hose->private_data;
+		if (private == NULL)
+			return PCIBIOS_DEVICE_NOT_FOUND;
+		*val = irq_create_mapping(NULL, private->epci_ext_irq);
+		return PCIBIOS_SUCCESSFUL;
+	} else if (where == PCI_INTERRUPT_PIN) {
+		*val = 1;
+		return PCIBIOS_SUCCESSFUL;
+	}
+
+	clear_and_disable_master_abort_interrupt(hose);
+
+	/* address for PCI configuration access */
+	addr = (unsigned long)hose->cfg_data +
+		(((bus & 0xff) << 16)
+		 | ((devfn & 0xff) << 8)
+		 | (where & 0xff)
+		 | 0x01000000);
+
+	switch (size) {
+	case 1:
+		*val = in_8((u8 *)addr);
+		break;
+	case 2:
+		*val = in_le16((u16 *)addr);
+		break;
+	case 4:
+		*val = in_le32((u32 *)addr);
+		break;
+	default:
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	}
+
+	return celleb_epci_check_abort(hose, 0);
+}
+
+static int celleb_epci_subordinate_write_config(struct pci_controller *hose,
+						int bus, unsigned int devfn,
+						int where, int size, u32 val)
+{
+	unsigned long addr;
+
+	if (!hose->cfg_data)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	clear_and_disable_master_abort_interrupt(hose);
+
+	/* address for PCI configuration access */
+	addr = (unsigned long)hose->cfg_data +
+		(((bus & 0xff) << 16)
+		 | ((devfn & 0xff) << 8)
+		 | (where & 0xff)
+		 | 0x01000000);
+
+	switch (size) {
+	case 1:
+		out_8((u8 *)addr, val);
+		break;
+	case 2:
+		out_le16((u16 *)addr, val);
+		break;
+	case 4:
+		out_le32((u32 *)addr, val);
+		break;
+	default:
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	}
+
+	return celleb_epci_check_abort(hose, addr);
+}
+
+static int celleb_epci_read_config(struct pci_bus *bus,
+			unsigned int devfn, int where, int size, u32 * val)
+{
+	unsigned long addr;
+	struct device_node *node;
+	struct pci_controller *hose;
+
+	/* allignment check */
+	BUG_ON(where % size);
+
+	node = (struct device_node *)bus->sysdata;
+	hose = pci_find_hose_for_OF_device(node);
+
+	if (bus->self)
+		return celleb_epci_subordinate_read_config(hose,
+					bus->number, devfn, where, size, val);
+
+	if (!hose->cfg_data)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	if (bus->number == hose->first_busno && devfn == 0) {
+		/* EPCI controller self */
+
+		if (where == PCI_INTERRUPT_LINE) {
+			struct celleb_epci_private *private = hose->private_data;
+			if (private == NULL)
+				return PCIBIOS_DEVICE_NOT_FOUND;
+			*val = irq_create_mapping(NULL, private->epci_int_irq);
+			return PCIBIOS_SUCCESSFUL;
+		} else if (where == PCI_INTERRUPT_PIN) {
+			*val = 1;
+			return PCIBIOS_SUCCESSFUL;
+		}
+
+		addr = (unsigned long)hose->cfg_addr + where;
+
+		switch (size) {
+		case 1:
+			*val = in_8((u8 *)addr);
+			break;
+		case 2:
+			*val = in_be16((u16 *)addr);
+			break;
+		case 4:
+			*val = in_be32((u32 *)addr);
+			break;
+		default:
+			return PCIBIOS_DEVICE_NOT_FOUND;
+		}
+
+	} else {
+
+		if (where == PCI_INTERRUPT_LINE) {
+			struct celleb_epci_private *private = hose->private_data;
+			if (private == NULL)
+				return PCIBIOS_DEVICE_NOT_FOUND;
+			*val = irq_create_mapping(NULL, private->epci_ext_irq);
+			return PCIBIOS_SUCCESSFUL;
+		} else if (where == PCI_INTERRUPT_PIN) {
+			*val = 1;
+			return PCIBIOS_SUCCESSFUL;
+		}
+
+		clear_and_disable_master_abort_interrupt(hose);
+
+		/* address for PCI configuration access */
+		addr = (unsigned long)hose->cfg_data +
+			(((devfn & 0xff) << 8) | (where & 0xff));
+
+		switch (size) {
+		case 1:
+			*val = in_8((u8 *)addr);
+			break;
+		case 2:
+			*val = in_le16((u16 *)addr);
+			break;
+		case 4:
+			*val = in_le32((u32 *)addr);
+			break;
+		default:
+			return PCIBIOS_DEVICE_NOT_FOUND;
+		}
+	}
+
+	pr_debug("    epci read: "
+		 "addr=0x%lx, devfn=0x%x, where=0x%x, size=0x%x, val=0x%x\n",
+		 addr, devfn, where, size, *val);
+
+	return celleb_epci_check_abort(hose, 0);
+}
+
+static int celleb_epci_write_config(struct pci_bus *bus,
+			unsigned int devfn, int where, int size, u32 val)
+{
+	unsigned long addr;
+	struct device_node *node;
+	struct pci_controller *hose;
+
+	/* allignment check */
+	BUG_ON(where % size);
+
+	node = (struct device_node *)bus->sysdata;
+	hose = pci_find_hose_for_OF_device(node);
+
+	if (bus->self)
+		return celleb_epci_subordinate_write_config(hose,
+					bus->number, devfn, where, size, val);
+
+	if (!hose->cfg_data)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	if (bus->number == hose->first_busno && devfn == 0) {
+		/* EPCI controller self */
+
+		addr = (unsigned long)hose->cfg_addr + where;
+
+		switch (size) {
+		case 1:
+			out_8((u8 *)addr, val);
+			break;
+		case 2:
+			out_be16((u16 *)addr, val);
+			break;
+		case 4:
+			out_be32((u32 *)addr, val);
+			break;
+		default:
+			return PCIBIOS_DEVICE_NOT_FOUND;
+		}
+
+	} else {
+
+		clear_and_disable_master_abort_interrupt(hose);
+
+		/* address for PCI configuration access */
+		addr = (unsigned long)hose->cfg_data +
+			(((devfn & 0xff) << 8) | (where & 0xff));
+
+		switch (size) {
+		case 1:
+			out_8((u8 *)addr, val);
+			break;
+		case 2:
+			out_le16((u16 *)addr, val);
+			break;
+		case 4:
+			out_le32((u32 *)addr, val);
+			break;
+		default:
+			return PCIBIOS_DEVICE_NOT_FOUND;
+		}
+	}
+
+	return celleb_epci_check_abort(hose, addr);
+}
+
+struct pci_ops celleb_epci_ops = {
+	celleb_epci_read_config,
+	celleb_epci_write_config,
+};
+
+static int __devinit celleb_epci_init(struct pci_controller *hose)
+{
+	u32 val;
+	unsigned long reg;
+	unsigned long epci_base;
+	int hwres = 0;
+
+	epci_base = (unsigned long)hose->cfg_addr;
+
+	/* PCI core reset(Internal bus and PCI clock) */
+	reg = epci_base + SCC_EPCI_CKCTRL;
+	val = in_be32((void *)reg);
+	if (val == 0x00030101)
+		hwres = 1;
+	else {
+		val &= ~(SCC_EPCI_CKCTRL_CRST0 | SCC_EPCI_CKCTRL_CRST1);
+		out_be32((void *)reg, val);
+
+		/* set PCI core clock */
+		val = in_be32((void *)reg);
+		val |= (SCC_EPCI_CKCTRL_OCLKEN | SCC_EPCI_CKCTRL_LCLKEN);
+		out_be32((void *)reg, val);
+
+		/* release PCI core reset (internal bus) */
+		val = in_be32((void *)reg);
+		val |= SCC_EPCI_CKCTRL_CRST0;
+		out_be32((void *)reg, val);
+
+		/* set PCI clock select */
+		reg = epci_base + SCC_EPCI_CLKRST;
+		val = in_be32((void *)reg);
+		val &= ~SCC_EPCI_CLKRST_CKS_MASK;
+		val |= SCC_EPCI_CLKRST_CKS_2;
+		out_be32((void *)reg, val);
+
+		/* set arbiter */
+		reg = epci_base + SCC_EPCI_ABTSET;
+		out_be32((void *)reg, 0x0f1f001f);	/* temporary value */
+
+		/* buffer on */
+		reg = epci_base + SCC_EPCI_CLKRST;
+		val = in_be32((void *)reg);
+		val |= SCC_EPCI_CLKRST_BC;
+		out_be32((void *)reg, val);
+
+		/* PCI clock enable */
+		val = in_be32((void *)reg);
+		val |= SCC_EPCI_CLKRST_PCKEN;
+		out_be32((void *)reg, val);
+
+		/* release PCI core reset (all) */
+		reg = epci_base + SCC_EPCI_CKCTRL;
+		val = in_be32((void *)reg);
+		val |= (SCC_EPCI_CKCTRL_CRST0 | SCC_EPCI_CKCTRL_CRST1);
+		out_be32((void *)reg, val);
+
+		/* set base translation registers. (already set by Beat) */
+
+		/* set base address masks. (already set by Beat) */
+	}
+
+	/* release interrupt masks and clear all interrupts */
+	reg = epci_base + SCC_EPCI_INTSET;
+	out_be32((void *)reg, 0x013f011f);	/* all interrupts enable */
+	reg = epci_base + SCC_EPCI_VIENAB;
+	val = SCC_EPCI_VIENAB_PMPEE | SCC_EPCI_VIENAB_PMFEE;
+	out_be32((void *)reg, val);
+	reg = epci_base + SCC_EPCI_STATUS;
+	out_be32((void *)reg, 0xffffffff);
+	reg = epci_base + SCC_EPCI_VISTAT;
+	out_be32((void *)reg, 0xffffffff);
+
+	/* disable PCI->IB address translation */
+	reg = epci_base + SCC_EPCI_VCSR;
+	val = in_be32((void *)reg);
+	val &= ~(SCC_EPCI_VCSR_DR | SCC_EPCI_VCSR_AT);
+	out_be32((void *)reg, val);
+
+	/* set base addresses. (no need to set?) */
+
+	/* memory space, bus master enable */
+	reg = epci_base + PCI_COMMAND;
+	val = PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER;
+	out_be32((void *)reg, val);
+
+	/* endian mode setup */
+	reg = epci_base + SCC_EPCI_ECMODE;
+	//val = 0x00ff03ff;
+	val = 0x00550155;
+	//val = 0x00550000;
+	out_be32((void *)reg, val);
+
+	/* set control option */
+	reg = epci_base + SCC_EPCI_CNTOPT;
+	val = in_be32((void *)reg);
+	val |= SCC_EPCI_CNTOPT_O2PMB;
+	out_be32((void *)reg, val);
+
+	/* XXX: temporay: set registers for address conversion setup */
+	reg = epci_base + SCC_EPCI_CNF10_REG;
+	out_be32((void *)reg, 0x80000008);
+	reg = epci_base + SCC_EPCI_CNF14_REG;
+	out_be32((void *)reg, 0x40000008);
+
+	reg = epci_base + SCC_EPCI_BAM0;
+	out_be32((void *)reg, 0x80000000);
+	reg = epci_base + SCC_EPCI_BAM1;
+	out_be32((void *)reg, 0xe0000000);
+
+	reg = epci_base + SCC_EPCI_PVBAT;
+	out_be32((void *)reg, 0x80000000);
+
+	if (!hwres) {
+		/* release external PCI reset */
+		reg = epci_base + SCC_EPCI_CLKRST;
+		val = in_be32((void *)reg);
+		val |= SCC_EPCI_CLKRST_PCIRST;
+		out_be32((void *)reg, val);
+	}
+
+	return 0;
+}
+
+int __devinit celleb_setup_epci(struct device_node *node,
+				struct pci_controller *hose)
+{
+	const unsigned long *li, *li2;
+	unsigned int rlen;
+	struct celleb_epci_private *private;
+
+
+	pr_debug("PCI: celleb_setup_epci()\n");
+
+	li = get_property(node, "toshiba,reg", &rlen);
+
+	if (!li || ((rlen >> 4) != 4)) {
+		printk(KERN_ERR "PCI: No toshiba,reg property\n");
+		goto error;
+	}
+
+	hose->cfg_addr = ioremap(li[0], li[1]);
+	if (!hose->cfg_addr)
+		goto error;
+
+	hose->cfg_data = ioremap(li[4], li[5]);
+	if (!hose->cfg_data)
+		goto error;
+
+	if (mem_init_done)
+		hose->private_data = private =
+		    kzalloc(sizeof(struct celleb_epci_private), GFP_KERNEL);
+	else
+		hose->private_data = private =
+		    alloc_bootmem(sizeof(struct celleb_epci_private));
+
+
+	li2 = get_property(node, "interrupts", &rlen);
+	if (!li2) {
+		printk(KERN_ERR "PCI: No interrupts property");
+		goto error;
+	}
+
+	if (private){
+		private->epci_ext_irq = li2[0];
+		private->epci_int_irq = li2[1];
+	}
+
+	pr_debug("PCI: epci_ext_irq %x epci_int_irq %x\n",
+		 private->epci_ext_irq, private->epci_int_irq);
+	pr_debug("PCI: cfg_addr 0x%016lx->0x%016lx + 0x%016lx\n",
+		 li[0], (unsigned long)hose->cfg_addr, li[1]);
+	pr_debug("PCI: cfg_data map 0x%016lx->0x%016lx + 0x%016lx\n",
+		 li[4], (unsigned long)hose->cfg_data, li[5]);
+
+	celleb_epci_init(hose);
+
+	return 0;
+
+error:
+	if (hose->cfg_addr)
+		iounmap((void *)hose->cfg_addr);
+
+	if (hose->cfg_data)
+		iounmap((void *)hose->cfg_data);
+
+	return 1;
+}
Index: linux-powerpc-git/arch/powerpc/platforms/celleb/scc_uhc.c
diff -u /dev/null linux-powerpc-git/arch/powerpc/platforms/celleb/scc_uhc.c:1.3
--- /dev/null	Wed Dec 13 21:32:03 2006
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/scc_uhc.c	Wed Dec 13 18:37:14 2006
@@ -0,0 +1,90 @@
+/*
+ * SCC (Super Companion Chip) UHC setup
+ *
+ * (C) Copyright 2006 TOSHIBA CORPORATION
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+
+#include <asm/delay.h>
+#include <asm/io.h>
+
+#include "scc.h"
+
+#define UHC_RESET_WAIT_MAX 10000
+
+static inline int uhc_clkctrl_ready(u32 val)
+{
+	const u32 mask = SCC_UHC_USBCEN | SCC_UHC_USBCEN;
+	return((val & mask) == mask);
+}
+
+/*
+ * UHC(usb host controler) enable function.
+ * affect to both of OHCI and EHCI core module.
+ */
+static void quirk_scc_uhc_enable(struct pci_dev *dev)
+{
+	void __iomem *uhc_base;
+	u32 __iomem *uhc_clkctrl;
+	u32 __iomem *uhc_ecmode;
+	u32 val = 0;
+	int i;
+
+	uhc_base = ioremap(pci_resource_start(dev, 0),
+			   pci_resource_len(dev, 0));
+	if (!uhc_base) {
+		printk(KERN_ERR "failed to map UHC register base.\n");
+		return;
+	}
+	uhc_clkctrl = uhc_base + SCC_UHC_CKRCTRL; 
+	uhc_ecmode  = uhc_base + SCC_UHC_ECMODE; 
+
+	/* setup for normal mode */
+	val |= SCC_UHC_F48MCKLEN;
+	out_be32(uhc_clkctrl, val);
+	val |= SCC_UHC_PHY_SUSPEND_SEL;
+	out_be32(uhc_clkctrl, val);
+	udelay(10);
+	val |= SCC_UHC_PHYEN;
+	out_be32(uhc_clkctrl, val);
+	udelay(50);
+
+	/* disable reset */
+	val |= SCC_UHC_HCLKEN;
+	out_be32(uhc_clkctrl, val);
+	val |= (SCC_UHC_USBCEN | SCC_UHC_USBEN);
+	out_be32(uhc_clkctrl, val);
+	i = 0;
+	while (!uhc_clkctrl_ready(in_be32(uhc_clkctrl))) {
+		udelay(10);
+		if (i++ > UHC_RESET_WAIT_MAX) {
+			printk(KERN_ERR "Failed to disable UHC reset %x\n",
+			       in_be32(uhc_clkctrl));
+			break;
+		}
+	}
+
+	/* Endian Conversion Mode for Master ALL area */
+	out_be32(uhc_ecmode, SCC_UHC_ECMODE_BY_BYTE);
+
+	iounmap(uhc_base);
+}
+
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TOSHIBA_2,
+		 PCI_DEVICE_ID_TOSHIBA_SCC_USB, quirk_scc_uhc_enable);
