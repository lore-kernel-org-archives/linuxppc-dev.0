Message-Id: <200003142211.XAA00663@piglet.grunz.lu>
Date: Tue, 14 Mar 2000 23:11:35 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: [linux-fbdev] [PATCH 2.3.x] fbdev reversion
To: Geert.Uytterhoeven@sonycom.com, mj@ucw.cz
cc: bh40@calva.net, linux-fbdev@vuser.vu.union.edu,
        linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.GSO.4.10.10003141104380.15255-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY="134392852-1804289383-953071895=:662"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--134392852-1804289383-953071895=:662
Content-Type: TEXT/plain; CHARSET=US-ASCII

Hi all,

On  14 Mar, this message from Geert Uytterhoeven echoed through cyberspace:
>> Well, while we are at it, we could also work on fixing the PCI problems:
>> Instead of relying on XFree knowing the host bridge and deducing the
>> iobase, I beleive we should export from the kernel either one iobase per
>> PCI device (there can be different busses with different iobases, that's
>> the case on the new macs and they have the same bus number), or we can
>> have /proc/bus/pci export "fixed'up" IO addresses (already including the
>> iobase).

I'd clearly vote for this approach. Something along those lines is
neede as well if you want to use more than one IDE controller at the
same time (or anything other than Apple's integrated controller, for
that matter).

>> I can code those fixes, but I'm not sure what solution has most chances
>> of beeing accepted (especially changing /poc/bus/pci semantics). The
>> problem is that exporting an IO address alone (without the iobase) has
>> really no meaning on arch that don't have a x86-like separate IO space at
>> the CPU level.

I have just yesterday completed my patch doing exactly that (ported
over from 2.2.x); it is, however, PowerMac-only. It's attached below,
and also fixes the missing scan of PCI buses other than bus 0 on
PowerMacs.

> Have you talked to Martin Mares about this?

Martin, what is your feeling about this? I think the IO-port-fixup
scheme could be generalized on PPC (or any PCI platform lacking true IO
space); however, it would be best if there were a generic way to find
out the processor base address of the IO space of a specific bus. On
PowerMacs, we get that from OF.

I'm thinking about something along the lines of a resource of the
parent bridge's PCI dev; much like it is available for P2P bridges. So
even though the information is not given directly by host bridges, the
platform fixup code would need to provide those through other means
(typically something firmware-derived).

This would be a step in the direction of a complete resource tree
starting at the host bridges, which, at least on PMacs, is not there
right now. That is needed, however, if dynamic resource allocation is
to produce working results ;-)

Please try this patch if you expierence PCI trouble, and also if you
have IDE in your machine; I'd like to verify I didn't break built-in
PowerMac IDE. Be warned, however....

Flames, comments, cookies, ideas? Beer?

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "

--134392852-1804289383-953071895=:662
Content-Type: TEXT/plain; CHARSET=US-ASCII
Content-Description: pci.diff

diff -uNr linux-2.3.paul/include/asm-ppc/io.h linux-2.3.paul-work/include/asm-ppc/io.h
--- linux-2.3.paul/include/asm-ppc/io.h	Sat Mar 11 06:09:07 2000
+++ linux-2.3.paul-work/include/asm-ppc/io.h	Sun Mar 12 17:08:44 2000
@@ -32,7 +32,9 @@
 extern unsigned long isa_io_base;
 extern unsigned long isa_mem_base;
 extern unsigned long pci_dram_offset;
-#define _IO_BASE	isa_io_base
+/* We're correcting io base addresses in pci fixup code */
+/* #define _IO_BASE	isa_io_base */
+#define _IO_BASE	0
 #define _ISA_MEM_BASE	isa_mem_base
 #define PCI_DRAM_OFFSET	pci_dram_offset
 #endif /* CONFIG_APUS */
diff -uNr linux-2.3.paul/arch/ppc/kernel/pmac_pci.c linux-2.3.paul-work/arch/ppc/kernel/pmac_pci.c
--- linux-2.3.paul/arch/ppc/kernel/pmac_pci.c	Fri Feb 11 00:19:51 2000
+++ linux-2.3.paul-work/arch/ppc/kernel/pmac_pci.c	Mon Mar 13 21:07:21 2000
@@ -27,6 +27,15 @@

 #include "pci.h"

+#undef DEBUG
+#define DEBUG
+
+#ifdef DEBUG
+#define DBG(x...) printk(x)
+#else
+#define DBG(x...)
+#endif
+
 struct bridge_data **bridges, *bridge_list;
 static int max_bus;

@@ -41,6 +50,10 @@
 static int uninorth_default = -1;

 static void add_bridges(struct device_node *dev);
