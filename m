Message-ID: <38DF96D0.9823B129@pop.agri.ch>
Date: Mon, 27 Mar 2000 19:13:58 +0200
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Linux-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: pci-resources feedback
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,
I have applied the patches from Michel to my 2399p3 tree. The main
reason for that was some hope in getting my CardBus card recognized
properly. Ok, not that successful but I think on the right way. At least
what dmesg says.

Also I'm confused about the ati memory range two. Which base is the one
I have to take?
A wallstreet I.

Below the dmesg from the 2399p3 (only pci-probing) and the corresponding
lspci -vv

as PCIBIOS_MIN_MEM I took 0x80000000.

---2399-dmesg---
PCI: Probing PCI hardware (semiautomatic)
Scanning bus 00
Found 00:00 [1057/0002] 000600 00
Found 00:68 [106b/0010] 00ff00 00
Found 00:80 [106b/0010] 00ff00 00
Found 00:88 [1002/4c47] 000300 00
Found 00:98 [104c/ac15] 000607 02
Found 00:99 [104c/ac15] 000607 02
Fixups for bus 00
Scanning CardBus bridge 00:13.0			<------ sounds good for CardBus!!
Scanning CardBus bridge 00:13.1
Bus scan for 00 returning with max=09
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
PCI: Resource f4000000-f407ffff (f=200, d=0, p=0)
PCI: Resource f3000000-f307ffff (f=200, d=0, p=0)
PCI: Resource 82000000-82ffffff (f=200, d=0, p=0)
PCI: Resource fe000400-fe0004ff (f=101, d=0, p=0)
PCI: Resource 82fff000-82ffffff (f=200, d=0, p=0)
PCI: Cannot allocate resource region 2 of device 00:11.0
PCI: Resource 81803000-81803fff (f=200, d=0, p=0)
PCI: Resource 81802000-81802fff (f=200, d=0, p=0)
  for root[0:ffffffff] min[80000000] size[1000]
  got res[80000000:80000fff] for resource 2
---end---

---lspci2399p3---

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
---end---

For comparison reasons a lspci -vv from the actual 2215p14:

---lspci2215p14---

00:11.0 VGA compatible controller: ATI Technologies Inc 215LG [Mach64
LG] (rev 80)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 8 min, 32 set, cache line size 08
	Interrupt: pin A routed to IRQ 24
	Region 0: Memory at 82000000 (32-bit, non-prefetchable)
	Region 1: I/O ports at 0400 [disabled]
	Region 2: Memory at 82fff000 (32-bit, non-prefetchable)
---end---


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
