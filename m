To: ad@mpifr-bonn.mpg.de
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: FireWire + Apple PB G3: some success
In-Reply-To: Your message of "Mon, 28 Feb 2000 13:59:14 +0100"
	<38BA7122.44C833A9@mpifr-bonn.mpg.de>
References: <38BA7122.44C833A9@mpifr-bonn.mpg.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Message-Id: <20000301010720K.roikawa@rr.iij4u.or.jp>
Date: Wed, 01 Mar 2000 01:07:20 +0900
From: Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


From: Albrecht Dreﬂ <ad@mpifr-bonn.mpg.de>
Subject: Re: FireWire + Apple PB G3: some success
Date: Mon, 28 Feb 2000 13:59:14 +0100
Message-ID: <38BA7122.44C833A9@mpifr-bonn.mpg.de>

> 01:00.0 FireWire (IEEE 1394): Texas Instruments PCILynx/PCILynx2 IEEE 1394 Link
> Layer Controller (rev 04) (prog-if 00 [Generic])
>         Subsystem: Texas Instruments: Unknown device 8000
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 1 min, 2 max, 32 set, cache line size 20
>         Interrupt: pin A routed to IRQ 0
                                     ^^^^^^
>         Region 0: Memory at 90030000 (32-bit, non-prefetchable)
>         Region 1: Memory at 90000000 (32-bit, non-prefetchable)
>         Region 2: Memory at 90010000 (32-bit, non-prefetchable)
>         Expansion ROM at 90020000
>
> I think IRQ 0 is a little bit suspicious, right?  At least /proc/interrupts does
> not count ANY irq's on this line.  The same information for the Cardbus bridge
> is-
>
> 00:13.0 CardBus bridge: Texas Instruments: Unknown device ac1e
                                                            ^^^^

>         Subsystem: Texas Instruments: Unknown device ac1e
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32 set, cache line size 08
>         Interrupt: pin A routed to IRQ 22
>         Region 0: Memory at 80880000 (32-bit, non-prefetchable)
>         Bus: primary=00, secondary=01, subordinate=04, sec-latency=64
> Memory window 0: 90000000-90031000
>         I/O window 0: 00000000-00000003
>         I/O window 1: 00000000-00000003
>         BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
>         16-bit legacy interface ports at 0007

Have you checked if the patch you used is really working correctly?
It setups CardBus bridge's interrupt routing for only TI1130(0xac12)
and TI1131(0xac15) (see the patch to arch/ppc/kernel/pmac_pci.c).
You will have to add support for your CardBus bridge(ID 0xac1e)
referring the document from TI.

Regards,


Ryuichi Oikawa
roikawa@rr.iij4u.or.jp

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
