Return-Path: <cn.vijaibaskar@gdatech.co.in>
Received: from gdatech.co.in (mail.gdatech.co.in [202.144.30.226])
	by ozlabs.org (Postfix) with ESMTP id 18E66DDEDD
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 26 Nov 2007 17:26:54 +1100 (EST)
Received: from [172.29.36.2] (localhost.localdomain [127.0.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id D25BF87809F
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 25 Nov 2007 22:07:17 -0800 (PST)
Received: from mail.gdatech.co.in (unknown [172.29.36.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id 7129B878084
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 25 Nov 2007 22:07:17 -0800 (PST)
Message-ID: <474A639A.3090006@gdatech.co.in>
Date: Mon, 26 Nov 2007 11:41:38 +0530
From: vijay baskar <cn.vijaibaskar@gdatech.co.in>
MIME-Version: 1.0
To: =?UTF-8?B?6YOt5Yqy?= <guojin02@tsinghua.org.cn>
Subject: Re: The question about the high memory support on MPC8360?
References: <396049508.10992@tsinghua.org.cn>
In-Reply-To: <396049508.10992@tsinghua.org.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi friends,

Kernel virtual space is divided into 3 different zones namely ZONE_DMA,=20
ZONE_NORMAL, ZONE_HIGHMEM.Remember that the kernel follows the 3GB/1GB=20
split ie 3 GB for user space and 1  GB for kernel space. Since your ram=20
is 1 GB, 896 MB will be mapped one to one with the kernel virtual space.=20
This one to one mapping will be done in the ZONE_NORMAL and ZONE_DMA of=20
kernel virtual space.Remaining 128 MB of kernel virtual address space=20
will be used for setting up kernel  data structures and for ioremaps and=20
vmallocs that  the kernel will need to perform during boot up.  If  u=20
configure high memory this 128 MB will be used for accessing unmapped=20
memory regions in the ram and there wont be sufficient  virtual=20
addresses for ioremaps and vmallocs. Thats why your kernel did not boot=20
when high mem is configured.

                   Since u want to have 1 GB of ram an alternative to=20
this is that u can try 2 GB/ 2 GB split which is configurable ie 2 GB=20
for user space and 2 GB for kernel space in your kernel.

Thanks and Regards,
vijai



=E9=83=AD=E5=8A=B2 wrote:

>Hi,friends,=20
>  I plug in 1GB DDR-1 on my MPC8360 board, the u-boot-1.2.0 found the DD=
R storage
>is 1GB, but the linux just found  773504k. please see follow information=
.
>   I think I need to config the kernel to support the high memory. but i=
f I config
>the kernel to select the "high memory support" under the "platform optio=
ns" on
>"linux kernel configuration" during compile, the kernel is not to boot. =
if I
>cancel this options, the kernel is ok to run.
>   why? how to deal with this problem? there are two DIMM-184 slots on m=
y MPC8360
>board, I want to support total 2GB DDR-1 storage. now I want to try 1GB =
on one of=20
>DIMM-184 slots firstly.
>    please see follow information. Thanks.
>
>
>~ # dmesg                                                               =
       =20
>Linux version 2.6.11 (olivia@bamboo) (gcc version 3.4.3) #1 Thu Jul 12 1=
4:29:297
>On node 0 totalpages: 196608                                            =
       =20
>  DMA zone: 196608 pages, LIFO batch:16                                 =
       =20
>  Normal zone: 0 pages, LIFO batch:1                                    =
       =20
>  HighMem zone: 0 pages, LIFO batch:1                                   =
       =20
>Built 1 zonelists                                                       =
       =20
>Kernel command line: console=3DttyS0,115200 root=3D/dev/ram0            =
           =20
>IPIC (128 IRQ sources, 8 External IRQs) at fe000700                     =
       =20
>QE IC (64 IRQ sources) at fe100080                                      =
       =20
>PID hash table entries: 4096 (order: 12, 65536 bytes)                   =
       =20
>Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)        =
       =20
>Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)          =
       =20
>Memory: 773504k available (1724k kernel code, 432k data, 100k init, 0k h=
ighmem)=20
>Calibrating delay loop... 351.23 BogoMIPS (lpj=3D175616)                =
         =20
>Mount-cache hash table entries: 512 (order: 0, 4096 bytes)              =
       =20
>checking if image is initramfs...it isn't (no cpio magic); looks like an=
 initrd=20
>Freeing initrd memory: 3120k freed                                      =
       =20
>NET: Registered protocol family 16                                      =
       =20
>Registering ipic with sysfs...                                          =
       =20
>SCSI subsystem initialized                                              =
       =20
>JFFS2 version 2.2. (C) 2001-2003 Red Hat, Inc.                          =
       =20
>Generic RTC Driver v1.07                                                =
       =20
>Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing disable=
d      =20
>ttyS0 at MMIO 0xe0004500 (irq =3D 9) is a 16550A                        =
         =20
>ttyS1 at MMIO 0xe0004600 (irq =3D 10) is a 16550A                       =
         =20
>io scheduler noop registered                                            =
       =20
>io scheduler anticipatory registered                                    =
       =20
>io scheduler deadline registered                                        =
       =20
>io scheduler cfq registered                                             =
       =20
>RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize  =
       =20
>loop: loaded (max 8 devices)                                            =
       =20
>MPC8360E PB flash device: 2000000 at fe000000 Partition number 6        =
       =20
>MPC8360E PB Flash Map Info: Found 1 x16 devices at 0x0 in 16-bit bank   =
       =20
>MPC8360E PB Flash Map Info: Found an alias at 0x1000000 for the chip at =
0x0    =20
>Support for command set 0001 not present                                =
       =20
>gen_probe: No supported Vendor Command Set found                        =
       =20
>i2c /dev entries driver                                                 =
       =20
>eth0: Running with NAPI disabled                                        =
       =20
>eth1: Running with NAPI disabled                                        =
       =20
>NET: Registered protocol family 2                                       =
       =20
>IP: routing cache hash table of 8192 buckets, 64Kbytes                  =
       =20
>TCP established hash table entries: 131072 (order: 8, 1048576 bytes)    =
       =20
>TCP bind hash table entries: 65536 (order: 6, 262144 bytes)             =
       =20
>TCP: Hash tables configured (established 131072 bind 65536)             =
       =20
>NET: Registered protocol family 1                                       =
       =20
>NET: Registered protocol family 17                                      =
       =20
>RAMDISK: Compressed image found at block 0                              =
       =20
>VFS: Mounted root (ext2 filesystem) readonly.                           =
       =20
>Freeing unused kernel memory: 100k init                                 =
       =20
>eth0: PHY is Marvell 88E11x1 (1410cc1)                                  =
       =20
>eth0: Full Duplex                                                       =
       =20
>eth0: Speed 1000BT                                                      =
       =20
>eth0: Link is up
>
>
>U-Boot 1.2.0 (Nov 21 2007 - 16:05:15) MPC83XX                           =
       =20
>                                                                        =
       =20
>CPU:   e300c1, MPC8360E, Rev: 20 at 528 MHz, CSB:  264 MHz              =
       =20
>Board: Freescale MPC8360EMDS                                            =
       =20
>I2C:   ready                                                            =
       =20
>DRAM:                                                                   =
       =20
>DIMM type:                                                              =
       =20
>SPD size:        128                                                    =
       =20
>EEPROM size:     256                                                    =
       =20
>Memory type:     7                                                      =
       =20
>Row addr:        13                                                     =
       =20
>Column addr:     11                                                     =
       =20
># of rows:       2                                                      =
       =20
>Row density:     128                                                    =
       =20
># of banks:      4                                                      =
       =20
>Data width:      64                                                     =
       =20
>Chip width:      8                                                      =
       =20
>Refresh rate:    82                                                     =
       =20
>CAS latencies:   1C                                                     =
       =20
>Write latencies: 02                                                     =
       =20
>tRP:             60                                                     =
       =20
>tRCD:            60                                                     =
       =20
>                                                                        =
       =20
>                                                                        =
       =20
>   DDR DIMM: data bus width is 64 bit without ECC                       =
       =20
>   DDRC ECC mode: OFF                                                   =
       =20
>                                                                        =
       =20
>   SDRAM on Local Bus: 64 MB                                            =
       =20
>   DDR RAM: 1024 MB                                                     =
       =20
>FLASH: 16 MB                                                            =
       =20
>PCI clock is 66MHz                                                      =
       =20
>PCI 32bit bus on PMC1 & PMC2 & PMC3                                     =
       =20
>In:    serial                                                           =
       =20
>Out:   serial                                                           =
       =20
>Err:   serial                                                           =
       =20
>Net:   UEC: PHY is Marvell 88E11x1 (1410cc1)                            =
       =20
>FSL UEC0: Full Duplex                                                   =
       =20
>FSL UEC0: Speed 1000BT                                                  =
       =20
>FSL UEC0: Link is up                                                    =
       =20
>FSL UEC0                                                                =
       =20
>Hit any key to stop autoboot:  0                                        =
       =20
>=3D> bootm fed00000 fe900000                                            =
         =20
>## Booting image at fed00000 ...                                        =
       =20
>   Image Name:   Linux-2.6.11                                           =
       =20
>   Image Type:   PowerPC Linux Kernel Image (gzip compressed)           =
       =20
>   Data Size:    1054435 Bytes =3D  1 MB                                =
         =20
>   Load Address: 00000000                                               =
       =20
>   Entry Point:  00000000                                               =
       =20
>   Verifying Checksum ... OK                                            =
       =20
>   Uncompressing Kernel Image ... OK                                    =
       =20
>## Loading RAMDisk Image at fe900000 ...                                =
       =20
>   Image Name:   uboot ext2 ramdisk rootfs                              =
       =20
>   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)          =
       =20
>   Data Size:    3195657 Bytes =3D  3 MB                                =
         =20
>   Load Address: 00000000                                               =
       =20
>   Entry Point:  00000000                                               =
       =20
>   Verifying Checksum ... OK                                            =
       =20
>   Loading Ramdisk to 0fc9a000, end 0ffa6309 ... OK
>
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>
> =20
>
