From: "maurie" <maurie@risc.sps.mot.com>
To: <linuxppc-dev@lists.linuxppc.org>
Cc: "'Maurie Ommerman'" <maurie@risc.sps.mot.com>
Subject: Linuxppc 8245 lost interrupt
Date: Thu, 10 Jul 2003 09:19:28 -0500
Message-ID: <000101c346ee$46545ac0$9b7c520a@sps.mot.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	I am building linux for the Sandpoint X3 with the Unity (MPC8245
V1.1).  I have attempted this boot with all available speeds and bus speeds
with the same result.
	I have used the same linux kernel with this Sandpoint X3 and a VAlis
(MPC7457) and it reads the harddrive and boots correctly.
	I am using kernel 2.4.21-rc1.
	I have the sandpoint switches set for default.  I have the PMC
switches set for default, except that I have PROGMODE set to Swap local
flash to program and M66EN set to 33 MHz PCI only.
	My problem is that on the 8245, linux will recognize the harddrive,
but then it gets "lost interrupt" while attempting to read the partition
table and later when trying to boot from this hard drive.
	I added some printk statements to ide-io.c to see the flow and it
must have changed the timing so that I get additional messages about the
host losing the IRQ.
	I am including the printout from both builds.
	The "MLO" designation is my idication of areas that I have touched
or just printed to ensure that I was changing the code.
	I would like any suggestions on how to fix this problem.

Thank you,

Maurie Ommerman
maurie@risc.sps.mot.com

Linus kernel boot with out my ide debug
messages:=====================================
I/O system initialized...
Memory Enabled: [ 128MB at CL=3 ]
Caches Enabled: [ L1I(16K), L1D(16K) ]
Register Inits: [ 32 GPRs, 32 FPRs, 222 SPRs ]


                 ##  ##            ##
                 ##  ##            ##
                 ##                ##
            #######  ##  #######   ##    ##
           ##    ##  ##  ##    ##  ##   ##
           ##    ##  ##  ##    ##  ######
           ##    ##  ##  ##    ##  ##   ##
            ######   ##  ##    ##  ##    ##


   Version : 13.1.1, Metaware Build
  Released : May 13, 2003 Built on May 13 2003 13:09:37
Written by : Motorola's RISC Applications Group, Austin, TX
    System : Sandpoint X3 with Unity (MPMC8245)
 Processor : MPC8245 V1.1 @ 332 MHz, 133 MHz memory
    Memory : Map B (CHRP) 128MB at CL=3

