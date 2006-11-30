Return-Path: <olaf@aepfle.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.189])
	by ozlabs.org (Postfix) with ESMTP id 709BA67A2E
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Dec 2006 03:52:58 +1100 (EST)
Date: Thu, 30 Nov 2006 17:52:02 +0100 (MET)
From: Olaf Hering <olaf@aepfle.de>
To: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: pata_sl82c105 can not reserve IO region
Message-ID: <20061130165202.GA23205@aepfle.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ew6BAiZeqk4r7MaW"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline


pata_sl82c105 can be used on the ppc64 POWER4 system p610, p615 and p630
for the onboard IDE CD drive. It could be also used for ppc32 Motorola
PowerStack PReP systems.

Unfortunately, it doesnt work for me on the p630:

PCI: Enabling device: (0000:00:03.1), cmd 141
PCI: Unable to reserve I/O region #6:10@0 for device 0000:00:03.1
pata_sl82c105: probe of 0000:00:03.1 failed with error -16

Any idea how to fix it properly?

dmesg and other info attached.

--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="winbond-ide.txt"

Using pSeries machine description
Page orders: linear mapping = 24, virtual = 12, io = 12
Found legacy serial port 0 for /pci@400000000110/isa@3/serial@i3f8
  port=3f8, taddr=3fd300003f8, irq=0, clk=1843200, speed=0
Found legacy serial port 1 for /pci@400000000110/isa@3/serial@i2f8
  port=2f8, taddr=3fd300002f8, irq=0, clk=1843200, speed=0
Found legacy serial port 2 for /pci@400000000110/isa@3/serial@i898
  port=898, taddr=3fd30000898, irq=0, clk=1843200, speed=0
Starting Linux PPC64 #7 SMP Thu Nov 30 15:59:33 CET 2006
-----------------------------------------------------
ppc64_pft_size                = 0x0
physicalMemorySize            = 0x200000000
ppc64_caches.dcache_line_size = 0x80
ppc64_caches.icache_line_size = 0x80
htab_address                  = 0xc0000001f0000000
htab_hash_mask                = 0xfffff
-----------------------------------------------------
Linux version 2.6.19-ppc64-bug159235 (olaf@pomegranate) (gcc version 4.1.0 (SUSE Linux)) #7 SMP Thu Nov 30 15:59:33 CET 2006
[boot]0012 Setup Arch
Entering add_active_range(0, 0, 2097152) 0 entries of 256 used
No ramdisk, default root is /dev/sda2
EEH: PCI Enhanced I/O Error Handling Enabled
PPC64 nvram contains 81920 bytes
Using default idle loop
Top of RAM: 0x200000000, Total RAM: 0x200000000
Memory hole size: 0MB
Zone PFN ranges:
  DMA             0 ->  2097152
  Normal    2097152 ->  2097152
early_node_map[1] active PFN ranges
    0:        0 ->  2097152
On node 0 totalpages: 2097152
  DMA zone: 28672 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 2068480 pages, LIFO batch:31
  Normal zone: 0 pages used for memmap
[boot]0015 Setup Done
Built 1 zonelists.  Total pages: 2068480
Kernel command line:  debug video=matroxfb:1280x1024@85 sysrq=1 panic=32 root=/dev/sdb2  
[boot]0020 XICS Init
xics: PCI 8259 intack at 0x000003fffdf091f0
i8259 legacy interrupt controller initialized
[boot]0021 XICS Done
PID hash table entries: 4096 (order: 12, 32768 bytes)
time_init: decrementer frequency = 181.701290 MHz
time_init: processor frequency   = 1453.000000 MHz
Console: colour dummy device 80x25
Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Memory: 8102896k/8388608k available (3508k kernel code, 284972k reserved, 1072k data, 2273k bss, 180k init)
Calibrating delay loop... 362.90 BogoMIPS (lpj=1814528)
Mount-cache hash table entries: 256
Processor 1 found.
Processor 2 found.
Processor 3 found.
Brought up 4 CPUs
migration_cost=0
NET: Registered protocol family 16
PCI: Probing PCI hardware
Failed to request PCI IO region on PCI domain 0000
Using INTC for W82c105 IDE controller.
IOMMU table initialized, virtual merging enabled
ISA bridge at 0000:00:03.0
mapping IO 3fd30000000 -> d000080000000000, size: 100000
mapping IO 3fd50000000 -> d000080000100000, size: 100000
PCI: Probing PCI hardware done
SCSI subsystem initialized
NET: Registered protocol family 2
IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
TCP established hash table entries: 1048576 (order: 12, 16777216 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 1048576 bind 65536)
TCP reno registered
RTAS daemon started
RTAS: event: 188, Type: Internal Device Failure, Severity: 2
io scheduler noop registered (default)
matroxfb: Matrox G450 detected
PInS data found at offset 31168
PInS memtype = 4
matroxfb: 1280x1024x8bpp (virtual: 1280x13107)
matroxfb: framebuffer at 0x3FDEC000000, mapped to 0xd000080080009000, size 16777216
Console: switching to colour frame buffer device 160x64
fb0: MATROX frame buffer device
matroxfb_crtc2: secondary head of fb0 was registered as fb1
Generic RTC Driver v1.07
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250.0: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250.0: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
serial8250.0: ttyS2 at I/O 0x898 (irq = 10) is a 16550A
loop: loaded (max 8 devices)
e100: Intel(R) PRO/100 Network Driver, 3.5.17-k2-NAPI
e100: Copyright(c) 1999-2006 Intel Corporation
PCI: Enabling device: (0000:21:01.0), cmd 143
e100: eth0: e100_probe: addr 0x3fd88030000, irq 85, MAC addr 00:02:55:4F:05:C7
PCI: Enabling device: (0001:21:01.0), cmd 143
e100: eth1: e100_probe: addr 0x3fde8030000, irq 117, MAC addr 00:02:55:4F:05:D7
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
W82C105: IDE controller at PCI slot 0000:00:03.1
PCI: Enabling device: (0000:00:03.1), cmd 141
W82C105: chipset revision 5
W82C105: 100% native mode on irq 86
    ide0: BM-DMA at 0xf040-0xf047, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf048-0xf04f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: LG CD-ROM CRD-8484B, ATAPI CD/DVD-ROM drive
hda: selected PIO 4 (120ns) (0240)
ide0 at 0xf000-0xf007,0xf012 on irq 86
Probing IDE interface ide1...
hda: ATAPI 48X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.20
PCI: Enabling device: (0000:41:01.0), cmd 143
sym0: <1010-66> rev 0x1 at pci 0000:41:01.0 irq 87
sym0: No NVRAM, ID 7, Fast-80, LVD, parity checking
sym0: SCSI BUS has been reset.
scsi0 : sym-2.2.3
scsi 0:0:8:0: Direct-Access     IBM      IC35L036UCD210-0 S5BS PQ: 0 ANSI: 3
 target0:0:8: tagged command queuing enabled, command queue depth 16.
 target0:0:8: Beginning Domain Validation
 target0:0:8: asynchronous
 target0:0:8: wide asynchronous
 target0:0:8: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 31)
 target0:0:8: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 31)
 target0:0:8: Ending Domain Validation
scsi 0:0:9:0: Direct-Access     IBM      IC35L036UCD210-0 S5BS PQ: 0 ANSI: 3
 target0:0:9: tagged command queuing enabled, command queue depth 16.
 target0:0:9: Beginning Domain Validation
 target0:0:9: asynchronous
 target0:0:9: wide asynchronous
 target0:0:9: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 31)
 target0:0:9: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 31)
 target0:0:9: Ending Domain Validation
