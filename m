Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx2.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 40775DDEEF
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Mar 2008 23:23:13 +1100 (EST)
Date: Fri, 14 Mar 2008 21:23:09 +0900 (JST)
Message-Id: <20080314.212309.-494074809.kouish@swc.toshiba.co.jp>
To: paulus@samba.org
Subject: [PATCH 4/11] celleb: move the base part for celleb support
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

This patch moves the base code for celleb support into platforms/cell/.
All files in this patch are used by celleb-beat and celleb-native commonly.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
---
 arch/powerpc/platforms/Kconfig             |    1 
 arch/powerpc/platforms/cell/Kconfig        |   13 
 arch/powerpc/platforms/cell/Makefile       |    4 
 arch/powerpc/platforms/cell/celleb_pci.c   |  531 ++++++++++++++++++++++++++++
 arch/powerpc/platforms/cell/celleb_pci.h   |   39 ++
 arch/powerpc/platforms/cell/celleb_setup.c |  259 ++++++++++++++
 arch/powerpc/platforms/celleb/Kconfig      |   12 
 arch/powerpc/platforms/celleb/Makefile     |    4 
 arch/powerpc/platforms/celleb/pci.c        |  533 -----------------------------
 arch/powerpc/platforms/celleb/pci.h        |   39 --
 arch/powerpc/platforms/celleb/scc_epci.c   |    2 
 arch/powerpc/platforms/celleb/setup.c      |  259 --------------
 12 files changed, 848 insertions(+), 848 deletions(-)

Index: b/arch/powerpc/platforms/Kconfig
===================================================================
--- a/arch/powerpc/platforms/Kconfig	2008-03-13 17:54:30.000000000 +0900
+++ b/arch/powerpc/platforms/Kconfig	2008-03-13 17:57:55.000000000 +0900
@@ -45,7 +45,6 @@
 source "arch/powerpc/platforms/prep/Kconfig"
 source "arch/powerpc/platforms/maple/Kconfig"
 source "arch/powerpc/platforms/pasemi/Kconfig"
-source "arch/powerpc/platforms/celleb/Kconfig"
 source "arch/powerpc/platforms/ps3/Kconfig"
 source "arch/powerpc/platforms/cell/Kconfig"
 source "arch/powerpc/platforms/8xx/Kconfig"
Index: b/arch/powerpc/platforms/cell/Kconfig
===================================================================
--- a/arch/powerpc/platforms/cell/Kconfig	2008-03-13 17:54:30.000000000 +0900
+++ b/arch/powerpc/platforms/cell/Kconfig	2008-03-13 17:57:55.000000000 +0900
@@ -25,6 +25,19 @@
 	select PPC_UDBG_16550
 	select UDBG_RTAS_CONSOLE
 
+config PPC_CELLEB
+	bool "Toshiba's Cell Reference Set 'Celleb' Architecture"
+	depends on PPC_MULTIPLATFORM && PPC64
+	select PPC_CELL
+	select PPC_CELL_NATIVE
+	select PPC_RTAS
+	select PPC_INDIRECT_IO
+	select PPC_OF_PLATFORM_PCI
+	select HAS_TXX9_SERIAL
+	select PPC_UDBG_BEAT
+	select USB_OHCI_BIG_ENDIAN_MMIO
+	select USB_EHCI_BIG_ENDIAN_MMIO
+
 menu "Cell Broadband Engine options"
 	depends on PPC_CELL
 
