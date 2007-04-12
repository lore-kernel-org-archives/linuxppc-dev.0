Return-Path: <chrisw@cristie.com>
Received: from exchangesrv.cristie.co.uk (ip02.christiedata.adsl.gxn.net
	[195.147.204.218]) by ozlabs.org (Postfix) with ESMTP id 797A1DDE0A
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 21:36:03 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: Cannot open ramdisk
Date: Thu, 12 Apr 2007 11:37:08 +0100
Message-ID: <E1AF14BEE9B355499E146B179F69E9AF152EB9@exchangesrv.cristie.co.uk>
From: "Chris West" <chrisw@cristie.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> My ramdisk is a compressed 64MB ext3 filesystem in /ppc/chrp/system
>>=20
>> After the kernel has booted I get the following message:
>>=20
>> VFS: Cannot open root device "ram0" or unknown-block(1,0)
>> Please append a correct "root=3D" boot option
>>=20
>> I've read that only uncompressed kernels can load a ramdisk, is this =
still the case?
>> I have tried using an uncompressed kernel with the same results.
>>=20
>> Can anyone tell me why my ramdisk isn't being loaded?
>
> Not sure... what is the full kernel log and the messages from yaboot ?
> It's possible that your ramdisk is just too big for either yaboot or =
the
> kernel to cope...
>
> Also, the ramdisk should be compressed, is it ?

Thanks for your reply.

Is there a yaboot limit on the size of initrd?
Mine is about 15MB.

The ramdisk is 64MB uncompressed, compressed using gzip -9.

Here is the latest yaboot.conf:

init-message=3Dlinux
timeout=3D300
default=3Dlinux
image=3Dppc/chrp/kernel
        label=3Dlinux
        initrd=3Dppc/chrp/ramdisk.image.gz
        append=3D"root=3D/dev/ram0 console=3DttyS0"
        read-only

Here are the full logs:

Elapsed time since release of system processors: 2 mins 47 secs

Config file read, 164 bytes

linux
Welcome to yaboot version 1.3.13 (Red Hat 1.3.13-2.fc6)
Enter "help" to get some basic usage information
boot: linux
Please wait, loading kernel...
   Elf64 kernel loaded...
Loading ramdisk...
ramdisk loaded at 04300000, size: 14805 Kbytes
OF stdout device is: /pci@400000000110/isa@3/serial@i3f8
command line: ro root=3D/dev/ram0 console=3DttyS0
memory layout at init:
  alloc_bottom : 0000000005176000
  alloc_top    : 0000000030000000
  alloc_top_hi : 0000000080000000
  rmo_top      : 0000000030000000
  ram_top      : 0000000080000000