Copyright Motorola Inc. 1993-2003
Refer to `history.c' for release info, changes, errata and fixes.


DINK32[MPC8245] {1} >>dl -nw -b -o800000 -fzImage.sandpoint_8245_6
Filename = zImage.sandpoint_8245_6
File format =  Plain binary
Offset = 0x00800000
Received 2308 TFTP data blocks.

Successfully read 1181380 bytes via TFTP at  1373953 bytes/sec


DINK32[MPC8245] {2} >>go 810000
loaded at:     00810000 009221D8
relocated to:  00800000 009121D8
zimage at:     0080590B 0090E937
avail ram:     00400000 00800000

Linux/PPC load: root=/dev/hda3
Uncompressing Linux...done.
MLO: Now booting the kernel
Memory BAT mapping: BAT2=128Mb, BAT3=0Mb, residual: 0Mb
Linux version 2.4.21-rc1 (maurie@localhost.localdomain) (gcc version 3.3)
#81 We
d Jul 9 10:14:19 EDT 2003
Motorola SPS Sandpoint Test Platform
Port by MontaVista Software, Inc. (source@mvista.com)
On node 0 totalpages: 32768
zone(0): 32768 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/hda3
OpenPIC Version 1.2 (1 CPUs and 11 IRQ sources) at fdfd0000
OpenPIC timer frequency is 133.000000 MHz
time_init: decrementer frequency = 33.002375 MHz
JPAN READ GTCCR=fecf2250
Calibrating delay loop... 219.54 BogoMIPS
Memory: 127064k available (1676k kernel code, 700k data, 80k init, 0k
highmem)
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
initialize_kbd: Keyboard reset failed, no ACK
Detected PS/2 Mouse Port.
keyboard: Timeout - AT keyboard not present?(ed)
keyboard: Timeout - AT keyboard not present?(f4)
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI en
abled
ttyS00 at 0xfe0003f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
pcnet32.c:v1.27a 10.02.2002 tsbogend@alpha.franken.de
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
8139too Fast Ethernet driver 0.9.26
eth0: RealTek RTL8139 Fast Ethernet at 0xc9000f00, 00:40:f4:79:72:73, IRQ 19
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
W82C105: IDE controller at PCI slot 00:0b.1
W82C105: chipset revision 5
W82C105: 100% native mode on irq 16
    ide0: BM-DMA at 0xbfffd0-0xbfffd7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xbfffd8-0xbfffdf, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: WDC WD400BB-00CAA1, ATA DISK drive
hda: selected PIO 4 (120ns) (0240)
Probing IDE interface ide1...
ide1: Wait for ready failed before probe !
ide0 at 0xbffff8-0xbfffff,0xbffff6 on irq 14
hda: attached ide-disk driver.
hda: MLO:lost interrupt
hda: MLO:lost interrupt
hda: MLO:lost interrupt
hda: host protected area => 1
hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=77545/16/63
ide-floppy driver 0.99.newide
Partition check:
 /dev/ide/host0/bus0/target0/lun0:<3>hda: MLO:lost interrupt
hda: MLO:lost interrupt
hda: MLO:lost interrupt
hda: MLO:lost interrupt
hda: MLO:lost interrupt
hda: MLO:lost interrupt
hda: MLO:lost interrupt
hda: MLO:lost interrupt
 p1 p2 p3 p4
ide-floppy driver 0.99.newide
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
hda: MLO:lost interrupt
hda: MLO:lost interrupt
hda: MLO:lost interrupt
hda: MLO:lost interrupt
hda: MLO:lost interrupt
hda: MLO:lost interrupt
hda: MLO:lost interrupt
hda: MLO:lost interrupt
hda: MLO:lost interrupt
hda: MLO:lost interrupt
hda: MLO:lost interrupt
hda: MLO:lost interrupt
hda: MLO:lost interrupt
hda: MLO:lost interrupt
hda: MLO:lost interrupt
hda: MLO:lost interrupt
hda: MLO:lost interrupt
hda: MLO:lost interrupt
hda: MLO:lost interrupt
hda: MLO:lost interrupt
hda: MLO:lost interrupt
hda: MLO:lost interrupt
hda: MLO:lost interrupt
hda: MLO:lost interrupt
hda: MLO:lost interrupt
hda: MLO:lost interrupt
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 80k init
hda: MLO:lost interrupt
hda: MLO:lost interrupt
hda: MLO:lost interrupt
hda: MLO:lost interrupt
hda: MLO:lost interrupt


Linus kernel boot with  my ide debug
messages:=====================================

I/O system initialized...
Memory Enabled: [ 128MB at CL=3 ]
Caches Enabled: [ L1I(16K), L1D(16K) ]
Register Inits: [ 32 GPRs, 32 FPRs, 222 SPRs ]


                 ##  ##            ##
                 ##  ##            ##
                 ##                ##
            #######  ##  #######   ##    ##
           ##    ##  ##  ##    ##  ##   ##
           ##    ##  ##  ##    ##  ######
           ##    ##  ##  ##    ##  ##   ##
            ######   ##  ##    ##  ##    ##


   Version : 13.1.1, Metaware Build
  Released : May 13, 2003 Built on May 13 2003 13:09:37
Written by : Motorola's RISC Applications Group, Austin, TX
    System : Sandpoint X3 with Unity (MPMC8245)
 Processor : MPC8245 V1.1 @ 332 MHz, 133 MHz memory
    Memory : Map B (CHRP) 128MB at CL=3

Copyright Motorola Inc. 1993-2003
Refer to `history.c' for release info, changes, errata and fixes.


DINK32[MPC8245] {1} >>dl -nw -b -o800000 -fzImage.sandpoint_8245_14
Filename = zImage.sandpoint_8245_14
File format =  Plain binary
Offset = 0x00800000
Received 2308 TFTP data blocks.

Successfully read 1181380 bytes via TFTP at  1390732 bytes/sec


DINK32[MPC8245] {2} >>go 810000
loaded at:     00810000 009221D8
relocated to:  00800000 009121D8
zimage at:     0080590B 0090E8B0
avail ram:     00400000 00800000

