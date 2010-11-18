Return-Path: <jkenisto@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 24122B71A8
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Nov 2010 05:23:37 +1100 (EST)
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e5.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id oAII1v49018831
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Nov 2010 13:01:57 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oAIINWr2347502
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Nov 2010 13:23:32 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	oAIINWAt032713
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Nov 2010 13:23:32 -0500
Subject: Re: [PATCH] powerpc: fix call to subpage_protection()
From: Jim Keniston <jkenisto@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <13149.1290047579@neuling.org>
References: <1289418856.2983.23.camel@localhost>
	<1289426817.2147.1403.camel@pasglop>
	<1289520464.4752.12.camel@localhost>
	<17075.1289877977@neuling.org> <1289958663.3028.175.camel@localhost>
	<27638.1289959435@neuling.org> <1290020404.2974.15.camel@localhost>
	<13149.1290047579@neuling.org>
Content-Type: multipart/mixed; boundary="=-FBXptrT66GD7Ndotffp0"
Date: Thu, 18 Nov 2010 10:23:30 -0800
Message-ID: <1290104610.3067.32.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-FBXptrT66GD7Ndotffp0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2010-11-18 at 13:32 +1100, Michael Neuling wrote:
> In: 
>   powerpc/mm: Fix pgtable cache cleanup with CONFIG_PPC_SUBPAGE_PROT
>   commit d28513bc7f675d28b479db666d572e078ecf182d
>   Author: David Gibson <david@gibson.dropbear.id.au>
> 
> subpage_protection() was changed to to take an mm rather a pgdir but it
> didn't change calling site in hashpage_preload().  The change wasn't
> noticed at compile time since hashpage_preload() used a void* as the
> parameter to subpage_protection().
> 
> This is obviously wrong and can trigger the following crash when
> CONFIG_SLAB, CONFIG_DEBUG_SLAB, CONFIG_PPC_64K_PAGES
> CONFIG_PPC_SUBPAGE_PROT are enabled.
> 
...
> 
> The following changes this subpage_protection() call.
> 
> Reported-by: Jim Keniston <jkenisto@linux.vnet.ibm.com>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Tested-by: Jim Keniston <jkenisto@linux.vnet.ibm.com>
> cc: David Gibson <david@gibson.dropbear.id.au>
> cc: stable@kernel.org (only 2.6.33 and newer)
> ---
> > It boots fine with pseries_defconfig.
> > 
> > Attached is the config file that I've been using, which is probably
> > descended over many generations of kernels from some config file in my
> > machine's distant past.  (Enable DEBUG_SLAB or DEBUG_PAGEALLOC and it
> > will fail to boot.)  After I run 'make menuconfig' starting from
> > pseries_defconfig...
> > $ diff config_ok .config | wc -l
> > 2052
> 
> I narrowed this down to adding the following on pseries_defconfig:
>   +CONFIG_SLAB=y
>   +CONFIG_PPC_64K_PAGES=y
>   +CONFIG_PPC_SUBPAGE_PROT=y
>   +CONFIG_DEBUG_SLAB=y
> To reproduce the fail.

I have indeed verified that when I apply those config changes atop
pseries_defconfig, the resulting kernel fails to boot on my Power 5
system without this fix, and boots correctly with this fix.  So the
Tested-by line is correct.

Unfortunately, this fix doesn't enable my legacy configuration to boot
with CONFIG_SLAB=y.  It still fails in the same way -- console output
attached.

FWIW, this failure isn't an obstacle for me.  I'm in no way attached to
my legacy configuration; pseries_defconfig is fine for me.  On the other
hand, I can continue testing fixes, and/or make my system available to
other IBMers when I'm not using it, if you want to continue to pursue
this problem.

Thanks.
Jim

