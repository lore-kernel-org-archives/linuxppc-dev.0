Message-ID: <004101c47af6$3f8d8800$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "Song Sam" <samlinuxppc@yahoo.com.cn>,
	<linuxppc-embedded@lists.linuxppc.org>
References: <20040805042134.41548.qmail@web15610.mail.cnb.yahoo.com>
Subject: Re: How to remove JFFS2 'Making dirty' display on RPXlite DW?
Date: Thu, 5 Aug 2004 10:12:26 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


BTW, I've been able to skip a step by just:

mkfs.jffs2  -o /dev/mtd3

I think your problem is a mis-match in block size.

Mark Chambers

----- Original Message -----
From: "Song Sam" <samlinuxppc@yahoo.com.cn>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: Thursday, August 05, 2004 12:21 AM
Subject: How to remove JFFS2 'Making dirty' display on RPXlite DW?


>
> Hi,
>
> When creating a JFFS2 filesytem with DENX SELF ramdisk
> as follows,the target displayed some wired
> message,what would be problem be?
>
> =====================================================
>
> After unpacking SELF,I use the following command to
> create a jffs2 filesystem:
>
> eraseall /dev/mtd3
>
> mkfs.jffs2 -r /tmp/tmp -e 0x10000 -o image.jffs2 -b
>
> dd if=image.jffs2 of=/dev/mtd3 bs=256k
>
> mount -t jffs2 /dev/mtdblock3 /mnt
>
> ====================================================
>
> U-Boot 1.1.2 (Jul 15 2004 - 17:26:45)
>
> CPU:   PPC823EZTnnB2 at 48 MHz: 16 kB I-Cache 8 kB
> D-Cache
> Board: RPXlite_DW
> DRAM:  64 MB
> FLASH: 16 MB
> In:    serial
> Out:   serial
> Err:   serial
> Net:   SCC ETHERNET
> -boot>pri
> bootcmd=run flash_self
> baudrate=9600
> loads_echo=1
> ethaddr=00:10:EC:00:37:5B
> netdev=eth0
> addip=setenv bootargs $(bootargs)
> ip=$(ipaddr):$(serverip):$(gatewayip):$(netmask):$(hostname):$(netdev):off
> panic=1
> flash_nfs=run nfsargs addip;bootm $(kernel_addr)
> net_nfs=tftp 200000 $(bootfile);run nfsargs
> addip;bootm
> ethact=SCC ETHERNET
> ramdisk_addr=ff900000
> rootpath=/workspace/myfilesystem/target/
> bootfile=uImage.rpxmtd
> nfsargs=setenv bootargs console=ttyS0,9600
> root=/dev/nfs rw nfsroot=$(serverip):$(rootpath)
> flash_self=run ramargs addip;bootm $(kernel_addr)
> ramargs=setenv bootargs console=ttyS0,9600
> root=/dev/mtdblock3 rw
> stdin=serial
> stdout=serial
> stderr=serial
> filesize=abfeb
> fileaddr=100000
> gatewayip=172.16.115.254
> netmask=255.255.255.0
> ipaddr=172.16.115.7
> serverip=172.16.115.6
> kernel_addr=ff080000
>
> Environment size: 806/32764 bytes
> u-boot>run flash_self
> ## Booting image at ff080000 ...
>    Image Name:   Linux-2.4.18_mvl30-rpxlite
>    Image Type:   PowerPC Linux Kernel Image (gzip
> compressed)
>    Data Size:    704427 Bytes = 687.9 kB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
> ...
> Kernel command line: console=ttyS0,9600
> root=/dev/mtdblock3 rw
> ip=172.16.115.7:172.16.115.6:172.16.115.254:255.255.255.0::eth0:off
> panic=1
> Decrementer Frequency = 180000000/60
> ...
> RPX Lite or CLLF flash device: 1000000 at ff000000
>  Amd/Fujitsu Extended Query Table v1.2 at 0x0040
> number of CFI chips: 1
> Creating 3 MTD partitions on "RPX":
> 0x00000000-0x00080000 : "RPXLITE flash U-BOOT
> partition"
> 0x00080000-0x00200000 : "RPXLITE flash KERNEL
> partition"
> 0x00200000-0x01000000 : "RPXLITE flash APPLICATION
> partition"
> ...
> IP-Config: Complete:
>       device=eth0, addr=172.16.115.7,
> mask=255.255.255.0, gw=172.16.115.254,
>      host=172.16.115.7, domain=, nis-domain=(none),
>      bootserver=172.16.115.6, rootserver=172.16.115.6,
> rootpath=
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> jffs2_scan_empty(): Empty block at 0x0000fffc ends at
> 0x00010000 (with 0x1985e002)! Marking dirty
> jffs2_scan_empty(): Empty block at 0x0001fffc ends at
> 0x00020000 (with 0x1985e002)! Marking dirty
> jffs2_scan_empty(): Empty block at 0x0002fffc ends at
> 0x00030000 (with 0x1985e002)! Marking dirty
> jffs2_scan_empty(): Empty block at 0x0004ff60 ends at
> 0x00050000 (with 0x1985e002)! Marking dirty
> jffs2_scan_empty(): Empty block at 0x0005fffc ends at
> 0x00060000 (with 0x1985e002)! Marking dirty
> jffs2_scan_empty(): Empty block at 0x0006ff78 ends at
> 0x00070000 (with 0x1985e002)! Marking dirty
> jffs2_scan_empty(): Empty block at 0x0008fffc ends at
> 0x00090000 (with 0x1985e002)! Marking dirty
> jffs2_scan_empty(): Empty block at 0x0009fffc ends at
> 0x000a0000 (with 0x1985e002)! Marking dirty
> jffs2_scan_empty(): Empty block at 0x000afffc ends at
> 0x000b0000 (with 0x1985e002)! Marking dirty
> jffs2_scan_empty(): Empty block at 0x000cfffc ends at
> 0x000d0000 (with 0x1985e002)! Marking dirty
> jffs2_scan_empty(): Empty block at 0x000dfffc ends at
> 0x000e0000 (with 0x1985e002)! Marking dirty
> jffs2_scan_empty(): Empty block at 0x000efffc ends at
> 0x000f0000 (with 0x1985e002)! Marking dirty
> jffs2_scan_empty(): Empty block at 0x0010fffc ends at
> 0x00110000 (with 0x1985e002)! Marking dirty
> jffs2_scan_empty(): Empty block at 0x0011fffc ends at
> 0x00120000 (with 0x1985e002)! Marking dirty
> jffs2_scan_empty(): Empty block at 0x0014fffc ends at
> 0x00150000 (with 0x1985e002)! Marking dirty
> jffs2_scan_empty(): Empty block at 0x0015fffc ends at
> 0x00160000 (with 0x1985e002)! Marking dirty
> jffs2_scan_empty(): Empty block at 0x0016fffc ends at
> 0x00170000 (with 0x1985e002)! Marking dirty
> jffs2_scan_empty(): Empty block at 0x0018fffc ends at
> 0x00190000 (with 0x1985e002)! Marking dirty
> jffs2_scan_empty(): Empty block at 0x0019fffc ends at
> 0x001a0000 (with 0x1985e002)! Marking dirty
> jffs2_scan_empty(): Empty block at 0x001afffc ends at
> 0x001b0000 (with 0x1985e002)! Marking dirty
> jffs2_scan_empty(): Empty block at 0x001cfffc ends at
> 0x001d0000 (with 0x1985e002)! Marking dirty
> jffs2_scan_empty(): Empty block at 0x001dffd0 ends at
> 0x001e0000 (with 0x1985e002)! Marking dirty
> jffs2_scan_empty(): Empty block at 0x001efffc ends at
> 0x001f0000 (with 0x1985e002)! Marking dirty
> jffs2_scan_empty(): Empty block at 0x0020fffc ends at
> 0x00210000 (with 0x1985e002)! Marking dirty
> jffs2_scan_empty(): Empty block at 0x0021fffc ends at
> 0x00220000 (with 0x1985e002)! Marking dirty
> VFS: Mounted root (jffs2 filesystem).
> Freeing unused kernel memory: 76k init
> My application is running ... Sam Song
>
> BusyBox v0.60.1 (2002.10.24-04:52+0000) Built-in shell
> (msh)
> Enter 'help' for a list of built-in commands.
>
> #        Feb.7,2004
> Hello Shanghai Univ.
> Hi Everybody!
>
> ---------------------------------------------
>
> The 'Making dirty' display took up about 5 seconds.I
> need to remove them.
>
> Thanks for any input!
>
> Best regards,
>
> Sam
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
