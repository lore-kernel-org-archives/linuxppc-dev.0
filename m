Return-Path: <ppc64@storix.com>
Received: from storix.com (unknown [206.71.178.18])
	by ozlabs.org (Postfix) with ESMTP id CE4DE67B97
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Sep 2006 08:47:39 +1000 (EST)
Received: from david (david [65.106.88.139])
	by storix.com (Postfix) with ESMTP id 5D318E06
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Sep 2006 15:18:49 -0700 (PDT)
From: ppc64@storix.com
To: linuxppc-dev@ozlabs.org
Subject: Kernel panic: kernel access of bad area pc
Date: Fri, 8 Sep 2006 15:32:59 -0700
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_b+eAFgYpC25MMUG"
Message-Id: <200609081532.59764.ppc64@storix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Boundary-00=_b+eAFgYpC25MMUG
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have a process to create tape boot images by combining the kernel and initrd 
into a zImage. The process works for 2.4 (RHEL 3.3) & 2.6 kernels (SLES9 & 
RHEL4). However on SLES8 ppc64 the kernel panics with "error kernel access of 
bad area pc". 

Attached is the complete log of the boot with backtrace data.

The system is:

IBM 7044-170
SLES 8 (2.4.19-ul1-ppc64-SMP)

The kernel was uncompressed using:
# objcopy -j .kernel:vmlinux -O binary vmlinuz vmlinux-storix.gz
# gunzip vmlinux-storix.gz

Which gives me vmlinux-storix

Kernel Memsize
# nm -n /boot/vmlinux-storix | tail -n1
c0000000007c4000 A _end

Anyone have an idea what is causing the failure? The error message appears to 
be pretty generic.

-- 
David Huffman
Support & Development
Storix, Inc

Life is hard. Get a helmet.

--Boundary-00=_b+eAFgYpC25MMUG
Content-Type: text/plain;
  charset="us-ascii";
  name="debug.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="debug.txt"

RS/6000 Firmware
Version SPH04194
(c) Copyright IBM Corp. 2000  All rights reserved.
-------------------------------------------------------------------------------

zImage starting: loaded at 0x400000
Allocating 0x8c4000 bytes for kernel ...
    trying: 0x01400000
Allocating 0x12400b bytes for initrd ...
    trying: 0x01cc4000
initial ramdisk moving 0x1cc4000 <- 0x6a6000 (12400b bytes)
initrd head: 0x1f8b0800
gunzipping (0x1400000 <- 0x409000:0x66ddff)...done 0x7df6b0 bytes
0xe158 bytes of heap consumed, max in use 0x%
... skipping 0x10000 bytes of ELF header
initrd head: 0x1f8b0800
kernel:
        entry addr = 0x1410000
        a1         = 0x1cc4000,
        a2         = 0x12400b,
        prom       = 0xc1b320,
        bi_recs    = 0x0,
opening display /pci@fef00000/display@d... ok
instantiating rtas at 0x000000002ffb5000... done
opened /pci@fef00000
open success
opened /pci@fee00000
open success
 (translate ok) returning from prom_init
