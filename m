Message-ID: <38B3B564.CBA71EC0@mpifr-bonn.mpg.de>
Date: Wed, 23 Feb 2000 11:24:36 +0100
From: Albrecht Dre_ <ad@mpifr-bonn.mpg.de>
MIME-Version: 1.0
To: FireWire devel <linux1394-devel@eclipt.uni-klu.ac.at>
CC: LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>
Subject: FireWire + Apple PB G3: some success
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


[I am new to the FireWire list, so please excuse me if this is not new for you.
Sorry, this is a quite long message]

I had some success with Newer Tech's FireWire2Go CardBus device on an Apple
PowerBook G3/333 (aka "Lombard") with LinuxPPC 2.2.14pre9.  This is what I did:

* added Ryuichi Oikawa patch to the kernel which enables the pci scan to "see"
CardBus devices without the PCMCIA package (there is a japanese description at
http://www.rr.iij4u.or.jp/~roikawa/others.html [which I can't read], but the
patch seems to work really fine)

* used the FireWire package for 2.2.14.  As always with LinuxPPC, I had to patch
the pcilynx driver, as OpenFirmware (Apple's "BIOS") does not activate all
devices automatically:

--- snip here -----------------------------------------------------------------
--- pcilynx.c.orig      Wed Feb 23 10:47:21 2000
+++ pcilynx.c   Wed Feb 23 10:52:33 2000
@@ -1212,6 +1212,7 @@
         struct ti_lynx *lynx; /* shortcut to currently handled device */
         unsigned long page;
         unsigned int i;
+       unsigned short w;

         if (num_of_cards == MAX_PCILYNX_CARDS) {
                 PRINT_G(KERN_WARNING, "cannot handle more than %d cards.  "
@@ -1225,7 +1226,8 @@
         lynx->id = num_of_cards-1;
         lynx->dev = dev;

-        pci_set_master(dev);
+       pci_read_config_word (dev, PCI_COMMAND, &w);
+       pci_write_config_word (dev, PCI_COMMAND, w | PCI_COMMAND_MASTER |
PCI_COMMAND_MEMORY | PCI_COMMAND_IO);

         if (!request_irq(dev->irq, lynx_irq_handler, SA_SHIRQ,
                          PCILYNX_DRIVER_NAME, lynx)) {
--- patch ends here -----------------------------------------------------------

* `modprobe pcilynx' gives the following kernel messages:

kernel: ieee1394: registered pcilynx driver, initializing now
kernel: pcilynx: looking for PCILynx cards
kernel: pcilynx0: allocated interrupt 0
kernel: pcilynx0: allocated PCL memory 65536 Bytes @ 0xc12f0000
kernel: pcilynx0: remapped memory spaces reg 0xd8887000, rom 0xd88ab001, ram
0xd8889000, aux 0xd889a000
kernel: pcilynx0: found 1394a conform PHY (using extended register set)
kernel: pcilynx0: PHY vendor id 0x00c02d
kernel: pcilynx0: PHY product id 0x303562
kernel: pcilynx0: resetting bus on request
kernel: ieee1394: detected 1 pcilynx adapter

* remaining questions:

I have a FW disk attached to the bus, but when I run testlibraw, it is not seen:

[root@tirilap133 src]# ./testlibraw
successfully got handle
current generation number: 0
1 card(s) found
  nodes on bus:  0, card name: pcilynx
using first card found: 0 nodes on bus, local ID is 0

doing transactions with custom tag handler

using standard tag handler and synchronous calls
[root@tirilap133 src]#

Is this normal, or where ist the problem?

Thanks, Albrecht.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
