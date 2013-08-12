Return-Path: <R65777@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9D8EC2C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Aug 2013 20:20:18 +1000 (EST)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: "aik@ozlabs.ru" <aik@ozlabs.ru>, "benh@kernel.crashing.org"
 <benh@kernel.crashing.org>
Subject: Powerpc: Kernel warn_on when enabling IOMMU_API
Date: Mon, 12 Aug 2013 10:20:08 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D0710DCBF@039-SN2MPN1-013.039d.mgd.msft.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Alexey/Ben,

When I enable the IOMMU_API then I get warn_on in arch/powerpc/kernel/iommu=
.c (here is the code snapshot)
{
1110 static int iommu_add_device(struct device *dev)
1111 {
1112         struct iommu_table *tbl;
1113         int ret =3D 0;
1114=20
1115         if (WARN_ON(dev->iommu_group)) {

^^^^
    This is the point is Warn_on.

1116                 pr_warn("iommu_tce: device %s is already in iommu grou=
p %d, skipping\n",
1117                                 dev_name(dev),
1118                                 iommu_group_id(dev->iommu_group));
1119                 return -EBUSY;
1120         }
}


---------------This is the bootlog with #define DEBUG in iommu.c-----------=
--------------

Using P5040 DS machine description
MMU: Supported page sizes
         4 KB as direct
      4096 KB as direct
     16384 KB as direct
     65536 KB as direct
    262144 KB as direct
   1048576 KB as direct
MMU: Book3E HW tablewalk not supported
Found initrd at 0xc00000002b759000:0xc00000002ffff4ab
bootconsole [udbg0] enabled
CPU maps initialized for 1 thread per core
Starting Linux PPC64 #16 SMP Mon Aug 12 15:22:11 IST 2013
-----------------------------------------------------
ppc64_pft_size                =3D 0x0
physicalMemorySize            =3D 0x200000000
ppc64_caches.dcache_line_size =3D 0x40
ppc64_caches.icache_line_size =3D 0x40
-----------------------------------------------------
Linux version 3.11.0-rc1-10505-g8d33668-dirty (r65777@perfidc-01) (gcc vers=
ion 4.5.1 (Sourcery G++ Lite 2010.09-55) ) #16 SMP Mon Aug 12 15:22:11 IST =
2013
CF000012

Setup Arch
[boot]0012 Setup Arch
P5040 DS board from Freescale Semiconductor
Zone ranges:
  DMA      [mem 0x00000000-0x1ffffffff]
  Normal   empty
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x00000000-0x1ffffffff]
MMU: Allocated 2112 bytes of context maps for 255 contexts
CF000015

Setup Done
[boot]0015 Setup Done
PERCPU: Embedded 10 pages/cpu @c00000000b100000 s11200 r0 d29760 u262144
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 206848=
0
Kernel command line: console=3DttyS0,115200 ramdisk_size=3D10000000 root=3D=
/dev/ram rw
PID hash table entries: 4096 (order: 3, 32768 bytes)
Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Sorting __ex_table...
Memory: 8110276K/8388608K available (6276K kernel code, 1104K rwdata, 2212K=
 rodata, 268K init, 325K bss, 278332K reserved)
SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D4, Nodes=3D1
Hierarchical RCU implementation.
	RCU restricting CPUs from NR_CPUS=3D24 to nr_cpu_ids=3D4.
NR_IRQS:512 nr_irqs:512 16
mpic: Setting up MPIC " OpenPIC  " version 1.2 at ffe040000, max 4 CPUs
mpic: ISU size: 512, shift: 9, mask: 1ff
mpic: Initializing for 512 sources
clocksource: timebase mult[14000000] shift[24] registered
Console: colour dummy device 80x25
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 256
mpic: requesting IPIs...
Brought up 4 CPUs
devtmpfs: initialized
NET: Registered protocol family 16
Found FSL PCI host bridge at 0x0000000ffe200000. Firmware bus number: 0->1
PCI host bridge /pcie@ffe200000 (primary) ranges:
 MEM 0x0000000c00000000..0x0000000c1fffffff -> 0x00000000e0000000=20
  IO 0x0000000ff8000000..0x0000000ff800ffff -> 0x0000000000000000
/pcie@ffe200000: PCICSRBAR @ 0xdf000000
/pcie@ffe200000: Setup 64-bit PCI DMA window
/pcie@ffe200000: DMA window size is 0xdf000000
Found FSL PCI host bridge at 0x0000000ffe201000. Firmware bus number: 0->1
PCI host bridge /pcie@ffe201000  ranges:
 MEM 0x0000000c20000000..0x0000000c3fffffff -> 0x00000000e0000000=20
  IO 0x0000000ff8010000..0x0000000ff801ffff -> 0x0000000000000000
