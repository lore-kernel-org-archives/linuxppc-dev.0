Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 56FAB67D24
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 20:45:40 +1100 (EST)
Received: from wall11.toshiba.co.jp (wall11 [133.199.90.149])
	by imx12.toshiba.co.jp  with ESMTP id kAF9jZIi023850
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 18:45:35 +0900 (JST)
Received: (from root@localhost) by wall11.toshiba.co.jp  id kAF9jZXU006722
	for linuxppc-dev@ozlabs.org; Wed, 15 Nov 2006 18:45:35 +0900 (JST)
Received: from mx2.toshiba.co.jp (localhost [127.0.0.1])
	by ovp11.toshiba.co.jp  with ESMTP id kAF9jYNc013832
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 18:45:34 +0900 (JST)
Date: Wed, 15 Nov 2006 18:45:32 +0900 (JST)
Message-Id: <200611150945.kAF9jXRV007053@toshiba.co.jp>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 9/16] Supporting of PCI bus for Celleb
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch includes support for pci buses, base of Celleb specific devices,
and etc. 


Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
---

Index: linux-2.6.19/arch/powerpc/platforms/celleb/ioif.c
diff -u /dev/null linux-2.6.19/arch/powerpc/platforms/celleb/ioif.c:1.1
--- /dev/null	Thu Nov  9 18:40:50 2006
+++ linux-2.6.19/arch/powerpc/platforms/celleb/ioif.c	Fri Oct  6 16:13:37 2006
@@ -0,0 +1,48 @@
+/*
+ * Celleb IOIF management
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
+#include <linux/bootmem.h>
+
+#include <asm/prom.h>
+#include <asm/iommu.h>
+
+#include "ioif.h"
+
+
+static inline void ioif_setup(struct ioif *ioif, struct device_node *dn)
+{
+	ioif->iommu_table = NULL;
+}
+
+struct ioif *ioif_alloc(struct device_node *dn)
+{
+	struct ioif *ioif;
+
+	if (mem_init_done)
+		ioif = kmalloc(sizeof(struct ioif), GFP_KERNEL);
+	else
+		ioif = alloc_bootmem(sizeof(struct ioif));
+
+	if (ioif)
+		ioif_setup(ioif, dn);
+
+	return ioif;
+}
Index: linux-2.6.19/arch/powerpc/platforms/celleb/ioif.h
diff -u /dev/null linux-2.6.19/arch/powerpc/platforms/celleb/ioif.h:1.1
--- /dev/null	Thu Nov  9 18:40:50 2006
+++ linux-2.6.19/arch/powerpc/platforms/celleb/ioif.h	Fri Oct  6 16:13:37 2006
@@ -0,0 +1,31 @@
+/*
+ * CBE IOIF description
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
+#ifndef __CELLEB_IOIF_H__
+#define __CELLEB_IOIF_H__
+
+struct ioif {
+	struct iommu_table *iommu_table;
+};
+
+
+struct ioif *ioif_alloc(struct device_node *dn);
+
+#endif
Index: linux-2.6.19/arch/powerpc/platforms/celleb/celleb_pci.c
diff -u /dev/null linux-2.6.19/arch/powerpc/platforms/celleb/celleb_pci.c:1.2
--- /dev/null	Thu Nov  9 18:40:50 2006
+++ linux-2.6.19/arch/powerpc/platforms/celleb/celleb_pci.c	Mon Nov  6 20:16:26 2006
@@ -0,0 +1,583 @@
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
+#include <linux/kernel.h>
+#include <linux/threads.h>
+#include <linux/pci.h>
+#include <linux/string.h>
+#include <linux/init.h>
+#include <linux/bootmem.h>
+#include <linux/pci_regs.h>
+
+#include <asm/io.h>
+#include <asm/pgtable.h>
+#include <asm/irq.h>
+#include <asm/prom.h>
+#include <asm/machdep.h>
+#include <asm/pci-bridge.h>
+#include <asm/iommu.h>
+#include <asm/rtas.h>
+#include <asm/mpic.h>
+#include <asm/ppc-pci.h>
+
+#include "celleb_scc.h"
+#include "interrupt.h"
+#include "ioif.h"
+
+//#define DEBUG
+#undef DEBUG
+
+#define MAX_PCI_DEVICES    32
+#define MAX_PCI_FUNCTIONS   8
+
+
+/* dummy pci configuration area for GbE, .... ,and etc. */
+unsigned char *fake_config[MAX_PCI_DEVICES][MAX_PCI_FUNCTIONS];
+
+unsigned int celleb_config_valid[MAX_PCI_DEVICES];
+unsigned long celleb_iobase[MAX_PCI_DEVICES][MAX_PCI_FUNCTIONS][3];
+unsigned long celleb_iosize[MAX_PCI_DEVICES][MAX_PCI_FUNCTIONS][3];
+
+extern int 
+__init celleb_setup_pci_bridge(struct device_node *, struct pci_controller *);
+
+static int 
+celleb_dummy_pci_read_config(struct pci_bus *bus,
+                             unsigned int devfn,
+                             int where, int size, u32 *val)
+{
+
+
+	return PCIBIOS_DEVICE_NOT_FOUND;
+}
+
+
+static int 
+celleb_dummy_pci_write_config(struct pci_bus *bus,
+                              unsigned int devfn,
+                              int where, int size, u32 val)
+{
+
+	return PCIBIOS_DEVICE_NOT_FOUND;
+}
+
+struct pci_ops celleb_dummy_pci_ops = {
+/* for generic PCI buses/devices */
+	celleb_dummy_pci_read_config,
+	celleb_dummy_pci_write_config
+};
+
+void 
+celleb_config_read_fake(unsigned char *config, int where, int size, u32 *val)
+{
+	char *p=config+where;
+	u32 *p32;
+
+	p32 = (u32 *)p;
+
+	switch(size){
+	case 1:
+		*val = (*p32)>>24 & 0xff;
+		break;
+	case 2:
+		*val =(*p32)>>16 & 0xffff;		
+		break;
+	case 4:
+		*val =(*p32);
+		break;
+	}
+
+	return;
+
+}
+
+void 
+celleb_config_write_fake(unsigned char *config, int where, int size, u32 val)
+{
+	char *p=config+where;
+	int i;
+	char n;
+
+	switch(size){
+	case 1:
+		n = (char)val;
+		*p = n;
+		break;
+	case 2:
+		for(i=0;i<2;i++,p++){
+			n = (char)(val >> (8*(1-i)));
+			*p = n;
+		}
+		break;
+	case 4:
+		for(i=0;i<4;i++,p++){
+			n = (char)(val >> (8*(3-i)));
+			*p = n;
+		}
+		break;
+	}
+	return;
+
+}
+
+static int 
+celleb_fake_pci_read_config(struct pci_bus *bus,
+                            unsigned int devfn,
+                            int where, int size, u32 *val)
+{
+
+	char *config;
+	unsigned int devno = devfn >> 3;
+	unsigned int fn = devfn & 0x7;
+
+#ifdef DEBUG
+	printk("    fake read: bus=0x%x, ", bus->number);
+#endif	
+
+	config = fake_config[devno][fn];
+
+#ifdef DEBUG
+	printk("devno=0x%x, where=0x%x, size=0x%x, ", 
+	       devno, where, size);
+#endif
+	if(!celleb_config_valid[devno] || !config){
+#ifdef DEBUG
+		printk("failed\n");
+#endif
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	}
+
+	celleb_config_read_fake(config, where, size, val);
+
+#ifdef DEBUG
+	printk("val=0x%x\n", *val);
+#endif
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+
+static int 
+celleb_fake_pci_write_config(struct pci_bus *bus,
+                             unsigned int devfn,
+                             int where, int size, u32 val)
+{
+
+	char *config;
+	unsigned int devno = devfn >> 3;
+	unsigned int fn = devfn & 0x7;
+
+	config = fake_config[devno][fn];
+
+	if(!celleb_config_valid[devno] || !config){
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	}
+
+	if(val == ~0){
+		int i=(where-PCI_BASE_ADDRESS_0)>>3;
+
+		switch(where){
+		case PCI_BASE_ADDRESS_0:
+		case PCI_BASE_ADDRESS_2:
+			if(size!=4){
+				return PCIBIOS_DEVICE_NOT_FOUND;
+			}
+			celleb_config_write_fake(config, where, size, 
+			                            celleb_iosize[devno][fn][i]);
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
+
+	celleb_config_write_fake(config, where, size, val);
+#ifdef DEBUG
+	printk("    fake write: where=%x, size=%d, val=%x\n", 
+	       where, size, val);
+#endif
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+struct pci_ops celleb_fake_pci_ops = {
+	celleb_fake_pci_read_config,
+	celleb_fake_pci_write_config
+};
+
+
+int
+celleb_setup_pci_base_addrs(struct device_node *node, 
+                            unsigned int devno, 
+                            unsigned int fn,
+                            unsigned int num_base_addr)
+{
+
+	u32 val;
+	unsigned char *config;
+
+	config = fake_config[devno][fn];
+	if(!config){
+		return 1;
+	}
+
+	switch(num_base_addr){
+	case 3: /* FALLTHROUGH */
+		val = (celleb_iobase[devno][fn][2] & 0xfffffff0)
+			| PCI_BASE_ADDRESS_MEM_TYPE_64;
+		celleb_config_write_fake(config, PCI_BASE_ADDRESS_4, 4, val);
+		val = celleb_iobase[devno][fn][2] >> 32;
+		celleb_config_write_fake(config, PCI_BASE_ADDRESS_5, 4, val);
+	case 2: /* FALLTHROUGH */
+		val = (celleb_iobase[devno][fn][1] & 0xfffffff0)
+			| PCI_BASE_ADDRESS_MEM_TYPE_64;
+		celleb_config_write_fake(config, PCI_BASE_ADDRESS_2, 4, val);
+		val = celleb_iobase[devno][fn][1] >> 32;
+		celleb_config_write_fake(config, PCI_BASE_ADDRESS_3, 4, val);
+	case 1:
+		val = (celleb_iobase[devno][fn][0] & 0xfffffff0)
+			| PCI_BASE_ADDRESS_MEM_TYPE_64;
+		celleb_config_write_fake(config, PCI_BASE_ADDRESS_0, 4, val);
+		val = celleb_iobase[devno][fn][0] >> 32;
+		celleb_config_write_fake(config, PCI_BASE_ADDRESS_1, 4, val);
+		break;
+	}
+
+	val = PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER;
+	celleb_config_write_fake(config, PCI_COMMAND, 2, val);
+
+	return 0;
+
+}
+
+int __init 
+celleb_setup_fake_pci(struct device_node *node)
+{
+	unsigned int rlen, num_base_addr;
+	u32 val;
+	u32 *wi0, *wi1, *wi2, *wi3, *wi4;
+	unsigned int devno, fn;
+	char *config;
+	char *name;
+	unsigned long *li;
+	int size;
+	int i;
+
+
+	name = (char *)get_property(node, "model", &rlen);
+	if(!name){
+		printk("PCI: model property not found.\n");
+		return -1;
+	}
+
+	wi4 = (uint32_t*)get_property(node, "reg", &rlen);
+	if(wi4 == NULL){
+		goto error;
+	}
+	devno = ((wi4[0] >> 8) & 0xff) >> 3;
+	fn = (wi4[0] >> 8) & 0x7;
+
+#ifdef DEBUG
+	printk("PCI: celleb_setup_fake_pci() %s devno=%x fn=%x\n", name, devno, fn);
+#endif
+
+	size = 256;
+	if(mem_init_done)
+		fake_config[devno][fn] = (unsigned char *)kmalloc(size, GFP_KERNEL);
+	else
+		fake_config[devno][fn] = (unsigned char *)alloc_bootmem(size);
+
+	if(fake_config[devno][fn] == NULL){
+		printk(KERN_ERR "PCI: not enough memory for dummy configuration space\n");
+		goto error;
+	}
+
+	config = fake_config[devno][fn];
+	memset(config, 0, size);
+
+	wi0 = (uint32_t*)get_property(node, "device-id", NULL);
+	wi1 = (uint32_t*)get_property(node, "vendor-id", NULL);
+	wi2 = (uint32_t*)get_property(node, "class-code", NULL);
+	wi3 = (uint32_t*)get_property(node, "revision-id", NULL);
+
+	celleb_config_write_fake(config, PCI_DEVICE_ID, 2, wi0[0]&0xffff);
+	celleb_config_write_fake(config, PCI_VENDOR_ID, 2, wi1[0]&0xffff);
+#ifdef DEBUG
+	printk("class-code = 0x%x\n", wi2[0]);
+#endif
+	celleb_config_write_fake(config, PCI_CLASS_PROG, 1, wi2[0]&0xff);
+	celleb_config_write_fake(config, PCI_CLASS_DEVICE, 2,
+		(wi2[0]>>8)&0xffff);
+	celleb_config_write_fake(config, PCI_REVISION_ID, 1, wi3[0]);
+
+	li = (unsigned long *)get_property(node, "toshiba,reg", &rlen);
+
+	if(li){	
+		num_base_addr = rlen >> 4 ;
+		
+		if(num_base_addr > 3){
+			num_base_addr = 3;
+		}
+
+#ifdef DEBUG
+		printk("PCI: %s: number of base addresses is %d\n", name, num_base_addr);
+#endif
+
+		for(i=0; i < num_base_addr; i++){
+			celleb_iobase[devno][fn][i] = li[i*2];
+			celleb_iosize[devno][fn][i] = li[i*2+1];
+#ifdef DEBUG
+			printk("PCI: base address %d: 0x%lx-0x%lx\n", i, li[i*2], li[i*2+1]);
+#endif
+		}
+
+	}else{
+		printk(KERN_ERR "PCI: No toshiba,reg property\n");
+		goto error;
+	}
+
+	celleb_setup_pci_base_addrs(node, devno, fn, num_base_addr);
+
+
+	li = (unsigned long *)get_property(node, "interrupts", &rlen);
+	val = li[0];
+	celleb_config_write_fake(config, PCI_INTERRUPT_PIN, 1, 1);
+	celleb_config_write_fake(config, PCI_INTERRUPT_LINE, 1, val);
+
+#ifdef DEBUG
+	printk("PCI: %s irq=%ld\n", name, li[0]);
+	for(i=0; i<6; i++){
+		celleb_config_read_fake(config, PCI_BASE_ADDRESS_0+0x4*i, 4, &val);
+		printk("PCI: %s fn=%d base_address_%d=0x%x\n", name, fn, i, val);
+	}
+#endif
+
+
+	celleb_config_write_fake(config, PCI_HEADER_TYPE, 1, PCI_HEADER_TYPE_NORMAL);
+
+	celleb_config_valid[devno] = 1;
+
+	return 0;
+
+error:
+	return 1;
+
+}
+
+
+static void __init celleb_pcibios_fixup(void)
+{
+	struct pci_dev *dev = NULL;
+	struct pci_bus *bus;
+	struct list_head *ln;
+
+	for_each_pci_dev(dev){
+
+		bus = dev->bus;
+
+		if(bus && ppc_md.pci_probe_mode(bus) == PCI_PROBE_NORMAL){
+			continue;
+		}
+
+		pci_read_irq_line(dev);
+
+	}
+
+	list_for_each(ln, &pci_root_buses){
+		bus = pci_bus_b(ln);
+		if(ppc_md.pci_probe_mode(bus) == PCI_PROBE_NORMAL){
+			dev = NULL;
+#if 1 /* XXX: This is for SYSCON workaround */
+			list_for_each_entry(dev, &bus->devices, bus_list){
+				int i;
+				if((dev->class >> 8) != PCI_CLASS_BRIDGE_HOST)
+					continue;
+				for(i = 0; i < PCI_NUM_RESOURCES; i++ ){
+					struct resource *r = NULL;
+					struct resource *root = NULL;
+					r = &dev->resource[i];
+					root = pcibios_select_root(dev, r);
+					if(!(r->flags) || r->parent){
+						continue;
+					}
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
+
+}
+
+static int 
+phb_set_bus_ranges(struct device_node *dev, struct pci_controller *phb)
+{
+	int *bus_range;
+	unsigned int len;
+
+	bus_range = (int *) get_property(dev, "bus-range", &len);
+	if (bus_range == NULL || len < 2 * sizeof(int)) {
+		return 1;
+ 	}
+
+	phb->first_busno =  bus_range[0];
+	phb->last_busno  =  bus_range[1];
+
+	return 0;
+}
+
+extern struct pci_ops celleb_epci_ops;
+
+int __devinit 
+celleb_setup_phb(struct device_node *dev, struct pci_controller *phb)
+{
+
+	const char *name;
+	unsigned int rlen;
+	extern int celleb_setup_epci(struct device_node *, struct pci_controller *);
+	struct device_node *node;
+
+	if (phb_set_bus_ranges(dev, phb))
+		return 1;
+
+	name = get_property(dev, "name", &rlen);
+
+	if(!name){
+		phb->ops = &celleb_dummy_pci_ops;
+	}else if(strcmp(name, "epci") == 0){
+		phb->ops = &celleb_epci_ops;
+		celleb_setup_epci(dev, phb);
+	}else if(strcmp(name, "pci-pseudo") == 0){
+		phb->ops = &celleb_fake_pci_ops;
+		for (node = of_get_next_child(dev, NULL);
+		     node != NULL;
+		     node = of_get_next_child(dev, node)){
+			celleb_setup_fake_pci(node);
+		}
+
+	}else{
+		phb->ops = &celleb_dummy_pci_ops;
+	}
+
+
+	phb->buid = get_phb_buid(dev);
+
+	return 0;
+}
+
+
+static unsigned int __init init_phbs_ioif_recursive(
+		struct device_node *parent, unsigned int index)
+{
+	struct device_node *node;
+	struct pci_controller *phb;
+	struct ioif *ioif;
+
+	for (node = of_get_next_child(parent, NULL);
+	     node != NULL;
+	     node = of_get_next_child(parent, node)) {
+
+		if (node->type == NULL)
+			continue;
+
+		if (strcmp(node->type,"pci") == 0 || strcmp(node->type,"pciex") == 0) {
+			phb = pcibios_alloc_controller(node);
+			if (!phb)
+				continue;
+
+			celleb_setup_phb(node, phb);
+			pci_process_bridge_OF_ranges(phb, node, 0);
+			pci_setup_phb_io(phb, index == 0);
+			index++;
+		} else if (strcmp(node->type, "ioif") == 0) {
+			ioif = ioif_alloc(node);
+			if (!ioif)
+				continue;
+			node->data = ioif;
+			index = init_phbs_ioif_recursive(node, index);
+		}
+	}
+
+	return index;
+}
+
+unsigned long __init 
+celleb_find_and_init_phbs(void)
+{
+	unsigned int index;
+	unsigned int root_size_cells = 0;
+	struct device_node *root = of_find_node_by_path("/");
+
+	int i;
+
+	for( i=0 ;i<MAX_PCI_DEVICES ; i++){
+		int j, k;
+		celleb_config_valid[i] = 0;
+
+		for( j=0; j<MAX_PCI_FUNCTIONS; j++){
+			fake_config[i][j] = NULL;
+			for(k=0; k<3; k++){
+				celleb_iobase[i][j][k] = 0;
+				celleb_iosize[i][j][k] = 0;
+			}
+		}
+	}
+
+	ppc_md.pcibios_fixup = celleb_pcibios_fixup;
+
+	root_size_cells = prom_n_size_cells(root);
+
+	index = 0;
+
+	init_phbs_ioif_recursive(root, index);
+
+	of_node_put(root);
+	pci_devs_phb_init();
+
+	/*
+	 * pci_probe_only and pci_assign_all_buses can be set via properties
+	 * in chosen.
+	 */
+	if (of_chosen) {
+		int *prop;
+
+		prop = (int *)get_property(of_chosen, "linux,pci-probe-only",
+					   NULL);
+		if (prop)
+			pci_probe_only = *prop;
+
+	}
+
+	return 0;
+}
+
Index: linux-2.6.19/arch/powerpc/platforms/celleb/celleb_epci.c
diff -u /dev/null linux-2.6.19/arch/powerpc/platforms/celleb/celleb_epci.c:1.2
--- /dev/null	Thu Nov  9 18:40:50 2006
+++ linux-2.6.19/arch/powerpc/platforms/celleb/celleb_epci.c	Tue Nov  7 13:51:31 2006
@@ -0,0 +1,583 @@
+/*
+ * Support for Celleb external PCI
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
+#include <linux/kernel.h>
+#include <linux/threads.h>
+#include <linux/pci.h>
+#include <linux/string.h>
+#include <linux/init.h>
+#include <linux/bootmem.h>
+#include <linux/pci_regs.h>
+
+#include <asm/io.h>
+#include <asm/pgtable.h>
+#include <asm/irq.h>
+#include <asm/prom.h>
+#include <asm/machdep.h>
+#include <asm/pci-bridge.h>
+#include <asm/iommu.h>
+#include <asm/rtas.h>
+#include <asm/mpic.h>
+#include <asm/ppc-pci.h>
+
+#include "celleb_scc.h"
+#include "interrupt.h"
+
+//#define DEBUG
+#undef DEBUG
+
+#define MAX_PCI_DEVICES   32
+#define MAX_PCI_FUNCTIONS  8
+
+#define iob()  __asm__ __volatile__("eieio; sync":::"memory")
+
+unsigned int epci_ext_irq=0L;
+unsigned int epci_int_irq=0L;
+
+void celleb_epci_dummy_read(struct pci_dev *dev){
+
+	unsigned long epci_base;
+	struct device_node *node;
+	struct pci_controller *hose;
+	u32 val;
+
+	node = (struct device_node *)dev->bus->sysdata;
+	hose = pci_find_hose_for_OF_device(node);
+
+	if(!hose)
+		return;
+
+	epci_base = (unsigned long)hose->cfg_addr;
+
+	val = in_be32((void *)(epci_base + SCC_EPCI_WATRP));	
+
+	return;
+}
+
+static int
+celleb_epci_check_abort(struct pci_controller *hose, unsigned long addr)
+{
+
+	unsigned long reg;
+	unsigned long epci_base;
+	u32 val;
+	
+
+	iob();
+	epci_base = (unsigned long)hose->cfg_addr;	
+
+	reg = epci_base + PCI_COMMAND;
+	val = in_be32((void *)reg);
+
+	if ( val & (PCI_STATUS_REC_MASTER_ABORT << 16)) {
+		out_be32((void *)reg, 
+		         (val & 0x0000ffff) |(PCI_STATUS_REC_MASTER_ABORT << 16));
+
+		/* clear PCI Contro0ller error, FRE, PMFE */
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
+
+}
+
+int
+celleb_epci_subordinate_read_config(struct pci_controller *hose,
+                                    int bus, unsigned int devfn,
+                                    int where, int size, u32 *val)
+{
+
+	unsigned long addr;
+
+	if( !hose->cfg_data )
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+
+	if(where == PCI_INTERRUPT_LINE){
+		*val = irq_create_mapping(NULL, epci_ext_irq);
+		return PCIBIOS_SUCCESSFUL;
+	}else if(where == PCI_INTERRUPT_PIN){
+		*val = 1;
+		return PCIBIOS_SUCCESSFUL;
+	}
+
+	/* Clear and Disable Master Abort interrupt */
+	addr = (unsigned long)hose->cfg_addr + PCI_COMMAND;
+	out_be32((void *)addr,  
+	         (in_be32((void *)addr) | (PCI_STATUS_REC_MASTER_ABORT << 16)));
+
+	/* address for PCI configuration access */
+	addr = (unsigned long)hose->cfg_data +
+	       (((bus & 0xff) << 16)
+	        | ((devfn & 0xff) << 8) 
+	        | (where & 0xff)
+	        | 0x01000000);
+	
+
+	switch(size){
+	case 1:
+		addr &= ~0x3;
+		*val = in_le32((void *)(addr)) >> (8 * (where & 0x3));
+		break;
+	case 2:
+		addr &= ~0x2;
+		*val = in_le32((void *)(addr)) >> (8 * (where & 0x2));
+		break;
+	case 4:
+		*val = in_le32((void *)addr);
+		break;
+	default:
+		//*val = 0;
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	}
+
+	return celleb_epci_check_abort(hose, 0);
+}
+
+int
+celleb_epci_subordinate_write_config(struct pci_controller *hose,
+                                     int bus, unsigned int devfn,
+                                     int where, int size, u32 val)
+{
+
+	unsigned long addr;
+	u32 xval;
+
+	if( !hose->cfg_data )
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	/* Clear and Disable Master Abort interrupt */
+	addr = (unsigned long)hose->cfg_addr + PCI_COMMAND;
+	out_be32((void *)addr, 
+	         (in_be32((void *)addr) | (PCI_STATUS_REC_MASTER_ABORT << 16)));
+
+	/* address for PCI configuration access */
+	addr = (unsigned long)hose->cfg_data +
+	       (((bus & 0xff) << 16)
+	        | ((devfn & 0xff) << 8) 
+	        | (where & 0xff)
+	        | 0x01000000);
+
+	
+	switch(size){
+	case 1:
+		addr &= ~0x3;
+		xval = in_le32((void *)addr);
+		xval = (xval & ~(0xff << (8 * (where & 0x3)))) |
+		       ((val & 0xff) << (8 * (where & 0x3)));
+		break;
+	case 2:
+		addr &= ~0x2;
+		xval = in_le32((void *)addr);
+		xval = (xval & ~(0xffff << (8 * (where & 0x2 )))) |
+		       ((val & 0xffff) << (8 * (where & 0x2)));
+		break;
+	case 4:
+		xval = val;
+		break;
+	default:
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	}
+
+	out_le32((void *)addr, xval);
+
+	return celleb_epci_check_abort(hose, addr);
+}
+
+int
+celleb_epci_read_config(struct pci_bus *bus,
+                        unsigned int devfn,
+                        int where, int size, u32 *val)
+{
+
+	unsigned long addr;
+	struct device_node *node;
+	struct pci_controller *hose;
+
+
+	node = (struct device_node *)bus->sysdata;	
+	hose = pci_find_hose_for_OF_device(node);
+
+	if( bus->self )
+		return celleb_epci_subordinate_read_config(hose, bus->number, devfn,
+		                                           where, size, val);
+
+
+	if( !hose->cfg_data )
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	if(bus->number == hose->first_busno  &&  devfn == 0){
+		/* SYSCON */
+
+		if(where == PCI_INTERRUPT_LINE){
+			*val = irq_create_mapping(NULL, epci_int_irq);
+			return PCIBIOS_SUCCESSFUL;
+		}else if(where == PCI_INTERRUPT_PIN){
+			*val = 1;
+			return PCIBIOS_SUCCESSFUL;
+		}
+
+		addr = (unsigned long)hose->cfg_addr + where;
+
+		switch(size){
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
+	}else{
+
+		if(where == PCI_INTERRUPT_LINE){
+			*val = irq_create_mapping(NULL, epci_ext_irq);
+			return PCIBIOS_SUCCESSFUL;
+		}else if(where == PCI_INTERRUPT_PIN){
+			*val = 1;
+			return PCIBIOS_SUCCESSFUL;
+		}
+
+		/* Clear and Disable Master Abort interrupt */
+		addr = (unsigned long)hose->cfg_addr + PCI_COMMAND;
+		out_be32((void *)addr,  
+	         	(in_be32((void *)addr) | (PCI_STATUS_REC_MASTER_ABORT << 16)));
+
+		/* address for PCI configuration access */
+		addr = (unsigned long)hose->cfg_data + (((devfn & 0xff) << 8) | (where & 0xff));
+	
+		switch(size){
+		case 1:
+			addr &= ~0x3;
+			*val = in_le32((void *)addr) >> (8 * (where & 0x3));
+			break;
+		case 2:
+			addr &= ~0x2;
+			*val = in_le32((void *)addr) >> (8 * (where & 0x2));
+			break;
+		case 4:
+			*val = in_le32((void *)addr);
+			break;
+		default:
+			//*val = 0;
+			return PCIBIOS_DEVICE_NOT_FOUND;
+		}
+	}
+
+#ifdef DEBUG
+	printk("    epci read: addr=0x%lx, devfn=0x%x, where=0x%x, size=0x%x, val=0x%x\n", 
+	       addr, devfn, where, size, *val);
+#endif
+
+	return celleb_epci_check_abort(hose, 0);
+}
+
+
+int
+celleb_epci_write_config(struct pci_bus *bus,
+                         unsigned int devfn,
+                         int where, int size, u32 val)
+{
+
+	unsigned long addr;
+	struct device_node *node;
+	struct pci_controller *hose;
+	u32 xval;
+
+	node = (struct device_node *)bus->sysdata;
+	hose = pci_find_hose_for_OF_device(node);
+
+	if( bus->self )
+		return celleb_epci_subordinate_write_config(hose, bus->number, devfn,
+		                                            where, size, val);
+
+
+	if( !hose->cfg_data )
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	if(bus->number == hose->first_busno && devfn == 0){
+		/* SYSCON */
+
+		addr = (unsigned long)hose->cfg_addr + where;
+
+		switch(size){
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
+	}else{
+		/* Clear and Disable Master Abort interrupt */
+		addr = (unsigned long)hose->cfg_addr + PCI_COMMAND;
+		out_be32((void *)addr, 
+	                 (in_be32((void *)addr) | (PCI_STATUS_REC_MASTER_ABORT << 16)));
+
+		/* address for PCI configuration access */
+		addr = (unsigned long)hose->cfg_data + (((devfn & 0xff) << 8) | (where & 0xff));
+
+	
+		switch(size){
+		case 1:
+			addr &= ~0x3;
+			xval = in_le32((void *)addr);
+			xval = (xval & ~(0xff << (8 * (where & 0x3)))) |
+		       	       ((val & 0xff) << (8 * (where & 0x3)));
+		break;
+		case 2:
+			addr &= ~0x2;
+			xval = in_le32((void *)addr);
+			xval = (xval & ~(0xffff << (8 * (where & 0x2 )))) |
+		       	       ((val & 0xffff) << (8 * (where & 0x2)));
+			break;
+		case 4:
+			xval = val;
+			break;
+		default:
+			return PCIBIOS_DEVICE_NOT_FOUND;
+
+		}
+		out_le32((void *)addr, xval);
+
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
+static int __init celleb_epci_init(struct pci_controller *hose){
+
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
+	if (val == 0x00030101) {
+		hwres = 1;
+	} else {
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
+		out_be32((void *)reg, 0x0f1f001f); /* temporary value */
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
+	/* release interrupt masks and clear all interrupts*/
+	reg = epci_base + SCC_EPCI_INTSET;
+	out_be32((void *)reg, 0x013f011f); /* all interrupts enable */
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
+	val &= ~(SCC_EPCI_VCSR_DR | SCC_EPCI_VCSR_AT | SCC_EPCI_VCSR_SR);
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
+
+
+}
+
+int __init 
+celleb_setup_epci(struct device_node *node, struct pci_controller *hose)
+{
+
+	unsigned long *li, *li2;
+	unsigned int rlen;
+
+#ifdef DEBUG
+	printk("PCI: celleb_setup_epci()\n");
+#endif
+	
+	li = (unsigned long *)get_property(node, "toshiba,reg", &rlen);
+
+	if(!li || ((rlen >> 4) != 4)){
+		printk(KERN_ERR "PCI: No toshiba,reg property\n");
+		goto error;
+	}
+
+	hose->cfg_addr = ioremap(li[0], li[1]);
+	if( !hose->cfg_addr ){
+		goto error;
+	}
+	hose->cfg_data = ioremap(li[4], li[5]);
+	if( !hose->cfg_data ){
+		goto error;
+	}
+
+	li2 = (unsigned long *)get_property(node, "interrupts", &rlen);
+	if( !li2 ){
+		printk(KERN_ERR "PCI: No interrupts property");
+		goto error;
+	}
+	epci_ext_irq = li2[0];
+	epci_int_irq = li2[1];
+
+
+#ifdef DEBUG
+	printk("PCI: epci_ext_irq %x epci_int_irq %x\n", epci_ext_irq, epci_int_irq);
+	printk("PCI: cfg_addr 0x%016lx->0x%016lx + 0x%016lx\n", 
+	       li[0], (unsigned long)hose->cfg_addr, li[1]);
+	printk("PCI: cfg_data map 0x%016lx->0x%016lx + 0x%016lx\n", 
+	       li[4], (unsigned long)hose->cfg_data, li[5]);
+#endif
+
+	celleb_epci_init(hose);
+
+
+	return 0;
+
+error:
+
+	if( hose->cfg_addr ){
+		iounmap((void *)hose->cfg_addr);
+	}
+
+	if( hose->cfg_data ){
+		iounmap((void *)hose->cfg_data);
+	}
+	return 1;
+
+} 
+
+/* End: celleb_epci.c */
+
+
+
Index: linux-2.6.19/arch/powerpc/platforms/celleb/celleb_scc.h
diff -u /dev/null linux-2.6.19/arch/powerpc/platforms/celleb/celleb_scc.h:1.1
--- /dev/null	Thu Nov  9 18:40:50 2006
+++ linux-2.6.19/arch/powerpc/platforms/celleb/celleb_scc.h	Fri Oct  6 16:13:37 2006
@@ -0,0 +1,164 @@
+/*
+ * SCC (Super Companion Chip) definitions
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
+#ifndef _CELLEB_SCC_H__
+#define _CELLEB_SCC_H__
+
+
+#define	PCI_VENDOR_ID_TOSHIBA_2                 0x102f
+#define	PCI_DEVICE_ID_TOSHIBA_SCC_PCIEXC_BRIDGE 0x01b0
+#define	PCI_DEVICE_ID_TOSHIBA_SCC_EPCI_BRIDGE   0x01b1
+#define	PCI_DEVICE_ID_TOSHIBA_SCC_BRIDGE        0x01b2
+#define	PCI_DEVICE_ID_TOSHIBA_SCC_GBE           0x01b3
+#define	PCI_DEVICE_ID_TOSHIBA_SCC_ATA           0x01b4
+#define	PCI_DEVICE_ID_TOSHIBA_SCC_USB2          0x01b5
+#define	PCI_DEVICE_ID_TOSHIBA_SCC_USB           0x01b6
+#define	PCI_DEVICE_ID_TOSHIBA_SCC_ENCDEC        0x01b7
+
+#define SCC_EPCI_REG  0x0000d000
+
+/* EPCI registers */
+#define SCC_EPCI_CNF10_REG     0x010
+#define SCC_EPCI_CNF14_REG     0x014
+#define SCC_EPCI_CNF18_REG     0x018
+#define SCC_EPCI_PVBAT         0x100
+#define SCC_EPCI_VPMBAT        0x104
+#define SCC_EPCI_VPIBAT        0x108
+#define SCC_EPCI_VCSR          0x110
+#define SCC_EPCI_VIENAB        0x114
+#define SCC_EPCI_VISTAT        0x118
+#define SCC_EPCI_VRDCOUNT      0x124
+#define SCC_EPCI_BAM0          0x12c
+#define SCC_EPCI_BAM1          0x134
+#define SCC_EPCI_BAM2          0x13c
+#define SCC_EPCI_IADR          0x164
+#define SCC_EPCI_CLKRST        0x800
+#define SCC_EPCI_INTSET        0x804
+#define SCC_EPCI_STATUS        0x808
+#define SCC_EPCI_ABTSET        0x80c
+#define SCC_EPCI_WATRP         0x810
+#define SCC_EPCI_DUMMYRADR     0x814
+#define SCC_EPCI_SWRESP        0x818
+#define SCC_EPCI_CNTOPT        0x81c
+#define SCC_EPCI_ECMODE        0xf00
+#define SCC_EPCI_IOM_AC_NUM    5
+#define SCC_EPCI_IOM_ACTE(n)   (0xf10 + (n) * 4)
+#define SCC_EPCI_IOT_AC_NUM    4
+#define SCC_EPCI_IOT_ACTE(n)   (0xf30 + (n) * 4)
+#define SCC_EPCI_MAEA          0xf50
+#define SCC_EPCI_MAEC          0xf54
+#define SCC_EPCI_CKCTRL        0xff0
+
+/* bits for SCC_EPCI_VCSR */
+#define SCC_EPCI_VCSR_FRE      0x00020000
+#define SCC_EPCI_VCSR_FWE      0x00010000
+#define SCC_EPCI_VCSR_DR       0x00000400
+#define SCC_EPCI_VCSR_SR       0x00000008
+#define SCC_EPCI_VCSR_AT       0x00000004
+
+/* bits for SCC_EPCI_VIENAB/SCC_EPCI_VISTAT */
+#define SCC_EPCI_VISTAT_PMPE   0x00000008
+#define SCC_EPCI_VISTAT_PMFE   0x00000004
+#define SCC_EPCI_VISTAT_PRA    0x00000002
+#define SCC_EPCI_VISTAT_PRD    0x00000001
+#define SCC_EPCI_VISTAT_ALL    0x0000000f
+
+#define SCC_EPCI_VIENAB_PMPEE  0x00000008
+#define SCC_EPCI_VIENAB_PMFEE  0x00000004
+#define SCC_EPCI_VIENAB_PRA    0x00000002
+#define SCC_EPCI_VIENAB_PRD    0x00000001
+#define SCC_EPCI_VIENAB_ALL    0x0000000f
+
+/* bits for SCC_EPCI_CLKRST */
+#define SCC_EPCI_CLKRST_CKS_MASK 0x00030000
+#define SCC_EPCI_CLKRST_CKS_2    0x00000000
+#define SCC_EPCI_CLKRST_CKS_4    0x00010000
+#define SCC_EPCI_CLKRST_CKS_8    0x00020000
+#define SCC_EPCI_CLKRST_PCICRST  0x00000400
+#define SCC_EPCI_CLKRST_BC       0x00000200
+#define SCC_EPCI_CLKRST_PCIRST   0x00000100
+#define SCC_EPCI_CLKRST_PCKEN    0x00000001
+
+/* bits for SCC_EPCI_INTSET/SCC_EPCI_STATUS */
+#define SCC_EPCI_INT_2M     0x01000000
+#define SCC_EPCI_INT_RERR   0x00200000
+#define SCC_EPCI_INT_SERR   0x00100000
+#define SCC_EPCI_INT_PRTER  0x00080000
+#define SCC_EPCI_INT_SER    0x00040000
+#define SCC_EPCI_INT_PER    0x00020000
+#define SCC_EPCI_INT_PAI    0x00010000
+#define SCC_EPCI_INT_1M     0x00000100
+#define SCC_EPCI_INT_PME    0x00000010
+#define SCC_EPCI_INT_INTD   0x00000008
+#define SCC_EPCI_INT_INTC   0x00000004
+#define SCC_EPCI_INT_INTB   0x00000002
+#define SCC_EPCI_INT_INTA   0x00000001
+#define SCC_EPCI_INT_DEVINT 0x0000000f
+#define SCC_EPCI_INT_ALL    0x003f001f
+#define SCC_EPCI_INT_ALLERR 0x003f0000
+
+/* bits for SCC_EPCI_CKCTRL */
+#define SCC_EPCI_CKCTRL_CRST0    0x00010000
+#define SCC_EPCI_CKCTRL_CRST1    0x00020000
+#define SCC_EPCI_CKCTRL_OCLKEN   0x00000100
+#define SCC_EPCI_CKCTRL_LCLKEN   0x00000001
+
+#define SCC_EPCI_IDSEL_AD_TO_SLOT(ad)       ((ad) - 10)
+#define SCC_EPCI_MAX_DEVNU  SCC_EPCI_IDSEL_AD_TO_SLOT(32)
+
+/* bits for SCC_EPCI_CNTOPT */
+#define SCC_EPCI_CNTOPT_O2PMB    0x00000002
+
+/* PCICFG registers */
+#define SCC_PCICFG_CNFADD   0x00c
+#define SCC_PCICFG_CNFSET   0x010
+#define SCC_PCICFG_CNFWDT   0x014
+#define SCC_PCICFG_CNFRDT   0x018
+#define SCC_PCICFG_CCKCTRL  0xff0
+
+/* bits for SCC_PCICFG_CCKCTRL */
+#define SCC_PCICFG_CCKCTRL_RST      0x00010000
+#define SCC_PCICFG_CCKCTRL_CLKEN    0x00000001
+
+/* bits for SCC_CFG_BUSCLKCTL */
+#define SCC_CFG_BUSCLKCTL_BBUSCLKEN         0x00000010
+#define SCC_CFG_BUSCLKCTL_SBSBUSCLKEN       0x00000008
+#define SCC_CFG_BUSCLKCTL_SBHBUSCLKEN       0x00000004
+#define SCC_CFG_BUSCLKCTL_SBMBUSCLKEN       0x00000002
+#define SCC_CFG_BUSCLKCTL_SBTBUSCLKEN       0x00000001
+
+/* bits for SCC_CFG_BUSRSTCTL */
+#define SCC_CFG_BUSRSTCTL_BBUSRSTEN         0x00000010
+#define SCC_CFG_BUSRSTCTL_SBSBUSRSTEN       0x00000008
+#define SCC_CFG_BUSRSTCTL_SBHBUSRSTEN       0x00000004
+#define SCC_CFG_BUSRSTCTL_SBMBUSRSTEN       0x00000002
+#define SCC_CFG_BUSRSTCTL_SBTBUSRSTEN       0x00000001
+
+/* IPCI device numbers */
+#ifndef	EEHREGIONBASE
+#define	EEHREGIONBASE	0xa000000000000000ul
+#endif	/* EEHREGIONBASE */
+#define	REGION_DATA_MASK	(~REGION_MASK)
+#define	IO_TOKEN_TO_ADDR(token)	((((unsigned long)token)&REGION_DATA_MASK)|IOREGIONBASE)
+#define	IO_ADDR_TO_TOKEN(token)	((((unsigned long)token)&REGION_DATA_MASK)|EEHREGIONBASE)
+#define	IS_EEH_REGION(token)	((((unsigned long)token)&REGION_MASK)==EEHREGIONBASE)
+
+
+#endif
