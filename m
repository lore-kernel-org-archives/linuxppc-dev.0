Reply-To: <crow@pinetron.com>
From: "Chang-ho Park" <crow@pinetron.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: self id problem in ohci1394 with IBM walnut board
Date: Wed, 7 Mar 2001 01:50:41 -0800
Message-ID: <000501c0a6ec$13c9d160$18cdadd3@changho>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear developers.

I have a problems with ohci1394 device driver in IBM's walnut (cpu: ppc405GP) board rev. D.

target machine: IBM walnut revision D.
target CPU: IBM PPC405GP
Linux kernel version: MontaVista Linux kernel 2.4.0 for walnut. .. not 2.4.0 pre2.

>>cat /proc/pci

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: IBM 405GP PLB to PCI Bridge (rev 1).
      Master Capable.  Latency=7.
      Prefetchable 32 bit memory at 0x0 [0x1fffffff].
  Bus  0, device   1, function  0:
    FireWire (IEEE 1394): PCI device 104c:8020 (Texas Instruments) (rev 0).
      IRQ 28.
      Master Capable.  Latency=128.  Min Gnt=3.Max Lat=4.
      Non-prefetchable 32 bit memory at 0x80000000 [0x800007ff].
      Non-prefetchable 32 bit memory at 0x80004000 [0x80007fff].

>>insmod ohci1394.o
>>cat /proc/kmsg

