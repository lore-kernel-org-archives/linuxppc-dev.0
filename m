Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 60CCEDDDD8
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 08:49:58 +1000 (EST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id l8BMnqQv016884
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 17:49:53 -0500
To: "linuxppc-dev" <linuxppc-dev@ozlabs.org>
From: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: [PATCH] [RFC][POWERPC] Merge 32 and 64 bit
	pci_process_bridge_OF_ranges() instances
Date: Wed, 12 Sep 2007 02:49:52 +0400
Message-ID: <20070911224952.9838.46644.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


We are having 2 different instances of pci_process_bridge_OF_ranges(),
which makes describing 64-bit physical addresses in non PPC64 case
impossible.

This approach inherits pci space parsing, but has a new way to behave
equally good in both 32bit and 64bit environments. This approach uses
of_translate_address(), so implies proper ranges <> definition in
devicetree, where PCI node has its reg on soc bus, and its ranges
effectively belong to LAW addresses.

Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>
Signed-off-by: Stefan Roese <sr@denx.de>

---

 arch/powerpc/kernel/pci-common.c |  130 ++++++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/pci_32.c     |  114 ---------------------------------
 arch/powerpc/kernel/pci_64.c     |   94 ---------------------------
 include/asm-powerpc/ppc-pci.h    |    7 ++
 4 files changed, 137 insertions(+), 208 deletions(-)


diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 083cfbd..c0efd6d 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -478,3 +478,133 @@ void pci_resource_to_user(const struct pci_dev *dev, int bar,
 	*start = rsrc->start - offset;
 	*end = rsrc->end - offset;
 }
+
+void __devinit pci_process_bridge_OF_ranges(struct pci_controller *hose,
+					    struct device_node *dev, int prim)
+{
+	const unsigned int *ranges;
+	unsigned int pci_space;
+	u64 size = 0, pci_addr;
+	int rlen = 0;
+	int ranges_amnt, i, j, np;
+	int memno = 0;
+	struct resource *res;
+	int na = of_n_addr_cells(dev);
+	struct ranges_pci *ranges64 = NULL;
+	phys_addr_t cpu_phys_addr;
+
+	np = na + 5;
+
+	/* From "PCI Binding to 1275"
+	 * The ranges property is laid out as an array of elements,
+	 * each of which comprises:
+	 *   cells 0 - 2:       a PCI address
+	 *   cells 3 or 3+4:    a CPU physical address
+	 *                      (size depending on dev->n_addr_cells)
+	 *   cells 4+5 or 5+6:  the size of the range
+	 */
+	ranges = of_get_property(dev, "ranges", &rlen);
+	if (!ranges)
+		return;
+	/* Map ranges to struct according to spec. */
+	ranges64 = (void *)ranges;
+	ranges_amnt = rlen / sizeof(*ranges64);
+
+	hose->io_base_phys = 0;
+	for (i = 0; i < ranges_amnt; i++) {
+		u32 *addr_ptr;
+		res = NULL;
+
+		if (ranges64[i].pci_space == 0)
+			continue;
+
+		pci_space = ranges64[i].pci_space;
+		pci_addr = ranges64[i].pci_addr;
+		addr_ptr = (u32 *)(&ranges64[i].phys_addr);
+		cpu_phys_addr =
+			(phys_addr_t)of_translate_address(dev, addr_ptr);
+		size = ranges64[i].size;
+
+		DBG("Observed: pci %llx phys %llx size %llx\n", pci_addr,
+				cpu_phys_addr, size);
+
+		/* here we need to handle contiguous ranges */
+		for (j = i+1; j < ranges_amnt; j++) {
+			/* no need to coalesce different region types  */
+			if (ranges64[j].pci_space != pci_space)
+				break;
+			/* not contiguous. give up. */
+			if (ranges64[j].pci_addr != pci_addr + size ||
+				ranges64[j].phys_addr != cpu_phys_addr + size)
+				break;
+			size += ranges64[j].size;
+			i = j; /* skip this one next turn */
+		}
+		switch ((pci_space >> 24) & 0x3) {
+		case 1:	/* I/O space */
+#ifdef CONFIG_PPC32
+			/*
+			 * check from ppc32 pci implementation.
+			 * This seems just wrong. -vitb
+			 */
+			if (pci_addr != 0)
+				break;
+#endif
+			/* limit I/O space to 16MB */
+			if (size > 0x01000000)
+				size = 0x01000000;
+
+			hose->io_base_phys = cpu_phys_addr - pci_addr;
+			/* handle from 0 to top of I/O window */
+#ifdef CONFIG_PPC64
+			hose->pci_io_size = pci_addr + size;
+#endif
+			hose->io_base_virt = ioremap(hose->io_base_phys, size);
+#ifdef CONFIG_PPC32
+			if (prim)
+				isa_io_base = (unsigned long)hose->io_base_virt;
+#endif
+			res = &hose->io_resource;
+			res->flags = IORESOURCE_IO;
+			res->start = pci_addr;
+			DBG("phb%d: IO 0x%llx -> 0x%llx\n", hose->global_number,
+				(u64) res->start,
+				(u64) (res->start + size - 1));
+			DBG("IO phys %llx IO virt %p\n",
+				(u64) hose->io_base_phys, hose->io_base_virt);
+			break;
+		case 2:	/* memory space */
+			memno = 0;
+#ifdef CONFIG_PPC32
+			if ((pci_addr == 0) && (size <= (16 << 20))) {
+				/* 1st 16MB, i.e. ISA memory area */
+				if (prim)
+					isa_mem_base = cpu_phys_addr;
+				memno = 1;
+			}
+#endif
+			while (memno < 3 && hose->mem_resources[memno].flags)
+				++memno;
+
+			if (memno == 0)
+				hose->pci_mem_offset = cpu_phys_addr - pci_addr;
+			if (memno < 3) {
+				res = &hose->mem_resources[memno];
+				res->flags = IORESOURCE_MEM;
+				res->start = cpu_phys_addr;
+				DBG("phb%d: MEM 0x%llx -> 0x%llx\n",
+						hose->global_number, res->start,
+						res->start + size - 1);
+			}
+			break;
+		}
+		if (res != NULL) {
+			res->name = dev->full_name;
+			res->end = res->start + size - 1;
+			res->parent = NULL;
+			res->sibling = NULL;
+			res->child = NULL;
+		}
+	}
+}
+
diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index 0e2bee4..dc519e1 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -843,120 +843,6 @@ pci_device_from_OF_node(struct device_node* node, u8* bus, u8* devfn)
 }
 EXPORT_SYMBOL(pci_device_from_OF_node);
 
