Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Mon, 01 May 2006 10:53:43 +1000
Subject: [RFC/PATCH 2/4] powerpc: Convert DBG to pr_debug in
	arch/powerpc/kernel
In-Reply-To: <1146444821.660434.518701003988.qpush@concordia>
Message-Id: <20060501005346.5431F67B18@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Convert DBG to pr_debug in arch/powerpc/kernel.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/kernel/crash.c         |    6 ---
 arch/powerpc/kernel/crash_dump.c    |   12 +------
 arch/powerpc/kernel/iommu.c         |   22 ++++++-------
 arch/powerpc/kernel/legacy_serial.c |   58 ++++++++++++++++--------------------
 arch/powerpc/kernel/pci_32.c        |   40 ++++++++++--------------
 arch/powerpc/kernel/pci_64.c        |   43 +++++++++++---------------
 arch/powerpc/kernel/prom.c          |   53 ++++++++++++++------------------
 arch/powerpc/kernel/prom_parse.c    |   28 ++++++-----------
 arch/powerpc/kernel/setup-common.c  |   21 ++++---------
 arch/powerpc/kernel/setup_32.c      |    4 +-
 arch/powerpc/kernel/setup_64.c      |   28 ++++++-----------
 arch/powerpc/kernel/smp.c           |   15 ++-------
 arch/powerpc/kernel/vdso.c          |   20 ++++--------
 13 files changed, 140 insertions(+), 210 deletions(-)

Index: to-merge/arch/powerpc/kernel/crash.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/crash.c
+++ to-merge/arch/powerpc/kernel/crash.c
@@ -31,13 +31,7 @@
 #include <asm/lmb.h>
 #include <asm/firmware.h>
 #include <asm/smp.h>
-
-#ifdef DEBUG
 #include <asm/udbg.h>
-#define DBG(fmt...) udbg_printf(fmt)
-#else
-#define DBG(fmt...)
-#endif
 
 /* This keeps a track of which one is crashing cpu. */
 int crashing_cpu = -1;
Index: to-merge/arch/powerpc/kernel/crash_dump.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/crash_dump.c
+++ to-merge/arch/powerpc/kernel/crash_dump.c
@@ -11,6 +11,7 @@
 
 #undef DEBUG
 
+#include <linux/kernel.h>
 #include <linux/crash_dump.h>
 #include <linux/bootmem.h>
 #include <asm/kdump.h>
@@ -18,13 +19,6 @@
 #include <asm/firmware.h>
 #include <asm/uaccess.h>
 
