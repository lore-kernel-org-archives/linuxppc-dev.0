Date: Mon, 27 Mar 2000 13:34:50 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
cc: Gabriel Paubert <paubert@iram.es>, Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: LongTrail PCI resource assignment
In-Reply-To: <Pine.GSO.4.10.10003271230470.11532-100000@dandelion.sonytel.be>
Message-ID: <Pine.LNX.4.10.10003271332080.32203-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > 00:11.0 VGA compatible controller: ATI Technologies Inc: Unknown device
> > 4c49 (rev dc)
> > 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
> > 	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> > 	Latency: 8 min, 32 set, cache line size 08
> > 	Interrupt: pin A routed to IRQ 24
> > 	Region 0: Memory at 81000000 (32-bit, non-prefetchable)
> > 	Region 1: I/O ports at <unassigned>
> > 	Region 2: Memory at 00010000 (32-bit, non-prefetchable)
>                             ^^^^^^^^
> Tadaaa, that's why you need to change PCIBIOS_MIN_MEM. I don't think this is a
> valid address for PCI memory for your box. To me, it looks like PCIBIOS_MIN_MEM
> must be 0x80000000 for your machine, but one of the PowerMac gurus can tell for
> sure.

Well, all I know is that it works.

And this is my PCIBIOS_MIN_MEM:

include/asm/pci.h:#define PCIBIOS_MIN_MEM		0x10000000

Seems it got ignored and the resource allocator picked the next free spot.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
