Message-Id: <200011050936.KAA00822@piglet.grunz.lu>
Date: Sun, 5 Nov 2000 10:36:16 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: whacked out 2.2.18pre17?
To: jeglin@4pi.com
cc: bh40@calva.net, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <p04330101b629db91dabb@[192.168.0.1]>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On   4 Nov, this message from Stefan Jeglinski echoed through cyberspace:
>>That's weird. The symptoms you describe are typicall of a kernel beeing
>>damaged by bus-mastering devices (your 6 PCI cards frighten me ...).
>
>
> Me too :-) FWIW, here they are in order from top to bottom:
>
> Adaptec 2940UW
> Farallon ethernet 10/100
> OrangeLink firewire/usb combo
> Matrox Mystique card
> ixMicro TV card
> ixMicro Twin Turbo card

OK, 6 slots, so I suppose this is a 9x00 or compatible box?

> lspci gives (only):
>
> 00:0b.0 Host bridge: Apple Computer Inc. Bandit PowerPC host bridge (rev 03)
> 00:0d.0 SCSI storage controller: Adaptec AIC-7881U
> 00:0e.0 Ethernet controller: Digital Equipment Corporation DECchip
> 21142/43 (rev 41)
> 00:0f.0 PCI bridge: Action Tec Electronics Inc: Unknown device 0100 (rev 11)
> 00:10.0 Class ff00: Apple Computer Inc. Grand Central I/O (rev 02)
> 01:0c.0 FireWire (IEEE 1394): NEC Corporation: Unknown device 00cd (rev 01)
> 01:0d.0 USB Controller: OPTi Inc. 82C861 (rev 10)

Hmm, there's one bus missing here, the one with the Matrox and the
ixMicro cards. And the accompanying bandit host bridge is missing. You
might want to try my PCI patches (see:
http://www.cpu.lu/~mlan/linux/dev/pci.html). The relevant part is this
here, in arch/ppc/kernel/pmac_pci.c:

 pmac_pcibios_fixup(void))
 {
        struct pci_dev *dev;
-
+       int i, has_io, has_mem;
+       unsigned short cmd;
+       struct bridge_data *bp;
+
        /*
-        * FIXME: This is broken: We should not assign IRQ's to IRQless
-        *        devices (look at PCI_INTERRUPT_PIN) and we also should
-        *        honor the existence of multi-function devices where
-        *        different functions have different interrupt pins. [mj]
+        * The generic PCI code scans only bus 0 for devices and P2P
+        * bridges. We fix this here based on the array of host
+        * bridges.
+        *
+        * However, we need to treat the bus behind chaos with special
+        * care. chaos doesn't like being poked at while scanning that
+        * bus...
+        *
+        * Comments on everything below to mlan@cpu.lu...
         */
+       for (bp = bridge_list; bp != NULL; bp = bp->next) {
+               if (bp->bus_number == 0) continue;
+               if (strcmp(bp->node->name, "chaos") != 0)
+                       pci_scan_peer_bridge (bp->bus_number);
+       }
+
        for(dev=pci_devices; dev; dev=dev->next)
        {

Mind you, the patch is not complete; but it should make your other PCI
primary bus appear in lspci's output.

Ben, Paul, any chance to get this code snippet into 2.2.18? At least,
then, 9x00 and clones would be supported for their second PCI bus....
Note that I'm simply avoiding chaos at all.

Stefan, a final note, if you want to turn multihead, it might be a good
idea performance-wise to put both of your graphics boards not in the
same PCI bus... ie one into slots 1-3, and the other in slots 4-6.

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
