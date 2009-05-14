Return-Path: <sachinp@in.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [59.145.155.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp08.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8CE03DE00F
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 21:46:43 +1000 (EST)
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28smtp08.in.ibm.com (8.13.1/8.13.1) with ESMTP id n4EB49KX020995
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 16:34:09 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4EBkYuQ2482364
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 17:16:34 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.13.1/8.13.3) with ESMTP id n4EBkX43012324
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 17:16:34 +0530
Message-ID: <4A0C0496.2000809@in.ibm.com>
Date: Thu, 14 May 2009 17:16:30 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: Next May 11 : BUG during scsi initialization
References: <20090511161442.3e9d9cb9.sfr@canb.auug.org.au>
	<4A081002.4050802@in.ibm.com>
	<20090511115233.GB8112@parisc-linux.org>
	<4A081437.7000409@in.ibm.com>
	<20090511122135.GC8112@parisc-linux.org>
	<20090512045716.GC32535@wotan.suse.de>
	<4A0BD6BB.1050600@in.ibm.com>
	<1242291113.21646.6.camel@penberg-laptop>
	<4A0BEA44.2050908@in.ibm.com>
	<1242295150.21646.10.camel@penberg-laptop>
	<1242295263.21646.11.camel@penberg-laptop>
In-Reply-To: <1242295263.21646.11.camel@penberg-laptop>
Content-Type: multipart/mixed; boundary="------------010100060900050603030708"
Cc: Nick Piggin <npiggin@suse.de>, Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-next@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Matthew Wilcox <matthew@wil.cx>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------010100060900050603030708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Pekka Enberg wrote:
>> Thanks! Can you please enable CONFIG_DEBUG_VM, CONFIG_DEBUG_LIST, and
>> decrease CONFIG_NR_CPUS=1024 to, say, 32 and retest? Perhaps we'll get a
>> some clues to what's going on here.
>>     
>
> Furthermore, you might want to test with CONFIG_PPC_4K_PAGES and
> CONFIG_PPC_16K_PAGES to see if it makes a difference compared to the
> CONFIG_PPC_64K_PAGES you currently have.
>   
Here is the boot log with following options. Symptom remains the same.

CONFIG_PPC_4K_PAGES=y
CONFIG_DEBUG_VM=y
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_DEBUG_LIST=y
CONFIG_NR_CPUS=32

Thanks
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------


--------------010100060900050603030708
Content-Type: text/plain;
 name="slqb-4k-boot"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="slqb-4k-boot"

Using 007b9f91 bytes for initrd buffer
Please wait, loading kernel...
Allocated 00c00000 bytes for kernel @ 02300000
   Elf64 kernel loaded...
Loading ramdisk...
ramdisk loaded 007b9f91 @ 02f00000
OF stdout device is: /vdevice/vty@30000000
Preparing to boot Linux version 2.6.30-rc5-autotest-next-20090514 (root@mpower6lp5) (gcc version 4.3.2 [gcc-4_3-branch revision 141291] (SUSE Linux) ) #2 SMP Thu May 14 16:36:26 IST 2009
Calling ibm,client-architecture... done
command line: root=/dev/sda3 sysrq=8 insmod=sym53c8xx insmod=ipr crashkernel=512M-:256M mminit_loglevel=4 loglevel=8 
memory layout at init:
  alloc_bottom : 00000000036ba000
  alloc_top    : 0000000008000000
  alloc_top_hi : 0000000008000000
  rmo_top      : 0000000008000000
  ram_top      : 0000000008000000
instantiating rtas at 0x00000000074e6000... done
boot cpu hw idx 0000000000000000
copying OF device tree...
Building dt strings...
Building dt structure...
Device tree strings 0x00000000036bb000 -> 0x00000000036bc5c2
Device tree struct  0x00000000036bd000 -> 0x00000000036d5000
Calling quiesce...
returning from prom_init
Crash kernel location must be 0x2000000
Reserving 256MB of memory at 32MB for crashkernel (System RAM: 4096MB)
Phyp-dump disabled at boot time
Using pSeries machine description
Page orders: linear mapping = 12, virtual = 12, io = 12
Using 1TB segments
Found initrd at 0xc000000002f00000:0xc0000000036b9f91
console [udbg0] enabled
Partition configured for 2 cpus.
CPU maps initialized for 2 threads per core
 (thread shift is 1)
