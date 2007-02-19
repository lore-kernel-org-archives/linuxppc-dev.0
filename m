Return-Path: <agl@us.ibm.com>
Subject: Re: [PATCH] powerpc: Introduce address space "slices"
From: Adam Litke <agl@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1171914050.18571.35.camel@localhost.localdomain>
References: <1171867418.18571.3.camel@localhost.localdomain>
	<1171911281.22940.21.camel@localhost.localdomain>
	<1171914050.18571.35.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 19 Feb 2007 14:35:07 -0600
Message-Id: <1171917307.22940.35.camel@localhost.localdomain>
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

On Tue, 2007-02-20 at 06:40 +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2007-02-19 at 12:54 -0600, Adam Litke wrote:
> > Patch seems good to me.  I tried it on my power4+ system and it was not
> > happy.  Have you tested on Power4 at all? 
> 
> No, on Power5 only so far, I might still have something wrong :-) What
> did you try and what was not happy ?

I haven't investigated too deeply yet, but it didn't boot.  Seemed
unable to find init.  [ And yes, I am sure it's not something related to
missing scsi drivers ;) ] Anything you want me to try out?  

console log follows...

   Elf32 kernel loaded...

zImage starting: loaded at 0x00400010 (sp: 0x0291fbe0)
Allocating 0x6d72f0 bytes for kernel ...
OF version = 'IBM,RG040719_regatta'
gunzipping (0x3a00000 <- 0x407010:0x6807b7)...done 0x697938 bytes
Finalizing device tree... using OF tree (promptr=00c3c578)
OF stdout device is: /vdevice/vty@0
Hypertas detected, assuming LPAR !
command line: selinux=0 elevator=cfq autobench_args: root=/dev/sdb1 ABAT:1171916974 
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
Starting Linux PPC64 #48 SMP Mon Feb 19 12:11:37 PST 2007
-----------------------------------------------------
ppc64_pft_size                = 0x1d
physicalMemorySize            = 0x780000000
ppc64_caches.dcache_line_size = 0x80
ppc64_caches.icache_line_size = 0x80
htab_address                  = 0x0000000000000000
htab_hash_mask                = 0x3fffff
-----------------------------------------------------
Linux version 2.6.20-rc7-gcb36fb6c (aglitke@kernel) (gcc version 3.4.2) #48 SMP Mon Feb 19 12:11:37 PST 2007
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
Kernel command line: selinux=0 elevator=cfq autobench_args: root=/dev/sdb1 ABAT:1171916974 
[boot]0020 XICS Init
i8259 legacy interrupt controller initialized
[boot]0021 XICS Done
PID hash table entries: 4096 (order: 12, 32768 bytes)
Using pSeries machine description
Partition configured for 16 cpus.
Starting Linux PPC64 #48 SMP Mon Feb 19 12:11:37 PST 2007
-----------------------------------------------------
ppc64_pft_size                = 0x1d
physicalMemorySize            = 0x780000000
ppc64_caches.dcache_line_size = 0x80
ppc64_caches.icache_line_size = 0x80
htab_address                  = 0x0000000000000000
htab_hash_mask                = 0x3fffff
-----------------------------------------------------
Linux version 2.6.20-rc7-gcb36fb6c (aglitke@kernel) (gcc version 3.4.2) #48 SMP Mon Feb 19 12:11:37 PST 2007
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
Kernel command line: selinux=0 elevator=cfq autobench_args: root=/dev/sdb1 ABAT:1171916974 
[boot]0020 XICS Init
i8259 legacy interrupt controller initialized
[boot]0021 XICS Done
PID hash table entries: 4096 (order: 12, 32768 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes)
Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes)
freeing bootmem node 0
Memory: 30967340k/31457280k available (5584k kernel code, 489940k reserved, 952k data, 272k bss, 268k init)
Mount-cache hash table entries: 256
Processor 1 found.
Processor 2 found.
Processor 3 found.
Brought up 4 CPUs
migration_cost=0
NET: Registered protocol family 16
Failed to request PCI IO region on PCI domain 0000
IOMMU table initialized, virtual merging disabled
SCSI subsystem initialized
NET: Registered protocol family 2
IP route cache hash table entries: 1048576 (order: 11, 8388608 bytes)
TCP established hash table entries: 1048576 (order: 12, 16777216 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 1048576 bind 65536)
TCP reno registered
Total HugeTLB memory allocated, 0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
JFS: nTxBlock = 8192, nTxLock = 65536
SGI XFS with large block/inode numbers, no debug enabled
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
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
e1000: 0006:61:01.0: e1000_probe: (PCI-X:133MHz:64-bit) 00:02:55:53:78:34
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
pcnet32.c:v1.33 27.Jun.2006 tsbogend@alpha.franken.de
e100: Intel(R) PRO/100 Network Driver, 3.5.17-k2-NAPI
e100: Copyright(c) 1999-2006 Intel Corporation
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
st: Version 20061107, fixed bufsize 32768, s/g segs 256
SCSI device sda: 71096640 512-byte hdwr sectors (36401 MB)
sda: Write Protect is off
SCSI device sda: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
SCSI device sda: 71096640 512-byte hdwr sectors (36401 MB)
sda: Write Protect is off
SCSI device sda: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3
sd 0:0:8:0: Attached scsi disk sda
SCSI device sdb: 71096640 512-byte hdwr sectors (36401 MB)
sdb: Write Protect is off
SCSI device sdb: write cache: disabled, read cache: enabled, supports DPO and FUA
SCSI device sdb: 71096640 512-byte hdwr sectors (36401 MB)
sdb: Write Protect is off
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
 <0>Rebooting in 180 seconds..


-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center