scsi 0:0:15:0: Enclosure         IBM      HSBPD4E  PU3SCSI 0011 PQ: 0 ANSI: 2
 target0:0:15: Beginning Domain Validation
scsi 0:0:15:0: phase change 6-7 6@40000fa0 resid=4.
 target0:0:15: asynchronous
 target0:0:15: Ending Domain Validation
PCI: Enabling device: (0000:41:01.1), cmd 143
sym1: <1010-66> rev 0x1 at pci 0000:41:01.1 irq 88
sym1: No NVRAM, ID 7, Fast-80, SE, parity checking
sym1: SCSI BUS has been reset.
scsi1 : sym-2.2.3
 target1:0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 31)
scsi 1:0:0:0: Sequential-Access HP       IBM-C568303030!D C209 PQ: 0 ANSI: 2
 target1:0:0: Beginning Domain Validation
 target1:0:0: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 31)
 target1:0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 31)
 target1:0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 31)
 target1:0:0: Domain Validation skipping write tests
 target1:0:0: Ending Domain Validation
SCSI device sda: 71096640 512-byte hdwr sectors (36401 MB)
sda: Write Protect is off
sda: Mode Sense: cb 00 00 08
SCSI device sda: drive cache: write through
SCSI device sda: 71096640 512-byte hdwr sectors (36401 MB)
sda: Write Protect is off
sda: Mode Sense: cb 00 00 08
SCSI device sda: drive cache: write through
 sda: sda1 sda2 sda3
sd 0:0:8:0: Attached scsi disk sda
SCSI device sdb: 71096640 512-byte hdwr sectors (36401 MB)
sdb: Write Protect is off
sdb: Mode Sense: cb 00 00 08
SCSI device sdb: drive cache: write through
SCSI device sdb: 71096640 512-byte hdwr sectors (36401 MB)
sdb: Write Protect is off
sdb: Mode Sense: cb 00 00 08
SCSI device sdb: drive cache: write through
 sdb: sdb1 sdb2
sd 0:0:9:0: Attached scsi disk sdb
sd 0:0:8:0: Attached scsi generic sg0 type 0
sd 0:0:9:0: Attached scsi generic sg1 type 0
scsi 0:0:15:0: Attached scsi generic sg2 type 13
scsi 1:0:0:0: Attached scsi generic sg3 type 1
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
input: AT Raw Set 2 keyboard as /class/input/input0
logips2pp: Detected unknown logitech mouse model 1
input: PS/2 Logitech Mouse as /class/input/input1
ReiserFS: sdb2: found reiserfs format "3.6" with standard journal
ReiserFS: sdb2: using ordered data mode
ReiserFS: sdb2: journal params: device sdb2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sdb2: checking transaction log (sdb2)
ReiserFS: sdb2: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 180k freed
ioctl32(showconsole:353): Unknown cmd fd(0) cmd(40045432){00} arg(ffda1b38) on /dev/console
ioctl32(showconsole:388): Unknown cmd fd(0) cmd(40045432){00} arg(fff67ac8) on /dev/console
ReiserFS: sdb2: warning: acl not supported.
ReiserFS: sdb2: warning: user_xattr not supported.
ReiserFS: sdb2: warning: acl not supported.
ReiserFS: sdb2: warning: user_xattr not supported.
ioctl32(showconsole:958): Unknown cmd fd(0) cmd(40045432){00} arg(ff8fdac8) on /dev/console
ioctl32(showconsole:1130): Unknown cmd fd(0) cmd(40045432){00} arg(ff997ad8) on /dev/console
Adding 1048568k swap on /dev/sda2.  Priority:-1 extents:1 across:1048568k
ioctl32(showconsole:1217): Unknown cmd fd(0) cmd(40045432){00} arg(ffe01b18) on /dev/console
e100: eth2: e100_watchdog: link up, 100Mbps, full-duplex
ioctl32(showconsole:2448): Unknown cmd fd(0) cmd(40045432){00} arg(ff821a78) on /dev/tty0
ISO 9660 Extensions: RRIP_1991A
==> /proc/ide <==

==> /proc/interrupts <==
           CPU0       CPU1       CPU2       CPU3       
  1:          3          2          4          3   i8259     Level     i8042
 12:         28         28         27         26   i8259     Level     i8042
 16:        442        666        574        337   XICS      Level     IPI
 86:        269        255        236        255   XICS      Level     ide0
 87:       2243       2234       2260       2218   XICS      Level     sym53c8xx
 88:         13         14         13         13   XICS      Level     sym53c8xx
117:       1714       1736       1727       1752   XICS      Level     eth2
BAD:          0

==> /proc/iomem <==
3fcc0000000-3fcc00fffff : PCI Bus #61
  3fcc0000000-3fcc00fffff : PCI Bus #41
    3fcc0000000-3fcc00fffff : PCI Bus #21
      3fcc0000000-3fcc00fffff : PCI Bus #01
        3fcc0000000-3fcc0007fff : 0000:00:02.6
          3fcc0000000-3fcc0007fff : 0000:00:02.4
          3fcc0000000-3fcc0007fff : 0000:00:02.2
3fd00000000-3fd000fffff : PCI Bus #61
  3fd00000000-3fd000fffff : PCI Bus #21
    3fd00000000-3fd000fffff : PCI Bus #01
      3fd00000000-3fd00007fff : 0001:00:02.6
        3fd00000000-3fd00007fff : 0001:00:02.2
3fd80000000-3fdbfffffff : /pci@400000000110
  3fd80000000-3fd87ffffff : PCI Bus #01
  3fd88000000-3fd8bffffff : PCI Bus #21
    3fd88000000-3fd8801ffff : 0000:21:01.0
      3fd88000000-3fd8801ffff : e100
    3fd88020000-3fd8802ffff : 0000:21:01.0
    3fd88030000-3fd88030fff : 0000:21:01.0
      3fd88030000-3fd88030fff : e100
  3fd8c000000-3fd8fffffff : PCI Bus #41
    3fd8c000000-3fd8c001fff : 0000:41:01.1
      3fd8c000000-3fd8c001fff : sym53c8xx
    3fd8c002000-3fd8c003fff : 0000:41:01.0
      3fd8c002000-3fd8c003fff : sym53c8xx
    3fd8c004000-3fd8c0043ff : 0000:41:01.1
      3fd8c004000-3fd8c0043ff : sym53c8xx
    3fd8c005000-3fd8c0053ff : 0000:41:01.0
      3fd8c005000-3fd8c0053ff : sym53c8xx
  3fd90000000-3fd97ffffff : PCI Bus #61
    3fd90000000-3fd90003fff : 0000:61:01.0
  3fd9fff0000-3fd9fff7fff : 0000:00:02.0
  3fdb4000000-3fdb7ffffff : 0000:00:01.0
  3fdb8000000-3fdbbffffff : 0000:00:01.0
  3fdbd700000-3fdbd700fff : 0000:00:01.0
  3fdbd800000-3fdbd87ffff : 0000:00:01.0