Starting Linux PPC64 #2 SMP Thu May 14 16:36:26 IST 2009
-----------------------------------------------------
ppc64_pft_size                = 0x1a
physicalMemorySize            = 0x100000000
htab_hash_mask                = 0x7ffff
-----------------------------------------------------
Initializing cgroup subsys cpuset
Initializing cgroup subsys cpu
Linux version 2.6.30-rc5-autotest-next-20090514 (root@mpower6lp5) (gcc version 4.3.2 [gcc-4_3-branch revision 141291] (SUSE Linux) ) #2 SMP Thu May 14 16:36:26 IST 2009
[boot]0012 Setup Arch
mminit::memory_register Entering add_active_range(2, 0x0, 0x8000) 0 entries of 256 used
mminit::memory_register Entering add_active_range(2, 0x8000, 0x10000) 1 entries of 256 used
mminit::memory_register Entering add_active_range(2, 0x10000, 0x18000) 1 entries of 256 used
mminit::memory_register Entering add_active_range(2, 0x18000, 0x20000) 1 entries of 256 used
mminit::memory_register Entering add_active_range(2, 0x20000, 0x28000) 1 entries of 256 used
mminit::memory_register Entering add_active_range(2, 0x28000, 0x30000) 1 entries of 256 used
mminit::memory_register Entering add_active_range(2, 0x30000, 0x38000) 1 entries of 256 used
mminit::memory_register Entering add_active_range(2, 0x38000, 0x40000) 1 entries of 256 used
mminit::memory_register Entering add_active_range(2, 0x40000, 0x48000) 1 entries of 256 used
mminit::memory_register Entering add_active_range(2, 0x48000, 0x50000) 1 entries of 256 used
mminit::memory_register Entering add_active_range(2, 0x50000, 0x58000) 1 entries of 256 used
mminit::memory_register Entering add_active_range(2, 0x58000, 0x60000) 1 entries of 256 used
mminit::memory_register Entering add_active_range(2, 0x60000, 0x68000) 1 entries of 256 used
mminit::memory_register Entering add_active_range(2, 0x68000, 0x70000) 1 entries of 256 used
mminit::memory_register Entering add_active_range(2, 0x70000, 0x78000) 1 entries of 256 used
mminit::memory_register Entering add_active_range(2, 0x78000, 0x80000) 1 entries of 256 used
mminit::memory_register Entering add_active_range(2, 0x80000, 0x88000) 1 entries of 256 used
mminit::memory_register Entering add_active_range(2, 0x88000, 0x90000) 1 entries of 256 used
mminit::memory_register Entering add_active_range(2, 0x90000, 0x98000) 1 entries of 256 used
mminit::memory_register Entering add_active_range(2, 0x98000, 0xa0000) 1 entries of 256 used
mminit::memory_register Entering add_active_range(2, 0xa0000, 0xa8000) 1 entries of 256 used
mminit::memory_register Entering add_active_range(2, 0xa8000, 0xb0000) 1 entries of 256 used
mminit::memory_register Entering add_active_range(2, 0xb0000, 0xb8000) 1 entries of 256 used
mminit::memory_register Entering add_active_range(2, 0xb8000, 0xc0000) 1 entries of 256 used
mminit::memory_register Entering add_active_range(2, 0xc0000, 0xc8000) 1 entries of 256 used
mminit::memory_register Entering add_active_range(2, 0xc8000, 0xd0000) 1 entries of 256 used
mminit::memory_register Entering add_active_range(2, 0xd0000, 0xd8000) 1 entries of 256 used
mminit::memory_register Entering add_active_range(2, 0xd8000, 0xe0000) 1 entries of 256 used
mminit::memory_register Entering add_active_range(3, 0xe0000, 0xe8000) 1 entries of 256 used
mminit::memory_register Entering add_active_range(3, 0xe8000, 0xf0000) 2 entries of 256 used
mminit::memory_register Entering add_active_range(3, 0xf0000, 0xf8000) 2 entries of 256 used
mminit::memory_register Entering add_active_range(3, 0xf8000, 0x100000) 2 entries of 256 used
Node 0 Memory:
Node 2 Memory: 0x0-0xe0000000
Node 3 Memory: 0xe0000000-0x100000000
EEH: No capable adapters found
PPC64 nvram contains 15360 bytes
Using shared processor idle loop
Zone PFN ranges:
  DMA      0x00000000 -> 0x00100000
  Normal   0x00100000 -> 0x00100000
