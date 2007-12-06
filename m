Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 06 Dec 2007 19:00:01 +1100
Subject: [PATCH 2/25] powerpc: Merge pci_process_bridge_OF_ranges()
In-Reply-To: <1196927999.714593.205329520306.qpush@grosgo>
Message-Id: <20071206080113.49887DDE05@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch merges the 32 and 64 bits implementations of
pci_process_bridge_OF_ranges(). The new function is cleaner than both
the old ones supports 64 bits ranges on ppc32 which is necessary for
the 4xx port.

It also adds some better (hopefully) output to the kernel log which
should help disagnose problems and makes better use of existing OF
parsing helpers (avoiding a few bugs of both implementations along
the way).

There are still a few unfortunate ifdef's but there is no way around
these for now at least not until some other bits of the PCI code are
made common.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Tested on a few pSeries, PowerMac G5, and a 32 bits PowerMacs and
a BriQ. Please let me know if it misbehaves anywhere else.

 arch/powerpc/kernel/pci-common.c |  177 +++++++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/pci_32.c     |  114 -------------------------
 arch/powerpc/kernel/pci_64.c     |   93 --------------------
 include/asm-powerpc/pci-bridge.h |    1 
 4 files changed, 178 insertions(+), 207 deletions(-)

Index: linux-work/arch/powerpc/kernel/pci-common.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/pci-common.c	2007-12-03 12:00:58.000000000 +1100
+++ linux-work/arch/powerpc/kernel/pci-common.c	2007-12-03 12:01:55.000000000 +1100
@@ -479,3 +479,180 @@ void pci_resource_to_user(const struct p
 	*start = rsrc->start - offset;
 	*end = rsrc->end - offset;
 }
