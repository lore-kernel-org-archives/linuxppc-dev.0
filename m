Message-ID: <38BA7122.44C833A9@mpifr-bonn.mpg.de>
Date: Mon, 28 Feb 2000 13:59:14 +0100
From: Albrecht Dre_ <ad@mpifr-bonn.mpg.de>
MIME-Version: 1.0
To: Andreas Bombe <andreas.bombe@munich.netsurf.de>
CC: "Maxim S. Shatskih" <maxim@storagecraft.com>,
        FireWire devel <linux1394-devel@eclipt.uni-klu.ac.at>,
        LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>
Subject: Re: FireWire + Apple PB G3: some success
References: <38B3B564.CBA71EC0@mpifr-bonn.mpg.de> <20000224005839.A2784@storm.local> <002801bf7e71$24c2e5a0$0100000a@sauron> <20000224171715.B2137@storm.local>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


[sorry for the late answer, was out for a few days...]

Andreas Bombe wrote:
> Setting PCI_COMMAND_IO on the other hand is unneccessary since the
> PCILynx only uses memory mapped I/O (if I understand PCI config
> correctly).  I don't know if this flag is harmful if there are no I/O
> ports.

I don't think that writing a read-only bit will cause any problem.

You told me earlier that the PCILynx was stuck in bus reset, because DMA seems
not to work.  Does DMA signal success/completition by interrupt?  Then this
might be a problem with the CardBus Bridge and/or interrupts.  "lspci -vv" tells
me for the PCILynx

01:00.0 FireWire (IEEE 1394): Texas Instruments PCILynx/PCILynx2 IEEE 1394 Link
Layer Controller (rev 04) (prog-if 00 [Generic])
        Subsystem: Texas Instruments: Unknown device 8000
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 1 min, 2 max, 32 set, cache line size 20
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at 90030000 (32-bit, non-prefetchable)
        Region 1: Memory at 90000000 (32-bit, non-prefetchable)
        Region 2: Memory at 90010000 (32-bit, non-prefetchable)
        Expansion ROM at 90020000

I think IRQ 0 is a little bit suspicious, right?  At least /proc/interrupts does
not count ANY irq's on this line.  The same information for the Cardbus bridge
is-

00:13.0 CardBus bridge: Texas Instruments: Unknown device ac1e
        Subsystem: Texas Instruments: Unknown device ac1e
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 set, cache line size 08
        Interrupt: pin A routed to IRQ 22
        Region 0: Memory at 80880000 (32-bit, non-prefetchable)
        Bus: primary=00, secondary=01, subordinate=04, sec-latency=64
Memory window 0: 90000000-90031000
        I/O window 0: 00000000-00000003
        I/O window 1: 00000000-00000003
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
        16-bit legacy interface ports at 0007

Any cardbus/pci gurus out there?

Thanks, Albrecht.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
