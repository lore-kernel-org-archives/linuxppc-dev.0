Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx2.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 55F84DDE3A
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Mar 2008 23:20:42 +1100 (EST)
Date: Fri, 14 Mar 2008 21:20:34 +0900 (JST)
Message-Id: <20080314.212034.-1625856941.kouish@swc.toshiba.co.jp>
To: paulus@samba.org
Subject: [PATCH 2/11] cell: generalize io-workarounds code
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

This patch splits cell io-workaround code into spider-pci dependent
code and a generic part, and also adds interfaces to the generic
io-workaround mechanism.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
---

Please test on CellBlade because I don't have any access to CellBlade.


 arch/powerpc/platforms/cell/Makefile         |    3 
 arch/powerpc/platforms/cell/io-workarounds.c |  365 +++++++--------------------
 arch/powerpc/platforms/cell/io-workarounds.h |   45 +++
 arch/powerpc/platforms/cell/spider-pci.c     |  217 ++++++++++++++++
 include/asm-powerpc/io-defs.h                |  107 +++----
 include/asm-powerpc/io.h                     |    8 
 6 files changed, 427 insertions(+), 318 deletions(-)

Index: b/arch/powerpc/platforms/cell/Makefile
===================================================================
--- a/arch/powerpc/platforms/cell/Makefile	2008-03-10 14:11:58.000000000 +0900
+++ b/arch/powerpc/platforms/cell/Makefile	2008-03-10 14:13:25.000000000 +0900
@@ -1,6 +1,7 @@
 obj-$(CONFIG_PPC_CELL_NATIVE)		+= interrupt.o iommu.o setup.o \
 					   cbe_regs.o spider-pic.o \
-					   pervasive.o pmu.o io-workarounds.o
+					   pervasive.o pmu.o io-workarounds.o \
+					   spider-pci.o
 obj-$(CONFIG_CBE_RAS)			+= ras.o
 
 obj-$(CONFIG_CBE_THERM)			+= cbe_thermal.o
Index: b/arch/powerpc/platforms/cell/io-workarounds.c
===================================================================
--- a/arch/powerpc/platforms/cell/io-workarounds.c	2008-03-10 14:11:58.000000000 +0900
+++ b/arch/powerpc/platforms/cell/io-workarounds.c	2008-03-10 14:13:25.000000000 +0900
@@ -1,343 +1,188 @@
 /*
+ * Support PCI IO workaround
+ *
  *  Copyright (C) 2006 Benjamin Herrenschmidt <benh@kernel.crashing.org>
  *		       IBM, Corp.
+ *  (C) Copyright 2007-2008 TOSHIBA CORPORATION
  *
  * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
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
  */
+
 #undef DEBUG
 
 #include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/pci.h>
-#include <asm/io.h>
+
 #include <asm/machdep.h>
-#include <asm/pci-bridge.h>
+#include <asm/pgtable.h>
 #include <asm/ppc-pci.h>
+#include <asm/io.h>
 
+#include "io-workarounds.h"
 
-#define SPIDER_PCI_REG_BASE		0xd000
-#define SPIDER_PCI_VCI_CNTL_STAT	0x0110
-#define SPIDER_PCI_DUMMY_READ		0x0810
-#define SPIDER_PCI_DUMMY_READ_BASE	0x0814
-
-/* Undefine that to re-enable bogus prefetch
- *
- * Without that workaround, the chip will do bogus prefetch past
- * page boundary from system memory. This setting will disable that,
- * though the documentation is unclear as to the consequences of doing
- * so, either purely performances, or possible misbehaviour... It's not
- * clear wether the chip can handle unaligned accesses at all without
- * prefetching enabled.
- *
- * For now, things appear to be behaving properly with that prefetching
- * disabled and IDE, possibly because IDE isn't doing any unaligned
- * access.
- */
-#define SPIDER_DISABLE_PREFETCH
-
-#define MAX_SPIDERS	3
+#define IOWA_MAX_BUS	8
 
-static struct spider_pci_bus {
-	void __iomem	*regs;
-	unsigned long	mmio_start;
-	unsigned long	mmio_end;
-	unsigned long	pio_vstart;
-	unsigned long	pio_vend;
-} spider_pci_busses[MAX_SPIDERS];
-static int spider_pci_count;
+static struct iowa_bus iowa_busses[IOWA_MAX_BUS];
+static unsigned int iowa_bus_count;
 
