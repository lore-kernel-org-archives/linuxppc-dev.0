Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41902f44hRzF0Tn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 17:29:14 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: Constant ata messages on console with commit 28361c403683
 ("libata: add extra internal command") (was Re: [GIT PULL 2/2] libata changes
 for v4.18-rc1)
In-Reply-To: <ddef9feb-2764-6959-3a36-e97fbe377931@kernel.dk>
References: <20180605190807.GE1351649@devbig577.frc2.facebook.com>
 <20180605191525.GF1351649@devbig577.frc2.facebook.com>
 <87bmc8a6qi.fsf@concordia.ellerman.id.au>
 <ddef9feb-2764-6959-3a36-e97fbe377931@kernel.dk>
Date: Tue, 19 Jun 2018 17:29:12 +1000
Message-ID: <87sh5jxmif.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-=-=
Content-Type: text/plain

Jens Axboe <axboe@kernel.dk> writes:
> On 6/18/18 1:33 AM, Michael Ellerman wrote:
>> Tejun Heo <tj@kernel.org> writes:
>> ...
>>> Jens Axboe (10):
>>>       libata: introduce notion of separate hardware tags
>>>       libata: convert core and drivers to ->hw_tag usage
>>>       libata: bump ->qc_active to a 64-bit type
>>>       libata: use ata_tag_internal() consistently
>>>       libata: remove assumption that ATA_MAX_QUEUE - 1 is the max
>>>       sata_nv: set host can_queue count appropriately
>>>       libata: add extra internal command
>> 
>> Replying here because I can't find the original mail.
>> 
>> The above commit is causing one of my machines to constantly spew ata
>> messages on the console, according to bisect:
>> 
>> # first bad commit: [28361c403683c2b00d4f5e76045f3ccd299bf99d] libata: add extra internal command
>> 
>> To get it to boot I have to also apply:
>> 
>>   88e10092f6a6 ("sata_fsl: use the right type for tag bitshift")
>> 
>> 
>> The system boots OK and seems fine, except that it's just printing
>> multiple of these per second:
>> 
>>   ata2: Signature Update detected @ 0 msecs
>>   ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>   ata2.00: configured for UDMA/100
>>   ata2: Signature Update detected @ 0 msecs
>>   ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>   ata2.00: configured for UDMA/100
>>   ata2: Signature Update detected @ 0 msecs
>>   ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>   ata2.00: configured for UDMA/100
>>   ata2: Signature Update detected @ 0 msecs
>>   ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>   ata2.00: configured for UDMA/100
>>   ata2: Signature Update detected @ 0 msecs
>> 
>> And it never seems to stop.
>> 
>> The machine is a Freescale/NXP P5020ds, using the sata_fsl driver
>> presumably. Any ideas?
>
> Hmm that's odd. Can you include the boot log from a working boot as
> well? Would be nice to see what devices are on the sata adapter.
> The above just looks like a hardreset loop.

Ah yep. I stupidly assumed it was working, because the machine booted,
but that's because the root disk is on ata1.

Booting the good kernel:

  ba80c3a572f4 ("sata_nv: set host can_queue count appropriately")

I see:

  root@p5020ds:~# ls -l /sys/class/ata_port/
  total 0
  lrwxrwxrwx 1 root root 0 Jun 19 06:49 ata1 -> ../../devices/platform/ffe000000.soc/ffe220000.sata/ata1/ata_port/ata1
  lrwxrwxrwx 1 root root 0 Jun 19 17:06 ata2 -> ../../devices/platform/ffe000000.soc/ffe221000.sata/ata2/ata_port/ata2

  root@p5020ds:~# ls -l /sys/class/block/ | grep ata
  lrwxrwxrwx 1 root root 0 Jun 19 17:11 sda -> ../../devices/platform/ffe000000.soc/ffe220000.sata/ata1/host0/target0:0:0/0:0:0:0/block/sda
  lrwxrwxrwx 1 root root 0 Jun 19 17:11 sda1 -> ../../devices/platform/ffe000000.soc/ffe220000.sata/ata1/host0/target0:0:0/0:0:0:0/block/sda/sda1
  lrwxrwxrwx 1 root root 0 Jun 19 17:11 sda2 -> ../../devices/platform/ffe000000.soc/ffe220000.sata/ata1/host0/target0:0:0/0:0:0:0/block/sda/sda2
  lrwxrwxrwx 1 root root 0 Jun 19 17:11 sda5 -> ../../devices/platform/ffe000000.soc/ffe220000.sata/ata1/host0/target0:0:0/0:0:0:0/block/sda/sda5
  lrwxrwxrwx 1 root root 0 Jun 19 17:11 sr0 -> ../../devices/platform/ffe000000.soc/ffe221000.sata/ata2/host1/target1:0:0/1:0:0:0/block/sr0

So it's the DVD drive.

  root@p5020ds:/sys/devices/platform/ffe000000.soc/ffe221000.sata/ata2/host1/target1:0:0/1:0:0:0/scsi_device/1:0:0:0/device# cat vendor 
  Optiarc 
  root@p5020ds:/sys/devices/platform/ffe000000.soc/ffe221000.sata/ata2/host1/target1:0:0/1:0:0:0/scsi_device/1:0:0:0/device# cat model
  DVD RW AD-7260S 


