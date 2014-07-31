Return-Path: <rjohnson@sierraphotonics.com>
Received: from spibarracuda01.sierraphotonics.com
 (66-162-147-187.static.twtelecom.net [66.162.147.187])
 by lists.ozlabs.org (Postfix) with ESMTP id AD5701A07B9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Aug 2014 06:43:09 +1000 (EST)
Received: from SPIEXCHMAIL01.sierraphotonics.com
 (spiexchmail01.sierraphotonics.com [192.168.10.45]) by
 spibarracuda01.sierraphotonics.com with ESMTP id iilCjqb78vB8kIoo for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jul 2014 13:28:15 -0700 (PDT)
From: Robert Johnson <rjohnson@sierraphotonics.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Does 3.0.4 kernel support PCIe AER driver on powerpc?
Date: Thu, 31 Jul 2014 20:28:41 +0000
Message-ID: <c6ba5e90e53e4ce9ae9851618aabbbf2@SPIEXCHMAIL01.sierraphotonics.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I tried asking the linux-pci mail list but got no response, so I thought I =
should really ask a more powerpc centric audience.

I am working with a Freescale P2020 based embedded system that includes an =
IDT PCIe switch with x1 PCIe lanes to custom PCIe devices on a backplane.  =
I was hoping to use the AER driver to get more info about any PCIe errors t=
hat may occur between the IDT switch and the PCIe devices.  The embedded sy=
stem uses a board support package currently based on Gentoo Linux with kern=
el 3.0.4.

I guess the first question is does the 3.0.4 kernel support PCIe AER driver=
 on powerpc?

I found one related old post from 2010 but the behavior I observe is differ=
ent than what is described in this post:

http://thread.gmane.org/gmane.linux.kernel.pci/9685/focus=3D9709

My assumption is that if the AER driver is working properly, I should see s=
ome kernel log entries that include "... service driver aer loaded" which c=
ome from pcie_port_probe_service() in drivers/pci/pcie/portdrv_core.c.  Is =
that a correct assumption?

Here is a summary of what I see:

In drivers/pci/pcie/aer/aerdrv.c:
                - aer_service_init() gets call at boot and appears to be su=
ccessful returning 0
                - aer_probe() never gets called
=20
In drivers/pci/pcie/portdrv_core.c:
                - pcie_port_service_register() gets called from aer_service=
_init() at boot, as expected it shows service name "aer" and returns 0
                - pcie_port_probe_service() never gets called, I assume thi=
s would likely cause aer_probe() to get called
                - pcie_port_device_register() gets called for many of the P=
CIe devices in the system and completes successfully for many cases where s=
ervice=3D0x02 (AER) is included

I end up with many devices in "/sys/bus/pci_express/devices" with names tha=
t end in "2" indicating that they are successfully associated with the AER =
service.  There is also a directory /sys/bus/pci_express/drivers which cont=
ains an "aer" entry.

# ls /sys/bus/pci_express/devices
0000:01:00.0:pcie18  0000:02:11.0:pcie22  0000:02:14.0:pcie28  0000:05:00.0=
:pcie12  0000:06:05.0:pcie28  0000:06:0d.0:pcie22
0000:02:08.0:pcie22  0000:02:11.0:pcie28  0000:02:15.0:pcie22  0000:05:00.0=
:pcie18  0000:06:07.0:pcie22  0000:06:0d.0:pcie28
0000:02:08.0:pcie28  0000:02:12.0:pcie22  0000:02:15.0:pcie28  0000:06:01.0=
:pcie22  0000:06:07.0:pcie28  0000:06:0f.0:pcie22
0000:02:0c.0:pcie22  0000:02:12.0:pcie28  0000:02:16.0:pcie22  0000:06:01.0=
:pcie28  0000:06:09.0:pcie22  0000:06:0f.0:pcie28
0000:02:0c.0:pcie28  0000:02:13.0:pcie22  0000:02:16.0:pcie28  0000:06:03.0=
:pcie22  0000:06:09.0:pcie28  0000:07:00.0:pcie18
0000:02:10.0:pcie22  0000:02:13.0:pcie28  0000:02:17.0:pcie22  0000:06:03.0=
:pcie28  0000:06:0b.0:pcie22  0000:08:01.0:pcie22
0000:02:10.0:pcie28  0000:02:14.0:pcie22  0000:02:17.0:pcie28  0000:06:05.0=
:pcie22  0000:06:0b.0:pcie28  0000:08:02.0:pcie22

# ls /sys/bus/pci_express/drivers/aer
bind  uevent  unbind

Any idea why pcie_port_probe_service() is never called?  Where should this =
be called from?

Here is a partial output of the lspci command (full listing too many chars)=
:

xpedite5570 / # lspci -vvv
00:00.0 PCI bridge: Freescale Semiconductor Inc P2020E (rev 21) (prog-if 00=
 [Normal decode])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 32 bytes
        Region 0: Memory at <ignored> (32-bit, non-prefetchable)
        Bus: primary=3D00, secondary=3D01, subordinate=3D1a, sec-latency=3D=