3fde0000000-3fdffffffff : /pci@400000000112
  3fde0000000-3fde7ffffff : PCI Bus #01
    3fde0000000-3fde0000fff : 0001:01:01.3
    3fde0001000-3fde0001fff : 0001:01:01.2
    3fde0002000-3fde0002fff : 0001:01:01.1
    3fde0003000-3fde0003fff : 0001:01:01.0
  3fde8000000-3fdebffffff : PCI Bus #21
    3fde8000000-3fde801ffff : 0001:21:01.0
      3fde8000000-3fde801ffff : e100
    3fde8020000-3fde802ffff : 0001:21:01.0
    3fde8030000-3fde8030fff : 0001:21:01.0
      3fde8030000-3fde8030fff : e100
  3fdec000000-3fdf3ffffff : PCI Bus #61
    3fdec000000-3fdef0fffff : PCI Bus #62
      3fdec000000-3fdedffffff : 0001:62:00.0
        3fdec000000-3fdedffffff : matroxfb FB
      3fdee000000-3fdee7fffff : 0001:62:00.0
      3fdee800000-3fdee803fff : 0001:62:00.0
        3fdee800000-3fdee803fff : matroxfb MMIO
      3fdef000000-3fdef01ffff : 0001:62:00.0
  3fdffff0000-3fdffff7fff : 0001:00:02.0

==> /proc/ioports <==
00000000-0000001f : dma1
00000020-00000021 : 8259 (master)
00000040-0000005f : timer
00000060-0000006f : i8042
00000080-0000008f : dma page reg
000000a0-000000a1 : 8259 (slave)
000000c0-000000df : dma2
000002f8-000002ff : serial
000003c0-000003df : matrox
000003f8-000003ff : serial
000004d0-000004d1 : 8259 edge control
00000898-0000089f : serial
0000f000-0000f007 : 0000:00:03.1
  0000f000-0000f007 : ide0
0000f010-0000f013 : 0000:00:03.1
  0000f012-0000f012 : ide0
0000f020-0000f027 : 0000:00:03.1
0000f030-0000f033 : 0000:00:03.1
0000f040-0000f04f : 0000:00:03.1
  0000f040-0000f047 : ide0
  0000f048-0000f04f : ide1
00010000-0001ffff : PCI Bus #01
00020000-0002ffff : PCI Bus #21
  0002ec00-0002ec3f : 0000:21:01.0
    0002ec00-0002ec3f : e100
00030000-0003ffff : PCI Bus #41
  0003e800-0003e8ff : 0000:41:01.0
    0003e800-0003e8ff : sym53c8xx
  0003ec00-0003ecff : 0000:41:01.1
    0003ec00-0003ecff : sym53c8xx
00040000-0004ffff : PCI Bus #61
00100000-001fffff : /pci@400000000112
  00100000-0010ffff : PCI Bus #01
  00110000-0011ffff : PCI Bus #21
    0011ec00-0011ec3f : 0001:21:01.0
      0011ec00-0011ec3f : e100
  00120000-0012ffff : PCI Bus #61

==> /proc/irq <==
00:01.0 Co-processor: IBM Unknown device 00e0 (rev 01) (prog-if ff)
	Subsystem: IBM Unknown device 00e1
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 72
	Interrupt: pin A routed to IRQ 255
	Region 0: Memory at 3fdbd700000 (32-bit, prefetchable) [size=4K]
	Region 1: Memory at 3fdbd800000 (32-bit, prefetchable) [size=512K]
	Region 2: Memory at 3fdb4000000 (32-bit, prefetchable) [size=64M]
	Region 3: Memory at 3fdb8000000 (32-bit, prefetchable) [size=64M]

00:02.0 PCI bridge: IBM EADS-X PCI-X to PCI-X Bridge (rev 01) (prog-if 0f)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248, Cache Line Size 20
	BIST result: 00
	Region 0: Memory at 3fd9fff0000 (64-bit, prefetchable) [size=32K]
	Bus: primary=00, secondary=01, subordinate=10, sec-latency=248
	I/O behind bridge: 00010000-0001ffff
	Memory behind bridge: c0000000-c7ffffff
	Prefetchable memory behind bridge: 0000000000000000-0000000000000000
	Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset+ FastB2B-
	Capabilities: [a0] PCI-X bridge device
		Secondary Status: 64bit+ 133MHz+ SCD- USC- SCO- SRD- Freq=conv
		Status: Dev=00:00.0 64bit+ 133MHz- SCD- USC- SCO- SRD-
		Upstream: Capacity=0 CommitmentLimit=0
		Downstream: Capacity=0 CommitmentLimit=0
	Capabilities: [b0] Power Management version 2
		Flags: PMEClk+ DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [b8] #0c [0000]

00:02.2 PCI bridge: IBM EADS-X PCI-X to PCI-X Bridge (rev 01) (prog-if 0f)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248, Cache Line Size 20
	BIST result: 00
	Region 0: Memory at 3fcc0000000 (64-bit, prefetchable) [size=32K]
	Bus: primary=00, secondary=21, subordinate=30, sec-latency=248
	I/O behind bridge: 00020000-0002ffff
	Memory behind bridge: c8000000-cbffffff
	Prefetchable memory behind bridge: 0000000000000000-0000000000000000
	Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [a0] PCI-X bridge device
		Secondary Status: 64bit- 133MHz- SCD- USC- SCO- SRD- Freq=conv
		Status: Dev=00:00.2 64bit+ 133MHz- SCD- USC- SCO- SRD-
		Upstream: Capacity=0 CommitmentLimit=0
		Downstream: Capacity=0 CommitmentLimit=0
	Capabilities: [b0] Power Management version 2
		Flags: PMEClk+ DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [b8] #0c [0000]

00:02.4 PCI bridge: IBM EADS-X PCI-X to PCI-X Bridge (rev 01) (prog-if 0f)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248, Cache Line Size 20
	BIST result: 00
	Region 0: Memory at 3fcc0000000 (64-bit, prefetchable) [size=32K]
	Bus: primary=00, secondary=41, subordinate=50, sec-latency=248
	I/O behind bridge: 00030000-0003ffff
	Memory behind bridge: cc000000-cfffffff
	Prefetchable memory behind bridge: 0000000000000000-0000000000000000
	Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [a0] PCI-X bridge device
		Secondary Status: 64bit+ 133MHz+ SCD- USC- SCO- SRD- Freq=conv
		Status: Dev=00:00.4 64bit+ 133MHz- SCD- USC- SCO- SRD-
		Upstream: Capacity=0 CommitmentLimit=0
		Downstream: Capacity=0 CommitmentLimit=0
	Capabilities: [b0] Power Management version 2
		Flags: PMEClk+ DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [b8] #0c [0000]

00:02.6 PCI bridge: IBM EADS-X PCI-X to PCI-X Bridge (rev 01) (prog-if 0f)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248, Cache Line Size 20
	BIST result: 00
	Region 0: Memory at 3fcc0000000 (64-bit, prefetchable) [size=32K]
	Bus: primary=00, secondary=61, subordinate=70, sec-latency=248
	I/O behind bridge: 00040000-0004ffff
	Memory behind bridge: d0000000-d7ffffff
	Prefetchable memory behind bridge: 0000000000000000-0000000000000000
	Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [a0] PCI-X bridge device
		Secondary Status: 64bit+ 133MHz+ SCD- USC- SCO- SRD- Freq=conv
		Status: Dev=00:00.6 64bit+ 133MHz- SCD- USC- SCO- SRD-
		Upstream: Capacity=0 CommitmentLimit=0
		Downstream: Capacity=0 CommitmentLimit=0
	Capabilities: [b0] Power Management version 2
		Flags: PMEClk+ DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [b8] #0c [0000]

