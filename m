Return-Path: <agl@us.ibm.com>
Subject: Re: [PATCH] powerpc: Introduce address space "slices"
From: Adam Litke <agl@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1171918045.18571.63.camel@localhost.localdomain>
References: <1171867418.18571.3.camel@localhost.localdomain>
	<1171911281.22940.21.camel@localhost.localdomain>
	<1171914050.18571.35.camel@localhost.localdomain>
	<1171917307.22940.35.camel@localhost.localdomain>
	<1171918045.18571.63.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 19 Feb 2007 15:15:01 -0600
Message-Id: <1171919702.22940.36.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"cbe-oss-dev@ozlabs.org" <cbe-oss-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-02-20 at 07:47 +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2007-02-19 at 14:35 -0600, Adam Litke wrote:
> > On Tue, 2007-02-20 at 06:40 +1100, Benjamin Herrenschmidt wrote:
> > > On Mon, 2007-02-19 at 12:54 -0600, Adam Litke wrote:
> > > > Patch seems good to me.  I tried it on my power4+ system and it was not
> > > > happy.  Have you tested on Power4 at all? 
> > > 
> > > No, on Power5 only so far, I might still have something wrong :-) What
> > > did you try and what was not happy ?
> > 
> > I haven't investigated too deeply yet, but it didn't boot.  Seemed
> > unable to find init.  [ And yes, I am sure it's not something related to
> > missing scsi drivers ;) ] Anything you want me to try out?  
> 
> You can try #define'ing DEBUG in slice.c and booting with "debug" on the
> kernel command line ?

Hmm didn't seem to add much additional info, but what do I know.  Here
is the new console log.


   Elf32 kernel loaded...

zImage starting: loaded at 0x00400010 (sp: 0x0291fbe0)
Allocating 0x6d72f0 bytes for kernel ...
OF version = 'IBM,RG040719_regatta'
gunzipping (0x3a00000 <- 0x407010:0x6807c4)...done 0x697938 bytes
Finalizing device tree... using OF tree (promptr=00c3c578)
OF stdout device is: /vdevice/vty@0
Hypertas detected, assuming LPAR !
command line: selinux=0 elevator=cfq autobench_args: root=/dev/sdb1 ABAT:1171919179 debug
memory layout at init:
  alloc_bottom : 00000000040dc000
  alloc_top    : 0000000030000000
  alloc_top_hi : 0000000780000000
  rmo_top      : 0000000030000000
  ram_top      : 0000000780000000
Looking for displays
instantiating rtas at 0x000000002fd3a000 ... done
0000000000000000 : boot cpu     0000000000000014
0000000000000001 : starting cpu hw idx 0000000000000015... done
0000000000000002 : starting cpu hw idx 0000000000000016... done
0000000000000003 : starting cpu hw idx 0000000000000017... done
copying OF device tree ...
Building dt strings...
Building dt structure...
Device tree strings 0x00000000040dd000 -> 0x00000000040de225
Device tree struct  0x00000000040df000 -> 0x00000000040e9000
Calling quiesce ...
returning from prom_init
Partition configured for 16 cpus.
Starting Linux PPC64 #49 SMP Mon Feb 19 13:08:18 PST 2007
-----------------------------------------------------
ppc64_pft_size                = 0x1d
physicalMemorySize            = 0x780000000
ppc64_caches.dcache_line_size = 0x80
ppc64_caches.icache_line_size = 0x80
htab_address                  = 0x0000000000000000
htab_hash_mask                = 0x3fffff
-----------------------------------------------------
Linux version 2.6.20-rc7-gd835aad4-dirty (aglitke@kernel) (gcc version 3.4.2) #49 SMP Mon Feb 19 13:08:18 PST 2007
[boot]0012 Setup Arch
No ramdisk, default root is /dev/sda2
EEH: PCI Enhanced I/O Error Handling Enabled
PPC64 nvram contains 20480 bytes
Zone PFN ranges:
  DMA             0 ->  7864320
  Normal    7864320 ->  7864320
early_node_map[1] active PFN ranges
    0:        0 ->  7864320
