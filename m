Return-Path: <walkinair@cn.ibm.com>
Received: from ausmtp06.au.ibm.com (ausmtp06.au.ibm.com [202.81.18.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6EC6F67C0A
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Oct 2006 02:27:06 +1000 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp06.au.ibm.com (8.13.8/8.13.6) with ESMTP id k9FGRquG7626896
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Oct 2006 02:27:52 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.250.242])
	by sd0208e0.au.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k9FGUGbC224510
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Oct 2006 02:30:21 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k9FGQoAX009807
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Oct 2006 02:26:50 +1000
Message-ID: <4532613D.1090107@cn.ibm.com>
Date: Mon, 16 Oct 2006 00:26:37 +0800
From: Yao Fei Zhu <walkinair@cn.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Failed to boot kernel 2.6.19-rc2 due to IBM veth problem.
Content-Type: text/plain; charset=gb2312
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, all,

Boot kernel 2.6.19-rc2 on IBM System P5 partitions will fall into xmon.
Here is the boot log,

Please wait, loading kernel...
   Elf64 kernel loaded...
Loading ramdisk...
ramdisk loaded at 02400000, size: 1441 Kbytes
OF stdout device is: /vdevice/vty@30000000
Hypertas detected, assuming LPAR !
command line: ro console=hvc0 rhgb quiet root=LABEL=/ xmon=on sysrq=1 selinux=0
memory layout at init:
  alloc_bottom : 0000000002570000
  alloc_top    : 0000000010000000
  alloc_top_hi : 0000000200000000
  rmo_top      : 0000000010000000
  ram_top      : 0000000200000000
Looking for displays
instantiating rtas at 0x000000000f710000 ... done
0000000000000000 : boot cpu     0000000000000000
0000000000000002 : starting cpu hw idx 0000000000000002... done
copying OF device tree ...
Building dt strings...
Building dt structure...
Device tree strings 0x0000000002880000 -> 0x00000000028810e3
Device tree struct  0x0000000002890000 -> 0x00000000028a0000
Calling quiesce ...
returning from prom_init
Partition configured for 6 cpus.
Starting Linux PPC64 #1 SMP Sun Oct 15 11:36:37 EDT 2006
-----------------------------------------------------
ppc64_pft_size                = 0x1c
physicalMemorySize            = 0x200000000
ppc64_caches.dcache_line_size = 0x80
ppc64_caches.icache_line_size = 0x80
htab_address                  = 0x0000000000000000
htab_hash_mask                = 0x1fffff
-----------------------------------------------------
Linux version 2.6.19-rc2 (root@tc1.cn.ibm.com) (gcc version 4.1.1 20060817 (Red                                              Hat 4.1.1-18)) #1 SMP Sun Oct 15 11:36:37 EDT 2006
[boot]0012 Setup Arch
EEH: No capable adapters found
PPC64 nvram contains 7168 bytes
Zone PFN ranges:
  DMA             0 ->   131072
  Normal     131072 ->   131072
early_node_map[1] active PFN ranges
    0:        0 ->   131072
[boot]0015 Setup Done
Built 1 zonelists.  Total pages: 130944
Kernel command line: ro console=hvc0 rhgb quiet root=LABEL=/ xmon=on sysrq=1 sel                                             inux=0
scan-log-dump not implemented on this system
Red Hat nash version 5.1.2 starting
sda: assuming drive cache: write through
sda: assuming drive cache: write through
sdb: assuming drive cache: write through
sdb: assuming drive cache: write through
ERROR unmounting old /proc/bus/usb: No such file or directory
forcing unmount of /proc/bus/usb
                Welcome to Red Hat Enterprise Linux Server
                Press 'I' to enter interactive startup.
