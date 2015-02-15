Return-Path: <runaway@candw.ms>
Received: from mail-vc0-f171.google.com (mail-vc0-f171.google.com
 [209.85.220.171])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 422411A0728
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Feb 2015 23:16:14 +1100 (AEDT)
Received: by mail-vc0-f171.google.com with SMTP id kv19so9061289vcb.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Feb 2015 04:16:11 -0800 (PST)
Received: from [192.168.1.10] ([209.59.111.79])
 by mx.google.com with ESMTPSA id i3sm2546562vdv.6.2015.02.15.04.16.07
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 15 Feb 2015 04:16:09 -0800 (PST)
Message-ID: <54E08E06.8060607@candw.ms>
Date: Sun, 15 Feb 2015 08:16:06 -0400
From: Julian Margetson <runaway@candw.ms>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Problems with Kernels 3.17-rc1 and onwards on Acube Sam460 AMCC 460ex
 board
Content-Type: multipart/alternative;
 boundary="------------010106060805060703020500"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------010106060805060703020500
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

I am unable to get any kernel beyond  the 3.16 branch working on an 
Acube Sam460ex
  AMCC 460ex based motherboard. Kernel  up 3.16.7-ckt6 working.

These are the patches applied

diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
index 49b0659..fa33568 100644
--- a/drivers/gpu/drm/radeon/radeon_device.c
+++ b/drivers/gpu/drm/radeon/radeon_device.c
@@ -1066,7 +1066,7 @@ int radeon_device_init(struct radeon_device *rdev,
  	if (rdev->rmmio == NULL) {
  		return -ENOMEM;
  	}
-	DRM_INFO("register mmio base: 0x%08X\n", (uint32_t)rdev->rmmio_base);
+	DRM_INFO("register mmio base: 0x%llx\n", (uint64_t)rdev->rmmio_base);
  	DRM_INFO("register mmio size: %u\n", (unsigned)rdev->rmmio_size);
  
  	/* io port mapping */
diff --git a/include/drm/ttm/ttm_bo_api.h b/include/drm/ttm/ttm_bo_api.h
index 3cb5d84..fcdb208 100644
--- a/include/drm/ttm/ttm_bo_api.h
+++ b/include/drm/ttm/ttm_bo_api.h
@@ -81,7 +81,7 @@ struct ttm_placement {
   */
  struct ttm_bus_placement {
  	void		*addr;
-	unsigned long	base;
+	phys_addr_t	base;
  	unsigned long	size;
  	unsigned long	offset;
  	bool		is_iomem;



These are the serial boot messages

U-Boot 2010.06.05a (Jan 30 2012 - 16:06:56)

CPU:   AMCC PowerPC 460EX Rev. B at 1155 MHz (PLB=231 OPB=115 EBC=115)
        No Security/Kasumi support
        Bootstrap Option H - Boot ROM Location I2C (Addr 0x52)
        Internal PCI arbiter enabled
        32 kB I-Cache 32 kB D-Cache
Board: Sam460ex, PCIe 4x + PCIe 1x
I2C:   ready
DRAM:  2 GiB (ECC not enabled, 462 MHz, CL4)
PCI:   Bus Dev VenId DevId Class Int
         00  04  1095  3512  0104  00
         00  06  126f  0501  0380  00
PCIE0: successfully set as root-complex
         03  00  1412  1724  0401  ff
         02  00  1b21  1080  0604  00
PCIE1: successfully set as root-complex
         05  00  1002  6758  0300  ff
Net:   ppc_4xx_eth0
FPGA:  Revision 03 (2010-10-07)
SM502: found
VGA:   1
VESA:  OK
[    0.000000] Using Canyonlands machine description
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.17.0-rc1-Sam460ex (root@julian-VirtualBox) (gcc version 4.8.2 (Ubuntu 4.8.2-16ubuntu3) ) #1 PREEMPT Sat Feb 14 19:45:33 AST 2015
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00000000-0x2fffffff]
[    0.000000]   Normal   empty
[    0.000000]   HighMem  [mem 0x30000000-0x7fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00000000-0x7fffffff]
[    0.000000] MMU: Allocated 1088 bytes of context maps for 255 contexts
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 522752
[    0.000000] Kernel command line: root=/dev/sda12 console=ttyS0,115200 console=tty0
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Sorting __ex_table...
[    0.000000] Memory: 2004844K/2097152K available (5764K kernel code, 232K rwdata, 1456K rodata, 236K init, 1333K bss, 92308K reserved, 1310720K highmem)
[    0.000000] Kernel virtual memory layout:
[    0.000000]   * 0xfffcf000..0xfffff000  : fixmap
[    0.000000]   * 0xffc00000..0xffe00000  : highmem PTEs
[    0.000000]   * 0xffa00000..0xffc00000  : consistent mem
[    0.000000]   * 0xffa00000..0xffa00000  : early ioremap
[    0.000000]   * 0xf1000000..0xffa00000  : vmalloc & ioremap
[    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] NR_IRQS:512 nr_irqs:512 16
[    0.000000] UIC0 (32 IRQ sources) at DCR 0xc0
[    0.000000] UIC1 (32 IRQ sources) at DCR 0xd0
[    0.000000] UIC2 (32 IRQ sources) at DCR 0xe0
[    0.000000] UIC3 (32 IRQ sources) at DCR 0xf0
[    0.000013] clocksource: timebase mult[dda520] shift[24] registered
[    0.000138] Console: colour dummy device 80x25
[    0.000557] console [tty0] enabled
[    0.000581] pid_max: default: 32768 minimum: 301
[    0.000683] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000706] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.002800] devtmpfs: initialized
[    0.003674] xor: measuring software checksum speed
[    0.013505]    8regs     :   856.000 MB/sec
[    0.023276]    8regs_prefetch:   780.000 MB/sec
[    0.033309]    32regs    :  1120.000 MB/sec
[    0.043362]    32regs_prefetch:   996.000 MB/sec
[    0.043388] xor: using function: 32regs (1120.000 MB/sec)
[    0.045174] NET: Registered protocol family 16
[    0.046996] 256k L2-cache enabled
[    0.047113] PCIE0: Checking link...
[    0.047126] PCIE0: Device detected, waiting for link...
[    0.047140] PCIE0: link is up !
[    0.149234] PCI host bridge /plb/pciex@d00000000 (primary) ranges:
[    0.149287]  MEM 0x0000000e00000000..0x0000000e7fffffff -> 0x0000000080000000
[    0.149313]  MEM 0x0000000f00000000..0x0000000f000fffff -> 0x0000000000000000
[    0.149336]   IO 0x0000000f80000000..0x0000000f8000ffff -> 0x0000000000000000
[    0.149362] 4xx PCI DMA offset set to 0x00000000
[    0.149375] 4xx PCI DMA window base to 0x0000000000000000
[    0.149390] DMA window size 0x0000000080000000
[    0.149420] PCIE0: successfully set as root-complex
[    0.149460] PCIE1: Checking link...
[    0.149472] PCIE1: Device detected, waiting for link...
[    0.149486] PCIE1: link is up !
[    0.251485] PCI host bridge /plb/pciex@d20000000 (primary) ranges:
[    0.251520]  MEM 0x0000000e80000000..0x0000000effffffff -> 0x0000000080000000
[    0.251546]  MEM 0x0000000f00100000..0x0000000f001fffff -> 0x0000000000000000
[    0.251568]   IO 0x0000000f80010000..0x0000000f8001ffff -> 0x0000000000000000
[    0.251592] 4xx PCI DMA offset set to 0x00000000
[    0.251606] 4xx PCI DMA window base to 0x0000000000000000
[    0.251620] DMA window size 0x0000000080000000
[    0.251646] PCIE1: successfully set as root-complex
[    0.251726] PCI host bridge /plb/pci@c0ec00000 (primary) ranges:
[    0.251748]  MEM 0x0000000d80000000..0x0000000dffffffff -> 0x0000000080000000
[    0.251774]  MEM 0x0000000c0ee00000..0x0000000c0eefffff -> 0x0000000000000000
[    0.251796]   IO 0x0000000c08000000..0x0000000c0800ffff -> 0x0000000000000000
[    0.251819] 4xx PCI DMA offset set to 0x00000000
[    0.251832] 4xx PCI DMA window base to 0x0000000000000000
[    0.251846] DMA window size 0x0000000080000000
[    0.261402] PCI: Probing PCI hardware
[    0.261731] PCI host bridge to bus 0000:40
[    0.261768] pci_bus 0000:40: root bus resource [io  0xfffc0000-0xfffcffff] (bus address [0x0000-0xffff])
[    0.261797] pci_bus 0000:40: root bus resource [mem 0xe00000000-0xe7fffffff] (bus address [0x80000000-0xffffffff])
[    0.261826] pci_bus 0000:40: root bus resource [mem 0xf00000000-0xf000fffff] (bus address [0x00000000-0x000fffff])
[    0.261855] pci_bus 0000:40: root bus resource [bus 40-ff]
[    0.261969] PCI: Hiding 4xx host bridge resources 0000:40:00.0
[    0.264189] pci 0000:40:00.0: PCI bridge to [bus 41-7f]
[    0.264293] pci 0000:41:00.0: bridge configuration invalid ([bus 02-02]), reconfiguring
[    0.264868] pci 0000:41:00.0: PCI bridge to [bus 42-7f]
[    0.265081] PCI host bridge to bus 0001:80
[    0.265106] pci_bus 0001:80: root bus resource [io  0xfffe0000-0xfffeffff] (bus address [0x0000-0xffff])
[    0.265134] pci_bus 0001:80: root bus resource [mem 0xe80000000-0xeffffffff] (bus address [0x80000000-0xffffffff])
[    0.265181] pci_bus 0001:80: root bus resource [mem 0xf00100000-0xf001fffff] (bus address [0x00000000-0x000fffff])
[    0.265209] pci_bus 0001:80: root bus resource [bus 80-ff]
[    0.265305] PCI: Hiding 4xx host bridge resources 0001:80:00.0
[    0.268247] pci 0001:80:00.0: PCI bridge to [bus 81-bf]
[    0.268539] PCI host bridge to bus 0002:00
[    0.268563] pci_bus 0002:00: root bus resource [io  0x0000-0xffff]
[    0.268585] pci_bus 0002:00: root bus resource [mem 0xd80000000-0xdffffffff] (bus address [0x80000000-0xffffffff])
[    0.268614] pci_bus 0002:00: root bus resource [mem 0xc0ee00000-0xc0eefffff] (bus address [0x00000000-0x000fffff])
[    0.268642] pci_bus 0002:00: root bus resource [bus 00-ff]
[    0.269359] pci 0000:40:00.0: BAR 13: assigned [io  0xfffc1000-0xfffc1fff]
[    0.269393] pci 0000:41:00.0: BAR 13: assigned [io  0xfffc1000-0xfffc1fff]
[    0.269415] pci 0000:42:00.0: BAR 1: assigned [io  0xfffc1000-0xfffc107f]
[    0.269440] pci 0000:42:00.0: BAR 0: assigned [io  0xfffc1080-0xfffc109f]
[    0.269463] pci 0000:41:00.0: PCI bridge to [bus 42]
[    0.269482] pci 0000:41:00.0:   bridge window [io  0xfffc1000-0xfffc1fff]
[    0.269511] pci 0000:40:00.0: PCI bridge to [bus 41-7f]
[    0.269529] pci 0000:40:00.0:   bridge window [io  0xfffc1000-0xfffc1fff]
[    0.269615] pci 0001:80:00.0: BAR 15: assigned [mem 0xe80000000-0xe8fffffff 64bit pref]
[    0.269640] pci 0001:80:00.0: BAR 14: assigned [mem 0xe90000000-0xe900fffff]
[    0.269661] pci 0001:80:00.0: BAR 13: assigned [io  0xfffe1000-0xfffe1fff]
[    0.269685] pci 0001:81:00.0: BAR 0: assigned [mem 0xe80000000-0xe8fffffff 64bit pref]
[    0.269717] pci 0001:81:00.0: BAR 2: assigned [mem 0xe90000000-0xe9001ffff 64bit]
[    0.269747] pci 0001:81:00.0: BAR 6: assigned [mem 0xe90020000-0xe9003ffff pref]
[    0.269773] pci 0001:81:00.1: BAR 0: assigned [mem 0xe90040000-0xe90043fff 64bit]
[    0.269802] pci 0001:81:00.0: BAR 4: assigned [io  0xfffe1000-0xfffe10ff]
[    0.269824] pci 0001:80:00.0: PCI bridge to [bus 81-bf]
[    0.269842] pci 0001:80:00.0:   bridge window [io  0xfffe1000-0xfffe1fff]
[    0.269863] pci 0001:80:00.0:   bridge window [mem 0xe90000000-0xe900fffff]
[    0.269883] pci 0001:80:00.0:   bridge window [mem 0xe80000000-0xe8fffffff 64bit pref]
[    0.269968] pci 0002:00:06.0: BAR 0: assigned [mem 0xd80000000-0xd83ffffff]
[    0.269990] pci 0002:00:06.0: BAR 1: assigned [mem 0xd84000000-0xd841fffff]
[    0.270013] pci 0002:00:04.0: BAR 6: assigned [mem 0xd84200000-0xd8427ffff pref]
[    0.270037] pci 0002:00:04.0: BAR 5: assigned [mem 0xd84280000-0xd842801ff]
[    0.270058] pci 0002:00:04.0: BAR 4: assigned [io  0x1000-0x100f]
[    0.270079] pci 0002:00:04.0: BAR 0: assigned [io  0x1010-0x1017]
[    0.270099] pci 0002:00:04.0: BAR 2: assigned [io  0x1018-0x101f]
[    0.270120] pci 0002:00:04.0: BAR 1: assigned [io  0x1020-0x1023]
[    0.270140] pci 0002:00:04.0: BAR 3: assigned [io  0x1024-0x1027]
[    0.298144] raid6: int32x1    300 MB/s
[    0.314619] raid6: int32x2    429 MB/s
[    0.332598] raid6: int32x4    480 MB/s
[    0.349843] raid6: int32x8    234 MB/s
[    0.349865] raid6: using algorithm int32x4 (480 MB/s)
[    0.349880] raid6: using intx1 recovery algorithm
[    0.350216] vgaarb: device added: PCI:0001:81:00.0,decodes=io+mem,owns=none,locks=none
[    0.350248] vgaarb: loaded
[    0.350259] vgaarb: bridge control possible 0001:81:00.0
[    0.350804] SCSI subsystem initialized
[    0.351433] usbcore: registered new interface driver usbfs
[    0.351518] usbcore: registered new interface driver hub
[    0.351630] usbcore: registered new device driver usb
[    0.352644] Switched to clocksource timebase
[    0.362225] NET: Registered protocol family 2
[    0.363055] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.363156] TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
[    0.363233] TCP: Hash tables configured (established 8192 bind 8192)
[    0.363343] TCP: reno registered
[    0.363362] UDP hash table entries: 512 (order: 1, 8192 bytes)
[    0.363394] UDP-Lite hash table entries: 512 (order: 1, 8192 bytes)
[    0.363571] NET: Registered protocol family 1
[    0.364087] RPC: Registered named UNIX socket transport module.
[    0.364119] RPC: Registered udp transport module.
[    0.364133] RPC: Registered tcp transport module.
[    0.364147] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.364803] Could not remap bcsr
[    0.368882] genirq: Setting trigger mode 3 for irq 45 failed (uic_set_irq_type+0x0/0x184)
[    0.371303] futex hash table entries: 256 (order: -1, 3072 bytes)
[    0.383577] ntfs: driver 2.1.30 [Flags: R/W].
[    0.384237] fuse init (API version 7.23)
[    0.384866] msgmni has been set to 1486
[    0.387277] bounce: pool size: 64 pages
[    0.387378] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.387406] io scheduler noop registered
[    0.387443] io scheduler cfq registered (default)
[    0.388226] aer: probe of 0000:40:00.0:pcie02 failed with error -22
[    0.388277] aer: probe of 0001:80:00.0:pcie02 failed with error -22
[    0.388357] pcie_pme: probe of 0000:40:00.0:pcie01 failed with error -22
[    0.388395] pcie_pme: probe of 0001:80:00.0:pcie01 failed with error -22
[    0.389326] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.390412] console [ttyS0] disabled
[    0.411567] serial8250.0: ttyS0 at MMIO 0x4ef600300 (irq = 23, base_baud = 691200) is a U6_16550A
[    1.414596] console [ttyS0] enabled
[    1.438798] serial8250.0: ttyS1 at MMIO 0x4ef600400 (irq = 24, base_baud = 691200) is a U6_16550A
[    1.448482] console [ttyS0] disabled
[    0.000000] Using Canyonlands machine description
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.17.0-rc1-Sam460ex (root@julian-VirtualBox) (gcc version 4.8.2 (Ubuntu 4.8.2-16ubuntu3) ) #1 PREEMPT Sat Feb 14 19:45:33 AST 2015
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00000000-0x2fffffff]
[    0.000000]   Normal   empty
[    0.000000]   HighMem  [mem 0x30000000-0x7fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00000000-0x7fffffff]
[    0.000000] MMU: Allocated 1088 bytes of context maps for 255 contexts
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 522752
[    0.000000] Kernel command line: root=/dev/sda12 console=ttyS0,115200 console=tty0
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Sorting __ex_table...
[    0.000000] Memory: 2004844K/2097152K available (5764K kernel code, 232K rwdata, 1456K rodata, 236K init, 1333K bss, 92308K reserved, 1310720K highmem)
[    0.000000] Kernel virtual memory layout:
[    0.000000]   * 0xfffcf000..0xfffff000  : fixmap
[    0.000000]   * 0xffc00000..0xffe00000  : highmem PTEs
[    0.000000]   * 0xffa00000..0xffc00000  : consistent mem
[    0.000000]   * 0xffa00000..0xffa00000  : early ioremap
[    0.000000]   * 0xf1000000..0xffa00000  : vmalloc & ioremap
[    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] NR_IRQS:512 nr_irqs:512 16
[    0.000000] UIC0 (32 IRQ sources) at DCR 0xc0
[    0.000000] UIC1 (32 IRQ sources) at DCR 0xd0
[    0.000000] UIC2 (32 IRQ sources) at DCR 0xe0
[    0.000000] UIC3 (32 IRQ sources) at DCR 0xf0
[    0.000013] clocksource: timebase mult[dda520] shift[24] registered
[    0.000138] Console: colour dummy device 80x25
[    0.000557] console [tty0] enabled
[    0.000581] pid_max: default: 32768 minimum: 301
[    0.000683] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000706] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.002800] devtmpfs: initialized
[    0.003674] xor: measuring software checksum speed
[    0.013505]    8regs     :   856.000 MB/sec
[    0.023276]    8regs_prefetch:   780.000 MB/sec
[    0.033309]    32regs    :  1120.000 MB/sec
[    0.043362]    32regs_prefetch:   996.000 MB/sec
[    0.043388] xor: using function: 32regs (1120.000 MB/sec)
[    0.045174] NET: Registered protocol family 16
[    0.046996] 256k L2-cache enabled
[    0.047113] PCIE0: Checking link...
[    0.047126] PCIE0: Device detected, waiting for link...
[    0.047140] PCIE0: link is up !
[    0.149234] PCI host bridge /plb/pciex@d00000000 (primary) ranges:
[    0.149287]  MEM 0x0000000e00000000..0x0000000e7fffffff -> 0x0000000080000000
[    0.149313]  MEM 0x0000000f00000000..0x0000000f000fffff -> 0x0000000000000000
[    0.149336]   IO 0x0000000f80000000..0x0000000f8000ffff -> 0x0000000000000000
[    0.149362] 4xx PCI DMA offset set to 0x00000000
[    0.149375] 4xx PCI DMA window base to 0x0000000000000000
[    0.149390] DMA window size 0x0000000080000000
[    0.149420] PCIE0: successfully set as root-complex
[    0.149460] PCIE1: Checking link...
[    0.149472] PCIE1: Device detected, waiting for link...
[    0.149486] PCIE1: link is up !
[    0.251485] PCI host bridge /plb/pciex@d20000000 (primary) ranges:
[    0.251520]  MEM 0x0000000e80000000..0x0000000effffffff -> 0x0000000080000000
[    0.251546]  MEM 0x0000000f00100000..0x0000000f001fffff -> 0x0000000000000000
[    0.251568]   IO 0x0000000f80010000..0x0000000f8001ffff -> 0x0000000000000000
[    0.251592] 4xx PCI DMA offset set to 0x00000000
[    0.251606] 4xx PCI DMA window base to 0x0000000000000000
[    0.251620] DMA window size 0x0000000080000000
[    0.251646] PCIE1: successfully set as root-complex
[    0.251726] PCI host bridge /plb/pci@c0ec00000 (primary) ranges:
[    0.251748]  MEM 0x0000000d80000000..0x0000000dffffffff -> 0x0000000080000000
[    0.251774]  MEM 0x0000000c0ee00000..0x0000000c0eefffff -> 0x0000000000000000
[    0.251796]   IO 0x0000000c08000000..0x0000000c0800ffff -> 0x0000000000000000
[    0.251819] 4xx PCI DMA offset set to 0x00000000
[    0.251832] 4xx PCI DMA window base to 0x0000000000000000
[    0.251846] DMA window size 0x0000000080000000
[    0.261402] PCI: Probing PCI hardware
[    0.261731] PCI host bridge to bus 0000:40
[    0.261768] pci_bus 0000:40: root bus resource [io  0xfffc0000-0xfffcffff] (bus address [0x0000-0xffff])
[    0.261797] pci_bus 0000:40: root bus resource [mem 0xe00000000-0xe7fffffff] (bus address [0x80000000-0xffffffff])
[    0.261826] pci_bus 0000:40: root bus resource [mem 0xf00000000-0xf000fffff] (bus address [0x00000000-0x000fffff])
[    0.261855] pci_bus 0000:40: root bus resource [bus 40-ff]
[    0.261969] PCI: Hiding 4xx host bridge resources 0000:40:00.0
[    0.264189] pci 0000:40:00.0: PCI bridge to [bus 41-7f]
[    0.264293] pci 0000:41:00.0: bridge configuration invalid ([bus 02-02]), reconfiguring
[    0.264868] pci 0000:41:00.0: PCI bridge to [bus 42-7f]
[    0.265081] PCI host bridge to bus 0001:80
[    0.265106] pci_bus 0001:80: root bus resource [io  0xfffe0000-0xfffeffff] (bus address [0x0000-0xffff])
[    0.265134] pci_bus 0001:80: root bus resource [mem 0xe80000000-0xeffffffff] (bus address [0x80000000-0xffffffff])
[    0.265181] pci_bus 0001:80: root bus resource [mem 0xf00100000-0xf001fffff] (bus address [0x00000000-0x000fffff])
[    0.265209] pci_bus 0001:80: root bus resource [bus 80-ff]
[    0.265305] PCI: Hiding 4xx host bridge resources 0001:80:00.0
[    0.268247] pci 0001:80:00.0: PCI bridge to [bus 81-bf]
[    0.268539] PCI host bridge to bus 0002:00
[    0.268563] pci_bus 0002:00: root bus resource [io  0x0000-0xffff]
[    0.268585] pci_bus 0002:00: root bus resource [mem 0xd80000000-0xdffffffff] (bus address [0x80000000-0xffffffff])
[    0.268614] pci_bus 0002:00: root bus resource [mem 0xc0ee00000-0xc0eefffff] (bus address [0x00000000-0x000fffff])
[    0.268642] pci_bus 0002:00: root bus resource [bus 00-ff]
[    0.269359] pci 0000:40:00.0: BAR 13: assigned [io  0xfffc1000-0xfffc1fff]
[    0.269393] pci 0000:41:00.0: BAR 13: assigned [io  0xfffc1000-0xfffc1fff]
[    0.269415] pci 0000:42:00.0: BAR 1: assigned [io  0xfffc1000-0xfffc107f]
[    0.269440] pci 0000:42:00.0: BAR 0: assigned [io  0xfffc1080-0xfffc109f]
[    0.269463] pci 0000:41:00.0: PCI bridge to [bus 42]
[    0.269482] pci 0000:41:00.0:   bridge window [io  0xfffc1000-0xfffc1fff]
[    0.269511] pci 0000:40:00.0: PCI bridge to [bus 41-7f]
[    0.269529] pci 0000:40:00.0:   bridge window [io  0xfffc1000-0xfffc1fff]
[    0.269615] pci 0001:80:00.0: BAR 15: assigned [mem 0xe80000000-0xe8fffffff 64bit pref]
[    0.269640] pci 0001:80:00.0: BAR 14: assigned [mem 0xe90000000-0xe900fffff]
[    0.269661] pci 0001:80:00.0: BAR 13: assigned [io  0xfffe1000-0xfffe1fff]
[    0.269685] pci 0001:81:00.0: BAR 0: assigned [mem 0xe80000000-0xe8fffffff 64bit pref]
[    0.269717] pci 0001:81:00.0: BAR 2: assigned [mem 0xe90000000-0xe9001ffff 64bit]
[    0.269747] pci 0001:81:00.0: BAR 6: assigned [mem 0xe90020000-0xe9003ffff pref]
[    0.269773] pci 0001:81:00.1: BAR 0: assigned [mem 0xe90040000-0xe90043fff 64bit]
[    0.269802] pci 0001:81:00.0: BAR 4: assigned [io  0xfffe1000-0xfffe10ff]
[    0.269824] pci 0001:80:00.0: PCI bridge to [bus 81-bf]
[    0.269842] pci 0001:80:00.0:   bridge window [io  0xfffe1000-0xfffe1fff]
[    0.269863] pci 0001:80:00.0:   bridge window [mem 0xe90000000-0xe900fffff]
[    0.269883] pci 0001:80:00.0:   bridge window [mem 0xe80000000-0xe8fffffff 64bit pref]
[    0.269968] pci 0002:00:06.0: BAR 0: assigned [mem 0xd80000000-0xd83ffffff]
[    0.269990] pci 0002:00:06.0: BAR 1: assigned [mem 0xd84000000-0xd841fffff]
[    0.270013] pci 0002:00:04.0: BAR 6: assigned [mem 0xd84200000-0xd8427ffff pref]
[    0.270037] pci 0002:00:04.0: BAR 5: assigned [mem 0xd84280000-0xd842801ff]
[    0.270058] pci 0002:00:04.0: BAR 4: assigned [io  0x1000-0x100f]
[    0.270079] pci 0002:00:04.0: BAR 0: assigned [io  0x1010-0x1017]
[    0.270099] pci 0002:00:04.0: BAR 2: assigned [io  0x1018-0x101f]
[    0.270120] pci 0002:00:04.0: BAR 1: assigned [io  0x1020-0x1023]
[    0.270140] pci 0002:00:04.0: BAR 3: assigned [io  0x1024-0x1027]
[    0.298144] raid6: int32x1    300 MB/s
[    0.314619] raid6: int32x2    429 MB/s
[    0.332598] raid6: int32x4    480 MB/s
[    0.349843] raid6: int32x8    234 MB/s
[    0.349865] raid6: using algorithm int32x4 (480 MB/s)
[    0.349880] raid6: using intx1 recovery algorithm
[    0.350216] vgaarb: device added: PCI:0001:81:00.0,decodes=io+mem,owns=none,locks=none
[    0.350248] vgaarb: loaded
[    0.350259] vgaarb: bridge control possible 0001:81:00.0
[    0.350804] SCSI subsystem initialized
[    0.351433] usbcore: registered new interface driver usbfs
[    0.351518] usbcore: registered new interface driver hub
[    0.351630] usbcore: registered new device driver usb
[    0.352644] Switched to clocksource timebase
[    0.362225] NET: Registered protocol family 2
[    0.363055] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.363156] TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
[    0.363233] TCP: Hash tables configured (established 8192 bind 8192)
[    0.363343] TCP: reno registered
[    0.363362] UDP hash table entries: 512 (order: 1, 8192 bytes)
[    0.363394] UDP-Lite hash table entries: 512 (order: 1, 8192 bytes)
[    0.363571] NET: Registered protocol family 1
[    0.364087] RPC: Registered named UNIX socket transport module.
[    0.364119] RPC: Registered udp transport module.
[    0.364133] RPC: Registered tcp transport module.
[    0.364147] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.364803] Could not remap bcsr
[    0.368882] genirq: Setting trigger mode 3 for irq 45 failed (uic_set_irq_type+0x0/0x184)
[    0.371303] futex hash table entries: 256 (order: -1, 3072 bytes)
[    0.383577] ntfs: driver 2.1.30 [Flags: R/W].
[    0.384237] fuse init (API version 7.23)
[    0.384866] msgmni has been set to 1486
[    0.387277] bounce: pool size: 64 pages
[    0.387378] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.387406] io scheduler noop registered
[    0.387443] io scheduler cfq registered (default)
[    0.388226] aer: probe of 0000:40:00.0:pcie02 failed with error -22
[    0.388277] aer: probe of 0001:80:00.0:pcie02 failed with error -22
[    0.388357] pcie_pme: probe of 0000:40:00.0:pcie01 failed with error -22
[    0.388395] pcie_pme: probe of 0001:80:00.0:pcie01 failed with error -22
[    0.389326] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.390412] console [ttyS0] disabled
[    0.411567] serial8250.0: ttyS0 at MMIO 0x4ef600300 (irq = 23, base_baud = 691200) is a U6_16550A
[    1.414596] console [ttyS0] enabled
[    1.438798] serial8250.0: ttyS1 at MMIO 0x4ef600400 (irq = 24, base_baud = 691200) is a U6_16550A
[    1.448482] console [ttyS0] disabled
[    1.452349] 4ef600300.serial: ttyS0 at MMIO 0x4ef600300 (irq = 23, base_baud = 691200) is a 16550
[    2.456385] console [ttyS0] enabled
[    2.460383] 4ef600400.serial: ttyS1 at MMIO 0x4ef600400 (irq = 24, base_baud = 691200) is a 16550
[    2.470039] Generic non-volatile memory driver v1.1
[    2.481188] brd: module loaded
[    2.487701] loop: module loaded
[    2.491960] sata_sil 0002:00:04.0: Applying R_ERR on DMA activate FIS errata fix
[    2.501064] scsi host0: sata_sil
[    2.505141] scsi host1: sata_sil
[    2.508768] ata1: SATA max UDMA/100 mmio m512@0xd84280000 tf 0xd84280080 irq 22
[    2.516506] ata2: SATA max UDMA/100 mmio m512@0xd84280000 tf 0xd842800c0 irq 22
[    2.525981] PPC 4xx OCP EMAC driver, version 3.54
[    2.531525] MAL v2 /plb/mcmal, 2 TX channels, 16 RX channels
[    2.537795] ZMII /plb/opb/emac-zmii@ef600d00 initialized
[    2.543568] RGMII /plb/opb/emac-rgmii@ef601500 initialized with MDIO support
[    2.551163] TAH /plb/opb/emac-tah@ef601350 initialized
[    2.556772] TAH /plb/opb/emac-tah@ef601450 initialized
[    2.562463] /plb/opb/emac-rgmii@ef601500: input 0 in RGMII mode
[    2.570153] eth0: EMAC-0 /plb/opb/ethernet@ef600e00, MAC 00:50:c2:80:d5:c5
[    2.577457] eth0: found Generic MII PHY (0x00)
[    2.582336] /plb/opb/emac-rgmii@ef601500: input 1 in RGMII mode
[    2.589957] eth1: EMAC-1 /plb/opb/ethernet@ef600f00, MAC 00:00:00:00:00:00
[    2.597249] eth1: found Generic MII PHY (0x01)
[    2.602220] PPP generic driver version 2.4.2
[    2.607065] PPP BSD Compression module registered
[    2.612062] PPP Deflate Compression module registered
[    2.617445] NET: Registered protocol family 24
[    2.622433] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.629496] ppc-of-ehci 4bffd0400.ehci: OF EHCI
[    2.634522] ppc-of-ehci 4bffd0400.ehci: new USB bus registered, assigned bus number 1
[    2.642960] ppc-of-ehci 4bffd0400.ehci: irq 32, io mem 0x4bffd0400
[    2.654655] ppc-of-ehci 4bffd0400.ehci: USB 2.0 started, EHCI 1.00
[    2.660996] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    2.667814] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.675054] usb usb1: Product: OF EHCI
[    2.678820] usb usb1: Manufacturer: Linux 3.17.0-rc1-Sam460ex ehci_hcd
[    2.685365] usb usb1: SerialNumber: PPC-OF USB
[    2.690317] hub 1-0:1.0: USB hub found
[    2.694296] hub 1-0:1.0: 1 port detected
[    2.698713] ehci-pci: EHCI PCI platform driver
[    2.703415] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    2.709837] ppc-of-ohci 4bffd0000.usb: OF OHCI
[    2.714547] ppc-of-ohci 4bffd0000.usb: new USB bus registered, assigned bus number 2
[    2.722450] ppc-of-ohci 4bffd0000.usb: irq 33, io mem 0x4bffd0000
[    2.839669] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[    2.852779] ata1.00: ATAPI: ASUS    DRW-24B3ST   c, 1.01, max UDMA/100
[    2.869759] ata1.00: configured for UDMA/100
[    2.881895] scsi 0:0:0:0: CD-ROM            ASUS     DRW-24B3ST   c   1.01 PQ: 0 ANSI: 5
[    2.921748] sr 0:0:0:0: [sr0] scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
[    2.936644] cdrom: Uniform CD-ROM driver Revision: 3.20
[    2.949588] sr 0:0:0:0: Attached scsi generic sg0 type 5
[    2.999688] usb 1-1: new high-speed USB device number 2 using ppc-of-ehci
[    3.128059] usb 1-1: New USB device found, idVendor=0424, idProduct=2517
[    3.138646] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    3.155769] hub 1-1:1.0: USB hub found
[    3.162681] hub 1-1:1.0: 7 ports detected
[    3.264671] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[    3.276928] ata2.00: ATA-8: WDC WD5000AAKS-00V1A0, 05.01D05, max UDMA/133
[    3.288646] ata2.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
[    3.308910] ata2.00: configured for UDMA/100
[    3.327902] scsi 1:0:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 1D05 PQ: 0 ANSI: 5
[    3.344909] sd 1:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/465 GiB)
[    3.352720] sd 1:0:0:0: Attached scsi generic sg1 type 0
[    3.361832] sd 1:0:0:0: [sda] Write Protect is off
[    3.371781] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.403263]  sda: RDSK (512) sda1 (SFS^@)(res 2 spb 1) sda2 (SFS^@)(res 2 spb 1) sda3 (SFS^B)(res 2 spb 1) sda4 (NTFS)(res 2 spb 2) sda5 (LNX^@)(res 2 spb 1) sda6 ((res 2 spb 1) sda7 (SWP^@)(res 2 spb 1) sda8 (LNX^@)(res 2 spb 1) sda9 (EXT^C)(res 2 spb 1) sda10 (SWP^@)(res 2 spb 1) sda11 (LNX^@)(res 2 spb 1) sda12 (EXT^C)(res 2 spb 1) sda13 (SWP^@)(res 2 spb 1) sda14 (LNX^@)(res 2 spb 1) sda15 (EXT^C)(res 2 spb 1) sda16 (SWP^@)(res 2 spb 1)
[    3.453796] usb 1-1.1: new low-speed USB device number 3 using ppc-of-ehci
[    3.464819] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
[    3.471690] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.478971] usb usb2: Product: OF OHCI
[    3.482753] usb usb2: Manufacturer: Linux 3.17.0-rc1-Sam460ex ohci_hcd
[    3.492302] sd 1:0:0:0: [sda] Attached SCSI disk
[    3.497187] usb usb2: SerialNumber: PPC-OF USB
[    3.502434] hub 2-0:1.0: USB hub found
[    3.506457] hub 2-0:1.0: 1 port detected
[    3.511108] ohci-pci: OHCI PCI platform driver
[    3.516197] usbcore: registered new interface driver usb-storage
[    3.522783] usbcore: registered new interface driver usbserial
[    3.529060] usbcore: registered new interface driver usbserial_generic
[    3.536054] usbserial: USB Serial support registered for generic
[    3.542929] mousedev: PS/2 mouse device common for all mice
[    3.548882] i2c /dev entries driver
[    3.554713] rtc-m41t80 0-0068: rtc core: registered m41t80 as rtc0
[    3.562282] ibm-iic 4ef600700.i2c: using standard (100 kHz) mode
[    3.568946] ibm-iic 4ef600800.i2c: using standard (100 kHz) mode
[    3.576004] device-mapper: ioctl: 4.27.0-ioctl (2013-10-30) initialised: dm-devel@redhat.com
[    3.585099] sdhci: Secure Digital Host Controller Interface driver
[    3.591467] sdhci: Copyright(c) Pierre Ossman
[    3.596039] usbcore: registered new interface driver ushc
[    3.601517] usb 1-1.1: New USB device found, idVendor=04f2, idProduct=0116
[    3.608724] hidraw: raw HID events driver (C) Jiri Kosina
[    3.614182] usb 1-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.622377] usbcore: registered new interface driver usbhid
[    3.628150] usb 1-1.1: Product: USB Keyboard
[    3.632699] usbhid: USB HID core driver
[    3.636707] usb 1-1.1: Manufacturer: CHICONY
[    3.641316] ipip: IPv4 over IPv4 tunneling driver
[    3.647581] TCP: cubic registered
[    3.651320] Initializing XFRM netlink socket
[    3.658330] input: CHICONY USB Keyboard as /devices/plb/4bffd0400.ehci/usb1/1-1/1-1.1/1-1.1:1.0/0003:04F2:0116.0001/input/input0
[    3.671169] NET: Registered protocol family 10
[    3.677096] sit: IPv6 over IPv4 tunneling driver
[    3.682360] hid-generic 0003:04F2:0116.0001: input,hidraw0: USB HID v1.10 Keyboard [CHICONY USB Keyboard] on usb-PPC-OF USB-1.1/input0
[    3.695282] NET: Registered protocol family 17
[    3.699988] NET: Registered protocol family 15
[    3.707516] Btrfs loaded
[    3.711967] rtc-m41t80 0-0068: setting system clock to 2015-02-15 00:23:59 UTC (1423959839)
[    3.765100] EXT3-fs (sda12): mounted filesystem with ordered data mode
[    3.771691] kjournald starting.  Commit interval 5 seconds
[    3.777232] VFS: Mounted root (ext3 filesystem) readonly on device 8:12.
[    3.784045] usb 1-1.2: new full-speed USB device number 4 using ppc-of-ehci
[    3.812205] devtmpfs: mounted
[    3.815858] Freeing unused kernel memory: 236K (c070f000 - c074a000)
[    3.888328] usb 1-1.2: New USB device found, idVendor=046d, idProduct=c52b
[    3.895399] usb 1-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.902902] usb 1-1.2: Product: USB Receiver
[    3.907338] usb 1-1.2: Manufacturer: Logitech
[    3.918233] input: Logitech USB Receiver as /devices/plb/4bffd0400.ehci/usb1/1-1/1-1.2/1-1.2:1.0/0003:046D:C52B.0002/input/input1
[    3.930895] hid-generic 0003:046D:C52B.0002: input,hidraw1: USB HID v1.11 Keyboard [Logitech USB Receiver] on usb-PPC-OF USB-1.2/input0
[    3.952076] input: Logitech USB Receiver as /devices/plb/4bffd0400.ehci/usb1/1-1/1-1.2/1-1.2:1.1/0003:046D:C52B.0003/input/input2
[    3.965443] hid-generic 0003:046D:C52B.0003: input,hidraw2: USB HID v1.11 Mouse [Logitech USB Receiver] on usb-PPC-OF USB-1.2/input1
[    3.985424] hid-generic 0003:046D:C52B.0004: hidraw3: USB HID v1.11 Device [Logitech USB Receiver] on usb-PPC-OF USB-1.2/input2
[    4.071920] usb 1-1.7: new high-speed USB device number 5 using ppc-of-ehci
[    4.171278] usb 1-1.7: New USB device found, idVendor=0424, idProduct=2240
[    4.178473] usb 1-1.7: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    4.186345] usb 1-1.7: Product: Ultra Fast Media
[    4.191221] usb 1-1.7: Manufacturer: Generic
[    4.196312] usb 1-1.7: SerialNumber: 000000225001
[    4.202312] usb-storage 1-1.7:1.0: USB Mass Storage device detected
[    4.208952] scsi host2: usb-storage 1-1.7:1.0
[    4.301159] random: nonblocking pool is initialized
[    5.111272] udevd[880]: starting version 175
[    5.215723] scsi 2:0:0:0: Direct-Access     Generic  Ultra HS-COMBO   1.98 PQ: 0 ANSI: 0
[    5.238185] sd 2:0:0:0: Attached scsi generic sg2 type 0
[    5.244138] sd 2:0:0:0: [sdb] Attached SCSI removable disk
[    5.715269] Linux agpgart interface v0.103
[    6.019063] [drm] Initialized drm 1.1.0 20060810
[    6.364350] snd_hda_intel 0001:81:00.1: enabling device (0000 -> 0002)
[    6.453794] snd_hda_intel 0001:81:00.1: ppc4xx_setup_msi_irqs: fail mapping irq
[    6.487530] Unable to handle kernel paging request for data at address 0x0fa06c7c
[    6.495055] Faulting instruction address: 0xc032202c
[    6.500033] Vector: 300 (Data Access) at [efa31cf0]
[    6.504922]     pc: c032202c: __reg_op+0xe8/0x100
[    6.509697]     lr: c0014f88: msi_bitmap_free_hwirqs+0x50/0x94
[    6.515600]     sp: efa31da0
[    6.518491]    msr: 21000
[    6.521112]    dar: fa06c7c
[    6.523915]  dsisr: 0
[    6.526190]   current = 0xef8bab00
[    6.529603]     pid   = 115, comm = kworker/0:1
[    6.534163] enter ? for help
[    6.537054] [link register   ] c0014f88 msi_bitmap_free_hwirqs+0x50/0x94
[    6.543811] [efa31da0] c0014f78 msi_bitmap_free_hwirqs+0x40/0x94 (unreliable)
[    6.551001] [efa31dc0] c001aee8 ppc4xx_setup_msi_irqs+0xac/0xf4
[    6.556973] [efa31e00] c03503a4 pci_enable_msi_range+0x1e0/0x280
[    6.563032] [efa31e40] f92c2f74 azx_probe_work+0xe0/0x57c [snd_hda_intel]
[    6.569906] [efa31e80] c0036344 process_one_work+0x1e8/0x2f0
[    6.575627] [efa31eb0] c003677c worker_thread+0x2f4/0x438
[    6.581079] [efa31ef0] c003a3e4 kthread+0xc8/0xcc
[    6.585844] [efa31f40] c000aec4 ret_from_kernel_thread+0x5c/0x64
[    6.591910] mon>  <no input ...>
[    8.595205] Oops: Kernel access of bad area, sig: 11 [#1]
[    8.600607] PREEMPT Canyonlands
[    8.603769] Modules linked in: snd_seq_midi snd_seq_midi_event cfbfillrect snd_hda_intel cfbimgblt snd_hda_controller cfbcopyarea snd_rawmidi i2c_algo_bit snd_hda_codec drm_kms_helper ttm snd_pcm snd_seq snd_seq_device snd_timer drm snd agpgart
[    8.625753] CPU: 0 PID: 115 Comm: kworker/0:1 Not tainted 3.17.0-rc1-Sam460ex #1
[    8.633171] Workqueue: events azx_probe_work [snd_hda_intel]
[    8.638857] task: ef8bab00 ti: efa30000 task.ti: efa30000
[    8.644264] NIP: c032202c LR: c0014f88 CTR: 00000001
[    8.649238] REGS: efa31cf0 TRAP: 0300   Not tainted  (3.17.0-rc1-Sam460ex)
[    8.656121] MSR: 00021000 <CE,ME>  CR: 24002022  XER: 20000000
[    8.662023] DEAR: 0fa06c7c ESR: 00000000
GPR00: c0014f78 efa31da0 ef8bab00 0fa06c7c ffefffff 00000001 00000002 00000000
GPR08: 00000002 00000000 00000001 efa31da0 24002024 00000000 c003a31c ef9f9520
GPR16: 00000000 00000000 00000000 00000000 c074fd8c fffffef7 c0750000 00000000
GPR24: ef843538 00000000 c0885830 ef843000 fffffff4 c0885830 00000000 00029000
[    8.694807] NIP [c032202c] __reg_op+0xe8/0x100
[    8.699259] LR [c0014f88] msi_bitmap_free_hwirqs+0x50/0x94
[    8.704749] Call Trace:
[    8.707202] [efa31da0] [c0014f78] msi_bitmap_free_hwirqs+0x40/0x94 (unreliable)
[    8.714552] [efa31dc0] [c001aee8] ppc4xx_setup_msi_irqs+0xac/0xf4
[    8.720672] [efa31e00] [c03503a4] pci_enable_msi_range+0x1e0/0x280
[    8.726882] [efa31e40] [f92c2f74] azx_probe_work+0xe0/0x57c [snd_hda_intel]
[    8.733867] [efa31e80] [c0036344] process_one_work+0x1e8/0x2f0
[    8.739726] [efa31eb0] [c003677c] worker_thread+0x2f4/0x438
[    8.745326] [efa31ef0] [c003a3e4] kthread+0xc8/0xcc
[    8.750229] [efa31f40] [c000aec4] ret_from_kernel_thread+0x5c/0x64
[    8.756433] Instruction dump:
[    8.759419] 38600001 4e800020 42400038 5549103a 394a0001 7d03482e 7d082378 7d03492e
[    8.767300] 4bffffe8 4240001c 5549103a 394a0001 <7d03482e> 7d082038 7d03492e 4bffffe8
[    8.775360] ---[ end trace 1b4d3bc28e3986f5 ]---
[    8.779983]







--------------010106060805060703020500
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=utf-8">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    Hi<br>
    <br>
    I am unable to get any kernel beyond  the 3.16 branch working on an
    Acube Sam460ex<br>
     AMCC 460ex based motherboard. Kernel  up 3.16.7-ckt6 working.<br>
    <br>
    These are the patches applied<br>
    <br>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <pre class="western">diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
index 49b0659..fa33568 100644
--- a/drivers/gpu/drm/radeon/radeon_device.c
+++ b/drivers/gpu/drm/radeon/radeon_device.c
@@ -1066,7 +1066,7 @@ int radeon_device_init(struct radeon_device *rdev,
 	if (rdev-&gt;rmmio == NULL) {
 		return -ENOMEM;
 	}
-	DRM_INFO("register mmio base: 0x%08X\n", (uint32_t)rdev-&gt;rmmio_base);
+	DRM_INFO("register mmio base: 0x%llx\n", (uint64_t)rdev-&gt;rmmio_base);
 	DRM_INFO("register mmio size: %u\n", (unsigned)rdev-&gt;rmmio_size);
 
 	/* io port mapping */
diff --git a/include/drm/ttm/ttm_bo_api.h b/include/drm/ttm/ttm_bo_api.h
index 3cb5d84..fcdb208 100644
--- a/include/drm/ttm/ttm_bo_api.h
+++ b/include/drm/ttm/ttm_bo_api.h
@@ -81,7 +81,7 @@ struct ttm_placement {
  */
 struct ttm_bus_placement {
 	void		*addr;
-	unsigned long	base;
+	phys_addr_t	base;
 	unsigned long	size;
 	unsigned long	offset;
 	bool		is_iomem;</pre>
    <br>
    <br>
    These are the serial boot messages <br>
    <br>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <pre class="western">U-Boot 2010.06.05a (Jan 30 2012 - 16:06:56)

CPU:   AMCC PowerPC 460EX Rev. B at 1155 MHz (PLB=231 OPB=115 EBC=115)
       No Security/Kasumi support
       Bootstrap Option H - Boot ROM Location I2C (Addr 0x52)
       Internal PCI arbiter enabled
       32 kB I-Cache 32 kB D-Cache
Board: Sam460ex, PCIe 4x + PCIe 1x
I2C:   ready
DRAM:  2 GiB (ECC not enabled, 462 MHz, CL4)
PCI:   Bus Dev VenId DevId Class Int
        00  04  1095  3512  0104  00
        00  06  126f  0501  0380  00
PCIE0: successfully set as root-complex
        03  00  1412  1724  0401  ff
        02  00  1b21  1080  0604  00
PCIE1: successfully set as root-complex
        05  00  1002  6758  0300  ff
Net:   ppc_4xx_eth0
FPGA:  Revision 03 (2010-10-07)
SM502: found
VGA:   1
VESA:  OK
[    0.000000] Using Canyonlands machine description
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.17.0-rc1-Sam460ex (root@julian-VirtualBox) (gcc version 4.8.2 (Ubuntu 4.8.2-16ubuntu3) ) #1 PREEMPT Sat Feb 14 19:45:33 AST 2015
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00000000-0x2fffffff]
[    0.000000]   Normal   empty
[    0.000000]   HighMem  [mem 0x30000000-0x7fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00000000-0x7fffffff]
[    0.000000] MMU: Allocated 1088 bytes of context maps for 255 contexts
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 522752
[    0.000000] Kernel command line: root=/dev/sda12 console=ttyS0,115200 console=tty0
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Sorting __ex_table...
[    0.000000] Memory: 2004844K/2097152K available (5764K kernel code, 232K rwdata, 1456K rodata, 236K init, 1333K bss, 92308K reserved, 1310720K highmem)
[    0.000000] Kernel virtual memory layout:
[    0.000000]   * 0xfffcf000..0xfffff000  : fixmap
[    0.000000]   * 0xffc00000..0xffe00000  : highmem PTEs
[    0.000000]   * 0xffa00000..0xffc00000  : consistent mem
[    0.000000]   * 0xffa00000..0xffa00000  : early ioremap
[    0.000000]   * 0xf1000000..0xffa00000  : vmalloc &amp; ioremap
[    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] NR_IRQS:512 nr_irqs:512 16
[    0.000000] UIC0 (32 IRQ sources) at DCR 0xc0
[    0.000000] UIC1 (32 IRQ sources) at DCR 0xd0
[    0.000000] UIC2 (32 IRQ sources) at DCR 0xe0
[    0.000000] UIC3 (32 IRQ sources) at DCR 0xf0
[    0.000013] clocksource: timebase mult[dda520] shift[24] registered
[    0.000138] Console: colour dummy device 80x25
[    0.000557] console [tty0] enabled
[    0.000581] pid_max: default: 32768 minimum: 301
[    0.000683] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000706] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.002800] devtmpfs: initialized
[    0.003674] xor: measuring software checksum speed
[    0.013505]    8regs     :   856.000 MB/sec
[    0.023276]    8regs_prefetch:   780.000 MB/sec
[    0.033309]    32regs    :  1120.000 MB/sec
[    0.043362]    32regs_prefetch:   996.000 MB/sec
[    0.043388] xor: using function: 32regs (1120.000 MB/sec)
[    0.045174] NET: Registered protocol family 16
[    0.046996] 256k L2-cache enabled
[    0.047113] PCIE0: Checking link...
[    0.047126] PCIE0: Device detected, waiting for link...
[    0.047140] PCIE0: link is up !
[    0.149234] PCI host bridge /plb/pciex@d00000000 (primary) ranges:
[    0.149287]  MEM 0x0000000e00000000..0x0000000e7fffffff -&gt; 0x0000000080000000
[    0.149313]  MEM 0x0000000f00000000..0x0000000f000fffff -&gt; 0x0000000000000000
[    0.149336]   IO 0x0000000f80000000..0x0000000f8000ffff -&gt; 0x0000000000000000
[    0.149362] 4xx PCI DMA offset set to 0x00000000
[    0.149375] 4xx PCI DMA window base to 0x0000000000000000
[    0.149390] DMA window size 0x0000000080000000
[    0.149420] PCIE0: successfully set as root-complex
[    0.149460] PCIE1: Checking link...
[    0.149472] PCIE1: Device detected, waiting for link...
[    0.149486] PCIE1: link is up !
[    0.251485] PCI host bridge /plb/pciex@d20000000 (primary) ranges:
[    0.251520]  MEM 0x0000000e80000000..0x0000000effffffff -&gt; 0x0000000080000000
[    0.251546]  MEM 0x0000000f00100000..0x0000000f001fffff -&gt; 0x0000000000000000
[    0.251568]   IO 0x0000000f80010000..0x0000000f8001ffff -&gt; 0x0000000000000000
[    0.251592] 4xx PCI DMA offset set to 0x00000000
[    0.251606] 4xx PCI DMA window base to 0x0000000000000000
[    0.251620] DMA window size 0x0000000080000000
[    0.251646] PCIE1: successfully set as root-complex
[    0.251726] PCI host bridge /plb/pci@c0ec00000 (primary) ranges:
[    0.251748]  MEM 0x0000000d80000000..0x0000000dffffffff -&gt; 0x0000000080000000
[    0.251774]  MEM 0x0000000c0ee00000..0x0000000c0eefffff -&gt; 0x0000000000000000
[    0.251796]   IO 0x0000000c08000000..0x0000000c0800ffff -&gt; 0x0000000000000000
[    0.251819] 4xx PCI DMA offset set to 0x00000000
[    0.251832] 4xx PCI DMA window base to 0x0000000000000000
[    0.251846] DMA window size 0x0000000080000000
[    0.261402] PCI: Probing PCI hardware
[    0.261731] PCI host bridge to bus 0000:40
[    0.261768] pci_bus 0000:40: root bus resource [io  0xfffc0000-0xfffcffff] (bus address [0x0000-0xffff])
[    0.261797] pci_bus 0000:40: root bus resource [mem 0xe00000000-0xe7fffffff] (bus address [0x80000000-0xffffffff])
[    0.261826] pci_bus 0000:40: root bus resource [mem 0xf00000000-0xf000fffff] (bus address [0x00000000-0x000fffff])
[    0.261855] pci_bus 0000:40: root bus resource [bus 40-ff]
[    0.261969] PCI: Hiding 4xx host bridge resources 0000:40:00.0
[    0.264189] pci 0000:40:00.0: PCI bridge to [bus 41-7f]
[    0.264293] pci 0000:41:00.0: bridge configuration invalid ([bus 02-02]), reconfiguring
[    0.264868] pci 0000:41:00.0: PCI bridge to [bus 42-7f]
[    0.265081] PCI host bridge to bus 0001:80
[    0.265106] pci_bus 0001:80: root bus resource [io  0xfffe0000-0xfffeffff] (bus address [0x0000-0xffff])
[    0.265134] pci_bus 0001:80: root bus resource [mem 0xe80000000-0xeffffffff] (bus address [0x80000000-0xffffffff])
[    0.265181] pci_bus 0001:80: root bus resource [mem 0xf00100000-0xf001fffff] (bus address [0x00000000-0x000fffff])
[    0.265209] pci_bus 0001:80: root bus resource [bus 80-ff]
[    0.265305] PCI: Hiding 4xx host bridge resources 0001:80:00.0
[    0.268247] pci 0001:80:00.0: PCI bridge to [bus 81-bf]
[    0.268539] PCI host bridge to bus 0002:00
[    0.268563] pci_bus 0002:00: root bus resource [io  0x0000-0xffff]
[    0.268585] pci_bus 0002:00: root bus resource [mem 0xd80000000-0xdffffffff] (bus address [0x80000000-0xffffffff])
[    0.268614] pci_bus 0002:00: root bus resource [mem 0xc0ee00000-0xc0eefffff] (bus address [0x00000000-0x000fffff])
[    0.268642] pci_bus 0002:00: root bus resource [bus 00-ff]
[    0.269359] pci 0000:40:00.0: BAR 13: assigned [io  0xfffc1000-0xfffc1fff]
[    0.269393] pci 0000:41:00.0: BAR 13: assigned [io  0xfffc1000-0xfffc1fff]
[    0.269415] pci 0000:42:00.0: BAR 1: assigned [io  0xfffc1000-0xfffc107f]
[    0.269440] pci 0000:42:00.0: BAR 0: assigned [io  0xfffc1080-0xfffc109f]
[    0.269463] pci 0000:41:00.0: PCI bridge to [bus 42]
[    0.269482] pci 0000:41:00.0:   bridge window [io  0xfffc1000-0xfffc1fff]
[    0.269511] pci 0000:40:00.0: PCI bridge to [bus 41-7f]
[    0.269529] pci 0000:40:00.0:   bridge window [io  0xfffc1000-0xfffc1fff]
[    0.269615] pci 0001:80:00.0: BAR 15: assigned [mem 0xe80000000-0xe8fffffff 64bit pref]
[    0.269640] pci 0001:80:00.0: BAR 14: assigned [mem 0xe90000000-0xe900fffff]
[    0.269661] pci 0001:80:00.0: BAR 13: assigned [io  0xfffe1000-0xfffe1fff]
[    0.269685] pci 0001:81:00.0: BAR 0: assigned [mem 0xe80000000-0xe8fffffff 64bit pref]
[    0.269717] pci 0001:81:00.0: BAR 2: assigned [mem 0xe90000000-0xe9001ffff 64bit]
[    0.269747] pci 0001:81:00.0: BAR 6: assigned [mem 0xe90020000-0xe9003ffff pref]
[    0.269773] pci 0001:81:00.1: BAR 0: assigned [mem 0xe90040000-0xe90043fff 64bit]
[    0.269802] pci 0001:81:00.0: BAR 4: assigned [io  0xfffe1000-0xfffe10ff]
[    0.269824] pci 0001:80:00.0: PCI bridge to [bus 81-bf]
[    0.269842] pci 0001:80:00.0:   bridge window [io  0xfffe1000-0xfffe1fff]
[    0.269863] pci 0001:80:00.0:   bridge window [mem 0xe90000000-0xe900fffff]
[    0.269883] pci 0001:80:00.0:   bridge window [mem 0xe80000000-0xe8fffffff 64bit pref]
[    0.269968] pci 0002:00:06.0: BAR 0: assigned [mem 0xd80000000-0xd83ffffff]
[    0.269990] pci 0002:00:06.0: BAR 1: assigned [mem 0xd84000000-0xd841fffff]
[    0.270013] pci 0002:00:04.0: BAR 6: assigned [mem 0xd84200000-0xd8427ffff pref]
[    0.270037] pci 0002:00:04.0: BAR 5: assigned [mem 0xd84280000-0xd842801ff]
[    0.270058] pci 0002:00:04.0: BAR 4: assigned [io  0x1000-0x100f]
[    0.270079] pci 0002:00:04.0: BAR 0: assigned [io  0x1010-0x1017]
[    0.270099] pci 0002:00:04.0: BAR 2: assigned [io  0x1018-0x101f]
[    0.270120] pci 0002:00:04.0: BAR 1: assigned [io  0x1020-0x1023]
[    0.270140] pci 0002:00:04.0: BAR 3: assigned [io  0x1024-0x1027]
[    0.298144] raid6: int32x1    300 MB/s
[    0.314619] raid6: int32x2    429 MB/s
[    0.332598] raid6: int32x4    480 MB/s
[    0.349843] raid6: int32x8    234 MB/s
[    0.349865] raid6: using algorithm int32x4 (480 MB/s)
[    0.349880] raid6: using intx1 recovery algorithm
[    0.350216] vgaarb: device added: PCI:0001:81:00.0,decodes=io+mem,owns=none,locks=none
[    0.350248] vgaarb: loaded
[    0.350259] vgaarb: bridge control possible 0001:81:00.0
[    0.350804] SCSI subsystem initialized
[    0.351433] usbcore: registered new interface driver usbfs
[    0.351518] usbcore: registered new interface driver hub
[    0.351630] usbcore: registered new device driver usb
[    0.352644] Switched to clocksource timebase
[    0.362225] NET: Registered protocol family 2
[    0.363055] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.363156] TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
[    0.363233] TCP: Hash tables configured (established 8192 bind 8192)
[    0.363343] TCP: reno registered
[    0.363362] UDP hash table entries: 512 (order: 1, 8192 bytes)
[    0.363394] UDP-Lite hash table entries: 512 (order: 1, 8192 bytes)
[    0.363571] NET: Registered protocol family 1
[    0.364087] RPC: Registered named UNIX socket transport module.
[    0.364119] RPC: Registered udp transport module.
[    0.364133] RPC: Registered tcp transport module.
[    0.364147] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.364803] Could not remap bcsr
[    0.368882] genirq: Setting trigger mode 3 for irq 45 failed (uic_set_irq_type+0x0/0x184)
[    0.371303] futex hash table entries: 256 (order: -1, 3072 bytes)
[    0.383577] ntfs: driver 2.1.30 [Flags: R/W].
[    0.384237] fuse init (API version 7.23)
[    0.384866] msgmni has been set to 1486
[    0.387277] bounce: pool size: 64 pages
[    0.387378] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.387406] io scheduler noop registered
[    0.387443] io scheduler cfq registered (default)
[    0.388226] aer: probe of 0000:40:00.0:pcie02 failed with error -22
[    0.388277] aer: probe of 0001:80:00.0:pcie02 failed with error -22
[    0.388357] pcie_pme: probe of 0000:40:00.0:pcie01 failed with error -22
[    0.388395] pcie_pme: probe of 0001:80:00.0:pcie01 failed with error -22
[    0.389326] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.390412] console [ttyS0] disabled
[    0.411567] serial8250.0: ttyS0 at MMIO 0x4ef600300 (irq = 23, base_baud = 691200) is a U6_16550A
[    1.414596] console [ttyS0] enabled
[    1.438798] serial8250.0: ttyS1 at MMIO 0x4ef600400 (irq = 24, base_baud = 691200) is a U6_16550A
[    1.448482] console [ttyS0] disabled
[    0.000000] Using Canyonlands machine description
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.17.0-rc1-Sam460ex (root@julian-VirtualBox) (gcc version 4.8.2 (Ubuntu 4.8.2-16ubuntu3) ) #1 PREEMPT Sat Feb 14 19:45:33 AST 2015
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00000000-0x2fffffff]
[    0.000000]   Normal   empty
[    0.000000]   HighMem  [mem 0x30000000-0x7fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00000000-0x7fffffff]
[    0.000000] MMU: Allocated 1088 bytes of context maps for 255 contexts
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 522752
[    0.000000] Kernel command line: root=/dev/sda12 console=ttyS0,115200 console=tty0
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Sorting __ex_table...
[    0.000000] Memory: 2004844K/2097152K available (5764K kernel code, 232K rwdata, 1456K rodata, 236K init, 1333K bss, 92308K reserved, 1310720K highmem)
[    0.000000] Kernel virtual memory layout:
[    0.000000]   * 0xfffcf000..0xfffff000  : fixmap
[    0.000000]   * 0xffc00000..0xffe00000  : highmem PTEs
[    0.000000]   * 0xffa00000..0xffc00000  : consistent mem
[    0.000000]   * 0xffa00000..0xffa00000  : early ioremap
[    0.000000]   * 0xf1000000..0xffa00000  : vmalloc &amp; ioremap
[    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] NR_IRQS:512 nr_irqs:512 16
[    0.000000] UIC0 (32 IRQ sources) at DCR 0xc0
[    0.000000] UIC1 (32 IRQ sources) at DCR 0xd0
[    0.000000] UIC2 (32 IRQ sources) at DCR 0xe0
[    0.000000] UIC3 (32 IRQ sources) at DCR 0xf0
[    0.000013] clocksource: timebase mult[dda520] shift[24] registered
[    0.000138] Console: colour dummy device 80x25
[    0.000557] console [tty0] enabled
[    0.000581] pid_max: default: 32768 minimum: 301
[    0.000683] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000706] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.002800] devtmpfs: initialized
[    0.003674] xor: measuring software checksum speed
[    0.013505]    8regs     :   856.000 MB/sec
[    0.023276]    8regs_prefetch:   780.000 MB/sec
[    0.033309]    32regs    :  1120.000 MB/sec
[    0.043362]    32regs_prefetch:   996.000 MB/sec
[    0.043388] xor: using function: 32regs (1120.000 MB/sec)
[    0.045174] NET: Registered protocol family 16
[    0.046996] 256k L2-cache enabled
[    0.047113] PCIE0: Checking link...
[    0.047126] PCIE0: Device detected, waiting for link...
[    0.047140] PCIE0: link is up !
[    0.149234] PCI host bridge /plb/pciex@d00000000 (primary) ranges:
[    0.149287]  MEM 0x0000000e00000000..0x0000000e7fffffff -&gt; 0x0000000080000000
[    0.149313]  MEM 0x0000000f00000000..0x0000000f000fffff -&gt; 0x0000000000000000
[    0.149336]   IO 0x0000000f80000000..0x0000000f8000ffff -&gt; 0x0000000000000000
[    0.149362] 4xx PCI DMA offset set to 0x00000000
[    0.149375] 4xx PCI DMA window base to 0x0000000000000000
[    0.149390] DMA window size 0x0000000080000000
[    0.149420] PCIE0: successfully set as root-complex
[    0.149460] PCIE1: Checking link...
[    0.149472] PCIE1: Device detected, waiting for link...
[    0.149486] PCIE1: link is up !
[    0.251485] PCI host bridge /plb/pciex@d20000000 (primary) ranges:
[    0.251520]  MEM 0x0000000e80000000..0x0000000effffffff -&gt; 0x0000000080000000
[    0.251546]  MEM 0x0000000f00100000..0x0000000f001fffff -&gt; 0x0000000000000000
[    0.251568]   IO 0x0000000f80010000..0x0000000f8001ffff -&gt; 0x0000000000000000
[    0.251592] 4xx PCI DMA offset set to 0x00000000
[    0.251606] 4xx PCI DMA window base to 0x0000000000000000
[    0.251620] DMA window size 0x0000000080000000
[    0.251646] PCIE1: successfully set as root-complex
[    0.251726] PCI host bridge /plb/pci@c0ec00000 (primary) ranges:
[    0.251748]  MEM 0x0000000d80000000..0x0000000dffffffff -&gt; 0x0000000080000000
[    0.251774]  MEM 0x0000000c0ee00000..0x0000000c0eefffff -&gt; 0x0000000000000000
[    0.251796]   IO 0x0000000c08000000..0x0000000c0800ffff -&gt; 0x0000000000000000
[    0.251819] 4xx PCI DMA offset set to 0x00000000
[    0.251832] 4xx PCI DMA window base to 0x0000000000000000
[    0.251846] DMA window size 0x0000000080000000
[    0.261402] PCI: Probing PCI hardware
[    0.261731] PCI host bridge to bus 0000:40
[    0.261768] pci_bus 0000:40: root bus resource [io  0xfffc0000-0xfffcffff] (bus address [0x0000-0xffff])
[    0.261797] pci_bus 0000:40: root bus resource [mem 0xe00000000-0xe7fffffff] (bus address [0x80000000-0xffffffff])
[    0.261826] pci_bus 0000:40: root bus resource [mem 0xf00000000-0xf000fffff] (bus address [0x00000000-0x000fffff])
[    0.261855] pci_bus 0000:40: root bus resource [bus 40-ff]
[    0.261969] PCI: Hiding 4xx host bridge resources 0000:40:00.0
[    0.264189] pci 0000:40:00.0: PCI bridge to [bus 41-7f]
[    0.264293] pci 0000:41:00.0: bridge configuration invalid ([bus 02-02]), reconfiguring
[    0.264868] pci 0000:41:00.0: PCI bridge to [bus 42-7f]
[    0.265081] PCI host bridge to bus 0001:80
[    0.265106] pci_bus 0001:80: root bus resource [io  0xfffe0000-0xfffeffff] (bus address [0x0000-0xffff])
[    0.265134] pci_bus 0001:80: root bus resource [mem 0xe80000000-0xeffffffff] (bus address [0x80000000-0xffffffff])
[    0.265181] pci_bus 0001:80: root bus resource [mem 0xf00100000-0xf001fffff] (bus address [0x00000000-0x000fffff])
[    0.265209] pci_bus 0001:80: root bus resource [bus 80-ff]
[    0.265305] PCI: Hiding 4xx host bridge resources 0001:80:00.0
[    0.268247] pci 0001:80:00.0: PCI bridge to [bus 81-bf]
[    0.268539] PCI host bridge to bus 0002:00
[    0.268563] pci_bus 0002:00: root bus resource [io  0x0000-0xffff]
[    0.268585] pci_bus 0002:00: root bus resource [mem 0xd80000000-0xdffffffff] (bus address [0x80000000-0xffffffff])
[    0.268614] pci_bus 0002:00: root bus resource [mem 0xc0ee00000-0xc0eefffff] (bus address [0x00000000-0x000fffff])
[    0.268642] pci_bus 0002:00: root bus resource [bus 00-ff]
[    0.269359] pci 0000:40:00.0: BAR 13: assigned [io  0xfffc1000-0xfffc1fff]
[    0.269393] pci 0000:41:00.0: BAR 13: assigned [io  0xfffc1000-0xfffc1fff]
[    0.269415] pci 0000:42:00.0: BAR 1: assigned [io  0xfffc1000-0xfffc107f]
[    0.269440] pci 0000:42:00.0: BAR 0: assigned [io  0xfffc1080-0xfffc109f]
[    0.269463] pci 0000:41:00.0: PCI bridge to [bus 42]
[    0.269482] pci 0000:41:00.0:   bridge window [io  0xfffc1000-0xfffc1fff]
[    0.269511] pci 0000:40:00.0: PCI bridge to [bus 41-7f]
[    0.269529] pci 0000:40:00.0:   bridge window [io  0xfffc1000-0xfffc1fff]
[    0.269615] pci 0001:80:00.0: BAR 15: assigned [mem 0xe80000000-0xe8fffffff 64bit pref]
[    0.269640] pci 0001:80:00.0: BAR 14: assigned [mem 0xe90000000-0xe900fffff]
[    0.269661] pci 0001:80:00.0: BAR 13: assigned [io  0xfffe1000-0xfffe1fff]
[    0.269685] pci 0001:81:00.0: BAR 0: assigned [mem 0xe80000000-0xe8fffffff 64bit pref]
[    0.269717] pci 0001:81:00.0: BAR 2: assigned [mem 0xe90000000-0xe9001ffff 64bit]
[    0.269747] pci 0001:81:00.0: BAR 6: assigned [mem 0xe90020000-0xe9003ffff pref]
[    0.269773] pci 0001:81:00.1: BAR 0: assigned [mem 0xe90040000-0xe90043fff 64bit]
[    0.269802] pci 0001:81:00.0: BAR 4: assigned [io  0xfffe1000-0xfffe10ff]
[    0.269824] pci 0001:80:00.0: PCI bridge to [bus 81-bf]
[    0.269842] pci 0001:80:00.0:   bridge window [io  0xfffe1000-0xfffe1fff]
[    0.269863] pci 0001:80:00.0:   bridge window [mem 0xe90000000-0xe900fffff]
[    0.269883] pci 0001:80:00.0:   bridge window [mem 0xe80000000-0xe8fffffff 64bit pref]
[    0.269968] pci 0002:00:06.0: BAR 0: assigned [mem 0xd80000000-0xd83ffffff]
[    0.269990] pci 0002:00:06.0: BAR 1: assigned [mem 0xd84000000-0xd841fffff]
[    0.270013] pci 0002:00:04.0: BAR 6: assigned [mem 0xd84200000-0xd8427ffff pref]
[    0.270037] pci 0002:00:04.0: BAR 5: assigned [mem 0xd84280000-0xd842801ff]
[    0.270058] pci 0002:00:04.0: BAR 4: assigned [io  0x1000-0x100f]
[    0.270079] pci 0002:00:04.0: BAR 0: assigned [io  0x1010-0x1017]
[    0.270099] pci 0002:00:04.0: BAR 2: assigned [io  0x1018-0x101f]
[    0.270120] pci 0002:00:04.0: BAR 1: assigned [io  0x1020-0x1023]
[    0.270140] pci 0002:00:04.0: BAR 3: assigned [io  0x1024-0x1027]
[    0.298144] raid6: int32x1    300 MB/s
[    0.314619] raid6: int32x2    429 MB/s
[    0.332598] raid6: int32x4    480 MB/s
[    0.349843] raid6: int32x8    234 MB/s
[    0.349865] raid6: using algorithm int32x4 (480 MB/s)
[    0.349880] raid6: using intx1 recovery algorithm
[    0.350216] vgaarb: device added: PCI:0001:81:00.0,decodes=io+mem,owns=none,locks=none
[    0.350248] vgaarb: loaded
[    0.350259] vgaarb: bridge control possible 0001:81:00.0
[    0.350804] SCSI subsystem initialized
[    0.351433] usbcore: registered new interface driver usbfs
[    0.351518] usbcore: registered new interface driver hub
[    0.351630] usbcore: registered new device driver usb
[    0.352644] Switched to clocksource timebase
[    0.362225] NET: Registered protocol family 2
[    0.363055] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.363156] TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
[    0.363233] TCP: Hash tables configured (established 8192 bind 8192)
[    0.363343] TCP: reno registered
[    0.363362] UDP hash table entries: 512 (order: 1, 8192 bytes)
[    0.363394] UDP-Lite hash table entries: 512 (order: 1, 8192 bytes)
[    0.363571] NET: Registered protocol family 1
[    0.364087] RPC: Registered named UNIX socket transport module.
[    0.364119] RPC: Registered udp transport module.
[    0.364133] RPC: Registered tcp transport module.
[    0.364147] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.364803] Could not remap bcsr
[    0.368882] genirq: Setting trigger mode 3 for irq 45 failed (uic_set_irq_type+0x0/0x184)
[    0.371303] futex hash table entries: 256 (order: -1, 3072 bytes)
[    0.383577] ntfs: driver 2.1.30 [Flags: R/W].
[    0.384237] fuse init (API version 7.23)
[    0.384866] msgmni has been set to 1486
[    0.387277] bounce: pool size: 64 pages
[    0.387378] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.387406] io scheduler noop registered
[    0.387443] io scheduler cfq registered (default)
[    0.388226] aer: probe of 0000:40:00.0:pcie02 failed with error -22
[    0.388277] aer: probe of 0001:80:00.0:pcie02 failed with error -22
[    0.388357] pcie_pme: probe of 0000:40:00.0:pcie01 failed with error -22
[    0.388395] pcie_pme: probe of 0001:80:00.0:pcie01 failed with error -22
[    0.389326] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.390412] console [ttyS0] disabled
[    0.411567] serial8250.0: ttyS0 at MMIO 0x4ef600300 (irq = 23, base_baud = 691200) is a U6_16550A
[    1.414596] console [ttyS0] enabled
[    1.438798] serial8250.0: ttyS1 at MMIO 0x4ef600400 (irq = 24, base_baud = 691200) is a U6_16550A
[    1.448482] console [ttyS0] disabled
[    1.452349] 4ef600300.serial: ttyS0 at MMIO 0x4ef600300 (irq = 23, base_baud = 691200) is a 16550
[    2.456385] console [ttyS0] enabled
[    2.460383] 4ef600400.serial: ttyS1 at MMIO 0x4ef600400 (irq = 24, base_baud = 691200) is a 16550
[    2.470039] Generic non-volatile memory driver v1.1
[    2.481188] brd: module loaded
[    2.487701] loop: module loaded
[    2.491960] sata_sil 0002:00:04.0: Applying R_ERR on DMA activate FIS errata fix
[    2.501064] scsi host0: sata_sil
[    2.505141] scsi host1: sata_sil
[    2.508768] ata1: SATA max UDMA/100 mmio m512@0xd84280000 tf 0xd84280080 irq 22
[    2.516506] ata2: SATA max UDMA/100 mmio m512@0xd84280000 tf 0xd842800c0 irq 22
[    2.525981] PPC 4xx OCP EMAC driver, version 3.54
[    2.531525] MAL v2 /plb/mcmal, 2 TX channels, 16 RX channels
[    2.537795] ZMII /plb/opb/emac-zmii@ef600d00 initialized
[    2.543568] RGMII /plb/opb/emac-rgmii@ef601500 initialized with MDIO support
[    2.551163] TAH /plb/opb/emac-tah@ef601350 initialized
[    2.556772] TAH /plb/opb/emac-tah@ef601450 initialized
[    2.562463] /plb/opb/emac-rgmii@ef601500: input 0 in RGMII mode
[    2.570153] eth0: EMAC-0 /plb/opb/ethernet@ef600e00, MAC 00:50:c2:80:d5:c5
[    2.577457] eth0: found Generic MII PHY (0x00)
[    2.582336] /plb/opb/emac-rgmii@ef601500: input 1 in RGMII mode
[    2.589957] eth1: EMAC-1 /plb/opb/ethernet@ef600f00, MAC 00:00:00:00:00:00
[    2.597249] eth1: found Generic MII PHY (0x01)
[    2.602220] PPP generic driver version 2.4.2
[    2.607065] PPP BSD Compression module registered
[    2.612062] PPP Deflate Compression module registered
[    2.617445] NET: Registered protocol family 24
[    2.622433] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.629496] ppc-of-ehci 4bffd0400.ehci: OF EHCI
[    2.634522] ppc-of-ehci 4bffd0400.ehci: new USB bus registered, assigned bus number 1
[    2.642960] ppc-of-ehci 4bffd0400.ehci: irq 32, io mem 0x4bffd0400
[    2.654655] ppc-of-ehci 4bffd0400.ehci: USB 2.0 started, EHCI 1.00
[    2.660996] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    2.667814] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.675054] usb usb1: Product: OF EHCI
[    2.678820] usb usb1: Manufacturer: Linux 3.17.0-rc1-Sam460ex ehci_hcd
[    2.685365] usb usb1: SerialNumber: PPC-OF USB
[    2.690317] hub 1-0:1.0: USB hub found
[    2.694296] hub 1-0:1.0: 1 port detected
[    2.698713] ehci-pci: EHCI PCI platform driver
[    2.703415] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    2.709837] ppc-of-ohci 4bffd0000.usb: OF OHCI
[    2.714547] ppc-of-ohci 4bffd0000.usb: new USB bus registered, assigned bus number 2
[    2.722450] ppc-of-ohci 4bffd0000.usb: irq 33, io mem 0x4bffd0000
[    2.839669] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[    2.852779] ata1.00: ATAPI: ASUS    DRW-24B3ST   c, 1.01, max UDMA/100
[    2.869759] ata1.00: configured for UDMA/100
[    2.881895] scsi 0:0:0:0: CD-ROM            ASUS     DRW-24B3ST   c   1.01 PQ: 0 ANSI: 5
[    2.921748] sr 0:0:0:0: [sr0] scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
[    2.936644] cdrom: Uniform CD-ROM driver Revision: 3.20
[    2.949588] sr 0:0:0:0: Attached scsi generic sg0 type 5
[    2.999688] usb 1-1: new high-speed USB device number 2 using ppc-of-ehci
[    3.128059] usb 1-1: New USB device found, idVendor=0424, idProduct=2517
[    3.138646] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    3.155769] hub 1-1:1.0: USB hub found
[    3.162681] hub 1-1:1.0: 7 ports detected
[    3.264671] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[    3.276928] ata2.00: ATA-8: WDC WD5000AAKS-00V1A0, 05.01D05, max UDMA/133
[    3.288646] ata2.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
[    3.308910] ata2.00: configured for UDMA/100
[    3.327902] scsi 1:0:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 1D05 PQ: 0 ANSI: 5
[    3.344909] sd 1:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/465 GiB)
[    3.352720] sd 1:0:0:0: Attached scsi generic sg1 type 0
[    3.361832] sd 1:0:0:0: [sda] Write Protect is off
[    3.371781] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.403263]  sda: RDSK (512) sda1 (SFS^@)(res 2 spb 1) sda2 (SFS^@)(res 2 spb 1) sda3 (SFS^B)(res 2 spb 1) sda4 (NTFS)(res 2 spb 2) sda5 (LNX^@)(res 2 spb 1) sda6 ((res 2 spb 1) sda7 (SWP^@)(res 2 spb 1) sda8 (LNX^@)(res 2 spb 1) sda9 (EXT^C)(res 2 spb 1) sda10 (SWP^@)(res 2 spb 1) sda11 (LNX^@)(res 2 spb 1) sda12 (EXT^C)(res 2 spb 1) sda13 (SWP^@)(res 2 spb 1) sda14 (LNX^@)(res 2 spb 1) sda15 (EXT^C)(res 2 spb 1) sda16 (SWP^@)(res 2 spb 1)
[    3.453796] usb 1-1.1: new low-speed USB device number 3 using ppc-of-ehci
[    3.464819] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
[    3.471690] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.478971] usb usb2: Product: OF OHCI
[    3.482753] usb usb2: Manufacturer: Linux 3.17.0-rc1-Sam460ex ohci_hcd
[    3.492302] sd 1:0:0:0: [sda] Attached SCSI disk
[    3.497187] usb usb2: SerialNumber: PPC-OF USB
[    3.502434] hub 2-0:1.0: USB hub found
[    3.506457] hub 2-0:1.0: 1 port detected
[    3.511108] ohci-pci: OHCI PCI platform driver
[    3.516197] usbcore: registered new interface driver usb-storage
[    3.522783] usbcore: registered new interface driver usbserial
[    3.529060] usbcore: registered new interface driver usbserial_generic
[    3.536054] usbserial: USB Serial support registered for generic
[    3.542929] mousedev: PS/2 mouse device common for all mice
[    3.548882] i2c /dev entries driver
[    3.554713] rtc-m41t80 0-0068: rtc core: registered m41t80 as rtc0
[    3.562282] ibm-iic 4ef600700.i2c: using standard (100 kHz) mode
[    3.568946] ibm-iic 4ef600800.i2c: using standard (100 kHz) mode
[    3.576004] device-mapper: ioctl: 4.27.0-ioctl (2013-10-30) initialised: <a class="moz-txt-link-abbreviated" href="mailto:dm-devel@redhat.com">dm-devel@redhat.com</a>
[    3.585099] sdhci: Secure Digital Host Controller Interface driver
[    3.591467] sdhci: Copyright(c) Pierre Ossman
[    3.596039] usbcore: registered new interface driver ushc
[    3.601517] usb 1-1.1: New USB device found, idVendor=04f2, idProduct=0116
[    3.608724] hidraw: raw HID events driver (C) Jiri Kosina
[    3.614182] usb 1-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.622377] usbcore: registered new interface driver usbhid
[    3.628150] usb 1-1.1: Product: USB Keyboard
[    3.632699] usbhid: USB HID core driver
[    3.636707] usb 1-1.1: Manufacturer: CHICONY
[    3.641316] ipip: IPv4 over IPv4 tunneling driver
[    3.647581] TCP: cubic registered
[    3.651320] Initializing XFRM netlink socket
[    3.658330] input: CHICONY USB Keyboard as /devices/plb/4bffd0400.ehci/usb1/1-1/1-1.1/1-1.1:1.0/0003:04F2:0116.0001/input/input0
[    3.671169] NET: Registered protocol family 10
[    3.677096] sit: IPv6 over IPv4 tunneling driver
[    3.682360] hid-generic 0003:04F2:0116.0001: input,hidraw0: USB HID v1.10 Keyboard [CHICONY USB Keyboard] on usb-PPC-OF USB-1.1/input0
[    3.695282] NET: Registered protocol family 17
[    3.699988] NET: Registered protocol family 15
[    3.707516] Btrfs loaded
[    3.711967] rtc-m41t80 0-0068: setting system clock to 2015-02-15 00:23:59 UTC (1423959839)
[    3.765100] EXT3-fs (sda12): mounted filesystem with ordered data mode
[    3.771691] kjournald starting.  Commit interval 5 seconds
[    3.777232] VFS: Mounted root (ext3 filesystem) readonly on device 8:12.
[    3.784045] usb 1-1.2: new full-speed USB device number 4 using ppc-of-ehci
[    3.812205] devtmpfs: mounted
[    3.815858] Freeing unused kernel memory: 236K (c070f000 - c074a000)
[    3.888328] usb 1-1.2: New USB device found, idVendor=046d, idProduct=c52b
[    3.895399] usb 1-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.902902] usb 1-1.2: Product: USB Receiver
[    3.907338] usb 1-1.2: Manufacturer: Logitech
[    3.918233] input: Logitech USB Receiver as /devices/plb/4bffd0400.ehci/usb1/1-1/1-1.2/1-1.2:1.0/0003:046D:C52B.0002/input/input1
[    3.930895] hid-generic 0003:046D:C52B.0002: input,hidraw1: USB HID v1.11 Keyboard [Logitech USB Receiver] on usb-PPC-OF USB-1.2/input0
[    3.952076] input: Logitech USB Receiver as /devices/plb/4bffd0400.ehci/usb1/1-1/1-1.2/1-1.2:1.1/0003:046D:C52B.0003/input/input2
[    3.965443] hid-generic 0003:046D:C52B.0003: input,hidraw2: USB HID v1.11 Mouse [Logitech USB Receiver] on usb-PPC-OF USB-1.2/input1
[    3.985424] hid-generic 0003:046D:C52B.0004: hidraw3: USB HID v1.11 Device [Logitech USB Receiver] on usb-PPC-OF USB-1.2/input2
[    4.071920] usb 1-1.7: new high-speed USB device number 5 using ppc-of-ehci
[    4.171278] usb 1-1.7: New USB device found, idVendor=0424, idProduct=2240
[    4.178473] usb 1-1.7: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    4.186345] usb 1-1.7: Product: Ultra Fast Media
[    4.191221] usb 1-1.7: Manufacturer: Generic
[    4.196312] usb 1-1.7: SerialNumber: 000000225001
[    4.202312] usb-storage 1-1.7:1.0: USB Mass Storage device detected
[    4.208952] scsi host2: usb-storage 1-1.7:1.0
[    4.301159] random: nonblocking pool is initialized
[    5.111272] udevd[880]: starting version 175
[    5.215723] scsi 2:0:0:0: Direct-Access     Generic  Ultra HS-COMBO   1.98 PQ: 0 ANSI: 0
[    5.238185] sd 2:0:0:0: Attached scsi generic sg2 type 0
[    5.244138] sd 2:0:0:0: [sdb] Attached SCSI removable disk
[    5.715269] Linux agpgart interface v0.103
[    6.019063] [drm] Initialized drm 1.1.0 20060810
[    6.364350] snd_hda_intel 0001:81:00.1: enabling device (0000 -&gt; 0002)
[    6.453794] snd_hda_intel 0001:81:00.1: ppc4xx_setup_msi_irqs: fail mapping irq
[    6.487530] Unable to handle kernel paging request for data at address 0x0fa06c7c
[    6.495055] Faulting instruction address: 0xc032202c
[    6.500033] Vector: 300 (Data Access) at [efa31cf0]
[    6.504922]     pc: c032202c: __reg_op+0xe8/0x100
[    6.509697]     lr: c0014f88: msi_bitmap_free_hwirqs+0x50/0x94
[    6.515600]     sp: efa31da0
[    6.518491]    msr: 21000
[    6.521112]    dar: fa06c7c
[    6.523915]  dsisr: 0
[    6.526190]   current = 0xef8bab00
[    6.529603]     pid   = 115, comm = kworker/0:1
[    6.534163] enter ? for help
[    6.537054] [link register   ] c0014f88 msi_bitmap_free_hwirqs+0x50/0x94
[    6.543811] [efa31da0] c0014f78 msi_bitmap_free_hwirqs+0x40/0x94 (unreliable)
[    6.551001] [efa31dc0] c001aee8 ppc4xx_setup_msi_irqs+0xac/0xf4
[    6.556973] [efa31e00] c03503a4 pci_enable_msi_range+0x1e0/0x280
[    6.563032] [efa31e40] f92c2f74 azx_probe_work+0xe0/0x57c [snd_hda_intel]
[    6.569906] [efa31e80] c0036344 process_one_work+0x1e8/0x2f0
[    6.575627] [efa31eb0] c003677c worker_thread+0x2f4/0x438
[    6.581079] [efa31ef0] c003a3e4 kthread+0xc8/0xcc
[    6.585844] [efa31f40] c000aec4 ret_from_kernel_thread+0x5c/0x64
[    6.591910] mon&gt;  &lt;no input ...&gt;
[    8.595205] Oops: Kernel access of bad area, sig: 11 [#1]
[    8.600607] PREEMPT Canyonlands
[    8.603769] Modules linked in: snd_seq_midi snd_seq_midi_event cfbfillrect snd_hda_intel cfbimgblt snd_hda_controller cfbcopyarea snd_rawmidi i2c_algo_bit snd_hda_codec drm_kms_helper ttm snd_pcm snd_seq snd_seq_device snd_timer drm snd agpgart
[    8.625753] CPU: 0 PID: 115 Comm: kworker/0:1 Not tainted 3.17.0-rc1-Sam460ex #1
[    8.633171] Workqueue: events azx_probe_work [snd_hda_intel]
[    8.638857] task: ef8bab00 ti: efa30000 task.ti: efa30000
[    8.644264] NIP: c032202c LR: c0014f88 CTR: 00000001
[    8.649238] REGS: efa31cf0 TRAP: 0300   Not tainted  (3.17.0-rc1-Sam460ex)
[    8.656121] MSR: 00021000 &lt;CE,ME&gt;  CR: 24002022  XER: 20000000
[    8.662023] DEAR: 0fa06c7c ESR: 00000000
GPR00: c0014f78 efa31da0 ef8bab00 0fa06c7c ffefffff 00000001 00000002 00000000
GPR08: 00000002 00000000 00000001 efa31da0 24002024 00000000 c003a31c ef9f9520
GPR16: 00000000 00000000 00000000 00000000 c074fd8c fffffef7 c0750000 00000000
GPR24: ef843538 00000000 c0885830 ef843000 fffffff4 c0885830 00000000 00029000
[    8.694807] NIP [c032202c] __reg_op+0xe8/0x100
[    8.699259] LR [c0014f88] msi_bitmap_free_hwirqs+0x50/0x94
[    8.704749] Call Trace:
[    8.707202] [efa31da0] [c0014f78] msi_bitmap_free_hwirqs+0x40/0x94 (unreliable)
[    8.714552] [efa31dc0] [c001aee8] ppc4xx_setup_msi_irqs+0xac/0xf4
[    8.720672] [efa31e00] [c03503a4] pci_enable_msi_range+0x1e0/0x280
[    8.726882] [efa31e40] [f92c2f74] azx_probe_work+0xe0/0x57c [snd_hda_intel]
[    8.733867] [efa31e80] [c0036344] process_one_work+0x1e8/0x2f0
[    8.739726] [efa31eb0] [c003677c] worker_thread+0x2f4/0x438
[    8.745326] [efa31ef0] [c003a3e4] kthread+0xc8/0xcc
[    8.750229] [efa31f40] [c000aec4] ret_from_kernel_thread+0x5c/0x64
[    8.756433] Instruction dump:
[    8.759419] 38600001 4e800020 42400038 5549103a 394a0001 7d03482e 7d082378 7d03492e
[    8.767300] 4bffffe8 4240001c 5549103a 394a0001 &lt;7d03482e&gt; 7d082038 7d03492e 4bffffe8
[    8.775360] ---[ end trace 1b4d3bc28e3986f5 ]---
[    8.779983]
</pre>
    <title></title>
    <meta name="generator" content="LibreOffice 4.3.5.2 (Windows)">
    <meta name="created" content="00:00:00">
    <meta name="changed" content="00:00:00">
    <style type="text/css">
		@page { margin: 0.79in }
		pre.cjk { font-family: "NSimSun", monospace }
		p { margin-bottom: 0.1in; line-height: 120% }
		a:link { so-language: zxx }
	</style><br>
    <br>
     
    <title></title>
    <meta name="generator" content="LibreOffice 4.3.5.2 (Windows)">
    <meta name="created" content="00:00:00">
    <meta name="changed" content="00:00:00">
    <style type="text/css">
		@page { margin: 0.79in }
		pre.cjk { font-family: "NSimSun", monospace }
		p { margin-bottom: 0.1in; line-height: 120% }
		a:link { so-language: zxx }
	</style><br>
    <br>
    <br>
  </body>
</html>

--------------010106060805060703020500--
