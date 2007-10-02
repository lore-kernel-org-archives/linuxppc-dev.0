Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0D7F9DDEF2
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 18:26:57 +1000 (EST)
Date: Tue, 02 Oct 2007 17:26:53 +0900 (JST)
Message-Id: <20071002.172653.-1962661557.kouish@swc.toshiba.co.jp>
Subject: [PATCH 5/5] Celleb: update for PCI
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

This is a patch kit to support PCI bus on Celleb with new "I/O routines
for PowerPC." External PCI on Celleb must do explicit synchronization
with devices (Bus has no automatic synchronization feature).

Signed-off-by: Kou Ishizaki <Kou.Ishizaki@toshiba.co.jp>
---

Index: linux-powerpc-git/arch/powerpc/platforms/celleb/pci.h
===================================================================
--- linux-powerpc-git.orig/arch/powerpc/platforms/celleb/pci.h
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/pci.h
@@ -25,11 +25,18 @@
 
 #include <asm/pci-bridge.h>
 #include <asm/prom.h>
+#include <asm/ppc-pci.h>
 
 extern int celleb_setup_phb(struct pci_controller *);
 extern int celleb_pci_probe_mode(struct pci_bus *);
 
-extern struct pci_ops celleb_epci_ops;
 extern int celleb_setup_epci(struct device_node *, struct pci_controller *);
 
+extern void *celleb_dummy_page_va;
+extern int __init celleb_pci_workaround_init(void);
+extern void __init celleb_pci_add_one(struct pci_controller *,
+				      void (*)(struct pci_controller *));
+extern void fake_pci_workaround_init(struct pci_controller *);
+extern void epci_workaround_init(struct pci_controller *);
+
 #endif /* _CELLEB_PCI_H */
Index: linux-powerpc-git/arch/powerpc/platforms/celleb/scc.h
===================================================================
--- linux-powerpc-git.orig/arch/powerpc/platforms/celleb/scc.h
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/scc.h
@@ -53,7 +53,7 @@
 #define SCC_EPCI_STATUS         0x808
 #define SCC_EPCI_ABTSET         0x80c
 #define SCC_EPCI_WATRP          0x810
-#define SCC_EPCI_DUMMYRADR      0x814
+#define SCC_EPCI_DUMYRADR       0x814
 #define SCC_EPCI_SWRESP         0x818
 #define SCC_EPCI_CNTOPT         0x81c
 #define SCC_EPCI_ECMODE         0xf00
Index: linux-powerpc-git/arch/powerpc/platforms/celleb/Makefile
===================================================================
--- linux-powerpc-git.orig/arch/powerpc/platforms/celleb/Makefile
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/Makefile
@@ -1,6 +1,7 @@
 obj-y				+= interrupt.o iommu.o setup.o \
-				   htab.o beat.o pci.o \
-				   scc_epci.o scc_uhc.o hvCall.o
+				   htab.o beat.o hvCall.o pci.o \
+				   scc_epci.o scc_uhc.o \
+				   io-workarounds.o
 
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_PPC_UDBG_BEAT)	+= udbg_beat.o
Index: linux-powerpc-git/arch/powerpc/platforms/celleb/setup.c
===================================================================
--- linux-powerpc-git.orig/arch/powerpc/platforms/celleb/setup.c
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/setup.c
@@ -137,6 +137,8 @@ static int __init celleb_publish_devices
 	/* Publish OF platform devices for southbridge IOs */
 	of_platform_bus_probe(NULL, celleb_bus_ids, NULL);
 
+	celleb_pci_workaround_init();
+
 	return 0;
 }
 device_initcall(celleb_publish_devices);
Index: linux-powerpc-git/arch/powerpc/platforms/celleb/pci.c
===================================================================
--- linux-powerpc-git.orig/arch/powerpc/platforms/celleb/pci.c
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/pci.c
@@ -31,6 +31,7 @@
 #include <linux/init.h>
 #include <linux/bootmem.h>
 #include <linux/pci_regs.h>