Setting clock  (utc): Sun Oct 15 11:56:20 EDT 2006 [  OK  ]
Starting udev: [  OK  ]
Setting hostname tc1.cn.ibm.com:  [  OK  ]
Setting up Logical Volume Management:   No volume groups found
[  OK  ]
Checking filesystems
Checking all file systems.
[/sbin/fsck.ext3 (1) -- /] fsck.ext3 -a /dev/sdb3
/: clean, 388834/5124480 files, 4963350/5120704 blocks
[/sbin/fsck.ext3 (1) -- /boot] fsck.ext3 -a /dev/sdb2
/boot: clean, 29/26104 files, 70058/104384 blocks
[  OK  ]
Remounting root filesystem in read-write mode:  [  OK  ]
Mounting local filesystems:  [  OK  ]
Enabling local filesystem quotas:  [  OK  ]
Enabling /etc/fstab swaps:  [  OK  ]
INIT: Entering runlevel: 3
Entering non-interactive startup
Starting sysstat:  Calling the system activity data collector (sadc):
[  OK  ]
Starting readahead_early:  Starting background readahead: [  OK  ]
[  OK  ]
Checking for hardware changes [  OK  ]
Applying ip6tables firewall rules: [  OK  ]
Applying iptables firewall rules: [  OK  ]
Loading additional iptables modules: ip_conntrack_netbios_ns [  OK  ]
Bringing up loopback interface:  [  OK  ]
Bringing up interface eth0:  [  OK  ]
Bringing up interface eth1:
Determining IP information for eth1... done.
[  OK  ]
Starting restorecond: Daemon requires SELinux be enabled to run.
[FAILED]
Starting auditd: [  OK  ]
Starting system logger: [  OK  ]
Starting kernel logger: [  OK  ]
WARNING: initlog is deprecated and will be removed in a future release
WARNING: initlog is deprecated and will be removed in a future release
Starting irqbalance: [  OK  ]
Starting iSCSI initiator service: [FAILED]
Starting portmap: [  OK  ]
Starting NFS statd: [  OK  ]
Starting RPC idmapd: [  OK  ]
Starting system message bus: [  OK  ]
[  OK  ] Bluetooth services:[  OK  ]
Mounting other filesystems:  [  OK  ]
Starting PC/SC smart card daemon (pcscd): [  OK  ]
Starting hidd: [  OK  ]
Loading autofs4: [  OK  ]
Starting automount: [  OK  ]
Starting hpiod: [  OK  ]
Starting hpssd: [  OK  ]
Starting ipr initialization daemon[  OK  ]
Starting iprupdate:  Checking ipr microcode levels
Completed ipr microcode updates[  OK  ]
[  OK  ]
Starting ipr dump daemon[  OK  ]
Starting cups: [  OK  ]
Starting sshd: [  OK  ]
Starting xinetd: [  OK  ]
Starting NFS services:  [  OK  ]
Starting NFS quotas: [  OK  ]
Starting NFS daemon: NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state reco                                             very directory
NFSD: starting 90-second grace period
[  OK  ]
Starting NFS mountd: [  OK  ]
Starting vsftpd for vsftpd: [  OK  ]
Starting sendmail: [  OK  ]
Starting sm-client: [  OK  ]
Starting console mouse services: [  OK  ]
Starting crond: [  OK  ]
Starting xfs: [  OK  ]
Starting SMB services: [  OK  ]
Starting NMB services: [  OK  ]
Unable to handle kernel paging request for data at address 0x000000d8
Faulting instruction address: 0xd000000000081ff8
cpu 0x1: Vector: 300 (Data Access) at [c00000000f6f7b00]
    pc: d000000000081ff8: .ibmveth_poll+0x20c/0x470 [ibmveth]
    lr: d000000000081fc8: .ibmveth_poll+0x1dc/0x470 [ibmveth]
    sp: c00000000f6f7d80
   msr: 8000000000009032
   dar: d8
 dsisr: 40010000
  current = 0xc000000001b65330
  paca    = 0xc000000000454800
    pid   = 0, comm = swapper
enter ? for help
[c00000000f6f7e40] c0000000002b77dc .net_rx_action+0xe0/0x288
[c00000000f6f7ef0] c00000000006bb14 .__do_softirq+0xa8/0x168
[c00000000f6f7f90] c000000000026864 .call_do_softirq+0x14/0x24
[c000000001b7b980] c00000000000c2a0 .do_softirq+0x70/0x98
[c000000001b7ba10] c00000000006ba54 .irq_exit+0x5c/0x74
[c000000001b7ba90] c00000000000ca68 .do_IRQ+0x180/0x1bc
[c000000001b7bb20] c0000000000044ec hardware_interrupt_entry+0xc/0x10
--- Exception: 501 (Hardware Interrupt) at c0000000000452b8 .plpar_hcall_norets+                                             0x24/0x90
[link register   ] c0000000000464a0 .pseries_shared_idle_sleep+0x24/0x44
[c000000001b7be10] 0000000000000000 .__start+0x4000000000000000/0x8 (unreliable)
[c000000001b7be80] c000000000012258 .cpu_idle+0x110/0x1e8
[c000000001b7bf00] c000000000029fdc .start_secondary+0x144/0x168
[c000000001b7bf90] c0000000000083bc .start_secondary_prolog+0xc/0x10
1:mon>
1:mon> e
cpu 0x1: Vector: 300 (Data Access) at [c00000000f6f7b00]
    pc: d000000000081ff8: .ibmveth_poll+0x20c/0x470 [ibmveth]
    lr: d000000000081fc8: .ibmveth_poll+0x1dc/0x470 [ibmveth]
    sp: c00000000f6f7d80
   msr: 8000000000009032
   dar: d8
 dsisr: 40010000
  current = 0xc000000001b65330
  paca    = 0xc000000000454800
    pid   = 0, comm = swapper
