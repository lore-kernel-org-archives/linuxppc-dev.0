Message-Id: <199908251727.TAA00387@piglet.cpu.lu>
Date: Wed, 25 Aug 1999 19:27:11 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Various PMac PCI patches
To: ran@krazynet.com, Paul.Mackerras@cs.anu.edu.au
cc: mj@ucw.cz, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <19990819204726.A82@gondolin.asf>
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY="134392852-1804289383-935602031=:386"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--134392852-1804289383-935602031=:386
Content-Type: TEXT/plain; CHARSET=US-ASCII

Hi all,

Here is another try for the PMac PCI multi-patch, trying to solve the
mapping problem with IO ports on PCI devices, among others.

What's in the patch:

- scanning of PCI buses on host bridges other than the first one;
- verbose reporting of fixed IRQ numbers, plus a comment change;
- mapping of a bigger PCI IO-space on the bandit host bridge (23 bits
according to Apple's doc) (Comments, Paul? Others?);
- inclusion of i386's PCI fixup code, enabling IO- and memory-space
response on devices that have such spaces, plus the fix for correciong
IO space offset according to the host bridge;
- setting of _IO_BASE to 0, so inb/outb don't do any offset;
- removal of _IO_BASE from ide-pmac.c

Ryan,

On  19 Aug, this message from Ryan Nielsen echoed through cyberspace:
> It detects two out of two on mi 9600.

Can you check this patch still works for you? It should now also
correct the IO-space addresses, so your PCI card should work in both
buses.

To the list, can those with IDE onboard their PMacs check that this
keeps your IDE working?

There is, however, still an issue with PCMCIA on Powerbook machines,
because:

On  25 Aug, this message from Paul Mackerras echoed through cyberspace:
> I guess that's the best approach overall.  Where I can see it failing
> is with things like pcmcia.  You insert a pcmcia modem card (say) and
> the pcmcia code allocates some I/O ports and tells the card to use
> them.

I will have to investigate this problem, and how the card's and the
pcmcia driver's perspective of that IO port address are. We might be
able to base a solution to this problem on the address of the CardBus
bridge's IO space, as found in that bridge's config space (unbiased),
and in its corresponding struct pci_dev (should have offest applied).

As usual, happy patching... and direct your comments and complaints at
my inbox ;-)

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "

--134392852-1804289383-935602031=:386
Content-Type: TEXT/plain; CHARSET=US-ASCII
Content-Description: 2.2.11-pci-patches

diff -uNr linux-2.2.11/arch/ppc/kernel/pci.c linux/arch/ppc/kernel/pci.c
--- linux-2.2.11/arch/ppc/kernel/pci.c	Sun Aug 15 19:54:40 1999
+++ linux/arch/ppc/kernel/pci.c	Sun Aug 22 12:41:31 1999
@@ -99,8 +99,11 @@
 		if (reg == 0 || ((reg[0] >> 8) & 0xff) != dev->devfn)
 			continue;
 		/* this is the node, see if it has interrupts */
-		if (node->n_intrs > 0) 
+		if (node->n_intrs > 0) {
 			dev->irq = node->intrs[0].line;
+			printk ("PCI: setting IRQ %d on device %02x:%02x.\n",
+				dev->irq, dev->bus->number, dev->devfn);
+		}
 		break;
 	}
 }
diff -uNr linux-2.2.11/arch/ppc/kernel/pmac_pci.c linux/arch/ppc/kernel/pmac_pci.c
--- linux-2.2.11/arch/ppc/kernel/pmac_pci.c	Sat Aug  7 17:09:25 1999
+++ linux/arch/ppc/kernel/pmac_pci.c	Tue Aug 24 22:56:14 1999
@@ -17,6 +17,7 @@
 #include <linux/delay.h>
 #include <linux/string.h>
 #include <linux/init.h>
+#include <linux/malloc.h>
 #include <asm/io.h>
 #include <asm/pgtable.h>
 #include <asm/prom.h>
@@ -418,7 +419,7 @@
 				ioremap(addr->address + 0x800000, 0x1000);
 			bp->cfg_data = (volatile unsigned char *)
 				ioremap(addr->address + 0xc00000, 0x1000);
-			bp->io_base = (void *) ioremap(addr->address, 0x10000);
+			bp->io_base = (void *) ioremap(addr->address, 0x800000);
 		} else {
 			/* XXX */
 			bp->cfg_addr = (volatile unsigned int *)
@@ -447,20 +448,30 @@
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
+		 # so no need to worry about multifunction cards.
 		 */
 		struct bridge_data *bp = bridges[dev->bus->number];
 		unsigned char pin;
@@ -469,6 +480,63 @@
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
+					printk (KERN_INFO "PCI: Correcting IO"
+						"address %d on device %02x:"
+						"%02x, now %08lx.\n", i, 
+						dev->bus->number,dev->devfn,a);
+				}
+			} else if (a & PCI_BASE_ADDRESS_MEM_MASK)
+				has_mem = 1;
+		}
+		/*
+		 * Don't enable VGA-compatible cards since they have
+		 * fixed I/O and memory space.
+		 *
+		 * Don't enabled disabled IDE interfaces either because
+		 * some BIOSes may reallocate the same address when they
+		 * find that no devices are attached.
+		 *
+		 * FIXME: Is this really relevant here?
+		 */
+		if (((dev->class >> 8) != PCI_CLASS_DISPLAY_VGA) &&
+		    ((dev->class >> 8) != PCI_CLASS_STORAGE_IDE)) {
+			pci_read_config_word(dev, PCI_COMMAND, &cmd);
+			if (has_io && !(cmd & PCI_COMMAND_IO)) {
+				printk("PCI: Enabling I/O for device %02x:"
+				    "%02x\n", dev->bus->number, dev->devfn);
+				cmd |= PCI_COMMAND_IO;
+				pci_write_config_word(dev, PCI_COMMAND, cmd);
+			}
+			if (has_mem && !(cmd & PCI_COMMAND_MEMORY)) {
+				printk("PCI: Enabling memory for device %02x:"
+				    "%02x\n", dev->bus->number, dev->devfn);
+				cmd |= PCI_COMMAND_MEMORY;
+				pci_write_config_word(dev, PCI_COMMAND, cmd);
+			}
+		}
 	}
 }
 
diff -uNr linux-2.2.11/include/asm-ppc/io.h linux/include/asm-ppc/io.h
--- linux-2.2.11/include/asm-ppc/io.h	Sun Aug 15 19:54:48 1999
+++ linux/include/asm-ppc/io.h	Fri Aug 20 19:59:16 1999
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
diff -uNr linux-2.2.11/drivers/block/ide-pmac.c linux/drivers/block/ide-pmac.c
--- linux-2.2.11/drivers/block/ide-pmac.c	Wed Aug 25 18:59:00 1999
+++ linux/drivers/block/ide-pmac.c	Wed Aug 25 18:53:22 1999
@@ -109,10 +109,10 @@
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
@@ -182,7 +182,7 @@
 		if (i >= MAX_HWIFS)
 			break;
 
-		base = (unsigned long) ioremap(np->addrs[0].address, 0x200) - _IO_BASE;
+		base = (unsigned long) ioremap(np->addrs[0].address, 0x200);
 
 		/* XXX This is bogus. Should be fixed in the registry by checking
 		   the kind of host interrupt controller, a bit like gatwick

--134392852-1804289383-935602031=:386--

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
