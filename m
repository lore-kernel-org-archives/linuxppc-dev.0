Date: Wed, 22 Mar 2000 09:27:44 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: LongTrail PCI resource assignment
Message-ID: <Pine.GSO.4.10.10003220852390.29557-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Hi,

I added code to do automatic PCI resource assignment for unassigned resources
on my CHRP LongTrail. This is experimental, of course.

The code is heavily based on the ia32 code that checks for unassigned and
overlapping resources. In fact the only difference is that I also check for

    if (r->end == 0xffffffff) {     /* Unassigned */
	DBG("PCI: Resource %08lx-%08lx was unassigned\n", r->start, r->end);
	r->end -= r->start;
	r->start = 0;
	continue;
    }

in pcibios_allocate_resources() to catch the unassigned regions that show up in
high memory on my box (e.g. an unassigned 4 KB region shows up as occupying
0xfffff000-0xffffffff). It looks like OF did write 0xffffffff to the PCI
base address registers during the probe phase, but didn't bother to do anything
with the returned size mask.

Now the kernel assigns a valid memory resource for my S3 Trio64V+ and for the
secondary MMIO aperture of my ATI RAGE II+. It doesn't assign valid I/O
resources for the Winbond IDE yet, but I guess I just have to remove the test
for PCI_CLASS_STORAGE_IDE in pcibios_assign_resources() (on PC you must not
mess with the IDE interface, on PPC you probably have to).


