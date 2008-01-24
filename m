Return-Path: <bgholikh@cisco.com>
Received: from sj-iport-5.cisco.com (sj-iport-5.cisco.com [171.68.10.87])
	by ozlabs.org (Postfix) with ESMTP id 3D8E0DDE3F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Jan 2008 09:04:31 +1100 (EST)
Received: from sj-core-5.cisco.com (sj-core-5.cisco.com [171.71.177.238])
	by sj-dkim-2.cisco.com (8.12.11/8.12.11) with ESMTP id m0OLsh0J015871
	for <linuxppc-embedded@ozlabs.org>; Thu, 24 Jan 2008 13:54:43 -0800
Received: from xbh-sjc-231.amer.cisco.com (xbh-sjc-231.cisco.com
	[128.107.191.100])
	by sj-core-5.cisco.com (8.12.10/8.12.6) with ESMTP id m0OLsaB1007373
	for <linuxppc-embedded@ozlabs.org>; Thu, 24 Jan 2008 21:54:43 GMT
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C85ED3.99119281"
Subject: Failed to mount rootfs
Date: Thu, 24 Jan 2008 13:53:47 -0800
Message-ID: <F795765B112E7344AF36AA911279641502D1A9F4@xmb-sjc-212.amer.cisco.com>
From: "Bizhan Gholikhamseh (bgholikh)" <bgholikh@cisco.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C85ED3.99119281
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi All,
Our custom board is leveraged from MPC8541cds from freescale.
We have been running Linux 2.6.11 on it recently I have tried to boot
the system with the latest Linux 2.6.22-rc4 from PowerPC git tree.
=20
I did ported the libfdt to our older version of the uboot and were able
to
resolve the device tree. After downloading the uImage, dtb file and
ramdisk
I use the bootm command to boot the linux, but it failes..
........................................................................
...................
driver initialized: 16 RAM disks of 4096K size 1024 blocksize
VFS: Cannot open root device "<NULL>" or unknown-block(0,0) Please
append a correct "root=3D" boot option; here are the available =
partitions:
Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(0,0) Rebooting in 180 seconds..
........................................................................
...............
=20
During boot I observeed that the "kernel Command Line:" is empty, is
this parameter should be supplied by fdt also?
=20
I have copied the boot log and dump of the device tree below, Any help
greatly appreicate it.
=20
Thanks,
=20
=20
=20
Last Reset Type: Power On
FLASH: 8 MB
L2 cache 256KB:enabled
In: serial
Out: serial
Err: serial
Net: TSEC0.
IDE: Compact Flash: Bus 0: OK
Device 0: Model: STI Flash 7.4.0 Firm: 01.25.06 Ser#: STI
J106306241050439
Type: Hard Disk
Capacity: 245.0 MB =3D 0.2 GB (501760 x 512) System watchdog: is now
stopped.
=3D> printenv
bootcmd=3Dsetenv bootargs root=3D/dev/hda2 rw =
console=3D$consoledev,$baudrate
$othbootargs;setenv autostart yes;diskboot $l; nfsboot=3Dsetenv bootargs
root=3D/dev/nfs rw nfsroot=3D$serverip:$rootpath
ip=3D$ipaddr:$serverip:$gatewayip:$netmask:$hostnar
bootdelay=3D2
baudrate=3D115200
loads_echo=3D1
rootpath=3D/nfsroot
hostname=3Dunknown
loadaddr=3D1000000
netdev=3Deth0
consoledev=3DttyS1
ramdiskaddr=3D1000000
ramdiskfile=3Dramdisk.UBoot
ethact=3DTSEC0
firstboot=3Dno
bootargs=3Droot=3D/dev/ram rw console=3DttyS1,115200 fdfile=3Dbiz3.dtb
bootfile=3DuImage
ramboot=3Dsetenv bootargs root=3D/dev/ram rw console=3DttyS1,115200
filesize=3D80000 fileaddr=3D100000
ipaddr=3D172.28.176.13
serverip=3D172.28.176.140
stdin=3Dserial
stdout=3Dserial
stderr=3Dserial
ethaddr=3D00:18:18:8f:a6:ac
eth1addr=3D00:18:18:8f:a6:ad
eth2addr=3D00:18:18:8f:a6:ae
pid=3DCTS-CODEC-PRIM=3D
serial=3DFSJC0537522
ver_id=3DV01
hwver=3D0400
ver=3DU-boot 1.1.2(pq3-20050113-0) (Jan 20 2008 - 18:03:58)
Environment size: 1050/8188 bytes
=3D> tftp 100000 uImage
Using TSEC0 device
TFTP from server 172.28.176.140; our IP address is 172.28.176.13
Filename 'uImage'.
Load address: 0x100000
Loading:
#################################################################
###########################################################
done
Bytes transferred =3D 629989 (99ce5 hex)
=3D> tftp 2000000 ramdisk.u-boot
Using TSEC0 device
TFTP from server 172.28.176.140; our IP address is 172.28.176.13
Filename 'ramdisk.u-boot'.
Load address: 0x2000000
Loading:
#################################################################
#################################################################
#################################################################
#################################################################
#################################################################
#################################################################
#################################################################
#################################################################
#################################################################
#################################################################
done
Bytes transferred =3D 15622378 (ee60ea hex) =3D> tftp c00000 board.dtb =
Using
TSEC0 device TFTP from server 172.28.176.140; our IP address is
172.28.176.13 Filename 'board.dtb'.
Load address: 0xc00000
Loading: #
done
Bytes transferred =3D 4273 (10b1 hex)
=3D> bootm 100000 2000000 c00000
## Booting image at 00100000 ...
Image Name: Linux-2.6.22-rc4-geff2ebd2-dirty
Image Type: PowerPC Linux Kernel Image (gzip compressed)
Data Size: 629925 Bytes =3D 615.2 kB
Load Address: 00000000
Entry Point: 00000000
Verifying Checksum ... OK
Uncompressing Kernel Image ... OK
>>> inside do_bootm_linux <<<<
## Loading RAMDisk Image at 02000000 ...
Image Name: MPC85xxCDS MTWKS Ramdisk
Image Type: PowerPC Linux RAMDisk Image (gzip compressed)
Data Size: 15622314 Bytes =3D 14.9 MB
Load Address: 00000000
Entry Point: 00000000
Verifying Checksum ... OK
Booting using flat device tree at 0xc00000
Loading Ramdisk to 1ef33000, end 1fe190aa ... OK vfpga watchdog not
supported in this CTS version. Keeping watchdog disabled System
watchdog: is now stopped.
## Transferring control to Kernel (at address 00000000) ...
Using MPC85xx CDS machine description
Memory CAM mapping: CAM0=3D256Mb, CAM1=3D256Mb, CAM2=3D0Mb residual: 0Mb =
Linux
version 2.6.22-rc4-geff2ebd2-dirty (bizhan@bizhanhost.cisco.com) (gcc
version 3.4.3) #6 Sun Jan 20 22:51:26 PST8
setup_arch: bootmem
mpc85xx_cds_setup_arch()
CDS Version =3D 0xff in slot 4
Found MPC85xx PCI host bridge at 0x00000000e0008000. Firmware bus
number: 0->0 Found MPC85xx PCI host bridge at 0x00000000e0009000.
Firmware bus number: 0->0
arch: exit
Zone PFN ranges:
DMA 0 -> 131072
Normal 131072 -> 131072
early_node_map[1] active PFN ranges
0: 0 -> 131072
Built 1 zonelists. Total pages: 130048
Kernel command line:
mpic: Setting up MPIC " OpenPIC " version 1.2 at e0040000, max 1 CPUs
mpic: ISU size: 4, shift: 2, mask: 3
mpic: Initializing for 60 sources
PID hash table entries: 2048 (order: 11, 8192 bytes) Dentry cache hash
table entries: 65536 (order: 6, 262144 bytes) Inode-cache hash table
entries: 32768 (order: 5, 131072 bytes)
Memory: 502528k/524288k available (1224k kernel code, 21196k reserved,
64k data, 108k bss, 116k init) Mount-cache hash table entries: 512
device-tree: Duplicate name in /, renamed to "chosen#1"
PCI: Probing PCI hardware
PCI: Cannot allocate resource region 0 of device 0000:00:16.0
PCI: Cannot allocate resource region 1 of device 0000:00:16.0
PCI: Cannot allocate resource region 0 of device 0000:00:19.0
PCI: Cannot allocate resource region 2 of device 0000:00:19.0
PCI: Cannot allocate resource region 0 of device 0001:00:15.0
PCI: Cannot allocate resource region 1 of device 0001:00:15.0
PCI: Cannot allocate resource region 2 of device 0001:00:15.0 io
scheduler noop registered (default)
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0xe0004500 (irq =3D 26) is a =
16550A....?50.0:
ttyS1 at MMIO 0xe0004600 (irq =3D 26) is a 16 A
] RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
VFS: Cannot open root device "<NULL>" or unknown-block(0,0) Please
append a correct "root=3D" boot option; here are the available =
partitions:
Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(0,0) Rebooting in 180 seconds..
=20
=20
And here is the device tree:
/memreserve/ a 0;
 {
    model =3D "MPC8541CDS";
    compatible =3D [4d 50 43 38 35 34 31 43 44 53 00 4d 50 43 38 35 78 =
78
43 44 53 00];
    #address-cells =3D <1>;
    #size-cells =3D <1>;
    cpus {
        #address-cells =3D <1>;
        #size-cells =3D <0>;
        PowerPC,8541@0 {
            device_type =3D "cpu";
            reg =3D <0>;
            d-cache-line-size =3D <20>;
            i-cache-line-size =3D <20>;
            d-cache-size =3D <8000>;
            i-cache-size =3D <8000>;
            timebase-frequency =3D <1f78a40>;
            bus-frequency =3D <fbc5200>;
            clock-frequency =3D <1f78a400>;
            32-bit;
        };
    };
    memory {
        device_type =3D "memory";
        reg =3D <8>;
    };
    soc8541@e0000000 {
        #address-cells =3D <1>;
        #size-cells =3D <1>;
        #interrupt-cells =3D <2>;
        device_type =3D "soc";
        ranges =3D [00 00 00 00 e0 00 00 00 00 10 00 00];
        reg =3D <8>;
        bus-frequency =3D <0>;
        memory-controller@2000 {
            compatible =3D "fsl,8541-memory-controller";
            reg =3D <8>;
            interrupt-parent =3D <1>;
            interrupts =3D <8>;
        };
        l2-cache-controller@20000 {
            compatible =3D "fsl,8541-l2-cache-controller";
            reg =3D <8>;
            cache-line-size =3D <20>;
            cache-size =3D <40000>;
            interrupt-parent =3D <1>;
            interrupts =3D <8>;
        };
        i2c@3000 {
            device_type =3D "i2c";
            compatible =3D "fsl-i2c";
            reg =3D <8>;
            interrupts =3D <8>;
            interrupt-parent =3D <1>;
            dfsrr;
        };
        mdio@24520 {
            #address-cells =3D <1>;
            #size-cells =3D <0>;
            device_type =3D "mdio";
            compatible =3D "gianfar";
            reg =3D <8>;
            ethernet-phy@0 {
                interrupt-parent =3D <1>;
                interrupts =3D <8>;
                reg =3D <0>;
                device_type =3D "ethernet-phy";
                linux,phandle =3D <2>;
            };
            ethernet-phy@1 {
                interrupt-parent =3D <1>;
                interrupts =3D <8>;
                reg =3D <1>;
                device_type =3D "ethernet-phy";
            };
        };
        ethernet@24000 {
            #address-cells =3D <1>;
            #size-cells =3D <0>;
            device_type =3D "network";
            model =3D "TSEC";
            compatible =3D "gianfar";
            reg =3D <8>;
            local-mac-address =3D [00 18 18 8f a6 ac];
            interrupts =3D [00 00 00 0d 00 00 00 02 00 00 00 0e 00 00 00
02 00 00 00 12 00 00 00 02];
            interrupt-parent =3D <1>;
            phy-handle =3D <2>;
        };
        serial@4500 {
            device_type =3D "serial";
            compatible =3D "ns16550";
            reg =3D <8>;
            clock-frequency =3D <fbc5200>;
            interrupts =3D <8>;
            interrupt-parent =3D <1>;
        };
        serial@4600 {
            device_type =3D "serial";
            compatible =3D "ns16550";
            reg =3D <8>;
            clock-frequency =3D <fbc5200>;
            interrupts =3D <8>;
            interrupt-parent =3D <1>;
        };
        pci@8000 {
            interrupt-map-mask =3D [00 01 f8 00 00 00 00 00 00 00 00 00 =
00
00 00 07];
            interrupt-map =3D [00 00 80 00 00 00 00 00 00 00 00 00 00 00
00 04 00 00 00 01 00 00 00 30 00 00 00 01 00 0;
            interrupt-parent =3D <1>;
            interrupts =3D <8>;
            bus-range =3D <8>;
            ranges =3D [02 00 00 00 00 00 00 00 80 00 00 00 80 00 00 00 =
00
00 00 00 20 00 00 00 01 00 00 00 00 00 00 00;
            clock-frequency =3D <3f940aa>;
            #interrupt-cells =3D <1>;
            #size-cells =3D <2>;
            #address-cells =3D <3>;
            reg =3D <8>;
            compatible =3D "85xx";
            device_type =3D "pci";
            linux,phandle =3D <3>;
            i8259@19000 {
                clock-frequency =3D <0>;
                interrupt-controller;
                device_type =3D "interrupt-controller";
                reg =3D [00 01 90 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 01];
                #address-cells =3D <0>;
                #interrupt-cells =3D <2>;
                built-in;
                compatible =3D "chrp,iic";
                big-endian;
                interrupts =3D <1>;
                interrupt-parent =3D <3>;
            };
        };
        pci@9000 {
            interrupt-map-mask =3D [00 00 f8 00 00 00 00 00 00 00 00 00 =
00
00 00 07];
            interrupt-map =3D [00 00 a8 00 00 00 00 00 00 00 00 00 00 00
00 01 00 00 00 01 00 00 00 3b 00 00 00 01 00 0;
            interrupt-parent =3D <1>;
            interrupts =3D <8>;
            bus-range =3D <8>;
            ranges =3D [02 00 00 00 00 00 00 00 a0 00 00 00 a0 00 00 00 =
00
00 00 00 20 00 00 00 01 00 00 00 00 00 00 00;
            clock-frequency =3D <3f940aa>;
            #interrupt-cells =3D <1>;
            #size-cells =3D <2>;
            #address-cells =3D <3>;
            reg =3D <8>;
            compatible =3D "85xx";
            device_type =3D "pci";
        };
        pic@40000 {
            clock-frequency =3D <0>;
            interrupt-controller;
            #address-cells =3D <0>;
            #interrupt-cells =3D <2>;
            reg =3D <8>;
            built-in;
            compatible =3D "chrp,open-pic";
            device_type =3D "open-pic";
            big-endian;
            linux,phandle =3D <1>;
        };
    };
    chosen {
        linux,stdout-path =3D "/soc8541@e0000000/serial@4600";
    };
    chosen {
        name =3D "chosen";
        bootargs =3D "root=3D/dev/ram rw console=3DttyS1,115200";
        linux,platform =3D <600>;
        linux,initrd-start =3D <1ef33000>;
        linux,initrd-end =3D <1fe190aa>;
        linux,stdout-path =3D "/soc8541@e0000000/serial@4600";
    };
};

=20

------_=_NextPart_001_01C85ED3.99119281
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3243" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D468543321-24012008>Hi=20
All,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D468543321-24012008>Our =
custom board is=20
leveraged from MPC8541cds from freescale.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D468543321-24012008>We =
have been running=20
Linux 2.6.11 on it recently I have tried to boot</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D468543321-24012008>the =
system with the=20
latest Linux 2.6.22-rc4 from PowerPC git tree.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><FONT face=3DArial size=3D2><SPAN =

class=3D468543321-24012008></SPAN></FONT></FONT></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D468543321-24012008>I did =
ported the=20
libfdt to our older version of the uboot and were able =
to</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D468543321-24012008>resolve the device=20
tree.&nbsp;After downloading the&nbsp;uImage, dtb file and=20
ramdisk</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D468543321-24012008>I =
use&nbsp;the bootm=20
command to boot the&nbsp;linux, but it failes..</SPAN></FONT></DIV>
<DIV><FONT><SPAN class=3D468543321-24012008><FONT face=3DArial=20
size=3D2>................................................................=
...........................</FONT></FONT></DIV>
<DIV><FONT face=3DArial size=3D2>driver initialized: 16 RAM disks of =
4096K size 1024=20
blocksize</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>VFS: Cannot open root device =
"&lt;NULL&gt;" or=20
unknown-block(0,0) Please append a correct "root=3D" boot option; here =
are the=20
available partitions:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Kernel panic - not syncing: VFS: Unable =
to mount=20
root fs on unknown-block(0,0) Rebooting in 180 seconds..</FONT></DIV>
<DIV><SPAN class=3D468543321-24012008><FONT face=3DArial=20
size=3D2>................................................................=
.......................</FONT></SPAN></DIV>
<DIV><SPAN class=3D468543321-24012008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D468543321-24012008><FONT face=3DArial size=3D2>During =
boot I=20
observeed that the "kernel Command Line:" is empty, is this parameter =
should be=20
supplied by fdt also?</FONT></SPAN></DIV>
<DIV><SPAN class=3D468543321-24012008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D468543321-24012008><FONT face=3DArial size=3D2>I have =
copied the=20
boot log and dump of the device tree below, Any help greatly appreicate=20
it.</FONT></SPAN></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN =
class=3D468543321-24012008><FONT=20
face=3DArial size=3D2></FONT></SPAN></FONT></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D468543321-24012008><FONT face=3DArial=20
size=3D2>Thanks,</FONT></SPAN></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN =
class=3D468543321-24012008><FONT=20
face=3DArial size=3D2></FONT></SPAN></FONT></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D468543321-24012008>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Last Reset Type: Power On</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>FLASH: 8 MB</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>L2 cache 256KB:enabled</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>In: serial</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Out: serial</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Err: serial</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Net: TSEC0.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>IDE: Compact Flash: Bus 0: =
OK</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Device 0: Model: STI Flash 7.4.0 Firm: =
01.25.06=20
Ser#: STI J106306241050439</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Type: Hard Disk</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Capacity: 245.0 MB =3D 0.2 GB (501760 x =
512) System=20
watchdog: is now stopped.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>=3D&gt; printenv</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>bootcmd=3Dsetenv bootargs =
root=3D/dev/hda2 rw=20
console=3D$consoledev,$baudrate $othbootargs;setenv autostart =
yes;diskboot $l;=20
nfsboot=3Dsetenv bootargs root=3D/dev/nfs rw =
nfsroot=3D$serverip:$rootpath=20
ip=3D$ipaddr:$serverip:$gatewayip:$netmask:$hostnar</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>bootdelay=3D2</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>baudrate=3D115200</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>loads_echo=3D1</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>rootpath=3D/nfsroot</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>hostname=3Dunknown</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>loadaddr=3D1000000</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>netdev=3Deth0</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>consoledev=3DttyS1</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>ramdiskaddr=3D1000000</FONT></DIV>
<DIV><FONT face=3DArial =
size=3D2>ramdiskfile=3Dramdisk.UBoot</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>ethact=3DTSEC0</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>firstboot=3Dno</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>bootargs=3Droot=3D/dev/ram rw =
console=3DttyS1,115200=20
fdfile=3Dbiz3.dtb</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>bootfile=3DuImage</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>ramboot=3Dsetenv bootargs =
root=3D/dev/ram rw=20
console=3DttyS1,115200 filesize=3D80000 fileaddr=3D100000</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>ipaddr=3D172.28.176.13</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>serverip=3D172.28.176.140</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>stdin=3Dserial</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>stdout=3Dserial</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>stderr=3Dserial</FONT></DIV>
<DIV><FONT face=3DArial =
size=3D2>ethaddr=3D00:18:18:8f:a6:ac</FONT></DIV>
<DIV><FONT face=3DArial =
size=3D2>eth1addr=3D00:18:18:8f:a6:ad</FONT></DIV>
<DIV><FONT face=3DArial =
size=3D2>eth2addr=3D00:18:18:8f:a6:ae</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>pid=3DCTS-CODEC-PRIM=3D</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>serial=3DFSJC0537522</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>ver_id=3DV01</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>hwver=3D0400</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>ver=3DU-boot 1.1.2(pq3-20050113-0) (Jan =
20 2008 -=20
18:03:58)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Environment size: 1050/8188 =
bytes</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>=3D&gt; tftp 100000 uImage</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Using TSEC0 device</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>TFTP from server 172.28.176.140; our IP =
address is=20
172.28.176.13 Filename 'uImage'.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Load address: 0x100000</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Loading:=20
#################################################################</FONT><=
/DIV>
<DIV><FONT face=3DArial=20
size=3D2>###########################################################</FON=
T></DIV>
<DIV><FONT face=3DArial size=3D2>done</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Bytes transferred =3D 629989 (99ce5 =
hex)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>=3D&gt; tftp 2000000 =
ramdisk.u-boot</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Using TSEC0 device</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>TFTP from server 172.28.176.140; our IP =
address is=20
172.28.176.13 Filename 'ramdisk.u-boot'.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Load address: 0x2000000</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Loading:=20
#################################################################</FONT><=
/DIV>
<DIV><FONT face=3DArial=20
size=3D2>################################################################=
#</FONT></DIV>
<DIV><FONT face=3DArial=20
size=3D2>################################################################=
#</FONT></DIV>
<DIV><FONT face=3DArial=20
size=3D2>################################################################=
#</FONT></DIV>
<DIV><FONT face=3DArial=20
size=3D2>################################################################=
#</FONT></DIV>
<DIV><FONT face=3DArial=20
size=3D2>################################################################=
#</FONT></DIV>
<DIV><FONT face=3DArial=20
size=3D2>################################################################=
#</FONT></DIV>
<DIV><FONT face=3DArial=20
size=3D2>################################################################=
#</FONT></DIV>
<DIV><FONT face=3DArial=20
size=3D2>################################################################=
#</FONT></DIV>
<DIV><FONT face=3DArial=20
size=3D2>################################################################=
#</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>done</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Bytes transferred =3D 15622378 (ee60ea =
hex) =3D&gt;=20
tftp c00000 b<SPAN class=3D468543321-24012008>oard</SPAN>.dtb Using =
TSEC0 device=20
TFTP from server 172.28.176.140; our IP address is 172.28.176.13 =
Filename '<SPAN=20
class=3D468543321-24012008>board</SPAN>.dtb'.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Load address: 0xc00000</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Loading: #</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>done</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Bytes transferred =3D 4273 (10b1 =
hex)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>=3D&gt; bootm 100000 2000000 =
c00000</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>## Booting image at 00100000 =
...</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Image Name:=20
Linux-2.6.22-rc4-geff2ebd2-dirty</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Image Type: PowerPC Linux Kernel Image =
(gzip=20
compressed)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Data Size: 629925 Bytes =3D 615.2 =
kB</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Load Address: 00000000</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Entry Point: 00000000</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Verifying Checksum ... OK</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Uncompressing Kernel Image ... =
OK</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>&gt;&gt;&gt; inside do_bootm_linux=20
&lt;&lt;&lt;&lt;</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>## Loading RAMDisk Image at 02000000=20
...</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Image Name: MPC85xxCDS MTWKS =
Ramdisk</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Image Type: PowerPC Linux RAMDisk Image =
(gzip=20
compressed)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Data Size: 15622314 Bytes =3D 14.9 =
MB</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Load Address: 00000000</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Entry Point: 00000000</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Verifying Checksum ... OK</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Booting using flat device tree at=20
0xc00000</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Loading Ramdisk to 1ef33000, end =
1fe190aa ... OK=20
vfpga watchdog not supported in this CTS version. Keeping watchdog =
disabled=20
System watchdog: is now stopped.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>## Transferring control to Kernel (at =
address=20
00000000) ...</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Using MPC85xx CDS machine =
description</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Memory CAM mapping: CAM0=3D256Mb, =
CAM1=3D256Mb,=20
CAM2=3D0Mb residual: 0Mb Linux version 2.6.22-rc4-geff2ebd2-dirty=20
(bizhan@bizhanhost.cisco.com) (gcc version 3.4.3) #6 Sun Jan 20 22:51:26 =

