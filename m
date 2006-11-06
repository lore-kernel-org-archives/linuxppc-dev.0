Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 06 Nov 2006 18:05:56 +1100
Subject: [PATCH 24/27] powerpc: Cell "Spider" MMIO workarounds
In-Reply-To: <1162796738.274582.277491064706.qpush@grosgo>
Message-Id: <20061106070712.4876E67DA7@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is totally untested, I just put it together quickly, but gives an
example of how the hooks can be used which is why I introduced it in
this serie. Hopefully, I'll test & fix it up properly this week.

This patch implements a workaround for a Spider PCI host bridge bug
where it doesn't enforce some of the PCI ordering rules unless some
manual manipulation of a special register is done. In order to be
fully compliant with the PCI spec, I do this on every MMIO read
operation.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 arch/powerpc/Kconfig                         |    1 
 arch/powerpc/platforms/cell/Makefile         |    3 
 arch/powerpc/platforms/cell/io-workarounds.c |  205 +++++++++++++++++++++++++++
 3 files changed, 208 insertions(+), 1 deletion(-)

Index: linux-cell/arch/powerpc/platforms/cell/io-workarounds.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/arch/powerpc/platforms/cell/io-workarounds.c	2006-11-06 15:47:42.000000000 +1100
@@ -0,0 +1,205 @@
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/pci.h>
+#include <asm/io.h>
+#include <asm/machdep.h>
+#include <asm/pci-bridge.h>
+#include <asm/ppc-pci.h>
+
+#define MAX_SPIDERS	2
+
+static struct spider_pci_bus {
+	void __iomem	*dummy_reg;
+	unsigned long	mmio_start;
+	unsigned long	mmio_end;
+	unsigned long	pio_vstart;
+	unsigned long	pio_vend;
+} spider_pci_busses[MAX_SPIDERS];
+static int spider_pci_count;
+
+static struct spider_pci_bus *spider_pci_find(unsigned long vaddr,
+					      unsigned long paddr)
+{
+	int i;
+
+	for (i = 0; i < spider_pci_count; i++) {
+		struct spider_pci_bus *bus = &spider_pci_busses[i];
+		if (paddr && paddr >= bus->mmio_start && paddr < bus->mmio_end)
+			return bus;
+		if (vaddr && vaddr >= bus->pio_vstart && vaddr < bus->pio_vend)
+			return bus;
+	}
+	return NULL;
+}
+
+static void spider_io_flush(const volatile void __iomem *addr)
+{
+	struct spider_pci_bus *bus;
+	int token;
+
+	/* Fast path if we have a token, else we need to
+	 * translate the virtual address and do a linear
+	 * search
+	 */
+	token = PCI_GET_ADDR_TOKEN(addr);
+	if (token)
+		bus = &spider_pci_busses[token - 1];
+	else {
+		unsigned long vaddr, paddr;
+		pte_t *ptep;
+
+		/* Fixup physical address */
+		vaddr = (unsigned long)PCI_FIX_ADDR(addr);
+
+		/* Check if it's in allowed range for MMIO and PIO */
+		if (vaddr < VMALLOC_START || vaddr >= IMALLOC_END)
+			return;
+
+		/* Try to find a PTE. If not, clear the paddr, we'll do
+		 * a vaddr only lookup (PIO only)
+		 */
+		ptep = find_linux_pte(init_mm.pgd, vaddr);
+		if (ptep == NULL)
+			paddr = 0;
+		else
+			paddr = pte_pfn(*ptep) << PAGE_SHIFT;
+		bus = spider_pci_find(vaddr, paddr);
+		if (bus == NULL)
+			return;
+	}
+
+	/* Now do the workaround (yuck). Dbl-check what we are doing
+	 * here, spec is unclear to me
+	 */
+	out_le32(bus->dummy_reg, 0x80000000);
+	(void)in_le32(bus->dummy_reg + 4);
+}
+
+static u8 spider_readb(const volatile void __iomem *addr)
+{
+	u8 val = __do_readb(addr);
+	spider_io_flush(addr);
+	return val;
+}
+
+static u16 spider_readw(const volatile void __iomem *addr)
+{
+	u16 val = __do_readw(addr);
+	spider_io_flush(addr);
+	return val;
+}
+
+static u32 spider_readl(const volatile void __iomem *addr)
+{
+	u32 val = __do_readl(addr);
+	spider_io_flush(addr);
+	return val;
+}
+
+static u64 spider_readq(const volatile void __iomem *addr)
+{
+	u64 val = __do_readq(addr);
+	spider_io_flush(addr);
+	return val;
+}
+
+static void spider_memcpy_fromio(void *dest, const volatile void __iomem *src,
+				 unsigned long n)
+{
+	__do_memcpy_fromio(dest, src, n);
+	spider_io_flush(src);
+}
+
+
+static void __iomem * spider_ioremap(unsigned long addr, unsigned long size,
+				     unsigned long flags)
+{
+	struct spider_pci_bus *bus;
+	void __iomem *res = __ioremap(addr, size, flags);
+
+	bus = spider_pci_find(0, addr);
+	if (bus != NULL)
+		PCI_SET_ADDR_TOKEN(res, bus - spider_pci_busses + 1);
+	return res;
+}
+
+static void __init spider_pci_add_one(struct pci_controller *phb)
+{
+	struct spider_pci_bus *bus = &spider_pci_busses[spider_pci_count];
+	struct device_node *np = phb->arch_data;
+	struct resource rsrc;
+	void __iomem *regs;
+
+	if (spider_pci_count >= MAX_SPIDERS) {
+		printk(KERN_ERR "Too many spider bridges, workarounds"
+		       " disabled for %s\n", np->full_name);
+		return;
+	}
+
+	/* Get the registers for the beast */
+	if (of_address_to_resource(np, 0, &rsrc)) {
+		printk(KERN_ERR "Failed to get registers for spider %s"
+		       " workarounds disabled\n", np->full_name);
+		return;
+	}
+
+	/* Map them. XXX Dbl-check the registers, spec is unclear to me */
+	regs = ioremap(rsrc.start + 0xd810, 0x1000);
+	if (regs == NULL) {
+		printk(KERN_ERR "Failed to map registers for spider %s"
+		       " workarounds disabled\n", np->full_name);
+		return;
+	}
+
+	spider_pci_count++;
+
+	/* We assume spiders only have one MMIO resource */
+	bus->mmio_start = phb->mem_resources[0].start;
+	bus->mmio_end = phb->mem_resources[0].end + 1;
+
+	bus->pio_vstart = (unsigned long)phb->io_base_virt;
+	bus->pio_vend = bus->pio_vstart + phb->pci_io_size;
+
+	bus->dummy_reg = regs;
+}
+
+static int __init spider_pci_workaround_init(void)
+{
+	struct pci_controller *phb;
+
+	/* Find spider bridges. We assume they have been all probed
+	 * in setup_arch(). If that was to change, we would need to
+	 * update this code to cope with dynamically added busses
+	 */
+	list_for_each_entry(phb, &hose_list, list_node) {
+		struct device_node *np = phb->arch_data;
+		const char *model = get_property(np, "model", NULL);
+
+		/* If no model property or name isn't exactly "pci", skip */
+		if (model == NULL || strcmp(np->name, "pci"))
+			continue;
+		/* If model is not "Spider", skip */
+		if (strcmp(model, "Spider"))
+			continue;
+		spider_pci_add_one(phb);
+	}
+
+	/* No Spider PCI found, exit */
+	if (spider_pci_count == 0)
+		return 0;
+
+	/* Setup IO callbacks. We only setup MMIO reads. PIO reads will
+	 * fallback to MMIO reads (though without a token, thus slower)
+	 */
+	ppc_pci_io.readb = spider_readb;
+	ppc_pci_io.readw = spider_readw;
+	ppc_pci_io.readl = spider_readl;
+	ppc_pci_io.readq = spider_readq;
+	ppc_pci_io.memcpy_fromio = spider_memcpy_fromio;
+
+	/* Setup ioremap callback */
+	ppc_md.ioremap = spider_ioremap;
+
+	return 0;
+}
+arch_initcall(spider_pci_workaround_init);
Index: linux-cell/arch/powerpc/Kconfig
===================================================================
--- linux-cell.orig/arch/powerpc/Kconfig	2006-11-06 15:47:35.000000000 +1100
+++ linux-cell/arch/powerpc/Kconfig	2006-11-06 15:48:07.000000000 +1100
@@ -468,6 +468,7 @@ config PPC_CELL_NATIVE
 	select PPC_CELL
 	select PPC_DCR_MMIO
 	select PPC_OF_PLATFORM_PCI
+	select PPC_INDIRECT_IO
 	select MPIC
 	default n
 
Index: linux-cell/arch/powerpc/platforms/cell/Makefile
===================================================================
--- linux-cell.orig/arch/powerpc/platforms/cell/Makefile	2006-11-06 15:18:35.000000000 +1100
+++ linux-cell/arch/powerpc/platforms/cell/Makefile	2006-11-06 15:47:42.000000000 +1100
@@ -1,5 +1,6 @@
 obj-$(CONFIG_PPC_CELL_NATIVE)		+= interrupt.o iommu.o setup.o \
-					   cbe_regs.o spider-pic.o pervasive.o
+					   cbe_regs.o spider-pic.o \
+					   pervasive.o io-workarounds.o
 obj-$(CONFIG_CBE_RAS)			+= ras.o
 
 ifeq ($(CONFIG_SMP),y)