---- start early boot console ----
Starting Linux PPC64 2.4.19-ul1-ppc64-SMP
-----------------------------------------------------
naca                          = 0xc000000000004000
naca->pftSize                 = 0x18
naca->debug_switch            = 0x0
naca->interrupt_controller    = 0x1
systemcf                      = 0xc000000000005000
systemcfg->processorCount     = 0x1
systemcfg->physicalMemorySize = 0x30000000
systemcfg->dCacheL1LineSize   = 0x80
systemcfg->iCacheL1LineSize   = 0x80
htab_data.htab                = 0xc00000002e000000
htab_data.num_ptegs           = 0x20000
-----------------------------------------------------
of_stdout_device /pci@fef00000/isa@b/serial@i3f8
console= not found, add console=ttyS0,9600
cmd_line is now AUTOCONSOLE console=ttyS0,9600 
[boot]0010 Setup System
Linux version 2.4.19-ul1-ppc64-SMP (root@PowerPC64-pSeries.suse.de) (gcc version 3.2) #1 SMP Wed Dec 4 18:41:23 UTC 2002
[boot]0012 Setup Arch
Boot arguments: AUTOCONSOLE console=ttyS0,9600 
Python workaround: reg0: 18e3388
Python workaround: reg0: 18eb788
On node 0 totalpages: 196608
zone(0): 196608 pages.
zone(1): 0 pages.
zone(2): 0 pages.
[boot]0015 Setup Done
Building zonelist for node : 0
Kernel command line: AUTOCONSOLE console=ttyS0,9600 
[boot]0020 OpenPic Init
OpenPIC Version 1.2 (8 CPUs and 1 IRQ sources) at e000000002207000
[boot]0021 OpenPic Timer
[boot]0022 OpenPic IPI
OpenPIC reversed IPI registers detected
[boot]0023 OpenPic Ext
[boot]0024 OpenPic Spurious
[boot]0025 OpenPic Done
time_init: decrementer frequency = 95.141892 MHz
time_init: processor frequency   = 333.000000 MHz
---- end early boot console ----
Starting Linux PPC64 2.4.19-ul1-ppc64-SMP
-----------------------------------------------------
naca                          = 0xc000000000004000
naca->pftSize                 = 0x18
naca->debug_switch            = 0x0
naca->interrupt_controller    = 0x1
systemcf                      = 0xc000000000005000
systemcfg->processorCount     = 0x1
systemcfg->physicalMemorySize = 0x30000000
systemcfg->dCacheL1LineSize   = 0x80
systemcfg->iCacheL1LineSize   = 0x80
htab_data.htab                = 0xc00000002e000000
htab_data.num_ptegs           = 0x20000
-----------------------------------------------------
of_stdout_device /pci@fef00000/isa@b/serial@i3f8
console= not found, add console=ttyS0,9600
cmd_line is now AUTOCONSOLE console=ttyS0,9600 
[boot]0010 Setup System
Linux version 2.4.19-ul1-ppc64-SMP (root@PowerPC64-pSeries.suse.de) (gcc version 3.2) #1 SMP Wed Dec 4 18:41:23 UTC 2002
[boot]0012 Setup Arch
Boot arguments: AUTOCONSOLE console=ttyS0,9600 
Python workaround: reg0: 18e3388
Python workaround: reg0: 18eb788
On node 0 totalpages: 196608
zone(0): 196608 pages.
zone(1): 0 pages.
zone(2): 0 pages.
[boot]0015 Setup Done
Building zonelist for node : 0
Kernel command line: AUTOCONSOLE console=ttyS0,9600 
[boot]0020 OpenPic Init
OpenPIC Version 1.2 (8 CPUs and 1 IRQ sources) at e000000002207000
[boot]0021 OpenPic Timer
[boot]0022 OpenPic IPI
OpenPIC reversed IPI registers detected
[boot]0023 OpenPic Ext
[boot]0024 OpenPic Spurious
[boot]0025 OpenPic Done
time_init: decrementer frequency = 95.141892 MHz
time_init: processor frequency   = 333.000000 MHz
Console: colour dummy device 80x25
Calibrating delay loop... 190.05 BogoMIPS
Memory: 736596k available (3276k kernel code, 4536k data, 196k init) [c000000000000000,c000000030000000]
kdb version 2.3 by Scott Lurndal, Keith Owens. Copyright SGI, All Rights Reserved
Dentry cache hash table entries: 131072 (order: 9, 2097152 bytes)
Inode cache hash table entries: 65536 (order: 8, 1048576 bytes)
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 65536 (order: 7, 524288 bytes)
Page-cache hash table entries: 262144 (order: 9, 2097152 bytes)
proc_ppc64: Creating /proc/ppc64/pmc
PCI: Creating ../proc/ppc64/pcifr 
PCI: Creating ../proc/ppc64/pci 
POSIX conformance testing by UNIFIX
Entering SMP Mode...
Probe found 1 CPUs
Waiting for 0 CPUs
migration_task 0 on cpu=0
[boot]0040 PCI Probe
PCI: Probing PCI hardware
PCI: Cannot allocate resource region 3 of PCI bridge 0
PCI: resource is a0000..9ffff (200), parent c0000000003dabf0
ISA bridge at 00:0b.0
PCI: Probing PCI hardware done
[boot]0041 PCI Done
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
i/pSeries Real Time Clock Driver v1.1
RTAS daemon started
PPC64 nvram contains 110592 bytes
Starting kswapd
kinoded started
aio_setup: num_physpages = 49152
aio_setup: sizeof(struct page) = 88
Journalled Block Device driver loaded
JFS development version: $Name: v1_0_24 $
Using unsupported 1280x1024 pci1014,b7 at c0000000, depth=8, pitch=4096
Console: switching to colour frame buffer device 160x64
fb0: Open Firmware frame buffer device on /pci@fef00000/display@d
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Floppy drive(s): fd0 is 2.88M
FDC 0 is a National Semiconductor PC87306
RAMDISK driver initialized: 16 RAM disks of 128000K size 1024 blocksize
loop: loaded (max 16 devices)
SCSI subsystem driver Revision: 1.00
PCI: Enabling device 00:0c.0 (0140 -> 0143)
sym53c8xx: at PCI bus 0, device 12, function 0
sym53c8xx: setting PCI_COMMAND_MASTER...(fix-up)
sym53c8xx: setting PCI_COMMAND_INVALIDATE (fix-up)
sym53c8xx: 53c896 detected 
PCI: Enabling device 00:0c.1 (0140 -> 0143)
sym53c8xx: at PCI bus 0, device 12, function 1
sym53c8xx: setting PCI_COMMAND_MASTER...(fix-up)
sym53c8xx: setting PCI_COMMAND_INVALIDATE (fix-up)
sym53c8xx: 53c896 detected 
sym53c896-0: rev 0x5 on pci bus 0 device 12 function 0 irq 20
sym53c896-0: ID 7, Fast-40, Parity Checking
sym53c896-0: handling phase mismatch from SCRIPTS.
sym53c896-1: rev 0x5 on pci bus 0 device 12 function 1 irq 17
sym53c896-1: ID 7, Fast-40, Parity Checking
sym53c896-1: handling phase mismatch from SCRIPTS.
scsi0 : sym53c8xx-1.7.3c-20010512
scsi1 : sym53c8xx-1.7.3c-20010512
  Vendor: SEAGATE   Model: ST336607LW        Rev: 0004
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: IBM       Model: CDRM00203     !K  Rev: 1_05
  Type:   CD-ROM                             ANSI SCSI revision: 02
