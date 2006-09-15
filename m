Return-Path: <lagrange@fr.oleane.com>
Received: from smtp14.clb.oleane.net (smtp14.clb.oleane.net [213.56.31.53])
	by ozlabs.org (Postfix) with ESMTP id 9F12667B58
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Sep 2006 00:23:44 +1000 (EST)
Received: from GEG2400 ([194.3.133.184]) (authenticated)
	by smtp14.clb.oleane.net with ESMTP id k8FENboq032564
	for <linuxppc-embedded@ozlabs.org>; Fri, 15 Sep 2006 16:23:38 +0200
From: "Laurent Lagrange" <lagrange@fr.oleane.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Linux 2.6.x  :  useless IO mappings behing PCI bridge
Date: Fri, 15 Sep 2006 16:26:13 +0200
Message-ID: <000001c6d8d2$eaa15050$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hello,

I use a custom 82xx PMC board as a PCI monarch board
on a carrier and another PCI agent board with a bridge.

The PCI agent board requests prefetchable and non
prefetchable memories behind its bridge but no IO region.
The IO flag is not set in the header space.

When probing PCI, Linux warns :
PCI: Probing PCI hardware
PCI: Cannot allocate resource region 0 of PCI bridge 1
--> the default address is not a valid pci address !!!
PCI: bridge 1 resource 0 moved to f8fff000..f8ffffff
--> This size is the default io region size.

So the kernel allocates and ioremaps 4096B for no requested IO.
The problem is not that it consumes address space but
that the kernel warns as if it is a mistake :-(

It can be checked by lspci command.
# lspci -vvx
00:13.0 Class 0604: 3388:0026 (rev 04)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248, cache line size 08
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
-->     I/O behind bridge: f8fff000-f8ffffff
        Memory behind bridge: a0100000-a01fffff
        Prefetchable memory behind bridge: 0000000080000000-0000000081f00000
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [e4] #06 [0094]
        Capabilities: [e8] Vital Product Data
00: 88 33 26 00 06 00 b0 02 04 00 04 06 08 f8 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 f1 f1 a0 02
20: 10 a0 10 a0 01 80 f1 81 00 00 00 00 00 00 00 00
30: ff f8 ff f8 dc 00 00 00 00 00 00 00 00 00 00 00

I think it would be right to check if IO is requested before
allocating some region.

Any opinion ?
Thanks all
Laurent
