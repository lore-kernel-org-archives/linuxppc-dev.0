Message-Id: <200005261837.UAA00662@piglet.grunz.lu>
Date: Fri, 26 May 2000 20:37:39 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: ide_dmaproc
To: Henning.Loeser@Physik.Uni-Marburg.DE
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.OSF.4.02.10005261009230.16152-100000@ax1305.physik.uni-marburg.de>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi there,

On  26 May, this message from Henning Loeser echoed through cyberspace:
>> Could you provide the complete detection messages from dmesg, and a full
>> line of error meessage? You might also want to contact Andre about
>> this...
> I allready contacted Andre, the driver works swell on x86 Boxes ... :-(,
> he said he couldn't help me any futher in the lack of a PPC to check
> what's wrong.

Well, he might not be able to check himself, but might well be able to
tell you under what circumstances those error messages do appear...

> The detection message from dmesg is:
>
> Uniform Multi-Platform E-IDE driver Revision: 6.30
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> AEC6260R: IDE controller on PCI bus 00 dev 68
> AEC6260R: not 100% native mode: will probe irqs later
> AEC6260R: ROM enabled at 0x80810000
> AEC6260: reg49h=0x00 ATA-66 Cable Port0
>     ide0: BM-DMA at 0xf2000800-0xf2000807, BIOS settings: hda:pio, hdb:pio
> AEC6260: reg49h=0x00 ATA-66 Cable Port1
>     ide1: BM-DMA at 0xf2000808-0xf200080f, BIOS settings: hdc:pio, hdd:pio
> hda: IBM-DJNA-352030, ATA DISK drive
> ide0 at 0xf2000840-0xf2000847,0x000 on irq 23
> hda: IBM-DJNA-352030, 19470MB w/1966kB Cache, CHS=39560/16/63, UDMA(66)
>
> The first ide0 and ide1 detection look a little strange to me, as there is
> only one drive connected to ide0 and the adress looks wrong aswell. The
> second ide0 statement appears to be correct with 0xf2000840-847 ...

No, that's actually OK. Those are separate memory regions. I'm not an
IDE expert, so I can't explain what they are for...

> The Error messages look like:
>  hda:hda: lost interrupt
> hda: lost interrupt

Ohhhh, the lost interrupt problem... That was reported quite often
recently. Anyone know what the fix is/was? It never ocured on my system,
so I didn't bother... You might want to look through the list archives
for the solution. Although, I wonder whether it wasn't specifically on
the G4 systems when booted with the wrong booter, i.e. not relevant
here...

> ide_dmaproc: chipset supported ide_dma_lostirq func only: 11
> hda: lost interrupt
> ide_dmaproc: chipset supported ide_dma_lostirq func only: 11
> hda: lost interrupt
[snip]
> Just for completeness, the lspci -vvx reads:
>
> 00:0b.0 Host bridge: Apple Computer Inc. Bandit PowerPC host bridge (rev
> 03)
>
> 00:0d.0 SCSI storage controller: Artop Electronic Corp: Unknown device
> 0007 (rev 01)

SCSI controller? I suppose they masquerade so the regular PCI BIOS and
M$ OS'es leave the controller alone..

>         Subsystem: Unknown device 1191:0007
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 6 min, 6 max, 128 set
>         Interrupt: pin A routed to IRQ 23
>         Region 0: I/O ports at f2000840
>         Region 1: I/O ports at f2000830
>         Region 2: I/O ports at f2000820
>         Region 3: I/O ports at f2000810
>         Region 4: I/O ports at f2000800
>         Capabilities: [58] Power Management version 1
>                 Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 00: 91 11 07 00 05 00 90 02 01 00 00 01 00 80 00 00
> 10: 41 08 00 00 31 08 00 00 21 08 00 00 11 08 00 00
> 20: 01 08 00 00 00 00 00 00 00 00 00 00 91 11 07 00
> 30: 01 00 81 80 58 00 00 00 00 00 00 00 00 01 06 06

Except the funky latency (not really important, I think), everything
looks ok....

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
