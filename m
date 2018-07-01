Return-Path: <mroos@linux.ee>
Received: from smtp1.it.da.ut.ee (smtp1.it.da.ut.ee
 [IPv6:2001:bb8:2002:500::46])
 by lists.ozlabs.org (Postfix) with ESMTP id 41JZX65l7SzF1Hg
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jul 2018 01:47:33 +1000 (AEST)
Date: Sun, 1 Jul 2018 18:47:21 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
Sender: mroos@math.ut.ee
To: Mathieu Malaterre <malat@debian.org>
cc: Arnd Bergmann <arnd@arndb.de>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Geert Uytterhoeven <geert@linux-m68k.org>, funaho@jurai.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, gerg@linux-m68k.org,
 linux-m68k@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>, y2038@lists.linaro.org,
 schwab@linux-m68k.org
Subject: Re: [PATCH 1/3] [v2] powerpc: mac: fix rtc read/write functions
In-Reply-To: <CA+7wUsyN_gru4rW0y3ZzXzYwhfaA=uHKaOG=z5bprnYq6oVfMg@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1807011844470.19761@math.ut.ee>
References: <20180619140229.3615110-1-arnd@arndb.de>
 <CA+7wUsyN_gru4rW0y3ZzXzYwhfaA=uHKaOG=z5bprnYq6oVfMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A patch for the subject is now upstream. That made me finally take some 
time to test it on my PowerMac G4. Tha date is OK but I get two warnings 
with backtrace on bootup. Full dmesg below.

[    0.000000] Total memory = 1024MB; using 2048kB for hash table (at (ptrval))
[    0.000000] RAM mapped without BATs
[    0.000000] Linux version 4.18.0-rc2-00223-g1904148a361a (mroos@pohl) (gcc version 7.3.0 (Debian 7.3.0-24)) #88 Sun Jul 1 01:39:01 EEST 2018
[    0.000000] Found UniNorth memory controller & host bridge @ 0xf8000000 revision: 0x11
[    0.000000] Mapped at 0xff7c0000
[    0.000000] Found a Keylargo mac-io controller, rev: 3, mapped at 0x(ptrval)
[    0.000000] Processor NAP mode on idle enabled.
[    0.000000] PowerMac motherboard: PowerMac G4 Silver
[    0.000000] Using PowerMac machine description
[    0.000000] bootconsole [udbg0] enabled
[    0.000000] -----------------------------------------------------
[    0.000000] Hash_size         = 0x200000
[    0.000000] phys_mem_size     = 0x40000000
[    0.000000] dcache_bsize      = 0x20
[    0.000000] icache_bsize      = 0x20
[    0.000000] cpu_features      = 0x000000000401a00a
[    0.000000]   possible        = 0x000000002f7ff04b
[    0.000000]   always          = 0x0000000000000000
[    0.000000] cpu_user_features = 0x9c000001 0x00000000
[    0.000000] mmu_features      = 0x00000001
[    0.000000] Hash              = 0x(ptrval)
[    0.000000] Hash_mask         = 0x7fff
[    0.000000] -----------------------------------------------------
[    0.000000] Found UniNorth PCI host bridge at 0x00000000f0000000. Firmware bus number: 0->0
[    0.000000] PCI host bridge /pci@f0000000  ranges:
[    0.000000]  MEM 0x00000000f1000000..0x00000000f1ffffff -> 0x00000000f1000000 
[    0.000000]   IO 0x00000000f0000000..0x00000000f07fffff -> 0x0000000000000000
[    0.000000]  MEM 0x0000000090000000..0x000000009fffffff -> 0x0000000090000000 
[    0.000000] Found UniNorth PCI host bridge at 0x00000000f2000000. Firmware bus number: 0->0
[    0.000000] PCI host bridge /pci@f2000000 (primary) ranges:
[    0.000000]  MEM 0x00000000f3000000..0x00000000f3ffffff -> 0x00000000f3000000 
[    0.000000]   IO 0x00000000f2000000..0x00000000f27fffff -> 0x0000000000000000
[    0.000000]  MEM 0x0000000080000000..0x000000008fffffff -> 0x0000000080000000 
[    0.000000] Found UniNorth PCI host bridge at 0x00000000f4000000. Firmware bus number: 0->0
[    0.000000] PCI host bridge /pci@f4000000  ranges:
[    0.000000]  MEM 0x00000000f5000000..0x00000000f5ffffff -> 0x00000000f5000000 
[    0.000000]   IO 0x00000000f4000000..0x00000000f47fffff -> 0x0000000000000000
[    0.000000] via-pmu: Server Mode is disabled
[    0.000000] PMU driver v2 initialized for Core99, firmware: 0c
[    0.000000] nvram: Checking bank 0...
[    0.000000] nvram: gen0=134, gen1=135
[    0.000000] nvram: Active bank is: 1
[    0.000000] nvram: OF partition at 0x210
[    0.000000] nvram: XP partition at 0x1220
[    0.000000] nvram: NR partition at 0x1320
[    0.000000] Top of RAM: 0x40000000, Total RAM: 0x40000000
[    0.000000] Memory hole size: 0MB
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000000000-0x000000002fffffff]
[    0.000000]   Normal   empty
[    0.000000]   HighMem  [mem 0x0000000030000000-0x000000003fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000003fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000003fffffff]
[    0.000000] On node 0 totalpages: 262144
[    0.000000]   DMA zone: 1536 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 196608 pages, LIFO batch:31
[    0.000000]   HighMem zone: 65536 pages, LIFO batch:15
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 260608
[    0.000000] Kernel command line: root=/dev/sda3 ro 
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 1029696K/1048576K available (5136K kernel code, 228K rwdata, 996K rodata, 208K init, 255K bss, 18880K reserved, 0K cma-reserved, 262144K highmem)
[    0.000000] Kernel virtual memory layout:
[    0.000000]   * 0xfffcf000..0xfffff000  : fixmap
[    0.000000]   * 0xff800000..0xffc00000  : highmem PTEs
[    0.000000]   * 0xfded8000..0xff800000  : early ioremap
[    0.000000]   * 0xf1000000..0xfded8000  : vmalloc & ioremap
[    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] NR_IRQS: 512, nr_irqs: 512, preallocated irqs: 16
[    0.000000] mpic: Resetting
[    0.000000] mpic: Setting up MPIC " MPIC 1   " version 1.2 at 80040000, max 1 CPUs
[    0.000000] mpic: ISU size: 64, shift: 6, mask: 3f
[    0.000000] mpic: Initializing for 64 sources
[    0.000000] GMT Delta read from XPRAM: 120 minutes, DST: on
[    0.000000] WARNING: CPU: 0 PID: 0 at arch/powerpc/platforms/powermac/time.c:154 pmu_get_time+0x7c/0xc8
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.18.0-rc2-00223-g1904148a361a #88
[    0.000000] NIP:  c0021354 LR: c0021308 CTR: 00000000
[    0.000000] REGS: c0659df0 TRAP: 0700   Not tainted  (4.18.0-rc2-00223-g1904148a361a)
[    0.000000] MSR:  00021032 <ME,IR,DR,RI>  CR: 48000222  XER: 20000000
[    0.000000] 
               GPR00: c0021308 c0659ea0 c0635320 00000000 00d70298 00000004 00000001 00000098 
               GPR08: 00d70000 00000001 00000200 c06a0000 28000228 00000000 006cf290 006cf738 
               GPR16: ffbc1700 00000000 00000000 0076b855 006d6594 0013da24 009f0028 40140000 
               GPR24: 00000000 006ac000 efff44c0 c06293ec c065e020 c06293dc c066c4e4 c0659f78 
