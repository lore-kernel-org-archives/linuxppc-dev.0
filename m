Return-Path: <ayman@elkhashab.com>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.124]) by ozlabs.org (Postfix) with ESMTP id 1958FB6FAA
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Apr 2011 09:59:08 +1100 (EST)
Received: from crust.elkhashab.com (localhost [127.0.0.1])
	by crust.elkhashab.com (8.14.3/8.14.3/Debian-5) with ESMTP id
	p31Mx4lo027526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Apr 2011 17:59:04 -0500
Received: (from ayman@localhost)
	by crust.elkhashab.com (8.14.3/8.14.3/Submit) id p31Mx3nk027525
	for linuxppc-dev@ozlabs.org; Fri, 1 Apr 2011 17:59:03 -0500
Date: Fri, 1 Apr 2011 17:59:03 -0500
From: Ayman El-Khashab <ayman@elkhashab.com>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: problem PCIe LSI detected at 32 device addresses (ppc460ex)
Message-ID: <20110401225903.GA27320@crust.elkhashab.com>
References: <20110401162619.GA20132@crust.elkhashab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110401162619.GA20132@crust.elkhashab.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 01, 2011 at 11:26:19AM -0500, Ayman El-Khashab wrote:
> I've got an LSI SAS2008 controller (w/ firmware v9) that works
> fine in a Linux PC w/ a recent kernel.  It does NOT work on my
> 460EX board.  What I find is that the device shows up as every
> device on the subordinate bus where it is really located.  (see
> the dumps below).  With the LSI firmware v8 this didn't occur
> and it showed up correctly as a single device.  I am not sure

<snip>

Ok, I've narrowed the scope of the problem some.  I moved forward
to a more recent kernel (2.6.31 to 2.6.36) and that resolved the
problem of the controller showing up as every device on the bus.
However, from 2.6.37 to the current HEAD, I have not been able to
build a kernel to run on the 460EX.  I tried 2.6.37, 2.6.38, and
the HEAD and all result in the following kernel panic.  I am not
sure how to proceed here.  I suppose we can stick with 2.6.36 since
it works, but I'd like to understand what it might take to remedy
this.

Thanks

U-Boot 2008.10 (Mar 15 2011 - 18:44:08)

CPU:   AMCC PowerPC 460EX Rev. A at 800 MHz (PLB=200, OPB=100, EBC=100 MHz)
       Security/Kasumi support
       Bootstrap Option D - Boot ROM Location PCI
       Internal PCI arbiter disabled
       32 kB I-Cache 32 kB D-Cache
Board: tanosx-slave - Tanisys SX Platform, 2*PCIeToggling PLX reset
, Rev. 0
I2C:   ready
DRAM:  Auto calibration |*** --------------
*** best_result window size: 231
*** best_result WRDTR: 0x0001
*** best_result CLKTR: 0x0001
*** best_result RQFD: 0x002e
*** best_result RFFD: 0x0230
*** best_result RDCC: 0x40000000
*** --------------

512 MB (ECC enabled, 400 MHz, CL3)
*** Warning - bad CRC, using default environment

PCIE0: successfully set as endpoint
PCIE1: successfully set as root-complex
### Unknown PB ###
Net:   No ethernet found.

Type run flash_nfs to mount root filesystem over NFS

Hit any key to stop autoboot:  0
## Booting kernel from Legacy Image at ff000000 ...
   Image Name:   Linux-2.6.37-00000-v2.6.37
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    2146637 Bytes =  2 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
## Loading init Ramdisk from Legacy Image at ff400000 ...
   Image Name:   Tanisys Ramdisk Image
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    3830562 Bytes =  3.7 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
## Flattened Device Tree blob at ff3e0000
   Booting using the fdt blob at 0xff3e0000
   Uncompressing Kernel Image ... OK
   Loading Device Tree to 007fa000, end 007ffe96 ... OK
   Loading Ramdisk to 1fabe000, end 1fe65322 ... OK
Using PowerPC 44x Platform machine description
Linux version 2.6.37-00000-v2.6.37 (aymane@lablinux) (gcc version 4.2.2) #16 Fri Apr 1 15:20:03 CDT
 2011