sym53c896-0-<3,*>: FAST-20 WIDE SCSI 40.0 MB/s (50.0 ns, offset 31)
  Vendor: IBM       Model: DNES-309170W      Rev: SA40
  Type:   Direct-Access                      ANSI SCSI revision: 03
sym53c896-0-<4,*>: FAST-20 WIDE SCSI 40.0 MB/s (50.0 ns, offset 31)
  Vendor: IBM       Model: DNES-309170W      Rev: SA40
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: HP        Model: C1557A            Rev: U812
  Type:   Sequential-Access                  ANSI SCSI revision: 02
  Vendor: HP        Model: C1557A            Rev: U812
  Type:   Medium Changer                     ANSI SCSI revision: 02
st: Version 20020205, bufsize 32768, wrt 30720, max init. bufs 4, s/g segs 16
Attached scsi tape st0 at scsi1, channel 0, id 4, lun 0
sd: allocated major 8
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 3, lun 0
Attached scsi disk sdc at scsi0, channel 0, id 4, lun 0
sym53c896-0-<0,*>: FAST-20 WIDE SCSI 40.0 MB/s (50.0 ns, offset 31)
SCSI device sda: 71687372 512-byte hdwr sectors (36704 MB)
Partition check:
 sda: sda1 sda2 sda3
