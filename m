Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcJc146jczDqYw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 04:14:25 +1000 (AEST)
Date: Wed, 23 Aug 2017 04:14:24 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ppc-dev
 <linuxppc-dev@lists.ozlabs.org>, "Paul E. McKenney"
 <paulmck@linux.vnet.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: linux-next: Tree for Aug 22
Message-ID: <20170823041424.1dddeb2d@canb.auug.org.au>
In-Reply-To: <20170823041117.780097f7@canb.auug.org.au>
References: <20170822183816.7925e0f8@canb.auug.org.au>
 <20170823041117.780097f7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/m80B16CMtXc8etMUFlAKluv"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--MP_/m80B16CMtXc8etMUFlAKluv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

On Wed, 23 Aug 2017 04:11:17 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> This tree fails to boot on my qemu test.  2 boot logs attached.
> 
> Paul, Nick, is this the same/similar to the other RCU/lockup bug you
> are chasing.  This is the first time I have seen this failure.
> 
> This qemu boot is in full emulation mode if I add --enable-kvm to the
> qemu command, it does not fail to boot.  (the test just boots and then shuts down)

Boot logs attached this time.
-- 
Cheers,
Stephen Rothwell

--MP_/m80B16CMtXc8etMUFlAKluv
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename=bad-log-1

spawn qemu-system-ppc64 -M pseries -m 2G -vga none -nographic -kernel /home/sfr/next/powerpc_pseries_le_defconfig/vmlinux -initrd ./ppc64le-rootfs.cpio.gz


