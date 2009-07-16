Return-Path: <Rupesh.Kumar@Lntemsys.com>
Received: from mail145.messagelabs.com (mail145.messagelabs.com
	[216.82.242.163])
	by bilbo.ozlabs.org (Postfix) with SMTP id 880D7B7B72
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Jul 2009 15:13:55 +1000 (EST)
In-Reply-To: <4A5FDCDF.9010005@windriver.com>
To: tonyliu <Bo.Liu@windriver.com>
Subject: Re: booting MPC8313 based board with yaffs2 RFS
MIME-Version: 1.0
Message-ID: <OF2CCFE0B3.51B58673-ON652575F5.001ABC10-652575F5.001C7443@lntemsys.com>
From: Rupesh Kumar <Rupesh.Kumar@Lntemsys.com>
Date: Thu, 16 Jul 2009 10:52:46 +0530
Content-Type: multipart/mixed; boundary="=_mixed 001C7442652575F5_="
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=_mixed 001C7442652575F5_=
Content-Type: text/plain; charset="US-ASCII"

Hi 
Thanks for reply.
After erasing one of the flash partition, i mounted it as yaffs2 and 
manually created rootfs there. 
Though it (careting RFS in NAND partiton) marked blocks bad, I am able to 
boot with this yaffs2 filesystem.
When image is created with mkyffs2image binary, board does not boot with 
that and says kernel panic.

1. What nand flash is on-board? what's the size of the nand flash page 
size, 512/2048?
Nand Flash used on board is K9F2G08U0M-P from Samsung and page size is 
2048.
2. what's the version of mkyaffs2image you are using?
mkyaffs2image: image building tool for YAFFS2 built Jan 31 2009
3. Can you mount an empty nand flash partition using yaffs2 type,
mount  /dev/mtdblock##x   xxx
Yes, i wrote RFS contents to the nand flash partition and booted with 
that. 
4. It's better to attatch bootup message.
Bootup message is attached for both conditions 
1) booting with manually created RFS on flash drive mounted as 
yaffs2(boot-up_manual_RFS.txt).
2) booting with yaffs2 image created by mkyaffs2image tool.
        Note :- below are steps used for writing RFS iamge 
                ~ # flash_eraseall /dev/mtd11
                ~ # nandwrite -a -o /dev/mtd11 rootrfs_1.yaffs2


 




Thanks 
Rupesh





tonyliu <Bo.Liu@windriver.com> 
07/17/2009 07:37 AM

To
Rupesh Kumar <Rupesh.Kumar@Lntemsys.com>
cc
linuxppc-dev@lists.ozlabs.org
Subject
Re: booting MPC8313 based board with yaffs2 RFS







Rupesh Kumar wrote:
> Hi
> I am using MPC8313 board which is currently booting with JFFS2 root file 

> system. 
> I am using linux kernel version 2.6.23 from FreeScale's LTIB for 
MPC8313. 
>
> As, I want it to boot with YAFFS2 root file system, I did compile kernel 

> with yaffs2 support, craeted yaffs2 rootfile system and passed yaffs2 
> partiton of nand in bootargs. However it didnot work.
>
>
> If any one has done it successfully, can please share the steps to be 
> followed ?
> 
More detailed info maybe helpful for debugging this issue.

1. What nand flash is on-board? what's the size of the nand flash page 
size, 512/2048?
2. what's the version of mkyaffs2image you are using?
3. Can you mount an empty nand flash partition using yaffs2 type,
mount  /dev/mtdblock##x   xxx
4. It's better to attatch bootup message.

Tony
> Thanks
> Rupesh
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
> 


--=_mixed 001C7442652575F5_=
Content-Type: text/plain; name="boot-up_manual_RFS.txt"
Content-Disposition: attachment; filename="boot-up_manual_RFS.txt"
Content-Transfer-Encoding: quoted-printable

U-Boot 1.3.0-S600-Ver1.0 (Jul 16 2009 - 00:03:56) MPC83XX

Reset Status: Software Hard, External/Internal Soft, External/Internal Hard

CPU:   e300c3, Rev: Unknown revision number:80b10021
Warning: Unsupported cpu revision!
Board: S600 CPU BOARD=20
I2C:   ready
DRAM:  128 MB
FLASH: 16 MB
NAND:  256 MiB
In:    serial
Out:   serial
Err:   serial
Net:   TSEC0, TSEC1 [PRIME]
Hit any key to stop autoboot:  6 =08=08=08 5 =08=08=08 4 =08=08=08 3 =08=08=
=08 2 =08=08=08 1 =08=08=08 0=20
Speed: 100, full duplex
Using TSEC1 device
TFTP from server 192.168.6.251; our IP address is 192.168.34.10; sending th=
rough gateway 192.168.32.47
Filename 'uImage=5Fyaffs2'.
Load address: 0x200000
Loading: *=08##############################################################=
###
	 #################################################
done
Bytes transferred =3D 1669252 (197884 hex)
## Booting image at 00200000 ...
   Image Name:   Linux-2.6.23-S600-Ver1.0
   Created:      2009-07-16   2:03:41 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1669188 Bytes =3D  1.6 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
   Booting using the fdt at 0xfe900000
   Loading Device Tree to 007fd000, end 007fef4f ... OK
Using MPC8313 RDB machine description
Linux version 2.6.23-S600-Ver1.0 (root@leapfrogserver) (gcc version 4.1.2) =
#71 Thu Jul 16 07:33:39 IST 2009
console [udbg0] enabled
setup=5Farch: bootmem
mpc8313=5Frdb=5Fsetup=5Farch()
Found MPC83xx PCI host bridge at 0x00000000e0008500. Firmware bus number: 0=
->0
arch: exit
Zone PFN ranges:
  DMA             0 ->    32768
  Normal      32768 ->    32768
Movable zone start PFN for each node
early=5Fnode=5Fmap[1] active PFN ranges
    0:        0 ->    32768
Built 1 zonelists in Zone order.  Total pages: 32512
Kernel command line: root=3D/dev/mtdblock12 rootfstype=3Dyaffs2 rw console=
=3DttyS0,115200
IPIC (128 IRQ sources) at fdef9700
PID hash table entries: 512 (order: 9, 2048 bytes)
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 126220k/131072k available (3288k kernel code, 4712k reserved, 148k =
data, 96k bss, 152k init)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
            =20