+
+/**
+ * pci_process_bridge_OF_ranges - Parse PCI bridge resources from device tree
+ * @hose: newly allocated pci_controller to be setup
+ * @dev: device node of the host bridge
+ * @primary: set if primary bus (32 bits only, soon to be deprecated)
+ *
+ * This function will parse the "ranges" property of a PCI host bridge device
+ * node and setup the resource mapping of a pci controller based on its
+ * content.
+ *
+ * Life would be boring if it wasn't for a few issues that we have to deal
+ * with here:
+ *
+ *   - We can only cope with one IO space range and up to 3 Memory space
+ *     ranges. However, some machines (thanks Apple !) tend to split their
+ *     space into lots of small contiguous ranges. So we have to coalesce.
+ *
+ *   - We can only cope with all memory ranges having the same offset
+ *     between CPU addresses and PCI addresses. Unfortunately, some bridges
+ *     are setup for a large 1:1 mapping along with a small "window" which
+ *     maps PCI address 0 to some arbitrary high address of the CPU space in
+ *     order to give access to the ISA memory hole.
+ *     The way out of here that I've chosen for now is to always set the
+ *     offset based on the first resource found, then override it if we
+ *     have a different offset and the previous was set by an ISA hole.
+ *
+ *   - Some busses have IO space not starting at 0, which causes trouble with
+ *     the way we do our IO resource renumbering. The code somewhat deals with
+ *     it for 64 bits but I would expect problems on 32 bits.
+ *
+ *   - Some 32 bits platforms such as 4xx can have physical space larger than
+ *     32 bits so we need to use 64 bits values for the parsing
+ */
+void __devinit pci_process_bridge_OF_ranges(struct pci_controller *hose,
+					    struct device_node *dev,
+					    int primary)
+{
+	const u32 *ranges;
+	int rlen;
+	int pna = of_n_addr_cells(dev);
+	int np = pna + 5;
+	int memno = 0, isa_hole = -1;
+	u32 pci_space;
+	unsigned long long pci_addr, cpu_addr, pci_next, cpu_next, size;
+	unsigned long long isa_mb = 0;
+	struct resource *res;
+
+	printk(KERN_INFO "PCI host bridge %s %s ranges:\n",
+	       dev->full_name, primary ? "(primary)" : "");
+
+	/* Get ranges property */
+	ranges = of_get_property(dev, "ranges", &rlen);
+	if (ranges == NULL)
+		return;
+
+	/* Parse it */
+	while ((rlen -= np * 4) >= 0) {
+		/* Read next ranges element */
+		pci_space = ranges[0];
+		pci_addr = of_read_number(ranges + 1, 2);
+		cpu_addr = of_translate_address(dev, ranges + 3);
+		size = of_read_number(ranges + pna + 3, 2);
+		ranges += np;
+		if (cpu_addr == OF_BAD_ADDR || size == 0)
+			continue;
+
+		/* Now consume following elements while they are contiguous */
+		for (; rlen >= np * sizeof(u32);
+		     ranges += np, rlen -= np * 4) {
+			if (ranges[0] != pci_space)
+				break;
+			pci_next = of_read_number(ranges + 1, 2);
+			cpu_next = of_translate_address(dev, ranges + 3);
+			if (pci_next != pci_addr + size ||
+			    cpu_next != cpu_addr + size)
+				break;
+			size += of_read_number(ranges + pna + 3, 2);
+		}
+
+		/* Act based on address space type */
+		res = NULL;
+		switch ((pci_space >> 24) & 0x3) {
+		case 1:		/* PCI IO space */
+			printk(KERN_INFO
+			       "  IO 0x%016llx..0x%016llx -> 0x%016llx\n",
+			       cpu_addr, cpu_addr + size - 1, pci_addr);
+
+			/* We support only one IO range */
+			if (hose->pci_io_size) {
+				printk(KERN_WARNING
+				       " \\--> Skipped (too many) !\n");
+				continue;
+			}
+#ifdef CONFIG_PPC32
+			/* On 32 bits, limit I/O space to 16MB */
+			if (size > 0x01000000)
+				size = 0x01000000;
+
+			/* 32 bits needs to map IOs here */
+			hose->io_base_virt = ioremap(cpu_addr, size);
+
+			/* Expect trouble if pci_addr is not 0 */
+			if (primary)
+				isa_io_base =
+					(unsigned long)hose->io_base_virt;
+#endif /* CONFIG_PPC32 */
+			/* pci_io_size and io_base_phys always represent IO
+			 * space starting at 0 so we factor in pci_addr
+			 */
+			hose->pci_io_size = pci_addr + size;
+			hose->io_base_phys = cpu_addr - pci_addr;
+
+			/* Build resource */
+			res = &hose->io_resource;
+			res->flags = IORESOURCE_IO;
+			res->start = pci_addr;
+			break;
+		case 2:		/* PCI Memory space */
+			printk(KERN_INFO
+			       " MEM 0x%016llx..0x%016llx -> 0x%016llx %s\n",
+			       cpu_addr, cpu_addr + size - 1, pci_addr,
+			       (pci_space & 0x40000000) ? "Prefetch" : "");
+
+			/* We support only 3 memory ranges */
+			if (memno >= 3) {
+				printk(KERN_WARNING
+				       " \\--> Skipped (too many) !\n");
+				continue;
+			}
+			/* Handles ISA memory hole space here */
+			if (pci_addr == 0) {
+				isa_mb = cpu_addr;
+				isa_hole = memno;
+				if (primary || isa_mem_base == 0)
+					isa_mem_base = cpu_addr;
+			}
+
+			/* We get the PCI/Mem offset from the first range or
+			 * the, current one if the offset came from an ISA
+			 * hole. If they don't match, bugger.
+			 */
+			if (memno == 0 ||
+			    (isa_hole >= 0 && pci_addr != 0 &&
+			     hose->pci_mem_offset == isa_mb))
+				hose->pci_mem_offset = cpu_addr - pci_addr;
+			else if (pci_addr != 0 &&
+				 hose->pci_mem_offset != cpu_addr - pci_addr) {
+				printk(KERN_WARNING
+				       " \\--> Skipped (offset mismatch) !\n");
+				continue;
+			}
+
+			/* Build resource */
+			res = &hose->mem_resources[memno++];
+			res->flags = IORESOURCE_MEM;
+			if (pci_space & 0x40000000)
+				res->flags |= IORESOURCE_PREFETCH;
+			res->start = cpu_addr;
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
+
+	/* Out of paranoia, let's put the ISA hole last if any */
+	if (isa_hole >= 0 && memno > 0 && isa_hole != (memno-1)) {
+		struct resource tmp = hose->mem_resources[isa_hole];
+		hose->mem_resources[isa_hole] = hose->mem_resources[memno-1];
+		hose->mem_resources[memno-1] = tmp;
+	}
+}
Index: linux-work/arch/powerpc/kernel/pci_32.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/pci_32.c	2007-12-03 12:00:58.000000000 +1100
+++ linux-work/arch/powerpc/kernel/pci_32.c	2007-12-03 12:01:02.000000000 +1100
@@ -842,120 +842,6 @@ pci_device_from_OF_node(struct device_no
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
Index: linux-work/arch/powerpc/kernel/pci_64.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/pci_64.c	2007-12-03 11:48:04.000000000 +1100
+++ linux-work/arch/powerpc/kernel/pci_64.c	2007-12-03 12:01:02.000000000 +1100
@@ -592,99 +592,6 @@ int pci_proc_domain(struct pci_bus *bus)
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
 
 #ifdef CONFIG_HOTPLUG
 
Index: linux-work/include/asm-powerpc/pci-bridge.h
===================================================================
--- linux-work.orig/include/asm-powerpc/pci-bridge.h	2007-12-03 11:48:04.000000000 +1100
+++ linux-work/include/asm-powerpc/pci-bridge.h	2007-12-03 12:01:02.000000000 +1100
@@ -27,6 +27,7 @@ struct pci_controller {
 
 	void __iomem *io_base_virt;
 	resource_size_t io_base_phys;
+	resource_size_t pci_io_size;
 
 	/* Some machines (PReP) have a non 1:1 mapping of
 	 * the PCI memory space in the CPU bus space