Full boot log from a good boot attached if that's helpful.

All of the above looks the same when I boot with the broken setup, it
just spams dmesg constantly.

One thing that is different, on the good kernel I see:

  root@p5020ds:~# mount /dev/sr0 /mnt
  mount: no medium found on /dev/sr0

vs bad (88e10092f6a6):

  root@p5020ds:~# mount /dev/sr0 /mnt
  mount: /dev/sr0 is already mounted or /mnt busy

cheers


--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=good-boot.txt
Content-Transfer-Encoding: quoted-printable

U-Boot 2015.04-rc2-00081-g47d8ae4-dirty (Feb 26 2015 - 15:10:42)

CPU0:  P5020E, Version: 2.0, (0x82280020)
Core:  e5500, Version: 1.2, (0x80240012)
Clock Configuration:
       CPU0:2000 MHz, CPU1:2000 MHz,=20
       CCB:800  MHz,
       DDR:666.667 MHz (1333.333 MT/s data rate) (Asynchronous), LBC:100  M=
Hz
       FMAN1: 600 MHz
       QMAN:  400 MHz
       PME:   400 MHz
L1:    D-cache 32 KiB enabled
       I-cache 32 KiB enabled
Reset Configuration Word (RCW):
       00000000: 0c540000 00000000 1e120000 00000000
       00000010: d8984a01 03002000 58000000 41000000
       00000020: 00000000 00000000 00000000 10070000
       00000030: 00000000 00000000 00000000 00000000
Board: P5020DS, Sys ID: 0x1c, Sys Ver: 0x12, FPGA Ver: 0x05, vBank: 0
SERDES Reference Clocks: Bank1=3D100Mhz Bank2=3D125Mhz Bank3=3D125Mhz=20
I2C:   ready
SPI:   ready
DRAM:  Initializing....using SPD
Detected UDIMM i-DIMM
Detected UDIMM i-DIMM
2 GiB left unmapped
Testing 0x00000000 - 0x7fffffff
Testing 0x80000000 - 0xffffffff
Remap DDR 2 GiB left unmapped

4 GiB (DDR3, 64-bit, CL=3D9, ECC on)
       DDR Controller Interleaving Mode: cache line
       DDR Chip-Select Interleaving Mode: CS0+CS1
POST memory PASSED
Flash: 128 MiB
L2:    512 KiB enabled
Corenet Platform Cache: 2 MiB enabled
SRIO1: disabled
SRIO2: disabled
NAND:  1024 MiB
MMC:   FSL_SDHC: 0
SF: Detected S25FL128S_64K with page size 256 Bytes, erase size 64 KiB, tot=
al 16 MiB
EEPROM: CRC mismatch (56e8e0ae !=3D ffffffff)
PCIe1: Root Complex, no link, regs @ 0xfe200000
PCIe1: Bus 00 - 00
PCIe2: disabled
PCIe3: Root Complex, x2 gen1, regs @ 0xfe202000
  02:00.0     - 8086:105e - Network controller
  02:00.1     - 8086:105e - Network controller
PCIe3: Bus 01 - 02
PCIe4: disabled
In:    serial
Out:   serial
Err:   serial
Net:   Initializing Fman
SF: Detected S25FL128S_64K with page size 256 Bytes, erase size 64 KiB, tot=
al 16 MiB
Fman1: Data at 7fdf7f90 is not a firmware
e1000: 00:15:17:54:a8:b2
       e1000: 00:15:17:54:a8:b3
       e1000#0, e1000#1
Hit any key to stop autoboot:  0=20
Using e1000#0 device
TFTP from server 10.61.2.7; our IP address is 10.61.200.147
Filename 'p5020ds/uImage'.
Load address: 0x1000000
Loading: #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 ##############################################################
	 13.6 MiB/s
done
Bytes transferred =3D 6634161 (653ab1 hex)
Using e1000#0 device
TFTP from server 10.61.2.7; our IP address is 10.61.200.147
Filename 'p5020ds/p5020ds.dtb'.
Load address: 0xc000000
Loading: ###
	 6.2 MiB/s
done
Bytes transferred =3D 32322 (7e42 hex)
WARNING: adjusting available memory to 30000000
## Booting kernel from Legacy Image at 01000000 ...
   Image Name:   Linux-4.17.0-rc4-gcc-7.0.1-00013
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    6634097 Bytes =3D 6.3 MiB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
## Flattened Device Tree blob at 0c000000
   Booting using the fdt blob at 0xc000000
   Uncompressing Kernel Image ... OK
   Loading Device Tree to 03fe5000, end 03fffe41 ... OK
OF: reserved mem: initialized node qman-fqd, compatible id fsl,qman-fqd
OF: reserved mem: initialized node qman-pfdr, compatible id fsl,qman-pfdr
OF: reserved mem: initialized node bman-fbpr, compatible id fsl,bman-fbpr
MMU: Supported page sizes
         4 KB as direct
      4096 KB as direct
     16384 KB as direct
     65536 KB as direct
    262144 KB as direct
   1048576 KB as direct
