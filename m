Return-Path: <sachinp@in.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A10BCB7BCE
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Sep 2009 18:03:39 +1000 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp05.au.ibm.com (8.14.3/8.13.1) with ESMTP id n8P80vse030178
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Sep 2009 18:00:57 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8P83bqZ377256
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Sep 2009 18:03:37 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8P83a8H021139
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Sep 2009 18:03:37 +1000
Message-ID: <4ABC7955.2070404@in.ibm.com>
Date: Fri, 25 Sep 2009 13:33:33 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Tejun Heo <tj@kernel.org>
Subject: Re: 2.6.31-git5 kernel boot hangs on powerpc
References: <4AB0D947.8010301@in.ibm.com> <4AB214C3.4040109@in.ibm.com>
	<1253185994.8375.352.camel@pasglop>	<4AB25B61.9020609@kernel.org>
	<4AB266AF.9080705@in.ibm.com> <4AB49C37.6020003@in.ibm.com>
	<4AB9DAEC.3060309@in.ibm.com> <4AB9DD8F.1040305@kernel.org>
	<4ABA2DE2.6000601@kernel.org> <4ABB269F.6020309@in.ibm.com>
	<4ABB6D33.6060706@kernel.org> <4ABB72BD.9050905@in.ibm.com>
	<1253826309.7103.461.camel@pasglop>
	<4ABC376D.1020704@kernel.org> <4ABC6E25.7090904@in.ibm.com>
	<4ABC73C7.20403@kernel.org> <4ABC7486.8040500@kernel.org>
In-Reply-To: <4ABC7486.8040500@kernel.org>
Content-Type: multipart/mixed; boundary="------------060104040206070009020100"
Cc: David Miller <davem@davemloft.net>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060104040206070009020100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Tejun Heo wrote:
> Tejun Heo wrote:
>   
>> Hello,
>>
>> Sachin Sant wrote:
>>     
>>> <4>PERCPU: chunk 1 relocating -1 -> 18 c0000000db70fb00
>>> <c0000000db70fb00:c0000000db70fb00>
>>> <4>PERCPU: relocated <c000000001120320:c000000001120320>
>>> <4>PERCPU: chunk 1 relocating 18 -> 16 c0000000db70fb00
>>> <c000000001120320:c000000001120320>
>>> <4>PERCPU: relocated <c000000001120300:c000000001120300>
>>> <4>PERCPU: chunk 1, alloc pages [0,1)
>>> <4>PERCPU: chunk 1, map pages [0,1)
>>> <4>PERCPU: map 0xd00007fffff00000, 1 pages 53544
>>> <4>PERCPU: map 0xd00007fffff80000, 1 pages 53545
>>> <4>PERCPU: chunk 1, will clear 4096b/unit d00007fffff00000 d00007fffff80000
>>> <3>INFO: RCU detected CPU 0 stall (t=1000 jiffies)
>>>       
>> This supports my hypothesis.  This is the first area being allocated
>> from a dynamic chunk and cleared.  PFN 53544 and 53545 have been
>> allocated and successfully mapped to 0xd00007fffff00000 and
>> 0xd00007fffff80000 using map_kernel_range_noflush() but when those
>> addresses are actually accessed, we end up with infinite faults.  The
>> fault handler probably thinks that the fault has been handled
>> correctly but, when the control is returned, the processor faults
>> again.  Benjamin, I'm way out of my depth here, can you please help?
>>
>> Oh, one more simple experiment.  Sachin, does the following patch make
>> any difference?
>>     
With this patch applied the machine boots OK :-)

Have attached the boot log. Note that this boot log is
from a different machine, but the reported problem can be
recreate on this machine as well.

Thanks
-Sachin