sym53c896-0-<3,*>: FAST-20 WIDE SCSI 40.0 MB/s (50.0 ns, offset 31)
SCSI device sdb: 17774160 512-byte hdwr sectors (9100 MB)
 sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 >
sym53c896-0-<4,*>: FAST-20 WIDE SCSI 40.0 MB/s (50.0 ns, offset 31)
SCSI device sdc: 17774160 512-byte hdwr sectors (9100 MB)
 sdc: sdc1 sdc2 sdc3
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 1, lun 0
sym53c896-0-<1,*>: FAST-20 WIDE SCSI 40.0 MB/s (50.0 ns, offset 15)
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.12
sg_attach: dev0=(21:0)
sg_attach: dev1=(21:1)
sg_attach: dev2=(21:2)
sg_attach: dev3=(21:3)
sg_attach: dev4=(21:4)
sg_attach: dev5=(21:5)
Attached scsi generic sg5 at scsi1, channel 0, id 4, lun 1,  type 8
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 64Kbytes
TCP: Hash tables configured (established 131072 bind 65536)
IPv4 over IPv4 tunneling driver
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Couldn't find valid RAM disk image starting at 0.
Freeing initrd memory: 1168k freed
cramfs: wrong magic
reiserfs: found format "3.6" with standard journal
reiserfs: checking transaction log (sd(8,3)) for (sd(8,3))
reiserfs: using ordered data mode
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 196k init
NIP: C000000000085874 XER: 0000000000000000 LR: C000000000085B24 REGS: c00000002ff86a30 TRAP: 0600    Not tainted
MSR: a000000000009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c00000002ff84000[1] 'swapper' Last syscall: 5 
last math 0000000000000000 
GPR00: C000000000085B24 C00000002FF86CB0 C0000000006A0000 C000000001F7E948 
GPR04: 0000000000002CDC 0000000000000019 0000000000000001 C0000000003DE300 
GPR08: C00000000074FB00 000000000003FFFF C00000000074DFC0 000006000000000F 
GPR12: 0000000000002CDC C00000002FF84000 0000000000000020 C00000002FF874B0 
GPR16: C00000002FF87620 C00000002FF875D0 0000000000000001 C00000000231B018 
GPR20: C00000002FF87628 C000000001CC5800 C000000001D950A0 0000000000002CDC 
GPR24: C000000001F7E948 0000000000000001 0000000000000019 0000000000002CDC 
GPR28: C000000001F7E948 00000000000000F0 C000000000486860 0000000000000019 
Call backtrace: 
C0000000000718A0 do_timer+0xd4
C000000000085B24 find_or_create_page+0xc4
C0000000000AA6A8 grow_dev_page+0x30
C0000000000AAA6C grow_buffers+0xd4
C0000000000A6B44 getblk+0x6c
C000000000170664 search_by_key_reada+0x58
C000000000170874 search_by_key+0x11c
C0000000001508BC search_by_entry_key+0x38
C000000000151100 reiserfs_find_entry+0xa4
C0000000001512F4 reiserfs_lookup+0x88
C0000000000B6B60 real_lookup+0x1e0
C0000000000B7448 link_path_walk+0x52c
C0000000000B7864 path_walk+0x18
C0000000000B86E4 open_namei+0x340
C0000000000A0BB4 filp_open+0x40
C0000000000A1160 sys_open+0xb0
C0000000000109F4 Unknown
C00000000000C424 init+0x78
C00000000001936C Unknown

Kernel panic: kernel access of bad area pc c000000000085874 lr c000000000085b24 address 29 tsk swapper/1
 <0>Rebooting in 180 seconds..~.

--Boundary-00=_b+eAFgYpC25MMUG--
