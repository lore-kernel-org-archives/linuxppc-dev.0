Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id CF628DDE11
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Dec 2008 20:07:17 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so550869yxg.39
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Dec 2008 01:07:15 -0800 (PST)
Message-ID: <fa686aa40812210107o3d12d42q2e6b0265810f7b77@mail.gmail.com>
Date: Sun, 21 Dec 2008 02:07:15 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
To: "Paul Mackerras" <paulus@samba.org>
Subject: Re: Commits added to powerpc.git next and master branches
In-Reply-To: <18765.58426.49381.986612@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <18765.58426.49381.986612@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hey Paul,

Top of your -next tree fails with a stack overflow on the MPC5200 when
attempting to mount an NFS rootfs (log below).  I haven't had a chance
to bisect yet, but I'm posting this in case someone has already seen
and solved this.

Cheers,
g.

Linux/PowerPC load: ip=192.168.0.64::192.168.0.1
nfsroot=192.168.0.200:/home/srv/nfs/gdc/efika-1,tcp rw
console=ttyPSC0,115200 libata.force=udma2
Finalizing device tree... using OF tree (promptr=01003ed8)
OF stdout device is: /failsafe
command line: ip=192.168.0.64::192.168.0.1
nfsroot=192.168.0.200:/home/srv/nfs/gdc/efika-1,tcp rw
console=ttyPSC0,115200 libata.force=udma2
memory layout at init:
  alloc_bottom : 01ba7000
  alloc_top    : 30000000
  alloc_top_hi : f000c000
  rmo_top      : 30000000
  ram_top      : f000c000
