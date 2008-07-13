Return-Path: <nadavs@corrigent.com>
Received: from tlvmail1.corrigent.com (tlvmail1.corrigent.com [213.31.203.2])
	by ozlabs.org (Postfix) with ESMTP id D5433DE073
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 14 Jul 2008 00:22:07 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8E4F2.1C389212"
Subject: EXT2-fs error when trying to work with highmem
Date: Sun, 13 Jul 2008 17:09:48 +0300
Message-ID: <44F4E579A764584EA9BDFD07D0CA0813E042A1@tlvmail1>
From: "Nadav Sharabi" <nadavs@corrigent.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8E4F2.1C389212
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hi All,
=20
I have built a 2.6.14 image and Ramdisk for my board witch has a ppc
8349 processor with 1G DDR. The system works file if I build it without
highmem support but if I try to add highmem support to the system, witch
I need in order to expand my memory to 2G, I get the following error:
=20
EXT2-fs error (device ram0): ext2_check_page: bad entry in directory #2:
directory entry across blocks - offset=3D0, inode=3D2147614725,
rec_len=3D1152, name_len=3D8
=20
This is my console output:
=20
=3D=3D=3D=3D Booting kernel =3D=3D=3D=3D
## Booting image at 00200000 ...
   Image Name:   Linux-2.6.14.7-saline
   Image Type:   PowerPC Linux Kernel Image (grip compressed)
   Data Size:    1658344 Bytes =3D  1.6 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Loading RAM Disk Image at 01000000 ...
   Image Name:   Corrigent_ignited_fess
   Image Type:   PowerPC Linux RAM Disk Image (grip compressed)
   Data Size:    13721548 Bytes =3D 13.1 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Ramdisk to 0b2ea000, end 0bffffcc ... OK