Index: b/arch/powerpc/platforms/cell/celleb_pci.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ b/arch/powerpc/platforms/cell/celleb_pci.c	2008-03-13 17:57:55.000000000 +0900
@@ -0,0 +1,531 @@
+/*
+ * Support for PCI on Celleb platform.
+ *
+ * (C) Copyright 2006-2007 TOSHIBA CORPORATION
+ *
+ * This code is based on arch/powerpc/kernel/rtas_pci.c:
+ *  Copyright (C) 2001 Dave Engebretsen, IBM Corporation
+ *  Copyright (C) 2003 Anton Blanchard <anton@au.ibm.com>, IBM
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
+#include <linux/of.h>
+#include <linux/of_device.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/prom.h>
+#include <asm/pci-bridge.h>
+#include <asm/ppc-pci.h>
+
+#include "io-workarounds.h"
+#include "celleb_pci.h"
+
+#define MAX_PCI_DEVICES    32
+#define MAX_PCI_FUNCTIONS   8
+#define MAX_PCI_BASE_ADDRS  3 /* use 64 bit address */
+
+/* definition for fake pci configuration area for GbE, .... ,and etc. */
+
+struct celleb_pci_resource {
+	struct resource r[MAX_PCI_BASE_ADDRS];
+};
+
+struct celleb_pci_private {
+	unsigned char *fake_config[MAX_PCI_DEVICES][MAX_PCI_FUNCTIONS];
+	struct celleb_pci_resource *res[MAX_PCI_DEVICES][MAX_PCI_FUNCTIONS];
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
+	__le16 *p = addr;
+	return le16_to_cpu(*p);
+}
+
+static inline u32 celleb_fake_config_readl(void *addr)
+{
+	__le32 *p = addr;
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
+	__le16 val16;
+	__le16 *p = addr;
+	val16 = cpu_to_le16(val);
+	*p = val16;
+}
+
+static inline void celleb_fake_config_writel(u32 val, void *addr)
+{
+	__le32 val32;
+	__le32 *p = addr;
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
+static struct celleb_pci_resource *get_resource_start(
+				struct pci_controller *hose,
+				int devno, int fn)
+{
+	struct celleb_pci_private *private = hose->private_data;
+
+	if (private == NULL)
+		return NULL;
+
+	return private->res[devno][fn];
+}
+
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
+		unsigned int devfn, int where, int size, u32 val)
+{
+	char *config;
+	struct device_node *node;
+	struct pci_controller *hose;
+	struct celleb_pci_resource *res;
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
+			res = get_resource_start(hose, devno, fn);
+			if (!res)
+				return PCIBIOS_DEVICE_NOT_FOUND;
+			celleb_config_write_fake(config, where, size,
+					(res->r[i].end - res->r[i].start));
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
+	.read = celleb_fake_pci_read_config,
+	.write = celleb_fake_pci_write_config,
+};
+
+static inline void celleb_setup_pci_base_addrs(struct pci_controller *hose,
+					unsigned int devno, unsigned int fn,
+					unsigned int num_base_addr)
+{
+	u32 val;
+	unsigned char *config;
+	struct celleb_pci_resource *res;
+
+	config = get_fake_config_start(hose, devno, fn);
+	res = get_resource_start(hose, devno, fn);
+
+	if (!config || !res)
+		return;
+
+	switch (num_base_addr) {
+	case 3:
+		val = (res->r[2].start & 0xfffffff0)
+		    | PCI_BASE_ADDRESS_MEM_TYPE_64;
+		celleb_config_write_fake(config, PCI_BASE_ADDRESS_4, 4, val);
+		val = res->r[2].start >> 32;
+		celleb_config_write_fake(config, PCI_BASE_ADDRESS_5, 4, val);
+		/* FALLTHROUGH */
+	case 2:
+		val = (res->r[1].start & 0xfffffff0)
+		    | PCI_BASE_ADDRESS_MEM_TYPE_64;
+		celleb_config_write_fake(config, PCI_BASE_ADDRESS_2, 4, val);
+		val = res->r[1].start >> 32;
+		celleb_config_write_fake(config, PCI_BASE_ADDRESS_3, 4, val);
+		/* FALLTHROUGH */
+	case 1:
+		val = (res->r[0].start & 0xfffffff0)
+		    | PCI_BASE_ADDRESS_MEM_TYPE_64;
+		celleb_config_write_fake(config, PCI_BASE_ADDRESS_0, 4, val);
+		val = res->r[0].start >> 32;
+		celleb_config_write_fake(config, PCI_BASE_ADDRESS_1, 4, val);
+		break;
+	}
+
+	val = PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER;
+	celleb_config_write_fake(config, PCI_COMMAND, 2, val);
+}
+
+static int __init celleb_setup_fake_pci_device(struct device_node *node,
+					       struct pci_controller *hose)
+{
+	unsigned int rlen;
+	int num_base_addr = 0;
+	u32 val;
+	const u32 *wi0, *wi1, *wi2, *wi3, *wi4;
+	unsigned int devno, fn;
+	struct celleb_pci_private *private = hose->private_data;
+	unsigned char **config = NULL;
+	struct celleb_pci_resource **res = NULL;
+	const char *name;
+	const unsigned long *li;
+	int size, result;
+
+	if (private == NULL) {
+		printk(KERN_ERR "PCI: "
+		       "memory space for pci controller is not assigned\n");
+		goto error;
+	}
+
+	name = of_get_property(node, "model", &rlen);
+	if (!name) {
+		printk(KERN_ERR "PCI: model property not found.\n");
+		goto error;
+	}
+
+	wi4 = of_get_property(node, "reg", &rlen);
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
+	*config = alloc_maybe_bootmem(size, GFP_KERNEL);
+	if (*config == NULL) {
+		printk(KERN_ERR "PCI: "
+		       "not enough memory for fake configuration space\n");
+		goto error;
+	}
+	pr_debug("PCI: fake config area assigned 0x%016lx\n",
+		 (unsigned long)*config);
+
+	size = sizeof(struct celleb_pci_resource);
+	res = &private->res[devno][fn];
+	*res = alloc_maybe_bootmem(size, GFP_KERNEL);
+	if (*res == NULL) {
+		printk(KERN_ERR
+		       "PCI: not enough memory for resource data space\n");
+		goto error;
+	}
+	pr_debug("PCI: res assigned 0x%016lx\n", (unsigned long)*res);
+
+	wi0 = of_get_property(node, "device-id", NULL);
+	wi1 = of_get_property(node, "vendor-id", NULL);
+	wi2 = of_get_property(node, "class-code", NULL);
+	wi3 = of_get_property(node, "revision-id", NULL);
+	if (!wi0 || !wi1 || !wi2 || !wi3) {
+		printk(KERN_ERR "PCI: Missing device tree properties.\n");
+		goto error;
+	}
+
+	celleb_config_write_fake(*config, PCI_DEVICE_ID, 2, wi0[0] & 0xffff);
+	celleb_config_write_fake(*config, PCI_VENDOR_ID, 2, wi1[0] & 0xffff);
+	pr_debug("class-code = 0x%08x\n", wi2[0]);
+
+	celleb_config_write_fake(*config, PCI_CLASS_PROG, 1, wi2[0] & 0xff);
+	celleb_config_write_fake(*config, PCI_CLASS_DEVICE, 2,
+				 (wi2[0] >> 8) & 0xffff);
+	celleb_config_write_fake(*config, PCI_REVISION_ID, 1, wi3[0]);
+
+	while (num_base_addr < MAX_PCI_BASE_ADDRS) {
+		result = of_address_to_resource(node,
+				num_base_addr, &(*res)->r[num_base_addr]);
+		if (result)
+			break;
+		num_base_addr++;
+	}
+
+	celleb_setup_pci_base_addrs(hose, devno, fn, num_base_addr);
+
+	li = of_get_property(node, "interrupts", &rlen);
+	if (!li) {
+		printk(KERN_ERR "PCI: interrupts not found.\n");
+		goto error;
+	}
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
+		if (res && *res)
+			kfree(*res);
+
+	} else {
+		if (config && *config) {
+			size = 256;
+			free_bootmem((unsigned long)(*config), size);
+		}
+		if (res && *res) {
+			size = sizeof(struct celleb_pci_resource);
+			free_bootmem((unsigned long)(*res), size);
+		}
+	}
+
+	return 1;
+}
+
+static int __init phb_set_bus_ranges(struct device_node *dev,
+				     struct pci_controller *phb)
+{
+	const int *bus_range;
+	unsigned int len;
+
+	bus_range = of_get_property(dev, "bus-range", &len);
+	if (bus_range == NULL || len < 2 * sizeof(int))
+		return 1;
+
+	phb->first_busno = bus_range[0];
+	phb->last_busno = bus_range[1];
+
+	return 0;
+}
+
+static void __init celleb_alloc_private_mem(struct pci_controller *hose)
+{
+	hose->private_data =
+		alloc_maybe_bootmem(sizeof(struct celleb_pci_private),
+			GFP_KERNEL);
+}
+
+static int __init celleb_setup_fake_pci(struct device_node *dev,
+					struct pci_controller *phb)
+{
+	struct device_node *node;
+
+	phb->ops = &celleb_fake_pci_ops;
+	celleb_alloc_private_mem(phb);
+
+	for (node = of_get_next_child(dev, NULL);
+	     node != NULL; node = of_get_next_child(dev, node))
+		celleb_setup_fake_pci_device(node, phb);
+
+	return 0;
+}
+
+static struct of_device_id celleb_phb_match[] __initdata = {
+	{
+		.name = "pci-pseudo",
+		.data = celleb_setup_fake_pci,
+	}, {
+		.name = "epci",
+		.data = celleb_setup_epci,
+	}, {
+	},
+};
+
+int __init celleb_setup_phb(struct pci_controller *phb)
+{
+	struct device_node *dev = phb->dn;
+	const struct of_device_id *match;
+	int (*setup_func)(struct device_node *, struct pci_controller *);
+
+	match = of_match_node(celleb_phb_match, dev);
+	if (!match)
+		return 1;
+
+	phb_set_bus_ranges(dev, phb);
+	phb->buid = 1;
+
+	setup_func = match->data;
+	return (*setup_func)(dev, phb);
+}
+
+int celleb_pci_probe_mode(struct pci_bus *bus)
+{
+	return PCI_PROBE_DEVTREE;
+}
+
+struct celleb_iowa_bus_param {
+	struct ppc_pci_io *ops;
+	int (*init)(struct iowa_bus *, void *);
+	void *data;
+};
+
+static struct of_device_id celleb_io_workaround_match[] __initdata = {
+	{
+		.name = "epci",
+		.data = &(struct celleb_iowa_bus_param){
+			.ops = &spiderpci_ops,
+			.init = &spiderpci_iowa_init,
+			.data = (void *)0,
+		},
+	}, {
+	},
+};
+
+int __init celleb_io_workaround_init(void)
+{
+	struct pci_controller *phb;
+	struct device_node *node;
+	struct celleb_iowa_bus_param *param;
+	const struct  of_device_id *match;
+
+	list_for_each_entry(phb, &hose_list, list_node) {
+		node = phb->dn;
+		match = of_match_node(celleb_io_workaround_match, node);
+
+		if (match) {
+			param = match->data;
+			iowa_register_bus(phb, param->ops, param->init,
+					  param->data);
+		}
+	}
+
+	io_workaround_init();
+
+	return 0;
+}
Index: b/arch/powerpc/platforms/cell/celleb_pci.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ b/arch/powerpc/platforms/cell/celleb_pci.h	2008-03-13 17:57:55.000000000 +0900
@@ -0,0 +1,39 @@
+/*
+ * pci prototypes for Celleb platform
+ *
+ * (C) Copyright 2006-2007 TOSHIBA CORPORATION
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
+#include <asm/ppc-pci.h>
+
+#include "io-workarounds.h"
+
+extern int celleb_setup_phb(struct pci_controller *);
+extern int celleb_pci_probe_mode(struct pci_bus *);
+
+extern int celleb_setup_epci(struct device_node *, struct pci_controller *);
+extern int __init celleb_io_workaround_init(void);
+
+
+#endif /* _CELLEB_PCI_H */
Index: b/arch/powerpc/platforms/cell/celleb_setup.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ b/arch/powerpc/platforms/cell/celleb_setup.c	2008-03-13 17:57:55.000000000 +0900
@@ -0,0 +1,259 @@
+/*
+ * Celleb setup code
+ *
+ * (C) Copyright 2006-2007 TOSHIBA CORPORATION
+ *
+ * This code is based on arch/powerpc/platforms/cell/setup.c:
+ *  Copyright (C) 1995  Linus Torvalds
+ *  Adapted from 'alpha' version by Gary Thomas
+ *  Modified by Cort Dougan (cort@cs.nmt.edu)
+ *  Modified by PPC64 Team, IBM Corp
+ *  Modified by Cell Team, IBM Deutschland Entwicklung GmbH
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
+#include <linux/cpu.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/stddef.h>
+#include <linux/unistd.h>
+#include <linux/reboot.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/seq_file.h>
+#include <linux/root_dev.h>
+#include <linux/console.h>
+#include <linux/of_platform.h>
+
+#include <asm/mmu.h>
+#include <asm/processor.h>
+#include <asm/io.h>
+#include <asm/kexec.h>
+#include <asm/prom.h>
+#include <asm/machdep.h>
+#include <asm/cputable.h>
+#include <asm/irq.h>
+#include <asm/time.h>
+#include <asm/spu_priv1.h>
+#include <asm/firmware.h>
+#include <asm/rtas.h>
+#include <asm/cell-regs.h>
+
+#include "../celleb/interrupt.h"
+#include "../celleb/beat_wrapper.h"
+#include "../celleb/beat.h"
+#include "celleb_pci.h"
+#include "interrupt.h"
+#include "pervasive.h"
+#include "ras.h"
+
+static char celleb_machine_type[128] = "Celleb";
+
+static void celleb_show_cpuinfo(struct seq_file *m)
+{
+	struct device_node *root;
+	const char *model = "";
+
+	root = of_find_node_by_path("/");
+	if (root)
+		model = of_get_property(root, "model", NULL);
+	/* using "CHRP" is to trick anaconda into installing FCx into Celleb */
+	seq_printf(m, "machine\t\t: %s %s\n", celleb_machine_type, model);
+	of_node_put(root);
+}
+
+static int __init celleb_machine_type_hack(char *ptr)
+{
+	strncpy(celleb_machine_type, ptr, sizeof(celleb_machine_type));
+	celleb_machine_type[sizeof(celleb_machine_type)-1] = 0;
+	return 0;
+}
+
+__setup("celleb_machine_type_hack=", celleb_machine_type_hack);
+
+static void celleb_progress(char *s, unsigned short hex)
+{
+	printk("*** %04x : %s\n", hex, s ? s : "");
+}
+
+static void __init celleb_setup_arch_common(void)
+{
+	/* init to some ~sane value until calibrate_delay() runs */
+	loops_per_jiffy = 50000000;
+
+#ifdef CONFIG_DUMMY_CONSOLE
+	conswitchp = &dummy_con;
+#endif
+}
+
+static struct of_device_id celleb_bus_ids[] __initdata = {
+	{ .type = "scc", },
+	{ .type = "ioif", },	/* old style */
+	{},
+};
+
+static int __init celleb_publish_devices(void)
+{
+	/* Publish OF platform devices for southbridge IOs */
+	of_platform_bus_probe(NULL, celleb_bus_ids, NULL);
+
+	/* Setup io-workaround for pci busses */
+	celleb_io_workaround_init();
+
+	return 0;
+}
+machine_device_initcall(celleb_beat, celleb_publish_devices);
+machine_device_initcall(celleb_native, celleb_publish_devices);
+
+
+/*
+ * functions for Celleb-Beat
+ */
+static void __init celleb_setup_arch_beat(void)
+{
+#ifdef CONFIG_SPU_BASE
+	spu_priv1_ops		= &spu_priv1_beat_ops;
+	spu_management_ops	= &spu_management_of_ops;
+#endif
+
+#ifdef CONFIG_SMP
+	smp_init_celleb();
+#endif
+
+	celleb_setup_arch_common();
+}
+
+static int __init celleb_probe_beat(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (!of_flat_dt_is_compatible(root, "Beat"))
+		return 0;
+
+	powerpc_firmware_features |= FW_FEATURE_CELLEB_ALWAYS
+		| FW_FEATURE_BEAT | FW_FEATURE_LPAR;
+	hpte_init_beat_v3();
+
+	return 1;
+}
+
+
+/*
+ * functions for Celleb-native
+ */
+static void __init celleb_init_IRQ_native(void)
+{
+	iic_init_IRQ();
+	spider_init_IRQ();
+}
+
+static void __init celleb_setup_arch_native(void)
+{
+#ifdef CONFIG_SPU_BASE
+	spu_priv1_ops		= &spu_priv1_mmio_ops;
+	spu_management_ops	= &spu_management_of_ops;
+#endif
+
+	cbe_regs_init();
+
+#ifdef CONFIG_CBE_RAS
+	cbe_ras_init();
+#endif
+
+#ifdef CONFIG_SMP
+	smp_init_cell();
+#endif
+
+	cbe_pervasive_init();
+
+	/* XXX: nvram initialization should be added */
+
+	celleb_setup_arch_common();
+}
+
+static int __init celleb_probe_native(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (of_flat_dt_is_compatible(root, "Beat") ||
+	    !of_flat_dt_is_compatible(root, "TOSHIBA,Celleb"))
+		return 0;
+
+	powerpc_firmware_features |= FW_FEATURE_CELLEB_ALWAYS;
+	hpte_init_native();
+
+	return 1;
+}
+
+
+/*
+ * machine definitions
+ */
+define_machine(celleb_beat) {
+	.name			= "Cell Reference Set (Beat)",
+	.probe			= celleb_probe_beat,
+	.setup_arch		= celleb_setup_arch_beat,
+	.show_cpuinfo		= celleb_show_cpuinfo,
+	.restart		= beat_restart,
+	.power_off		= beat_power_off,
+	.halt			= beat_halt,
+	.get_rtc_time		= beat_get_rtc_time,
+	.set_rtc_time		= beat_set_rtc_time,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= celleb_progress,
+	.power_save		= beat_power_save,
+	.nvram_size		= beat_nvram_get_size,
+	.nvram_read		= beat_nvram_read,
+	.nvram_write		= beat_nvram_write,
+	.set_dabr		= beat_set_xdabr,
+	.init_IRQ		= beatic_init_IRQ,
+	.get_irq		= beatic_get_irq,
+	.pci_probe_mode 	= celleb_pci_probe_mode,
+	.pci_setup_phb		= celleb_setup_phb,
+#ifdef CONFIG_KEXEC
+	.kexec_cpu_down		= beat_kexec_cpu_down,
+	.machine_kexec		= default_machine_kexec,
+	.machine_kexec_prepare	= default_machine_kexec_prepare,
+	.machine_crash_shutdown	= default_machine_crash_shutdown,
+#endif
+};
+
+define_machine(celleb_native) {
+	.name			= "Cell Reference Set (native)",
+	.probe			= celleb_probe_native,
+	.setup_arch		= celleb_setup_arch_native,
+	.show_cpuinfo		= celleb_show_cpuinfo,
+	.restart		= rtas_restart,
+	.power_off		= rtas_power_off,
+	.halt			= rtas_halt,
+	.get_boot_time		= rtas_get_boot_time,
+	.get_rtc_time		= rtas_get_rtc_time,
+	.set_rtc_time		= rtas_set_rtc_time,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= celleb_progress,
+	.pci_probe_mode 	= celleb_pci_probe_mode,
+	.pci_setup_phb		= celleb_setup_phb,
+	.init_IRQ		= celleb_init_IRQ_native,
+#ifdef CONFIG_KEXEC
+	.machine_kexec		= default_machine_kexec,
+	.machine_kexec_prepare	= default_machine_kexec_prepare,
+	.machine_crash_shutdown	= default_machine_crash_shutdown,
+#endif
+};
Index: b/arch/powerpc/platforms/celleb/Makefile
===================================================================
--- a/arch/powerpc/platforms/celleb/Makefile	2008-03-13 17:57:52.000000000 +0900
+++ b/arch/powerpc/platforms/celleb/Makefile	2008-03-13 17:57:55.000000000 +0900
@@ -1,5 +1,5 @@
-obj-y				+= interrupt.o iommu.o setup.o \
-				   htab.o beat.o hvCall.o pci.o \
+obj-y				+= interrupt.o iommu.o \
+				   htab.o beat.o hvCall.o \
 				   scc_epci.o scc_uhc.o
 
 obj-$(CONFIG_SMP)		+= smp.o