Linux/PPC load: root=/dev/hda3
Uncompressing Linux...done.
MLO: Now booting the kernel
Memory BAT mapping: BAT2=128Mb, BAT3=0Mb, residual: 0Mb
Linux version 2.4.21-rc1 (maurie@localhost.localdomain) (gcc version 3.3)
#94 We
d Jul 9 16:21:00 EDT 2003
Motorola SPS Sandpoint Test Platform
Port by MontaVista Software, Inc. (source@mvista.com)
On node 0 totalpages: 32768
zone(0): 32768 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/hda3
OpenPIC Version 1.2 (1 CPUs and 11 IRQ sources) at fdfd0000
OpenPIC timer frequency is 133.000000 MHz
time_init: decrementer frequency = 33.002375 MHz
Calibrating delay loop... 219.54 BogoMIPS
Memory: 127064k available (1676k kernel code, 700k data, 80k init, 0k
highmem)
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
initialize_kbd: Keyboard reset failed, no ACK
Detected PS/2 Mouse Port.
keyboard: Timeout - AT keyboard not present?(ed)
keyboard: Timeout - AT keyboard not present?(f4)
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI en
abled
ttyS00 at 0xfe0003f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
pcnet32.c:v1.27a 10.02.2002 tsbogend@alpha.franken.de
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
8139too Fast Ethernet driver 0.9.26
eth0: RealTek RTL8139 Fast Ethernet at 0xc9000f00, 00:40:f4:79:72:73, IRQ 19
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
W82C105: MLO:IDE controller at PCI slot 00:0b.1
W82C105: chipset revision 5
W82C105: 100% native mode on irq 16
    ide0: BM-DMA at 0xbfffd0-0xbfffd7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xbfffd8-0xbfffdf, BIOS settings: hdc:DMA, hdd:DMA
MLOProbing IDE interface ide0...
hda: WDC WD400BB-00CAA1, ATA DISK drive
hda: selected PIO 4 (120ns) (0240)
MLOProbing IDE interface ide1...
ide1: MLOWait for ready failed before probe !
ide0 at 0xbffff8-0xbfffff,0xbffff6 on irq 14
hda: MLO attached ide-disk driver.
 MLO:ide-timer-expiry1
 MLO:ide-timer-expiry2
 MLO:ide-timer-expiry3
 MLO:ide-timer-expiry6
 MLO:ide-timer-expiry8
sl82c105: lost IRQ: resetting host
sl82c105: drive was requesting IRQ, but host lost it
hda: MLO:lost interrupt
 MLO:ide-timer-expiry13
 MLO:ide-timer-expiry14
 MLO:ide-timer-expiry15
 MLO:ide-timer-expiry16
 MLO:ide-timer-expiry1
 MLO:ide-timer-expiry2
 MLO:ide-timer-expiry3
 MLO:ide-timer-expiry6
 MLO:ide-timer-expiry8
sl82c105: lost IRQ: resetting host
sl82c105: drive was requesting IRQ, but host lost it
hda: MLO:lost interrupt
 MLO:ide-timer-expiry13
 MLO:ide-timer-expiry14
 MLO:ide-timer-expiry15
 MLO:ide-timer-expiry16
 MLO:ide-timer-expiry1
 MLO:ide-timer-expiry2
 MLO:ide-timer-expiry3
 MLO:ide-timer-expiry6
 MLO:ide-timer-expiry8
sl82c105: lost IRQ: resetting host
sl82c105: drive was requesting IRQ, but host lost it
hda: MLO:lost interrupt
 MLO:ide-timer-expiry13
 MLO:ide-timer-expiry14
 MLO:ide-timer-expiry15
 MLO:ide-timer-expiry16
hda: host protected area => 1
hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=77545/16/63
ide-floppy driver 0.99.newide
Partition check:
 /dev/ide/host0/bus0/target0/lun0:<3> MLO:ide-timer-expiry1
 MLO:ide-timer-expiry2
 MLO:ide-timer-expiry3
 MLO:ide-timer-expiry6
 MLO:ide-timer-expiry8
sl82c105: lost IRQ: resetting host
sl82c105: drive was requesting IRQ, but host lost it
hda: MLO:lost interrupt
 MLO:ide-timer-expiry13
 MLO:ide-timer-expiry15
 MLO:ide-timer-expiry16
 MLO:ide-timer-expiry1
 MLO:ide-timer-expiry2
 MLO:ide-timer-expiry3
 MLO:ide-timer-expiry6
 MLO:ide-timer-expiry8