Notes:

  - There are machine dependent things related to PCI resource assignment,
    namely PCIBIOS_MIN_IO and PCIBIOS_MIN_MEM in include/asm-ppc/pci.h. On the
    LongTrail, PCI memory space is from 0xc0000000 until 0xf7000000, so I had
    to change PCIBIOS_MIN_MEM to make sure allocation starts at 0xc0000000. I
    think we need

	#define PCIBIOS_MIN_IO	ppc_md.pcibios_min_io
	#define PCIBIOS_MIN_MEM	ppc_md.pcibios_min_mem

    and solve this in the machine specific setup code.

    Martin, do you think it makes sense to have PCIBIOS_MAX_IO and
    PCIBIOS_MAX_MEM to pass to allocate_resource() as the upper limits?

  - Instead of testing for r->end == 0xffffffff, I think I can also lower
    iomem_resource.end (which is currently 0xffffffff), so the allocation of
    resources at the top of memory space fails and they will be reassigned.
    But then I can no longer allocate a resource for the ROM at
    0xfff80000-0xffffffff if I ever would want to do that.

  - Since the secondary MMIO aperture of Mach64 chips seems to overlap with the
    primary aperture on PowerMac, you may want to try this on PowerMac as well.
    Make sure to change the machine specific things (notable PCIBIOS_MIN_MEM)!

  - If you want to reassign all resources, you can just call

	pci_assign_unassigned_resources();
	pci_set_bus_ranges();

    (don't know what the second call really does, just copied it from the
    Alpha and it seems to work fine on my MIPS board at work as well) in
    pcibios_init() instead of the current calls to pcibios_*() functions there.
    You do not want to do this on a PowerMac or CHRP box, though, since it will
    make sure the OF device tree is no longer in sync with the PCI resource
    assignments. But it could be an alternative to Gabriel's bootloader on PReP
    boxes (under the motto: keep as much code shared in the kernel :-).

  - The code in pci_debug.c is just there for dumping all PCI buses, devices
    and resources. You activate it by doing `cat proc/pci' and looking in the
    kernel messages. The patch also enables all PCI debug code, since this is
    probably what you want when playing with PCI resource assignment :-)

Good luck!


===== arch/ppc/kernel/Makefile 1.14 vs edited =====
--- 1.14/arch/ppc/kernel/Makefile	Tue Mar  7 03:01:53 2000
+++ edited/arch/ppc/kernel/Makefile	Tue Mar 21 17:47:32 2000
@@ -38,7 +38,7 @@
 endif

 ifdef CONFIG_PCI
-O_OBJS += pci.o pci-dma.o
+O_OBJS += pci.o pci-dma.o pci_debug.o
 endif

 ifdef CONFIG_KGDB
===== arch/ppc/kernel/pci.c 1.13 vs edited =====
--- 1.13/arch/ppc/kernel/pci.c	Tue Mar  7 03:01:54 2000
+++ edited/arch/ppc/kernel/pci.c	Tue Mar 21 22:08:08 2000
@@ -22,6 +22,15 @@

 #include "pci.h"

+#define DEBUG
+
+#ifdef DEBUG
+#define DBG(x...) printk(x)
+#else
+#define DBG(x...)
+#endif
+
+
 static void __init pcibios_claim_resources(struct list_head *);

 unsigned long isa_io_base     = 0;
@@ -67,13 +76,271 @@
 	generic_pcibios_write_dword
 };

+
+
+#define PCI_PROBE_BIOS 1
+#define PCI_PROBE_CONF1 2
+#define PCI_PROBE_CONF2 4
+#define PCI_NO_SORT 0x100
+#define PCI_BIOS_SORT 0x200
+#define PCI_NO_CHECKS 0x400
+#define PCI_PEER_FIXUP 0x800
+#define PCI_ASSIGN_ROMS 0x1000
+#define PCI_BIOS_IRQ_SCAN 0x2000
+
+unsigned int pci_probe;
+
+
+void pcibios_update_resource(struct pci_dev *dev, struct resource *root,
+			     struct resource *res, int resource)
+{
+	u32 new, check;
+	int reg;
+
+	new = res->start | (res->flags & PCI_REGION_FLAG_MASK);
+	if (resource < 6) {
+		reg = PCI_BASE_ADDRESS_0 + 4*resource;
+	} else if (resource == PCI_ROM_RESOURCE) {
+		res->flags |= PCI_ROM_ADDRESS_ENABLE;
+		reg = dev->rom_base_reg;
+	} else {
+		/* Somebody might have asked allocation of a non-standard resource */
+		return;
+	}
+
+	pci_write_config_dword(dev, reg, new);
+	pci_read_config_dword(dev, reg, &check);
+	if ((new ^ check) & ((new & PCI_BASE_ADDRESS_SPACE_IO) ? PCI_BASE_ADDRESS_IO_MASK : PCI_BASE_ADDRESS_MEM_MASK)) {
+		printk(KERN_ERR "PCI: Error while updating region "
+		       "%s/%d (%08x != %08x)\n", dev->slot_name, resource,
+		       new, check);
+	}
+}
+
+void
+pcibios_align_resource(void *data, struct resource *res, unsigned long size)
+{
+	struct pci_dev *dev = data;
+
+	if (res->flags & IORESOURCE_IO) {
+		unsigned long start = res->start;
+
+		/* We need to avoid collisions with `mirrored' VGA ports
+		   and other strange ISA hardware, so we always want the
+		   addresses kilobyte aligned.  */
+		if (size > 0x100) {
+			printk(KERN_ERR "PCI: I/O Region %s/%d too large"
+			       " (%ld bytes)\n", dev->slot_name,
+			       dev->resource - res, size);
+		}
+
+		start = (start + 1024 - 1) & ~(1024 - 1);
+		res->start = start;
+	}
+}
+
+
+/*
+ *  Handle resources of PCI devices.  If the world were perfect, we could
+ *  just allocate all the resource regions and do nothing more.  It isn't.
+ *  On the other hand, we cannot just re-allocate all devices, as it would
+ *  require us to know lots of host bridge internals.  So we attempt to
+ *  keep as much of the original configuration as possible, but tweak it
+ *  when it's found to be wrong.
+ *
+ *  Known BIOS problems we have to work around:
+ *	- I/O or memory regions not configured
+ *	- regions configured, but not enabled in the command register
+ *	- bogus I/O addresses above 64K used
+ *	- expansion ROMs left enabled (this may sound harmless, but given
+ *	  the fact the PCI specs explicitly allow address decoders to be
+ *	  shared between expansion ROMs and other resource regions, it's
+ *	  at least dangerous)
+ *
+ *  Our solution:
+ *	(1) Allocate resources for all buses behind PCI-to-PCI bridges.
+ *	    This gives us fixed barriers on where we can allocate.
+ *	(2) Allocate resources for all enabled devices.  If there is
+ *	    a collision, just mark the resource as unallocated. Also
+ *	    disable expansion ROMs during this step.
+ *	(3) Try to allocate resources for disabled devices.  If the
+ *	    resources were assigned correctly, everything goes well,
+ *	    if they weren't, they won't disturb allocation of other
+ *	    resources.
+ *	(4) Assign new addresses to resources which were either
+ *	    not configured at all or misconfigured.  If explicitly
+ *	    requested by the user, configure expansion ROM address
+ *	    as well.
+ */
+
+static void __init pcibios_allocate_bus_resources(struct list_head *bus_list)
+{
+	struct list_head *ln;
+	struct pci_bus *bus;
+	struct pci_dev *dev;
+	int idx;
+	struct resource *r, *pr;
+
+	/* Depth-First Search on bus tree */
+	for (ln=bus_list->next; ln != bus_list; ln=ln->next) {
+		bus = pci_bus_b(ln);
+		if ((dev = bus->self)) {
+			for (idx = PCI_BRIDGE_RESOURCES; idx < PCI_NUM_RESOURCES; idx++) {
+				r = &dev->resource[idx];
+				if (!r->start)
+					continue;
+				pr = pci_find_parent_resource(dev, r);
+				if (!pr || request_resource(pr, r) < 0)
+					printk(KERN_ERR "PCI: Cannot allocate resource region %d of bridge %s\n", idx, dev->slot_name);
+			}
+		}
+		pcibios_allocate_bus_resources(&bus->children);
+	}
+}
+
+static void __init pcibios_allocate_resources(int pass)
+{
+	struct pci_dev *dev;
+	int idx, disabled;
+	u16 command;
+	struct resource *r, *pr;
+
+	pci_for_each_dev(dev) {
+		pci_read_config_word(dev, PCI_COMMAND, &command);
+		for(idx = 0; idx < 6; idx++) {
+			r = &dev->resource[idx];
+			if (r->parent)		/* Already allocated */
+				continue;
+			if (!r->start)		/* Address not assigned at all */
+				continue;
+			if (r->end == 0xffffffff) {	/* Unassigned */
+				DBG("PCI: Resource %08lx-%08lx was unassigned\n", r->start, r->end);
+				r->end -= r->start;
+				r->start = 0;
+				continue;
+			}
+
+			if (r->flags & IORESOURCE_IO)
+				disabled = !(command & PCI_COMMAND_IO);
+			else
+				disabled = !(command & PCI_COMMAND_MEMORY);
+			if (pass == disabled) {
+				DBG("PCI: Resource %08lx-%08lx (f=%lx, d=%d, p=%d)\n",
+				    r->start, r->end, r->flags, disabled, pass);
+				pr = pci_find_parent_resource(dev, r);
+				if (!pr || request_resource(pr, r) < 0) {
+					printk(KERN_ERR "PCI: Cannot allocate resource region %d of device %s\n", idx, dev->slot_name);
+					/* We'll assign a new address later */
+					r->start -= r->end;
+					r->start = 0;
+				}
+			}
+		}
+		if (!pass) {
+			r = &dev->resource[PCI_ROM_RESOURCE];
+			if (r->flags & PCI_ROM_ADDRESS_ENABLE) {
+				/* Turn the ROM off, leave the resource region, but keep it unregistered. */
+				u32 reg;
+				DBG("PCI: Switching off ROM of %s\n", dev->slot_name);
+				r->flags &= ~PCI_ROM_ADDRESS_ENABLE;
+				pci_read_config_dword(dev, dev->rom_base_reg, &reg);
+				pci_write_config_dword(dev, dev->rom_base_reg, reg & ~PCI_ROM_ADDRESS_ENABLE);
+			}
+		}
+	}
+}
+
+static void __init pcibios_assign_resources(void)
+{
+	struct pci_dev *dev;
+	int idx;
+	struct resource *r;
+
+	pci_for_each_dev(dev) {
+		int class = dev->class >> 8;
+
+		/* Don't touch classless devices and host bridges */
+		if (!class || class == PCI_CLASS_BRIDGE_HOST)
+			continue;
+
+		for(idx=0; idx<6; idx++) {
+			r = &dev->resource[idx];
+
+			/*
+			 *  Don't touch IDE controllers and I/O ports of video cards!
+			 */
+			if ((class == PCI_CLASS_STORAGE_IDE && idx < 4) ||
+			    (class == PCI_CLASS_DISPLAY_VGA && (r->flags & IORESOURCE_IO)))
+				continue;
+
+			/*
+			 *  We shall assign a new address to this resource, either because
+			 *  the BIOS forgot to do so or because we have decided the old
+			 *  address was unusable for some reason.
+			 */
+			if (!r->start && r->end)
+				pci_assign_resource(dev, idx);
+		}
+
+		if (pci_probe & PCI_ASSIGN_ROMS) {
+			r = &dev->resource[PCI_ROM_RESOURCE];
+			r->end -= r->start;
+			r->start = 0;
+			if (r->end)
+				pci_assign_resource(dev, PCI_ROM_RESOURCE);
+		}
+	}
+}
+
+
+int pcibios_enable_resources(struct pci_dev *dev)
+{
+	u16 cmd, old_cmd;
+	int idx;
+	struct resource *r;
+
+	pci_read_config_word(dev, PCI_COMMAND, &cmd);
+	old_cmd = cmd;
+	for(idx=0; idx<6; idx++) {
+		r = &dev->resource[idx];
+		if (!r->start && r->end) {
+			printk(KERN_ERR "PCI: Device %s not available because of resource collisions\n", dev->slot_name);
+			return -EINVAL;
+		}
+		if (r->flags & IORESOURCE_IO)
+			cmd |= PCI_COMMAND_IO;
+		if (r->flags & IORESOURCE_MEM)
+			cmd |= PCI_COMMAND_MEMORY;
+	}
+	if (cmd != old_cmd) {
+		printk("PCI: Enabling device %s (%04x -> %04x)\n", dev->slot_name, old_cmd, cmd);
+		pci_write_config_word(dev, PCI_COMMAND, cmd);
+	}
+	return 0;
+}
+
+
+
 void __init pcibios_init(void)
 {
+#if 0
 	printk("PCI: Probing PCI hardware\n");
 	pci_scan_bus(0, &generic_pci_ops, NULL);
 	if (ppc_md.pcibios_fixup)
 		ppc_md.pcibios_fixup();
 	pcibios_claim_resources(&pci_root_buses);
+#else
+	printk("PCI: Probing PCI hardware (semiautomatic)\n");
+	pci_scan_bus(0, &generic_pci_ops, NULL);
+	if (ppc_md.pcibios_fixup)
+		ppc_md.pcibios_fixup();
+
+	pcibios_allocate_bus_resources(&pci_root_buses);
+	pcibios_allocate_resources(0);
+	pcibios_allocate_resources(1);
+	pcibios_assign_resources();
+#endif
+debug_scan_pci();
 }

 void __init