-void __init
-pci_process_bridge_OF_ranges(struct pci_controller *hose,
-			   struct device_node *dev, int primary)
-{
-	static unsigned int static_lc_ranges[256] __initdata;
-	const unsigned int *dt_ranges;
-	unsigned int *lc_ranges, *ranges, *prev, size;
-	int rlen = 0, orig_rlen;
-	int memno = 0;
-	struct resource *res;
-	int np, na = of_n_addr_cells(dev);
-	np = na + 5;
-
-	/* First we try to merge ranges to fix a problem with some pmacs
-	 * that can have more than 3 ranges, fortunately using contiguous
-	 * addresses -- BenH
-	 */
-	dt_ranges = of_get_property(dev, "ranges", &rlen);
-	if (!dt_ranges)
-		return;
-	/* Sanity check, though hopefully that never happens */
-	if (rlen > sizeof(static_lc_ranges)) {
-		printk(KERN_WARNING "OF ranges property too large !\n");
-		rlen = sizeof(static_lc_ranges);
-	}
-	lc_ranges = static_lc_ranges;
-	memcpy(lc_ranges, dt_ranges, rlen);
-	orig_rlen = rlen;
-
-	/* Let's work on a copy of the "ranges" property instead of damaging
-	 * the device-tree image in memory
-	 */
-	ranges = lc_ranges;
-	prev = NULL;
-	while ((rlen -= np * sizeof(unsigned int)) >= 0) {
-		if (prev) {
-			if (prev[0] == ranges[0] && prev[1] == ranges[1] &&
-				(prev[2] + prev[na+4]) == ranges[2] &&
-				(prev[na+2] + prev[na+4]) == ranges[na+2]) {
-				prev[na+4] += ranges[na+4];
-				ranges[0] = 0;
-				ranges += np;
-				continue;
-			}
-		}
-		prev = ranges;
-		ranges += np;
-	}
-
-	/*
-	 * The ranges property is laid out as an array of elements,
-	 * each of which comprises:
-	 *   cells 0 - 2:	a PCI address
-	 *   cells 3 or 3+4:	a CPU physical address
-	 *			(size depending on dev->n_addr_cells)
-	 *   cells 4+5 or 5+6:	the size of the range
-	 */
-	ranges = lc_ranges;
-	rlen = orig_rlen;
-	while (ranges && (rlen -= np * sizeof(unsigned int)) >= 0) {
-		res = NULL;
-		size = ranges[na+4];
-		switch ((ranges[0] >> 24) & 0x3) {
-		case 1:		/* I/O space */
-			if (ranges[2] != 0)
-				break;
-			hose->io_base_phys = ranges[na+2];
-			/* limit I/O space to 16MB */
-			if (size > 0x01000000)
-				size = 0x01000000;
-			hose->io_base_virt = ioremap(ranges[na+2], size);
-			if (primary)
-				isa_io_base = (unsigned long) hose->io_base_virt;
-			res = &hose->io_resource;
-			res->flags = IORESOURCE_IO;
-			res->start = ranges[2];
-			DBG("PCI: IO 0x%llx -> 0x%llx\n",
-			    (u64)res->start, (u64)res->start + size - 1);
-			break;
-		case 2:		/* memory space */
-			memno = 0;
-			if (ranges[1] == 0 && ranges[2] == 0
-			    && ranges[na+4] <= (16 << 20)) {
-				/* 1st 16MB, i.e. ISA memory area */
-				if (primary)
-					isa_mem_base = ranges[na+2];
-				memno = 1;
-			}
-			while (memno < 3 && hose->mem_resources[memno].flags)
-				++memno;
-			if (memno == 0)
-				hose->pci_mem_offset = ranges[na+2] - ranges[2];
-			if (memno < 3) {
-				res = &hose->mem_resources[memno];
-				res->flags = IORESOURCE_MEM;
-				if(ranges[0] & 0x40000000)
-					res->flags |= IORESOURCE_PREFETCH;
-				res->start = ranges[na+2];
-				DBG("PCI: MEM[%d] 0x%llx -> 0x%llx\n", memno,
-				    (u64)res->start, (u64)res->start + size - 1);
-			}
-			break;
-		}
-		if (res != NULL) {
-			res->name = dev->full_name;
-			res->end = res->start + size - 1;
-			res->parent = NULL;
-			res->sibling = NULL;
-			res->child = NULL;
-		}
-		ranges += np;
-	}
-}
-
 /* We create the "pci-OF-bus-map" property now so it appears in the
  * /proc device tree
  */
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 291ffbc..68bce38 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -592,100 +592,6 @@ int pci_proc_domain(struct pci_bus *bus)
 	}
 }
 