00:03.0 ISA bridge: Symphony Labs W83C553 (rev 10)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:03.1 IDE interface: Symphony Labs SL82c105 (rev 05) (prog-if 8f [Master SecP SecO PriP PriO])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 72 (500ns min, 10000ns max), Cache Line Size 08
	Interrupt: pin A routed to IRQ 86
	Region 0: I/O ports at 3fd3000f000 [size=8]
	Region 1: I/O ports at 3fd3000f010 [size=4]
	Region 2: I/O ports at 3fd3000f020 [size=8]
	Region 3: I/O ports at 3fd3000f030 [size=4]
	Region 4: I/O ports at 3fd3000f040 [size=16]
	Region 5: I/O ports at 3fd30000000 [size=16]

21:01.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100] (rev 0d)
	Subsystem: IBM Unknown device 01ff
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 74 (2000ns min, 14000ns max)
	Interrupt: pin A routed to IRQ 85
	Region 0: Memory at 3fd88030000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 3fd3002ec00 [size=64]
	Region 2: Memory at 3fd88000000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at 3fd88020000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

41:01.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1010 66MHz  Ultra3 SCSI Adapter (rev 01)
	Subsystem: LSI Logic / Symbios Logic LSI53C1000/1000R/1010R/1010-66 PCI to Ultra160 SCSI Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 74 (4250ns min, 4500ns max), Cache Line Size 20
	Interrupt: pin A routed to IRQ 87
	Region 0: I/O ports at 3fd3003e800 [size=256]
	Region 1: Memory at 3fd8c005000 (64-bit, non-prefetchable) [size=1K]
	Region 3: Memory at 3fd8c002000 (64-bit, non-prefetchable) [size=8K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

41:01.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1010 66MHz  Ultra3 SCSI Adapter (rev 01)
	Subsystem: LSI Logic / Symbios Logic LSI53C1000/1000R/1010R/1010-66 PCI to Ultra160 SCSI Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 74 (4250ns min, 4500ns max), Cache Line Size 20
	Interrupt: pin B routed to IRQ 88
	Region 0: I/O ports at 3fd3003ec00 [size=256]
	Region 1: Memory at 3fd8c004000 (64-bit, non-prefetchable) [size=1K]
	Region 3: Memory at 3fd8c000000 (64-bit, non-prefetchable) [size=8K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

61:01.0 Ethernet controller: Alteon Networks Inc. AceNIC Gigabit Ethernet (rev 01)
	Subsystem: IBM Gigabit Ethernet-SX PCI Adapter
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 89
	Region 0: Memory at 3fd90000000 (32-bit, non-prefetchable) [disabled] [size=16K]

0001:00:02.0 PCI bridge: IBM EADS-X PCI-X to PCI-X Bridge (rev 01) (prog-if 0f)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248, Cache Line Size 20
	BIST result: 00
	Region 0: Memory at 3fdffff0000 (64-bit, prefetchable) [size=32K]
	Bus: primary=00, secondary=01, subordinate=10, sec-latency=248
	I/O behind bridge: 00000000-0000ffff
	Memory behind bridge: e0000000-e7ffffff
	Prefetchable memory behind bridge: 0000000000000000-0000000000000000
	Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [a0] PCI-X bridge device
		Secondary Status: 64bit+ 133MHz+ SCD- USC- SCO- SRD- Freq=conv
		Status: Dev=00:02.0 64bit+ 133MHz+ SCD- USC- SCO- SRD-
		Upstream: Capacity=0 CommitmentLimit=0
		Downstream: Capacity=0 CommitmentLimit=0
	Capabilities: [b0] Power Management version 2
		Flags: PMEClk+ DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [b8] #0c [0000]

0001:00:02.2 PCI bridge: IBM EADS-X PCI-X to PCI-X Bridge (rev 01) (prog-if 0f)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248, Cache Line Size 20
	BIST result: 00
	Region 0: Memory at 3fd00000000 (64-bit, prefetchable) [size=32K]
	Bus: primary=00, secondary=21, subordinate=30, sec-latency=248
	I/O behind bridge: 00010000-0001ffff
	Memory behind bridge: e8000000-ebffffff
	Prefetchable memory behind bridge: 0000000000000000-0000000000000000
	Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [a0] PCI-X bridge device
		Secondary Status: 64bit- 133MHz- SCD- USC- SCO- SRD- Freq=conv
		Status: Dev=00:02.2 64bit+ 133MHz+ SCD- USC- SCO- SRD-
		Upstream: Capacity=0 CommitmentLimit=0
		Downstream: Capacity=0 CommitmentLimit=0
	Capabilities: [b0] Power Management version 2
		Flags: PMEClk+ DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [b8] #0c [0000]

0001:00:02.6 PCI bridge: IBM EADS-X PCI-X to PCI-X Bridge (rev 01) (prog-if 0f)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248, Cache Line Size 20
	BIST result: 00
	Region 0: Memory at 3fd00000000 (64-bit, prefetchable) [size=32K]
	Bus: primary=00, secondary=61, subordinate=70, sec-latency=248
	I/O behind bridge: 00020000-0002ffff
	Memory behind bridge: ec000000-f3ffffff
	Prefetchable memory behind bridge: 0000000000000000-0000000000000000
	Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [a0] PCI-X bridge device
		Secondary Status: 64bit+ 133MHz+ SCD- USC- SCO- SRD- Freq=conv
		Status: Dev=00:02.6 64bit+ 133MHz+ SCD- USC- SCO- SRD-
		Upstream: Capacity=0 CommitmentLimit=0
		Downstream: Capacity=0 CommitmentLimit=0
	Capabilities: [b0] Power Management version 2
		Flags: PMEClk+ DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [b8] #0c [0000]

0001:01:01.0 USB Controller: Agere Systems USS-344S USB Controller (rev 11) (prog-if 10 [OHCI])
	Subsystem: Agere Systems USS-344S USB Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 72 (750ns min, 21500ns max)
	Interrupt: pin A routed to IRQ 115
	Region 0: Memory at 3fde0003000 (32-bit, non-prefetchable) [size=4K]

0001:01:01.1 USB Controller: Agere Systems USS-344S USB Controller (rev 11) (prog-if 10 [OHCI])
	Subsystem: Agere Systems USS-344S USB Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 72 (750ns min, 21500ns max)
	Interrupt: pin B routed to IRQ 116
	Region 0: Memory at 3fde0002000 (32-bit, non-prefetchable) [size=4K]

0001:01:01.2 USB Controller: Agere Systems USS-344S USB Controller (rev 11) (prog-if 10 [OHCI])
	Subsystem: Agere Systems USS-344S USB Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 72 (750ns min, 21500ns max)
	Interrupt: pin C routed to IRQ 115
	Region 0: Memory at 3fde0001000 (32-bit, non-prefetchable) [size=4K]

0001:01:01.3 USB Controller: Agere Systems USS-344S USB Controller (rev 11) (prog-if 10 [OHCI])
	Subsystem: Agere Systems USS-344S USB Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 72 (750ns min, 21500ns max)
	Interrupt: pin D routed to IRQ 116
	Region 0: Memory at 3fde0000000 (32-bit, non-prefetchable) [size=4K]

0001:21:01.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100] (rev 0d)
	Subsystem: IBM Unknown device 01ff
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 74 (2000ns min, 14000ns max)
	Interrupt: pin A routed to IRQ 117
	Region 0: Memory at 3fde8030000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 3fd5001ec00 [size=64]
	Region 2: Memory at 3fde8000000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at 3fde8020000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

0001:61:01.0 PCI bridge: Hint Corp HB6 Universal PCI-PCI bridge (non-transparent mode) (rev 12) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 74, Cache Line Size 08
	Bus: primary=61, secondary=62, subordinate=62, sec-latency=128
	I/O behind bridge: 01001000-01000fff
	Memory behind bridge: ec000000-ef0fffff
	Prefetchable memory behind bridge: 0000000001000000-0000000000f00000
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] #06 [0000]
	Capabilities: [a0] Vital Product Data