[boot]0015 Setup Done
Built 1 zonelists.  Total pages: 7756800
Kernel command line: selinux=0 elevator=cfq autobench_args: root=/dev/sdb1 ABAT:1171919179 debug
[boot]0020 XICS Init
xics: PCI 8259 intack at 0x000003fffdf091f0
i8259 legacy interrupt controller initialized
[boot]0021 XICS Done
PID hash table entries: 4096 (order: 12, 32768 bytes)
time_init: decrementer frequency = 212.995662 MHz
time_init: processor frequency   = 1703.965296 MHz
Using pSeries machine description
Page orders: linear mapping = 24, virtual = 12, io = 12
Found legacy serial port 0 for /pci@3fffdf09000/isa@3/serial@i3f8
  port=3f8, taddr=3fdffe003f8, irq=0, clk=1843200, speed=0
Found legacy serial port 1 for /pci@3fffdf09000/isa@3/serial@i2f8
  port=2f8, taddr=3fdffe002f8, irq=0, clk=1843200, speed=0
Partition configured for 16 cpus.
Starting Linux PPC64 #49 SMP Mon Feb 19 13:08:18 PST 2007
-----------------------------------------------------
ppc64_pft_size                = 0x1d
physicalMemorySize            = 0x780000000
ppc64_caches.dcache_line_size = 0x80
ppc64_caches.icache_line_size = 0x80
htab_address                  = 0x0000000000000000
htab_hash_mask                = 0x3fffff
-----------------------------------------------------
Linux version 2.6.20-rc7-gd835aad4-dirty (aglitke@kernel) (gcc version 3.4.2) #49 SMP Mon Feb 19 13:08:18 PST 2007
[boot]0012 Setup Arch
Top of RAM: 0x780000000, Total RAM: 0x780000000
Memory hole size: 0MB
Entering add_active_range(0, 0, 7864320) 0 entries of 256 used
No ramdisk, default root is /dev/sda2
RTAS: event: 1, Type: Internal Device Failure, Severity: 5
RTAS: event: 2, Type: Internal Device Failure, Severity: 5
EEH: PCI Enhanced I/O Error Handling Enabled
PPC64 nvram contains 20480 bytes
Using default idle loop
Zone PFN ranges:
  DMA             0 ->  7864320
  Normal    7864320 ->  7864320
early_node_map[1] active PFN ranges
    0:        0 ->  7864320
On node 0 totalpages: 7864320
  DMA zone: 107520 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 7756800 pages, LIFO batch:31
  Normal zone: 0 pages used for memmap
[boot]0015 Setup Done
Built 1 zonelists.  Total pages: 7756800
Kernel command line: selinux=0 elevator=cfq autobench_args: root=/dev/sdb1 ABAT:1171919179 debug
[boot]0020 XICS Init
xics: PCI 8259 intack at 0x000003fffdf091f0
i8259 legacy interrupt controller initialized
[boot]0021 XICS Done
PID hash table entries: 4096 (order: 12, 32768 bytes)
time_init: decrementer frequency = 212.995662 MHz
time_init: processor frequency   = 1703.965296 MHz
Console: colour dummy device 80x25
Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes)
Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes)
freeing bootmem node 0
Memory: 30967340k/31457280k available (5584k kernel code, 489940k reserved, 952k data, 272k bss, 268k init)
Calibrating delay loop... 424.96 BogoMIPS (lpj=849920)
Mount-cache hash table entries: 256
Processor 1 found.
Processor 2 found.
Processor 3 found.
Brought up 4 CPUs
migration_cost=1
NET: Registered protocol family 16
PCI: Probing PCI hardware
Failed to request PCI IO region on PCI domain 0000
IOMMU table initialized, virtual merging disabled
RTAS: event: 3, Type: Internal Device Failure, Severity: 5
RTAS: event: 4, Type: Internal Device Failure, Severity: 5
ISA bridge at 0000:00:03.0
mapping IO 3fdffe00000 -> d000080000000000, size: 100000
mapping IO 3fe3fe00000 -> d000080000100000, size: 100000
mapping IO 3fe3ff00000 -> d000080000200000, size: 100000
mapping IO 3fe3fd00000 -> d000080000300000, size: 100000
mapping IO 3fcbfe00000 -> d000080000400000, size: 100000
mapping IO 3fcbff00000 -> d000080000500000, size: 100000
mapping IO 3fcbfd00000 -> d000080000600000, size: 100000
PCI: Probing PCI hardware done
Registering pmac pic with sysfs...
SCSI subsystem initialized
NET: Registered protocol family 2
IP route cache hash table entries: 1048576 (order: 11, 8388608 bytes)
TCP established hash table entries: 1048576 (order: 12, 16777216 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 1048576 bind 65536)
TCP reno registered
vio_bus_init: processing c00000077fffbcd8
vio_bus_init: processing c00000077fffbe08
vio_bus_init: processing c00000077fffbf60
RTAS daemon started
RTAS: event: 69, Type: EPOW, Severity: 2
Total HugeTLB memory allocated, 0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
JFS: nTxBlock = 8192, nTxLock = 65536
SGI XFS with large block/inode numbers, no debug enabled
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
vio_register_driver: driver hvc_console registering
HVSI: registered 0 devices
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250.0: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250.0: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Floppy drive(s): fd0 is 2.88M
FDC 0 is a National Semiconductor PC87306
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
nbd: registered device at major 43
Intel(R) PRO/1000 Network Driver - version 7.3.15-k2
Copyright (c) 1999-2006 Intel Corporation.
PCI: Enabling device: (0006:61:01.0), cmd 143
e1000: 0006:61:01.0: e1000_probe: (PCI-X:133MHz:64-bit) 00:02:55:53:78:34
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
pcnet32.c:v1.33 27.Jun.2006 tsbogend@alpha.franken.de
e100: Intel(R) PRO/100 Network Driver, 3.5.17-k2-NAPI
e100: Copyright(c) 1999-2006 Intel Corporation
PCI: Enabling device: (0006:41:01.0), cmd 143
sym0: <1010-66> rev 0x1 at pci 0006:41:01.0 irq 71
sym0: No NVRAM, ID 7, Fast-80, LVD, parity checking
sym0: SCSI BUS has been reset.
scsi0 : sym-2.2.3
 target0:0:8: FAST-40 WIDE SCSI 80.0 MB/s ST (25 ns, offset 31)
