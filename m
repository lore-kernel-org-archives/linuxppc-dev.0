Date: Thu, 29 Nov 01 14:24:17 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0111292224.AA01126@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: ide_init_hwif_ports
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras <paulus@samba.org> wrote:

> Thanks for the explanation.  I'll ask Vojtech Pavlik and Andre Hedrick
> if they can suggest a better way (drivers/ide/via82cxxx.c has
                                    ^^^^^^^^^^^^^^^^^^^^^^^
> Vojtech's name on it).

That VIA82CXXX fast mode code makes the Adirondack *hang* on the partition
check if enabled... I'm keeping it out of the picture for now.

> Actually, I have just noticed this code in drivers/ide/ide-pci.c:
>
>                 if (IDE_PCI_DEVID_EQ(d->devid, DEVID_UM8886A) ||
>                     IDE_PCI_DEVID_EQ(d->devid, DEVID_UM8886BF) ||
>                     IDE_PCI_DEVID_EQ(d->devid, DEVID_UM8673F)) {
>                         hwif->irq = hwif->channel ? 15 : 14;
>                         goto bypass_umc_dma;
>                 }
>
> We may be able to get something similar added for our case(s).

Keep in mind that, as I just said, from what I could tell the IDE interrupt
routing is fixed by the board circuitry *outside* the chip, although I doubt
that anyone out there has routed the IDE interrupts anywhere other than IRQ14
and IRQ15... But never say never, we have some new boards coming up with a
GT64260 and a VT82C686B, and it seems like they want to avoid using the PeeCee
dual 8259 PIC as much as possible, so who knows, maybe they'll route the IDE
interrupts upstairs bypassing the VT82C686B altogether... Didn't I just hear
someone on this list talk about their IDE interrupts going to an EPIC?

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