PCI: Probing PCI hardware
Generic PHY: Registered new driver
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP reno registered
JFFS2 version 2.2. (NAND) =C2=A9 2001-2006 Red Hat, Inc.
yaffs Jul 16 2009 04:53:10 Installing.=20
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
device node obtained!
sram=5Firq =3D 48
Sram driver inserted
Serial: 8250/16550 driver $Revision: 1.90 $ 14 ports, IRQ sharing disabled
serial8250.0: ttyS0 at MMIO 0xe0004500 (irq =3D 18) is a 16550A
console handover: boot [udbg0] -> real [ttyS0]
serial8250.0: ttyS1 at MMIO 0xe0004600 (irq =3D 21) is a 16550A
serial8250.0: ttyS2 at MMIO 0xfa000000 (irq =3D 22) is a ST16654
serial8250.0: ttyS3 at MMIO 0xfa000008 (irq =3D 22) is a ST16654
serial8250.0: ttyS4 at MMIO 0xfa000010 (irq =3D 22) is a ST16654
serial8250.0: ttyS5 at MMIO 0xfa000018 (irq =3D 22) is a ST16654
serial8250.0: ttyS6 at MMIO 0xfa000020 (irq =3D 22) is a ST16654
serial8250.0: ttyS7 at MMIO 0xfa000028 (irq =3D 22) is a ST16654
serial8250.0: ttyS8 at MMIO 0xfa000030 (irq =3D 22) is a ST16654
serial8250.0: ttyS9 at MMIO 0xfa000038 (irq =3D 22) is a ST16654
serial8250.0: ttyS10 at MMIO 0xfa000040 (irq =3D 23) is a ST16654
serial8250.0: ttyS11 at MMIO 0xfa000048 (irq =3D 23) is a ST16654
serial8250.0: ttyS12 at MMIO 0xfa000050 (irq =3D 23) is a ST16654
serial8250.0: ttyS13 at MMIO 0xfa000058 (irq =3D 23) is a ST16654
RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize
loop: module loaded
Intel(R) PRO/1000 Network Driver - version 7.3.20-k2-NAPI
Copyright (c) 1999-2006 Intel Corporation.
Gianfar MII Bus: probed
eth0: Gianfar Ethernet Controller Version 1.3-skbr, 00:e0:0c:00:95:01=20
GFAR: SKB Handler initialized at CPU#0(max=3D32)
eth0: MTU =3D 1500 (frame size=3D1526, truesize=3D1800)
eth0: Running with NAPI enabled
eth0: 64/64 RX/TX BD ring size
eth1: Gianfar Ethernet Controller Version 1.3-skbr, 00:e0:0c:00:95:02=20
GFAR: SKB Handler initialized at CPU#0(max=3D32)
eth1: MTU =3D 1500 (frame size=3D1526, truesize=3D1800)
eth1: Running with NAPI enabled
eth1: 64/64 RX/TX BD ring size
e100: Intel(R) PRO/100 Network Driver, 3.5.23-k4-NAPI
e100: Copyright(c) 1999-2006 Intel Corporation
Marvell 88E1101: Registered new driver
Marvell 88E1112: Registered new driver
Marvell 88E1111: Registered new driver
Marvell 88E1145: Registered new driver
Fixed MDIO Bus: probed
NFTL driver: nftlcore.c $Revision: 1.98 $, nftlmount.c $Revision: 1.41 $
nor: Found 1 x16 devices at 0x0 in 16-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
nor: CFI does not contain boot bank location. Assuming top.
number of CFI chips: 1
cfi=5Fcmdset=5F0002: Disabling erase-suspend-program due to code brokenness.
RedBoot partition parsing not available
physmap-flash nor: Using OF partition information
Creating 6 MTD partitions on "nor":
0x00000000-0x00100000 : "U-Boot"
0x00100000-0x00500000 : "Kernel1"
0x00500000-0x00900000 : "Kernel2"
0x00900000-0x00980000 : "DTB1"
0x00980000-0x00a00000 : "DTB2"
0x00a00000-0x01000000 : "Unused"
Freescale eLBC NAND Driver (C) 2006-2007 Freescale
NAND device: Manufacturer ID: 0xec, Chip ID: 0xda (Samsung NAND 256MiB 3,3V=
 8-bit)
