Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C58F12C0369
 for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2012 01:40:18 +1000 (EST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glppe-linuxppc-embedded-2@m.gmane.org>)
 id 1StKk2-0004tf-4Q
 for linuxppc-dev@ozlabs.org; Mon, 23 Jul 2012 17:40:14 +0200
Received: from 146.177.65.86.rev.sfr.net ([86.65.177.146])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2012 17:40:14 +0200
Received: from g.bugniot by 146.177.65.86.rev.sfr.net with local (Gmexim 0.1
 (Debian)) id 1AlnuQ-0007hv-00
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2012 17:40:14 +0200
To: linuxppc-dev@ozlabs.org
From: Geoffrey Bugniot <g.bugniot@gmail.com>
Subject: Memory management problems on a custom PPC 8270 board
Date: Mon, 23 Jul 2012 15:34:02 +0000 (UTC)
Message-ID: <loom.20120723T170223-328@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I've ported on a custom board U-Boot and Linux 2.6.39.4. It seems to work
well until the kernel is begin to manipulate "data/file" with a size larger
than about 5 Mo. I suppose that's a VM management problem, but I'm not
sure.

In fact, when I use "cp file1 file2" with file1 >= 5/6 Mo, the kernel panics.
Same behaviour with a command like "tar cvf file.tar.gz file1 file2...".

I got something like that :

[  148.891584] Kernel panic - not syncing: Attempted to kill init!
[  148.897503] Call Trace:
[  148.899934] [c7829d10] [c0008fbc] show_stack+0x4c/0x138 (unreliable)
[  148.906470] [c7829d50] [c03be7d8] panic+0xa4/0x1e8
[  148.911401] [c7829db0] [c0025580] do_exit+0x94/0x630
[  148.916501] [c7829e00] [c0025bdc] do_group_exit+0x80/0xac
[  148.922071] [c7829e10] [c00340d8] get_signal_to_deliver+0x474/0x490
[  148.928515] [c7829e70] [c0009aa4] do_signal_pending.constprop.9+0x40/0x22c
[  148.935586] [c7829f30] [c0009d88] do_signal+0x24/0x50
[  148.940793] [c7829f40] [c000f76c] do_user_signal+0x74/0xc4
[  148.946419] --- Exception: 700 at 0xfec5394
[  148.946433]     LR = 0x1000410c
[  148.954009] Rebooting in 3 seconds..

When I use netsniff-ng, with default parameters, kernel hangs too. But If I
specify a small ring buffer size with option "netsniff-ng -S 3MB" all is
running fine. Here, is the dump when netsniff-ng causes a crash:

root@pLinesE_VMEb:~# netsniff-ng
netsniff-ng 0.5.5.0 -- pid (245)
[   36.065574] device eth0 entered promiscuous mode
nice (0), scheduler (0 prio 0)
1 of 1 CPUs online, affinity bitstring (1)
No device specified, using `eth0`.
No filter applied. Switching to `all traffic`.

