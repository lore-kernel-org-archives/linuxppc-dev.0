Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 78FBDDDEE3
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2008 09:10:19 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: locking problem in sata_sil24?
Date: Mon, 3 Mar 2008 16:10:17 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B0410A524@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <linuxppc-dev@ozlabs.org>,
	<linux-ide@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi I am trying to get PREEMPT_RT pach to wokr on my 2.6.24 kernel, but
kept gettign a BUG() (kernel BUG at kernel/rtmutex.c:692).
While tryiong to figure out what it was, I saw some mention of trying
LOCKDEP to see what is going on, so I patched my -rt1 kernel with some
lockdep patches from BenH.

Now I get an "inconsistent locking state", but I need help in trying to
fiure out what I should look for.
kernel is fo an Freescale 8280 and the locking seems to occur in the
driver for a Silicon Image SII3124 SATA disk driver

Linux version 2.6.24-rt1 (runet@runet) (gcc version 4.1.2) #12 PREEMPT
RT Mon Mar 3 15:47:03 CST 2008
Trying to allocate DevcomPtr
DevcomHugeMemPtr =3D c1800000
Zone PFN ranges:
  DMA             0 ->   196608
  Normal     196608 ->   196608
  HighMem    196608 ->   262144
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->   262144
Real-Time Preemption Support (C) 2004-2007 Ingo Molnar
Built 1 zonelists in Zone order, mobility grouping on.  Total pages:
260096
Kernel command line: root=3D/dev/sda3 rw console=3DttyCPM0,115200
WARNING: experimental RCU implementation.
PID hash table entries: 4096 (order: 12, 16384 bytes)
clocksource: timebase mult[a0c0437] shift[22] registered
console [ttyCPM0] enabled
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:      8
... MAX_LOCK_DEPTH:             30
... MAX_LOCKDEP_KEYS:         2048
... CLASSHASH_SIZE:           1024
... MAX_LOCKDEP_ENTRIES:     16384
... MAX_LOCKDEP_CHAINS:      32768
... CHAINHASH_SIZE:          16384
 memory used by lock dependency info: 1568 kB
 per task-struct memory footprint: 1200 bytes
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1007824k/1048576k available (3240k kernel code, 302324k
reserved, 176k data, 2803k bss, 128k init)
Mount-cache hash table entries: 512
net_namespace: 88 bytes
NET: Registered protocol family 16
PCI: Probing PCI hardware
SCSI subsystem initialized
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 32768 (order: 9, 2228224 bytes)
TCP: Hash tables configured (established 131072 bind 32768)
TCP reno registered
krcupreemptd setsched 0
  prio =3D 98