Movable zone start PFN for each node
early_node_map[2] active PFN ranges
    2: 0x00000000 -> 0x000e0000
    3: 0x000e0000 -> 0x00100000
mminit::pageflags_layout_widths Section 20 Node 4 Zone 2 Flags 23
mminit::pageflags_layout_shifts Section 20 Node 4 Zone 2
mminit::pageflags_layout_offsets Section 44 Node 40 Zone 38
mminit::pageflags_layout_zoneid Zone ID: 38 -> 44
mminit::pageflags_layout_usage location: 64 -> 38 unused 38 -> 23 flags 23 -> 0
Could not find start_pfn for node 0
On node 0 totalpages: 0
On node 2 totalpages: 917504
  DMA zone: 14336 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 903168 pages, LIFO batch:31
mminit::memmap_init Initialising map node 2 zone 0 pfns 0 -> 917504
On node 3 totalpages: 131072
  DMA zone: 2048 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 129024 pages, LIFO batch:31
mminit::memmap_init Initialising map node 3 zone 0 pfns 917504 -> 1048576
[boot]0015 Setup Done
mminit::zonelist general 2:DMA = 2:DMA 3:DMA 
mminit::zonelist thisnode 2:DMA = 2:DMA 
mminit::zonelist general 3:DMA = 3:DMA 2:DMA 
mminit::zonelist thisnode 3:DMA = 3:DMA 
Built 3 zonelists in Node order, mobility grouping on.  Total pages: 1032192
Policy zone: DMA
Kernel command line: root=/dev/sda3 sysrq=8 insmod=sym53c8xx insmod=ipr crashkernel=512M-:256M mminit_loglevel=4 loglevel=8 
Experimental hierarchical RCU implementation.
RCU-based detection of stalled CPUs is enabled.
Experimental hierarchical RCU init done.
NR_IRQS:512
[boot]0020 XICS Init
[boot]0021 XICS Done
pic: no ISA interrupt controller
PID hash table entries: 4096 (order: 12, 32768 bytes)
time_init: decrementer frequency = 512.000000 MHz
time_init: processor frequency   = 4704.000000 MHz
clocksource: timebase mult[7d0000] shift[22] registered
clockevent: decrementer mult[8312] shift[16] cpu[0]
Console: colour dummy device 80x25
console handover: boot [udbg0] -> real [hvc0]
allocated 41943040 bytes of page_cgroup
please try cgroup_disable=memory option if you don't want
freeing bootmem node 2
freeing bootmem node 3
Memory: 3812292k/4194304k available (8708k kernel code, 382012k reserved, 1024k data, 1253k bss, 332k init)
Calibrating delay loop... 1022.36 BogoMIPS (lpj=5111808)
Security Framework initialized
SELinux:  Disabled at boot.
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Mount-cache hash table entries: 256
Initializing cgroup subsys ns
Initializing cgroup subsys cpuacct
Initializing cgroup subsys memory
Initializing cgroup subsys devices
Initializing cgroup subsys freezer
irq: irq 2 on host null mapped to virtual irq 16
clockevent: decrementer mult[8312] shift[16] cpu[1]
Processor 1 found.
Brought up 2 CPUs
Node 0 CPUs: 0-1
Node 2 CPUs:
Node 3 CPUs:
CPU0 attaching sched-domain:
 domain 0: span 0-1 level SIBLING
  groups: 0 1
  domain 1: span 0-1 level NODE
   groups: 0-1
CPU1 attaching sched-domain:
 domain 0: span 0-1 level SIBLING
  groups: 1 0
  domain 1: span 0-1 level NODE
   groups: 0-1
