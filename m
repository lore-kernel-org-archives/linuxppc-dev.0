Date: Mon, 27 Mar 2000 12:35:31 +0200 (MET DST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: Gabriel Paubert <paubert@iram.es>, Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: LongTrail PCI resource assignment
In-Reply-To: <Pine.LNX.4.10.10003271159060.31775-100000@opal.biophys.uni-duesseldorf.de>
Message-ID: <Pine.GSO.4.10.10003271230470.11532-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 27 Mar 2000, Michael Schmitz wrote:
> > > Applying Geerts patch (minus the PCIBIOS_MIN_MEM patch) plus the following
> > > one solves my PCI address conflict for the Mach64 by reallocating the MMIO
> >
> > So it works without changing PCIBIOS_MIN_MEM? I'm wondering what address is
> > assigned to the secondary aperture? Can you please send me the output of
> > `lspci -vv'? Thx!
>
> 00:11.0 VGA compatible controller: ATI Technologies Inc: Unknown device
> 4c49 (rev dc)
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 8 min, 32 set, cache line size 08
> 	Interrupt: pin A routed to IRQ 24
> 	Region 0: Memory at 81000000 (32-bit, non-prefetchable)
> 	Region 1: I/O ports at <unassigned>
> 	Region 2: Memory at 00010000 (32-bit, non-prefetchable)
                            ^^^^^^^^
Tadaaa, that's why you need to change PCIBIOS_MIN_MEM. I don't think this is a
valid address for PCI memory for your box. To me, it looks like PCIBIOS_MIN_MEM
must be 0x80000000 for your machine, but one of the PowerMac gurus can tell for
sure.

> > > aperture, and allows XFree86 4.0 to run on my Lombard.
> >
> > Guess I have to try 4.0 as well...
>
> Does this mean you didn't compile it already? :-)

Indeed. For now, I intend to go with Jack's RPMs...

> I noticed after reading linux-m68k - how did that thread move there?

That's my fault: I really should make the aliases for the Linux/m68k list and
for my personal email less similar. Or perhaps I should switch to a
GUI-based mail client, where I can just click click click click on adresses :-)
Nah, that would lower my productivity.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248638 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