Scanning device for bad blocks
Bad eraseblock 1062 at 0x084c0000
Bad eraseblock 1063 at 0x084e0000
Bad eraseblock 1064 at 0x08500000
Bad eraseblock 1065 at 0x08520000
Bad eraseblock 1066 at 0x08540000
Bad eraseblock 1067 at 0x08560000
Bad eraseblock 1068 at 0x08580000
Bad eraseblock 1069 at 0x085a0000
Bad eraseblock 1070 at 0x085c0000
Bad eraseblock 1071 at 0x085e0000
Bad eraseblock 1072 at 0x08600000
Bad eraseblock 1073 at 0x08620000
Bad eraseblock 1074 at 0x08640000
Bad eraseblock 1075 at 0x08660000
Bad eraseblock 1076 at 0x08680000
Bad eraseblock 1077 at 0x086a0000
Bad eraseblock 1078 at 0x086c0000
Bad eraseblock 1079 at 0x086e0000
Bad eraseblock 1080 at 0x08700000
Bad eraseblock 1081 at 0x08720000
Bad eraseblock 1082 at 0x08740000
Bad eraseblock 1083 at 0x08760000
Bad eraseblock 1084 at 0x08780000
Bad eraseblock 1085 at 0x087a0000
Bad eraseblock 1086 at 0x087c0000
Bad eraseblock 1087 at 0x087e0000
Bad eraseblock 1088 at 0x08800000
Bad eraseblock 1089 at 0x08820000
Bad eraseblock 1090 at 0x08840000
Bad eraseblock 1091 at 0x08860000
Bad eraseblock 1092 at 0x08880000
Bad eraseblock 1093 at 0x088a0000
Bad eraseblock 1094 at 0x088c0000
Bad eraseblock 1095 at 0x088e0000
Bad eraseblock 1096 at 0x08900000
Bad eraseblock 1097 at 0x08920000
Bad eraseblock 1098 at 0x08940000
Bad eraseblock 1099 at 0x08960000
Bad eraseblock 1100 at 0x08980000
Bad eraseblock 1101 at 0x089a0000
Bad eraseblock 1102 at 0x089c0000
Bad eraseblock 1103 at 0x089e0000
Bad eraseblock 1104 at 0x08a00000
Bad eraseblock 1105 at 0x08a20000
Bad eraseblock 1106 at 0x08a40000
Bad eraseblock 1107 at 0x08a60000
Bad eraseblock 1108 at 0x08a80000
Bad eraseblock 1109 at 0x08aa0000
Bad eraseblock 1110 at 0x08ac0000
Bad eraseblock 1111 at 0x08ae0000
Bad eraseblock 1112 at 0x08b00000
Bad eraseblock 1113 at 0x08b20000
Bad eraseblock 1114 at 0x08b40000
Bad eraseblock 1115 at 0x08b60000
Bad eraseblock 1116 at 0x08b80000
Bad eraseblock 1117 at 0x08ba0000
Bad eraseblock 1118 at 0x08bc0000
Bad eraseblock 1119 at 0x08be0000
Bad eraseblock 1120 at 0x08c00000
Bad eraseblock 1121 at 0x08c20000
Bad eraseblock 1122 at 0x08c40000
Bad eraseblock 1123 at 0x08c60000
Bad eraseblock 1124 at 0x08c80000
Bad eraseblock 1125 at 0x08ca0000
Bad eraseblock 1126 at 0x08cc0000
Bad eraseblock 1127 at 0x08ce0000
Bad eraseblock 1128 at 0x08d00000
Bad eraseblock 1129 at 0x08d20000
Bad eraseblock 1130 at 0x08d40000
Bad eraseblock 1131 at 0x08d60000
Bad eraseblock 1132 at 0x08d80000
Bad eraseblock 1133 at 0x08da0000
Bad eraseblock 1134 at 0x08dc0000
Bad eraseblock 1135 at 0x08de0000
Bad eraseblock 1136 at 0x08e00000
Bad eraseblock 1137 at 0x08e20000
Bad eraseblock 1138 at 0x08e40000
Bad eraseblock 1139 at 0x08e60000
Bad eraseblock 1140 at 0x08e80000
Bad eraseblock 1141 at 0x08ea0000
Bad eraseblock 1142 at 0x08ec0000
Bad eraseblock 1143 at 0x08ee0000
Bad eraseblock 1144 at 0x08f00000
Bad eraseblock 1145 at 0x08f20000
Bad eraseblock 1146 at 0x08f40000
Bad eraseblock 1147 at 0x08f60000
Bad eraseblock 1148 at 0x08f80000
Bad eraseblock 1149 at 0x08fa0000
Bad eraseblock 1150 at 0x08fc0000
Bad eraseblock 1151 at 0x08fe0000
Bad eraseblock 1152 at 0x09000000
Bad eraseblock 1153 at 0x09020000
Bad eraseblock 1154 at 0x09040000
Bad eraseblock 1155 at 0x09060000
Bad eraseblock 1156 at 0x09080000
Bad eraseblock 1157 at 0x090a0000
Bad eraseblock 1158 at 0x090c0000
Bad eraseblock 1159 at 0x090e0000
Bad eraseblock 1160 at 0x09100000
Bad eraseblock 1161 at 0x09120000
Bad eraseblock 1162 at 0x09140000
Bad eraseblock 1163 at 0x09160000
Bad eraseblock 1164 at 0x09180000
Bad eraseblock 1165 at 0x091a0000
Bad eraseblock 1166 at 0x091c0000
Bad eraseblock 1167 at 0x091e0000
Bad eraseblock 1168 at 0x09200000
Bad eraseblock 1169 at 0x09220000
Bad eraseblock 1170 at 0x09240000
Bad eraseblock 1171 at 0x09260000
Bad eraseblock 1172 at 0x09280000
Bad eraseblock 1173 at 0x092a0000
Bad eraseblock 1174 at 0x092c0000
Bad eraseblock 1175 at 0x092e0000
Bad eraseblock 1176 at 0x09300000
Bad eraseblock 1177 at 0x09320000
Bad eraseblock 1178 at 0x09340000
Bad eraseblock 1179 at 0x09360000
Bad eraseblock 1180 at 0x09380000
Bad eraseblock 1181 at 0x093a0000
Bad eraseblock 1182 at 0x093c0000
Bad eraseblock 1183 at 0x093e0000
Bad eraseblock 1184 at 0x09400000
Bad eraseblock 1185 at 0x09420000
Bad eraseblock 1186 at 0x09440000
Bad eraseblock 1187 at 0x09460000
Bad eraseblock 1188 at 0x09480000
Bad eraseblock 1189 at 0x094a0000
Bad eraseblock 1190 at 0x094c0000
Bad eraseblock 1191 at 0x094e0000
Bad eraseblock 1192 at 0x09500000
Bad eraseblock 1193 at 0x09520000
Bad eraseblock 1194 at 0x09540000
Bad eraseblock 1195 at 0x09560000
Bad eraseblock 1196 at 0x09580000
Bad eraseblock 1197 at 0x095a0000
Bad eraseblock 1198 at 0x095c0000
Bad eraseblock 1199 at 0x095e0000
Bad eraseblock 1200 at 0x09600000
Bad eraseblock 1201 at 0x09620000
Bad eraseblock 1202 at 0x09640000
Bad eraseblock 1203 at 0x09660000
Bad eraseblock 1204 at 0x09680000
Bad eraseblock 1205 at 0x096a0000
Bad eraseblock 1206 at 0x096c0000
Bad eraseblock 1207 at 0x096e0000
Bad eraseblock 1208 at 0x09700000
Bad eraseblock 1209 at 0x09720000
Bad eraseblock 1210 at 0x09740000
Bad eraseblock 1211 at 0x09760000
Bad eraseblock 1212 at 0x09780000
Bad eraseblock 1213 at 0x097a0000
Bad eraseblock 1214 at 0x097c0000
Bad eraseblock 1215 at 0x097e0000
Bad eraseblock 1216 at 0x09800000
Bad eraseblock 1217 at 0x09820000
Bad eraseblock 1218 at 0x09840000
Bad eraseblock 1219 at 0x09860000
Bad eraseblock 1220 at 0x09880000
Bad eraseblock 1221 at 0x098a0000
Bad eraseblock 1222 at 0x098c0000
Bad eraseblock 1223 at 0x098e0000
Bad eraseblock 1224 at 0x09900000
Bad eraseblock 1225 at 0x09920000
Bad eraseblock 1226 at 0x09940000
Bad eraseblock 1227 at 0x09960000
Bad eraseblock 1228 at 0x09980000
Bad eraseblock 1229 at 0x099a0000
Bad eraseblock 1230 at 0x099c0000
Bad eraseblock 1231 at 0x099e0000
Bad eraseblock 1232 at 0x09a00000
Bad eraseblock 1233 at 0x09a20000
Bad eraseblock 1234 at 0x09a40000
fsl-elbc fsl-elbc.0: Using OF partition information
Creating 7 MTD partitions on "nand":
0x00000000-0x00100000 : "U-Boot-NAND"
0x00100000-0x00500000 : "Kernel1"
0x00500000-0x00900000 : "Kernel2"
0x00900000-0x00980000 : "DTB1"
0x00980000-0x00a00000 : "DTB2"
0x00a00000-0x08500000 : "RFS1"
0x084c0000-0x0ffc0000 : "RFS2"
mpc83xx=5Fspi.0: MPC83xx SPI Controller driver at 0xc907e000 (irq =3D 24)
usbmon: debugfs is not available
fsl-ehci fsl-ehci.0: Freescale On-Chip EHCI Host Controller
fsl-ehci fsl-ehci.0: new USB bus registered, assigned bus number 1
fsl-ehci fsl-ehci.0: irq 38, io base 0xe0023000
CMD REG : 10009
fsl-ehci fsl-ehci.0: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
i2c /dev entries driver
rtc-ds1307 0-0068: rtc core: registered ds1339 as rtc0
WDT driver for MPC83xx initialized. mode:reset timeout=3D65535 (25 seconds)
mmc=5Fspi spi28672.0: SD/MMC host mmc0, no DMA, no WP, no poweroff
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
rtc-ds1307 0-0068: setting the system clock to 2009-07-15 13:15:24 (1247663=
724)
yaffs: dev is 32505868 name is "mtdblock12"
yaffs: passed flags ""
yaffs: Attempting MTD mount on 31.12, "mtdblock12"
yaffs: restored from checkpoint
yaffs=5Fread=5Fsuper: isCheckpointed 1
VFS: Mounted root (yaffs2 filesystem).
Freeing unused kernel memory: 152k init
Setting the hostname to S600CPUBoardRev2.1
Mounting filesystems
Running sysctl
Setting up networking on loopback device:=20
nand=5Ferase: attempt to erase a bad block at page 0x00013180
------retval -5--------1
nand=5Ferase: attempt to erase a bad block at page 0x000131c0
------retval -5--------1

Warning: no IPADDR is set, please set this from the ltib
config screen, or directly in /etc/rc.d/rc.conf.
IP address setup bypassed

