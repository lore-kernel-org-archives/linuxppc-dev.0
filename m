Return-Path: <stewart.midgley@sync.monash.edu.au>
Received: from kyle.its.monash.edu.au (kyle.its.monash.edu.au [130.194.13.163])
	by ozlabs.org (Postfix) with ESMTP id 2069ADDEF7
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Jun 2007 14:28:13 +1000 (EST)
Received: from moe.its.monash.edu.au ([130.194.13.88])
	by kyle.its.monash.edu.au
	(Sun Java System Messaging Server 6.2-4.03 (built Sep 22 2005))
	with ESMTP id <0JJG001UGCAXWLA0@kyle.its.monash.edu.au> for
	linuxppc-dev@ozlabs.org; Mon, 11 Jun 2007 13:28:09 +1000 (EST)
Received: from moe.its.monash.edu.au (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with ESMTP id EC10DAB542	for
	<linuxppc-dev@ozlabs.org>; Mon, 11 Jun 2007 13:28:08 +1000 (EST)
Received: from [130.194.91.73]
	(l-cl27-g41-a.physics.monash.edu.au [130.194.91.73])
	by moe.its.monash.edu.au (Postfix) with ESMTP id CB6894FB06	for
	<linuxppc-dev@ozlabs.org>; Mon, 11 Jun 2007 13:28:08 +1000 (EST)
Date: Mon, 11 Jun 2007 14:23:56 +1000
From: stewart midgley <stewart.midgley@sync.monash.edu.au>
Subject: linux kernel BUG REPORT
	"/usr/src/linux-2.6.11.7/drivers/ide/ppc/pmac.c"
To: linuxppc-dev@ozlabs.org
Message-id: <466CCE5C.5040506@sync.monash.edu.au>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

(1) One line summary: Occasional problem with hard disk access, that 
kills an iBookG4, but is fixed by rebooting

(2) Full description: Occasional error with the following kernel message
 > EXT3-fs error device hda17 in start_transaction : Journal has aborted
The /var partition is mounted on /dev/hda17

The machine will not respond, acknowledging key board commands but cant 
execute code (e.g., /sbin/sync or /sbin/shutdown -r now), with 
complaints that I forgot to write down. Problem fixed by rebooting, but 
all unsaved data is lost. We speculated about hard disk failure and 
consulted the web. A link suggested looking at 
/usr/src/linux-2.6.11.7/drivers/ide/ppc/pmac.c, and I find the following 
clues in /var/log/messages (at the time of the last failure).

 > Jun  7 04:02:11 l-cl27-g41-a logrotate: ALERT exited abnormally with [1]
 > Jun  8 04:02:11 l-cl27-g41-a logrotate: ALERT exited abnormally with [1]
 > Jun  8 15:49:39 l-cl27-g41-a kernel: ide-pmac lost interrupt, dma 
status: 8480
 > Jun  8 15:49:39 l-cl27-g41-a kernel: hda: lost interrupt
 > Jun  8 15:49:39 l-cl27-g41-a kernel: hda: dma_intr: status=0xd0 { Busy }
 > Jun  8 15:49:39 l-cl27-g41-a kernel:
 > Jun  8 15:49:39 l-cl27-g41-a kernel: ide: failed opcode was: unknown
 > Jun  8 15:49:39 l-cl27-g41-a kernel: hda: DMA disabled
 > Jun  8 15:49:55 l-cl27-g41-a kernel: ide0: reset: success
 > Jun  8 17:24:48 localhost syslogd 1.4.1: restart.
 > Jun  8 17:24:48 localhost syslog: syslogd startup succeeded

(3) Key words: drivers, ide, ppc pmac.c

(4) cat /proc/version
Linux version 2.6.11.7 (root@w-cl27-g41-aa.spme.monash.edu.au) (gcc 
version 3.3.3 (Yellow Dog Linux 3.3.3-16.ydl.4)) #1 Wed Apr 27 10:16:03 
EST 2005
rnel version

(5) Not an Oops problem

(6) Problem creation script: N/A, an infrequent problem

(7) Environment information

(7.1) Software is Yellow Dog linux 4.0
script ver_linux finds

 Linux l-cl27-g41-a.physics.monash.edu.au 2.6.11.7 #1 Wed Apr 27 
10:16:03 EST 2005 ppc ppc ppc GNU/Linux

Gnu C                  3.3.3
Gnu make               3.80
binutils               2.15.90
util-linux             2.12pre
mount                  2.12pre
module-init-tools      2.4.26
e2fsprogs              1.35
reiserfsprogs          line
reiser4progs           line
pcmcia-cs              3.2.7
quota-tools            3.10.
PPP                    2.4.2
isdn4k-utils           3.3
nfs-utils              1.0.6
Linux C Library        2.3.3
Dynamic linker (ldd)   2.3.3
Procps                 3.2.0
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
./ver_linux: line 90: udevinfo: command not found
Modules Loaded         ipx p8022 psnap llc sg ohci1394 ieee1394 sd_mod 
scsi_mod vfat fat

(7.2) cat /proc/cpuinfo
processor       : 0
cpu             : 7447A, altivec supported
clock           : 1066MHz
revision        : 1.1 (pvr 8003 0101)
bogomips        : 1060.86
machine         : PowerBook6,5
motherboard     : PowerBook6,5 MacRISC3 Power Macintosh
detected as     : 287 (iBook G4)
pmac flags      : 0000001b
L2 cache        : 512K unified
memory          : 768MB
pmac-generation : NewWorld

(7.3)  cat /proc/modules
ipx 28188 0 - Live 0xf21ee000
p8022 1792 1 ipx, Live 0xf21df000
psnap 3460 1 ipx, Live 0xf1032000
llc 6460 2 p8022,psnap, Live 0xf21e1000
sg 34916 0 - Live 0xf20f6000
ohci1394 35716 0 - Live 0xf1075000
ieee1394 106984 1 ohci1394, Live 0xf21c1000
sd_mod 15120 0 - Live 0xf1028000
scsi_mod 137404 2 sg,sd_mod, Live 0xf2401000
vfat 12736 0 - Live 0xf102d000
fat 41468 1 vfat, Live 0xf1061000

(7.4) cat /proc/modules
ipx 28188 0 - Live 0xf21ee000
p8022 1792 1 ipx, Live 0xf21df000
psnap 3460 1 ipx, Live 0xf1032000
llc 6460 2 p8022,psnap, Live 0xf21e1000
sg 34916 0 - Live 0xf20f6000
ohci1394 35716 0 - Live 0xf1075000
ieee1394 106984 1 ohci1394, Live 0xf21c1000
sd_mod 15120 0 - Live 0xf1028000
scsi_mod 137404 2 sg,sd_mod, Live 0xf2401000
vfat 12736 0 - Live 0xf102d000
fat 41468 1 vfat, Live 0xf1061000
[root@l-cl27-g41-a scripts]# cat /proc/ioports
00000000-007fffff : /pci@f2000000
00802000-01001fff : /pci@f0000000
  00802400-008024ff : 0000:00:10.0
    00802400-008024ff : radeonfb
ff7fe000-ffffdfff : /pci@f4000000
cat /proc/iomem
80000000-8fffffff : /pci@f2000000
  80000000-8007ffff : 0001:10:17.0
    80000000-8007ffff : 0.80000000:mac-io
      80000050-8000007f : 0.00000050:gpio
      80008000-800080ff : 0.00010000:i2s
        80008000-800080ff : i2s-a (tx dma)
      80008100-800081ff : 0.00010000:i2s
        80008100-800081ff : i2s-a (rx dma)
      80008200-800082ff : 0.00010000:i2s
      80008300-800083ff : 0.00010000:i2s
      80008800-800088ff : 0.00020000:ata-3
        80008800-800088ff : ide-pmac (dma)
      80010000-80010fff : 0.00010000:i2s
        80010000-80010fff : i2s-a
      80013000-80013000 : 0.00013000:ch-b
      80013010-80013010 : 0.00013000:ch-b
      80013020-80013020 : 0.00013020:ch-a
      80013030-80013030 : 0.00013020:ch-a
      80013040-80013040 : 0.00013000:ch-b
      80013050-80013050 : 0.00013020:ch-a
      80015000-80015fff : 0.00015000:timer
      80016000-80017fff : 0.00016000:via-pmu
        80016000-80017fff : via-pmu
      80018000-80018fff : 0.00018000:i2c
      80020000-80020fff : 0.00020000:ata-3
        80020000-80020fff : ide-pmac (ports)
      80040000-8007ffff : interrupt-controller
        80040000-8007ffff : 0.00040000:interrup
  80080000-800800ff : 0001:10:1b.2
    80080000-800800ff : ehci_hcd
  80081000-80081fff : 0001:10:1b.1
    80081000-80081fff : ohci_hcd
  80082000-80082fff : 0001:10:1b.0
    80082000-80082fff : ohci_hcd
  80083000-80083fff : 0001:10:1a.0
    80083000-80083fff : ohci_hcd
90000000-9fffffff : /pci@f0000000
  90000000-9000ffff : 0000:00:10.0
    90000000-9000ffff : radeonfb
  98000000-9fffffff : 0000:00:10.0
    98000000-9fffffff : radeonfb
f1000000-f1ffffff : /pci@f0000000
  f1000000-f101ffff : 0000:00:10.0
f3000000-f3ffffff : /pci@f2000000
f5000000-f5ffffff : /pci@f4000000
  f5000000-f5000fff : 0002:20:0e.0
    f5000000-f50007ff : ohci1394
  f5004000-f5007fff : 0002:20:0d.0
    f5004000-f5007fff : Kauai ATA
  f5200000-f53fffff : 0002:20:0f.0
    f5200000-f53fffff : sungem
f8000000-f8ffffff : uni-n

(7.5) /sbin/lspci -vvv
00:0b.0 Host bridge: Apple Computer Inc. UniNorth 2 AGP
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 16, Cache Line Size 08
        Capabilities: [80] AGP version 1.0
                Status: RQ=8 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- 
Rate=x1

00:10.0 VGA compatible controller: ATI Technologies Inc Radeon RV280 
[Radeon Mobility 9200 M9+] (rev 01) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Radeon RV280 [Radeon Mobility 
9200 M9+]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 255 (2000ns min), Cache Line Size 08
        Interrupt: pin A routed to IRQ 48
        Region 0: Memory at 0000000098000000 (32-bit, prefetchable) 
[size=00000000f1000000]
        Region 1: I/O ports at 802400 [size=256]
        Region 2: Memory at 0000000090000000 (32-bit, non-prefetchable) 
[size=64K]
        Expansion ROM at 0000000000020000 [disabled]
        Capabilities: [58] AGP version 2.0
                Status: RQ=80 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=8 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- 
Rate=x1
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0001:10:0b.0 Host bridge: Apple Computer Inc. UniNorth 2 PCI
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 16, Cache Line Size 08

0001:10:17.0 Class ff00: Apple Computer Inc. KeyLargo/Intrepid Mac I/O
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 16, Cache Line Size 08
        Region 0: Memory at 0000000080000000 (32-bit, non-prefetchable)

0001:10:18.0 USB Controller: Apple Computer Inc. KeyLargo/Intrepid USB 
(prog-if 10 [OHCI])
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 0

0001:10:19.0 USB Controller: Apple Computer Inc. KeyLargo/Intrepid USB 
(prog-if 10 [OHCI])
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 0

0001:10:1a.0 USB Controller: Apple Computer Inc. KeyLargo/Intrepid USB 
(prog-if 10 [OHCI])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 16 (750ns min, 21500ns max), Cache Line Size 08
        Interrupt: pin A routed to IRQ 29
        Region 0: Memory at 0000000080083000 (32-bit, non-prefetchable)

0001:10:1b.0 USB Controller: NEC Corporation USB (rev 43) (prog-if 10 
[OHCI])
        Subsystem: NEC Corporation USB
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 16 (250ns min, 10500ns max), Cache Line Size 08
        Interrupt: pin A routed to IRQ 63
        Region 0: Memory at 0000000080082000 (32-bit, non-prefetchable)
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0001:10:1b.1 USB Controller: NEC Corporation USB (rev 43) (prog-if 10 
[OHCI])
        Subsystem: NEC Corporation USB
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 16 (250ns min, 10500ns max), Cache Line Size 08
        Interrupt: pin B routed to IRQ 63
        Region 0: Memory at 0000000080081000 (32-bit, non-prefetchable)
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0001:10:1b.2 USB Controller: NEC Corporation USB 2.0 (rev 04) (prog-if 
20 [EHCI])
        Subsystem: NEC Corporation USB 2.0
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 16 (4000ns min, 8500ns max), Cache Line Size 08
        Interrupt: pin C routed to IRQ 63
        Region 0: Memory at 0000000080080000 (32-bit, non-prefetchable)
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0002:20:0b.0 Host bridge: Apple Computer Inc. UniNorth 2 Internal PCI
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 16, Cache Line Size 08

0002:20:0d.0 Class ff00: Apple Computer Inc. UniNorth/Intrepid ATA/100
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 32, Cache Line Size 08
        Interrupt: pin ? routed to IRQ 39
        Region 0: Memory at 00000000f5004000 (32-bit, non-prefetchable)

0002:20:0e.0 FireWire (IEEE 1394): Apple Computer Inc. UniNorth 2 
FireWire (rev 81) (prog-if 10 [OHCI])
        Subsystem: Apple Computer Inc.: Unknown device 5811
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (3000ns min, 6000ns max), Cache Line Size 08
        Interrupt: pin A routed to IRQ 40
        Region 0: Memory at 00000000f5000000 (32-bit, non-prefetchable)

        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

0002:20:0f.0 Ethernet controller: Apple Computer Inc. UniNorth 2 GMAC 
(Sun GEM) (rev 80)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 16 (16000ns min, 16000ns max), Cache Line Size 08
        Interrupt: pin A routed to IRQ 41
        Region 0: Memory at 00000000f5200000 (32-bit, non-prefetchable) 
[size=00000000f5100000]
        Expansion ROM at 0000000000100000 [disabled]

(7.6) cat /proc/scsi/scsi
Attached devices:

(7.7) Other relevant information:

Hi Paul, Benjamin and helpers,

I found your names in the code and among list of maintainers.
Perhaps you already fixed this and I need to upgrade my 2 year old kernel?

regards

Stewart

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   Dr Stewart Midgley
   Instrumentation Group, 
   Monash Centre for Synchrotron Science,
   Monash University, Clayton, VIC 3800
   Room 111, Building 26
   ph: +61 3 9905 9350   fax: +61 3 9905 3637
   email: stewart.midgley@sync.monash.ed.au
   http://www.sync.monash.edu.au/instgroup/
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
