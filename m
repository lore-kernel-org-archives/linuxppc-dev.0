Message-ID: <38F77A99.7A233BC8@amberdata.demon.co.uk>
Date: Fri, 14 Apr 2000 21:07:53 +0100
From: David Monro <davidm@amberdata.demon.co.uk>
MIME-Version: 1.0
To: Linux/ppc Dev List <linuxppc-dev@lists.linuxppc.org>
Subject: prep interrupt routing
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I've had my suspicions for a little while that all is not quite right
with the kernel interrupt routing for the IBM 850, caused by the
behaviour of my SCSI controller (the ncr53c8xx driver ended up in a loop
which looked exactly like what happens on an intel PC when the interrupt
routing is wrong). Looks like I'm right. Dumping the residual data on my
850 shows that all PCI interrupts are mapped to IRQ 15:

Integrated PCI device DevFunc 0x58 interrupt line(s)  routed to 8259
line(s) 8259
Integrated PCI device DevFunc 0x60 interrupt line(s) A routed to 8259
line(s) 15(L)
Integrated PCI device DevFunc 0x70 interrupt line(s) A routed to 8259
line(s) 15(L)
Integrated PCI device DevFunc 0x80 interrupt line(s) A routed to 8259
line(s) 15(L)
PCI Slot 1 DevFunc 0xb0 interrupt line(s) A/B/C/D routed to 8259 line(s)
15(L)/15(L)/15(L)/15(L)
PCI Slot 2 DevFunc 0x90 interrupt line(s) A/B/C/D routed to 8259 line(s)
15(L)/15(L)/15(L)/15(L)

DevFunc 0x58 is dev 0xb0, the Fire Coral ISA bridge, with no interrupts.
DevFunc 0x60 is dev 0xc0, the onboard ethernet.
DevFunc 0x70 is dev 0xe0, the onboard video.
DevFunc 0x80 is dev 0x10, which I don't have but would be onboard SCSI
on a 7248.
DevFunc 0xb0 is def 0x16, which is an ncr53c825 SCSI card.
DevFunc 0x90 is dev 0x12, which is currently a GXT-150P graphics board.

Forcing the interrupt line to be 15 for all PCI devices (by hacking
prep_pci.c) means that my SCSI host adapter is now detected and
initialized correctly.

Of course putting all of the devices on irq 15 doesn't seem like a
particularly good idea. Does anybody know a) which chip is responsible
for the mapping and b) how to reprogram it?

Cheers,

	David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
