Return-Path: <Rick.Moleres@xilinx.com>
Received: from outbound2-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id DCB50DDDF3
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Feb 2008 13:27:12 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Problems with plb_temac+hard_temac+2.6.24rc3
Date: Wed, 20 Feb 2008 19:26:42 -0700
In-Reply-To: <47BC563D.4040003@gmail.com>
References: <47BC563D.4040003@gmail.com>
From: "Rick Moleres" <Rick.Moleres@xilinx.com>
To: "A. Nolson" <alohanono@gmail.com>,
	<linuxppc-embedded@ozlabs.org>
Message-Id: <20080221022651.1383190008A@mail125-sin.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Try using hard_temac_v3_00_a with the ML403 board.  There's an
incompatibility (posted previously on this list) with PHY access.  This
could be causing the strange behavior you're seeing.

-Rick

-----Original Message-----
From: linuxppc-embedded-bounces+moleres=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+moleres=3Dxilinx.com@ozlabs.org] On
Behalf Of A. Nolson
Sent: Wednesday, February 20, 2008 8:33 AM
To: linuxppc-embedded@ozlabs.org
Subject: Problems with plb_temac+hard_temac+2.6.24rc3

Hi,

 I am working with a ML403 platform and I have my kernel 2.6.24rc3=20
perfectly running on it. Almost everything seems to work but the=20
ethernet. I am using the IP cores that come with the EDK 9.1sp2 (=20
plb_emac 3.00a + hard_temac 3.00b). The weird thing arises when I try to

bring up the interface and use it. If I do "ifconfig eth0 up" the=20
interface shows up but, strangely, it eithers not receives or send=20
packets. I will explain myself, if I assing an IP manually and try to=20
connect to another worksatation within the network ( by pinging from=20
just one of the sides  for example ) the interface seems only to send or

receive packets , but generallty not both at the same time ( I can see=20
this through the evolution of the Rx/Tx bytes in ifconfig). The only few

times that both tx/rx work at the same time is when I do (ifconfig eth0=20
down and ifconfig eth0 up), but this only works sporadically and only =20
for around a second or less.

This is what I get after the first "ifconfig eth0 up":
[  293.258765] eth0: XTemac: Options: 0xb8f2

[  295.253048] eth0: XTemac: speed set to 10Mb/s

[  295.256042] eth0: XTemac: Send Threshold =3D 16, Receive Threshold =
=3D 2

[  295.256095] eth0: XTemac: Send Wait bound =3D 1, Receive Wait bound =
=3D 1

[  297.252047] eth0: XTemac: PHY Link carrier lost.

[  299.251657] eth0: XTemac: PHY Link carrier restored.


and this after some ifconfig up/down:

[  293.258765] eth0: XTemac: Options: 0xb8f2

[  295.253048] eth0: XTemac: speed set to 10Mb/s

[  295.256042] eth0: XTemac: Send Threshold =3D 16, Receive Threshold =
=3D 2

[  295.256095] eth0: XTemac: Send Wait bound =3D 1, Receive Wait bound =
=3D 1

[  297.252047] eth0: XTemac: PHY Link carrier lost.

[  299.251657] eth0: XTemac: PHY Link carrier restored.

[  438.159833] eth0: XTemac: Options: 0xb8f2

[  440.154122] eth0: XTemac: speed set to 1000Mb/s

[  440.157316] eth0: XTemac: Send Threshold =3D 16, Receive Threshold =
=3D 2

[  440.157369] eth0: XTemac: Send Wait bound =3D 1, Receive Wait bound =
=3D 1

[  442.153739] eth0: XTemac: PHY Link carrier lost.

[  511.255518] eth0: XTemac: Options: 0xb8f2

[  513.249808] eth0: XTemac: speed set to 10Mb/s

[  513.252729] eth0: XTemac: Send Threshold =3D 16, Receive Threshold =
=3D 2

[  513.252784] eth0: XTemac: Send Wait bound =3D 1, Receive Wait bound =
=3D 1

[  515.249462] eth0: XTemac: PHY Link carrier restored.

[  992.441619] eth0: XTemac: Options: 0xb8f2

[  994.435904] eth0: XTemac: speed set to 1000Mb/s

[  994.438786] eth0: XTemac: Send Threshold =3D 16, Receive Threshold =
=3D 2

[  994.438839] eth0: XTemac: Send Wait bound =3D 1, Receive Wait bound =
=3D 1

[  996.435460] eth0: XTemac: PHY Link carrier lost.

[ 1099.850622] eth0: XTemac: Options: 0xb8f2

[ 1101.844907] eth0: XTemac: speed set to 10Mb/s

