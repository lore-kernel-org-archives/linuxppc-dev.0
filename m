Message-Id: <200009292135.XAA00900@piglet.grunz.lu>
Date: Fri, 29 Sep 2000 23:35:07 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
To: geert@linux-m68k.org
cc: bh40@calva.net, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.10.10009291319510.383-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  29 Sep, this message from Geert Uytterhoeven echoed through cyberspace:
> On Thu, 28 Sep 2000, Michel Lanners wrote:
>> On  28 Sep, this message from Geert Uytterhoeven echoed through cyberspace:
>> >> I'm not sure it would help. It would probably allow a kind of "mapping on
>> >> demand" of the IO region on memory mapped IOs platforms, but unless we
>> >> add another parameter to ioportremap telling it the pci_dev (or at least
>> >> the bus number), we can't "guess" on which IO bus the device is and which
>> >> physical base we must use.
>> >
>> > But we can find out the IO bus by looking in which region the physical address
>> > is located, right? Or do we have the same region on different IO busses?
>> > That would be really weird! Different IO busses should decode different
>> > regions.
>>
>> No, they map the same bus-view IO space (bus addr. 0x0 - 0xsomething) to
>> different windows in the processor's memory space.
>>
>> In other words, you can have IO port 0x3f8 on each of the PCI buses, but
>> it will be accessed at different addresses from the processor's point of
>> view.
>
> Hence you have to fixup any pci_dev on the non-primary bus so its resources
> reflect the `real' I/O addresses, as seen from the CPU.

Yes, you will have to correct the pci_dev IO resources of all devices on
buses other than what you assign as being bus 0. In fact, the way Paul
and Ben intend to do it, is adding a fixed offset in inb() and friends,
and having a MMU mappung such that all IO regions appear as a single
consecutive region within the processor's virtual space.

In other words, IO on bus 1 needs to be offset (in pci_dev) by the size
of bus 0's IO space, and so on.

> So I/O address 0x3f8 (CPU view) is decoded by the first bus and accesses 0x3f8
> on the first bus.
> Say the second bus decodes, 0x1000-0x1fff. Then I/O address 0x13f8 (CPU view)
> is decoded by the second bus and accesses 0x3f8 on the second bus.

Yes, except that the offset to bus 1 will more likely be something like
0x10000 or more, i.e inb(0x103f8) gives you 0x3f8 on bus 1. Remember we
don't want to overlap the IO spaces of the different buses, rather
concatenate them. This saves the hassle of 'correcting' the firmware's
IO resource asignments.

> [ I think I really need the output of lspci -vv on a PC with PCI, AGP and a
>   PCI-PCI bridge (and lots of cards) to bring some clarity... ]

Sure you want to see that? ;-)

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
