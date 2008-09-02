Return-Path: <Agostino.Sette@technolabs.it>
Received: from smtp.technolabs.it
	(host20-155-static.82-213-b.business.telecomitalia.it
	[213.82.155.20]) by ozlabs.org (Postfix) with ESMTP id ECAA9DDE28
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  2 Sep 2008 23:18:49 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: MPC8568MDS RAMDISK Problem
Date: Tue, 2 Sep 2008 15:18:41 +0200
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8E0107370E@aquib01a>
In-Reply-To: <48BD112C.6080902@denx.de>
From: "SETTE AGOSTINO - technolabs" <Agostino.Sette@technolabs.it>
To: "Anatolij Gustschin" <agust@denx.de>
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

Hi Anatolij,

I updated my u-boot

U-Boot 1.3.4-00253-g33aa4ea (Sep  2 2008 - 13:04:22)

CPU:   8568E, Version: 1.1, (0x807d0011)
Core:  E500, Version: 2.2, (0x80210022)
Clock Configuration:
       CPU:1320 MHz, CCB: 528 MHz,
       DDR: 264 MHz (528 MT/s data rate), LBC: 132 MHz
L1:    D-cache 32 kB enabled
       I-cache 32 kB enabled
Board: 8568 MDS
I2C:   ready
DRAM:  Initializing
    SDRAM: 64 MB
    DDR: 512 MB
FLASH: 32 MB
L2:    512 KB enabled
    PCI: 32 bit, 66 MHz, async, host, arbiter
               Scanning PCI bus 00
PCI on bus 00 - 00

    PCIE connected to slot as Root Complex (base address e000a000)
PCIE on bus 01 - 01
In:    serial
Out:   serial
Err:   serial
Net:   eTSEC0, eTSEC1, FSL UEC0, FSL UEC1

But now I have the following problem:

## Checking Image at 02000100 ...
   Legacy image found
   Image Name:   Linux-2.6.25.5
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1354587 Bytes =3D  1.3 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
## Booting kernel from Legacy Image at 02000100 ...
   Image Name:   Linux-2.6.25.5
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1354587 Bytes =3D  1.3 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
## Loading init Ramdisk from Legacy Image at 02200100 ...
   Image Name:   initrd
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    3658157 Bytes =3D  3.5 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
## Flattened Device Tree blob at 021f0100
   Booting using the fdt blob at 0x21f0100
   Uncompressing Kernel Image ... OK
   Loading Device Tree to 007fa000, end 007fffff ... OK
WARNING: could not set linux,stdout-path FDT_ERR_NOTFOUND.
ERROR: /chosen node create failed - must RESET the board to recover.

Do I need to add some environment variables or set some fdt commands =
before booting the board?
Here are the env variables

=3D> printenv
ramboot=3Drun ramargs;tftp $ramdiskaddr $ramdiskfile;tftp $loadaddr =
$bootfile;bootm $loadaddr $ramdiskaddr
nfsboot=3Drun nfsargs;tftp $loadaddr $bootfile;tftp $fdtaddr =
$fdtfile;bootm $loadaddr - $fdtaddr
bootdelay=3D10
baudrate=3D115200
loads_echo=3D1
ethaddr=3D00:E0:0C:00:00:FD
eth1addr=3D00:E0:0C:00:01:FD
eth2addr=3D00:E0:0C:00:02:FD
eth3addr=3D00:E0:0C:00:03:FD
rootpath=3D/nfsroot
gatewayip=3D192.168.1.1
netmask=3D255.255.255.0
bootfile=3Dyour.uImage
netdev=3Deth0
consoledev=3DttyS0
ramdiskaddr=3D600000
ramdiskfile=3Dyour.ramdisk.u-boot
fdtaddr=3D400000
fdtfile=3Dyour.fdt.dtb
nfsargs=3Dsetenv bootargs root=3D/dev/nfs rw =
nfsroot=3D$serverip:$rootpath =
ip=3D$ipaddr:$serverip:$gatewayip:$netmask:$hostname:$netdev:off =
console=3D$consoledev,$bau
drate $othbootargs
ramargs=3Dsetenv bootargs root=3D/dev/ram rw =
console=3D$consoledev,$baudrate $othbootargs
ethact=3DeTSEC0
serverip=3D192.168.0.33
ipaddr=3D192.168.0.126
bootcmdFREE=3Drun ramargs;cp.b fff00000 400000 3500;bootm ff800000 =
ffa00000 400000
myaps=3DMPC8568MDS/aps
mtdargs=3Dmtdparts=3Dphysmap-flash.0:1M(boot),7M(aps0),7M(aps1),1M(optusr=
)
pram=3D0x100000
mem=3D0x3f00000
pram_start=3D0x3f00000
loadaddr=3D0x2000000
aps0_fl_start=3D0xfe100000
aps0_fl_size=3D0x00700000
aps1_fl_start=3D0xfe800000
aps1_fl_end=3D0xfeefffff
aps1_fl_size=3D0x00700000
aps_ram_start=3D0x2000000
aps_ram_kernel_start=3D0x2000100
aps_ram_dtb_start=3D0x21f0100
aps_ram_rootfs_start=3D0x2200100
aps=3D0
dl_boot=3Dtftp ${aps_ram_start} "u-boot.bin" && protect off 0xfe000000 =
0xfe07ffff && cp.b ${aps_ram_start} 0xfe000000 ${filesize} && protect on =
0xfe000000 0xf
e07ffff && saveenv
bootcmd=3Dif itest ${aps} =3D=3D 0; then run dl_ram0; else run =
dl_ram1;fi
altbootcmd=3Dmw.b ${pram_start} 0 ${pram} && if itest ${aps} =3D=3D 0; =
then setenv aps 1; else setenv aps 0; fi; saveenv; run bootcmd
dl_ram0=3Dcp.b ${aps0_fl_start} ${aps_ram_start} ${aps0_fl_size};if imi =
${aps_ram_kernel_start}; then run bargs;bootm ${aps_ram_kernel_start} =
${aps_ram_rootfs
_start} ${aps_ram_dtb_start}; else reset; fi
dl_ram1=3Dcp.b ${aps1_fl_start} ${aps_ram_start} ${aps1_fl_size};if imi =
${aps_ram_kernel_start}; then run bargs;bootm ${aps_ram_kernel_start} =
${aps_ram_rootfs
_start} ${aps_ram_dtb_start}; else reset; fi
bootlimit=3D5
initrd_high=3Dno
hostname=3DMPC8568MDS
aps0_fl_end=3D0xfe7fffff
dl_aps0=3Dtftp ${aps_ram_start} ${myaps};erase ${aps0_fl_start} =
${aps0_fl_end};cp.b ${aps_ram_start} ${aps0_fl_start} ${filesize};boot
dl_aps1=3Dtftp ${aps_ram_start} ${myaps};erase ${aps1_fl_start} =
${aps1_fl_end};cp.b ${aps_ram_start} ${aps1_fl_start} ${filesize};boot
bargs=3Dsetenv bootargs ${mtdargs} console=3DttyS0,$baudrate =
root=3D/dev/ram ramdisk_size=3D500000 rw =
ip=3D${ipaddr}:${serverip}:${gatewayip}:${netmask}:${hostname}:e
th0:off panic=3D1 mem=3D${mem} aps=3D${aps} ${misc} ${slram}
dl_mykernel=3Dtftp 1000000 MPC8568MDS/uImage; erase ff800000 ff9fffff; =
cp.b 1000000 ff800000 ${filesize}
dl_myrootfs=3Dtftp 2000000 MPC8568MDS/RamDisk.ext2; erase ffa00000 =
ffefffff; cp.b 2000000 ffa00000 ${filesize}
dl_mydtb=3Dtftp 400000 MPC8568MDS/mpc8568mds.dtb; erase fff00000 =
fff7ffff; cp.b 400000 fff00000 ${filesize}
fdt_file=3DMPC8568MDS/mpc8568mds.dtb
fdt_addr_r=3D0x21f0100
stdin=3Dserial
stdout=3Dserial
stderr=3Dserial