<6>ieee1394: registered ohci1394 driver, initializing now
<6>ohci1394: looking for Ohci1394 cards
<6>ohci1394_0: Selfid buffer c3015000 not aligned on 8Kb boundary... may cause pb on some CXD3222 chip
<6>ohci1394_0: remapped memory spaces reg 0xc3018000
<6>ohci1394_0: allocated interrupt 28
<6>ohci1394_0: The 1st byte at offset 0x404 is: 0x31
<6>ohci1394_0: soft reset finished
<6>ohci1394_0: max packet size = 2048 bytes
<6>ohci1394_0: Iso contexts reg: 000000a8 implemented: 0000000f
<6>ohci1394_0: 4 iso receive contexts available
<6>ohci1394_0: Iso contexts reg: 00000098 implemented: 000000ff
<6>ohci1394_0: 8 iso transmit contexts available
<6>ohci1394_0: Receive DMA ctx=0 initialized
<6>ohci1394_0: Receive DMA ctx=1 initialized
<6>ohci1394_0: AT dma ctx=0 initialized
<6>ohci1394_0: AT dma ctx=1 initialized
<6>ohci1394_0: Receive DMA ctx=2 initialized
<6>ohci1394_0: request csr_rom address: C3013000
<6>ohci1394_0: Cancel request received
<6>ohci1394_0: resetting bus on request
<6>ohci1394_0: IntEvent: 00020000
<6>ohci1394_0: IntEvent: 00010000
<6>ohci1394_0: SelfID process finished (phyid 0, root)
<3>ohci1394_0: Error in reception of self-id packetsSelf-id count: 80010004 q[0]: 00000000
<6>ohci1394_0: IntEvent: 00020000
<6>ohci1394_0: IntEvent: 00010000
<6>ohci1394_0: SelfID process finished (phyid 0, root)
<3>ohci1394_0: Error in reception of self-id packetsSelf-id count: 80020004 q[0]: 00000000
<6>ohci1394_0: IntEvent: 00020000
<6>ohci1394_0: IntEvent: 00010000
<6>ohci1394_0: SelfID process finished (phyid 0, root)
<3>ohci1394_0: Error in reception of self-id packetsSelf-id count: 80030004 q[0]: 00000000
<6>ohci1394_0: IntEvent: 00020000
<6>ohci1394_0: IntEvent: 00010000
<6>ohci1394_0: SelfID process finished (phyid 0, root)
<3>ohci1394_0: Error in reception of self-id packetsSelf-id count: 80040004 q[0]: 00000000
<6>ohci1394_0: IntEvent: 00020000
<6>ohci1394_0: IntEvent: 00010000
<6>ohci1394_0: SelfID process finished (phyid 0, root)
<3>ohci1394_0: Error in reception of self-id packetsSelf-id count: 80050004 q[0]: 00000000
<6>ohci1394_0: IntEvent: 00020000
<6>ohci1394_0: IntEvent: 00010000
<6>ohci1394_0: SelfID process finished (phyid 0, root)
<3>ohci1394_0: Error in reception of self-id packetsSelf-id count: 80060004 q[0]: 00000000
<6>ohci1394_0: IntEvent: 00020000
<6>ohci1394_0: IntEvent: 00010000
<6>ohci1394_0: SelfID process finished (phyid 0, root)
<3>ohci1394_0: Error in reception of self-id packetsSelf-id count: 80070004 q[0]: 00000000
<6>ohci1394_0: IntEvent: 00020000
<6>ohci1394_0: IntEvent: 00010000
<6>ohci1394_0: SelfID process finished (phyid 0, root)
<3>ohci1394_0: Error in reception of self-id packetsSelf-id count: 80080004 q[0]: 00000000
<6>ohci1394_0: IntEvent: 00020000
<6>ohci1394_0: IntEvent: 00010000
<6>ohci1394_0: SelfID process finished (phyid 0, root)
<3>ohci1394_0: Error in reception of self-id packetsSelf-id count: 80090004 q[0]: 00000000
<6>ohci1394_0: IntEvent: 00020000
<6>ohci1394_0: IntEvent: 00010000
<6>ohci1394_0: SelfID process finished (phyid 0, root)
<3>ohci1394_0: Error in reception of self-id packetsSelf-id count: 800a0004 q[0]: 00000000
<6>ohci1394_0: IntEvent: 00020000
<6>ohci1394_0: IntEvent: 00010000
<6>ohci1394_0: SelfID process finished (phyid 0, root)
<3>ohci1394_0: Error in reception of self-id packetsSelf-id count: 800b0004 q[0]: 00000000
<6>ohci1394_0: IntEvent: 00020000
<6>ohci1394_0: IntEvent: 00010000
<6>ohci1394_0: SelfID process finished (phyid 0, root)
<3>ohci1394_0: Error in reception of self-id packetsSelf-id count: 800c0004 q[0]: 00000000
<6>ohci1394_0: IntEvent: 00020000
<6>ohci1394_0: IntEvent: 00010000
<6>ohci1394_0: SelfID process finished (phyid 0, root)
<3>ohci1394_0: Error in reception of self-id packetsSelf-id count: 800d0004 q[0]: 00000000
<6>ohci1394_0: IntEvent: 00020000
<6>ohci1394_0: IntEvent: 00010000
<6>ohci1394_0: SelfID process finished (phyid 0, root)
<3>ohci1394_0: Error in reception of self-id packetsSelf-id count: 800e0004 q[0]: 00000000
<6>ohci1394_0: IntEvent: 00020000
<6>ohci1394_0: IntEvent: 00010000
<6>ohci1394_0: SelfID process finished (phyid 0, root)
<3>ohci1394_0: Error in reception of self-id packetsSelf-id count: 800f0004 q[0]: 00000000
<6>ohci1394_0: IntEvent: 00020000
<6>ohci1394_0: IntEvent: 00010000
<6>ohci1394_0: SelfID process finished (phyid 0, root)
<3>ohci1394_0: Error in reception of self-id packetsSelf-id count: 80100004 q[0]: 00000000
<6>ohci1394_0: IntEvent: 00020000
<6>ohci1394_0: IntEvent: 00010000
<6>ohci1394_0: SelfID process finished (phyid 0, root)
<3>ohci1394_0: Error in reception of self-id packetsSelf-id count: 80110004 q[0]: 00000000
<3>ohci1394_0: Timeout on self-id error reception
<6>ieee1394: detected 1 ohci1394 adapter


>>cat /proc/ohci1394

IEEE-1394 OHCI Driver status report:
  bus number: 0x3ff Node ID: 0x0

