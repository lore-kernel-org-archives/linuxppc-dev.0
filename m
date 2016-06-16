Return-Path: <darrick.wong@oracle.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rVXjh65KNzDqR3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 15:58:00 +1000 (AEST)
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rVXjg23BXz9t1c
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Jun 2016 15:57:59 +1000 (AEST)
Date: Wed, 15 Jun 2016 22:57:46 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@ozlabs.org
Subject: Re: kernel bug in "Drop WIMG in favour of new constants"?
Message-ID: <20160616055746.GC22590@birch.djwong.org>
References: <20160616043340.GB22590@birch.djwong.org>
 <1466054627.5400.5.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8t9RHnE3ZwKMSgU+"
In-Reply-To: <1466054627.5400.5.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 16, 2016 at 03:23:47PM +1000, Michael Ellerman wrote:
> On Wed, 2016-06-15 at 21:33 -0700, Darrick J. Wong wrote:
> 
> > Hi Aneesh,
> > 
> > I noticed when trying out 4.7-rc3 on qemu-2.5 that the kernel no longer
> > boots.  4.6 booted just fine, so I bisected the kernel to the commit
> > 30bda41aba4efb2370c97e2cbe7385de93ccc372, which is "powerpc/mm: Drop WIMG in
> > favour of new constants".  The changelog suggests that the KVM changes need
> > closer review, and here's an actual crash:
> > 
> > (I can send libvirt's machine xml, .config, and full dmesg if that helps.)
> 
> Yes please.
> 
> I'm successfully booting 4.7-rc's on qemu (2.5.0 (Debian 1:2.5+dfsg-5ubuntu10.1)).

Ok, see attached.  I also sent along the dpkg --status output for qemu
and qemu-slof; looks like we're running the same Ubuntu packages...

...my host kernel is 4.6.0 on x64.

--D

--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

Connected to domain mtrp0
Escape character is ^]
Populating /vdevice methods
Populating /vdevice/vty@30000000
Populating /vdevice/nvram@71000000
Populating /pci@800000020000000
                     00 4000 (D) : 1af4 1005    unknown-legacy-device*
                     00 3800 (D) : 1af4 1000    virtio [ net ]
                     00 3000 (D) : 1af4 1000    virtio [ net ]
                     00 2800 (D) : 1af4 1002    unknown-legacy-device*
                     00 2000 (D) : 1af4 1003    communication-controller*
                     00 1800 (D) : 1af4 1004    virtio [ scsi ]
Populating /pci@800000020000000/scsi@3
       SCSI: Looking for devices
          100000100000000 DISK     : "QEMU     QEMU HARDDISK    2.5+"
          100000000000000 DISK     : "QEMU     QEMU HARDDISK    2.5+"
                     00 1000 (D) : 1033 0194    serial bus [ usb-xhci ]
                     00 0800 (D) : 1234 1111    qemu vga
Installing QEMU fb



Scanning USB 
  XHCI: Initializing
    USB Keyboard 
    USB mouse 
    USB HUB 
No console specified using screen & keyboard
Detected RAM kernel at 400000 (103dad8 bytes)      
  Welcome to Open Firmware

  Copyright (c) 2004, 2011 IBM Corporation All rights reserved.
  This program and the accompanying materials are made available
  under the terms of the BSD License available at
  http://www.opensource.org/licenses/bsd-license.php

Booting from memory...
[    0.000000] bootconsole [udbg0] enabled
 -> early_setup(), dt_ptr: 0x1942000
[    0.000000] Allocated 4096 bytes for 1 pacas at c00000000ffff000
[    0.000000] pSeries detected, looking for LPAR capability...
[    0.000000]  -> fw_vec5_feature_init()
[    0.000000]  <- fw_vec5_feature_init()
[    0.000000]  -> fw_hypertas_feature_init()
[    0.000000]  <- fw_hypertas_feature_init()
[    0.000000] Machine is LPAR !
[    0.000000] Using pSeries machine description
Found, Initializing memory management...
[    0.000000] Page sizes from device-tree:
[    0.000000] base_shift=12: shift=12, sllp=0x0000, avpnm=0x00000000, tlbiel=1, penc=0
[    0.000000] base_shift=24: shift=24, sllp=0x0100, avpnm=0x00000001, tlbiel=0, penc=0
[    0.000000] Page orders: linear mapping = 24, virtual = 12, io = 12, vmemmap = 24
[    0.000000] Using 1TB segments
 <- early_setup()
 -> setup_system()
 -> initialize_cache_info()
 <- initialize_cache_info()
[    0.000000] Found initrd at 0xc000000001450000:0xc0000000018d8cd3
[    0.000000]  -> pSeries_init_early()
[    0.000000]  -> fw_cmo_feature_init()
[    0.000000] CMO not available
[    0.000000]  <- fw_cmo_feature_init()
[    0.000000]  <- pSeries_init_early()
[    0.000000] Starting Linux ppc64 #11 PREEMPT Wed Jun 15 18:03:32 PDT 2016
[    0.000000] -----------------------------------------------------
[    0.000000] ppc64_pft_size    = 0x18
[    0.000000] phys_mem_size     = 0x80000000
[    0.000000] cpu_features      = 0x0b7e7a6418500049
[    0.000000]   possible        = 0x3f7fffff18500649
[    0.000000]   always          = 0x0000000018100040
[    0.000000] cpu_user_features = 0xdc0065c2 0x20000000
[    0.000000] mmu_features      = 0x7c000001
[    0.000000] firmware_features = 0x00000001405a440b
[    0.000000] htab_hash_mask    = 0x1ffff
[    0.000000] -----------------------------------------------------
 <- setup_system()