>
> Oops, the patch should look like the following.
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 69511e6..37ab9e2 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2056,7 +2056,8 @@ static unsigned long pvm_determine_end(struct vmap_area **pnext,
>  				       struct vmap_area **pprev,
>  				       unsigned long align)
>  {
> -	const unsigned long vmalloc_end = VMALLOC_END & ~(align - 1);
> +	const unsigned long vmalloc_start = ALIGN(VMALLOC_START, align);
> +	const unsigned long vmalloc_end = vmalloc_start + (512 << 20);
>  	unsigned long addr;
>
>  	if (*pnext)
> @@ -2102,7 +2103,7 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
>  				     size_t align, gfp_t gfp_mask)
>  {
>  	const unsigned long vmalloc_start = ALIGN(VMALLOC_START, align);
> -	const unsigned long vmalloc_end = VMALLOC_END & ~(align - 1);
> +	const unsigned long vmalloc_end = vmalloc_start + (512 << 20);
>  	struct vmap_area **vas, *prev, *next;
>  	struct vm_struct **vms;
>  	int area, area2, last_area, term_area;
>
>   


-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------


--------------060104040206070009020100
Content-Type: text/plain;
 name="boot-log-with-patch-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="boot-log-with-patch-2"

Phyp-dump disabled at boot time
Using pSeries machine description
Page orders: linear mapping = 24, virtual = 16, io = 12, vmemmap = 24
Using 1TB segments
Found initrd at 0xc000000003700000:0xc000000003eca37e
bootconsole [udbg0] enabled
Partition configured for 8 cpus.
CPU maps initialized for 2 threads per core
 (thread shift is 1)
Starting Linux PPC64 #3 SMP Fri Sep 25 13:19:46 IST 2009
-----------------------------------------------------
ppc64_pft_size                = 0x19
physicalMemorySize            = 0x80000000
htab_hash_mask                = 0x3ffff
-----------------------------------------------------
Initializing cgroup subsys cpuset
Initializing cgroup subsys cpu
Linux version 2.6.31-git15 (root@mjs22lp5) (gcc version 4.3.2 [gcc-4_3-branch revision 141291] (SUSE Linux) ) #3 SMP Fri Sep 25 13:19:46 IST 2009
[boot]0012 Setup Arch
Node 0 Memory: 0x0-0x42000000
Node 1 Memory: 0x42000000-0x80000000
EEH: No capable adapters found
PPC64 nvram contains 15360 bytes
Using shared processor idle loop
Zone PFN ranges:
  DMA      0x00000000 -> 0x00008000
  Normal   0x00008000 -> 0x00008000
Movable zone start PFN for each node
early_node_map[2] active PFN ranges
    0: 0x00000000 -> 0x00004200
    1: 0x00004200 -> 0x00008000
On node 0 totalpages: 16896
  DMA zone: 15 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 16881 pages, LIFO batch:1
On node 1 totalpages: 15872
  DMA zone: 14 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 15858 pages, LIFO batch:1
[boot]0015 Setup Done
PERCPU: Embedded 2 pages/cpu @c000000001400000 s96744 r0 d34328 u131072
pcpu-alloc: s96744 r0 d34328 u131072 alloc=1*1048576
pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
PERCPU: initialized 17 slots [c000000001500200,c000000001500310)
PERCPU: chunk 0 relocating -1 -> 13 c000000001500380 <c000000001500380:c000000001500380>
PERCPU: relocated <c0000000015002d0:c0000000015002d0>
Built 2 zonelists in Node order, mobility grouping on.  Total pages: 32739
Policy zone: DMA
Kernel command line: root=/dev/sda3 sysrq=8 xmon=on 
PID hash table entries: 4096 (order: -1, 32768 bytes)
freeing bootmem node 0
freeing bootmem node 1
Memory: 2040320k/2097152k available (12800k kernel code, 56832k reserved, 2880k data, 4268k bss, 4800k init)
Hierarchical RCU implementation.
NR_IRQS:512
[boot]0020 XICS Init
[boot]0021 XICS Done
pic: no ISA interrupt controller
time_init: decrementer frequency = 512.000000 MHz
time_init: processor frequency   = 4005.000000 MHz
clocksource: timebase mult[7d0000] shift[22] registered
clockevent: decrementer mult[83126e97] shift[32] cpu[0]
Console: colour dummy device 80x25
console [hvc0] enabled, bootconsole disabled
allocated 1310720 bytes of page_cgroup
please try 'cgroup_disable=memory' option if you don't want memory cgroups
Security Framework initialized
SELinux:  Disabled at boot.
Dentry cache hash table entries: 262144 (order: 5, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 4, 1048576 bytes)
Mount-cache hash table entries: 4096
Initializing cgroup subsys ns
Initializing cgroup subsys cpuacct
Initializing cgroup subsys memory
Initializing cgroup subsys devices
Initializing cgroup subsys freezer
irq: irq 2 on host null mapped to virtual irq 16
clockevent: decrementer mult[83126e97] shift[32] cpu[1]
Processor 1 found.
clockevent: decrementer mult[83126e97] shift[32] cpu[2]
Processor 2 found.
clockevent: decrementer mult[83126e97] shift[32] cpu[3]
Processor 3 found.
Brought up 4 CPUs
Node 0 CPUs: 0-3
Node 1 CPUs:
CPU0 attaching sched-domain:
 domain 0: span 0-1 level SIBLING
  groups: 0 (cpu_power = 589) 1 (cpu_power = 589)
  domain 1: span 0-3 level CPU
   groups: 0-1 (cpu_power = 1178) 2-3 (cpu_power = 1178)
CPU1 attaching sched-domain:
 domain 0: span 0-1 level SIBLING
  groups: 1 (cpu_power = 589) 0 (cpu_power = 589)
  domain 1: span 0-3 level CPU
   groups: 0-1 (cpu_power = 1178) 2-3 (cpu_power = 1178)
CPU2 attaching sched-domain:
 domain 0: span 2-3 level SIBLING
  groups: 2 (cpu_power = 589) 3 (cpu_power = 589)
  domain 1: span 0-3 level CPU
   groups: 2-3 (cpu_power = 1178) 0-1 (cpu_power = 1178)
CPU3 attaching sched-domain:
 domain 0: span 2-3 level SIBLING
  groups: 3 (cpu_power = 589) 2 (cpu_power = 589)
  domain 1: span 0-3 level CPU
   groups: 2-3 (cpu_power = 1178) 0-1 (cpu_power = 1178)
NET: Registered protocol family 16
IBM eBus Device Driver
POWER6 performance monitor hardware support registered
PCI: Probing PCI hardware
PCI: Probing PCI hardware done
bio: create slab <bio-0> at 0
vgaarb: loaded
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Switching to clocksource timebase
Switched to high resolution mode on CPU 1
Switched to high resolution mode on CPU 2
Switched to high resolution mode on CPU 3
NET: Registered protocol family 2
PERCPU: chunk 0 relocating 13 -> 12 c000000001500380 <c0000000015002d0:c0000000015002d0>
PERCPU: relocated <c0000000015002c0:c0000000015002c0>
IP route cache hash table entries: 16384 (order: 1, 131072 bytes)
TCP established hash table entries: 65536 (order: 4, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 4, 1048576 bytes)
TCP: Hash tables configured (established 65536 bind 65536)
TCP reno registered
NET: Registered protocol family 1
Unpacking initramfs...
Switched to high resolution mode on CPU 0
Freeing initrd memory: 7976k freed
irq: irq 655360 on host null mapped to virtual irq 17
irq: irq 655362 on host null mapped to virtual irq 18
IOMMU table initialized, virtual merging enabled
irq: irq 655364 on host null mapped to virtual irq 19
irq: irq 655365 on host null mapped to virtual irq 20
irq: irq 589825 on host null mapped to virtual irq 21
RTAS daemon started
audit: initializing netlink socket (disabled)
type=2000 audit(1253865170.250:1): initialized
HugeTLB registered 16 MB page size, pre-allocated 0 pages
HugeTLB registered 16 GB page size, pre-allocated 0 pages
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 8192 (order 0, 65536 bytes)
msgmni has been set to 4000
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
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
mice: PS/2 mouse device common for all mice
EDAC MC: Ver: 2.1.0 Sep 25 2009
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
usbhid: v2.6:USB HID core driver
TCP cubic registered
NET: Registered protocol family 15
registered taskstats version 1
Freeing unused kernel memory: 4800k freed
PERCPU: chunk 0 relocating 12 -> 11 c000000001500380 <c0000000015002c0:c0000000015002c0>
PERCPU: relocated <c0000000015002b0:c0000000015002b0>
SysRq : Changing Loglevel
Loglevel set to 8
SCSI subsystem initialized
vio_register_driver: driver ibmvscsi registering
ibmvscsi 30000002: SRP_VERSION: 16.a
scsi0 : IBM POWER Virtual SCSI Adapter 1.5.8
ibmvscsi 30000002: partner initialization complete
ibmvscsi 30000002: host srp version: 16.a, host partition 06-1C12A (1), OS 3, max io 262144
ibmvscsi 30000002: Client reserve enabled
ibmvscsi 30000002: sent SRP login
ibmvscsi 30000002: SRP_LOGIN succeeded
scsi 0:0:1:0: Direct-Access     AIX      VDASD            0001 PQ: 0 ANSI: 3
scsi 0:0:2:0: CD-ROM            AIX      VOPTA                 PQ: 0 ANSI: 4
udevd version 128 started
sd 0:0:1:0: [sda] 33554432 512-byte logical blocks: (17.1 GB/16.0 GiB)
sd 0:0:1:0: [sda] Write Protect is off
sd 0:0:1:0: [sda] Mode Sense: 17 00 00 08
sd 0:0:1:0: [sda] Cache data unavailable
sd 0:0:1:0: [sda] Assuming drive cache: write through
sd 0:0:1:0: [sda] Cache data unavailable
sd 0:0:1:0: [sda] Assuming drive cache: write through
 sda: sda1 sda2 sda3
sd 0:0:1:0: [sda] Cache data unavailable
sd 0:0:1:0: [sda] Assuming drive cache: write through
sd 0:0:1:0: [sda] Attached SCSI disk
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda3, internal journal
EXT3-fs: mounted filesystem with writeback data mode.
udevd version 128 started
sd 0:0:1:0: Attached scsi generic sg0 type 0
scsi 0:0:2:0: Attached scsi generic sg1 type 5
drivers/net/ibmveth.c: ibmveth: IBM i/pSeries Virtual Ethernet Driver 1.03
vio_register_driver: driver ibmveth registering
IBM eHEA ethernet device driver (Release EHEA_0102)
irq: irq 590080 on host null mapped to virtual irq 256
ehea: eth2: Jumbo frames are enabled
ehea: eth2 -> logical port id #9
ehea: eth3: Jumbo frames are enabled
ehea: eth3 -> logical port id #10
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.20
sr 0:0:2:0: Attached scsi CD-ROM sr0
Adding 1044096k swap on /dev/sda2.  Priority:-1 extents:1 across:1044096k 
device-mapper: uevent: version 1.0.3
device-mapper: ioctl: 4.15.0-ioctl (2009-04-01) initialised: dm-devel@redhat.com
loop: module loaded
fuse init (API version 7.13)
irq: irq 777 on host null mapped to virtual irq 265
ehea: eth2: Physical port up
ehea: External switch port is backup port
irq: irq 778 on host null mapped to virtual irq 266
NET: Registered protocol family 10
PERCPU: chunk 0 relocating 11 -> 10 c000000001500380 <c0000000015002b0:c0000000015002b0>
PERCPU: relocated <c0000000015002a0:c0000000015002a0>
PERCPU: chunk 0 relocating 10 -> 9 c000000001500380 <c0000000015002a0:c0000000015002a0>
PERCPU: relocated <c000000001500290:c000000001500290>
PERCPU: chunk 1 relocating -1 -> 16 c00000003e6d7500 <c00000003e6d7500:c00000003e6d7500>
PERCPU: relocated <c000000001500300:c000000001500300>
PERCPU: chunk 1 relocating 16 -> 14 c00000003e6d7500 <c000000001500300:c000000001500300>
PERCPU: relocated <c0000000015002e0:c0000000015002e0>
PERCPU: chunk 1, alloc pages [0,1)
PERCPU: chunk 1, map pages [0,1)
PERCPU: map 0xd00000001ff00000, 1 pages 14136
PERCPU: map 0xd00000001ff20000, 1 pages 14137
PERCPU: map 0xd00000001ff40000, 1 pages 14159
PERCPU: map 0xd00000001ff60000, 1 pages 14166
PERCPU: map 0xd00000001ff80000, 1 pages 14161
PERCPU: map 0xd00000001ffa0000, 1 pages 14165
PERCPU: map 0xd00000001ffc0000, 1 pages 15732
PERCPU: map 0xd00000001ffe0000, 1 pages 16049
PERCPU: chunk 1, will clear 4096b/unit d00000001ff00000 d00000001ff20000 d00000001ff40000 d00000001ff60000 d00000001ff80000 d00000001ffa0000 d00000001ffc0000 d00000001ffe0000
PERCPU: chunk 0 relocating 9 -> 8 c000000001500380 <c000000001500290:c000000001500290>
PERCPU: relocated <c000000001500280:c000000001500280>
PERCPU: chunk 0 relocating 8 -> 7 c000000001500380 <c000000001500280:c000000001500280>
PERCPU: relocated <c000000001500270:c000000001500270>
eth2: no IPv6 routers present

--------------060104040206070009020100--