-#ifdef DEBUG
-#include <asm/udbg.h>
-#define DBG(fmt...) udbg_printf(fmt)
-#else
-#define DBG(fmt...)
-#endif
-
 static void __init create_trampoline(unsigned long addr)
 {
 	/* The maximum range of a single instruction branch, is the current
@@ -43,7 +37,7 @@ void __init kdump_setup(void)
 {
 	unsigned long i;
 
-	DBG(" -> kdump_setup()\n");
+	pr_debug(" -> kdump_setup()\n");
 
 	for (i = KDUMP_TRAMPOLINE_START; i < KDUMP_TRAMPOLINE_END; i += 8) {
 		create_trampoline(i);
@@ -52,7 +46,7 @@ void __init kdump_setup(void)
 	create_trampoline(__pa(system_reset_fwnmi) - PHYSICAL_START);
 	create_trampoline(__pa(machine_check_fwnmi) - PHYSICAL_START);
 
-	DBG(" <- kdump_setup()\n");
+	pr_debug(" <- kdump_setup()\n");
 }
 
 #ifdef CONFIG_PROC_VMCORE
Index: to-merge/arch/powerpc/kernel/iommu.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/iommu.c
+++ to-merge/arch/powerpc/kernel/iommu.c
@@ -22,7 +22,9 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
 
+#undef DEBUG
 
+#include <linux/kernel.h>
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/types.h>
@@ -39,8 +41,6 @@
 #include <asm/pci-bridge.h>
 #include <asm/machdep.h>
 
-#define DBG(...)
-
 #ifdef CONFIG_IOMMU_VMERGE
 static int novmerge = 0;
 #else
@@ -270,7 +270,7 @@ int iommu_map_sg(struct device *dev, str
 	/* Init first segment length for backout at failure */
 	outs->dma_length = 0;
 
-	DBG("mapping %d elements:\n", nelems);
+	pr_debug("mapping %d elements:\n", nelems);
 
 	spin_lock_irqsave(&(tbl->it_lock), flags);
 
@@ -289,7 +289,7 @@ int iommu_map_sg(struct device *dev, str
 		npages >>= PAGE_SHIFT;
 		entry = iommu_range_alloc(tbl, npages, &handle, mask >> PAGE_SHIFT, 0);
 
-		DBG("  - vaddr: %lx, size: %lx\n", vaddr, slen);
+		pr_debug("  - vaddr: %lx, size: %lx\n", vaddr, slen);
 
 		/* Handle failure */
 		if (unlikely(entry == DMA_ERROR_CODE)) {
@@ -304,7 +304,7 @@ int iommu_map_sg(struct device *dev, str
 		dma_addr = entry << PAGE_SHIFT;
 		dma_addr |= s->offset;
 
-		DBG("  - %lx pages, entry: %lx, dma_addr: %lx\n",
+		pr_debug("  - %lx pages, entry: %lx, dma_addr: %lx\n",
 			    npages, entry, dma_addr);
 
 		/* Insert into HW table */
@@ -312,7 +312,7 @@ int iommu_map_sg(struct device *dev, str
 
 		/* If we are in an open segment, try merging */
 		if (segstart != s) {
-			DBG("  - trying merge...\n");
+			pr_debug("  - trying merge...\n");
 			/* We cannot merge if:
 			 * - allocated dma_addr isn't contiguous to previous allocation
 			 */
@@ -320,16 +320,16 @@ int iommu_map_sg(struct device *dev, str
 				/* Can't merge: create a new segment */
 				segstart = s;
 				outcount++; outs++;
-				DBG("    can't merge, new segment.\n");
+				pr_debug("    can't merge, new segment.\n");
 			} else {
 				outs->dma_length += s->length;
-				DBG("    merged, new len: %lx\n", outs->dma_length);
+				pr_debug("    merged, new len: %lx\n", outs->dma_length);
 			}
 		}
 
 		if (segstart == s) {
 			/* This is a new segment, fill entries */
-			DBG("  - filling new segment.\n");
+			pr_debug("  - filling new segment.\n");
 			outs->dma_address = dma_addr;
 			outs->dma_length = slen;
 		}
@@ -337,7 +337,7 @@ int iommu_map_sg(struct device *dev, str
 		/* Calculate next page pointer for contiguous check */
 		dma_next = dma_addr + slen;
 
-		DBG("  - dma next is: %lx\n", dma_next);
+		pr_debug("  - dma next is: %lx\n", dma_next);
 	}
 
 	/* Flush/invalidate TLB caches if necessary */
@@ -346,7 +346,7 @@ int iommu_map_sg(struct device *dev, str
 
 	spin_unlock_irqrestore(&(tbl->it_lock), flags);
 
-	DBG("mapped %d elements:\n", outcount);
+	pr_debug("mapped %d elements:\n", outcount);
 
 	/* For the sake of iommu_unmap_sg, we clear out the length in the
 	 * next entry of the sglist if we didn't fill the list completely
Index: to-merge/arch/powerpc/kernel/legacy_serial.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/legacy_serial.c
+++ to-merge/arch/powerpc/kernel/legacy_serial.c
@@ -1,3 +1,5 @@
+#undef DEBUG
+
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/serial.h>
@@ -13,14 +15,6 @@
 #include <asm/pci-bridge.h>
 #include <asm/ppc-pci.h>
 
-#undef DEBUG
-
-#ifdef DEBUG
-#define DBG(fmt...) do { printk(fmt); } while(0)
-#else
-#define DBG(fmt...) do { } while(0)
-#endif
-
 #define MAX_LEGACY_SERIAL_PORTS	8
 
 static struct plat_serial8250_port
@@ -249,7 +243,7 @@ static void __init setup_legacy_serial_c
 		return;
 	if (info->speed == 0)
 		info->speed = udbg_probe_uart_speed(addr, info->clock);
-	DBG("default console speed = %d\n", info->speed);
+	pr_debug("default console speed = %d\n", info->speed);
 	udbg_init_uart(addr, info->speed, info->clock);
 }
 
@@ -268,16 +262,16 @@ void __init find_legacy_serial_ports(voi
 	char *path;
 	int index;
 
-	DBG(" -> find_legacy_serial_port()\n");
+	pr_debug(" -> find_legacy_serial_port()\n");
 
 	/* Now find out if one of these is out firmware console */
 	path = (char *)get_property(of_chosen, "linux,stdout-path", NULL);
 	if (path != NULL) {
 		stdout = of_find_node_by_path(path);
 		if (stdout)
-			DBG("stdout is %s\n", stdout->full_name);
+			pr_debug("stdout is %s\n", stdout->full_name);
 	} else {
-		DBG(" no linux,stdout-path !\n");
+		pr_debug(" no linux,stdout-path !\n");
 	}
 
 	/* First fill our array with SOC ports */
@@ -334,10 +328,10 @@ void __init find_legacy_serial_ports(voi
 	}
 #endif
 
-	DBG("legacy_serial_console = %d\n", legacy_serial_console);
+	pr_debug("legacy_serial_console = %d\n", legacy_serial_console);
 	if (legacy_serial_console >= 0)
 		setup_legacy_serial_console(legacy_serial_console);
-	DBG(" <- find_legacy_serial_port()\n");
+	pr_debug(" <- find_legacy_serial_port()\n");
 }
 
 static struct platform_device serial_device = {
@@ -352,12 +346,12 @@ static void __init fixup_port_irq(int in
 				  struct device_node *np,
 				  struct plat_serial8250_port *port)
 {
-	DBG("fixup_port_irq(%d)\n", index);
+	pr_debug("fixup_port_irq(%d)\n", index);
 
 	/* Check for interrupts in that node */
 	if (np->n_intrs > 0) {
 		port->irq = np->intrs[0].line;
-		DBG(" port %d (%s), irq=%d\n",
+		pr_debug(" port %d (%s), irq=%d\n",
 		    index, np->full_name, port->irq);
 		return;
 	}
@@ -369,7 +363,7 @@ static void __init fixup_port_irq(int in
 
 	if (np->n_intrs > 0) {
 		port->irq = np->intrs[0].line;
-		DBG(" port %d (%s), irq=%d\n",
+		pr_debug(" port %d (%s), irq=%d\n",
 		    index, np->full_name, port->irq);
 	}
 	of_node_put(np);
@@ -382,7 +376,7 @@ static void __init fixup_port_pio(int in
 #ifdef CONFIG_PCI
 	struct pci_controller *hose;
 
-	DBG("fixup_port_pio(%d)\n", index);
+	pr_debug("fixup_port_pio(%d)\n", index);
 
 	hose = pci_find_hose_for_OF_device(np);
 	if (hose) {
@@ -392,7 +386,7 @@ static void __init fixup_port_pio(int in
 #else
 			isa_io_base;
 #endif
-		DBG("port %d, IO %lx -> %lx\n",
+		pr_debug("port %d, IO %lx -> %lx\n",
 		    index, port->iobase, port->iobase + offset);
 		port->iobase += offset;
 	}
@@ -403,7 +397,7 @@ static void __init fixup_port_mmio(int i
 				   struct device_node *np,
 				   struct plat_serial8250_port *port)
 {
-	DBG("fixup_port_mmio(%d)\n", index);
+	pr_debug("fixup_port_mmio(%d)\n", index);
 
 	port->membase = ioremap(port->mapbase, 0x100);
 }
@@ -432,7 +426,7 @@ static int __init serial_dev_init(void)
 	 * Before we register the platfrom serial devices, we need
 	 * to fixup their interrutps and their IO ports.
 	 */
-	DBG("Fixing serial ports interrupts and IO ports ...\n");
+	pr_debug("Fixing serial ports interrupts and IO ports ...\n");
 
 	for (i = 0; i < legacy_serial_count; i++) {
 		struct plat_serial8250_port *port = &legacy_serial_ports[i];
@@ -446,7 +440,7 @@ static int __init serial_dev_init(void)
 			fixup_port_mmio(i, np, port);
 	}
 
-	DBG("Registering platform serial ports\n");
+	pr_debug("Registering platform serial ports\n");
 
 	return platform_device_register(&serial_device);
 }
@@ -468,40 +462,40 @@ static int __init check_legacy_serial_co
 	char *name;
 	u32 *spd;
 
-	DBG(" -> check_legacy_serial_console()\n");
+	pr_debug(" -> check_legacy_serial_console()\n");
 
 	/* The user has requested a console so this is already set up. */
 	if (strstr(saved_command_line, "console=")) {
-		DBG(" console was specified !\n");
+		pr_debug(" console was specified !\n");
 		return -EBUSY;
 	}
 
 	if (!of_chosen) {
-		DBG(" of_chosen is NULL !\n");
+		pr_debug(" of_chosen is NULL !\n");
 		return -ENODEV;
 	}
 
 	if (legacy_serial_console < 0) {
-		DBG(" legacy_serial_console not found !\n");
+		pr_debug(" legacy_serial_console not found !\n");
 		return -ENODEV;
 	}
 	/* We are getting a weird phandle from OF ... */
 	/* ... So use the full path instead */
 	name = (char *)get_property(of_chosen, "linux,stdout-path", NULL);
 	if (name == NULL) {
-		DBG(" no linux,stdout-path !\n");
+		pr_debug(" no linux,stdout-path !\n");
 		return -ENODEV;
 	}
 	prom_stdout = of_find_node_by_path(name);
 	if (!prom_stdout) {
-		DBG(" can't find stdout package %s !\n", name);
+		pr_debug(" can't find stdout package %s !\n", name);
 		return -ENODEV;
 	}
-	DBG("stdout is %s\n", prom_stdout->full_name);
+	pr_debug("stdout is %s\n", prom_stdout->full_name);
 
 	name = (char *)get_property(prom_stdout, "name", NULL);
 	if (!name) {
-		DBG(" stdout package has no name !\n");
+		pr_debug(" stdout package has no name !\n");
 		goto not_found;
 	}
 	spd = (u32 *)get_property(prom_stdout, "current-speed", NULL);
@@ -535,7 +529,7 @@ static int __init check_legacy_serial_co
 		goto not_found;
 	of_node_put(prom_stdout);
 
-	DBG("Found serial console at ttyS%d\n", offset);
+	pr_debug("Found serial console at ttyS%d\n", offset);
 
 	if (speed) {
 		static char __initdata opt[16];
@@ -545,7 +539,7 @@ static int __init check_legacy_serial_co
 		return add_preferred_console("ttyS", offset, NULL);
 
  not_found:
-	DBG("No preferred console found !\n");
+	pr_debug("No preferred console found !\n");
 	of_node_put(prom_stdout);
 	return -ENODEV;
 }
Index: to-merge/arch/powerpc/kernel/pci_32.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/pci_32.c
+++ to-merge/arch/powerpc/kernel/pci_32.c
@@ -2,6 +2,8 @@
  * Common pmac/prep/chrp pci routines. -- Cort
  */
 
+#undef DEBUG
+
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
@@ -23,14 +25,6 @@
 #include <asm/uaccess.h>
 #include <asm/machdep.h>
 
-#undef DEBUG
-
-#ifdef DEBUG
-#define DBG(x...) printk(x)
-#else
-#define DBG(x...)
-#endif
-
 unsigned long isa_io_base     = 0;
 unsigned long isa_mem_base    = 0;
 unsigned long pci_dram_offset = 0;
@@ -99,7 +93,7 @@ pcibios_fixup_resources(struct pci_dev *
 		if (!res->flags)
 			continue;
 		if (res->end == 0xffffffff) {
-			DBG("PCI:%s Resource %d [%08lx-%08lx] is unassigned\n",
+			pr_debug("PCI:%s Resource %d [%08lx-%08lx] is unassigned\n",
 			    pci_name(dev), i, res->start, res->end);
 			res->end -= res->start;
 			res->start = 0;
@@ -255,7 +249,7 @@ pcibios_allocate_bus_resources(struct li
 				}
 			}
 
-			DBG("PCI: bridge rsrc %lx..%lx (%lx), parent %p\n",
+			pr_debug("PCI: bridge rsrc %lx..%lx (%lx), parent %p\n",
 			    res->start, res->end, res->flags, pr);
 			if (pr) {
 				if (request_resource(pr, res) == 0)
@@ -306,7 +300,7 @@ reparent_resources(struct resource *pare
 	*pp = NULL;
 	for (p = res->child; p != NULL; p = p->sibling) {
 		p->parent = res;
-		DBG(KERN_INFO "PCI: reparented %s [%lx..%lx] under %s\n",
+		pr_debug(KERN_INFO "PCI: reparented %s [%lx..%lx] under %s\n",
 		    p->name, p->start, p->end, res->name);
 	}
 	return 0;
@@ -362,7 +356,7 @@ pci_relocate_bridge_resource(struct pci_
 		try = conflict->start - 1;
 	}
 	if (request_resource(pr, res)) {
-		DBG(KERN_ERR "PCI: huh? couldn't move to %lx..%lx\n",
+		pr_debug(KERN_ERR "PCI: huh? couldn't move to %lx..%lx\n",
 		    res->start, res->end);
 		return -1;		/* "can't happen" */
 	}
@@ -469,7 +463,7 @@ update_bridge_base(struct pci_bus *bus, 
 		pci_write_config_word(dev, PCI_PREF_MEMORY_LIMIT, mem_limit);
 
 	} else {
-		DBG(KERN_ERR "PCI: ugh, bridge %s res %d has flags=%lx\n",
+		pr_debug(KERN_ERR "PCI: ugh, bridge %s res %d has flags=%lx\n",
 		    pci_name(dev), i, res->flags);
 	}
 	pci_write_config_word(dev, PCI_COMMAND, cmd);
@@ -479,14 +473,14 @@ static inline void alloc_resource(struct
 {
 	struct resource *pr, *r = &dev->resource[idx];
 
-	DBG("PCI:%s: Resource %d: %08lx-%08lx (f=%lx)\n",
+	pr_debug("PCI:%s: Resource %d: %08lx-%08lx (f=%lx)\n",
 	    pci_name(dev), idx, r->start, r->end, r->flags);
 	pr = pci_find_parent_resource(dev, r);
 	if (!pr || request_resource(pr, r) < 0) {
 		printk(KERN_ERR "PCI: Cannot allocate resource region %d"
 		       " of device %s\n", idx, pci_name(dev));
 		if (pr)
-			DBG("PCI:  parent is %p: %08lx-%08lx (f=%lx)\n",
+			pr_debug("PCI:  parent is %p: %08lx-%08lx (f=%lx)\n",
 			    pr, pr->start, pr->end, pr->flags);
 		/* We'll assign a new address later */
 		r->flags |= IORESOURCE_UNSET;
@@ -524,7 +518,7 @@ pcibios_allocate_resources(int pass)
 		if (r->flags & IORESOURCE_ROM_ENABLE) {
 			/* Turn the ROM off, leave the resource region, but keep it unregistered. */
 			u32 reg;
-			DBG("PCI: Switching off ROM of %s\n", pci_name(dev));
+			pr_debug("PCI: Switching off ROM of %s\n", pci_name(dev));
 			r->flags &= ~IORESOURCE_ROM_ENABLE;
 			pci_read_config_dword(dev, dev->rom_base_reg, &reg);
 			pci_write_config_dword(dev, dev->rom_base_reg,
@@ -956,7 +950,7 @@ pci_process_bridge_OF_ranges(struct pci_
 			res = &hose->io_resource;
 			res->flags = IORESOURCE_IO;
 			res->start = ranges[2];
-			DBG("PCI: IO 0x%lx -> 0x%lx\n",
+			pr_debug("PCI: IO 0x%lx -> 0x%lx\n",
 				    res->start, res->start + size - 1);
 			break;
 		case 2:		/* memory space */
@@ -978,7 +972,7 @@ pci_process_bridge_OF_ranges(struct pci_
 				if(ranges[0] & 0x40000000)
 					res->flags |= IORESOURCE_PREFETCH;
 				res->start = ranges[na+2];
-				DBG("PCI: MEM[%d] 0x%lx -> 0x%lx\n", memno,
+				pr_debug("PCI: MEM[%d] 0x%lx -> 0x%lx\n", memno,
 					    res->start, res->start + size - 1);
 			}
 			break;
@@ -1071,10 +1065,10 @@ do_update_p2p_io_resource(struct pci_bus
 		return;
  	res = *(bus->resource[0]);
 
-	DBG("Remapping Bus %d, bridge: %s\n", bus->number, pci_name(bridge));
+	pr_debug("Remapping Bus %d, bridge: %s\n", bus->number, pci_name(bridge));
 	res.start -= ((unsigned long) hose->io_base_virt - isa_io_base);
 	res.end -= ((unsigned long) hose->io_base_virt - isa_io_base);
-	DBG("  IO window: %08lx-%08lx\n", res.start, res.end);
+	pr_debug("  IO window: %08lx-%08lx\n", res.start, res.end);
 
 	/* Set up the top and bottom of the PCI I/O segment for this bus. */
 	pci_read_config_dword(bridge, PCI_IO_BASE, &l);
@@ -1222,13 +1216,13 @@ do_fixup_p2p_level(struct pci_bus *bus)
 					continue;
 				if ((r->flags & IORESOURCE_IO) == 0)
 					continue;
-				DBG("Trying to allocate from %08lx, size %08lx from parent"
+				pr_debug("Trying to allocate from %08lx, size %08lx from parent"
 				    " res %d: %08lx -> %08lx\n",
 					res->start, res->end, i, r->start, r->end);
 			
 				if (allocate_resource(r, res, res->end + 1, res->start, max,
 				    res->end + 1, NULL, NULL) < 0) {
-					DBG("Failed !\n");
+					pr_debug("Failed !\n");
 					continue;
 				}
 				do_update_p2p_io_resource(b, found_vga);
@@ -1624,7 +1618,7 @@ pgprot_t pci_phys_mem_access_prot(struct
 		pci_dev_put(pdev);
 	}
 
-	DBG("non-PCI map for %lx, prot: %lx\n", offset, prot);
+	pr_debug("non-PCI map for %lx, prot: %lx\n", offset, prot);
 
 	return __pgprot(prot);
 }
Index: to-merge/arch/powerpc/kernel/pci_64.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/pci_64.c
+++ to-merge/arch/powerpc/kernel/pci_64.c
@@ -32,13 +32,6 @@
 #include <asm/machdep.h>
 #include <asm/ppc-pci.h>
 
-#ifdef DEBUG
-#include <asm/udbg.h>
-#define DBG(fmt...) printk(fmt)
-#else
-#define DBG(fmt...)
-#endif
-
 unsigned long pci_probe_only = 1;
 int pci_assign_all_buses = 0;
 
@@ -320,7 +313,7 @@ static void pci_parse_of_addrs(struct de
 	addrs = (u32 *) get_property(node, "assigned-addresses", &proplen);
 	if (!addrs)
 		return;
-	DBG("    parse addresses (%d bytes) @ %p\n", proplen, addrs);
+	pr_debug("    parse addresses (%d bytes) @ %p\n", proplen, addrs);
 	for (; proplen >= 20; proplen -= 20, addrs += 5) {
 		flags = pci_parse_of_flags(addrs[0]);
 		if (!flags)
@@ -330,7 +323,7 @@ static void pci_parse_of_addrs(struct de
 		if (!size)
 			continue;
 		i = addrs[0] & 0xff;
-		DBG("  base: %llx, size: %llx, i: %x\n",
+		pr_debug("  base: %llx, size: %llx, i: %x\n",
 		    (unsigned long long)base, (unsigned long long)size, i);
 
 		if (PCI_BASE_ADDRESS_0 <= i && i <= PCI_BASE_ADDRESS_5) {
@@ -363,7 +356,7 @@ struct pci_dev *of_create_pci_dev(struct
 	if (type == NULL)
 		type = "";
 
-	DBG("    create device, devfn: %x, type: %s\n", devfn, type);
+	pr_debug("    create device, devfn: %x, type: %s\n", devfn, type);
 
 	memset(dev, 0, sizeof(struct pci_dev));
 	dev->bus = bus;
@@ -384,7 +377,7 @@ struct pci_dev *of_create_pci_dev(struct
 		dev->bus->number, PCI_SLOT(devfn), PCI_FUNC(devfn));
 	dev->class = get_int_prop(node, "class-code", 0);
 
-	DBG("    class: 0x%x\n", dev->class);
+	pr_debug("    class: 0x%x\n", dev->class);
 
 	dev->current_state = 4;		/* unknown power state */
 
@@ -407,7 +400,7 @@ struct pci_dev *of_create_pci_dev(struct
 
 	pci_parse_of_addrs(node, dev);
 
-	DBG("    adding to system ...\n");
+	pr_debug("    adding to system ...\n");
 
 	pci_device_add(dev, bus);
 
@@ -425,10 +418,10 @@ void __devinit of_scan_bus(struct device
 	int reglen, devfn;
 	struct pci_dev *dev;
 
-	DBG("of_scan_bus(%s) bus no %d... \n", node->full_name, bus->number);
+	pr_debug("of_scan_bus(%s) bus no %d... \n", node->full_name, bus->number);
 
 	while ((child = of_get_next_child(node, child)) != NULL) {
-		DBG("  * %s\n", child->full_name);
+		pr_debug("  * %s\n", child->full_name);
 		reg = (u32 *) get_property(child, "reg", &reglen);
 		if (reg == NULL || reglen < 20)
 			continue;
@@ -438,7 +431,7 @@ void __devinit of_scan_bus(struct device
 		dev = of_create_pci_dev(child, bus, devfn);
 		if (!dev)
 			continue;
-		DBG("dev header type: %x\n", dev->hdr_type);
+		pr_debug("dev header type: %x\n", dev->hdr_type);
 
 		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
 		    dev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
@@ -459,7 +452,7 @@ void __devinit of_scan_pci_bridge(struct
 	unsigned int flags;
 	u64 size;
 
-	DBG("of_scan_pci_bridge(%s)\n", node->full_name);
+	pr_debug("of_scan_pci_bridge(%s)\n", node->full_name);
 
 	/* parse bus-range property */
 	busrange = (u32 *) get_property(node, "bus-range", &len);
@@ -524,12 +517,12 @@ void __devinit of_scan_pci_bridge(struct
 	}
 	sprintf(bus->name, "PCI Bus %04x:%02x", pci_domain_nr(bus),
 		bus->number);
-	DBG("    bus name: %s\n", bus->name);
+	pr_debug("    bus name: %s\n", bus->name);
 
 	mode = PCI_PROBE_NORMAL;
 	if (ppc_md.pci_probe_mode)
 		mode = ppc_md.pci_probe_mode(bus);
-	DBG("    probe mode: %d\n", mode);
+	pr_debug("    probe mode: %d\n", mode);
 
 	if (mode == PCI_PROBE_DEVTREE)
 		of_scan_bus(node, bus);
@@ -546,7 +539,7 @@ void __devinit scan_phb(struct pci_contr
 	int i, mode;
 	struct resource *res;
 
-	DBG("Scanning PHB %s\n", node ? node->full_name : "<NO NAME>");
+	pr_debug("Scanning PHB %s\n", node ? node->full_name : "<NO NAME>");
 
 	bus = pci_create_bus(NULL, hose->first_busno, hose->ops, node);
 	if (bus == NULL) {
@@ -574,7 +567,7 @@ void __devinit scan_phb(struct pci_contr
 #ifdef CONFIG_PPC_MULTIPLATFORM
 	if (node && ppc_md.pci_probe_mode)
 		mode = ppc_md.pci_probe_mode(bus);
-	DBG("    probe mode: %d\n", mode);
+	pr_debug("    probe mode: %d\n", mode);
 	if (mode == PCI_PROBE_DEVTREE) {
 		bus->subordinate = hose->last_busno;
 		of_scan_bus(node, bus);
@@ -847,7 +840,7 @@ pgprot_t pci_phys_mem_access_prot(struct
 		pci_dev_put(pdev);
 	}
 
-	DBG("non-PCI map for %lx, prot: %lx\n", offset, prot);
+	pr_debug("non-PCI map for %lx, prot: %lx\n", offset, prot);
 
 	return __pgprot(prot);
 }
@@ -1047,7 +1040,7 @@ void __devinit pci_process_bridge_OF_ran
 			res = &hose->io_resource;
 			res->flags = IORESOURCE_IO;
 			res->start = pci_addr;
-			DBG("phb%d: IO 0x%lx -> 0x%lx\n", hose->global_number,
+			pr_debug("phb%d: IO 0x%lx -> 0x%lx\n", hose->global_number,
 				    res->start, res->start + size - 1);
 			break;
 		case 2:		/* memory space */
@@ -1061,7 +1054,7 @@ void __devinit pci_process_bridge_OF_ran
 				res = &hose->mem_resources[memno];
 				res->flags = IORESOURCE_MEM;
 				res->start = cpu_phys_addr;
-				DBG("phb%d: MEM 0x%lx -> 0x%lx\n", hose->global_number,
+				pr_debug("phb%d: MEM 0x%lx -> 0x%lx\n", hose->global_number,
 					    res->start, res->start + size - 1);
 			}
 			break;
@@ -1084,7 +1077,7 @@ void __init pci_setup_phb_io(struct pci_
 	struct device_node *isa_dn;
 
 	hose->io_base_virt = reserve_phb_iospace(size);
-	DBG("phb%d io_base_phys 0x%lx io_base_virt 0x%lx\n",
+	pr_debug("phb%d io_base_phys 0x%lx io_base_virt 0x%lx\n",
 		hose->global_number, hose->io_base_phys,
 		(unsigned long) hose->io_base_virt);
 
@@ -1114,7 +1107,7 @@ void __devinit pci_setup_phb_io_dynamic(
 
 	hose->io_base_virt = __ioremap(hose->io_base_phys, size,
 					_PAGE_NO_CACHE | _PAGE_GUARDED);
-	DBG("phb%d io_base_phys 0x%lx io_base_virt 0x%lx\n",
+	pr_debug("phb%d io_base_phys 0x%lx io_base_virt 0x%lx\n",
 		hose->global_number, hose->io_base_phys,
 		(unsigned long) hose->io_base_virt);
 
Index: to-merge/arch/powerpc/kernel/prom.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/prom.c
+++ to-merge/arch/powerpc/kernel/prom.c
@@ -51,13 +51,6 @@
 #include <asm/pSeries_reconfig.h>
 #include <asm/pci-bridge.h>
 
-#ifdef DEBUG
-#define DBG(fmt...) printk(KERN_ERR fmt)
-#else
-#define DBG(fmt...)
-#endif
-
-
 static int __initdata dt_root_addr_cells;
 static int __initdata dt_root_size_cells;
 
@@ -470,7 +463,7 @@ void __init finish_device_tree(void)
 {
 	unsigned long start, end, size = 0;
 
-	DBG(" -> finish_device_tree\n");
+	pr_debug(" -> finish_device_tree\n");
 
 #ifdef CONFIG_PPC64
 	/* Initialize virtual IRQ map */
@@ -500,7 +493,7 @@ void __init finish_device_tree(void)
 	finish_node(allnodes, &end, 0);
 	BUG_ON(end != start + size);
 
-	DBG(" <- finish_device_tree\n");
+	pr_debug(" <- finish_device_tree\n");
 }
 
 static inline char *find_flat_dt_string(u32 offset)
@@ -716,7 +709,7 @@ static unsigned long __init unflatten_dt
 				strcpy(p, dad->full_name);
 #ifdef DEBUG
 				if ((strlen(p) + l + 1) != allocl) {
-					DBG("%s: p: %d, l: %d, a: %d\n",
+					pr_debug("%s: p: %d, l: %d, a: %d\n",
 					    pathp, (int)strlen(p), l, allocl);
 				}
 #endif
@@ -811,7 +804,7 @@ static unsigned long __init unflatten_dt
 			prev_pp = &pp->next;
 			memcpy(pp->value, ps, sz - 1);
 			((char *)pp->value)[sz - 1] = 0;
-			DBG("fixed up name for %s -> %s\n", pathp, pp->value);
+			pr_debug("fixed up name for %s -> %s\n", pathp, pp->value);
 		}
 	}
 	if (allnextpp) {
@@ -848,7 +841,7 @@ void __init unflatten_device_tree(void)
 	unsigned long start, mem, size;
 	struct device_node **allnextp = &allnodes;
 
-	DBG(" -> unflatten_device_tree()\n");
+	pr_debug(" -> unflatten_device_tree()\n");
 
 	/* First pass, scan for size */
 	start = ((unsigned long)initial_boot_params) +
@@ -856,7 +849,7 @@ void __init unflatten_device_tree(void)
 	size = unflatten_dt_node(0, &start, NULL, NULL, 0);
 	size = (size | 3) + 1;
 
-	DBG("  size is %lx, allocating...\n", size);
+	pr_debug("  size is %lx, allocating...\n", size);
 
 	/* Allocate memory for the expanded device tree */
 	mem = lmb_alloc(size + 4, __alignof__(struct device_node));
@@ -864,7 +857,7 @@ void __init unflatten_device_tree(void)
 
 	((u32 *)mem)[size / 4] = 0xdeadbeef;
 
-	DBG("  unflattening %lx...\n", mem);
+	pr_debug("  unflattening %lx...\n", mem);
 
 	/* Second pass, do actual unflattening */
 	start = ((unsigned long)initial_boot_params) +
@@ -882,7 +875,7 @@ void __init unflatten_device_tree(void)
 	if (of_chosen == NULL)
 		of_chosen = of_find_node_by_path("/chosen@0");
 
-	DBG(" <- unflatten_device_tree()\n");
+	pr_debug(" <- unflatten_device_tree()\n");
 }
 
 static int __init early_init_dt_scan_cpus(unsigned long node,
@@ -947,7 +940,7 @@ static int __init early_init_dt_scan_cpu
 	}
 
 	if (found) {
-		DBG("boot cpu: logical %d physical %d\n", logical_cpuid,
+		pr_debug("boot cpu: logical %d physical %d\n", logical_cpuid,
 			intserv[i]);
 		boot_cpuid = logical_cpuid;
 		set_hard_smp_processor_id(boot_cpuid, intserv[i]);
@@ -986,7 +979,7 @@ static int __init early_init_dt_scan_cho
 	unsigned long l;
 	char *p;
 
-	DBG("search \"chosen\", depth: %d, uname: %s\n", depth, uname);
+	pr_debug("search \"chosen\", depth: %d, uname: %s\n", depth, uname);
 
 	if (depth != 1 ||
 	    (strcmp(uname, "chosen") != 0 && strcmp(uname, "chosen@0") != 0))
@@ -1051,7 +1044,7 @@ static int __init early_init_dt_scan_cho
 		strlcpy(cmd_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
 #endif /* CONFIG_CMDLINE */
 
-	DBG("Command line is: %s\n", cmd_line);
+	pr_debug("Command line is: %s\n", cmd_line);
 
 	if (strstr(cmd_line, "mem=")) {
 		char *p, *q;
@@ -1078,11 +1071,11 @@ static int __init early_init_dt_scan_roo
 
 	prop = of_get_flat_dt_prop(node, "#size-cells", NULL);
 	dt_root_size_cells = (prop == NULL) ? 1 : *prop;
-	DBG("dt_root_size_cells = %x\n", dt_root_size_cells);
+	pr_debug("dt_root_size_cells = %x\n", dt_root_size_cells);
 
 	prop = of_get_flat_dt_prop(node, "#address-cells", NULL);
 	dt_root_addr_cells = (prop == NULL) ? 2 : *prop;
-	DBG("dt_root_addr_cells = %x\n", dt_root_addr_cells);
+	pr_debug("dt_root_addr_cells = %x\n", dt_root_addr_cells);
 	
 	/* break now */
 	return 1;
@@ -1138,7 +1131,7 @@ static int __init early_init_dt_scan_mem
 
 	endp = reg + (l / sizeof(cell_t));
 
-	DBG("memory scan node %s, reg size %ld, data: %x %x %x %x,\n",
+	pr_debug("memory scan node %s, reg size %ld, data: %x %x %x %x,\n",
 	    uname, l, reg[0], reg[1], reg[2], reg[3]);
 
 	while ((endp - reg) >= (dt_root_addr_cells + dt_root_size_cells)) {
@@ -1149,7 +1142,7 @@ static int __init early_init_dt_scan_mem
 
 		if (size == 0)
 			continue;
-		DBG(" - %lx ,  %lx\n", base, size);
+		pr_debug(" - %lx ,  %lx\n", base, size);
 #ifdef CONFIG_PPC64
 		if (iommu_is_off) {
 			if (base >= 0x80000000ul)
@@ -1184,7 +1177,7 @@ static void __init early_reserve_mem(voi
 			size_32 = *(reserve_map_32++);
 			if (size_32 == 0)
 				break;
-			DBG("reserving: %x -> %x\n", base_32, size_32);
+			pr_debug("reserving: %x -> %x\n", base_32, size_32);
 			lmb_reserve(base_32, size_32);
 		}
 		return;
@@ -1195,19 +1188,19 @@ static void __init early_reserve_mem(voi
 		size = *(reserve_map++);
 		if (size == 0)
 			break;
-		DBG("reserving: %llx -> %llx\n", base, size);
+		pr_debug("reserving: %llx -> %llx\n", base, size);
 		lmb_reserve(base, size);
 	}
 
 #if 0
-	DBG("memory reserved, lmbs :\n");
+	pr_debug("memory reserved, lmbs :\n");
       	lmb_dump_all();
 #endif
 }
 
 void __init early_init_devtree(void *params)
 {
-	DBG(" -> early_init_devtree()\n");
+	pr_debug(" -> early_init_devtree()\n");
 
 	/* Setup flat device-tree pointer */
 	initial_boot_params = params;
@@ -1225,7 +1218,7 @@ void __init early_init_devtree(void *par
 	lmb_enforce_memory_limit(memory_limit);
 	lmb_analyze();
 
-	DBG("Phys. mem: %lx\n", lmb_phys_mem_size());
+	pr_debug("Phys. mem: %lx\n", lmb_phys_mem_size());
 
 	/* Reserve LMB regions used by kernel, initrd, dt, etc... */
 	lmb_reserve(PHYSICAL_START, __pa(klimit) - PHYSICAL_START);
@@ -1234,14 +1227,14 @@ void __init early_init_devtree(void *par
 #endif
 	early_reserve_mem();
 
-	DBG("Scanning CPUs ...\n");
+	pr_debug("Scanning CPUs ...\n");
 
 	/* Retreive CPU related informations from the flat tree
 	 * (altivec support, boot CPU ID, ...)
 	 */
 	of_scan_flat_dt(early_init_dt_scan_cpus, NULL);
 
-	DBG(" <- early_init_devtree()\n");
+	pr_debug(" <- early_init_devtree()\n");
 }
 
 #undef printk
@@ -2004,7 +1997,7 @@ void kdump_move_device_tree(void)
 
 	initial_boot_params = new;
 
-	DBG("Flat device tree blob moved to %p\n", initial_boot_params);
+	pr_debug("Flat device tree blob moved to %p\n", initial_boot_params);
 
 	/* XXX should we unreserve the old DT? */
 }
Index: to-merge/arch/powerpc/kernel/prom_parse.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/prom_parse.c
+++ to-merge/arch/powerpc/kernel/prom_parse.c
@@ -8,12 +8,6 @@
 #include <asm/prom.h>
 #include <asm/pci-bridge.h>
 
-#ifdef DEBUG
-#define DBG(fmt...) do { printk(fmt); } while(0)
-#else
-#define DBG(fmt...) do { } while(0)
-#endif
-
 #ifdef CONFIG_PPC64
 #define PRu64	"%lx"
 #else
@@ -81,7 +75,7 @@ static u64 of_bus_default_map(u32 *addr,
 	s  = of_read_addr(range + na + pna, ns);
 	da = of_read_addr(addr, na);
 
-	DBG("OF: default map, cp="PRu64", s="PRu64", da="PRu64"\n",
+	pr_debug("OF: default map, cp="PRu64", s="PRu64", da="PRu64"\n",
 	    cp, s, da);
 
 	if (da < cp || da >= (cp + s))
@@ -139,7 +133,7 @@ static u64 of_bus_pci_map(u32 *addr, u32
 	s  = of_read_addr(range + na + pna, ns);
 	da = of_read_addr(addr + 1, na - 1);
 
-	DBG("OF: PCI map, cp="PRu64", s="PRu64", da="PRu64"\n", cp, s, da);
+	pr_debug("OF: PCI map, cp="PRu64", s="PRu64", da="PRu64"\n", cp, s, da);
 
 	if (da < cp || da >= (cp + s))
 		return OF_BAD_ADDR;
@@ -199,7 +193,7 @@ static u64 of_bus_isa_map(u32 *addr, u32
 	s  = of_read_addr(range + na + pna, ns);
 	da = of_read_addr(addr + 1, na - 1);
 
-	DBG("OF: ISA map, cp="PRu64", s="PRu64", da="PRu64"\n", cp, s, da);
+	pr_debug("OF: ISA map, cp="PRu64", s="PRu64", da="PRu64"\n", cp, s, da);
 
 	if (da < cp || da >= (cp + s))
 		return OF_BAD_ADDR;
@@ -297,11 +291,11 @@ static int of_translate_one(struct devic
 	if (ranges == NULL || rlen == 0) {
 		offset = of_read_addr(addr, na);
 		memset(addr, 0, pna * 4);
-		DBG("OF: no ranges, 1:1 translation\n");
+		pr_debug("OF: no ranges, 1:1 translation\n");
 		goto finish;
 	}
 
-	DBG("OF: walking ranges...\n");
+	pr_debug("OF: walking ranges...\n");
 
 	/* Now walk through the ranges */
 	rlen /= 4;
@@ -312,14 +306,14 @@ static int of_translate_one(struct devic
 			break;
 	}
 	if (offset == OF_BAD_ADDR) {
-		DBG("OF: not found !\n");
+		pr_debug("OF: not found !\n");
 		return 1;
 	}
 	memcpy(addr, ranges + na, 4 * pna);
 
  finish:
 	of_dump_addr("OF: parent translation for:", addr, pna);
-	DBG("OF: with offset: "PRu64"\n", offset);
+	pr_debug("OF: with offset: "PRu64"\n", offset);
 
 	/* Translate it into parent bus space */
 	return pbus->translate(addr, offset, pna);
@@ -344,7 +338,7 @@ u64 of_translate_address(struct device_n
 	int na, ns, pna, pns;
 	u64 result = OF_BAD_ADDR;
 
-	DBG("OF: ** translation for device %s **\n", dev->full_name);
+	pr_debug("OF: ** translation for device %s **\n", dev->full_name);
 
 	/* Increase refcount at current level */
 	of_node_get(dev);
@@ -364,7 +358,7 @@ u64 of_translate_address(struct device_n
 	}
 	memcpy(addr, in_addr, na * 4);
 
-	DBG("OF: bus is %s (na=%d, ns=%d) on %s\n",
+	pr_debug("OF: bus is %s (na=%d, ns=%d) on %s\n",
 	    bus->name, na, ns, parent->full_name);
 	of_dump_addr("OF: translating address:", addr, na);
 
@@ -377,7 +371,7 @@ u64 of_translate_address(struct device_n
 
 		/* If root, we have finished */
 		if (parent == NULL) {
-			DBG("OF: reached root node\n");
+			pr_debug("OF: reached root node\n");
 			result = of_read_addr(addr, na);
 			break;
 		}
@@ -391,7 +385,7 @@ u64 of_translate_address(struct device_n
 			break;
 		}
 
-		DBG("OF: parent bus is %s (na=%d, ns=%d) on %s\n",
+		pr_debug("OF: parent bus is %s (na=%d, ns=%d) on %s\n",
 		    pbus->name, pna, pns, parent->full_name);
 
 		/* Apply bus translation */
Index: to-merge/arch/powerpc/kernel/setup-common.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/setup-common.c
+++ to-merge/arch/powerpc/kernel/setup-common.c
@@ -61,13 +61,6 @@
 
 #include "setup.h"
 
-#ifdef DEBUG
-#include <asm/udbg.h>
-#define DBG(fmt...) udbg_printf(fmt)
-#else
-#define DBG(fmt...)
-#endif
-
 /* The main machine-dep calls structure
  */
 struct machdep_calls ppc_md;
@@ -307,7 +300,7 @@ void __init check_for_initrd(void)
 #ifdef CONFIG_BLK_DEV_INITRD
 	unsigned long *prop;
 
-	DBG(" -> check_for_initrd()\n");
+	pr_debug(" -> check_for_initrd()\n");
 
 	if (of_chosen) {
 		prop = (unsigned long *)get_property(of_chosen,
@@ -336,7 +329,7 @@ void __init check_for_initrd(void)
 	if (initrd_start)
 		printk("Found initrd at 0x%lx:0x%lx\n", initrd_start, initrd_end);
 
-	DBG(" <- check_for_initrd()\n");
+	pr_debug(" <- check_for_initrd()\n");
 #endif /* CONFIG_BLK_DEV_INITRD */
 }
 
@@ -495,22 +488,22 @@ void probe_machine(void)
 	 * Iterate all ppc_md structures until we find the proper
 	 * one for the current machine type
 	 */
-	DBG("Probing machine type ...\n");
+	pr_debug("Probing machine type ...\n");
 
 	for (machine_id = &__machine_desc_start;
 	     machine_id < &__machine_desc_end;
 	     machine_id++) {
-		DBG("  %s ...", machine_id->name);
+		pr_debug("  %s ...", machine_id->name);
 		memcpy(&ppc_md, machine_id, sizeof(struct machdep_calls));
 		if (ppc_md.probe()) {
-			DBG(" match !\n");
+			pr_debug(" match !\n");
 			break;
 		}
-		DBG("\n");
+		pr_debug("\n");
 	}
 	/* What can we do if we didn't find ? */
 	if (machine_id >= &__machine_desc_end) {
-		DBG("No suitable machine found !\n");
+		pr_debug("No suitable machine found !\n");
 		for (;;);
 	}
 
Index: to-merge/arch/powerpc/kernel/setup_32.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/setup_32.c
+++ to-merge/arch/powerpc/kernel/setup_32.c
@@ -2,6 +2,8 @@
  * Common prep/pmac/chrp boot and setup code.
  */
 
+#undef DEBUG
+
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/string.h>
@@ -44,8 +46,6 @@
 
 #include "setup.h"
 
-#define DBG(fmt...)
-
 #if defined CONFIG_KGDB
 #include <asm/kgdb.h>
 #endif
Index: to-merge/arch/powerpc/kernel/setup_64.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/setup_64.c
+++ to-merge/arch/powerpc/kernel/setup_64.c
@@ -65,12 +65,6 @@
 
 #include "setup.h"
 
-#ifdef DEBUG
-#define DBG(fmt...) udbg_printf(fmt)
-#else
-#define DBG(fmt...)
-#endif
-
 int have_of = 1;
 int boot_cpuid = 0;
 dev_t boot_dev;
@@ -179,7 +173,7 @@ void __init early_setup(unsigned long dt
 	/* Enable early debugging if any specified (see udbg.h) */
 	udbg_early_init();
 
- 	DBG(" -> early_setup(), dt_ptr: 0x%lx\n", dt_ptr);
+	pr_debug(" -> early_setup(), dt_ptr: 0x%lx\n", dt_ptr);
 
 	/*
 	 * Do early initializations using the flattened device
@@ -203,7 +197,7 @@ void __init early_setup(unsigned long dt
 	kdump_setup();
 #endif
 
-	DBG("Found, Initializing memory management...\n");
+	pr_debug("Found, Initializing memory management...\n");
 
 	/*
 	 * Initialize the MMU Hash table and create the linear mapping
@@ -220,7 +214,7 @@ void __init early_setup(unsigned long dt
 	else if (!firmware_has_feature(FW_FEATURE_ISERIES))
 		stab_initialize(get_paca()->stab_real);
 
-	DBG(" <- early_setup()\n");
+	pr_debug(" <- early_setup()\n");
 }
 
 #ifdef CONFIG_SMP
@@ -252,7 +246,7 @@ void smp_release_cpus(void)
 	extern unsigned long __secondary_hold_spinloop;
 	unsigned long *ptr;
 
-	DBG(" -> smp_release_cpus()\n");
+	pr_debug(" -> smp_release_cpus()\n");
 
 	/* All secondary cpus are spinning on a common spinloop, release them
 	 * all now so they can start to spin on their individual paca
@@ -266,7 +260,7 @@ void smp_release_cpus(void)
 	*ptr = 1;
 	mb();
 
-	DBG(" <- smp_release_cpus()\n");
+	pr_debug(" <- smp_release_cpus()\n");
 }
 #endif /* CONFIG_SMP || CONFIG_KEXEC */
 
@@ -282,7 +276,7 @@ static void __init initialize_cache_info
 	struct device_node *np;
 	unsigned long num_cpus = 0;
 
-	DBG(" -> initialize_cache_info()\n");
+	pr_debug(" -> initialize_cache_info()\n");
 
 	for (np = NULL; (np = of_find_node_by_type(np, "cpu"));) {
 		num_cpus += 1;
@@ -314,7 +308,7 @@ static void __init initialize_cache_info
 			if (lsizep != NULL)
 				lsize = *lsizep;
 			if (sizep == 0 || lsizep == 0)
-				DBG("Argh, can't find dcache properties ! "
+				pr_debug("Argh, can't find dcache properties ! "
 				    "sizep: %p, lsizep: %p\n", sizep, lsizep);
 
 			ppc64_caches.dsize = size;
@@ -331,7 +325,7 @@ static void __init initialize_cache_info
 			if (lsizep != NULL)
 				lsize = *lsizep;
 			if (sizep == 0 || lsizep == 0)
-				DBG("Argh, can't find icache properties ! "
+				pr_debug("Argh, can't find icache properties ! "
 				    "sizep: %p, lsizep: %p\n", sizep, lsizep);
 
 			ppc64_caches.isize = size;
@@ -341,7 +335,7 @@ static void __init initialize_cache_info
 		}
 	}
 
-	DBG(" <- initialize_cache_info()\n");
+	pr_debug(" <- initialize_cache_info()\n");
 }
 
 
@@ -351,7 +345,7 @@ static void __init initialize_cache_info
  */
 void __init setup_system(void)
 {
-	DBG(" -> setup_system()\n");
+	pr_debug(" -> setup_system()\n");
 
 #ifdef CONFIG_KEXEC
 	kdump_move_device_tree();
@@ -453,7 +447,7 @@ void __init setup_system(void)
 #endif
 	printk("-----------------------------------------------------\n");
 
-	DBG(" <- setup_system()\n");
+	pr_debug(" <- setup_system()\n");
 }
 
 static int ppc64_panic_event(struct notifier_block *this,
Index: to-merge/arch/powerpc/kernel/smp.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/smp.c
+++ to-merge/arch/powerpc/kernel/smp.c
@@ -50,13 +50,6 @@
 #include <asm/paca.h>
 #endif
 
-#ifdef DEBUG
-#include <asm/udbg.h>
-#define DBG(fmt...) udbg_printf(fmt)
-#else
-#define DBG(fmt...)
-#endif
-
 int smp_hw_index[NR_CPUS];
 struct thread_info *secondary_ti;
 
@@ -83,11 +76,11 @@ int __init smp_mpic_probe(void)
 {
 	int nr_cpus;
 
-	DBG("smp_mpic_probe()...\n");
+	pr_debug("smp_mpic_probe()...\n");
 
 	nr_cpus = cpus_weight(cpu_possible_map);
 
-	DBG("nr_cpus: %d\n", nr_cpus);
+	pr_debug("nr_cpus: %d\n", nr_cpus);
 
 	if (nr_cpus > 1)
 		mpic_request_ipis();
@@ -346,7 +339,7 @@ void __init smp_prepare_cpus(unsigned in
 {
 	unsigned int cpu;
 
-	DBG("smp_prepare_cpus\n");
+	pr_debug("smp_prepare_cpus\n");
 
 	/* 
 	 * setup_cpu may need to be called on the boot cpu. We havent
@@ -483,7 +476,7 @@ int __devinit __cpu_up(unsigned int cpu)
 	smp_mb();
 
 	/* wake up cpus */
-	DBG("smp: kicking cpu %d\n", cpu);
+	pr_debug("smp: kicking cpu %d\n", cpu);
 	smp_ops->kick_cpu(cpu);
 
 	/*
Index: to-merge/arch/powerpc/kernel/vdso.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/vdso.c
+++ to-merge/arch/powerpc/kernel/vdso.c
@@ -8,6 +8,8 @@
  *  2 of the License, or (at your option) any later version.
  */
 
+#undef DEBUG
+
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/errno.h>
@@ -37,14 +39,6 @@
 #include <asm/vdso.h>
 #include <asm/vdso_datapage.h>
 
-#undef DEBUG
-
-#ifdef DEBUG
-#define DBG(fmt...) printk(fmt)
-#else
-#define DBG(fmt...)
-#endif
-
 /* Max supported size for symbol names */
 #define MAX_SYMNAME	64
 
@@ -187,7 +181,7 @@ static struct page * vdso_vma_nopage(str
 	void *vbase = vdso32_kbase;
 #endif
 
-	DBG("vdso_vma_nopage(current: %s, address: %016lx, off: %lx)\n",
+	pr_debug("vdso_vma_nopage(current: %s, address: %016lx, off: %lx)\n",
 	    current->comm, address, offset);
 
 	if (address < vma->vm_start || address > vma->vm_end)
@@ -202,7 +196,7 @@ static struct page * vdso_vma_nopage(str
 		pg = virt_to_page(vbase + offset);
 
 	get_page(pg);
-	DBG(" ->page count: %d\n", page_count(pg));
+	pr_debug(" ->page count: %d\n", page_count(pg));
 
 	return pg;
 }
@@ -584,7 +578,7 @@ static __init int vdso_fixup_alt_funcs(s
 		if (!match)
 			continue;
 
-		DBG("replacing %s with %s...\n", patch->gen_name,
+		pr_debug("replacing %s with %s...\n", patch->gen_name,
 		    patch->fix_name ? "NONE" : patch->fix_name);
 
 		/*
@@ -685,7 +679,7 @@ void __init vdso_init(void)
 	 * Calculate the size of the 64 bits vDSO
 	 */
 	vdso64_pages = (&vdso64_end - &vdso64_start) >> PAGE_SHIFT;
-	DBG("vdso64_kbase: %p, 0x%x pages\n", vdso64_kbase, vdso64_pages);
+	pr_debug("vdso64_kbase: %p, 0x%x pages\n", vdso64_kbase, vdso64_pages);
 #endif /* CONFIG_PPC64 */
 
 
@@ -693,7 +687,7 @@ void __init vdso_init(void)
 	 * Calculate the size of the 32 bits vDSO
 	 */
 	vdso32_pages = (&vdso32_end - &vdso32_start) >> PAGE_SHIFT;
-	DBG("vdso32_kbase: %p, 0x%x pages\n", vdso32_kbase, vdso32_pages);
+	pr_debug("vdso32_kbase: %p, 0x%x pages\n", vdso32_kbase, vdso32_pages);
 
 
 	/*
