Message-Id: <200003271146.NAA00323@piglet.grunz.lu>
Date: Mon, 27 Mar 2000 13:46:07 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: LongTrail PCI resource assignment
To: Geert.Uytterhoeven@sonycom.com
cc: schmitz@opal.biophys.uni-duesseldorf.de, paubert@iram.es, bh40@calva.net,
        linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.GSO.4.10.10003271230470.11532-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  27 Mar, this message from Geert Uytterhoeven echoed through cyberspace:
> On Mon, 27 Mar 2000, Michael Schmitz wrote:
>> > > Applying Geerts patch (minus the PCIBIOS_MIN_MEM patch) plus the following
>> > > one solves my PCI address conflict for the Mach64 by reallocating the MMIO
>> >
>> > So it works without changing PCIBIOS_MIN_MEM? I'm wondering what address is
>> > assigned to the secondary aperture? Can you please send me the output of
>> > `lspci -vv'? Thx!
>>
>> 00:11.0 VGA compatible controller: ATI Technologies Inc: Unknown device
>> 4c49 (rev dc)
>> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
>> 	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>> 	Latency: 8 min, 32 set, cache line size 08
>> 	Interrupt: pin A routed to IRQ 24
>> 	Region 0: Memory at 81000000 (32-bit, non-prefetchable)
>> 	Region 1: I/O ports at <unassigned>
>> 	Region 2: Memory at 00010000 (32-bit, non-prefetchable)
>                             ^^^^^^^^
> Tadaaa, that's why you need to change PCIBIOS_MIN_MEM. I don't think this is a
> valid address for PCI memory for your box.

IIRC, physical RAM is mapped starting at 0x0.... with host bridges
being transparent for mem accesses that would mean your memory region is
in the midst of RAM... funny, no?

> To me, it looks like PCIBIOS_MIN_MEM
> must be 0x80000000 for your machine, but one of the PowerMac gurus can tell for
> sure.

On my machine, yes, OF starts mapping mem resources at 0x80000000; but I
can't remember reading explicitly what the memory map is on PowerMacs.

Ben?

Cheers

Michel

PS I just checked in OF's device tree; each host bridge has an assigned
range for memory resources; for bus 0, its: 0x80000000 - 0x8fffffff.

Which means we should probably implement 'corrected' mem resources per
bus like I did with IO resources.

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