1:mon> t
[c00000000f6f7e40] c0000000002b77dc .net_rx_action+0xe0/0x288
[c00000000f6f7ef0] c00000000006bb14 .__do_softirq+0xa8/0x168
[c00000000f6f7f90] c000000000026864 .call_do_softirq+0x14/0x24
[c000000001b7b980] c00000000000c2a0 .do_softirq+0x70/0x98
[c000000001b7ba10] c00000000006ba54 .irq_exit+0x5c/0x74
[c000000001b7ba90] c00000000000ca68 .do_IRQ+0x180/0x1bc
[c000000001b7bb20] c0000000000044ec hardware_interrupt_entry+0xc/0x10
--- Exception: 501 (Hardware Interrupt) at c0000000000452b8 .plpar_hcall_norets+0x24/0x90
[link register   ] c0000000000464a0 .pseries_shared_idle_sleep+0x24/0x44
[c000000001b7be10] 0000000000000000 .__start+0x4000000000000000/0x8 (unreliable)
[c000000001b7be80] c000000000012258 .cpu_idle+0x110/0x1e8
[c000000001b7bf00] c000000000029fdc .start_secondary+0x144/0x168
[c000000001b7bf90] c0000000000083bc .start_secondary_prolog+0xc/0x10
1:mon> r
R00 = 0000000000000701   R16 = 0000000000000000
R01 = c00000000f6f7d80   R17 = 0000000000000000
R02 = d000000000092930   R18 = 0000000000000000
R03 = c000000001b3a638   R19 = 0000000000000000
R04 = 8000000000009032   R20 = 0000000000000000
R05 = 00000000000000f1   R21 = 0000000000000000
R06 = 000000000000090f   R22 = 0000000000000010
R07 = 0000000000000001   R23 = c00000000f6f7eb0
R08 = c0000001f7ec0220   R24 = 000000000000006e
R09 = 0000000000000022   R25 = 0000000000000001
R10 = c0000001ffaaa790   R26 = c0000001ffaaa100
R11 = 0000000000000000   R27 = 0000000000000008
R12 = 0000000000004000   R28 = c0000001ffaaa100
R13 = c000000000454800   R29 = 0000000000000000
R14 = 0000000000000000   R30 = d000000000092500
R15 = 000000000f9d82a4   R31 = c0000001ffaaa680
pc  = d000000000081ff8 .ibmveth_poll+0x20c/0x470 [ibmveth]
lr  = d000000000081fc8 .ibmveth_poll+0x1dc/0x470 [ibmveth]
msr = 8000000000009032   cr  = 24000088
ctr = 0000000000000000   xer = 0000000020000000   trap =  300
dar = 00000000000000d8   dsisr = 40010000
1:mon> di d000000000081ff8
d000000000081ff8  e81d00d8      ld      r0,216(r29)
d000000000081ffc  e93d00e0      ld      r9,224(r29)
d000000000082000  7f6b07b4      extsw   r11,r27
d000000000082004  7b040020      clrldi  r4,r24,32
d000000000082008  7c005a14      add     r0,r0,r11
d00000000008200c  7d295a14      add     r9,r9,r11
d000000000082010  f81d00d8      std     r0,216(r29)
d000000000082014  f93d00e0      std     r9,224(r29)
d000000000082018  e81d008e      lwa     r0,140(r29)
d00000000008201c  0b000000      tdnei   r0,0
d000000000082020  e81d00e0      ld      r0,224(r29)
d000000000082024  e97d00e8      ld      r11,232(r29)
d000000000082028  813d0088      lwz     r9,136(r29)
d00000000008202c  7c002214      add     r0,r0,r4
d000000000082030  7d244a14      add     r9,r4,r9
d000000000082034  7fa05840      cmpld   cr7,r0,r11
1:mon> mi
Mem-info:
Node 0 DMA per-cpu:
CPU    0: Hot: hi:    6, btch:   1 usd:   5   Cold: hi:    2, btch:   1 usd:   0
CPU    1: Hot: hi:    6, btch:   1 usd:   0   Cold: hi:    2, btch:   1 usd:   0
CPU    2: Hot: hi:    6, btch:   1 usd:   0   Cold: hi:    2, btch:   1 usd:   0
CPU    3: Hot: hi:    6, btch:   1 usd:   5   Cold: hi:    2, btch:   1 usd:   0
Active:2913 inactive:2098 dirty:191 writeback:1 unstable:0 free:124082 slab:705 mapped:563 pagetables:96
Node 0 DMA free:7941248kB min:11520kB low:14400kB high:17280kB active:186432kB inactive:134272kB present:8380416kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0
Node 0 DMA: 20*64kB 5*128kB 1*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB 1*8192kB 484*16384kB = 7941248kB
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 2096320kB
Total swap = 2096320kB
Free swap:       2096320kB
131072 pages of RAM
581 reserved pages
3372 pages shared
0 pages swap cached
1:mon>