-void __devinit pci_process_bridge_OF_ranges(struct pci_controller *hose,
-					    struct device_node *dev, int prim)
-{
-	const unsigned int *ranges;
-	unsigned int pci_space;
-	unsigned long size;
-	int rlen = 0;
-	int memno = 0;
-	struct resource *res;
-	int np, na = of_n_addr_cells(dev);
-	unsigned long pci_addr, cpu_phys_addr;
-
-	np = na + 5;
-
-	/* From "PCI Binding to 1275"
-	 * The ranges property is laid out as an array of elements,
-	 * each of which comprises:
-	 *   cells 0 - 2:	a PCI address
-	 *   cells 3 or 3+4:	a CPU physical address
-	 *			(size depending on dev->n_addr_cells)
-	 *   cells 4+5 or 5+6:	the size of the range
-	 */
-	ranges = of_get_property(dev, "ranges", &rlen);
-	if (ranges == NULL)
-		return;
-	hose->io_base_phys = 0;
-	while ((rlen -= np * sizeof(unsigned int)) >= 0) {
-		res = NULL;
-		pci_space = ranges[0];
-		pci_addr = ((unsigned long)ranges[1] << 32) | ranges[2];
-		cpu_phys_addr = of_translate_address(dev, &ranges[3]);
-		size = ((unsigned long)ranges[na+3] << 32) | ranges[na+4];
-		ranges += np;
-		if (size == 0)
-			continue;
-
-		/* Now consume following elements while they are contiguous */
-		while (rlen >= np * sizeof(unsigned int)) {
-			unsigned long addr, phys;
-
-			if (ranges[0] != pci_space)
-				break;
-			addr = ((unsigned long)ranges[1] << 32) | ranges[2];
-			phys = ranges[3];
-			if (na >= 2)
-				phys = (phys << 32) | ranges[4];
-			if (addr != pci_addr + size ||
-			    phys != cpu_phys_addr + size)
-				break;
-
-			size += ((unsigned long)ranges[na+3] << 32)
-				| ranges[na+4];
-			ranges += np;
-			rlen -= np * sizeof(unsigned int);
-		}
-
-		switch ((pci_space >> 24) & 0x3) {
-		case 1:		/* I/O space */
-			hose->io_base_phys = cpu_phys_addr - pci_addr;
-			/* handle from 0 to top of I/O window */
-			hose->pci_io_size = pci_addr + size;
-
-			res = &hose->io_resource;
-			res->flags = IORESOURCE_IO;
-			res->start = pci_addr;
-			DBG("phb%d: IO 0x%lx -> 0x%lx\n", hose->global_number,
-				    res->start, res->start + size - 1);
-			break;
-		case 2:		/* memory space */
-			memno = 0;
-			while (memno < 3 && hose->mem_resources[memno].flags)
-				++memno;
-
-			if (memno == 0)
-				hose->pci_mem_offset = cpu_phys_addr - pci_addr;
-			if (memno < 3) {
-				res = &hose->mem_resources[memno];
-				res->flags = IORESOURCE_MEM;
-				res->start = cpu_phys_addr;
-				DBG("phb%d: MEM 0x%lx -> 0x%lx\n", hose->global_number,
-					    res->start, res->start + size - 1);
-			}
-			break;
-		}
-		if (res != NULL) {
-			res->name = dev->full_name;
-			res->end = res->start + size - 1;
-			res->parent = NULL;
-			res->sibling = NULL;
-			res->child = NULL;
-		}
-	}
-}
-
 #ifdef CONFIG_HOTPLUG
 
 int pcibios_unmap_io_space(struct pci_bus *bus)
diff --git a/include/asm-powerpc/ppc-pci.h b/include/asm-powerpc/ppc-pci.h
index b847aa1..882b8bc 100644
--- a/include/asm-powerpc/ppc-pci.h
+++ b/include/asm-powerpc/ppc-pci.h
@@ -15,6 +15,13 @@
 #include <linux/pci.h>
 #include <asm/pci-bridge.h>
 
+struct ranges_pci {
+	unsigned int pci_space;
+	u64 pci_addr;
+	phys_addr_t phys_addr;
+	u64 size;
+} __attribute__((packed));
+
 extern unsigned long isa_io_base;
 
 extern void pci_setup_phb_io(struct pci_controller *hose, int primary);
