Message-Id: <200004030858.KAA00243@piglet.grunz.lu>
Date: Mon, 3 Apr 2000 10:58:16 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: LongTrail PCI resource assignment
To: schmitz@opal.biophys.uni-duesseldorf.de
cc: geert@linux-m68k.org, michdaen@iiic.ethz.ch, paubert@iram.es,
        bh40@calva.net, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.10.10003301038370.19296-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  30 Mar, this message from Michael Schmitz echoed through cyberspace:
> I played a bit with PCI resource remapping in 2.2.15pre9 and I've got a
> few questions, one of them dealing with PCI I/O space:
>
> - OF reports two base addresses for the Mach64, one of which is the I/O
> region (according to the PCI BAR values) at 0xc00. OF reports its address
                                              ^^^^^
Where does that address come from? I'm missing something here..

> as 0x80881000 or some such. Does this mean the I/O registers are
> accessible at 0x80881000, or did OF probing get some bogus values there?

When talking PCI IO space on PowerMacs, always keep in mind that the
host bridge adds an offset to PCI IO space, i.e. IO port 0xc00 on the
bus will have processor physical address 0xf2000c00 or something like
that. The offset might be reprogrammable, but I'd suggest _not_
changing it, as it is also the base address for config space accesses on
that bus...

> - I can successfully remap the MMIO range of the chip to some area outside
> the VRAM range. XFree86 no longer barfs on the mem resource conflict
> (though it still reports the I/O resource conflict with the DVD decoder),
> reports the new mapping of the MMIO range, and starts up nicely. lspci -vv,
> however, still reports the old range. Where's that one stored
> (assuming /proc/pci somewhere), and wouldn't it make more sense to have
> the PCI bus rescanned on reading /proc/pci entries?

If you remap the MMIO range, you need to do two things:

1. change the BAR setting, so that the device will respond to the new
address

2. change the values stored in struct pci_dev, so that the kernel at
large (that includes other drivers, and the interface used by lspci)
knows about it.

> - I picked a range to remap MMIO to more or less at random. How can I find
> out what ranges are believed to be unassigned from OF data?

There's no other way than to look up all assigned regions. However,
don't rely (only) on what OF tells you in the devide tree, as some
assigments may have been changed by PCI fixup code, and OF may have
forgotten some assigments.

Good luck!

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