highmem bounce pool size: 64 pages
JFFS2 version 2.2. (NAND) .. 2001-2006 Red Hat, Inc.
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
ttyCPM0 at MMIO 0xf1050a80 (irq =3D 16) is a CPM UART
Fixed MDIO Bus: probed
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
eth0: fs_enet: 00:30:d7:00:14:52
eth1: fs_enet: 00:30:d7:00:14:53
eth2: fs_enet: 00:30:d7:00:00:01
Driver 'sd' needs updating - please use bus_type methods
scsi0 : sata_sil24
scsi1 : sata_sil24
scsi2 : sata_sil24
scsi3 : sata_sil24
ata1: SATA max UDMA/100 host m128@0x90000000 port 0x90008000 irq 17
ata2: SATA max UDMA/100 host m128@0x90000000 port 0x9000a000 irq 17
ata3: SATA max UDMA/100 host m128@0x90000000 port 0x9000c000 irq 17
ata4: SATA max UDMA/100 host m128@0x90000000 port 0x9000e000 irq 17
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
stopped custom tracer.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
[ INFO: inconsistent lock state ]
[ 2.6.24-rt1 #12
---------------------------------
inconsistent {hardirq-on-W} -> {in-hardirq-W} usage.
swapper/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
 (&host->lock){+-..}, at: [<c01c8e14>] sil24_interrupt+0x68/0x53c
{hardirq-on-W} state was registered at:
  [<c0047724>] __lock_acquire+0x494/0xc04
  [<c0047ee8>] lock_acquire+0x54/0x78
  [<c025c8f0>] rt_spin_lock+0x34/0x54
  [<c01b45ac>] ata_dev_init+0x38/0x88
  [<c01b467c>] ata_link_init+0x80/0xa4
  [<c01b4840>] ata_port_alloc+0x1a0/0x1bc
  [<c01b48f4>] ata_host_alloc+0x98/0xf8
  [<c01b4974>] ata_host_alloc_pinfo+0x20/0x104
  [<c01c83b4>] sil24_init_one+0x128/0x390
  [<c01802f0>] pci_device_probe+0x70/0xa8
  [<c0197d10>] driver_probe_device+0x104/0x1ac
  [<c0197e0c>] __driver_attach+0x54/0x8c
  [<c0197030>] bus_for_each_dev+0x58/0xa0
  [<c0197adc>] driver_attach+0x2c/0x44
  [<c0197778>] bus_add_driver+0xb4/0x1b8
  [<c01980b8>] driver_register+0x7c/0x114
  [<c01803bc>] __pci_register_driver+0x60/0x78
  [<c031e620>] sil24_init+0x2c/0x44
  [<c030a2c8>] kernel_init+0xdc/0x334
  [<c0010408>] kernel_thread+0x44/0x60
irq event stamp: 16174
hardirqs last  enabled at (16173): [<c0046d18>]
trace_hardirqs_on+0x1c/0x34
hardirqs last disabled at (16174): [<c0045554>]
trace_hardirqs_off+0x1c/0x34
softirqs last  enabled at (0): [<00000000>] 0x0
softirqs last disabled at (0): [<00000000>] 0x0

other info that might help us debug this:
no locks held by swapper/0.

stack backtrace:
Call Trace:
[c0357ca0] [c0008474] show_stack+0x54/0x18c (unreliable)
[c0357cd0] [c00085cc] dump_stack+0x20/0x38
[c0357ce0] [c00460a0] print_usage_bug+0x130/0x14c
[c0357d10] [c0046674] mark_lock+0xf0/0x4ec
[c0357d30] [c004769c] __lock_acquire+0x40c/0xc04
[c0357d80] [c0047ee8] lock_acquire+0x54/0x78
[c0357da0] [c025c8f0] rt_spin_lock+0x34/0x54
[c0357dc0] [c01c8e14] sil24_interrupt+0x68/0x53c
[c0357e00] [c00529e0] handle_IRQ_event+0x6c/0x114
[c0357e30] [c0052bcc] __do_IRQ+0x144/0x1c4
[c0357e50] [c0017d88] apmax_int_irq_demux+0x90/0xb8
[c0357e70] [c00063f0] do_IRQ+0x6c/0xb0
[c0357e80] [c0010cfc] ret_from_except+0x0/0x28
--- Exception: 501 at check_critical_timing+0x184/0x190
    LR =3D check_critical_timing+0x15c/0x190
[c0357f80] [c00519a4] touch_critical_timing+0x5c/0xb0
[c0357fa0] [c00096c4] cpu_idle+0xe4/0x124
[c0357fb0] [c0003bcc] rest_init+0x78/0xac
[c0357fc0] [c030ab9c] start_kernel+0x2c4/0x2dc
[c0357ff0] [00003438] 0x3438
ata1.00: ATA-7: Hitachi HDT725032VLA360, V54OA52A, max UDMA/133
ata1.00: 625142448 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata1.00: configured for UDMA/100
ata2: SATA link down (SStatus 0 SControl 0)
ata3: SATA link down (SStatus 0 SControl 0)
ata4: SATA link down (SStatus 0 SControl 0)
scsi 0:0:0:0: Direct-Access     ATA      Hitachi HDT72503 V54O PQ: 0
ANSI: 5
sd 0:0:0:0: [sda] 625142448 512-byte hardware sectors (320073 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 0:0:0:0: [sda] 625142448 512-byte hardware sectors (320073 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
sd 0:0:0:0: [sda] Attached SCSI disk
ff800000.flash: Found 1 x16 devices at 0x0 in 16-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
ff800000.flash: CFI does not contain boot bank location. Assuming top.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
cmdlinepart partition parsing not available
RedBoot partition parsing not available
Creating 7 MTD partitions on "ff800000.flash":
0x00000000-0x00010000 : "HWCR"
0x00010000-0x00030000 : "Altera"
0x00030000-0x00600000 : "Kernel"
0x00700000-0x00740000 : "u-boot"
0x00740000-0x00750000 : "u-boot-env"
0x00750000-0x00800000 : "JFFS2"
0x00600000-0x00610000 : "Altera Backup"
of-flash f8400000.sram: Device tree uses obsolete "direct-mapped" flash
binding
cmdlinepart partition parsing not available
RedBoot partition parsing not available
Creating 1 MTD partitions on "f8400000.sram":
0x00000000-0x00020000 : "SRAM"
arp_tables: (C) 2002 David S. Miller
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
------------[ cut here ]------------
kernel BUG at kernel/rtmutex.c:692!
Oops: Exception in kernel mode, sig: 5 [#1]
PREEMPT Innovative Systems ApMax
Modules linked in:
NIP: c025c340 LR: c025c318 CTR: c01c8dac
REGS: ef859ad0 TRAP: 0700   Not tainted  (2.6.24-rt1)
MSR: 00021032 <ME,IR,DR>  CR: 28004042  XER: 20000000
TASK =3D ef852090[8] 'softirq-block/0' THREAD: ef858000
GPR00: 00000001 ef859b80 ef852090 00000000 00000000 00000000 00000000
00000002
GPR08: 00000001 ef852090 ef852090 ef859b80 00000000 ffffffff 0fffd000
00000028
GPR16: 00800564 00800000 00000000 007fff00 00000000 00000001 ef8bc000
ef3ac2f0
GPR24: 00000011 00000000 00000000 ef3f77e0 ef858000 00001032 ef3ac2f0
ef859b80
NIP [c025c340] rt_spin_lock_slowlock+0x7c/0x1c0
LR [c025c318] rt_spin_lock_slowlock+0x54/0x1c0
Call Trace:
[ef859b80] [c025c318] rt_spin_lock_slowlock+0x54/0x1c0 (unreliable)
[ef859be0] [c025c78c] __rt_spin_lock+0x80/0x98
[ef859bf0] [c025c8f8] rt_spin_lock+0x3c/0x54
[ef859c10] [c01c8e14] sil24_interrupt+0x68/0x53c
[ef859c50] [c00529e0] handle_IRQ_event+0x6c/0x114
[ef859c80] [c0052bcc] __do_IRQ+0x144/0x1c4
[ef859ca0] [c0017d88] apmax_int_irq_demux+0x90/0xb8
[ef859cc0] [c00063f0] do_IRQ+0x6c/0xb0
[ef859cd0] [c0010cfc] ret_from_except+0x0/0x28
--- Exception: 501 at ata_qc_issue+0x140/0x684
    LR =3D ata_scsi_translate+0x138/0x184
[ef859d90] [ef385960] 0xef385960 (unreliable)
[ef859dd0] [c01bd7a0] ata_scsi_translate+0x138/0x184
[ef859e00] [c01c0d0c] ata_scsi_queuecmd+0x210/0x240
[ef859e20] [c01a46d4] scsi_dispatch_cmd+0x1d0/0x240
[ef859e40] [c01aaecc] scsi_request_fn+0x274/0x340
[ef859e60] [c0160b9c] blk_run_queue+0x68/0xac
[ef859e80] [c01a8ee0] scsi_run_queue+0x1cc/0x1e4
[ef859eb0] [c01a9678] scsi_next_command+0x3c/0x5c
[ef859ed0] [c01a987c] scsi_end_request+0xd4/0xf4
[ef859ef0] [c01a9c30] scsi_io_completion+0xf4/0x320
[ef859f30] [c01a3f78] scsi_finish_command+0x94/0xac
[ef859f50] [c01aa5d4] scsi_softirq_done+0xd4/0xec
[ef859f70] [c015c83c] blk_done_softirq+0x8c/0xbc
[ef859f90] [c0026008] ksoftirqd+0x168/0x27c
[ef859fd0] [c00386d0] kthread+0x50/0x90
[ef859ff0] [c0010408] kernel_thread+0x44/0x60
Instruction dump:
7fc3f378 4bdefce9 2f830000 41be0010 7fc3f378 7fa4eb78 48000140 801e002c
5400003a 7c001278 7c000034 5400d97e <0f000000> 38000004 901f0008
801f0008
Kernel panic - not syncing: Fatal exception in interrupt
Call Trace:
[ef8598f0] [c0008474] show_stack+0x54/0x18c (unreliable)
[ef859920] [c00085cc] dump_stack+0x20/0x38
[ef859930] [c001f198] panic+0x94/0x178
[ef859980] [c000e4d0] die+0x178/0x184
[ef8599a0] [c000e6d8] _exception+0x5c/0x17c
[ef859a90] [c000eadc] program_check_exception+0x154/0x504
[ef859ac0] [c0010cb0] ret_from_except_full+0x0/0x4c
--- Exception: 700 at rt_spin_lock_slowlock+0x7c/0x1c0
    LR =3D rt_spin_lock_slowlock+0x54/0x1c0
[ef859be0] [c025c78c] __rt_spin_lock+0x80/0x98
[ef859bf0] [c025c8f8] rt_spin_lock+0x3c/0x54
[ef859c10] [c01c8e14] sil24_interrupt+0x68/0x53c
[ef859c50] [c00529e0] handle_IRQ_event+0x6c/0x114
[ef859c80] [c0052bcc] __do_IRQ+0x144/0x1c4
[ef859ca0] [c0017d88] apmax_int_irq_demux+0x90/0xb8
[ef859cc0] [c00063f0] do_IRQ+0x6c/0xb0
[ef859cd0] [c0010cfc] ret_from_except+0x0/0x28
--- Exception: 501 at ata_qc_issue+0x140/0x684
    LR =3D ata_scsi_translate+0x138/0x184
[ef859d90] [ef385960] 0xef385960 (unreliable)
[ef859dd0] [c01bd7a0] ata_scsi_translate+0x138/0x184
[ef859e00] [c01c0d0c] ata_scsi_queuecmd+0x210/0x240
[ef859e20] [c01a46d4] scsi_dispatch_cmd+0x1d0/0x240
[ef859e40] [c01aaecc] scsi_request_fn+0x274/0x340
[ef859e60] [c0160b9c] blk_run_queue+0x68/0xac
[ef859e80] [c01a8ee0] scsi_run_queue+0x1cc/0x1e4
[ef859eb0] [c01a9678] scsi_next_command+0x3c/0x5c
[ef859ed0] [c01a987c] scsi_end_request+0xd4/0xf4
[ef859ef0] [c01a9c30] scsi_io_completion+0xf4/0x320
[ef859f30] [c01a3f78] scsi_finish_command+0x94/0xac
[ef859f50] [c01aa5d4] scsi_softirq_done+0xd4/0xec
[ef859f70] [c015c83c] blk_done_softirq+0x8c/0xbc
[ef859f90] [c0026008] ksoftirqd+0x168/0x27c
[ef859fd0] [c00386d0] kthread+0x50/0x90
[ef859ff0] [c0010408] kernel_thread+0x44/0x60
Rebooting in 180 seconds..
