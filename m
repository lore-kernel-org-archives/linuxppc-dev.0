Message-Id: <200012250303.VAA08564@lists.linuxppc.org>
Date: Sun, 24 Dec 2000 22:03:04 -0500
From: jingai <jingai@telocity.com>
To: "debian-powerpc" <debian-powerpc@lists.debian.org>,
        "linuxppc-dev" <linuxppc-dev@lists.linuxppc.org>
Subject: Status of PCI-PCI bridge on UMAX S900
Reply-To: jingai@telocity.com
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello, I am just curious if anyone is working on getting the PCI-PCI
bridge code working for the UMAX S900 (similar to 9500, but
obviously different enough to break the code).  The problem is this:
all cards not in slots 1-2 are assigned an IRQ of 1, which is
obviously wrong.  I'm not sure why slot 3 does not work, however,
unless the code just thinks the PCI bridge *is* slot 3 (which it does
appear to be that way).

If no one is currently attempting to fix it, but someone would like to,
here is all of the relevant info I can think of.  Thanks in advance for
any help.

Location of the pci bridge in /proc is:

/proc/device-tree/bandit/pci-bridge/AAPL,interrupts

colour:/home/jingai# lspci
00:0b.0 Host bridge: Apple Computer Inc. Bandit PowerPC host bridge (rev
03)
00:0d.0 Unknown mass storage controller: Promise Technology, Inc. 20267
(rev 02)
00:0e.0 USB Controller: OPTi Inc. 82C861 (rev 10)
00:0f.0 PCI bridge: Digital Equipment Corporation DECchip 21052 (rev 01)
00:10.0 Class ff00: Apple Computer Inc. Grand Central I/O (rev 02)
01:01.0 VGA compatible controller: ATI Technologies Inc Rage 128 RE
01:02.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink]
(rev 30)

colour:/home/jingai# lspci -vv
00:0b.0 Host bridge: Apple Computer Inc. Bandit PowerPC host bridge (rev
03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32, cache line size 08

00:0d.0 Unknown mass storage controller: Promise Technology, Inc. 20267
(rev 02)
        Subsystem: Promise Technology, Inc.: Unknown device 4d33
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 23
        Region 0: I/O ports at 2070 [size=8]
        Region 1: I/O ports at 2060 [size=4]
        Region 2: I/O ports at 2050 [size=8]
        Region 3: I/O ports at 2040 [size=4]
        Region 4: I/O ports at 2000 [size=64]
        Region 5: Memory at 88020000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at 88010000 [disabled] [size=64K]
        Capabilities: [58] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0e.0 USB Controller: OPTi Inc. 82C861 (rev 10) (prog-if 10 [OHCI])
        Subsystem: OPTi Inc. 82C861
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 32, cache line size 08
        Interrupt: pin A routed to IRQ 24
        Region 0: Memory at 88000000 (32-bit, non-prefetchable) [size=4K]

00:0f.0 PCI bridge: Digital Equipment Corporation DECchip 21052 (rev 01)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00001000-00001fff
        Memory behind bridge: 80800000-87ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:10.0 Class ff00: Apple Computer Inc. Grand Central I/O (rev 02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 32, cache line size 08
        Region 0: Memory at f3000000 (32-bit, non-prefetchable) [size=128K]

01:01.0 VGA compatible controller: ATI Technologies Inc Rage 128 RE
(prog-if 00 [VGA])
        Subsystem: Unknown device b530:0408
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 1
        Region 0: Memory at 84000000 (32-bit, prefetchable) [size=64M]
        Region 1: I/O ports at 1000 [size=256]
        Region 2: Memory at 80804000 (32-bit, non-prefetchable) [size=16K]
        Expansion ROM at 80840000 [disabled] [size=128K]
        Capabilities: [5c] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:02.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink]
(rev 30)
        Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC
Management NIC
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2500ns min, 2500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 1
        Region 0: I/O ports at 1400 [size=128]
        Region 1: Memory at 80800000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at 80820000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable+ DSel=0 DScale=2 PME-


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
