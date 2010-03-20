Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F3B4CB7CF0
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Mar 2010 08:05:38 +1100 (EST)
Subject: Re: 2.6.34-rc2 fails to boot on powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sachin Sant <sachinp@in.ibm.com>
In-Reply-To: <4BA4F96A.5060703@in.ibm.com>
References: <4BA4F96A.5060703@in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 21 Mar 2010 08:05:23 +1100
Message-ID: <1269119123.8599.66.camel@pasglop>
Mime-Version: 1.0
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2010-03-20 at 22:05 +0530, Sachin Sant wrote:
> 2.6.34-rc2 fails to boot on number of PowerPC boxes. The boot
> hangs with the following messages :

Appears to be a regression in hvc_console caused by
e74d098c66543d0731de62eb747ccd5b636a6f4c. I'm working on it.

Cheers,
Ben.

> /sbin/fsck.ext3 (1) -- /] fsck.ext3 -a /dev/sda5 
> /dev/sda5: clean, 726435/3948544 files, 9655477/15773808 blocks
> fsck succeeded. Mounting root device read-write.
> Mounting root /dev/sda5
> mount -o rw,acl,user_xattr -t ext3 /dev/sda5 /root
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs (sda5): using internal journal
> EXT3-fs (sda5): mounted filesystem with writeback data mode
> mount: can't find /root/proc in /etc/fstab or /etc/mtab
> /sbin/smart_agetty: can not determine 'console' speed
> 
> This problem seem to have started with 
> 2.6.34-rc1-git9 (352d4657b23fbd329efccc396000a549e0150907).
> Haven't yet tried a git bisect. Boot log attached
> 
> Thanks
> -Sachin
> 
> plain text document attachment (boot-log)
> Using 0081e5dd bytes for initrd buffer
> Please wait, loading kernel...
> Allocated 00f00000 bytes for kernel @ 00d00000
>    Elf64 kernel loaded...
> Loading ramdisk...
> ramdisk loaded 0081e5dd @ 034d0000
> OF stdout device is: /vdevice/vty@30000000
> Preparing to boot Linux version 2.6.34-rc1-git9-autotest (root@llm62) (gcc version 4.3.2 [gcc-4_3-branch revision 141291] (SUSE Linux) ) #1 SMP Sat Mar 20 07:30:22 IST 2010
> Max number of cores passed to firmware: 0x0000000000000200
> Calling ibm,client-architecture-support... done
> command line: root=/dev/sda5 IDENT=1269051459 
> memory layout at init:
>   memory_limit : 0000000000000000 (16 MB aligned)
>   alloc_bottom : 0000000003cf0000
>   alloc_top    : 0000000008000000
>   alloc_top_hi : 0000000008000000
>   rmo_top      : 0000000008000000
>   ram_top      : 0000000008000000
> instantiating rtas at 0x00000000074e0000... done
> boot cpu hw idx 0000000000000000
> starting cpu hw idx 0000000000000002... done
> copying OF device tree...
> Building dt strings...
> Building dt structure...
> Device tree strings 0x0000000003d00000 -> 0x0000000003d015fa
> Device tree struct  0x0000000003d10000 -> 0x0000000003d30000
> Calling quiesce...
> returning from prom_init
> Phyp-dump disabled at boot time
> Using pSeries machine description
> Using 1TB segments
> Found initrd at 0xc0000000034d0000:0xc000000003cee5dd
> bootconsole [udbg0] enabled
> Partition configured for 4 cpus.
> CPU maps initialized for 2 threads per core
> Starting Linux PPC64 #1 SMP Sat Mar 20 07:30:22 IST 2010
> -----------------------------------------------------
> ppc64_pft_size                = 0x1a
> physicalMemorySize            = 0x100000000
> htab_hash_mask                = 0x7ffff
> -----------------------------------------------------
> Initializing cgroup subsys cpuset
> Initializing cgroup subsys cpu
> Linux version 2.6.34-rc1-git9-autotest (root@llm62) (gcc version 4.3.2 [gcc-4_3-branch revision 141291] (SUSE Linux) ) #1 SMP Sat Mar 20 07:30:22 IST 2010
> [boot]0012 Setup Arch
> EEH: No capable adapters found
> PPC64 nvram contains 15360 bytes
> Zone PFN ranges:
>   DMA      0x00000000 -> 0x00010000
>   Normal   empty
> Movable zone start PFN for each node
> early_node_map[1] active PFN ranges
>     1: 0x00000000 -> 0x00010000
> Could not find start_pfn for node 0
> [boot]0015 Setup Done
> PERCPU: Embedded 1 pages/cpu @c000000000e00000 s24744 r0 d40792 u262144
> pcpu-alloc: s24744 r0 d40792 u262144 alloc=1*1048576
> pcpu-alloc: [0] 0 1 2 3 
> Built 2 zonelists in Node order, mobility grouping on.  Total pages: 65480
> Policy zone: DMA
> Kernel command line: root=/dev/sda5 IDENT=1269051459 
> PID hash table entries: 4096 (order: -1, 32768 bytes)
> freeing bootmem node 1
> Memory: 4143168k/4194304k available (9408k kernel code, 51136k reserved, 2624k data, 1430k bss, 512k init)
> SLUB: Genslabs=18, HWalign=128, Order=0-3, MinObjects=0, CPUs=4, Nodes=256
> Hierarchical RCU implementation.
> RCU-based detection of stalled CPUs is enabled.
> NR_IRQS:512 nr_irqs:512
> [boot]0020 XICS Init
> [boot]0021 XICS Done
> clocksource: timebase mult[7d0000] shift[22] registered
> Console: colour dummy device 80x25
> console [hvc0] enabled, bootconsole disabled
> console [hvc0] enabled, bootconsole disabled
> allocated 2621440 bytes of page_cgroup
> please try 'cgroup_disable=memory' option if you don't want memory cgroups
> Security Framework initialized
> SELinux:  Disabled at boot.
> Dentry cache hash table entries: 524288 (order: 6, 4194304 bytes)
> Inode-cache hash table entries: 262144 (order: 5, 2097152 bytes)
> Mount-cache hash table entries: 4096
> Initializing cgroup subsys ns
> Initializing cgroup subsys cpuacct
> Initializing cgroup subsys memory
> Initializing cgroup subsys devices
> Initializing cgroup subsys freezer
> Initializing cgroup subsys blkio
> Processor 1 found.
> Processor 2 found.
> Processor 3 found.
> Brought up 4 CPUs
> NET: Registered protocol family 16
> IBM eBus Device Driver
> POWER6 performance monitor hardware support registered
> PCI: Probing PCI hardware
> bio: create slab <bio-0> at 0
> vgaarb: loaded
> usbcore: registered new interface driver usbfs
> usbcore: registered new interface driver hub
> usbcore: registered new device driver usb
> Switching to clocksource timebase
> NET: Registered protocol family 2
> IP route cache hash table entries: 32768 (order: 2, 262144 bytes)
> TCP established hash table entries: 131072 (order: 5, 2097152 bytes)
> TCP bind hash table entries: 65536 (order: 5, 2097152 bytes)
> TCP: Hash tables configured (established 131072 bind 65536)
> TCP reno registered
> UDP hash table entries: 2048 (order: 1, 196608 bytes)
> UDP-Lite hash table entries: 2048 (order: 1, 196608 bytes)
> NET: Registered protocol family 1
> Unpacking initramfs...
> Freeing initrd memory: 8313k freed
> IOMMU table initialized, virtual merging enabled
> audit: initializing netlink socket (disabled)
> type=2000 audit(1269051512.190:1): initialized
> Kprobe smoke test started
> Kprobe smoke test passed successfully
> rcu-torture:--- Start of test: nreaders=8 nfakewriters=4 stat_interval=0 verbose=0 test_no_idle_hz=0 shuffle_interval=3 stutter=5 irqreader=1 fqs_duration=0 fqs_holdoff=0 fqs_stutter=3
> HugeTLB registered 16 MB page size, pre-allocated 0 pages
> HugeTLB registered 16 GB page size, pre-allocated 0 pages
> VFS: Disk quotas dquot_6.5.2
> Dquot-cache hash table entries: 8192 (order 0, 65536 bytes)
> Btrfs loaded
> msgmni has been set to 8108
> alg: No test for stdrng (krng)
> Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
> io scheduler noop registered
> io scheduler deadline registered
> io scheduler cfq registered (default)
> pci_hotplug: PCI Hot Plug PCI Core version: 0.5
> rpaphp: RPA HOT Plug PCI Controller Driver version: 0.1
> Generic RTC Driver v1.07
> Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
> pmac_zilog: 0.6 (Benjamin Herrenschmidt <benh@kernel.crashing.org>)
> Uniform Multi-Platform E-IDE driver
> ide-gd driver 1.18
> IBM eHEA ethernet device driver (Release EHEA_0102)
> ehea: eth0: Jumbo frames are disabled
> ehea: eth0 -> logical port id #2
> ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> mice: PS/2 mouse device common for all mice
> EDAC MC: Ver: 2.1.0 Mar 20 2010
> usbcore: registered new interface driver hiddev
> usbcore: registered new interface driver usbhid
> usbhid: USB HID core driver
> TCP cubic registered
> NET: Registered protocol family 15
> registered taskstats version 1
> Freeing unused kernel memory: 512k freed
> doing fast boot
> SCSI subsystem initialized
> ibmvscsi 30000002: SRP_VERSION: 16.a
> scsi0 : IBM POWER Virtual SCSI Adapter 1.5.8
> ibmvscsi 30000002: partner initialization complete
> ibmvscsi 30000002: host srp version: 16.a, host partition VIO (1), OS 3, max io 1048576
> ibmvscsi 30000002: fast_fail not supported in server
> ibmvscsi 30000002: Client reserve enabled
> ibmvscsi 30000002: sent SRP login
> ibmvscsi 30000002: SRP_LOGIN succeeded
> scsi 0:0:1:0: Direct-Access     AIX      VDASD            0001 PQ: 0 ANSI: 3
> Creating device nodes with udev
> udevd version 128 started
> sd 0:0:1:0: [sda] 167772160 512-byte logical blocks: (85.8 GB/80.0 GiB)
> sd 0:0:1:0: [sda] Write Protect is off
> sd 0:0:1:0: [sda] Cache data unavailable
> sd 0:0:1:0: [sda] Assuming drive cache: write through
> sd 0:0:1:0: [sda] Cache data unavailable
> sd 0:0:1:0: [sda] Assuming drive cache: write through
>  sda: sda1 sda2 < sda5 > sda3 sda4
> sd 0:0:1:0: [sda] Cache data unavailable
> sd 0:0:1:0: [sda] Assuming drive cache: write through
> sd 0:0:1:0: [sda] Attached SCSI disk
> Boot logging started on /dev/hvc0(/dev/console) at Sat Mar 20 02:18:33 2010
> resume device  not found (ignoring)
> Waiting for device /dev/sda5 to appear:  ok
> showconsole: Warning: the ioctl TIOCGDEV is not known by the kernel
> fsck 1.41.9 (22-Aug-2009)
> [/sbin/fsck.ext3 (1) -- /] fsck.ext3 -a /dev/sda5 
> /dev/sda5: clean, 726435/3948544 files, 9655477/15773808 blocks
> fsck succeeded. Mounting root device read-write.
> Mounting root /dev/sda5
> mount -o rw,acl,user_xattr -t ext3 /dev/sda5 /root
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs (sda5): using internal journal
> EXT3-fs (sda5): mounted filesystem with writeback data mode
> mount: can't find /root/proc in /etc/fstab or /etc/mtab
> /sbin/smart_agetty: can not determine 'console' speed
> 