Linux version 2.6.14.7-saline (nadavs@nadavs_l.corrigent.com) (gcc
version 3.4.4 (Wind River Linux)) #50 PREEMPT Sun Jul 13 11:04:30 IDT
2008
Built 1 zonelists
Kernel command line: root=3D/dev/ram0 rw ramdisk_size=3D300000 =
mem=3D1008M
ip=3D192.168.10.50:192.168.10.1:192.168.10.1:255.255.255.0:SBC8349:eth0:o=
f
f console=3DttyS1,115200,115200 debug_flag=3Dno msm_standalone=3Dno
oper_mode=3Dnormal bootdir=3Dmsm_images vlan=3D sd=3D
LTT : ltt-base init
IPIC (128 IRQ sources, 8 External IRQs) at fe000700
PID hash table entries: 4096 (order: 12, 65536 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1005368k available (2612k kernel code, 960k data, 124k init,
114688k highmem)
Security Framework v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 512
checking if image is initramfs...softlockup thread 0 started up.
it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 13399k freed
NET: Registered protocol family 16
PCI: Probing PCI hardware
PCI: Cannot allocate resource region 0 of device 0000:00:00.0
PCI: Cannot allocate resource region 2 of device 0000:00:00.0
PCI: Failed to allocate mem resource #2:80000000@0 for 0000:00:00.0
Generic PHY: Registered new driver
LTT : ltt-facilities init
LTT : ltt-core init as module
Registering GDB sysrq handler
highmem bounce pool size: 64 pages
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
LTT : ltt-facility-core init in kernel
LTT : ltt-facility-fs init in kernel
LTT : ltt-facility-ipc init in kernel
LTT : ltt-facility-kernel_arch init in kernel
LTT : ltt-facility-kernel init in kernel
LTT : ltt-facility-memory init in kernel
LTT : ltt-facility-network init in kernel
LTT : ltt-facility-process init in kernel
LTT : ltt-facility-socket init in kernel
LTT : ltt-facility-timer init in kernel
LTT : ltt-facility-statedump init in kernel
Software Watchdog Timer: 0.07 initialized. soft_noboot=3D1 =
soft_margin=3D10
sec (nowayout=3D 1)
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing
disabled
ttyS0 at MMIO map 0xe0004500 mem 0xfe004500 (irq =3D 9) is a 16550A
ttyS1 at MMIO map 0xe0004600 mem 0xfe004600 (irq =3D 10) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 1 RAM disks of 300000K size 1024 blocksize
loop: loaded (max 8 devices)
nbd: registered device at major 43
eth0: Gianfar Ethernet Controller Version 1.1, 40:08:db:00:00:01=20
eth0: Running with NAPI disabled
eth0: 256/256 RX/TX BD ring size
eth1: Gianfar Ethernet Controller Version 1.1, 40:08:db:00:10:00=20
eth1: Running with NAPI disabled
eth1: 256/256 RX/TX BD ring size
netconsole: not configured, aborting
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=3Dxx
hda: W7NCF01GH20IS4BG, CFA DISK drive
ide0 at 0xf9002000-0xf9002007,0xf900208c on irq 21
hda: max request size: 128KiB
hda: 2046240 sectors (1047 MB) w/0KiB Cache, CHS=3D2030/16/63
hda: cache flushes not supported
 hda: hda1 hda2
physmap flash device: 800000 at ff800000
phys_mapped_flash: Found 1 x16 devices at 0x0 in 16-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
RedBoot partition parsing not available
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 7, 524288 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
ip_conntrack version 2.3 (8064 buckets, 64512 max) - 236 bytes per
conntrack
ip_tables: (C) 2000-2002 Netfilter core team
arp_tables: (C) 2002 David S. Miller
TCP bic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
eth0: PHY is Marvell 88E6046 (1410c89)
IP-Config: Complete:
      device=3Deth0, addr=3D192.168.10.50, mask=3D255.255.255.0,
gw=3D192.168.10.1,
     host=3DSBC8349, domain=3D, nis-domain=3D(none),
     bootserver=3D192.168.10.1, rootserver=3D192.168.10.1, rootpath=3D
RAMDISK: Compressed image found at block 0
eth0: Full Duplex
eth0: Speed 1000BT
eth0: Link is up
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 124k init
EXT2-fs error (device ram0): ext2_check_page: bad entry in directory #2:
directory entry across blocks - offset=3D0, inode=3D2147614725,
rec_len=3D1152, name_len=3D8
Warning: unable to open an initial console.
Kernel panic - not syncing: No init found.  Try passing init=3D option =
to
kernel.
 <0>Rebooting in 180 seconds
=20
Thanks,
Nadav

------_=_NextPart_001_01C8E4F2.1C389212
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.6000.16640" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D947154513-13072008><FONT face=3DArial size=3D2>Hi=20
All,</FONT></SPAN></DIV>
<DIV><SPAN class=3D947154513-13072008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D947154513-13072008><FONT face=3DArial size=3D2>I have =
built a=20
2.6.14 image and Ramdisk for my board witch has a ppc 8349 processor =
with 1G=20
DDR. The system works file if I build it without highmem support but if =
I try to=20
add highmem support to the system, witch I need in order to expand my =
memory to=20
2G, I get the following error:</FONT></SPAN></DIV>
<DIV><SPAN class=3D947154513-13072008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D947154513-13072008><FONT face=3DArial =
size=3D2>EXT2-fs error=20
(device ram0): ext2_check_page: bad entry in directory #2: directory =
entry=20
across blocks - offset=3D0, inode=3D2147614725, rec_len=3D1152,=20
name_len=3D8</FONT></SPAN><SPAN class=3D947154513-13072008></DIV></SPAN>
<DIV><SPAN class=3D947154513-13072008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D947154513-13072008><FONT face=3DArial size=3D2>This =
is my console=20
output:</FONT></SPAN></DIV>
<DIV><SPAN class=3D947154513-13072008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D947154513-13072008><FONT face=3DArial =
size=3D2>=3D=3D=3D=3D Booting kernel=20
=3D=3D=3D=3D<BR>## Booting image at 00200000 ...<BR>&nbsp;&nbsp; Image =
Name:&nbsp;&nbsp;=20
Linux-2.6.14.7-saline<BR>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC =
Linux=20
Kernel Image (grip compressed)<BR>&nbsp;&nbsp; Data =
Size:&nbsp;&nbsp;&nbsp;=20
1658344 Bytes =3D&nbsp; 1.6 MB<BR>&nbsp;&nbsp; Load Address:=20
00000000<BR>&nbsp;&nbsp; Entry Point:&nbsp; 00000000<BR>&nbsp;&nbsp; =
Verifying=20
Checksum ... OK<BR>&nbsp;&nbsp; Uncompressing Kernel Image ... OK<BR>## =
Loading=20
RAM Disk Image at 01000000 ...<BR>&nbsp;&nbsp; Image Name:&nbsp;&nbsp;=20
Corrigent_ignited_fess<BR>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC =
Linux RAM=20
Disk Image (grip compressed)<BR>&nbsp;&nbsp; Data =
Size:&nbsp;&nbsp;&nbsp;=20
13721548 Bytes =3D 13.1 MB<BR>&nbsp;&nbsp; Load Address: =
00000000<BR>&nbsp;&nbsp;=20
Entry Point:&nbsp; 00000000<BR>&nbsp;&nbsp; Verifying Checksum ...=20
OK<BR>&nbsp;&nbsp; Loading Ramdisk to 0b2ea000, end 0bffffcc ... =
OK<BR>Linux=20
version 2.6.14.7-saline (<A=20
href=3D"mailto:nadavs@nadavs_l.corrigent.com">nadavs@nadavs_l.corrigent.c=
om</A>)=20
(gcc version 3.4.4 (Wind River Linux)) #50 PREEMPT Sun Jul 13 11:04:30 =
IDT=20
2008<BR>Built 1 zonelists</FONT></SPAN></DIV>
<DIV><SPAN class=3D947154513-13072008><FONT face=3DArial size=3D2>Kernel =
command line:=20
root=3D/dev/ram0 rw ramdisk_size=3D300000 mem=3D1008M=20
ip=3D192.168.10.50:192.168.10.1:192.168.10.1:255.255.255.0:SBC8349:eth0:o=
ff=20
console=3DttyS1,115200,115200 debug_flag=3Dno msm_standalone=3Dno =
oper_mode=3Dnormal=20
bootdir=3Dmsm_images vlan=3D sd=3D<BR>LTT : ltt-base init<BR>IPIC (128 =
IRQ sources, 8=20
External IRQs) at fe000700<BR>PID hash table entries: 4096 (order: 12, =
65536=20
bytes)<BR>Dentry cache hash table entries: 131072 (order: 7, 524288=20
bytes)<BR>Inode-cache hash table entries: 65536 (order: 6, 262144=20
bytes)<BR>Memory: 1005368k available (2612k kernel code, 960k data, 124k =
init,=20
114688k highmem)<BR>Security Framework v1.0.0 initialized<BR>Capability =
LSM=20
initialized<BR>Mount-cache hash table entries: 512<BR>checking if image =
is=20
initramfs...softlockup thread 0 started up.<BR>it isn't (no cpio magic); =
looks=20
like an initrd<BR>Freeing initrd memory: 13399k freed<BR>NET: Registered =

protocol family 16<BR>PCI: Probing PCI hardware<BR>PCI: Cannot allocate =
resource=20
region 0 of device 0000:00:00.0<BR>PCI: Cannot allocate resource region =
2 of=20
device 0000:00:00.0<BR>PCI: Failed to allocate mem resource =
#2:80000000@0 for=20
0000:00:00.0<BR>Generic PHY: Registered new driver<BR>LTT : =
ltt-facilities=20
init<BR>LTT : ltt-core init as module<BR>Registering GDB sysrq=20
handler<BR>highmem bounce pool size: 64 pages<BR>Installing knfsd =
(copyright (C)=20
1996 <A =
href=3D"mailto:okir@monad.swb.de">okir@monad.swb.de</A>).<BR>Initializing=
=20
Cryptographic API<BR>LTT : ltt-facility-core init in kernel<BR>LTT :=20
ltt-facility-fs init in kernel<BR>LTT : ltt-facility-ipc init in =
kernel<BR>LTT :=20
ltt-facility-kernel_arch init in kernel<BR>LTT : ltt-facility-kernel =
init in=20
kernel<BR>LTT : ltt-facility-memory init in kernel<BR>LTT : =
ltt-facility-network=20
init in kernel<BR>LTT : ltt-facility-process init in kernel<BR>LTT :=20
ltt-facility-socket init in kernel<BR>LTT : ltt-facility-timer init in=20
kernel<BR>LTT : ltt-facility-statedump init in kernel<BR>Software =
Watchdog=20
Timer: 0.07 initialized. soft_noboot=3D1 soft_margin=3D10 sec =
(nowayout=3D=20
1)<BR>Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing=20
disabled<BR>ttyS0 at MMIO map 0xe0004500 mem 0xfe004500 (irq =3D 9) is a =

16550A<BR>ttyS1 at MMIO map 0xe0004600 mem 0xfe004600 (irq =3D 10) is a=20
16550A<BR>io scheduler noop registered<BR>io scheduler anticipatory=20
registered<BR>io scheduler deadline registered<BR>io scheduler cfq=20
registered<BR>RAMDISK driver initialized: 1 RAM disks of 300000K size =
1024=20
blocksize<BR>loop: loaded (max 8 devices)<BR>nbd: registered device at =
major=20
43<BR>eth0: Gianfar Ethernet Controller Version 1.1, 40:08:db:00:00:01 =
<BR>eth0:=20
Running with NAPI disabled<BR>eth0: 256/256 RX/TX BD ring size<BR>eth1: =
Gianfar=20
Ethernet Controller Version 1.1, 40:08:db:00:10:00 <BR>eth1: Running =
with NAPI=20
disabled<BR>eth1: 256/256 RX/TX BD ring size<BR>netconsole: not =
configured,=20
aborting<BR>Uniform Multi-Platform E-IDE driver Revision: =
7.00alpha2<BR>ide:=20
Assuming 33MHz system bus speed for PIO modes; override with =
idebus=3Dxx<BR>hda:=20
W7NCF01GH20IS4BG, CFA DISK drive<BR>ide0 at =
0xf9002000-0xf9002007,0xf900208c on=20
irq 21<BR>hda: max request size: 128KiB<BR>hda: 2046240 sectors (1047 =
MB) w/0KiB=20
Cache, CHS=3D2030/16/63<BR>hda: cache flushes not =
supported<BR>&nbsp;hda: hda1=20
hda2<BR>physmap flash device: 800000 at ff800000<BR>phys_mapped_flash: =
Found 1=20
x16 devices at 0x0 in 16-bit bank<BR>&nbsp;Amd/Fujitsu Extended Query =
Table at=20
0x0040<BR>number of CFI chips: 1<BR>cfi_cmdset_0002: Disabling=20
erase-suspend-program due to code brokenness.<BR>RedBoot partition =
parsing not=20
available<BR>NET: Registered protocol family 2<BR>IP route cache hash =
table=20
entries: 32768 (order: 5, 131072 bytes)<BR>TCP established hash table =
entries:=20
131072 (order: 7, 524288 bytes)<BR>TCP bind hash table entries: 65536 =
(order: 6,=20
262144 bytes)<BR>TCP: Hash tables configured (established 131072 bind=20
65536)<BR>TCP reno registered<BR>ip_conntrack version 2.3 (8064 buckets, =
64512=20
max) - 236 bytes per conntrack<BR>ip_tables: (C) 2000-2002 Netfilter =
core=20
team<BR>arp_tables: (C) 2002 David S. Miller<BR>TCP bic=20
registered<BR>Initializing XFRM netlink socket<BR>NET: Registered =
protocol=20
family 1<BR>NET: Registered protocol family 17<BR>NET: Registered =
protocol=20
family 15<BR>802.1Q VLAN Support v1.8 Ben Greear &lt;<A=20
href=3D"mailto:greearb@candelatech.com">greearb@candelatech.com</A>&gt;<B=
R>All=20
bugs added by David S. Miller &lt;<A=20
href=3D"mailto:davem@redhat.com">davem@redhat.com</A>&gt;<BR>eth0: PHY =
is Marvell=20
88E6046 (1410c89)<BR>IP-Config: =
Complete:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
device=3Deth0, addr=3D192.168.10.50, mask=3D255.255.255.0,=20
gw=3D192.168.10.1,<BR>&nbsp;&nbsp;&nbsp;&nbsp; host=3DSBC8349, =
domain=3D,=20
nis-domain=3D(none),<BR>&nbsp;&nbsp;&nbsp;&nbsp; =
bootserver=3D192.168.10.1,=20
rootserver=3D192.168.10.1, rootpath=3D<BR>RAMDISK: Compressed image =
found at block=20
0<BR>eth0: Full Duplex<BR>eth0: Speed 1000BT<BR>eth0: Link is up<BR>VFS: =
Mounted=20
root (ext2 filesystem).<BR>Freeing unused kernel memory: 124k =
init<BR>EXT2-fs=20
error (device ram0): ext2_check_page: bad entry in directory #2: =
directory entry=20
across blocks - offset=3D0, inode=3D2147614725, rec_len=3D1152, =
name_len=3D8<BR>Warning:=20
unable to open an initial console.<BR>Kernel panic - not syncing: No =
init=20
found.&nbsp; Try passing init=3D option to =
kernel.<BR>&nbsp;&lt;0&gt;Rebooting in=20
180 seconds</FONT></SPAN></DIV>
<DIV><SPAN class=3D947154513-13072008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D947154513-13072008><FONT face=3DArial=20
size=3D2>Thanks,</FONT></SPAN></DIV>
<DIV><SPAN class=3D947154513-13072008><FONT face=3DArial=20
size=3D2>Nadav</FONT></SPAN></DIV></BODY></HTML>

------_=_NextPart_001_01C8E4F2.1C389212--
