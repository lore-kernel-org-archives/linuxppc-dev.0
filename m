Return-Path: <Orges.Furxhi@thyssenkrupp.com>
Received: from mail001.triaton.com (mail001.triaton.com [149.250.222.55])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "mail001.triaton.com",
	Issuer "TC TrustCenter for Security in Data Networks GmbH" (not
	verified)) by ozlabs.org (Postfix) with ESMTP id 3432F67A3E
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 29 Jul 2006 01:25:13 +1000 (EST)
Message-ID: <162B449665D6D643AD9E1D50FC6F4B14042F1C93@mdcexc05.na.ops.local>
From: "Furxhi, Orges" <Orges.Furxhi@thyssenkrupp.com>
To: "'Igor Luri'" <iluri@fagorautomation.es>
Subject: USB flashdrive on Motorola MPC5200 (IceCube) board, linux kernel
	2.4.25 (DENX drop)
Date: Fri, 28 Jul 2006 09:53:37 -0500
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Igor, and anyone else who can help, 

About 1 month ago you replied to one of my messages on the board. I was
trying to get the USB working as a mass storage device, mainly to be used
for file transfer, but I was having no success so I stopped working on that
and got on to other parts of the project. Now I got back on it. 

I have a LITE5200 Version 2.0 board and I have loaded the latest DENX drop
of the 2.4 kernel on it. When I plug in the usb flash drive I get the
following message:

Usb.c: USB device not accepting new address=4 (error=-110)   
Usb.c: USB device not accepting new address=5 (error=-110)

I must be doing something wrong, and I do not know what it is.

You said that you had the same board and kernel and that your USB as mass
storage was working. Could you please send me your kernel's .config file so
that I can compare it with mine? 
  
Thanks,

Orges


-----Original Message-----
From: Igor Luri [mailto:iluri@fagorautomation.es] 
Sent: Wednesday, June 14, 2006 8:57 AM
To: Furxhi, Orges
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: USB flashdrive on Motorola MPC5200 (IceCube) board, linux
kernel 2.4.20

It is posible that your kernel uses old USB code. We also have an 
Icecube board, the same board a yours, with linux 2.4.25 version from 
DENX and USB works well.

You can try with this kernel:

ftp://ftp.denx.de/pub/linux/linuxppc_2_4_devel-2006-04-06-1735.tar.bz2


Hope this helps.


Furxhi, Orges wrote:

>Thank you for your help.
>
>I am using a Memorex travel drive 2.0 (512 MB), and I also have a
>Intelligent Stick 2.0 from GE. 
>When I plug in the Memorex stick the following appears on the terminal :
>	# hub.c: new USB device builtin-1, assigned address 2
>	usb.c: USB device not accepting new address=2 (error=-110)
>	hub.c: new USB device builtin-1, assigned address 3
>	usb.c: USB device not accepting new address=3 (error=-110)
>
>When I plug in the GE stick nothing shows on the terminal, but when I
remove
>it the following message comes up: 
>	# hub.c: connect-debounce failed, port 1 disabled
>
>Both the USB flash drives work on my Dell PC with RedHat 9.0 (2.4.20
>kernel).
>
>Orges
>  
>
>
>-----Original Message-----
>From: Igor Luri [mailto:iluri@fagorautomation.es] 
>Sent: Wednesday, June 14, 2006 3:07 AM
>To: Furxhi, Orges
>Cc: linuxppc-embedded@ozlabs.org
>Subject: Re: USB flashdrive on Motorola MPC5200 (IceCube) board, linux
>kernel 2.4.20
>
>What kind of USB flash drive are you using? Linux doesn't detect your 
>device.
>
>When you plug/unplug a USB device you have to get something like this:
>
>            hub.c: new USB device 0-1, assigned address 2
>            scsi0 : SCSI emulation for USB Mass Storage devices
>            Vendor: Model: USB DISK Pro Rev: 1.00
>            Type: Direct-Access ANSI SCSI revision: 02
>            Attached scsi removable disk sda at scsi0, channel 0, id 0,
>            lun 0
>            SCSI device sda: 240640 512-byte hdwr sectors (123 MB)
>            sda: Write Protect is off
>            sda: sda1
>
>            usb.c: USB disconnect on device 0-1 address 2
>
>
>Are you sure that this device is supported in your Linux configuration?
>
>
>
>Furxhi, Orges wrote:
>
>  
>
>>Hi all,
>>
>>I have been trying for days now to get my usb flashdrive to work on my 
>>Motorola MPC5200 (IceCube) board running on the 2.4.20 linux kernel. I 
>>have followed the instruction in this Flash Memory HOWTO article 
>>(http://www.tldp.org/HOWTO/Flash-Memory-HOWTO/index.html), but I have 
>>had no success.
>>
>>When I mount the usbfs filesystem (mount -t usbfs none /proc/bus/usb/) 
>>the following 3 items are created in the /proc/bus/usb/ directory:
>>
>>dr-xr-xr-x 1 root root 0 Jan 1 00:12 001
>>
>>-r--r--r-- 1 root root 0 Jan 1 00:12 devices
>>
>>-r--r--r-- 1 root root 0 Jan 1 00:12 drivers
>>
>># cat devices shows:
>>
>>T: Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#= 1 Spd=12 MxCh= 2
>>
>>B: Alloc= 0/900 us ( 0%), #Int= 0, #Iso= 0
>>
>>D: Ver= 1.10 Cls=09(hub ) Sub=00 Prot=00 MxPS= 8 #Cfgs= 1
>>
>>P: Vendor=0000 ProdID=0000 Rev= 0.00
>>
>>S: Product=USB OHCI Root Hub
>>
>>S: SerialNumber=f0001000
>>
>>C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr= 0mA
>>
>>I: If#= 0 Alt= 0 #EPs= 1 Cls=09(hub ) Sub=00 Prot=00 Driver=hub
>>
>>E: Ad=81(I) Atr=03(Int.) MxPS= 2 Ivl=255ms
>>
>># cat drivers shows
>>
>>usbdevfs
>>
>>hub
>>
>>usb-storage
>>
>>In the this Flash Memory-HOWTO it is mentioned that the usb-storage-x 
>>directory will be created in the /proc/scsi/ directory, but I do not 
>>see it on my system. Also the contents of /proc/scsi/scsi are 
>>"Attached devices: none".
>>
>>Following are my boot up messages:
>>
>>U-Boot 1.1.4 (Mar 21 2006 - 15:07:57)
>>
>>CPU: MPC5200 v1.2 at 462 MHz
>>
>>Bus 132 MHz, IPB 66 MHz, PCI 33 MHz
>>
>>Board: Motorola MPC5200 (IceCube)
>>
>>I2C: 85 kHz, ready
>>
>>DRAM: 64 MB
>>
>>FLASH: 8 MB
>>
>>In: serial
>>
>>Out: serial
>>
>>Err: serial
>>
>>Net: FEC ETHERNET
>>
>>Type "run flash_nfs" to mount root filesystem over NFS
>>
>>Hit any key to stop autoboot: 0
>>
>>## Booting image at ff900000 ...
>>
>>Image Name: Linux-2.4.20_mvl31-lite5200
>>
>>Created: 2006-06-13 21:40:05 UTC
>>
>>Image Type: PowerPC Linux Kernel Image (gzip compressed)
>>
>>Data Size: 989480 Bytes = 966.3 kB
>>
>>Load Address: 00000000
>>
>>Entry Point: 00000000
>>
>>Verifying Checksum ... OK
>>
>>Uncompressing Kernel Image ... OK
>>
>>Memory BAT mapping: BAT2=64Mb, BAT3=0Mb, residual: 0Mb
>>
>>Linux version 2.4.20_mvl31-lite5200 (ofurxhi@mdc58503) (gcc version 
>>3.3.1 (Monta
>>
>>Vista 3.3.1-7.0.13.0500039 2005-01-12)) #11 Tue Jun 13 16:32:09 CDT 2006
>>
>>On node 0 totalpages: 16384
>>
>>zone(0): 16384 pages.
>>
>>zone(1): 0 pages.
>>
>>zone(2): 0 pages.
>>
>>Kernel command line: root=/dev/mtdblock2 rw rootfstype=jffs2 
>>ip=192.168.0.7:192.
>>
>>168.0.2:192.168.0.2:255.255.255.0:cpua::off
>>
>>frequencies: cpu=461995100, bus=131998608, ipb=65999304, pci=32999652
>>
>>Calibrating delay loop... 307.20 BogoMIPS
>>
>>Memory: 62460k available (1540k kernel code, 524k data, 240k init, 0k 
>>highmem)
>>
>>Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
>>
>>Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
>>
>>Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
>>
>>Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
>>
>>Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
>>
>>POSIX conformance testing by UNIFIX
>>
>>PCI: Probing PCI hardware
>>
>>PCI: Cannot allocate resource region 1 of device 00:00.0
>>
>>PCI: Cannot allocate resource region 1 of device 00:01.0
>>
>>PCI: Cannot allocate resource region 1 of device 00:02.0
>>
>>PCI: Cannot allocate resource region 1 of device 00:03.0
>>
>>PCI: Cannot allocate resource region 1 of device 00:04.0
>>
>>PCI: Cannot allocate resource region 1 of device 00:05.0
>>
>>PCI: Cannot allocate resource region 1 of device 00:06.0
>>
>>PCI: Cannot allocate resource region 1 of device 00:07.0
>>
>>PCI: Cannot allocate resource region 1 of device 00:08.0
>>
>>PCI: Cannot allocate resource region 1 of device 00:09.0
>>
>>PCI: Cannot allocate resource region 1 of device 00:0a.0
>>
>>PCI: Cannot allocate resource region 1 of device 00:0b.0
>>
>>PCI: Cannot allocate resource region 1 of device 00:0c.0
>>
>>PCI: Cannot allocate resource region 1 of device 00:0d.0
>>
>>PCI: Cannot allocate resource region 1 of device 00:0e.0
>>
>>PCI: Cannot allocate resource region 1 of device 00:0f.0
>>
>>PCI: Cannot allocate resource region 1 of device 00:10.0
>>
>>PCI: Cannot allocate resource region 1 of device 00:11.0
>>
>>PCI: Cannot allocate resource region 1 of device 00:12.0
>>
>>PCI: Cannot allocate resource region 1 of device 00:13.0
>>
>>PCI: Cannot allocate resource region 1 of device 00:14.0
>>
>>PCI: Cannot allocate resource region 1 of device 00:15.0
>>
>>PCI: Cannot allocate resource region 1 of device 00:16.0
>>
>>PCI: Cannot allocate resource region 1 of device 00:17.0
>>
>>PCI: Cannot allocate resource region 1 of device 00:18.0
>>
>>PCI: Cannot allocate resource region 1 of device 00:19.0
>>
>>PCI: Cannot allocate resource region 1 of device 00:1a.0
>>
>>PCI: Cannot allocate resource region 1 of device 00:1b.0
>>
>>PCI: Cannot allocate resource region 1 of device 00:1c.0
>>
>>PCI: Cannot allocate resource region 1 of device 00:1d.0
>>
>>PCI: Cannot allocate resource region 1 of device 00:1e.0
>>
>>Linux NET4.0 for Linux 2.4
>>
>>Based upon Swansea University Computer Society NET3.039
>>
>>Initializing RT netlink socket
>>
>>LSP Revision 52
>>
>>ikconfig 0.5 with /proc/ikconfig
>>
>>Starting kswapd
>>
>>Disabling the Out Of Memory Killer
>>
>>Journalled Block Device driver loaded
>>
>>devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
>>
>>devfs: boot_options: 0x1
>>
>>JFFS version 1.0, (C) 1999, 2000 Axis Communications AB
>>
>>JFFS2 version 2.1. (C) 2001, 2002 Red Hat, Inc., designed by Axis 
>>Communications
>>
>>AB.
>>
>>pty: 256 Unix98 ptys configured
>>
>>RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
>>
>>loop: loaded (max 8 devices)
>>
>>Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
>>
>>SCSI subsystem driver Revision: 1.00
>>
>>kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
>>
>>kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
>>
>>NO QRY response
>>
>>cfi_cmdset_0001: Erase suspend on write enabled
>>
>>Using buffer write method
>>
>>Icecube flash bank 0: Using static image partition definition
>>
>>Creating 3 MTD partitions on "Icecube Bank 0":
>>
>>0x00000000-0x00100000 : "u-boot"
>>
>>0x00100000-0x00200000 : "kernel"
>>
>>0x00200000-0x00800000 : "jffs2"
>>
>>usb.c: registered new driver usbdevfs
>>
>>usb.c: registered new driver hub
>>
>>usb-ohci.c: USB OHCI at membase 0xf0001000, IRQ 44
>>
>>usb.c: new USB bus registered, assigned bus number 1
>>
>>Product: USB OHCI Root Hub
>>
>>SerialNumber: f0001000
>>
>>hub.c: USB hub found
>>
>>hub.c: 2 ports detected
>>
>>Initializing USB Mass Storage driver...
>>
>>usb.c: registered new driver usb-storage
>>
>>USB Mass Storage support registered.
>>
>>eth0: Phy @ 0x0, type LXT971 (0x001378e2)
>>
>>NET4: Linux TCP/IP 1.0 for NET4.0
>>
>>IP Protocols: ICMP, UDP, TCP, IGMP
>>
>>IP: routing cache hash table of 512 buckets, 4Kbytes
>>
>>TCP: Hash tables configured (established 4096 bind 8192)
>>
>>eth0: config: auto-negotiation off, 100HDX, 10HDX.
>>
>>IP-Config: Complete:
>>
>>device=eth0, addr=192.168.0.7, mask=255.255.255.0, gw=192.168.0.2,
>>
>>host=cpua, domain=, nis-domain=(none),
>>
>>bootserver=192.168.0.2, rootserver=192.168.0.2, rootpath=
>>
>>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
>>
>>Empty flash at 0x0000fffc ends at 0x00010000
>>
>>CLEANMARKER node found at 0x00010000, not first node in block (0x00000000)
>>
>>Empty flash at 0x0002fffc ends at 0x00030000
>>
>>CLEANMARKER node found at 0x00030000, not first node in block (0x00020000)
>>
>>Empty flash at 0x0004fffc ends at 0x00050000
>>
>>CLEANMARKER node found at 0x00050000, not first node in block (0x00040000)
>>
>>Empty flash at 0x0006fffc ends at 0x00070000
>>
>>CLEANMARKER node found at 0x00070000, not first node in block (0x00060000)
>>
>>Empty flash at 0x0008fffc ends at 0x00090000
>>
>>CLEANMARKER node found at 0x00090000, not first node in block (0x00080000)
>>
>>Empty flash at 0x000afffc ends at 0x000b0000
>>
>>CLEANMARKER node found at 0x000b0000, not first node in block (0x000a0000)
>>
>>Empty flash at 0x000cfffc ends at 0x000d0000
>>
>>CLEANMARKER node found at 0x000d0000, not first node in block (0x000c0000)
>>
>>Empty flash at 0x000efffc ends at 0x000f0000
>>
>>CLEANMARKER node found at 0x000f0000, not first node in block (0x000e0000)
>>
>>Empty flash at 0x0010fffc ends at 0x00110000
>>
>>CLEANMARKER node found at 0x00110000, not first node in block (0x00100000)
>>
>>Empty flash at 0x0012fffc ends at 0x00130000
>>
>>CLEANMARKER node found at 0x00130000, not first node in block (0x00120000)
>>
>>Empty flash at 0x0014fffc ends at 0x00150000
>>
>>CLEANMARKER node found at 0x00150000, not first node in block (0x00140000)
>>
>>Empty flash at 0x0016fffc ends at 0x00170000
>>
>>CLEANMARKER node found at 0x00170000, not first node in block (0x00160000)
>>
>>Empty flash at 0x0018fffc ends at 0x00190000
>>
>>CLEANMARKER node found at 0x00190000, not first node in block (0x00180000)
>>
>>Empty flash at 0x001afffc ends at 0x001b0000
>>
>>CLEANMARKER node found at 0x001b0000, not first node in block (0x001a0000)
>>
>>Empty flash at 0x001cfffc ends at 0x001d0000
>>
>>CLEANMARKER node found at 0x001d0000, not first node in block (0x001c0000)
>>
>>Empty flash at 0x001efffc ends at 0x001f0000
>>
>>CLEANMARKER node found at 0x001f0000, not first node in block (0x001e0000)
>>
>>Empty flash at 0x0020fffc ends at 0x00210000
>>
>>CLEANMARKER node found at 0x00210000, not first node in block (0x00200000)
>>
>>Empty flash at 0x0022fffc ends at 0x00230000
>>
>>CLEANMARKER node found at 0x00230000, not first node in block (0x00220000)
>>
>>Empty flash at 0x0024fffc ends at 0x00250000
>>
>>CLEANMARKER node found at 0x00250000, not first node in block (0x00240000)
>>
>>Empty flash at 0x0026fffc ends at 0x00270000
>>
>>CLEANMARKER node found at 0x00270000, not first node in block (0x00260000)
>>
>>VFS: Mounted root (jffs2 filesystem).
>>
>>Mounted devfs on /dev
>>
>>Freeing unused kernel memory: 240k init
>>
>>serial console detected. Disabling virtual terminals.
>>
>>init started: BusyBox v0.60.3 (2004.01.09-22:53+0000) multi-call binary
>>
>>Initializing iocspi
>>
>>Warning: loading /lib/modules/iocspim.o will taint the kernel: no license
>>
>>See http://www.tux.org/lkml/#export-tainted for information about 
>>tainted modu
>>
>>les
>>
>>iocspi: release_20060418
>>
>>iocspi: major 254.
>>
>>Module iocspim loaded, with warnings
>>
>>Initializing canspi
>>
>>Warning: loading /lib/modules/canspim.o will taint the kernel: no license
>>
>>See http://www.tux.org/lkml/#export-tainted for information about 
>>tainted modu
>>
>>les
>>
>>canspi: init_module()
>>
>>canspi: init_module(): sema_init
>>
>>canspi: init_module(): register_chrdev
>>
>>canspi: major 253.
>>
>>canspi: micro_config()
>>
>>canspi: micro_config: PSC request_irq failed (0)
>>
>>canspi: micro_config psc=f0002400 cdm=f0000200 gpio=f0000b00 
>>portcfg=10051004
>>
>>Module canspim loaded, with warnings
>>
>>Initializing iocdrv
>>
>>Warning: loading /lib/modules/iocdrvm.o will taint the kernel: no license
>>
>>See http://www.tux.org/lkml/#export-tainted for information about 
>>tainted modu
>>
>>les
>>
>>iocdrv: release_20060502
>>
>>iocdrv: major 252.
>>
>>Module iocdrvm loaded, with warnings
>>
>>System initialized
>>
>>MontaVista(R) Linux(R) Professional Edition 3.1
>>
>>cpua login:
>>
>>Any help would be highly appreciated.
>>
>>Thank you,
>>
>>Orges Furxhi
>>
>>------------------------------------------------------------------------
>>
>>_______________________________________________
>>Linuxppc-embedded mailing list
>>Linuxppc-embedded@ozlabs.org
>>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>
>>    
>>