net_namespace: 1936 bytes
NET: Registered protocol family 16
IBM eBus Device Driver
PCI: Probing PCI hardware
PCI: Probing PCI hardware done
bio: create slab <bio-0> at 0
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Failed to register trace events module notifier
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
Switched to high resolution mode on CPU 0
Switched to high resolution mode on CPU 1
TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
TCP reno registered
NET: Registered protocol family 1
Unpacking initramfs...
irq: irq 655360 on host null mapped to virtual irq 17
irq: irq 655367 on host null mapped to virtual irq 18
IOMMU table initialized, virtual merging enabled
irq: irq 589825 on host null mapped to virtual irq 19
RTAS daemon started
audit: initializing netlink socket (disabled)
type=2000 audit(1242300811.347:1): initialized
Kprobe smoke test started
Kprobe smoke test passed successfully
HugeTLB registered 16 MB page size, pre-allocated 0 pages
HugeTLB registered 16 GB page size, pre-allocated 0 pages
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Btrfs loaded
msgmni has been set to 7445
alg: No test for stdrng (krng)
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
rpaphp: RPA HOT Plug PCI Controller Driver version: 0.1
vio_register_driver: driver hvc_console registering
HVSI: registered 0 devices
Generic RTC Driver v1.07
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
pmac_zilog: 0.6 (Benjamin Herrenschmidt <benh@kernel.crashing.org>)
input: Macintosh mouse button emulation as /devices/virtual/input/input0
Uniform Multi-Platform E-IDE driver
ide-gd driver 1.18
IBM eHEA ethernet device driver (Release EHEA_0101)
irq: irq 590088 on host null mapped to virtual irq 264
ehea: eth0: Jumbo frames are disabled
ehea: eth0 -> logical port id #2
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
mice: PS/2 mouse device common for all mice
EDAC MC: Ver: 2.1.0 May 14 2009
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
usbhid: v2.6:USB HID core driver
TCP cubic registered
NET: Registered protocol family 15
registered taskstats version 1
Freeing unused kernel memory: 332k freed
doing fast boot
SysRq : Changing Loglevel
Loglevel set to 8
Unable to handle kernel paging request for data at address 0xc00000000087e704
Faulting instruction address: 0xc00000000035e524
Oops: Kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=32 DEBUG_PAGEALLOC NUMA pSeries
Modules linked in: scsi_mod(+)
NIP: c00000000035e524 LR: c0000000005d4790 CTR: 0000000000000000
REGS: c0000000db5bf590 TRAP: 0300   Not tainted  (2.6.30-rc5-autotest-next-20090514)
MSR: 8000000000009032 <EE,ME,IR,DR>  CR: 44222448  XER: 00000001
DAR: c00000000087e704, DSISR: 0000000040000000
TASK = c0000000db63c000[63] 'modprobe' THREAD: c0000000db5bc000 CPU: 1
GPR00: c0000000005d4790 c0000000db5bf810 c0000000009837f8 c00000000087e700 
GPR04: c0000000db89ef00 0000000000000000 0000000000000000 c0000000dfffde80 
GPR08: 0000000000000001 c0000000de000010 0000000000000002 c0000000009c4858 
GPR12: 0000000044222448 c0000000009be500 0000000000000000 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR20: 0000000000000018 ffffffffffffffff c000000000894cc8 0000000000000010 
GPR24: 0000000000210d00 c0000000db89ef00 c000000013ba27a0 c000000000ad2b80 
GPR28: c00000000087e700 c00000000087e700 c000000000904008 c000000013ba2780 
NIP [c00000000035e524] ._raw_spin_lock+0x30/0x184
LR [c0000000005d4790] ._spin_lock+0x10/0x24
Call Trace:
[c0000000db5bf8b0] [c0000000005d4790] ._spin_lock+0x10/0x24
[c0000000db5bf920] [c00000000013ed90] .__slab_alloc_page+0x35c/0x3ec
[c0000000db5bf9e0] [c0000000001404e8] .kmem_cache_alloc+0x188/0x268
[c0000000db5bfaa0] [c000000000140e78] .kmem_cache_create+0x294/0x2a8
[c0000000db5bfb90] [d00000000143c198] .scsi_init_queue+0x38/0x170 [scsi_mod]
[c0000000db5bfc20] [d00000000143c094] .init_scsi+0x1c/0xe8 [scsi_mod]
[c0000000db5bfca0] [c0000000000092c0] .do_one_initcall+0x80/0x19c
[c0000000db5bfd90] [c0000000000bece0] .SyS_init_module+0xe0/0x244
[c0000000db5bfe30] [c000000000008534] syscall_exit+0x0/0x40
Instruction dump:
7c0802a6 fba1ffe8 7d800026 7c7d1b78 fbc1fff0 ebc2c148 f8010010 fb61ffd8 
fb81ffe0 fbe1fff8 91810008 f821ff61 <80030004> 6c09dead 2f894ead 419e000c 
---[ end trace 12a7f8dbf2aa739a ]---
/init: line 21:    63 Segmentation fault      modprobe $file
Creating device nodes with udev
udevd version 128 started


--------------010100060900050603030708--
