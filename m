Message-ID: <38DF9AD6.7E08D346@pop.agri.ch>
Date: Mon, 27 Mar 2000 19:31:12 +0200
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Linux-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: pci-detection of Cardbus cards.
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

this is mail nbr 2 concerning pci-patches from Michel. I had to split it
up, since there are two topics.

I hoped to get some support in detecting the CardBus card I have
correctly. I tried it on a 2399p3, the lspci -vv shows the same as below
except the function of the card.


What I try to get working is the following:

excerpt of lspci -vv from a 2215p14 kernel patched with this patch:

http://www.rr.iij4u.or.jp/~roikawa/others.html

I don't know if the numbering below is correct: 01:00.0 for the first
function of the device.
Also, how would it be best to integrate the detection of such cards? In
the patch above the special bridge TI1131 was hardcoded. But as I know,
other PB's (Lombard) uses different (TI1211 or so) chips.
Is it necessary to code all different chips or is there a generaL approach?



---lspci2215p14---
00:13.0 CardBus bridge: Texas Instruments PCI1131 (rev 01)
	Subsystem: Unknown device 104c:ac15
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 set, cache line size 08
	Interrupt: pin A routed to IRQ 22
	Region 0: Memory at 81803000 (32-bit, non-prefetchable)
	Bus: primary=00, secondary=01, subordinate=04, sec-latency=64
Memory window 0: 90000000-90005000
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
	16-bit legacy interface ports at 0007

00:13.1 CardBus bridge: Texas Instruments PCI1131 (rev 01)
	Subsystem: Unknown device 104c:ac15
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 set, cache line size 08
	Interrupt: pin B routed to IRQ 23
	Region 0: Memory at 81802000 (32-bit, non-prefetchable)
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=64
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt- PostWrite-
	16-bit legacy interface ports at 0007

01:00.0 Ethernet controller: Xircom: Unknown device 0003 (rev 03)
	Subsystem: Unknown device 115d:1181
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 20 min, 40 max, 40 set
	Interrupt: pin A routed to IRQ 255
	Region 0: I/O ports at <unassigned>
	Region 1: Memory at 90004800 (32-bit, non-prefetchable)
	Region 2: Memory at 90004000 (32-bit, non-prefetchable)
	Expansion ROM at 90000000
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- AuxPwr+ DSI- D1+ D2+ PME+
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

01:00.1 Serial controller: Xircom: Unknown device 0103 (rev 03) (prog-if 02)
	Subsystem: Unknown device 115d:1181
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 255
	Region 0: I/O ports at <unassigned> [disabled]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- AuxPwr+ DSI- D1+ D2+ PME+
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

---end---


Thanks for any hints/help

Andreas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