@@ -131,31 +398,12 @@
 	return str;
 }

-/* the next two are stolen from the alpha port... */
-void __init
-pcibios_update_resource(struct pci_dev *dev, struct resource *root,
-			struct resource *res, int resource)
-{
-        unsigned long where, size;
-        u32 reg;
-
-        where = PCI_BASE_ADDRESS_0 + (resource * 4);
-        size = res->end - res->start;
-        pci_read_config_dword(dev, where, &reg);
-        reg = (reg & size) | (((u32)(res->start - root->start)) & ~size);
-        pci_write_config_dword(dev, where, reg);
-}
-
+/* the next one is stolen from the alpha port... */
 void __init
 pcibios_update_irq(struct pci_dev *dev, int irq)
 {
 	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
 	/* XXX FIXME - update OF device tree node interrupt property */
-}
-
-void __init
-pcibios_align_resource(void *data, struct resource *res, unsigned long size)
-{
 }

 int pcibios_enable_device(struct pci_dev *dev)
===== drivers/pci/pci.c 1.16 vs edited =====
--- 1.16/drivers/pci/pci.c	Sat Mar 18 15:38:57 2000
+++ edited/drivers/pci/pci.c	Tue Mar 21 18:57:54 2000
@@ -22,7 +22,7 @@
 #include <asm/page.h>
 #include <asm/dma.h>	/* isa_dma_bridge_buggy */