+void fix_chaos (struct bridge_data *);
+void fix_planb (struct pci_dev *);
+
+extern struct pci_ops generic_pci_ops;

 /*
  * Magic constants for enabling cache coherency in the bandit/PSX bridge.
@@ -54,6 +67,10 @@
 #define BANDIT_MAGIC	0x50
 #define BANDIT_COHERENT	0x40

+#define CONTROL_DEVID	3
+#define PLANB_DEVID	4
+#define PLANB_BASE      0xf1000000
+
 __pmac
 void *pci_io_base(unsigned int bus)
 {
@@ -629,7 +646,7 @@
 				ioremap(addr->address + 0x800000, 0x1000);
 			bp->cfg_data = (volatile unsigned char *)
 				ioremap(addr->address + 0xc00000, 0x1000);
-			bp->io_base = (void *) ioremap(addr->address, 0x10000);
+			bp->io_base = (void *) ioremap(addr->address, 0x800000);
 		}
 		if (isa_io_base == 0)
 			isa_io_base = (unsigned long) bp->io_base;
@@ -664,8 +681,11 @@
 		if (reg == 0 || ((reg[0] >> 8) & 0xff) != dev->devfn)
 			continue;
 		/* this is the node, see if it has interrupts */
-		if (node->n_intrs > 0)
+		if (node->n_intrs > 0)  {
 			dev->irq = node->intrs[0].line;
+			DBG("PCI: Setting IRQ %d on device %s.\n",
+				dev->irq, dev->slot_name);
+		}
 		break;
 	}
 }
@@ -674,35 +694,214 @@
 pmac_pcibios_fixup(void)
 {
 	struct pci_dev *dev;
+	struct bridge_data *bp;
+	int i;

 	/*
-	 * FIXME: This is broken: We should not assign IRQ's to IRQless
-	 *	  devices (look at PCI_INTERRUPT_PIN) and we also should
-	 *	  honor the existence of multi-function devices where
-	 *	  different functions have different interrupt pins. [mj]
+	 * The generic PCI code scans only bus 0 for devices and P2P
+	 * bridges. We fix this here based on the array of host
+	 * bridges.
 	 */
+	for (bp = bridge_list; bp != NULL; bp = bp->next) {
+
+		if (bp->bus_number == 0) continue;
+
+		if (strcmp(bp->node->name, "chaos") == 0)
+			fix_chaos(bp);
+		else
+			pci_scan_bus(bp->bus_number, &generic_pci_ops, NULL);
+	}
+
 	pci_for_each_dev(dev)
 	{
-		/*
-		 * Open Firmware often doesn't initialize the,
-		 * PCI_INTERRUPT_LINE config register properly, so we
-		 * should find the device node and se if it has an
-		 * AAPL,interrupts property.
-		 */
 		struct bridge_data *bp = bridges[dev->bus->number];
 		unsigned char pin;
+
+		DBG("PCI: Fixing device %02x:%02x (%04x:%04x)\n",
+			dev->bus->number, dev->devfn,
+			dev->vendor, dev->device);
+
+		/* SPECIAL DEVICES
+		 * ---------------
+		 * control was fixed in fix_chaos().
+		 */
+		if (dev->vendor == APPLE_VENDID &&
+		    dev->device == CONTROL_DEVID) {
+			continue;
+		}
+		/* planb needs special care.
+		 */
+		if (dev->vendor == APPLE_VENDID &&
+		    dev->device == PLANB_DEVID) {
+			fix_planb (dev);
+			continue;
+		}
+		/* INTERRUPT FIXING
+		 * ----------------
+		 * Open Firmware doesn't initialize the PCI_INTERRUPT_LINE
+		 * config register, so we need to find the device node and
+		 * see if it has an AAPL,interrupts property.
+		 *
+		 * Note that INTA# - INTD# are OR'ed together per slot,
+		 * so no need to worry about multifunction cards.
+		 */

-		if (pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin) ||
-		    !pin)
-			continue; /* No interrupt generated -> no fixup */
-		/* We iterate all instances of uninorth for now */
-		if (uninorth_count && dev->bus->number == 0) {
-			int i;
-			for (i=0;i<uninorth_count;i++)
-				fix_intr(uninorth_bridges[i].node->child, dev);
-		} else
-                	fix_intr(bp->node->child, dev);
+		/* Is there an interrupt? */
+		if ( !(pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin) ||
+		    !pin) ) {
+			/* We iterate all instances of uninorth for now */
+			if (uninorth_count && dev->bus->number == 0) {
+				int i;
+				for (i=0;i<uninorth_count;i++)
+					fix_intr(uninorth_bridges[i].node->child, dev);
+			} else
+       		         	fix_intr(bp->node->child, dev);
+		}
+		/*
+		 * Since the PMac host bridges do translate IO accesses,
+		 * we correct the kernel PCI device database here with an
+		 * offset we add to IO region's base address. The exact
+		 * offset is provided by the bridge controling the
+		 * device's bus.
+		 */
+		if (dev->hdr_type != PCI_HEADER_TYPE_NORMAL) goto nextfix;
+
+		for(i=0; i<6; i++) {
+			struct resource *res = &dev->resource[i];
+			unsigned long base;
+			unsigned long a = res->start;
+
+			if (res->flags & PCI_BASE_ADDRESS_SPACE_IO) {
+				base = (unsigned long)
+					pci_io_base(dev->bus->number);
+				/* unassigned region? */
+				if (a == 0) continue;
+				/* strange value? */
+				if (a > 0x800000) continue;
+				if (a < base) a += base;
+				if (a > base) {
+					res->start = a;
+					res->end += base;
+					DBG("PCI: Correcting IO address %d on "
+					    "device %s, now %08lx.\n",
+					    i, dev->slot_name, a);
+				}
+			}
+		}
+nextfix:
+		/*
+		 * Open Firmware does not enable I/O and memory space
+		 * response on PCI devices. We try to fix this, but we need
+		 * to be sure that OF didn't forget to assign an address
+		 * to the device. [mj]
+		 *
+		 * FIXME: How can we know? We should use OF properties....
+		 *        Or maybe the new 2.3 resource code?
+		 */
+		pcibios_enable_device(dev);
 	}
