Message-Id: <200003211841.TAA00654@piglet.grunz.lu>
Date: Tue, 21 Mar 2000 19:41:04 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: PCI fixup code for PowerMacs (new patch)
To: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200003201935.UAA00401@piglet.grunz.lu>
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY="134392852-1804289383-953664064=:346"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--134392852-1804289383-953664064=:346
Content-Type: TEXT/plain; CHARSET=US-ASCII

Hi list,

On  20 Mar, this message from /me echoed through cyberspace:
> The patch corrects two main issues:

.... and needs to be fixed itself. It was hand-edited, but it seems I
didn't get line numbering right.

Anyway, below is the corrected version against Paul's 2.3.52 tree.

> What needs to be tested:
> ========================
>
> - confirm that it works on the 9500/9600
>
> - see how it interacts with the UNI-North 'multiple bus 0' weirdness

I still need lots of reports on how it works out!

Thanks


Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "

--134392852-1804289383-953664064=:346
Content-Type: TEXT/plain; CHARSET=US-ASCII
Content-Description: sane-pci.diff

--- linux-2.3.paul/arch/ppc/kernel/pmac_pci.c	Fri Feb 11 00:19:51 2000
+++ linux-2.3.paul-work/arch/ppc/kernel/pmac_pci.c	Tue Mar 21 19:37:11 2000
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
@@ -674,35 +694,178 @@
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
+		 * Open Firmware does not enable I/O and memory space
+		 * response on PCI devices. We try to fix this, but we need
+		 * to be sure that OF didn't forget to assign an address
+		 * to the device. [mj]
+		 *
+		 * FIXME: How can we know? We should use OF properties....
+		 *        Or maybe the new 2.3 resource code?
+		 */
+		pcibios_enable_device(dev);
+	}
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
 	}
+	return;
+}
+
+void __init
+fix_planb (struct pci_dev *pcidev)
+{
+	/* There is a bug with the way OF assigns addresses
+	 * to the devices behind the chaos bridge.
+	 * control needs only 0x1000 of space, aliased into
+	 * a full 64K range. OF assigns the planb controller memory
+	 * within this space, so we need to change that here in order
+	 * to access planb. Note that the new address (0xf1000000)
+	 * is within chaos' address space, so it should never get
+	 * assigned to other devices by OF.
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

--134392852-1804289383-953664064=:346--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
