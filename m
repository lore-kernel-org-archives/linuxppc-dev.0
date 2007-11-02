Return-Path: <guojin02@tsinghua.org.cn>
Received: from tsinghua.org.cn (unknown [210.77.143.232])
	by ozlabs.org (Postfix) with SMTP id 882BCDDD0C
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Nov 2007 13:58:49 +1100 (EST)
Message-ID: <393970936.26969@tsinghua.org.cn>
From: "=?gb2312?B?ufm+og==?=" <guojin02@tsinghua.org.cn>
To: linuxppc-embedded@ozlabs.org
Date: Fri, 02 Nov 2007 10:35:35 +0800
Subject: NETDEV WATCHDOG: eth1: transmit timed out on MPC8360?
Content-Type: text/plain
Reply-To: =?gb2312?B?ufm+og==?= <guojin02@tsinghua.org.cn>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,friends,
 I had a problem about the eth1 on MPC8360E, I used the eth0 to connect the
88E1111 phy chip, the eth0 is OK always,I can download the kernel uImage and
ramdisk from eth0 by TFTP. I connected the eth1 to the BCM5387 switch chip, there
are series resistor between the MPC8360E and BCM5387 on all GMII signal, I
installed those series resistor and uninstalled them, follow error are both
happened.

Follow is the uboot information:
U-Boot 1.2.0 (Oct 26 2007 - 18:22:13) MPC83XX

Clock configuration:
  Coherent System Bus:  264 MHz
  Core:                 528 MHz
  QE:                   198 MHz
  Local Bus Controller: 264 MHz
  Local Bus:             66 MHz
  DDR:                  264 MHz
  DDR Secondary:        264 MHz
  SEC:                   88 MHz
  I2C1:                 264 MHz
  I2C2:                 264 MHz
CPU: MPC8360E, Rev: 20 at 528 MHz
Board: Freescale MPC8360EMDS
I2C:   ready
DRAM:  now begin spd_sdram ....... 

   SDRAM on Local Bus: 64 MB
   DDR RAM: 256 MB
DDR test phase 1:
DDR test phase 2:
DDR test passed. 
FLASH: 16 MB
PCI clock is 33MHz
PCI 32bit bus on PMC1 & PMC2 & PMC3
In:    serial
Out:   serial
Err:   serial
Net:   UEC: PHY is Marvell 88E11x1 (1410cc1)
FSL UEC0: Full Duplex
FSL UEC0: Speed 1000BT
FSL UEC0: Link is up
UEC: PHY is Marvell 88E11x1 (1410cc1)
FSL UEC1: Full Duplex
FSL UEC1: Speed 1000BT
FSL UEC1: Link is up
FSL UEC0, FSL UEC1
Hit any key to stop autoboot:   0 

Follow is the linux kernel loading information:
=> run bootcmd
Using FSL UEC0 device
TFTP from server 192.168.0.2; our IP address is 192.168.0.100
Filename 'uImage'.
Load address: 0xd000000
Loading: *#################################################################
	 #################################################################
	 ###############
done
Bytes transferred = 738275 (b43e3 hex)
Using FSL UEC0 device
TFTP from server 192.168.0.2; our IP address is 192.168.0.100
Filename 'ramdisk_ppc'.
Load address: 0xe000000
Loading: *#################################################################
	 #################################################################
	 ############################################################
done
Bytes transferred = 971744 (ed3e0 hex)
## Booting image at 0d000000 ...
   Image Name:   Linux-2.6.11
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    738211 Bytes = 720.9 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at 0e000000 ...
   Image Name:   ramdisk
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    971680 Bytes = 948.9 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Ramdisk to 0febe000, end 0ffab3a0 ... OK

Follow is the random output from begin of kernel,why the kernel output those
random character?