[    0.000000] NIP [c0021354] pmu_get_time+0x7c/0xc8
[    0.000000] LR [c0021308] pmu_get_time+0x30/0xc8
[    0.000000] Call Trace:
[    0.000000] [c0659ea0] [c0021308] pmu_get_time+0x30/0xc8 (unreliable)
[    0.000000] [c0659f10] [c000c428] read_persistent_clock64+0xc8/0x13c
[    0.000000] [c0659f50] [c060e288] timekeeping_init+0x1c/0x24c
[    0.000000] [c0659fc0] [c06020d8] start_kernel+0x2a0/0x38c
[    0.000000] [c0659ff0] [00003444] 0x3444
[    0.000000] Instruction dump:
[    0.000000] 8941002e 5484c00e 5508801e 88e1002f 7c844214 554a402e 7c845214 7c843a14 
[    0.000000] 7d244810 7d294910 7d2948f8 552907fe <0f090000> 3d2083da 80010074 38210070 
[    0.000000] random: get_random_bytes called from print_oops_end_marker+0x58/0x7c with crng_init=0
[    0.000000] ---[ end trace 2e01ad9337fe08fa ]---
[    0.000000] time_init: decrementer frequency = 33.290001 MHz
[    0.000000] time_init: processor frequency   = 533.333332 MHz
[    0.000021] clocksource: timebase: mask: 0xffffffffffffffff max_cycles: 0x7ad7d595e, max_idle_ns: 440795202265 ns
[    0.000697] clocksource: timebase mult[1e09ff2c] shift[24] registered
[    0.001075] clockevent: decrementer mult[885b18a] shift[32] cpu[0]
[    0.001234] Console: colour dummy device 80x25
[    0.001558] console [tty0] enabled
[    0.001855] bootconsole [udbg0] disabled
[    0.002335] pid_max: default: 32768 minimum: 301
[    0.002463] Security Framework initialized
[    0.002586] AppArmor: AppArmor initialized
[    0.002676] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.002701] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.004649] devtmpfs: initialized
[    0.005064] Duplicate name in PowerPC,G4@0, renamed to "l2-cache#1"
[    0.007902] random: get_random_u32 called from bucket_table_alloc+0x90/0x1dc with crng_init=0
[    0.008118] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.008143] futex hash table entries: 256 (order: -1, 3072 bytes)
[    0.008462] NET: Registered protocol family 16
[    0.008890] audit: initializing netlink subsys (disabled)
[    0.010008] KeyWest i2c @0xf8001003 irq 42 /uni-n@f8000000/i2c@f8001000
[    0.010033]  channel 0 bus <multibus>
[    0.010042]  channel 1 bus <multibus>
[    0.010154] KeyWest i2c @0x80018000 irq 26 /pci@f2000000/mac-io@17/i2c@18000
[    0.010183]  channel 0 bus <multibus>
[    0.010228] PMU i2c /pci@f2000000/mac-io@17/via-pmu@16000
[    0.010240]  channel 1 bus <multibus>
[    0.010249]  channel 2 bus <multibus>
[    0.010670] PCI: Probing PCI hardware
[    0.010826] PCI host bridge to bus 0000:00
[    0.010860] pci_bus 0000:00: root bus resource [io  0x802000-0x1001fff] (bus address [0x0000-0x7fffff])
[    0.010886] pci_bus 0000:00: root bus resource [mem 0xf1000000-0xf1ffffff]
[    0.010906] pci_bus 0000:00: root bus resource [mem 0x90000000-0x9fffffff]
[    0.010928] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.010950] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to ff
[    0.011456] pci 0000:00:0b.0: [106b:002d] type 00 class 0x060000
[    0.011929] pci 0000:00:10.0: [1002:5046] type 00 class 0x030000
[    0.011960] pci 0000:00:10.0: reg 0x10: [mem 0x94000000-0x97ffffff pref]
[    0.011973] pci 0000:00:10.0: reg 0x14: [io  0x802400-0x8024ff]
[    0.011986] pci 0000:00:10.0: reg 0x18: [mem 0x90000000-0x90003fff]
[    0.012014] pci 0000:00:10.0: reg 0x30: [mem 0x90020000-0x9003ffff pref]
[    0.012058] pci 0000:00:10.0: supports D1
[    0.012948] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 00
[    0.013076] PCI host bridge to bus 0001:10
[    0.013105] pci_bus 0001:10: root bus resource [io  0x0000-0x7fffff]
[    0.013125] pci_bus 0001:10: root bus resource [mem 0xf3000000-0xf3ffffff]
[    0.013144] pci_bus 0001:10: root bus resource [mem 0x80000000-0x8fffffff]
[    0.013193] pci_bus 0001:10: root bus resource [bus 10-ff]
[    0.013214] pci_bus 0001:10: busn_res: [bus 10-ff] end is updated to ff
[    0.013706] pci 0001:10:0b.0: [106b:002e] type 00 class 0x060000
[    0.014424] pci 0001:10:17.0: [106b:0022] type 00 class 0xff0000
[    0.014449] pci 0001:10:17.0: reg 0x10: [mem 0x80000000-0x8007ffff]
[    0.014685] pci 0001:10:18.0: [106b:0019] type 00 class 0x0c0310
[    0.014710] pci 0001:10:18.0: reg 0x10: [mem 0x80081000-0x80081fff]
[    0.014944] pci 0001:10:19.0: [106b:0019] type 00 class 0x0c0310
[    0.014970] pci 0001:10:19.0: reg 0x10: [mem 0x80080000-0x80080fff]
[    0.015553] pci_bus 0001:10: busn_res: [bus 10-ff] end is updated to 10
[    0.015671] PCI host bridge to bus 0002:20
[    0.015702] pci_bus 0002:20: root bus resource [io  0xff7fe000-0xffffdfff] (bus address [0x0000-0x7fffff])
[    0.015728] pci_bus 0002:20: root bus resource [mem 0xf5000000-0xf5ffffff]
[    0.015749] pci_bus 0002:20: root bus resource [bus 20-ff]
[    0.015768] pci_bus 0002:20: busn_res: [bus 20-ff] end is updated to ff
[    0.016256] pci 0002:20:0b.0: [106b:002f] type 00 class 0x060000
[    0.016581] pci 0002:20:0e.0: [11c1:5811] type 00 class 0x0c0010
[    0.016606] pci 0002:20:0e.0: reg 0x10: [mem 0xf5000000-0xf5000fff]
[    0.016658] pci 0002:20:0e.0: supports D1 D2
[    0.016665] pci 0002:20:0e.0: PME# supported from D0 D1 D2 D3hot
[    0.016875] pci 0002:20:0f.0: [106b:0021] type 00 class 0x020000
[    0.016899] pci 0002:20:0f.0: reg 0x10: [mem 0xf5200000-0xf53fffff]
[    0.016934] pci 0002:20:0f.0: reg 0x30: [mem 0xf5100000-0xf51fffff pref]
[    0.017919] pci_bus 0002:20: busn_res: [bus 20-ff] end is updated to 20
[    0.017991] PCI 0000:00 Cannot reserve Legacy IO [io  0x802000-0x802fff]
[    0.018011] pci_bus 0000:00: resource 4 [io  0x802000-0x1001fff]
[    0.018018] pci_bus 0000:00: resource 5 [mem 0xf1000000-0xf1ffffff]
[    0.018025] pci_bus 0000:00: resource 6 [mem 0x90000000-0x9fffffff]
[    0.018035] pci_bus 0001:10: resource 4 [io  0x0000-0x7fffff]
[    0.018042] pci_bus 0001:10: resource 5 [mem 0xf3000000-0xf3ffffff]
[    0.018049] pci_bus 0001:10: resource 6 [mem 0x80000000-0x8fffffff]
[    0.018058] pci_bus 0002:20: resource 4 [io  0xff7fe000-0xffffdfff]
[    0.018065] pci_bus 0002:20: resource 5 [mem 0xf5000000-0xf5ffffff]
[    0.025369] audit: type=2000 audit(0.008:1): state=initialized audit_enabled=0 res=1
[    0.034974] pci 0000:00:10.0: vgaarb: VGA device added: decodes=io+mem,owns=mem,locks=none
[    0.035036] pci 0000:00:10.0: vgaarb: bridge control possible
[    0.035055] pci 0000:00:10.0: vgaarb: setting as boot device (VGA legacy resources not available)
[    0.035077] vgaarb: loaded
[    0.035363] SCSI subsystem initialized
[    0.035944] libata version 3.00 loaded.
[    0.036069] usbcore: registered new interface driver usbfs
[    0.036135] usbcore: registered new interface driver hub
[    0.036205] usbcore: registered new device driver usb
[    0.038128] clocksource: Switched to clocksource timebase
[    0.038599] AppArmor: AppArmor Filesystem Enabled
[    0.054259] NET: Registered protocol family 2
[    0.054390] random: get_random_u32 called from neigh_hash_alloc+0x84/0xe0 with crng_init=0
[    0.054948] tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 4096 bytes)
[    0.054995] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.055096] TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
[    0.055183] TCP: Hash tables configured (established 8192 bind 8192)
[    0.055338] UDP hash table entries: 512 (order: 1, 8192 bytes)
[    0.055387] UDP-Lite hash table entries: 512 (order: 1, 8192 bytes)
[    0.055564] NET: Registered protocol family 1
[    0.055606] NET: Registered protocol family 44
[    0.055700] pci 0001:10:18.0: enabling device (0000 -> 0002)
[    0.114214] pci 0001:10:18.0: quirk_usb_early_handoff+0x0/0x8cc took 57137 usecs
[    0.114270] pci 0001:10:19.0: enabling device (0000 -> 0002)
[    0.174156] pci 0001:10:19.0: quirk_usb_early_handoff+0x0/0x8cc took 58481 usecs
[    0.174197] PCI: CLS mismatch (32 != 1020), using 32 bytes
[    0.174448] Thermal assist unit 
[    0.174453] using timers, 
[    0.174473] shrink_timer: 500 jiffies
[    0.175062] Initialise system trusted keyrings
[    0.175711] workingset: timestamp_bits=30 max_order=18 bucket_order=0
[    0.194025] Key type asymmetric registered
[    0.194079] Asymmetric key parser 'x509' registered
[    0.194248] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    0.194278] io scheduler noop registered
[    0.194291] io scheduler deadline registered
[    0.194481] io scheduler cfq registered (default)
[    0.195115] aty128fb 0000:00:10.0: enabling device (0086 -> 0087)
[    0.195588] aty128fb 0000:00:10.0: Invalid PCI ROM header signature: expecting 0xaa55, got 0x1111
[    0.195623] aty128fb: ROM failed to map
[    0.195636] aty128fb: BIOS not located, guessing timings.
[    0.195659] aty128fb: Rage128 PF PRO AGP [chip rev 0x1] 
[    0.195663] 16M 128-bit SDR SGRAM (1:1)
[    0.212238] Console: switching to colour frame buffer device 128x48
[    0.227164] fb0: ATY Rage128 frame buffer device on Rage128 PF PRO AGP
[    0.227746] pmac_zilog: 0.6 (Benjamin Herrenschmidt <benh@kernel.crashing.org>)
[    0.228033] Generic non-volatile memory driver v1.1
[    0.233973] loop: module loaded
[    0.234259] MacIO PCI driver attached to Keylargo chipset
[    0.236238] 0.00013020:ch-a: ttyS0 at MMIO 0x80013020 (irq = 22, base_baud = 230400) is a Z85c30 ESCC - Serial port
[    0.238389] 0.00013000:ch-b: ttyS1 at MMIO 0x80013000 (irq = 50, base_baud = 230400) is a Z85c30 ESCC - Serial port
[    1.282145] pata-macio 0.0001f000:ata-4: Activating pata-macio chipset KeyLargo ATA-4, Apple bus ID 2
[    1.283355] scsi host0: pata_macio
[    1.283766] ata1: PATA max UDMA/66 irq 19
[    1.445026] ata1.00: ATA-6: Maxtor 92049U3, BAC51JJ0, max UDMA/66
[    1.445230] ata1.00: 40010544 sectors, multi 0: LBA 
[    1.450748] scsi 0:0:0:0: Direct-Access     ATA      Maxtor 92049U3   1JJ0 PQ: 0 ANSI: 5
[    1.452076] sd 0:0:0:0: [sda] 40010544 512-byte logical blocks: (20.5 GB/19.1 GiB)
[    1.452392] sd 0:0:0:0: [sda] Write Protect is off
[    1.452557] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.452660] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.472546]  sda: [mac] sda1 sda2 sda3 sda4
[    1.474038] sd 0:0:0:0: [sda] Attached SCSI disk
[    2.338145] pata-macio 0.00020000:ata-3: Activating pata-macio chipset KeyLargo ATA-3, Apple bus ID 0
[    2.344877] scsi host1: pata_macio
[    2.350832] ata2: PATA max MWDMA2 irq 20
[    2.554418] ata2.00: ATAPI: MATSHITA CD-RW CW-7586, 1A17, max MWDMA2
[    2.560218] ata2.01: ATAPI: IOMEGA  ZIP 250       ATAPI, 41.S, max UDMA/33, CDB intr
[    2.618851] scsi 1:0:0:0: CD-ROM            MATSHITA CD-RW  CW-7586   1A17 PQ: 0 ANSI: 5
[    2.630676] scsi 1:0:1:0: Direct-Access     IOMEGA   ZIP 250          41.S PQ: 0 ANSI: 5
[    2.671193] sd 1:0:1:0: [sdb] Attached SCSI removable disk
[    3.394143] pata-macio 0.00021000:ata-3: Activating pata-macio chipset KeyLargo ATA-3, Apple bus ID 1
[    3.401263] scsi host2: pata_macio
[    3.407591] ata3: PATA max MWDMA2 irq 21
[    3.413826] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    3.420094] ohci-pci: OHCI PCI platform driver
[    3.426292] ohci-pci 0001:10:18.0: OHCI PCI host controller
[    3.432457] ohci-pci 0001:10:18.0: new USB bus registered, assigned bus number 1
[    3.438790] ohci-pci 0001:10:18.0: irq 27, io mem 0x80081000
[    3.522135] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.18
[    3.528544] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.534935] usb usb1: Product: OHCI PCI host controller
[    3.541239] usb usb1: Manufacturer: Linux 4.18.0-rc2-00223-g1904148a361a ohci_hcd
[    3.547669] usb usb1: SerialNumber: 0001:10:18.0
[    3.554601] hub 1-0:1.0: USB hub found
[    3.561194] hub 1-0:1.0: 2 ports detected
[    3.568015] ohci-pci 0001:10:19.0: OHCI PCI host controller
[    3.574418] ohci-pci 0001:10:19.0: new USB bus registered, assigned bus number 2
[    3.580866] ohci-pci 0001:10:19.0: irq 28, io mem 0x80080000
[    3.666142] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.18
[    3.672533] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.678911] usb usb2: Product: OHCI PCI host controller
[    3.685256] usb usb2: Manufacturer: Linux 4.18.0-rc2-00223-g1904148a361a ohci_hcd
[    3.691597] usb usb2: SerialNumber: 0001:10:19.0
[    3.698572] hub 2-0:1.0: USB hub found
[    3.704984] hub 2-0:1.0: 2 ports detected
[    3.711898] mousedev: PS/2 mouse device common for all mice
[    3.718339] WARNING: CPU: 0 PID: 1 at arch/powerpc/platforms/powermac/time.c:154 pmu_get_time+0x7c/0xc8
[    3.724661] Modules linked in:
[    3.730901] CPU: 0 PID: 1 Comm: swapper Tainted: G        W         4.18.0-rc2-00223-g1904148a361a #88
[    3.737332] NIP:  c0021354 LR: c0021308 CTR: 00000000
[    3.743649] REGS: ef047b50 TRAP: 0700   Tainted: G        W          (4.18.0-rc2-00223-g1904148a361a)
[    3.750136] MSR:  00029032 <EE,ME,IR,DR,RI>  CR: 44000822  XER: 20000000
[    3.756639] 
               GPR00: c0021308 ef047c00 ef048000 00000000 00d7029c 00000004 00000001 0000009c 
               GPR08: 00d70000 00000001 00000200 c06a0000 24000828 00000000 c0004c9c 00000000 
               GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 c0670000 c0601a38 
               GPR24: 00000007 00000000 ef0ccf40 00000000 ef047cec ef273800 ef047cec ef047cec 