### Host data ###
node_count:        0  node_id   : 00000000
irm_id    : 0000FFFF  busmgr_id : 0000FFFF
initialized in_bus_reset


---Iso Receive DMA---
Current buf: 0 offset: 0

---Async Receive DMA---
Ar req current buf: 0 offset: 0
AR resp current buf: 0 offset: 0

---Async Transmit DMA---
AT req prg: 0 sent: 0 free: 32 branchAddrPtr: 00000000
AT req queue: first: 00000000 last: 00000000
AR resp prg: 0 sent: 0 free: 32 branchAddrPtr: 00000000
AT resp queue: first: 00000000 last: 00000000

### HC Register dump ###
Version     : 01010000  GUID_ROM    : 00000000  ATRetries   : 00000822
CSRData     : 00000000  CSRCompData : 00000000  CSRControl  : 80000000
ConfigROMhdr: 04040704  BusID       : 31333934  BusOptions  : f07da002
GUIDHi      : 0002f100  GUIDLo      : 000002ca  ConfigROMmap: 01dc6000
PtdWrAddrLo : 00000000  PtdWrAddrHi : 00000000  VendorID    : 00000000
HCControl   : 408e0000  SelfIDBuffer: 01dc4000  SelfIDCount : 80110004
IRMuChMaskHi: 00000000  IRMuChMaskLo: 00000000  IntEvent    : 01700000
IntMask     : 840300ff  IsoXmIntEvnt: 00000000  IsoXmIntMask: 00000000
IsoRcvIntEvt: 00000000  IsoRcvIntMsk: 00000001  FairnessCtrl: 00000000
LinkControl : 00300200  NodeID      : c800ffc0  PhyControl  : 000001ff
IsoCyclTimer: ae763b1b  AsRqFilterHi: ffffffff  AsRqFilterLo: ffffffff
PhyReqFiltHi: ffffffff  PhyReqFiltLo: ffffffff  PhyUpperBnd : 00000000
AsRqTrCxtCtl: 00000000  AsRqTrCmdPtr: 00000000  AsRsTrCtxCtl: 00000000
AsRsTrCmdPtr: 00000000  AsRqRvCtxCtl: 00008806  AsRqRvCmdPtr: 01dc2001
AsRsRvCtxCtl: 00008806  AsRsRvCmdPtr: 01d7a001  IntEvent    : 01700000
IsoRCtxCtl00: d0008806  IsoRCmdPtr00: 01b12001  IsoRCxtMch00: f0000000
IsoRCtxCtl01: 00000000  IsoRCmdPtr01: 00000000  IsoRCxtMch01: 00000000
IsoRCtxCtl02: 00000000  IsoRCmdPtr02: 00000000  IsoRCxtMch02: 00000000
IsoRCtxCtl03: 00000000  IsoRCmdPtr03: 00000000  IsoRCxtMch03: 00000000
IsoTCtxCtl00: 00000000  IsoTCmdPtr00: 00000000
IsoTCtxCtl01: 00000000  IsoTCmdPtr01: 00000000
IsoTCtxCtl02: 00000000  IsoTCmdPtr02: 00000000
IsoTCtxCtl03: 00000000  IsoTCmdPtr03: 00000000
IsoTCtxCtl04: 00000000  IsoTCmdPtr04: 00000000
IsoTCtxCtl05: 00000000  IsoTCmdPtr05: 00000000
IsoTCtxCtl06: 00000000  IsoTCmdPtr06: 00000000
IsoTCtxCtl07: 00000000  IsoTCmdPtr07: 00000000

>>cat /proc/iomem
00000000-1fffffff : IBM 405GP PLB to PCI Bridge
80000000-800007ff : PCI device 104c:8020 (Texas Instruments)
80004000-80007fff : PCI device 104c:8020 (Texas Instruments)


Thanks for your help.

regards.





-------------------------------------------------
Chang-ho Park
Research Engineer. Pinetron Co., Ltd.
Phone +82-2-6324-6500
E-mail <mailto:crow@pinetron.com> or
E-mail <mailto:crow@cello.korea.ac.kr>
-------------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