Setting up networking on eth1:=20
Adding static route for default gateway to 192.168.174.47:=20
**>> yaffs chunk 10432 was not erased
**>> yaffs chunk 10433 was not erased
**>> yaffs chunk 10434 was not erased
**>> yaffs chunk 10435 was not erased
**>> yaffs chunk 10436 was not erased
**>> yaffs chunk 10437 was not erased
**>> yaffs chunk 10438 was not erased
**>> yaffs chunk 10439 was not erased
**>> yaffs chunk 10440 was not erased
**>> yaffs chunk 10441 was not erased
**>> yaffs chunk 10442 was not erased
**>> yaffs chunk 10443 was not erased
**>> yaffs chunk 10444 was not erased
**>> yaffs chunk 10445 was not erased
**>> yaffs chunk 10446 was not erased
**>> yaffs chunk 10447 was not erased
**>> yaffs chunk 10448 was not erased
**>> yaffs chunk 10449 was not erased
**>> yaffs chunk 10450 was not erased
**>> yaffs chunk 10451 was not erased
**>> yaffs chunk 10452 was not erased
**>> yaffs chunk 10453 was not erased
**>> yaffs chunk 10454 was not erased
**>> yaffs chunk 10455 was not erased
**>> yaffs chunk 10456 was not erased
**>> yaffs chunk 10457 was not erased
**>> yaffs chunk 10458 was not erased
**>> yaffs chunk 10459 was not erased
**>> yaffs chunk 10460 was not erased
**>> yaffs chunk 10461 was not erased
**>> yaffs chunk 10462 was not erased
**>> yaffs chunk 10463 was not erased
**>> yaffs chunk 10464 was not erased
**>> yaffs chunk 10465 was not erased
**>> yaffs chunk 10466 was not erased
**>> yaffs chunk 10467 was not erased
**>> yaffs chunk 10468 was not erased
**>> yaffs chunk 10469 was not erased
**>> yaffs chunk 10470 was not erased
**>> yaffs chunk 10471 was not erased
**>> yaffs chunk 10472 was not erased
**>> yaffs chunk 10473 was not erased
**>> yaffs chunk 10474 was not erased
**>> yaffs chunk 10475 was not erased
**>> yaffs chunk 10476 was not erased
**>> yaffs chunk 10477 was not erased
**>> yaffs chunk 10478 was not erased
**>> yaffs chunk 10479 was not erased
**>> yaffs chunk 10480 was not erased
**>> yaffs chunk 10481 was not erased
**>> yaffs chunk 10482 was not erased
**>> yaffs chunk 10483 was not erased
**>> yaffs chunk 10484 was not erased
**>> yaffs chunk 10485 was not erased
**>> yaffs chunk 10486 was not erased
**>> yaffs chunk 10487 was not erased
**>> yaffs chunk 10488 was not erased
**>> yaffs chunk 10489 was not erased
**>> yaffs chunk 10490 was not erased
**>> yaffs chunk 10491 was not erased
**>> yaffs chunk 10492 was not erased
**>> yaffs chunk 10493 was not erased
**>> yaffs chunk 10494 was not erased
**>> yaffs chunk 10495 was not erased
**>> yaffs chunk 10496 was not erased
**>> yaffs chunk 10560 was not erased
**>> yaffs chunk 10624 was not erased
**>> yaffs chunk 10625 was not erased
**>> yaffs chunk 10626 was not erased
**>> yaffs chunk 10627 was not erased
**>> yaffs chunk 10628 was not erased
**>> yaffs chunk 10629 was not erased
**>> yaffs chunk 10630 was not erased
**>> yaffs chunk 10631 was not erased
**>> yaffs chunk 10632 was not erased
**>> yaffs chunk 10633 was not erased
**>> yaffs chunk 10634 was not erased
**>> yaffs chunk 10635 was not erased
**>> yaffs chunk 10636 was not erased
**>> yaffs chunk 10637 was not erased
**>> yaffs chunk 10638 was not erased
**>> yaffs chunk 10639 was not erased
**>> yaffs chunk 10640 was not erased
**>> yaffs chunk 10641 was not erased
**>> yaffs chunk 10642 was not erased
**>> yaffs chunk 10643 was not erased
**>> yaffs chunk 10644 was not erased
**>> yaffs chunk 10645 was not erased
**>> yaffs chunk 10646 was not erased
**>> yaffs chunk 10647 was not erased
**>> yaffs chunk 10648 was not erased
**>> yaffs chunk 10649 was not erased
**>> yaffs chunk 10650 was not erased
**>> yaffs chunk 10651 was not erased
**>> yaffs chunk 10652 was not erased
**>> yaffs chunk 10653 was not erased
**>> yaffs chunk 10654 was not erased
**>> yaffs chunk 10655 was not erased
**>> yaffs chunk 10656 was not erased
**>> yaffs chunk 10657 was not erased
**>> yaffs chunk 10658 was not erased
**>> yaffs chunk 10659 was not erased
**>> yaffs chunk 10660 was not erased
**>> yaffs chunk 10661 was not erased
**>> yaffs chunk 10662 was not erased
**>> yaffs chunk 10663 was not erased
**>> yaffs chunk 10664 was not erased
**>> yaffs chunk 10665 was not erased
**>> yaffs chunk 10666 was not erased
**>> yaffs chunk 10667 was not erased
**>> yaffs chunk 10668 was not erased
**>> yaffs chunk 10669 was not erased
**>> yaffs chunk 10670 was not erased
**>> yaffs chunk 10671 was not erased
**>> yaffs chunk 10672 was not erased
**>> yaffs chunk 10673 was not erased
**>> yaffs chunk 10674 was not erased
**>> yaffs chunk 10675 was not erased
**>> yaffs chunk 10676 was not erased
**>> yaffs chunk 10677 was not erased
**>> yaffs chunk 10678 was not erased
**>> yaffs chunk 10679 was not erased
**>> yaffs chunk 10680 was not erased
**>> yaffs chunk 10681 was not erased
**>> yaffs chunk 10682 was not erased
**>> yaffs chunk 10683 was not erased
**>> yaffs chunk 10684 was not erased
**>> yaffs chunk 10685 was not erased
**>> yaffs chunk 10686 was not erased
**>> yaffs chunk 10687 was not erased
**>> yaffs chunk 10688 was not erased
**>> yaffs chunk 10752 was not erased
**>> yaffs chunk 10816 was not erased
**>> yaffs chunk 10880 was not erased
**>> yaffs chunk 10944 was not erased
**>> yaffs chunk 10945 was not erased
**>> yaffs chunk 10946 was not erased
**>> yaffs chunk 10947 was not erased
**>> yaffs chunk 10948 was not erased
**>> yaffs chunk 10949 was not erased
**>> yaffs chunk 10950 was not erased
**>> yaffs chunk 10951 was not erased
**>> yaffs chunk 10952 was not erased
**>> yaffs chunk 10953 was not erased
**>> yaffs chunk 10954 was not erased
**>> yaffs chunk 10955 was not erased
**>> yaffs chunk 10956 was not erased
**>> yaffs chunk 10957 was not erased
**>> yaffs chunk 10958 was not erased
**>> yaffs chunk 10959 was not erased
**>> yaffs chunk 10960 was not erased
**>> yaffs chunk 10961 was not erased
**>> yaffs chunk 10962 was not erased
**>> yaffs chunk 10963 was not erased
**>> yaffs chunk 10964 was not erased
**>> yaffs chunk 10965 was not erased
**>> yaffs chunk 10966 was not erased
**>> yaffs chunk 10967 was not erased
**>> yaffs chunk 10968 was not erased
**>> yaffs chunk 10969 was not erased
**>> yaffs chunk 10970 was not erased
**>> yaffs chunk 10971 was not erased
**>> yaffs chunk 10972 was not erased
**>> yaffs write required 164 attempts
page 10496 in gc has no object: 165 1 2048=20
nand=5Ferase: attempt to erase a bad block at page 0x00013240
------retval -5<4>**>> Erasure failed 164
**>> Block 164 retired
Block 164 is in state 9 after gc, should be erased
page 10560 in gc has no object: 166 65 2048=20
nand=5Ferase: attempt to erase a bad block at page 0x00013280
------retval -5<4>**>> Erasure failed 165
**>> Block 165 retired
Block 165 is in state 9 after gc, should be erased
page 10688 in gc has no object: 168 1 2048=20
nand=5Ferase: attempt to erase a bad block at page 0x00013300
------retval -5<4>**>> Erasure failed 167
**>> Block 167 retired
Block 167 is in state 9 after gc, should be erased
page 10752 in gc has no object: 169 65 2048=20
nand=5Ferase: attempt to erase a bad block at page 0x00013340
------retval -5<4>**>> Erasure failed 168
**>> Block 168 retired
Block 168 is in state 9 after gc, should be erased
page 10816 in gc has no object: 136 1 2048=20
nand=5Ferase: attempt to erase a bad block at page 0x00013380
------retval -5<4>**>> Erasure failed 169
**>> Block 169 retired
Block 169 is in state 9 after gc, should be erased
Setting nameservpage 10880 in gc has no object: 171 65 2048=20
er to 192.168.1.nand=5Ferase: attempt to erase a bad block at page 0x000133=
c0
1 in /etc/resolv------retval -5.conf:=20
<4>**>> Erasure failed 170
**>> Block 170 retired
Block 170 is in state 9 after gc, should be erased
Starting inetd:=20
Starting the dropbear ssh server:=20
Setting RS485 Mode


        Welcome to Freescale Semiconductor Embedded Linux Environment