-static struct spider_pci_bus *spider_pci_find(unsigned long vaddr,
-					      unsigned long paddr)
+static struct iowa_bus *iowa_pci_find(unsigned long vaddr, unsigned long paddr)
 {
-	int i;
+	int i, j;
+	struct resource *res;
 
-	for (i = 0; i < spider_pci_count; i++) {
-		struct spider_pci_bus *bus = &spider_pci_busses[i];
-		if (paddr && paddr >= bus->mmio_start && paddr < bus->mmio_end)
-			return bus;
-		if (vaddr && vaddr >= bus->pio_vstart && vaddr < bus->pio_vend)
+	for (i = 0; i < iowa_bus_count; i++) {
+		struct iowa_bus *bus = &iowa_busses[i];
+		struct pci_controller *phb = bus->phb;
+
+		if (vaddr && vaddr >= bus->pio_vstart && vaddr <= bus->pio_vend)
 			return bus;
+
+		if (paddr)
+			for (j = 0; j < 3; j++) {
+				res = &phb->mem_resources[j];
+				if (paddr >= res->start && paddr <= res->end)
+					return bus;
+			}
 	}
+
 	return NULL;
 }
 
-static void spider_io_flush(const volatile void __iomem *addr)
+struct iowa_bus *iowa_mem_find_bus(const PCI_IO_ADDR addr)
 {
-	struct spider_pci_bus *bus;
+	struct iowa_bus *bus;
 	int token;
 
-	/* Get platform token (set by ioremap) from address */
 	token = PCI_GET_ADDR_TOKEN(addr);
 
-	/* Fast path if we have a non-0 token, it indicates which bus we
-	 * are on.
-	 *
-	 * If the token is 0, that means either that the ioremap was done
-	 * before we initialized this layer, or it's a PIO operation. We
-	 * fallback to a low path in this case. Hopefully, internal devices
-	 * which are ioremap'ed early should use in_XX/out_XX functions
-	 * instead of the PCI ones and thus not suffer from the slowdown.
-	 *
-	 * Also note that currently, the workaround will not work for areas
-	 * that are not mapped with PTEs (bolted in the hash table). This
-	 * is the case for ioremaps done very early at boot (before
-	 * mem_init_done) and includes the mapping of the ISA IO space.
-	 *
-	 * Fortunately, none of the affected devices is expected to do DMA
-	 * and thus there should be no problem in practice.
-	 *
-	 * In order to improve performances, we only do the PTE search for
-	 * addresses falling in the PHB IO space area. That means it will
-	 * not work for hotplug'ed PHBs but those don't exist with Spider.
-	 */
-	if (token && token <= spider_pci_count)
-		bus = &spider_pci_busses[token - 1];
+	if (token && token <= iowa_bus_count)
+		bus = &iowa_busses[token - 1];
 	else {
 		unsigned long vaddr, paddr;
 		pte_t *ptep;
 
-		/* Fixup physical address */
 		vaddr = (unsigned long)PCI_FIX_ADDR(addr);
+		if (vaddr < PHB_IO_BASE || vaddr >= PHB_IO_END)
+			return NULL;
 
-		/* Check if it's in allowed range for  PIO */
-		if (vaddr < PHB_IO_BASE || vaddr > PHB_IO_END)
-			return;
-
-		/* Try to find a PTE. If not, clear the paddr, we'll do
-		 * a vaddr only lookup (PIO only)
-		 */
 		ptep = find_linux_pte(init_mm.pgd, vaddr);
 		if (ptep == NULL)
 			paddr = 0;
 		else
 			paddr = pte_pfn(*ptep) << PAGE_SHIFT;
+		bus = iowa_pci_find(vaddr, paddr);
 
-		bus = spider_pci_find(vaddr, paddr);
 		if (bus == NULL)
-			return;
+			return NULL;
 	}
 
-	/* Now do the workaround
-	 */
-	(void)in_be32(bus->regs + SPIDER_PCI_DUMMY_READ);
+	return bus;
 }
 
-static u8 spider_readb(const volatile void __iomem *addr)
+struct iowa_bus *iowa_pio_find_bus(unsigned long port)
 {
-	u8 val = __do_readb(addr);
-	spider_io_flush(addr);
-	return val;
+	unsigned long vaddr = (unsigned long)pci_io_base + port;
+	return iowa_pci_find(vaddr, 0);
 }
 
-static u16 spider_readw(const volatile void __iomem *addr)
-{
-	u16 val = __do_readw(addr);
-	spider_io_flush(addr);
-	return val;
-}
 
-static u32 spider_readl(const volatile void __iomem *addr)
-{
-	u32 val = __do_readl(addr);
-	spider_io_flush(addr);
-	return val;
+#define DEF_PCI_AC_RET(name, ret, at, al, space, aa)		\
+static ret iowa_##name at					\
+{								\
+	struct iowa_bus *bus;					\
+	bus = iowa_##space##_find_bus(aa);			\
+	if (bus && bus->ops && bus->ops->name)			\
+		return bus->ops->name al;			\
+	return __do_##name al;					\
 }
 
-static u64 spider_readq(const volatile void __iomem *addr)
-{
-	u64 val = __do_readq(addr);
-	spider_io_flush(addr);
-	return val;
+#define DEF_PCI_AC_NORET(name, at, al, space, aa)		\
+static void iowa_##name at					\
+{								\
+	struct iowa_bus *bus;					\
+	bus = iowa_##space##_find_bus(aa);			\
+	if (bus && bus->ops && bus->ops->name) {		\
+		bus->ops->name al;				\
+		return;						\
+	}							\
+	__do_##name al;						\
 }
 
-static u16 spider_readw_be(const volatile void __iomem *addr)
-{
-	u16 val = __do_readw_be(addr);
-	spider_io_flush(addr);
-	return val;
-}
+#include <asm/io-defs.h>
 
-static u32 spider_readl_be(const volatile void __iomem *addr)
-{
-	u32 val = __do_readl_be(addr);
-	spider_io_flush(addr);
-	return val;
-}
+#undef DEF_PCI_AC_RET
+#undef DEF_PCI_AC_NORET
 
-static u64 spider_readq_be(const volatile void __iomem *addr)
-{
-	u64 val = __do_readq_be(addr);
-	spider_io_flush(addr);
-	return val;
-}
-
-static void spider_readsb(const volatile void __iomem *addr, void *buf,
-			  unsigned long count)
-{
-	__do_readsb(addr, buf, count);
-	spider_io_flush(addr);
-}
+static struct ppc_pci_io __initdata iowa_pci_io = {
 
-static void spider_readsw(const volatile void __iomem *addr, void *buf,
-			  unsigned long count)
-{
-	__do_readsw(addr, buf, count);
-	spider_io_flush(addr);
-}
+#define DEF_PCI_AC_RET(name, ret, at, al, space, aa)	.name = iowa_##name,
+#define DEF_PCI_AC_NORET(name, at, al, space, aa)	.name = iowa_##name,
 
-static void spider_readsl(const volatile void __iomem *addr, void *buf,
-			  unsigned long count)
-{
-	__do_readsl(addr, buf, count);
-	spider_io_flush(addr);
-}
+#include <asm/io-defs.h>
 
-static void spider_memcpy_fromio(void *dest, const volatile void __iomem *src,
-				 unsigned long n)
-{
-	__do_memcpy_fromio(dest, src, n);
-	spider_io_flush(src);
-}
+#undef DEF_PCI_AC_RET
+#undef DEF_PCI_AC_NORET
 
+};
 
-static void __iomem * spider_ioremap(unsigned long addr, unsigned long size,
-				     unsigned long flags)
+static void __iomem *iowa_ioremap(unsigned long addr, unsigned long size,
+						unsigned long flags)
 {
-	struct spider_pci_bus *bus;
+	struct iowa_bus *bus;
 	void __iomem *res = __ioremap(addr, size, flags);
 	int busno;
 
-	pr_debug("spider_ioremap(0x%lx, 0x%lx, 0x%lx) -> 0x%p\n",
-		 addr, size, flags, res);
-
-	bus = spider_pci_find(0, addr);
+	bus = iowa_pci_find(0, addr);
 	if (bus != NULL) {
-		busno = bus - spider_pci_busses;
-		pr_debug(" found bus %d, setting token\n", busno);
+		busno = bus - iowa_busses;
 		PCI_SET_ADDR_TOKEN(res, busno + 1);
 	}
-	pr_debug(" result=0x%p\n", res);
-
 	return res;
 }
 
-static void __init spider_pci_setup_chip(struct spider_pci_bus *bus)
-{
-#ifdef SPIDER_DISABLE_PREFETCH
-	u32 val = in_be32(bus->regs + SPIDER_PCI_VCI_CNTL_STAT);
-	pr_debug(" PVCI_Control_Status was 0x%08x\n", val);
-	out_be32(bus->regs + SPIDER_PCI_VCI_CNTL_STAT, val | 0x8);
-#endif
-
-	/* Configure the dummy address for the workaround */
-	out_be32(bus->regs + SPIDER_PCI_DUMMY_READ_BASE, 0x80000000);
-}
-
-static void __init spider_pci_add_one(struct pci_controller *phb)
+/* Regist new bus to support workaround */
+void __init iowa_register_bus(struct pci_controller *phb,
+			struct ppc_pci_io *ops,
+			int (*initfunc)(struct iowa_bus *, void *), void *data)
 {
-	struct spider_pci_bus *bus = &spider_pci_busses[spider_pci_count];
+	struct iowa_bus *bus;
 	struct device_node *np = phb->dn;
-	struct resource rsrc;
-	void __iomem *regs;
 
-	if (spider_pci_count >= MAX_SPIDERS) {
-		printk(KERN_ERR "Too many spider bridges, workarounds"
-		       " disabled for %s\n", np->full_name);
+	if (iowa_bus_count >= IOWA_MAX_BUS) {
+		pr_err("IOWA:Too many pci bridges, "
+		       "workarounds disabled for %s\n", np->full_name);
 		return;
 	}
 
-	/* Get the registers for the beast */
-	if (of_address_to_resource(np, 0, &rsrc)) {
-		printk(KERN_ERR "Failed to get registers for spider %s"
-		       " workarounds disabled\n", np->full_name);
-		return;
-	}
-
-	/* Mask out some useless bits in there to get to the base of the
-	 * spider chip
-	 */
-	rsrc.start &= ~0xfffffffful;
-
-	/* Map them */
-	regs = ioremap(rsrc.start + SPIDER_PCI_REG_BASE, 0x1000);
-	if (regs == NULL) {
-		printk(KERN_ERR "Failed to map registers for spider %s"
-		       " workarounds disabled\n", np->full_name);
-		return;
-	}
-
-	spider_pci_count++;
-
-	/* We assume spiders only have one MMIO resource */
-	bus->mmio_start = phb->mem_resources[0].start;
-	bus->mmio_end = phb->mem_resources[0].end + 1;
-
+	bus = &iowa_busses[iowa_bus_count];
+	bus->phb = phb;
+	bus->ops = ops;
 	bus->pio_vstart = (unsigned long)phb->io_base_virt;
-	bus->pio_vend = bus->pio_vstart + phb->pci_io_size;
+	bus->pio_vend = bus->pio_vstart + phb->pci_io_size - 1;
 
-	bus->regs = regs;
-
-	printk(KERN_INFO "PCI: Spider MMIO workaround for %s\n",np->full_name);
+	if (initfunc)
+		if ((*initfunc)(bus, data))
+			return;
 
-	pr_debug(" mmio (P) = 0x%016lx..0x%016lx\n",
-		 bus->mmio_start, bus->mmio_end);
-	pr_debug("  pio (V) = 0x%016lx..0x%016lx\n",
-		 bus->pio_vstart, bus->pio_vend);
-	pr_debug(" regs (P) = 0x%016lx (V) = 0x%p\n",
-		 rsrc.start + SPIDER_PCI_REG_BASE, bus->regs);
+	iowa_bus_count++;
 
-	spider_pci_setup_chip(bus);
+	pr_debug("IOWA:[%d]Add bus, %s.\n", iowa_bus_count-1, np->full_name);
 }
 
-static struct ppc_pci_io __initdata spider_pci_io = {
-	.readb = spider_readb,
-	.readw = spider_readw,
-	.readl = spider_readl,
-	.readq = spider_readq,
-	.readw_be = spider_readw_be,
-	.readl_be = spider_readl_be,
-	.readq_be = spider_readq_be,
-	.readsb = spider_readsb,
-	.readsw = spider_readsw,
-	.readsl = spider_readsl,
-	.memcpy_fromio = spider_memcpy_fromio,
-};
-
-static int __init spider_pci_workaround_init(void)
+/* enable IO workaround */
+void __init io_workaround_init(void)
 {
-	struct pci_controller *phb;
-
-	/* Find spider bridges. We assume they have been all probed
-	 * in setup_arch(). If that was to change, we would need to
-	 * update this code to cope with dynamically added busses
-	 */
-	list_for_each_entry(phb, &hose_list, list_node) {
-		struct device_node *np = phb->dn;
-		const char *model = of_get_property(np, "model", NULL);
-
-		/* If no model property or name isn't exactly "pci", skip */
-		if (model == NULL || strcmp(np->name, "pci"))
-			continue;
-		/* If model is not "Spider", skip */
-		if (strcmp(model, "Spider"))
-			continue;
-		spider_pci_add_one(phb);
-	}
-
-	/* No Spider PCI found, exit */
-	if (spider_pci_count == 0)
-		return 0;
-
-	/* Setup IO callbacks. We only setup MMIO reads. PIO reads will
-	 * fallback to MMIO reads (though without a token, thus slower)
-	 */
-	ppc_pci_io = spider_pci_io;
-
-	/* Setup ioremap callback */
-	ppc_md.ioremap = spider_ioremap;
-
-	return 0;
+	ppc_pci_io = iowa_pci_io;
+	ppc_md.ioremap = iowa_ioremap;
 }
-machine_arch_initcall(cell, spider_pci_workaround_init);
Index: b/arch/powerpc/platforms/cell/io-workarounds.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ b/arch/powerpc/platforms/cell/io-workarounds.h	2008-03-10 14:13:25.000000000 +0900
@@ -0,0 +1,45 @@
+/*
+ * Support PCI IO workaround
+ *
+ * (C) Copyright 2007-2008 TOSHIBA CORPORATION
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
+#ifndef _IO_WORKAROUNDS_H
+#define _IO_WORKAROUNDS_H
+
+#include <asm/io.h>
+#include <asm/pci-bridge.h>
+
+/* Bus info */
+struct iowa_bus {
+	struct pci_controller *phb;
+	struct ppc_pci_io *ops;
+	unsigned long pio_vstart;
+	unsigned long pio_vend;
+	void   *private;
+};
+
+void __init io_workaround_init(void);
+void __init iowa_register_bus(struct pci_controller *, struct ppc_pci_io *,
+			      int (*)(struct iowa_bus *, void *), void *);
+struct iowa_bus *iowa_mem_find_bus(const PCI_IO_ADDR);
+struct iowa_bus *iowa_pio_find_bus(unsigned long);
+
+extern struct ppc_pci_io spiderpci_ops;
+int spiderpci_iowa_init(struct iowa_bus *, void *);
+
+#endif /* _IO_WORKAROUNDS_H */
Index: b/arch/powerpc/platforms/cell/spider-pci.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ b/arch/powerpc/platforms/cell/spider-pci.c	2008-03-10 14:13:25.000000000 +0900
@@ -0,0 +1,217 @@
+/*
+ * IO workarounds for PCI on Celleb/Cell platform
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
+#undef DEBUG
+
+#include <linux/kernel.h>
+
+#include <asm/ppc-pci.h>
+#include <asm/pci-bridge.h>
+#include <asm/io.h>
+
+#include "io-workarounds.h"
+
+#undef SPIDER_PCI_DISABLE_PREFETCH
+
+#define SPIDER_PCI_REG_BASE		0xd000
+#define SPIDER_PCI_REG_SIZE		0x1000
+#define SPIDER_PCI_VCI_CNTL_STAT	0x0110
+#define SPIDER_PCI_DUMMY_READ		0x0810
+#define SPIDER_PCI_DUMMY_READ_BASE	0x0814
+
+struct spiderpci_iowa_private {
+	void __iomem *regs;
+};
+
+static void spiderpci_io_flush(struct iowa_bus *bus)
+{
+	struct spiderpci_iowa_private *priv;
+	u32 val;
+
+	priv = bus->private;
+	val = in_be32(priv->regs + SPIDER_PCI_DUMMY_READ);
+	iosync();
+}
+
+#define SPIDER_PCI_MMIO_READ(name, ret)					\
+static ret spiderpci_##name(const PCI_IO_ADDR addr)			\
+{									\
+	ret val = __do_##name(addr);					\
+	spiderpci_io_flush(iowa_mem_find_bus(addr));			\
+	return val;							\
+}
+
+#define SPIDER_PCI_MMIO_READ_STR(name)					\
+static void spiderpci_##name(const PCI_IO_ADDR addr, void *buf, 	\
+			     unsigned long count)			\
+{									\
+	__do_##name(addr, buf, count);					\
+	spiderpci_io_flush(iowa_mem_find_bus(addr));			\
+}
+
+SPIDER_PCI_MMIO_READ(readb, u8)
+SPIDER_PCI_MMIO_READ(readw, u16)
+SPIDER_PCI_MMIO_READ(readl, u32)
+SPIDER_PCI_MMIO_READ(readq, u64)
+SPIDER_PCI_MMIO_READ(readw_be, u16)
+SPIDER_PCI_MMIO_READ(readl_be, u32)
+SPIDER_PCI_MMIO_READ(readq_be, u64)
+SPIDER_PCI_MMIO_READ_STR(readsb)
+SPIDER_PCI_MMIO_READ_STR(readsw)
+SPIDER_PCI_MMIO_READ_STR(readsl)
+
+static void spiderpci_memcpy_fromio(void *dest, const PCI_IO_ADDR src,
+				    unsigned long n)
+{
+	__do_memcpy_fromio(dest, src, n);
+	spiderpci_io_flush(iowa_mem_find_bus(src));
+}
+
+static int __init spiderpci_pci_setup_chip(struct pci_controller *phb,
+					   void __iomem *regs)
+{
+	void *dummy_page_va;
+	dma_addr_t dummy_page_da;
+
+#ifdef SPIDER_PCI_DISABLE_PREFETCH
+	u32 val = in_be32(regs + SPIDER_PCI_VCI_CNTL_STAT);
+	pr_debug("SPIDER_IOWA:PVCI_Control_Status was 0x%08x\n", val);
+	out_be32(regs + SPIDER_PCI_VCI_CNTL_STAT, val | 0x8);
+#endif /* SPIDER_PCI_DISABLE_PREFETCH */
+
+	/* setup dummy read */
+	/*
+	 * On CellBlade, we can't know that which XDR memory is used by
+	 * kmalloc() to allocate dummy_page_va.
+	 * In order to imporve the performance, the XDR which is used to
+	 * allocate dummy_page_va is the nearest the spider-pci.
+	 * We have to select the CBE which is the nearest the spider-pci
+	 * to allocate memory from the best XDR, but I don't know that
+	 * how to do.
+	 *
+	 * Celleb does not have this problem, because it has only one XDR.
+	 */
+	dummy_page_va = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!dummy_page_va) {
+		pr_err("SPIDERPCI-IOWA:Alloc dummy_page_va failed.\n");
+		return -1;
+	}
+
+	dummy_page_da = dma_map_single(phb->parent, dummy_page_va,
+				       PAGE_SIZE, DMA_FROM_DEVICE);
+	if (dma_mapping_error(dummy_page_da)) {
+		pr_err("SPIDER-IOWA:Map dummy page filed.\n");
+		kfree(dummy_page_va);
+		return -1;
+	}
+
+	out_be32(regs + SPIDER_PCI_DUMMY_READ_BASE, dummy_page_da);
+
+	return 0;
+}
+
+int __init spiderpci_iowa_init(struct iowa_bus *bus, void *data)
+{
+	void __iomem *regs = NULL;
+	struct spiderpci_iowa_private *priv;
+	struct device_node *np = bus->phb->dn;
+	struct resource r;
+	unsigned long offset = (unsigned long)data;
+
+	pr_debug("SPIDERPCI-IOWA:Bus initialize for spider(%s)\n",
+		 np->full_name);
+
+	priv = kzalloc(sizeof(struct spiderpci_iowa_private), GFP_KERNEL);
+	if (!priv) {
+		pr_err("SPIDERPCI-IOWA:"
+		       "Can't allocate struct spiderpci_iowa_private");
+		return -1;
+	}
+
+	if (of_address_to_resource(np, 0, &r)) {
+		pr_err("SPIDERPCI-IOWA:Can't get resource.\n");
+		goto error;
+	}
+
+	regs = ioremap(r.start + offset, SPIDER_PCI_REG_SIZE);
+	if (!regs) {
+		pr_err("SPIDERPCI-IOWA:ioremap failed.\n");
+		goto error;
+	}
+	priv->regs = regs;
+	bus->private = priv;
+
+	if (spiderpci_pci_setup_chip(bus->phb, regs))
+		goto error;
+
+	return 0;
+
+error:
+	kfree(priv);
+	bus->private = NULL;
+
+	if (regs)
+		iounmap(regs);
+
+	return -1;
+}
+
+struct ppc_pci_io spiderpci_ops = {
+	.readb = spiderpci_readb,
+	.readw = spiderpci_readw,
+	.readl = spiderpci_readl,
+	.readq = spiderpci_readq,
+	.readw_be = spiderpci_readw_be,
+	.readl_be = spiderpci_readl_be,
+	.readq_be = spiderpci_readq_be,
+	.readsb = spiderpci_readsb,
+	.readsw = spiderpci_readsw,
+	.readsl = spiderpci_readsl,
+	.memcpy_fromio = spiderpci_memcpy_fromio,
+};
+
+/* We must setup the IOMMU before spider_io_workaround_init() is called. */
+static int __init spider_pci_workaround_init(void)
+{
+	struct pci_controller *phb;
+
+	/* Find spider bridges. We assume they have been all probed
+	 * in setup_arch(). If that was to change, we would need to
+	 * update this code to cope with dynamically added busses
+	 */
+	list_for_each_entry(phb, &hose_list, list_node) {
+		struct device_node *np = phb->dn;
+		const char *model = of_get_property(np, "model", NULL);
+
+		/* If no model property or name isn't exactly "pci", skip */
+		if (model == NULL || strcmp(np->name, "pci"))
+			continue;
+		/* If model is not "Spider", skip */
+		if (strcmp(model, "Spider"))
+			continue;
+		iowa_register_bus(phb, &spiderpci_ops, &spiderpci_iowa_init,
+				  (void *)SPIDER_PCI_REG_BASE);
+	}
+
+	io_workaround_init();
+
+	return 0;
+}
+machine_arch_initcall_sync(cell, spider_pci_workaround_init);
Index: b/include/asm-powerpc/io-defs.h
===================================================================
--- a/include/asm-powerpc/io-defs.h	2008-03-10 14:11:58.000000000 +0900
+++ b/include/asm-powerpc/io-defs.h	2008-03-10 14:13:25.000000000 +0900
@@ -1,59 +1,60 @@
 /* This file is meant to be include multiple times by other headers */
+/* last 2 argments are used by platforms/cell/io-workarounds.[ch] */
 
-DEF_PCI_AC_RET(readb, u8, (const PCI_IO_ADDR addr), (addr))
-DEF_PCI_AC_RET(readw, u16, (const PCI_IO_ADDR addr), (addr))
-DEF_PCI_AC_RET(readl, u32, (const PCI_IO_ADDR addr), (addr))
-DEF_PCI_AC_RET(readw_be, u16, (const PCI_IO_ADDR addr), (addr))
-DEF_PCI_AC_RET(readl_be, u32, (const PCI_IO_ADDR addr), (addr))
-DEF_PCI_AC_NORET(writeb, (u8 val, PCI_IO_ADDR addr), (val, addr))
-DEF_PCI_AC_NORET(writew, (u16 val, PCI_IO_ADDR addr), (val, addr))
-DEF_PCI_AC_NORET(writel, (u32 val, PCI_IO_ADDR addr), (val, addr))
-DEF_PCI_AC_NORET(writew_be, (u16 val, PCI_IO_ADDR addr), (val, addr))
-DEF_PCI_AC_NORET(writel_be, (u32 val, PCI_IO_ADDR addr), (val, addr))
+DEF_PCI_AC_RET(readb, u8, (const PCI_IO_ADDR addr), (addr), mem, addr)
+DEF_PCI_AC_RET(readw, u16, (const PCI_IO_ADDR addr), (addr), mem, addr)
+DEF_PCI_AC_RET(readl, u32, (const PCI_IO_ADDR addr), (addr), mem, addr)
+DEF_PCI_AC_RET(readw_be, u16, (const PCI_IO_ADDR addr), (addr), mem, addr)
+DEF_PCI_AC_RET(readl_be, u32, (const PCI_IO_ADDR addr), (addr), mem, addr)
+DEF_PCI_AC_NORET(writeb, (u8 val, PCI_IO_ADDR addr), (val, addr), mem, addr)
+DEF_PCI_AC_NORET(writew, (u16 val, PCI_IO_ADDR addr), (val, addr), mem, addr)
+DEF_PCI_AC_NORET(writel, (u32 val, PCI_IO_ADDR addr), (val, addr), mem, addr)
+DEF_PCI_AC_NORET(writew_be, (u16 val, PCI_IO_ADDR addr), (val, addr), mem, addr)
+DEF_PCI_AC_NORET(writel_be, (u32 val, PCI_IO_ADDR addr), (val, addr), mem, addr)
 
 #ifdef __powerpc64__
-DEF_PCI_AC_RET(readq, u64, (const PCI_IO_ADDR addr), (addr))
-DEF_PCI_AC_RET(readq_be, u64, (const PCI_IO_ADDR addr), (addr))
-DEF_PCI_AC_NORET(writeq, (u64 val, PCI_IO_ADDR addr), (val, addr))
-DEF_PCI_AC_NORET(writeq_be, (u64 val, PCI_IO_ADDR addr), (val, addr))
+DEF_PCI_AC_RET(readq, u64, (const PCI_IO_ADDR addr), (addr), mem, addr)
+DEF_PCI_AC_RET(readq_be, u64, (const PCI_IO_ADDR addr), (addr), mem, addr)
+DEF_PCI_AC_NORET(writeq, (u64 val, PCI_IO_ADDR addr), (val, addr), mem, addr)
+DEF_PCI_AC_NORET(writeq_be, (u64 val, PCI_IO_ADDR addr), (val, addr), mem, addr)
 #endif /* __powerpc64__ */
 
-DEF_PCI_AC_RET(inb, u8, (unsigned long port), (port))
-DEF_PCI_AC_RET(inw, u16, (unsigned long port), (port))
-DEF_PCI_AC_RET(inl, u32, (unsigned long port), (port))
-DEF_PCI_AC_NORET(outb, (u8 val, unsigned long port), (val, port))
-DEF_PCI_AC_NORET(outw, (u16 val, unsigned long port), (val, port))
-DEF_PCI_AC_NORET(outl, (u32 val, unsigned long port), (val, port))
-
-DEF_PCI_AC_NORET(readsb, (const PCI_IO_ADDR a, void *b, unsigned long c), \
-		 (a, b, c))
-DEF_PCI_AC_NORET(readsw, (const PCI_IO_ADDR a, void *b, unsigned long c), \
-		 (a, b, c))
-DEF_PCI_AC_NORET(readsl, (const PCI_IO_ADDR a, void *b, unsigned long c), \
-		 (a, b, c))
-DEF_PCI_AC_NORET(writesb, (PCI_IO_ADDR a, const void *b, unsigned long c), \
-		 (a, b, c))
-DEF_PCI_AC_NORET(writesw, (PCI_IO_ADDR a, const void *b, unsigned long c), \
-		 (a, b, c))
-DEF_PCI_AC_NORET(writesl, (PCI_IO_ADDR a, const void *b, unsigned long c), \
-		 (a, b, c))
-
-DEF_PCI_AC_NORET(insb, (unsigned long p, void *b, unsigned long c), \
-		 (p, b, c))
-DEF_PCI_AC_NORET(insw, (unsigned long p, void *b, unsigned long c), \
-		 (p, b, c))
-DEF_PCI_AC_NORET(insl, (unsigned long p, void *b, unsigned long c), \
-		 (p, b, c))
-DEF_PCI_AC_NORET(outsb, (unsigned long p, const void *b, unsigned long c), \
-		 (p, b, c))
-DEF_PCI_AC_NORET(outsw, (unsigned long p, const void *b, unsigned long c), \
-		 (p, b, c))
-DEF_PCI_AC_NORET(outsl, (unsigned long p, const void *b, unsigned long c), \
-		 (p, b, c))
-
-DEF_PCI_AC_NORET(memset_io, (PCI_IO_ADDR a, int c, unsigned long n),	   \
-		 (a, c, n))
-DEF_PCI_AC_NORET(memcpy_fromio,(void *d,const PCI_IO_ADDR s,unsigned long n), \
-		 (d, s, n))
-DEF_PCI_AC_NORET(memcpy_toio,(PCI_IO_ADDR d,const void *s,unsigned long n),   \
-		 (d, s, n))
+DEF_PCI_AC_RET(inb, u8, (unsigned long port), (port), pio, port)
+DEF_PCI_AC_RET(inw, u16, (unsigned long port), (port), pio, port)
+DEF_PCI_AC_RET(inl, u32, (unsigned long port), (port), pio, port)
+DEF_PCI_AC_NORET(outb, (u8 val, unsigned long port), (val, port), pio, port)
+DEF_PCI_AC_NORET(outw, (u16 val, unsigned long port), (val, port), pio, port)
+DEF_PCI_AC_NORET(outl, (u32 val, unsigned long port), (val, port), pio, port)
+
+DEF_PCI_AC_NORET(readsb, (const PCI_IO_ADDR a, void *b, unsigned long c),
+		 (a, b, c), mem, a)
+DEF_PCI_AC_NORET(readsw, (const PCI_IO_ADDR a, void *b, unsigned long c),
+		 (a, b, c), mem, a)
+DEF_PCI_AC_NORET(readsl, (const PCI_IO_ADDR a, void *b, unsigned long c),
+		 (a, b, c), mem, a)
+DEF_PCI_AC_NORET(writesb, (PCI_IO_ADDR a, const void *b, unsigned long c),
+		 (a, b, c), mem, a)
+DEF_PCI_AC_NORET(writesw, (PCI_IO_ADDR a, const void *b, unsigned long c),
+		 (a, b, c), mem, a)
+DEF_PCI_AC_NORET(writesl, (PCI_IO_ADDR a, const void *b, unsigned long c),
+		 (a, b, c), mem, a)
+
+DEF_PCI_AC_NORET(insb, (unsigned long p, void *b, unsigned long c),
+		 (p, b, c), pio, p)
+DEF_PCI_AC_NORET(insw, (unsigned long p, void *b, unsigned long c),
+		 (p, b, c), pio, p)
+DEF_PCI_AC_NORET(insl, (unsigned long p, void *b, unsigned long c),
+		 (p, b, c), pio, p)
+DEF_PCI_AC_NORET(outsb, (unsigned long p, const void *b, unsigned long c),
+		 (p, b, c), pio, p)
+DEF_PCI_AC_NORET(outsw, (unsigned long p, const void *b, unsigned long c),
+		 (p, b, c), pio, p)
+DEF_PCI_AC_NORET(outsl, (unsigned long p, const void *b, unsigned long c),
+		 (p, b, c), pio, p)
+
+DEF_PCI_AC_NORET(memset_io, (PCI_IO_ADDR a, int c, unsigned long n),
+		 (a, c, n), mem, a)
+DEF_PCI_AC_NORET(memcpy_fromio, (void *d, const PCI_IO_ADDR s, unsigned long n),
+		 (d, s, n), mem, s)
+DEF_PCI_AC_NORET(memcpy_toio, (PCI_IO_ADDR d, const void *s, unsigned long n),
+		 (d, s, n), mem, d)
Index: b/include/asm-powerpc/io.h
===================================================================
--- a/include/asm-powerpc/io.h	2008-03-10 14:11:58.000000000 +0900
+++ b/include/asm-powerpc/io.h	2008-03-10 14:13:25.000000000 +0900
@@ -458,8 +458,8 @@
 /* Structure containing all the hooks */
 extern struct ppc_pci_io {
 
-#define DEF_PCI_AC_RET(name, ret, at, al)	ret (*name) at;
-#define DEF_PCI_AC_NORET(name, at, al)		void (*name) at;
+#define DEF_PCI_AC_RET(name, ret, at, al, space, aa)	ret (*name) at;
+#define DEF_PCI_AC_NORET(name, at, al, space, aa)	void (*name) at;
 
 #include <asm/io-defs.h>
 
@@ -469,7 +469,7 @@
 } ppc_pci_io;
 
 /* The inline wrappers */
-#define DEF_PCI_AC_RET(name, ret, at, al)			\
+#define DEF_PCI_AC_RET(name, ret, at, al, space, aa)		\
 static inline ret name at					\
 {								\
 	if (DEF_PCI_HOOK(ppc_pci_io.name) != NULL)		\
@@ -477,7 +477,7 @@
 	return __do_##name al;					\
 }
 
-#define DEF_PCI_AC_NORET(name, at, al)				\
+#define DEF_PCI_AC_NORET(name, at, al, space, aa)		\
 static inline void name at					\
 {								\
 	if (DEF_PCI_HOOK(ppc_pci_io.name) != NULL)		\