Found initrd at 0xdfabe000:0xdfe65322
Zone PFN ranges:
  DMA      0x00000000 -> 0x00020000
  Normal   empty
  HighMem  empty
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00020000
MMU: Allocated 1088 bytes of context maps for 255 contexts
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
Kernel command line: root=/dev/ram rw mem=512M ip=::::tanosx-slave:eth0:off panic=1 console=ttyS0,5
7600
PID hash table entries: 2048 (order: 1, 8192 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 510452k/524288k available (4180k kernel code, 13836k reserved, 160k data, 1144k bss, 180k i
nit)
Kernel virtual memory layout:
  * 0xfffcf000..0xfffff000  : fixmap
  * 0xffc00000..0xffe00000  : highmem PTEs
  * 0xff200000..0xffc00000  : consistent mem
  * 0xff200000..0xff200000  : early ioremap
  * 0xe1000000..0xff200000  : vmalloc & ioremap
SLUB: Genslabs=13, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
NR_IRQS:512
UIC0 (32 IRQ sources) at DCR 0xc0
UIC1 (32 IRQ sources) at DCR 0xd0
UIC2 (32 IRQ sources) at DCR 0xe0
UIC3 (32 IRQ sources) at DCR 0xf0
clocksource: timebase mult[500000] shift[22] registered
pid_max: default: 4096 minimum: 301
Mount-cache hash table entries: 512
xor: measuring software checksum speed
   8regs     :   691.000 MB/sec
   8regs_prefetch:   607.000 MB/sec
   32regs    :   882.000 MB/sec
   32regs_prefetch:   748.000 MB/sec
xor: using function: 32regs (882.000 MB/sec)
NET: Registered protocol family 16
256k L2-cache enabled
PCIE0: Checking link...
PCIE0: Device detected, waiting for link...
PCIE0: link is up !
PCI host bridge /plb/pciex@d00000000 (primary) ranges:
 MEM 0x0000000e00000000..0x0000000e7fffffff -> 0x0000000080000000
  IO 0x0000000f80000000..0x0000000f8000ffff -> 0x0000000000000000
4xx PCI DMA offset set to 0x00000000
PCIE0: successfully set as endpoint
PCIE1: Checking link...
PCIE1: Device detected, waiting for link...
PCIE1: link is up !
PCI host bridge /plb/pciex@d20000000 (primary) ranges:
 MEM 0x0000000e80000000..0x0000000effffffff -> 0x0000000080000000
  IO 0x0000000f80010000..0x0000000f8001ffff -> 0x0000000000000000
4xx PCI DMA offset set to 0x00000000
PCIE1: successfully set as root-complex
PCI host bridge /plb/pci@c0ec00000 (primary) ranges:
 MEM 0x0000000d80000000..0x0000000dffffffff -> 0x0000000080000000
  IO 0x0000000c08000000..0x0000000c0800ffff -> 0x0000000000000000
4xx PCI DMA offset set to 0x00000000
PCI: Probing PCI hardware
PCI: Hiding 4xx host bridge resources 0000:40:00.0
PCI: Hiding 4xx host bridge resources 0001:80:00.0
pci 0001:80:00.0: PCI bridge to [bus 81-bf]
pci 0001:81:00.0: PCI bridge to [bus 82-ff]
pci 0001:82:01.0: PCI bridge to [bus 83-ff]
pci 0001:82:04.0: PCI bridge to [bus 84-ff]
pci 0001:82:05.0: PCI bridge to [bus 85-ff]
pci 0001:80:00.0: BAR 8: assigned [mem 0xe80000000-0xe804fffff]
pci 0001:80:00.0: BAR 9: assigned [mem 0xe80500000-0xe808fffff pref]
pci 0001:80:00.0: BAR 7: assigned [io  0xfffe1000-0xfffe2fff]
pci 0001:81:00.0: BAR 8: assigned [mem 0xe80000000-0xe803fffff]
pci 0001:81:00.0: BAR 9: assigned [mem 0xe80500000-0xe808fffff pref]
pci 0001:81:00.0: BAR 0: assigned [mem 0xe80400000-0xe8041ffff]
pci 0001:81:00.0: BAR 0: set to [mem 0xe80400000-0xe8041ffff] (PCI address [0x80400000-0x8041ffff])
pci 0001:81:00.0: BAR 7: assigned [io  0xfffe1000-0xfffe2fff]
pci 0001:82:01.0: BAR 8: assigned [mem 0xe80000000-0xe801fffff]
pci 0001:82:01.0: BAR 9: assigned [mem 0xe80500000-0xe806fffff pref]
pci 0001:82:05.0: BAR 8: assigned [mem 0xe80200000-0xe803fffff]
pci 0001:82:05.0: BAR 9: assigned [mem 0xe80700000-0xe808fffff 64bit pref]
pci 0001:82:01.0: BAR 7: assigned [io  0xfffe1000-0xfffe1fff]
pci 0001:82:05.0: BAR 7: assigned [io  0xfffe2000-0xfffe2fff]
pci 0001:83:00.0: BAR 6: assigned [mem 0xe80500000-0xe8057ffff pref]
pci 0001:83:00.0: BAR 3: assigned [mem 0xe80000000-0xe8003ffff 64bit]
pci 0001:83:00.0: BAR 3: set to [mem 0xe80000000-0xe8003ffff 64bit] (PCI address [0x80000000-0x8003
ffff])
pci 0001:83:00.0: BAR 1: assigned [mem 0xe80040000-0xe80043fff 64bit]
pci 0001:83:00.0: BAR 1: set to [mem 0xe80040000-0xe80043fff 64bit] (PCI address [0x80040000-0x8004
3fff])
pci 0001:83:00.0: BAR 0: assigned [io  0xfffe1000-0xfffe10ff]
pci 0001:83:00.0: BAR 0: set to [io  0xfffe1000-0xfffe10ff] (PCI address [0x1000-0x10ff])
pci 0001:82:01.0: PCI bridge to [bus 83-83]
pci 0001:82:01.0:   bridge window [io  0xfffe1000-0xfffe1fff]
pci 0001:82:01.0:   bridge window [mem 0xe80000000-0xe801fffff]
pci 0001:82:01.0:   bridge window [mem 0xe80500000-0xe806fffff pref]
pci 0001:82:04.0: PCI bridge to [bus 84-84]
pci 0001:82:04.0:   bridge window [io  disabled]
pci 0001:82:04.0:   bridge window [mem disabled]
pci 0001:82:04.0:   bridge window [mem pref disabled]
pci 0001:82:05.0: PCI bridge to [bus 85-85]
pci 0001:82:05.0:   bridge window [io  0xfffe2000-0xfffe2fff]
pci 0001:82:05.0:   bridge window [mem 0xe80200000-0xe803fffff]
pci 0001:82:05.0:   bridge window [mem 0xe80700000-0xe808fffff 64bit pref]
pci 0001:81:00.0: PCI bridge to [bus 82-85]
pci 0001:81:00.0:   bridge window [io  0xfffe1000-0xfffe2fff]
pci 0001:81:00.0:   bridge window [mem 0xe80000000-0xe803fffff]
pci 0001:81:00.0:   bridge window [mem 0xe80500000-0xe808fffff pref]
pci 0001:80:00.0: PCI bridge to [bus 81-bf]
pci 0001:80:00.0:   bridge window [io  0xfffe1000-0xfffe2fff]
pci 0001:80:00.0:   bridge window [mem 0xe80000000-0xe804fffff]
pci 0001:80:00.0:   bridge window [mem 0xe80500000-0xe808fffff pref]
pci 0001:81:00.0: enabling device (0000 -> 0003)
pci 0001:82:01.0: enabling device (0000 -> 0003)
pci 0001:82:05.0: enabling device (0000 -> 0003)
bio: create slab <bio-0> at 0
raid6: int32x1    246 MB/s
raid6: int32x2    303 MB/s
raid6: int32x4    384 MB/s
raid6: int32x8    202 MB/s
raid6: using algorithm int32x4 (384 MB/s)
vgaarb: loaded
SCSI subsystem initialized
Switching to clocksource timebase
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
Switched to NOHz mode on CPU #0
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
NET: Registered protocol family 1
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
Trying to unpack rootfs image as initramfs...
rootfs image is not initramfs (no cpio magic); looks like an initrd
Freeing initrd memory: 3740k freed
JFFS2 version 2.2. (NAND) Ac 2001-2006 Red Hat, Inc.
msgmni has been set to 1006
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
io scheduler noop registered
io scheduler deadline registered (default)
io scheduler cfq registered
Serial: 8250/16550 driver, 1 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0x4ef600300 (irq = 21) is a U6_16550A
console [ttyS0] enabled
serial8250 serial8250.0: unable to register port at index 1 (IO0 MEM4ef600400 IRQ22): -28
4ef600300.serial: ttyS0 at MMIO 0x4ef600300 (irq = 21) is a 16550
of:of_serial: probe of 4ef600400.serial failed with error -28
brd: module loaded
Unable to handle kernel paging request for data at address 0x00000030
Faulting instruction address: 0xc02010c4
Oops: Kernel access of bad area, sig: 11 [#1]
PowerPC 44x Platform
last sysfs file:
Modules linked in:
NIP: c02010c4 LR: c01fe0e4 CTR: c020109c
REGS: df431ce0 TRAP: 0300   Not tainted  (2.6.37-00000-v2.6.37)
MSR: 00029000 <EE,ME,CE>  CR: 82f44d42  XER: 20000000
DEAR: 00000030, ESR: 00000000
TASK = df42e400[1] 'swapper' THREAD: df430000
GPR00: 00000000 df431d90 df42e400 00000000 ded9d544 00000000 00000000 c07faa8c
GPR08: 00000002 00000000 00000000 c0550000 24f44d42 805144f2 c03b1890 c0346a94
GPR16: c03b14f8 c03b2428 c03b23ec c03b2374 c0419fa8 deda01a0 df431e10 ded9d544
GPR24: c03c5984 00000000 ded9d544 00000000 00000000 c05564ac c042cf00 c042cb9c
NIP [c02010c4] parse_cmdline_partitions+0x28/0x2ec
LR [c01fe0e4] parse_mtd_partitions+0x78/0x114
Call Trace:
[df431d90] [df426e00] 0xdf426e00 (unreliable)
[df431dd0] [c01fe0e4] parse_mtd_partitions+0x78/0x114
[df431e00] [c031bb70] of_flash_probe+0x39c/0x6e8
[df431e80] [c0277960] platform_driver_probe_shim+0x40/0x54
[df431e90] [c01d1624] platform_drv_probe+0x20/0x30
[df431ea0] [c01d0138] driver_probe_device+0x148/0x1ac
[df431ec0] [c01d044c] __driver_attach+0xa4/0xa8
[df431ee0] [c01cf274] bus_for_each_dev+0x60/0x9c
[df431f10] [c01cfe8c] driver_attach+0x24/0x34
[df431f20] [c01cfc1c] bus_add_driver+0x1b8/0x274
[df431f50] [c01d06a8] driver_register+0x6c/0x160
[df431f70] [c01d1994] platform_driver_register+0x68/0x78
[df431f80] [c0277b2c] of_register_platform_driver+0xa8/0xc4
[df431f90] [c0402f1c] of_flash_init+0x18/0x28
[df431fa0] [c0001574] do_one_initcall+0x160/0x1a8
[df431fd0] [c03e81e8] kernel_init+0xcc/0x174
[df431ff0] [c000c588] kernel_thread+0x4c/0x68
Instruction dump:
3ba00000 4bfffe74 9421ffc0 7c0802a6 bee1001c 90010044 3d60c055 3bab64ac
801d0004 7c791b78 2f800000 7c972378 <83830030> 409e00f0 83eb64ac 38000001
---[ end trace 6d92ab5ca4b92b20 ]---
Kernel panic - not syncing: Attempted to kill init!
Call Trace:
[df431bd0] [c00063b8] show_stack+0x44/0x16c (unreliable)
[df431c10] [c00204a4] panic+0xa4/0x1d4
[df431c60] [c00242a0] do_exit+0x59c/0x5f0
[df431ca0] [c0009ff8] kernel_bad_stack+0x0/0x4c
[df431cc0] [c00102d0] bad_page_fault+0xc0/0x108
[df431cd0] [c000cc7c] handle_page_fault+0x7c/0x80
--- Exception: 300 at parse_cmdline_partitions+0x28/0x2ec
    LR = parse_mtd_partitions+0x78/0x114
[df431d90] [df426e00] 0xdf426e00 (unreliable)
[df431dd0] [c01fe0e4] parse_mtd_partitions+0x78/0x114
[df431e00] [c031bb70] of_flash_probe+0x39c/0x6e8
[df431e80] [c0277960] platform_driver_probe_shim+0x40/0x54
[df431e90] [c01d1624] platform_drv_probe+0x20/0x30
[df431ea0] [c01d0138] driver_probe_device+0x148/0x1ac
[df431ec0] [c01d044c] __driver_attach+0xa4/0xa8
[df431ee0] [c01cf274] bus_for_each_dev+0x60/0x9c
[df431f10] [c01cfe8c] driver_attach+0x24/0x34
[df431f20] [c01cfc1c] bus_add_driver+0x1b8/0x274
[df431f50] [c01d06a8] driver_register+0x6c/0x160
[df431f70] [c01d1994] platform_driver_register+0x68/0x78
[df431f80] [c0277b2c] of_register_platform_driver+0xa8/0xc4
[df431f90] [c0402f1c] of_flash_init+0x18/0x28
[df431fa0] [c0001574] do_one_initcall+0x160/0x1a8
[df431fd0] [c03e81e8] kernel_init+0xcc/0x174
[df431ff0] [c000c588] kernel_thread+0x4c/0x68
Rebooting in 1 seconds..
