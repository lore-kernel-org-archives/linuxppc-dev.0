Return-Path: <borish@batm.co.il>
Received: from mailserver.batm.batm.co.il (out.batm.co.il [212.199.94.207])
	by ozlabs.org (Postfix) with ESMTP id 27440DDE22
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 Jul 2007 00:54:35 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7C880.AFABB6A0"
Subject: Memory Corruption in Linux kernel MPC8347 revision 3
Date: Tue, 17 Jul 2007 17:42:23 +0300
Message-ID: <1184683343.3337.57.camel@localhost.localdomain>
From: "Boris Shteinbock" <borish@batm.co.il>
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

------_=_NextPart_001_01C7C880.AFABB6A0
Content-Type: text/plain;
	charset="windows-1255"
Content-Transfer-Encoding: quoted-printable

	Hi Everyone.
I am working on the Linux port for MPC8347 revision 3 custom build board
with DDR2 memory.

I've successfully ported U-boot (latest git) and the kernel itself,
however during kernel boot I am encountering serious memory corruption
errors. The log for one of the examples is at the bottom of this
message.

Basically, the corruption is always happening somewhere at memory
management intensive tasks such as networking, JFFS2 mounting etc.

As far as I can see, it is not related to some specific driver, because
even it happens even at kernel configured at absolute minimum, ( console
serial driver only and even without it)
The place of the corruption depends on kernel configuration.

The DDR2 memory controller is configured correctly as far as I can tell,
since :
1. DDR2 controller register values are taken from VxWorks bootrom=20
that works on this board without any problems.
2. u-boot mtest passes successfully
3. u-boot alternative mtest passes successfully
4. My own custom mem tests in u-boot pass successfully
5. If I manage two boot the board into shell prompt (with absolute
minimum configuration) memtester application is also successful.=20

The minimum configuration that is one I am able to boot into shell is a
kernel configured with serial console and small busybox JFFS2 file
system in the flash. In this configuration, the boot fails the first
time JFFS2 root FS is mounted. However it does boot after reset.

I've tried different kernels with the same results  starting from, I
think, 2.6.16  up to 2.6.22
I tried the kernel that is provided by Freescale for 834x reference
boards. ( with my board support of course)

I tried booting both OF flat trees (powerpc) and bd_t based builds (ppc)

I've also tried all memory management options :
SLAB, SLOB and SLUB (in the latest kernel). They all failed at some
point of time, so the assumption is that the problem is not in the
memory management facilities.

The board manufacturer swears that DDR2 memory controller values are
correct and should work perfectly.

So now I almost out of options and I am seeking your help.
Any type of input on this issue would be greatly appreciated.=20

Thanks,
Boris

PS. Note that an below example represents failure during DHCP
autoconfiguration. However the similar error happens even when
networking is disabled completely. just in a different place.

=3D> bootm
## Booting image at 00400000 ...
   Image Name:   Linux-.6.21.5
   Created:      2007-07-10  14:20:19 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    898361 Bytes =3D 877.3 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Current stack ends at 0x07FA3CF8 =3D> set upper limit to 0x00800000
## cmdline at 0x007FFF00 ... 0x007FFF41
bd address  =3D 0x07FA3FBC
memstart    =3D 0x00000000
memsize     =3D 0x08000000
flashstart  =3D 0xFE000000
flashsize   =3D 0x02000000
flashoffset =3D 0x00033000
sramstart   =3D 0x00000000
sramsize    =3D 0x00000000
bootflags   =3D 0x00000001
intfreq     =3D    528 MHz
busfreq     =3D    264 MHz
ethaddr     =3D 00:04:9F:EF:23:35
eth1addr    =3D 00:E0:0C:00:7E:25
IP addr     =3D 10.2.222.20
baudrate    =3D 115200 bps
No initrd
## Transferring control to Linux (at address 00000000) ...
!!!! of_flat_tree =3D 00000000
Booting without OF Flat tree
Linux version .6.21.5 (me@localhost) (gcc version
4.0.0 (DENX ELDK 4.1 4.0.0)) #24 Tue Jul 10 17:20:09 IDT 2007
Zone PFN ranges:
  DMA             0 ->    32768
  Normal      32768 ->    32768