-#undef DEBUG
+#define DEBUG

 #ifdef DEBUG
 #define DBG(x...) printk(x)
===== drivers/pci/setup-irq.c 1.1 vs edited =====
--- 1.1/drivers/pci/setup-irq.c	Thu Jan 13 04:40:58 2000
+++ edited/drivers/pci/setup-irq.c	Tue Mar 21 18:58:11 2000
@@ -18,7 +18,7 @@
 #include <linux/cache.h>


-#define DEBUG_CONFIG 0
+#define DEBUG_CONFIG 1
 #if DEBUG_CONFIG
 # define DBGC(args)     printk args
 #else
===== drivers/pci/setup-res.c 1.2 vs edited =====
--- 1.2/drivers/pci/setup-res.c	Thu Jan 13 23:46:31 2000
+++ edited/drivers/pci/setup-res.c	Tue Mar 21 18:58:16 2000
@@ -19,7 +19,7 @@
 #include <linux/cache.h>


-#define DEBUG_CONFIG 0
+#define DEBUG_CONFIG 1
 #if DEBUG_CONFIG
 # define DBGC(args)     printk args
 #else
===== drivers/pci/setup-bus.c 1.1 vs edited =====
--- 1.1/drivers/pci/setup-bus.c	Tue Jan 11 16:22:31 2000
+++ edited/drivers/pci/setup-bus.c	Tue Mar 21 18:58:08 2000
@@ -17,7 +17,7 @@
 #include <linux/cache.h>