sl82c105: lost IRQ: resetting host
sl82c105: drive was requesting IRQ, but host lost it
hda: MLO:lost interrupt
 MLO:ide-timer-expiry13
 MLO:ide-timer-expiry15
 MLO:ide-timer-expiry16
 MLO:ide-timer-expiry1
 MLO:ide-timer-expiry2
 MLO:ide-timer-expiry3
 MLO:ide-timer-expiry6
 MLO:ide-timer-expiry8
sl82c105: lost IRQ: resetting host
sl82c105: drive was requesting IRQ, but host lost it
hda: MLO:lost interrupt
 MLO:ide-timer-expiry13
 MLO:ide-timer-expiry15
 MLO:ide-timer-expiry16
 MLO:ide-timer-expiry1
 MLO:ide-timer-expiry2
 MLO:ide-timer-expiry3
 MLO:ide-timer-expiry6
 MLO:ide-timer-expiry8
sl82c105: lost IRQ: resetting host
sl82c105: drive was requesting IRQ, but host lost it
hda: MLO:lost interrupt
 MLO:ide-timer-expiry13
 MLO:ide-timer-expiry15
 MLO:ide-timer-expiry16
 MLO:ide-timer-expiry1
 MLO:ide-timer-expiry2
 MLO:ide-timer-expiry3
 MLO:ide-timer-expiry6
 MLO:ide-timer-expiry8
sl82c105: lost IRQ: resetting host
sl82c105: drive was requesting IRQ, but host lost it
hda: MLO:lost interrupt
 MLO:ide-timer-expiry13
 MLO:ide-timer-expiry15
 MLO:ide-timer-expiry16
 MLO:ide-timer-expiry1
 MLO:ide-timer-expiry2
 MLO:ide-timer-expiry3
 MLO:ide-timer-expiry6
 MLO:ide-timer-expiry8
sl82c105: lost IRQ: resetting host
sl82c105: drive was requesting IRQ, but host lost it
hda: MLO:lost interrupt
 MLO:ide-timer-expiry13
 MLO:ide-timer-expiry15
 MLO:ide-timer-expiry16
 MLO:ide-timer-expiry1
 MLO:ide-timer-expiry2
 MLO:ide-timer-expiry3
 MLO:ide-timer-expiry6
 MLO:ide-timer-expiry8
sl82c105: lost IRQ: resetting host
sl82c105: drive was requesting IRQ, but host lost it
hda: MLO:lost interrupt
 MLO:ide-timer-expiry13
 MLO:ide-timer-expiry15
 MLO:ide-timer-expiry16
 MLO:ide-timer-expiry1
 MLO:ide-timer-expiry2
 MLO:ide-timer-expiry3
 MLO:ide-timer-expiry6
 MLO:ide-timer-expiry8
sl82c105: lost IRQ: resetting host
sl82c105: drive was requesting IRQ, but host lost it
hda: MLO:lost interrupt
 MLO:ide-timer-expiry13
 MLO:ide-timer-expiry14
 MLO:ide-timer-expiry15
 MLO:ide-timer-expiry16
 p1 p2 p3 p4
ide-floppy driver 0.99.newide
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
 MLO:ide-timer-expiry1
 MLO:ide-timer-expiry2
 MLO:ide-timer-expiry3
 MLO:ide-timer-expiry6
 MLO:ide-timer-expiry8
sl82c105: lost IRQ: resetting host
sl82c105: drive was requesting IRQ, but host lost it
hda: MLO:lost interrupt
 MLO:ide-timer-expiry13
 MLO:ide-timer-expiry15
 MLO:ide-timer-expiry16
 MLO:ide-timer-expiry1
 MLO:ide-timer-expiry2
 MLO:ide-timer-expiry3
 MLO:ide-timer-expiry6
 MLO:ide-timer-expiry8
sl82c105: lost IRQ: resetting host
sl82c105: drive was requesting IRQ, but host lost it
hda: MLO:lost interrupt
 MLO:ide-timer-expiry13
 MLO:ide-timer-expiry14
 MLO:ide-timer-expiry15
 MLO:ide-timer-expiry16
 MLO:ide-timer-expiry1
 MLO:ide-timer-expiry2
 MLO:ide-timer-expiry3
 MLO:ide-timer-expiry6
 MLO:ide-timer-expiry8
sl82c105: lost IRQ: resetting host
sl82c105: drive was requesting IRQ, but host lost it
hda: MLO:lost interrupt
 MLO:ide-timer-expiry13
 MLO:ide-timer-expiry15
 MLO:ide-timer-expiry16
 MLO:ide-timer-expiry1
 MLO:ide-timer-expiry2
 MLO:ide-timer-expiry3
 MLO:ide-timer-expiry6
 MLO:ide-timer-expiry8
