Return-Path: <sachinp@in.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E979FB7B79
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2009 17:58:28 +1000 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp07.au.ibm.com (8.14.3/8.13.1) with ESMTP id n8O7wQ2N028432
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2009 17:58:26 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8O7wQPM516160
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2009 17:58:26 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8O7wQp0006655
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2009 17:58:26 +1000
Message-ID: <4ABB269F.6020309@in.ibm.com>
Date: Thu, 24 Sep 2009 13:28:23 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Tejun Heo <tj@kernel.org>
Subject: Re: 2.6.31-git5 kernel boot hangs on powerpc
References: <4AB0D947.8010301@in.ibm.com> <4AB214C3.4040109@in.ibm.com>
	<1253185994.8375.352.camel@pasglop>	<4AB25B61.9020609@kernel.org>
	<4AB266AF.9080705@in.ibm.com> <4AB49C37.6020003@in.ibm.com>
	<4AB9DAEC.3060309@in.ibm.com> <4AB9DD8F.1040305@kernel.org>
	<4ABA2DE2.6000601@kernel.org>
In-Reply-To: <4ABA2DE2.6000601@kernel.org>
Content-Type: multipart/mixed; boundary="------------090406030500080600050800"
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------090406030500080600050800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Tejun Heo wrote:
> Can you please apply the attached patch and see whether anything
> interesting shows up in the kernel log?
>   
Thanks Tejun for the debug patch. Attached here are the relevant logs.
The only messages related to percpu in the logs are

<6>PERCPU: Embedded 2 pages/cpu @c000000001200000 s100232 r0 d30840 u524288
<7>pcpu-alloc: s100232 r0 d30840 u524288 alloc=1*1048576
<7>pcpu-alloc: [0] 0 1 

The captured logs are with latest git.

Thanks
-Sachin



--------------090406030500080600050800
Content-Type: text/plain;
 name="dmesg-log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-log"