+}
+
+/*
+ * The chaos hostbridge, controlling the separate video bus
+ * on the 7x00/8x00 PowerMacs, doesn't like being probed for
+ * attached devices. Therefore, we rely on OF to discover those.
+ */
+
+void __init
+fix_chaos (struct bridge_data *bp)
+{
+	struct device_node *nd;
+	struct pci_dev temp;
+	struct pci_dev *dev = NULL;
+	struct pci_bus *b;
+
+	b = pci_alloc_primary_bus(bp->bus_number);
+	b->sysdata = NULL;
+	b->ops = &generic_pci_ops;
+	b->subordinate = bp->max_bus;
+	/*
+	 * Walk OF's list of devices on this bus.
+	 */
+	for (nd = bp->node->child; nd; nd = nd->sibling) {
+		/*
+		 * We need at least one address entry to get the PCI
+		 * device / function values.
+		 */
+		if (nd->n_addrs == 0) {
+			printk(KERN_ERR "PCI: %s: not a PCI device!\n",
+				nd->name);
+			continue;
+		}
+		temp.devfn = (nd->addrs[0].space >> 8) & 0xff;
+		temp.bus = b;
+		pci_scan_slot(&temp);
+	}
+	return;
+}
+
+void __init
+fix_planb (struct pci_dev *pcidev)
+{
+	/* There is a bug with the way OF assigns addresses
+	 * to the devices behind the chaos bridge.
+	 * control needs only 0x1000 of space, yet decodes only
+	 * the upper 16 bits. It therefore occupies a full 64K.
+	 * OF assigns the planb controller memory within this space;
+	 * so we need to change that here in order to access planb.
+	 * Note that the new address (0xf1000000) is within chaos'
+	 * address space, so it should never get assigned to other
+	 * devices by OF.
+	 * planb also gets its interrupt set.
+	 */
+	struct device_node *planb_device;
+	struct resource *res;
+	unsigned char bus, devfn, confreg;
+	unsigned int reg;
+	u32 sz;
+
+	DBG("PCI: fixing PlanB...\n");
+	planb_device = find_devices("planb");
+	if (planb_device == 0) {
+		printk(KERN_WARNING "PCI: Error fixing planb: no OF device.\n");
+		return;
+	}
+	if (planb_device->next != NULL)
+		printk(KERN_WARNING "PCI: Only fixing first planb device.\n");
+
+	if (planb_device->n_addrs != 1) {
+		printk(KERN_WARNING "PCI: Error fixing planb: expected 1 "
+			"address, got %d.\n", planb_device->n_addrs);
+		return;
+	}
+	if (planb_device->n_intrs == 0) {
+		printk(KERN_WARNING "PCI: Error fixing planb: no IRQ.\n");
+		return;
+	}
+	bus = (planb_device->addrs[0].space >> 16) & 0xff;
+	devfn = (planb_device->addrs[0].space >> 8) & 0xff;
+	if ((bus != pcidev->bus->number) || (devfn != pcidev->devfn)) {
+		printk(KERN_WARNING "PCI: Error fixing planb: OF and PCI "
+			"device don't match!\n");
+		return;
+	}
+	pcidev->irq = planb_device->intrs[0].line;
+	confreg = planb_device->addrs[0].space & 0xff;
+	reg = (confreg - PCI_BASE_ADDRESS_0) >> 2;
+	/* Set the new base address */
+	pcibios_write_config_dword(bus, devfn, confreg, ~0);
+	pcibios_read_config_dword(bus, devfn, confreg, &sz);
+	pcibios_write_config_dword(bus, devfn, confreg, PLANB_BASE);
+	res = &pcidev->resource[reg];
+	res->start = PLANB_BASE & PCI_BASE_ADDRESS_MEM_MASK;
+	sz = ~(sz & PCI_BASE_ADDRESS_MEM_MASK);
+	res->end = res->start + (unsigned long) sz;
+	/*
+	 * Everything else should be set up right from the generic scan
+	 * code. Now enable PlanB...
+	 */
+	pcibios_enable_device(pcidev);
+	return;
 }

 void __init

--134392852-1804289383-953071895=:662--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
