Date: Tue, 9 May 2000 10:55:29 +0200 (MET DST)
From: Henning Loeser <Henning.Loeser@Physik.Uni-Marburg.DE>
To: Michel Lanners <mlan@cpu.lu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: AEC6260M PCI-IDE-Card
In-Reply-To: <200005082113.XAA00798@piglet.grunz.lu>
Message-ID: <Pine.OSF.4.02.10005091004480.15244-100000@ax1305.physik.uni-marburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,
here come the requested lspci outputs

On Mon, 8 May 2000, Michel Lanners wrote:
[snip]
> >>hde: IBM-DJNA-352030, ATA DISK drive
> >>ide2 at 0x840-0x847,0x000 on irq 25
>                                ^^^^^^
> This sounds reasonable. To be sure, can you send an lspci -vv and
> lspci -bvv along?

lspci -vv gives:

00:0b.0 Host bridge: Apple Computer Inc. Bandit PowerPC host bridge (rev
03)

[snip] (the Bandit host bridge are not important I figure nor the Voodoo3
VGA card)

00:0f.0 SCSI storage controller: Artop Electronic Corp: Unknown device
0007 (rev 01)
	Subsystem: Unknown device 1191:0007
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-	Status: Cap+ 66Mhz- UDF- FastB2B+
ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 6 min, 6 max, 128 set
	Interrupt: pin A routed to IRQ 25
	Region 0: I/O ports at 0840
	Region 1: I/O ports at 0830
	Region 2: I/O ports at 0820
	Region 3: I/O ports at 0810
	Region 4: I/O ports at 0800
	Capabilities: [58] Power Management version 1
		Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 Class ff00: Apple Computer Inc. Grand Central I/O (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-	Status: Cap- 66Mhz- UDF- FastB2B-
ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 32 set, cache line size 08
	Region 0: Memory at f3000000 (32-bit, non-prefetchable)

and lspci -bvv gives :
[snip]
00:0f.0 SCSI storage controller: Artop Electronic Corp: Unknown device
0007 (rev 01)
	Subsystem: Unknown device 1191:0007
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <P
ERR-
	Latency: 6 min, 6 max, 128 set
	Interrupt: pin A routed to IRQ 0
	Region 0: I/O ports at 0840
	Region 1: I/O ports at 0830
	Region 2: I/O ports at 0820
	Region 3: I/O ports at 0810
	Region 4: I/O ports at 0800
	Capabilities: [58] Power Management version 1
		Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Looks pretty much identical to me ???

I hope this helps.
>
> >>hde: IBM-DJNA-352030, 19470MB w/1966kB Cache, CHS=39560/16/63, UDMA(66)
>
> Disk found. I guess if it gets through here, it is at least able to read
> id info from the drive...

When I use pdisk /dev/hde I can even read the partition map. But it keeps
reporting loosing its interrupt and cloggs my messages file every 10
seconds :-)
Furthermore I can't format a partition as the access is drat slow (I
suppose the lost interrupt) it seems as if the computer is locked but it
simply is tied up trying to do stuff on the drive.
> Hm, might this be a problem with doing DMA?

Don't know. Supposetly the driver wants DMA ??? I simply don't know.

Henning
--------------------------------------------------------------------------
Henning Loeser					      Fachbereich Physik
email: henning.loeser@physik.uni-marburg.de	      AG Oberflaechen
						      Philipps-Uni Marburg


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