+#include <linux/of_device.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -435,36 +436,58 @@ static void __init celleb_alloc_private_
 			GFP_KERNEL);
 }
 
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
+void __init fake_pci_workaround_init(struct pci_controller *phb)
+{
+	/**
+	 *  We will add fake pci bus to scc_pci_bus for the purpose to improve
+	 *  I/O Macro performance. But device-tree and device drivers
+	 *  are not ready to use address with a token.
+	 */
+
+	/* celleb_pci_add_one(phb, NULL); */
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
 int __init celleb_setup_phb(struct pci_controller *phb)
 {
-	const char *name;
 	struct device_node *dev = phb->arch_data;
-	struct device_node *node;
-	unsigned int rlen;
+	const struct of_device_id *match;
+	int (*setup_func)(struct device_node *, struct pci_controller *);
 
-	name = of_get_property(dev, "name", &rlen);
-	if (!name)
+	match = of_match_node(celleb_phb_match, dev);
+	if (!match)
 		return 1;
 
-	pr_debug("PCI: celleb_setup_phb() %s\n", name);
 	phb_set_bus_ranges(dev, phb);
 	phb->buid = 1;
 
-	if (strcmp(name, "epci") == 0) {
-		phb->ops = &celleb_epci_ops;
-		return celleb_setup_epci(dev, phb);
-
-	} else if (strcmp(name, "pci-pseudo") == 0) {
-		phb->ops = &celleb_fake_pci_ops;
-		celleb_alloc_private_mem(phb);
-		for (node = of_get_next_child(dev, NULL);
-		     node != NULL; node = of_get_next_child(dev, node))
-			celleb_setup_fake_pci_device(node, phb);
-
-	} else
-		return 1;
-
-	return 0;
+	setup_func = match->data;
+	return (*setup_func)(dev, phb);
 }
 
 int celleb_pci_probe_mode(struct pci_bus *bus)
Index: linux-powerpc-git/arch/powerpc/platforms/celleb/scc_epci.c
===================================================================
--- linux-powerpc-git.orig/arch/powerpc/platforms/celleb/scc_epci.c
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/scc_epci.c
@@ -43,7 +43,11 @@
 
 #define iob()  __asm__ __volatile__("eieio; sync":::"memory")
 
-static inline volatile void __iomem *celleb_epci_get_epci_base(
+struct epci_private {
+	dma_addr_t	dummy_page_da;
+};
+
+static inline PCI_IO_ADDR celleb_epci_get_epci_base(
 					struct pci_controller *hose)
 {
 	/*
@@ -55,7 +59,7 @@ static inline volatile void __iomem *cel
 	return hose->cfg_addr;
 }
 
-static inline volatile void __iomem *celleb_epci_get_epci_cfg(
+static inline PCI_IO_ADDR celleb_epci_get_epci_cfg(
 					struct pci_controller *hose)
 {
 	/*
@@ -67,20 +71,11 @@ static inline volatile void __iomem *cel
 	return hose->cfg_data;
 }
 
-#if 0 /* test code for epci dummy read */
-static void celleb_epci_dummy_read(struct pci_dev *dev)
+static void scc_epci_dummy_read(struct pci_controller *hose)
 {
-	volatile void __iomem *epci_base;
-	struct device_node *node;
-	struct pci_controller *hose;
+	PCI_IO_ADDR epci_base;
 	u32 val;
 
-	node = (struct device_node *)dev->bus->sysdata;
-	hose = pci_find_hose_for_OF_device(node);
-
-	if (!hose)
-		return;
-
 	epci_base = celleb_epci_get_epci_base(hose);
 
 	val = in_be32(epci_base + SCC_EPCI_WATRP);
@@ -88,21 +83,45 @@ static void celleb_epci_dummy_read(struc
 
 	return;
 }
-#endif
+
+void __init epci_workaround_init(struct pci_controller *hose)
+{
+	PCI_IO_ADDR epci_base;
+	PCI_IO_ADDR reg;
+	struct epci_private *private = hose->private_data;
+
+	BUG_ON(!private);
+
+	private->dummy_page_da = dma_map_single(hose->parent,
+		celleb_dummy_page_va, PAGE_SIZE, DMA_FROM_DEVICE);
+	if (private->dummy_page_da == DMA_ERROR_CODE) {
+		printk(KERN_ERR "EPCI: dummy read disabled."
+		       "Map dummy page failed.\n");
+		return;
+	}
+
+	celleb_pci_add_one(hose, scc_epci_dummy_read);
+	epci_base = celleb_epci_get_epci_base(hose);
+
+	reg = epci_base + SCC_EPCI_DUMYRADR;
+	out_be32(reg, private->dummy_page_da);
+}
 
 static inline void clear_and_disable_master_abort_interrupt(
 					struct pci_controller *hose)
 {
-	volatile void __iomem *epci_base, *reg;
+	PCI_IO_ADDR epci_base;
+	PCI_IO_ADDR reg;
 	epci_base = celleb_epci_get_epci_base(hose);
 	reg = epci_base + PCI_COMMAND;
 	out_be32(reg, in_be32(reg) | (PCI_STATUS_REC_MASTER_ABORT << 16));
 }
 
 static int celleb_epci_check_abort(struct pci_controller *hose,
-				   volatile void __iomem *addr)
+				   PCI_IO_ADDR addr)
 {
-	volatile void __iomem *reg, *epci_base;
+	PCI_IO_ADDR reg;
+	PCI_IO_ADDR epci_base;
 	u32 val;
 
 	iob();
@@ -132,12 +151,12 @@ static int celleb_epci_check_abort(struc
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static volatile void __iomem *celleb_epci_make_config_addr(
+static PCI_IO_ADDR celleb_epci_make_config_addr(
 					struct pci_bus *bus,
 					struct pci_controller *hose,
 					unsigned int devfn, int where)
 {
-	volatile void __iomem *addr;
+	PCI_IO_ADDR addr;
 
 	if (bus != hose->bus)
 		addr = celleb_epci_get_epci_cfg(hose) +
@@ -157,7 +176,8 @@ static volatile void __iomem *celleb_epc
 static int celleb_epci_read_config(struct pci_bus *bus,
 			unsigned int devfn, int where, int size, u32 * val)
 {
-	volatile void __iomem *epci_base, *addr;
+	PCI_IO_ADDR epci_base;
+	PCI_IO_ADDR addr;
 	struct device_node *node;
 	struct pci_controller *hose;
 
@@ -220,7 +240,8 @@ static int celleb_epci_read_config(struc
 static int celleb_epci_write_config(struct pci_bus *bus,
 			unsigned int devfn, int where, int size, u32 val)
 {
-	volatile void __iomem *epci_base, *addr;
+	PCI_IO_ADDR epci_base;
+	PCI_IO_ADDR addr;
 	struct device_node *node;
 	struct pci_controller *hose;
 
@@ -286,7 +307,8 @@ struct pci_ops celleb_epci_ops = {
 static int __init celleb_epci_init(struct pci_controller *hose)
 {
 	u32 val;
-	volatile void __iomem *reg, *epci_base;
+	PCI_IO_ADDR reg;
+	PCI_IO_ADDR epci_base;
 	int hwres = 0;
 
 	epci_base = celleb_epci_get_epci_base(hose);
@@ -440,10 +462,24 @@ int __init celleb_setup_epci(struct devi
 		 r.start, (unsigned long)hose->cfg_data,
 		(r.end - r.start + 1));
 
+	hose->private_data = kzalloc(sizeof(struct epci_private), GFP_KERNEL);
+	if (hose->private_data == NULL) {
+		printk(KERN_ERR "EPCI: no memory for private data.\n");
+		goto error;
+	}
+
+	hose->ops = &celleb_epci_ops;
 	celleb_epci_init(hose);
 
 	return 0;
 
 error:
+	kfree(hose->private_data);
+
+	if (hose->cfg_addr)
+		iounmap(hose->cfg_addr);
+
+	if (hose->cfg_data)
+		iounmap(hose->cfg_data);
 	return 1;
 }
Index: linux-powerpc-git/arch/powerpc/platforms/celleb/io-workarounds.c
===================================================================
--- /dev/null
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/io-workarounds.c
@@ -0,0 +1,279 @@
+/*
+ * Support for Celleb io workarounds
+ *
+ * (C) Copyright 2006-2007 TOSHIBA CORPORATION
+ *
+ * This file is based to arch/powerpc/platform/cell/io-workarounds.c
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
+#include <linux/of_device.h>
+#include <linux/irq.h>
+
+#include <asm/io.h>
+#include <asm/prom.h>
+#include <asm/machdep.h>
+#include <asm/pci-bridge.h>
+#include <asm/ppc-pci.h>
+
+#include "pci.h"
+
+#define MAX_CELLEB_PCI_BUS	4
+
+void *celleb_dummy_page_va;
+
+static struct celleb_pci_bus {
+	struct pci_controller *phb;
+	void (*dummy_read)(struct pci_controller *);
+} celleb_pci_busses[MAX_CELLEB_PCI_BUS];
+
+static int celleb_pci_count = 0;
+
+static struct celleb_pci_bus *celleb_pci_find(unsigned long vaddr,
+					      unsigned long paddr)
+{
+	int i, j;
+	struct resource *res;
+
+	for (i = 0; i < celleb_pci_count; i++) {
+		struct celleb_pci_bus *bus = &celleb_pci_busses[i];
+		struct pci_controller *phb = bus->phb;
+		if (paddr)
+			for (j = 0; j < 3; j++) {
+				res = &phb->mem_resources[j];
+				if (paddr >= res->start && paddr <= res->end)
+					return bus;
+			}
+		res = &phb->io_resource;
+		if (vaddr && vaddr >= res->start && vaddr <= res->end)
+			return bus;
+	}
+	return NULL;
+}
+
+static void celleb_io_flush(const PCI_IO_ADDR addr)
+{
+	struct celleb_pci_bus *bus;
+	int token;
+
+	token = PCI_GET_ADDR_TOKEN(addr);
+
+	if (token && token <= celleb_pci_count)
+		bus = &celleb_pci_busses[token - 1];
+	else {
+		unsigned long vaddr, paddr;
+		pte_t *ptep;
+
+		vaddr = (unsigned long)PCI_FIX_ADDR(addr);
+		if (vaddr < PHB_IO_BASE || vaddr >= PHB_IO_END)
+			return;
+
+		ptep = find_linux_pte(init_mm.pgd, vaddr);
+		if (ptep == NULL)
+			paddr = 0;
+		else
+			paddr = pte_pfn(*ptep) << PAGE_SHIFT;
+		bus = celleb_pci_find(vaddr, paddr);
+
+		if (bus == NULL)
+			return;
+	}
+
+	if (bus->dummy_read)
+		bus->dummy_read(bus->phb);
+}
+
+static u8 celleb_readb(const PCI_IO_ADDR addr)
+{
+	u8 val;
+	val = __do_readb(addr);
+	celleb_io_flush(addr);
+	return val;
+}
+
+static u16 celleb_readw(const PCI_IO_ADDR addr)
+{
+	u16 val;
+	val = __do_readw(addr);
+	celleb_io_flush(addr);
+	return val;
+}
+
+static u32 celleb_readl(const PCI_IO_ADDR addr)
+{
+	u32 val;
+	val = __do_readl(addr);
+	celleb_io_flush(addr);
+	return val;
+}
+
+static u64 celleb_readq(const PCI_IO_ADDR addr)
+{
+	u64 val;
+	val = __do_readq(addr);
+	celleb_io_flush(addr);
+	return val;
+}
+
+static u16 celleb_readw_be(const PCI_IO_ADDR addr)
+{
+	u16 val;
+	val = __do_readw_be(addr);
+	celleb_io_flush(addr);
+	return val;
+}
+
+static u32 celleb_readl_be(const PCI_IO_ADDR addr)
+{
+	u32 val;
+	val = __do_readl_be(addr);
+	celleb_io_flush(addr);
+	return val;
+}
+
+static u64 celleb_readq_be(const PCI_IO_ADDR addr)
+{
+	u64 val;
+	val = __do_readq_be(addr);
+	celleb_io_flush(addr);
+	return val;
+}
+
+static void celleb_readsb(const PCI_IO_ADDR addr,
+			  void *buf, unsigned long count)
+{
+	__do_readsb(addr, buf, count);
+	celleb_io_flush(addr);
+}
+
+static void celleb_readsw(const PCI_IO_ADDR addr,
+			  void *buf, unsigned long count)
+{
+	__do_readsw(addr, buf, count);
+	celleb_io_flush(addr);
+}
+
+static void celleb_readsl(const PCI_IO_ADDR addr,
+			  void *buf, unsigned long count)
+{
+	__do_readsl(addr, buf, count);
+	celleb_io_flush(addr);
+}
+
+static void celleb_memcpy_fromio(void *dest,
+				 const PCI_IO_ADDR src,
+				 unsigned long n)
+{
+	__do_memcpy_fromio(dest, src, n);
+	celleb_io_flush(src);
+}
+
+static void __iomem *celleb_ioremap(unsigned long addr,
+				     unsigned long size,
+				     unsigned long flags)
+{
+	struct celleb_pci_bus *bus;
+	void __iomem *res = __ioremap(addr, size, flags);
+	int busno;
+
+	bus = celleb_pci_find(0, addr);
+	if (bus != NULL) {
+		busno = bus - celleb_pci_busses;
+		PCI_SET_ADDR_TOKEN(res, busno + 1);
+	}
+	return res;
+}
+
+static void celleb_iounmap(volatile void __iomem *addr)
+{
+	return __iounmap(PCI_FIX_ADDR(addr));
+}
+
+static struct ppc_pci_io celleb_pci_io __initdata = {
+	.readb = celleb_readb,
+	.readw = celleb_readw,
+	.readl = celleb_readl,
+	.readq = celleb_readq,
+	.readw_be = celleb_readw_be,
+	.readl_be = celleb_readl_be,
+	.readq_be = celleb_readq_be,
+	.readsb = celleb_readsb,
+	.readsw = celleb_readsw,
+	.readsl = celleb_readsl,
+	.memcpy_fromio = celleb_memcpy_fromio,
+};
+
+void __init celleb_pci_add_one(struct pci_controller *phb,
+			       void (*dummy_read)(struct pci_controller *))
+{
+	struct celleb_pci_bus *bus = &celleb_pci_busses[celleb_pci_count];
+	struct device_node *np = phb->arch_data;
+
+	if (celleb_pci_count >= MAX_CELLEB_PCI_BUS) {
+		printk(KERN_ERR "Too many pci bridges, workarounds"
+		       " disabled for %s\n", np->full_name);
+		return;
+	}
+
+	celleb_pci_count++;
+
+	bus->phb = phb;
+	bus->dummy_read = dummy_read;
+}
+
+static struct of_device_id celleb_pci_workaround_match[] __initdata = {
+	{
+		.name = "pci-pseudo",
+		.data = fake_pci_workaround_init,
+	}, {
+		.name = "epci",
+		.data = epci_workaround_init,
+	}, {
+	},
+};
+
+int __init celleb_pci_workaround_init(void)
+{
+	struct pci_controller *phb;
+	struct device_node *node;
+	const struct  of_device_id *match;
+	void (*init_func)(struct pci_controller *);
+
+	celleb_dummy_page_va = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!celleb_dummy_page_va) {
+		printk(KERN_ERR "Celleb: dummy read disabled."
+			"Alloc celleb_dummy_page_va failed\n");
+		return 1;
+	}
+
+	list_for_each_entry(phb, &hose_list, list_node) {
+		node = phb->arch_data;
+		match = of_match_node(celleb_pci_workaround_match, node);
+
+		if (match) {
+			init_func = match->data;
+			(*init_func)(phb);
+		}
+	}
+
+	ppc_pci_io = celleb_pci_io;
+	ppc_md.ioremap = celleb_ioremap;
+	ppc_md.iounmap = celleb_iounmap;
+
+	return 0;
+}
Index: linux-powerpc-git/arch/powerpc/platforms/celleb/Kconfig
===================================================================
--- linux-powerpc-git.orig/arch/powerpc/platforms/celleb/Kconfig
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/Kconfig
@@ -2,6 +2,7 @@ config PPC_CELLEB
 	bool "Toshiba's Cell Reference Set 'Celleb' Architecture"
 	depends on PPC_MULTIPLATFORM && PPC64
 	select PPC_CELL
+	select PPC_INDIRECT_IO
 	select PPC_OF_PLATFORM_PCI
 	select HAS_TXX9_SERIAL
 	select PPC_UDBG_BEAT
