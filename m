Return-Path: <lagrange@fr.oleane.com>
Received: from relay01s.clb.oleane.net (relay01s.clb.oleane.net
	[213.56.31.142]) by ozlabs.org (Postfix) with ESMTP id 601E42BDA6
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Oct 2004 03:19:28 +1000 (EST)
Received: from smtp8.clb.oleane.net (smtp8.clb.oleane.net [213.56.31.28])
	by relay01s.clb.oleane.net with ESMTP id i9DHJMML025794
	for <linuxppc-embedded@ozlabs.org>; Wed, 13 Oct 2004 19:19:22 +0200
Received: from GEG2400 ([62.160.30.216]) (authenticated)
	by smtp8.clb.oleane.net with ESMTP id i9DH5hla002932
	for <linuxppc-embedded@ozlabs.org>; Wed, 13 Oct 2004 19:05:46 +0200
From: "Laurent Lagrange" <lagrange@fr.oleane.com>
To: <linuxppc-embedded@ozlabs.org>
Date: Wed, 13 Oct 2004 19:07:38 +0200
Message-ID: <000301c4b147$24be4460$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0004_01C4B157.E8471460"
Subject: MPC8560 problem to launch user application like /sbin/init
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

------=_NextPart_000_0004_01C4B157.E8471460
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hi,

I port a Linux 2.4.25 kernel on a MPC8560 custom board.
I don't use uboot but a custom boot on the board.

The console is mapped on SCC1 port.
CCSRBAR is mapped at 0xF8000000 and immr at 0xF8080000.

I open 2 TLBs on memory and a big TLB for all IOs included CSSRBAR.
Due to IO TLB, I don't io_remap cpm2_immr.

All things run fine until I launch the /sbin/init file from a nfs networK.
The file is right downloaded but seems not to run.
But the board is alived because I can press keys on console and receive
the echo and I can ping the board. It works.

I tried to use other files like /bin/sh, other busybox version, ...

The NFS file system seems to be right and well tested on a 8260 board
ie : the file system is 60x compiled without any special options for E500
core.

I also replaced the nfs by a ramdisk. Same results.

I don't know if uboot sets other things than TLBs to access IOs
and if my own boot is incomplete.
I don't know if cpm must be io_remapped instead of using TLBs.

Any ideas would be welcome.
Thanks

Laurent




loaded at:     00800000 0088C2A4
board data at: 00889130 00889194
relocated to:  0080530C 00805370
zimage at:     00805878 008882AF
avail ram:     0088D000 08000000

Linux/PPC load: devfs=mount ip=bootp root=/dev/nfs rw console=ttyS0,9600
Uncompressing Linux...done.
Now booting the kernel
Memory CAM mapping: CAM0=64Mb, CAM1=64Mb, CAM2=0Mb residual: 0Mb
motobooke_mmu.c110 index=0 virt=c0000000 phys=00000000 size=04000000
flags=82f pid=0
motobooke_mmu.c110 index=1 virt=c4000000 phys=04000000 size=04000000
flags=82f pid=0
motobooke_mmu.c110 index=2 virt=f0000000 phys=f0000000 size=10000000
flags=aaf pid=0
Linux version 2.4.25 (version gcc 3.2.3) #8 mer oct 13 17:30:00 CEST 2004
CPM_MAP_ADDR=F8080000
cpm2_immr=F8080000
On node 0 totalpages: 32768
zone(0): 32768 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: devfs=mount ip=bootp root=/dev/nfs rw
console=ttyS0,9600
OpenPIC Version 1.2 (1 CPUs and 44 IRQ sources) at f8040000
OpenPIC timer frequency is 33.333333 MHz
time_init: decrementer frequency = 33.333333 MHz
Calibrating delay loop... 665.19 BogoMIPS
Memory: 128248k available (924k kernel code, 292k data, 52k init, 0k
highmem)
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
CPM UART driver version 0.01
ttyS0 on SCC1 at 0x8000, BRG1
pty: 256 Unix98 ptys configured
loop: loaded (max 8 devices)
eth0: Gianfar Ethernet Controller Version 1.0, 00:10:cd:42:2e:08
eth0: Running with NAPI disabled
eth0: 64/64 RX/TX BD ring size
eth1: Gianfar Ethernet Controller Version 1.0, 00:10:cd:42:2e:09
eth1: Running with NAPI disabled
eth1: 64/64 RX/TX BD ring size
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 16384)
eth0: PHY is Marvell 88E1111S (1410cc1)
eth0: Auto-negotiation done
eth0: Full Duplex
eth0: Speed 100BT
eth0: Link is up
eth1: PHY is Marvell 88E1111S (1410cc1)
eth1: No link detected
Sending BOOTP requests . OK
IP-Config: Got BOOTP answer from 192.168.1.65, my address is 192.168.1.98
IP-Config: Complete:
      device=eth0, addr=192.168.1.98, mask=255.255.255.0,
