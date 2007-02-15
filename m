Return-Path: <dlclark@chtech.com>
Received: from mail26a.sbc-webhosting.com (mail26a.sbc-webhosting.com
	[216.173.237.164]) by ozlabs.org (Postfix) with SMTP id 9A124DDF6C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Feb 2007 03:10:53 +1100 (EST)
Received: from mx74.stngva01.us.mxservers.net (204.202.242.145)
	by mail26a.sbc-webhosting.com (RS ver 1.0.95vs) with SMTP id
	2-0414175452 for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Feb 2007 11:04:13 -0500 (EST)
From: "David Clark" <dlclark@chtech.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: 16-bit PCMCIA resource allocation 
Date: Thu, 15 Feb 2007 10:04:28 -0600
Message-ID: <000001c7511a$f8ef4b60$0f01a8c0@longhorn>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am having difficulty getting 16-bit PCMCIA cards to work on a custom
MPC8245-based board.  I am running kernel 2.6.14.2 with pcmciautils-014.
I have successfully run the network off a 32-bit PCMCIA network card so
I am certain that the interface to the PCMCIA socket is functional.  I'm
thinking it is just a resource allocation issue but I am having
difficulty understanding how it is supposed to work.  When I insert the
card or call "pccardctl insert" I receive the error "cs: unable to map
card memory."

>From following the source I can tell that the error occurs when the
kernel is trying read the cards CIS and it fails to allocate/map memory
to do so.  Do I need to tell the kernel to reserve a block of memory for
16-bit PCMCIA cards?  I assume this would be from the PCI busses address
space.  Is this done using the "/etc/pcmcia/config.opts" file?  I was
under the impression that I didn't need this file for a Yenta socket in
a PPC environment. Could is be the way my PCIbus is setup? ...

Any hints are greatly appreciated.

David Clark  

Below are a few relevant outputs.

********    pccardctl status  ********    
Socket 0:
  5.0V 16-bit PC Card