-#define DEBUG_CONFIG 0
+#define DEBUG_CONFIG 1
 #if DEBUG_CONFIG
 # define DBGC(args)     printk args
 #else
===== drivers/pci/proc.c 1.5 vs edited =====
--- 1.5/drivers/pci/proc.c	Mon Feb 28 13:35:33 2000
+++ edited/drivers/pci/proc.c	Tue Mar 21 17:49:51 2000
@@ -385,6 +385,7 @@
 	int nprinted, len, begin = 0;
 	struct pci_dev *dev;

+debug_dump_pci();
 	len = sprintf(buf, "PCI devices found:\n");

 	*eof = 1;
===== drivers/pci/quirks.c 1.2 vs edited =====
--- 1.2/drivers/pci/quirks.c	Thu Mar  2 14:07:11 2000
+++ edited/drivers/pci/quirks.c	Tue Mar 21 18:58:03 2000
@@ -17,7 +17,7 @@
 #include <linux/pci.h>
 #include <linux/init.h>

-#undef DEBUG
+#define DEBUG

 /* Deal with broken BIOS'es that neglect to enable passive release,
    which can cause problems in combination with the 82441FX/PPro MTRRs */
===== include/asm-ppc/pci.h 1.11 vs edited =====
--- 1.11/include/asm-ppc/pci.h	Sat Mar 18 23:16:43 2000
+++ edited/include/asm-ppc/pci.h	Tue Mar 21 18:57:04 2000
@@ -8,7 +8,7 @@
 #define pcibios_assign_all_busses()	0

 #define PCIBIOS_MIN_IO		0x1000