[   36.159714] BUG: Bad page state in process netsniff-ng  pfn:05401
[   36.165759] page:c0401020 count:0 mapcount:1 mapping:  (null) index:0x0
[   36.172548] page flags: 0x0()
[   36.175539] Call Trace:
[   36.178079] [c786fcc0] [c0008380] show_stack+0x4c/0x138 (unreliable)
[   36.184625] [c786fd00] [c005bb9c] bad_page+0xd4/0xec
[   36.189723] [c786fd10] [c005bfb4] get_page_from_freelist+0x334/0x450
[   36.196263] [c786fda0] [c005c7fc] __alloc_pages_nodemask+0x108/0x63c
[   36.202801] [c786fe40] [c005cd4c] __get_free_pages+0x1c/0x50
[   36.208628] [c786fe50] [c01f0080] packet_set_ring+0x158/0x360
[   36.214537] [c786fe90] [c01f05d8] packet_setsockopt+0x350/0x88c
[   36.220641] [c786fee0] [c017387c] sys_setsockopt+0x80/0xa8
[   36.226277] [c786ff10] [c017410c] sys_socketcall+0x18c/0x1f8
[   36.232112] [c786ff40] [c000e0a8] ret_from_syscall+0x0/0x38
[   36.237830] --- Exception: c01 at 0xff21ec8
[   36.237841]     LR = 0x10006de8
[   36.245387] Disabling lock debugging due to kernel taint
...
[] Unable to handle kernel paging request for data at address 0x00000004
[   41.356750] Faulting instruction address: 0xc005c3f4
[   41.361864] Oops: Kernel access of bad area, sig: 11 [#1]
[   41.367410] Interface Concept pLinesE_VMEb
[   41.371622] last sysfs file: /sys/kernel/uevent_seqnum
[   41.376914] NIP: c005c3f4 LR: c005d304 CTR: 00000009
[   41.382024] REGS: c7815bc0 TRAP: 0300   Tainted: G    B        (2.6.39.4)
[   41.389003] MSR: 00001032 <ME,IR,DR>  CR: 22222424  XER: 20000000
[   41.395278] DAR: 00000004, DSISR: 22000000
[] TASK = c780e000[1] 'init' THREAD: c7814000
GPR00: c0450458 c7815c70 c780e000 c0331f54 00000007 00000000 00000000 00000080
GPR08: 00000002 00000001 c0331fa4 00000000 22002442 1001f308 c7ab3000 c799b0fc
GPR16: c045b4b4 00000000 c0340000 ffffffff ffffff80 c0331fa0 00100100 00200200
GPR24: 00000001 c045b4c0 00000005 00000000 00000001 c0450440 00000007 c0331f54
[   41.439213] NIP [c005c3f4] free_pcppages_bulk+0x26c/0x2e8
[   41.444747] LR [c005d304] free_hot_cold_page+0x178/0x194
[   41.450200] Call Trace:
[] [c7815c70] [c005bdd0] get_page_from_freelist+0x150/0x450 (unreliable)
[   41.460427] [c7815cc0] [c005d304] free_hot_cold_page+0x178/0x194
[   41.466609] [c7815ce0] [c005f908] __put_single_page+0x34/0x3c
[   41.472532] [c7815cf0] [c0068ba4] unmap_vmas+0x310/0x52c
[   41.477986] [c7815d70] [c006d984] exit_mmap+0xa4/0x130
[   41.483288] [c7815d90] [c001c97c] mmput+0x48/0xc4
[   41.488113] [c7815da0] [c0020020] exit_mm+0x118/0x120
[   41.493309] [c7815dd0] [c002172c] do_exit+0x1b4/0x5c8
[   41.498505] [c7815e20] [c0021c00] do_group_exit+0x80/0xac
[   41.504065] [c7815e30] [c002c000] get_signal_to_deliver+0x2e4/0x300
[   41.510526] [c7815e70] [c0008e6c] do_signal_pending.constprop.9+0x40/0x22c
[   41.517591] [c7815f30] [c0009150] do_signal+0x24/0x50
[   41.522801] [c7815f40] [c000e88c] do_user_signal+0x74/0xc4
[   41.528430] --- Exception: 700 at 0xfec5394
[   41.528440]     LR = 0x1000410c
[   41.535948] Instruction dump:
92bd0018 917d001c 900b0000 48000034 1d69002c 56b51838 381d0018 7eb55a14
3ab50020 7ebfaa14 81750004 39550004 <900b0004> 917d0018 915d001c 90150004
[   41.555131] ---[ end trace d0a9d484110ce6f6 ]---
[   41.559873] Fixing recursive fault but reboot is needed!
[   41.565346] BUG: scheduling while atomic: init/1/0x00000001
[   41.571070] Call Trace:
[] [c78159f0] [c0008380] show_stack+0x4c/0x138 (unreliable)
[   41.580144] [c7815a30] [c01f4198] __schedule_bug+0x58/0x60
[   41.585776] [c7815a40] [c01f1fa8] schedule+0x64/0x3b8
[   41.590974] [c7815b30] [c0021670] do_exit+0xf8/0x5c8
[   41.596081] [c7815b80] [c000b340] die+0x184/0x190
[   41.600920] [c7815ba0] [c0011c9c] bad_page_fault+0xdc/0xe4
[   41.606566] [c7815bb0] [c000e548] handle_page_fault+0x7c/0x80
[   41.612498] --- Exception: 300 at free_pcppages_bulk+0x26c/0x2e8
[   41.612510]     LR = free_hot_cold_page+0x178/0x194
[] [c7815c70] [c005bdd0] get_page_from_freelist+0x150/0x450 (unreliable)
[   41.631384] [c7815cc0] [c005d304] free_hot_cold_page+0x178/0x194
[   41.637566] [c7815ce0] [c005f908] __put_single_page+0x34/0x3c
[   41.643488] [c7815cf0] [c0068ba4] unmap_vmas+0x310/0x52c
[   41.648944] [c7815d70] [c006d984] exit_mmap+0xa4/0x130
[   41.654244] [c7815d90] [c001c97c] mmput+0x48/0xc4
[   41.659068] [c7815da0] [c0020020] exit_mm+0x118/0x120
[   41.664265] [c7815dd0] [c002172c] do_exit+0x1b4/0x5c8
[   41.669461] [c7815e20] [c0021c00] do_group_exit+0x80/0xac
[   41.675021] [c7815e30] [c002c000] get_signal_to_deliver+0x2e4/0x300
[   41.681480] [c7815e70] [c0008e6c] do_signal_pending.constprop.9+0x40/0x22c
[   41.688548] [c7815f30] [c0009150] do_signal+0x24/0x50
[   41.693752] [c7815f40] [c000e88c] do_user_signal+0x74/0xc4
[   41.699387] --- Exception: 700 at 0xfec5394
[   41.699397]     LR = 0x1000410c
[] Unable to handle kernel paging request for data at address 0x00000004
[   45.146562] Faulting instruction address: 0xc005d014
[   45.151676] Oops: Kernel access of bad area, sig: 11 [#2]
[   45.157221] Interface Concept pLinesE_VMEb
[   45.161434] last sysfs file: /sys/kernel/uevent_seqnum
[   45.166725] NIP: c005d014 LR: c005d168 CTR: c00200ec
[   45.171835] REGS: c7825e40 TRAP: 0300   Tainted: G    B D      (2.6.39.4)
[   45.178815] MSR: 00001032 <ME,IR,DR>  CR: 42042044  XER: 20000000
[   45.185089] DAR: 00000004, DSISR: 22000000
[   45.189303] TASK = c781e590[6] 'rcu_kthread' THREAD: c7824000
GPR00: c0450318 c7825ef0 c781e590 ffffffff 00200200 00100100 00000001 ffffffc0
GPR08: 00000000 00000000 00000080 c0331fa4 00000000 1008f4d4 00000000 00000000
GPR16: 07f986bc 00000000 07b1e300 07b1e2a8 07f9b138 07f6480c 07f9c044 07f896ec
GPR24: 00000000 00000001 c0331fa0 00000001 00000001 00000000 c0331f54 c0450300
[   45.229652] NIP [c005d014] free_one_page+0x218/0x278
[   45.234736] LR [c005d168] __free_pages_ok+0xf4/0x100
[   45.239832] Call Trace:
[   45.242355] [c7825f20] [c005d168] __free_pages_ok+0xf4/0x100
[   45.248191] [c7825f40] [c001c7b0] free_task+0x38/0x50
[   45.253376] [c7825f50] [c0020130] delayed_put_task_struct+0x44/0x4c
[   45.259834] [c7825f60] [c004c880] rcu_process_callbacks+0x8c/0xa0
[   45.266096] [c7825f70] [c004c968] rcu_kthread+0xd4/0xe8
[   45.271474] [c7825fb0] [c0036204] kthread+0x78/0x7c
[   45.276498] [c7825ff0] [c000d240] kernel_thread+0x4c/0x68
[   45.282034] Instruction dump:
935f0018 913f001c 90090000 48000034 1d3b002c 575a1838 381f0018 7f5a4a14
3b5a0020 7f5ed214 813a0004 397a0004
913f0018 917f001c 901a0004
[   45.301845] Kernel panic - not syncing: Fatal exception in interrupt
[   45.308376] Call Trace:
[   45.310909] [c7825d60] [c0008380] show_stack+0x4c/0x138 (unreliable)
[   45.317449] [c7825da0] [c01f4244] panic+0xa4/0x1d8
[   45.322364] [c7825e00] [c000b334] die+0x178/0x190
[   45.327204] [c7825e20] [c0011c9c] bad_page_fault+0xdc/0xe4
[   45.332853] [c7825e30] [c000e548] handle_page_fault+0x7c/0x80
[   45.338781] --- Exception: 300 at free_one_page+0x218/0x278
[   45.338793]     LR = __free_pages_ok+0xf4/0x100
[   45.349148] [c7825ef0] [00000000]   (null) (unreliable)
[   45.354532] [c7825f20] [c005d168] __free_pages_ok+0xf4/0x100
[   45.360367] [c7825f40] [c001c7b0] free_task+0x38/0x50
[   45.365554] [c7825f50] [c0020130] delayed_put_task_struct+0x44/0x4c
[   45.372011] [c7825f60] [c004c880] rcu_process_callbacks+0x8c/0xa0
[   45.378275] [c7825f70] [c004c968] rcu_kthread+0xd4/0xe8
[   45.383653] [c7825fb0] [c0036204] kthread+0x78/0x7c
[   45.388671] [c7825ff0] [c000d240] kernel_thread+0x4c/0x68
[   45.394219] Rebooting in 3 seconds..


My complete dmesg output :

root@pLinesE_VMEb:~# dmesg 
[    0.000000] Using Interface Concept pLinesE_VMEb machine description
[    0.000000] Linux version 2.6.39.4 (gbt@eingpcb180) (gcc version 4.6.1
20110627 (prerelease) (GCC) ) #1 Mon Jul 23 16:06:44 CEST 2012
[    0.000000] Top of RAM: 0x8000000, Total RAM: 0x8000000
[    0.000000] Memory hole size: 0MB
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000000 -> 0x00008000
[    0.000000]   Normal   empty
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x00008000
[    0.000000] On node 0 totalpages: 32768
[    0.000000] free_area_init_node: node 0, pgdat c031ac18, node_mem_map
c0340000
[    0.000000]   DMA zone: 256 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 32512 pages, LIFO batch:7
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total
pages: 32512
[    0.000000] Kernel command line: console=ttyCPM0,115200n8 mtdparts=
physmap-flash.0:0xc00000(system)ro,-(rootfs) rootfstype=jffs2 root=
/dev/mtdblock1 panic=3
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Memory: 126552k/131072k available (3060k kernel code, 4520k
reserved, 144k data, 115k bss, 744k init)
[    0.000000] Kernel virtual memory layout:
[    0.000000]   * 0xfffdf000..0xfffff000  : fixmap
[    0.000000]   * 0xfdfae000..0xfe000000  : early ioremap
[    0.000000]   * 0xc9000000..0xfdfae000  : vmalloc & ioremap
[    0.000000] NR_IRQS:512
[    0.000000] time_init: decrementer frequency = 25.000000 MHz
[    0.000000] time_init: processor frequency   = 400.000000 MHz
[    0.000000] clocksource: timebase mult[a000000] shift[22] registered
[    0.000000] clockevent: decrementer mult[6666666] shift[32] cpu[0]
[    0.000000] Console: colour dummy device 80x25
[    0.000000] irq: irq 4 on host /soc@ff000000/interrupt-controller
@10c00 mapped to virtual irq 16
[    0.000000] console [ttyCPM0] enabled
[    0.134107] pid_max: default: 32768 minimum: 301
[    0.138914] Mount-cache hash table entries: 512
[    0.147310] NET: Registered protocol family 16
[    0.152617] Registering qe_ic with sysfs...
[    0.157694] bio: create slab <bio-0> at 0
[    0.163351] Switching to clocksource timebase
[    0.167824] FS-Cache: Loaded
[    0.171694] Switched to NOHz mode on CPU #0
[    0.190952] NET: Registered protocol family 2
[    0.195470] IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.202853] TCP established hash table entries: 4096 (order: 3, 32768 bytes)
[    0.210249] TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
[    0.216812] TCP: Hash tables configured (established 4096 bind 4096)
[    0.223183] TCP reno registered
[    0.226430] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    0.232469] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    0.239592] NET: Registered protocol family 1
[    0.355317] irq: irq 32 on host /soc@ff000000/interrupt-controller
@10c00 mapped to virtual irq 32
[    0.355820] irq: irq 33 on host /soc@ff000000/interrupt-controller
@10c00 mapped to virtual irq 33
[    0.356251] irq: irq 34 on host /soc@ff000000/interrupt-controller
@10c00 mapped to virtual irq 34
[    0.358242] JFFS2 version 2.2. © 2001-2006 Red Hat, Inc.
[    0.363900] msgmni has been set to 247
[    0.374732] Block layer SCSI generic (bsg) driver version 0.4 loaded
(major 254)
[    0.382160] io scheduler noop registered (default)
[    0.387052] io scheduler deadline registered
[    0.391447] io scheduler cfq registered
[    0.396188] ff011a80.serial: ttyCPM0 at MMIO 0xc9058a80 (irq = 16) is
a CPM UART
[    0.404044] Freescale QUICC Engine UART device driver
[    0.409067] ucc-uart: could not register UART driver
[    0.424369] brd: module loaded
[    0.428300] physmap platform flash device: 04000000 at f0000000
[    0.438232] physmap-flash.0: Found 1 x16 devices at 0x0 in 16-bit bank.
Manufacturer ID 0x000001 Chip ID 0x002301
[    0.448661] Amd/Fujitsu Extended Query Table at 0x0040
[    0.453912]   Amd/Fujitsu Extended Query version 1.3.
[    0.459111] number of CFI chips: 1
[    0.462632] 2 cmdlinepart partitions found on MTD device physmap-flash.0
[    0.469499] Creating 2 MTD partitions on "physmap-flash.0":
[    0.475240] 0x000000000000-0x000000c00000 : "system"
[    0.482169] 0x000000c00000-0x000004000000 : "rootfs"
[    0.489835] eth0: fs_enet: aa:bb:cc:00:00:00
[    0.495138] eth1: fs_enet: 00:00:00:00:00:00
[    0.500501] eth2: fs_enet: 00:00:00:00:00:00
[    0.505200] CPM2 Bitbanged MII: probed
[    0.508929] irq: irq 25 on host /soc@ff000000/interrupt-controller@10c00
mapped to virtual irq 25
[    0.511018] IPv4 over IPv4 tunneling driver
[    0.516127] GRE over IPv4 demultiplexor driver
[    0.520304] GRE over IPv4 tunneling driver
[    0.525817] TCP bic registered
[    0.528735] TCP cubic registered
[    0.532023] TCP westwood registered
[    0.535551] TCP htcp registered
[    0.538826] Initializing XFRM netlink socket
[    0.543267] NET: Registered protocol family 17
[    0.547887] NET: Registered protocol family 15
[    0.553647] Freeing unused kernel memory: 744k init
[    3.997732] udev[74]: starting version 164


Any help will be appreciated...

Regars,
G.B.
