Date: Mon, 27 Mar 2000 13:54:49 +0200 (MET DST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: Gabriel Paubert <paubert@iram.es>, Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: LongTrail PCI resource assignment
In-Reply-To: <Pine.LNX.4.10.10003271332080.32203-100000@opal.biophys.uni-duesseldorf.de>
Message-ID: <Pine.GSO.4.10.10003271353080.11532-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 27 Mar 2000, Michael Schmitz wrote:
> > > 00:11.0 VGA compatible controller: ATI Technologies Inc: Unknown device
> > > 4c49 (rev dc)
> > > 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
> > > 	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> > > 	Latency: 8 min, 32 set, cache line size 08
> > > 	Interrupt: pin A routed to IRQ 24
> > > 	Region 0: Memory at 81000000 (32-bit, non-prefetchable)
> > > 	Region 1: I/O ports at <unassigned>
> > > 	Region 2: Memory at 00010000 (32-bit, non-prefetchable)
> >                             ^^^^^^^^
> > Tadaaa, that's why you need to change PCIBIOS_MIN_MEM. I don't think this is a
> > valid address for PCI memory for your box. To me, it looks like PCIBIOS_MIN_MEM
> > must be 0x80000000 for your machine, but one of the PowerMac gurus can tell for
> > sure.
>
> Well, all I know is that it works.

Ever tried writing to it? :-) For your own safety, please don't! But you can
try reading the CHIP_ID register.

> And this is my PCIBIOS_MIN_MEM:
>
> include/asm/pci.h:#define PCIBIOS_MIN_MEM		0x10000000
>
> Seems it got ignored and the resource allocator picked the next free spot.

Weird, mine got assigned to 0xc0000000, which is what I expect.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248638 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