SLOF[0m[?25l **********************************************************************
[1mQEMU Starting
[0m Build Date = Jan  3 2017 22:22:01
 FW Version = buildd@ release 20161019
 Press "s" to enter Open Firmware.

[0m[?25hC0000
C0100
C0120
C0140
C0200
C0201
C0220
C0240
C0260
C02E0
C0300
C0320
C0340
C0360
C0370
C0380
C0371
C0372
C0373
C0374
C03F0
C0400
C0480
C04C0
C04D0
C0500
Populating /vdevice methods
Populating /vdevice/vty@71000000
Populating /vdevice/nvram@71000001
Populating /vdevice/l-lan@71000002
Populating /vdevice/v-scsi@71000003
       SCSI: Looking for devices
          8200000000000000 CD-ROM   : "QEMU     QEMU CD-ROM      2.5+"
C0580
C05A0
Populating /pci@800000020000000
C0600
C0640
C0690
C06A0
C06A8
C06B0
C06B8
C06C0
C06E0
C0700
C0800
C0880
No NVRAM common partition, re-initializing...
C0890
C08A0
C08A8
C08B0
Scanning USB 
C08C0
C08D0
Using default console: /vdevice/vty@71000000
C08E0
C08E8
Detected RAM kernel at 400000 (1071618 bytes) C08FF
     
  Welcome to Open Firmware

  Copyright (c) 2004, 2011 IBM Corporation All rights reserved.
  This program and the accompanying materials are made available
  under the terms of the BSD License available at
  http://www.opensource.org/licenses/bsd-license.php

Booting from memory...
OF stdout device is: /vdevice/vty@71000000
Preparing to boot Linux version 4.13.0-rc6 (sfr@colugo-sfr) (gcc version 5.2.1 20151008 (GCC)) #2 SMP Tue Aug 22 18:19:21 AEST 2017
Detected machine type: 0000000000000101
command line: 
Max number of cores passed to firmware: 2048 (NR_CPUS = 2048)
Calling ibm,client-architecture-support... done
memory layout at init:
  memory_limit : 0000000000000000 (16 MB aligned)
  alloc_bottom : 0000000001490000
  alloc_top    : 0000000030000000
  alloc_top_hi : 0000000080000000
  rmo_top      : 0000000030000000
  ram_top      : 0000000080000000
instantiating rtas at 0x000000002fff0000... done
prom_hold_cpus: skipped
copying OF device tree...
Building dt strings...
Building dt structure...
Device tree strings 0x00000000016a0000 -> 0x00000000016a09df
Device tree struct  0x00000000016b0000 -> 0x00000000016c0000
Quiescing Open Firmware ...
Booting Linux via __start() @ 0x0000000000400000 ...
Page sizes from device-tree:
base_shift=12: shift=12, sllp=0x0000, avpnm=0x00000000, tlbiel=1, penc=0
base_shift=12: shift=16, sllp=0x0000, avpnm=0x00000000, tlbiel=1, penc=7
base_shift=12: shift=24, sllp=0x0000, avpnm=0x00000000, tlbiel=1, penc=56
base_shift=16: shift=16, sllp=0x0110, avpnm=0x00000000, tlbiel=1, penc=1
base_shift=16: shift=24, sllp=0x0110, avpnm=0x00000000, tlbiel=1, penc=8
base_shift=24: shift=24, sllp=0x0100, avpnm=0x00000001, tlbiel=0, penc=0
base_shift=34: shift=34, sllp=0x0120, avpnm=0x000007ff, tlbiel=0, penc=3
Using 1TB segments
Initializing hash mmu with SLB
Linux version 4.13.0-rc6 (sfr@colugo-sfr) (gcc version 5.2.1 20151008 (GCC)) #2 SMP Tue Aug 22 18:19:21 AEST 2017
Found initrd at 0xc000000001490000:0xc00000000165d70b
Using pSeries machine description
bootconsole [udbg0] enabled
Partition configured for 1 cpus.
CPU maps initialized for 1 thread per core
 -> smp_release_cpus()
spinning_secondaries = 0
 <- smp_release_cpus()
-----------------------------------------------------
ppc64_pft_size    = 0x18
phys_mem_size     = 0x80000000
dcache_bsize      = 0x80
icache_bsize      = 0x80
cpu_features      = 0x077c7a6c18500249
  possible        = 0x5fffffff18500649
  always          = 0x0000000018100040
cpu_user_features = 0xdc0065c2 0xae000000
mmu_features      = 0x7c006001
firmware_features = 0x00000001405a445f
htab_hash_mask    = 0x1ffff
-----------------------------------------------------
numa:   NODE_DATA [mem 0x7ffe2300-0x7ffebfff]
PCI host bridge /pci@800000020000000  ranges:
  IO 0x0000200000000000..0x000020000000ffff -> 0x0000000000000000
 MEM 0x0000200080000000..0x00002000ffffffff -> 0x0000000080000000 
 MEM 0x0000210000000000..0x000021ffffffffff -> 0x0000210000000000 
PPC64 nvram contains 65536 bytes
Zone ranges:
  DMA      [mem 0x0000000000000000-0x000000007fffffff]
  DMA32    empty
  Normal   empty
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000000000000-0x000000007fffffff]
Initmem setup node 0 [mem 0x0000000000000000-0x000000007fffffff]
percpu: Embedded 3 pages/cpu @c00000007fe00000 s158616 r0 d37992 u1048576
Built 1 zonelists, mobility grouping on.  Total pages: 32736
Policy zone: DMA
Kernel command line: 
PID hash table entries: 4096 (order: -1, 32768 bytes)
Memory: 2060800K/2097152K available (10112K kernel code, 1600K rwdata, 2752K rodata, 896K init, 1413K bss, 36352K reserved, 0K cma-reserved)
SLUB: HWalign=128, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
Hierarchical RCU implementation.
	RCU event tracing is enabled.
	RCU restricting CPUs from NR_CPUS=2048 to nr_cpu_ids=1.
RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
NR_IRQS: 512, nr_irqs: 512, preallocated irqs: 16
clocksource: timebase: mask: 0xffffffffffffffff max_cycles: 0x761537d007, max_idle_ns: 440795202126 ns
clocksource: timebase mult[1f40000] shift[24] registered
Console: colour dummy device 80x25
console [hvc0] enabled
console [hvc0] enabled
bootconsole [udbg0] disabled
bootconsole [udbg0] disabled
pid_max: default: 32768 minimum: 301
Dentry cache hash table entries: 262144 (order: 5, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 4, 1048576 bytes)
Mount-cache hash table entries: 8192 (order: 0, 65536 bytes)
Mountpoint-cache hash table entries: 8192 (order: 0, 65536 bytes)
EEH: pSeries platform initialized
POWER8 performance monitor hardware support registered
Hierarchical SRCU implementation.
smp: Bringing up secondary CPUs ...
smp: Brought up 1 node, 1 CPU
numa: Node 0 CPUs: 0
devtmpfs: initialized
random: get_random_u32 called from bucket_table_alloc+0x144/0x380 with crng_init=0
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
futex hash table entries: 256 (order: -1, 32768 bytes)
NET: Registered protocol family 16
EEH: No capable adapters found
cpuidle: using governor menu
kworker/u2:1 (27) used greatest stack depth: 13872 bytes left
kworker/u2:1 (28) used greatest stack depth: 13584 bytes left
random: fast init done
kworker/u2:0 (17) used greatest stack depth: 12352 bytes left
pstore: using zlib compression
pstore: Registered nvram as persistent store backend

Linux ppc64le
#2 SMP Tue Aug 2PCI: Probing PCI hardware
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x10000-0x1ffff] (bus address [0x0000-0xffff])
pci_bus 0000:00: root bus resource [mem 0x200080000000-0x2000ffffffff] (bus address [0x80000000-0xffffffff])
pci_bus 0000:00: root bus resource [mem 0x210000000000-0x21ffffffffff]
pci_bus 0000:00: root bus resource [bus 00-ff]
IOMMU table initialized, virtual merging enabled
HugeTLB registered 16.0 MiB page size, pre-allocated 0 pages
HugeTLB registered 16.0 GiB page size, pre-allocated 0 pages
vgaarb: loaded
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
PTP clock support registered
clocksource: Switched to clocksource timebase
NET: Registered protocol family 2
TCP established hash table entries: 16384 (order: 1, 131072 bytes)
TCP bind hash table entries: 16384 (order: 2, 262144 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
UDP hash table entries: 2048 (order: 0, 65536 bytes)
UDP-Lite hash table entries: 2048 (order: 0, 65536 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
Trying to unpack rootfs image as initramfs...
Freeing initrd memory: 1792K
audit: initializing netlink subsys (disabled)
audit: type=2000 audit(1503390342.630:1): state=initialized audit_enabled=0 res=1
workingset: timestamp_bits=38 max_order=15 bucket_order=0
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
io scheduler mq-deadline registered
io scheduler kyber registered
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
brd: module loaded
loop: module loaded
ipr: IBM Power RAID SCSI Device Driver version: 2.6.4 (March 14, 2017)
ibmvscsi 71000003: SRP_VERSION: 16.a
ibmvscsi 71000003: Maximum ID: 64 Maximum LUN: 32 Maximum Channel: 3
scsi host0: IBM POWER Virtual SCSI Adapter 1.5.9
ibmvscsi 71000003: partner initialization complete
ibmvscsi 71000003: host srp version: 16.a, host partition qemu (0), OS 2, max io 2097152
ibmvscsi 71000003: sent SRP login
ibmvscsi 71000003: SRP_LOGIN succeeded
scsi 0:0:2:0: CD-ROM            QEMU     QEMU CD-ROM      2.5+ PQ: 0 ANSI: 5
sr 0:0:2:0: [sr0] scsi3-mmc drive: 16x/50x cd/rw xa/form2 cdda tray
cdrom: Uniform CD-ROM driver Revision: 3.20
sr 0:0:2:0: Attached scsi generic sg0 type 5
libphy: Fixed MDIO Bus: probed
e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
e100: Copyright(c) 1999-2006 Intel Corporation
e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
e1000: Copyright (c) 1999-2006 Intel Corporation.
e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-pci: EHCI PCI platform driver
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ohci-pci: OHCI PCI platform driver
rtc-generic rtc-generic: rtc core: registered rtc-generic as rtc0
IR NEC protocol handler initialized
IR RC5(x/sz) protocol handler initialized
IR RC6 protocol handler initialized
IR JVC protocol handler initialized
IR Sony protocol handler initialized
IR SANYO protocol handler initialized
IR Sharp protocol handler initialized
IR MCE Keyboard/mouse protocol handler initialized
IR XMP protocol handler initialized
device-mapper: uevent: version 1.0.3
device-mapper: ioctl: 4.36.0-ioctl (2017-06-09) initialised: dm-devel@redhat.com
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
ipip: IPv4 and MPLS over IPv4 tunneling driver
NET: Registered protocol family 17
Key type dns_resolver registered
registered taskstats version 1
console [netcon0] enabled
netconsole: network logging started
rtc-generic rtc-generic: setting system clock to 2017-08-22 08:25:43 UTC (1503390343)
Freeing unused kernel memory: 896K
This architecture does not have kernel memory protection.
INFO: rcu_sched self-detected stall on CPU
	0-...: (2100 ticks this GP) idle=026/140000000000001/0 softirq=1069/1069 fqs=0 
	 (t=2100 jiffies g=-66 c=-67 q=17)
rcu_sched kthread starved for 2100 jiffies! g18446744073709551550 c18446744073709551549 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x0 ->cpu=0
rcu_sched       R  running task    14192     8      2 0x00000800
Call Trace:
[c00000007e65f8d0] [c00000007e65f900] 0xc00000007e65f900 (unreliable)
[c00000007e65faa0] [c00000000001b678] __switch_to+0x298/0x460
[c00000007e65fb00] [c0000000009d5524] __schedule+0x3e4/0xab0
[c00000007e65fbe0] [c0000000009d5c30] schedule+0x40/0xb0
[c00000007e65fc10] [c0000000009da4bc] schedule_timeout+0x1fc/0x440
[c00000007e65fcf0] [c0000000001754ac] rcu_gp_kthread+0x60c/0x1090
[c00000007e65fdc0] [c000000000112a10] kthread+0x160/0x1a0
[c00000007e65fe30] [c00000000000bae0] ret_from_kernel_thread+0x5c/0x7c
NMI backtrace for cpu 0
CPU: 0 PID: 7 Comm: ksoftirqd/0 Not tainted 4.13.0-rc6 #2
Call Trace:
[c00000007e65b0e0] [c0000000009bbfa0] dump_stack+0xb0/0xf0 (unreliable)
[c00000007e65b120] [c0000000009c4cb8] nmi_cpu_backtrace+0x208/0x210
[c00000007e65b1b0] [c0000000009c4ea0] nmi_trigger_cpumask_backtrace+0x1e0/0x220
[c00000007e65b240] [c00000000002d100] arch_trigger_cpumask_backtrace+0x20/0x40
[c00000007e65b260] [c000000000177d00] rcu_dump_cpu_stacks+0xf4/0x164
[c00000007e65b2b0] [c000000000177174] rcu_check_callbacks+0x994/0xaf0
[c00000007e65b3e0] [c00000000017f34c] update_process_times+0x3c/0x90
[c00000007e65b410] [c000000000195c0c] tick_sched_handle.isra.5+0x2c/0xc0
[c00000007e65b440] [c000000000195cf8] tick_sched_timer+0x58/0xd0
[c00000007e65b480] [c00000000017fdc8] __hrtimer_run_queues+0xf8/0x360
[c00000007e65b500] [c000000000180d24] hrtimer_interrupt+0xf4/0x340
[c00000007e65b5d0] [c0000000000231dc] __timer_interrupt+0x8c/0x270
[c00000007e65b620] [c0000000000238c0] timer_interrupt+0xa0/0xe0
[c00000007e65b650] [c0000000000091c0] decrementer_common+0x150/0x160
--- interrupt: 901 at .L142+0x0/0x4
    LR = arch_local_irq_restore+0x74/0x90
[c00000007e65b940] [fed0895fbd054278] 0xfed0895fbd054278 (unreliable)
[c00000007e65b960] [c00000000002c688] wd_smp_clear_cpu_pending+0x168/0x380
[c00000007e65b9f0] [c00000000002d188] watchdog_timer_interrupt+0x68/0x370
[c00000007e65ba90] [c00000000002d528] wd_timer_fn+0x38/0x60
[c00000007e65bac0] [c00000000017de28] call_timer_fn+0x58/0x1c0
[c00000007e65bb50] [c00000000017e100] expire_timers+0x140/0x1e0
[c00000007e65bbc0] [c00000000017e268] run_timer_softirq+0xc8/0x230
[c00000007e65bc50] [c0000000009dc7f0] __do_softirq+0x170/0x3e4
[c00000007e65bd40] [c0000000000eef9c] run_ksoftirqd+0x3c/0xb0
[c00000007e65bd60] [c000000000118500] smpboot_thread_fn+0x290/0x2a0
[c00000007e65bdc0] [c000000000112a10] kthread+0x160/0x1a0
[c00000007e65be30] [c00000000000bae0] ret_from_kernel_thread+0x5c/0x7c
watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [ksoftirqd/0:7]
Modules linked in:
CPU: 0 PID: 7 Comm: ksoftirqd/0 Not tainted 4.13.0-rc6 #2
task: c00000007e62e100 task.stack: c00000007e658000
NIP: c00000000000ad4c LR: c000000000015ae4 CTR: c00000000002d4f0
REGS: c00000007e65b6c0 TRAP: 0901   Not tainted  (4.13.0-rc6)
MSR: 8000000002009033 <SF,VEC,EE,ME,IR,DR,RI,LE>
  CR: 24000244  XER: 20000000
CFAR: c000000000334910 SOFTE: 1 
GPR00: c00000000002c688 c00000007e65b940 c000000000ea5a00 0000000000000900 
GPR04: 0000000000000001 000000007f0b0000 000000055f52d5ae 0000000000000000 
GPR08: c00000000fd40000 0000000000400000 0000000000400000 0000000000000000 
GPR12: 0000000028000222 c00000000fd40000 
NIP [c00000000000ad4c] .L142+0x0/0x4
LR [c000000000015ae4] arch_local_irq_restore+0x74/0x90
Call Trace:
[c00000007e65b940] [98a11310c2925282] 0x98a11310c2925282 (unreliable)
[c00000007e65b960] [c00000000002c688] wd_smp_clear_cpu_pending+0x168/0x380
[c00000007e65b9f0] [c00000000002d188] watchdog_timer_interrupt+0x68/0x370
[c00000007e65ba90] [c00000000002d528] wd_timer_fn+0x38/0x60
[c00000007e65bac0] [c00000000017de28] call_timer_fn+0x58/0x1c0
[c00000007e65bb50] [c00000000017e100] expire_timers+0x140/0x1e0
[c00000007e65bbc0] [c00000000017e268] run_timer_softirq+0xc8/0x230
[c00000007e65bc50] [c0000000009dc7f0] __do_softirq+0x170/0x3e4
[c00000007e65bd40] [c0000000000eef9c] run_ksoftirqd+0x3c/0xb0
[c00000007e65bd60] [c000000000118500] smpboot_thread_fn+0x290/0x2a0
[c00000007e65bdc0] [c000000000112a10] kthread+0x160/0x1a0
[c00000007e65be30] [c00000000000bae0] ret_from_kernel_thread+0x5c/0x7c
Instruction dump:
7d200026 618c8000 2c030900 4182e348 2c030500 4182dda0 2c030a00 4182ffc0 
60000000 60000000 60000000 60000000 <4e800020> 7c781b78 48000331 48000349 
timeout waiting for login

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 BAD BAD BAD BAD BAD BAD BAD BAD BAD BAD 
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

--MP_/m80B16CMtXc8etMUFlAKluv
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename=bad-log-2

spawn qemu-system-ppc64 -M pseries -m 2G -vga none -nographic -kernel /home/sfr/next/powerpc_pseries_le_defconfig/vmlinux -initrd ./ppc64le-rootfs.cpio.gz


SLOF[0m[?25l **********************************************************************
[1mQEMU Starting
[0m Build Date = Jan  3 2017 22:22:01
 FW Version = buildd@ release 20161019
 Press "s" to enter Open Firmware.

[0m[?25hC0000
C0100
C0120
C0140
C0200
C0201
C0220
C0240
C0260
C02E0
C0300
C0320
C0340
C0360
C0370
C0380
C0371
C0372
C0373
C0374
C03F0
C0400
C0480
C04C0
C04D0
C0500
Populating /vdevice methods
Populating /vdevice/vty@71000000
Populating /vdevice/nvram@71000001
Populating /vdevice/l-lan@71000002
Populating /vdevice/v-scsi@71000003
       SCSI: Looking for devices
          8200000000000000 CD-ROM   : "QEMU     QEMU CD-ROM      2.5+"
C0580
C05A0
Populating /pci@800000020000000
C0600
C0640
C0690
C06A0
C06A8
C06B0
C06B8
C06C0
C06E0
C0700
C0800
C0880
No NVRAM common partition, re-initializing...
C0890
C08A0
C08A8
C08B0
Scanning USB 
C08C0
C08D0
Using default console: /vdevice/vty@71000000
C08E0
C08E8
Detected RAM kernel at 400000 (1071618 bytes) C08FF
     
  Welcome to Open Firmware

  Copyright (c) 2004, 2011 IBM Corporation All rights reserved.
  This program and the accompanying materials are made available
  under the terms of the BSD License available at
  http://www.opensource.org/licenses/bsd-license.php

Booting from memory...
OF stdout device is: /vdevice/vty@71000000
Preparing to boot Linux version 4.13.0-rc6 (sfr@colugo-sfr) (gcc version 5.2.1 20151008 (GCC)) #2 SMP Tue Aug 22 18:19:21 AEST 2017
Detected machine type: 0000000000000101
command line: 
Max number of cores passed to firmware: 2048 (NR_CPUS = 2048)
Calling ibm,client-architecture-support... done
memory layout at init:
  memory_limit : 0000000000000000 (16 MB aligned)
  alloc_bottom : 0000000001490000
  alloc_top    : 0000000030000000
  alloc_top_hi : 0000000080000000
  rmo_top      : 0000000030000000
  ram_top      : 0000000080000000
instantiating rtas at 0x000000002fff0000... done
prom_hold_cpus: skipped
copying OF device tree...
Building dt strings...
Building dt structure...
Device tree strings 0x00000000016a0000 -> 0x00000000016a09df
Device tree struct  0x00000000016b0000 -> 0x00000000016c0000
Quiescing Open Firmware ...
Booting Linux via __start() @ 0x0000000000400000 ...
Page sizes from device-tree:
base_shift=12: shift=12, sllp=0x0000, avpnm=0x00000000, tlbiel=1, penc=0
base_shift=12: shift=16, sllp=0x0000, avpnm=0x00000000, tlbiel=1, penc=7
base_shift=12: shift=24, sllp=0x0000, avpnm=0x00000000, tlbiel=1, penc=56
base_shift=16: shift=16, sllp=0x0110, avpnm=0x00000000, tlbiel=1, penc=1
base_shift=16: shift=24, sllp=0x0110, avpnm=0x00000000, tlbiel=1, penc=8
base_shift=24: shift=24, sllp=0x0100, avpnm=0x00000001, tlbiel=0, penc=0
base_shift=34: shift=34, sllp=0x0120, avpnm=0x000007ff, tlbiel=0, penc=3
Using 1TB segments
Initializing hash mmu with SLB
Linux version 4.13.0-rc6 (sfr@colugo-sfr) (gcc version 5.2.1 20151008 (GCC)) #2 SMP Tue Aug 22 18:19:21 AEST 2017
Found initrd at 0xc000000001490000:0xc00000000165d70b
Using pSeries machine description
bootconsole [udbg0] enabled
Partition configured for 1 cpus.
CPU maps initialized for 1 thread per core
 -> smp_release_cpus()
spinning_secondaries = 0
 <- smp_release_cpus()
-----------------------------------------------------
ppc64_pft_size    = 0x18
phys_mem_size     = 0x80000000
dcache_bsize      = 0x80
icache_bsize      = 0x80
cpu_features      = 0x077c7a6c18500249
  possible        = 0x5fffffff18500649
  always          = 0x0000000018100040
cpu_user_features = 0xdc0065c2 0xae000000
mmu_features      = 0x7c006001
firmware_features = 0x00000001405a445f
htab_hash_mask    = 0x1ffff
-----------------------------------------------------
numa:   NODE_DATA [mem 0x7ffe2300-0x7ffebfff]
PCI host bridge /pci@800000020000000  ranges:
  IO 0x0000200000000000..0x000020000000ffff -> 0x0000000000000000
 MEM 0x0000200080000000..0x00002000ffffffff -> 0x0000000080000000 
 MEM 0x0000210000000000..0x000021ffffffffff -> 0x0000210000000000 
PPC64 nvram contains 65536 bytes
Zone ranges:
  DMA      [mem 0x0000000000000000-0x000000007fffffff]
  DMA32    empty
  Normal   empty
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000000000000-0x000000007fffffff]
Initmem setup node 0 [mem 0x0000000000000000-0x000000007fffffff]
percpu: Embedded 3 pages/cpu @c00000007fe00000 s158616 r0 d37992 u1048576
Built 1 zonelists, mobility grouping on.  Total pages: 32736
Policy zone: DMA
Kernel command line: 
PID hash table entries: 4096 (order: -1, 32768 bytes)
Memory: 2060800K/2097152K available (10112K kernel code, 1600K rwdata, 2752K rodata, 896K init, 1413K bss, 36352K reserved, 0K cma-reserved)
SLUB: HWalign=128, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
Hierarchical RCU implementation.
	RCU event tracing is enabled.
	RCU restricting CPUs from NR_CPUS=2048 to nr_cpu_ids=1.
RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
NR_IRQS: 512, nr_irqs: 512, preallocated irqs: 16
clocksource: timebase: mask: 0xffffffffffffffff max_cycles: 0x761537d007, max_idle_ns: 440795202126 ns
clocksource: timebase mult[1f40000] shift[24] registered
Console: colour dummy device 80x25
console [hvc0] enabled
console [hvc0] enabled
bootconsole [udbg0] disabled
bootconsole [udbg0] disabled
pid_max: default: 32768 minimum: 301
Dentry cache hash table entries: 262144 (order: 5, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 4, 1048576 bytes)
Mount-cache hash table entries: 8192 (order: 0, 65536 bytes)
Mountpoint-cache hash table entries: 8192 (order: 0, 65536 bytes)
EEH: pSeries platform initialized
POWER8 performance monitor hardware support registered
Hierarchical SRCU implementation.
smp: Bringing up secondary CPUs ...
smp: Brought up 1 node, 1 CPU
numa: Node 0 CPUs: 0
devtmpfs: initialized
random: get_random_u32 called from bucket_table_alloc+0x144/0x380 with crng_init=0
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
futex hash table entries: 256 (order: -1, 32768 bytes)
NET: Registered protocol family 16
EEH: No capable adapters found
cpuidle: using governor menu
kworker/u2:1 (27) used greatest stack depth: 13872 bytes left
kworker/u2:1 (28) used greatest stack depth: 13584 bytes left
random: fast init done
kworker/u2:0 (17) used greatest stack depth: 12192 bytes left
pstore: using zlib compression
pstore: Registered nvram as persistent store backend

Linux ppc64le
#2 SMP Tue Aug 2PCI: Probing PCI hardware
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x10000-0x1ffff] (bus address [0x0000-0xffff])
pci_bus 0000:00: root bus resource [mem 0x200080000000-0x2000ffffffff] (bus address [0x80000000-0xffffffff])
pci_bus 0000:00: root bus resource [mem 0x210000000000-0x21ffffffffff]
pci_bus 0000:00: root bus resource [bus 00-ff]
IOMMU table initialized, virtual merging enabled
HugeTLB registered 16.0 MiB page size, pre-allocated 0 pages
HugeTLB registered 16.0 GiB page size, pre-allocated 0 pages
vgaarb: loaded
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
PTP clock support registered
clocksource: Switched to clocksource timebase
Watchdog CPU:0 Hard LOCKUP
Modules linked in:
CPU: 0 PID: 7 Comm: ksoftirqd/0 Not tainted 4.13.0-rc6 #2
task: c00000007e62e100 task.stack: c00000007e658000
NIP: c00000000017bb68 LR: c00000000017bb68 CTR: c000000000106330
REGS: c00000003ffefd80 TRAP: 0900   Not tainted  (4.13.0-rc6)
MSR: 8000000002009033 <SF,VEC,EE,ME,IR,DR,RI,LE>
  CR: 24000802  XER: 00000000
CFAR: c0000000009dbc34 SOFTE: 0 
GPR00: c00000000017bb68 c00000007e65b9b0 c000000000ea5a00 0000000000000000 
GPR04: c00000007e65ba30 c00000007e160000 8000000000000000 c00000007e65bbe8 
GPR08: 0000000000000004 0000000000000000 0000000080000000 c00000007fe0fea8 
GPR12: c000000000106330 c00000000fd40000 c0000000001128b8 c00000007e150180 
GPR16: 0000000000000100 0000000004208040 c00000007e658000 0000000000000000 
GPR20: c000000000d74f00 c000000000ed3b00 00000000ffff8af5 000000000000000a 
GPR24: c000000000d74f00 c000000000d5fe80 c000000000eddbf8 c00000007e65ba30 
GPR28: c000000000d5ee00 c00000007e160048 c00000007fe0fe80 000000007fc80000 
NIP [c00000000017bb68] lock_timer_base+0x98/0xf0
LR [c00000000017bb68] lock_timer_base+0x98/0xf0
Call Trace:
[c00000007e65b9b0] [c00000000017bb68] lock_timer_base+0x98/0xf0 (unreliable)
[c00000007e65ba10] [c00000000017ed9c] mod_timer+0x2fc/0x350
[c00000007e65ba80] [c000000000106468] idle_worker_timeout+0x138/0x190
[c00000007e65bac0] [c00000000017de28] call_timer_fn+0x58/0x1c0
[c00000007e65bb50] [c00000000017e100] expire_timers+0x140/0x1e0
[c00000007e65bbc0] [c00000000017e348] run_timer_softirq+0x1a8/0x230
[c00000007e65bc50] [c0000000009dc7f0] __do_softirq+0x170/0x3e4
[c00000007e65bd40] [c0000000000eef9c] run_ksoftirqd+0x3c/0xb0
[c00000007e65bd60] [c000000000118500] smpboot_thread_fn+0x290/0x2a0
[c00000007e65bdc0] [c000000000112a10] kthread+0x160/0x1a0
[c00000007e65be30] [c00000000000bae0] ret_from_kernel_thread+0x5c/0x7c
Instruction dump:
7be91ae8 4082ffec 7d5a482a 7be96fe3 7fdc5214 893e0025 2f890000 419e000c 
41820008 7fcaca14 7fc3f378 48860065 <60000000> f87b0000 7c641b78 7fc3f378 
INFO: rcu_sched self-detected stall on CPU
	0-...: (2100 ticks this GP) idle=002/140000000000001/0 softirq=183/183 fqs=0 
	 (t=2100 jiffies g=-278 c=-279 q=136)
rcu_sched kthread starved for 2100 jiffies! g18446744073709551338 c18446744073709551337 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x0 ->cpu=0
rcu_sched       R  running task    13216     8      2 0x00000800
Call Trace:
[c00000007e65f8d0] [c00000007e65fbd0] 0xc00000007e65fbd0 (unreliable)
[c00000007e65faa0] [c00000000001b678] __switch_to+0x298/0x460
[c00000007e65fb00] [c0000000009d5524] __schedule+0x3e4/0xab0
[c00000007e65fbe0] [c0000000009d5c30] schedule+0x40/0xb0
[c00000007e65fc10] [c0000000009da4bc] schedule_timeout+0x1fc/0x440
[c00000007e65fcf0] [c0000000001754ac] rcu_gp_kthread+0x60c/0x1090
[c00000007e65fdc0] [c000000000112a10] kthread+0x160/0x1a0
[c00000007e65fe30] [c00000000000bae0] ret_from_kernel_thread+0x5c/0x7c
NMI backtrace for cpu 0
CPU: 0 PID: 7 Comm: ksoftirqd/0 Not tainted 4.13.0-rc6 #2
Call Trace:
[c00000007e65b200] [c0000000009bbfa0] dump_stack+0xb0/0xf0 (unreliable)
[c00000007e65b240] [c0000000009c4cb8] nmi_cpu_backtrace+0x208/0x210
[c00000007e65b2d0] [c0000000009c4ea0] nmi_trigger_cpumask_backtrace+0x1e0/0x220
[c00000007e65b360] [c00000000002d100] arch_trigger_cpumask_backtrace+0x20/0x40
[c00000007e65b380] [c000000000177d00] rcu_dump_cpu_stacks+0xf4/0x164
[c00000007e65b3d0] [c000000000177174] rcu_check_callbacks+0x994/0xaf0
[c00000007e65b500] [c00000000017f34c] update_process_times+0x3c/0x90
[c00000007e65b530] [c000000000195c0c] tick_sched_handle.isra.5+0x2c/0xc0
[c00000007e65b560] [c000000000195cf8] tick_sched_timer+0x58/0xd0
[c00000007e65b5a0] [c00000000017fdc8] __hrtimer_run_queues+0xf8/0x360
[c00000007e65b620] [c000000000180d24] hrtimer_interrupt+0xf4/0x340
[c00000007e65b6f0] [c0000000000231dc] __timer_interrupt+0x8c/0x270
[c00000007e65b740] [c0000000000238c0] timer_interrupt+0xa0/0xe0
[c00000007e65b770] [c0000000000091c0] decrementer_common+0x150/0x160
--- interrupt: 901 at .L142+0x0/0x4
    LR = arch_local_irq_restore+0x74/0x90
[c00000007e65ba60] [c000000000ed3b00] jiffies+0x0/0x80 (unreliable)
[c00000007e65ba80] [c000000000106434] idle_worker_timeout+0x104/0x190
[c00000007e65bac0] [c00000000017de28] call_timer_fn+0x58/0x1c0
[c00000007e65bb50] [c00000000017e100] expire_timers+0x140/0x1e0
[c00000007e65bbc0] [c00000000017e348] run_timer_softirq+0x1a8/0x230
[c00000007e65bc50] [c0000000009dc7f0] __do_softirq+0x170/0x3e4
[c00000007e65bd40] [c0000000000eef9c] run_ksoftirqd+0x3c/0xb0
[c00000007e65bd60] [c000000000118500] smpboot_thread_fn+0x290/0x2a0
[c00000007e65bdc0] [c000000000112a10] kthread+0x160/0x1a0
[c00000007e65be30] [c00000000000bae0] ret_from_kernel_thread+0x5c/0x7c
watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [ksoftirqd/0:7]
Modules linked in:
CPU: 0 PID: 7 Comm: ksoftirqd/0 Not tainted 4.13.0-rc6 #2
task: c00000007e62e100 task.stack: c00000007e658000
NIP: c00000000000ad4c LR: c000000000015ae4 CTR: 0000000000000001
REGS: c00000007e65b8b0 TRAP: 0901   Not tainted  (4.13.0-rc6)
MSR: 8000000002009033 <SF,VEC,EE,ME,IR,DR,RI,LE>
  CR: 24000804  XER: 00000000
CFAR: c00000000017dbdc SOFTE: 1 
GPR00: c00000000017e0ec c00000007e65bb30 c000000000ea5a00 0000000000000900 
GPR04: 0000000000000001 c00000007e160000 8000000000000000 0000000000000000 
GPR08: c00000000fd40000 0000000000000012 0000000000000000 c00000007fe0fea8 
GPR12: c000000000106330 c00000000fd40000 
NIP [c00000000000ad4c] .L142+0x0/0x4
LR [c000000000015ae4] arch_local_irq_restore+0x74/0x90
Call Trace:
[c00000007e65bb30] [c000000000d74f00] irq_stat+0x0/0x80 (unreliable)
[c00000007e65bb50] [c00000000017e0ec] expire_timers+0x12c/0x1e0
[c00000007e65bbc0] [c00000000017e348] run_timer_softirq+0x1a8/0x230
[c00000007e65bc50] [c0000000009dc7f0] __do_softirq+0x170/0x3e4
[c00000007e65bd40] [c0000000000eef9c] run_ksoftirqd+0x3c/0xb0
[c00000007e65bd60] [c000000000118500] smpboot_thread_fn+0x290/0x2a0
[c00000007e65bdc0] [c000000000112a10] kthread+0x160/0x1a0
[c00000007e65be30] [c00000000000bae0] ret_from_kernel_thread+0x5c/0x7c
Instruction dump:
7d200026 618c8000 2c030900 4182e348 2c030500 4182dda0 2c030a00 4182ffc0 
60000000 60000000 60000000 60000000 <4e800020> 7c781b78 48000331 48000349 
timeout waiting for login

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 BAD BAD BAD BAD BAD BAD BAD BAD BAD BAD 
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

--MP_/m80B16CMtXc8etMUFlAKluv--