/pcie@ffe201000: PCICSRBAR @ 0xdf000000
/pcie@ffe201000: Setup 64-bit PCI DMA window
/pcie@ffe201000: DMA window size is 0xdf000000
software IO TLB [mem 0x0bdca000-0x0fdca000] (64MB) mapped at [c00000000bdca=
000-c00000000fdc9fff]
PCI: Probing PCI hardware
fsl-pci ffe200000.pcie: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x10000-0x1ffff] (bus address [0x00=
00-0xffff])
pci_bus 0000:00: root bus resource [mem 0xc00000000-0xc1fffffff] (bus addre=
ss [0xe0000000-0xffffffff])
pci_bus 0000:00: root bus resource [bus 00-01]
pci 0000:00:00.0: ignoring class 0x0b2000 (doesn't match header type 01)
pci 0000:00:00.0: PCI bridge to [bus 01-ff]
fsl-pci ffe201000.pcie: PCI host bridge to bus 0001:00
pci_bus 0001:00: root bus resource [io  0x21000-0x30fff] (bus address [0x00=
00-0xffff])
pci_bus 0001:00: root bus resource [mem 0xc20000000-0xc3fffffff] (bus addre=
ss [0xe0000000-0xffffffff])
pci_bus 0001:00: root bus resource [bus 00-01]
pci 0001:00:00.0: ignoring class 0x0b2000 (doesn't match header type 01)
pci 0001:00:00.0: PCI bridge to [bus 01-ff]
pci 0000:00:00.0: PCI bridge to [bus 01]
pci 0000:00:00.0:   bridge window [io  0x10000-0x1ffff]
pci 0000:00:00.0:   bridge window [mem 0xc00000000-0xc1fffffff]
pci 0001:00:00.0: BAR 9: can't assign mem pref (size 0x100000)
pci 0001:01:00.0: BAR 6: assigned [mem 0xc20040000-0xc2007ffff pref]
pci 0001:00:00.0: PCI bridge to [bus 01]
pci 0001:00:00.0:   bridge window [io  0x21000-0x30fff]
pci 0001:00:00.0:   bridge window [mem 0xc20000000-0xc3fffffff]
Some PCI device resources are unassigned, try booting with pci=3Drealloc
bio: create slab <bio-0> at 0
Freescale Elo / Elo Plus DMA driver
fsl-elo-dma ffe100300.dma: #0 (fsl,eloplus-dma-channel), irq 28
fsl-elo-dma ffe100300.dma: #1 (fsl,eloplus-dma-channel), irq 29
fsl-elo-dma ffe100300.dma: #2 (fsl,eloplus-dma-channel), irq 30
fsl-elo-dma ffe100300.dma: #3 (fsl,eloplus-dma-channel), irq 31
fsl-elo-dma ffe101300.dma: #0 (fsl,eloplus-dma-channel), irq 32
fsl-elo-dma ffe101300.dma: #1 (fsl,eloplus-dma-channel), irq 33
fsl-elo-dma ffe101300.dma: #2 (fsl,eloplus-dma-channel), irq 34
fsl-elo-dma ffe101300.dma: #3 (fsl,eloplus-dma-channel), irq 35
vgaarb: loaded
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giome=
tti@linux.it>
PTP clock support registered
EDAC MC: Ver: 3.0.0
------------[ cut here ]------------
WARNING: at arch/powerpc/kernel/iommu.c:1115
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.11.0-rc1-10505-g8d33668-dirty #=
16
task: c0000001fe080000 ti: c0000001fe07c000 task.ti: c0000001fe07c000
NIP: c00000000001b538 LR: c000000000858210 CTR: c000000000316b70
REGS: c0000001fe07f880 TRAP: 0700   Not tainted  (3.11.0-rc1-10505-g8d33668=
-dirty)
MSR: 0000000080029000 <CE,EE,ME>  CR: 84adbe82  XER: 00000000
SOFTE: 1

GPR00: 0000000000000001 c0000001fe07fb00 c000000000995fb8 c0000001fe26cc00=
=20
GPR04: 0000000000000000 0000000000000000 c000000000955b88 0000000000000000=
=20
GPR08: c000000000892ce8 0000000000000001 000000000a870000 0000000000000001=
=20
GPR12: 0000000024adbe82 c00000000fffa000 c000000000001b30 0000000000000000=
=20
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR24: 0000000000000000 c00000000088da28 00000000000000a7 c000000000883ed0=
=20
GPR28: 0000000000000000 c0000001fe00c098 c0000000008fc020 c0000001fe00c000=
=20
NIP [c00000000001b538] .iommu_add_device+0x38/0x110
LR [c000000000858210] .tce_iommu_init+0x24/0x74
Call Trace:
[c0000001fe07fb00] [c000000000316e24] .pci_get_subsys+0x34/0x50 (unreliable=
)
[c0000001fe07fb90] [c000000000858210] .tce_iommu_init+0x24/0x74
[c0000001fe07fc10] [c00000000000138c] .do_one_initcall+0x5c/0x1b0
[c0000001fe07fd00] [c000000000851b28] .kernel_init_freeable+0x14c/0x214
[c0000001fe07fdb0] [c000000000001b4c] .kernel_init+0x1c/0x4d0
[c0000001fe07fe30] [c000000000000878] .ret_from_kernel_thread+0x5c/0x64
Instruction dump:
fba1ffe8 fbc1fff0 fbe1fff8 7c7d1b78 ebc28200 f8010010 f821ff71 e8630178=20
7c600074 7800d182 68000001 7c0907b4 <0b000000> 2fa90000 409e0068 eb9d0100=20
---[ end trace 1962e9b02154856d ]---
iommu_tce: device 0000:00:00.0 is already in iommu group 9, skipping
------------[ cut here ]------------
WARNING: at arch/powerpc/kernel/iommu.c:1115
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W    3.11.0-rc1-10505-g8d33=
668-dirty #16
task: c0000001fe080000 ti: c0000001fe07c000 task.ti: c0000001fe07c000
NIP: c00000000001b538 LR: c000000000858210 CTR: c000000000316b70
REGS: c0000001fe07f880 TRAP: 0700   Tainted: G        W     (3.11.0-rc1-105=
05-g8d33668-dirty)
MSR: 0000000080029000 <CE,EE,ME>  CR: 84adbe24  XER: 00000000
SOFTE: 1

GPR00: 0000000000000001 c0000001fe07fb00 c000000000995fb8 c0000001fe26cc00=
=20
GPR04: 0000000000000000 c0000001fe276200 c000000000955b88 c0000001fe00c000=
=20
GPR08: 20392c20736b6970 0000000000000001 c0000000009a3910 0000000000000001=
=20
GPR12: 0000000024adbe24 c00000000fffa000 c000000000001b30 0000000000000000=
=20
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR24: 0000000000000000 c00000000088da28 00000000000000a7 c000000000883ed0=
=20
GPR28: 0000000000000000 c0000001fe00c898 c0000000008fc020 c0000001fe00c800=
=20
NIP [c00000000001b538] .iommu_add_device+0x38/0x110
LR [c000000000858210] .tce_iommu_init+0x24/0x74
Call Trace:
[c0000001fe07fb00] [c000000000316e24] .pci_get_subsys+0x34/0x50 (unreliable=
)
[c0000001fe07fb90] [c000000000858210] .tce_iommu_init+0x24/0x74
[c0000001fe07fc10] [c00000000000138c] .do_one_initcall+0x5c/0x1b0
[c0000001fe07fd00] [c000000000851b28] .kernel_init_freeable+0x14c/0x214
[c0000001fe07fdb0] [c000000000001b4c] .kernel_init+0x1c/0x4d0
[c0000001fe07fe30] [c000000000000878] .ret_from_kernel_thread+0x5c/0x64
Instruction dump:
fba1ffe8 fbc1fff0 fbe1fff8 7c7d1b78 ebc28200 f8010010 f821ff71 e8630178=20
7c600074 7800d182 68000001 7c0907b4 <0b000000> 2fa90000 409e0068 eb9d0100=20
---[ end trace 1962e9b02154856e ]---
iommu_tce: device 0000:01:00.0 is already in iommu group 9, skipping
------------[ cut here ]------------
WARNING: at arch/powerpc/kernel/iommu.c:1115
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W    3.11.0-rc1-10505-g8d33=
668-dirty #16
task: c0000001fe080000 ti: c0000001fe07c000 task.ti: c0000001fe07c000
NIP: c00000000001b538 LR: c000000000858210 CTR: c000000000316b70
REGS: c0000001fe07f880 TRAP: 0700   Tainted: G        W     (3.11.0-rc1-105=
05-g8d33668-dirty)
MSR: 0000000080029000 <CE,EE,ME>  CR: 82adbe24  XER: 00000000
SOFTE: 1

GPR00: 0000000000000001 c0000001fe07fb00 c000000000995fb8 c0000001fe26cd00=
=20
GPR04: 0000000000000000 c0000001fe276500 c000000000955b88 c0000001fe00c800=
=20
GPR08: 20392c2000000000 0000000000000001 c0000000009a3910 0000000000000001=
=20
GPR12: 0000000022adbe24 c00000000fffa000 c000000000001b30 0000000000000000=
=20
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR24: 0000000000000000 c00000000088da28 00000000000000a7 c000000000883ed0=
=20
GPR28: 0000000000000000 c0000001fe00d098 c0000000008fc020 c0000001fe00d000=
=20
NIP [c00000000001b538] .iommu_add_device+0x38/0x110
LR [c000000000858210] .tce_iommu_init+0x24/0x74
Call Trace:
[c0000001fe07fb00] [c000000000316e24] .pci_get_subsys+0x34/0x50 (unreliable=
)
[c0000001fe07fb90] [c000000000858210] .tce_iommu_init+0x24/0x74
[c0000001fe07fc10] [c00000000000138c] .do_one_initcall+0x5c/0x1b0
[c0000001fe07fd00] [c000000000851b28] .kernel_init_freeable+0x14c/0x214
[c0000001fe07fdb0] [c000000000001b4c] .kernel_init+0x1c/0x4d0
[c0000001fe07fe30] [c000000000000878] .ret_from_kernel_thread+0x5c/0x64
Instruction dump:
fba1ffe8 fbc1fff0 fbe1fff8 7c7d1b78 ebc28200 f8010010 f821ff71 e8630178=20
7c600074 7800d182 68000001 7c0907b4 <0b000000> 2fa90000 409e0068 eb9d0100=20
---[ end trace 1962e9b02154856f ]---
iommu_tce: device 0001:00:00.0 is already in iommu group 7, skipping
------------[ cut here ]------------
WARNING: at arch/powerpc/kernel/iommu.c:1115
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W    3.11.0-rc1-10505-g8d33=
668-dirty #16
task: c0000001fe080000 ti: c0000001fe07c000 task.ti: c0000001fe07c000
NIP: c00000000001b538 LR: c000000000858210 CTR: c000000000316b70
REGS: c0000001fe07f880 TRAP: 0700   Tainted: G        W     (3.11.0-rc1-105=
05-g8d33668-dirty)
MSR: 0000000080029000 <CE,EE,ME>  CR: 84adbe24  XER: 00000000
SOFTE: 1

GPR00: 0000000000000001 c0000001fe07fb00 c000000000995fb8 c0000001fe26cd00=
=20
GPR04: 0000000000000000 c0000001fe276980 c000000000955b88 c0000001fe00d000=
=20
GPR08: 20372c20736b6970 0000000000000001 c0000000009a3910 0000000000000001=
=20
GPR12: 0000000024adbe24 c00000000fffa000 c000000000001b30 0000000000000000=
=20
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR24: 0000000000000000 c00000000088da28 00000000000000a7 c000000000883ed0=
=20
GPR28: 0000000000000000 c0000001fe00d898 c0000000008fc020 c0000001fe00d800=
=20
NIP [c00000000001b538] .iommu_add_device+0x38/0x110
LR [c000000000858210] .tce_iommu_init+0x24/0x74
Call Trace:
[c0000001fe07fb00] [c000000000316e24] .pci_get_subsys+0x34/0x50 (unreliable=
)
[c0000001fe07fb90] [c000000000858210] .tce_iommu_init+0x24/0x74
[c0000001fe07fc10] [c00000000000138c] .do_one_initcall+0x5c/0x1b0
[c0000001fe07fd00] [c000000000851b28] .kernel_init_freeable+0x14c/0x214
[c0000001fe07fdb0] [c000000000001b4c] .kernel_init+0x1c/0x4d0
[c0000001fe07fe30] [c000000000000878] .ret_from_kernel_thread+0x5c/0x64
Instruction dump:
fba1ffe8 fbc1fff0 fbe1fff8 7c7d1b78 ebc28200 f8010010 f821ff71 e8630178=20
7c600074 7800d182 68000001 7c0907b4 <0b000000> 2fa90000 409e0068 eb9d0100=20
---[ end trace 1962e9b021548570 ]---
iommu_tce: device 0001:01:00.0 is already in iommu group 7, skipping
Switched to clocksource timebase
NET: Registered protocol family 2
TCP established hash table entries: 65536 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 65536 bind 65536)
TCP: reno registered
UDP hash table entries: 4096 (order: 5, 131072 bytes)
UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
Trying to unpack rootfs image as initramfs...
rootfs image is not initramfs (no cpio magic); looks like an initrd
Freeing initrd memory: 74392K (c00000002b759000 - c00000002ffff000)
HugeTLB registered 4 MB page size, pre-allocated 0 pages
HugeTLB registered 16 MB page size, pre-allocated 0 pages
HugeTLB registered 64 MB page size, pre-allocated 0 pages
HugeTLB registered 256 MB page size, pre-allocated 0 pages
HugeTLB registered 1 GB page size, pre-allocated 0 pages
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
NTFS driver 2.1.30 [Flags: R/O].
jffs2: version 2.2. (NAND)  2001-2006 Red Hat, Inc.
msgmni has been set to 15985
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0xffe11c500 (irq =3D 36) is a 16550A
console [ttyS0] enabled, bootconsole disabled
console [ttyS0] enabled, bootconsole disabled
serial8250.0: ttyS1 at MMIO 0xffe11c600 (irq =3D 36) is a 16550A
serial8250.0: ttyS2 at MMIO 0xffe11d500 (irq =3D 37) is a 16550A
serial8250.0: ttyS3 at MMIO 0xffe11d600 (irq =3D 37) is a 16550A
brd: module loaded
loop: module loaded
fsl-sata ffe220000.sata: Sata FSL Platform/CSB Driver init
scsi0 : sata_fsl
ata1: SATA max UDMA/133 irq 68
fsl-sata ffe221000.sata: Sata FSL Platform/CSB Driver init
scsi1 : sata_fsl
ata2: SATA max UDMA/133 irq 69
fe8000000.flash: Found 1 x16 devices at 0x0 in 16-bit bank. Manufacturer ID=
 0x000001 Chip ID 0x002801
Amd/Fujitsu Extended Query Table at 0x0040
  Amd/Fujitsu Extended Query version 1.3.
number of CFI chips: 1
ftl_cs: FTL header not found.
ONFI param page 0 valid
ONFI flash detected
NAND device: Manufacturer ID: 0x2c, Chip ID: 0xdc (Micron MT29F4G08ABADAWP)=
, 512MiB, page size: 2048, OOB size: 64
Bad block table found at page 262080, version 0x01
Bad block table found at page 262016, version 0x01
6 ofpart partitions found on MTD device ffa00000.flash
Creating 6 MTD partitions on "ffa00000.flash":
0x000000000000-0x000002000000 : "NAND U-Boot Image"
ftl_cs: FTL header not found.
0x000002000000-0x000012000000 : "NAND Root File System"
ftl_cs: FTL header not found.
0x000012000000-0x00001a000000 : "NAND Compressed RFS Image"
ftl_cs: FTL header not found.
0x00001a000000-0x00001e000000 : "NAND Linux Kernel Image"
ftl_cs: FTL header not found.
0x00001e000000-0x00001f000000 : "NAND DTB Image"
ftl_cs: FTL header not found.
0x00001f000000-0x000020000000 : "NAND Writable User area"
ftl_cs: FTL header not found.
eLBC NAND device at 0xfffa00000, bank 2
fsl_espi ffe110000.spi: master is unqueued, this is deprecated
m25p80 spi32766.0: found s25fl129p1, expected s25sl12801
m25p80 spi32766.0: s25fl129p1 (16384 Kbytes)
4 ofpart partitions found on MTD device spi32766.0
Creating 4 MTD partitions on "spi32766.0":
0x000000000000-0x000000100000 : "u-boot"
ftl_cs: FTL header not found.
0x000000100000-0x000000600000 : "kernel"
ftl_cs: FTL header not found.
0x000000600000-0x000000700000 : "dtb"
ftl_cs: FTL header not found.
0x000000700000-0x000001000000 : "file system"
ftl_cs: FTL header not found.
fsl_espi ffe110000.spi: at 0x8000080080058000 (irq =3D 53)
e1000e: Intel(R) PRO/1000 Network Driver - 2.3.2-k
e1000e: Copyright(c) 1999 - 2013 Intel Corporation.
e1000e 0001:01:00.0: Disabling ASPM L0s L1
e1000e 0001:01:00.0: Interrupt Throttling Rate (ints/sec) set to dynamic co=
nservative mode
e1000e 0001:01:00.0 eth0: registered PHC clock
e1000e 0001:01:00.0 eth0: (PCI Express:2.5GT/s:Width x1) 00:1b:21:81:d2:e3
e1000e 0001:01:00.0 eth0: Intel(R) PRO/1000 Network Connection
e1000e 0001:01:00.0 eth0: MAC: 3, PHY: 8, PBA No: E46981-004
VFIO - User Level meta-driver version: 0.3
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-pci: EHCI PCI platform driver
fsl-ehci fsl-ehci.0: Freescale On-Chip EHCI Host Controller
fsl-ehci fsl-ehci.0: new USB bus registered, assigned bus number 1
fsl-ehci fsl-ehci.0: irq 44, io mem 0xffe210000
fsl-ehci fsl-ehci.0: USB 2.0 started, EHCI 1.00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
usbcore: registered new interface driver usb-storage
i2c /dev entries driver
mpc-i2c ffe118100.i2c: timeout 1000000 us
mpc-i2c ffe119100.i2c: timeout 1000000 us
mpc-i2c ffe118000.i2c: timeout 1000000 us
mpc-i2c ffe119000.i2c: timeout 1000000 us
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
------------[ cut here ]------------
WARNING: at arch/powerpc/kernel/iommu.c:1115
Modules linked in:
CPU: 2 PID: 1 Comm: swapper/0 Tainted: G        W    3.11.0-rc1-10505-g8d33=
668-dirty #16
task: c0000001fe080000 ti: c0000001fe07c000 task.ti: c0000001fe07c000
NIP: c00000000001b538 LR: c00000000007ea24 CTR: c00000000001b610
REGS: c0000001fe07ef10 TRAP: 0700   Tainted: G        W     (3.11.0-rc1-105=
05-g8d33668-dirty)
MSR: 0000000080029000 <CE,EE,ME>  CR: 24ad2e82  XER: 00000000
SOFTE: 1

GPR00: 0000000000000001 c0000001fe07f190 c000000000995fb8 c00000002e3f9a00=
=20
GPR04: 0000000000000001 c00000002e1eb010 ffffffffffffffff 0000000000000000=
=20
GPR08: 0000000000000000 0000000000000001 0000000000000000 0000000000000000=
=20
GPR12: 0000000024ad2e88 c00000000fffa800 c000000000001b30 0000000000000000=
=20
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR20: 0000000000000000 ata1: No Device OR PHYRDY change,Hstatus =3D 0xa000=
0000
ata1: SATA link down (SStatus 0 SControl 300)
0000000000000000 0000000000000000 0000000000000000=20
GPR24: c0000000009c6288 c0000000008a9090 ata2: No Device OR PHYRDY change,H=
status =3D 0xa0000000
ata2: SATA link down (SStatus 0 SControl 300)
0000000000000000 0000000000000000=20
GPR28: fffffffffffffffb c00000002e1eb010 c0000000008fc020 0000000000000001=
=20
NIP [c00000000001b538] .iommu_add_device+0x38/0x110
LR [c00000000007ea24] .notifier_call_chain+0x94/0xf0
Call Trace:
[c0000001fe07f190] [c0000000004cbe78] .iommu_bus_notifier+0xe8/0x180 (unrel=
iable)
[c0000001fe07f220] [c00000000007ea24] .notifier_call_chain+0x94/0xf0
[c0000001fe07f2c0] [c00000000007ef48] .__blocking_notifier_call_chain+0x58/=
0x90
[c0000001fe07f370] [c000000000373f9c] .device_add+0x4fc/0x710
[c0000001fe07f450] [c0000000004c1ff8] .of_device_add+0x68/0x80
[c0000001fe07f4c0] [c0000000004c29d4] .of_platform_device_create_pdata+0xb4=
/0xe0
[c0000001fe07f560] [c0000000004a7b90] .caam_jr_probe+0xa0/0x3e0
[c0000001fe07f620] [c0000000004a65f4] .caam_probe+0x1c4/0x8d0
[c0000001fe07f710] [c000000000379780] .platform_drv_probe+0x30/0x50
[c0000001fe07f780] [c000000000377bf4] .driver_probe_device+0xe4/0x2c0
[c0000001fe07f820] [c000000000377edc] .__driver_attach+0x10c/0x110
[c0000001fe07f8b0] [c0000000003756ac] .bus_for_each_dev+0xac/0x100
[c0000001fe07f950] [c000000000377648] .driver_attach+0x28/0x40
[c0000001fe07f9d0] [c000000000376fd8] .bus_add_driver+0x258/0x2d0
[c0000001fe07fa70] [c000000000378450] .driver_register+0xa0/0x1e0
[c0000001fe07fb10] [c000000000379be4] .__platform_driver_register+0x64/0x80
[c0000001fe07fb90] [c000000000874ca4] .caam_driver_init+0x20/0x38
[c0000001fe07fc10] [c00000000000138c] .do_one_initcall+0x5c/0x1b0
[c0000001fe07fd00] [c000000000851b28] .kernel_init_freeable+0x14c/0x214
[c0000001fe07fdb0] [c000000000001b4c] .kernel_init+0x1c/0x4d0
[c0000001fe07fe30] [c000000000000878] .ret_from_kernel_thread+0x5c/0x64
Instruction dump:
fba1ffe8 fbc1fff0 fbe1fff8 7c7d1b78 ebc28200 f8010010 f821ff71 e8630178=20
7c600074 7800d182 68000001 7c0907b4 <0b000000> 2fa90000 409e0068 eb9d0100=20
---[ end trace 1962e9b021548571 ]---
iommu_tce: device ffe301000.jr is already in iommu group 8, skipping
------------[ cut here ]------------
WARNING: at arch/powerpc/kernel/iommu.c:1115
Modules linked in:
CPU: 2 PID: 1 Comm: swapper/0 Tainted: G        W    3.11.0-rc1-10505-g8d33=
668-dirty #16
task: c0000001fe080000 ti: c0000001fe07c000 task.ti: c0000001fe07c000
NIP: c00000000001b538 LR: c00000000007ea24 CTR: c00000000001b610
REGS: c0000001fe07ef10 TRAP: 0700   Tainted: G        W     (3.11.0-rc1-105=
05-g8d33668-dirty)
MSR: 0000000080029000 <CE,EE,ME>  CR: 24ad2e82  XER: 00000000
SOFTE: 1

GPR00: 0000000000000001 c0000001fe07f190 c000000000995fb8 c00000002e3f9e00=
=20
GPR04: 0000000000000001 c00000002e1eb210 ffffffffffffffff 0000000000000000=
=20
GPR08: 0000000000000000 0000000000000001 0000000000000000 0000000000000000=
=20
GPR12: 0000000024ad2e88 c00000000fffa800 c000000000001b30 0000000000000000=
=20
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR24: c0000000009c6288 c0000000008a9090 0000000000000000 0000000000000000=
=20
GPR28: fffffffffffffffb c00000002e1eb210 c0000000008fc020 0000000000000001=
=20
NIP [c00000000001b538] .iommu_add_device+0x38/0x110
LR [c00000000007ea24] .notifier_call_chain+0x94/0xf0
Call Trace:
[c0000001fe07f190] [c0000000004cbe78] .iommu_bus_notifier+0xe8/0x180 (unrel=
iable)
[c0000001fe07f220] [c00000000007ea24] .notifier_call_chain+0x94/0xf0
[c0000001fe07f2c0] [c00000000007ef48] .__blocking_notifier_call_chain+0x58/=
0x90
[c0000001fe07f370] [c000000000373f9c] .device_add+0x4fc/0x710
[c0000001fe07f450] [c0000000004c1ff8] .of_device_add+0x68/0x80
[c0000001fe07f4c0] [c0000000004c29d4] .of_platform_device_create_pdata+0xb4=
/0xe0
[c0000001fe07f560] [c0000000004a7b90] .caam_jr_probe+0xa0/0x3e0
[c0000001fe07f620] [c0000000004a65f4] .caam_probe+0x1c4/0x8d0
[c0000001fe07f710] [c000000000379780] .platform_drv_probe+0x30/0x50
[c0000001fe07f780] [c000000000377bf4] .driver_probe_device+0xe4/0x2c0
[c0000001fe07f820] [c000000000377edc] .__driver_attach+0x10c/0x110
[c0000001fe07f8b0] [c0000000003756ac] .bus_for_each_dev+0xac/0x100
[c0000001fe07f950] [c000000000377648] .driver_attach+0x28/0x40
[c0000001fe07f9d0] [c000000000376fd8] .bus_add_driver+0x258/0x2d0
[c0000001fe07fa70] [c000000000378450] .driver_register+0xa0/0x1e0
[c0000001fe07fb10] [c000000000379be4] .__platform_driver_register+0x64/0x80
[c0000001fe07fb90] [c000000000874ca4] .caam_driver_init+0x20/0x38
[c0000001fe07fc10] [c00000000000138c] .do_one_initcall+0x5c/0x1b0
[c0000001fe07fd00] [c000000000851b28] .kernel_init_freeable+0x14c/0x214
[c0000001fe07fdb0] [c000000000001b4c] .kernel_init+0x1c/0x4d0
[c0000001fe07fe30] [c000000000000878] .ret_from_kernel_thread+0x5c/0x64
Instruction dump:
fba1ffe8 fbc1fff0 fbe1fff8 7c7d1b78 ebc28200 f8010010 f821ff71 e8630178=20
7c600074 7800d182 68000001 7c0907b4 <0b000000> 2fa90000 409e0068 eb9d0100=20
---[ end trace 1962e9b021548572 ]---
iommu_tce: device ffe302000.jr is already in iommu group 10, skipping
------------[ cut here ]------------
WARNING: at arch/powerpc/kernel/iommu.c:1115
Modules linked in:
CPU: 2 PID: 1 Comm: swapper/0 Tainted: G        W    3.11.0-rc1-10505-g8d33=
668-dirty #16
task: c0000001fe080000 ti: c0000001fe07c000 task.ti: c0000001fe07c000
NIP: c00000000001b538 LR: c00000000007ea24 CTR: c00000000001b610
REGS: c0000001fe07ef10 TRAP: 0700   Tainted: G        W     (3.11.0-rc1-105=
05-g8d33668-dirty)
MSR: 0000000080029000 <CE,EE,ME>  CR: 24ad2e82  XER: 00000000
SOFTE: 1

GPR00: 0000000000000001 c0000001fe07f190 c000000000995fb8 c0000001fe15f500=
=20
GPR04: 0000000000000001 c00000002e1eb410 ffffffffffffffff 0000000000000000=
=20
GPR08: 0000000000000000 0000000000000001 0000000000000000 0000000000000000=
=20
GPR12: 0000000024ad2e88 c00000000fffa800 c000000000001b30 0000000000000000=
=20
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR24: c0000000009c6288 c0000000008a9090 0000000000000000 0000000000000000=
=20
GPR28: fffffffffffffffb c00000002e1eb410 c0000000008fc020 0000000000000001=
=20
NIP [c00000000001b538] .iommu_add_device+0x38/0x110
LR [c00000000007ea24] .notifier_call_chain+0x94/0xf0
Call Trace:
[c0000001fe07f190] [c0000000004cbe78] .iommu_bus_notifier+0xe8/0x180 (unrel=
iable)
[c0000001fe07f220] [c00000000007ea24] .notifier_call_chain+0x94/0xf0
[c0000001fe07f2c0] [c00000000007ef48] .__blocking_notifier_call_chain+0x58/=
0x90
[c0000001fe07f370] [c000000000373f9c] .device_add+0x4fc/0x710
[c0000001fe07f450] [c0000000004c1ff8] .of_device_add+0x68/0x80
[c0000001fe07f4c0] [c0000000004c29d4] .of_platform_device_create_pdata+0xb4=
/0xe0
[c0000001fe07f560] [c0000000004a7b90] .caam_jr_probe+0xa0/0x3e0
[c0000001fe07f620] [c0000000004a65f4] .caam_probe+0x1c4/0x8d0
[c0000001fe07f710] [c000000000379780] .platform_drv_probe+0x30/0x50
[c0000001fe07f780] [c000000000377bf4] .driver_probe_device+0xe4/0x2c0
[c0000001fe07f820] [c000000000377edc] .__driver_attach+0x10c/0x110
[c0000001fe07f8b0] [c0000000003756ac] .bus_for_each_dev+0xac/0x100
[c0000001fe07f950] [c000000000377648] .driver_attach+0x28/0x40
[c0000001fe07f9d0] [c000000000376fd8] .bus_add_driver+0x258/0x2d0
[c0000001fe07fa70] [c000000000378450] .driver_register+0xa0/0x1e0
[c0000001fe07fb10] [c000000000379be4] .__platform_driver_register+0x64/0x80
[c0000001fe07fb90] [c000000000874ca4] .caam_driver_init+0x20/0x38
[c0000001fe07fc10] [c00000000000138c] .do_one_initcall+0x5c/0x1b0
[c0000001fe07fd00] [c000000000851b28] .kernel_init_freeable+0x14c/0x214
[c0000001fe07fdb0] [c000000000001b4c] .kernel_init+0x1c/0x4d0
[c0000001fe07fe30] [c000000000000878] .ret_from_kernel_thread+0x5c/0x64
Instruction dump:
fba1ffe8 fbc1fff0 fbe1fff8 7c7d1b78 ebc28200 f8010010 f821ff71 e8630178=20
7c600074 7800d182 68000001 7c0907b4 <0b000000> 2fa90000 409e0068 eb9d0100=20
---[ end trace 1962e9b021548573 ]---
iommu_tce: device ffe303000.jr is already in iommu group 11, skipping
------------[ cut here ]------------
WARNING: at arch/powerpc/kernel/iommu.c:1115
Modules linked in:
CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W    3.11.0-rc1-10505-g8d33=
668-dirty #16
task: c0000001fe080000 ti: c0000001fe07c000 task.ti: c0000001fe07c000
NIP: c00000000001b538 LR: c00000000007ea24 CTR: c00000000001b610
REGS: c0000001fe07ef10 TRAP: 0700   Tainted: G        W     (3.11.0-rc1-105=
05-g8d33668-dirty)
MSR: 0000000080029000 <CE,EE,ME>  CR: 24ad2e82  XER: 00000000
SOFTE: 1

GPR00: 0000000000000001 c0000001fe07f190 c000000000995fb8 c0000001fe13e800=
=20
GPR04: 0000000000000001 c0000001fe1df410 ffffffffffffffff 0000000000000000=
=20
GPR08: 0000000000000000 0000000000000001 0000000000000000 0000000000000000=
=20
GPR12: 0000000024ad2e88 c00000000fffa400 c000000000001b30 0000000000000000=
=20
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR24: c0000000009c6288 c0000000008a9090 0000000000000000 0000000000000000=
=20
GPR28: fffffffffffffffb c0000001fe1df410 c0000000008fc020 0000000000000001=
=20
NIP [c00000000001b538] .iommu_add_device+0x38/0x110
LR [c00000000007ea24] .notifier_call_chain+0x94/0xf0
Call Trace:
[c0000001fe07f190] [c0000000004cbe78] .iommu_bus_notifier+0xe8/0x180 (unrel=
iable)
[c0000001fe07f220] [c00000000007ea24] .notifier_call_chain+0x94/0xf0
[c0000001fe07f2c0] [c00000000007ef48] .__blocking_notifier_call_chain+0x58/=
0x90
[c0000001fe07f370] [c000000000373f9c] .device_add+0x4fc/0x710
[c0000001fe07f450] [c0000000004c1ff8] .of_device_add+0x68/0x80
[c0000001fe07f4c0] [c0000000004c29d4] .of_platform_device_create_pdata+0xb4=
/0xe0
[c0000001fe07f560] [c0000000004a7b90] .caam_jr_probe+0xa0/0x3e0
[c0000001fe07f620] [c0000000004a65f4] .caam_probe+0x1c4/0x8d0
[c0000001fe07f710] [c000000000379780] .platform_drv_probe+0x30/0x50
[c0000001fe07f780] [c000000000377bf4] .driver_probe_device+0xe4/0x2c0
[c0000001fe07f820] [c000000000377edc] .__driver_attach+0x10c/0x110
[c0000001fe07f8b0] [c0000000003756ac] .bus_for_each_dev+0xac/0x100
[c0000001fe07f950] [c000000000377648] .driver_attach+0x28/0x40
[c0000001fe07f9d0] [c000000000376fd8] .bus_add_driver+0x258/0x2d0
[c0000001fe07fa70] [c000000000378450] .driver_register+0xa0/0x1e0
[c0000001fe07fb10] [c000000000379be4] .__platform_driver_register+0x64/0x80
[c0000001fe07fb90] [c000000000874ca4] .caam_driver_init+0x20/0x38
[c0000001fe07fc10] [c00000000000138c] .do_one_initcall+0x5c/0x1b0
[c0000001fe07fd00] [c000000000851b28] .kernel_init_freeable+0x14c/0x214
[c0000001fe07fdb0] [c000000000001b4c] .kernel_init+0x1c/0x4d0
[c0000001fe07fe30] [c000000000000878] .ret_from_kernel_thread+0x5c/0x64
Instruction dump:
fba1ffe8 fbc1fff0 fbe1fff8 7c7d1b78 ebc28200 f8010010 f821ff71 e8630178=20
7c600074 7800d182 68000001 7c0907b4 <0b000000> 2fa90000 409e0068 eb9d0100=20
---[ end trace 1962e9b021548574 ]---
iommu_tce: device ffe304000.jr is already in iommu group 12, skipping
caam ffe300000.crypto: device ID =3D 0x0a13010000000000 (Era -524)
caam ffe300000.crypto: job rings =3D 4, qi =3D 1
caam ffe300000.crypto: fsl,sec-v5.2 algorithms registered in /proc/crypto
platform ffe301000.jr: registering rng-caam
ipip: IPv4 over IPv4 tunneling driver
TCP: cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 10
sit: IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 15
Key type dns_resolver registered
RAMDISK: gzip image found at block 0
VFS: Mounted root (ext2 filesystem) on device 1:0.
Freeing unused kernel memory: 268K (c000000000851000 - c000000000894000)
INIT: version 2.88 booting
Starting udev
Starting Bootlog daemon: bootlogd.
Configuring network interfaces... done.
net.ipv4.conf.default.rp_filter =3D 0
net.ipv4.conf.all.rp_filter =3D 0
hwclock: can't open '/dev/misc/rtc': No such file or directory
Wed Sep  5 19:45:00 UTC 2012
hwclock: can't open '/dev/misc/rtc': No such file or directory
Running postinst /etc/rpm-postinsts/100...
update-alternatives: Linking //usr/sbin/add-shell to add-shell.debianutils
update-alternatives: Linking //usr/sbin/installkernel to installkernel.debi=
anutils
update-alternatives: Linking //usr/sbin/mkboot to mkboot.debianutils
update-alternatives: Linking //usr/sbin/remove-shell to remove-shell.debian=
utils
update-alternatives: Linking //usr/bin/savelog to savelog.debianutils
update-alternatives: Linking //usr/bin/sensible-browser to sensible-browser=
.debianutils
update-alternatives: Linking //usr/bin/sensible-editor to sensible-editor.d=
ebianutils
update-alternatives: Linking //usr/bin/sensible-pager to sensible-pager.deb=
ianutils
update-alternatives: Linking //usr/bin/which to which.debianutils
update-alternatives: Linking //bin/run-parts to run-parts.debianutils
update-alternatives: Linking //bin/tempfile to tempfile.debianutils
Running postinst /etc/rpm-postinsts/101...
WARNING: -e needs -E or -F
WARNING: Couldn't open directory /lib/modules/3.11.0-rc1-10505-g8d33668-dir=
ty: No such file or directory
FATAL: Could not open /lib/modules/3.11.0-rc1-10505-g8d33668-dirty/modules.=
dep.temp for writing: No such file or directory
INIT: Entering runlevel: 5postinsts/102...
Starting Dropbear SSH server: Will output 1024 bit rsa secret key to '/etc/=
dropbear/dropbear_rsa_host_key'
Generating key, this may take a while...
Public key portion is:
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAgwClgV0llGONsTqePbqwQKb/s2n4fCDuFm8JWq1=
GCZ0sBFom2D0OXeQsS7fD6D8yhSDYjuk876kryMntPfxQEIXLXg/MHQe9YSXedxaF0RXXJHB1Fk=
hBSFJekqe5fLgLXZXTiaVqi74dhtq04ucBcDqu8LSI+A2NZJI5YUYiG4/rcndd root@p5040ds
Fingerprint: md5 61:74:c1:17:1b:88:92:3e:bc:3f:80:4d:22:24:32:ce
dropbear.
Starting network benchmark server: netserver.
Starting system log daemon...0
Starting kernel log daemon...0
Stopping Bootlog daemon: bootlogd.

Yocto (Built by Poky 7.0) 1.2 p5040ds ttyS0

p5040ds login:

---------------------- End of bootlog--------------------------------------

And this simple fix work for me=20
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index b20ff17..8869b0d 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -48,6 +48,8 @@
 #include <asm/vio.h>
 #include <asm/tce.h>
=20
+#define DEBUG
+
 #define DBG(...)
=20
 static int novmerge;
@@ -871,7 +873,7 @@ void iommu_free_coherent(struct iommu_table *tbl, size_=
t size,
        }
 }
=20
-#ifdef CONFIG_IOMMU_API
+#ifdef SPAPR_TCE_IOMMU
 /*
  * SPAPR TCE API
  */
----------------------


Thanks
-Bharat
