Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5D45FDDE07
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 09:44:42 +1100 (EST)
Subject: Re: [ppc64] 2.6.29-git7 : offlining a cpu causes an exception
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sachin Sant <sachinp@in.ibm.com>
In-Reply-To: <49D1E21E.3090505@in.ibm.com>
References: <49D1E21E.3090505@in.ibm.com>
Content-Type: text/plain
Date: Wed, 01 Apr 2009 09:44:29 +1100
Message-Id: <1238539469.17330.70.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2009-03-31 at 14:57 +0530, Sachin Sant wrote:
> While executing CPU HotPlug[1] tests i observed that during
> every cpu offline process an exception is thrown.

Looks like a BUG_ON() to me... can you look at what other
messages just before that ?

That or lookup where the PC and LR values are in System.map
and maybe get us a backtrace from xmon ?

(You seem to have no symbols, have you built with kallsyms ?)

Ben.

> cpu 0x2: Vector: 700 (Program Check) at [c0000000074c7ca0]
>     pc: 00000000007b6640
>     lr: 000000000079ddc0
>     sp: c0000000074c7f20
>    msr: 8000000000081002
>   current = 0xc0000000fe1c8580
>   paca    = 0xc000000000ab2800
>     pid   = 0, comm = swapper
> 2:mon> r
> R00 = 0000000000000000   R16 = 0000000000000002
> R01 = c0000000074c7f20   R17 = 0000000000000000
> R02 = 00000000009e8dc0   R18 = 0000000000000000
> R03 = 0000000000008278   R19 = 0000000000000000
> R04 = 0000000000008000   R20 = 0000000000000000
> R05 = 0000000000000002   R21 = 0000000000000000
> R06 = 0000000000000002   R22 = c000000000b33ae0
> R07 = 0000000000000000   R23 = 0000000000000000
> R08 = 0000000000000000   R24 = 0000000000000002
> R09 = 00000000000082fc   R25 = 0000000000000000
> R10 = 0000000000000000   R26 = 0000000000000004
> R11 = a000000000001002   R27 = c000000000a95bd8
> R12 = a000000000000000   R28 = 0000000000000008
> R13 = c000000000ab2800   R29 = ffffffffffffffff
> R14 = 0000000000000000   R30 = c00000000095e750
> R15 = 0000000007531868   R31 = 0000000007d70b20
> pc  = 00000000007b6640
> lr  = 000000000079ddc0
> msr = 8000000000081002   cr  = 22000004
> ctr = 0000000000000000   xer = 0000000000000020   trap =  700
> 2:mon> u
> SLB contents of cpu 2
> 00 c000000008000000 40004f7ca3000500  1T  ESID=   c00000  VSID=       4f7ca3 LLP:100
> 01 d000000008000000 4000eb71b0000510  1T  ESID=   d00000  VSID=       eb71b0 LLP:110
> 24 0000000008000000 0000000000000c80 256M ESID=        0  VSID=            0 LLP:  0
> 2:mon>
> 
> I can recreate this problem very easily on power5
> as well as power6 box.
> 
> 2.6.29-git6 did not have this problem. Let me know if there
> is any other information i can provide. I have attached the
> dmesg log here.
> 
> Thanks
> -Sachin
> 
> [1] -> CPU Hotplug test which is part of LTP.
> 
> plain text document attachment (dmesg_cpu_hotplug)
> <6>Phyp-dump disabled at boot time.
> <6>Using pSeries machine description.
> <7>Page orders: linear mapping = 24, virtual = 16, io = 12.
> <6>Using 1TB segments.
> <4>Found initrd at 0xc0000000034d0000:0xc000000003c7f14f.
> <6>console [udbg0] enabled.
> <6>Partition configured for 4 cpus..
> <6>CPU maps initialized for 2 threads per core.
> <7> (thread shift is 1).
> <4>Starting Linux PPC64 #3 SMP Tue Mar 31 14:33:34 IST 2009.
> <4>-----------------------------------------------------.
> <4>ppc64_pft_size                = 0x1a.
> <4>physicalMemorySize            = 0x100000000.
> <4>htab_hash_mask                = 0x7ffff.
> <4>-----------------------------------------------------.
> <6>Initializing cgroup subsys cpuset.
> <6>Initializing cgroup subsys cpu.
> <5>Linux version 2.6.29-git7 (root@llm62) (gcc version 4.3.2 [gcc-4_3-branch revision 141291] (SUSE Linux) ) #3 SMP Tue Mar 31 14:33:34 IST 2009.
> <4>[boot]0012 Setup Arch.
> <7>Node 0 Memory: 0x0-0x100000000.
> <4>EEH: No capable adapters found.
> <6>PPC64 nvram contains 15360 bytes.
> <7>Using shared processor idle loop.
> <4>Zone PFN ranges:.
> <4>  DMA      0x00000000 -> 0x00010000.
> <4>  Normal   0x00010000 -> 0x00010000.
> <4>Movable zone start PFN for each node.
> <4>early_node_map[1] active PFN ranges.
> <4>    0: 0x00000000 -> 0x00010000.
> <7>On node 0 totalpages: 65536.
> <7>  DMA zone: 56 pages used for memmap.
> <7>  DMA zone: 0 pages reserved.
> <7>  DMA zone: 65480 pages, LIFO batch:1.
> <4>[boot]0015 Setup Done.
> <4>Built 1 zonelists in Node order, mobility grouping on.  Total pages: 65480.
> <4>Policy zone: DMA.
> <5>Kernel command line: root=/dev/sda5 sysrq=1 insmod=sym53c8xx insmod=ipr crashkernel=512M-:256M  .
> <6>NR_IRQS:512.
> <4>[boot]0020 XICS Init.
> <4>[boot]0021 XICS Done.
> <7>pic: no ISA interrupt controller.
> <4>PID hash table entries: 4096 (order: 12, 32768 bytes).
> <7>time_init: decrementer frequency = 512.000000 MHz.
> <7>time_init: processor frequency   = 4704.000000 MHz.
> <6>clocksource: timebase mult[7d0000] shift[22] registered.
> <7>clockevent: decrementer mult[8312] shift[16] cpu[0].
> <4>Console: colour dummy device 80x25.
> <6>console handover: boot [udbg0] -> real [hvc0].
> <6>Dentry cache hash table entries: 524288 (order: 6, 4194304 bytes).
> <6>Inode-cache hash table entries: 262144 (order: 5, 2097152 bytes).
> <6>allocated 2621440 bytes of page_cgroup.
> <6>please try cgroup_disable=memory option if you don't want.
> <4>freeing bootmem node 0.
> <6>Memory: 4119872k/4194304k available (8192k kernel code, 74432k reserved, 1984k data, 4194k bss, 448k init).
> <6>Calibrating delay loop... 1022.36 BogoMIPS (lpj=5111808).
> <6>Security Framework initialized.
> <6>SELinux:  Disabled at boot..
> <4>Mount-cache hash table entries: 4096.
> <6>Initializing cgroup subsys debug.
> <6>Initializing cgroup subsys ns.
> <6>Initializing cgroup subsys cpuacct.
> <6>Initializing cgroup subsys memory.
> <6>Initializing cgroup subsys devices.
> <6>Initializing cgroup subsys freezer.
> <7>clockevent: decrementer mult[8312] shift[16] cpu[1].
> <4>Processor 1 found..
> <7>clockevent: decrementer mult[8312] shift[16] cpu[2].
> <4>Processor 2 found..
> <7>clockevent: decrementer mult[8312] shift[16] cpu[3].
> <4>Processor 3 found..
> <6>Brought up 4 CPUs.
> <7>Node 0 CPUs: 0-3.
> <7>CPU0 attaching sched-domain:.
> <7> domain 0: span 0-1 level SIBLING.
> <7>  groups: 0 1.
> <7>  domain 1: span 0-3 level CPU.
> <7>   groups: 0-1 2-3.
> <7>   domain 2: span 0-3 level NODE.
> <7>    groups: 0-3.
> <7>CPU1 attaching sched-domain:.
> <7> domain 0: span 0-1 level SIBLING.
> <7>  groups: 1 0.
> <7>  domain 1: span 0-3 level CPU.
> <7>   groups: 0-1 2-3.
> <7>   domain 2: span 0-3 level NODE.
> <7>    groups: 0-3.
> <7>CPU2 attaching sched-domain:.
> <7> domain 0: span 2-3 level SIBLING.
> <7>  groups: 2 3.
> <7>  domain 1: span 0-3 level CPU.
> <7>   groups: 2-3 0-1.
> <7>   domain 2: span 0-3 level NODE.
> <7>    groups: 0-3.
> <7>CPU3 attaching sched-domain:.
> <7> domain 0: span 2-3 level SIBLING.
> <7>  groups: 3 2.
> <7>  domain 1: span 0-3 level CPU.
> <7>   groups: 2-3 0-1.
> <7>   domain 2: span 0-3 level NODE.
> <7>    groups: 0-3.
> <6>net_namespace: 1888 bytes.
> <6>NET: Registered protocol family 16.
> <6>IBM eBus Device Driver.
> <6>PCI: Probing PCI hardware.
> <7>PCI: Probing PCI hardware done.
> <4>bio: create slab 
> <bio-0> at 0.
> <6>usbcore: registered new interface driver usbfs.
> <6>usbcore: registered new interface driver hub.
> <6>usbcore: registered new device driver usb.
> <6>NET: Registered protocol family 2.
> <7>Switched to high resolution mode on CPU 0.
> <7>Switched to high resolution mode on CPU 1.
> <7>Switched to high resolution mode on CPU 2.
> <7>Switched to high resolution mode on CPU 3.
> <6>IP route cache hash table entries: 32768 (order: 2, 262144 bytes).
> <6>TCP established hash table entries: 131072 (order: 5, 2097152 bytes).
> <6>TCP bind hash table entries: 65536 (order: 4, 1048576 bytes).
> <6>TCP: Hash tables configured (established 131072 bind 65536).
> <6>TCP reno registered.
> <6>NET: Registered protocol family 1.
> <6>Unpacking initramfs... done.
> <4>Freeing initrd memory: 7868k freed.
> <6>IOMMU table initialized, virtual merging enabled.
> <7>RTAS daemon started.
> <6>audit: initializing netlink socket (disabled).
> <5>type=2000 audit(1238490478.637:1): initialized.
> <6>Kprobe smoke test started.
> <6>Kprobe smoke test passed successfully.
> <6>HugeTLB registered 16 MB page size, pre-allocated 0 pages.
> <6>HugeTLB registered 16 GB page size, pre-allocated 0 pages.
> <5>VFS: Disk quotas dquot_6.5.2.
> <4>Dquot-cache hash table entries: 8192 (order 0, 65536 bytes).
> <6>msgmni has been set to 8060.
> <6>alg: No test for stdrng (krng).
> <6>Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254).
> <6>io scheduler noop registered.
> <6>io scheduler anticipatory registered.
> <6>io scheduler deadline registered.
> <6>io scheduler cfq registered (default).
> <6>pci_hotplug: PCI Hot Plug PCI Core version: 0.5.
> <6>rpaphp: RPA HOT Plug PCI Controller Driver version: 0.1.
> <7>vio_register_driver: driver hvc_console registering.
> <7>HVSI: registered 0 devices.
> <6>Generic RTC Driver v1.07.
> <6>Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled.
> <6>pmac_zilog: 0.6 (Benjamin Herrenschmidt 
> <benh@kernel.crashing.org>).
> <6>input: Macintosh mouse button emulation as /devices/virtual/input/input0.
> <6>Uniform Multi-Platform E-IDE driver.
> <6>ide-gd driver 1.18.
> <6>IBM eHEA ethernet device driver (Release EHEA_0100).
> <6>ehea: eth0: Jumbo frames are disabled.
> <6>ehea: eth0 -> logical port id #2.
> <6>ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver.
> <6>ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver.
> <6>mice: PS/2 mouse device common for all mice.
> <6>EDAC MC: Ver: 2.1.0 Mar 31 2009.
> <6>usbcore: registered new interface driver hiddev.
> <6>usbcore: registered new interface driver usbhid.
> <6>usbhid: v2.6:USB HID core driver.
> <6>TCP cubic registered.
> <6>NET: Registered protocol family 15.
> <4>registered taskstats version 1.
> <4>Freeing unused kernel memory: 448k freed.
> <6>SysRq : Changing Loglevel.
> <4>Loglevel set to 1.
> <5>SCSI subsystem initialized.
> <7>vio_register_driver: driver ibmvscsi registering.
> <6>ibmvscsi 30000002: SRP_VERSION: 16.a.
> <6>scsi0 : IBM POWER Virtual SCSI Adapter 1.5.8.
> <6>ibmvscsi 30000002: partner initialization complete.
> <6>ibmvscsi 30000002: sent SRP login.
> <6>ibmvscsi 30000002: SRP_LOGIN succeeded.
> <6>ibmvscsi 30000002: host srp version: 16.a, host partition VIO (1), OS 3, max io 1048576.
> <5>scsi 0:0:1:0: Direct-Access     AIX      VDASD            0001 PQ: 0 ANSI: 3.
> <6>udevd version 128 started.
> <4>Driver 'sd' needs updating - please use bus_type methods.
> <5>sd 0:0:1:0: [sda] 167772160 512-byte hardware sectors: (85.8 GB/80.0 GiB).
> <5>sd 0:0:1:0: [sda] Write Protect is off.
> <7>sd 0:0:1:0: [sda] Mode Sense: 17 00 00 08.
> <5>sd 0:0:1:0: [sda] Cache data unavailable.
> <3>sd 0:0:1:0: [sda] Assuming drive cache: write through.
> <5>sd 0:0:1:0: [sda] Cache data unavailable.
> <3>sd 0:0:1:0: [sda] Assuming drive cache: write through.
> <6> sda: sda1 sda2 
> < sda5 > sda3 sda4.
> <5>sd 0:0:1:0: [sda] Attached SCSI disk.
> <6>kjournald starting.  Commit interval 5 seconds.
> <6>EXT3 FS on sda5, internal journal.
> <6>EXT3-fs: mounted filesystem with ordered data mode..
> <6>udevd version 128 started.
> <5>sd 0:0:1:0: Attached scsi generic sg0 type 0.
> <6>Adding 1044096k swap on /dev/sda3.  Priority:-1 extents:1 across:1044096k .
> <6>device-mapper: uevent: version 1.0.3.
> <6>device-mapper: ioctl: 4.14.0-ioctl (2008-04-23) initialised: dm-devel@redhat.com.
> <6>loop: module loaded.
> <6>fuse init (API version 7.11).
> <6>ehea: eth0: Physical port up.
> <6>ehea: External switch port is backup port.
> <6>NET: Registered protocol family 10.
> <6>lo: Disabled Privacy Extensions.
> <7>eth0: no IPv6 routers present.
> <4>cpu 2 (hwid 2) Ready to die....
> <7>CPU0 attaching NULL sched-domain..
> <7>CPU1 attaching NULL sched-domain..
> <7>CPU2 attaching NULL sched-domain..
> <7>CPU3 attaching NULL sched-domain..
> <7>CPU0 attaching sched-domain:.
> <7> domain 0: span 0-1 level SIBLING.
> <7>  groups: 0 1.
> <7>  domain 1: span 0-1,3 level CPU.
> <7>   groups: 0-1 3.
> <7>   domain 2: span 0-1,3 level NODE.
> <7>    groups: 0-1,3.
> <7>CPU1 attaching sched-domain:.
> <7> domain 0: span 0-1 level SIBLING.
> <7>  groups: 1 0.
> <7>  domain 1: span 0-1,3 level CPU.
> <7>   groups: 0-1 3.
> <7>   domain 2: span 0-1,3 level NODE.
> <7>    groups: 0-1,3.
> <7>CPU3 attaching sched-domain:.
> <7> domain 0: span 0-1,3 level CPU.
> <7>  groups: 3 0-1.
> <7>  domain 1: span 0-1,3 level NODE.
> <7>   groups: 0-1,3.....................
