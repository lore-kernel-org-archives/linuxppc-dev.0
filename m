Return-Path: <sachinp@in.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1F6D1B7B65
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 18:37:10 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp06.au.ibm.com (8.14.3/8.13.1) with ESMTP id nAH7b8qf014101
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 18:37:08 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nAH7XmGj790636
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 18:33:48 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nAH7b9uo007309
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 18:37:09 +1100
Message-ID: <4B02529F.1060801@in.ibm.com>
Date: Tue, 17 Nov 2009 13:07:03 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: dwg@au1.ibm.com
Subject: Re: [powerpc] Next tree Nov 2 : kernel BUG at mm/mmap.c:2135!
References: <20091102173845.210d1c57.sfr@canb.auug.org.au>
	<4AEEA279.4040106@in.ibm.com> <4AF175D4.7030507@in.ibm.com>
	<20091105001650.GD3613@yookeroo.seuss>
	<4AFBEE98.2070208@in.ibm.com>
	<20091113013729.GB18848@yookeroo.seuss>
	<20091113021048.GA4865@yookeroo.seuss>
	<4AFD2865.5090503@in.ibm.com> <20091117052542.GB2576@yookeroo>
In-Reply-To: <20091117052542.GB2576@yookeroo>
Content-Type: multipart/mixed; boundary="------------090206040300020208010305"
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>, linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------090206040300020208010305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

David Gibson wrote:
> Hrm.  Ok.  I am truly baffled.  Well, below is a revised debug patch
> which I hope will shed some sort of light on things.  I do also notice
>   
Thanks for the debug patch. I have attached the collected information.

> from your full log that it looks like the bug is happening shortly
> after we start userspace.  So it may be differences in my userspace
> set up that meant I haven't been able to reproduce it.  I'll have
> another look at that when I get a chance.
>   
Let me know if you need access to the system on which i can recreate the
bug. I can make that system available for you to debug this issue.

Thanks
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------


--------------090206040300020208010305
Content-Type: text/plain;
 name="dmesg-log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-log"

------------[ cut here ]------------
kernel BUG at mm/mmap.c:2142!
cpu 0x3: Vector: 700 (Program Check) at [c0000000fae2b7e0]
    pc: c0000000001510d0: .exit_mmap+0x1dc/0x204
    lr: c0000000001510c0: .exit_mmap+0x1cc/0x204
    sp: c0000000fae2ba60
   msr: 8000000000029032
  current = 0xc0000000fad98be0
  paca    = 0xc000000000bb2c00
    pid   = 84, comm = cat