Index: b/arch/powerpc/platforms/celleb/pci.c
===================================================================
--- a/arch/powerpc/platforms/celleb/pci.c	2008-03-13 17:57:52.000000000 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,533 +0,0 @@
-/*
- * Support for PCI on Celleb platform.
- *
- * (C) Copyright 2006-2007 TOSHIBA CORPORATION
- *
- * This code is based on arch/powerpc/kernel/rtas_pci.c:
- *  Copyright (C) 2001 Dave Engebretsen, IBM Corporation
- *  Copyright (C) 2003 Anton Blanchard <anton@au.ibm.com>, IBM
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-#undef DEBUG
-
-#include <linux/kernel.h>
-#include <linux/threads.h>
-#include <linux/pci.h>
-#include <linux/string.h>
-#include <linux/init.h>
-#include <linux/bootmem.h>
-#include <linux/pci_regs.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
-
-#include <asm/io.h>
-#include <asm/irq.h>
-#include <asm/prom.h>
-#include <asm/machdep.h>
-#include <asm/pci-bridge.h>
-#include <asm/ppc-pci.h>
-
-#include "../cell/io-workarounds.h"
-#include "pci.h"
-#include "interrupt.h"
-
-#define MAX_PCI_DEVICES    32
-#define MAX_PCI_FUNCTIONS   8
-#define MAX_PCI_BASE_ADDRS  3 /* use 64 bit address */
-
-/* definition for fake pci configuration area for GbE, .... ,and etc. */
-
-struct celleb_pci_resource {
-	struct resource r[MAX_PCI_BASE_ADDRS];
-};
-
-struct celleb_pci_private {
-	unsigned char *fake_config[MAX_PCI_DEVICES][MAX_PCI_FUNCTIONS];
-	struct celleb_pci_resource *res[MAX_PCI_DEVICES][MAX_PCI_FUNCTIONS];
-};
-
-static inline u8 celleb_fake_config_readb(void *addr)
-{
-	u8 *p = addr;
-	return *p;
-}
-
-static inline u16 celleb_fake_config_readw(void *addr)
-{
-	__le16 *p = addr;
-	return le16_to_cpu(*p);
-}
-
-static inline u32 celleb_fake_config_readl(void *addr)
-{
-	__le32 *p = addr;
-	return le32_to_cpu(*p);
-}
-
-static inline void celleb_fake_config_writeb(u32 val, void *addr)
-{
-	u8 *p = addr;
-	*p = val;
-}
-
-static inline void celleb_fake_config_writew(u32 val, void *addr)
-{
-	__le16 val16;
-	__le16 *p = addr;
-	val16 = cpu_to_le16(val);
-	*p = val16;
-}
-
-static inline void celleb_fake_config_writel(u32 val, void *addr)
-{
-	__le32 val32;
-	__le32 *p = addr;
-	val32 = cpu_to_le32(val);
-	*p = val32;
-}
-
-static unsigned char *get_fake_config_start(struct pci_controller *hose,
-					    int devno, int fn)
-{
-	struct celleb_pci_private *private = hose->private_data;
-
-	if (private == NULL)
-		return NULL;
-
-	return private->fake_config[devno][fn];
-}
-
-static struct celleb_pci_resource *get_resource_start(
-				struct pci_controller *hose,
-				int devno, int fn)
-{
-	struct celleb_pci_private *private = hose->private_data;
-
-	if (private == NULL)
-		return NULL;
-
-	return private->res[devno][fn];
-}
-
-
-static void celleb_config_read_fake(unsigned char *config, int where,
-				    int size, u32 *val)
-{
-	char *p = config + where;
-
-	switch (size) {
-	case 1:
-		*val = celleb_fake_config_readb(p);
-		break;
-	case 2:
-		*val = celleb_fake_config_readw(p);
-		break;
-	case 4:
-		*val = celleb_fake_config_readl(p);
-		break;
-	}
-}
-
-static void celleb_config_write_fake(unsigned char *config, int where,
-				     int size, u32 val)
-{
-	char *p = config + where;
-
-	switch (size) {
-	case 1:
-		celleb_fake_config_writeb(val, p);
-		break;
-	case 2:
-		celleb_fake_config_writew(val, p);
-		break;
-	case 4:
-		celleb_fake_config_writel(val, p);
-		break;
-	}
-}
-
-static int celleb_fake_pci_read_config(struct pci_bus *bus,
-		unsigned int devfn, int where, int size, u32 *val)
-{
-	char *config;
-	struct device_node *node;
-	struct pci_controller *hose;
-	unsigned int devno = devfn >> 3;
-	unsigned int fn = devfn & 0x7;
-
-	/* allignment check */
-	BUG_ON(where % size);
-
-	pr_debug("    fake read: bus=0x%x, ", bus->number);
-	node = (struct device_node *)bus->sysdata;
-	hose = pci_find_hose_for_OF_device(node);
-	config = get_fake_config_start(hose, devno, fn);
-
-	pr_debug("devno=0x%x, where=0x%x, size=0x%x, ", devno, where, size);
-	if (!config) {
-		pr_debug("failed\n");
-		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
-
-	celleb_config_read_fake(config, where, size, val);
-	pr_debug("val=0x%x\n", *val);
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-
-static int celleb_fake_pci_write_config(struct pci_bus *bus,
-		 unsigned int devfn, int where, int size, u32 val)
-{
-	char *config;
-	struct device_node *node;
-	struct pci_controller *hose;
-	struct celleb_pci_resource *res;
-	unsigned int devno = devfn >> 3;
-	unsigned int fn = devfn & 0x7;
-
-	/* allignment check */
-	BUG_ON(where % size);
-
-	node = (struct device_node *)bus->sysdata;
-	hose = pci_find_hose_for_OF_device(node);
-	config = get_fake_config_start(hose, devno, fn);
-
-	if (!config)
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	if (val == ~0) {
-		int i = (where - PCI_BASE_ADDRESS_0) >> 3;
-
-		switch (where) {
-		case PCI_BASE_ADDRESS_0:
-		case PCI_BASE_ADDRESS_2:
-			if (size != 4)
-				return PCIBIOS_DEVICE_NOT_FOUND;
-			res = get_resource_start(hose, devno, fn);
-			if (!res)
-				return PCIBIOS_DEVICE_NOT_FOUND;
-			celleb_config_write_fake(config, where, size,
-					(res->r[i].end - res->r[i].start));
-			return PCIBIOS_SUCCESSFUL;
-		case PCI_BASE_ADDRESS_1:
-		case PCI_BASE_ADDRESS_3:
-		case PCI_BASE_ADDRESS_4:
-		case PCI_BASE_ADDRESS_5:
-			break;
-		default:
-			break;
-		}
-	}
-
-	celleb_config_write_fake(config, where, size, val);
-	pr_debug("    fake write: where=%x, size=%d, val=%x\n",
-		 where, size, val);
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static struct pci_ops celleb_fake_pci_ops = {
-	.read = celleb_fake_pci_read_config,
-	.write = celleb_fake_pci_write_config,
-};
-
-static inline void celleb_setup_pci_base_addrs(struct pci_controller *hose,
-					unsigned int devno, unsigned int fn,
-					unsigned int num_base_addr)
-{
-	u32 val;
-	unsigned char *config;
-	struct celleb_pci_resource *res;
-
-	config = get_fake_config_start(hose, devno, fn);
-	res = get_resource_start(hose, devno, fn);
-
-	if (!config || !res)
-		return;
-
-	switch (num_base_addr) {
-	case 3:
-		val = (res->r[2].start & 0xfffffff0)
-		    | PCI_BASE_ADDRESS_MEM_TYPE_64;
-		celleb_config_write_fake(config, PCI_BASE_ADDRESS_4, 4, val);
-		val = res->r[2].start >> 32;
-		celleb_config_write_fake(config, PCI_BASE_ADDRESS_5, 4, val);
-		/* FALLTHROUGH */
-	case 2:
-		val = (res->r[1].start & 0xfffffff0)
-		    | PCI_BASE_ADDRESS_MEM_TYPE_64;
-		celleb_config_write_fake(config, PCI_BASE_ADDRESS_2, 4, val);
-		val = res->r[1].start >> 32;
-		celleb_config_write_fake(config, PCI_BASE_ADDRESS_3, 4, val);
-		/* FALLTHROUGH */
-	case 1:
-		val = (res->r[0].start & 0xfffffff0)
-		    | PCI_BASE_ADDRESS_MEM_TYPE_64;
-		celleb_config_write_fake(config, PCI_BASE_ADDRESS_0, 4, val);
-		val = res->r[0].start >> 32;
-		celleb_config_write_fake(config, PCI_BASE_ADDRESS_1, 4, val);
-		break;
-	}
-
-	val = PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER;
-	celleb_config_write_fake(config, PCI_COMMAND, 2, val);
-}
-
-static int __init celleb_setup_fake_pci_device(struct device_node *node,
-					       struct pci_controller *hose)
-{
-	unsigned int rlen;
-	int num_base_addr = 0;
-	u32 val;
-	const u32 *wi0, *wi1, *wi2, *wi3, *wi4;
-	unsigned int devno, fn;
-	struct celleb_pci_private *private = hose->private_data;
-	unsigned char **config = NULL;
-	struct celleb_pci_resource **res = NULL;
-	const char *name;
-	const unsigned long *li;
-	int size, result;
-
-	if (private == NULL) {
-		printk(KERN_ERR "PCI: "
-		       "memory space for pci controller is not assigned\n");
-		goto error;
-	}
-
-	name = of_get_property(node, "model", &rlen);
-	if (!name) {
-		printk(KERN_ERR "PCI: model property not found.\n");
-		goto error;
-	}
-
-	wi4 = of_get_property(node, "reg", &rlen);
-	if (wi4 == NULL)
-		goto error;
-
-	devno = ((wi4[0] >> 8) & 0xff) >> 3;
-	fn = (wi4[0] >> 8) & 0x7;
-
-	pr_debug("PCI: celleb_setup_fake_pci() %s devno=%x fn=%x\n", name,
-		 devno, fn);
-
-	size = 256;
-	config = &private->fake_config[devno][fn];
-	*config = alloc_maybe_bootmem(size, GFP_KERNEL);
-	if (*config == NULL) {
-		printk(KERN_ERR "PCI: "
-		       "not enough memory for fake configuration space\n");
-		goto error;
-	}
-	pr_debug("PCI: fake config area assigned 0x%016lx\n",
-		 (unsigned long)*config);
-
-	size = sizeof(struct celleb_pci_resource);
-	res = &private->res[devno][fn];
-	*res = alloc_maybe_bootmem(size, GFP_KERNEL);
-	if (*res == NULL) {
-		printk(KERN_ERR
-		       "PCI: not enough memory for resource data space\n");
-		goto error;
-	}
-	pr_debug("PCI: res assigned 0x%016lx\n", (unsigned long)*res);
-
-	wi0 = of_get_property(node, "device-id", NULL);
-	wi1 = of_get_property(node, "vendor-id", NULL);
-	wi2 = of_get_property(node, "class-code", NULL);
-	wi3 = of_get_property(node, "revision-id", NULL);
-	if (!wi0 || !wi1 || !wi2 || !wi3) {
-		printk(KERN_ERR "PCI: Missing device tree properties.\n");
-		goto error;
-	}
-
-	celleb_config_write_fake(*config, PCI_DEVICE_ID, 2, wi0[0] & 0xffff);
-	celleb_config_write_fake(*config, PCI_VENDOR_ID, 2, wi1[0] & 0xffff);
-	pr_debug("class-code = 0x%08x\n", wi2[0]);
-
-	celleb_config_write_fake(*config, PCI_CLASS_PROG, 1, wi2[0] & 0xff);
-	celleb_config_write_fake(*config, PCI_CLASS_DEVICE, 2,
-				 (wi2[0] >> 8) & 0xffff);
-	celleb_config_write_fake(*config, PCI_REVISION_ID, 1, wi3[0]);
-
-	while (num_base_addr < MAX_PCI_BASE_ADDRS) {
-		result = of_address_to_resource(node,
-				num_base_addr, &(*res)->r[num_base_addr]);
-		if (result)
-			break;
-		num_base_addr++;
-	}
-
-	celleb_setup_pci_base_addrs(hose, devno, fn, num_base_addr);
-
-	li = of_get_property(node, "interrupts", &rlen);
-	if (!li) {
-		printk(KERN_ERR "PCI: interrupts not found.\n");
-		goto error;
-	}
-	val = li[0];
-	celleb_config_write_fake(*config, PCI_INTERRUPT_PIN, 1, 1);
-	celleb_config_write_fake(*config, PCI_INTERRUPT_LINE, 1, val);
-
-#ifdef DEBUG
-	pr_debug("PCI: %s irq=%ld\n", name, li[0]);
-	for (i = 0; i < 6; i++) {
-		celleb_config_read_fake(*config,
-					PCI_BASE_ADDRESS_0 + 0x4 * i, 4,
-					&val);
-		pr_debug("PCI: %s fn=%d base_address_%d=0x%x\n",
-			 name, fn, i, val);
-	}
-#endif
-
-	celleb_config_write_fake(*config, PCI_HEADER_TYPE, 1,
-				 PCI_HEADER_TYPE_NORMAL);
-
-	return 0;
-
-error:
-	if (mem_init_done) {
-		if (config && *config)
-			kfree(*config);
-		if (res && *res)
-			kfree(*res);
-
-	} else {
-		if (config && *config) {
-			size = 256;
-			free_bootmem((unsigned long)(*config), size);
-		}
-		if (res && *res) {
-			size = sizeof(struct celleb_pci_resource);
-			free_bootmem((unsigned long)(*res), size);
-		}
-	}
-
-	return 1;
-}
-
-static int __init phb_set_bus_ranges(struct device_node *dev,
-				     struct pci_controller *phb)
-{
-	const int *bus_range;
-	unsigned int len;
-
-	bus_range = of_get_property(dev, "bus-range", &len);
-	if (bus_range == NULL || len < 2 * sizeof(int))
-		return 1;
-
-	phb->first_busno = bus_range[0];
-	phb->last_busno = bus_range[1];
-
-	return 0;
-}
-
-static void __init celleb_alloc_private_mem(struct pci_controller *hose)
-{
-	hose->private_data =
-		alloc_maybe_bootmem(sizeof(struct celleb_pci_private),
-			GFP_KERNEL);
-}
-
-static int __init celleb_setup_fake_pci(struct device_node *dev,
-					struct pci_controller *phb)
-{
-	struct device_node *node;
-
-	phb->ops = &celleb_fake_pci_ops;
-	celleb_alloc_private_mem(phb);
-
-	for (node = of_get_next_child(dev, NULL);
-	     node != NULL; node = of_get_next_child(dev, node))
-		celleb_setup_fake_pci_device(node, phb);
-
-	return 0;
-}
-
-static struct of_device_id celleb_phb_match[] __initdata = {
-	{
-		.name = "pci-pseudo",
-		.data = celleb_setup_fake_pci,
-	}, {
-		.name = "epci",
-		.data = celleb_setup_epci,
-	}, {
-	},
-};
-
-int __init celleb_setup_phb(struct pci_controller *phb)
-{
-	struct device_node *dev = phb->dn;
-	const struct of_device_id *match;
-	int (*setup_func)(struct device_node *, struct pci_controller *);
-
-	match = of_match_node(celleb_phb_match, dev);
-	if (!match)
-		return 1;
-
-	phb_set_bus_ranges(dev, phb);
-	phb->buid = 1;
-
-	setup_func = match->data;
-	return (*setup_func)(dev, phb);
-}
-
-int celleb_pci_probe_mode(struct pci_bus *bus)
-{
-	return PCI_PROBE_DEVTREE;
-}
-
-struct celleb_iowa_bus_param {
-	struct ppc_pci_io *ops;
-	int (*init)(struct iowa_bus *, void *);
-	void *data;
-};
-
-static struct of_device_id celleb_io_workaround_match[] __initdata = {
-	{
-		.name = "epci",
-		.data = &(struct celleb_iowa_bus_param){
-			.ops = &spiderpci_ops,
-			.init = &spiderpci_iowa_init,
-			.data = (void *)0,
-		},
-	}, {
-	},
-};
-
-int __init celleb_io_workaround_init(void)
-{
-	struct pci_controller *phb;
-	struct device_node *node;
-	struct celleb_iowa_bus_param *param;
-	const struct  of_device_id *match;
-
-	list_for_each_entry(phb, &hose_list, list_node) {
-		node = phb->dn;
-		match = of_match_node(celleb_io_workaround_match, node);
-
-		if (match) {
-			param = match->data;
-			iowa_register_bus(phb, param->ops, param->init,
-					  param->data);
-		}
-	}
-
-	io_workaround_init();
-
-	return 0;
-}
Index: b/arch/powerpc/platforms/celleb/pci.h
===================================================================
--- a/arch/powerpc/platforms/celleb/pci.h	2008-03-13 17:57:52.000000000 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,39 +0,0 @@
-/*
- * pci prototypes for Celleb platform
- *
- * (C) Copyright 2006-2007 TOSHIBA CORPORATION
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-#ifndef _CELLEB_PCI_H
-#define _CELLEB_PCI_H
-
-#include <linux/pci.h>
-
-#include <asm/pci-bridge.h>
-#include <asm/prom.h>
-#include <asm/ppc-pci.h>
-
-#include "../cell/io-workarounds.h"
-
-extern int celleb_setup_phb(struct pci_controller *);
-extern int celleb_pci_probe_mode(struct pci_bus *);
-
-extern int celleb_setup_epci(struct device_node *, struct pci_controller *);
-extern int __init celleb_io_workaround_init(void);
-
-
-#endif /* _CELLEB_PCI_H */
Index: b/arch/powerpc/platforms/celleb/scc_epci.c
===================================================================
--- a/arch/powerpc/platforms/celleb/scc_epci.c	2008-03-13 17:57:52.000000000 +0900
+++ b/arch/powerpc/platforms/celleb/scc_epci.c	2008-03-13 17:57:55.000000000 +0900
@@ -35,7 +35,7 @@
 #include <asm/ppc-pci.h>
 
 #include "scc.h"
-#include "pci.h"
+#include "../cell/celleb_pci.h"
 #include "interrupt.h"
 
 #define MAX_PCI_DEVICES   32
Index: b/arch/powerpc/platforms/celleb/setup.c
===================================================================
--- a/arch/powerpc/platforms/celleb/setup.c	2008-03-13 17:57:52.000000000 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,259 +0,0 @@
-/*
- * Celleb setup code
- *
- * (C) Copyright 2006-2007 TOSHIBA CORPORATION
- *
- * This code is based on arch/powerpc/platforms/cell/setup.c:
- *  Copyright (C) 1995  Linus Torvalds
- *  Adapted from 'alpha' version by Gary Thomas
- *  Modified by Cort Dougan (cort@cs.nmt.edu)
- *  Modified by PPC64 Team, IBM Corp
- *  Modified by Cell Team, IBM Deutschland Entwicklung GmbH
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-#undef DEBUG
-
-#include <linux/cpu.h>
-#include <linux/sched.h>
-#include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/stddef.h>
-#include <linux/unistd.h>
-#include <linux/reboot.h>
-#include <linux/init.h>
-#include <linux/delay.h>
-#include <linux/irq.h>
-#include <linux/seq_file.h>
-#include <linux/root_dev.h>
-#include <linux/console.h>
-#include <linux/of_platform.h>
-
-#include <asm/mmu.h>
-#include <asm/processor.h>
-#include <asm/io.h>
-#include <asm/kexec.h>
-#include <asm/prom.h>
-#include <asm/machdep.h>
-#include <asm/cputable.h>
-#include <asm/irq.h>
-#include <asm/time.h>
-#include <asm/spu_priv1.h>
-#include <asm/firmware.h>
-#include <asm/rtas.h>
-#include <asm/cell-regs.h>
-
-#include "interrupt.h"
-#include "beat_wrapper.h"
-#include "beat.h"
-#include "pci.h"
-#include "../cell/interrupt.h"
-#include "../cell/pervasive.h"
-#include "../cell/ras.h"
-
-static char celleb_machine_type[128] = "Celleb";
-
-static void celleb_show_cpuinfo(struct seq_file *m)
-{
-	struct device_node *root;
-	const char *model = "";
-
-	root = of_find_node_by_path("/");
-	if (root)
-		model = of_get_property(root, "model", NULL);
-	/* using "CHRP" is to trick anaconda into installing FCx into Celleb */
-	seq_printf(m, "machine\t\t: %s %s\n", celleb_machine_type, model);
-	of_node_put(root);
-}
-
-static int __init celleb_machine_type_hack(char *ptr)
-{
-	strncpy(celleb_machine_type, ptr, sizeof(celleb_machine_type));
-	celleb_machine_type[sizeof(celleb_machine_type)-1] = 0;
-	return 0;
-}
-
-__setup("celleb_machine_type_hack=", celleb_machine_type_hack);
-
-static void celleb_progress(char *s, unsigned short hex)
-{
-	printk("*** %04x : %s\n", hex, s ? s : "");
-}
-
-static void __init celleb_setup_arch_common(void)
-{
-	/* init to some ~sane value until calibrate_delay() runs */
-	loops_per_jiffy = 50000000;
-
-#ifdef CONFIG_DUMMY_CONSOLE
-	conswitchp = &dummy_con;
-#endif
-}
-
-static struct of_device_id celleb_bus_ids[] __initdata = {
-	{ .type = "scc", },
-	{ .type = "ioif", },	/* old style */
-	{},
-};
-
-static int __init celleb_publish_devices(void)
-{
-	/* Publish OF platform devices for southbridge IOs */
-	of_platform_bus_probe(NULL, celleb_bus_ids, NULL);
-
-	/* Setup io-workaround for pci busses */
-	celleb_io_workaround_init();
-
-	return 0;
-}
-machine_device_initcall(celleb_beat, celleb_publish_devices);
-machine_device_initcall(celleb_native, celleb_publish_devices);
-
-
-/*
- * functions for Celleb-Beat
- */
-static void __init celleb_setup_arch_beat(void)
-{
-#ifdef CONFIG_SPU_BASE
-	spu_priv1_ops		= &spu_priv1_beat_ops;
-	spu_management_ops	= &spu_management_of_ops;
-#endif
-
-#ifdef CONFIG_SMP
-	smp_init_celleb();
-#endif
-
-	celleb_setup_arch_common();
-}
-
-static int __init celleb_probe_beat(void)
-{
-	unsigned long root = of_get_flat_dt_root();
-
-	if (!of_flat_dt_is_compatible(root, "Beat"))
-		return 0;
-
-	powerpc_firmware_features |= FW_FEATURE_CELLEB_ALWAYS
-		| FW_FEATURE_BEAT | FW_FEATURE_LPAR;
-	hpte_init_beat_v3();
-
-	return 1;
-}
-
-
-/*
- * functions for Celleb-native
- */
-static void __init celleb_init_IRQ_native(void)
-{
-	iic_init_IRQ();
-	spider_init_IRQ();
-}
-
-static void __init celleb_setup_arch_native(void)
-{
-#ifdef CONFIG_SPU_BASE
-	spu_priv1_ops		= &spu_priv1_mmio_ops;
-	spu_management_ops	= &spu_management_of_ops;
-#endif
-
-	cbe_regs_init();
-
-#ifdef CONFIG_CBE_RAS
-	cbe_ras_init();
-#endif
-
-#ifdef CONFIG_SMP
-	smp_init_cell();
-#endif
-
-	cbe_pervasive_init();
-
-	/* XXX: nvram initialization should be added */
-
-	celleb_setup_arch_common();
-}
-
-static int __init celleb_probe_native(void)
-{
-	unsigned long root = of_get_flat_dt_root();
-
-	if (of_flat_dt_is_compatible(root, "Beat") ||
-	    !of_flat_dt_is_compatible(root, "TOSHIBA,Celleb"))
-		return 0;
-
-	powerpc_firmware_features |= FW_FEATURE_CELLEB_ALWAYS;
-	hpte_init_native();
-
-	return 1;
-}
-
-
-/*
- * machine definitions
- */
-define_machine(celleb_beat) {
-	.name			= "Cell Reference Set (Beat)",
-	.probe			= celleb_probe_beat,
-	.setup_arch		= celleb_setup_arch_beat,
-	.show_cpuinfo		= celleb_show_cpuinfo,
-	.restart		= beat_restart,
-	.power_off		= beat_power_off,
-	.halt			= beat_halt,
-	.get_rtc_time		= beat_get_rtc_time,
-	.set_rtc_time		= beat_set_rtc_time,
-	.calibrate_decr		= generic_calibrate_decr,
-	.progress		= celleb_progress,
-	.power_save		= beat_power_save,
-	.nvram_size		= beat_nvram_get_size,
-	.nvram_read		= beat_nvram_read,
-	.nvram_write		= beat_nvram_write,
-	.set_dabr		= beat_set_xdabr,
-	.init_IRQ		= beatic_init_IRQ,
-	.get_irq		= beatic_get_irq,
-	.pci_probe_mode 	= celleb_pci_probe_mode,
-	.pci_setup_phb		= celleb_setup_phb,
-#ifdef CONFIG_KEXEC
-	.kexec_cpu_down		= beat_kexec_cpu_down,
-	.machine_kexec		= default_machine_kexec,
-	.machine_kexec_prepare	= default_machine_kexec_prepare,
-	.machine_crash_shutdown	= default_machine_crash_shutdown,
-#endif
-};
-
-define_machine(celleb_native) {
-	.name			= "Cell Reference Set (native)",
-	.probe			= celleb_probe_native,
-	.setup_arch		= celleb_setup_arch_native,
-	.show_cpuinfo		= celleb_show_cpuinfo,
-	.restart		= rtas_restart,
-	.power_off		= rtas_power_off,
-	.halt			= rtas_halt,
-	.get_boot_time		= rtas_get_boot_time,
-	.get_rtc_time		= rtas_get_rtc_time,
-	.set_rtc_time		= rtas_set_rtc_time,
-	.calibrate_decr		= generic_calibrate_decr,
-	.progress		= celleb_progress,
-	.pci_probe_mode 	= celleb_pci_probe_mode,
-	.pci_setup_phb		= celleb_setup_phb,
-	.init_IRQ		= celleb_init_IRQ_native,
-#ifdef CONFIG_KEXEC
-	.machine_kexec		= default_machine_kexec,
-	.machine_kexec_prepare	= default_machine_kexec_prepare,
-	.machine_crash_shutdown	= default_machine_crash_shutdown,
-#endif
-};
Index: b/arch/powerpc/platforms/cell/Makefile
===================================================================
--- a/arch/powerpc/platforms/cell/Makefile	2008-03-13 17:57:52.000000000 +0900
+++ b/arch/powerpc/platforms/cell/Makefile	2008-03-13 17:57:55.000000000 +0900
@@ -31,5 +31,7 @@
 
 # celleb stuff
 ifeq ($(CONFIG_PPC_CELLEB),y)
-obj-y					+= io-workarounds.o spider-pci.o
+obj-y					+= celleb_setup.o \
+					   celleb_pci.o \
+					   io-workarounds.o spider-pci.o
 endif
Index: b/arch/powerpc/platforms/celleb/Kconfig
===================================================================
--- a/arch/powerpc/platforms/celleb/Kconfig	2008-03-13 17:54:30.000000000 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,12 +0,0 @@
-config PPC_CELLEB
-	bool "Toshiba's Cell Reference Set 'Celleb' Architecture"
-	depends on PPC_MULTIPLATFORM && PPC64
-	select PPC_CELL
-	select PPC_CELL_NATIVE
-	select PPC_RTAS
-	select PPC_INDIRECT_IO
-	select PPC_OF_PLATFORM_PCI
-	select HAS_TXX9_SERIAL
-	select PPC_UDBG_BEAT
-	select USB_OHCI_BIG_ENDIAN_MMIO
-	select USB_EHCI_BIG_ENDIAN_MMIO