MMU: Book3E HW tablewalk not supported
Linux version 4.17.0-rc4-gcc-7.0.1-00013-gba80c3a572f4 (michael@ka3.ozlabs.=
ibm.com) (gcc version 7.0.1 20170213 (experimental) (Custom 8e8a14c238db56c=
7)) #166 SMP Mon Jun 18 17:31:54 AEST 2018
Using CoreNet Generic machine description
bootconsole [udbg0] enabled
CPU maps initialized for 1 thread per core
-----------------------------------------------------
phys_mem_size     =3D 0x100000000
dcache_bsize      =3D 0x40
icache_bsize      =3D 0x40
cpu_features      =3D 0x00000003008003b4
  possible        =3D 0x00000003009003b6
  always          =3D 0x00000003008003b4
cpu_user_features =3D 0xcc008000 0x08000000
mmu_features      =3D 0x000a0010
firmware_features =3D 0x0000000000000000
-----------------------------------------------------
CoreNet Generic board
Zone ranges:
  DMA      [mem 0x0000000000000000-0x000000007fffffff]
  DMA32    empty
  Normal   [mem 0x0000000080000000-0x00000000ffffffff]
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000000000000-0x00000000ffffffff]
Initmem setup node 0 [mem 0x0000000000000000-0x00000000ffffffff]
MMU: Allocated 2112 bytes of context maps for 255 contexts
percpu: Embedded 22 pages/cpu @        (ptrval) s51416 r0 d38696 u524288
Built 1 zonelists, mobility grouping on.  Total pages: 1034240
Kernel command line: root=3D/dev/sda1 rw console=3DttyS0,115200
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Memory: 3995012K/4194304K available (9988K kernel code, 1964K rwdata, 3212K=
 rodata, 524K init, 306K bss, 199292K reserved, 0K cma-reserved)
SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D2, Nodes=3D1
Hierarchical RCU implementation.
	RCU event tracing is enabled.
	RCU restricting CPUs from NR_CPUS=3D24 to nr_cpu_ids=3D2.
RCU: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=3D2
NR_IRQS: 512, nr_irqs: 512, preallocated irqs: 16
mpic: Setting up MPIC " OpenPIC  " version 1.2 at ffe040000, max 2 CPUs
mpic: ISU size: 512, shift: 9, mask: 1ff
mpic: Initializing for 512 sources
clocksource: timebase: mask: 0xffffffffffffffff max_cycles: 0x5c40939b5, ma=
x_idle_ns: 440795202646 ns
clocksource: timebase mult[28000000] shift[24] registered
Console: colour dummy device 80x25
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes)
e500 family performance monitor hardware support registered
Hierarchical SRCU implementation.
smp: Bringing up secondary CPUs ...
smp: Brought up 1 node, 2 CPUs
Using standard scheduler topology
devtmpfs: initialized
random: get_random_u32 called from .bucket_table_alloc+0x9c/0x22c with crng=
_init=3D0
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns:=
 7645041785100000 ns
futex hash table entries: 512 (order: 3, 32768 bytes)
NET: Registered protocol family 16
audit: initializing netlink subsys (disabled)
audit: type=3D2000 audit(0.044:1): state=3Dinitialized audit_enabled=3D0 re=
s=3D1
Machine: fsl,P5020DS
SoC family: QorIQ
SoC ID: svr:0x82280020, Revision: 2.0
Found FSL PCI host bridge at 0x0000000ffe200000. Firmware bus number: 0->0
PCI host bridge /pcie@ffe200000  ranges:
 MEM 0x0000000c00000000..0x0000000c1fffffff -> 0x00000000e0000000=20
  IO 0x0000000ff8000000..0x0000000ff800ffff -> 0x0000000000000000
/pcie@ffe200000: PCICSRBAR @ 0xdf000000
setup_pci_atmu: end of DRAM 100000000
/pcie@ffe200000: Setup 64-bit PCI DMA window
/pcie@ffe200000: DMA window size is 0xdf000000
Found FSL PCI host bridge at 0x0000000ffe202000. Firmware bus number: 0->1
PCI host bridge /pcie@ffe202000  ranges:
 MEM 0x0000000c40000000..0x0000000c5fffffff -> 0x00000000e0000000=20
  IO 0x0000000ff8020000..0x0000000ff802ffff -> 0x0000000000000000