0001:62:00.0 VGA compatible controller: Matrox Graphics, Inc. G400/G450 (rev 82) (prog-if 00 [VGA])
	Subsystem: IBM Unknown device 0233
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 121
	Region 0: Memory at 3fdec000000 (32-bit, prefetchable) [size=32M]
	Region 1: Memory at 3fdee800000 (32-bit, non-prefetchable) [size=16K]
	Region 2: Memory at 3fdee000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at 3fdef000000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [f0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="winbond-libata.txt"

Using pSeries machine description
Page orders: linear mapping = 24, virtual = 12, io = 12
Found legacy serial port 0 for /pci@400000000110/isa@3/serial@i3f8
  port=3f8, taddr=3fd300003f8, irq=0, clk=1843200, speed=0
Found legacy serial port 1 for /pci@400000000110/isa@3/serial@i2f8
  port=2f8, taddr=3fd300002f8, irq=0, clk=1843200, speed=0
Found legacy serial port 2 for /pci@400000000110/isa@3/serial@i898
  port=898, taddr=3fd30000898, irq=0, clk=1843200, speed=0
Starting Linux PPC64 #8 SMP Thu Nov 30 17:33:10 CET 2006
-----------------------------------------------------
ppc64_pft_size                = 0x0
physicalMemorySize            = 0x200000000
ppc64_caches.dcache_line_size = 0x80
ppc64_caches.icache_line_size = 0x80
htab_address                  = 0xc0000001f0000000
htab_hash_mask                = 0xfffff
-----------------------------------------------------
Linux version 2.6.19-ppc64-bug159235 (olaf@pomegranate) (gcc version 4.1.0 (SUSE Linux)) #8 SMP Thu Nov 30 17:33:10 CET 2006
[boot]0012 Setup Arch
Entering add_active_range(0, 0, 2097152) 0 entries of 256 used
No ramdisk, default root is /dev/sda2
EEH: PCI Enhanced I/O Error Handling Enabled
PPC64 nvram contains 81920 bytes
Using default idle loop
Top of RAM: 0x200000000, Total RAM: 0x200000000
Memory hole size: 0MB
Zone PFN ranges:
  DMA             0 ->  2097152
  Normal    2097152 ->  2097152
early_node_map[1] active PFN ranges
    0:        0 ->  2097152
On node 0 totalpages: 2097152
  DMA zone: 28672 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 2068480 pages, LIFO batch:31
  Normal zone: 0 pages used for memmap
[boot]0015 Setup Done
Built 1 zonelists.  Total pages: 2068480
Kernel command line:  debug video=matroxfb:1280x1024@85 sysrq=1 panic=32 root=/dev/sdb2  
[boot]0020 XICS Init
xics: PCI 8259 intack at 0x000003fffdf091f0
i8259 legacy interrupt controller initialized
[boot]0021 XICS Done
PID hash table entries: 4096 (order: 12, 32768 bytes)
time_init: decrementer frequency = 181.701788 MHz
time_init: processor frequency   = 1453.000000 MHz
Console: colour dummy device 80x25
Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Memory: 8103028k/8388608k available (3476k kernel code, 284888k reserved, 1060k data, 2236k bss, 176k init)
Calibrating delay loop... 362.90 BogoMIPS (lpj=1814528)
Mount-cache hash table entries: 256
Processor 1 found.
Processor 2 found.
Processor 3 found.
Brought up 4 CPUs
migration_cost=0
NET: Registered protocol family 16
PCI: Probing PCI hardware
Failed to request PCI IO region on PCI domain 0000
Using INTC for W82c105 IDE controller.
IOMMU table initialized, virtual merging enabled
ISA bridge at 0000:00:03.0
mapping IO 3fd30000000 -> d000080000000000, size: 100000
mapping IO 3fd50000000 -> d000080000100000, size: 100000
PCI: Probing PCI hardware done
SCSI subsystem initialized
libata version 2.00 loaded.
NET: Registered protocol family 2
IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
TCP established hash table entries: 1048576 (order: 12, 16777216 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 1048576 bind 65536)
TCP reno registered
RTAS daemon started
RTAS: event: 188, Type: Internal Device Failure, Severity: 2
io scheduler noop registered (default)
matroxfb: Matrox G450 detected
PInS data found at offset 31168
PInS memtype = 4
matroxfb: 1280x1024x8bpp (virtual: 1280x13107)
matroxfb: framebuffer at 0x3FDEC000000, mapped to 0xd000080080009000, size 16777216
Console: switching to colour frame buffer device 160x64
fb0: MATROX frame buffer device
matroxfb_crtc2: secondary head of fb0 was registered as fb1
Generic RTC Driver v1.07
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250.0: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250.0: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
serial8250.0: ttyS2 at I/O 0x898 (irq = 10) is a 16550A
loop: loaded (max 8 devices)
e100: Intel(R) PRO/100 Network Driver, 3.5.17-k2-NAPI
e100: Copyright(c) 1999-2006 Intel Corporation
PCI: Enabling device: (0000:21:01.0), cmd 143
e100: eth0: e100_probe: addr 0x3fd88030000, irq 85, MAC addr 00:02:55:4F:05:C7
PCI: Enabling device: (0001:21:01.0), cmd 143
e100: eth1: e100_probe: addr 0x3fde8030000, irq 117, MAC addr 00:02:55:4F:05:D7
PCI: Enabling device: (0000:41:01.0), cmd 143
sym0: <1010-66> rev 0x1 at pci 0000:41:01.0 irq 87
sym0: No NVRAM, ID 7, Fast-80, LVD, parity checking
sym0: SCSI BUS has been reset.
scsi0 : sym-2.2.3
scsi 0:0:8:0: Direct-Access     IBM      IC35L036UCD210-0 S5BS PQ: 0 ANSI: 3
 target0:0:8: tagged command queuing enabled, command queue depth 16.
 target0:0:8: Beginning Domain Validation
 target0:0:8: asynchronous
 target0:0:8: wide asynchronous
 target0:0:8: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 31)
 target0:0:8: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 31)
 target0:0:8: Ending Domain Validation
scsi 0:0:9:0: Direct-Access     IBM      IC35L036UCD210-0 S5BS PQ: 0 ANSI: 3
 target0:0:9: tagged command queuing enabled, command queue depth 16.
 target0:0:9: Beginning Domain Validation
 target0:0:9: asynchronous
 target0:0:9: wide asynchronous
 target0:0:9: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 31)
 target0:0:9: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 31)
 target0:0:9: Ending Domain Validation
scsi 0:0:15:0: Enclosure         IBM      HSBPD4E  PU3SCSI 0011 PQ: 0 ANSI: 2
 target0:0:15: Beginning Domain Validation
scsi 0:0:15:0: phase change 6-7 6@40000fa0 resid=4.
 target0:0:15: asynchronous
 target0:0:15: Ending Domain Validation
PCI: Enabling device: (0000:41:01.1), cmd 143
sym1: <1010-66> rev 0x1 at pci 0000:41:01.1 irq 88
sym1: No NVRAM, ID 7, Fast-80, SE, parity checking
sym1: SCSI BUS has been reset.
scsi1 : sym-2.2.3
 target1:0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 31)