[ 1101.847816] eth0: XTemac: Send Threshold =3D 16, Receive Threshold =
=3D 2

[ 1101.847868] eth0: XTemac: Send Wait bound =3D 1, Receive Wait bound =
=3D 1

[ 1103.844479] eth0: XTemac: PHY Link carrier restored.

[ 1180.024979] eth0: XTemac: Options: 0xb8f2

[ 1182.019263] eth0: XTemac: speed set to 1000Mb/s

[ 1182.022265] eth0: XTemac: Send Threshold =3D 16, Receive Threshold =
=3D 2

[ 1182.022316] eth0: XTemac: Send Wait bound =3D 1, Receive Wait bound =
=3D 1

[ 1184.018815] eth0: XTemac: PHY Link carrier lost.


It also seems to negotiate wrongly the speed since my network is
100Mb/s.

This is my dmesg before "ifconfig eth0 up":

[    0.000000] Linux version 2.6.24-rc3-gd7ed933b-dirty (ios@xxx) (gcc=20
versio
ion 4.0.0 (DENX ELDK 4.1 4.0.0)) #17 Mon Feb 18 11:52:47 CET=20
2008               [
[    0.000000] Xilinx ML403 Reference System (Virtex-4=20
FX)                      [
[    0.000000] Entering add_active_range(0, 0, 16384) 0 entries of 256=20
used     [
[    0.000000] Zone PFN=20
ranges:                                                 [
[    0.000000]   DMA             0 ->   =20
16384                                  [
[    0.000000]   Normal      16384 ->   =20
16384                                  [
[    0.000000]   HighMem     16384 ->   =20
16384                                  [
[    0.000000] Movable zone start PFN for each=20
node                             [
[    0.000000] early_node_map[1] active PFN=20
ranges                              [
[    0.000000]     0:        0 ->   =20
16384                                      [
[    0.000000] On node 0 totalpages:=20
16384                                      [
[    0.000000]   DMA zone: 128 pages used for=20
memmap                            [
[    0.000000]   DMA zone: 0 pages=20
reserved                                     [
[    0.000000]   DMA zone: 16256 pages, LIFO=20
batch:3                            [
[    0.000000]   Normal zone: 0 pages used for=20
memmap                           [
[    0.000000]   HighMem zone: 0 pages used for=20
memmap                          [
[    0.000000]   Movable zone: 0 pages used for=20
memmap                          [
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on. =20
Total pages
es:=20
16256

[
[    0.000000] Kernel command line: console=3DttyS0,57600 =
root=3D/dev/xsa2=20
rw init=3D/sb
sbin/init

[
[    0.000000] Xilinx INTC #0 at 0x41200000 mapped to=20
0xFDFFE000                [
[    0.000000] PID hash table entries: 256 (order: 8, 1024=20
bytes)               [
[    0.000189] Console: colour dummy device=20
80x25                               [
[    0.000632] Dentry cache hash table entries: 8192 (order: 3, 32768=20
bytes)    [
[    0.001411] Inode-cache hash table entries: 4096 (order: 2, 16384=20
bytes)     [
[    0.015628] Memory: 61312k available (2744k kernel code, 780k data,=20
116k init,
, 0k=20
highmem)

[
[    0.015942] SLUB: Genslabs=3D11, HWalign=3D32, Order=3D0-1, =
MinObjects=3D4,=20
CPUs=3D1, Nod
odes=3D1

[
[    0.015988] Calibrating delay loop... 199.47 BogoMIPS=20
(lpj=3D997376)           [
[    0.210274] Mount-cache hash table entries:=20
512                              [
[    0.214569] net_namespace: 64=20
bytes                                          [
[    0.220610] NET: Registered protocol family=20
16                               [
[    0.268325] NET: Registered protocol family=20
2                                [
[    0.350699] IP route cache hash table entries: 1024 (order: 0, 4096=20
bytes)   [
[    0.353529] TCP established hash table entries: 2048 (order: 2, 16384

bytes) [
[    0.353862] TCP bind hash table entries: 2048 (order: 1, 8192=20
bytes)         [
[    0.354067] TCP: Hash tables configured (established 2048 bind=20
2048)         [
[    0.354107] TCP reno=20
registered                                              [
[    0.381445] sysctl table check failed: /kernel/l2cr .1.31 Missing=20
strategy   [
[    0.381529] Call=20
Trace:                                                      [
[    0.381556] [c3c11e80] [c0008380] show_stack+0x4c/0x174=20
(unreliable)         [
[    0.381653] [c3c11eb0] [c0037170]=20
set_fail+0x50/0x68                         [
[    0.381735] [c3c11ed0] [c00377f8]=20
sysctl_check_table+0x670/0x6bc             [
[    0.381804] [c3c11f10] [c003780c]=20
sysctl_check_table+0x684/0x6bc             [
[    0.381871] [c3c11f50] [c0024e7c]=20
register_sysctl_table+0x5c/0xac            [
[    0.381953] [c3c11f70] [c034ab68]=20
register_ppc_htab_sysctl+0x18/0x2c         [
[    0.382040] [c3c11f80] [c034484c]=20
kernel_init+0xc8/0x284                     [
[    0.382103] [c3c11ff0] [c0004b18]=20
kernel_thread+0x44/0x60                    [
[    0.442249] Installing knfsd (copyright (C) 1996=20
okir@monad.swb.de).         [
[    0.447391] JFS: nTxBlock =3D 479, nTxLock =3D=20
3832                              [
[    0.450534] SGI XFS with ACLs, large block numbers, no debug=20
enabled         [
[    0.466636] io scheduler noop=20
registered                                     [
[    0.466687] io scheduler anticipatory=20
registered                             [
[    0.466722] io scheduler deadline=20
registered                                 [
[    0.467224] io scheduler cfq registered=20
(default)                            [
[    1.069672] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ=20
sharing di
disabled

[
[    1.078357] serial8250.0: ttyS0 at MMIO 0x40401003 (irq =3D 3) is a=20
16550A     [
[    1.078443] console [ttyS0]=20
enabled                                          [
[    1.621990] RAMDISK driver initialized: 16 RAM disks of 4096K size=20
1024 blocksi
size

[
[    1.644429] loop: module=20
loaded                                              [
[    1.651930] xsysace xsysace.0: Xilinx SystemACE revision=20
1.0.12              [
[    1.664582] xsysace xsysace.0: capacity: 1019088=20
sectors                     [
[    1.675836]  xsa: xsa1 xsa2=20
xsa3                                             [
[    1.688906] Xilinx SystemACE device driver,=20
major=3D254                        [
[    1.700197] nbd: registered device at major=20
43                               [
[    1.728380] XTemac: using sgDMA=20
mode.                                        [
[    1.735840] XTemac: using TxDRE=20
mode                                         [
[    1.743198] XTemac: using RxDRE=20
mode                                         [
[    1.750455] XTemac: buffer descriptor size: 32768=20
(0x8000)                   [
[    1.762007] XTemac: (buffer_descriptor_init) phy: 0x3d98000, virt:=20
0xff100000,
, size:=20
0x8000
[
[    1.785641] eth%d: XTemac: No PHY detected.  Assuming a PHY at=20
address 0     [
[    1.799277] eth0: Dropping NETIF_F_SG since no checksum=20
feature.             [
[    1.814696] eth0: Xilinx TEMAC #0 at 0x81200000 mapped to 0xC5060000,

irq=3D0  [
[    1.828792] eth0: XTemac id 1.0f, block id 5, type=20
8                         [
[    1.840200] NFTL driver: nftlcore.c $Revision: 1.98 $, nftlmount.c=20
$Revision: 1
 1.41=20
$
[
[    1.856295] INFTL: inftlcore.c $Revision: 1.19 $, inftlmount.c=20
$Revision: 1.18
8=20
$

[
[    1.872015] SSFDC read-only Flash Translation=20
layer                          [
[    1.885404] i8042.c: No controller=20
found.                                    [
[    1.895700] mice: PS/2 mouse device common for all=20
mice                      [
[    1.908819] i2c /dev entries=20
driver                                          [
[    1.917372] TCP cubic=20
registered                                             [
[    1.924238] NET: Registered protocol family=20
1                                [
[    1.933271] NET: Registered protocol family=20
17                               [
[    1.944649] RPC: Registered udp transport=20
module.                            [
[    1.954206] RPC: Registered tcp transport=20
module.                            [
[    4.575003] kjournald starting.  Commit interval 5=20
seconds                   [
[    4.586220] EXT3-fs warning: maximal mount count reached, running=20
e2fsck is rec
ecommended

[
[    4.641727] EXT3 FS on xsa2, internal=20
journal                                [
[    4.650587] EXT3-fs: recovery=20
complete.                                      [
[    4.697624] EXT3-fs: mounted filesystem with ordered data=20
mode.              [
[    4.709702] VFS: Mounted root (ext3=20
filesystem).                             [
[    4.719390] Freeing unused kernel memory: 116k=20
init                         =20
ba                                                             =20

Any idea of what it can be?

Thanks in advance!

/A
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
