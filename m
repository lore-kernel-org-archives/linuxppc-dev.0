Date: Mon, 5 Jun 2000 09:42:02 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: PCI resource assignment
Message-ID: <Pine.LNX.4.05.10006050927350.5397-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The saga continues... PCI resource assignment for the CHRP LongTrail

Notes:
  - I no longer need to touch PCIBIOS_MIN_MEM in <asm/pci.h> because the iomem
    regions of all PCI devices are now made a child of gg2_resources.pci_mem.
    Hence the PCI resource allocation code makes sure it obtains a region from
    gg2_resources.pci_mem.

    I think a similar trick is needed to take care of the different I/O spaces
    on PowerMacs with multiple host bridges.

  - I did my best to have the least impact on other types of machines. Just
    write code for your machine and fill it in in
    ppc_md.pcibios_{fixup,fixup_bus} and rock!

  - This code assigns missing resources for
      o the secondary aperture of my ATI Mach64 GT (3D RAGE II+)
      o the aperture of my S3 Trio64V+

  - I don't know what to do with the code marked with

	Don't touch IDE controllers and I/O ports of video cards!

    Perhaps we do need to touch IDE controllers on PPC? I don't have IDE
    devices connected to the IDE interface in my LongTrail, so I don't know.
    AFAIK the IDE interface does work without fiddling with the PCI resources
    on other LongTrails, but that could be caused by the different OF in those
    boxes (that different OF does assign other missing resources, unlike mine).

  - Fun stuff in /proc:

    callisto$ cat /proc/iomem
    00000000-08000000 : RAM
    c0000000-f6ffffff : GG2 PCI mem
      c0000000-c0000fff : ATI Technologies Inc 3D Rage I/II 215GT [Mach64 GT]
      c1000000-c107ffff : Apple Computer Inc. Hydra Mac I/O
      c1080000-c108007f : Digital Equipment Corporation DECchip 21041 [Tulip Pass 3]  c2000000-c2ffffff : ATI Technologies Inc 3D Rage I/II 215GT [Mach64 GT]
	c2000000-c2ffffff : atyfb
      c3000000-c30000ff : Symbios Logic Inc. (formerly NCR) 53c875
      c3001000-c3001fff : Symbios Logic Inc. (formerly NCR) 53c875
      c4000000-c7ffffff : S3 Inc. 86c764/765 [Trio32/64/64V+]
    f7000000-f7ffffff : GG2 ISA mem
      f70e0000-f70e7fff : NVRAM
    f8000000-f8ffffff : GG2 PCI I/O
    fec00000-fec7ffff : GG2 PCI cfg
    ff000000-ff7fffff : ROM exp
    fff80000-ffffffff : Flash ROM
    callisto$ lspci -v
    00:00.0 Host bridge: VLSI Technology Inc VAS96011 [Golden Gate II] (rev 11)
	    Flags: bus master, medium devsel, latency 0

    00:01.0 ISA bridge: Symphony Labs W83C553 (rev 04)
	    Flags: bus master, medium devsel, latency 0

    00:01.1 IDE interface: Symphony Labs SL82c105 (rev 05) (prog-if 8f [Master SecP SecO PriP PriO])
	    Flags: medium devsel, IRQ 32
	    I/O ports at 0008 [disabled] [size=8]
	    I/O ports at 000c [disabled] [size=4]
	    I/O ports at 0008 [disabled] [size=8]
	    I/O ports at 000c [disabled] [size=4]
	    I/O ports at 1000 [disabled] [size=16]
	    I/O ports at 1010 [disabled] [size=16]

    00:02.0 Class ff00: Apple Computer Inc. Hydra Mac I/O (rev 02)
	    Flags: bus master, medium devsel, latency 0
	    Memory at c1000000 (32-bit, non-prefetchable) [size=512K]

    00:03.0 VGA compatible controller: S3 Inc. 86c764/765 [Trio32/64/64V+] (rev 53) (prog-if 00 [VGA])
	    Flags: medium devsel, IRQ 28
	    Memory at c4000000 (32-bit, non-prefetchable) [disabled] [size=64M]
	    Expansion ROM at c8000000 [disabled] [size=64K]

    00:04.0 Ethernet controller: Digital Equipment Corporation DECchip 21041 [Tulip Pass 3] (rev 21)
	    Subsystem: D-Link System Inc DE-530+
	    Flags: bus master, medium devsel, latency 0, IRQ 29
	    I/O ports at 1080 [size=128]
	    Memory at c1080000 (32-bit, non-prefetchable) [size=128]
	    Expansion ROM at c11c0000 [disabled] [size=256K]

    00:05.0 VGA compatible controller: ATI Technologies Inc 3D Rage I/II 215GT [Mach64 GT] (rev 9a) (prog-if 00 [VGA])
	    Flags: stepping, medium devsel, IRQ 30
	    Memory at c2000000 (32-bit, non-prefetchable) [size=16M]
	    I/O ports at <ignored> [disabled] [size=256]
	    Memory at c0000000 (32-bit, non-prefetchable) [size=4K]
	    Expansion ROM at c3020000 [disabled] [size=128K]

    00:06.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c875 (rev 04)
	    Flags: bus master, medium devsel, latency 80, IRQ 31
	    I/O ports at 1400 [size=256]
	    Memory at c3000000 (32-bit, non-prefetchable) [size=256]
	    Memory at c3001000 (32-bit, non-prefetchable) [size=4K]
	    Expansion ROM at c1190000 [disabled] [size=64K]

    callisto$