********    dmesg  ********    
dmesg
oop registered
io scheduler deadline registered
RAMDISK driver initialized: 4 RAM disks of 32768K size 1024 blocksize
QS6612: Registered new driver
Linux Tulip driver version 1.1.13 (May 11, 2002)
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media 100baseTx (#3) described by a 21143 SYM PHY
(4) block.
tulip0:  Index #1 - Media 100baseTx-FDX (#5) described by a 21143 SYM
PHY (4) bl
ock.
tulip0:  Index #2 - Media 10baseT (#0) described by a 21142 Serial PHY
(2) block
.
tulip0:  Index #3 - Media 10baseT-FDX (#4) described by a 21142 Serial
PHY (2) b
lock.
eth0: Digital DS21143 Tulip rev 65 at c9002c00, 00:40:42:07:00:04, IRQ
16.
Yenta: CardBus bridge found at 0000:00:14.0 [0000:0000]
PCI: Bus 2, cardbus bridge: 0000:00:14.0
  IO window: 00000000-000001ff
  IO window: 00000400-000005ff
  PREFETCH window: bf8ff000-bfcfefff
  MEM window: 80000000-803fffff
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:14.0, mfunc 0x00101000, devctl 0x66
Yenta TI: socket 0000:00:14.0 probing PCI interrupt failed, trying to
fix
Yenta TI: socket 0000:00:14.0 falling back to parallel PCI interrupts
Yenta TI: socket 0000:00:14.0 parallel PCI interrupts ok
Yenta: ISA IRQ mask 0x0000, PCI irq 19
Socket status: 30000410
pcmcia: parent PCI bridge I/O window: 0xfe000000 - 0xfebfffff
pcmcia: parent PCI bridge Memory window: 0x80000000 - 0xfcffffff
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 3, 32768 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
cs: memory probe 0x80000000-0xfcffffff:IP-Config: Complete:
      device=eth0, addr=192.168.1.228, mask=255.255.255.0,
gw=255.255.255.255,
     host=vx411c, domain=, nis-domain=(none),
     bootserver=255.255.255.255, rootserver=255.255.255.255, rootpath=
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 100k init
 - nothing to change...
 - nothing to change...
 excluding 0x80000000-0xfcffffff
cs: unable to map card memory!
cs: unable to map card memory!
- nothing to change...
 - data bits = 8
 - parity = none
 - stop bits = 1
 - RTS/CTS is disabled
 - baud rate = 57600<5>***CH DEBUG:  s->callback->event() = 0xc0121b54
cs: unable to map card memory!
cs: unable to map card memory!


********    lspci -vvv   ********    
~ # lspci -vvv
00:00.0 Host bridge: Motorola MPC8245 [Unity] (rev 14)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- 
<MAbort+ >SERR- <PERR-
	Latency: 64, Cache Line Size 08
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at <unassigned> (32-bit, prefetchable)
	Region 2: Memory at <unassigned> (32-bit, prefetchable)

00:10.0 I2O: Anchor Chips Inc. AN3042Q CO-MEM Lite (rev 02) (prog-if 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-
	Latency: 128, Cache Line Size 08
	Interrupt: pin ? routed to IRQ 20
	Region 0: Memory at 00000000bfff8000 (32-bit, non-prefetchable)
[size=32
K]
	Region 1: I/O ports at bffff8 [size=8]

00:12.0 Ethernet controller: Digital Equipment Corporation DECchip
21142/43 (rev
 41)
	Subsystem: Unknown device 0400:0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-
	Latency: 128 (5000ns min, 10000ns max), Cache Line Size 08
	Interrupt: pin A routed to IRQ 16
	Region 0: I/O ports at bfff00 [size=128]
	Region 1: Memory at 00000000bfff7c00 (32-bit, non-prefetchable)
[size=1K
]
	Expansion ROM at 00000000dfbc0000 [disabled] [size=256K]

00:13.0 PCI bridge: Texas Instruments PCI2250 PCI-to-PCI Bridge (rev 02)
(prog-i
f 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-
	Latency: 128, Cache Line Size 08
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=128
	I/O behind bridge: 00bfe000-00bfefff
	Memory behind bridge: bfe00000-bfefffff
	Prefetchable memory behind bridge: bfd00000-bfdfffff
	Secondary status: 66Mhz- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot
-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:14.0 CardBus bridge: Texas Instruments PCI1620 PC Card Controller
(rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size 08
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at 00000000bfcff000 (32-bit, non-prefetchable)
[size=4K
]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: bf8ff000-bfcfe000 (prefetchable)
	Memory window 1: 80000000-803ff000
	I/O window 0: 00000000-000001ff
	I/O window 1: 00000400-000005ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+
PostWrite+
	16-bit legacy interface ports at 0001

00:14.2 System peripheral: Texas Instruments PCI1620 Firmware Loading
Function (
rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-
	Latency: 128 (1750ns min, 1000ns max), Cache Line Size 08
	Interrupt: pin ? routed to IRQ 19
	Region 0: I/O ports at bf9fc0 [size=64]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot
-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


********    lspcmcia -vvv   ********    
~ # lspcmcia -vvv
Socket 0 Bridge:   	[yenta_cardbus] 	(bus ID: 0000:00:14.0)
	Configuration:	state: suspended	ready: yes
			Voltage: 5.0V Vcc: 5.0V Vpp: 5.0V
			Available IRQs: none
			Available ioports:	0xfe000000 - 0xfebfffff
			Available iomem:	--none--


********    /proc/iomem   ********    
~ # cat /proc/iomem
80000000-fcffffff : PCI host bridge
  80000000-803fffff : PCI CardBus #02
  bf8ff000-bfcfefff : PCI CardBus #02
  bfcff000-bfcfffff : 0000:00:14.0
    bfcff000-bfcfffff : yenta_socket
  bfd00000-bfdfffff : PCI Bus #01
  bfe00000-bfefffff : PCI Bus #01
  bfff7c00-bfff7fff : 0000:00:12.0
    bfff7c00-bfff7fff : tulip
  bfff8000-bfffffff : 0000:00:10.0
  fc004500-fc004507 : serial


********    /proc/ioports   ********     
~ # cat /proc/ioports
fe000000-febfffff : PCI host bridge
  fe000000-fe0001ff : PCI CardBus #02
  fe000400-fe0005ff : PCI CardBus #02
  febf9fc0-febf9fff : 0000:00:14.2
  febfe000-febfefff : PCI Bus #01
  febfff00-febfff7f : 0000:00:12.0
    febfff00-febfff7f : tulip
  febffff8-febfffff : 0000:00:10.0
~ #
