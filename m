Date: Mon, 15 Jan 2001 18:50:47 +0000
Subject: Re: bk 2.4.1pre2 Lombard PCI allocation fails.
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010115185300.45C6EDB9F8@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>Fixed by the kernel, and reassigned to 0x10000000.
>>
>>> BootX uses the MacOS PCI mappings which are bogus for the Rage LT Pro.
>>> Though I'm certain Geert's old PCI resource allocation patch worked fine
>>> in spite of this. There was some message about resource conflict but that
>>> was fixed by the kernel.
>>>
>>> What's the PCI resourced for the card after the kernel has finished
>>> booting?
>>
>>I expect it to be 0x10000000.
>>
>>BTW, this also means we can start using the secondary aperture as well in
>>2.4.0. Gives us an additional 4 kB of frame buffer on little-endian boxes.

indeed:

00:11.0 VGA compatible controller: ATI Technologies Inc: Unknown device 4c49
(rev dc)
 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
 Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 8 min, 32 set, cache line size 08
 Interrupt: pin A routed to IRQ 24
 Region 0: Memory at 81000000 (32-bit, non-prefetchable)
 Region 1: I/O ports at <ignored> [disabled]
 Region 2: Memory at 10000000 (32-bit, non-prefetchable)
 Capabilities: [5c] Power Management version 1
  Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME-
  Status: D0 PME-Enable- DSel=0 DScale=0 PME-

> Well, unfortunately, 0x10000000 is bogus on most cases. (I didn't check
> with Grackle, but for example on UniNorth based machines, this address is
> not routed to PCI).

How can I find out whether the area is bogus?

> Our PCI code still have no knowledge of which physical ranges can
> actually be allocated for each bus. That should be implemented via proper
> root bus resources, but I've not yet been able to find a good solution
> for that (mostly because we would need more resources than the current
> pci_bus structure provides in some cases where the bridge can decode
> several discontiguous regions). Maybe We could fake this, my knowledge of
> the linux resource mecanism is not perfect.

If I yaboot it will the problem go away?
(hadn't worried yet - this is the first prob. I've had with it)

and this machine seems to be in a grey-area where either method will work...

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
