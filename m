Message-ID: <391289B2.4060C2DF@mpifr-bonn.mpg.de>
Date: Fri, 05 May 2000 10:43:30 +0200
From: Albrecht Dre_ <ad@mpifr-bonn.mpg.de>
MIME-Version: 1.0
To: LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>
Subject: Q: IO window remapping
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all!

I am currently trying to get the PCMCIA package working on a PISMO Powerbook.
The problem it that the Cardbus bridge (a TI 1211) has a odd IO window
definition (from lspci -vv):

00:1a.0 CardBus bridge: Texas Instruments: Unknown device ac1e
	Subsystem: Unknown device 104c:ac1e
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 16 set, cache line size 08
	Interrupt: pin A routed to IRQ 58
	Region 0: Memory at 80080000 (32-bit, non-prefetchable)
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
I/O window 0: 00001000-00000fff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0007

As a result, any pcmcia package operation (like card insertion) fails as no io
ports can be assigned.

I hope this question is not too dumb: What is the correct range for this IO
window?  Where should I fix it (probabely in arch/ppc/kernel/pmac_pci.c)?

Thanks in advance, Albrecht


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
