Date: Fri, 26 May 2000 10:33:08 +0200 (MET DST)
From: Henning Loeser <Henning.Loeser@Physik.Uni-Marburg.DE>
To: Michel Lanners <mlan@cpu.lu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ide_dmaproc
In-Reply-To: <200005251849.UAA00650@piglet.grunz.lu>
Message-ID: <Pine.OSF.4.02.10005261009230.16152-100000@ax1305.physik.uni-marburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On Thu, 25 May 2000, Michel Lanners wrote:
> Welcome to the club ;-)
Thanks ... It's always nice to be welcome :-)

>
> > I patched a standart 2.2.15 kernel source with Andre's ide-patches (they
> > wouldn't install on Pauls rsynced stable tree)
>
> Yeah, I haven't bothered to rsync the stable tree, as kernel.org has
> always worked fine for me....

Oh I didn't even try yours, Andre's allready wouldn't work ...

> Could you provide the complete detection messages from dmesg, and a full
> line of error meessage? You might also want to contact Andre about
> this...
I allready contacted Andre, the driver works swell on x86 Boxes ... :-(,
he said he couldn't help me any futher in the lack of a PPC to check
what's wrong.

The detection message from dmesg is:

Uniform Multi-Platform E-IDE driver Revision: 6.30
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
AEC6260R: IDE controller on PCI bus 00 dev 68
AEC6260R: not 100% native mode: will probe irqs later
AEC6260R: ROM enabled at 0x80810000
AEC6260: reg49h=0x00 ATA-66 Cable Port0
    ide0: BM-DMA at 0xf2000800-0xf2000807, BIOS settings: hda:pio, hdb:pio
AEC6260: reg49h=0x00 ATA-66 Cable Port1
    ide1: BM-DMA at 0xf2000808-0xf200080f, BIOS settings: hdc:pio, hdd:pio
hda: IBM-DJNA-352030, ATA DISK drive
ide0 at 0xf2000840-0xf2000847,0x000 on irq 23
hda: IBM-DJNA-352030, 19470MB w/1966kB Cache, CHS=39560/16/63, UDMA(66)

The first ide0 and ide1 detection look a little strange to me, as there is
only one drive connected to ide0 and the adress looks wrong aswell. The
second ide0 statement appears to be correct with 0xf2000840-847 ...

The Error messages look like:
 hda:hda: lost interrupt
hda: lost interrupt
ide_dmaproc: chipset supported ide_dma_lostirq func only: 11
hda: lost interrupt
ide_dmaproc: chipset supported ide_dma_lostirq func only: 11
hda: lost interrupt
 hda1ide_dmaproc: chipset supported ide_dma_lostirq func only: 11
[snip]
 hda6 hda7ide_dmaproc: chipset supported ide_dma_lostirq func only: 11
hda: lost interrupt
 hda8 hda9

For all nine Partitions on the drive. If I start pdisk /dev/hda I can read
the partition map (after a couple of seconds) and my /var/log/messages
file reads:
May 26 10:17:28 ma1304 kernel: ide_dmaproc: chipset supported
ide_dma_lostirq func only: 11
May 26 10:17:28 ma1304 kernel: hda: lost interrupt
May 26 10:17:38 ma1304 kernel: ide_dmaproc: chipset supported
ide_dma_lostirq func only: 11
May 26 10:17:38 ma1304 kernel: hda: lost interrupt

Just for completeness, the lspci -vvx reads:

00:0b.0 Host bridge: Apple Computer Inc. Bandit PowerPC host bridge (rev
03)

00:0d.0 SCSI storage controller: Artop Electronic Corp: Unknown device
0007 (rev 01)
        Subsystem: Unknown device 1191:0007
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 6 min, 6 max, 128 set
        Interrupt: pin A routed to IRQ 23
        Region 0: I/O ports at f2000840
        Region 1: I/O ports at f2000830
        Region 2: I/O ports at f2000820
        Region 3: I/O ports at f2000810
        Region 4: I/O ports at f2000800
        Capabilities: [58] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 91 11 07 00 05 00 90 02 01 00 00 01 00 80 00 00
10: 41 08 00 00 31 08 00 00 21 08 00 00 11 08 00 00
20: 01 08 00 00 00 00 00 00 00 00 00 00 91 11 07 00
30: 01 00 81 80 58 00 00 00 00 00 00 00 00 01 06 06

00:0f.0 VGA compatible controller: 3Dfx Interactive, Inc.: Unknown device
0005 (rev 01)

00:10.0 Class ff00: Apple Computer Inc. Grand Central I/O (rev 02)
01:0b.0 Non-VGA unclassified device: Apple Computer Inc. Control Video
01:0d.0 Class ff00: Apple Computer Inc. PlanB Video-In (rev 01)

Do you know what this is supposed to mean? Everything seems to work,
untill the kernel actually tries to access the drive. I tried ide0=reset
in the kernel options aswell as ide0=autotune. Didn't help.

Henning

--------------------------------------------------------------------------
Henning Loeser					      Fachbereich Physik
email: henning.loeser@physik.uni-marburg.de	      AG Oberflaechen
						      Philipps-Uni Marburg


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