0
        I/O behind bridge: 00000000-00000fff
        Memory behind bridge: 80000000-dfffffff
        Prefetchable memory behind bridge: 00000000fff00000-00000000000ffff=
f
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2=
+,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [4c] Express (v1) Root Port (Slot-), MSI 00
                DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64n=
s, L1 <1us
                        ExtTag- RBE- FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsup=
ported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- Tr=
ansPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x4, ASPM L0s, Latency=
 L0 <2us, L1 unlimited
                        ClockPM- Surprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; RCB 128 bytes Disabled- Retrain- Com=
mClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk- DLA=
ctive- BWMgmt- ABWMgmt-
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-=
 CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr+ BadTLP- BadDLLP- Rollover- Timeout- NonFatal=
Err-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatal=
Err-
                AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ Ch=
kEn-

01:00.0 PCI bridge: Integrated Device Technology, Inc. Device 808e (prog-if=
 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 32 bytes
        Bus: primary=3D01, secondary=3D02, subordinate=3D1a, sec-latency=3D=
0
        I/O behind bridge: 00000000-00000fff
        Memory behind bridge: 80000000-805fffff
        Prefetchable memory behind bridge: 0000000080600000-00000000806ffff=
f
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v2) Upstream Port, MSI 00
                DevCap: MaxPayload 2048 bytes, PhantFunc 0, Latency L0s <64=
ns, L1 <1us
                        ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-Slot=
PowerLimit 15.000W
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsup=
ported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- Tr=
ansPend-
                LnkCap: Port #8, Speed 5GT/s, Width x4, ASPM L0s L1, Latenc=
y L0 <4us, L1 <4us
                        ClockPM- Surprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; Disabled- Retrain- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk- DLA=
ctive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Not Supported, TimeoutDis-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- Speed=
Dis-, Selectable De-emphasis: -6dB
                         Transmit Margin: Normal Operating Range, EnterModi=
fiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationCompl=
ete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, LinkEqua=
lizationRequest-
        Capabilities: [c0] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2=
-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [100 v2] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatal=
Err+
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatal=
Err+
                AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ Ch=
kEn-
        Capabilities: [200 v1] Virtual Channel
                Caps:   LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=3DFixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTra=
ns-
                        Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR25=
6-
                        Ctrl:   Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3Dff
                        Status: NegoPending- InProgress-
        Capabilities: [330 v1] #12
        Kernel driver in use: pcieport

02:08.0 PCI bridge: Integrated Device Technology, Inc. Device 808e (prog-if=
 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 32 bytes
        Bus: primary=3D02, secondary=3D03, subordinate=3D04, sec-latency=3D=
0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: 80000000-800fffff
        Prefetchable memory behind bridge: 00000000fff00000-00000000000ffff=
f
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v2) Downstream Port (Slot-), MSI 00
                DevCap: MaxPayload 2048 bytes, PhantFunc 0, Latency L0s <64=
ns, L1 <1us
                        ExtTag+ RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsup=
ported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- Tr=
ansPend-
                LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Latenc=
y L0 <4us, L1 <4us
                        ClockPM- Surprise+ LLActRep+ BwNot+
                LnkCtl: ASPM Disabled; Disabled- Retrain- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk- DLA=
ctive+ BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Not Supported, TimeoutDis- ARI=
Fwd+
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIF=
wd-
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- Speed=
Dis-, Selectable De-emphasis: -6dB
                         Transmit Margin: Normal Operating Range, EnterModi=
fiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationCompl=
ete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, LinkEqua=
lizationRequest-
        Capabilities: [c0] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2=
