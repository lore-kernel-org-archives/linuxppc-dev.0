Message-ID: <20010806135001.17880.qmail@web13802.mail.yahoo.com>
Date: Mon, 6 Aug 2001 06:50:01 -0700 (PDT)
From: Sigurdur Asgeirsson <sigurasg@yahoo.com>
Reply-To: siggi@undo.com
Subject: 2.4.7, PCI & Promise/66 Problems
To: LinuxPPC-dev <linuxppc-dev@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have a SuperMac S-900 with dual 604e processors & an IMSTT 2Mb
video card. I've been trying to get both the Promise/66 card and SMP
to work simultaneously, but without success so far.
I've tried the YDL 2.4.4 kernel compiled for SMP, but this freezes on
the IDE partition check right after finding the Promise card (it
works fine in a single processor configuration).
I then downloaded the stock 2.4.7 kernel from kernel.org and patched
it with the SUSE patch set at
ftp://ftp.suse.com/pub/suse/ppc/update/BETA/kernel/patches/. This
seems to have problems mapping the PCI resources of the bridges
and/or the Promise card.
Below is /var/log/dmesg from the 2.4.7 kernel - anyone have a
suggestion on how to proceed?

Total memory = 112MB; using 512kB for hash table (at c0380000)
Linux version 2.4.7-suse-SMP-SMP (root@slowpoke) (gcc version 2.95.3
20010111 (prerelease/franzo/20010111)) #4 SMP Sun Aug 5 21:10:24 EDT
2001
Cache coherency enabled for bandit/PSX at 00000000
Found Bandit PCI host bridge at 0xf2000000. Firmware bus number: 0->1
On node 0 totalpages: 28672
zone(0): 28672 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/sdb6 video=imsttfb:vmode:17,cmode:8
System has 32 possible interrupts
GMT Delta read from XPRAM: -300 minutes, DST: off
via_calibrate_decr: ticks per jiffy = 129599 (777596 ticks)
Console: colour dummy device 80x25
Calibrating delay loop... 362.08 BogoMIPS
Memory: 108708k available (1784k kernel code, 1112k data, 296k init,
0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
POSIX conformance testing by UNIFIX
Entering SMP Mode...
Processor 1 found.
PCI: Probing PCI hardware
Scanning bus 00
Found 00:58 [106b/0001] 000600 00
Found 00:68 [105a/4d38] 000180 00
Found 00:70 [1244/0a00] 000280 00
Found 00:78 [1011/0021] 000604 01
Found 00:80 [106b/0002] 00ff00 00
Fixups for bus 00
Scanning behind PCI bridge 00:0f.0, config 010100, pass 0
Scanning bus 01
Found 01:00 [10e0/9128] 000380 00
Fixups for bus 01
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 2: assuming transparent
Bus scan for 01 returning with max=01
Scanning behind PCI bridge 00:0f.0, config 010100, pass 1
Bus scan for 00 returning with max=01
PCI: Cannot allocate resource region 2 of PCI bridge 1
PCI: resource is 80000000..8fffffff (200), parent c033d068
PCI:00:10.0: Resource 0: f3000000-f301ffff (f=200)
PCI:01:00.0: Resource 0: 82000000-82ffffff (f=1208)
PCI: Cannot allocate resource region 0 of device 01:00.0
PCI:  parent is c033d068: 80000000-8fffffff (f=200)
PCI:00:0d.0: Resource 0: 00001090-00001097 (f=101)
PCI: Cannot allocate resource region 0 of device 00:0d.0
PCI:  parent is c033d030: 00000000-007fffff (f=100)
PCI:00:0d.0: Resource 1: 00001080-00001083 (f=101)
PCI: Cannot allocate resource region 1 of device 00:0d.0
PCI:  parent is c033d030: 00000000-007fffff (f=100)
PCI:00:0d.0: Resource 2: 00001070-00001077 (f=101)
PCI: Cannot allocate resource region 2 of device 00:0d.0
PCI:  parent is c033d030: 00000000-007fffff (f=100)
PCI:00:0d.0: Resource 3: 00001060-00001063 (f=101)
PCI: Cannot allocate resource region 3 of device 00:0d.0
PCI:  parent is c033d030: 00000000-007fffff (f=100)
PCI:00:0d.0: Resource 4: 00001000-0000103f (f=101)
PCI: Cannot allocate resource region 4 of device 00:0d.0
PCI:  parent is c033d030: 00000000-007fffff (f=100)
PCI:00:0d.0: Resource 5: 84020000-8403ffff (f=200)
PCI:00:0e.0: Resource 0: 84000000-8400001f (f=200)
PCI:00:0e.0: Resource 1: 00001040-0000105f (f=101)
PCI: Cannot allocate resource region 1 of device 00:0e.0
PCI:  parent is c033d030: 00000000-007fffff (f=100)
PCI: Failed to allocate resource 0(800000-7fffff) for 00:0d.0
PCI: Failed to allocate resource 1(800000-7fffff) for 00:0d.0
PCI: Failed to allocate resource 2(800000-7fffff) for 00:0d.0
PCI: Failed to allocate resource 3(800000-7fffff) for 00:0d.0
PCI: Failed to allocate resource 4(800000-7fffff) for 00:0d.0
PCI: Failed to allocate resource 1(800000-7fffff) for 00:0e.0
  got res[81000000:81ffffff] for resource 0 of Integrated Micro
Solutions Inc. IMS9129 [Twin turbo 128]
PCI: Enabling device 00:0d.0 (0004 -> 0007)
Macintosh CUDA driver v0.5 for Unified ADB.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
devfs: v0.107 (20010709) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Console: switching to colour frame buffer device 128x48
fb0: IMS TT (IBM) frame buffer; 2MB vram; chip version 2
MacOS display is /bandit/pci-bridge/IMS,tt128mb
Using unsupported 1152x870 IMS,tt128mb at 82000020, depth=16,
pitch=2304
fb1: Open Firmware frame buffer device on
/bandit/pci-bridge/IMS,tt128mb
input0: Macintosh mouse button emulation
pty: 256 Unix98 ptys configured
block: queued sectors max/low 71968kB/23989kB, 256 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PDC20262: IDE controller on PCI bus 00 dev 68
PDC20262: chipset revision 1
PDC20262: not 100% native mode: will probe irqs later
PDC20262: ROM enabled at 0x84010000
PDC20262: (U)DMA Burst Bit DISABLED Primary PCI Mode Secondary MASTER
Mode.
    ide2: BM-DMA at 0x800000-0x800007, BIOS settings: hde:pio,
hdf:pio
PDC20262: port 0x800000 already claimed by ide2
loop: loaded (max 8 devices)
eth0: MACE at 00:05:9a:c0:6c:16, chip revision 9.64
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
scsi1 : MESH
mesh: target 0 synchronous at 5.0 MB/s
  Vendor: Quantum   Model: XP32150W          Rev: L912
  Type:   Direct-Access                      ANSI SCSI revision: 02
mesh: target 3 synchronous at 5.0 MB/s
  Vendor: MATSHITA  Model: CD-ROM CR-506     Rev: 8S05
  Type:   CD-ROM                             ANSI SCSI revision: 02
mesh: target 4 synchronous at 5.0 MB/s
  Vendor: iomega    Model: jaz 1GB           Rev: H.72
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi2 : 53C94
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
Attached scsi removable disk sdb at scsi1, channel 0, id 4, lun 0
SCSI device sda: 4199760 512-byte hdwr sectors (2150 MB)
Partition check:
 /dev/scsi/host1/bus0/target0/lun0: [mac] p1 p2 p3 p4 p5 p6 p7 p8 p9
p10
SCSI device sdb: 2091050 512-byte hdwr sectors (1071 MB)
sdb: Write Protect is off
 /dev/scsi/host1/bus0/target4/lun0: [mac] p1 p2 p3 p4 p5 p6
Attached scsi CD-ROM sr0 at scsi1, channel 0, id 3, lun 0
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.12
Macintosh non-volatile memory driver v1.0
adb devices: [2]: 2 5 [3]: 3 1
ADB keyboard at 2, handler 1
Detected ADB keyboard, type ISO, swapping keys.
input1: ADB HID on ID 2:2.05
ADB mouse at 3, handler set to 2
input2: ADB HID on ID 3:3.01
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-ohci.c: v5.2:USB OHCI Host Controller Driver
usb.c: registered new driver hid
hid.c: v1.16:USB HID support drivers
keybdev.c: Adding keyboard: input1
mouse0: PS/2 mouse device for input2
mouse1: PS/2 mouse device for input0
mice: PS/2 mouse device common for all mice
event0: Event device for input2
event1: Event device for input1
event2: Event device for input0
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 256 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
EXT2-fs warning: feature flags set on rev 0 fs, running e2fsck is
recommended
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 296k init 4k chrp 36k prep
Adding Swap: 65528k swap-space (priority -1)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