early_node_map[1] active PFN ranges
    0:        0 ->    32768
Built 1 zonelists.  Total pages: 32512
Kernel command line: console=3DttyS0,115200 root=3D/dev/mtdblock1
rootfstype=3Djffs2 ip=3Ddhcp
IPIC (128 IRQ sources, 8 External IRQs) at fe000700
PID hash table entries: 512 (order: 9, 2048 bytes)
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 127744k available (1584k kernel code, 444k data, 84k init, 0k
highmem)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
Setup MTD partitions
Generic PHY: Registered new driver
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP reno registered
JFFS2 version 2.2. (NAND) (C) 2001-2006 Red Hat, Inc.
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing
disabled
serial8250.0: ttyS0 at MMIO 0xe0004500 (irq =3D 9) is a 16550A
serial8250.0: ttyS1 at MMIO 0xe0004600 (irq =3D 10) is a 16550A
Gianfar MII Bus: probed
eth0: Gianfar Ethernet Controller Version 1.2, 00:04:9f:ef:23:35
eth0: Running with NAPI disabled
eth0: 64/64 RX/TX BD ring size
Broadcom BCM5241: Registered new driver
physmap platform flash device: 02000000 at fe000000
physmap-flash.0: Found 1 x16 devices at 0x0 in 8-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
physmap-flash.0: CFI does not contain boot bank location. Assuming top.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
cmdlinepart partition parsing not available
RedBoot partition parsing not available
Using physmap partition information
Creating 2 MTD partitions on "physmap-flash.0":
0x00000000-0x00100000 : "uboot"
0x00100000-0x02000000 : "rootfs"
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
!!!! Gianfar init_phy. phy_id =3D 0:01
!!!! phy_attach. phy_id =3D 0:01
!!!! phy_attach device found. phy_id =3D 0:01
Sending DHCP requests .<3>slab: Internal list corruption detected in
cache 'files_cache'(21), slabp c0344000(16). Hexdump:

000: 00 10 01 00 00 20 02 00 00 00 00 70 c0 34 40 70
010: 00 00 00 10 00 00 ff 10 00 00 00 00 ff ff ff fe
020: ff ff ff fe ff ff ff fe ff ff ff fe ff ff ff fe
030: ff ff ff fe ff ff ff fe ff ff ff fe ff ff ff fe
040: ff ff ff fe ff ff ff fe ff ff ff fe ff ff ff fe
050: ff ff ff fe ff ff ff fe ff ff ff fd 00 00 00 11
060: 00 00 00 12 00 00 00 13 00 00 00 14 ff ff ff ff
------------[ cut here ]------------
kernel BUG at mm/slab.c:2936!
Oops: Exception in kernel mode, sig: 5 [#1]
NIP: C0050F80 LR: C0050F80 CTR: 00000000
REGS: c034fe00 TRAP: 0700   Not tainted  (.6.21.5)
MSR: 00021032 <ME,IR,DR>  CR: 24004002  XER: 00000000
TASK =3D c032a3c0[3] 'events/0' THREAD: c034e000
GPR00: C0050F80 C034FEB0 C032A3C0 00000001 00000DF5 FFFFFFFF C00F5B54
00000010
GPR08: C01D0000 C01E0000 00000DF5 00000DF5 00000000 00F1C5DB 07FFD000
FFFFFFFF
GPR16: 00000001 00000000 00000000 00800000 00000000 007FFF00 00000000
C033DAA0
GPR24: C0339C90 00000007 00000000 C01B0000 C01B0000 C0344000 C033DAA0
00000070
NIP [C0050F80] check_slabp+0xe4/0x11c
LR [C0050F80] check_slabp+0xe4/0x11c
Call Trace:
[C034FEB0] [C0050F80] check_slabp+0xe4/0x11c (unreliable)
[C034FED0] [C0051450] free_block+0x88/0x138
[C034FF00] [C0052188] drain_array+0xa0/0xe0
[C034FF20] [C0052228] cache_reap+0x60/0x144
[C034FF40] [C00257B0] run_workqueue+0xd0/0x170
[C034FF60] [C0025960] worker_thread+0x110/0x144
[C034FFC0] [C00298E4] kthread+0x74/0xb0
[C034FFF0] [C0005F38] kernel_thread+0x44/0x60
Instruction dump:
387b6538 7c9df8ae 4bfc2b49 3bff0001 813e0020 5529103a 3929001c 7f9f4840
419cffcc 3c60c01b 3863336c 4bfc2b25 <0fe00000> 48000000 80030020
2f800000

------_=_NextPart_001_01C7C880.AFABB6A0
Content-Type: text/html;
	charset="windows-1255"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dwindows-1255">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7638.1">
<TITLE>Memory Corruption in Linux kernel MPC8347 revision 3</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2>Hi =
Everyone.<BR>
I am working on the Linux port for MPC8347 revision 3 custom build =
board<BR>
with DDR2 memory.<BR>
<BR>
I've successfully ported U-boot (latest git) and the kernel itself,<BR>
however during kernel boot I am encountering serious memory =
corruption<BR>
errors. The log for one of the examples is at the bottom of this<BR>
message.<BR>
<BR>
Basically, the corruption is always happening somewhere at memory<BR>
management intensive tasks such as networking, JFFS2 mounting etc.<BR>
<BR>
As far as I can see, it is not related to some specific driver, =
because<BR>
even it happens even at kernel configured at absolute minimum, ( =
console<BR>
serial driver only and even without it)<BR>
The place of the corruption depends on kernel configuration.<BR>
<BR>
The DDR2 memory controller is configured correctly as far as I can =
tell,<BR>
since :<BR>
1. DDR2 controller register values are taken from VxWorks bootrom<BR>
that works on this board without any problems.<BR>
2. u-boot mtest passes successfully<BR>
3. u-boot alternative mtest passes successfully<BR>
4. My own custom mem tests in u-boot pass successfully<BR>
5. If I manage two boot the board into shell prompt (with absolute<BR>
minimum configuration) memtester application is also successful.<BR>
<BR>
The minimum configuration that is one I am able to boot into shell is =
a<BR>
kernel configured with serial console and small busybox JFFS2 file<BR>
system in the flash. In this configuration, the boot fails the first<BR>
time JFFS2 root FS is mounted. However it does boot after reset.<BR>
<BR>
I've tried different kernels with the same results&nbsp; starting from, =
I<BR>
think, 2.6.16&nbsp; up to 2.6.22<BR>
I tried the kernel that is provided by Freescale for 834x reference<BR>
boards. ( with my board support of course)<BR>
<BR>
I tried booting both OF flat trees (powerpc) and bd_t based builds =
(ppc)<BR>
<BR>
I've also tried all memory management options :<BR>
SLAB, SLOB and SLUB (in the latest kernel). They all failed at some<BR>
point of time, so the assumption is that the problem is not in the<BR>
memory management facilities.<BR>
<BR>
The board manufacturer swears that DDR2 memory controller values are<BR>
correct and should work perfectly.<BR>
<BR>
So now I almost out of options and I am seeking your help.<BR>
Any type of input on this issue would be greatly appreciated.<BR>
<BR>
Thanks,<BR>
Boris<BR>
<BR>
PS. Note that an below example represents failure during DHCP<BR>
autoconfiguration. However the similar error happens even when<BR>
networking is disabled completely. just in a different place.<BR>
<BR>
=3D&gt; bootm<BR>
## Booting image at 00400000 ...<BR>
&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Linux-.6.21.5<BR>
&nbsp;&nbsp; Created:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2007-07-10&nbsp; =
14:20:19 UTC<BR>
&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip =
compressed)<BR>
&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 898361 Bytes =3D 877.3 kB<BR>
&nbsp;&nbsp; Load Address: 00000000<BR>
&nbsp;&nbsp; Entry Point:&nbsp; 00000000<BR>
&nbsp;&nbsp; Verifying Checksum ... OK<BR>
&nbsp;&nbsp; Uncompressing Kernel Image ... OK<BR>
## Current stack ends at 0x07FA3CF8 =3D&gt; set upper limit to =
0x00800000<BR>
## cmdline at 0x007FFF00 ... 0x007FFF41<BR>
bd address&nbsp; =3D 0x07FA3FBC<BR>
memstart&nbsp;&nbsp;&nbsp; =3D 0x00000000<BR>
memsize&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x08000000<BR>
flashstart&nbsp; =3D 0xFE000000<BR>
flashsize&nbsp;&nbsp; =3D 0x02000000<BR>
flashoffset =3D 0x00033000<BR>
sramstart&nbsp;&nbsp; =3D 0x00000000<BR>
sramsize&nbsp;&nbsp;&nbsp; =3D 0x00000000<BR>
bootflags&nbsp;&nbsp; =3D 0x00000001<BR>
intfreq&nbsp;&nbsp;&nbsp;&nbsp; =3D&nbsp;&nbsp;&nbsp; 528 MHz<BR>
busfreq&nbsp;&nbsp;&nbsp;&nbsp; =3D&nbsp;&nbsp;&nbsp; 264 MHz<BR>
ethaddr&nbsp;&nbsp;&nbsp;&nbsp; =3D 00:04:9F:EF:23:35<BR>
eth1addr&nbsp;&nbsp;&nbsp; =3D 00:E0:0C:00:7E:25<BR>
IP addr&nbsp;&nbsp;&nbsp;&nbsp; =3D 10.2.222.20<BR>
baudrate&nbsp;&nbsp;&nbsp; =3D 115200 bps<BR>
No initrd<BR>
## Transferring control to Linux (at address 00000000) ...<BR>
!!!! of_flat_tree =3D 00000000<BR>
Booting without OF Flat tree<BR>
Linux version .6.21.5 (me@localhost) (gcc version<BR>
4.0.0 (DENX ELDK 4.1 4.0.0)) #24 Tue Jul 10 17:20:09 IDT 2007<BR>
Zone PFN ranges:<BR>
&nbsp; =
DMA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 0 -&gt;&nbsp;&nbsp;&nbsp; 32768<BR>
&nbsp; Normal&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 32768 =
-&gt;&nbsp;&nbsp;&nbsp; 32768<BR>
early_node_map[1] active PFN ranges<BR>
&nbsp;&nbsp;&nbsp; 0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 =
-&gt;&nbsp;&nbsp;&nbsp; 32768<BR>
Built 1 zonelists.&nbsp; Total pages: 32512<BR>
Kernel command line: console=3DttyS0,115200 root=3D/dev/mtdblock1<BR>
rootfstype=3Djffs2 ip=3Ddhcp<BR>
IPIC (128 IRQ sources, 8 External IRQs) at fe000700<BR>
PID hash table entries: 512 (order: 9, 2048 bytes)<BR>
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)<BR>
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)<BR>
Memory: 127744k available (1584k kernel code, 444k data, 84k init, =
0k<BR>
highmem)<BR>
Mount-cache hash table entries: 512<BR>
NET: Registered protocol family 16<BR>
Setup MTD partitions<BR>
Generic PHY: Registered new driver<BR>
NET: Registered protocol family 2<BR>
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)<BR>
TCP established hash table entries: 4096 (order: 3, 32768 bytes)<BR>
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)<BR>
TCP: Hash tables configured (established 4096 bind 4096)<BR>
TCP reno registered<BR>
JFFS2 version 2.2. (NAND) (C) 2001-2006 Red Hat, Inc.<BR>
io scheduler noop registered<BR>
io scheduler anticipatory registered (default)<BR>
io scheduler deadline registered<BR>
io scheduler cfq registered<BR>
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing<BR>
disabled<BR>
serial8250.0: ttyS0 at MMIO 0xe0004500 (irq =3D 9) is a 16550A<BR>
serial8250.0: ttyS1 at MMIO 0xe0004600 (irq =3D 10) is a 16550A<BR>
Gianfar MII Bus: probed<BR>
eth0: Gianfar Ethernet Controller Version 1.2, 00:04:9f:ef:23:35<BR>
eth0: Running with NAPI disabled<BR>
eth0: 64/64 RX/TX BD ring size<BR>
Broadcom BCM5241: Registered new driver<BR>
physmap platform flash device: 02000000 at fe000000<BR>
physmap-flash.0: Found 1 x16 devices at 0x0 in 8-bit bank<BR>
&nbsp;Amd/Fujitsu Extended Query Table at 0x0040<BR>
physmap-flash.0: CFI does not contain boot bank location. Assuming =
top.<BR>
number of CFI chips: 1<BR>
cfi_cmdset_0002: Disabling erase-suspend-program due to code =
brokenness.<BR>
cmdlinepart partition parsing not available<BR>
RedBoot partition parsing not available<BR>
Using physmap partition information<BR>
Creating 2 MTD partitions on &quot;physmap-flash.0&quot;:<BR>
0x00000000-0x00100000 : &quot;uboot&quot;<BR>
0x00100000-0x02000000 : &quot;rootfs&quot;<BR>
IPv4 over IPv4 tunneling driver<BR>
GRE over IPv4 tunneling driver<BR>
TCP cubic registered<BR>
NET: Registered protocol family 1<BR>
NET: Registered protocol family 17<BR>
!!!! Gianfar init_phy. phy_id =3D 0:01<BR>
!!!! phy_attach. phy_id =3D 0:01<BR>
!!!! phy_attach device found. phy_id =3D 0:01<BR>
Sending DHCP requests .&lt;3&gt;slab: Internal list corruption detected =
in<BR>
cache 'files_cache'(21), slabp c0344000(16). Hexdump:<BR>
<BR>
000: 00 10 01 00 00 20 02 00 00 00 00 70 c0 34 40 70<BR>
010: 00 00 00 10 00 00 ff 10 00 00 00 00 ff ff ff fe<BR>
020: ff ff ff fe ff ff ff fe ff ff ff fe ff ff ff fe<BR>
030: ff ff ff fe ff ff ff fe ff ff ff fe ff ff ff fe<BR>
040: ff ff ff fe ff ff ff fe ff ff ff fe ff ff ff fe<BR>
050: ff ff ff fe ff ff ff fe ff ff ff fd 00 00 00 11<BR>
060: 00 00 00 12 00 00 00 13 00 00 00 14 ff ff ff ff<BR>
------------[ cut here ]------------<BR>
kernel BUG at mm/slab.c:2936!<BR>
Oops: Exception in kernel mode, sig: 5 [#1]<BR>
NIP: C0050F80 LR: C0050F80 CTR: 00000000<BR>
REGS: c034fe00 TRAP: 0700&nbsp;&nbsp; Not tainted&nbsp; (.6.21.5)<BR>
MSR: 00021032 &lt;ME,IR,DR&gt;&nbsp; CR: 24004002&nbsp; XER: =
00000000<BR>
TASK =3D c032a3c0[3] 'events/0' THREAD: c034e000<BR>
GPR00: C0050F80 C034FEB0 C032A3C0 00000001 00000DF5 FFFFFFFF =
C00F5B54<BR>
00000010<BR>
GPR08: C01D0000 C01E0000 00000DF5 00000DF5 00000000 00F1C5DB =
07FFD000<BR>
FFFFFFFF<BR>
GPR16: 00000001 00000000 00000000 00800000 00000000 007FFF00 =
00000000<BR>
C033DAA0<BR>
GPR24: C0339C90 00000007 00000000 C01B0000 C01B0000 C0344000 =
C033DAA0<BR>
00000070<BR>
NIP [C0050F80] check_slabp+0xe4/0x11c<BR>
LR [C0050F80] check_slabp+0xe4/0x11c<BR>
Call Trace:<BR>
[C034FEB0] [C0050F80] check_slabp+0xe4/0x11c (unreliable)<BR>
[C034FED0] [C0051450] free_block+0x88/0x138<BR>
[C034FF00] [C0052188] drain_array+0xa0/0xe0<BR>
[C034FF20] [C0052228] cache_reap+0x60/0x144<BR>
[C034FF40] [C00257B0] run_workqueue+0xd0/0x170<BR>
[C034FF60] [C0025960] worker_thread+0x110/0x144<BR>
[C034FFC0] [C00298E4] kthread+0x74/0xb0<BR>
[C034FFF0] [C0005F38] kernel_thread+0x44/0x60<BR>
Instruction dump:<BR>
387b6538 7c9df8ae 4bfc2b49 3bff0001 813e0020 5529103a 3929001c =
7f9f4840<BR>
419cffcc 3c60c01b 3863336c 4bfc2b25 &lt;0fe00000&gt; 48000000 =
80030020<BR>
2f800000<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C7C880.AFABB6A0--