sl82c105: lost IRQ: resetting host
sl82c105: drive was requesting IRQ, but host lost it
hda: MLO:lost interrupt
 MLO:ide-timer-expiry13
 MLO:ide-timer-expiry15
 MLO:ide-timer-expiry16
 MLO:ide-timer-expiry1
 MLO:ide-timer-expiry2
 MLO:ide-timer-expiry3
 MLO:ide-timer-expiry6
 MLO:ide-timer-expiry8
sl82c105: lost IRQ: resetting host
sl82c105: drive was requesting IRQ, but host lost it
hda: MLO:lost interrupt
 MLO:ide-timer-expiry13
 MLO:ide-timer-expiry15
 MLO:ide-timer-expiry16
 MLO:ide-timer-expiry1
 MLO:ide-timer-expiry2
 MLO:ide-timer-expiry3
 MLO:ide-timer-expiry6
 MLO:ide-timer-expiry8
sl82c105: lost IRQ: resetting host
sl82c105: drive was requesting IRQ, but host lost it
hda: MLO:lost interrupt
 MLO:ide-timer-expiry13
 MLO:ide-timer-expiry15
 MLO:ide-timer-expiry16
 MLO:ide-timer-expiry1
 MLO:ide-timer-expiry2
 MLO:ide-timer-expiry3
 MLO:ide-timer-expiry6
 MLO:ide-timer-expiry8
sl82c105: lost IRQ: resetting host
sl82c105: drive was requesting IRQ, but host lost it
hda: MLO:lost interrupt
 MLO:ide-timer-expiry13
 MLO:ide-timer-expiry15
 MLO:ide-timer-expiry16
 MLO:ide-timer-expiry1
 MLO:ide-timer-expiry2
 MLO:ide-timer-expiry3
 MLO:ide-timer-expiry6
 MLO:ide-timer-expiry8
sl82c105: lost IRQ: resetting host
sl82c105: drive was requesting IRQ, but host lost it
hda: MLO:lost interrupt
 MLO:ide-timer-expiry13
 MLO:ide-timer-expiry15
 MLO:ide-timer-expiry16
 MLO:ide-timer-expiry1
 MLO:ide-timer-expiry2
 MLO:ide-timer-expiry3
 MLO:ide-timer-expiry6
 MLO:ide-timer-expiry8
sl82c105: lost IRQ: resetting host
sl82c105: drive was requesting IRQ, but host lost it
hda: MLO:lost interrupt
 MLO:ide-timer-expiry13
 MLO:ide-timer-expiry15
 MLO:ide-timer-expiry16
 MLO:ide-timer-expiry1
 MLO:ide-timer-expiry2
 MLO:ide-timer-expiry3
 MLO:ide-timer-expiry6
 MLO:ide-timer-expiry8
sl82c105: lost IRQ: resetting host
sl82c105: drive was requesting IRQ, but host lost it
hda: MLO:lost interrupt
 MLO:ide-timer-expiry13
 MLO:ide-timer-expiry14
 MLO:ide-timer-expiry15
 MLO:ide-timer-expiry16
 MLO:ide-timer-expiry1
 MLO:ide-timer-expiry2
 MLO:ide-timer-expiry3
 MLO:ide-timer-expiry6
 MLO:ide-timer-expiry8
sl82c105: lost IRQ: resetting host
sl82c105: drive was requesting IRQ, but host lost it
hda: MLO:lost interrupt
 MLO:ide-timer-expiry13
 MLO:ide-timer-expiry15
 MLO:ide-timer-expiry16
 MLO:ide-timer-expiry1
 MLO:ide-timer-expiry2
 MLO:ide-timer-expiry3
 MLO:ide-timer-expiry6
 MLO:ide-timer-expiry8
sl82c105: lost IRQ: resetting host
sl82c105: drive was requesting IRQ, but host lost it
hda: MLO:lost interrupt
 MLO:ide-timer-expiry13
 MLO:ide-timer-expiry15
 MLO:ide-timer-expiry16
 MLO:ide-timer-expiry1
 MLO:ide-timer-expiry2
 MLO:ide-timer-expiry3
 MLO:ide-timer-expiry6
 MLO:ide-timer-expiry8