-#define PCIBIOS_MIN_MEM		0x10000000
+#define PCIBIOS_MIN_MEM		0xc0000000

 extern inline void pcibios_set_master(struct pci_dev *dev)
 {
--- /dev/null	Thu Aug  6 16:24:46 1998
+++ new/arch/ppc/kernel/pci_debug.c	Tue Mar 21 17:44:52 2000
@@ -0,0 +1,349 @@
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+
+static struct pci_dev *__pci_devices[100];
+static int num_pci_devices = 0;
+
+static struct pci_bus *__pci_buses[100];
+static int num_pci_buses = 0;
+
+static struct resource *__resources[1000];
+static int num_resources = 0;
+
+static void __add_pointer(const void *ptr, const void **table,
+			  int *num_entries, int max_entries)
+{
+    int i;
+
+    if (ptr == NULL)
+	return;
+
+    if (*num_entries == max_entries) {
+	printk("add_pointer: %p is full (%d entries)\n", table, *num_entries);
+	return;
+    }
+    for (i = 0; i < *num_entries; i++)
+	if ((unsigned long)table[i] == (unsigned long)ptr)
+	    return;
+    table[(*num_entries)++] = ptr;
+}
+
+static void __sort_table(const void **table, int num_entries)
+{
+    int i, j;
+
+    for (i = 0; i < num_entries-1; i++)
+	for (j = i+1; j < num_entries; j++)
+	    if ((unsigned long)table[j] < (unsigned long)table[i]) {
+		const void *t = table[i];
+		table[i] = table[j];
+		table[j] = t;
+	    }
+}
+
+static void add_pci_device(const struct pci_dev *dev)
+{
+    __add_pointer(dev, (const void **)__pci_devices, &num_pci_devices,
+		  sizeof(__pci_devices)/sizeof(void *));
+}
+
+static void add_pci_bus(const struct pci_bus *bus)
+{
+    __add_pointer(bus, (const void **)__pci_buses, &num_pci_buses,
+		  sizeof(__pci_buses)/sizeof(void *));
+}
+
+static void add_resource(const struct resource *res)
+{
+    __add_pointer(res, (const void **)__resources, &num_resources,
+		  sizeof(__resources)/sizeof(void *));
+}
+
+static void sort_pci_devices(void)
+{
+    __sort_table((const void **)__pci_devices, num_pci_devices);
+}
+
+static void sort_pci_buses(void)
+{
+    __sort_table((const void **)__pci_buses, num_pci_buses);
+}
+
+static void sort_resources(void)
+{
+    __sort_table((const void **)__resources, num_resources);
+}
+
+static void dump_resource_terse(int n, const struct resource *res)
+{
+    if (!res || !res->flags)
+	return;
+    printk("   %2d: %p [", n, res);
+    if (res->flags & IORESOURCE_IO)
+	printk(" I/O");
+    if (res->flags & IORESOURCE_MEM)
+	printk(" MEM");
+    if (res->flags & IORESOURCE_IRQ)
+	printk(" IRQ");
+    if (res->flags & IORESOURCE_DMA)
+	printk(" DMA");
+    if (res->flags & (IORESOURCE_IO|IORESOURCE_MEM))
+	printk(" %p-%p", (void *)res->start, (void *)res->end);
+    printk(" ]\n");
+}
+
+void dump_resource(const struct resource *res)
+{
+    printk("Resource %p %s\n", res, res->name);
+    if (!res->flags)
+	return;
+    printk("  range = %p-%p\n", (void *)res->start, (void *)res->end);
+    printk("  flags = 0x%08lx [", res->flags);
+    if (res->flags & IORESOURCE_IO)
+	printk(" IO");
+    if (res->flags & IORESOURCE_MEM)
+	printk(" MEM");
+    if (res->flags & IORESOURCE_IRQ)
+	printk(" IRQ");
+    if (res->flags & IORESOURCE_DMA)
+	printk(" DMA");
+
+    if (res->flags & IORESOURCE_PREFETCH)
+	printk(" PREFETCH");
+    if (res->flags & IORESOURCE_READONLY)
+	printk(" READONLY");
+    if (res->flags & IORESOURCE_CACHEABLE)
+	printk(" CACHEABLE");
+    if (res->flags & IORESOURCE_RANGELENGTH)
+	printk(" RANGELENGTH");
+    if (res->flags & IORESOURCE_SHADOWABLE)
+	printk(" SHADOWABLE");
+
+    if (res->flags & IORESOURCE_UNSET)
+	printk(" UNSET");
+    if (res->flags & IORESOURCE_AUTO)
+	printk(" AUTO");
+    if (res->flags & IORESOURCE_BUSY)
+	printk(" BUSY");
+
+    if (res->flags & IORESOURCE_IRQ) {
+	if (res->flags & IORESOURCE_IRQ_HIGHEDGE)
+	    printk(" IRQ_HIGHEDGE");
+	if (res->flags & IORESOURCE_IRQ_LOWEDGE)
+	    printk(" IRQ_LOWEDGE");
+	if (res->flags & IORESOURCE_IRQ_HIGHLEVEL)
+	    printk(" IRQ_HIGHLEVEL");
+	if (res->flags & IORESOURCE_IRQ_LOWLEVEL)
+	    printk(" IRQ_LOWLEVEL");
+    }
+
+    if (res->flags & IORESOURCE_DMA) {
+	switch (res->flags & IORESOURCE_DMA_TYPE_MASK) {
+	    case IORESOURCE_DMA_8BIT:
+		printk(" DMA_8BIT");
+		break;
+	    case IORESOURCE_DMA_8AND16BIT:
+		printk(" DMA_8AND16BIT");
+		break;
+	    case IORESOURCE_DMA_16BIT:
+		printk(" DMA_16BIT");
+		break;
+	}
+	if (res->flags & IORESOURCE_DMA_MASTER)
+	    printk(" DMA_MASTER");
+	if (res->flags & IORESOURCE_DMA_BYTE)
+	    printk(" DMA_BYTE");
+	if (res->flags & IORESOURCE_DMA_WORD)
+	    printk(" DMA_WORD");
+	switch (res->flags & IORESOURCE_DMA_SPEED_MASK) {
+	    case IORESOURCE_DMA_COMPATIBLE:
+		printk(" DMA_COMPATIBLE");
+		break;
+	    case IORESOURCE_DMA_TYPEA:
+		printk(" DMA_TYPEA");
+		break;
+	    case IORESOURCE_DMA_TYPEB:
+		printk(" DMA_TYPEB");
+		break;
+	    case IORESOURCE_DMA_TYPEF:
+		printk(" DMA_TYPEF");
+		break;
+	}
+    }
+
+    if (res->flags & IORESOURCE_MEM) {
+	if (res->flags & IORESOURCE_MEM_WRITEABLE)
+	    printk(" MEM_WRITEABLE");
+	if (res->flags & IORESOURCE_MEM_CACHEABLE)
+	    printk(" MEM_CACHEABLE");
+	if (res->flags & IORESOURCE_MEM_RANGELENGTH)
+	    printk(" MEM_RANGELENGTH");
+	switch (res->flags & IORESOURCE_MEM_TYPE_MASK) {
+	    case IORESOURCE_MEM_8BIT:
+		printk(" MEM_8BIT");
+		break;
+	    case IORESOURCE_MEM_16BIT:
+		printk(" MEM_16BIT");
+		break;
+	    case IORESOURCE_MEM_8AND16BIT:
+		printk(" MEM_8AND16BIT");
+		break;
+	}
+	if (res->flags & IORESOURCE_MEM_SHADOWABLE)
+	    printk(" MEM_SHADOWABLE");
+	if (res->flags & IORESOURCE_MEM_EXPANSIONROM)
+	    printk(" MEM_EXPANSIONROM");
+    }
+    printk(" ]\n");
+    printk("  parent = %p sibling = %p child = %p\n", res->parent,
+	   res->sibling, res->child);
+}
+
+void dump_pci_device(const struct pci_dev *dev)
+{
+    int i;
+
+    printk("PCI device %p %s %s\n", dev, dev->slot_name, dev->name);
+    printk("  global_list.prev = %p global_list.next = %p\n",
+	   dev->global_list.prev, dev->global_list.next);
+    printk("  bus_list.prev = %p bus_list.next = %p\n", dev->bus_list.prev,
+	   dev->bus_list.next);
+    printk("  bus = %p subordinate = %p\n", dev->bus, dev->subordinate);
+    printk("  sysdata = %p procent = %p devfn = 0x%08x\n", dev->sysdata,
+	   dev->procent, dev->devfn);
+    printk("  vendor/device = %04x:%04x subsystem = 0x%04x:%04x\n",
+	   dev->vendor, dev->device, dev->subsystem_vendor,
+	   dev->subsystem_device);
+    printk("  class = 0x%08x hdr_type = 0x%02x rom_base_reg = 0x%02x\n",
+	   dev->class, dev->hdr_type, dev->rom_base_reg);
+    printk("  driver = %p driver_data = %p\n", dev->driver, dev->driver_data);
+    printk("  dma_mask = %p\n", (void *)dev->dma_mask);
+    printk("  compatible[] = ");
+    for (i = 0; i < DEVICE_COUNT_COMPATIBLE; i++)
+	printk(" %04x:%04x", dev->vendor_compatible[i],
+	       dev->device_compatible[i]);
+    printk("\n");
+    printk("  irq = %d\n", dev->irq);
+    printk("  resource[] =\n");
+    for (i = 0; i < DEVICE_COUNT_RESOURCE; i++)
+	dump_resource_terse(i, &dev->resource[i]);
+    printk("  dma_resource[] =\n");
+    for (i = 0; i < DEVICE_COUNT_DMA; i++)
+	dump_resource_terse(i, &dev->dma_resource[i]);
+    printk("  irq_resource[] =\n");
+    for (i = 0; i < DEVICE_COUNT_IRQ; i++)
+	dump_resource_terse(i, &dev->irq_resource[i]);
+    printk("  active = %d ro = %d regs = 0x%04x\n", dev->active, dev->ro,
+	   dev->regs);
+    printk("  prepare = %p activate = %p deactivate = %p\n", dev->prepare,
+	   dev->activate, dev->deactivate);
+    printk("\n");
+}
+
+void dump_pci_bus(const struct pci_bus *bus)
+{
+    int i;
+
+    printk("PCI bus %p %s\n", bus, bus->name);
+    printk("  node.prev = %p node.next = %p\n", bus->node.prev,
+	   bus->node.next);
+    printk("  parent = %p\n", bus->parent);
+    printk("  children.prev = %p children.next = %p\n", bus->children.prev,
+	   bus->children.next);
+    printk("  devices.prev = %p devices.next = %p\n", bus->devices.prev,
+	   bus->devices.next);
+    printk("  self = %p\n", bus->self);
+    printk("  resource[] = [\n");
+    for (i = 0; i < 4; i++)
+	dump_resource_terse(i, bus->resource[i]);
+    printk("  ]\n");
+    printk("  ops = %p sysdata = %p procdir = %p\n", bus->ops, bus->sysdata,
+	   bus->procdir);
+    printk("  number = %d primary = %d secondary = %d subordinate = %d\n",
+	   bus->number, bus->primary, bus->secondary, bus->subordinate);
+    printk("  vendor/device = %04x:%04x\n", bus->vendor, bus->device);
+    printk("  serial = %d pnpver = %d productver = %d checksum = %d\n",
+	   bus->serial, bus->pnpver, bus->productver, bus->checksum);
+    printk("\n");
+}
+
+
+static void scan_pci_buses(void)
+{
+    struct pci_bus *bus;
+    int i;
+
+    for (bus = pci_bus_b(pci_root_buses.next);
+	 bus != pci_bus_b(&pci_root_buses);
+	 bus = pci_bus_b(bus->node.next)) {
+	add_pci_bus(bus);
+	for (i = 0; i < 4; i++)
+	    add_resource(bus->resource[i]);
+    }
+}
+
+static void scan_pci_devices(void)
+{
+    struct pci_dev *dev;
+    int i;
+
+    pci_for_each_dev(dev) {
+	add_pci_device(dev);
+	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++)
+	    add_resource(&dev->resource[i]);
+	for (i = 0; i < DEVICE_COUNT_DMA; i++)
+	    add_resource(&dev->dma_resource[i]);
+	for (i = 0; i < DEVICE_COUNT_IRQ; i++)
+	    add_resource(&dev->irq_resource[i]);
+    }
+}
+
+void dump_pci_buses(void)
+{
+    int i;
+
+    printk(">>>>>>>>>>>>>>>>>>>> PCI Buses >>>>>>>>>>>>>>>>>>>>\n");
+    for (i = 0; i < num_pci_buses; i++)
+	dump_pci_bus(__pci_buses[i]);
+    printk("<<<<<<<<<<<<<<<<<<<< PCI Buses <<<<<<<<<<<<<<<<<<<<\n");
+}
+
+
+void dump_pci_devices(void)
+{
+    int i;
+
+    printk(">>>>>>>>>>>>>>>>>>>> PCI Devices >>>>>>>>>>>>>>>>>>>>\n");
+    for (i = 0; i < num_pci_devices; i++)
+	dump_pci_device(__pci_devices[i]);
+    printk("<<<<<<<<<<<<<<<<<<<< PCI Devices <<<<<<<<<<<<<<<<<<<<\n");
+}
+
+
+void dump_resources(void)
+{
+    int i;
+
+    printk(">>>>>>>>>>>>>>>>>>>> Resources >>>>>>>>>>>>>>>>>>>>\n");
+    for (i = 0; i < num_resources; i++)
+	dump_resource(__resources[i]);
+    printk("<<<<<<<<<<<<<<<<<<<< Resources <<<<<<<<<<<<<<<<<<<<\n");
+}
+
+void debug_scan_pci(void)
+{
+    scan_pci_buses();
+    scan_pci_devices();
+    sort_pci_buses();
+    sort_pci_devices();
+    sort_resources();
+}
+
+void debug_dump_pci(void)
+{
+    dump_pci_buses();
+    dump_pci_devices();
+    dump_resources();
+}
+

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