kernel BUG at mm/mmap.c:2142!
enter ? for help
[c0000000fae2bb10] c000000000093e28 .mmput+0x54/0x164
[c0000000fae2bba0] c000000000099034 .exit_mm+0x17c/0x1a0
[c0000000fae2bc50] c00000000009b414 .do_exit+0x248/0x784
[c0000000fae2bd30] c00000000009ba04 .do_group_exit+0xb4/0xe8
[c0000000fae2bdc0] c00000000009ba4c .SyS_exit_group+0x14/0x28
[c0000000fae2be30] c0000000000085b4 syscall_exit+0x0/0x40
--- Exception: c01 (System Call) at 00000fff9604ff40
SP (fffed84bae0) is in userspace
3:mon> dl
<4>Crash kernel location must be 0x2000000
<6>Reserving 256MB of memory at 32MB for crashkernel (System RAM: 4096MB)
<6>Using pSeries machine description
<7>Page orders: linear mapping = 24, virtual = 16, io = 12
<6>Using 1TB segments
<4>Found initrd at 0xc0000000034d0000:0xc000000003cf89c1
<6>bootconsole [udbg0] enabled
<6>Partition configured for 4 cpus.
<6>CPU maps initialized for 2 threads per core
<7> (thread shift is 1)
<4>Starting Linux PPC64 #6 SMP Tue Nov 17 12:51:36 IST 2009
<4>-----------------------------------------------------
<4>ppc64_pft_size                = 0x1a
<4>physicalMemorySize            = 0x100000000
<4>htab_hash_mask                = 0x7ffff
<4>-----------------------------------------------------
<6>Initializing cgroup subsys cpuset
<6>Initializing cgroup subsys cpu
<5>Linux version 2.6.32-rc7-next-20091116 (root@llm62) (gcc version 4.3.2 [gcc-4_3-branch revision 141291] (SUSE Linux) ) #6 SMP Tue Nov 17 12:51:36 IST 2009
<4>[boot]0012 Setup Arch
<7>Node 0 Memory:
<7>Node 1 Memory: 0x0-0x100000000
<4>EEH: No capable adapters found
<6>PPC64 nvram contains 15360 bytes
<7>Using shared processor idle loop
<4>Zone PFN ranges:
<4>  DMA      0x00000000 -> 0x00010000
<4>  Normal   0x00010000 -> 0x00010000
<4>Movable zone start PFN for each node
<4>early_node_map[1] active PFN ranges
<4>    1: 0x00000000 -> 0x00010000
<4>Could not find start_pfn for node 0
<7>On node 0 totalpages: 0
<7>On node 1 totalpages: 65536
<7>  DMA zone: 56 pages used for memmap
<7>  DMA zone: 0 pages reserved
<7>  DMA zone: 65480 pages, LIFO batch:1
<4>[boot]0015 Setup Done
<6>PERCPU: Embedded 2 pages/cpu @c000000000f00000 s89000 r0 d42072 u262144
<6>pcpu-alloc: s89000 r0 d42072 u262144 alloc=1*1048576
<6>pcpu-alloc: [0] 0 1 2 3 
<4>Built 2 zonelists in Node order, mobility grouping on.  Total pages: 65480
<4>Policy zone: DMA
<5>Kernel command line: root=/dev/sda5 sysrq=1 insmod=sym53c8xx insmod=ipr crashkernel=512M-:256M xmon=on 
<6>PID hash table entries: 4096 (order: -1, 32768 bytes)
<4>freeing bootmem node 1
<6>Memory: 3899712k/4194304k available (9216k kernel code, 294592k reserved, 2688k data, 2370k bss, 640k init)
<6>Hierarchical RCU implementation.
<6>RCU-based detection of stalled CPUs is enabled.
<6>NR_IRQS:512 nr_irqs:512
<4>[boot]0020 XICS Init
<4>[boot]0021 XICS Done
<7>pic: no ISA interrupt controller
<7>time_init: decrementer frequency = 512.000000 MHz
<7>time_init: processor frequency   = 4704.000000 MHz
<6>clocksource: timebase mult[7d0000] shift[22] registered
<7>clockevent: decrementer mult[83126e97] shift[32] cpu[0]
<4>Console: colour dummy device 80x25
<6>console [hvc0] enabled, bootconsole disabled
<6>allocated 2621440 bytes of page_cgroup
<6>please try 'cgroup_disable=memory' option if you don't want memory cgroups
<6>Security Framework initialized
<6>SELinux:  Disabled at boot.
<6>Dentry cache hash table entries: 524288 (order: 6, 4194304 bytes)
<6>Inode-cache hash table entries: 262144 (order: 5, 2097152 bytes)
<4>Mount-cache hash table entries: 4096
<6>Initializing cgroup subsys ns
<6>Initializing cgroup subsys cpuacct
<6>Initializing cgroup subsys memory
<6>Initializing cgroup subsys devices
<6>Initializing cgroup subsys freezer
<7>  alloc irq_desc for 16 on node 0
<7>  alloc kstat_irqs on node 0
<7>irq: irq 2 on host null mapped to virtual irq 16
<7>clockevent: decrementer mult[83126e97] shift[32] cpu[1]
<4>Processor 1 found.
<7>clockevent: decrementer mult[83126e97] shift[32] cpu[2]
<4>Processor 2 found.
<7>clockevent: decrementer mult[83126e97] shift[32] cpu[3]
<4>Processor 3 found.
<6>Brought up 4 CPUs
<7>Node 0 CPUs: 0-3
<7>Node 1 CPUs:
<7>CPU0 attaching sched-domain:
<7> domain 0: span 0-1 level SIBLING
<7>  groups: 0 (cpu_power = 589) 1 (cpu_power = 589)
<7>  domain 1: span 0-3 level CPU
<7>   groups: 0-1 (cpu_power = 1178) 2-3 (cpu_power = 1178)
<7>CPU1 attaching sched-domain:
<7> domain 0: span 0-1 level SIBLING
<7>  groups: 1 (cpu_power = 589) 0 (cpu_power = 589)
<7>  domain 1: span 0-3 level CPU
<7>   groups: 0-1 (cpu_power = 1178) 2-3 (cpu_power = 1178)
<7>CPU2 attaching sched-domain:
<7> domain 0: span 2-3 level SIBLING
<7>  groups: 2 (cpu_power = 589) 3 (cpu_power = 589)
<7>  domain 1: span 0-3 level CPU
<7>   groups: 2-3 (cpu_power = 1178) 0-1 (cpu_power = 1178)
<7>CPU3 attaching sched-domain:
<7> domain 0: span 2-3 level SIBLING
<7>  groups: 3 (cpu_power = 589) 2 (cpu_power = 589)
<7>  domain 1: span 0-3 level CPU
<7>   groups: 2-3 (cpu_power = 1178) 0-1 (cpu_power = 1178)
<6>NET: Registered protocol family 16
<6>IBM eBus Device Driver
<6>POWER6 performance monitor hardware support registered
<6>PCI: Probing PCI hardware
<7>PCI: Probing PCI hardware done
<4>bio: create slab <bio-0> at 0
<6>vgaarb: loaded
<6>usbcore: registered new interface driver usbfs
<6>usbcore: registered new interface driver hub
<6>usbcore: registered new device driver usb
<6>Switching to clocksource timebase
<6>NET: Registered protocol family 2
<6>IP route cache hash table entries: 32768 (order: 2, 262144 bytes)
<6>TCP established hash table entries: 131072 (order: 5, 2097152 bytes)
<6>TCP bind hash table entries: 65536 (order: 4, 1048576 bytes)
<6>TCP: Hash tables configured (established 131072 bind 65536)
<6>TCP reno registered
<6>UDP hash table entries: 2048 (order: 0, 65536 bytes)
<6>UDP-Lite hash table entries: 2048 (order: 0, 65536 bytes)
<6>NET: Registered protocol family 1
<7>PCI: CLS 0 bytes, default 128
<6>Unpacking initramfs...
<7>RTAS daemon started
<7>  alloc irq_desc for 17 on node 0
<7>  alloc kstat_irqs on node 0
<7>irq: irq 655360 on host null mapped to virtual irq 17
<7>  alloc irq_desc for 18 on node 0
<7>  alloc kstat_irqs on node 0
<7>irq: irq 655362 on host null mapped to virtual irq 18
<6>IOMMU table initialized, virtual merging enabled
<7>  alloc irq_desc for 19 on node 0
<7>  alloc kstat_irqs on node 0
<7>irq: irq 589825 on host null mapped to virtual irq 19
<6>audit: initializing netlink socket (disabled)
<5>type=2000 audit(1258442853.220:1): initialized
<1>rcu-torture:--- Start of test: nreaders=8 nfakewriters=4 stat_interval=0 verbose=0 test_no_idle_hz=0 shuffle_interval=3 stutter=5 irqreader=1
<6>HugeTLB registered 16 MB page size, pre-allocated 0 pages
<6>HugeTLB registered 16 GB page size, pre-allocated 0 pages
<5>VFS: Disk quotas dquot_6.5.2
<4>Dquot-cache hash table entries: 8192 (order 0, 65536 bytes)
<6>msgmni has been set to 7616
<6>alg: No test for stdrng (krng)
<6>Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
<6>io scheduler noop registered
<6>io scheduler deadline registered
<6>io scheduler cfq registered (default)
<6>pci_hotplug: PCI Hot Plug PCI Core version: 0.5
<6>pciehp: PCI Express Hot Plug Controller Driver version: 0.4
<6>rpaphp: RPA HOT Plug PCI Controller Driver version: 0.1
<7>vio_register_driver: driver hvc_console registering
<7>HVSI: registered 0 devices
<6>Generic RTC Driver v1.07
<6>Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
<6>pmac_zilog: 0.6 (Benjamin Herrenschmidt <benh@kernel.crashing.org>)
<6>input: Macintosh mouse button emulation as /devices/virtual/input/input0
<6>Uniform Multi-Platform E-IDE driver
<6>ide-gd driver 1.18
<6>ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
<6>ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
<6>mice: PS/2 mouse device common for all mice
<6>EDAC MC: Ver: 2.1.0 Nov 16 2009
<6>usbcore: registered new interface driver hiddev
<6>usbcore: registered new interface driver usbhid
<6>usbhid: USB HID core driver
<6>TCP cubic registered
<6>NET: Registered protocol family 15
<4>registered taskstats version 1
<4>Freeing unused kernel memory: 640k freed
<4>__pte_alloc() -> mm c0000000fa9f0180 addr 0xffffffffff2 nr_ptes 1
<4>__pte_alloc() -> mm c0000000fa9f0180 addr 0x419cacb8 nr_ptes 2
<4>__pte_alloc() -> mm c0000000fa9f0180 addr 0xfff886daf30 nr_ptes 3
<4>__pte_alloc() -> mm c0000000fa9f0580 addr 0x419b0000 nr_ptes 1
<4>__pte_alloc() -> mm c0000000fa9f0580 addr 0xfff88370000 nr_ptes 2
<4>__pte_alloc() -> mm c0000000fa9f0580 addr 0xffff03d0000 nr_ptes 3
<4>__pte_alloc() -> mm c0000000fa9f0980 addr 0xfffffffffed nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f0580 addr 0x40000000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f0580 addr 0xfff80000000 nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f0580 addr 0xffff0000000 nr_ptes 0
<4>__pte_alloc() -> mm c0000000fa9f0980 addr 0xfffd45b0000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f0980 addr 0xffff0000000 nr_ptes 1
<4>__pte_alloc() -> mm c0000000fa9f0980 addr 0x10029a80 nr_ptes 2
<4>__pte_alloc() -> mm c0000000fa9f0980 addr 0xfff7dd5af30 nr_ptes 3
<4>free_pte_range() -> mm c0000000fa9f0980 addr 0x10000000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f0980 addr 0xfff70000000 nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f0980 addr 0xfffd0000000 nr_ptes 0
<4>__pte_alloc() -> mm c0000000fa9f0d80 addr 0x419b0000 nr_ptes 1
<4>__pte_alloc() -> mm c0000000fa9f0d80 addr 0xfff88370000 nr_ptes 2
<4>__pte_alloc() -> mm c0000000fa9f0d80 addr 0xffff03d0000 nr_ptes 3
<4>__pte_alloc() -> mm c0000000fa9f1180 addr 0xfffffffffed nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f0d80 addr 0x40000000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f0d80 addr 0xfff80000000 nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f0d80 addr 0xffff0000000 nr_ptes 0
<4>__pte_alloc() -> mm c0000000fa9f1180 addr 0xfffe4880000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f1180 addr 0xffff0000000 nr_ptes 1
<4>__pte_alloc() -> mm c0000000fa9f1180 addr 0x10029a80 nr_ptes 2
<4>__pte_alloc() -> mm c0000000fa9f1180 addr 0xfff97f3af30 nr_ptes 3
<4>free_pte_range() -> mm c0000000fa9f1180 addr 0x10000000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f1180 addr 0xfff90000000 nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f1180 addr 0xfffe0000000 nr_ptes 0
<4>__pte_alloc() -> mm c0000000fa9f1580 addr 0x419b0000 nr_ptes 1
<4>__pte_alloc() -> mm c0000000fa9f1580 addr 0xfff88370000 nr_ptes 2
<4>__pte_alloc() -> mm c0000000fa9f1580 addr 0xffff03d0000 nr_ptes 3
<4>__pte_alloc() -> mm c0000000fa9f1980 addr 0xfffffffffed nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f1580 addr 0x40000000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f1580 addr 0xfff80000000 nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f1580 addr 0xffff0000000 nr_ptes 0
<4>__pte_alloc() -> mm c0000000fa9f1980 addr 0xfffd1700000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f1980 addr 0xffff0000000 nr_ptes 1
<4>__pte_alloc() -> mm c0000000fa9f1980 addr 0x10029a80 nr_ptes 2
<4>__pte_alloc() -> mm c0000000fa9f1980 addr 0xfff9d31af30 nr_ptes 3
<4>free_pte_range() -> mm c0000000fa9f1980 addr 0x10000000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f1980 addr 0xfff90000000 nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f1980 addr 0xfffd0000000 nr_ptes 0
<4>__pte_alloc() -> mm c0000000fa9f1d80 addr 0x419b0000 nr_ptes 1
<4>__pte_alloc() -> mm c0000000fa9f1d80 addr 0xfff88370000 nr_ptes 2
<4>__pte_alloc() -> mm c0000000fa9f1d80 addr 0xffff03d0000 nr_ptes 3
<4>__pte_alloc() -> mm c0000000fa9f2180 addr 0xfffffffffed nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f1d80 addr 0x40000000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f1d80 addr 0xfff80000000 nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f1d80 addr 0xffff0000000 nr_ptes 0
<4>__pte_alloc() -> mm c0000000fa9f2180 addr 0xfffdad00000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f2180 addr 0xffff0000000 nr_ptes 1
<4>__pte_alloc() -> mm c0000000fa9f2180 addr 0x10017830 nr_ptes 2
<4>__pte_alloc() -> mm c0000000fa9f2180 addr 0xfff93bfaf30 nr_ptes 3
<4>free_pte_range() -> mm c0000000fa9f2180 addr 0x10000000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f2180 addr 0xfff90000000 nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f2180 addr 0xfffd0000000 nr_ptes 0
<4>__pte_alloc() -> mm c0000000fa9f2580 addr 0x419b0000 nr_ptes 1
<4>__pte_alloc() -> mm c0000000fa9f2580 addr 0xfff88370000 nr_ptes 2
<4>__pte_alloc() -> mm c0000000fa9f2580 addr 0xffff03d0000 nr_ptes 3
<4>__pte_alloc() -> mm c0000000fa9f2980 addr 0xfffffffffed nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f2580 addr 0x40000000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f2580 addr 0xfff80000000 nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f2580 addr 0xffff0000000 nr_ptes 0
<4>__pte_alloc() -> mm c0000000fa9f2980 addr 0xfffd9b10000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f2980 addr 0xffff0000000 nr_ptes 1
<4>__pte_alloc() -> mm c0000000fa9f2980 addr 0x10017830 nr_ptes 2
<4>__pte_alloc() -> mm c0000000fa9f2980 addr 0xfff9a09af30 nr_ptes 3
<4>free_pte_range() -> mm c0000000fa9f2980 addr 0x10000000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f2980 addr 0xfff90000000 nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f2980 addr 0xfffd0000000 nr_ptes 0
<4>__pte_alloc() -> mm c0000000fa9f2d80 addr 0x419b0000 nr_ptes 1
<4>__pte_alloc() -> mm c0000000fa9f2d80 addr 0xfff88370000 nr_ptes 2
<4>__pte_alloc() -> mm c0000000fa9f2d80 addr 0xffff03d0000 nr_ptes 3
<4>__pte_alloc() -> mm c0000000fa9f3180 addr 0xfffffffffed nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f2d80 addr 0x40000000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f2d80 addr 0xfff80000000 nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f2d80 addr 0xffff0000000 nr_ptes 0
<4>__pte_alloc() -> mm c0000000fa9f3180 addr 0xfffc0dc0000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f3180 addr 0xffff0000000 nr_ptes 1
<4>__pte_alloc() -> mm c0000000fa9f3180 addr 0x10017830 nr_ptes 2
<4>__pte_alloc() -> mm c0000000fa9f3180 addr 0xfff7bb1af30 nr_ptes 3
<4>free_pte_range() -> mm c0000000fa9f3180 addr 0x10000000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f3180 addr 0xfff70000000 nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f3180 addr 0xfffc0000000 nr_ptes 0
<4>__pte_alloc() -> mm c0000000fa9f3580 addr 0x419b0000 nr_ptes 1
<4>__pte_alloc() -> mm c0000000fa9f3580 addr 0xfff88370000 nr_ptes 2
<4>__pte_alloc() -> mm c0000000fa9f3580 addr 0xffff03d0000 nr_ptes 3
<4>__pte_alloc() -> mm c0000000fa9f3980 addr 0xfffffffffed nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f3580 addr 0x40000000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f3580 addr 0xfff80000000 nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f3580 addr 0xffff0000000 nr_ptes 0
<4>__pte_alloc() -> mm c0000000fa9f3980 addr 0xfffe80f0000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f3980 addr 0xffff0000000 nr_ptes 1
<4>__pte_alloc() -> mm c0000000fa9f3980 addr 0x10017830 nr_ptes 2
<4>__pte_alloc() -> mm c0000000fa9f3980 addr 0xfff9a73af30 nr_ptes 3
<4>free_pte_range() -> mm c0000000fa9f3980 addr 0x10000000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f3980 addr 0xfff90000000 nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f3980 addr 0xfffe0000000 nr_ptes 0
<4>__pte_alloc() -> mm c0000000fa9f3d80 addr 0x419b0000 nr_ptes 1
<4>__pte_alloc() -> mm c0000000fa9f3d80 addr 0xfff88370000 nr_ptes 2
<4>__pte_alloc() -> mm c0000000fa9f3d80 addr 0xffff03d0000 nr_ptes 3
<4>__pte_alloc() -> mm c0000000fa9f4180 addr 0xfffffffffed nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f3d80 addr 0x40000000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f3d80 addr 0xfff80000000 nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f3d80 addr 0xffff0000000 nr_ptes 0
<4>__pte_alloc() -> mm c0000000fa9f4180 addr 0xfffc0650000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f4180 addr 0xffff0000000 nr_ptes 1
<4>__pte_alloc() -> mm c0000000fa9f4180 addr 0x10017830 nr_ptes 2
<4>__pte_alloc() -> mm c0000000fa9f4180 addr 0xfffa335af30 nr_ptes 3
<4>free_pte_range() -> mm c0000000fa9f4180 addr 0x10000000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f4180 addr 0xfffa0000000 nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f4180 addr 0xfffc0000000 nr_ptes 0
<4>__pte_alloc() -> mm c0000000fa9f4580 addr 0x419b0000 nr_ptes 1
<4>__pte_alloc() -> mm c0000000fa9f4580 addr 0xfff88370000 nr_ptes 2
<4>__pte_alloc() -> mm c0000000fa9f4580 addr 0xffff03d0000 nr_ptes 3
<4>__pte_alloc() -> mm c0000000fa9f4980 addr 0xfffffffffed nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f4580 addr 0x40000000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f4580 addr 0xfff80000000 nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f4580 addr 0xffff0000000 nr_ptes 0
<4>__pte_alloc() -> mm c0000000fa9f4980 addr 0xfffe5970000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f4980 addr 0xffff0000000 nr_ptes 1
<4>__pte_alloc() -> mm c0000000fa9f4980 addr 0x10017830 nr_ptes 2
<4>__pte_alloc() -> mm c0000000fa9f4980 addr 0xfff812daf30 nr_ptes 3
<4>free_pte_range() -> mm c0000000fa9f4980 addr 0x10000000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f4980 addr 0xfff80000000 nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f4980 addr 0xfffe0000000 nr_ptes 0
<4>__pte_alloc() -> mm c0000000fa9f4d80 addr 0x419b0000 nr_ptes 1
<4>__pte_alloc() -> mm c0000000fa9f4d80 addr 0xfff88370000 nr_ptes 2
<4>__pte_alloc() -> mm c0000000fa9f4d80 addr 0xffff03d0000 nr_ptes 3
<4>__pte_alloc() -> mm c0000000fa9f5180 addr 0xfffffffffed nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f4d80 addr 0x40000000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f4d80 addr 0xfff80000000 nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f4d80 addr 0xffff0000000 nr_ptes 0
<4>__pte_alloc() -> mm c0000000fa9f5180 addr 0xfffd0950000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f5180 addr 0xffff0000000 nr_ptes 1
<4>__pte_alloc() -> mm c0000000fa9f5180 addr 0x10017830 nr_ptes 2
<4>__pte_alloc() -> mm c0000000fa9f5180 addr 0xfff9865af30 nr_ptes 3
<4>free_pte_range() -> mm c0000000fa9f5180 addr 0x10000000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f5180 addr 0xfff90000000 nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f5180 addr 0xfffd0000000 nr_ptes 0
<4>__pte_alloc() -> mm c0000000fa9f5580 addr 0x419b0000 nr_ptes 1
<4>__pte_alloc() -> mm c0000000fa9f5580 addr 0xfff88370000 nr_ptes 2
<4>__pte_alloc() -> mm c0000000fa9f5580 addr 0xffff03d0000 nr_ptes 3
<4>__pte_alloc() -> mm c0000000fa9f5980 addr 0xfffffffffed nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f5580 addr 0x40000000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f5580 addr 0xfff80000000 nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f5580 addr 0xffff0000000 nr_ptes 0
<4>__pte_alloc() -> mm c0000000fa9f5980 addr 0xfffea6f0000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f5980 addr 0xffff0000000 nr_ptes 1
<4>__pte_alloc() -> mm c0000000fa9f5980 addr 0x10017830 nr_ptes 2
<4>__pte_alloc() -> mm c0000000fa9f5980 addr 0xfff9575af30 nr_ptes 3
<4>free_pte_range() -> mm c0000000fa9f5980 addr 0x10000000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f5980 addr 0xfff90000000 nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f5980 addr 0xfffe0000000 nr_ptes 0
<4>__pte_alloc() -> mm c0000000fa9f5d80 addr 0x419b0000 nr_ptes 1
<4>__pte_alloc() -> mm c0000000fa9f5d80 addr 0xfff88370000 nr_ptes 2
<4>__pte_alloc() -> mm c0000000fa9f5d80 addr 0xffff03d0000 nr_ptes 3
<4>__pte_alloc() -> mm c0000000fa9f6180 addr 0xfffffffffed nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f5d80 addr 0x40000000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f5d80 addr 0xfff80000000 nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f5d80 addr 0xffff0000000 nr_ptes 0
<4>__pte_alloc() -> mm c0000000fa9f6180 addr 0xfffe6650000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f6180 addr 0xffff0000000 nr_ptes 1
<4>__pte_alloc() -> mm c0000000fa9f6180 addr 0x10018960 nr_ptes 2
<4>__pte_alloc() -> mm c0000000fa9f6180 addr 0xfffaf91af30 nr_ptes 3
<4>free_pte_range() -> mm c0000000fa9f6180 addr 0x10000000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f6180 addr 0xfffa0000000 nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f6180 addr 0xfffe0000000 nr_ptes 0
<4>__pte_alloc() -> mm c0000000fa9f6580 addr 0x419b0000 nr_ptes 1
<4>__pte_alloc() -> mm c0000000fa9f6580 addr 0xfff88370000 nr_ptes 2
<4>__pte_alloc() -> mm c0000000fa9f6580 addr 0xffff03d0000 nr_ptes 3
<4>__pte_alloc() -> mm c0000000fa9f6980 addr 0xfffffffffed nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f6580 addr 0x40000000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f6580 addr 0xfff80000000 nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f6580 addr 0xffff0000000 nr_ptes 0
<4>__pte_alloc() -> mm c0000000fa9f6980 addr 0xfffcbcf0000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f6980 addr 0xffff0000000 nr_ptes 1
<4>__pte_alloc() -> mm c0000000fa9f6980 addr 0x10018960 nr_ptes 2
<4>__pte_alloc() -> mm c0000000fa9f6980 addr 0xfff9589af30 nr_ptes 3
<4>free_pte_range() -> mm c0000000fa9f6980 addr 0x10000000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f6980 addr 0xfff90000000 nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f6980 addr 0xfffc0000000 nr_ptes 0
<4>__pte_alloc() -> mm c0000000fa9f6d80 addr 0x419b0000 nr_ptes 1
<4>__pte_alloc() -> mm c0000000fa9f6d80 addr 0xfff88370000 nr_ptes 2
<4>__pte_alloc() -> mm c0000000fa9f6d80 addr 0xffff03d0000 nr_ptes 3
<4>__pte_alloc() -> mm c0000000fa9f7180 addr 0xffffffffff0 nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f6d80 addr 0x40000000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f6d80 addr 0xfff80000000 nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f6d80 addr 0xffff0000000 nr_ptes 0
<4>__pte_alloc() -> mm c0000000fa9f7180 addr 0xfffe0660000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f7180 addr 0xffff0000000 nr_ptes 1
<4>__pte_alloc() -> mm c0000000fa9f7180 addr 0x1001be48 nr_ptes 2
<4>__pte_alloc() -> mm c0000000fa9f7180 addr 0xfffb65faf30 nr_ptes 3
<4>free_pte_range() -> mm c0000000fa9f7180 addr 0x10000000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f7180 addr 0xfffb0000000 nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f7180 addr 0xfffe0000000 nr_ptes 0
<4>__pte_alloc() -> mm c0000000fa9f7580 addr 0x419b0000 nr_ptes 1
<4>__pte_alloc() -> mm c0000000fa9f7580 addr 0xfff88370000 nr_ptes 2
<4>__pte_alloc() -> mm c0000000fa9f7580 addr 0xffff03d0000 nr_ptes 3
<4>__pte_alloc() -> mm c0000000fa9f7980 addr 0xffffffffff0 nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f7580 addr 0x40000000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f7580 addr 0xfff80000000 nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f7580 addr 0xffff0000000 nr_ptes 0
<4>__pte_alloc() -> mm c0000000fa9f7980 addr 0xfffec320000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f7980 addr 0xffff0000000 nr_ptes 1
<4>__pte_alloc() -> mm c0000000fa9f7980 addr 0x1001be48 nr_ptes 2
<4>__pte_alloc() -> mm c0000000fa9f7980 addr 0xfffa1ebaf30 nr_ptes 3
<4>free_pte_range() -> mm c0000000fa9f7980 addr 0x10000000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f7980 addr 0xfffa0000000 nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f7980 addr 0xfffe0000000 nr_ptes 0
<4>__pte_alloc() -> mm c0000000fa9f7d80 addr 0x419b0000 nr_ptes 1
<4>__pte_alloc() -> mm c0000000fa9f7d80 addr 0xfff88370000 nr_ptes 2
<4>__pte_alloc() -> mm c0000000fa9f7d80 addr 0xffff03d0000 nr_ptes 3
<4>__pte_alloc() -> mm c0000000fa9f8180 addr 0xffffffffff0 nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f7d80 addr 0x40000000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f7d80 addr 0xfff80000000 nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f7d80 addr 0xffff0000000 nr_ptes 0
<4>__pte_alloc() -> mm c0000000fa9f8180 addr 0xfffcdb20000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f8180 addr 0xffff0000000 nr_ptes 1
<4>__pte_alloc() -> mm c0000000fa9f8180 addr 0x1001be48 nr_ptes 2
<4>__pte_alloc() -> mm c0000000fa9f8180 addr 0xfff9a19af30 nr_ptes 3
<4>free_pte_range() -> mm c0000000fa9f8180 addr 0x10000000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f8180 addr 0xfff90000000 nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f8180 addr 0xfffc0000000 nr_ptes 0
<4>__pte_alloc() -> mm c0000000fa9f8580 addr 0x419b0000 nr_ptes 1
<4>__pte_alloc() -> mm c0000000fa9f8580 addr 0xfff88370000 nr_ptes 2
<4>__pte_alloc() -> mm c0000000fa9f8580 addr 0xffff03d0000 nr_ptes 3
<4>__pte_alloc() -> mm c0000000fa9f8980 addr 0xffffffffff0 nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f8580 addr 0x40000000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f8580 addr 0xfff80000000 nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f8580 addr 0xffff0000000 nr_ptes 0
<4>__pte_alloc() -> mm c0000000fa9f8980 addr 0xfffcc8a0000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f8980 addr 0xffff0000000 nr_ptes 1
<4>__pte_alloc() -> mm c0000000fa9f8980 addr 0x1001be48 nr_ptes 2
<4>__pte_alloc() -> mm c0000000fa9f8980 addr 0xfffa7dbaf30 nr_ptes 3
<4>free_pte_range() -> mm c0000000fa9f8980 addr 0x10000000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f8980 addr 0xfffa0000000 nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f8980 addr 0xfffc0000000 nr_ptes 0
<4>__pte_alloc() -> mm c0000000fa9f8d80 addr 0x419b0000 nr_ptes 1
<4>__pte_alloc() -> mm c0000000fa9f8d80 addr 0xfff88370000 nr_ptes 2
<4>__pte_alloc() -> mm c0000000fa9f8d80 addr 0xffff03d0000 nr_ptes 3
<4>__pte_alloc() -> mm c0000000fa9f9180 addr 0x419b0000 nr_ptes 1
<4>__pte_alloc() -> mm c0000000fa9f9180 addr 0xfff88370000 nr_ptes 2
<4>__pte_alloc() -> mm c0000000fa9f9180 addr 0xffff03d0000 nr_ptes 3
<4>__pte_alloc() -> mm c0000000fa9f9580 addr 0xfffffffffef nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f9180 addr 0x40000000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f9180 addr 0xfff80000000 nr_ptes 1
<4>free_pte_range() -> mm c0000000fa9f9180 addr 0xffff0000000 nr_ptes 0
<4>__pte_alloc() -> mm c0000000fa9f9580 addr 0xfffed840000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f9580 addr 0xffff0000000 nr_ptes 1
<4>__pte_alloc() -> mm c0000000fa9f9580 addr 0x1001bae0 nr_ptes 2
<4>__pte_alloc() -> mm c0000000fa9f9580 addr 0xfff9619af30 nr_ptes 3
<4>free_pte_range() -> mm c0000000fa9f9580 addr 0xfff90000000 nr_ptes 2
<4>free_pte_range() -> mm c0000000fa9f9580 addr 0xfffe0000000 nr_ptes 1
<7>exit_mmap(): mm c0000000fa9f9580 nr_ptes 1
<4>exit_mmap(): mm c0000000fa9f9580 nr_ptes 1 current c0000000fad98be0 pid 84 comm "cat"
<0>------------[ cut here ]------------
<2>kernel BUG at mm/mmap.c:2142!
3:mon>



--------------090206040300020208010305--