LZw|¥ttwœ±Éœ>4∑Ã4ªyGªè£≈{O?Ñ˜/?ØÛ"7{æÆ˚œ"7∑Mºè1#ø›L7?L?7¥Ãìè?4^Ãå7íÑ?,”áˇ/1øœ
£áctO?ù£áro€{?ªµ:øœ—ÁøuGøMß«0t7M=ªœLÿœ˜O0\Ãí71:“t?/ö¥?kØvLÆªÛc?O$áT|º{>;6z[Gs
¥|?4ºí?s¥vl?3vN5£œw?}Ó—Éøt7ºÃÜ∑"v¥¸&sLfn7L'∑åD770l?$wO1ßáwN?/Ù∑≤«?$¥rd[> v1,
?§≥?D?◊˜k?øørO? ?~O?v∑|?˜{wºÃ?DŸè—ÁásG?tD¥|Øc&∂}‰∂èr={>'∂≥∫æˇ0{tG?7/¥˜164¥æwO+
„v=∑ı?'z>?/c7¥Lw∂èùÉ∑~tøz??4ˇ8D¥rDX> t?5?¶∑1bﬂ˛}Ó[å¸?r}ΩL¶∑9;?¶wl?ùÉ?6‹”~∑rNXÑÙ
èg??î˜?¥‹LvœkºÔ?=øá|g€ÏáY˙èn4[æå6$;O1£ıcF?Ñ¥èr-[>'v12$Ùp¥{.77?ß«84¥º˜Ô;?/Ù˜/1øá
{F¥~ø∑0Oá{NZévÔc∑€—£˘s.?,?'¸~ªg?O'6œo{1L??zªávv∂∞DÌ∑wO?O∑¸?/??r=ΩLGn?∂ıg41?w
:?◊˚˜Ùp??øtO˜èªá˝kº|7∑Ï4îœ˘c?∂˜0?∫∆ávvZwv¥œå¥Âsm?$^⁄ƒ 5"º‘<?r¥Ù7ˇxGø¸£µ{wZ>£}
—„«S4¥|vå∑<?xŸÃ7?4¥Ãw?$^N§{0G¥l”s«S√ıt?ÃÑ4Ö›ìƒ?2ºÔ7 áxt‹Ã"è«8D??≤å?c„€öüátD??
ˇ?„árG?ctY?49?rwVzßœyt?=;?ß∑{~Xˇ
Ù˝"vRwÏºÆ≠7Õd¥l?˜ZDázG¥ÃD71b,OkwOgè„L˚Ò£∑~G?4Øq|¥ÃËœ{'[æG∫¸gt¥L'∂G±ª?g4˘tºƒ5c
0D?4Øf√Gº¸ ”wN∑~?{t¥L??árG??¸NSw ∂Wg-ıgv[n?v/Ω~$∑|4∑˘"ø≈¸O?˜ØfO?GZ>?c7ÙLw∂è
g¥œ˚«4<?◊Ïªè›£?6Ã{t?
˘t4ù“?pD¥¸∫Ø",z>6Òbº{¥ªrO?'?3<æLá⁄˝wtøÃ/öå?4¥ı~W?“t?œf$Ù|.;?ª∑wDŸè—ß∑s>¥Ã?=",œf%?
dn¢é?4??;√t4?
≈s,¥}6èsd=~&zﬂáw?<{>w∂èΩﬂátD¥Ã??&Zf$~??(”~?duœk7ıp?~˜èΩüø|∑|=£«07áÁLPw'h‘gMıgv[D
n?v/œ~∑|5≥˘"5èt”{>¥∫¥«Ûg7?6vØcv"ø˜~D¥¸4??øá"√Ô›∑á›o5˜}6MΩø?ÿ¸7ˇ/1ßÕ{w?=7-}ˇﬂ
r%{~?èn?}6˜Ø—ªµ~D?=˚≈:dºL-?Ω„7init started: BusyBox v1.5.1 (2007-10-26 20:04:50
CST) multi-call binary
starting pid 13, tty '': '/etc/init.d/rcS'
dzy XLU Build20070605
================================XLU================================
================================XLU================================

Please press Enter to activate this console. 
starting pid 18, tty '': '/bin/sh'


BusyBox v1.5.1 (2007-10-26 20:04:50 CST) Built-in shell (ash)
Enter 'help' for a list of built-in commands.

Follow is the dmesg output:
/ # dmesg
Linux version 2.6.11 (ticket@dpim4307) (gcc version 3.4.3) #22 Thu Nov 1 14:18:49
CST 2007
On node 0 totalpages: 65536
  DMA zone: 65536 pages, LIFO batch:16
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Built 1 zonelists
Kernel command line: root=/dev/ram0 rw console=ttyS0,115200
IPIC (128 IRQ sources, 8 External IRQs) at fe000700
QE IC (64 IRQ sources) at fe100080, phy: E0100080
PID hash table entries: 2048 (order: 11, 32768 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 256896k available (1216k kernel code, 304k data, 80k init, 0k highmem)
Calibrating delay loop... 351.23 BogoMIPS (lpj=175616)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 948k freed
NET: Registered protocol family 16
Registering ipic with sysfs...
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ttyS0 at MMIO 0xe0004500 (irq = 9) is a 16550A
ttyS1 at MMIO 0xe0004600 (irq = 10) is a 16550A
io scheduler noop registered
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
loop: loaded (max 8 devices)
eth0: Running with NAPI disabled
eth1: Running with NAPI disabled
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
NET: Registered protocol family 1
NET: Registered protocol family 17
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 80k init
/ # lsmod
Module                  Size  Used by

Follow is the ifconfig output:

/ # ifconfig eth1 192.168.0.20
read wrong value : mii_id 1,mii_reg 2, base fe103120
read wrong value : mii_id 1,mii_reg 3, base fe103120
eth1: PHY is Generic MII (ffffffff)
/ # read wrong value : mii_id 1,mii_reg 4, base fe103120
read wrong value : mii_id 1,mii_reg 0, base fe103120

Follow is the ping output:

/ # ping 192.168.0.100
PING 192.168.0.100 (192.168.0.100): 56 data bytes

Follow is the ping NETDEV WATCHDOG error,why we are failed here?

NETDEV WATCHDOG: eth1: transmit timed out
UCC1 Fast registers:
Base address: 0xfe103000
gumr  : addr - 0xfe103000, val - 0x0000003c
upsmr : addr - 0xfe103004, val - 0x02002000
utodr : addr - 0xfe103008, val - 0x0000
udsr  : addr - 0xfe10300c, val - 0x7e7e
ucce  : addr - 0xfe103010, val - 0x00000000
uccm  : addr - 0xfe103014, val - 0x7f010001
uccs  : addr - 0xfe103018, val - 0x00
urfb  : addr - 0xfe103020, val - 0x00002c00
urfs  : addr - 0xfe103024, val - 0x1000
urfet : addr - 0xfe103028, val - 0x0800
urfset: addr - 0xfe10302a, val - 0x0c00
utfb  : addr - 0xfe10302c, val - 0x00000c00
utfs  : addr - 0xfe103030, val - 0x2000
utfet : addr - 0xfe103034, val - 0x1000
utftt : addr - 0xfe103038, val - 0x0400
utpt  : addr - 0xfe10303c, val - 0x0100
urtry : addr - 0xfe103040, val - 0x00000000
guemr : addr - 0xfe103090, val - 0x13
UCC1 Geth registers:
Base address: 0xfe103000
maccfg1    : addr - 0xfe103100, val - 0x00000035
maccfg2    : addr - 0xfe103104, val - 0x00007205
ipgifg     : addr - 0xfe103108, val - 0x40605060
hafdup     : addr - 0xfe10310c, val - 0x00a1f037
miimcfg    : addr - 0xfe103120, val - 0x00000005
miimcom    : addr - 0xfe103124, val - 0x00000000
miimadd    : addr - 0xfe103128, val - 0x00000100
miimcon    : addr - 0xfe10312c, val - 0x0000ffff
miimstat   : addr - 0xfe103130, val - 0x0000ffff
miimmind   : addr - 0xfe103134, val - 0x00000000
ifctl      : addr - 0xfe103138, val - 0x01000000
ifstat     : addr - 0xfe10313c, val - 0x00000000
macstnaddr1: addr - 0xfe103140, val - 0x00000000
macstnaddr2: addr - 0xfe103144, val - 0x00000000
uempr      : addr - 0xfe103150, val - 0x00000000
utbipar    : addr - 0xfe103154, val - 0x00000011
uescr      : addr - 0xfe103158, val - 0x0804
tx64       : addr - 0xfe103180, val - 0x00000000
tx127      : addr - 0xfe103184, val - 0x00000000
tx255      : addr - 0xfe103188, val - 0x00000000
rx64       : addr - 0xfe10318c, val - 0x00000000
rx127      : addr - 0xfe103190, val - 0x00000000
rx255      : addr - 0xfe103194, val - 0x00000000
txok       : addr - 0xfe103198, val - 0x00000000
txcf       : addr - 0xfe10319c, val - 0x0000
tmca       : addr - 0xfe1031a0, val - 0x00000000
tbca       : addr - 0xfe1031a4, val - 0x00000000
rxfok      : addr - 0xfe1031a8, val - 0x00000000
rxbok      : addr - 0xfe1031ac, val - 0x00000000
rbyt       : addr - 0xfe1031b0, val - 0x00000000
rmca       : addr - 0xfe1031b4, val - 0x00000000
rbca       : addr - 0xfe1031b8, val - 0x00000000
scar       : addr - 0xfe1031bc, val - 0x00000000
scam       : addr - 0xfe1031c0, val - 0xffff0000
Thread data TXs:
Base address: 0xfe113d00
Thread data TX[0]:
Base address: 0xfe113d00
0xfe113d00: 00000000 00003e00 0f003e60 83003e80
0xfe113d10: 0f003e60 00e00001 00000000 0000e0c0
0xfe113d20: 0c000001 00000000 0000000c 0000000c
0xfe113d30: 00000000 00003004 00000000 00000000
0xfe113d40: 00000000 00000600 00003f00 05ee0040
0xfe113d50: 05f005f0 00000000 00000000 00000000
0xfe113d60: 00000000 00000000 
Thread data TX[1]:
Base address: 0xfe113d68
0xfe113d68: 00000000 00000000 00000000 00000000
0xfe113d78: 00000000 81000000 00000000 00000000
0xfe113d88: 00000000 00000000 00000000 00000000
0xfe113d98: 00000000 00000000 00000000 00000000
0xfe113da8: 00000000 00000000 00000000 00000000
0xfe113db8: 81000000 00000000 00000000 00000000
0xfe113dc8: 00000000 00000000 
Thread data TX[2]:
Base address: 0xfe113dd0
0xfe113dd0: 00000000 00000000 00000000 00000000
0xfe113de0: 00000000 00000000 00000000 00000000
0xfe113df0: 00000000 00000000 00000000 00000000
0xfe113e00: 00000000 02000000 00000000 0000807f
0xfe113e10: 00000000 0000807f 00000000 0000807f
0xfe113e20: 00000000 0000807f 00000000 08009031
0xfe113e30: 00000000 02000000 
Thread data TX[3]:
Base address: 0xfe113e38
0xfe113e38: 00000000 0000807f 00000000 0000807f
0xfe113e48: 00000000 0000807f 00000000 0000807f
0xfe113e58: 00000000 08009011 00000000 02000000
0xfe113e68: 00000000 0000807f 00000000 0000807f
0xfe113e78: 00000000 08009031 15004300 00000000
0xfe113e88: 1c004340 00000001 1d004380 00000002
0xfe113e98: 240043c0 00000003 
Thread data RX:
Base address: 0xfe114000
Thread data RX[0]:
Base address: 0xfe114000
0xfe114000: 00000000 00000000 00000000 00000000
0xfe114010: 00000000 00000000 00000000 00000000
0xfe114020: 00000000 00000000 
Thread data RX[1]:
Base address: 0xfe114028
0xfe114028: 00000000 00000000 00000000 00000000
0xfe114038: 00000000 00000000 00000000 00000000
0xfe114048: 00000000 00000000 
Thread data RX[2]:
Base address: 0xfe114050
0xfe114050: 00000000 00000000 00000000 00000000
0xfe114060: 00000000 00000000 00000000 00000000
0xfe114070: 00000000 00000000 
Thread data RX[3]:
Base address: 0xfe114078
0xfe114078: 00000000 00000000 00004100 00000005
0xfe114088: 00004180 0000000c 00004200 0000000d
0xfe114098: 00004280 00000014 
TX global param:
Base address: 0xfe113c80
temoder      : addr - 0xfe113c80, val - 0xc100
sqptr        : addr - 0xfe113cb8, val - 0x00003c20
schedulerbasepointer: addr - 0xfe113cbc, val - 0x00000000
txrmonbaseptr: addr - 0xfe113cc0, val - 0x00003ea0
tstate       : addr - 0xfe113cc4, val - 0x30000000
iphoffset[0] : addr - 0xfe113cc8, val - 0x00
iphoffset[1] : addr - 0xfe113cc9, val - 0x00
iphoffset[2] : addr - 0xfe113cca, val - 0x00
iphoffset[3] : addr - 0xfe113ccb, val - 0x00
iphoffset[4] : addr - 0xfe113ccc, val - 0x00
iphoffset[5] : addr - 0xfe113ccd, val - 0x00
iphoffset[6] : addr - 0xfe113cce, val - 0x00
iphoffset[7] : addr - 0xfe113ccf, val - 0x00
vtagtable[0] : addr - 0xfe113cd0, val - 0x00000000
vtagtable[1] : addr - 0xfe113cd4, val - 0x00000000
vtagtable[2] : addr - 0xfe113cd8, val - 0x00000000
vtagtable[3] : addr - 0xfe113cdc, val - 0x00000000
vtagtable[4] : addr - 0xfe113ce0, val - 0x00000000
vtagtable[5] : addr - 0xfe113ce4, val - 0x00000000
vtagtable[6] : addr - 0xfe113ce8, val - 0x00000000
vtagtable[7] : addr - 0xfe113cec, val - 0x00000000
tqptr        : addr - 0xfe113cf0, val - 0x00003d00
RX global param:
Base address: 0xfe113f00
remoder         : addr - 0xfe113f00, val - 0x00001000
rqptr           : addr - 0xfe113f04, val - 0x00004000
typeorlen       : addr - 0xfe113f20, val - 0x0c00
rxgstpack       : addr - 0xfe113f23, val - 0x00
rxrmonbaseptr   : addr - 0xfe113f24, val - 0x000040a0
intcoalescingptr: addr - 0xfe113f30, val - 0x00003c08
rstate          : addr - 0xfe113f36, val - 0x30
mrblr           : addr - 0xfe113f46, val - 0x0600
rbdqptr         : addr - 0xfe113f48, val - 0x00003ed0
mflr            : addr - 0xfe113f4c, val - 0x05ee
minflr          : addr - 0xfe113f4e, val - 0x0040
maxd1           : addr - 0xfe113f50, val - 0x05f0
maxd2           : addr - 0xfe113f52, val - 0x05f0
ecamptr         : addr - 0xfe113f54, val - 0x00000000
l2qt            : addr - 0xfe113f58, val - 0x00000000
l3qt[0]         : addr - 0xfe113f5c, val - 0x00000000
l3qt[1]         : addr - 0xfe113f60, val - 0x00000000
l3qt[2]         : addr - 0xfe113f64, val - 0x00000000
l3qt[3]         : addr - 0xfe113f68, val - 0x00000000
l3qt[4]         : addr - 0xfe113f6c, val - 0x00000000
l3qt[5]         : addr - 0xfe113f70, val - 0x00000000
l3qt[6]         : addr - 0xfe113f74, val - 0x00000000
l3qt[7]         : addr - 0xfe113f78, val - 0x00000000
vlantype        : addr - 0xfe113f7c, val - 0x8100
vlantci         : addr - 0xfe113f7e, val - 0x0000
addressfiltering[0]: addr - 0xfe113f80, val - 0x00
addressfiltering[1]: addr - 0xfe113f81, val - 0x00
addressfiltering[2]: addr - 0xfe113f82, val - 0x00
addressfiltering[3]: addr - 0xfe113f83, val - 0x00
addressfiltering[4]: addr - 0xfe113f84, val - 0x00
addressfiltering[5]: addr - 0xfe113f85, val - 0x00
addressfiltering[6]: addr - 0xfe113f86, val - 0x00
addressfiltering[7]: addr - 0xfe113f87, val - 0x00
addressfiltering[8]: addr - 0xfe113f88, val - 0x00
addressfiltering[9]: addr - 0xfe113f89, val - 0x00
addressfiltering[10]: addr - 0xfe113f8a, val - 0x00
addressfiltering[11]: addr - 0xfe113f8b, val - 0x00
addressfiltering[12]: addr - 0xfe113f8c, val - 0x00
addressfiltering[13]: addr - 0xfe113f8d, val - 0x00
addressfiltering[14]: addr - 0xfe113f8e, val - 0x02
addressfiltering[15]: addr - 0xfe113f8f, val - 0x00
addressfiltering[16]: addr - 0xfe113f90, val - 0x00
addressfiltering[17]: addr - 0xfe113f91, val - 0x00
addressfiltering[18]: addr - 0xfe113f92, val - 0x01
addressfiltering[19]: addr - 0xfe113f93, val - 0x00
addressfiltering[20]: addr - 0xfe113f94, val - 0x5e
addressfiltering[21]: addr - 0xfe113f95, val - 0x00
addressfiltering[22]: addr - 0xfe113f96, val - 0x00
addressfiltering[23]: addr - 0xfe113f97, val - 0x01
addressfiltering[24]: addr - 0xfe113f98, val - 0x00
addressfiltering[25]: addr - 0xfe113f99, val - 0x00
addressfiltering[26]: addr - 0xfe113f9a, val - 0xff
addressfiltering[27]: addr - 0xfe113f9b, val - 0xff
addressfiltering[28]: addr - 0xfe113f9c, val - 0xff
addressfiltering[29]: addr - 0xfe113f9d, val - 0xff
addressfiltering[30]: addr - 0xfe113f9e, val - 0xff
addressfiltering[31]: addr - 0xfe113f9f, val - 0xff
addressfiltering[32]: addr - 0xfe113fa0, val - 0x00
addressfiltering[33]: addr - 0xfe113fa1, val - 0x00
addressfiltering[34]: addr - 0xfe113fa2, val - 0xff
addressfiltering[35]: addr - 0xfe113fa3, val - 0xff
addressfiltering[36]: addr - 0xfe113fa4, val - 0xff
addressfiltering[37]: addr - 0xfe113fa5, val - 0xff
addressfiltering[38]: addr - 0xfe113fa6, val - 0xff
addressfiltering[39]: addr - 0xfe113fa7, val - 0xff
addressfiltering[40]: addr - 0xfe113fa8, val - 0x00
addressfiltering[41]: addr - 0xfe113fa9, val - 0x00
addressfiltering[42]: addr - 0xfe113faa, val - 0xff
addressfiltering[43]: addr - 0xfe113fab, val - 0xff
addressfiltering[44]: addr - 0xfe113fac, val - 0xff
addressfiltering[45]: addr - 0xfe113fad, val - 0xff
addressfiltering[46]: addr - 0xfe113fae, val - 0xff
addressfiltering[47]: addr - 0xfe113faf, val - 0xff
addressfiltering[48]: addr - 0xfe113fb0, val - 0x00
addressfiltering[49]: addr - 0xfe113fb1, val - 0x00
addressfiltering[50]: addr - 0xfe113fb2, val - 0xff
addressfiltering[51]: addr - 0xfe113fb3, val - 0xff
addressfiltering[52]: addr - 0xfe113fb4, val - 0xff
addressfiltering[53]: addr - 0xfe113fb5, val - 0xff
addressfiltering[54]: addr - 0xfe113fb6, val - 0xff
addressfiltering[55]: addr - 0xfe113fb7, val - 0xff
addressfiltering[56]: addr - 0xfe113fb8, val - 0x81
addressfiltering[57]: addr - 0xfe113fb9, val - 0x00
addressfiltering[58]: addr - 0xfe113fba, val - 0x00
addressfiltering[59]: addr - 0xfe113fbb, val - 0x00
addressfiltering[60]: addr - 0xfe113fbc, val - 0x00
addressfiltering[61]: addr - 0xfe113fbd, val - 0x00
addressfiltering[62]: addr - 0xfe113fbe, val - 0x00
addressfiltering[63]: addr - 0xfe113fbf, val - 0x00
exfGlobalParam  : addr - 0xfe113fc0, val - 0x00000000
Send Q memory registers:
Base address: 0xfe113c20
SQQD[0]:
Base address: 0xfe113c20
0xfe113c20: 0feb6ca0 00003c40 0feb6ca0 0feb6d18
0xfe113c30: 00000000 00000000 0feb6ca0 0feb6d18
0xfe113c40: 00000000 00000000 00000000 00000000
0xfe113c50: 00000000 00000000 00000000 00000000
TX FW statistics pram:
Base address: 0xfe113ea0
0xfe113ea0: 00000000 00000000 00000000 00000000
0xfe113eb0: 00000000 00000000 00000000 00000000
0xfe113ec0: 00000000 00000000 00000000 00000000
RX FW statistics pram:
Base address: 0xfe1140a0
0xfe1140a0: 00000000 00000000 00000000 00000000
0xfe1140b0: 00000000 00000000 00000000 00000000
0xfe1140c0: 00000000 00000000 00000000 00000000
0xfe1140d0: 00000000 00000000 00000000 00000000
0xfe1140e0: 00000000 00000000 00000000 00000000
0xfe1140f0: 00000000 00000000 00000000 
RX IRQ coalescing tables:
Base address: 0xfe113c08
RX IRQ coalescing table entry[0]:
Base address: 0xfe113c08
interruptcoalescingmaxvalue: addr - 0xfe113c08, val - 0x00000001
interruptcoalescingcounter : addr - 0xfe113c0c, val - 0x00000001
RX BD QS tables:
Base address: 0xfe113ed0
RX BD QS table[0]:
Base address: 0xfe113ed0
bdbaseptr        : addr - 0xfe113ed0, val - 0x00003ee0
bdptr            : addr - 0xfe113ed4, val - 0x00003ee0
externalbdbaseptr: addr - 0xfe113ed8, val - 0x0feb6d60
externalbdptr    : addr - 0xfe113edc, val - 0x0feb6d60
ucode RX Prefetched BDs:
Base address: 0xfe113ee0
0xfe113ee0: 90000000 0fe5b040 90000000 0fe4d840
0xfe113ef0: 90000000 0fe4d040 90000000 0fe4e840
Init enet param shadow:
Base address: 0xcfe49ea0
0xcfe49ea0: 0630ff00 04000000 00003f03 04000003
0xcfe49eb0: 05004103 0c004183 0d004203 14004283
0xcfe49ec0: 00000000 00000000 00000000 00000000
0xcfe49ed0: 00000000 00000000 00003c83 15004303
0xcfe49ee0: 1c004343 1d004383 240043c3 00000000
0xcfe49ef0: 00000000 00000000 00000000 00
Init enet entry 0:
Base address: 0xfe114300
0xfe114300: 00003c80 00000000 00000000 00000015
0xfe114310: 00000000 00000000 00000000 00000000
0xfe114320: 00000000 00000010 06003d80 06003d80
0xfe114330: 00000000 00000000 00000000 00000000
Init enet entry 1:
Base address: 0xfe114340
0xfe114340: 00003c80 00000000 00000000 0001001c
0xfe114350: 00000000 00000000 00000000 00000000
0xfe114360: 00000000 00000010 06003dc0 06003dc0
0xfe114370: 00000000 00000000 00000000 00000000
Init enet entry 2:
Base address: 0xfe114380
0xfe114380: 00003c80 00000000 00000000 0002001d
0xfe114390: 00000000 00000000 00000000 00000000
0xfe1143a0: 00000000 00000010 06003e00 06003e00
0xfe1143b0: 00000000 00000000 00000000 00000000
Init enet entry 3:
Base address: 0xfe1143c0
0xfe1143c0: 40003c80 00000000 00000000 00030024
0xfe1143d0: 00000000 00000000 00000000 00000000
0xfe1143e0: 00000000 00000010 06003e40 06003e40
0xfe1143f0: 00000000 00000000 00000000 00000000
Init enet entry 1:
Base address: 0xfe114100
0xfe114100: 00003f00 00000000 00000000 30000000
0xfe114110: 00000000 000040c0 00000000 00000000
0xfe114120: 00000000 00000000 00000000 00000000
0xfe114130: 00000000 00000000 00000000 00000000
0xfe114140: 00000000 00000000 00000000 00000000
0xfe114150: 00000000 00000000 00000005 0000000c
0xfe114160: 00001000 81000000 00000000 00000000
0xfe114170: 00000000 00000000 00000000 00000000
Init enet entry 2:
Base address: 0xfe114180
0xfe114180: 00003f00 00000000 00000000 30000000
0xfe114190: 00000000 00004140 02000049 08009011
0xfe1141a0: 0c000212 0ffb3240 05f00000 00003f00
0xfe1141b0: 0ffb3440 00000000 00000000 00000000
0xfe1141c0: 00000000 00000000 00000000 00000000
0xfe1141d0: 00000000 0ffae3c8 0000000c 0000000d
0xfe1141e0: 00001000 81000000 00000000 00000000
0xfe1141f0: 00000000 00000000 00000400 00000212
Init enet entry 3:
Base address: 0xfe114200
0xfe114200: 00003f00 00000000 80000000 30000000
0xfe114210: 00000000 000041c0 00000000 00000000
0xfe114220: 00000000 00000000 86003a80 86003a80
0xfe114230: 00000000 00000000 00000000 00000000
0xfe114240: 000038c0 06003af0 00000000 0001001c
0xfe114250: 00000000 00000000 0000000d 00000014
0xfe114260: 00001000 81000000 86003ac0 86003ac0
0xfe114270: 00000000 00000000 00000000 00000000
Init enet entry 4:
Base address: 0xfe114280
0xfe114280: 00003f00 00000000 80000000 30000000
0xfe114290: 00000000 00004240 00000000 00000000
0xfe1142a0: 00000000 00000000 86003b00 86003b00
0xfe1142b0: 00000000 00000000 00000000 00000000
0xfe1142c0: 400038c0 06003b70 80000000 00030024
0xfe1142d0: 00000000 00000000 00000014 00000005
0xfe1142e0: 00001000 81000000 86003b40 86003b40
0xfe1142f0: 00000000 00000000 00000000 00000000
TX BDs[0]
0xcfeb6ca0: 9800002a 0fe4b0c2 9800002a 0fe4b1c2
0xcfeb6cb0: 9800002a 0fe4b2c2 9800002a 0fe4b3c2
0xcfeb6cc0: 9800002a 0fe4b4c2 9800002a 0fe4b5c2
0xcfeb6cd0: 9800002a 0fe4b6c2 9800002a 0fe4b7c2
0xcfeb6ce0: 9800002a 0fe4b8c2 9800002a 0fe4b9c2
0xcfeb6cf0: 9800002a 0fe4bac2 9800002a 0fe4bbc2
0xcfeb6d00: 9800002a 0fe4bcc2 9800002a 0fe4bdc2
0xcfeb6d10: 9800002a 0fe47ee2 b800002a 0fe47de2
RX BDs[0]
0xcfeb6d60: 90000000 0fe5b040 90000000 0fe4d840
0xcfeb6d70: 90000000 0fe4d040 90000000 0fe4e840
0xcfeb6d80: 90000000 0fe4e040 90000000 0fe4f840
0xcfeb6d90: 90000000 0fe4f040 90000000 0fe50840
0xcfeb6da0: 90000000 0fe50040 90000000 0fe51840
0xcfeb6db0: 90000000 0fe51040 90000000 0fe52840
0xcfeb6dc0: 90000000 0fe52040 90000000 0fe37840
0xcfeb6dd0: 90000000 0fe37040 b0000000 0fe38840
