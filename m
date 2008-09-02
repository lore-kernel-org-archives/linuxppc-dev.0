Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id C3C88DE1C2
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Sep 2008 07:27:54 +1000 (EST)
Message-ID: <48BDAFD7.6060002@denx.de>
Date: Tue, 02 Sep 2008 23:27:51 +0200
From: Anatolij Gustschin <agust@denx.de>
MIME-Version: 1.0
To: SETTE AGOSTINO - technolabs <Agostino.Sette@technolabs.it>
Subject: Re: MPC8568MDS RAMDISK Problem
References: <F1F6EC0C8B75034F9E3A79FC85122E8E0107370E@aquib01a>
In-Reply-To: <F1F6EC0C8B75034F9E3A79FC85122E8E0107370E@aquib01a>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Agostino,

SETTE AGOSTINO - technolabs wrote:

> I updated my u-boot
> 
> U-Boot 1.3.4-00253-g33aa4ea (Sep  2 2008 - 13:04:22)
> 
> CPU:   8568E, Version: 1.1, (0x807d0011)
> Core:  E500, Version: 2.2, (0x80210022)
> Clock Configuration:
>        CPU:1320 MHz, CCB: 528 MHz,
>        DDR: 264 MHz (528 MT/s data rate), LBC: 132 MHz
> L1:    D-cache 32 kB enabled
>        I-cache 32 kB enabled
> Board: 8568 MDS
> I2C:   ready
> DRAM:  Initializing
>     SDRAM: 64 MB
>     DDR: 512 MB
> FLASH: 32 MB
> L2:    512 KB enabled
>     PCI: 32 bit, 66 MHz, async, host, arbiter
>                Scanning PCI bus 00
> PCI on bus 00 - 00
> 
>     PCIE connected to slot as Root Complex (base address e000a000)
> PCIE on bus 01 - 01
> In:    serial
> Out:   serial
> Err:   serial
> Net:   eTSEC0, eTSEC1, FSL UEC0, FSL UEC1
> 
> But now I have the following problem:
> 
> ## Checking Image at 02000100 ...
>    Legacy image found
>    Image Name:   Linux-2.6.25.5
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    1354587 Bytes =  1.3 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
> ## Booting kernel from Legacy Image at 02000100 ...
>    Image Name:   Linux-2.6.25.5
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    1354587 Bytes =  1.3 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
> ## Loading init Ramdisk from Legacy Image at 02200100 ...
>    Image Name:   initrd
>    Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
>    Data Size:    3658157 Bytes =  3.5 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
> ## Flattened Device Tree blob at 021f0100
>    Booting using the fdt blob at 0x21f0100
>    Uncompressing Kernel Image ... OK
>    Loading Device Tree to 007fa000, end 007fffff ... OK
> WARNING: could not set linux,stdout-path FDT_ERR_NOTFOUND.
> ERROR: /chosen node create failed - must RESET the board to recover.

Does your "arch/powerpc/boot/dts/mpc8568mds.dts" file contain
aliases node with "serial0 = &serial0;" in it?
How do you compile your mpc8568mds.dtb DTB and which dtc version
are you using to compile it?
 
> Do I need to add some environment variables or set some fdt commands before booting the board?

The mpc8568mds.dts from 2.6.25.5 kernel seems to be Ok. Booting
should work if you use this mpc8568mds.dts file. The problem
could also be somewhere in U-Boot environment setup.

