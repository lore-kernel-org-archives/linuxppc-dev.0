Return-Path: <gregoire.banderet@ge.com>
Received: from ext-ch1gw-2.online-age.net (ext-ch1gw-2.online-age.net
	[216.34.191.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-ch1gw.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8C5BDDDE1D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Mar 2007 21:38:22 +1100 (EST)
Received: from int-ch1gw-4.online-age.net (int-ch1gw-4 [3.159.232.68])
	by ext-ch1gw-2.online-age.net (8.13.6/8.13.6/20051111-SVVS-TLS-DNSBL)
	with ESMTP id l2G9bTAZ029857 for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Mar 2007 05:37:29 -0400 (EDT)
Received: from cinmlef06.e2k.ad.ge.com (int-ch1gw-4 [3.159.232.68])
	by int-ch1gw-4.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id l2G9bSrd029004 for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Mar 2007 05:37:28 -0400 (EDT)
Message-ID: <45FA6550.3010604@ge.com>
Date: Fri, 16 Mar 2007 10:37:20 +0100
From: Gregoire Banderet <Gregoire.Banderet@ge.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Replacing initrd by ramfs, not syncing: VFS: Unable to mount root
	fs on unknown-block(1,0)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I have an MPC8349EMDS board with an 2.6.14 kernel and u-boot 1.1.5.

Until now I was building an uImage from the kernel, creating my own 
rootfs and creating an initrd from it. Then I was grouping vmlinux.gz 
and initrd.gz with 'mkimage'.
Everything was fine, booting like this
=> tftpboot 1000000 /tftp/uLinux-initrd.img
=> bootm 1000000

Now I try to use an initramfs instead of the initrd.
So, I create an cpio.gz archive from my rootfs:
find . | cpio -o -H newc | gzip > initramfs.gz
Then I run mkimage:
mkimage -n 'Linux 2.6 and initramfs' -A ppc -O linux -T multi -C gzip -a 
0x00000000 -e 0x00000000 -d 
$(OUTPUT_DIR)/kernel/vmlinux.gz:$(OUTPUT_DIR)/images/initramfs.gz 
$(OUTPUT_DIR)/images/uLinux-initramfs.img

And I try to boot:
=> setenv bootargs 
ip=3.137.218.182:3.137.218.1:3.111.43.96:255.255.255.0:freescale:eth0 
console=ttyS0,115200
=> tftpboot 1000000 /tftp/uLinux-initramfs.img
=> bootm 1000000

But it ends with a kernel panic:
Kernel panic - not syncing: VFS: Unable to mount root fs on 
unknown-block(1,0)

I have ram devices created:
 > ls -l dev/ram*
brw-r--r-- 1 root root 1,  0 Mar 16 10:08 dev/ram0
brw-r--r-- 1 root root 1,  1 Mar 16 10:08 dev/ram1
...

I did not change my kernel config.

Any idea what the kernel panic message means?

Thanks,
Greg.

Complete boot log:

## Booting image at 01000000 ...
    Image Name:   Linux 2.6 and initramfs
    Created:      2007-03-16   9:08:29 UTC
    Image Type:   PowerPC Linux Multi-File Image (gzip compressed)
    Data Size:    12003210 Bytes = 11.4 MB
    Load Address: 00000000
    Entry Point:  00000000
    Contents:
    Image 0:  1489619 Bytes =  1.4 MB
    Image 1: 10513578 Bytes = 10 MB
    Verifying Checksum ... OK
    Uncompressing Multi-File Image ... OK
    Loading Ramdisk to 0f5a7000, end 0ffadcaa ... OK
Linux version 2.6.14 (gregb@tux) (gcc version 3.4.4 (Wind River Linux)) 
#79 PREEMPT Fri Mar 16 10:08:02 CET 2007
Built 1 zonelists
Kernel command line: 
ip=3.137.218.182:3.137.218.1:3.111.43.96:255.255.255.0:freescale:eth0 
console=ttyS0,115200
IPIC (128 IRQ sources, 8 External IRQs) at fe000700
PID hash table entries: 2048 (order: 11, 32768 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 245760k available (2488k kernel code, 764k data, 116k init, 0k 
highmem)
Mount-cache hash table entries: 512
checking if image is initramfs... it is
Freeing initrd memory: 10267k freed
NET: Registered protocol family 16
PCI: Probing PCI hardware
PCI: Cannot allocate resource region 0 of device 0000:00:00.0
PCI: Cannot allocate resource region 2 of device 0000:00:00.0
PCI: Cannot allocate resource region 0 of device 0001:01:00.0
PCI: Cannot allocate resource region 2 of device 0001:01:00.0
PCI: Failed to allocate mem resource #2:80000000@0 for 0000:00:00.0
PCI: Failed to allocate mem resource #2:80000000@0 for 0001:01:00.0
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
JFFS2 version 2.2. (NAND) (C) 2001-2003 Red Hat, Inc.
Generic RTC Driver v1.07
Macintosh non-volatile memory driver v1.1
Software Watchdog Timer: 0.07 initialized. soft_noboot=0 soft_margin=60 
sec (nowayout= 0)
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
ttyS0 at MMIO map 0xe0004500 mem 0xfe004500 (irq = 9) is a 16550A
ttyS1 at MMIO map 0xe0004600 mem 0xfe004600 (irq = 10) is a 16550A
io scheduler noop registered
io scheduler deadline registered
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
nbd: registered device at major 43
eth0: Gianfar Ethernet Controller Version 1.1, 00:04:9f:ef:23:33
eth0: Running with NAPI disabled
eth0: 64/64 RX/TX BD ring size
eth1: Gianfar Ethernet Controller Version 1.1, 00:e0:0c:00:7e:21
eth1: Running with NAPI disabled
eth1: 64/64 RX/TX BD ring size
sata_sil(0000:00:11.0): cache line size not set.  Driver may not function
sata_sil 0000:00:11.0: Applying R_ERR on DMA activate FIS errata fix
ata1: SATA max UDMA/100 cmd 0xD1050E80 ctl 0xD1050E8A bmdma 0xD1050E00 
irq 20
ata2: SATA max UDMA/100 cmd 0xD1050EC0 ctl 0xD1050ECA bmdma 0xD1050E08 
irq 20
ata1: dev 0 ATA, max UDMA/100, 488397168 sectors: lba48
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
ata2: no device found (phy stat 00000000)
scsi1 : sata_sil
   Vendor: ATA       Model: HDS722525VLSA80   Rev: V36O
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sda: drive cache: write back
  sda: sda1
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
MPC8349MDS flash device: 800000 at fe000000 Partition number 4
MPC8349MDS Flash Map Info: Found 1 x16 devices at 0x0 in 16-bit bank
  Intel/Sharp Extended Query Table at 0x0031
Using buffer write method
cfi_cmdset_0001: Erase suspend on write enabled
Creating 4 MTD partitions on "MPC8349MDS Flash Map Info":
0x00000000-0x00020000 : "HRCW"
0x00020000-0x00600000 : "JFFS2"
0x00600000-0x00700000 : "Kernel"
0x00700000-0x00800000 : "U-Boot"
MPC8349MDS flash device initialized
driver fsl-usb2-mph, $Revision: 1.11 $
fsl-usb2: PIB present, but selecting SYS USB
fsl-usb: MPH @ 0xfe022100, irq 39
fsl-usb2-mph fsl-usb2-mph.1: fsl usb20
fsl-usb2-mph fsl-usb2-mph.1: new USB bus registered, assigned bus number 1
fsl-usb2-mph fsl-usb2-mph.1: irq 39, io mem 0xfe022100
fsl-usb2-mph fsl-usb2-mph.1: park 0
fsl-usb2-mph fsl-usb2-mph.1: USB 0.0 initialized, EHCI 1.00, driver 
$Revision: 1.11 $
usb usb1: Product: fsl usb20
usb usb1: Manufacturer: Linux 2.6.14 fsl-usb2-mph
usb usb1: SerialNumber: fsl-usb2-mph.1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
fsl-usb2-mph fsl-usb2-mph.1: park 0
fsl-usb2-mph fsl-usb2-mph.1: USB 0.0 restarted, EHCI 1.00, driver 
$Revision: 1.11 $
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
i2c /dev entries driver
Advanced Linux Sound Architecture Driver Version 1.0.10rc1 (Mon Sep 12 
08:13:09 2005 UTC).
usbcore: registered new driver snd-usb-audio
ALSA device list:
   No soundcards found.
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 4, 65536 bytes)
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
usb 1-2: new high speed USB device using fsl-usb2-mph and address 2
hub 1-2:1.0: USB hub found
hub 1-2:1.0: 4 ports detected
eth0: PHY is Marvell 88E1101/88E1111 (1410cc2)
usb 1-2.2: new high speed USB device using fsl-usb2-mph and address 3
usb 1-2.2: Product: DaVinci based VCE module - 
SN12010160000000000026-0-V4.0.0.39851
usb 1-2.2: Manufacturer: GE Security - VisioWave
usb 1-2.3: new high speed USB device using fsl-usb2-mph and address 4
usb 1-2.3: Product: DaVinci based VCE module - 
SN12010160000000000002-0-V4.0.0.39851
usb 1-2.3: Manufacturer: GE Security - VisioWave
usb 1-2.4: new high speed USB device using fsl-usb2-mph and address 5
usb 1-2.4: Product: DaVinci based VCE module - 
SN12010160000000000027-0-V4.0.0.39851
usb 1-2.4: Manufacturer: GE Security - VisioWave
IP-Config: Gateway not on directly connected network.
Kernel panic - not syncing: VFS: Unable to mount root fs on 
unknown-block(1,0)
  <0>Rebooting in 180 seconds..