/pcie@ffe202000: PCICSRBAR @ 0xdf000000
setup_pci_atmu: end of DRAM 100000000
/pcie@ffe202000: Setup 64-bit PCI DMA window
/pcie@ffe202000: DMA window size is 0xdf000000
iommu: Adding device ff4200000.qman-portal to group 0
iommu: Adding device ff4204000.qman-portal to group 1
iommu: Adding device ff4208000.qman-portal to group 2
iommu: Adding device ff420c000.qman-portal to group 3
iommu: Adding device ff4210000.qman-portal to group 4
iommu: Adding device ff4214000.qman-portal to group 5
iommu: Adding device ff4218000.qman-portal to group 6
iommu: Adding device ff421c000.qman-portal to group 7
iommu: Adding device ff4220000.qman-portal to group 8
iommu: Adding device ff4224000.qman-portal to group 9
iommu: Adding device ffe100300.dma to group 10
iommu: Adding device ffe101300.dma to group 11
iommu: Adding device ffe114000.sdhc to group 12
iommu: Adding device ffe210000.usb to group 13
iommu: Adding device ffe211000.usb to group 14
iommu: Adding device ffe220000.sata to group 15
iommu: Adding device ffe221000.sata to group 16
iommu: Adding device ffe318000.qman to group 17
iommu: Adding device ffe31a000.bman to group 18
iommu: Adding device ffe200000.pcie to group 19
iommu: Adding device ffe202000.pcie to group 20
software IO TLB [mem 0xf4800000-0xf8800000] (64MB) mapped at [        (ptrv=
al)-        (ptrval)]
PCI: Probing PCI hardware
fsl-pci ffe200000.pcie: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x8000080000010000-0x800008000001ff=
ff] (bus address [0x0000-0xffff])
pci_bus 0000:00: root bus resource [mem 0xc00000000-0xc1fffffff] (bus addre=
ss [0xe0000000-0xffffffff])
pci_bus 0000:00: root bus resource [bus 00]
iommu: Removing device ffe200000.pcie from group 19
iommu: Adding device 0000:00:00.0 to group 19
pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:00:00.0: PCI bridge to [bus 01-ff]
fsl-pci ffe202000.pcie: PCI host bridge to bus 2000:00
pci_bus 2000:00: root bus resource [io  0x8000080000021000-0x8000080000030f=
ff] (bus address [0x0000-0xffff])
pci_bus 2000:00: root bus resource [mem 0xc40000000-0xc5fffffff] (bus addre=
ss [0xe0000000-0xffffffff])
pci_bus 2000:00: root bus resource [bus 00-01]
iommu: Removing device ffe202000.pcie from group 20
iommu: Adding device 2000:00:00.0 to group 20
iommu: Adding device 2000:01:00.0 to group 20
iommu: Adding device 2000:01:00.1 to group 20
pci 2000:00:00.0: PCI bridge to [bus 01-ff]
PCI: Cannot allocate resource region 0 of device 0000:00:00.0, will remap
PCI: Cannot allocate resource region 0 of device 2000:00:00.0, will remap
pci 0000:00:00.0: BAR 0: no space for [mem size 0x01000000]
pci 0000:00:00.0: BAR 0: failed to assign [mem size 0x01000000]
pci 0000:00:00.0: PCI bridge to [bus 01]
pci 0000:00:00.0:   bridge window [io  0x8000080000010000-0x800008000001fff=
f]
pci 0000:00:00.0:   bridge window [mem 0xc00000000-0xc1fffffff]
pci_bus 0000:00: Some PCI device resources are unassigned, try booting with=
 pci=3Drealloc
pci 2000:00:00.0: BAR 0: no space for [mem size 0x01000000]
pci 2000:00:00.0: BAR 0: failed to assign [mem size 0x01000000]
pci 2000:01:00.0: BAR 6: assigned [mem 0xc40080000-0xc4009ffff pref]
pci 2000:01:00.1: BAR 6: assigned [mem 0xc400a0000-0xc400bffff pref]
pci 2000:00:00.0: PCI bridge to [bus 01]
pci 2000:00:00.0:   bridge window [io  0x8000080000021000-0x8000080000030ff=
f]
pci 2000:00:00.0:   bridge window [mem 0xc40000000-0xc5fffffff]
pci_bus 2000:00: Some PCI device resources are unassigned, try booting with=
 pci=3Drealloc
