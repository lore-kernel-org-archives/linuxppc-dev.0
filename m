Message-Id: <199909122137.XAA00332@piglet.cpu.lu>
Date: Sun, 12 Sep 1999 23:37:43 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: More on Various PMac PCI patches
To: Paul.Mackerras@cs.anu.edu.au
cc: mj@ucw.cz, linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY="134392852-846930886-937172263=:240"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--134392852-846930886-937172263=:240
Content-Type: TEXT/plain; CHARSET=US-ASCII

Hi all,

Here is another round of PCI patches for the PowerMacs, against 2.2.12
official.

It includes all my previous patches, cleaned up a bit, with the special
cases upon region enabling removed for VGA and IDE, and with special
care for PlanB. That's since with OF's assignments, PlanB collides with
the memory held by control.

I haven't had time to investigate the potential PCMCIA problems nor
find an appropriate solution, so this PCI stuff might need to change
further. I just wanted to get it out the door, since more and more
people seem to be bothered by the lack of fixup code for the PCI bus.

Enjoy, and report any and all problems to me!

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "

--134392852-846930886-937172263=:240
Content-Type: TEXT/plain; CHARSET=US-ASCII
Content-Description: pci.diff

diff -uNr linux-2.2.12-pristine/arch/ppc/kernel/pci.c linux-2.2.12/arch/ppc/kernel/pci.c
--- linux-2.2.12-pristine/arch/ppc/kernel/pci.c	Thu Aug 26 21:51:03 1999
+++ linux-2.2.12/arch/ppc/kernel/pci.c	Sun Sep 12 23:23:18 1999
@@ -22,6 +22,14 @@
 
 #include "pci.h"
 
+#undef DEBUG
+
+#ifdef DEBUG
+#define DBG(x...) printk(x)
+#else
+#define DBG(x...)
+#endif
+
 unsigned long isa_io_base     = 0;
 unsigned long isa_mem_base    = 0;
 unsigned long pci_dram_offset = 0;
@@ -99,8 +107,11 @@
 		if (reg == 0 || ((reg[0] >> 8) & 0xff) != dev->devfn)
 			continue;
 		/* this is the node, see if it has interrupts */
-		if (node->n_intrs > 0) 
+		if (node->n_intrs > 0) {
 			dev->irq = node->intrs[0].line;
+			DBG("PCI: setting IRQ %d on device %02x:%02x.\n",
+				dev->irq, dev->bus->number, dev->devfn);
+		}
 		break;
 	}
 }
diff -uNr linux-2.2.12-pristine/arch/ppc/kernel/pmac_pci.c linux-2.2.12/arch/ppc/kernel/pmac_pci.c
--- linux-2.2.12-pristine/arch/ppc/kernel/pmac_pci.c	Sat Aug  7 17:09:25 1999
+++ linux-2.2.12/arch/ppc/kernel/pmac_pci.c	Sun Sep 12 23:22:05 1999
@@ -17,6 +17,7 @@
 #include <linux/delay.h>
 #include <linux/string.h>
 #include <linux/init.h>
+#include <linux/malloc.h>
 #include <asm/io.h>
 #include <asm/pgtable.h>
 #include <asm/prom.h>
@@ -25,6 +26,14 @@
 
 #include "pci.h"
 
+#undef DEBUG
+
+#ifdef DEBUG
+#define DBG(x...) printk(x)
+#else
+#define DBG(x...)
+#endif
+
 struct bridge_data **bridges, *bridge_list;
 static int max_bus;
 
@@ -42,6 +51,8 @@
 #define BANDIT_MAGIC	0x50
 #define BANDIT_COHERENT	0x40
 
+#define PLANB_DEVID	4
+
 __pmac
 void *pci_io_base(unsigned int bus)
 {
@@ -418,7 +429,7 @@
 				ioremap(addr->address + 0x800000, 0x1000);
 			bp->cfg_data = (volatile unsigned char *)
 				ioremap(addr->address + 0xc00000, 0x1000);
-			bp->io_base = (void *) ioremap(addr->address, 0x10000);
+			bp->io_base = (void *) ioremap(addr->address, 0x800000);
 		} else {
 			/* XXX */
 			bp->cfg_addr = (volatile unsigned int *)
@@ -447,20 +458,30 @@
 pmac_pcibios_fixup(void))
 {
 	struct pci_dev *dev;
-	
+	int i, has_io, has_mem;
+	unsigned short cmd;
+	struct bridge_data *bp;
+
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
+		if (bp->bus_number == 0) continue;
+
+		pci_scan_peer_bridge (bp->bus_number);
+	}
+
 	for(dev=pci_devices; dev; dev=dev->next)
 	{
 		/*
-		 * Open Firmware often doesn't initialize the,
-		 * PCI_INTERRUPT_LINE config register properly, so we
-		 * should find the device node and se if it has an
-		 * AAPL,interrupts property.
+		 * Open Firmware doesn't initialize the PCI_INTERRUPT_LINE
+		 * config register, so we need to find the device node and
+		 * see if it has an AAPL,interrupts property.
+		 *
+		 * Note that INTA# - INTD# are OR'ed together per slot,
+		 * so no need to worry about multifunction cards.
 		 */
 		struct bridge_data *bp = bridges[dev->bus->number];
 		unsigned char pin;
@@ -469,6 +490,57 @@
 		    !pin)
 			continue; /* No interrupt generated -> no fixup */
                 fix_intr(bp->node->child, dev);