gw=255.255.255.255,
     host=192.168.1.98, domain=, nis-domain=(none),
     bootserver=192.168.1.65, rootserver=192.168.1.65,
rootpath=/home/target/
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 192.168.1.65
Looking up port of RPC 100005/1 on 192.168.1.65
VFS: Mounted root (nfs filesystem).
Mounted devfs on /dev
Freeing unused kernel memory: 52k init
process.c619 sys_execve out error=0 filename=/sbin/init

                         free                        sibling
  task             PC    stack   pid father child younger older
init          R current      0     1      0     7               (NOTLB)
[c0004510] [c000bf8c] [c0021650] [c002b51c] [c0169714] [c001e12c] [c001e2a8]
[c0
009ce0] [c02c9c30] [00000001]
keventd       S 00000000     0     2      1             3       (L-TLB)
[c0004510] [c000bf8c] [c001c7b0] [c00042b8]
ksoftirqd_CPU S 00000000     0     3      1             4     2 (L-TLB)
[c0004510] [c000bf8c] [c0015324] [c00042b8]
kswapd        S 00000000     0     4      1             5     3 (L-TLB)
[c0004510] [c000bf8c] [c002a044] [c00042b8]
bdflush       S 00000000     0     5      1             6     4 (L-TLB)
[c0004510] [c000bf8c] [c000c61c] [c0037550] [c00042b8]
kupdated      R 00000000     0     6      1             7     5 (L-TLB)
[c0004510] [c000bf8c] [c000bcd4] [c0037644] [c00042b8]
rpciod        S 00000000     0     7      1                   6 (L-TLB)
[c0004510] [c000bf8c] [c00de400] [c00042b8]


??? nothing more ???

------=_NextPart_000_0004_01C4B157.E8471460
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<TITLE></TITLE>

<META content=3D"MSHTML 6.00.2800.1226" name=3DGENERATOR></HEAD>
<BODY>
<P><FONT face=3DArial><FONT size=3D2>Hi,<BR><BR>I port a Linux 2.4.25 =
kernel on a=20
MPC8560 custom board.<BR>I don't use uboot but a custom boot on the=20
board.<BR><BR>The console is mapped on SCC1 port.<BR>CCSRBAR is mapped =
at=20
0xF8000000 and immr at 0xF8080000.<BR><BR>I open 2 TLBs on memory and a =
big TLB=20
for all IOs included CSSRBAR.<BR>Due to IO TLB, I don't io_remap=20
cpm2_immr.<BR><BR>All things run fine until I launch the /sbin/init file =
from a=20
nfs networK.<BR>The file is right downloaded but seems not to =
run.<BR>But the=20
board is alived because I can press keys on console and receive<BR>the =
echo and=20
I can ping the board. It works.<BR><BR>I tried to use other files like =
/bin/sh,=20
other busybox version, ...<BR><BR>The NFS file system seems to be right =
and well=20
tested on a 8260 board<BR>ie : the file system is 60x compiled without =
any=20
special options for E500 core.<BR><BR>I also replaced the nfs by a =
ramdisk. Same=20
results.<BR><BR>I don't know if uboot sets other things than TLBs to =
access=20
IOs<BR>and if my own boot is incomplete.<BR>I don't know if cpm must be=20
io_remapped instead of using TLBs.<BR><BR>Any ideas would be=20
welcome.<BR>Thanks<BR><BR>Laurent<BR><BR><BR><BR><BR>loaded=20
at:&nbsp;&nbsp;&nbsp;&nbsp; 00800000 0088C2A4<BR>board data at: 00889130 =