[    3.788482] NIP [c0021354] pmu_get_time+0x7c/0xc8
[    3.794736] LR [c0021308] pmu_get_time+0x30/0xc8
[    3.800944] Call Trace:
[    3.807004] [ef047c00] [c0021308] pmu_get_time+0x30/0xc8 (unreliable)
[    3.813217] [ef047c70] [c00213e8] pmac_get_rtc_time+0x28/0x40
[    3.819357] [ef047c80] [c000bc04] rtc_generic_get_time+0x20/0x34
[    3.825395] [ef047c90] [c03aca34] __rtc_read_time+0x5c/0xe0
[    3.831290] [ef047ca0] [c03acafc] rtc_read_time+0x44/0x7c
[    3.837184] [ef047cc0] [c03ad81c] __rtc_read_alarm+0x28/0x440
[    3.843035] [ef047d30] [c03ac048] rtc_device_register+0x84/0x1b8
[    3.848869] [ef047d80] [c03ac1e4] devm_rtc_device_register+0x68/0xe8
[    3.854718] [ef047da0] [c061e1c8] generic_rtc_probe+0x2c/0x54
[    3.860538] [ef047db0] [c03209b4] platform_drv_probe+0x4c/0xb8
[    3.866355] [ef047dd0] [c031ed78] driver_probe_device+0x25c/0x35c
[    3.872071] [ef047e00] [c031ef8c] __driver_attach+0x114/0x118
[    3.877738] [ef047e20] [c031c960] bus_for_each_dev+0x80/0xc0
[    3.883334] [ef047e50] [c031df18] bus_add_driver+0x144/0x258
[    3.888857] [ef047e70] [c031f81c] driver_register+0x88/0x15c
[    3.894317] [ef047e80] [c03210e0] __platform_driver_probe+0x84/0x13c
[    3.899820] [ef047ea0] [c0004aa4] do_one_initcall+0x4c/0x1a8
[    3.905364] [ef047f00] [c06022f0] kernel_init_freeable+0x12c/0x1f4
[    3.910893] [ef047f30] [c0004cb4] kernel_init+0x18/0x130
[    3.916367] [ef047f40] [c00121c4] ret_from_kernel_thread+0x14/0x1c
[    3.921842] Instruction dump:
[    3.927168] 8941002e 5484c00e 5508801e 88e1002f 7c844214 554a402e 7c845214 7c843a14 
[    3.932672] 7d244810 7d294910 7d2948f8 552907fe <0f090000> 3d2083da 80010074 38210070 
[    3.938214] ---[ end trace 2e01ad9337fe08fb ]---
[    3.944429] rtc-generic rtc-generic: rtc core: registered rtc-generic as rtc0
[    3.950813] NET: Registered protocol family 10
[    3.956508] _warn_unseeded_randomness: 3 callbacks suppressed
[    3.956530] random: get_random_u32 called from neigh_hash_alloc+0x84/0xe0 with crng_init=0
[    3.969365] random: get_random_u32 called from bucket_table_alloc+0x90/0x1dc with crng_init=0
[    3.975248] Segment Routing with IPv6
[    3.980920] NET: Registered protocol family 17
[    3.986625] drmem: No dynamic reconfiguration memory found
[    3.992809] Loading compiled-in X.509 certificates
[    3.998321] AppArmor: AppArmor sha1 policy hashing enabled
[    4.003695] random: get_random_bytes called from prandom_seed_full_state+0x20/0x8c with crng_init=0
[    4.009807] input: PMU as /devices/virtual/input/input0
[    4.015320] console [netcon0] enabled
[    4.020771] netconsole: network logging started
[    4.026490] WARNING: CPU: 0 PID: 1 at arch/powerpc/platforms/powermac/time.c:154 pmu_get_time+0x7c/0xc8
[    4.032261] Modules linked in:
[    4.037878] CPU: 0 PID: 1 Comm: swapper Tainted: G        W         4.18.0-rc2-00223-g1904148a361a #88
[    4.043750] NIP:  c0021354 LR: c0021308 CTR: 00000000
[    4.049585] REGS: ef047cd0 TRAP: 0700   Tainted: G        W          (4.18.0-rc2-00223-g1904148a361a)
[    4.055572] MSR:  00029032 <EE,ME,IR,DR,RI>  CR: 44000222  XER: 20000000
[    4.061620] 
               GPR00: c0021308 ef047d80 ef048000 00000000 00d7029c 00000004 00000001 0000009c 
               GPR08: 00d70000 00000001 00000200 c06a0000 24000228 00000000 c0004c9c 00000000 
               GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 c0670000 c0601a38 
               GPR24: 00000008 c0630f18 c062a40c c05fc10c ef047e50 ef273800 ef047e50 ef047e50 
