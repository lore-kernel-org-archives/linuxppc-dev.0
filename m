Message-ID: <38DFCDF1.9390BB7D@pop.agri.ch>
Date: Mon, 27 Mar 2000 23:09:07 +0200
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


Michel Lanners wrote:
>
> Hey there,
>
> On  27 Mar, this message from Andreas Tobler echoed through cyberspace:
> > I hoped to get some support in detecting the CardBus card I have
> > correctly. I tried it on a 2399p3, the lspci -vv shows the same as below
> > except the function of the card.
>
> Well, card detection obviously works :-)
>
> > What I try to get working is the following:
> >
> > excerpt of lspci -vv from a 2215p14 kernel patched with this patch:
> >
> > http://www.rr.iij4u.or.jp/~roikawa/others.html
> >
> > I don't know if the numbering below is correct: 01:00.0 for the first
> > function of the device.
>
> Sure, why not? Device 0 on bus 1 is fine; as far as PCI is concerned,
> the CardBus bridge is treated like a PCI-to-PCI bridge, and its child
> bus is assigned bus no. 1.
>
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
> > ---lspci2215p14---
> > 00:13.0 CardBus bridge: Texas Instruments PCI1131 (rev 01)
> >       Subsystem: Unknown device 104c:ac15
> >       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> > Stepping- SERR- FastB2B-
> >       Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> > <TAbort- <MAbort- >SERR- <PERR-
> >       Latency: 32 set, cache line size 08
> >       Interrupt: pin A routed to IRQ 22
> >       Region 0: Memory at 81803000 (32-bit, non-prefetchable)
> >       Bus: primary=00, secondary=01, subordinate=04, sec-latency=64
> > Memory window 0: 90000000-90005000
> >       BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
> >       16-bit legacy interface ports at 0007
>                                 ^^^^^^^^^^^^^
> Anybody knows what this is supposed to mean?
>
> > 00:13.1 CardBus bridge: Texas Instruments PCI1131 (rev 01)
>
> This is the second half of the CardBus bridge; its config space is a
> mirror of the first function, except those registers that control the
> slots, where func0 controls slot0 and func1 controls slot1.
>
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
>
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
>
> Anybody else?

All I can add is, the function of the devices work ok (under 2215p14
with R.O. patch but NOT under 2399p3), means Modem(with an additional
patch and the eth1)
I can mail over the ppp1 -> (Xircom modem) and with eth1 in promiscous
mode I can ftp/nfs/telnet etc.

Sorry my lack of....

Andreas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
