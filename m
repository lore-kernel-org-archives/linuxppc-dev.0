Date: Sun, 28 Apr 2002 17:25:30 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Problem in pmac PCI fixup
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <E171qYc-0000AJ-00@piglet.grunz.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

I'm about to finish a bit of work on planb, the 7x00/8x00 video input
driver.

It's now in rather good shape (acording to my very low standards ;-);
among other things, it doesn't need to do any PCI fixups by hand
anymore.

Almost, I should add, because there's a problem left with the IRQ. In
fact, the PCI code does not fill pdev->irq for many pmac devices, since
OF doesn't set PCI_INTERRUPT_LINE. Therefore, we have fixup code in
pmac_pci.c; however, that code checks PCI_INTERRUPT_PIN on the device.

Now, the problem is that planb doesn't have a PCI_INTERRUPT_PIN setting,
therefore fixup doesn't get applied. And hardcoding the IRQ in the planb
driver code doesn't seem right....

Since the PCI fixup code is about fixing broken things anyway, I'd
propose we remove the check for PCI_INTERRUPT_PIN and solely rely on OF
properties to see whether there's an interrupt present at all. Patch
would be this here (hand-pasted):

--- linux-2.4.19-pre6-lvm-gentoo/arch/ppc/kernel/pmac_pci.c     Sun Apr 28 09:14:09 2002
+++ linux-2.4.16-planb/arch/ppc/kernel/pmac_pci.c       Sun Apr 28 17:18:39 2002
@@ -493,8 +503,6 @@
                unsigned char pin;
                struct device_node* node;

-               if (pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin) || !pin)
-                       continue; /* No interrupt generated -> no fixup */
                node = pci_device_to_OF_node(dev);
                if (!node) {
                        printk("No OF node for device %x:%x\n", dev->bus->number, dev->devfn >> 3);

Anybody have any problem with that approach?

Thanks, and cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