[    0.000000] Linux version 4.7.0-rc3-pcsum (djwong@alder.djwong.org) (gcc version 5.3.1 20160413 (Ubuntu 5.3.1-14ubuntu2) ) #11 PREEMPT Wed Jun 15 18:03:32 PDT 2016
[    0.000000] PCI host bridge /pci@800000020000000  ranges:
[    0.000000]   IO 0x0000010080000000..0x000001008000ffff -> 0x0000000000000000
[    0.000000]  MEM 0x00000100a0000000..0x000001101fffffff -> 0x0000000080000000 
[    0.000000] PPC64 nvram contains 131072 bytes
[    0.000000] Relocation on exceptions not supported
[    0.000000] Top of RAM: 0x80000000, Total RAM: 0x80000000
[    0.000000] Memory hole size: 0MB
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000000000-0x000000007fffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000007fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000007fffffff]
[    0.000000] On node 0 totalpages: 524288
[    0.000000]   DMA zone: 8192 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 524288 pages, LIFO batch:31
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 516096
[    0.000000] Kernel command line: ro rootdelay=60 panic=0 noresume root=/dev/nfs nfsroot=192.168.122.1:/storage/mtr/ppc64/ ip=dhcp hostname=alder-mtrp0 BOOTIF=01-52-54-00-26-f3-ee console=hvc0 debug systemd.show_status=false
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.000000] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.000000] Sorting __ex_table...
[    0.000000] Memory: 1973740K/2097152K available (7212K kernel code, 1432K rwdata, 2308K rodata, 3588K init, 2062K bss, 123412K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=128, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000]  Build-time adjustment of leaf fanout to 64.
[    0.000000] NR_IRQS:512 nr_irqs:512 16
[    0.000000] pic: no ISA interrupt controller
[    0.000000] time_init: decrementer frequency = 512.000000 MHz
[    0.000000] time_init: processor frequency   = 1000.000000 MHz
[    0.000210] clocksource: timebase: mask: 0xffffffffffffffff max_cycles: 0x761537d007, max_idle_ns: 440795202126 ns
[    0.000587] clocksource: timebase mult[1f40000] shift[24] registered
[    0.000923] clockevent: decrementer mult[83126e98] shift[32] cpu[0]
[    0.004297] Console: colour dummy device 80x25
[    0.004943] console [hvc0] enabled
[    0.004943] console [hvc0] enabled
[    0.005364] bootconsole [udbg0] disabled
[    0.005364] bootconsole [udbg0] disabled
[    0.008176] pid_max: default: 32768 minimum: 301
[    0.010985] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
[    0.011182] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes)
[    0.023245] ftrace: allocating 18922 entries in 112 pages
[    0.104384] EEH: pSeries platform initialized
[    0.106314] POWER7 performance monitor hardware support registered
[    0.129177] devtmpfs: initialized
[    0.143863] EEH: devices created
[    0.144887] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.149669] NET: Registered protocol family 16
[    0.154090] EEH: No capable adapters found
[    0.168883] cpuidle: using governor ladder
[    0.180984] cpuidle: using governor menu
Linux ppc64
#11 PREEMPT Wed [    0.184645] rtas_msi: Registering RTAS MSI callbacks.
[    0.197451] PCI: Probing PCI hardware
[    0.199166] no ibm,pcie-link-speed-stats property
[    0.200470] PCI host bridge to bus 0000:00
[    0.201075] pci_bus 0000:00: root bus resource [io  0x10000-0x1ffff] (bus address [0x0000-0xffff])
[    0.201548] pci_bus 0000:00: root bus resource [mem 0x100a0000000-0x1101fffffff] (bus address [0x80000000-0xfffffffff])
[    0.201994] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.212257] pci_dma_bus_setup_pSeriesLP: setting up bus /pci@800000020000000
[    0.212571]   parent is /pci@800000020000000, iommu_table: 0x          (null)
[    0.216849] IOMMU table initialized, virtual merging enabled
[    0.217357]   created table: c00000007f9ba3c0
[    0.217581] pci_dma_dev_setup_pSeriesLP: 0000:00:08.0
[    0.217723]   node is /pci@800000020000000/unknown-legacy-device@8
[    0.217920]   parent is /pci@800000020000000
[    0.218034]   found DMA window, table: c00000007f9ba3c0
[    0.218381] iommu: Adding device 0000:00:08.0 to group 0
[    0.221509] pci 0000:00:08.0: rtas_msi: disabling existing MSI.
[    0.221833] rtas_msi: ibm,change_msi(func=3,num=0), got 0 rc = -1
[    0.222044] rtas_msi: ibm,change_msi(func=1,num=0), got 0 rc = -1
[    0.222208] rtas_msi: Setting MSIs to 0 failed!
[    0.222346] pci_dma_dev_setup_pSeriesLP: 0000:00:07.0
[    0.222474]   node is /pci@800000020000000/ethernet@7
[    0.222600]   parent is /pci@800000020000000
[    0.222707]   found DMA window, table: c00000007f9ba3c0
[    0.222885] iommu: Adding device 0000:00:07.0 to group 0
[    0.223361] pci 0000:00:07.0: rtas_msi: disabling existing MSI.
[    0.223531] rtas_msi: ibm,change_msi(func=3,num=0), got 0 rc = -1
[    0.223698] rtas_msi: ibm,change_msi(func=1,num=0), got 0 rc = -1
[    0.223855] rtas_msi: Setting MSIs to 0 failed!
[    0.223978] pci_dma_dev_setup_pSeriesLP: 0000:00:06.0
[    0.224094]   node is /pci@800000020000000/ethernet@6
[    0.224213]   parent is /pci@800000020000000
[    0.224317]   found DMA window, table: c00000007f9ba3c0
[    0.224495] iommu: Adding device 0000:00:06.0 to group 0
[    0.225012] pci 0000:00:06.0: rtas_msi: disabling existing MSI.
[    0.225178] rtas_msi: ibm,change_msi(func=3,num=0), got 0 rc = -1
[    0.225338] rtas_msi: ibm,change_msi(func=1,num=0), got 0 rc = -1
[    0.225504] rtas_msi: Setting MSIs to 0 failed!
[    0.225627] pci_dma_dev_setup_pSeriesLP: 0000:00:05.0
[    0.225749]   node is /pci@800000020000000/unknown-legacy-device@5
[    0.225890]   parent is /pci@800000020000000
[    0.225991]   found DMA window, table: c00000007f9ba3c0
[    0.226174] iommu: Adding device 0000:00:05.0 to group 0
[    0.226565] pci 0000:00:05.0: rtas_msi: disabling existing MSI.
[    0.226731] rtas_msi: ibm,change_msi(func=3,num=0), got 0 rc = -1
[    0.226894] rtas_msi: ibm,change_msi(func=1,num=0), got 0 rc = -1
[    0.227042] rtas_msi: Setting MSIs to 0 failed!
[    0.227161] pci_dma_dev_setup_pSeriesLP: 0000:00:04.0
[    0.227278]   node is /pci@800000020000000/communication-controller@4
[    0.227429]   parent is /pci@800000020000000
[    0.227537]   found DMA window, table: c00000007f9ba3c0
[    0.227706] iommu: Adding device 0000:00:04.0 to group 0
[    0.228047] pci 0000:00:04.0: rtas_msi: disabling existing MSI.
[    0.228221] rtas_msi: ibm,change_msi(func=3,num=0), got 0 rc = -1
[    0.228385] rtas_msi: ibm,change_msi(func=1,num=0), got 0 rc = -1
[    0.228599] rtas_msi: Setting MSIs to 0 failed!
[    0.228734] pci_dma_dev_setup_pSeriesLP: 0000:00:03.0
[    0.228867]   node is /pci@800000020000000/scsi@3
[    0.229137]   parent is /pci@800000020000000
[    0.229263]   found DMA window, table: c00000007f9ba3c0
[    0.229466] iommu: Adding device 0000:00:03.0 to group 0
[    0.229768] pci 0000:00:03.0: rtas_msi: disabling existing MSI.
[    0.229944] rtas_msi: ibm,change_msi(func=3,num=0), got 0 rc = -1
[    0.230126] rtas_msi: ibm,change_msi(func=1,num=0), got 0 rc = -1
[    0.230284] rtas_msi: Setting MSIs to 0 failed!
[    0.230413] pci_dma_dev_setup_pSeriesLP: 0000:00:02.0
[    0.230546]   node is /pci@800000020000000/usb@2
[    0.230669]   parent is /pci@800000020000000
[    0.230783]   found DMA window, table: c00000007f9ba3c0
[    0.230966] iommu: Adding device 0000:00:02.0 to group 0
[    0.231235] pci 0000:00:02.0: rtas_msi: disabling existing MSI.
[    0.231418] rtas_msi: ibm,change_msi(func=3,num=0), got 0 rc = -1
[    0.231598] rtas_msi: ibm,change_msi(func=1,num=0), got 0 rc = -1
[    0.231752] rtas_msi: Setting MSIs to 0 failed!
[    0.231874] pci_dma_dev_setup_pSeriesLP: 0000:00:01.0
[    0.231996]   node is /pci@800000020000000/vga@1
[    0.232122]   parent is /pci@800000020000000
[    0.232231]   found DMA window, table: c00000007f9ba3c0
[    0.232416] iommu: Adding device 0000:00:01.0 to group 0
[    0.232694] pci 0000:00:01.0: rtas_msi: no LSI, nothing to do.
[    0.235387] PCI: Probing PCI hardware done
[    0.277880] HugeTLB registered 16 MB page size, pre-allocated 0 pages
[    0.289910] SCSI subsystem initialized
[    0.291318] usbcore: registered new interface driver usbfs
[    0.292508] usbcore: registered new interface driver hub
[    0.293151] usbcore: registered new device driver usb
[    0.305298] clocksource: Switched to clocksource timebase
[    0.443753] VFS: Disk quotas dquot_6.6.0
[    0.444154] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.478299] NET: Registered protocol family 2
[    0.484695] TCP established hash table entries: 16384 (order: 5, 131072 bytes)
[    0.488221] TCP bind hash table entries: 16384 (order: 5, 131072 bytes)
[    0.488806] TCP: Hash tables configured (established 16384 bind 16384)
[    0.489946] UDP hash table entries: 1024 (order: 3, 32768 bytes)
[    0.490270] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes)
[    0.491928] NET: Registered protocol family 1
[    0.494500] RPC: Registered named UNIX socket transport module.
[    0.494717] RPC: Registered udp transport module.
[    0.494879] RPC: Registered tcp transport module.
[    0.495017] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.497440] mm: Hashing failure ! EA=0xd000080080000010 access=0x800000000000000c current=swapper
[    0.498039]     trap=0x300 vsid=0x13d349c ssize=1 base psize=0 psize 0 pte=0xc0000101200001ae
[    0.498398] mm: Hashing failure ! EA=0xd000080080000010 access=0x800000000000000c current=swapper
[    0.498785]     trap=0x300 vsid=0x13d349c ssize=1 base psize=0 psize 0 pte=0xc0000101200001ae
[    0.499282] Unable to handle kernel paging request for data at address 0xd000080080000010
[    0.499575] Faulting instruction address: 0xc00000000053b4bc
[    0.499997] Oops: Kernel access of bad area, sig: 7 [#1]
[    0.500211] PREEMPT pSeries
[    0.500565] Modules linked in:
[    0.500879] CPU: 0 PID: 1 Comm: swapper Not tainted 4.7.0-rc3-pcsum #11
[    0.501250] task: c00000007f950000 ti: c00000007f94c000 task.ti: c00000007f94c000
[    0.501526] NIP: c00000000053b4bc LR: c00000000053b4a8 CTR: 0000000000000000
[    0.501783] REGS: c00000007f94f740 TRAP: 0300   Not tainted  (4.7.0-rc3-pcsum)
[    0.502031] MSR: 8000000002009032 <SF,VEC,EE,ME,IR,DR,RI>  CR: 84000242  XER: 00000000
[    0.502526] CFAR: c0000000000083b4 DAR: d000080080000010 DSISR: 40000000 SOFTE: 1 
GPR00: c00000000053b4a8 c00000007f94f9c0 c000000000e24000 d000080080000010 
GPR04: d000080080003000 c00000007f8d4018 4000000000000000 000000007f9f0000 
GPR08: 000000007f8d4000 c0000101200031ae 00000000000001ff 0000000000000300 
GPR12: 0000000084000242 c00000000ffff000 c00000000000b2a0 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR20: 0000000000000000 0000000000000000 0000000000000000 c00000000094a3b8 
GPR24: c000000000d952a8 c00000000099a098 c00000000102c250 c000000000e51088 
GPR28: 000000000000ffff d000080080000000 0000000000004000 c00000007f81b000 
[    0.505368] NIP [c00000000053b4bc] .quirk_usb_early_handoff+0x48c/0xd00
[    0.505626] LR [c00000000053b4a8] .quirk_usb_early_handoff+0x478/0xd00
[    0.505896] Call Trace:
[    0.506077] [c00000007f94f9c0] [c00000000053b4a8] .quirk_usb_early_handoff+0x478/0xd00 (unreliable)
[    0.506477] [c00000007f94fab0] [c0000000004312ac] .pci_do_fixups+0xdc/0x140
[    0.506751] [c00000007f94fb60] [c00000000098427c] .pci_apply_final_quirks+0xb0/0x194
[    0.507043] [c00000007f94fc10] [c00000000000aa48] .do_one_initcall+0x68/0x1e0
[    0.507311] [c00000007f94fcf0] [c000000000957278] .kernel_init_freeable+0x238/0x320
[    0.507597] [c00000007f94fdb0] [c00000000000b2c4] .kernel_init+0x24/0x160
[    0.507872] [c00000007f94fe30] [c000000000009230] .ret_from_kernel_thread+0x58/0xa8
[    0.508172] Instruction dump:
[    0.508385] 7d3e07b4 4bfff9e1 2fa30000 41befc8c e87f0320 7fc4f378 4bb093fd 60000000 
[    0.508794] 7c7d1b79 4182fc74 387d0010 7c0004ac <7d201c2c> 0c090000 4c00012c 2f89ffff 
[    0.510503] ---[ end trace b7e54f4dcb78b6ca ]---
[    0.537662] 
[    1.540840] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000007
[    1.540840] 



--8t9RHnE3ZwKMSgU+
Content-Type: application/xml
Content-Disposition: attachment; filename="libvirt.xml"
Content-Transfer-Encoding: quoted-printable

<!--=0AWARNING: THIS IS AN AUTO-GENERATED FILE. CHANGES TO IT ARE LIKELY TO=
 BE=0AOVERWRITTEN AND LOST. Changes to this xml configuration should be mad=
e using:=0A  virsh edit mtrp0=0Aor other application using the libvirt API.=
=0A-->=0A=0A<domain type=3D'qemu' xmlns:qemu=3D'http://libvirt.org/schemas/=
domain/qemu/1.0'>=0A  <name>mtrp0</name>=0A  <uuid>cf559133-7988-42cd-bef2-=
26f3ee8e385b</uuid>=0A  <description></description>=0A  <memory unit=3D'KiB=
'>2097152</memory>=0A  <currentMemory unit=3D'KiB'>2097152</currentMemory>=
=0A  <vcpu placement=3D'static'>4</vcpu>=0A  <os>=0A    <type arch=3D'ppc64=
' machine=3D'pseries-2.5'>hvm</type>=0A    <kernel>/storage/mtr/ppc64/boot/=
vmlinux-4.7.0-rc3-pcsum</kernel>=0A    <initrd>/storage/mtr/ppc64/boot/init=
rd.img-4.7.0-rc3-pcsum</initrd>=0A    <cmdline>ro rootdelay=3D60 panic=3D0 =
noresume root=3D/dev/nfs nfsroot=3D192.168.122.1:/storage/mtr/ppc64/ ip=3Dd=
hcp hostname=3Dalder-mtrp0 BOOTIF=3D01-52-54-00-26-f3-ee console=3Dhvc0 deb=
ug systemd.show_status=3Dfalse</cmdline>=0A    <boot dev=3D'network'/>=0A  =
</os>=0A  <clock offset=3D'utc'/>=0A  <on_poweroff>destroy</on_poweroff>=0A=
  <on_reboot>restart</on_reboot>=0A  <on_crash>restart</on_crash>=0A  <devi=
ces>=0A    <emulator>/usr/bin/qemu-system-ppc64</emulator>=0A    <disk type=
=3D'file' device=3D'disk'>=0A      <driver name=3D'qemu' type=3D'raw'/>=0A =
     <source file=3D'/dev/shm/a.img'/>=0A      <target dev=3D'sd0' bus=3D's=
csi'/>=0A      <address type=3D'drive' controller=3D'0' bus=3D'0' target=3D=
'0' unit=3D'0'/>=0A    </disk>=0A    <disk type=3D'file' device=3D'disk'>=
=0A      <driver name=3D'qemu' type=3D'raw'/>=0A      <source file=3D'/dev/=
shm/b.img'/>=0A      <target dev=3D'sd1' bus=3D'scsi'/>=0A      <address ty=
pe=3D'drive' controller=3D'0' bus=3D'0' target=3D'0' unit=3D'1'/>=0A    </d=
isk>=0A    <controller type=3D'pci' index=3D'0' model=3D'pci-root'/>=0A    =
<controller type=3D'usb' index=3D'0' model=3D'nec-xhci'>=0A      <address t=
ype=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' function=3D'0x0'/>=
=0A    </controller>=0A    <controller type=3D'scsi' index=3D'0' model=3D'v=
irtio-scsi'>=0A      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' s=
lot=3D'0x03' function=3D'0x0'/>=0A    </controller>=0A    <controller type=
=3D'virtio-serial' index=3D'0'>=0A      <address type=3D'pci' domain=3D'0x0=
000' bus=3D'0x00' slot=3D'0x04' function=3D'0x0'/>=0A    </controller>=0A  =
  <interface type=3D'bridge'>=0A      <mac address=3D'52:54:00:8e:38:5b'/>=
=0A      <source bridge=3D'br0'/>=0A      <model type=3D'virtio'/>=0A      =
<address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x07' function=
=3D'0x0'/>=0A    </interface>=0A    <interface type=3D'network'>=0A      <m=
ac address=3D'52:54:00:26:f3:ee'/>=0A      <source network=3D'default'/>=0A=
      <model type=3D'virtio'/>=0A      <address type=3D'pci' domain=3D'0x00=
00' bus=3D'0x00' slot=3D'0x06' function=3D'0x0'/>=0A    </interface>=0A    =
<serial type=3D'pty'>=0A      <target port=3D'0'/>=0A      <address type=3D=
'spapr-vio' reg=3D'0x30000000'/>=0A    </serial>=0A    <console type=3D'pty=
'>=0A      <target type=3D'serial' port=3D'0'/>=0A      <address type=3D'sp=
apr-vio' reg=3D'0x30000000'/>=0A    </console>=0A    <channel type=3D'spice=
vmc'>=0A      <target type=3D'virtio' name=3D'com.redhat.spice.0'/>=0A     =
 <address type=3D'virtio-serial' controller=3D'0' bus=3D'0' port=3D'1'/>=0A=
    </channel>=0A    <input type=3D'keyboard' bus=3D'usb'/>=0A    <input ty=
pe=3D'mouse' bus=3D'usb'/>=0A    <graphics type=3D'spice' autoport=3D'yes'/=
>=0A    <video>=0A      <model type=3D'vga' vram=3D'16384' heads=3D'1'/>=0A=
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' fu=
nction=3D'0x0'/>=0A    </video>=0A    <redirdev bus=3D'usb' type=3D'spicevm=
c'>=0A    </redirdev>=0A    <redirdev bus=3D'usb' type=3D'spicevmc'>=0A    =
</redirdev>=0A    <redirdev bus=3D'usb' type=3D'spicevmc'>=0A    </redirdev=
>=0A    <redirdev bus=3D'usb' type=3D'spicevmc'>=0A    </redirdev>=0A    <m=
emballoon model=3D'virtio'>=0A      <address type=3D'pci' domain=3D'0x0000'=
 bus=3D'0x00' slot=3D'0x05' function=3D'0x0'/>=0A    </memballoon>=0A    <r=
ng model=3D'virtio'>=0A      <backend model=3D'random'>/dev/random</backend=
>=0A      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x08=
' function=3D'0x0'/>=0A    </rng>=0A    <panic model=3D'pseries'/>=0A  </de=
vices>=0A  <qemu:commandline>=0A    <qemu:arg value=3D'-drive'/>=0A    <qem=
u:arg value=3D'if=3Dpflash,file=3D/storage/vms//mtrp0.bin,format=3Draw'/>=
=0A  </qemu:commandline>=0A</domain>=0A
--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pcsum_4.7.0-rc3_config.txt"

#
# Automatically generated file; DO NOT EDIT.
# Linux/powerpc 4.7.0-rc3 Kernel Configuration
#
CONFIG_PPC64=y

#
# Processor support
#
CONFIG_PPC_BOOK3S_64=y
# CONFIG_PPC_BOOK3E_64 is not set
CONFIG_GENERIC_CPU=y
# CONFIG_CELL_CPU is not set
# CONFIG_POWER4_CPU is not set
# CONFIG_POWER5_CPU is not set
# CONFIG_POWER6_CPU is not set
# CONFIG_POWER7_CPU is not set
# CONFIG_POWER8_CPU is not set
CONFIG_PPC_BOOK3S=y
CONFIG_PPC_FPU=y
CONFIG_ALTIVEC=y
CONFIG_VSX=y
CONFIG_PPC_ICSWX=y
CONFIG_PPC_ICSWX_PID=y
# CONFIG_PPC_ICSWX_USE_SIGILL is not set
CONFIG_PPC_STD_MMU=y
CONFIG_PPC_STD_MMU_64=y
# CONFIG_PPC_RADIX_MMU is not set
CONFIG_PPC_MM_SLICES=y
CONFIG_PPC_HAVE_PMU_SUPPORT=y
CONFIG_PPC_PERF_CTRS=y
# CONFIG_SMP is not set
CONFIG_PPC_DOORBELL=y
CONFIG_VDSO32=y
CONFIG_CPU_BIG_ENDIAN=y
# CONFIG_CPU_LITTLE_ENDIAN is not set
CONFIG_64BIT=y
CONFIG_WORD_SIZE=64
CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_MMU=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NR_IRQS=512
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_ARCH_HAS_ILOG2_U32=y
CONFIG_ARCH_HAS_ILOG2_U64=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_HAS_DMA_SET_COHERENT_MASK=y
CONFIG_PPC=y
# CONFIG_GENERIC_CSUM is not set
CONFIG_EARLY_PRINTK=y
CONFIG_PANIC_TIMEOUT=180
CONFIG_COMPAT=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_SCHED_OMIT_FRAME_POINTER=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_PPC_UDBG_16550=y
# CONFIG_GENERIC_TBSYNC is not set
CONFIG_AUDIT_ARCH=y
CONFIG_GENERIC_BUG=y
# CONFIG_EPAPR_BOOT is not set
# CONFIG_DEFAULT_UIMAGE is not set
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
# CONFIG_PPC_DCR_NATIVE is not set
# CONFIG_PPC_DCR_MMIO is not set
# CONFIG_PPC_OF_PLATFORM_PCI is not set
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_PPC_EMULATE_SSTEP=y
CONFIG_ZONE_DMA32=y
CONFIG_PGTABLE_LEVELS=4
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
CONFIG_IRQ_WORK=y

#
# General setup
#
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_CROSS_COMPILE=""
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_FHANDLE=y
CONFIG_USELIB=y
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y
CONFIG_AUDIT_WATCH=y
CONFIG_AUDIT_TREE=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_SHOW_LEVEL=y
CONFIG_IRQ_DOMAIN=y
CONFIG_GENERIC_MSI_IRQ=y
# CONFIG_IRQ_DOMAIN_DEBUG is not set
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_GENERIC_TIME_VSYSCALL_OLD=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ_FULL is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
# CONFIG_TICK_CPU_ACCOUNTING is not set
# CONFIG_VIRT_CPU_ACCOUNTING_NATIVE is not set
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set

#
# RCU Subsystem
#
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
# CONFIG_TASKS_RCU is not set
CONFIG_RCU_STALL_COMMON=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
# CONFIG_TREE_RCU_TRACE is not set
# CONFIG_RCU_NOCB_CPU_NONE is not set
# CONFIG_RCU_NOCB_CPU_ZERO is not set
# CONFIG_RCU_NOCB_CPU_ALL is not set
# CONFIG_RCU_EXPEDITE_BOOT is not set
# CONFIG_BUILD_BIN2C is not set
# CONFIG_IKCONFIG is not set
CONFIG_LOG_BUF_SHIFT=17
CONFIG_NMI_LOG_BUF_SHIFT=13
CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
# CONFIG_MEMCG_SWAP_ENABLED is not set
CONFIG_BLK_CGROUP=y
# CONFIG_DEBUG_BLK_CGROUP is not set
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
# CONFIG_RT_GROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
# CONFIG_CGROUP_DEBUG is not set
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
# CONFIG_RD_LZMA is not set
# CONFIG_RD_XZ is not set
# CONFIG_RD_LZO is not set
# CONFIG_RD_LZ4 is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_MULTIUSER=y
# CONFIG_SGETMASK_SYSCALL is not set
CONFIG_SYSFS_SYSCALL=y
CONFIG_SYSCTL_SYSCALL=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
# CONFIG_KALLSYMS_ABSOLUTE_PERCPU is not set
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_BPF_SYSCALL=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_ADVISE_SYSCALLS=y
# CONFIG_USERFAULTFD is not set
CONFIG_PCI_QUIRKS=y
CONFIG_MEMBARRIER=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
# CONFIG_SYSTEM_DATA_VERIFICATION is not set
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
CONFIG_KEXEC_CORE=y
# CONFIG_OPROFILE is not set
CONFIG_HAVE_OPROFILE=y
# CONFIG_KPROBES is not set
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
CONFIG_UPROBES=y
# CONFIG_HAVE_64BIT_ALIGNED_ACCESS is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_DMA_API_DEBUG=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_CC_STACKPROTECTOR is not set
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
# CONFIG_HAVE_ARCH_HASH is not set
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND=y
CONFIG_COMPAT_OLD_SIGACTION=y
# CONFIG_CPU_NO_EFFICIENT_FFS is not set

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
CONFIG_SLABINFO=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_MODVERSIONS=y
CONFIG_MODULE_SRCVERSION_ALL=y
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_THROTTLING=y
CONFIG_BLK_CMDLINE_PARSER=y

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_KARMA_PARTITION is not set
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
CONFIG_BLOCK_COMPAT=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_CFQ_GROUP_IOSCHED=y
CONFIG_DEFAULT_DEADLINE=y
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="deadline"
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_FREEZER=y
CONFIG_PPC_MSI_BITMAP=y
CONFIG_PPC_XICS=y
CONFIG_PPC_ICP_NATIVE=y
CONFIG_PPC_ICP_HV=y
CONFIG_PPC_ICS_RTAS=y
# CONFIG_GE_FPGA is not set

#
# Platform support
#
# CONFIG_PPC_POWERNV is not set
CONFIG_PPC_PSERIES=y
# CONFIG_PPC_SPLPAR is not set
CONFIG_PSERIES_ENERGY=m
CONFIG_SCANLOG=m
CONFIG_IO_EVENT_IRQ=y
CONFIG_LPARCFG=y
CONFIG_PPC_PSERIES_DEBUG=y
# CONFIG_PPC_SMLPAR is not set
CONFIG_HV_PERF_CTRS=y
# CONFIG_PPC_PMAC is not set
# CONFIG_PPC_MAPLE is not set
# CONFIG_PPC_PASEMI is not set
# CONFIG_PPC_PS3 is not set
# CONFIG_PPC_CELL is not set
# CONFIG_PPC_CELL_NATIVE is not set
# CONFIG_PPC_IBM_CELL_BLADE is not set
# CONFIG_PQ2ADS is not set
CONFIG_KVM_GUEST=y
CONFIG_EPAPR_PARAVIRT=y
CONFIG_PPC_NATIVE=y
CONFIG_PPC_OF_BOOT_TRAMPOLINE=y
CONFIG_UDBG_RTAS_CONSOLE=y
CONFIG_PPC_SMP_MUXED_IPI=y
# CONFIG_IPIC is not set
CONFIG_MPIC=y
# CONFIG_PPC_EPAPR_HV_PIC is not set
# CONFIG_MPIC_WEIRD is not set
CONFIG_MPIC_MSGR=y
CONFIG_PPC_I8259=y
# CONFIG_U3_DART is not set
CONFIG_PPC_RTAS=y
CONFIG_RTAS_ERROR_LOGGING=y
CONFIG_PPC_RTAS_DAEMON=y
CONFIG_RTAS_PROC=y
# CONFIG_RTAS_FLASH is not set
# CONFIG_MMIO_NVRAM is not set
# CONFIG_MPIC_U3_HT_IRQS is not set
CONFIG_IBMVIO=y
# CONFIG_IBMEBUS is not set
CONFIG_EEH=y
# CONFIG_PPC_MPC106 is not set
# CONFIG_PPC_970_NAP is not set
# CONFIG_PPC_P7_NAP is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# CPUIdle driver
#

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y

#
# POWERPC CPU Idle Drivers
#
CONFIG_PSERIES_CPUIDLE=y
# CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
# CONFIG_FSL_ULI1575 is not set
# CONFIG_SIMPLE_GPIO is not set

#
# Kernel options
#
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_SCHED_HRTICK=y
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
CONFIG_BINFMT_SCRIPT=y
# CONFIG_HAVE_AOUT is not set
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
CONFIG_HUGETLB_PAGE_SIZE_VARIABLE=y
CONFIG_IOMMU_HELPER=y
CONFIG_SWIOTLB=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_HAS_WALK_MEMORY=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
# CONFIG_PPC64_SUPPORTS_MEMORY_FAILURE is not set
CONFIG_KEXEC=y
# CONFIG_CRASH_DUMP is not set
# CONFIG_NUMA is not set
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_SYS_SUPPORTS_HUGETLBFS=y
CONFIG_SELECT_MEMORY_MODEL=y
# CONFIG_FLATMEM_MANUAL is not set
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_GENERIC_RCU_GUP=y
CONFIG_NO_BOOTMEM=y
CONFIG_MEMORY_ISOLATION=y
# CONFIG_HAVE_BOOTMEM_INFO_NODE is not set
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
# CONFIG_BOUNCE is not set
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=65536
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_NEED_PER_CPU_KM=y
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
CONFIG_CMA_DEBUGFS=y
CONFIG_CMA_AREAS=7
# CONFIG_ZSWAP is not set
# CONFIG_ZPOOL is not set
# CONFIG_ZBUD is not set
# CONFIG_ZSMALLOC is not set
CONFIG_ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_PPC_4K_PAGES=y
# CONFIG_PPC_64K_PAGES is not set
CONFIG_FORCE_MAX_ZONEORDER=9
# CONFIG_PPC_COPRO_BASE is not set
# CONFIG_PPC_DENORMALISATION is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_EXTRA_TARGETS=""
# CONFIG_SUSPEND is not set
# CONFIG_HIBERNATION is not set
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
CONFIG_SECCOMP=y
CONFIG_ISA_DMA_API=y

#
# Bus options
#
CONFIG_ZONE_DMA=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_GENERIC_ISA_DMA=y
# CONFIG_PPC_INDIRECT_PCI is not set
# CONFIG_FSL_LBC is not set
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCI_SYSCALL=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIE_ECRC=y
# CONFIG_PCIEAER_INJECT is not set
# CONFIG_PCIEASPM is not set
CONFIG_PCIE_PME=y
# CONFIG_PCIE_DPC is not set
CONFIG_PCI_BUS_ADDR_T_64BIT=y
CONFIG_PCI_MSI=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
CONFIG_PCI_STUB=m
CONFIG_PCI_ATS=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
CONFIG_HOTPLUG_PCI=y
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=m
# CONFIG_HOTPLUG_PCI_RPA is not set

#
# PCI host controller drivers
#
# CONFIG_PCIE_DW_PLAT is not set
# CONFIG_PCCARD is not set
# CONFIG_HAS_RAPIDIO is not set
# CONFIG_RAPIDIO is not set
CONFIG_NONSTATIC_KERNEL=y
CONFIG_RELOCATABLE=y
CONFIG_PAGE_OFFSET=0xc000000000000000
CONFIG_KERNEL_START=0xc000000000000000
CONFIG_PHYSICAL_START=0x00000000
CONFIG_ARCH_RANDOM=y
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_DIAG=m
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=m
CONFIG_XFRM_USER=m
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
# CONFIG_XFRM_STATISTICS is not set
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
# CONFIG_NET_KEY_MIGRATE is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE=y
# CONFIG_IP_MROUTE_MULTIPLE_TABLES is not set
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
CONFIG_NET_FOU=m
# CONFIG_NET_FOU_IP_TUNNELS is not set
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_XFRM_MODE_TRANSPORT=m
CONFIG_INET_XFRM_MODE_TUNNEL=m
CONFIG_INET_XFRM_MODE_BEET=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
# CONFIG_TCP_CONG_DCTCP is not set
# CONFIG_TCP_CONG_CDG is not set
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_INET6_XFRM_MODE_TRANSPORT=m
CONFIG_INET6_XFRM_MODE_TUNNEL=m
CONFIG_INET6_XFRM_MODE_BEET=m
CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_FOU=m
# CONFIG_IPV6_FOU_TUNNEL is not set
CONFIG_IPV6_MULTIPLE_TABLES=y
CONFIG_IPV6_SUBTREES=y
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_NETWORK_SECMARK=y
# CONFIG_NET_PTP_CLASSIFY is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
CONFIG_STP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_HAVE_NET_DSA=y
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
# CONFIG_NET_SCH_CBQ is not set
# CONFIG_NET_SCH_HTB is not set
# CONFIG_NET_SCH_HFSC is not set
# CONFIG_NET_SCH_PRIO is not set
# CONFIG_NET_SCH_MULTIQ is not set
# CONFIG_NET_SCH_RED is not set
# CONFIG_NET_SCH_SFB is not set
# CONFIG_NET_SCH_SFQ is not set
# CONFIG_NET_SCH_TEQL is not set
# CONFIG_NET_SCH_TBF is not set
# CONFIG_NET_SCH_GRED is not set
# CONFIG_NET_SCH_DSMARK is not set
# CONFIG_NET_SCH_NETEM is not set
# CONFIG_NET_SCH_DRR is not set
# CONFIG_NET_SCH_MQPRIO is not set
# CONFIG_NET_SCH_CHOKE is not set
# CONFIG_NET_SCH_QFQ is not set
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=m
# CONFIG_NET_SCH_FQ is not set
# CONFIG_NET_SCH_HHF is not set
# CONFIG_NET_SCH_PIE is not set
# CONFIG_NET_SCH_PLUG is not set

#
# Classification
#
# CONFIG_NET_CLS_BASIC is not set
# CONFIG_NET_CLS_TCINDEX is not set
# CONFIG_NET_CLS_ROUTE4 is not set
# CONFIG_NET_CLS_FW is not set
# CONFIG_NET_CLS_U32 is not set
# CONFIG_NET_CLS_RSVP is not set
# CONFIG_NET_CLS_RSVP6 is not set
# CONFIG_NET_CLS_FLOW is not set
# CONFIG_NET_CLS_CGROUP is not set
# CONFIG_NET_CLS_BPF is not set
# CONFIG_NET_CLS_FLOWER is not set
# CONFIG_NET_EMATCH is not set
# CONFIG_NET_CLS_ACT is not set
CONFIG_NET_SCH_FIFO=y
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=y
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_SOCK_CGROUP_DATA is not set
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_FIB_RULES=y
# CONFIG_WIRELESS is not set
# CONFIG_WIMAX is not set
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
# CONFIG_NET_DEVLINK is not set
CONFIG_MAY_USE_DEVLINK=y
CONFIG_HAVE_CBPF_JIT=y

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
CONFIG_FIRMWARE_IN_KERNEL=y
CONFIG_EXTRA_FIRMWARE=""
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_GENERIC_CPU_DEVICES is not set
# CONFIG_DMA_SHARED_BUFFER is not set

#
# Bus devices
#
CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
# CONFIG_MTD is not set
CONFIG_DTC=y
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_ADDRESS_PCI=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
CONFIG_OF_PCI=y
CONFIG_OF_PCI_IRQ=y
CONFIG_OF_RESERVED_MEM=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SKD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=y
# CONFIG_BLK_DEV_HD is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_BLK_DEV_NVME_SCSI=y

#
# Misc devices
#
# CONFIG_SENSORS_LIS3LV02D is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_PHANTOM is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HP_ILO is not set
# CONFIG_SRAM is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_93CX6 is not set
# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#

#
# Altera FPGA firmware download module
#

#
# Intel MIC Bus Driver
#

#
# SCIF Bus Driver
#

#
# VOP Bus Driver
#

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_CXL_BASE is not set
# CONFIG_CXL_KERNEL_API is not set
# CONFIG_CXL_EEH is not set
CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
# CONFIG_SCSI_NETLINK is not set
# CONFIG_SCSI_MQ_DEFAULT is not set
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
# CONFIG_SCSI_FC_ATTRS is not set
CONFIG_SCSI_ISCSI_ATTRS=m
# CONFIG_SCSI_SAS_ATTRS is not set
# CONFIG_SCSI_SAS_LIBSAS is not set
CONFIG_SCSI_SRP_ATTRS=m
CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_MPT3SAS is not set
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
CONFIG_SCSI_IBMVSCSI=m
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
CONFIG_SCSI_VIRTIO=y
# CONFIG_SCSI_DH is not set
# CONFIG_SCSI_OSD_INITIATOR is not set
CONFIG_ATA=m
# CONFIG_ATA_NONSTANDARD is not set
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_AHCI_CEVA is not set
# CONFIG_AHCI_QORIQ is not set
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
# CONFIG_ATA_SFF is not set
CONFIG_MD=y
# CONFIG_BLK_DEV_MD is not set
CONFIG_BCACHE=m
# CONFIG_BCACHE_DEBUG is not set
# CONFIG_BCACHE_CLOSURES_DEBUG is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
# CONFIG_DM_MQ_DEFAULT is not set
# CONFIG_DM_DEBUG is not set
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_STACK_TRACING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_CACHE_CLEANER=m
# CONFIG_DM_ERA is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
# CONFIG_DM_RAID is not set
CONFIG_DM_FUZZ=m
CONFIG_DM_ZERO=m
# CONFIG_DM_MULTIPATH is not set
CONFIG_DM_DELAY=m
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
# CONFIG_DM_VERITY is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_ISCSI_TARGET=m
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
CONFIG_BONDING=m
CONFIG_DUMMY=m
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=y
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
CONFIG_ETHERNET=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
# CONFIG_NET_VENDOR_AGERE is not set
# CONFIG_NET_VENDOR_ALTEON is not set
# CONFIG_ALTERA_TSE is not set
# CONFIG_NET_VENDOR_AMD is not set
# CONFIG_NET_VENDOR_ARC is not set
# CONFIG_NET_VENDOR_ATHEROS is not set
# CONFIG_NET_VENDOR_AURORA is not set
# CONFIG_NET_CADENCE is not set
# CONFIG_NET_VENDOR_BROADCOM is not set
# CONFIG_NET_VENDOR_BROCADE is not set
# CONFIG_NET_VENDOR_CAVIUM is not set
# CONFIG_NET_VENDOR_CHELSIO is not set
# CONFIG_NET_VENDOR_CISCO is not set
# CONFIG_DNET is not set
# CONFIG_NET_VENDOR_DEC is not set
# CONFIG_NET_VENDOR_DLINK is not set
# CONFIG_NET_VENDOR_EMULEX is not set
# CONFIG_NET_VENDOR_EZCHIP is not set
# CONFIG_NET_VENDOR_EXAR is not set
# CONFIG_NET_VENDOR_HP is not set
# CONFIG_NET_VENDOR_IBM is not set
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
# CONFIG_E1000E is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
# CONFIG_IXGBE is not set
# CONFIG_IXGBEVF is not set
# CONFIG_I40E is not set
# CONFIG_I40EVF is not set
# CONFIG_FM10K is not set
# CONFIG_NET_VENDOR_I825XX is not set
# CONFIG_JME is not set
# CONFIG_NET_VENDOR_MARVELL is not set
# CONFIG_NET_VENDOR_MELLANOX is not set
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MYRI is not set
# CONFIG_FEALNX is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
# CONFIG_NET_VENDOR_NETRONOME is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
# CONFIG_NET_VENDOR_OKI is not set
# CONFIG_ETHOC is not set
# CONFIG_NET_PACKET_ENGINE is not set
# CONFIG_NET_VENDOR_QLOGIC is not set
# CONFIG_NET_VENDOR_QUALCOMM is not set
# CONFIG_NET_VENDOR_REALTEK is not set
# CONFIG_NET_VENDOR_RENESAS is not set
# CONFIG_NET_VENDOR_RDC is not set
# CONFIG_NET_VENDOR_ROCKER is not set
# CONFIG_NET_VENDOR_SAMSUNG is not set
# CONFIG_NET_VENDOR_SEEQ is not set
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
# CONFIG_SFC is not set
# CONFIG_NET_VENDOR_SMSC is not set
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_SUN is not set
# CONFIG_NET_VENDOR_SYNOPSYS is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
# CONFIG_NET_VENDOR_TI is not set
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
# CONFIG_NET_VENDOR_XILINX is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PHYLIB is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_USB_NET_DRIVERS is not set
# CONFIG_WLAN is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
# CONFIG_VMXNET3 is not set
# CONFIG_ISDN is not set
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_POLLDEV=m
CONFIG_INPUT_SPARSEKMAP=m
CONFIG_INPUT_MATRIXKMAP=m

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=m

#
# Input Device Drivers
#
# CONFIG_INPUT_KEYBOARD is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
# CONFIG_SERIO_I8042 is not set
CONFIG_SERIO_SERPORT=m
# CONFIG_SERIO_PCIPS2 is not set
# CONFIG_SERIO_LIBPS2 is not set
# CONFIG_SERIO_RAW is not set
# CONFIG_SERIO_XILINX_XPS_PS2 is not set
# CONFIG_SERIO_ALTERA_PS2 is not set
# CONFIG_SERIO_PS2MULT is not set
# CONFIG_SERIO_ARC_PS2 is not set
# CONFIG_SERIO_APBPS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=0
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_NOZOMI is not set
# CONFIG_N_GSM is not set
# CONFIG_TRACE_SINK is not set
CONFIG_PPC_EPAPR_HV_BYTECHAN=y
CONFIG_PPC_EARLY_DEBUG_EHV_BC=y
CONFIG_PPC_EARLY_DEBUG_EHV_BC_HANDLE=0
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_KGDB_NMI is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_CONSOLE_POLL=y
# CONFIG_SERIAL_ICOM is not set
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
CONFIG_TTY_PRINTK=y
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_CONSOLE=y
# CONFIG_HVC_OLD_HVSI is not set
CONFIG_HVC_RTAS=y
CONFIG_HVC_UDBG=y
CONFIG_HVCS=m
CONFIG_VIRTIO_CONSOLE=y
# CONFIG_IBM_BSR is not set
# CONFIG_IPMI_HANDLER is not set
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_HW_RANDOM_PSERIES=m
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set
# CONFIG_TCG_TPM is not set
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set

#
# I2C support
#
# CONFIG_I2C is not set
# CONFIG_SPI is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set

#
# PPS support
#
# CONFIG_PPS is not set

#
# PPS generators support
#

#
# PTP clock support
#
# CONFIG_PTP_1588_CLOCK is not set

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
# CONFIG_GPIOLIB is not set
# CONFIG_W1 is not set
# CONFIG_POWER_SUPPLY is not set
# CONFIG_POWER_RESET is not set
# CONFIG_POWER_AVS is not set
# CONFIG_HWMON is not set
# CONFIG_THERMAL is not set
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y

#
# Sonics Silicon Backplane
#
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y

#
# Broadcom specific AMBA
#
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
# CONFIG_MFD_CORE is not set
# CONFIG_MFD_ATMEL_FLEXCOM is not set
# CONFIG_MFD_ATMEL_HLCDC is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_HI6421_PMIC is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RTSX_PCI is not set
# CONFIG_MFD_RTSX_USB is not set
# CONFIG_MFD_SM501 is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_TMIO is not set
# CONFIG_MFD_VX855 is not set
# CONFIG_REGULATOR is not set
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
# CONFIG_AGP is not set
# CONFIG_VGA_ARB is not set
# CONFIG_DRM is not set

#
# ACP (Audio CoProcessor) Configuration
#

#
# Frame buffer Devices
#
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
# CONFIG_FB_DDC is not set
# CONFIG_FB_BOOT_VESA_SUPPORT is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
# CONFIG_FB_SYS_FILLRECT is not set
# CONFIG_FB_SYS_COPYAREA is not set
# CONFIG_FB_SYS_IMAGEBLIT is not set
# CONFIG_FB_FOREIGN_ENDIAN is not set
# CONFIG_FB_SYS_FOPS is not set
# CONFIG_FB_SVGALIB is not set
CONFIG_FB_MACMODES=y
# CONFIG_FB_BACKLIGHT is not set
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
CONFIG_FB_CIRRUS=m
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_OF=y
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_BROADSHEET is not set
# CONFIG_FB_AUO_K190X is not set
CONFIG_FB_SIMPLE=y
# CONFIG_FB_SM712 is not set
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
# CONFIG_VGASTATE is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=64
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_LOGO is not set
# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=m
# CONFIG_HID_BATTERY_STRENGTH is not set
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=m

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
# CONFIG_HID_ACRUX is not set
# CONFIG_HID_APPLE is not set
# CONFIG_HID_APPLEIR is not set
# CONFIG_HID_AUREAL is not set
# CONFIG_HID_BELKIN is not set
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_CHERRY is not set
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CYPRESS is not set
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELECOM is not set
# CONFIG_HID_ELO is not set
# CONFIG_HID_EZKEY is not set
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
# CONFIG_HID_UCLOGIC is not set
# CONFIG_HID_WALTOP is not set
# CONFIG_HID_GYRATION is not set
# CONFIG_HID_ICADE is not set
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
# CONFIG_HID_LCPOWER is not set
# CONFIG_HID_LENOVO is not set
# CONFIG_HID_LOGITECH is not set
# CONFIG_HID_MAGICMOUSE is not set
# CONFIG_HID_MICROSOFT is not set
# CONFIG_HID_MONTEREY is not set
# CONFIG_HID_MULTITOUCH is not set
# CONFIG_HID_NTRIG is not set
# CONFIG_HID_ORTEK is not set
# CONFIG_HID_PANTHERLORD is not set
# CONFIG_HID_PENMOUNT is not set
# CONFIG_HID_PETALYNX is not set
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PLANTRONICS is not set
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_ROCCAT is not set
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SAMSUNG is not set
# CONFIG_HID_SPEEDLINK is not set
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
# CONFIG_HID_RMI is not set
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_SMARTJOYPLUS is not set
# CONFIG_HID_TIVO is not set
# CONFIG_HID_TOPSEED is not set
# CONFIG_HID_THRUSTMASTER is not set
# CONFIG_HID_WACOM is not set
# CONFIG_HID_XINMO is not set
# CONFIG_HID_ZEROPLUS is not set
# CONFIG_HID_ZYDACRON is not set
# CONFIG_HID_SENSOR_HUB is not set

#
# USB HID support
#
CONFIG_USB_HID=m
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y

#
# USB HID Boot Protocol drivers
#
CONFIG_USB_KBD=m
CONFIG_USB_MOUSE=m
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
CONFIG_USB_DYNAMIC_MINORS=y
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_MON is not set
# CONFIG_USB_WUSB_CBAF is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=m
CONFIG_USB_XHCI_PCI=m
# CONFIG_USB_XHCI_PLATFORM is not set
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_ISP1362_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
# CONFIG_USB_UHCI_HCD is not set
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
CONFIG_USB_UAS=m

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set

#
# USB Physical Layer drivers
#
# CONFIG_USB_PHY is not set
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GADGET is not set
# CONFIG_UWB is not set
# CONFIG_MMC is not set
# CONFIG_MEMSTICK is not set
# CONFIG_NEW_LEDS is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
# CONFIG_EDAC is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
# CONFIG_RTC_DEBUG is not set

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#

#
# SPI RTC drivers
#

#
# SPI and I2C RTC drivers
#

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
# CONFIG_RTC_DRV_DS1286 is not set
# CONFIG_RTC_DRV_DS1511 is not set
# CONFIG_RTC_DRV_DS1553 is not set
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
# CONFIG_RTC_DRV_DS1742 is not set
# CONFIG_RTC_DRV_DS2404 is not set
# CONFIG_RTC_DRV_STK17TA8 is not set
# CONFIG_RTC_DRV_M48T86 is not set
# CONFIG_RTC_DRV_M48T35 is not set
# CONFIG_RTC_DRV_M48T59 is not set
# CONFIG_RTC_DRV_MSM6242 is not set
# CONFIG_RTC_DRV_BQ4802 is not set
# CONFIG_RTC_DRV_RP5C01 is not set
# CONFIG_RTC_DRV_V3020 is not set
# CONFIG_RTC_DRV_ZYNQMP is not set

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_GENERIC is not set
# CONFIG_RTC_DRV_SNVS is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
# CONFIG_SYNC_FILE is not set
# CONFIG_AUXDISPLAY is not set
# CONFIG_UIO is not set
# CONFIG_VFIO is not set
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y

#
# Virtio drivers
#
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_INPUT=y
CONFIG_VIRTIO_MMIO=m
CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y

#
# Microsoft Hyper-V guest support
#
# CONFIG_STAGING is not set

#
# Hardware Spinlock drivers
#

#
# Clock Source drivers
#
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# CONFIG_ATMEL_PIT is not set
# CONFIG_SH_TIMER_CMT is not set
# CONFIG_SH_TIMER_MTU2 is not set
# CONFIG_SH_TIMER_TMU is not set
# CONFIG_EM_TIMER_STI is not set
# CONFIG_MAILBOX is not set
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
CONFIG_OF_IOMMU=y
CONFIG_SPAPR_TCE_IOMMU=y

#
# Remoteproc drivers
#
# CONFIG_STE_MODEM_RPROC is not set

#
# Rpmsg drivers
#

#
# SOC (System On Chip) specific Drivers
#
# CONFIG_SUNXI_SRAM is not set
# CONFIG_SOC_TI is not set
# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
# CONFIG_PWM is not set
CONFIG_IRQCHIP=y
CONFIG_ARM_GIC_MAX_NR=1
# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set
# CONFIG_FMC is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_POWERCAP is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
CONFIG_RAS=y
# CONFIG_THUNDERBOLT is not set

#
# Android
#
# CONFIG_ANDROID is not set
CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_BLK=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_DEV_DAX=m
CONFIG_NVMEM=m
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set

#
# FPGA Configuration Support
#
# CONFIG_FPGA is not set

#
# File systems
#
CONFIG_EXT2_FS=m
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
CONFIG_EXT3_FS=m
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_EXT4_FS=m
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_ENCRYPTION is not set
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=m
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=m
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_WARN=y
# CONFIG_XFS_DEBUG is not set
# CONFIG_GFS2_FS is not set
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
CONFIG_F2FS_FS_SECURITY=y
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FS_ENCRYPTION is not set
# CONFIG_F2FS_IO_TRACE is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
CONFIG_FS_DAX=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
# CONFIG_PRINT_QUOTA_WARNING is not set
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=m
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=m
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=m
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
CONFIG_OVERLAY_FS=m

#
# Caches
#
# CONFIG_FSCACHE is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
# CONFIG_PROC_CHILDREN is not set
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_CONFIGFS_FS=m
CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_LOGFS is not set
# CONFIG_CRAMFS is not set
# CONFIG_SQUASHFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_PSTORE is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=m
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_USE_LEGACY_DNS=y
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
CONFIG_NFSD_BLOCKLAYOUT=y
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FAULT_INJECTION is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_MAC_ROMAN is not set
# CONFIG_NLS_MAC_CELTIC is not set
# CONFIG_NLS_MAC_CENTEURO is not set
# CONFIG_NLS_MAC_CROATIAN is not set
# CONFIG_NLS_MAC_CYRILLIC is not set
# CONFIG_NLS_MAC_GAELIC is not set
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
# CONFIG_NLS_MAC_ROMANIAN is not set
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=m
# CONFIG_DLM is not set
CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_BITREVERSE=y
# CONFIG_HAVE_ARCH_BITREVERSE is not set
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IO=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_CRC_CCITT=m
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
# CONFIG_AUDIT_ARCH_COMPAT_GENERIC is not set
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=m
CONFIG_LZO_DECOMPRESS=m
CONFIG_XZ_DEC=y
# CONFIG_XZ_DEC_X86 is not set
CONFIG_XZ_DEC_POWERPC=y
# CONFIG_XZ_DEC_IA64 is not set
# CONFIG_XZ_DEC_ARM is not set
# CONFIG_XZ_DEC_ARMTHUMB is not set
# CONFIG_XZ_DEC_SPARC is not set
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=m
CONFIG_DECOMPRESS_GZIP=y
CONFIG_INTERVAL_TREE=y
CONFIG_RADIX_TREE_MULTIORDER=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE=y
CONFIG_CLZ_TAB=y
# CONFIG_CORDIC is not set
# CONFIG_DDR is not set
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_FONT_SOURCECODEPRO=y
# CONFIG_SG_SPLIT is not set
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_SG_CHAIN=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_DYNAMIC_DEBUG is not set

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_GDB_SCRIPTS is not set
# CONFIG_ENABLE_WARN_DEPRECATED is not set
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=1024
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
CONFIG_UNUSED_SYMBOLS=y
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=y
# CONFIG_HEADERS_CHECK is not set
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_MEMORY_INIT is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
CONFIG_WQ_WATCHDOG=y
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_TIMEKEEPING is not set
CONFIG_TIMER_STATS=y
CONFIG_DEBUG_PREEMPT=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_ATOMIC_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_STACKTRACE=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_PI_LIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
# CONFIG_PROVE_RCU is not set
# CONFIG_SPARSE_RCU_POINTER is not set
# CONFIG_TORTURE_TEST is not set
# CONFIG_RCU_PERF_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT is not set
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
# CONFIG_FAULT_INJECTION is not set
CONFIG_LATENCYTOP=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_PREEMPT_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_STACK_TRACER=y
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_UPROBE_EVENT=y
CONFIG_BPF_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_FTRACE_MCOUNT_RECORD=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_HIST_TRIGGERS is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_TRACE_ENUM_MAP_FILE is not set

#
# Runtime Testing
#
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
CONFIG_RBTREE_TEST=m
CONFIG_INTERVAL_TREE_TEST=m
CONFIG_PERCPU_TEST=m
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_TEST_HEXDUMP is not set
CONFIG_TEST_STRING_HELPERS=m
CONFIG_TEST_KSTRTOX=m
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_USER_COPY is not set
# CONFIG_TEST_BPF is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_MEMTEST is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
CONFIG_KGDB=y
CONFIG_KGDB_SERIAL_CONSOLE=y
# CONFIG_KGDB_TESTS is not set
CONFIG_KGDB_KDB=y
CONFIG_KDB_DEFAULT_ENABLE=0x1
CONFIG_KDB_KEYBOARD=y
CONFIG_KDB_CONTINUE_CATASTROPHIC=0
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set
CONFIG_PPC_DISABLE_WERROR=y
CONFIG_PRINT_STACK_DEPTH=64
# CONFIG_HCALL_STATS is not set
# CONFIG_PPC_EMULATED_STATS is not set
# CONFIG_CODE_PATCHING_SELFTEST is not set
# CONFIG_FTR_FIXUP_SELFTEST is not set
# CONFIG_MSI_BITMAP_SELFTEST is not set
# CONFIG_XMON is not set
CONFIG_DEBUGGER=y
CONFIG_BOOTX_TEXT=y
CONFIG_PPC_EARLY_DEBUG=y
# CONFIG_PPC_EARLY_DEBUG_BOOTX is not set
CONFIG_PPC_EARLY_DEBUG_LPAR=y
# CONFIG_PPC_EARLY_DEBUG_LPAR_HVSI is not set
# CONFIG_PPC_EARLY_DEBUG_RTAS_PANEL is not set
# CONFIG_PPC_EARLY_DEBUG_RTAS_CONSOLE is not set
# CONFIG_PPC_EARLY_DEBUG_MEMCONS is not set

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_BIG_KEYS is not set
# CONFIG_ENCRYPTED_KEYS is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
CONFIG_SECURITYFS=y
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
CONFIG_KEYS_COMPAT=y
CONFIG_XOR_BLOCKS=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=m
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=m
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=m
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
# CONFIG_CRYPTO_RSA is not set
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=m
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_MCRYPTD=m
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=m
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_SEQIV=m
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CTR=m
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
# CONFIG_CRYPTO_KEYWRAP is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_GHASH=m
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MD5_PPC=m
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_RMD128 is not set
# CONFIG_CRYPTO_RMD160 is not set
# CONFIG_CRYPTO_RMD256 is not set
# CONFIG_CRYPTO_RMD320 is not set
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_PPC=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_ANUBIS is not set
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_CAMELLIA is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_SALSA20 is not set
# CONFIG_CRYPTO_CHACHA20 is not set
# CONFIG_CRYPTO_SEED is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_TWOFISH is not set

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=m
# CONFIG_CRYPTO_LZO is not set
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=m
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=m
CONFIG_CRYPTO_JITTERENTROPY=m
CONFIG_CRYPTO_USER_API=m
CONFIG_CRYPTO_USER_API_HASH=m
CONFIG_CRYPTO_USER_API_SKCIPHER=m
CONFIG_CRYPTO_USER_API_RNG=m
CONFIG_CRYPTO_USER_API_AEAD=m
CONFIG_CRYPTO_HASH_INFO=y
# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS7_MESSAGE_PARSER is not set

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
# CONFIG_VIRTUALIZATION is not set

--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dpkg

Package: qemu-system-ppc
Status: install ok installed
Priority: optional
Section: otherosfs
Installed-Size: 25674
Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
Architecture: amd64
Multi-Arch: foreign
Source: qemu
Version: 1:2.5+dfsg-5ubuntu10.1
Replaces: kvm (<< 1.3.0+dfsg-5), qemu-common (<< 1.3.0+dfsg-5), qemu-kvm (<< 1.2.0.dfsg-1), qemu-system (<< 1.3.0+dfsg-5)
Provides: qemu-system-ppc64, qemu-system-ppcemb
Depends: libaio1 (>= 0.3.93), libasound2 (>= 1.0.16), libbluetooth3 (>= 4.91), libbrlapi0.6, libc6 (>= 2.15), libcacard0 (>= 2.2), libfdt1, libgcc1 (>= 1:3.4), libglib2.0-0 (>= 2.31.8), libgnutls30 (>= 3.4.2), libjpeg8 (>= 8c), libncurses5 (>= 6), libnettle6, libnuma1, libpixman-1-0 (>= 0.19.6), libpng12-0 (>= 1.2.13-4), libpulse0 (>= 0.99.1), libsasl2-2, libsdl1.2debian (>= 1.2.11), libseccomp2 (>= 0.0.0~20120605), libspice-server1 (>= 0.12.5), libtinfo5 (>= 6), libusb-1.0-0 (>= 2:1.0.19), libusbredirparser1 (>= 0.6), libuuid1 (>= 2.16), libx11-6, libxen-4.6 (>= 4.6.0), libxenstore3.0 (>= 3.2.0), zlib1g (>= 1:1.2.0), qemu-system-common (>> 2.0.0+dfsg-7~), qemu-slof
Recommends: qemu-utils, seabios, ipxe-qemu (>= 1.0.0+git-20131111.c3d1e78-1~)
Suggests: samba, vde2, qemu-block-extra (= 1:2.5+dfsg-5ubuntu10.1), openbios-ppc (>= 1.1+svn1229), openhackware
Breaks: kvm (<< 1.3.0+dfsg-5), qemu-common (<< 1.3.0+dfsg-5), qemu-kvm (<< 1.2.0.dfsg-1), qemu-system (<< 1.3.0+dfsg-5)
Description: QEMU full system emulation binaries (ppc)
 QEMU is a fast processor emulator: currently the package supports
 PowerPC emulation. By using dynamic translation it achieves
 reasonable speed while being easy to port on new host CPUs.
 .
 This package provides the full system emulation binaries to emulate
 the following PowerPC hardware: ppc ppcemb ppc64.
 .
 In system emulation mode QEMU emulates a full system, including a processor
 and various peripherals.  It enables easier testing and debugging of system
 code.  It can also be used to provide virtual hosting of several virtual
 machines on a single server.
Homepage: http://www.qemu.org/
Original-Maintainer: Debian QEMU Team <pkg-qemu-devel@lists.alioth.debian.org>

Package: qemu-slof
Status: install ok installed
Priority: extra
Section: misc
Installed-Size: 906
Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
Architecture: all
Multi-Arch: foreign
Source: slof
Version: 20151103+dfsg-1ubuntu1
Suggests: qemu
Description: Slimline Open Firmware -- QEMU PowerPC version
 Slimline Open Firmware (SLOF) is an implementation of the IEEE 1275
 standard. It can be used as partition firmware for pSeries machines
 running on QEMU or KVM.
Homepage: https://github.com/aik/SLOF
Original-Maintainer: Debian QEMU Team <pkg-qemu-devel@lists.alioth.debian.org>

--8t9RHnE3ZwKMSgU+--