scsi 1:0:0:0: Sequential-Access HP       IBM-C568303030!D C209 PQ: 0 ANSI: 2
 target1:0:0: Beginning Domain Validation
 target1:0:0: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 31)
 target1:0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 31)
 target1:0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 31)
 target1:0:0: Domain Validation skipping write tests
 target1:0:0: Ending Domain Validation
SCSI device sda: 71096640 512-byte hdwr sectors (36401 MB)
sda: Write Protect is off
sda: Mode Sense: cb 00 00 08
SCSI device sda: drive cache: write through
SCSI device sda: 71096640 512-byte hdwr sectors (36401 MB)
sda: Write Protect is off
sda: Mode Sense: cb 00 00 08
SCSI device sda: drive cache: write through
 sda: sda1 sda2 sda3
sd 0:0:8:0: Attached scsi disk sda
SCSI device sdb: 71096640 512-byte hdwr sectors (36401 MB)
sdb: Write Protect is off
sdb: Mode Sense: cb 00 00 08
SCSI device sdb: drive cache: write through
SCSI device sdb: 71096640 512-byte hdwr sectors (36401 MB)
sdb: Write Protect is off
sdb: Mode Sense: cb 00 00 08
SCSI device sdb: drive cache: write through
 sdb: sdb1 sdb2
sd 0:0:9:0: Attached scsi disk sdb
sd 0:0:8:0: Attached scsi generic sg0 type 0
sd 0:0:9:0: Attached scsi generic sg1 type 0
scsi 0:0:15:0: Attached scsi generic sg2 type 13
scsi 1:0:0:0: Attached scsi generic sg3 type 1
PCI: Enabling device: (0000:00:03.1), cmd 141
PCI: Unable to reserve I/O region #6:10@0 for device 0000:00:03.1
pata_sl82c105: probe of 0000:00:03.1 failed with error -16
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
input: AT Raw Set 2 keyboard as /class/input/input0
logips2pp: Detected unknown logitech mouse model 1
input: PS/2 Logitech Mouse as /class/input/input1
ReiserFS: sdb2: found reiserfs format "3.6" with standard journal
ReiserFS: sdb2: using ordered data mode
ReiserFS: sdb2: journal params: device sdb2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sdb2: checking transaction log (sdb2)
ReiserFS: sdb2: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 176k freed
ioctl32(showconsole:355): Unknown cmd fd(0) cmd(40045432){00} arg(ffa32b38) on /dev/console
ioctl32(showconsole:390): Unknown cmd fd(0) cmd(40045432){00} arg(fffb4ac8) on /dev/console
ReiserFS: sdb2: warning: acl not supported.
ReiserFS: sdb2: warning: user_xattr not supported.
ReiserFS: sdb2: warning: acl not supported.
ReiserFS: sdb2: warning: user_xattr not supported.
ioctl32(showconsole:953): Unknown cmd fd(0) cmd(40045432){00} arg(ffc97ac8) on /dev/console
ioctl32(showconsole:1125): Unknown cmd fd(0) cmd(40045432){00} arg(fff9bad8) on /dev/console
Adding 1048568k swap on /dev/sda2.  Priority:-1 extents:1 across:1048568k
ioctl32(showconsole:1212): Unknown cmd fd(0) cmd(40045432){00} arg(ffb99b18) on /dev/console
e100: eth2: e100_watchdog: link up, 100Mbps, full-duplex
ioctl32(showconsole:2409): Unknown cmd fd(0) cmd(40045432){00} arg(fff1fa78) on /dev/tty0
==> /proc/interrupts <==
           CPU0       CPU1       CPU2       CPU3       
  1:          3          3          2          4   i8259     Level     i8042
 12:         26         28         28         27   i8259     Level     i8042
 16:        254        597        403        583   XICS      Level     IPI
 87:       2088       2071       2092       2088   XICS      Level     sym53c8xx
 88:         13         13         14         13   XICS      Level     sym53c8xx
117:        490        506        484        489   XICS      Level     eth2
BAD:          0

==> /proc/iomem <==
3fcc0000000-3fcc00fffff : PCI Bus #61
  3fcc0000000-3fcc00fffff : PCI Bus #41
    3fcc0000000-3fcc00fffff : PCI Bus #21
      3fcc0000000-3fcc00fffff : PCI Bus #01
        3fcc0000000-3fcc0007fff : 0000:00:02.6
          3fcc0000000-3fcc0007fff : 0000:00:02.4
          3fcc0000000-3fcc0007fff : 0000:00:02.2
3fd00000000-3fd000fffff : PCI Bus #61
  3fd00000000-3fd000fffff : PCI Bus #21
    3fd00000000-3fd000fffff : PCI Bus #01
      3fd00000000-3fd00007fff : 0001:00:02.6
        3fd00000000-3fd00007fff : 0001:00:02.2
3fd80000000-3fdbfffffff : /pci@400000000110
  3fd80000000-3fd87ffffff : PCI Bus #01
  3fd88000000-3fd8bffffff : PCI Bus #21
    3fd88000000-3fd8801ffff : 0000:21:01.0
      3fd88000000-3fd8801ffff : e100
    3fd88020000-3fd8802ffff : 0000:21:01.0
    3fd88030000-3fd88030fff : 0000:21:01.0
      3fd88030000-3fd88030fff : e100
  3fd8c000000-3fd8fffffff : PCI Bus #41
    3fd8c000000-3fd8c001fff : 0000:41:01.1
      3fd8c000000-3fd8c001fff : sym53c8xx
    3fd8c002000-3fd8c003fff : 0000:41:01.0
      3fd8c002000-3fd8c003fff : sym53c8xx
    3fd8c004000-3fd8c0043ff : 0000:41:01.1
      3fd8c004000-3fd8c0043ff : sym53c8xx
    3fd8c005000-3fd8c0053ff : 0000:41:01.0
      3fd8c005000-3fd8c0053ff : sym53c8xx
  3fd90000000-3fd97ffffff : PCI Bus #61
    3fd90000000-3fd90003fff : 0000:61:01.0
  3fd9fff0000-3fd9fff7fff : 0000:00:02.0
  3fdb4000000-3fdb7ffffff : 0000:00:01.0
  3fdb8000000-3fdbbffffff : 0000:00:01.0
  3fdbd700000-3fdbd700fff : 0000:00:01.0
  3fdbd800000-3fdbd87ffff : 0000:00:01.0
3fde0000000-3fdffffffff : /pci@400000000112
  3fde0000000-3fde7ffffff : PCI Bus #01
    3fde0000000-3fde0000fff : 0001:01:01.3
    3fde0001000-3fde0001fff : 0001:01:01.2
    3fde0002000-3fde0002fff : 0001:01:01.1
    3fde0003000-3fde0003fff : 0001:01:01.0
  3fde8000000-3fdebffffff : PCI Bus #21
    3fde8000000-3fde801ffff : 0001:21:01.0
      3fde8000000-3fde801ffff : e100
    3fde8020000-3fde802ffff : 0001:21:01.0
    3fde8030000-3fde8030fff : 0001:21:01.0
      3fde8030000-3fde8030fff : e100
  3fdec000000-3fdf3ffffff : PCI Bus #61
    3fdec000000-3fdef0fffff : PCI Bus #62
      3fdec000000-3fdedffffff : 0001:62:00.0
        3fdec000000-3fdedffffff : matroxfb FB
      3fdee000000-3fdee7fffff : 0001:62:00.0
      3fdee800000-3fdee803fff : 0001:62:00.0
        3fdee800000-3fdee803fff : matroxfb MMIO
      3fdef000000-3fdef01ffff : 0001:62:00.0
  3fdffff0000-3fdffff7fff : 0001:00:02.0

