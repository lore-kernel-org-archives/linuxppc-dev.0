Return-Path: <marco.stornelli@coritel.it>
Received: from nausicaa2.coritel.it
	(host254-130-static.190-82-b.business.telecomitalia.it
	[82.190.130.254]) by ozlabs.org (Postfix) with ESMTP id 3D8DDDDDEE
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Feb 2008 19:48:52 +1100 (EST)
Received: from localhost (nausicaa2.coritel.it [127.0.0.1])
	by nausicaa2.coritel.it (Postfix) with ESMTP id B20CD434005
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Feb 2008 09:46:44 +0100 (CET)
Received: from nausicaa2.coritel.it ([127.0.0.1])
	by localhost (nausicaa2.coritel.it [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id vHHucaZWdo9O for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Feb 2008 09:46:43 +0100 (CET)
Received: from [192.168.2.2] (217-133-82-13.b2b.tiscali.it [217.133.82.13])
	by nausicaa2.coritel.it (Postfix) with ESMTP id ECE44434002
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Feb 2008 09:46:42 +0100 (CET)
Message-ID: <47C7C747.8030101@coritel.it>
Date: Fri, 29 Feb 2008 09:50:15 +0100
From: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
To: LinuxPPC-Embedded <linuxppc-embedded@ozlabs.org>
Subject: MPC8641D PCI-Express error
Content-Type: text/plain; charset=ISO-8859-15
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I have some news about my problem. When the system makes the boot
(kernel 2.6.24) I see these messages:

...........
PCI: Probing PCI hardware
PCI: 0000:00:00.0: class b20 doesn't match header type 01. Ignoring class.
PCI: Transparent bridge - 0000:00:00.0
PCI: Transparent bridge - 0000:01:00.0
PCI: 0001:03:00.0: class b20 doesn't match header type 01. Ignoring class.
PCI: Transparent bridge - 0001:03:00.0
PCI: Cannot allocate resource region 0 of device 0000:02:1f.0
PCI: Cannot allocate resource region 1 of device 0000:02:1f.0
PCI: Cannot allocate resource region 2 of device 0000:02:1f.0
PCI: Cannot allocate resource region 3 of device 0000:02:1f.0
PCI: Cannot allocate resource region 4 of device 0000:02:1f.0
PCI: Cannot allocate resource region 0 of device 0000:02:1f.1
PCI: Cannot allocate resource region 1 of device 0000:02:1f.1
PCI: Cannot allocate resource region 2 of device 0000:02:1f.1
PCI: Cannot allocate resource region 3 of device 0000:02:1f.1
PCI: Cannot allocate resource region 4 of device 0000:02:1f.1
PCI: Cannot allocate resource region 0 of device 0001:04:00.0
PCI: Cannot allocate resource region 1 of device 0001:04:00.0
PCI: Error while updating region 0000:02:1f.1/0 (00001419 != 00001411)
PCI: Error while updating region 0000:02:1f.1/2 (00001439 != 00001431)
PCI: Error while updating region 0000:02:1f.1/3 (00001435 != 00001431)

..............

where the device 0001:04:00.0 is my ML555 Virtex5 evaluation board. The
lspci output is:

0000:02:1f.0 Class 0101: Unknown device 10b9:5229 (rev c8) (prog-if 8f
[Master SecP SecO PriP PriO])
        Subsystem: Unknown device 10b9:5229
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 14
        Region 0: I/O ports at 1400 [size=8]
        Region 1: I/O ports at 1408 [size=4]
        Region 2: I/O ports at 1410 [size=8]
        Region 3: I/O ports at 140c [size=4]
        Region 4: I/O ports at 1420 [size=16]
        Capabilities: [60] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [80] Message Signalled Interrupts: Mask- 64bit-
Queue=0/0 Enable-
                Address: 00000000  Data: 0000




0000:02:1f.1 Class 0101: Unknown device 10b9:5288 (rev 10) (prog-if 01
[PriO])
        Subsystem: Unknown device 10b9:5288
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at 1418 [size=8]
        Region 1: I/O ports at 1430 [size=4]
        Region 2: I/O ports at 1438 [size=8]
        Region 3: I/O ports at 1434 [size=4]
        Region 4: I/O ports at 1440 [size=16]
        Region 5: Memory at 80006000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [70] Message Signalled Interrupts: Mask- 64bit+
Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000






0001:04:00.0 Class 0500: Unknown device 10ee:0007
        Subsystem: Unknown device 14d0:6601
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at a0000000 (32-bit, non-prefetchable)
[disabled] [size=1M]
        Region 1: Memory at a0100000 (32-bit, non-prefetchable)
[disabled] [size=1M]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [48] Message Signalled Interrupts: Mask+ 64bit+
Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
                Masking: 00000000  Pending: 00000000
        Capabilities: [60] Express Endpoint IRQ 0
                Device: Supported: MaxPayload 256 bytes, PhantFunc 1,
ExtTag+
                Device: Latency L0s unlimited, L1 unlimited
                Device: AtnBtn- AtnInd- PwrInd-
                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
                Link: Supported Speed 2.5Gb/s, Width x4, ASPM L0s L1, Port 0
                Link: Latency L0s unlimited, L1 unlimited
                Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
                Link: Speed 2.5Gb/s, Width x4
        Capabilities: [100] Device Serial Number 35-0a-00-01-01-00-00-00

(The last device appears disabled because the driver isn't still
loaded). Are  these prints a normal behaviour? Because I read in the
function which prints this messages (alloc_resource in
arch/powerpc/kernel/pci_32.c) this comment:

/* We'll assign a new address later */

Is there some bug in the kernel? Any suggestions? Please help me.

Thanks.

Marco