HugeTLB registered 4.00 MiB page size, pre-allocated 0 pages
HugeTLB registered 16.0 MiB page size, pre-allocated 0 pages
HugeTLB registered 64.0 MiB page size, pre-allocated 0 pages
HugeTLB registered 256 MiB page size, pre-allocated 0 pages
HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
Freescale Elo series DMA driver
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
Advanced Linux Sound Architecture Driver Initialized.
clocksource: Switched to clocksource timebase
NET: Registered protocol family 2
tcp_listen_portaddr_hash hash table entries: 2048 (order: 3, 32768 bytes)
TCP established hash table entries: 32768 (order: 6, 262144 bytes)
TCP bind hash table entries: 32768 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
UDP hash table entries: 2048 (order: 4, 65536 bytes)
UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
workingset: timestamp_bits=3D62 max_order=3D20 bucket_order=3D0
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
ntfs: driver 2.1.32 [Flags: R/O].
jffs2: version 2.2. (NAND) =C2=A9 2001-2006 Red Hat, Inc.
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
io scheduler mq-deadline registered
io scheduler kyber registered
pcieport 0000:00:00.0: AER enabled with IRQ 482
pcieport 2000:00:00.0: AER enabled with IRQ 480
bman_portal ff4000000.bman-portal: Portal initialised, cpu 0
bman_portal ff4004000.bman-portal: Portal initialised, cpu 1
qman_portal ff4200000.qman-portal: Portal initialised, cpu 0
qman_portal ff4204000.qman-portal: Portal initialised, cpu 1
Serial: 8250/16550 driver, 6 ports, IRQ sharing enabled
console [ttyS0] disabled
serial8250.0: ttyS0 at MMIO 0xffe11c500 (irq =3D 36, base_baud =3D 24999999=
) is a 16550A
console [ttyS0] enabled
console [ttyS0] enabled
bootconsole [udbg0] disabled
bootconsole [udbg0] disabled
serial8250.0: ttyS1 at MMIO 0xffe11c600 (irq =3D 36, base_baud =3D 24999999=
) is a 16550A
serial8250.0: ttyS2 at MMIO 0xffe11d500 (irq =3D 37, base_baud =3D 24999999=
) is a 16550A
serial8250.0: ttyS3 at MMIO 0xffe11d600 (irq =3D 37, base_baud =3D 24999999=
) is a 16550A
ePAPR hypervisor byte channel driver
brd: module loaded
loop: module loaded
st: Version 20160209, fixed bufsize 32768, s/g segs 256
fsl-sata ffe220000.sata: Sata FSL Platform/CSB Driver init
scsi host0: sata_fsl
ata1: SATA max UDMA/133 irq 68
fsl-sata ffe221000.sata: Sata FSL Platform/CSB Driver init
ata1: Signature Update detected @ 0 msecs
scsi host1: sata_fsl
ata2: SATA max UDMA/133 irq 69
ata2: Signature Update detected @ 0 msecs
fe8000000.flash: Found 1 x16 devices at 0x0 in 16-bit bank. Manufacturer ID=
 0x000001 Chip ID 0x002801
Amd/Fujitsu Extended Query Table at 0x0040
  Amd/Fujitsu Extended Query version 1.3.
number of CFI chips: 1
ftl_cs: FTL header not found.
nand: device found, Manufacturer ID: 0x20, Chip ID: 0xd3
nand: ST Micro NAND08GW3B2CN6
nand: 1024 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
Bad block table found at page 524224, version 0x01
Bad block table found at page 524160, version 0x01
nand_read_bbt: bad block at 0x00000b9e0000
6 fixed-partitions partitions found on MTD device fffa00000.flash
Creating 6 MTD partitions on "fffa00000.flash":
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
0x00001f000000-0x000040000000 : "NAND Writable User area"
ftl_cs: FTL header not found.
eLBC NAND device at 0xfffa00000, bank 2
fsl_espi ffe110000.spi: cs=3D0, init_csmode=3D0x100008
m25p80 spi0.0: found s25fl129p1, expected s25sl12801
m25p80 spi0.0: s25fl129p1 (16384 Kbytes)
4 fixed-partitions partitions found on MTD device spi0.0
Creating 4 MTD partitions on "spi0.0":
0x000000000000-0x000000100000 : "u-boot"
ftl_cs: FTL header not found.
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
0x000000100000-0x000000600000 : "kernel"
ata1.00: ATA-8: Hitachi HDS721050CLA362, JP2OA3MA, max UDMA/133
ata1.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 16/32)
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ftl_cs: FTL header not found.
ata2.00: ATAPI: Optiarc DVD RW AD-7260S, 1.03, max UDMA/100
ata1.00: configured for UDMA/133
0x000000600000-0x000000700000 : "dtb"
scsi 0:0:0:0: Direct-Access     ATA      Hitachi HDS72105 A3MA PQ: 0 ANSI: 5
ata2.00: configured for UDMA/100
sd 0:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/466 GiB)
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't suppor=
t DPO or FUA
scsi 1:0:0:0: CD-ROM            Optiarc  DVD RW AD-7260S  1.03 PQ: 0 ANSI: 5
random: fast init done
ftl_cs: FTL header not found.
0x000000700000-0x000001000000 : "file system"
ftl_cs: FTL header not found.
fsl_espi ffe110000.spi: at 0x        (ptrval) (irq =3D 53)
libphy: Fixed MDIO Bus: probed
libphy: Freescale XGMAC MDIO Bus: probed
mdio_bus ffe4f1000: Error while reading PHY4 reg at 1.6
mdio_bus ffe4f1000: Error while reading PHY4 reg at 1.5
mdio_bus ffe4f1000: Error while reading PHY4 reg at 0.6
 sda: sda1 sda2 < sda5 >