> Here are the env variables
> 
> => printenv
> ramboot=run ramargs;tftp $ramdiskaddr $ramdiskfile;tftp $loadaddr $bootfile;bootm $loadaddr $ramdiskaddr
> nfsboot=run nfsargs;tftp $loadaddr $bootfile;tftp $fdtaddr $fdtfile;bootm $loadaddr - $fdtaddr
> bootdelay=10
> baudrate=115200
> loads_echo=1
> ethaddr=00:E0:0C:00:00:FD
> eth1addr=00:E0:0C:00:01:FD
> eth2addr=00:E0:0C:00:02:FD
> eth3addr=00:E0:0C:00:03:FD
> rootpath=/nfsroot
> gatewayip=192.168.1.1
> netmask=255.255.255.0
> bootfile=your.uImage
> netdev=eth0
> consoledev=ttyS0
> ramdiskaddr=600000
> ramdiskfile=your.ramdisk.u-boot
> fdtaddr=400000
> fdtfile=your.fdt.dtb
> nfsargs=setenv bootargs root=/dev/nfs rw nfsroot=$serverip:$rootpath ip=$ipaddr:$serverip:$gatewayip:$netmask:$hostname:$netdev:off console=$consoledev,$bau
> drate $othbootargs
> ramargs=setenv bootargs root=/dev/ram rw console=$consoledev,$baudrate $othbootargs
> ethact=eTSEC0
> serverip=192.168.0.33
> ipaddr=192.168.0.126
> bootcmdFREE=run ramargs;cp.b fff00000 400000 3500;bootm ff800000 ffa00000 400000
> myaps=MPC8568MDS/aps
> mtdargs=mtdparts=physmap-flash.0:1M(boot),7M(aps0),7M(aps1),1M(optusr)
> pram=0x100000
> mem=0x3f00000
> pram_start=0x3f00000
> loadaddr=0x2000000
> aps0_fl_start=0xfe100000
> aps0_fl_size=0x00700000
> aps1_fl_start=0xfe800000
> aps1_fl_end=0xfeefffff
> aps1_fl_size=0x00700000
> aps_ram_start=0x2000000
> aps_ram_kernel_start=0x2000100
> aps_ram_dtb_start=0x21f0100
> aps_ram_rootfs_start=0x2200100
> aps=0
> dl_boot=tftp ${aps_ram_start} "u-boot.bin" && protect off 0xfe000000 0xfe07ffff && cp.b ${aps_ram_start} 0xfe000000 ${filesize} && protect on 0xfe000000 0xf
> e07ffff && saveenv
> bootcmd=if itest ${aps} == 0; then run dl_ram0; else run dl_ram1;fi
> altbootcmd=mw.b ${pram_start} 0 ${pram} && if itest ${aps} == 0; then setenv aps 1; else setenv aps 0; fi; saveenv; run bootcmd
> dl_ram0=cp.b ${aps0_fl_start} ${aps_ram_start} ${aps0_fl_size};if imi ${aps_ram_kernel_start}; then run bargs;bootm ${aps_ram_kernel_start} ${aps_ram_rootfs
> _start} ${aps_ram_dtb_start}; else reset; fi
> dl_ram1=cp.b ${aps1_fl_start} ${aps_ram_start} ${aps1_fl_size};if imi ${aps_ram_kernel_start}; then run bargs;bootm ${aps_ram_kernel_start} ${aps_ram_rootfs
> _start} ${aps_ram_dtb_start}; else reset; fi
> bootlimit=5
> initrd_high=no
> hostname=MPC8568MDS
> aps0_fl_end=0xfe7fffff
> dl_aps0=tftp ${aps_ram_start} ${myaps};erase ${aps0_fl_start} ${aps0_fl_end};cp.b ${aps_ram_start} ${aps0_fl_start} ${filesize};boot
> dl_aps1=tftp ${aps_ram_start} ${myaps};erase ${aps1_fl_start} ${aps1_fl_end};cp.b ${aps_ram_start} ${aps1_fl_start} ${filesize};boot
> bargs=setenv bootargs ${mtdargs} console=ttyS0,$baudrate root=/dev/ram ramdisk_size=500000 rw ip=${ipaddr}:${serverip}:${gatewayip}:${netmask}:${hostname}:e
> th0:off panic=1 mem=${mem} aps=${aps} ${misc} ${slram}
> dl_mykernel=tftp 1000000 MPC8568MDS/uImage; erase ff800000 ff9fffff; cp.b 1000000 ff800000 ${filesize}
> dl_myrootfs=tftp 2000000 MPC8568MDS/RamDisk.ext2; erase ffa00000 ffefffff; cp.b 2000000 ffa00000 ${filesize}
> dl_mydtb=tftp 400000 MPC8568MDS/mpc8568mds.dtb; erase fff00000 fff7ffff; cp.b 400000 fff00000 ${filesize}
> fdt_file=MPC8568MDS/mpc8568mds.dtb
> fdt_addr_r=0x21f0100
> stdin=serial
> stdout=serial
> stderr=serial
> 
> With previous u-boot I was able to load the images separately, with this u-boot I have the error.

What commands do you use to load kernel, ramdisk and dtb files? It is
not obvious from the environment above.

Best regargs,
Anatolij

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
