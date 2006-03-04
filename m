Return-Path: <tnt@246tNt.com>
Received: from outmx017.isp.belgacom.be (outmx017.isp.belgacom.be
	[195.238.4.116])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BF41F679E7
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Mar 2006 20:16:28 +1100 (EST)
Received: from outmx017.isp.belgacom.be (localhost [127.0.0.1])
	by outmx017.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id k249GJjg028707
	for <linuxppc-embedded@ozlabs.org>; Sat, 4 Mar 2006 10:16:19 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <44095B41.5010708@246tNt.com>
Date: Sat, 04 Mar 2006 10:17:53 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: #LI JIANGGAN# <lijianggan@pmail.ntu.edu.sg>
Subject: Re: boot failure on lite5200b board
References: <84A109BF918D934CB46ACF33BCE187C002D54D71@mail02.student.main.ntu.edu.sg><43FD6669.9090405@246tNt.com><84A109BF918D934CB46ACF33BCE187C002D54D7A@mail02.student.main.ntu.edu.sg><4b73d43f0602230818w63423513n817d9ec7eb580d2c@mail.gmail.com><84A109BF918D934CB46ACF33BCE187C002D54D7B@mail02.student.main.ntu.edu.sg><4b73d43f0602240917h1d80bcf8ycc87086305434304@mail.gmail.com><84A109BF918D934CB46ACF33BCE187C002D54D94@mail02.student.main.ntu.edu.sg>	<4b73d43f0603011652w39fb4393x8879891b7538f0b1@mail.gmail.com>
	<84A109BF918D934CB46ACF33BCE187C002D54D96@mail02.student.main.ntu.edu.sg>
In-Reply-To: <84A109BF918D934CB46ACF33BCE187C002D54D96@mail02.student.main.ntu.edu.sg>
Content-Type: text/plain; charset=ISO-8859-1
Cc: haidong_feng@126.com, linuxppc-embedded@ozlabs.org
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


#LI JIANGGAN# wrote:
> Thanks John, the Kernel now boots well. However it gives a kernel panic
> while mounting the root file sysem over NFS:
> 
> Looking up port of RPC 100003/2 on 10.190.3.103
> RPC: sendmsg returned error 101
> portmap: RPC call returned error 101
> Root-NFS: Unable to get nfsd port number from server, using default
> 
> I couldn't figure out why error 101 /* Network is unreachable */ is
> given. Below is my current U-boot settings and a snapshot of the booting:

Didn't I told you to try the tree I on http://gitbits.246tnt.com ?

I don't know the tree you're using but it doesn't seem to be mine ...
(nor any of the previous version i published).

I you want to have the most "complete" stuff i publish, clone the
mainstream, pull from my ide branch and then pull from the bestcomm branch.

There is also the denx tree but I don't know it's status.


> Linux version 2.6.11.7 (root@bob) (gcc version 3.3.2) #1 Tue Sep 6
> 22:40:03 UTC 2005
^^^^^^^^^^^^^^^^^^^^^^^^^^
 my tree is based on something more recent

> Real-Time Preemption Support (c) Ingo Molnar
> Built 1 zonelists
> Kernel command line: console=ttyS0,115200
                       ^^^^^^^^^^^^^^^^^^^^
 You would see nothing with the tree of gitbits.246tNt.com with that
command line. You need ttyPSC0 ...