+
+		/*
+		 * Open Firmware does not enable I/O and memory space
+		 * response on PCI devices. We try to fix this, but we need
+		 * to be sure that OF didn't forget to assign an address
+		 * to the device. [mj]
+		 *
+		 * FIXME: How can we know? We should use OF properties....
+		 *
+		 * In addition, we correct any I/O space address by adding
+		 * the offset provided by the corresponding host bridge.
+		 */
+		has_io = has_mem = 0;
+		for(i=0; i<6; i++) {
+			unsigned long base;
+			unsigned long a = dev->base_address[i];
+			if (a & PCI_BASE_ADDRESS_SPACE_IO) {
+				has_io = 1;
+				base = (unsigned long)
+					pci_io_base(dev->bus->number);
+				if (a < base) a += base;
+				if (a > base) {
+					dev->base_address[i] = a;
+					DBG("PCI: Correcting IO address %d on "
+					    "device %02x:%02x, now %08lx.\n",
+					    i, dev->bus->number,dev->devfn,a);
+				}
+			} else if (a & PCI_BASE_ADDRESS_MEM_MASK)
+				has_mem = 1;
+		}
+		/*
+		 * Don't enable the planb DMA controller, since its
+		 * assigned memory region collide with control.
+		 * This is a bug between hardware and software.
+		 */
+		if (! (dev->vendor == APPLE_VENDID &&
+		       dev->device == PLANB_DEVID)) {
+			pci_read_config_word(dev, PCI_COMMAND, &cmd);
+			if (has_io && !(cmd & PCI_COMMAND_IO)) {
+				DBG("PCI: Enabling I/O for device %02x:"
+				    "%02x\n", dev->bus->number, dev->devfn);
+				cmd |= PCI_COMMAND_IO;
+				pci_write_config_word(dev, PCI_COMMAND, cmd);
+			}
+			if (has_mem && !(cmd & PCI_COMMAND_MEMORY)) {
+				DBG("PCI: Enabling memory for device %02x:"
+				    "%02x\n", dev->bus->number, dev->devfn);
+				cmd |= PCI_COMMAND_MEMORY;
+				pci_write_config_word(dev, PCI_COMMAND, cmd);
+			}
+		}
 	}
 }
 
diff -uNr linux-2.2.12-pristine/arch/ppc/kernel/pmac_setup.c linux-2.2.12/arch/ppc/kernel/pmac_setup.c
--- linux-2.2.12-pristine/arch/ppc/kernel/pmac_setup.c	Sun Sep 12 16:55:02 1999
+++ linux-2.2.12/arch/ppc/kernel/pmac_setup.c	Sun Sep 12 17:18:16 1999
@@ -640,8 +640,9 @@
         ppc_ide_md.ide_init_hwif = pmac_ide_init_hwif_ports;
 
 	/* _IO_BASE isn't set yet, so it's just as well that
-	   ppc_ide_md.io_base isn't used any more. :-) */
-        ppc_ide_md.io_base = _IO_BASE;
+	   ppc_ide_md.io_base isn't used any more. :-)
+        ppc_ide_md.io_base = _IO_BASE;	*/
+	ppc_ide_md.io_base = 0;
 #endif		
 }
 
diff -uNr linux-2.2.12-pristine/drivers/block/ide-pmac.c linux-2.2.12/drivers/block/ide-pmac.c
--- linux-2.2.12-pristine/drivers/block/ide-pmac.c	Sun Sep 12 16:49:40 1999
+++ linux-2.2.12/drivers/block/ide-pmac.c	Sun Sep 12 17:18:16 1999
@@ -110,10 +110,10 @@
 	pio = ide_get_best_pio_mode(drive, pio, 4, &d);
 	switch (pio) {
 	case 4:
-		out_le32((unsigned *)(IDE_DATA_REG + 0x200 + _IO_BASE), 0x211025);
+		out_le32((unsigned *)(IDE_DATA_REG + 0x200), 0x211025);
 		break;
 	default:
-		out_le32((unsigned *)(IDE_DATA_REG + 0x200 + _IO_BASE), 0x2f8526);
+		out_le32((unsigned *)(IDE_DATA_REG + 0x200), 0x2f8526);
 		break;
 	}
 }
@@ -183,7 +183,7 @@
 		if (i >= MAX_HWIFS)
 			break;
 
-		base = (unsigned long) ioremap(np->addrs[0].address, 0x200) - _IO_BASE;
+		base = (unsigned long) ioremap(np->addrs[0].address, 0x200);
 
 		/* XXX This is bogus. Should be fixed in the registry by checking
 		   the kind of host interrupt controller, a bit like gatwick
diff -uNr linux-2.2.12-pristine/include/asm-ppc/io.h linux-2.2.12/include/asm-ppc/io.h
--- linux-2.2.12-pristine/include/asm-ppc/io.h	Sun Sep 12 16:49:41 1999
+++ linux-2.2.12/include/asm-ppc/io.h	Sun Sep 12 17:18:16 1999
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

--134392852-846930886-937172263=:240--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
