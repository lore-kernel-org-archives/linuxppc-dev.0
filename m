Date: Mon, 27 Mar 2000 12:01:12 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Gabriel Paubert <paubert@iram.es>, Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: LongTrail PCI resource assignment
In-Reply-To: <Pine.GSO.4.10.10003271148530.11532-100000@dandelion.sonytel.be>
Message-ID: <Pine.LNX.4.10.10003271159060.31775-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Applying Geerts patch (minus the PCIBIOS_MIN_MEM patch) plus the following
> > one solves my PCI address conflict for the Mach64 by reallocating the MMIO
>
> So it works without changing PCIBIOS_MIN_MEM? I'm wondering what address is
> assigned to the secondary aperture? Can you please send me the output of
> `lspci -vv'? Thx!

00:11.0 VGA compatible controller: ATI Technologies Inc: Unknown device
4c49 (rev dc)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 8 min, 32 set, cache line size 08
	Interrupt: pin A routed to IRQ 24
	Region 0: Memory at 81000000 (32-bit, non-prefetchable)
	Region 1: I/O ports at <unassigned>
	Region 2: Memory at 00010000 (32-bit, non-prefetchable)
	Capabilities: [5c] Power Management version 1
		Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


> > aperture, and allows XFree86 4.0 to run on my Lombard.
>
> Guess I have to try 4.0 as well...

Does this mean you didn't compile it already? :-)

> > -					r->start -= r->end;
> > +					r->end -= r->start;
> >  					r->start = 0;
> >  				}
> >  			}
>
> I copied this buglet from arch/i386/kernel/pci-i386.c.

I noticed after reading linux-m68k - how did that thread move there?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