scsi 0:0:8:0: Direct-Access     IBM      IC35L036UCDY10-0 S28C PQ: 0 ANSI: 3
 target0:0:8: tagged command queuing enabled, command queue depth 16.
 target0:0:8: Beginning Domain Validation
 target0:0:8: asynchronous
 target0:0:8: wide asynchronous
 target0:0:8: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 31)
 target0:0:8: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 31)
 target0:0:8: Ending Domain Validation
 target0:0:9: FAST-40 WIDE SCSI 80.0 MB/s ST (25 ns, offset 31)
scsi 0:0:9:0: Direct-Access     IBM      ST336607LC       C50H PQ: 0 ANSI: 3
 target0:0:9: tagged command queuing enabled, command queue depth 16.
 target0:0:9: Beginning Domain Validation
 target0:0:9: asynchronous
 target0:0:9: wide asynchronous
 target0:0:9: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 31)
 target0:0:9: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 31)
 target0:0:9: Ending Domain Validation
scsi 0:0:15:0: Enclosure         IBM      HSBPD4HA PU3SCSI 0018 PQ: 0 ANSI: 2
 target0:0:15: Beginning Domain Validation
scsi 0:0:15:0: phase change 6-7 6@60000fa0 resid=4.
 target0:0:15: asynchronous
 target0:0:15: Ending Domain Validation
vio_register_driver: driver ibmvscsi registering
st: Version 20061107, fixed bufsize 32768, s/g segs 256
SCSI device sda: 71096640 512-byte hdwr sectors (36401 MB)
sda: Write Protect is off
sda: Mode Sense: cb 00 00 08
SCSI device sda: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
SCSI device sda: 71096640 512-byte hdwr sectors (36401 MB)
sda: Write Protect is off
sda: Mode Sense: cb 00 00 08
SCSI device sda: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3
sd 0:0:8:0: Attached scsi disk sda
SCSI device sdb: 71096640 512-byte hdwr sectors (36401 MB)
sdb: Write Protect is off
sdb: Mode Sense: cb 00 10 08
SCSI device sdb: write cache: disabled, read cache: enabled, supports DPO and FUA
SCSI device sdb: 71096640 512-byte hdwr sectors (36401 MB)
sdb: Write Protect is off
sdb: Mode Sense: cb 00 10 08
SCSI device sdb: write cache: disabled, read cache: enabled, supports DPO and FUA
 sdb: sdb1 sdb2
sd 0:0:9:0: Attached scsi disk sdb
sd 0:0:8:0: Attached scsi generic sg0 type 0
sd 0:0:9:0: Attached scsi generic sg1 type 0
scsi 0:0:15:0: Attached scsi generic sg2 type 13
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input0
md: linear personality registered for level -1
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
oprofile: using ppc64/power4 performance monitoring.
IPv4 over IPv4 tunneling driver
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 268k freed
Kernel panic - not syncing: No init found.  Try passing init= option to kernel.

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center