PST8</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>setup_arch: bootmem</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>mpc85xx_cds_setup_arch()</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>CDS Version =3D 0xff in slot =
4</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Found MPC85xx PCI host bridge at=20
0x00000000e0008000. Firmware bus number: 0-&gt;0 Found MPC85xx PCI host =
bridge=20
at 0x00000000e0009000. Firmware bus number: 0-&gt;0</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>arch: exit</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Zone PFN ranges:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>DMA 0 -&gt; 131072</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Normal 131072 -&gt; 131072</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>early_node_map[1] active PFN =
ranges</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>0: 0 -&gt; 131072</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Built 1 zonelists. Total pages: =
130048</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Kernel command line:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>mpic: Setting up MPIC " OpenPIC " =
version 1.2 at=20
e0040000, max 1 CPUs</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>mpic: ISU size: 4, shift: 2, mask: =
3</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>mpic: Initializing for 60 =
sources</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>PID hash table entries: 2048 (order: =
11, 8192=20
bytes) Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)=20
Inode-cache hash table entries: 32768 (order: 5, 131072 =
bytes)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Memory: 502528k/524288k available =
(1224k kernel=20
code, 21196k reserved, 64k data, 108k bss, 116k init) Mount-cache hash =
table=20
entries: 512</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>device-tree: Duplicate name in /, =
renamed to=20
"chosen#1"</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>PCI: Probing PCI hardware</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>PCI: Cannot allocate resource region 0 =
of device=20
0000:00:16.0</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>PCI: Cannot allocate resource region 1 =
of device=20
0000:00:16.0</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>PCI: Cannot allocate resource region 0 =
of device=20
0000:00:19.0</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>PCI: Cannot allocate resource region 2 =
of device=20
0000:00:19.0</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>PCI: Cannot allocate resource region 0 =
of device=20
0001:00:15.0</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>PCI: Cannot allocate resource region 1 =
of device=20
0001:00:15.0</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>PCI: Cannot allocate resource region 2 =
of device=20
0001:00:15.0 io scheduler noop registered (default)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Serial: 8250/16550 driver $Revision: =
1.90 $ 2=20
ports, IRQ sharing enabled</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>serial8250.0: ttyS0 at MMIO 0xe0004500 =
(irq =3D 26)=20
is a 16550A....?50.0: ttyS1 at MMIO 0xe0004600 (irq =3D 26) is a 16 =
A</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>] RAMDISK driver initialized: 16 RAM =
disks of 4096K=20
size 1024 blocksize</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>VFS: Cannot open root device =
"&lt;NULL&gt;" or=20
unknown-block(0,0) Please append a correct "root=3D" boot option; here =
are the=20
available partitions:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Kernel panic - not syncing: VFS: Unable =
to mount=20
root fs on unknown-block(0,0) Rebooting in 180 seconds..</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D468543321-24012008><FONT face=3DArial size=3D2>And =
here is the=20
device tree:</FONT></SPAN></DIV>
<DIV><SPAN class=3D468543321-24012008><FONT face=3DArial =
size=3D2>/memreserve/ a=20
0;<BR>&nbsp;{<BR>&nbsp;&nbsp;&nbsp; model =3D =
"MPC8541CDS";<BR>&nbsp;&nbsp;&nbsp;=20
compatible =3D [4d 50 43 38 35 34 31 43 44 53 00 4d 50 43 38 35 78 78 43 =
44 53=20
00];<BR>&nbsp;&nbsp;&nbsp; #address-cells =3D =
&lt;1&gt;;<BR>&nbsp;&nbsp;&nbsp;=20
#size-cells =3D &lt;1&gt;;<BR>&nbsp;&nbsp;&nbsp; cpus=20
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #address-cells =3D=20
&lt;1&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #size-cells =3D =

&lt;0&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PowerPC,8541@0=20
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
device_type =3D=20
"cpu";<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; reg=20
=3D=20
&lt;0&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
d-cache-line-size =3D=20
&lt;20&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;=20
i-cache-line-size =3D=20
&lt;20&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;=20
d-cache-size =3D=20
&lt;8000&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;=20
i-cache-size =3D=20
&lt;8000&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;=20
timebase-frequency =3D=20
&lt;1f78a40&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;=20
bus-frequency =3D=20
&lt;fbc5200&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;=20
clock-frequency =3D=20
&lt;1f78a400&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;=20
32-bit;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
};<BR>&nbsp;&nbsp;&nbsp;=20
};<BR>&nbsp;&nbsp;&nbsp; memory =
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
device_type =3D "memory";<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
reg =3D=20
&lt;8&gt;;<BR>&nbsp;&nbsp;&nbsp; };<BR>&nbsp;&nbsp;&nbsp; <A=20
href=3D"mailto:soc8541@e0000000">soc8541@e0000000</A>=20
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #address-cells =3D=20
&lt;1&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #size-cells =3D =

