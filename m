Mime-Version: 1.0
Message-Id: <p04330100b64a0cac23a1@[192.168.0.1]>
Date: Tue, 28 Nov 2000 20:55:13 -0500
To: linuxppc-dev@lists.linuxppc.org
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: dual IRQ 23 (was: USB?; 2.2.18 no boot?; aic7xxx?)
Cc: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>	usb-ohci.c: USB OHCI at membase 0xd0184000, IRQ 23
>
>already gives a clue. Question is, what else is at IRQ 23?
>
>	Michael

In both 2.2.17 and 2.2.18pre23 (bk), 6-slot PTP (9500-ish), cards are
as follows, top to bottom:

Adaptec 2940UW
Farallon ethernet 10/100
OrangeLink firewire/usb combo
Matrox Mystique card
ixMicro TV card
ixMicro Twin Turbo card [aka imstt]


lspci -vv is attached at the end. The key point is that the entry for
the Adaptec 2940UW card and the Orangelink USB card BOTH say:

	Interrupt: pin A routed to IRQ 23

Hah. So, this might explain a lot. Obviously this is why my usb mouse
only responds when there is some disk activity, and only for a
moment. It ALSO may help explain why I was having trouble booting
(kernel panic traced to aic7xxx and its call to ioremap). However,
this boot issue is still suspicious for 2 reasons:

	1. 2.2.17 lspci -vv ALSO shows same shared IRQ 23, and 2.2.17
	   never had boot problem. But it also has no USB stuff compiled in.

	2. My boot "workaround" is simply to add printk statements at
	   strategic points in the source. Boot problem solved. Weird.


At any rate, why are these 2 devices sharing an IRQ, and what can be
done about it? Thanks Michael Schmitz for giving me the first
concrete lead on this.


Stefan Jeglinski

lspci output for 2.2.18pre23. FWIW I also note that there are
numerous but subtle differences (in the + and - designations) between
lspci -vv for 2.2.17 and 2.2.18pre23. Is this an issue?


00:0b.0 Host bridge: Apple Computer Inc. Bandit PowerPC host bridge (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort+
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32 set, cache line size 08

00:0d.0 SCSI storage controller: Adaptec AIC-7881U
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 8 min, 8 max, 32 set, cache line size 08
	Interrupt: pin A routed to IRQ 23
	Region 0: I/O ports at <unassigned>
	Region 1: Memory at 80901000 (32-bit, non-prefetchable)
	Expansion ROM at 80910000 [disabled]

00:0e.0 Ethernet controller: Digital Equipment Corporation DECchip
21142/43 (rev 41)
	Subsystem: Standard Microsystems Corp [SMC]: Unknown device 2401
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 20 min, 40 max, 96 set
	Interrupt: pin A routed to IRQ 24
	Region 0: I/O ports at 1000
	Region 1: Memory at 80900000 (32-bit, non-prefetchable) [disabled]
	Expansion ROM at 80940000 [disabled]

00:0f.0 PCI bridge: Action Tec Electronics Inc: Unknown device 0100
(rev 11) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 set, cache line size 08
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: 80800000-808fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 1
		Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] #06 [0000]

00:10.0 Class ff00: Apple Computer Inc. Grand Central I/O (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
	Latency: 32 set, cache line size 08
	Region 0: Memory at f3000000 (32-bit, non-prefetchable)

01:0c.0 FireWire (IEEE 1394): NEC Corporation: Unknown device 00cd
(rev 01) (prog-if 10 [OHCI])
	Subsystem: Orange Micro: Unknown device 8010
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 set, cache line size 08
	Interrupt: pin A routed to IRQ 1
	Region 0: Memory at 80801000 (32-bit, non-prefetchable)
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- AuxPwr- DSI- D1- D2+ PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:0d.0 USB Controller: OPTi Inc. 82C861 (rev 10) (prog-if 10 [OHCI])
	Subsystem: OPTi Inc.: Unknown device c861
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort+ <MAbort- >SERR- <PERR-
	Latency: 32 set, cache line size 08
	Interrupt: pin A routed to IRQ 23
	Region 0: Memory at 80800000 (32-bit, non-prefetchable)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
