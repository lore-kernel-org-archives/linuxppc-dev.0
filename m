Date: Mon, 28 Feb 2000 20:02:19 +0100
From: Andreas Bombe <andreas.bombe@munich.netsurf.de>
To: Albrecht Dreﬂ <ad@mpifr-bonn.mpg.de>
Cc: "Maxim S. Shatskih" <maxim@storagecraft.com>,
        FireWire devel <linux1394-devel@eclipt.uni-klu.ac.at>,
        LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>
Subject: Re: FireWire + Apple PB G3: some success
Message-ID: <20000228200219.B2068@storm.local>
References: <38B3B564.CBA71EC0@mpifr-bonn.mpg.de> <20000224005839.A2784@storm.local> <002801bf7e71$24c2e5a0$0100000a@sauron> <20000224171715.B2137@storm.local> <38BA7122.44C833A9@mpifr-bonn.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <38BA7122.44C833A9@mpifr-bonn.mpg.de>; from ad@mpifr-bonn.mpg.de on Mon, Feb 28, 2000 at 01:59:14PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Feb 28, 2000 at 01:59:14PM +0100, Albrecht Dreﬂ wrote:
> [sorry for the late answer, was out for a few days...]
>
> Andreas Bombe wrote:
> > Setting PCI_COMMAND_IO on the other hand is unneccessary since the
> > PCILynx only uses memory mapped I/O (if I understand PCI config
> > correctly).  I don't know if this flag is harmful if there are no I/O
> > ports.
>
> I don't think that writing a read-only bit will cause any problem.
>
> You told me earlier that the PCILynx was stuck in bus reset, because DMA seems
> not to work.  Does DMA signal success/completition by interrupt?

Yes, I forgot that possibility.

> Then this
> might be a problem with the CardBus Bridge and/or interrupts.  "lspci -vv" tells
> me for the PCILynx
>
> 01:00.0 FireWire (IEEE 1394): Texas Instruments PCILynx/PCILynx2 IEEE 1394 Link
> Layer Controller (rev 04) (prog-if 00 [Generic])
>         Subsystem: Texas Instruments: Unknown device 8000
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 1 min, 2 max, 32 set, cache line size 20
>         Interrupt: pin A routed to IRQ 0
>         Region 0: Memory at 90030000 (32-bit, non-prefetchable)
>         Region 1: Memory at 90000000 (32-bit, non-prefetchable)
>         Region 2: Memory at 90010000 (32-bit, non-prefetchable)
>         Expansion ROM at 90020000
>
> I think IRQ 0 is a little bit suspicious, right?  At least /proc/interrupts does
> not count ANY irq's on this line.

I think we found the guilty party (if IRQ 0 isn't a valid IRQ on PPCs).
You could try to use setpci to configure another IRQ, probably 22
because the CardBus bridge (also using pin A) uses this too, but I
don't know PCI internals well enough to know if this is required.

The question remains why it didn't get an IRQ assigned (either BIOS
(probably not on Mac) or Linux should do this).

--
          Andreas E. Bombe <andreas.bombe@munich.netsurf.de>
http://home.pages.de/~andreas.bombe/                DSA key 0x04880A44

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