&lt;1&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
#interrupt-cells =3D=20
&lt;2&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_type =3D =

"soc";<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ranges =3D [00 00 =
00 00 e0 00=20
00 00 00 10 00 00];<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =
=3D=20
&lt;8&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bus-frequency =
=3D=20
&lt;0&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <A=20
href=3D"mailto:memory-controller@2000">memory-controller@2000</A>=20
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
compatible =3D=20
"fsl,8541-memory-controller";<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;=20
reg =3D=20
&lt;8&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
interrupt-parent =3D=20
&lt;1&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
interrupts =3D &lt;8&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
};<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <A=20
href=3D"mailto:l2-cache-controller@20000">l2-cache-controller@20000</A>=20
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
compatible =3D=20
"fsl,8541-l2-cache-controller";<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
reg =3D=20
&lt;8&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
cache-line-size =3D=20
&lt;20&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;=20
cache-size =3D=20
&lt;40000&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;=20
interrupt-parent =3D=20
&lt;1&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
interrupts =3D &lt;8&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
};<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <A=20
href=3D"mailto:i2c@3000">i2c@3000</A>=20
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
device_type =3D=20
"i2c";<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;=20
compatible =3D=20
"fsl-i2c";<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
reg =3D=20
&lt;8&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
interrupts =3D=20
&lt;8&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
interrupt-parent =3D=20
&lt;1&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
dfsrr;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
};<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <A=20
href=3D"mailto:mdio@24520">mdio@24520</A>=20
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
#address-cells =3D=20
&lt;1&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
#size-cells =3D=20
&lt;0&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
device_type =3D=20
"mdio";<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
compatible =3D=20
"gianfar";<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
reg =3D=20
&lt;8&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
<A href=3D"mailto:ethernet-phy@0">ethernet-phy@0</A>=20
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
interrupt-parent =3D=20
&lt;1&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
interrupts =3D=20
&lt;8&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
reg =3D=20
&lt;0&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
device_type =3D=20
"ethernet-phy";<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
linux,phandle =3D=20
&lt;2&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
};<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<A=20
href=3D"mailto:ethernet-phy@1">ethernet-phy@1</A>=20
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
interrupt-parent =3D=20
&lt;1&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
interrupts =3D=20
&lt;8&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
reg =3D=20
&lt;1&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
device_type =3D=20
"ethernet-phy";<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;=20
};<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
};<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <A=20
href=3D"mailto:ethernet@24000">ethernet@24000</A>=20
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
#address-cells =3D=20
&lt;1&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
#size-cells =3D=20
&lt;0&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
device_type =3D=20
"network";<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
model =3D=20
"TSEC";<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
compatible =3D=20
"gianfar";<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
reg =3D=20
&lt;8&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
local-mac-address =3D [00 18 18 8f a6=20
ac];<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;=20
interrupts =3D [00 00 00 0d 00 00 00 02 00 00 00 0e 00 00 00 02 00 00 00 =
12 00 00=20
00 =
02];<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;=20
interrupt-parent =3D=20
&lt;1&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
phy-handle =3D &lt;2&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
};<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <A=20
href=3D"mailto:serial@4500">serial@4500</A>=20
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
device_type =3D=20
"serial";<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;=20
compatible =3D=20
"ns16550";<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
reg =3D=20
&lt;8&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
clock-frequency =3D=20
&lt;fbc5200&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;=20
interrupts =3D=20
&lt;8&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
interrupt-parent =3D =
&lt;1&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
};<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <A=20
href=3D"mailto:serial@4600">serial@4600</A>=20
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
device_type =3D=20
"serial";<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;=20
compatible =3D=20
"ns16550";<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
reg =3D=20
&lt;8&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
clock-frequency =3D=20
&lt;fbc5200&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;=20
interrupts =3D=20
&lt;8&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
interrupt-parent =3D =
&lt;1&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
};<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <A=20
href=3D"mailto:pci@8000">pci@8000</A>=20
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
interrupt-map-mask =3D [00 01 f8 00 00 00 00 00 00 00 00 00 00 00 00=20
07];<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;=20
interrupt-map =3D [00 00 80 00 00 00 00 00 00 00 00 00 00 00 00 04 00 00 =
00 01 00=20
00 00 30 00 00 00 01 00=20
0;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =

interrupt-parent =3D=20
&lt;1&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
interrupts =3D=20
&lt;8&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
bus-range =3D=20
&lt;8&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
ranges =3D [02 00 00 00 00 00 00 00 80 00 00 00 80 00 00 00 00 00 00 00 =
20 00 00=20
00 01 00 00 00 00 00 00=20
00;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
=20
clock-frequency =3D=20
&lt;3f940aa&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;=20
#interrupt-cells =3D=20
&lt;1&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
#size-cells =3D=20
&lt;2&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
#address-cells =3D=20
&lt;3&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
reg =3D=20
&lt;8&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
compatible =3D=20
"85xx";<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
device_type =3D=20
"pci";<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;=20
linux,phandle =3D=20
&lt;3&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
<A href=3D"mailto:i8259@19000">i8259@19000</A>=20
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
clock-frequency =3D=20
&lt;0&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
interrupt-controller;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
device_type =3D=20
"interrupt-controller";<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
reg =3D [00 01 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=20
01];<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;=20
#address-cells =3D=20
&lt;0&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
#interrupt-cells =3D=20
&lt;2&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
built-in;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
compatible =3D=20
"chrp,iic";<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
big-endian;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
interrupts =3D=20
&lt;1&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
interrupt-parent =3D=20
&lt;3&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
};<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
};<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <A=20
href=3D"mailto:pci@9000">pci@9000</A>=20
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
interrupt-map-mask =3D [00 00 f8 00 00 00 00 00 00 00 00 00 00 00 00=20
07];<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;=20
interrupt-map =3D [00 00 a8 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00 =
00 01 00=20
00 00 3b 00 00 00 01 00=20
0;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =

interrupt-parent =3D=20
&lt;1&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
interrupts =3D=20
&lt;8&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
bus-range =3D=20
&lt;8&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
ranges =3D [02 00 00 00 00 00 00 00 a0 00 00 00 a0 00 00 00 00 00 00 00 =
20 00 00=20
00 01 00 00 00 00 00 00=20
00;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
=20
clock-frequency =3D=20
&lt;3f940aa&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;=20
#interrupt-cells =3D=20
&lt;1&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
#size-cells =3D=20
&lt;2&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
#address-cells =3D=20
&lt;3&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
reg =3D=20
&lt;8&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
compatible =3D=20
"85xx";<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
device_type =3D "pci";<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
};<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <A=20
href=3D"mailto:pic@40000">pic@40000</A>=20
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
clock-frequency =3D=20
&lt;0&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
interrupt-controller;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;=20
#address-cells =3D=20
&lt;0&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
#interrupt-cells =3D=20
&lt;2&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
reg =3D=20
&lt;8&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
built-in;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;=20
compatible =3D=20
"chrp,open-pic";<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;=20
device_type =3D=20
"open-pic";<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;=20
big-endian;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;=20
linux,phandle =3D =
&lt;1&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
};<BR>&nbsp;&nbsp;&nbsp; };<BR>&nbsp;&nbsp;&nbsp; chosen=20
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; linux,stdout-path =3D=20
"<A>/soc8541@e0000000/serial@4600</A>";<BR>&nbsp;&nbsp;&nbsp;=20
};<BR>&nbsp;&nbsp;&nbsp; chosen =
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
name =3D "chosen";<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
bootargs =3D=20
"root=3D/dev/ram rw=20
console=3DttyS1,115200";<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
linux,platform =3D =
&lt;600&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
linux,initrd-start =3D=20
&lt;1ef33000&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
linux,initrd-end=20
=3D &lt;1fe190aa&gt;;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
linux,stdout-path =3D=20
"<A>/soc8541@e0000000/serial@4600</A>";<BR>&nbsp;&nbsp;&nbsp;=20
};<BR>};<BR></FONT></SPAN></DIV>
<DIV><SPAN class=3D468543321-24012008><FONT face=3DArial=20
size=3D2></FONT></SPAN></SPAN>&nbsp;</DIV></SPAN></BODY></HTML>

------_=_NextPart_001_01C85ED3.99119281--
