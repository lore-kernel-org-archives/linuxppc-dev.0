Message-Id: <199908082034.WAA02973@piglet.cpu.lu>
Date: Sun, 8 Aug 1999 22:34:15 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Various PMac PCI patches
To: mj@ucw.cz, paulus@cs.anu.edu.au, linuxppc-dev@lists.linuxppc.org
cc: hedrick@Astro.Dyer.Vanderbilt.Edu
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY="134392852-846930886-934144455=:2922"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--134392852-846930886-934144455=:2922
Content-Type: TEXT/plain; CHARSET=US-ASCII

Hi all,

Here are some PMac PCI patches and fixes:

1. On the PowerMac, OpenBugware explicitly ignores PCI_INTERRUPT_LINE.
However, a quick grep shows that numerous drivers rely on its value for
driver initialization. Therefore, I've added a config_write to the
existing IRQ fixup code, so that the IRQ gets written back into
the PCI config register. By the way, the fixup function (fix_intr) is
in a general file (pci.c), but only called from PMac-specific code. 

Can those of you with PCI add-on boards see if this breaks anything?

Patch is below (pci.c-patch).

Andre: not sure, but this might have helped for the Promise as well...

2. I've hacked pmac_pcibios_fixup with a few changes:

- It now checks for PCI buses other than the first one, on all bridges.
This should help on the 7x00/8x00 machines (bandit and chaos host
bridges) as well as on the 9x00 (two bandit bridges; second bus would
be invisible up to now). If anyone has a 9x00, can  you test if this
works? For me it only detects one of two devices on bus 1....

- The IRQ fixup code already checks for the presence of interrupts, so
I'v changed Martin's comment. Also, I'm not sure if PMac PCI boards can
ever use more than one interrupt, as all PCI interrupt lines are OR'ed
together on the bridge....

- I've added IO and memory space enable code from i386's fixup code,
minus some port address checks.This should be safe on all concerned
machines.

Patch for all this is below (pmac_pci.c-patch).

If no one objects to these patches, who volounteers to get them into
the mainstream? ;-)

Thanks

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "

--134392852-846930886-934144455=:2922
Content-Type: TEXT/plain; CHARSET=US-ASCII
Content-Description: pci.c-patch

--- linux/arch/ppc/kernel/pci.c	Sat Aug  7 17:09:25 1999
+++ linux-ideok/arch/ppc/kernel/pci.c	Sun Aug  8 22:01:36 1999
@@ -100,8 +100,10 @@
 		if (reg == 0 || ((reg[0] >> 8) & 0xff) != dev->devfn)
 			continue;
 		/* this is the node, see if it has interrupts */
-		if (node->n_intrs > 0) 
+		if (node->n_intrs > 0) {
 			dev->irq = node->intrs[0].line;
+			pci_write_config_byte(dev,PCI_INTERRUPT_LINE, dev->irq);
+		}
 		break;
 	}
 }

--134392852-846930886-934144455=:2922
Content-Type: TEXT/plain; CHARSET=US-ASCII
Content-Description: pmac_pci.c-patch

--- linux/arch/ppc/kernel/pmac_pci.c	Sat Aug  7 17:09:25 1999
+++ linux-ideok/arch/ppc/kernel/pmac_pci.c	Sun Aug  8 22:25:57 1999
@@ -17,6 +17,7 @@
 #include <linux/delay.h>
 #include <linux/string.h>
 #include <linux/init.h>
+#include <linux/malloc.h>
 #include <asm/io.h>
 #include <asm/pgtable.h>
 #include <asm/prom.h>
@@ -447,18 +448,36 @@
 pmac_pcibios_fixup(void))
 {
 	struct pci_dev *dev;
-	
+	int i, has_io, has_mem;
+	unsigned short cmd;
+       	struct bridge_data *bp;
+
+	for (bp = bridge_list; bp != NULL; bp = bp->next) {
+		struct pci_bus *b;
+
+		if (bp->bus_number == 0) continue;
+
+		b = kmalloc(sizeof(struct pci_bus), GFP_KERNEL);
+		memset(b, 0, sizeof(*b));
+		b->next = pci_root.next;
+		pci_root.next = b;
+		b->number = b->secondary = bp->bus_number;
+		b->subordinate = 0xff;
+		b->subordinate = pci_scan_bus(b);
+	}
+
 	/*
-	 * FIXME: This is broken: We should not assign IRQ's to IRQless
-	 *	  devices (look at PCI_INTERRUPT_PIN) and we also should
-	 *	  honor the existence of multi-function devices where
-	 *	  different functions have different interrupt pins. [mj]
+	 * FIXME: This is broken: We should honor the existence of multi-
+	 *	  function devices where different functions have different
+	 *	  interrupt pins. [mj]
+	 *	  Not sure if on the PMac, a single PCI slot can generate
+	 *	  more than one interrupt... [mlan]
 	 */
 	for(dev=pci_devices; dev; dev=dev->next)
 	{
 		/*
-		 * Open Firmware often doesn't initialize the,
-		 * PCI_INTERRUPT_LINE config register properly, so we
+		 * Open Firmware doesn't initialize the
+		 * PCI_INTERRUPT_LINE config register, so we
 		 * should find the device node and se if it has an
 		 * AAPL,interrupts property.
 		 */
@@ -469,6 +488,45 @@
 		    !pin)
 			continue; /* No interrupt generated -> no fixup */
                 fix_intr(bp->node->child, dev);
+
+		/*
+		 * Open Firmware does not enable I/O and memory space
+		 * response on PCI devices. We try to fix this, but we need to
+		 * be sure that the BIOS didn't forget to assign an address
+		 * to the device. [mj]
+		 */
+		has_io = has_mem = 0;
+		for(i=0; i<6; i++) {
+			unsigned long a = dev->base_address[i];
+			if (a & PCI_BASE_ADDRESS_SPACE_IO) {
+				has_io = 1;
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
+		 */
+		if (((dev->class >> 8) != PCI_CLASS_DISPLAY_VGA) &&
+		    ((dev->class >> 8) != PCI_CLASS_STORAGE_IDE)) {
+			pci_read_config_word(dev, PCI_COMMAND, &cmd);
+			if (has_io && !(cmd & PCI_COMMAND_IO)) {
+				printk("PCI: Enabling I/O for device %02x:%02x\n",
+					dev->bus->number, dev->devfn);
+				cmd |= PCI_COMMAND_IO;
+				pci_write_config_word(dev, PCI_COMMAND, cmd);
+			}
+			if (has_mem && !(cmd & PCI_COMMAND_MEMORY)) {
+				printk("PCI: Enabling memory for device %02x:%02x\n",
+					dev->bus->number, dev->devfn);
+				cmd |= PCI_COMMAND_MEMORY;
+				pci_write_config_word(dev, PCI_COMMAND, cmd);
+			}
+		}
 	}
 }
 

--134392852-846930886-934144455=:2922--

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
