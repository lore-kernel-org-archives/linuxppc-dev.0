Return-Path: <linuxppcdev@qbjnet.com>
Received: from kunk.qbjnet.com (ddsl1-28.ddsl.mr.net [137.192.135.28])
	by ozlabs.org (Postfix) with SMTP id 83C0567A67
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Mar 2005 04:52:59 +1100 (EST)
Date: 14 Mar 2005 17:52:57 -0000
Message-ID: <20050314175257.13153.qmail@kunk.qbjnet.com>
From: linuxppcdev@qbjnet.com
To: linuxppc-dev@ozlabs.org
Subject: Re: DMA appears broken in 2.6.11 for Mac 7200
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben Said:
> On Mon, 2005-03-14 at 03:51 +0000, linuxppcdev@qbjnet.com wrote:
> > Just updated a couple of old Mac 7200 (601) boxen and ran into trouble with
> > the ide driver and a promise PDC20267 card. 
> > 
> > The very same drives and card work fine on a 9500 but hang on a 7200. If
> > I set the kernel arg ide=nodma I get in the dmesg:
> > ide_setup: ide=nodma : Prevented DMA
> > and the 7200 boots and runs fine.
> > 
> > Another suspect, the mace ethernet driver (which also appears to use DMA)
> > doesn't work on the 7200 with 2.6.11 but does with 2.4.28 and it works 
> > with 2.6.11 on the 9500.
> 
> Interesting. Not sure what's up, though. Those old machines were known
> to have bugs relative to cache coherency... also check wetehr we are
> setting the cache line size properly in PCI devices. You can also try to
> disable use of PCI memory write & invalidate command in all devices.
 
Here is some info from a 7200 booted off of 2.6.11:

dmesg

Total memory = 112MB; using 256kB for hash table (at c04c0000)
Linux version 2.6.11.2 (root@dev) (gcc version 3.3.4 (Debian 1:3.3.4-9ubuntu5)) 
#8 Sun Mar 13 12:50:26 CST 2005
Found a Grand Central mac-io controller, rev: 2, mapped at 0xfdf00000
PowerMac motherboard: PowerMac 7200/7300
Cache coherency enabled for bandit/PSX
Found Bandit PCI host bridge at 0xf2000000. Firmware bus number: 0->0
nvram: OF partition at 0x1800
nvram: XP partition at 0x1300
nvram: NR partition at 0x1400
On node 0 totalpages: 28672
  DMA zone: 28672 pages, LIFO batch:7
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Built 1 zonelists
Kernel command line:  root=/dev/hda2 video=platinumfb ide=nodma
ide_setup: ide=nodma : Prevented DMA
System has 32 possible interrupts
PID hash table entries: 512 (order: 9, 8192 bytes)
.
.
.
Forcing PCI IDE into native mode: 0000:00:0d.0
Rewrite of PROGIF failed !
.
.
PDC20267: IDE controller at PCI slot 0000:00:0d.0
PDC20267: chipset revision 2
PDC20267: ROM enabled at 0x80860000
PDC20267: 100% native mode on irq 23
PDC20267: (U)DMA Burst Bit DISABLED Primary PCI Mode Secondary PCI Mode.
    ide0: BM-DMA at 0x0480-0x0487, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x0488-0x048f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
.
.
eth0: Digital DS21143 Tulip rev 33 at c805a000, 00:40:F6:84:F8:C0, IRQ 25.
pmac: can't request resource 0!

lspci -vv

0000:00:0b.0 Host bridge: Apple Computer Inc. Bandit PowerPC host bridge (rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin ? routed to IRQ 22

0000:00:0d.0 RAID bus controller: Promise Technology, Inc. 20267 (rev 02)
        Subsystem: Promise Technology, Inc.: Unknown device 4d32
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 23
        Region 0: I/O ports at 04f0 [size=80860000]
        Region 1: I/O ports at 04e0 [size=4]
        Region 2: I/O ports at 04d0 [size=8]
        Region 3: I/O ports at 04c0 [size=4]
        Region 4: I/O ports at 0480 [size=64]
        Region 5: Memory at 80840000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at 00010000 [disabled]
        Capabilities: [58] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

.
.
0000:00:0f.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 21)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (5000ns min, 10000ns max), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 25
        Region 0: I/O ports at 0400 [size=80800000]
        Region 1: Memory at 80871000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at 00040000 [disabled]

0000:00:10.0 Class ff00: Apple Computer Inc. Grand Central I/O (rev 02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
        Latency: 32, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin ? routed to IRQ 22
        Region 0: Memory at f3000000 (32-bit, non-prefetchable)


Does this help at all?

Bob