With previous u-boot I was able to load the images separately, with this =
u-boot I have the error.

Best Regards
Agostino




> -----Original Message-----
> From: Anatolij Gustschin [mailto:agust@denx.de]=20
> Sent: marted=EC 2 settembre 2008 12.11
> To: SETTE AGOSTINO - technolabs
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: MPC8568MDS RAMDISK Problem
>=20
> Hi Agostino,
>=20
> SETTE AGOSTINO - technolabs wrote:
>=20
> > First of all thanks for your help. I modified the=20
> mpc8568mds_defconfig
> >=20
> >>> cat kernel/linux/arch/powerpc/configs/mpc8568mds_defconfig
> > #
>=20
> <snip>
>=20
> >=20
> > But now I face this problem
> >=20
> > ## Checking Image at 02000100 ...
> >    Image Name:   Linux-2.6.25.5
> >    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
> >    Data Size:    1354578 Bytes =3D  1.3 MB
> >    Load Address: 00000000
> >    Entry Point:  00000000
> >    Verifying Checksum ... OK
> > ## Booting image at 02000100 ...
> >    Image Name:   Linux-2.6.25.5
> >    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
> >    Data Size:    1354578 Bytes =3D  1.3 MB
> >    Load Address: 00000000
> >    Entry Point:  00000000
> >    Verifying Checksum ... OK
> >    Uncompressing Kernel Image ... OK
> > ## Loading RAMDisk Image at 02200100 ...
> >    Image Name:   initrd
> >    Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
> >    Data Size:    3658110 Bytes =3D  3.5 MB
> >    Load Address: 00000000
> >    Entry Point:  00000000
> >    Verifying Checksum ... OK
> >    Booting using the fdt at 0x21f0100
> >    Loading Ramdisk to 00482000, end 007ff17e ... OK
> >    Loading Device Tree to 007fa000, end 007fcfff ... OK
>=20
> Ramdisk image is partially overwritten while loading the
> Device Tree: Ramdisk ends at 0x007ff17e, Device Tree starts
> at 0x007fa000. You probably need to update U-Boot to recent
> version to solve this issue.
>=20
> > Using MPC85xx MDS machine description
> > Memory CAM mapping: CAM0=3D16Mb, CAM1=3D16Mb, CAM2=3D16Mb residual: =
15Mb
> > Linux version 2.6.25.5 (ity10223@aqlbl05x) (gcc version=20
> 4.2.2) #1 Mon Sep 1 10:44:44 CEST 2008
> > Found initrd at 0xc0482000:0xc07ff17e
>=20
> <snip>
>=20
> > RAMDISK: Compressed image found at block 0
> > invalid compressed format (err=3D1)
>=20
> Ramdisk decompression failed, it's expected as ramdisk was
> overwritten by DTB while booting.
>=20
> Try to update U-Boot to v1.3.4.
>=20
> Best regards,
> Anatolij
>=20
> --=20
> DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
>=20