> nfsroot=10.190.3.103:/opt/eldk-4-0/nfs root=/dev/nfs rw
> PID hash table entries: 2048 (order: 11, 32768 bytes)
> Console: colour dummy device 80x25
> Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
> Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
> Memory: 256268k available (2336k kernel code, 896k data, 140k init, 0k
> highmem)
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> BUG: scheduling while atomic: swapper/0x00000001/0
> caller is schedule+0x50/0xe8
> Call trace:
>  [c0006bd8] dump_stack+0x18/0x28
>  [c0242818] __sched_text_start+0x69c/0x6a0
>  [c024286c] schedule+0x50/0xe8
>  [c0003f00] syscall_exit_work+0x108/0x10c
>  [c030c578] proc_root_init+0x144/0x150
>  [c0320000] 0xc0320000
>  [c02fe624] start_kernel+0x180/0x1b8
>  [000035fc] 0x35fc
> spawn_desched_task(00000000)
> desched cpu_callback 3/00000000
> ksoftirqd started up.
> softirq RT prio: 24.
> desched cpu_callback 2/00000000
> desched thread 0 started up.
> NET: Registered protocol family 16
> 
> PCI: Probing PCI hardware
> SCSI subsystem initialized
> usbcore: registered new driver usbfs
> usbcore: registered new driver hub
> JFFS2 version 2.2. (C) 2001-2003 Red Hat, Inc.
> ppdev: user-space parallel port driver
> Serial: MPC52xx PSC driver
> ttyS0 at MMIO 0xf0002000 (irq = 39) is a MPC52xx PSC
> io scheduler noop registered
> io scheduler anticipatory registered
> io scheduler deadline registered
> io scheduler cfq registered
> RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
> loop: loaded (max 8 devices)
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> ipb=132MHz, set clock period to 7
> GPIO config: 91051024
> ATA invalid: 01000000
> ATA hostcnf: 03000000
> ATA pio1   : 100a0a00
> ATA pio2   : 02040600
> XLB Arb cnf: 0000a366
> mpc52xx_ide: Setting up IDE interface ide0...
> flash chip on the Lite5200/Lite5200B: Found 1 x16 devices at 0x0 in
> 8-bit bank
> flash chip on the Lite5200/Lite5200B: Found 1 x16 devices at 0x1000000
> in 8-bit bank
>  Amd/Fujitsu Extended Query Table at 0x0040
> flash chip on the Lite5200/Lite5200B: CFI does not contain boot bank
> location. Assuming top.
> number of CFI chips: 2
> cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
> Creating 7 MTD partitions on "flash chip on the Lite5200/Lite5200B":
> 0x00000000-0x01000000 : "Filesystem"
> 0x01000000-0x01040000 : "BootLOW"
> 0x01040000-0x01060000 : "EnvLOW"
> 0x01060000-0x01d00000 : "Spare"
> 0x01d00000-0x01f00000 : "Kernel"
> 0x01f00000-0x01f40000 : "BootHIGH"
> 0x01f40000-0x01f60000 : "EnvHIGH"
> ocp-ohci 02: new USB bus registered, assigned bus number 1
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 2 ports detected
> Initializing USB Mass Storage driver...
> usbcore: registered new driver usb-storage
> USB Mass Storage support registered.
> usbcore: registered new driver usbhid
> drivers/usb/input/hid-core.c: v2.0:USB HID core driver
> mice: PS/2 mouse device common for all mice
> i2c /dev entries driver
> i2c-algo-52xx.o: scanning bus Lite5200 I2C module #1 interface...
> ................................................................................................................................
> i2c-lite5200.o: I2C module #1 installed
> i2c-algo-52xx.o: scanning bus Lite5200 I2C module #2 interface...
> ................................................................................(0x50)..............................................(0x7f)
> i2c-lite5200.o: I2C module #2 installed
> Advanced Linux Sound Architecture Driver Version 1.0.8 (Thu Jan 13
> 09:39:32 2005 UTC).
> ALSA device list:
>   No soundcards found.
> NET: Registered protocol family 2
> IP: routing cache hash table of 256 buckets, 16Kbytes
> TCP established hash table entries: 16384 (order: 8, 1048576 bytes)
> TCP bind hash table entries: 16384 (order: 7, 917504 bytes)
> TCP: Hash tables configured (established 16384 bind 16384)
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> Looking up port of RPC 100003/2 on 10.190.3.103
> RPC: sendmsg returned error 101
> portmap: RPC call returned error 101
> Root-NFS: Unable to get nfsd port number from server, using default
> Looking up port of RPC 100005/1 on 10.190.3.103
> RPC: sendmsg returned error 101
> portmap: RPC call returned error 101
> Root-NFS: Unable to get mountd port number from server, using default
> RPC: sendmsg returned error 101
> mount: RPC call returned error 101
> Root-NFS: Server returned error -101 while mounting /opt/eldk-4-0/nfs
> VFS: Unable to mount root fs via NFS, trying floppy.
> VFS: Cannot open root device "nfs" or unknown-block(2,0)
> Please append a correct "root=" boot option
> Kernel panic - not syncing: VFS: Unable to mount root fs on
> unknown-block(2,0)
>  <0>Rebooting in 180 seconds..                  