==> /proc/ioports <==
00000000-0000001f : dma1
00000020-00000021 : 8259 (master)
00000040-0000005f : timer
00000060-0000006f : i8042
00000080-0000008f : dma page reg
000000a0-000000a1 : 8259 (slave)
000000c0-000000df : dma2
000002f8-000002ff : serial
000003c0-000003df : matrox
000003f8-000003ff : serial
000004d0-000004d1 : 8259 edge control
00000898-0000089f : serial
0000f000-0000f007 : 0000:00:03.1
0000f010-0000f013 : 0000:00:03.1
0000f020-0000f027 : 0000:00:03.1
0000f030-0000f033 : 0000:00:03.1
0000f040-0000f04f : 0000:00:03.1
00010000-0001ffff : PCI Bus #01
00020000-0002ffff : PCI Bus #21
  0002ec00-0002ec3f : 0000:21:01.0
    0002ec00-0002ec3f : e100
00030000-0003ffff : PCI Bus #41
  0003e800-0003e8ff : 0000:41:01.0
    0003e800-0003e8ff : sym53c8xx
  0003ec00-0003ecff : 0000:41:01.1
    0003ec00-0003ecff : sym53c8xx
00040000-0004ffff : PCI Bus #61
00100000-001fffff : /pci@400000000112
  00100000-0010ffff : PCI Bus #01
  00110000-0011ffff : PCI Bus #21
    0011ec00-0011ec3f : 0001:21:01.0
      0011ec00-0011ec3f : e100
  00120000-0012ffff : PCI Bus #61

==> /proc/irq <==
00:01.0 Co-processor: IBM Unknown device 00e0 (rev 01) (prog-if ff)
	Subsystem: IBM Unknown device 00e1
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 72
	Interrupt: pin A routed to IRQ 255
	Region 0: Memory at 3fdbd700000 (32-bit, prefetchable) [size=4K]
	Region 1: Memory at 3fdbd800000 (32-bit, prefetchable) [size=512K]
	Region 2: Memory at 3fdb4000000 (32-bit, prefetchable) [size=64M]
	Region 3: Memory at 3fdb8000000 (32-bit, prefetchable) [size=64M]

00:02.0 PCI bridge: IBM EADS-X PCI-X to PCI-X Bridge (rev 01) (prog-if 0f)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248, Cache Line Size 20
	BIST result: 00
	Region 0: Memory at 3fd9fff0000 (64-bit, prefetchable) [size=32K]
	Bus: primary=00, secondary=01, subordinate=10, sec-latency=248
	I/O behind bridge: 00010000-0001ffff
	Memory behind bridge: c0000000-c7ffffff
	Prefetchable memory behind bridge: 0000000000000000-0000000000000000
	Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset+ FastB2B-
	Capabilities: [a0] PCI-X bridge device
		Secondary Status: 64bit+ 133MHz+ SCD- USC- SCO- SRD- Freq=conv
		Status: Dev=00:00.0 64bit+ 133MHz- SCD- USC- SCO- SRD-
		Upstream: Capacity=0 CommitmentLimit=0
		Downstream: Capacity=0 CommitmentLimit=0
	Capabilities: [b0] Power Management version 2
		Flags: PMEClk+ DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [b8] #0c [0000]

00:02.2 PCI bridge: IBM EADS-X PCI-X to PCI-X Bridge (rev 01) (prog-if 0f)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248, Cache Line Size 20
	BIST result: 00
	Region 0: Memory at 3fcc0000000 (64-bit, prefetchable) [size=32K]
	Bus: primary=00, secondary=21, subordinate=30, sec-latency=248
	I/O behind bridge: 00020000-0002ffff
	Memory behind bridge: c8000000-cbffffff
	Prefetchable memory behind bridge: 0000000000000000-0000000000000000
	Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [a0] PCI-X bridge device
		Secondary Status: 64bit- 133MHz- SCD- USC- SCO- SRD- Freq=conv
		Status: Dev=00:00.2 64bit+ 133MHz- SCD- USC- SCO- SRD-
		Upstream: Capacity=0 CommitmentLimit=0
		Downstream: Capacity=0 CommitmentLimit=0
	Capabilities: [b0] Power Management version 2
		Flags: PMEClk+ DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [b8] #0c [0000]

00:02.4 PCI bridge: IBM EADS-X PCI-X to PCI-X Bridge (rev 01) (prog-if 0f)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248, Cache Line Size 20
	BIST result: 00
	Region 0: Memory at 3fcc0000000 (64-bit, prefetchable) [size=32K]
	Bus: primary=00, secondary=41, subordinate=50, sec-latency=248
	I/O behind bridge: 00030000-0003ffff
	Memory behind bridge: cc000000-cfffffff
	Prefetchable memory behind bridge: 0000000000000000-0000000000000000
	Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [a0] PCI-X bridge device
		Secondary Status: 64bit+ 133MHz+ SCD- USC- SCO- SRD- Freq=conv
		Status: Dev=00:00.4 64bit+ 133MHz- SCD- USC- SCO- SRD-
		Upstream: Capacity=0 CommitmentLimit=0
		Downstream: Capacity=0 CommitmentLimit=0
	Capabilities: [b0] Power Management version 2
		Flags: PMEClk+ DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [b8] #0c [0000]

00:02.6 PCI bridge: IBM EADS-X PCI-X to PCI-X Bridge (rev 01) (prog-if 0f)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248, Cache Line Size 20
	BIST result: 00
	Region 0: Memory at 3fcc0000000 (64-bit, prefetchable) [size=32K]
	Bus: primary=00, secondary=61, subordinate=70, sec-latency=248
	I/O behind bridge: 00040000-0004ffff
	Memory behind bridge: d0000000-d7ffffff
	Prefetchable memory behind bridge: 0000000000000000-0000000000000000
	Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [a0] PCI-X bridge device
		Secondary Status: 64bit+ 133MHz+ SCD- USC- SCO- SRD- Freq=conv
		Status: Dev=00:00.6 64bit+ 133MHz- SCD- USC- SCO- SRD-
		Upstream: Capacity=0 CommitmentLimit=0
		Downstream: Capacity=0 CommitmentLimit=0
	Capabilities: [b0] Power Management version 2
		Flags: PMEClk+ DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [b8] #0c [0000]

00:03.0 ISA bridge: Symphony Labs W83C553 (rev 10)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:03.1 IDE interface: Symphony Labs SL82c105 (rev 05) (prog-if 8f [Master SecP SecO PriP PriO])
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 86
	Region 0: I/O ports at 3fd3000f000 [size=8]
	Region 1: I/O ports at 3fd3000f010 [size=4]
	Region 2: I/O ports at 3fd3000f020 [size=8]
	Region 3: I/O ports at 3fd3000f030 [size=4]
	Region 4: I/O ports at 3fd3000f040 [size=16]
	Region 5: I/O ports at 3fd30000000 [size=16]

21:01.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100] (rev 0d)
	Subsystem: IBM Unknown device 01ff
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 74 (2000ns min, 14000ns max)
	Interrupt: pin A routed to IRQ 85
	Region 0: Memory at 3fd88030000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 3fd3002ec00 [size=64]
	Region 2: Memory at 3fd88000000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at 3fd88020000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

