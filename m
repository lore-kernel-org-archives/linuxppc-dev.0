Message-ID: <38E39BDF.642013A0@schweiz.org>
Date: Thu, 30 Mar 2000 20:24:36 +0200
From: C&A <a.tobler@schweiz.org>
Reply-To: a.tobler@schweiz.org
MIME-Version: 1.0
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: cardbus probing, some more results
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

I played with the pci-fixup code from Geert/Michel et al.

To detect the devices behind the TI1131 bridge I replaced the
pci_scan_cardbus function-call in pci_do_scan_bus in driver/pci/pci.c
with pci_scan_bridge.

In arch/ppc/kernel/pmac_pci.c I added the code fragment below on line
667 to 673.

+		/* PowerBook 2400/3400 and G3 Macs have only one host bridge */
+		/* So we can assume all buses are under the one host bridge */
+		if(!strcmp(dev->name, "pci") ||
+		   (find_devices("ohare") && find_devices("via-pmu")))
+		  bp->max_bus = (bus_range[1] > 16)?bus_range[1] : 16;
+		else
+		  bp->max_bus = bus_range[1];


(sorry I write this on a Mac where I dont have Linux access, so no diff)

The result is the pci-probing below:

Well I know not that good, but my CardBus-function is now recognized,
EXCEPT the the resources. (IO-BASE was0x80000000)

The lspci -vv is also below.

Why is the cardbus-bridge detecting not done by default? How is this
done under intel machines?

The kernel: 2.3.99pre3 with pcmcia disabled.

If I'm totally wrong in the approach let me know.

Thanks,

Andreas

P.S. sorry for the length, but now Jeff has all the info :-)

----dmesg-start---
PCI: Probing PCI hardware (semiautomatic)
Scanning bus 00
Found 00:00 [1057/0002] 000600 00
Found 00:68 [106b/0010] 00ff00 00
Found 00:80 [106b/0010] 00ff00 00
Found 00:88 [1002/4c47] 000300 00
Found 00:98 [104c/ac15] 000607 02
Found 00:99 [104c/ac15] 000607 02
Fixups for bus 00
Scanning behind PCI bridge 00:13.0
Scanning bus 01
Found 01:00 [115d/0003] 000200 00	<--- Function 1 of the Xircom Card
Found 01:01 [115d/0103] 000700 00	<--- Function 2 of the Xircom Card
Fixups for bus 01
Bus scan for 01 returning with max=01
Scanning behind PCI bridge 00:13.1
Scanning bus 06
Fixups for bus 06
Bus scan for 06 returning with max=06
Bus scan for 00 returning with max=06
PCI: Fixing device 00:00.0 (1057:0002)
PCI: Fixing device 00:0d.0 (106b:0010)
PCI: Fixing device 00:10.0 (106b:0010)
PCI: Fixing device 00:11.0 (1002:4c47)
PCI: Setting IRQ 24 on device 00:11.0.
PCI: Correcting IO address 1 on device 00:11.0, now fe000400.
PCI: Enabling device 00:11.0 (0086 -> 0087)
PCI: Fixing device 00:13.0 (104c:ac15)
PCI: Setting IRQ 22 on device 00:13.0.
PCI: Fixing device 00:13.1 (104c:ac15)
PCI: Setting IRQ 23 on device 00:13.1.
PCI: Fixing device 01:00.0 (115d:0003)
PCI: Device 01:00.0 not available because of resource collisions
PCI: Fixing device 01:00.1 (115d:0103)
PCI: Device 01:00.1 not available because of resource collisions
PCI: Resource f4000000-f407ffff (f=200, d=0, p=0)
PCI: Resource f3000000-f307ffff (f=200, d=0, p=0)
PCI: Resource 82000000-82ffffff (f=200, d=0, p=0)
PCI: Resource fe000400-fe0004ff (f=101, d=0, p=0)
PCI: Resource 82fff000-82ffffff (f=200, d=0, p=0)
PCI: Cannot allocate resource region 2 of device 00:11.0
PCI: Resource 81803000-81803fff (f=200, d=0, p=0)
PCI: Resource 81802000-81802fff (f=200, d=0, p=0)
PCI: Resource 90004800-90004fff (f=200, d=0, p=0)
PCI: Cannot allocate resource region 1 of device 01:00.0
PCI: Resource 90004000-900047ff (f=200, d=0, p=0)
PCI: Cannot allocate resource region 2 of device 01:00.0
PCI: Switching off ROM of 01:00.0
  for root[0:ffffffff] min[80000000] size[1000]
  got res[80000000:80000fff] for resource 2
PCI: Cannot find parent resource for device 01:00.0
PCI: Cannot find parent resource for device 01:00.0
PCI: Cannot find parent resource for device 01:00.0
PCI: Cannot find parent resource for device 01:00.1
PCI: Cannot find parent resource for device 01:00.1
PCI: Cannot find parent resource for device 01:00.1

----dmesg-stop---

---lspci -vv---
00:00.0 Host bridge: Motorola Computer Group MPC106 [Grackle] (rev 40)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort+ <TAbort-
<MAbort+ >SERR- <PERR+
	Latency: 0 set, cache line size 08

00:0d.0 Class ff00: Apple Computer Inc. Heathrow Mac I/O (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
	Latency: 32 set, cache line size 08
	Region 0: Memory at f4000000 (32-bit, non-prefetchable)

00:10.0 Class ff00: Apple Computer Inc. Heathrow Mac I/O (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
	Latency: 32 set, cache line size 08
	Region 0: Memory at f3000000 (32-bit, non-prefetchable)

00:11.0 VGA compatible controller: ATI Technologies Inc 215LG [Mach64
LG] (rev 80)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 8 min, 32 set, cache line size 08
	Interrupt: pin A routed to IRQ 24
	Region 0: Memory at 82000000 (32-bit, non-prefetchable)
	Region 1: I/O ports at fe000400
	Region 2: Memory at 80000000 (32-bit, non-prefetchable)

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
	Region 1: Memory at <ignored> (32-bit, non-prefetchable)
	Region 2: Memory at <ignored> (32-bit, non-prefetchable)
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

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