>   
> 
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index 83f534d..5e95844 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -1123,7 +1123,7 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
>  	else
>  #endif /* CONFIG_PPC_HAS_HASH_64K */
>  		rc = __hash_page_4K(ea, access, vsid, ptep, trap, local, ssize,
> -				    subpage_protection(pgdir, ea));
> +				    subpage_protection(mm, ea));
> 
>  	/* Dump some info in case of hash insertion failure, they should
>  	 * never happen so it is really useful to know if/when they do
> 
> 


--=-FBXptrT66GD7Ndotffp0
Content-Disposition: attachment; filename="linus-oops6"
Content-Type: text/plain; name="linus-oops6"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This is with Michael Neuling's subpage_protection fix, using my legacy
.config DEBUG_SLAB configured.

boot: linus
Using 0084e28a bytes for initrd buffer
Please wait, loading kernel...
Allocated 00f00000 bytes for kernel @ 01e00000
   Elf64 kernel loaded...
Loading ramdisk...
ramdisk loaded 0084e28a @ 02d00000
OF stdout device is: /vdevice/vty@30000000
Preparing to boot Linux version 2.6.37-rc2-5-ppc64 (jimk@elm3b90) (gcc version 4.3.2 [gcc-4_3-branch revision 141291] (SUSE Linux) ) #9 SMP Wed Nov 17 18:17:23 PST 2010
Max number of cores passed to firmware: 512 (NR_CPUS = 1024)
Calling ibm,client-architecture-support... not implemented
command line: root=/dev/disk/by-id/scsi-SIBM_ST373453LC_3HW1CQ1400007445Q2A4-part3 quiet profile=2 sysrq=1 insmod=sym53c8xx insmod=ipr crashkernel=256M-:128M loglevel=8 
memory layout at init:
  memory_limit : 0000000000000000 (16 MB aligned)
  alloc_bottom : 0000000003550000
  alloc_top    : 0000000008000000
  alloc_top_hi : 0000000070000000
  amo_top      : 0000000008000000
  ram_top      : 0000000070000000
instantiating rtas at 0x00000000076a0000... done
boot cpu hw idx 0
starting cpu hw idx 2... done
copying OF device tree...
Building dt strings...
Building dt structure...
Device tree strings 0x0000000003560000 -> 0x000000000356129c
Device tree struct  0x0000000003570000 -> 0x0000000003580000
Calling quiesce...
returning from prom_init
Crash kernel location must be 0x2000000
Reserving 128MB of memory at 32MB for crashkernel (System RAM: 1792MB)
Phyp-dump not supported on this hardware
Allocated 655360 bytes for 1024 pacas at c000000001f30000
Using pSeries machine description
Page orders: linear mapping = 24, virtual = 12, io = 12
Found initrd at 0xc000000002d00000:0xc00000000354e28a
bootconsole [udbg0] enabled
Partition configured for 4 cpus.
CPU maps initialized for 2 threads per core
 (thread shift is 1)
Freed 589824 bytes for unused pacas
Starting Linux PPC64 #9 SMP Wed Nov 17 18:17:23 PST 2010
-----------------------------------------------------
ppc64_pft_size                = 0x19
physicalMemorySize            = 0x70000000
htab_hash_mask                = 0x3ffff
-----------------------------------------------------
Initializing cgroup subsys cpuset
Initializing cgroup subsys cpu
Linux version 2.6.37-rc2-5-ppc64 (jimk@elm3b90) (gcc version 4.3.2 [gcc-4_3-branch revision 141291] (SUSE Linux) ) #9 SMP Wed Nov 17 18:17:23 PST 2010
[boot]0012 Setup Arch
Node 0 Memory: 0x0-0x70000000
PCI host bridge /pci@800000020000002  ranges:
  IO 0x000003fe00200000..0x000003fe002fffff -> 0x0000000000000000
 MEM 0x0000040080000000..0x00000400bfffffff -> 0x00000000c0000000 
PCI host bridge /pci@800000020000003  ranges:
  IO 0x000003fe00700000..0x000003fe007fffff -> 0x0000000000000000
 MEM 0x00000401c0000000..0x00000401ffffffff -> 0x00000000c0000000 
EEH: PCI Enhanced I/O Error Handling Enabled
PPC64 nvram contains 7168 bytes
Using dedicated idle loop
Zone PFN ranges:
  DMA      0x00000000 -> 0x00007000
  Normal   empty
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00007000
On node 0 totalpages: 28672
  DMA zone: 25 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 28647 pages, LIFO batch:1
[boot]0015 Setup Done
PERCPU: Embedded 1 pages/cpu @c000000000f00000 s23424 r0 d42112 u262144
pcpu-alloc: s23424 r0 d42112 u262144 alloc=1*1048576
pcpu-alloc: [0] 0 1 2 3 
Built 1 zonelists in Node order, mobility grouping on.  Total pages: 28647
Policy zone: DMA
Kernel command line: root=/dev/disk/by-id/scsi-SIBM_ST373453LC_3HW1CQ1400007445Q2A4-part3 quiet profile=2 sysrq=1 insmod=sym53c8xx insmod=ipr crashkernel=256M-:128M loglevel=8 
kernel profiling enabled (shift: 2)
PID hash table entries: 4096 (order: -1, 32768 bytes)
freeing bootmem node 0
Memory: 1681088k/1835008k available (8192k kernel code, 153920k reserved, 1536k data, 4447k bss, 512k init)
Hierarchical RCU implementation.
	RCU-based detection of stalled CPUs is disabled.
NR_IRQS:512
[boot]0020 XICS Init
[boot]0021 XICS Done
pic: no ISA interrupt controller
time_init: decrementer frequency = 207.054000 MHz
time_init: processor frequency   = 1654.344000 MHz
clocksource: timebase mult[135191e] shift[22] registered
clockevent: decrementer mult[35017dae] shift[32] cpu[0]
Console: colour dummy device 80x25
console [hvc0] enabled, bootconsole disabled
console [hvc0] enabled, bootconsole disabled
allocated 1146880 bytes of page_cgroup
please try 'cgroup_disable=memory' option if you don't want memory cgroups
pid_max: default: 32768 minimum: 301
Security Framework initialized
SELinux:  Disabled at boot.
Dentry cache hash table entries: 262144 (order: 5, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 4, 1048576 bytes)
Mount-cache hash table entries: 4096
Initializing cgroup subsys ns
ns_cgroup deprecated: consider using the 'clone_children' flag without the ns_cgroup.
Initializing cgroup subsys cpuacct
Initializing cgroup subsys memory
Initializing cgroup subsys devices
Initializing cgroup subsys freezer
irq: irq 2 on host null mapped to virtual irq 16
Brought up 4 CPUs
Node 0 CPUs: 0-3
NET: Registered protocol family 16
IBM eBus Device Driver
POWER5 performance monitor hardware support registered
PCI: Probing PCI hardware
IOMMU table initialized, virtual merging enabled
pci 0000:c0:01.0: PME# supported from D0 D3hot D3cold
pci 0000:c0:01.0: PME# disabled
pci 0000:c0:01.1: PME# supported from D0 D3hot D3cold
pci 0000:c0:01.1: PME# disabled
irq: irq 115 on host null mapped to virtual irq 115
irq: irq 116 on host null mapped to virtual irq 116
pci 0001:cc:01.0: supports D1
irq: irq 150 on host null mapped to virtual irq 150
irq: irq 151 on host null mapped to virtual irq 151
PCI: Probing PCI hardware done
bio: create slab <bio-0> at 0
vgaarb: loaded
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Switching to clocksource timebase
NET: Registered protocol family 2
IP route cache hash table entries: 16384 (order: 1, 131072 bytes)
TCP established hash table entries: 65536 (order: 4, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 4, 1048576 bytes)
TCP: Hash tables configured (established 65536 bind 65536)
TCP reno registered
UDP hash table entries: 2048 (order: 0, 65536 bytes)
UDP-Lite hash table entries: 2048 (order: 0, 65536 bytes)
NET: Registered protocol family 1
PCI: CLS 128 bytes, default 128
Unpacking initramfs...
Initramfs unpacking failed: read error
RTAS daemon started
irq: irq 655360 on host null mapped to virtual irq 17
irq: irq 589825 on host null mapped to virtual irq 18
audit: initializing netlink socket (disabled)
type=2000 audit(1290100141.460:1): initialized
HugeTLB registered 16 MB page size, pre-allocated 0 pages
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 8192 (order 0, 65536 bytes)
msgmni has been set to 3284
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
rpaphp: RPA HOT Plug PCI Controller Driver version: 0.1
rpaphp: Slot [U787A.001.DNZ00XZ-P1-C1] registered
vio_register_driver: driver hvc_console registering
HVSI: registered 0 devices
Generic RTC Driver v1.07
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
pmac_zilog: 0.6 (Benjamin Herrenschmidt <benh@kernel.crashing.org>)
Uniform Multi-Platform E-IDE driver
ide-gd driver 1.18
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
mice: PS/2 mouse device common for all mice
EDAC MC: Ver: 2.1.0 Nov 17 2010
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
TCP cubic registered
NET: Registered protocol family 15
registered taskstats version 1
md: Waiting for all devices to be available before autodetect
md: If you don't use raid, use raid=noautodetect
md: Autodetecting RAID arrays.
md: Scanned 0 and added 0 devices.
md: autorun ...
md: ... autorun DONE.
VFS: Cannot open root device "disk/by-id/scsi-SIBM_ST373453LC_3HW1CQ1400007445Q2A4-part3" or unknown-block(0,0)
Please append a correct "root=" boot option; here are the available partitions:
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
Call Trace:
[c00000006e78fc30] [c000000000011218] .show_stack+0x6c/0x16c (unreliable)
[c00000006e78fce0] [c00000000054b204] .panic+0x9c/0x200
[c00000006e78fd80] [c000000000781354] .mount_block_root+0x2dc/0x318
[c00000006e78fe50] [c00000000078159c] .prepare_namespace+0x184/0x1cc
[c00000006e78fee0] [c000000000780554] .kernel_init+0x2e4/0x310
[c00000006e78ff90] [c00000000002985c] .kernel_thread+0x54/0x70
Rebooting in 180 seconds..


--=-FBXptrT66GD7Ndotffp0--