-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [d0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
                Address: 00000000fff41740  Data: 0000
        Capabilities: [100 v2] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatal=
Err+
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatal=
Err+
                AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ Ch=
kEn-
        Capabilities: [200 v1] Virtual Channel
                Caps:   LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=3DFixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTra=
ns-
                        Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR25=
6-
                        Ctrl:   Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3Dff
                        Status: NegoPending- InProgress-
        Capabilities: [320 v1] Access Control Services
                ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamF=
wd+ EgressCtrl+ DirectTrans+
                ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamF=
wd- EgressCtrl- DirectTrans-
        Capabilities: [330 v1] #12
        Kernel driver in use: pcieport

02:0c.0 PCI bridge: Integrated Device Technology, Inc. Device 808e (prog-if=
 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 32 bytes
        Bus: primary=3D02, secondary=3D05, subordinate=3D12, sec-latency=3D=
0
        I/O behind bridge: 00000000-00000fff
        Memory behind bridge: 80100000-804fffff
        Prefetchable memory behind bridge: 0000000080600000-00000000806ffff=
f
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v2) Downstream Port (Slot-), MSI 00
                DevCap: MaxPayload 2048 bytes, PhantFunc 0, Latency L0s <64=
ns, L1 <1us
                        ExtTag+ RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsup=
ported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- Tr=
ansPend-
                LnkCap: Port #12, Speed 5GT/s, Width x4, ASPM L0s L1, Laten=
cy L0 <4us, L1 <4us
                        ClockPM- Surprise+ LLActRep+ BwNot+
                LnkCtl: ASPM Disabled; Disabled- Retrain- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk- DLA=
ctive+ BWMgmt+ ABWMgmt-
                DevCap2: Completion Timeout: Not Supported, TimeoutDis- ARI=
Fwd+
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIF=
wd-
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- Speed=
Dis-, Selectable De-emphasis: -6dB
                         Transmit Margin: Normal Operating Range, EnterModi=
fiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationCompl=
ete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, LinkEqua=
lizationRequest-
        Capabilities: [c0] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2=
-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [d0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
                Address: 00000000fff41740  Data: 0001
        Capabilities: [100 v2] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatal=
Err+
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatal=
Err+
                AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ Ch=
kEn-
        Capabilities: [200 v1] Virtual Channel
                Caps:   LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=3DFixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTra=
ns-
                        Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR25=
6-
                        Ctrl:   Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3Dff
                        Status: NegoPending- InProgress-
        Capabilities: [320 v1] Access Control Services
                ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamF=
wd+ EgressCtrl+ DirectTrans+
                ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamF=
wd- EgressCtrl- DirectTrans-
        Capabilities: [330 v1] #12
        Kernel driver in use: pcieport

02:11.0 PCI bridge: Integrated Device Technology, Inc. Device 808e (prog-if=
 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 32 bytes
        Bus: primary=3D02, secondary=3D14, subordinate=3D14, sec-latency=3D=
0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: 80500000-805fffff
        Prefetchable memory behind bridge: 00000000fff00000-00000000000ffff=
f
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v2) Downstream Port (Slot-), MSI 00
                DevCap: MaxPayload 1024 bytes, PhantFunc 0, Latency L0s <64=
ns, L1 <1us
                        ExtTag+ RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsup=
ported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- Tr=
ansPend-
                LnkCap: Port #17, Speed 5GT/s, Width x1, ASPM L0s L1, Laten=
cy L0 <4us, L1 <4us
                        ClockPM- Surprise+ LLActRep+ BwNot+
                LnkCtl: ASPM Disabled; Disabled- Retrain- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk- DLA=
ctive+ BWMgmt+ ABWMgmt-
                DevCap2: Completion Timeout: Not Supported, TimeoutDis- ARI=
Fwd+
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIF=
wd-
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- Speed=
Dis-, Selectable De-emphasis: -6dB
                         Transmit Margin: Normal Operating Range, EnterModi=
fiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationCompl=
ete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, LinkEqua=
lizationRequest-
        Capabilities: [c0] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2=
-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [d0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
                Address: 00000000fff41740  Data: 0003
        Capabilities: [100 v2] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatal=
Err+
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatal=
Err+
                AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ Ch=
kEn-
        Capabilities: [200 v1] Virtual Channel
                Caps:   LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=3DFixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTra=
ns-
                        Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR25=
6-
                        Ctrl:   Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3Dff
                        Status: NegoPending- InProgress-
        Capabilities: [320 v1] Access Control Services
                ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamF=
wd+ EgressCtrl+ DirectTrans+
                ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamF=
wd- EgressCtrl- DirectTrans-
        Capabilities: [330 v1] #12
        Kernel driver in use: pcieport

14:00.0 Memory controller: Xilinx Corporation Device 6024
        Subsystem: Xilinx Corporation Device 0007
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 64
        Region 0: Memory at f80500000 (64-bit, non-prefetchable) [size=3D1M=
]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1+,D2=
+,D3hot+,D3cold-)
                Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [48] MSI: Enable+ Count=3D1/16 Maskable- 64bit+
                Address: 00000000fff41740  Data: 0016
        Capabilities: [60] Express (v2) Endpoint, MSI 00
                DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s <64n=
s, L1 unlimited
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsup=
ported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- Tr=
ansPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency=
 L0 unlimited, L1 unlimited
                        ClockPM- Surprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- Comm=
Clk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLA=
ctive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Range B, TimeoutDis-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- Speed=
Dis-, Selectable De-emphasis: -6dB
                         Transmit Margin: Normal Operating Range, EnterModi=
fiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationCom=
plete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, LinkEqua=
lizationRequest-
        Capabilities: [9c] MSI-X: Enable- Count=3D4 Masked-
                Vector table: BAR=3D0 offset=3D000f0000
                PBA: BAR=3D0 offset=3D000f8000
        Capabilities: [fc] #00 [0000]
        Capabilities: [100 v1] Device Serial Number 00-00-00-01-01-00-0a-35
        Kernel driver in use: spi_dev
