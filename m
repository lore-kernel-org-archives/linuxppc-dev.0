Message-ID: <3A0E57BA.44CFBDE7@emory.edu>
Date: Sun, 12 Nov 2000 00:41:30 -0800
From: Andreas H Meier <ameier@emory.edu>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: IEEE1394 hard drive woes on pismo
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am looking for some advice with ieee1394 on a pismo. I am trying to
talk to a 30GB Fantom FireWire hard drive from linux and have so far
been unsuccessful. I can get the firewire port up and running, and
plugging in the harddrive is registered by /proc/ohci1394 (see below).
Any attempt to access the harddrive (testlibraw, gscanbus) results in
unrecoverable system freeze (screen stays, keyboard no longer working.
Has anybody been able to get a firewire harddrive to work on a pismo? If
yes, let me know.
Can I use the linux1394 stuff from sourceforge or is there another tree
specifically for ppc?

Thanks, here is my system info and the relevant file printouts:

####System info #############

Linux kernel 2.2.18pre17-ben1 on
pismo 500
patched with linux1394 patch for 2.2 kernel
(http://linux1394.sourceforge.net)
relevant modules loaded:
sbp2_1394
raw1394
ohci1394
ieee1394

####/dmesg output, harddrive plugged in #############

/SNIP

ieee1394: registered ohci1394 driver, initializing now
ohci1394: looking for Ohci1394 cards
PCI: Enabling bus mastering for device 00:70
ohci1394_0: remapped memory spaces reg 0xe4874000
ohci1394_0: allocated interrupt 40
ohci1394_0: soft reset finished
ohci1394_0: max packet size = 2048 bytes
ohci1394_0: 4 iso receive contexts available
ohci1394_0: 4 iso transmit contexts available
ohci1394_0: Receive DMA ctx=0 initialized
ohci1394_0: Receive DMA ctx=1 initialized
ohci1394_0: AT dma ctx=0 initialized
ohci1394_0: AT dma ctx=1 initialized
ohci1394_0: Receive DMA ctx=2 initialized
ohci1394_0: resetting bus on request
ieee1394: detected 1 ohci1394 adapter
ohci1394_0: irq_handler timeout event=0x00020000
ohci1394_0: SelfID process finished (phyid 0, not root)
ohci1394_0: selfid packet 0x807f8c92 rcvd
ieee1394: including selfid 0x807f8c92
ohci1394_0: This node self-id is 0x807f8c92
ohci1394_0: selfid packet 0x817f84d0 rcvd
ieee1394: including selfid 0x817f84d0
ohci1394_0: calling self-id complete
ieee1394: GUID request sent to node 1
ohci1394_0: phy reg received outside of bus resetsequence
raw1394: /dev/raw1394 device initialized
SBP-2 storage driver for IEEE-1394
scsi0 : IEEE-1394 SBP-2 storage driver
scsi : 1 host.

/SNIP

####lspci -vvx output, harddrive plugged in#############

/SNIP

00:0e.0 FireWire (IEEE 1394): Apple Computer Inc.: Unknown device 0018
(rev 01) (prog-if 10)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 3 min, 4 max, 16 set, cache line size 08
	Interrupt: pin A routed to IRQ 40
	Region 0: Memory at f5000000 (32-bit, non-prefetchable)
00: 6b 10 18 00 16 00 20 02 01 10 00 0c 08 10 00 00
10: 00 00 00 f5 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 03 04

/SNIP


####/proc/ohci1394 output, harddrive unplugged #############

IEEE-1394 OHCI Driver status report:
  bus number: 0x3ff Node ID: 0x0

### Host data ###
node_count:        1  node_id   : 0000FFC0
irm_id    : 0000FFFF  busmgr_id : 0000FFFF
initialized
root

---Iso Receive DMA---
Current buf: 0 offset: 0

---Async Receive DMA---
Ar req current buf: 0 offset: 0
AR resp current buf: 0 offset: 0

---Async Transmit DMA---
AT req prg: 4 sent: 4 free: 32 branchAddrPtr: 00000000
AT req queue: first: 00000000 last: 00000000
AR resp prg: 0 sent: 0 free: 32 branchAddrPtr: 00000000
AT resp queue: first: 00000000 last: 00000000

### HC Register dump ###
Version     : 00010000  GUID_ROM    : 00000000  ATRetries   : 00000822
CSRData     : 00000000  CSRCompData : 00000000  CSRControl  : 80000000
ConfigROMhdr: 040471ed  BusID       : 31333934  BusOptions  : f07da002
GUIDHi      : 003065ff  GUIDLo      : fe4c2e1a  ConfigROMmap: 188f9000
PtdWrAddrLo : 00000000  PtdWrAddrHi : 00000000  VendorID    : 0000106b
HCControl   : 000e0000  SelfIDBuffer: 188d2000  SelfIDCount : 0004000c
IRMuChMaskHi: 00000000  IRMuChMaskLo: 00000000  IntEvent    : 01700000
IntMask     : 840300ff  IsoXmIntEvnt: 00000000  IsoXmIntMask: 00000000
IsoRcvIntEvt: 00000000  IsoRcvIntMsk: 00000001  FairnessCtrl: 00000000
LinkControl : 00300200  NodeID      : c800ffc0  PhyControl  : 8003017f
IsoCyclTimer: b9ece6ee  AsRqFilterHi: ffffffff  AsRqFilterLo: ffffffff
PhyReqFiltHi: ffffffff  PhyReqFiltLo: ffffffff  PhyUpperBnd : ffff0000
AsRqTrCxtCtl: 00000003  AsRqTrCmdPtr: 19428000  AsRsTrCtxCtl: 00000000
AsRsTrCmdPtr: 00000000  AsRqRvCtxCtl: 00008806  AsRqRvCmdPtr: 188d7001
AsRsRvCtxCtl: 00008806  AsRsRvCmdPtr: 191e5001  IntEvent    : 01700000
IsoRCtxCtl00: d0008806  IsoRCmdPtr00: 12e5b001  IsoRCxtMch00: f0000000
IsoRCtxCtl01: 00000000  IsoRCmdPtr01: 00000000  IsoRCxtMch01: 00000000
IsoRCtxCtl02: 00000000  IsoRCmdPtr02: 00000000  IsoRCxtMch02: 00000000
IsoRCtxCtl03: 00000000  IsoRCmdPtr03: 00000000  IsoRCxtMch03: 00000000
IsoTCtxCtl00: 00000000  IsoTCmdPtr00: 00000000
IsoTCtxCtl01: 00000000  IsoTCmdPtr01: 00000000
IsoTCtxCtl02: 00000000  IsoTCmdPtr02: 00000000
IsoTCtxCtl03: 00000000  IsoTCmdPtr03: 00000000

####/proc/ohci1394 output, harddrive plugged in #############

IEEE-1394 OHCI Driver status report:
  bus number: 0x3ff Node ID: 0x1

### Host data ###
node_count:        2  node_id   : 0000FFC1
irm_id    : 0000FFFF  busmgr_id : 0000FFFF
initialized
root

---Iso Receive DMA---
Current buf: 0 offset: 0

---Async Receive DMA---
Ar req current buf: 0 offset: 0
AR resp current buf: 0 offset: 0

---Async Transmit DMA---
AT req prg: 4 sent: 2 free: 30 branchAddrPtr: d8a93008
AT req queue: first: df9c0c60 last: d0217d80
AR resp prg: 0 sent: 0 free: 32 branchAddrPtr: 00000000
AT resp queue: first: 00000000 last: 00000000

### HC Register dump ###
Version     : 00010000  GUID_ROM    : 00000000  ATRetries   : 00000822
CSRData     : 00000000  CSRCompData : 00000000  CSRControl  : 80000000
ConfigROMhdr: 040471ed  BusID       : 31333934  BusOptions  : f07da002
GUIDHi      : 003065ff  GUIDLo      : fe4c2e1a  ConfigROMmap: 188f9000
PtdWrAddrLo : 00000000  PtdWrAddrHi : 00000000  VendorID    : 0000106b
HCControl   : 000e0000  SelfIDBuffer: 188d2000  SelfIDCount : 00030014
IRMuChMaskHi: 00000000  IRMuChMaskLo: 00000000  IntEvent    : 01700000
IntMask     : 840300ff  IsoXmIntEvnt: 00000000  IsoXmIntMask: 00000000
IsoRcvIntEvt: 00000000  IsoRcvIntMsk: 00000001  FairnessCtrl: 00000000
LinkControl : 00300200  NodeID      : c800ffc1  PhyControl  : 8007017f
IsoCyclTimer: 8ee7431e  AsRqFilterHi: ffffffff  AsRqFilterLo: ffffffff
PhyReqFiltHi: ffffffff  PhyReqFiltLo: ffffffff  PhyUpperBnd : ffff0000
AsRqTrCxtCtl: 00008003  AsRqTrCmdPtr: 19428000  AsRsTrCtxCtl: 00000000
AsRsTrCmdPtr: 00000000  AsRqRvCtxCtl: 00008806  AsRqRvCmdPtr: 188d7001
AsRsRvCtxCtl: 00008806  AsRsRvCmdPtr: 191e5001  IntEvent    : 01700000
IsoRCtxCtl00: d0008806  IsoRCmdPtr00: 12e5b001  IsoRCxtMch00: f0000000
IsoRCtxCtl01: 00000000  IsoRCmdPtr01: 00000000  IsoRCxtMch01: 00000000
IsoRCtxCtl02: 00000000  IsoRCmdPtr02: 00000000  IsoRCxtMch02: 00000000
IsoRCtxCtl03: 00000000  IsoRCmdPtr03: 00000000  IsoRCxtMch03: 00000000
IsoTCtxCtl00: 00000000  IsoTCmdPtr00: 00000000
IsoTCtxCtl01: 00000000  IsoTCmdPtr01: 00000000
IsoTCtxCtl02: 00000000  IsoTCmdPtr02: 00000000
IsoTCtxCtl03: 00000000  IsoTCmdPtr03: 00000000


--
Andreas H Meier
Egleston Children's Hospital
ameier@emory.edu

--
Andreas H Meier
Egleston Children's Hospital
ameier@emory.edu

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