mdio_bus ffe4f1000: Error while reading PHY4 reg at 0.5
sd 0:0:0:0: [sda] Attached SCSI disk
mdio_bus ffe4f1000: MDIO device at address 4 is missing.
mdio_bus ffe4f1000: Error while reading PHY0 reg at 1.6
mdio_bus ffe4f1000: Error while reading PHY0 reg at 1.5
mdio_bus ffe4f1000: Error while reading PHY0 reg at 0.6
mdio_bus ffe4f1000: Error while reading PHY0 reg at 0.5
mdio_bus ffe4f1000: MDIO device at address 0 is missing.
libphy: Freescale PowerQUICC MII Bus: probed
mdio_bus mdio@ffe4e1120: MDIO device at address 8 is missing.
libphy: Freescale PowerQUICC MII Bus: probed
libphy: Freescale PowerQUICC MII Bus: probed
libphy: Freescale PowerQUICC MII Bus: probed
libphy: Freescale PowerQUICC MII Bus: probed
sr 1:0:0:0: [sr0] scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cd=
da tray
fsl_dpaa_mac: of_phy_find_device (TBI PHY) failed
cdrom: Uniform CD-ROM driver Revision: 3.20
fsl_dpaa_mac ffe4e0000.ethernet: mac_dev->init() =3D -22
fsl_dpaa_mac: probe of ffe4e0000.ethernet failed with error -22
fsl_dpaa_mac ffe4e2000.ethernet: FMan dTSEC version: 0x08240101
sr 1:0:0:0: Attached scsi generic sg1 type 5
fsl_dpaa_mac ffe4e2000.ethernet: FMan MAC address: 00:15:17:54:a8:b3
fsl_dpaa_mac ffe4e4000.ethernet: of_get_mac_address(/soc@ffe000000/fman@400=
000/ethernet@e4000) failed
fsl_dpaa_mac: probe of ffe4e4000.ethernet failed with error -22
fsl_dpaa_mac ffe4e6000.ethernet: of_get_mac_address(/soc@ffe000000/fman@400=
000/ethernet@e6000) failed
fsl_dpaa_mac: probe of ffe4e6000.ethernet failed with error -22
fsl_dpaa_mac ffe4e8000.ethernet: of_get_mac_address(/soc@ffe000000/fman@400=
000/ethernet@e8000) failed
fsl_dpaa_mac: probe of ffe4e8000.ethernet failed with error -22
fsl_dpaa_mac ffe4f0000.ethernet: of_get_mac_address(/soc@ffe000000/fman@400=
000/ethernet@f0000) failed
fsl_dpaa_mac: probe of ffe4f0000.ethernet failed with error -22
fsl_dpaa_mac ffe4e2000.ethernet eth0: Probed interface eth0
e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
e1000: Copyright (c) 1999-2006 Intel Corporation.
e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
e1000e 2000:01:00.0: Interrupt Throttling Rate (ints/sec) set to dynamic co=
nservative mode
e1000e 2000:01:00.0 eth1: (PCI Express:2.5GT/s:Width x1) 00:15:17:54:a8:b2
e1000e 2000:01:00.0 eth1: Intel(R) PRO/1000 Network Connection
e1000e 2000:01:00.0 eth1: MAC: 0, PHY: 4, PBA No: D50868-003
e1000e 2000:01:00.1: Interrupt Throttling Rate (ints/sec) set to dynamic co=
nservative mode
e1000e 2000:01:00.1 eth2: (PCI Express:2.5GT/s:Width x1) 00:15:17:54:a8:b3
e1000e 2000:01:00.1 eth2: Intel(R) PRO/1000 Network Connection
e1000e 2000:01:00.1 eth2: MAC: 0, PHY: 4, PBA No: D50868-003
igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
igb: Copyright (c) 2007-2014 Intel Corporation.
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-pci: EHCI PCI platform driver
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ohci-pci: OHCI PCI platform driver
ehci-fsl: Freescale EHCI Host controller driver
fsl-ehci fsl-ehci.0: Freescale On-Chip EHCI Host Controller
fsl-ehci fsl-ehci.0: new USB bus registered, assigned bus number 1
fsl-ehci fsl-ehci.0: irq 44, io mem 0xffe210000
fsl-ehci fsl-ehci.0: USB 2.0 started, EHCI 1.00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
usbcore: registered new interface driver usb-storage
i2c /dev entries driver
mpc-i2c ffe118100.i2c: timeout 1000000 us
at24 0-0051: 32768 byte 24c256 EEPROM, writable, 1 bytes/write
at24 0-0052: 32768 byte 24c256 EEPROM, writable, 1 bytes/write
mpc-i2c ffe119100.i2c: timeout 1000000 us
rtc-ds3232 1-0068: rtc core: registered ds3232 as rtc0
mpc-i2c ffe118000.i2c: timeout 1000000 us
mpc-i2c ffe119000.i2c: timeout 1000000 us
ina2xx 1-0040: power monitor ina220 (Rshunt =3D 1000 uOhm)
ina2xx 1-0041: power monitor ina220 (Rshunt =3D 1000 uOhm)
ina2xx 1-0044: power monitor ina220 (Rshunt =3D 1000 uOhm)
ina2xx 1-0045: power monitor ina220 (Rshunt =3D 1000 uOhm)
Freescale(R) MPC85xx EDAC driver, (C) 2006 Montavista Software
EDAC MC0: Giving out device to module fsl_ddr_edac controller fsl_mc_err: D=
EV fsl_mc_err (INTERRUPT)
fsl_ddr_edac acquired irq 490 for MC
fsl_ddr_edac MC err registered
EDAC MC1: Giving out device to module fsl_ddr_edac controller fsl_mc_err: D=
EV fsl_mc_err (INTERRUPT)
fsl_ddr_edac acquired irq 489 for MC
fsl_ddr_edac MC err registered
EDAC PCI0: Giving out device to module MPC85xx_edac controller mpc85xx_pci_=
err: DEV mpc85xx-pci-edac.0.auto (INTERRUPT)
MPC85xx_edac acquired irq 482 for PCI Err
MPC85xx_edac PCI err registered
EDAC PCI1: Giving out device to module MPC85xx_edac controller mpc85xx_pci_=
err: DEV mpc85xx-pci-edac.1.auto (INTERRUPT)
MPC85xx_edac acquired irq 480 for PCI Err
MPC85xx_edac PCI err registered
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
sdhci-pltfm: SDHCI platform and OF driver helper
mmc0: SDHCI controller on ffe114000.sdhc [ffe114000.sdhc] using ADMA
iommu: Adding device ffe301000.jr to group 21
iommu: Adding device ffe302000.jr to group 22
iommu: Adding device ffe303000.jr to group 23
iommu: Adding device ffe304000.jr to group 24
platform caam_qi: Linux CAAM Queue I/F driver initialised
caam ffe300000.crypto: device ID =3D 0x0a12010000000000 (Era 3)
caam ffe300000.crypto: job rings =3D 4, qi =3D 1, dpaa2 =3D no
caam algorithms registered in /proc/crypto
platform caam_qi: algorithms registered in /proc/crypto
caam_jr ffe301000.jr: registering rng-caam
caam ffe300000.crypto: caam pkc algorithms registered in /proc/crypto
Freescale hypervisor management driver
fsl-hv: no hypervisor found
ipip: IPv4 and MPLS over IPv4 tunneling driver
Initializing XFRM netlink socket
NET: Registered protocol family 10
Segment Routing with IPv6
sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 15
Key type dns_resolver registered
drmem: No dynamic reconfiguration memory found
libphy: mdio_mux: probed
libphy: mdio_mux: probed
mdio_bus 0.48: MDIO device at address 28 is missing.
mdio_bus 0.48: MDIO device at address 29 is missing.
mdio_bus 0.48: MDIO device at address 30 is missing.
rtc-ds3232 1-0068: setting system clock to 2018-06-19 06:49:28 UTC (1529390=
968)
ALSA device list:
  No soundcards found.