!!!!! WARNING !!!!!!!

The default password for the root account is: root
please change this password using the 'passwd' command
and then edit this message (/etc/issue) to remove this message

S600CPUBoardRev2.1 login: PHY: e0024520:19 - Link is Up - 100/Full
root
Password:=20
login[889]: root login  on `console'

~ #=20
~ #=20
~ #=20
~ #=20
~ #=20
~ # =

--=_mixed 001C7442652575F5_=
Content-Type: text/plain; name="boot-up_with_RFS_createdby_mkyffs2image_tool.txt"
Content-Disposition: attachment; filename="boot-up_with_RFS_createdby_mkyffs2image_tool.txt"
Content-Transfer-Encoding: quoted-printable


Resetting the board.


U-Boot 1.3.0-S600-Ver1.0 (Jul 16 2009 - 00:03:56) MPC83XX

Reset Status: Software Hard, External/Internal Soft, External/Internal Hard

CPU:   e300c3, Rev: Unknown revision number:80b10021
Warning: Unsupported cpu revision!
Board: S600 CPU BOARD=20
I2C:   ready
DRAM:  128 MB
FLASH: 16 MB
NAND:  256 MiB
In:    serial
Out:   serial
Err:   serial
Net:   TSEC0, TSEC1 [PRIME]
Hit any key to stop autoboot:  6 =08=08=08 5 =08=08=08 4 =08=08=08 3 =08=08=
=08 2 =08=08=08 1 =08=08=08 0=20
Speed: 100, full duplex
Using TSEC1 device
TFTP from server 192.168.6.251; our IP address is 192.168.34.10; sending th=
rough gateway 192.168.32.47
Filename 'uImage=5Fyaffs2'.
Load address: 0x200000
Loading: *=08##############################################################=
###
	 #################################################
done
Bytes transferred =3D 1669252 (197884 hex)
## Booting image at 00200000 ...
   Image Name:   Linux-2.6.23-S600-Ver1.0
   Created:      2009-07-16   2:03:41 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1669188 Bytes =3D  1.6 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
   Booting using the fdt at 0xfe900000
   Loading Device Tree to 007fd000, end 007fef4f ... OK
Using MPC8313 RDB machine description=0ALinux version 2.6.23-S600-Ver1.0 (r=
oot@leapfrogserver) (gcc version 4.1.2) #71 Thu Jul 16 07:33:39 IST 2009=0A=
console [udbg0] enabled=0Asetup=5Farch: bootmem=0Ampc8313=5Frdb=5Fsetup=5Fa=
rch()=0AFound MPC83xx PCI host bridge at 0x00000000e0008500. Firmware bus n=
umber: 0->0=0Aarch: exit=0AZone PFN ranges:=0A  DMA             0 ->    327=
68=0A  Normal      32768 ->    32768=0AMovable zone start PFN for each node=
=0Aearly=5Fnode=5Fmap[1] active PFN ranges=0A    0:        0 ->    32768=0A=
Built 1 zonelists in Zone order.  Total pages: 32512=0AKernel command line:=
 root=3D/dev/mtdblock11 rootfstype=3Dyaffs2 rw console=3DttyS0,115200=0AIPI=
C (128 IRQ sources) at fdef9700=0APID hash table entries: 512 (order: 9, 20=
48 bytes)=0ADentry cache hash table entries: 16384 (order: 4, 65536 bytes)=
=0AInode-cache hash table entries: 8192 (order: 3, 32768 bytes)=0AMemory: 1=
26220k/131072k available (3288k kernel code, 4712k reserved, 148k data, 96k=
 bss, 152k init)=0AMount-cache hash table entries: 512=0ANET: Registered pr=
otocol family 16=0A             =0APCI: Probing PCI hardware=0AGeneric PHY:=
 Registered new driver=0ASCSI subsystem initialized=0Ausbcore: registered n=
ew interface driver usbfs=0Ausbcore: registered new interface driver hub=0A=
usbcore: registered new device driver usb=0ANET: Registered protocol family=
 2=0AIP route cache hash table entries: 1024 (order: 0, 4096 bytes)=0ATCP e=
stablished hash table entries: 4096 (order: 3, 32768 bytes)=0ATCP bind hash=
 table entries: 4096 (order: 2, 16384 bytes)=0ATCP: Hash tables configured =
(established 4096 bind 4096)=0ATCP reno registered=0AJFFS2 version 2.2. (NA=
ND) =C2=A9 2001-2006 Red Hat, Inc.=0Ayaffs Jul 16 2009 04:53:10 Installing.=
 =0Aio scheduler noop registered=0Aio scheduler anticipatory registered (de=
fault)=0Aio scheduler deadline registered=0Aio scheduler cfq registered=0Ad=
evice node obtained!=0Asram=5Firq =3D 48=0ASram driver inserted=0ASerial: 8=
250/16550 driver $Revision: 1.90 $ 14 ports, IRQ sharing disabled=0Aserial8=
250.0: ttyS0 at MMIO 0xe0004500 (irq =3D 18) is a 16550A=0Aconsole handover=
: boot [udbg0] -> real [ttyS0]=0Aserial8250.0: ttyS1 at MMIO 0xe0004600 (ir=
q =3D 21) is a 16550A
serial8250.0: ttyS2 at MMIO 0xfa000000 (irq =3D 22) is a ST16654
serial8250.0: ttyS3 at MMIO 0xfa000008 (irq =3D 22) is a ST16654
serial8250.0: ttyS4 at MMIO 0xfa000010 (irq =3D 22) is a ST16654
serial8250.0: ttyS5 at MMIO 0xfa000018 (irq =3D 22) is a ST16654
serial8250.0: ttyS6 at MMIO 0xfa000020 (irq =3D 22) is a ST16654
serial8250.0: ttyS7 at MMIO 0xfa000028 (irq =3D 22) is a ST16654
serial8250.0: ttyS8 at MMIO 0xfa000030 (irq =3D 22) is a ST16654
serial8250.0: ttyS9 at MMIO 0xfa000038 (irq =3D 22) is a ST16654
serial8250.0: ttyS10 at MMIO 0xfa000040 (irq =3D 23) is a ST16654
serial8250.0: ttyS11 at MMIO 0xfa000048 (irq =3D 23) is a ST16654
serial8250.0: ttyS12 at MMIO 0xfa000050 (irq =3D 23) is a ST16654
serial8250.0: ttyS13 at MMIO 0xfa000058 (irq =3D 23) is a ST16654
RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize
loop: module loaded
Intel(R) PRO/1000 Network Driver - version 7.3.20-k2-NAPI
Copyright (c) 1999-2006 Intel Corporation.
Gianfar MII Bus: probed
eth0: Gianfar Ethernet Controller Version 1.3-skbr, 00:e0:0c:00:95:01=20
GFAR: SKB Handler initialized at CPU#0(max=3D32)
eth0: MTU =3D 1500 (frame size=3D1526, truesize=3D1800)
eth0: Running with NAPI enabled
eth0: 64/64 RX/TX BD ring size
eth1: Gianfar Ethernet Controller Version 1.3-skbr, 00:e0:0c:00:95:02=20
GFAR: SKB Handler initialized at CPU#0(max=3D32)
eth1: MTU =3D 1500 (frame size=3D1526, truesize=3D1800)
eth1: Running with NAPI enabled
eth1: 64/64 RX/TX BD ring size
e100: Intel(R) PRO/100 Network Driver, 3.5.23-k4-NAPI
e100: Copyright(c) 1999-2006 Intel Corporation
Marvell 88E1101: Registered new driver
Marvell 88E1112: Registered new driver
Marvell 88E1111: Registered new driver
Marvell 88E1145: Registered new driver
Fixed MDIO Bus: probed
NFTL driver: nftlcore.c $Revision: 1.98 $, nftlmount.c $Revision: 1.41 $
nor: Found 1 x16 devices at 0x0 in 16-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
nor: CFI does not contain boot bank location. Assuming top.
number of CFI chips: 1
cfi=5Fcmdset=5F0002: Disabling erase-suspend-program due to code brokenness.
RedBoot partition parsing not available
physmap-flash nor: Using OF partition information
Creating 6 MTD partitions on "nor":
0x00000000-0x00100000 : "U-Boot"
0x00100000-0x00500000 : "Kernel1"
0x00500000-0x00900000 : "Kernel2"
0x00900000-0x00980000 : "DTB1"
0x00980000-0x00a00000 : "DTB2"
0x00a00000-0x01000000 : "Unused"
Freescale eLBC NAND Driver (C) 2006-2007 Freescale
NAND device: Manufacturer ID: 0xec, Chip ID: 0xda (Samsung NAND 256MiB 3,3V=
 8-bit)
Scanning device for bad blocks
Bad eraseblock 80 at 0x00a00000
Bad eraseblock 81 at 0x00a20000
Bad eraseblock 1062 at 0x084c0000
Bad eraseblock 1063 at 0x084e0000
Bad eraseblock 1064 at 0x08500000
Bad eraseblock 1065 at 0x08520000
Bad eraseblock 1066 at 0x08540000
Bad eraseblock 1067 at 0x08560000
Bad eraseblock 1068 at 0x08580000
Bad eraseblock 1069 at 0x085a0000
Bad eraseblock 1070 at 0x085c0000
Bad eraseblock 1071 at 0x085e0000
Bad eraseblock 1072 at 0x08600000
Bad eraseblock 1073 at 0x08620000
Bad eraseblock 1074 at 0x08640000
Bad eraseblock 1075 at 0x08660000
Bad eraseblock 1076 at 0x08680000
Bad eraseblock 1077 at 0x086a0000
Bad eraseblock 1078 at 0x086c0000
Bad eraseblock 1079 at 0x086e0000
Bad eraseblock 1080 at 0x08700000
Bad eraseblock 1081 at 0x08720000
Bad eraseblock 1082 at 0x08740000
Bad eraseblock 1083 at 0x08760000
Bad eraseblock 1084 at 0x08780000
Bad eraseblock 1085 at 0x087a0000
Bad eraseblock 1086 at 0x087c0000
Bad eraseblock 1087 at 0x087e0000
Bad eraseblock 1088 at 0x08800000
Bad eraseblock 1089 at 0x08820000
Bad eraseblock 1090 at 0x08840000
Bad eraseblock 1091 at 0x08860000
Bad eraseblock 1092 at 0x08880000
Bad eraseblock 1093 at 0x088a0000
Bad eraseblock 1094 at 0x088c0000
Bad eraseblock 1095 at 0x088e0000
Bad eraseblock 1096 at 0x08900000
Bad eraseblock 1097 at 0x08920000
Bad eraseblock 1098 at 0x08940000
Bad eraseblock 1099 at 0x08960000
Bad eraseblock 1100 at 0x08980000
Bad eraseblock 1101 at 0x089a0000
Bad eraseblock 1102 at 0x089c0000
Bad eraseblock 1103 at 0x089e0000
Bad eraseblock 1104 at 0x08a00000
Bad eraseblock 1105 at 0x08a20000
Bad eraseblock 1106 at 0x08a40000
Bad eraseblock 1107 at 0x08a60000
Bad eraseblock 1108 at 0x08a80000
Bad eraseblock 1109 at 0x08aa0000
Bad eraseblock 1110 at 0x08ac0000
Bad eraseblock 1111 at 0x08ae0000
Bad eraseblock 1112 at 0x08b00000
Bad eraseblock 1113 at 0x08b20000
Bad eraseblock 1114 at 0x08b40000
Bad eraseblock 1115 at 0x08b60000
Bad eraseblock 1116 at 0x08b80000
Bad eraseblock 1117 at 0x08ba0000
Bad eraseblock 1118 at 0x08bc0000
Bad eraseblock 1119 at 0x08be0000
Bad eraseblock 1120 at 0x08c00000
Bad eraseblock 1121 at 0x08c20000
Bad eraseblock 1122 at 0x08c40000
Bad eraseblock 1123 at 0x08c60000
Bad eraseblock 1124 at 0x08c80000
Bad eraseblock 1125 at 0x08ca0000
Bad eraseblock 1126 at 0x08cc0000
Bad eraseblock 1127 at 0x08ce0000
Bad eraseblock 1128 at 0x08d00000
Bad eraseblock 1129 at 0x08d20000
Bad eraseblock 1130 at 0x08d40000
Bad eraseblock 1131 at 0x08d60000
Bad eraseblock 1132 at 0x08d80000
Bad eraseblock 1133 at 0x08da0000
Bad eraseblock 1134 at 0x08dc0000
Bad eraseblock 1135 at 0x08de0000
Bad eraseblock 1136 at 0x08e00000
Bad eraseblock 1137 at 0x08e20000
Bad eraseblock 1138 at 0x08e40000
Bad eraseblock 1139 at 0x08e60000
Bad eraseblock 1140 at 0x08e80000
Bad eraseblock 1141 at 0x08ea0000
Bad eraseblock 1142 at 0x08ec0000
Bad eraseblock 1143 at 0x08ee0000
Bad eraseblock 1144 at 0x08f00000
Bad eraseblock 1145 at 0x08f20000
Bad eraseblock 1146 at 0x08f40000
Bad eraseblock 1147 at 0x08f60000
Bad eraseblock 1148 at 0x08f80000
Bad eraseblock 1149 at 0x08fa0000
Bad eraseblock 1150 at 0x08fc0000
Bad eraseblock 1151 at 0x08fe0000
Bad eraseblock 1152 at 0x09000000
Bad eraseblock 1153 at 0x09020000
Bad eraseblock 1154 at 0x09040000
Bad eraseblock 1155 at 0x09060000
Bad eraseblock 1156 at 0x09080000
Bad eraseblock 1157 at 0x090a0000
Bad eraseblock 1158 at 0x090c0000
Bad eraseblock 1159 at 0x090e0000
Bad eraseblock 1160 at 0x09100000
Bad eraseblock 1161 at 0x09120000
Bad eraseblock 1162 at 0x09140000
Bad eraseblock 1163 at 0x09160000
Bad eraseblock 1164 at 0x09180000
Bad eraseblock 1165 at 0x091a0000
Bad eraseblock 1166 at 0x091c0000
Bad eraseblock 1167 at 0x091e0000
Bad eraseblock 1168 at 0x09200000
Bad eraseblock 1169 at 0x09220000
Bad eraseblock 1170 at 0x09240000
Bad eraseblock 1171 at 0x09260000
Bad eraseblock 1172 at 0x09280000
Bad eraseblock 1173 at 0x092a0000
Bad eraseblock 1174 at 0x092c0000
Bad eraseblock 1175 at 0x092e0000
Bad eraseblock 1176 at 0x09300000
Bad eraseblock 1177 at 0x09320000
Bad eraseblock 1178 at 0x09340000
Bad eraseblock 1179 at 0x09360000
Bad eraseblock 1180 at 0x09380000
Bad eraseblock 1181 at 0x093a0000
Bad eraseblock 1182 at 0x093c0000
Bad eraseblock 1183 at 0x093e0000
Bad eraseblock 1184 at 0x09400000
Bad eraseblock 1185 at 0x09420000
Bad eraseblock 1186 at 0x09440000
Bad eraseblock 1187 at 0x09460000
Bad eraseblock 1188 at 0x09480000
Bad eraseblock 1189 at 0x094a0000
Bad eraseblock 1190 at 0x094c0000
Bad eraseblock 1191 at 0x094e0000
Bad eraseblock 1192 at 0x09500000
Bad eraseblock 1193 at 0x09520000
Bad eraseblock 1194 at 0x09540000
Bad eraseblock 1195 at 0x09560000
Bad eraseblock 1196 at 0x09580000
Bad eraseblock 1197 at 0x095a0000
Bad eraseblock 1198 at 0x095c0000
Bad eraseblock 1199 at 0x095e0000
Bad eraseblock 1200 at 0x09600000
Bad eraseblock 1201 at 0x09620000
Bad eraseblock 1202 at 0x09640000
Bad eraseblock 1203 at 0x09660000
Bad eraseblock 1204 at 0x09680000
Bad eraseblock 1205 at 0x096a0000
Bad eraseblock 1206 at 0x096c0000
Bad eraseblock 1207 at 0x096e0000
Bad eraseblock 1208 at 0x09700000
Bad eraseblock 1209 at 0x09720000
Bad eraseblock 1210 at 0x09740000
Bad eraseblock 1211 at 0x09760000
Bad eraseblock 1212 at 0x09780000
Bad eraseblock 1213 at 0x097a0000
Bad eraseblock 1214 at 0x097c0000
Bad eraseblock 1215 at 0x097e0000
Bad eraseblock 1216 at 0x09800000
Bad eraseblock 1217 at 0x09820000
Bad eraseblock 1218 at 0x09840000
Bad eraseblock 1219 at 0x09860000
Bad eraseblock 1220 at 0x09880000
Bad eraseblock 1221 at 0x098a0000
Bad eraseblock 1222 at 0x098c0000
Bad eraseblock 1223 at 0x098e0000
Bad eraseblock 1224 at 0x09900000
Bad eraseblock 1225 at 0x09920000
Bad eraseblock 1226 at 0x09940000
Bad eraseblock 1227 at 0x09960000
Bad eraseblock 1228 at 0x09980000
Bad eraseblock 1229 at 0x099a0000
Bad eraseblock 1230 at 0x099c0000
Bad eraseblock 1231 at 0x099e0000
Bad eraseblock 1232 at 0x09a00000
Bad eraseblock 1233 at 0x09a20000
Bad eraseblock 1234 at 0x09a40000
Bad eraseblock 1235 at 0x09a60000
Bad eraseblock 1236 at 0x09a80000
Bad eraseblock 1237 at 0x09aa0000
Bad eraseblock 1238 at 0x09ac0000
Bad eraseblock 1239 at 0x09ae0000
Bad eraseblock 1240 at 0x09b00000
Bad eraseblock 1241 at 0x09b20000
Bad eraseblock 1242 at 0x09b40000
Bad eraseblock 1243 at 0x09b60000
Bad eraseblock 1244 at 0x09b80000
Bad eraseblock 1245 at 0x09ba0000
Bad eraseblock 1246 at 0x09bc0000
Bad eraseblock 1247 at 0x09be0000
Bad eraseblock 1248 at 0x09c00000
Bad eraseblock 1249 at 0x09c20000
Bad eraseblock 1250 at 0x09c40000
Bad eraseblock 1251 at 0x09c60000
Bad eraseblock 1252 at 0x09c80000
Bad eraseblock 1253 at 0x09ca0000
Bad eraseblock 1254 at 0x09cc0000
Bad eraseblock 1255 at 0x09ce0000
Bad eraseblock 1256 at 0x09d00000
Bad eraseblock 1257 at 0x09d20000
Bad eraseblock 1258 at 0x09d40000
Bad eraseblock 1259 at 0x09d60000
Bad eraseblock 1260 at 0x09d80000
Bad eraseblock 1261 at 0x09da0000
Bad eraseblock 1262 at 0x09dc0000
Bad eraseblock 1263 at 0x09de0000
Bad eraseblock 1264 at 0x09e00000
Bad eraseblock 1265 at 0x09e20000
Bad eraseblock 1266 at 0x09e40000
Bad eraseblock 1267 at 0x09e60000
Bad eraseblock 1268 at 0x09e80000
Bad eraseblock 1269 at 0x09ea0000
Bad eraseblock 1270 at 0x09ec0000
Bad eraseblock 1271 at 0x09ee0000
Bad eraseblock 1272 at 0x09f00000
Bad eraseblock 1273 at 0x09f20000
Bad eraseblock 1274 at 0x09f40000
Bad eraseblock 1275 at 0x09f60000
Bad eraseblock 1276 at 0x09f80000
Bad eraseblock 1277 at 0x09fa0000
Bad eraseblock 1278 at 0x09fc0000
Bad eraseblock 1279 at 0x09fe0000
Bad eraseblock 1280 at 0x0a000000
Bad eraseblock 1281 at 0x0a020000
Bad eraseblock 1282 at 0x0a040000
Bad eraseblock 1283 at 0x0a060000
Bad eraseblock 1284 at 0x0a080000
Bad eraseblock 1285 at 0x0a0a0000
Bad eraseblock 1286 at 0x0a0c0000
Bad eraseblock 1287 at 0x0a0e0000
Bad eraseblock 1288 at 0x0a100000
Bad eraseblock 1289 at 0x0a120000
Bad eraseblock 1290 at 0x0a140000
Bad eraseblock 1291 at 0x0a160000
Bad eraseblock 1292 at 0x0a180000
Bad eraseblock 1293 at 0x0a1a0000
Bad eraseblock 1294 at 0x0a1c0000
Bad eraseblock 1295 at 0x0a1e0000
Bad eraseblock 1296 at 0x0a200000
Bad eraseblock 1297 at 0x0a220000
Bad eraseblock 1298 at 0x0a240000
Bad eraseblock 1299 at 0x0a260000
Bad eraseblock 1300 at 0x0a280000
Bad eraseblock 1301 at 0x0a2a0000
Bad eraseblock 1302 at 0x0a2c0000
Bad eraseblock 1303 at 0x0a2e0000
Bad eraseblock 1304 at 0x0a300000
Bad eraseblock 1305 at 0x0a320000
Bad eraseblock 1306 at 0x0a340000
Bad eraseblock 1307 at 0x0a360000
Bad eraseblock 1308 at 0x0a380000
Bad eraseblock 1309 at 0x0a3a0000
Bad eraseblock 1310 at 0x0a3c0000
Bad eraseblock 1311 at 0x0a3e0000
Bad eraseblock 1312 at 0x0a400000
Bad eraseblock 1313 at 0x0a420000
Bad eraseblock 1314 at 0x0a440000
Bad eraseblock 1315 at 0x0a460000
Bad eraseblock 1316 at 0x0a480000
Bad eraseblock 1317 at 0x0a4a0000
Bad eraseblock 1318 at 0x0a4c0000
Bad eraseblock 1319 at 0x0a4e0000
Bad eraseblock 1320 at 0x0a500000
Bad eraseblock 1321 at 0x0a520000
Bad eraseblock 1322 at 0x0a540000
Bad eraseblock 1323 at 0x0a560000
Bad eraseblock 1324 at 0x0a580000
Bad eraseblock 1325 at 0x0a5a0000
Bad eraseblock 1326 at 0x0a5c0000
Bad eraseblock 1327 at 0x0a5e0000
Bad eraseblock 1328 at 0x0a600000
Bad eraseblock 1329 at 0x0a620000
Bad eraseblock 1330 at 0x0a640000
Bad eraseblock 1331 at 0x0a660000
Bad eraseblock 1332 at 0x0a680000
Bad eraseblock 1333 at 0x0a6a0000
Bad eraseblock 1334 at 0x0a6c0000
Bad eraseblock 1335 at 0x0a6e0000
Bad eraseblock 1336 at 0x0a700000
Bad eraseblock 1337 at 0x0a720000
Bad eraseblock 1338 at 0x0a740000
Bad eraseblock 1339 at 0x0a760000
Bad eraseblock 1340 at 0x0a780000
Bad eraseblock 1341 at 0x0a7a0000
Bad eraseblock 1342 at 0x0a7c0000
Bad eraseblock 1343 at 0x0a7e0000
Bad eraseblock 1344 at 0x0a800000
Bad eraseblock 1345 at 0x0a820000
Bad eraseblock 1346 at 0x0a840000
Bad eraseblock 1347 at 0x0a860000
Bad eraseblock 1348 at 0x0a880000
Bad eraseblock 1349 at 0x0a8a0000
Bad eraseblock 1350 at 0x0a8c0000
Bad eraseblock 1351 at 0x0a8e0000
Bad eraseblock 1352 at 0x0a900000
Bad eraseblock 1353 at 0x0a920000
Bad eraseblock 1354 at 0x0a940000
Bad eraseblock 1355 at 0x0a960000
Bad eraseblock 1356 at 0x0a980000
Bad eraseblock 1357 at 0x0a9a0000
Bad eraseblock 1358 at 0x0a9c0000
Bad eraseblock 1359 at 0x0a9e0000
Bad eraseblock 1360 at 0x0aa00000
Bad eraseblock 1361 at 0x0aa20000
Bad eraseblock 1362 at 0x0aa40000
Bad eraseblock 1363 at 0x0aa60000
Bad eraseblock 1364 at 0x0aa80000
Bad eraseblock 1365 at 0x0aaa0000
Bad eraseblock 1366 at 0x0aac0000
Bad eraseblock 1367 at 0x0aae0000
Bad eraseblock 1368 at 0x0ab00000
Bad eraseblock 1369 at 0x0ab20000
Bad eraseblock 1370 at 0x0ab40000
Bad eraseblock 1371 at 0x0ab60000
Bad eraseblock 1372 at 0x0ab80000
Bad eraseblock 1373 at 0x0aba0000
Bad eraseblock 1374 at 0x0abc0000
Bad eraseblock 1375 at 0x0abe0000
Bad eraseblock 1376 at 0x0ac00000
Bad eraseblock 1377 at 0x0ac20000
Bad eraseblock 1378 at 0x0ac40000
Bad eraseblock 1379 at 0x0ac60000
Bad eraseblock 1380 at 0x0ac80000
Bad eraseblock 1381 at 0x0aca0000
Bad eraseblock 1382 at 0x0acc0000
Bad eraseblock 1383 at 0x0ace0000
Bad eraseblock 1384 at 0x0ad00000
Bad eraseblock 1385 at 0x0ad20000
Bad eraseblock 1386 at 0x0ad40000
Bad eraseblock 1387 at 0x0ad60000
Bad eraseblock 1388 at 0x0ad80000
Bad eraseblock 1389 at 0x0ada0000
Bad eraseblock 1390 at 0x0adc0000
Bad eraseblock 1391 at 0x0ade0000
Bad eraseblock 1392 at 0x0ae00000
Bad eraseblock 1393 at 0x0ae20000
Bad eraseblock 1394 at 0x0ae40000
Bad eraseblock 1395 at 0x0ae60000
Bad eraseblock 1396 at 0x0ae80000
Bad eraseblock 1397 at 0x0aea0000
Bad eraseblock 1398 at 0x0aec0000
Bad eraseblock 1399 at 0x0aee0000
Bad eraseblock 1400 at 0x0af00000
Bad eraseblock 1401 at 0x0af20000
Bad eraseblock 1402 at 0x0af40000
Bad eraseblock 1403 at 0x0af60000
fsl-elbc fsl-elbc.0: Using OF partition information
Creating 7 MTD partitions on "nand":
0x00000000-0x00100000 : "U-Boot-NAND"
0x00100000-0x00500000 : "Kernel1"
0x00500000-0x00900000 : "Kernel2"
0x00900000-0x00980000 : "DTB1"
0x00980000-0x00a00000 : "DTB2"
0x00a00000-0x08500000 : "RFS1"
0x084c0000-0x0ffc0000 : "RFS2"
mpc83xx=5Fspi.0: MPC83xx SPI Controller driver at 0xc907e000 (irq =3D 24)
usbmon: debugfs is not available
fsl-ehci fsl-ehci.0: Freescale On-Chip EHCI Host Controller
fsl-ehci fsl-ehci.0: new USB bus registered, assigned bus number 1
fsl-ehci fsl-ehci.0: irq 38, io base 0xe0023000
CMD REG : 10009
fsl-ehci fsl-ehci.0: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
i2c /dev entries driver
rtc-ds1307 0-0068: rtc core: registered ds1339 as rtc0
WDT driver for MPC83xx initialized. mode:reset timeout=3D65535 (25 seconds)
mmc=5Fspi spi28672.0: SD/MMC host mmc0, no DMA, no WP, no poweroff
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
rtc-ds1307 0-0068: setting the system clock to 2009-07-16 04:53:18 (1247719=
998)
yaffs: dev is 32505867 name is "mtdblock11"
yaffs: passed flags ""
yaffs: Attempting MTD mount on 31.11, "mtdblock11"
block 1 is bad
block 2 is bad
block 983 is bad
block 984 is bad
yaffs=5Fread=5Fsuper: isCheckpointed 0
VFS: Mounted root (yaffs2 filesystem).
Freeing unused kernel memory: 152k init
Warning: unable to open an initial console.
Kernel panic - not syncing: No init found.  Try passing init=3D option to k=
ernel.
Rebooting in 180 seconds..=

--=_mixed 001C7442652575F5_=--