41:01.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1010 66MHz  Ultra3 SCSI Adapter (rev 01)
	Subsystem: LSI Logic / Symbios Logic LSI53C1000/1000R/1010R/1010-66 PCI to Ultra160 SCSI Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 74 (4250ns min, 4500ns max), Cache Line Size 20
	Interrupt: pin A routed to IRQ 87
	Region 0: I/O ports at 3fd3003e800 [size=256]
	Region 1: Memory at 3fd8c005000 (64-bit, non-prefetchable) [size=1K]
	Region 3: Memory at 3fd8c002000 (64-bit, non-prefetchable) [size=8K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

41:01.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1010 66MHz  Ultra3 SCSI Adapter (rev 01)
	Subsystem: LSI Logic / Symbios Logic LSI53C1000/1000R/1010R/1010-66 PCI to Ultra160 SCSI Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 74 (4250ns min, 4500ns max), Cache Line Size 20
	Interrupt: pin B routed to IRQ 88
	Region 0: I/O ports at 3fd3003ec00 [size=256]
	Region 1: Memory at 3fd8c004000 (64-bit, non-prefetchable) [size=1K]
	Region 3: Memory at 3fd8c000000 (64-bit, non-prefetchable) [size=8K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

61:01.0 Ethernet controller: Alteon Networks Inc. AceNIC Gigabit Ethernet (rev 01)
	Subsystem: IBM Gigabit Ethernet-SX PCI Adapter
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 89
	Region 0: Memory at 3fd90000000 (32-bit, non-prefetchable) [disabled] [size=16K]

0001:00:02.0 PCI bridge: IBM EADS-X PCI-X to PCI-X Bridge (rev 01) (prog-if 0f)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248, Cache Line Size 20
	BIST result: 00
	Region 0: Memory at 3fdffff0000 (64-bit, prefetchable) [size=32K]
	Bus: primary=00, secondary=01, subordinate=10, sec-latency=248
	I/O behind bridge: 00000000-0000ffff
	Memory behind bridge: e0000000-e7ffffff
	Prefetchable memory behind bridge: 0000000000000000-0000000000000000
	Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [a0] PCI-X bridge device
		Secondary Status: 64bit+ 133MHz+ SCD- USC- SCO- SRD- Freq=conv
		Status: Dev=00:02.0 64bit+ 133MHz+ SCD- USC- SCO- SRD-
		Upstream: Capacity=0 CommitmentLimit=0
		Downstream: Capacity=0 CommitmentLimit=0
	Capabilities: [b0] Power Management version 2
		Flags: PMEClk+ DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [b8] #0c [0000]

0001:00:02.2 PCI bridge: IBM EADS-X PCI-X to PCI-X Bridge (rev 01) (prog-if 0f)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248, Cache Line Size 20
	BIST result: 00
	Region 0: Memory at 3fd00000000 (64-bit, prefetchable) [size=32K]
	Bus: primary=00, secondary=21, subordinate=30, sec-latency=248
	I/O behind bridge: 00010000-0001ffff
	Memory behind bridge: e8000000-ebffffff
	Prefetchable memory behind bridge: 0000000000000000-0000000000000000
	Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [a0] PCI-X bridge device
		Secondary Status: 64bit- 133MHz- SCD- USC- SCO- SRD- Freq=conv
		Status: Dev=00:02.2 64bit+ 133MHz+ SCD- USC- SCO- SRD-
		Upstream: Capacity=0 CommitmentLimit=0
		Downstream: Capacity=0 CommitmentLimit=0
	Capabilities: [b0] Power Management version 2
		Flags: PMEClk+ DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [b8] #0c [0000]

0001:00:02.6 PCI bridge: IBM EADS-X PCI-X to PCI-X Bridge (rev 01) (prog-if 0f)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248, Cache Line Size 20
	BIST result: 00
	Region 0: Memory at 3fd00000000 (64-bit, prefetchable) [size=32K]
	Bus: primary=00, secondary=61, subordinate=70, sec-latency=248
	I/O behind bridge: 00020000-0002ffff
	Memory behind bridge: ec000000-f3ffffff
	Prefetchable memory behind bridge: 0000000000000000-0000000000000000
	Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [a0] PCI-X bridge device
		Secondary Status: 64bit+ 133MHz+ SCD- USC- SCO- SRD- Freq=conv
		Status: Dev=00:02.6 64bit+ 133MHz+ SCD- USC- SCO- SRD-
		Upstream: Capacity=0 CommitmentLimit=0
		Downstream: Capacity=0 CommitmentLimit=0
	Capabilities: [b0] Power Management version 2
		Flags: PMEClk+ DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [b8] #0c [0000]

0001:01:01.0 USB Controller: Agere Systems USS-344S USB Controller (rev 11) (prog-if 10 [OHCI])
	Subsystem: Agere Systems USS-344S USB Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 72 (750ns min, 21500ns max)
	Interrupt: pin A routed to IRQ 115
	Region 0: Memory at 3fde0003000 (32-bit, non-prefetchable) [size=4K]

0001:01:01.1 USB Controller: Agere Systems USS-344S USB Controller (rev 11) (prog-if 10 [OHCI])
	Subsystem: Agere Systems USS-344S USB Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 72 (750ns min, 21500ns max)
	Interrupt: pin B routed to IRQ 116
	Region 0: Memory at 3fde0002000 (32-bit, non-prefetchable) [size=4K]

0001:01:01.2 USB Controller: Agere Systems USS-344S USB Controller (rev 11) (prog-if 10 [OHCI])
	Subsystem: Agere Systems USS-344S USB Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 72 (750ns min, 21500ns max)
	Interrupt: pin C routed to IRQ 115
	Region 0: Memory at 3fde0001000 (32-bit, non-prefetchable) [size=4K]

0001:01:01.3 USB Controller: Agere Systems USS-344S USB Controller (rev 11) (prog-if 10 [OHCI])
	Subsystem: Agere Systems USS-344S USB Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 72 (750ns min, 21500ns max)
	Interrupt: pin D routed to IRQ 116
	Region 0: Memory at 3fde0000000 (32-bit, non-prefetchable) [size=4K]

0001:21:01.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100] (rev 0d)
	Subsystem: IBM Unknown device 01ff
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 74 (2000ns min, 14000ns max)
	Interrupt: pin A routed to IRQ 117
	Region 0: Memory at 3fde8030000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 3fd5001ec00 [size=64]
	Region 2: Memory at 3fde8000000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at 3fde8020000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

0001:61:01.0 PCI bridge: Hint Corp HB6 Universal PCI-PCI bridge (non-transparent mode) (rev 12) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 74, Cache Line Size 08
	Bus: primary=61, secondary=62, subordinate=62, sec-latency=128
	I/O behind bridge: 01001000-01000fff
	Memory behind bridge: ec000000-ef0fffff
	Prefetchable memory behind bridge: 0000000001000000-0000000000f00000
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] #06 [0000]
	Capabilities: [a0] Vital Product Data

0001:62:00.0 VGA compatible controller: Matrox Graphics, Inc. G400/G450 (rev 82) (prog-if 00 [VGA])
	Subsystem: IBM Unknown device 0233
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 121
	Region 0: Memory at 3fdec000000 (32-bit, prefetchable) [size=32M]
	Region 1: Memory at 3fdee800000 (32-bit, non-prefetchable) [size=16K]
	Region 2: Memory at 3fdee000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at 3fdef000000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [f0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>


--ew6BAiZeqk4r7MaW--
