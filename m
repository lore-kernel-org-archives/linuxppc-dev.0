Message-ID: <393BCDA8.E346B65F@pop.agri.ch>
Date: Mon, 05 Jun 2000 17:56:37 +0200
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Linux -Dev <linuxppc-dev@lists.linuxppc.org>
Subject: 2940UW & 2.4.0-test-ac7 PCI probs
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I try to get the 2.4.0-test1-ac7 to boot on my 7200. It fails. I have a
2940UW where all my disks are connected to. A 2.3.99p9 from linuxcare
boots, but the ac7 from bk fails with the following message:

Total memory = 80MB; using 512kB for hash table (at c0300000)
Linux version 2.4.0-test1-ac7 (root@pm7200) (gcc version 2.95.3 19991030
(prerelease/franzo)) #4 Mon Jun 5 17:14:33 CEST 2000
PCI bus 0 controlled by bandit at f2000000
[snip]
PCI: Device 00:0e.0 not available because of resource collisions
[snip]

The kernel can't boot since it doesn't find the root. ;-)

I'm aware of problems with the adaptec on 2.4.0-test1 and up. (Alan Cox
writes so) But I'm not sure if that is the same problems, since on lk
people reported about timeouts etc. And on my side I have a general PCI problem.

Are any PCI-fixup patches integrated in bk? Or should I try Michel fixes?

Thanks,

Andreas

Below the lspci -vv from the 2.3.99p9

00:0b.0 Host bridge: Apple Computer Inc. Bandit PowerPC host bridge (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32 set, cache line size 08

00:0d.0 Ethernet controller: 3Com Corporation 3c590 10BaseT [Vortex]
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 3 min, 8 max, 32 set
	Interrupt: pin A routed to IRQ 23
	Region 0: I/O ports at 0480 [disabled]

00:0e.0 SCSI storage controller: Adaptec AIC-7881U
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 8 min, 8 max, 32 set, cache line size 08
	Interrupt: pin A routed to IRQ 24
	Region 0: I/O ports at <unassigned>
	Region 1: Memory at 80801000 (32-bit, non-prefetchable)

00:0f.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
(rev 64)
	Subsystem: Unknown device 10b7:9055
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 10 min, 10 max, 32 set, cache line size 08
	Interrupt: pin A routed to IRQ 25
	Region 0: I/O ports at 0400 [disabled]
	Region 1: Memory at 80800000 (32-bit, non-prefetchable) [disabled]
	Capabilities: <available only to root>

00:10.0 Class ff00: Apple Computer Inc. Grand Central I/O (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
	Latency: 32 set, cache line size 08
	Region 0: Memory at f3000000 (32-bit, non-prefetchable)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
