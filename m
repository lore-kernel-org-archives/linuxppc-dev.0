Return-Path: <dand1972@yahoo.com>
Received: from nm30-vm0.bullet.mail.bf1.yahoo.com
 (nm30-vm0.bullet.mail.bf1.yahoo.com [98.139.213.126])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8FD0C1A0E68
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2015 19:19:39 +1000 (AEST)
Message-ID: <1432631974.85649.YahooMailBasic@web141501.mail.bf1.yahoo.com>
Date: Tue, 26 May 2015 02:19:34 -0700
From: Dan DeVoto <dand1972@yahoo.com>
Subject: Re: [RFC] sound: ppc: keywest: check if DEQ was already instantiated
To: linuxppc-dev@lists.ozlabs.org, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, alsa-devel@alsa-project.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Mark Elliott <txlitebeer@gmail.com>, Wolfram Sang <wsa@the-dreams.de>
In-Reply-To: <1432397711-3186-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I applied this patch ("check if DEQ was already instantiated") on top of 
"sound: ppc: keywest: drop using attach adapter" and sound works great.
Everything works as expected.  Below is my dmesg output.

Regards,

Dan


On Sat, 5/23/15, Wolfram Sang <wsa@the-dreams.de> wrote:

> Due to changes in i2c-powermac, for some Macs the DEQ is instantiated
> now in i2c-powermac while some need the instantiation here in the
> keywest sound driver. The proper fix is to convert this driver to AOA.
> Until then support both ways of instantiation. Before this patch, some
> Macs lost sound because the sound driver failed when instantiating the
> DEQ for the second time.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
> 
> Dan, Mark: I hope I found a generic but not too intrusive solution to the
> doubled instantiation problem. Can you please test this patch on top of this
> one "sound: ppc: keywest: drop using attach adapter" from last time? Check if
> you have sound and send the dmesg output, please. I hope it compiles even,
> couldn't test that this time.