[    4.092393] NIP [c0021354] pmu_get_time+0x7c/0xc8
[    4.098596] LR [c0021308] pmu_get_time+0x30/0xc8
[    4.104779] Call Trace:
[    4.110909] [ef047d80] [c0021308] pmu_get_time+0x30/0xc8 (unreliable)
[    4.117209] [ef047df0] [c00213e8] pmac_get_rtc_time+0x28/0x40
[    4.123470] [ef047e00] [c000bc04] rtc_generic_get_time+0x20/0x34
[    4.129770] [ef047e10] [c03aca34] __rtc_read_time+0x5c/0xe0
[    4.136060] [ef047e20] [c03acafc] rtc_read_time+0x44/0x7c
[    4.142356] [ef047e40] [c061e000] rtc_hctosys+0x64/0x11c
[    4.148616] [ef047ea0] [c0004aa4] do_one_initcall+0x4c/0x1a8
[    4.154866] [ef047f00] [c06022f0] kernel_init_freeable+0x12c/0x1f4
[    4.161123] [ef047f30] [c0004cb4] kernel_init+0x18/0x130
[    4.167359] [ef047f40] [c00121c4] ret_from_kernel_thread+0x14/0x1c
[    4.173610] Instruction dump:
[    4.179766] 8941002e 5484c00e 5508801e 88e1002f 7c844214 554a402e 7c845214 7c843a14 
[    4.186076] 7d244810 7d294910 7d2948f8 552907fe <0f090000> 3d2083da 80010074 38210070 
[    4.192388] ---[ end trace 2e01ad9337fe08fd ]---
[    4.198643] rtc-generic rtc-generic: hctosys: unable to read the hardware clock
[    4.209046] EXT4-fs (sda3): mounting ext3 file system using the ext4 subsystem
[    4.236629] EXT4-fs (sda3): mounted filesystem with ordered data mode. Opts: (null)
[    4.243073] VFS: Mounted root (ext3 filesystem) readonly on device 8:3.
[    4.260646] devtmpfs: mounted
[    4.267211] Freeing unused kernel memory: 208K
[    4.398178] usb 2-1: new full-speed USB device number 2 using ohci-pci
[    4.629315] usb 2-1: New USB device found, idVendor=05ac, idProduct=1001, bcdDevice= 2.10
[    4.635736] usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    4.642038] usb 2-1: Product: Hub in Apple USB Keyboard
[    4.648301] usb 2-1: Manufacturer: Alps Electric
[    4.656332] hub 2-1:1.0: USB hub found
[    4.663208] hub 2-1:1.0: 3 ports detected
[    4.974155] usb 2-1.1: new low-speed USB device number 3 using ohci-pci
[    5.104225] usb 2-1.1: New USB device found, idVendor=05ac, idProduct=0201, bcdDevice= 1.02
[    5.110383] usb 2-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    5.116265] usb 2-1.1: Product: Apple USB Keyboard
[    5.122014] usb 2-1.1: Manufacturer: Alps Electric
[    5.210159] usb 2-1.2: new low-speed USB device number 4 using ohci-pci
[    5.242205] random: fast init done
[    5.338230] usb 2-1.2: New USB device found, idVendor=05ac, idProduct=0301, bcdDevice= 5.02
[    5.344013] usb 2-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    5.349638] usb 2-1.2: Product: M4848
[    5.355197] usb 2-1.2: Manufacturer: Logitech
[    7.600059] systemd[1]: System time before build time, advancing clock.
[    7.952523] systemd[1]: Failed to insert module 'autofs4': No such file or directory
[    8.148253] systemd[1]: systemd 239 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=hybrid)
[    8.178244] systemd[1]: Detected architecture ppc.
[    8.297863] systemd[1]: Set hostname to <pohl>.
[    8.319596] _warn_unseeded_randomness: 7 callbacks suppressed
[    8.319629] random: get_random_u32 called from bucket_table_alloc+0x90/0x1dc with crng_init=1
[    8.456375] random: get_random_u32 called from arch_pick_mmap_layout+0xe8/0x160 with crng_init=1
[    8.463131] random: get_random_u32 called from load_elf_binary+0x768/0x1214 with crng_init=1
[    9.348994] _warn_unseeded_randomness: 67 callbacks suppressed
[    9.349025] random: get_random_u32 called from arch_align_stack+0x44/0x64 with crng_init=1
[    9.362283] random: get_random_u32 called from arch_randomize_brk+0x20/0x78 with crng_init=1
[    9.893854] random: get_random_u32 called from arch_pick_mmap_layout+0xe8/0x160 with crng_init=1
[    9.962756] random: crng init done
[    9.969134] random: 5 get_random_xx warning(s) missed due to ratelimiting
[   13.408566] systemd[1]: Listening on Syslog Socket.
[   13.422964] systemd[1]: Listening on Journal Socket.
[   13.436231] systemd[1]: Starting of Arbitrary Executable File Formats File System Automount Point not supported.
[   13.525715] systemd[1]: Listening on udev Kernel Socket.
[   13.540122] systemd[1]: Reached target Remote File Systems.
[   13.554279] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[   13.569207] systemd[1]: Listening on udev Control Socket.
[   13.587771] systemd[1]: Starting udev Coldplug all Devices...
[   13.606824] systemd[1]: Listening on Journal Audit Socket.
[   13.626991] systemd[1]: Mounting Kernel Debug File System...
[   15.424946] PowerMac i2c bus pmu 2 registered
[   15.431134] PowerMac i2c bus pmu 1 registered
[   15.436983] PowerMac i2c bus mac-io 0 registered
[   15.442651] PowerMac i2c bus uni-n 1 registered
[   15.448242] PowerMac i2c bus uni-n 0 registered
[   15.879672] input: PowerMac Beep as /devices/pci0001:10/0001:10:17.0/input/input1
[   16.008274] EXT4-fs (sda3): re-mounted. Opts: acl
[   16.381033] systemd-journald[543]: Received request to flush runtime journal from PID 1
[   19.281274] genirq: Flags mismatch irq 31. 00000001 (i2sbus: i2s-a (tx)) vs. 00000001 (PMac Output)
[   19.422231] firewire_ohci 0002:20:0e.0: added OHCI v1.0 device as card 0, 8 IR + 8 IT contexts, quirks 0x0
[   19.487853] Linux agpgart interface v0.103
[   19.550217] sungem.c:v1.0 David S. Miller <davem@redhat.com>
[   19.556595] gem 0002:20:0f.0 eth0: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:03:93:48:0e:fe
[   19.566755] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   19.610255] scsi 1:0:0:0: Attached scsi generic sg1 type 5
[   19.617423] agpgart-uninorth 0000:00:0b.0: Apple UniNorth 1.5 chipset
[   19.642340] agpgart-uninorth 0000:00:0b.0: configuring for size idx: 64
[   19.665663] sd 1:0:1:0: Attached scsi generic sg2 type 0
[   19.698818] sr 1:0:0:0: [sr0] scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
[   19.704575] cdrom: Uniform CD-ROM driver Revision: 3.20
[   19.717067] agpgart-uninorth 0000:00:0b.0: AGP aperture is 256M @ 0x0
[   19.762489] sr 1:0:0:0: Attached scsi CD-ROM sr0
[   19.938493] firewire_core 0002:20:0e.0: created device fw0: GUID 000393fffe480efe, S400
[   20.294101] hidraw: raw HID events driver (C) Jiri Kosina
[   20.464381] usbcore: registered new interface driver usbhid
[   20.470456] usbhid: USB HID core driver
[   21.029892] input: Alps Electric Apple USB Keyboard as /devices/pci0001:10/0001:10:19.0/usb2/2-1/2-1.1/2-1.1:1.0/0003:05AC:0201.0001/input/input2
[   21.103209] hid-generic 0003:05AC:0201.0001: input,hidraw0: USB HID v1.00 Keyboard [Alps Electric Apple USB Keyboard] on usb-0001:10:19.0-1.1/input0
[   21.121248] input: Logitech M4848 as /devices/pci0001:10/0001:10:19.0/usb2/2-1/2-1.2/2-1.2:1.0/0003:05AC:0301.0002/input/input3
[   21.145442] hid-generic 0003:05AC:0301.0002: input,hidraw1: USB HID v1.00 Mouse [Logitech M4848] on usb-0001:10:19.0-1.2/input0
[   23.026805] Adding 848984k swap on /dev/sda4.  Priority:-2 extents:1 across:848984k 
[   33.034566] sungem_phy: PHY ID: 206053, addr: 0
[   33.555712] gem 0002:20:0f.0 eth0: Found BCM5401 PHY
[   33.561204] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   36.002364] gem 0002:20:0f.0 eth0: Link is up at 100 Mbps, full-duplex
[   36.007833] gem 0002:20:0f.0 eth0: Pause is enabled (rxfifo: 10240 off: 7168 on: 5632)
[   36.013215] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   43.522088] aty128fb 0000:00:10.0: Invalid PCI ROM header signature: expecting 0xaa55, got 0x1111


-- 
Meelis Roos (mroos@linux.ee)