Looking for displays
opening PHB /pci@400000000110... done
opening PHB /pci@400000000112... done
instantiating rtas at 0x000000002fd0d000 ... done
0000000000000001 : starting cpu hw idx 0000000000000001... done
WARNING: maximum CPUs (1) exceeded: ignoring extras
copying OF device tree ...
Building dt strings...
Building dt structure...
Device tree strings 0x0000000005377000 -> 0x00000000053782d2
Device tree struct  0x0000000005379000 -> 0x0000000005380000
Calling quiesce ...
returning from prom_init
Using pSeries machine description
Found initrd at 0xc000000004300000:0xc000000005175774
Starting Linux PPC64 #5 Tue Apr 10 15:19:56 BST 2007
-----------------------------------------------------
ppc64_pft_size                =3D 0x0
physicalMemorySize            =3D 0x80000000
ppc64_caches.dcache_line_size =3D 0x80
ppc64_caches.icache_line_size =3D 0x80
htab_address                  =3D 0xc00000007c000000
htab_hash_mask                =3D 0x3ffff
-----------------------------------------------------
Linux version 2.6.18-1.2798.fc6 (root@fedora6ppc64) (gcc version 4.1.1 =
20061011
(Red Hat 4.1.1-30)) #5 Tue Apr 10 15:19:56 BST 2007
[boot]0012 Setup Arch
EEH: PCI Enhanced I/O Error Handling Enabled
PPC64 nvram contains 81920 bytes
[boot]0015 Setup Done
Built 1 zonelists.  Total pages: 524288
Kernel command line: ro root=3D/dev/ram0 console=3DttyS0
[boot]0020 XICS Init
i8259 legacy interrupt controller initialized
[boot]0021 XICS Done
PID hash table entries: 4096 (order: 12, 32768 bytes)
Using pSeries machine description
Found initrd at 0xc000000004300000:0xc000000005175774
Starting Linux PPC64 #5 Tue Apr 10 15:19:56 BST 2007
-----------------------------------------------------
ppc64_pft_size                =3D 0x0
physicalMemorySize            =3D 0x80000000
ppc64_caches.dcache_line_size =3D 0x80
ppc64_caches.icache_line_size =3D 0x80
htab_address                  =3D 0xc00000007c000000
htab_hash_mask                =3D 0x3ffff
-----------------------------------------------------
Linux version 2.6.18-1.2798.fc6 (root@fedora6ppc64) (gcc version 4.1.1 =
20061011
(Red Hat 4.1.1-30)) #5 Tue Apr 10 15:19:56 BST 2007
[boot]0012 Setup Arch
EEH: PCI Enhanced I/O Error Handling Enabled
PPC64 nvram contains 81920 bytes
[boot]0015 Setup Done
Built 1 zonelists.  Total pages: 524288
Kernel command line: ro root=3D/dev/ram0 console=3DttyS0
[boot]0020 XICS Init
i8259 legacy interrupt controller initialized
[boot]0021 XICS Done
PID hash table entries: 4096 (order: 12, 32768 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Memory: 1990260k/2097152k available (5808k kernel code, 106272k =
reserved, 968k d
ata, 373k bss, 224k init)
Security Framework v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 256
checking if image is initramfs...it isn't (no cpio magic); looks like an =
initrd
Freeing initrd memory: 14805k freed
NET: Registered protocol family 16
Failed to request PCI IO region on PCI domain 0000
Using INTC for W82c105 IDE controller.
IOMMU table initialized, virtual merging disabled
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
TCP established hash table entries: 262144 (order: 10, 6291456 bytes)
TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
Coda Kernel/Venus communications, v6.0.0, coda@cs.cmu.edu
NTFS driver 2.1.27 [Flags: R/O].
JFS: nTxBlock =3D 8192, nTxLock =3D 65536
SGI XFS with ACLs, large block/inode numbers, no debug enabled
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered=20
io scheduler deadline registered
io scheduler cfq registered (default)
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing =
disabled
serial8250.0: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
serial8250.0: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
serial8250.0: ttyS2 at I/O 0x898 (irq =3D 10) is a 16550A
Floppy drive(s): fd0 is 2.88M=20
FDC 0 is a National Semiconductor PC87306
RAMDISK driver initialized: 16 RAM disks of 65536K size 512 blocksize
loop: loaded (max 8 devices)
usbcore: registered new driver ub
Ethernet Channel Bonding Driver: v3.0.3 (March 23, 2006)=20
bonding: Warning: either miimon or arp_interval and arp_ip_target module =
paramet
ers must be specified, otherwise bonding will not detect link failures! =
see bond
ing.txt for details.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with =
idebus=3Dxx
ide-floppy driver 0.99.newide
Loading iSCSI transport class v2.0-685.<6>st: Version 20050830, fixed =
bufsize 32
768, s/g segs 256
usbmon: debugfs is not available
USB Universal Host Controller Interface driver v3.0
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
md: bitmap version 4.39
device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised: =
dm-devel@redhat.com
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
atkbd.c: keyboard reset failed on isa0060/serio1
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Cannot open root device "ram0" or unknown-block(1,0)
Please append a correct "root=3D" boot option
Kernel panic - not syncing: VFS: Unable to mount root fs on =
unknown-block(1,0)
 <0>Rebooting in 180 seconds..

Regards,
Chris