===== arch/ppc/kernel/pci.c 1.13 vs edited =====
--- 1.13/arch/ppc/kernel/pci.c	Tue Mar  7 03:01:54 2000
+++ edited/arch/ppc/kernel/pci.c	Sun Jun  4 14:31:52 2000
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
@@ -67,13 +76,273 @@
 	generic_pcibios_write_dword
 };

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
+/*
+ * We need to avoid collisions with `mirrored' VGA ports
+ * and other strange ISA hardware, so we always want the
+ * addresses to be allocated in the 0x000-0x0ff region
+ * modulo 0x400.
+ *
+ * Why? Because some silly external IO cards only decode
+ * the low 10 bits of the IO address. The 0x00-0xff region
+ * is reserved for motherboard devices that decode all 16
+ * bits, so it's ok to allocate at, say, 0x2800-0x28ff,
+ * but we want to try to avoid allocating at 0x2900-0x2bff
+ * which might have be mirrored at 0x0100-0x03ff..
+ */
+void
+pcibios_align_resource(void *data, struct resource *res, unsigned long size)
+{
+	struct pci_dev *dev = data;
+
+	if (res->flags & IORESOURCE_IO) {
+		unsigned long start = res->start;
+
+		if (size > 0x100) {
+			printk(KERN_ERR "PCI: I/O Region %s/%d too large"
+			       " (%ld bytes)\n", dev->slot_name,
+			       dev->resource - res, size);
+		}
+
+		if (start & 0x300) {
+			start = (start + 0x3ff) & ~0x3ff;
+			res->start = start;
+		}
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
+			if (r->end == 0xffffffff) {
+				/* LongTrail OF quirk: unassigned */
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
+					r->end -= r->start;
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
+		if (0) { /* don't assign ROMs */
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
+	if (dev->resource[PCI_ROM_RESOURCE].start)
+		cmd |= PCI_COMMAND_MEMORY;
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
+//debug_scan_pci();
 }

 void __init
@@ -131,31 +400,12 @@
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
===== arch/ppc/kernel/chrp_pci.c 1.6 vs edited =====
--- 1.6/arch/ppc/kernel/chrp_pci.c	Tue May 16 08:24:48 2000
+++ edited/arch/ppc/kernel/chrp_pci.c	Sun Jun  4 15:51:31 2000
@@ -308,6 +308,40 @@
 	}
 }

+static struct {
+    /* parent is iomem */
+    struct resource ram, pci_mem, isa_mem, pci_io, pci_cfg, rom_exp, flash;
+    /* parent is isa_mem */
+    struct resource nvram;
+} gg2_resources = {
+    ram:	{ "RAM", 0x00000000, 0xbfffffff, IORESOURCE_MEM },
+    pci_mem:	{ "GG2 PCI mem", 0xc0000000, 0xf6ffffff, IORESOURCE_MEM },
+    isa_mem:	{ "GG2 ISA mem", 0xf7000000, 0xf7ffffff },
+    pci_io:	{ "GG2 PCI I/O", 0xf8000000, 0xf8ffffff },
+    pci_cfg:	{ "GG2 PCI cfg", 0xfec00000, 0xfec7ffff },
+    rom_exp:	{ "ROM exp", 0xff000000, 0xff7fffff, },
+    flash:	{ "Flash ROM", 0xfff80000, 0xffffffff },
+    nvram:	{ "NVRAM", 0xf70e0000, 0xf70e7fff },
+};
+
+static void __init gg2_pcibios_fixup(void)
+{
+	int i;
+	extern unsigned long *end_of_DRAM;
+
+	chrp_pcibios_fixup();
+	gg2_resources.ram.end = (unsigned long)end_of_DRAM-PAGE_OFFSET;
+	for (i = 0; i < 7; i++)
+	    request_resource(&iomem_resource,
+		    	     &((struct resource *)&gg2_resources)[i]);
+	request_resource(&gg2_resources.isa_mem, &gg2_resources.nvram);
+}
+
+static void __init gg2_pcibios_fixup_bus(struct pci_bus *bus)
+{
+    	bus->resource[1] = &gg2_resources.pci_mem;
+}
+
 decl_config_access_method(grackle);
 decl_config_access_method(indirect);
 decl_config_access_method(rtas);
@@ -317,6 +351,8 @@
 {
 	struct device_node *py;

+	ppc_md.pcibios_fixup = chrp_pcibios_fixup;
+
         if ( !strncmp("MOT",
                       get_property(find_path_device("/"), "model", NULL),3) )
         {
@@ -327,6 +363,8 @@
         }
         else
         {
+		const char *name = get_property(find_path_device("/"), "name",
+						NULL);
 		if ( (py = find_compatible_devices( "pci", "IBM,python" )) )
 		{
 			/* find out how many pythons */
@@ -337,13 +375,12 @@
 			 * try to read them from the python controller itself.
 			 * -- Cort
 			 */
-			if ( !strncmp("IBM,7025-F50", get_property(find_path_device("/"), "name", NULL),12) )
+			if ( !strncmp("IBM,7025-F50", name, 12) )
 			{
 				pci_dram_offset = 0x80000000;
 				isa_mem_base = 0xa0000000;
 				isa_io_base = 0x88000000;
-			} else if ( !strncmp("IBM,7043-260",
-			   get_property(find_path_device("/"), "name", NULL),12) )
+			} else if ( !strncmp("IBM,7043-260", name, 12) )
 			{
 				pci_dram_offset = 0x0;
 				isa_mem_base = 0xc0000000;
@@ -352,9 +389,9 @@
                 }
                 else
                 {
-			if ( !strncmp("IBM,7043-150", get_property(find_path_device("/"), "name", NULL),12) ||
-			     !strncmp("IBM,7046-155", get_property(find_path_device("/"), "name", NULL),12) ||
-			     !strncmp("IBM,7046-B50", get_property(find_path_device("/"), "name", NULL),12) )
+			if ( !strncmp("IBM,7043-150", name, 12) ||
+			     !strncmp("IBM,7046-155", name, 12) ||
+			     !strncmp("IBM,7046-B50", name, 12) )
 			{
 				pci_dram_offset = 0;
 				isa_mem_base = 0x80000000;
@@ -369,9 +406,9 @@
 				isa_mem_base = 0xf7000000;
 				isa_io_base = 0xf8000000;
 				set_config_access_method(gg2);
+				ppc_md.pcibios_fixup = gg2_pcibios_fixup;
+				ppc_md.pcibios_fixup_bus = gg2_pcibios_fixup_bus;
 			}
                 }
         }
-
-	ppc_md.pcibios_fixup = chrp_pcibios_fixup;
 }

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
