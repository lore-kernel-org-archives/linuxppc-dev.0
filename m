Message-ID: <38E08532.F607A0F5@pop.agri.ch>
Date: Tue, 28 Mar 2000 12:11:04 +0200
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: mlan@cpu.lu
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: pci-detection of Cardbus cards.
References: <200003271944.VAA01622@piglet.grunz.lu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Michel,

Michel Lanners wrote:
[snip]
> > Also, how would it be best to integrate the detection of such cards? In
> > the patch above the special bridge TI1131 was hardcoded. But as I know,
> > other PB's (Lombard) uses different (TI1211 or so) chips.
> > Is it necessary to code all different chips or is there a generaL approach?
>
> No, search by device class:
> (from include/linux/pci_ids.h)
> #define PCI_CLASS_BRIDGE_CARDBUS        0x0607
>
> .... which is what's being done:
> +#if defined(SCAN_CARDBUS)
> +               if ((dev->class >> 8) == PCI_CLASS_BRIDGE_PCI ||
> +                   (dev->class >> 8) == PCI_CLASS_BRIDGE_CARDBUS) {
> +#else
>                 if ((dev->class >> 8) == PCI_CLASS_BRIDGE_PCI) {
> +#endif
>

You mean adding this to the 2399p3 code would show some more results?
Have to try.

[snip]

> > 01:00.0 Ethernet controller: Xircom: Unknown device 0003 (rev 03)
> >       Subsystem: Unknown device 115d:1181
> >       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+
> > Stepping- SERR- FastB2B-
> >       Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> > <TAbort- <MAbort- >SERR- <PERR-
> >       Latency: 20 min, 40 max, 40 set
> >       Interrupt: pin A routed to IRQ 255
> >       Region 0: I/O ports at <unassigned>
>
> Hmmm... memory got assigned, but not IO ports? Who's supposed to assign
> those? And IRQ info is wrong... Are you sure the above patch is run
> _before_ the existing fixup function? It doesn't seem to cooperate
> well... See also this in your previous mail:

The IRQ is wrong, but when I run the pcmcia_cs package the IRQ got on
22/23 as expected from ti1131. And as long as it works without
bombing....

Well here  I have to clarify, the patch I spoke about I only applied to
2215p14 and not to the 2399p3 where the PCI-fixup is added.

> > Found 00:99 [104c/ac15] 000607 02
> > Fixups for bus 00
> > Scanning CardBus bridge 00:13.0
> > Scanning CardBus bridge 00:13.1
> > Bus scan for 00 returning with max=09
>                                      ^^
> A bit high, the number of PCI buses so far ;-)
>
> Plus, bus 1 (the one with your CardBus devices) never gets scanned, so
> it's probably not in the chain of buses, and doesn't get resources
> assigned.

I have to play around with the sources.
Hope so today.

Thanks,

Andreas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
