Return-Path: <bdyan@dstmedia.com>
Received: from smtp04.east.net (unknown [202.108.59.148])
	by ozlabs.org (Postfix) with ESMTP id AC5C368029
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Aug 2005 18:21:27 +1000 (EST)
Received: from unknown (HELO benson)
	(Authenticated?user:?bdyan@dstmedia.com@[203.86.84.62])
	(envelope-sender <bdyan@dstmedia.com>)
	by 0 (qmail-ldap-1.03) with SMTP
	for <linuxppc-embedded@ozlabs.org>; 26 Aug 2005 16:21:55 +0800
Date: Fri, 26 Aug 2005 16:13:29 +0800
From: "Bidong Yan" <bdyan@dstmedia.com>
To: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Message-Id: <20050826082127.AC5C368029@ozlabs.org>
Subject: Re: problem mounting ROOT-NFS
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

	Your nfs server did not startup, or with a wrong port.

Best regards,
Yan

======= At 2005-08-26 18:37:28 you wrote =======

>Hi,
>
>  I lately upgraded to Bestcomm API v2.2 from v2.1 , but root-nfs doesnt
>mount while booting from ram, but when booting from FLASH (Compact Flash
>and also NOR) it does well. This problem could be seen when I try to
>boot on MPC5200 RevA. 
>
> Then I switched to MPC5200 RevB to see it is the same here, but with
>same u.boot.bin and kernel image everything boot well on Rev B. I have
>compared the Environment perameters passed from u-boot to the kernel and
>everything seems to be the same. I also looked into the Errata to check
>if anything else regarding bestcomm or fec has changed, but couldnt
>figure out anything.
>
>console messages while booting on MPC5200 RevA from ram goes this
>way ...
>
>
>
>   
>U-Boot 1.1.1 (Aug 24 2005 - 09:56:03)
>
>CPU:   MPC5200 (JTAG ID 0001101d) at 396 MHz
>       Bus 132 MHz, IPB 66 MHz, PCI 33 MHz
>Board: Mitron, Type is not set
>DRAM:  64 MB
>FLASH:  4 MB
>FPGA:  OK
>SPI:   MPC5200_spi,mki_ad initialised
>BL:    (channel 2, dutycycle 50, freq 500) initialised
>Video: SMI720 @ 640x480x8 28kHz 53Hz
>In:    serial
>Out:   serial
>Err:   serial
>NAND:  128 MB at 0x28001000
>Net:   FEC ETHERNET
>IDE:   no card
> 0
>=> tftpboot 800000 u-boot.bin
>Using FEC ETHERNET device
>TFTP from server 192.168.1.61; our IP address is 192.168.30.130
>Filename 'u-boot.bin'.
>Load address: 0x800000
>Loading: T invalid RARP header
>
>TFTP error: 'File not found' (1)
>Starting again
>
>
>Abort
>=> tftpboot 800000 pImage
>Using FEC ETHERNET device
>TFTP from server 192.168.1.61; our IP address is 192.168.30.130
>Filename 'pImage'.
>Load address: 0x800000
>Loading:
>#################################################################
>
>#################################################################
>
>#################################################################
>         #
>done
>Bytes transferred = 1001433 (f47d9 hex)
>=> bootm 800000
>## Booting image at 00800000 ...
>   Image Name:   Linux-2.4.21-rc1
>   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>   Data Size:    1001369 Bytes = 977.9 kB
>   Load Address: 00000000
>   Entry Point:  00000000
>   Verifying Checksum ... OK
>   Uncompressing Kernel Image ... OK
>Mitron CVS tag: mct3_moto1_update
>Memory BAT mapping: BAT2=64Mb, BAT3=0Mb, residual: 0Mb
>Linux version 2.4.21-rc1 (nuguru@SW-server) (gcc version 2.95.4 20010319
>(prerelease/franzo/20011204)) #5 Fri Aug 26 09:51:30 EEST 2005
>Mitron SGVT port (C) 2003 Mitron Oy (mitron@mitron.fi)
>On node 0 totalpages: 16384
>zone(0): 16384 pages.
>zone(1): 0 pages.
>zone(2): 0 pages.
>Kernel command line: nfsroot=192.168.1.61:/tftpboot/rootfs
>ip=192.168.30.130:192.168.1.61:192.168.1.1:255.255.0.0:SGVT_180::off
>root=/dev/nfs video=scarlet:dev:0,no_pal console=ttyS0;init=/bin/sh;
>mgt5100_pic.c/mgt5100_init_irq: using configuration from FPGA binary
>file
>mgt5100_init_irq: external FPGA interrupt controller (by Mitron Oy)
>initialized
>Calibrating delay loop... 263.78 BogoMIPS
>Memory: 61828k available (1768k kernel code, 576k data, 76k init, 0k
>highmem)
>Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
>Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
>Mount cache hash table entries: 512 (order: 0, 4096 bytes)
>Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
>Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
>POSIX conformance testing by UNIFIX
>PCI: Probing PCI hardware
>Memory resource not set for host bridge 0
>Linux NET4.0 for Linux 2.4
>Based upon Swansea University Computer Society NET3.039
>Initializing RT netlink socket
>Starting kswapd
>JFFS2 version 2.2. (NAND) (C) 2001-2003 Red Hat, Inc.
>hwblock: Identification failure!
>hwblock: Checksum failure!
>hwblock: Forcing fallback
>hwblock: Configuring for MC?erial.c->init_chipsels: mfdev->count !=
>SGVT_RS_TABLE_SIZE
>Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
>SERIAL_PCI enabled
>uart00 at 0xc5076000 (irq = 92) is a TI16750
>uart01 at 0xc5078008 (irq = 92) is a TI16750
>uart02 at 0xc507a010 (irq = 92) is a TI16750
>RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
>PPP generic driver version 2.4.2
>PPP Deflate Compression module registered
>Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
>ide: Assuming 33MHz system bus speed for PIO modes; override with
>idebus=xx
>SCSI subsystem driver Revision: 1.00
>usb.c: registered new driver usbdevfs
>usb.c: registered new driver hub
>usb-ohci-embedded.c: USB OHCI at membase 0xf0001000, IRQ 44
>usb.c: new USB bus registered, assigned bus number 1
>hub.c: USB hub found
>hub.c: 2 ports detected
>usb.c: registered new driver hiddev
>usb.c: registered new driver hid
>hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
>hid-core.c: USB HID support drivers
>usb.c: registered new driver usblp
>printer.c: v0.11: USB Printer Device Class driver
>pegasus.c: v0.4.26 (2002/03/21):Pegasus/Pegasus II USB Ethernet driver
>usb.c: registered new driver pegasus
>Initializing USB Mass Storage driver...
>usb.c: registered new driver usb-storage
>USB Mass Storage support registered.
>eth0: Phy @ 0x0, type LXT971 (0x001378e2)
>Mitron multi chip CAN driver 0.4 inited
>Mitron SPI core functionality initialized
>spi-core.o: adapter SGVT SPI host registered as adapter 0.
>spi_add_driver: driver MKI driver registered.
>kb_probe_func: MKI keyboard 0 found. Versions: hw:3.1 sw:2.2
>spi_attach_client: client [SGVT SPI keyboard] registered to adapter
>[SGVT SPI host](pos. 0).
>MKI initialized succesfully
>SGVT_WDT: Software Watchdog Timer version 0.1, timeout 60 sec.
>SGVT Bank 0: Found 1 x16 devices at 0x0 in 8-bit bank
> Amd/Fujitsu Extended Query Table at 0x0040
>SGVT Bank 0: Swapping erase regions for broken CFI table.
>number of CFI chips: 1
>cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
>Creating 3 MTD partitions on "SGVT Bank 0":
>0x00000000-0x00200000 : "kernel"
>0x00200000-0x00280000 : "logo1"
>0x00280000-0x00300000 : "logo2"
>Initialised PWM buzzer, v. 0.2
>Nov. I/O 0.1 succesfully initialized
>spi_add_driver: driver A/D driver registered.
>spi_attach_client: client [SGVT SPI A/D converter] registered to adapter
>[SGVT SPI host](pos. 5).
>SPI A/D initialized succesfully
>ppcpmw 0.8 initialized
>NET4: Linux TCP/IP 1.0 for NET4.0
>IP Protocols: ICMP, UDP, TCP, IGMP
>IP: routing cache hash table of 512 buckets, 4Kbytes
>TCP: Hash tables configured (established 4096 bind 4096)
>eth0: config: auto-negotiation off, 100FDX, 100HDX, 10FDX, 10HDX.
>IP-Config: Complete:
>      device=eth0, addr=192.168.30.130, mask=255.255.0.0,
>gw=192.168.1.1,
>     host=SGVT_180, domain=, nis-domain=(none),
>     bootserver=192.168.1.61, rootserver=192.168.1.61, rootpath=
>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
>Looking up port of RPC 100003/2 on 192.168.1.61
>eth0: status: link up, 100 Mbps Full Duplex, auto-negotiation complete.
>portmap: server 192.168.1.61 not responding, timed out
>Root-NFS: Unable to get nfsd port number from server, using default
>Looking up port of RPC 100005/1 on 192.168.1.61
>
>then it stays until I reset the core :-(
>
> any hints  ???
>
>
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded

= = = = = = = = = = = = = = = = = = = =