Looking for displays
instantiating rtas at 0x07ffb000 ... done
Applying EFIKA device tree fixups
Fixing bestcomm interrupts property
Adding sound interrupts property
Adding Ethernet MDIO node
Adding Ethernet PHY node
copying OF device tree ...
Building dt strings...
Building dt structure...
Device tree strings 0x01ba8000 -> 0x01ba87ae
Device tree struct  0x01ba9000 -> 0x01bac000
Calling quiesce ...
returning from prom_init
psc_console=fdfe2000
[    0.000000] Using Efika machine description
[    0.000000] Only using first contiguous memory region<5>Linux
version 2.6.28-rc8-00225-gf06f0c2 (grant@trillian) (gcc version 4.1.2)
#57 Sun Dec 21 01:59:34 MST 2008
[    0.000000] console [udbg0] enabled
[    0.000000] Efika: PCI bus 0 controlled by /pci@80000000
[    0.000000]
[    0.000000] PCI host bridge /pci@80000000  ranges:
[    0.000000]   IO 0x00000000f8000000..0x00000000f800ffff -> 0x0000000000000000
[    0.000000]  MEM 0x0000000080000000..0x00000000bfffffff ->
0x0000000080000000
[    0.000000] Top of RAM: 0x8000000, Total RAM: 0x8000000
[    0.000000] Memory hole size: 0MB
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000000 -> 0x00008000
[    0.000000]   Normal   0x00008000 -> 0x00008000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x00008000
[    0.000000] On node 0 totalpages: 32768
[    0.000000] free_area_init_node: node 0, pgdat c0379b4c,
node_mem_map c03a5000
[    0.000000]   DMA zone: 256 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 32512 pages, LIFO batch:7
[    0.000000]   Normal zone: 0 pages used for memmap
[    0.000000]   Movable zone: 0 pages used for memmap
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 32512
[    0.000000] Kernel command line: ip=192.168.0.64::192.168.0.1
nfsroot=192.168.0.200:/home/srv/nfs/gdc/efika-1,tcp rw
console=ttyPSC0,115200 libata.force=udma2
[    0.000000] MPC52xx PIC is up and running!
[    0.000000] PID hash table entries: 512 (order: 9, 2048 bytes)
[    0.000000] time_init: decrementer frequency = 33.000000 MHz
[    0.000000] time_init: processor frequency   = 396.000000 MHz
[    0.000000] clocksource: timebase mult[79364d9] shift[22] registered
[    0.000000] clockevent: decrementer mult[872] shift[16] cpu[0]
[    0.012342] Console: colour dummy device 80x25
[    0.022389] console handover: boot [udbg0] -> real [ttyPSC0]
[    0.022903] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.035946] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.061939] Memory: 125980k/131072k available (3420k kernel code,
4932k reserved, 144k data, 122k bss, 184k init)
[    0.072632] SLUB: Genslabs=12, HWalign=32, Order=0-3, MinObjects=0,
CPUs=1, Nodes=1
[    0.080527] Calibrating delay loop... 65.79 BogoMIPS (lpj=131584)
[    0.175504] Mount-cache hash table entries: 512
[    0.185228] net_namespace: 288 bytes
[    0.189594] NET: Registered protocol family 16
[    0.205009] PCI: Probing PCI hardware
[    0.209622] pci 0000:00:18.0: reg 10 io port: [0x1000-0x107f]
[    0.215597] pci 0000:00:18.0: reg 14 32bit mmio: [0x80000000-0x8000007f]
[    0.222715] pci 0000:00:18.0: reg 30 32bit mmio: [0x80020000-0x8003ffff]
[    0.229673] pci 0000:00:18.0: supports D1 D2
[    0.234086] pci 0000:00:18.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.240899] pci 0000:00:18.0: PME# disabled
[    0.246731] bus: 00 index 0 io port: [0xfdfd0000-0xfdfdffff]
[    0.252580] bus: 00 index 1 mmio: [0x80000000-0xbfffffff]
[    0.258277] DMA: MPC52xx BestComm driver
[    0.262509] DMA: MPC52xx BestComm engine @f0001200 ok !
[    0.295488] SCSI subsystem initialized
[    0.299714] libata version 3.00 loaded.
[    0.323846] Switched to high resolution mode on CPU 0
[    0.330777] NET: Registered protocol family 2
[    0.376005] IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.383536] TCP established hash table entries: 4096 (order: 3, 32768 bytes)
[    0.391093] TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
[    0.397898] TCP: Hash tables configured (established 4096 bind 4096)
[    0.404450] TCP reno registered
[    0.416069] NET: Registered protocol family 1
[    0.459008] msgmni has been set to 246
[    0.464366] alg: No test for stdrng (krng)
[    0.468759] io scheduler noop registered
[    0.472902] io scheduler anticipatory registered (default)
[    0.478563] io scheduler deadline registered
[    0.483162] io scheduler cfq registered
[    1.001144] Generic RTC Driver v1.07
[    1.005815] Serial: MPC52xx PSC UART driver
[    1.010416] f0002000.serial: ttyPSC0 at MMIO 0xf0002000 (irq = 129)
is a MPC52xx PSC
[    1.036995] brd: module loaded
[    1.048974] loop: module loaded
[    1.056105] mpc52xx MII bus: probed
[    1.061429] net eth0: Using PHY at MDIO address 16
[    1.067254] Driver 'sd' needs updating - please use bus_type methods
[    1.074314] ata: MPC52xx IDE/ATA libata driver
[    1.079598] scsi0 : mpc52xx_ata
[    1.083744] ata1: PATA max PIO4 ata_regs 0xf0003a00 irq 135
[    1.252244] ata1.00: ATA-4: TRANSCEND, 20070418, max UDMA/66
[    1.258098] ata1.00: 994896 sectors, multi 0: LBA
[    1.263139] ata1.00: FORCE: xfer_mask set to udma2
[    1.284181] ata1.00: configured for UDMA/33
[    1.289209] scsi 0:0:0:0: Direct-Access     ATA      TRANSCEND
  2007 PQ: 0 ANSI: 5