<4>Crash kernel location must be 0x2000000
<6>Reserving 256MB of memory at 32MB for crashkernel (System RAM: 4096MB)
<6>Phyp-dump disabled at boot time
<6>Using pSeries machine description
<7>Page orders: linear mapping = 16, virtual = 16, io = 12
<6>Using 1TB segments
<4>Found initrd at 0xc000000003500000:0xc000000003ccdf60
<6>bootconsole [udbg0] enabled
<6>Partition configured for 2 cpus.
<6>CPU maps initialized for 2 threads per core
<7> (thread shift is 1)
<4>Starting Linux PPC64 #2 SMP Thu Sep 24 12:59:21 IST 2009
<4>-----------------------------------------------------
<4>ppc64_pft_size                = 0x1a
<4>physicalMemorySize            = 0x100000000
<4>htab_hash_mask                = 0x7ffff
<4>-----------------------------------------------------
<6>Initializing cgroup subsys cpuset
<6>Initializing cgroup subsys cpu
<5>Linux version 2.6.31-git13-autotest (root@mpower6lp5) (gcc version 4.3.2 [gcc-4_3-branch revision 141291] (SUSE Linux) ) #2 SMP Thu Sep 24 12:59:21 IST 2009
<4>[boot]0012 Setup Arch
<7>Node 0 Memory:
<7>Node 2 Memory: 0x0-0xe0000000
<7>Node 3 Memory: 0xe0000000-0x100000000
<4>EEH: No capable adapters found
<6>PPC64 nvram contains 15360 bytes
<7>Using shared processor idle loop
<4>Zone PFN ranges:
<4>  DMA      0x00000000 -> 0x00010000
<4>  Normal   0x00010000 -> 0x00010000
<4>Movable zone start PFN for each node
<4>early_node_map[2] active PFN ranges
<4>    2: 0x00000000 -> 0x0000e000
<4>    3: 0x0000e000 -> 0x00010000
<4>Could not find start_pfn for node 0
<7>On node 0 totalpages: 0
<7>On node 2 totalpages: 57344
<7>  DMA zone: 56 pages used for memmap
<7>  DMA zone: 0 pages reserved
<7>  DMA zone: 57288 pages, LIFO batch:1
<7>On node 3 totalpages: 8192
<7>  DMA zone: 8 pages used for memmap
<7>  DMA zone: 0 pages reserved
<7>  DMA zone: 8184 pages, LIFO batch:0
<4>[boot]0015 Setup Done
<6>PERCPU: Embedded 2 pages/cpu @c000000001200000 s100232 r0 d30840 u524288
<7>pcpu-alloc: s100232 r0 d30840 u524288 alloc=1*1048576
<7>pcpu-alloc: [0] 0 1 
<4>Built 3 zonelists in Node order, mobility grouping on.  Total pages: 65472
<4>Policy zone: DMA
<5>Kernel command line: root=/dev/sda3 sysrq=8 insmod=sym53c8xx insmod=ipr crashkernel=512M-:256M xmon=early 
<6>PID hash table entries: 4096 (order: -1, 32768 bytes)
<4>freeing bootmem node 2
<4>freeing bootmem node 3
<6>Memory: 3896832k/4194304k available (9728k kernel code, 297472k reserved, 3072k data, 4291k bss, 576k init)
<6>SLUB: Genslabs=18, HWalign=128, Order=0-3, MinObjects=0, CPUs=2, Nodes=16
<6>Hierarchical RCU implementation.
<6>RCU-based detection of stalled CPUs is enabled.
<6>NR_IRQS:512
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
<7>irq: irq 2 on host null mapped to virtual irq 16
<7>clockevent: decrementer mult[83126e97] shift[32] cpu[1]
<4>Processor 1 found.
<6>Brought up 2 CPUs
<7>Node 0 CPUs: 0-1
<7>Node 2 CPUs:
<7>Node 3 CPUs:
<7>CPU0 attaching sched-domain:
<7> domain 0: span 0-1 level SIBLING
<7>  groups: 0 (cpu_power = 589) 1 (cpu_power = 589)
<7>  domain 1: span 0-1 level CPU
<7>   groups: 0-1 (cpu_power = 1178)
<7>CPU1 attaching sched-domain:
<7> domain 0: span 0-1 level SIBLING
<7>  groups: 1 (cpu_power = 589) 0 (cpu_power = 589)
<7>  domain 1: span 0-1 level CPU
<7>   groups: 0-1 (cpu_power = 1178)
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
<6>TCP bind hash table entries: 65536 (order: 5, 2097152 bytes)
<6>TCP: Hash tables configured (established 131072 bind 65536)
<6>TCP reno registered
<6>NET: Registered protocol family 1
<6>Unpacking initramfs...
<7>Switched to high resolution mode on CPU 0
<7>Switched to high resolution mode on CPU 1
<7>irq: irq 655360 on host null mapped to virtual irq 17
<7>irq: irq 655367 on host null mapped to virtual irq 18
<6>IOMMU table initialized, virtual merging enabled
<7>irq: irq 589825 on host null mapped to virtual irq 19
<7>RTAS daemon started
<6>audit: initializing netlink socket (disabled)
<5>type=2000 audit(1253778214.210:1): initialized
<6>Kprobe smoke test started
<6>Kprobe smoke test passed successfully
<6>HugeTLB registered 16 MB page size, pre-allocated 0 pages
<6>HugeTLB registered 16 GB page size, pre-allocated 0 pages
<5>VFS: Disk quotas dquot_6.5.2
<4>Dquot-cache hash table entries: 8192 (order 0, 65536 bytes)
<6>Btrfs loaded
<6>msgmni has been set to 7608
<6>alg: No test for stdrng (krng)
<6>Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
<6>io scheduler noop registered
<6>io scheduler anticipatory registered
<6>io scheduler deadline registered
<6>io scheduler cfq registered (default)
<6>pci_hotplug: PCI Hot Plug PCI Core version: 0.5
<6>rpaphp: RPA HOT Plug PCI Controller Driver version: 0.1
<7>vio_register_driver: driver hvc_console registering
<7>HVSI: registered 0 devices
<6>Generic RTC Driver v1.07
<6>Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
<6>pmac_zilog: 0.6 (Benjamin Herrenschmidt <benh@kernel.crashing.org>)
<6>input: Macintosh mouse button emulation as /devices/virtual/input/input0
<6>Uniform Multi-Platform E-IDE driver
<6>ide-gd driver 1.18
<6>IBM eHEA ethernet device driver (Release EHEA_0102)
<7>irq: irq 590088 on host null mapped to virtual irq 264
<6>ehea: eth0: Jumbo frames are disabled
<6>ehea: eth0 -> logical port id #2
<6>ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
<6>ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
<6>mice: PS/2 mouse device common for all mice
<6>EDAC MC: Ver: 2.1.0 Sep 24 2009
<6>usbcore: registered new interface driver hiddev
<6>usbcore: registered new interface driver usbhid
<6>usbhid: v2.6:USB HID core driver
<6>TCP cubic registered
<6>NET: Registered protocol family 15
<4>registered taskstats version 1
<4>Freeing unused kernel memory: 576k freed
<6>SysRq : Changing Loglevel
<4>Loglevel set to 8
<5>SCSI subsystem initialized
<7>vio_register_driver: driver ibmvscsi registering
<6>ibmvscsi 30000007: SRP_VERSION: 16.a
<6>scsi0 : IBM POWER Virtual SCSI Adapter 1.5.8
<6>ibmvscsi 30000007: partner initialization complete
<6>ibmvscsi 30000007: host srp version: 16.a, host partition VIO Server (1), OS 3, max io 1048576
<6>ibmvscsi 30000007: Client reserve enabled
<6>ibmvscsi 30000007: sent SRP login
<6>ibmvscsi 30000007: SRP_LOGIN succeeded
<5>scsi 0:0:1:0: Direct-Access     AIX      VDASD            0001 PQ: 0 ANSI: 3
<5>scsi 0:0:2:0: CD-ROM            AIX      VOPTA                 PQ: 0 ANSI: 4
<6>udevd version 128 started
<5>sd 0:0:1:0: [sda] 146800640 512-byte logical blocks: (75.1 GB/70.0 GiB)
<5>sd 0:0:1:0: [sda] Write Protect is off
<7>sd 0:0:1:0: [sda] Mode Sense: 17 00 00 08
<5>sd 0:0:1:0: [sda] Cache data unavailable
<3>sd 0:0:1:0: [sda] Assuming drive cache: write through
<5>sd 0:0:1:0: [sda] Cache data unavailable
<3>sd 0:0:1:0: [sda] Assuming drive cache: write through
<6> sda: sda1 sda2 sda3
<5>sd 0:0:1:0: [sda] Cache data unavailable
<3>sd 0:0:1:0: [sda] Assuming drive cache: write through
<5>sd 0:0:1:0: [sda] Attached SCSI disk
<6>kjournald starting.  Commit interval 5 seconds
<6>EXT3 FS on sda3, internal journal
<6>EXT3-fs: mounted filesystem with writeback data mode.
<6>udevd version 128 started
<5>sd 0:0:1:0: Attached scsi generic sg0 type 0
<5>scsi 0:0:2:0: Attached scsi generic sg1 type 5
<4>sr0: scsi-1 drive
<6>Uniform CD-ROM driver Revision: 3.20
<7>sr 0:0:2:0: Attached scsi CD-ROM sr0
<6>Adding 2096320k swap on /dev/sda2.  Priority:-1 extents:1 across:2096320k 
<6>device-mapper: uevent: version 1.0.3
<6>device-mapper: ioctl: 4.15.0-ioctl (2009-04-01) initialised: dm-devel@redhat.com
<6>loop: module loaded
<6>fuse init (API version 7.13)
<7>irq: irq 33539 on host null mapped to virtual irq 259
<6>ehea: eth0: Physical port up
<6>ehea: External switch port is backup port
<7>irq: irq 33540 on host null mapped to virtual irq 260
<6>NET: Registered protocol family 10
<3>INFO: RCU detected CPU 0 stall (t=1000 jiffies)


--------------090406030500080600050800--