EXT4-fs (sda1): warning: maximal mount count reached, running e2fsck is rec=
ommended
EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
VFS: Mounted root (ext4 filesystem) on device 8:1.
devtmpfs: mounted
Freeing unused kernel memory: 524K
This architecture does not have kernel memory protection.
systemd[1]: Failed to insert module 'autofs4': No such file or directory
random: systemd: uninitialized urandom read (16 bytes read)
systemd[1]: systemd 230 running in system mode. (+PAM +AUDIT +SELINUX +IMA =
+APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ -L=
Z4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
systemd[1]: Detected architecture ppc64.

Welcome to Debian GNU/Linux stretch/sid!

systemd[1]: Set hostname to <p5020ds>.
random: systemd: uninitialized urandom read (16 bytes read)
random: systemd-cryptse: uninitialized urandom read (16 bytes read)
systemd[1]: Listening on Journal Socket.
[  OK  ] Listening on Journal Socket.
systemd[1]: Listening on Journal Socket (/dev/log).
[  OK  ] Listening on Journal Socket (/dev/log).
systemd[1]: Listening on udev Kernel Socket.
[  OK  ] Listening on udev Kernel Socket.
systemd[1]: Listening on udev Control Socket.
[  OK  ] Listening on udev Control Socket.
systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[  OK  ] Started Forward Password Requests to Wall Directory Watch.
systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
[  OK  ] Listening on /dev/initctl Compatibility Named Pipe.
systemd[1]: Listening on Journal Audit Socket.
[  OK  ] Listening on Journal Audit Socket.
[  OK  ] Listening on Syslog Socket.
[  OK  ] Listening on RPCbind Server Activation Socket.
[  OK  ] Listening on fsck to fsckd communication Socket.
[  OK  ] Created slice User and Session Slice.
[  OK  ] Reached target Encrypted Volumes.
[UNSUPP] Starting of Arbitrary Executable Fi...m Automount Point not suppor=
ted.
[  OK  ] Created slice System Slice.
         Starting hwclockfirst.service...
[  OK  ] Reached target Slices.
         Starting Set the console keyboard layout...
[  OK  ] Created slice system-getty.slice.
         Mounting RPC Pipe File System...
         Mounting Debug File System...
         Mounting POSIX Message Queue File System...
         Starting Journal Service...
         Mounting Huge Pages File System...
         Starting Load Kernel Modules...
[  OK  ] Created slice system-serial\x2dgetty.slice.
[  OK  ] Started Dispatch Password Requests to Console Directory Watch.
[  OK  ] Reached target Paths.
         Starting Create Static Device Nodes in /dev...
[FAILED] Failed to start Load Kernel Modules.
See 'systemctl status systemd-modules-load.service' for details.
         Starting Apply Kernel Variables...
[  OK  ] Started Journal Service.
[  OK  ] Started Apply Kernel Variables.
[  OK  ] Mounted Huge Pages File System.
[  OK  ] Mounted Debug File System.
[  OK  ] Mounted POSIX Message Queue File System.
[  OK  ] Mounted RPC Pipe File System.
random: crng init done
random: 7 urandom warning(s) missed due to ratelimiting
[  OK  ] Started Create Static Device Nodes in /dev.
         Starting udev Kernel Device Manager...
[  OK  ] Started Set the console keyboard layout.
[  OK  ] Started udev Kernel Device Manager.
[  OK  ] Started hwclockfirst.service.
         Starting Remount Root and Kernel File Systems...
EXT4-fs (sda1): re-mounted. Opts: errors=3Dremount-ro
[  OK  ] Started Remount Root and Kernel File Systems.
         Starting udev Coldplug all Devices...
[  OK  ] Reached target Local File Systems (Pre).
[  OK  ] Reached target Local File Systems.
         Starting Set console font and keymap...
         Starting Raise network interfaces...
         Starting Preprocess NFS configuration...
         Starting Load/Save Random Seed...
         Starting Flush Journal to Persistent Storage...
systemd-journald[1527]: Received request to flush runtime journal from PID 1
[  OK  ] Started Flush Journal to Persistent Storage.
[  OK  ] Started Set console font and keymap.
[  OK  ] Started Preprocess NFS configuration.
[  OK  ] Started Load/Save Random Seed.
[  OK  ] Reached target NFS client services.
         Starting Create Volatile Files and Directories...
[  OK  ] Started udev Coldplug all Devices.
[  OK  ] Started Create Volatile Files and Directories.
[  OK  ] Reached target System Time Synchronized.
         Starting Update UTMP about System Boot/Shutdown...
         Starting RPC bind portmap service...
fsl_dpaa_mac ffe4e2000.ethernet rename3: renamed from eth0
[  OK  ] Found device /dev/ttyS0.
e1000e 2000:01:00.1 rename5: renamed from eth2
e1000e 2000:01:00.0 eth0: renamed from eth1
fsl_dpaa_mac ffe4e2000.ethernet eth1: renamed from rename3
[  OK  ] Started Update UTMP about System Boot/Shutdown.
[  OK  ] Found device Hitachi_HDS721050CLA362 5.
[  OK  ] Started Raise network interfaces.
[  OK  ] Started ifup for eth0.
[  OK  ] Reached target Network.
[  OK  ] Reached target Network is Online.
         Activating swap /dev/disk/by-uuid/3...8-d132-4ebe-80c2-ca8afd64689=
c...
[  OK  ] Started RPC bind portmap service.
[  OK  ] Reached target RPC Port Mapper.
[  OK  ] Reached target Remote File Systems (Pre).
[  OK  ] Reached target Remote File Systems.
Adding 7918588k swap on /dev/sda5.  Priority:-2 extents:1 across:7918588k=20
[  OK  ] Activated swap /dev/disk/by-uuid/31de3858-d132-4ebe-80c2-ca8afd646=
89c.
[  OK  ] Reached target Swap.
[  OK  ] Reached target System Initialization.
[  OK  ] Listening on D-Bus System Message Bus Socket.
[  OK  ] Reached target Sockets.
[  OK  ] Reached target Basic System.
         Starting Permit User Sessions...
[  OK  ] Started Regular background program processing daemon.
         Starting OpenBSD Secure Shell server...
[  OK  ] Started Deferred execution scheduler.
         Starting System Logging Service...
         Starting Login Service...
         Starting /etc/rc.local Compatibility...
[  OK  ] Started Daily apt activities.
         Starting LSB: exim Mail Transport Agent...
[  OK  ] Started D-Bus System Message Bus.
IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[  OK  ] Started Daily Cleanup of Temporary Directories.
[  OK  ] Reached target Timers.
         Starting LSB: Start NTP daemon...
[  OK  ] Started Permit User Sessions.
[  OK  ] Started /etc/rc.local Compatibility.
[  OK  ] Started System Logging Service.
[  OK  ] Started Login Service.
[  OK  ] Started Getty on tty1.
[  OK  ] Started Serial Getty on ttyS0.
[  OK  ] Reached target Login Prompts.
[  OK  ] Started OpenBSD Secure Shell server.
[  OK  ] Started LSB: Start NTP daemon.
[  OK  ] Started LSB: exim Mail Transport Agent.
[  OK  ] Reached target Multi-User System.
[  OK  ] Reached target Graphical Interface.
         Starting Update UTMP about System Runlevel Changes...
[  OK  ] Started Update UTMP about System Runlevel Changes.
e1000e: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None
IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready

Debian GNU/Linux stretch/sid p5020ds ttyS0

--=-=-=--