sl82c105: lost IRQ: resetting host
sl82c105: drive was requesting IRQ, but host lost it
hda: MLO:lost interrupt
 MLO:ide-timer-expiry13
 MLO:ide-timer-expiry15
 MLO:ide-timer-expiry16
 MLO:ide-timer-expiry1
 MLO:ide-timer-expiry2
 MLO:ide-timer-expiry3
 MLO:ide-timer-expiry6
 MLO:ide-timer-expiry8
sl82c105: lost IRQ: resetting host
sl82c105: drive was requesting IRQ, but host lost it
hda: MLO:lost interrupt
 MLO:ide-timer-expiry13
 MLO:ide-timer-expiry15
 MLO:ide-timer-expiry16
 MLO:ide-timer-expiry1
 MLO:ide-timer-expiry2
 MLO:ide-timer-expiry3
 MLO:ide-timer-expiry6
 MLO:ide-timer-expiry8
sl82c105: lost IRQ: resetting host
sl82c105: drive was requesting IRQ, but host lost it
hda: MLO:lost interrupt
 MLO:ide-timer-expiry13
 MLO:ide-timer-expiry15
 MLO:ide-timer-expiry16
 MLO:ide-timer-expiry1
 MLO:ide-timer-expiry2
 MLO:ide-timer-expiry3
 MLO:ide-timer-expiry6
 MLO:ide-timer-expiry8
sl82c105: lost IRQ: resetting host
sl82c105: drive was requesting IRQ, but host lost it
hda: MLO:lost interrupt
 MLO:ide-timer-expiry13
 MLO:ide-timer-expiry15
 MLO:ide-timer-expiry16
 MLO:ide-timer-expiry1
 MLO:ide-timer-expiry2
 MLO:ide-timer-expiry3
 MLO:ide-timer-expiry6
 MLO:ide-timer-expiry8
sl82c105: lost IRQ: resetting host
sl82c105: drive was requesting IRQ, but host lost it
hda: MLO:lost interrupt
 MLO:ide-timer-expiry13
 MLO:ide-timer-expiry15
 MLO:ide-timer-expiry16
 MLO:ide-timer-expiry1
 MLO:ide-timer-expiry2
 MLO:ide-timer-expiry3
 MLO:ide-timer-expiry6
 MLO:ide-timer-expiry8
sl82c105: lost IRQ: resetting host
sl82c105: drive was requesting IRQ, but host lost it
hda: MLO:lost interrupt
 MLO:ide-timer-expiry13
 MLO:ide-timer-expiry14
 MLO:ide-timer-expiry15
 MLO:ide-timer-expiry16
 MLO:ide-timer-expiry1
 MLO:ide-timer-expiry2
 MLO:ide-timer-expiry3
 MLO:ide-timer-expiry6
 MLO:ide-timer-expiry8
sl82c105: lost IRQ: resetting host
sl82c105: drive was requesting IRQ, but host lost it
hda: MLO:lost interrupt
 MLO:ide-timer-expiry13
 MLO:ide-timer-expiry15
 MLO:ide-timer-expiry16
 MLO:ide-timer-expiry1
 MLO:ide-timer-expiry2
 MLO:ide-timer-expiry3
 MLO:ide-timer-expiry6
 MLO:ide-timer-expiry8
sl82c105: lost IRQ: resetting host
sl82c105: drive was requesting IRQ, but host lost it
hda: MLO:lost interrupt
 MLO:ide-timer-expiry13
 MLO:ide-timer-expiry15
 MLO:ide-timer-expiry16
 MLO:ide-timer-expiry1
 MLO:ide-timer-expiry2
 MLO:ide-timer-expiry3
 MLO:ide-timer-expiry6
 MLO:ide-timer-expiry8
sl82c105: lost IRQ: resetting host
sl82c105: drive was requesting IRQ, but host lost it
hda: MLO:lost interrupt
 MLO:ide-timer-expiry13
 MLO:ide-timer-expiry15
 MLO:ide-timer-expiry16
 MLO:ide-timer-expiry1
 MLO:ide-timer-expiry2
 MLO:ide-timer-expiry3
 MLO:ide-timer-expiry6
 MLO:ide-timer-expiry8
sl82c105: lost IRQ: resetting host
sl82c105: drive was requesting IRQ, but host lost it
hda: MLO:lost interrupt
 MLO:ide-timer-expiry13
 MLO:ide-timer-expiry15
 MLO:ide-timer-expiry16


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
