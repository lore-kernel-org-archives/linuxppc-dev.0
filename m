Reply-To: <tschaefer@giga-stream.de>
From: =?iso-8859-1?Q?Thomas_Sch=E4fer?= <tschaefer@giga-stream.de>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: PCI bridge setup with MPC8266ADS board
Date: Mon, 8 Sep 2003 18:23:34 +0200
Message-ID: <FIEJJAKAABLMHFKFECNJMEIOGPAA.tschaefer@giga-stream.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I'm using a MPC8266ADS board with u-boot 0.4.5 and a linux 2.4.18 kernel
from Montavista with PCI support. After booting the kernel, lspci -vv gives
the following output:

root@192.10.11.242:~# lspci -vv
00:00.0 Host bridge: Motorola: Unknown device 18c0 (rev 11)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 248, cache line size 08
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at <unassigned> (32-bit, non-prefetchable)
[size=128K]
        Region 1: Memory at <unassigned> (32-bit, prefetchable) [size=512M]
        Capabilities: [48] #06 [0000]

00:18.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev
08)
        Subsystem: Intel Corporation EtherExpress PRO/100+ Management
Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 66
        Region 0: Memory at bffff000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at 3ffffc0 [size=64]
        Region 2: Memory at bfe00000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

In the host bridge settings, memory region 0 and 1 are <unassigned>. Are
these settings correct or is there a bug in the kernel when initializing the
host bridge?

I also checked lspci -vv on our PPC405 systems and found, that the host
bridge isn't listed at all. I wonder what the reason for this different
behaviour is?

Any hints would be appreciated.

Best regards,

Thomas Schäfer

____________________________________

GIGA STREAM GmbH

Konrad-Zuse-Str. 7
66115 Saarbrücken

Tel.: + 49 (0)681 / 95916 - 203
Fax:  + 49 (0)681 / 95916 - 100
E-mail: tschaefer@giga-stream.de


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