[    1.299207] sd 0:0:0:0: [sda] 994896 512-byte hardware sectors:
(509 MB/485 MiB)
[    1.307048] sd 0:0:0:0: [sda] Write Protect is off
[    1.312027] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.317653] sd 0:0:0:0: [sda] Write cache: disabled, read cache:
enabled, doesn't support DPO or FUA
[    1.327702] sd 0:0:0:0: [sda] 994896 512-byte hardware sectors:
(509 MB/485 MiB)
[    1.335536] sd 0:0:0:0: [sda] Write Protect is off
[    1.340507] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.346099] sd 0:0:0:0: [sda] Write cache: disabled, read cache:
enabled, doesn't support DPO or FUA
[    1.355506]  sda: sda1
[    1.360460] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.368173] mice: PS/2 mouse device common for all mice
[    1.374670] i2c /dev entries driver
[    1.381619] TCP cubic registered
[    1.385040] NET: Registered protocol family 17
[    1.391136] RPC: Registered udp transport module.
[    1.396025] RPC: Registered tcp transport module.
[    1.912532] net eth0: attached phy 16 to driver Generic PHY
[    2.919875] IP-Config: Guessing netmask 255.255.255.0
[    2.925414] IP-Config: Complete:
[    2.928599]      device=eth0, addr=192.168.0.64,
mask=255.255.255.0, gw=192.168.0.1,
[    2.936518]      host=192.168.0.64, domain=, nis-domain=(none),
[    2.942608]      bootserver=255.255.255.255,
rootserver=192.168.0.200, rootpath=
[    2.950769] Looking up port of RPC 100003/2 on 192.168.0.200
[    3.912011] PHY: f0003000:10 - Link is Up - 100/Full
[    4.258019] Looking up port of RPC 100005/1 on 192.168.0.200
[    9.286978] VFS: Mounted root (nfs filesystem).
[    9.291906] Freeing unused kernel memory: 184k init
[    9.315799] Kernel stack overflow in process c7828000, r1=c7825b60
[    9.322122] NIP: c0018028 LR: c0018064 CTR: 00000226
[    9.327192] REGS: c7825ab0 TRAP: 0901   Not tainted
(2.6.28-rc8-00225-gf06f0c2)
[    9.334740] MSR: 00009032 <EE,ME,IR,DR>  CR: 48002022  XER: 00000000
[    9.341245] TASK = c7828000[1] 'init' THREAD: c7826000
[    9.346309] GPR00: 00000000 c7825b60 c7828000 c78ad520 c01da000
c0000000 c0000000 00000315
[    9.354853] GPR08: 00356795 c0380000 c7a24000 00000001 c7826000
[    9.361197] NIP [c0018028] _tlbia+0x14/0x20
[    9.365470] LR [c0018064] tlb_flush+0x30/0x40
[    9.369911] Call Trace:
[    9.372399] Instruction dump:
[    9.375424] 4185ffe4 7d400124 4c00012c 4e800020 7c001a64 7c0004ac
4e800020 7c0004ac
[    9.383344] 38800400 7c8903a6 3c80c000 7c002264 <38841000> 4200fff8
7c0004ac 9421fff0
[    9.391445] Kernel panic - not syncing: kernel stack overflow
[    9.397309] Rebooting in 180 seconds..


On Sat, Dec 20, 2008 at 11:37 PM, Paul Mackerras <paulus@samba.org> wrote:
> Anton Vorontsov (3):
>      of: Minor simplification for the of_parse_phandles_with_args()
>      of: of_parse_phandles_with_args() learns to differentiate 'hole' cells
>      of/gpio: Implement of_gpio_count()
>
> Benjamin Herrenschmidt (10):
>      powerpc/4xx: Extended DCR support v2
>      powerpc/mm: Split mmu_context handling
>      powerpc/mm: Rework context management for CPUs with no hash table
>      powerpc/mm: Introduce MMU features
>      powerpc/mm: Add SMP support to no-hash TLB handling
>      powerpc/mm: Split low level tlb invalidate for nohash processors
>      powerpc/44x: No need to mask MSR:CE, ME or DE in _tlbil_va on 440
>      powerpc/mm: Runtime allocation of mmu context maps for nohash CPUs
>      powerpc/mm: Rework usage of _PAGE_COHERENT/NO_CACHE/GUARDED
>      powerpc/44x: 44x TLB doesn't need "Guarded" set for all pages
>
> Brian King (2):
>      powerpc: Disable Collaborative Memory Manager for kdump
>      powerpc: Add reboot notifier to Collaborative Memory Manager
>
> David Howells (1):
>      powerpc: Rename struct vm_region to avoid conflict with NOMMU
>
> Grant Erickson (1):
>      powerpc: Const-qualify Device Node Argument to DCR Resource Extent API
>
> Hendrik Brueckner (1):
>      hvc_console: Escape magic sysrq key
>
> Nathan Lynch (3):
>      powerpc: Add of_find_next_cache_node()
>      powerpc: Convert cpu_to_l2cache() to of_find_next_cache_node()
>      powerpc: Convert sysfs cache code to of_find_next_cache_node()
>
> Scott Wood (1):
>      powerpc/bootwrapper: Use the child-bus #address-cells to decide which range entry to use
>
> Stephen Rothwell (1):
>      powerpc/iseries: viodasd needs to depend on CONFIG_BLOCK
>
> Tony Breeds (2):
>      powerpc: Protect against NULL pointer deref in phyp-dump code
>      powerpc: Pass a valid token to rtas_call() in phyp-dump code
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
