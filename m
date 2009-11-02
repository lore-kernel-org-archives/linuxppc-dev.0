Return-Path: <sachinp@in.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [59.145.155.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp08.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 90CB9B7BB7
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Nov 2009 20:12:33 +1100 (EST)
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp08.in.ibm.com (8.14.3/8.13.1) with ESMTP id nA28uS5t011207
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Nov 2009 14:26:28 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nA29CPXn2121734
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Nov 2009 14:42:25 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nA29CPL9003065
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Nov 2009 20:12:25 +1100
Message-ID: <4AEEA279.4040106@in.ibm.com>
Date: Mon, 02 Nov 2009 14:42:25 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Linux/PPC Development <linuxppc-dev@ozlabs.org>
Subject: [powerpc] Next tree Nov 2 : kernel BUG at mm/mmap.c:2135!
References: <20091102173845.210d1c57.sfr@canb.auug.org.au>
In-Reply-To: <20091102173845.210d1c57.sfr@canb.auug.org.au>
Content-Type: multipart/mixed; boundary="------------020501070806010101090303"
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------020501070806010101090303
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Stephen Rothwell wrote:
> Hi all,
>
> Changes since 20091030:
>   
Today's next tree failed to boot on a POWER 6 box with :

------------[ cut here ]------------
kernel BUG at mm/mmap.c:2135!
Oops: Exception in kernel mode, sig: 5 [#2]
SMP NR_CPUS=1024 NUMA pSeries
Modules linked in: ibmvscsic scsi_transport_srp scsi_tgt scsi_mod
NIP: c00000000014e30c LR: c00000000014e2f8 CTR: c00000000014db88
REGS: c0000000db703620 TRAP: 0700   Tainted: G      D     (2.6.32-rc5-autotest-next-20091102)
MSR: 8000000000029032 <EE,ME,CE,IR,DR>  CR: 24022442  XER: 2000000c
TASK = c0000000db7f6fe0[76] 'init' THREAD: c0000000db700000 CPU: 1
GPR00: 0000000000000001 c0000000db7038a0 c000000000b19900 0000000000000000
GPR04: c0000000db406a40 000000000000000c c0000000fe10c370 c000000000bb2800
GPR08: 000000000000db40 0000000000000000 c0000000dfdc0e00 000000000000000c
GPR12: 0000000044022442 c000000000bb2800 00000000ffffffff ffffffffffffffff
GPR16: 0000000008430000 00000000003c0000 c0000000db703ea0 c0000000db569108
GPR20: c0000000db568908 0000000000000000 c0000000db703d60 0000000000000000
GPR24: 0000000000000001 0000000000040100 c0000000fe503580 c0000000db1ac180
GPR28: 0000000000000000 c000000000f812d0 c000000000a84f00 0000000000000000
NIP [c00000000014e30c] .exit_mmap+0x190/0x1b8
LR [c00000000014e2f8] .exit_mmap+0x17c/0x1b8
Call Trace:
[c0000000db7038a0] [c00000000014e2f8] .exit_mmap+0x17c/0x1b8 (unreliable)
[c0000000db703950] [c0000000000916cc] .mmput+0x54/0x164
[c0000000db7039e0] [c0000000000968d8] .exit_mm+0x17c/0x1a0
[c0000000db703a90] [c000000000098cb8] .do_exit+0x248/0x784
[c0000000db703b70] [c0000000000992a8] .do_group_exit+0xb4/0xe8
[c0000000db703c00] [c0000000000aca2c] .get_signal_to_deliver+0x3ec/0x478
[c0000000db703cf0] [c0000000000134ac] .do_signal+0x6c/0x31c
[c0000000db703e30] [c000000000008b7c] do_work+0x24/0x28
Instruction dump:
7c8407b4 387d0018 4800ab11 60000000 939d0008 7fe3fb78 4bfffdbd 7c7f1b79
4082fff4 e81b00e8 3120ffff 7c090110 <0b000000> 382100b0 e8010010 eb61ffd8
---[ end trace ec052ac77a8e7cb4 ]---
Fixing recursive fault but reboot is needed!

mm/mmap.c:2135 corresponds to :

BUG_ON(mm->nr_ptes > (FIRST_USER_ADDRESS+PMD_SIZE-1)>>PMD_SHIFT);

3:mon> di 0xc00000000014e300
c00000000014e300  e81b00e8      ld      r0,232(r27)
c00000000014e304  3120ffff      addic   r9,r0,-1
c00000000014e308  7c090110      subfe   r0,r9,r0
c00000000014e30c  0b000000      tdnei   r0,0
c00000000014e310  382100b0      addi    r1,r1,176
c00000000014e314  e8010010      ld      r0,16(r1)
c00000000014e318  eb61ffd8      ld      r27,-40(r1)
c00000000014e31c  7c0803a6      mtlr    r0
c00000000014e320  eb81ffe0      ld      r28,-32(r1)
c00000000014e324  eba1ffe8      ld      r29,-24(r1)
c00000000014e328  ebc1fff0      ld      r30,-16(r1)
c00000000014e32c  ebe1fff8      ld      r31,-8(r1)
c00000000014e330  4e800020      blr
c00000000014e334  fb21ffc8      std     r25,-56(r1)
c00000000014e338  7c0802a6      mflr    r0
c00000000014e33c  fb81ffe0      std     r28,-32(r1)
3:mon> r
R00 = 0000000000000001   R16 = 0000000030daf420
R01 = c0000000fae37a60   R17 = 0000000000000002
R02 = c000000000b19900   R18 = 0000000000000000
R03 = 0000000000000000   R19 = 0000000030d903b0
R04 = c0000000fabd8670   R20 = 0000000000000000
R05 = c000000000a4d600   R21 = 0000000000000000
R06 = 0000000000000003   R22 = 0000000000000000
R07 = c000000000bb2c00   R23 = 0000000030daf340
R08 = 000000000000fabd   R24 = 0000000000000001
R09 = 0000000000000000   R25 = 00000fffc2402158
R10 = c0000000fffb2958   R26 = 00000fffb793df80
R11 = 0000000000000005   R27 = c0000000fa9aa580
R12 = 0000000044000442   R28 = 0000000000000000
R13 = c000000000bb2c00   R29 = c000000000fc12d0
R14 = 00000000ffffffff   R30 = c000000000a84f00
R15 = ffffffffffffffff   R31 = 0000000000000000
pc  = c00000000014e30c .exit_mmap+0x190/0x1b8
lr  = c00000000014e2f8 .exit_mmap+0x17c/0x1b8
msr = 8000000000029032   cr  = 24000442
ctr = c0000000002f0cb0   xer = 000000002000000a   trap =  700
3:mon>

Have attached the boot log. Next tree for 20091030 worked fine.

Thanks
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------


--------------020501070806010101090303
Content-Type: text/plain;
 name="boot-log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="boot-log"

Using 007cf32f bytes for initrd buffer
Please wait, loading kernel...
Allocated 00f00000 bytes for kernel @ 02300000
   Elf64 kernel loaded...
Loading ramdisk...
ramdisk loaded 007cf32f @ 03200000
OF stdout device is: /vdevice/vty@30000000
Preparing to boot Linux version 2.6.32-rc5-autotest-next-20091102 (root@mpower6lp5) (gcc version 4.3.2 [gcc-4_3-branch revision 141291] (SUSE Linux) ) #1 SMP Mon Nov 2 12:29:14 IST 2009
Calling ibm,client-architecture-support... done
command line: root=/dev/sda3 sysrq=8 insmod=sym53c8xx insmod=ipr crashkernel=512M-:256M IDENT=1257146334 
memory layout at init:
  memory_limit : 0000000000000000 (16 MB aligned)
  alloc_bottom : 00000000039d0000
  alloc_top    : 0000000008000000
  alloc_top_hi : 0000000008000000
  rmo_top      : 0000000008000000
  ram_top      : 0000000008000000
instantiating rtas at 0x00000000074e0000... done
boot cpu hw idx 0000000000000000
copying OF device tree...
Building dt strings...
Building dt structure...
Device tree strings 0x00000000039e0000 -> 0x00000000039e15c2
Device tree struct  0x00000000039f0000 -> 0x0000000003a10000
Calling quiesce...
returning from prom_init
Crash kernel location must be 0x2000000
Reserving 256MB of memory at 32MB for crashkernel (System RAM: 4096MB)
Using pSeries machine description
Using 1TB segments
Found initrd at 0xc000000003200000:0xc0000000039cf32f
bootconsole [udbg0] enabled
Partition configured for 2 cpus.
CPU maps initialized for 2 threads per core
Starting Linux PPC64 #1 SMP Mon Nov 2 12:29:14 IST 2009
-----------------------------------------------------
ppc64_pft_size                = 0x1a
physicalMemorySize            = 0x100000000
htab_hash_mask                = 0x7ffff
-----------------------------------------------------
Initializing cgroup subsys cpuset
Initializing cgroup subsys cpu
Linux version 2.6.32-rc5-autotest-next-20091102 (root@mpower6lp5) (gcc version 4.3.2 [gcc-4_3-branch revision 141291] (SUSE Linux) ) #1 SMP Mon Nov 2 12:29:14 IST 2009
[boot]0012 Setup Arch
EEH: No capable adapters found
PPC64 nvram contains 15360 bytes
Zone PFN ranges:
  DMA      0x00000000 -> 0x00010000
  Normal   0x00010000 -> 0x00010000
Movable zone start PFN for each node
early_node_map[2] active PFN ranges
    2: 0x00000000 -> 0x0000e000
    3: 0x0000e000 -> 0x00010000
Could not find start_pfn for node 0
[boot]0015 Setup Done
PERCPU: Embedded 2 pages/cpu @c000000000f00000 s89000 r0 d42072 u524288
pcpu-alloc: s89000 r0 d42072 u524288 alloc=1*1048576
pcpu-alloc: [0] 0 1 
Built 3 zonelists in Node order, mobility grouping on.  Total pages: 65480
Policy zone: DMA
Kernel command line: root=/dev/sda3 sysrq=8 insmod=sym53c8xx insmod=ipr crashkernel=512M-:256M IDENT=1257146334 
PID hash table entries: 4096 (order: -1, 32768 bytes)
freeing bootmem node 2
freeing bootmem node 3
Memory: 3899776k/4194304k available (9216k kernel code, 294528k reserved, 2688k data, 2370k bss, 640k init)
Hierarchical RCU implementation.
RCU-based detection of stalled CPUs is enabled.
NR_IRQS:512 nr_irqs:512
[boot]0020 XICS Init
[boot]0021 XICS Done
clocksource: timebase mult[7d0000] shift[22] registered
Console: colour dummy device 80x25
console [hvc0] enabled, bootconsole disabled
console [hvc0] enabled, bootconsole disabled
allocated 2621440 bytes of page_cgroup
please try 'cgroup_disable=memory' option if you don't want memory cgroups
Security Framework initialized
SELinux:  Disabled at boot.
Dentry cache hash table entries: 524288 (order: 6, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 5, 2097152 bytes)
Mount-cache hash table entries: 4096
Initializing cgroup subsys ns
Initializing cgroup subsys cpuacct
Initializing cgroup subsys memory
Initializing cgroup subsys devices
Initializing cgroup subsys freezer
Processor 1 found.
Brought up 2 CPUs
NET: Registered protocol family 16
IBM eBus Device Driver
POWER6 performance monitor hardware support registered
PCI: Probing PCI hardware
bio: create slab <bio-0> at 0
vgaarb: loaded
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Switching to clocksource timebase
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 2, 262144 bytes)
TCP established hash table entries: 131072 (order: 5, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 4, 1048576 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
UDP hash table entries: 4096 (order: 0, 65536 bytes)
UDP-Lite hash table entries: 4096 (order: 0, 65536 bytes)
NET: Registered protocol family 1
Unpacking initramfs...
IOMMU table initialized, virtual merging enabled
audit: initializing netlink socket (disabled)
type=2000 audit(1257150470.200:1): initialized
rcu-torture:--- Start of test: nreaders=4 nfakewriters=4 stat_interval=0 verbose=0 test_no_idle_hz=0 shuffle_interval=3 stutter=5 irqreader=1
HugeTLB registered 16 MB page size, pre-allocated 0 pages
HugeTLB registered 16 GB page size, pre-allocated 0 pages
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 8192 (order 0, 65536 bytes)
msgmni has been set to 7616
alg: No test for stdrng (krng)
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
pciehp: PCI Express Hot Plug Controller Driver version: 0.4
rpaphp: RPA HOT Plug PCI Controller Driver version: 0.1
Generic RTC Driver v1.07
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
pmac_zilog: 0.6 (Benjamin Herrenschmidt <benh@kernel.crashing.org>)
input: Macintosh mouse button emulation as /devices/virtual/input/input0
Uniform Multi-Platform E-IDE driver
ide-gd driver 1.18
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
mice: PS/2 mouse device common for all mice
EDAC MC: Ver: 2.1.0 Nov  2 2009
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
TCP cubic registered
NET: Registered protocol family 15
registered taskstats version 1
Freeing unused kernel memory: 640k freed
doing fast boot
------------[ cut here ]------------
kernel BUG at mm/mmap.c:2135!
Oops: Exception in kernel mode, sig: 5 [#1]
SMP NR_CPUS=1024 NUMA pSeries
Modules linked in:
NIP: c00000000014e30c LR: c00000000014e2f8 CTR: c0000000002f0cb0
REGS: c0000000db7337e0 TRAP: 0700   Not tainted  (2.6.32-rc5-autotest-next-20091102)
MSR: 8000000000029032 <EE,ME,CE,IR,DR>  CR: 24000442  XER: 20000002
TASK = c0000000db618a60[68] 'showconsole' THREAD: c0000000db730000 CPU: 0
GPR00: 0000000000000001 c0000000db733a60 c000000000b19900 0000000000000000 
GPR04: c0000000db408670 c000000000a4d600 0000000000000003 c000000000bb2600 
GPR08: 000000000000db40 0000000000000000 c0000000dfdc0e00 0000000000000005 
GPR12: 0000000044000442 c000000000bb2600 00000000ffffffff ffffffffffffffff 
GPR16: 000000004206e7d0 0000000000000002 0000000000000000 00000000420503b0 
GPR20: 0000000000000000 0000000000000000 0000000000000000 000000004206fd70 
GPR24: 0000000000000001 00000fffc0ac9b08 00000fff99b1df80 c0000000db1aa580 
GPR28: 0000000000000000 c000000000f012d0 c000000000a84f00 0000000000000000 
NIP [c00000000014e30c] .exit_mmap+0x190/0x1b8
LR [c00000000014e2f8] .exit_mmap+0x17c/0x1b8
Call Trace:
[c0000000db733a60] [c00000000014e2f8] .exit_mmap+0x17c/0x1b8 (unreliable)
[c0000000db733b10] [c0000000000916cc] .mmput+0x54/0x164
[c0000000db733ba0] [c0000000000968d8] .exit_mm+0x17c/0x1a0
[c0000000db733c50] [c000000000098cb8] .do_exit+0x248/0x784
[c0000000db733d30] [c0000000000992a8] .do_group_exit+0xb4/0xe8
[c0000000db733dc0] [c0000000000992f0] .SyS_exit_group+0x14/0x28
[c0000000db733e30] [c0000000000085b4] syscall_exit+0x0/0x40
Instruction dump:
7c8407b4 387d0018 4800ab11 60000000 939d0008 7fe3fb78 4bfffdbd 7c7f1b79 
4082fff4 e81b00e8 3120ffff 7c090110 <0b000000> 382100b0 e8010010 eb61ffd8 
SysRq : Changing Loglevel
Loglevel set to 8
---[ end trace ec052ac77a8e7cb3 ]---
Fixing recursive fault but reboot is needed!
SCSI subsystem initialized
vio_register_driver: driver ibmvscsi registering
ibmvscsi 30000007: SRP_VERSION: 16.a
scsi0 : IBM POWER Virtual SCSI Adapter 1.5.8
ibmvscsi 30000007: partner initialization complete
ibmvscsi 30000007: host srp version: 16.a, host partition VIO Server (1), OS 3, max io 1048576
ibmvscsi 30000007: Client reserve enabled
ibmvscsi 30000007: sent SRP login
ibmvscsi 30000007: SRP_LOGIN succeeded
scsi 0:0:1:0: Direct-Access     AIX      VDASD            0001 PQ: 0 ANSI: 3
scsi 0:0:2:0: CD-ROM            AIX      VOPTA                 PQ: 0 ANSI: 4
Creating device nodes with udev
------------[ cut here ]------------
kernel BUG at mm/mmap.c:2135!
Oops: Exception in kernel mode, sig: 5 [#2]
SMP NR_CPUS=1024 NUMA pSeries
Modules linked in: ibmvscsic scsi_transport_srp scsi_tgt scsi_mod
NIP: c00000000014e30c LR: c00000000014e2f8 CTR: c00000000014db88
REGS: c0000000db703620 TRAP: 0700   Tainted: G      D     (2.6.32-rc5-autotest-next-20091102)
MSR: 8000000000029032 <EE,ME,CE,IR,DR>  CR: 24022442  XER: 2000000c
TASK = c0000000db7f6fe0[76] 'init' THREAD: c0000000db700000 CPU: 1
GPR00: 0000000000000001 c0000000db7038a0 c000000000b19900 0000000000000000 
GPR04: c0000000db406a40 000000000000000c c0000000fe10c370 c000000000bb2800 
GPR08: 000000000000db40 0000000000000000 c0000000dfdc0e00 000000000000000c 
GPR12: 0000000044022442 c000000000bb2800 00000000ffffffff ffffffffffffffff 
GPR16: 0000000008430000 00000000003c0000 c0000000db703ea0 c0000000db569108 
GPR20: c0000000db568908 0000000000000000 c0000000db703d60 0000000000000000 
GPR24: 0000000000000001 0000000000040100 c0000000fe503580 c0000000db1ac180 
GPR28: 0000000000000000 c000000000f812d0 c000000000a84f00 0000000000000000 
NIP [c00000000014e30c] .exit_mmap+0x190/0x1b8
LR [c00000000014e2f8] .exit_mmap+0x17c/0x1b8
Call Trace:
[c0000000db7038a0] [c00000000014e2f8] .exit_mmap+0x17c/0x1b8 (unreliable)
[c0000000db703950] [c0000000000916cc] .mmput+0x54/0x164
[c0000000db7039e0] [c0000000000968d8] .exit_mm+0x17c/0x1a0
[c0000000db703a90] [c000000000098cb8] .do_exit+0x248/0x784
[c0000000db703b70] [c0000000000992a8] .do_group_exit+0xb4/0xe8
[c0000000db703c00] [c0000000000aca2c] .get_signal_to_deliver+0x3ec/0x478
[c0000000db703cf0] [c0000000000134ac] .do_signal+0x6c/0x31c
[c0000000db703e30] [c000000000008b7c] do_work+0x24/0x28
Instruction dump:
7c8407b4 387d0018 4800ab11 60000000 939d0008 7fe3fb78 4bfffdbd 7c7f1b79 
4082fff4 e81b00e8 3120ffff 7c090110 <0b000000> 382100b0 e8010010 eb61ffd8 
---[ end trace ec052ac77a8e7cb4 ]---
Fixing recursive fault but reboot is needed!




--------------020501070806010101090303--