00889194<BR>relocated to:&nbsp; 0080530C 00805370<BR>zimage=20
at:&nbsp;&nbsp;&nbsp;&nbsp; 00805878 008882AF<BR>avail=20
ram:&nbsp;&nbsp;&nbsp;&nbsp; 0088D000 08000000<BR><BR>Linux/PPC load:=20
devfs=3Dmount ip=3Dbootp root=3D/dev/nfs rw =
console=3DttyS0,9600<BR>Uncompressing=20
Linux...done.<BR>Now booting the kernel<BR>Memory CAM mapping: =
CAM0=3D64Mb,=20
CAM1=3D64Mb, CAM2=3D0Mb residual: 0Mb<BR>motobooke_mmu.c110 index=3D0 =
virt=3Dc0000000=20
phys=3D00000000 size=3D04000000 flags=3D82f =
pid=3D0<BR>motobooke_mmu.c110 index=3D1=20
virt=3Dc4000000 phys=3D04000000 size=3D04000000 flags=3D82f =
pid=3D0<BR>motobooke_mmu.c110=20
index=3D2 virt=3Df0000000 phys=3Df0000000 size=3D10000000 flags=3Daaf =
pid=3D0<BR>Linux=20
version 2.4.25 (version gcc 3.2.3) #8 mer oct 13 17:30:00 CEST=20
2004<BR>CPM_MAP_ADDR=3DF8080000<BR>cpm2_immr=3DF8080000<BR>On node 0 =
totalpages:=20
32768<BR>zone(0): 32768 pages.<BR>zone(1): 0 pages.<BR>zone(2): 0=20
pages.<BR>Kernel command line: devfs=3Dmount ip=3Dbootp root=3D/dev/nfs =
rw=20
console=3DttyS0,9600<BR>OpenPIC Version 1.2 (1 CPUs and 44 IRQ sources) =
at=20
f8040000<BR>OpenPIC timer frequency is 33.333333 MHz<BR>time_init: =
decrementer=20
frequency =3D 33.333333 MHz<BR>Calibrating delay loop... 665.19=20
BogoMIPS<BR>Memory: 128248k available (924k kernel code, 292k data, 52k =
init, 0k=20
highmem)<BR>Dentry cache hash table entries: 16384 (order: 5, 131072=20
bytes)<BR>Inode cache hash table entries: 8192 (order: 4, 65536 =
bytes)<BR>Mount=20
cache hash table entries: 512 (order: 0, 4096 bytes)<BR>Buffer cache =
hash table=20
entries: 8192 (order: 3, 32768 bytes)<BR>Page-cache hash table entries: =
32768=20
(order: 5, 131072 bytes)<BR>POSIX conformance testing by UNIFIX<BR>Linux =
NET4.0=20
for Linux 2.4<BR>Based upon Swansea University Computer Society=20
NET3.039<BR>Initializing RT netlink socket<BR>Starting kswapd<BR>devfs: =
v1.12c=20
(20020818) Richard Gooch (rgooch@atnf.csiro.au)<BR>devfs: boot_options:=20
0x1<BR>CPM UART driver version 0.01<BR>ttyS0 on SCC1 at 0x8000, =
BRG1<BR>pty: 256=20
Unix98 ptys configured<BR>loop: loaded (max 8 devices)<BR>eth0: Gianfar =
Ethernet=20
Controller Version 1.0, 00:10:cd:42:2e:08<BR>eth0: Running with NAPI=20
disabled<BR>eth0: 64/64 RX/TX BD ring size<BR>eth1: Gianfar Ethernet =
Controller=20
Version 1.0, 00:10:cd:42:2e:09<BR>eth1: Running with NAPI =
disabled<BR>eth1:=20
64/64 RX/TX BD ring size<BR>NET4: Linux TCP/IP 1.0 for NET4.0<BR>IP =
Protocols:=20
ICMP, UDP, TCP<BR>IP: routing cache hash table of 1024 buckets, =
8Kbytes<BR>TCP:=20
Hash tables configured (established 8192 bind 16384)<BR>eth0: PHY is =
Marvell=20
88E1111S (1410cc1)<BR>eth0: Auto-negotiation done<BR>eth0: Full =
Duplex<BR>eth0:=20
Speed 100BT<BR>eth0: Link is up<BR>eth1: PHY is Marvell 88E1111S=20
(1410cc1)<BR>eth1: No link detected<BR>Sending BOOTP requests . =
OK<BR>IP-Config:=20
Got BOOTP answer from 192.168.1.65, my address is =
192.168.1.98<BR>IP-Config:=20
Complete:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device=3Deth0, =
addr=3D192.168.1.98,=20
mask=3D255.255.255.0, gw=3D255.255.255.255,<BR>&nbsp;&nbsp;&nbsp;&nbsp;=20
host=3D192.168.1.98, domain=3D, =
nis-domain=3D(none),<BR>&nbsp;&nbsp;&nbsp;&nbsp;=20
bootserver=3D192.168.1.65, rootserver=3D192.168.1.65,=20
rootpath=3D/home/target/<BR>NET4: Unix domain sockets 1.0/SMP for Linux=20
NET4.0.<BR>Looking up port of RPC 100003/2 on 192.168.1.65<BR>Looking up =
port of=20
RPC 100005/1 on 192.168.1.65<BR>VFS: Mounted root (nfs =
filesystem).<BR>Mounted=20
devfs on /dev<BR>Freeing unused kernel memory: 52k init<BR>process.c619=20
sys_execve out error=3D0=20
filename=3D/sbin/init<BR><BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;=20
free&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
sibling<BR>&nbsp;=20
task&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;=20
PC&nbsp;&nbsp;&nbsp; stack&nbsp;&nbsp; pid father child younger=20
older<BR>init&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; R=20
current&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;=20
1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;=20
7&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;=20
(NOTLB)<BR>[c0004510] [c000bf8c] [c0021650] [c002b51c] [c0169714] =
[c001e12c]=20
[c001e2a8] [c0<BR>009ce0] [c02c9c30]=20
[00000001]<BR>keventd&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S=20
00000000&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;=20
2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
=20
3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (L-TLB)<BR>[c0004510] [c000bf8c]=20
[c001c7b0] [c00042b8]<BR>ksoftirqd_CPU S =
00000000&nbsp;&nbsp;&nbsp;&nbsp;=20
0&nbsp;&nbsp;&nbsp;&nbsp; 3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
=20
4&nbsp;&nbsp;&nbsp;&nbsp; 2 (L-TLB)<BR>[c0004510] [c000bf8c] [c0015324]=20
[c00042b8]<BR>kswapd&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S=20
00000000&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;=20
4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
=20
5&nbsp;&nbsp;&nbsp;&nbsp; 3 (L-TLB)<BR>[c0004510] [c000bf8c] [c002a044]=20
[c00042b8]<BR>bdflush&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S=20
00000000&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;=20
5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
=20
6&nbsp;&nbsp;&nbsp;&nbsp; 4 (L-TLB)<BR>[c0004510] [c000bf8c] [c000c61c]=20
[c0037550] [c00042b8]<BR>kupdated&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; R=20
00000000&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;=20
6&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
=20
7&nbsp;&nbsp;&nbsp;&nbsp; 5 (L-TLB)<BR>[c0004510] [c000bf8c] [c000bcd4]=20
[c0037644] =
[c00042b8]<BR>rpciod&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S=20
00000000&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;=20
7&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
6 (L-TLB)<BR>[c0004510] [c000bf8c] [c00de400] [c00042b8]<BR><BR><BR>??? =
nothing=20
more ???</FONT> </FONT></P></BODY></HTML>

------=_NextPart_000_0004_01C4B157.E8471460--