~$ dmesg
[    0.000000] Using PowerMac machine description
[    0.000000] Total memory = 640MB; using 2048kB for hash table (at c7e00000)
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 3.16.7-ckt9-custom4 (root@icebook) (gcc version 4.9.2 (Debian 4.9.2-10) ) #5 Mon May 25 23:52:51 PDT 2015
[    0.000000] Found initrd at 0xc1500000:0xc220b000
[    0.000000] Found UniNorth memory controller & host bridge @ 0xf8000000 revision: 0xc0
[    0.000000] Mapped at 0xff7c0000
[    0.000000] Found a Pangea mac-io controller, rev: 0, mapped at 0xff740000
[    0.000000] Processor NAP mode on idle enabled.
[    0.000000] PowerMac motherboard: iBook 2 rev. 2
[    0.000000] via-pmu: Server Mode is disabled
[    0.000000] PMU driver v2 initialized for Core99, firmware: 0c
[    0.000000] bootconsole [udbg0] enabled
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
[    0.000000] nvram: Checking bank 0...
[    0.000000] nvram: gen0=1100, gen1=1101
[    0.000000] nvram: Active bank is: 1
[    0.000000] nvram: OF partition at 0x410
[    0.000000] nvram: XP partition at 0x1020
[    0.000000] nvram: NR partition at 0x1120
[    0.000000] Top of RAM: 0x28000000, Total RAM: 0x28000000
[    0.000000] Memory hole size: 0MB
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00000000-0x27ffffff]
[    0.000000]   Normal   empty
[    0.000000]   HighMem  empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00000000-0x27ffffff]
[    0.000000] On node 0 totalpages: 163840
[    0.000000] free_area_init_node: node 0, pgdat c05ebf0c, node_mem_map c076b000
[    0.000000]   DMA zone: 1280 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 163840 pages, LIFO batch:31
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 162560
[    0.000000] Kernel command line: root=UUID=97b477c4-04c2-476e-9225-4eda6ca97833 ro nomodeset video=offb:off video=radeonfb:1024x768-32
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Sorting __ex_table...
[    0.000000] Memory: 626160K/655360K available (4252K kernel code, 320K rwdata, 1268K rodata, 292K init, 1395K bss, 29200K reserved, 0K highmem)
[    0.000000] Kernel virtual memory layout:
[    0.000000]   * 0xfffcf000..0xfffff000  : fixmap
[    0.000000]   * 0xff800000..0xffc00000  : highmem PTEs
[    0.000000]   * 0xfde72000..0xff800000  : early ioremap
[    0.000000]   * 0xe9000000..0xfde72000  : vmalloc & ioremap
[    0.000000] NR_IRQS:512 nr_irqs:512 16
[    0.000000] mpic: Resetting
[    0.000000] mpic: Setting up MPIC " MPIC 1   " version 1.2 at 80040000, max 1 CPUs
[    0.000000] mpic: ISU size: 64, shift: 6, mask: 3f
[    0.000000] mpic: Initializing for 64 sources
[    0.000000] GMT Delta read from XPRAM: -420 minutes, DST: on
[    0.000000] time_init: decrementer frequency = 24.835213 MHz
[    0.000000] time_init: processor frequency   = 700.000000 MHz
[    0.000018] clocksource: timebase mult[2843f1d2] shift[24] registered
[    0.000512] clockevent: decrementer mult[65b99bc] shift[32] cpu[0]
[    0.000827] Console: colour dummy device 80x25
[    0.001270] console [tty0] enabled
[    0.001686] bootconsole [udbg0] disabled
[    0.002484] pid_max: default: 32768 minimum: 301
[    0.002622] Security Framework initialized
[    0.002671] AppArmor: AppArmor disabled by boot time parameter
[    0.002716] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.002733] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.003965] Initializing cgroup subsys devices
[    0.004016] Initializing cgroup subsys freezer
[    0.004035] Initializing cgroup subsys net_cls
[    0.004072] Initializing cgroup subsys blkio
[    0.004100] Initializing cgroup subsys perf_event
[    0.006935] devtmpfs: initialized
[    0.008823] regulator-dummy: no parameters
[    0.009134] device-tree: Duplicate name in PowerPC,750@0, renamed to "l2-cache#1"
[    0.012932] NET: Registered protocol family 16
[    0.014428] KeyWest i2c @0xf8001003 irq 42 /uni-n@f8000000/i2c@f8001000
[    0.014455]  channel 0 bus <multibus>
[    0.014472]  channel 1 bus <multibus>
[    0.014553] KeyWest i2c @0x80018000 irq 26 /pci@f2000000/mac-io@17/i2c@18000
[    0.014580]  channel 0 bus <multibus>
[    0.014608] PMU i2c /pci@f2000000/mac-io@17/via-pmu@16000/pmu-i2c
[    0.014629]  channel 1 bus <multibus>
[    0.014644]  channel 2 bus <multibus>
[    0.015638] PCI: Probing PCI hardware
[    0.015818] PCI host bridge to bus 0000:00
[    0.015854] pci_bus 0000:00: root bus resource [io  0x802000-0x1001fff] (bus address [0x0000-0x7fffff])
[    0.015883] pci_bus 0000:00: root bus resource [mem 0xf1000000-0xf1ffffff]
[    0.015905] pci_bus 0000:00: root bus resource [mem 0x90000000-0x9fffffff]
[    0.015930] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.015955] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to ff
[    0.016018] pci 0000:00:0b.0: [106b:0027] type 00 class 0x060000
[    0.016314] pci 0000:00:10.0: [1002:4c59] type 00 class 0x030000
[    0.016343] pci 0000:00:10.0: reg 0x10: [mem 0x98000000-0x9fffffff pref]
[    0.016359] pci 0000:00:10.0: reg 0x14: [io  0x802400-0x8024ff]
[    0.016374] pci 0000:00:10.0: reg 0x18: [mem 0x90000000-0x9000ffff]
[    0.016404] pci 0000:00:10.0: reg 0x30: [mem 0x90020000-0x9003ffff pref]
[    0.016447] pci 0000:00:10.0: supports D1 D2
[    0.016658] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 00
[    0.016864] PCI host bridge to bus 0001:10
[    0.016886] pci_bus 0001:10: root bus resource [io  0x0000-0x7fffff]
[    0.016907] pci_bus 0001:10: root bus resource [mem 0xf3000000-0xf3ffffff]
[    0.016929] pci_bus 0001:10: root bus resource [mem 0x80000000-0x8fffffff]
[    0.016952] pci_bus 0001:10: root bus resource [bus 10-ff]
[    0.016973] pci_bus 0001:10: busn_res: [bus 10-ff] end is updated to ff
[    0.017017] pci 0001:10:0b.0: [106b:0028] type 00 class 0x060000
[    0.017247] pci 0001:10:17.0: [106b:0025] type 00 class 0xff0000
[    0.017268] pci 0001:10:17.0: reg 0x10: [mem 0x80000000-0x8007ffff]
[    0.017488] pci 0001:10:18.0: [106b:0026] type 00 class 0x0c0310
[    0.017512] pci 0001:10:18.0: reg 0x10: [mem 0x80081000-0x80081fff]
[    0.017576] pci 0001:10:18.0: supports D1 D2
[    0.017587] pci 0001:10:18.0: PME# supported from D1 D2 D3hot
[    0.017802] pci 0001:10:19.0: [106b:0026] type 00 class 0x0c0310
[    0.017825] pci 0001:10:19.0: reg 0x10: [mem 0x80080000-0x80080fff]
[    0.017891] pci 0001:10:19.0: supports D1 D2
[    0.017900] pci 0001:10:19.0: PME# supported from D1 D2 D3hot
[    0.018139] pci_bus 0001:10: busn_res: [bus 10-ff] end is updated to 10
[    0.018305] PCI host bridge to bus 0002:20
[    0.018330] pci_bus 0002:20: root bus resource [io  0xff7fe000-0xffffdfff] (bus address [0x0000-0x7fffff])
[    0.018359] pci_bus 0002:20: root bus resource [mem 0xf5000000-0xf5ffffff]
[    0.018381] pci_bus 0002:20: root bus resource [bus 20-ff]
[    0.018402] pci_bus 0002:20: busn_res: [bus 20-ff] end is updated to ff
[    0.018445] pci 0002:20:0b.0: [106b:0029] type 00 class 0x060000
[    0.018652] pci 0002:20:0e.0: [106b:0030] type 00 class 0x0c0010
[    0.018672] pci 0002:20:0e.0: reg 0x10: [mem 0xf5000000-0xf5000fff]
[    0.018723] pci 0002:20:0e.0: supports D1 D2
[    0.018733] pci 0002:20:0e.0: PME# supported from D0 D1 D2 D3hot
[    0.018939] pci 0002:20:0f.0: [106b:0024] type 00 class 0x020000
[    0.018958] pci 0002:20:0f.0: reg 0x10: [mem 0xf5200000-0xf53fffff]
[    0.018995] pci 0002:20:0f.0: reg 0x30: [mem 0xf5100000-0xf51fffff pref]
[    0.019207] pci_bus 0002:20: busn_res: [bus 20-ff] end is updated to 20
[    0.019281] PCI 0000:00 Cannot reserve Legacy IO [io  0x802000-0x802fff]
[    0.019303] pci_bus 0000:00: resource 4 [io  0x802000-0x1001fff]
[    0.019313] pci_bus 0000:00: resource 5 [mem 0xf1000000-0xf1ffffff]
[    0.019324] pci_bus 0000:00: resource 6 [mem 0x90000000-0x9fffffff]
[    0.019336] pci_bus 0001:10: resource 4 [io  0x0000-0x7fffff]
[    0.019346] pci_bus 0001:10: resource 5 [mem 0xf3000000-0xf3ffffff]
[    0.019356] pci_bus 0001:10: resource 6 [mem 0x80000000-0x8fffffff]
[    0.019367] pci_bus 0002:20: resource 4 [io  0xff7fe000-0xffffdfff]
[    0.019378] pci_bus 0002:20: resource 5 [mem 0xf5000000-0xf5ffffff]
[    0.025880] vgaarb: device added: PCI:0000:00:10.0,decodes=io+mem,owns=mem,locks=none
[    0.025925] vgaarb: loaded
[    0.025938] vgaarb: bridge control possible 0000:00:10.0
[    0.026346] SCSI subsystem initialized
[    0.026546] libata version 3.00 loaded.
[    0.027309] Switched to clocksource timebase
[    0.046749] NET: Registered protocol family 2
[    0.047990] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.048251] TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
[    0.048487] TCP: Hash tables configured (established 8192 bind 8192)
[    0.049009] TCP: reno registered
[    0.049030] UDP hash table entries: 512 (order: 1, 8192 bytes)
[    0.049107] UDP-Lite hash table entries: 512 (order: 1, 8192 bytes)
[    0.049425] NET: Registered protocol family 1
[    0.049595] pci 0001:10:18.0: enabling device (0000 -> 0002)
[    0.103389] pci 0001:10:19.0: enabling device (0000 -> 0002)
[    0.159337] PCI: CLS mismatch (32 != 1020), using 32 bytes
[    0.159645] Unpacking initramfs...
[    1.095053] Freeing initrd memory: 13356K (c1500000 - c220b000)
[    1.095780] Thermal assist unit using timers, shrink_timer: 500 jiffies
[    1.096917] futex hash table entries: 256 (order: -1, 3072 bytes)
[    1.097014] audit: initializing netlink subsys (disabled)
[    1.097160] audit: type=2000 audit(1432654282.092:1): initialized
[    1.098346] VFS: Disk quotas dquot_6.5.2
[    1.098428] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    1.098568] msgmni has been set to 1251
[    1.099841] alg: No test for stdrng (krng)
[    1.099960] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    1.099992] io scheduler noop registered
[    1.100012] io scheduler deadline registered
[    1.100169] io scheduler cfq registered (default)
[    1.100703] radeonfb 0000:00:10.0: enabling device (0086 -> 0087)
[    1.294616] radeonfb 0000:00:10.0: Invalid ROM contents
[    1.294645] radeonfb (0000:00:10.0): Invalid ROM signature 8080 should be 0xaa55
[    1.303347] radeonfb: Retrieved PLL infos from Open Firmware
[    1.303370] radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=166.00 Mhz, System=166.00 MHz
[    1.303392] radeonfb: PLL min 12000 max 35000
[    1.400363] i2c i2c-2: unable to read EDID block.
[    1.552349] i2c i2c-2: unable to read EDID block.
[    1.704348] i2c i2c-2: unable to read EDID block.
[    1.856348] i2c i2c-3: unable to read EDID block.
[    2.008352] i2c i2c-3: unable to read EDID block.
[    2.160348] i2c i2c-3: unable to read EDID block.
[    2.275313] radeonfb: Monitor 1 type LCD found
[    2.275328] radeonfb: EDID probed
[    2.275341] radeonfb: Monitor 2 type no found
[    2.287314] radeonfb: Using Firmware dividers 0x0001003a from PPLL 0
[    2.611312] radeonfb: Dynamic Clock Power Management enabled
[    3.067899] Console: switching to colour frame buffer device 128x48
[    3.200238] radeonfb: Backlight initialized (radeonbl0)
[    3.200853] radeonfb (0000:00:10.0): ATI Radeon 4c59 "LY"
[    3.202154] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    3.204032] pmac_zilog: 0.6 (Benjamin Herrenschmidt <benh@kernel.crashing.org>)
[    3.204943] Serial: MPC52xx PSC UART driver
[    3.205537] Generic non-volatile memory driver v1.1
[    3.206279] Linux agpgart interface v0.103
[    3.206822] agpgart-uninorth 0000:00:0b.0: Apple UniNorth/Pangea chipset
[    3.210164] agpgart-uninorth 0000:00:0b.0: configuring for size idx: 64
[    3.211089] agpgart-uninorth 0000:00:0b.0: AGP aperture is 256M @ 0x0
[    3.212160] MacIO PCI driver attached to Pangea chipset
[    3.214406] 0.00013020:ch-a: ttyPZ0 at MMIO 0x80013020 (irq = 22, base_baud = 230400) is a Z85c30 ESCC - Serial port
[    3.216111] 0.00013000:ch-b: ttyPZ1 at MMIO 0x80013000 (irq = 23, base_baud = 230400) is a Z85c30 ESCC - Serial port
[    3.218661] adb: starting probe task...
[    3.473562] adb devices: [2]: 2 c3 [3]: 3 1 [7]: 7 1f
[    3.480283] ADB keyboard at 2, handler 1
[    3.480776] Detected ADB keyboard, type ANSI.
[    3.481549] input: ADB keyboard as /devices/virtual/input/input0
[    3.482459] input: ADB Powerbook buttons as /devices/virtual/input/input1
[    3.498417] ADB mouse at 3, handler set to 4 (trackpad)
[    3.558440] input: ADB mouse as /devices/virtual/input/input2
[    3.559120] adb: finished probe task...
[    4.235335] pata-macio 0.0001f000:ata-4: Activating pata-macio chipset KeyLargo ATA-4, Apple bus ID 2
[    4.237278] scsi0 : pata_macio
[    4.259768] ata1: PATA max UDMA/66 irq 19
[    4.282443] mousedev: PS/2 mouse device common for all mice
[    4.305519] rtc-generic rtc-generic: rtc core: registered rtc-generic as rtc0
[    4.328218] Registering PowerMac CPU frequency driver
[    4.350493] Low: 400 Mhz, High: 700 Mhz, Boot: 700 Mhz
[    4.373142] drop_monitor: Initializing network drop monitor service
[    4.396273] TCP: cubic registered
[    4.419165] NET: Registered protocol family 10
[    4.442814] mip6: Mobile IPv6
[    4.465527] NET: Registered protocol family 17
[    4.488313] Key type dns_resolver registered
[    4.511641] registered taskstats version 1
[    4.534980] input: PMU as /devices/virtual/input/input3
[    4.558293] rtc-generic rtc-generic: setting system clock to 2015-05-26 08:31:25 UTC (1432629085)
[    4.582047] PM: Hibernation image not present or could not be loaded.
[    5.218743] ata1.00: ATA-5: TOSHIBA MK3018GAS, Q3.03 B, max UDMA/100
[    5.242497] ata1.00: 58605120 sectors, multi 16: LBA 
[    5.266500] ata1.01: ATAPI: SONY    CD-RW  CRX800E, 1.3p, max MWDMA2
[    5.291125] ata1.00: limited to UDMA/33 due to 40-wire cable
[    5.323797] ata1.00: configured for UDMA/33
[    5.363651] ata1.01: configured for MWDMA2
[    5.399259] scsi 0:0:0:0: Direct-Access     ATA      TOSHIBA MK3018GA 3 B  PQ: 0 ANSI: 5
[    5.427805] scsi 0:0:1:0: CD-ROM            SONY     CD-RW  CRX800E   1.3p PQ: 0 ANSI: 5
[    5.456983] Freeing unused kernel memory: 292K (c0568000 - c05b1000)
[    5.589042] systemd-udevd[52]: starting version 215
[    5.645884] random: systemd-udevd urandom read with 10 bits of entropy available
[    5.799434] sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
[    5.826206] cdrom: Uniform CD-ROM driver Revision: 3.20
[    5.857326] sungem.c:v1.0 David S. Miller <davem@redhat.com>
[    5.888329] sd 0:0:0:0: [sda] 58605120 512-byte logical blocks: (30.0 GB/27.9 GiB)
[    5.957056] usbcore: registered new interface driver usbfs
[    6.044089] sd 0:0:0:0: [sda] Write Protect is off
[    6.070911] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    6.073826] sr 0:0:1:0: Attached scsi CD-ROM sr0
[    6.081876] gem 0002:20:0f.0 eth0: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:03:93:99:74:70
[    6.112172] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    6.163525] usbcore: registered new interface driver hub
[    6.234764] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    6.269375] sr 0:0:1:0: Attached scsi generic sg1 type 5
[    6.299225] usbcore: registered new device driver usb
[    6.327509] firewire_ohci 0002:20:0e.0: added OHCI v1.0 device as card 0, 8 IR + 8 IT contexts, quirks 0x0
[    6.359250] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    6.402972] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    6.435778] ehci-pci: EHCI PCI platform driver
[    6.467479] ohci-pci: OHCI PCI platform driver
[    6.497504]  sda: [mac] sda1 sda2 sda3 sda4 sda5 sda6 sda7 sda8 sda9 sda10 sda11 sda12 sda13 sda14
[    6.527439] ohci-pci 0001:10:18.0: OHCI PCI host controller
[    6.561342] ohci-pci 0001:10:18.0: new USB bus registered, assigned bus number 1
[    6.590320] ohci-pci 0001:10:18.0: irq 27, io mem 0x80081000
[    6.690874] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
[    6.719325] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    6.747832] usb usb1: Product: OHCI PCI host controller
[    6.775962] usb usb1: Manufacturer: Linux 3.16.7-ckt9-custom4 ohci_hcd
[    6.804083] usb usb1: SerialNumber: 0001:10:18.0
[    6.836390] sd 0:0:0:0: [sda] Attached SCSI disk
[    6.864703] firewire_core 0002:20:0e.0: created device fw0: GUID 000393fffe997470, S400
[    6.895663] hub 1-0:1.0: USB hub found
[    6.941286] hub 1-0:1.0: 2 ports detected
[    6.970432] ohci-pci 0001:10:19.0: OHCI PCI host controller
[    6.999490] ohci-pci 0001:10:19.0: new USB bus registered, assigned bus number 2
[    7.028746] ohci-pci 0001:10:19.0: irq 28, io mem 0x80080000
[    7.130803] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
[    7.159799] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    7.188417] usb usb2: Product: OHCI PCI host controller
[    7.216524] usb usb2: Manufacturer: Linux 3.16.7-ckt9-custom4 ohci_hcd
[    7.244807] usb usb2: SerialNumber: 0001:10:19.0
[    7.274070] hub 2-0:1.0: USB hub found
[    7.301995] hub 2-0:1.0: 2 ports detected
[    9.278050] random: nonblocking pool is initialized
[    9.437900] PM: Starting manual resume from disk
[    9.466024] PM: Hibernation image partition 8:12 present
[    9.466030] PM: Looking for hibernation image.
[    9.484138] PM: Image not found (code -22)
[    9.484145] PM: Hibernation image not present or could not be loaded.
[   10.043383] EXT4-fs (sda13): mounted filesystem with ordered data mode. Opts: (null)
[   11.328636] systemd[1]: systemd 215 running in system mode. (+PAM +AUDIT +SELINUX +IMA +SYSVINIT +LIBCRYPTSETUP +GCRYPT +ACL +XZ -SECCOMP -APPARMOR)
[   11.386327] systemd[1]: Detected architecture 'ppc'.
[   11.901558] systemd[1]: Inserted module 'autofs4'
[   11.947070] systemd[1]: Set hostname to <icebook>.
[   14.332031] systemd[1]: Starting Forward Password Requests to Wall Directory Watch.
[   14.359820] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[   14.387139] systemd[1]: Starting Remote File Systems (Pre).
[   14.442531] systemd[1]: Reached target Remote File Systems (Pre).
[   14.469678] systemd[1]: Starting Encrypted Volumes.
[   14.523970] systemd[1]: Reached target Encrypted Volumes.
[   14.550995] systemd[1]: Starting Dispatch Password Requests to Console Directory Watch.
[   14.578595] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[   14.606144] systemd[1]: Starting Arbitrary Executable File Formats File System Automount Point.
[   14.662903] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[   14.691707] systemd[1]: Expecting device dev-disk-by\x2duuid-fdb8f9e3\x2d2abb\x2d4f68\x2d9cb4\x2d72f0c40f6585.device...
[   14.750611] systemd[1]: Expecting device dev-sda10.device...
[   14.810285] systemd[1]: Expecting device dev-sda11.device...
[   14.871165] systemd[1]: Starting Root Slice.
[   14.931020] systemd[1]: Created slice Root Slice.
[   14.960615] systemd[1]: Starting User and Session Slice.
[   15.021058] systemd[1]: Created slice User and Session Slice.
[   15.050894] systemd[1]: Starting Delayed Shutdown Socket.
[   15.111485] systemd[1]: Listening on Delayed Shutdown Socket.
[   15.141757] systemd[1]: Starting /dev/initctl Compatibility Named Pipe.
[   15.203242] systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
[   15.233664] systemd[1]: Starting Journal Socket (/dev/log).
[   15.294099] systemd[1]: Listening on Journal Socket (/dev/log).
[   15.324174] systemd[1]: Starting udev Control Socket.
[   15.383968] systemd[1]: Listening on udev Control Socket.
[   15.413310] systemd[1]: Starting udev Kernel Socket.
[   15.472461] systemd[1]: Listening on udev Kernel Socket.
[   15.501435] systemd[1]: Starting Journal Socket.
[   15.558075] systemd[1]: Listening on Journal Socket.
[   15.586272] systemd[1]: Starting System Slice.
[   15.642931] systemd[1]: Created slice System Slice.
[   15.671160] systemd[1]: Started File System Check on Root Device.
[   15.699558] systemd[1]: Starting system-getty.slice.
[   15.756320] systemd[1]: Created slice system-getty.slice.
[   15.784499] systemd[1]: Starting Increase datagram queue length...
[   15.844624] systemd[1]: Mounting Debug File System...
[   15.910863] systemd[1]: Starting Create list of required static device nodes for the current kernel...
[   15.982042] systemd[1]: Mounted Huge Pages File System.
[   16.016276] systemd[1]: Starting udev Coldplug all Devices...
[   16.195035] systemd[1]: Starting Load Kernel Modules...
[   16.322821] systemd[1]: Started Set Up Additional Binary Formats.
[   16.350340] systemd[1]: Mounting POSIX Message Queue File System...
[   16.408802] systemd[1]: Starting Slices.
[   16.486160] systemd[1]: Reached target Slices.
[   16.565115] systemd[1]: Started Create list of required static device nodes for the current kernel.
[   16.665299] systemd[1]: Starting Create Static Device Nodes in /dev...
[   16.782196] systemd[1]: Started udev Coldplug all Devices.
[   16.825486] lp: driver loaded but no devices found
[   16.928456] fuse init (API version 7.23)
[   17.153889] systemd[1]: Started Increase datagram queue length.
[   17.210814] systemd[1]: Mounted Debug File System.
[   17.267416] systemd[1]: Mounted POSIX Message Queue File System.
[   17.334588] systemd[1]: Starting Syslog Socket.
[   17.390102] systemd[1]: Listening on Syslog Socket.
[   17.417807] systemd[1]: Starting Journal Service...
[   17.508394] systemd[1]: Started Journal Service.
[   17.712676] cfg80211: Calling CRDA to update world regulatory domain
[   17.809342] orinoco 0.15 (David Gibson <hermes@gibson.dropbear.id.au>, Pavel Roskin <proski@gnu.org>, et al)
[   17.840427] airport 0.15 (Benjamin Herrenschmidt <benh@kernel.crashing.org>)
[   17.840540] airport: Physical address 80030000
[   18.187799] systemd-udevd[144]: starting version 215
[   19.044415] airport 0.00030000:radio: Hardware identity 0005:0001:0001:0002
[   19.071780] airport 0.00030000:radio: Station identity  001f:0001:0008:0046
[   19.098532] airport 0.00030000:radio: Firmware determined as Lucent/Agere 8.70
[   19.263133] airport 0.00030000:radio: firmware: direct-loading firmware agere_sta_fw.bin
[   19.377069] airport 0.00030000:radio: Hardware identity 0005:0001:0001:0002
[   19.403544] airport 0.00030000:radio: Station identity  001f:0002:0009:0030
[   19.429104] airport 0.00030000:radio: Firmware determined as Lucent/Agere 9.48
[   19.454303] airport 0.00030000:radio: Ad-hoc demo mode supported
[   19.479373] airport 0.00030000:radio: IEEE standard IBSS ad-hoc mode supported
[   19.504417] airport 0.00030000:radio: WEP supported, 104-bit key
[   19.529230] airport 0.00030000:radio: WPA-PSK supported
[   20.456095] PowerMac i2c bus pmu 2 registered
[   20.481449] PowerMac i2c bus pmu 1 registered
[   20.507471] PowerMac i2c bus mac-io 0 registered
[   20.531659] i2c i2c-6: No i2c address for /pci@f2000000/mac-io@17/i2c@18000/i2c-modem
[   20.561860] PowerMac i2c bus uni-n 1 registered
[   20.596036] i2c i2c-7: i2c-powermac: modalias failure on /uni-n@f8000000/i2c@f8001000/cereal@1c0
[   20.623810] PowerMac i2c bus uni-n 0 registered
[   21.067085] input: PowerMac Beep as /devices/pci0001:10/0001:10:17.0/input/input4
[   22.274630] [drm] Initialized drm 1.1.0 20060810
[   24.092092] [drm] VGACON disable radeon kernel modesetting.
[   24.115993] [drm:radeon_init] *ERROR* No UMS support in radeon module!
[   24.361299] EXT4-fs (sda13): re-mounted. Opts: errors=remount-ro
[   24.940172] cfg80211: World regulatory domain updated:
[   24.940188] cfg80211:  DFS Master region: unset
[   24.940189] cfg80211:   (start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp), (dfs_cac_time)
[   24.940206] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz), (N/A, 2000 mBm), (N/A)
[   24.940212] cfg80211:   (2457000 KHz - 2482000 KHz @ 40000 KHz), (N/A, 2000 mBm), (N/A)
[   24.940217] cfg80211:   (2474000 KHz - 2494000 KHz @ 20000 KHz), (N/A, 2000 mBm), (N/A)
[   24.940225] cfg80211:   (5170000 KHz - 5250000 KHz @ 80000 KHz, 160000 KHz AUTO), (N/A, 2000 mBm), (N/A)
[   24.940232] cfg80211:   (5250000 KHz - 5330000 KHz @ 80000 KHz, 160000 KHz AUTO), (N/A, 2000 mBm), (0 s)
[   24.940238] cfg80211:   (5490000 KHz - 5730000 KHz @ 160000 KHz), (N/A, 2000 mBm), (0 s)
[   24.940244] cfg80211:   (5735000 KHz - 5835000 KHz @ 80000 KHz), (N/A, 2000 mBm), (N/A)
[   24.940249] cfg80211:   (57240000 KHz - 63720000 KHz @ 2160000 KHz), (N/A, 0 mBm), (N/A)
[   27.106633] Adding 374996k swap on /dev/sda12.  Priority:-1 extents:1 across:374996k 
[   27.168400] hfsplus: Filesystem was not cleanly unmounted, running fsck.hfsplus is recommended.  mounting read-only.
[   27.262970] hfsplus: Filesystem was not cleanly unmounted, running fsck.hfsplus is recommended.  mounting read-only.
[   27.835464] systemd-journald[141]: Received request to flush runtime journal from PID 1
[   29.127671] sungem_phy: PHY ID: 4061e4, addr: 0
[   29.128024] gem 0002:20:0f.0 eth0: Found BCM5221 PHY
[   29.128322] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   31.465846] RPC: Registered named UNIX socket transport module.
[   31.468756] RPC: Registered udp transport module.
[   31.471433] RPC: Registered tcp transport module.
[   31.474051] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   31.535202] FS-Cache: Loaded
[   31.537910] gem 0002:20:0f.0 eth0: Link is up at 100 Mbps, full-duplex
[   31.540937] gem 0002:20:0f.0 eth0: Pause is disabled
[   31.545855] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   31.640991] FS-Cache: Netfs 'nfs' registered for caching
[   31.807108] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   36.063021] input: Mouseemu virtual keyboard as /devices/virtual/input/input5
[   36.079404] input: Mouseemu virtual mouse as /devices/virtual/input/input6
[   48.860034] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
