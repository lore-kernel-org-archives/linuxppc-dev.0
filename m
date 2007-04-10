Return-Path: <Leonid@a-k-a.net>
Received: from mis011-1.exch011.intermedia.net
	(mis011-1.exch011.intermedia.net [64.78.21.128])
	by ozlabs.org (Postfix) with ESMTP id CC792DDE25
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Apr 2007 15:57:12 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Linux w/ML403 PLB TEMAC
Date: Mon, 9 Apr 2007 22:57:11 -0700
Message-ID: <406A31B117F2734987636D6CCC93EE3CB05957@ehost011-3.exch011.intermedia.net>
In-Reply-To: <514df87a.324e3d40.461a6b58.edd0@o2.pl>
References: <514df87a.324e3d40.461a6b58.edd0@o2.pl>
From: "Leonid" <Leonid@a-k-a.net>
To: "Jarek" <spyrek3@o2.pl>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Sorry, I cannot tell. I didn't experience your problem, but then I don't
run ML403 precisely, my board is different. I had problem with MDIO, but
it appeared it just wasn't connected in our design.

Leonid.

-----Original Message-----
From: linuxppc-embedded-bounces+leonid=3Da-k-a.net@ozlabs.org
[mailto:linuxppc-embedded-bounces+leonid=3Da-k-a.net@ozlabs.org] On =
Behalf
Of Jarek
Sent: Monday, April 09, 2007 9:36 AM
To: linuxppc-embedded@ozlabs.org
Subject: RE: Linux w/ML403 PLB TEMAC

Hello folks,

I have been working for a while on bringing up PLB Temac on ml403. I
have followed all steps presented by Glenn, but unfortunately I have
stacked in one place. I hope that maybe one of you due to your experince
can give me some advice. I use systemace for mounting rfs and I have
patched my kernel with Paulus Temac patches. Kernel compiles without any
problem. As i said i followed Glenn's steps for configuring kernel with
plb/temac. The only difference I have noticed is that I use root file
system on a flash card. After booting the kernel from flash card I got
the following output:

loaded at:     00400000 0052013C
board data at: 0051E124 0051E13C
relocated to:  004040B8 004040D0
zimage at:     00404E45 0051DFC1
avail ram:     00521000 04000000

Linux/PPC load: console=3DttyS0,9600 root=3D/dev/xsa3 rw =
init=3D/sbin/init
Uncompressing Linux...done.
Now booting the kernel
[    0.000000] Linux version 2.6.20 (butanowi@amandla) (gcc version
4.0.2) #3 Mon Apr 9 16:44:13 CEST 2007
[    0.000000] Xilinx ML403 Reference System (Virtex-4 FX)
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->    16384
[    0.000000]   Normal      16384 ->    16384
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->    16384
[    0.000000] Built 1 zonelists.  Total pages: 16256
[    0.000000] Kernel command line: console=3DttyS0,9600 =
root=3D/dev/xsa3 rw
init=3D/sbin/init
[    0.000000] Xilinx INTC #0 at 0x41200000 mapped to 0xFDFFE000
[    0.000000] PID hash table entries: 256 (order: 8, 1024 bytes)
[    0.000430] Console: colour dummy device 80x25
[    0.001581] Dentry cache hash table entries: 8192 (order: 3, 32768
bytes)
[    0.003395] Inode-cache hash table entries: 4096 (order: 2, 16384
bytes)
[    0.036070] Memory: 62476k available (1840k kernel code, 488k data,
96k init, 0k highmem)
[    0.221232] Mount-cache hash table entries: 512
[    0.232180] NET: Registered protocol family 16
[    0.269606] NET: Registered protocol family 2
[    0.361155] IP route cache hash table entries: 1024 (order: 0, 4096
bytes)
[    0.363365] TCP established hash table entries: 2048 (order: 1, 8192
bytes)
[    0.363868] TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
[    0.364143] TCP: Hash tables configured (established 2048 bind 1024)
[    0.364229] TCP reno registered
[    0.401242] JFS: nTxBlock =3D 488, nTxLock =3D 3908
[    0.408340] SGI XFS with no debug enabled
[    0.411933] io scheduler noop registered
[    0.412037] io scheduler deadline registered (default)
[    0.517700] Serial: 8250/16550 driver $Revision: 1.90 $ 1 ports, IRQ
sharing disabled
[    0.524846] serial8250.0: ttyS0 at MMIO 0x40401003 (irq =3D 2) is a
16550A
[    2.444102] RAMDISK driver initialized: 1 RAM disks of 4096K size
1024 blocksize
[    2.536064]  xsa: xsa1 xsa2 xsa3
[    2.602624] XTemac: using sgDMA mode.
[    2.646747] XTemac: not using TxDRE mode
[    2.694037] XTemac: using RxDRE mode
[    2.737007] XTemac: buffer descriptor size: 32768 (0x8000)
[    2.804113] XTemac: (buffer_descriptor_init) phy: 0x3c00000, virt:
0xff100000, size: 0x8000
[    3.004280] XTemac: Could not alloc TX buffer 168 (9032 bytes).
Cleaning up.
[    3.093984] XTemac: Could not allocate TX buffers.
[    3.156274] xilinx_temac: probe of xilinx_temac.0 failed with error
-5
[    3.236276] mice: PS/2 mouse device common for all mice
[    3.299587] TCP cubic registered
[    3.338772] NET: Registered protocol family 1
[    3.391288] NET: Registered protocol family 17
[    3.495078] EXT2-fs warning: mounting unchecked fs, running e2fsck is
recommended
[    3.586449] VFS: Mounted root (ext2 filesystem).
[    3.642764] Freeing unused kernel memory: 96k init
serial console detected.  Disabling virtual terminals.
init started:  BusyBox v0.60.2 (2004.04.30-17:49+0000) multi-call binary

I have a problem with TxDRE: XTemac: not using TxDRE mode
[    3.004280] XTemac: Could not alloc TX buffer 168 (9032 bytes).
Cleaning up.
[    3.093984] XTemac: Could not allocate TX buffers.

Is it a problem related to my hardware design??=20
Looking for a help:-( or hint. I do not know what is the problem related
to.

Regards
Jaroslaw Butanowicz




> I have just learnt that MDIO lines are not connected in our design...
that explains everything... thanks a lot.
>=20
> Leonid.
>=20
> -----Original Message-----
> From: Rick Moleres [mailto:Rick.Moleres@xilinx.com]=20
> Sent: Wednesday, April 04, 2007 5:00 PM
> To: Leonid; linuxppc-embedded@ozlabs.org
> Subject: RE: Linux w/ML403 PLB TEMAC
>=20
>=20
> Leonid,
>=20
> If it's not the ML403 board and the FX part is CES4 or later (read
this at the bottom of the FX chip), then you will need
hard_temac_v3_00_b to get the MDIO access working properly.
>=20
> If this is pre-CES4 silicon, then hard_temac_v3_00_a is the right
version and there may be an issue with the MDIO signal connectivity in
your design (? just guessing).  You can also try to hardcode the PHY
address (gmii_addr) and see if the speed detection works at that point -
but my guess is it won't.
>=20
> -Rick
>=20
> -----Original Message-----
> From: Leonid [mailto:Leonid@a-k-a.net]=20
> Sent: Wednesday, April 04, 2007 5:50 PM
> To: Rick Moleres; linuxppc-embedded@ozlabs.org
> Subject: RE: Linux w/ML403 PLB TEMAC
>=20
> Hi, Rick:
>=20
> We have both in our design and both are 3.00a. I'm not sure why - I'll
ask our HW folks.=20
>=20
> I have actually managed (just 30 minutes ago) to bring up network
interface but I have commented out all accesses to PHY in your adapter.c
and I set speed to 1000 always (see my adapter.c attached). Without
these changes packets are not transmitted out of board.
>=20
> This is probably some issue in my EDK project.
>=20
> I'm not using ML403 actually but another proprietary board, based on
Virtex
> 4 (69FX) FPGA.
>=20
> Thanks,
>=20
> Leonid.
>=20
> -----Original Message-----
> From: Rick Moleres [mailto:Rick.Moleres@xilinx.com]=20
> Sent: Wednesday, April 04, 2007 4:41 PM
> To: Leonid; Glenn.G.Hart@us.westinghouse.com;
linuxppc-embedded@ozlabs.org
> Subject: RE: Linux w/ML403 PLB TEMAC
>=20
> Leonid,
>=20
> You mentioned that the TEMAC version if v3.00a.  Is this the plb_temac
version or the hard_temac version, or both?
>=20
> -Rick
>=20
> -----Original Message-----
> From: linuxppc-embedded-bounces+moleres=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+moleres=3Dxilinx.com@ozlabs.org] On
Behalf Of Leonid
> Sent: Wednesday, April 04, 2007 4:14 PM
> To: Glenn.G.Hart@us.westinghouse.com; linuxppc-embedded@ozlabs.org
> Subject: RE: Linux w/ML403 PLB TEMAC
>=20
> I have investigated little bit more. Receive is working actually, but
transmit doesn't. What can it be?
>=20
> -----Original Message-----
> From: linuxppc-embedded-bounces+leonid=3Da-k-a.net@ozlabs.org
[mailto:linuxppc-embedded-bounces+leonid=3Da-k-a.net@ozlabs.org] On =
Behalf
Of Leonid
> Sent: Wednesday, April 04, 2007 12:06 PM
> To: Glenn.G.Hart@us.westinghouse.com; linuxppc-embedded@ozlabs.org
> Subject: RE: Linux w/ML403 PLB TEMAC
>=20
> I have precisely the same problem you have described:
>=20
> [    0.430515] XTemac: using FIFO direct interrupt driven mode.
> [    0.437461] eth%d: XTemac: No PHY detected.  Assuming a PHY at
address 0
> [    0.445295] eth0: Xilinx TEMAC #0 at 0x02000000 mapped to
0xC3000000, irq=3D0
> [    0.452256] eth0: XTemac id 1.0f, block id 5, type 8
> [    0.458665] tun: Universal TUN/TAP device driver, 1.6
> [    0.463712] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
> [    0.471106] mice: PS/2 mouse device common for all mice
> [    0.476339] TCP cubic registered
> [    0.479615] NET: Registered protocol family 1
> [    0.484032] NET: Registered protocol family 17
> [    0.992599] eth0: XTemac: Options: 0xb8f2
> [   12.955691] eth0: XTemac: Not able to set the speed to 1000
(status: 0x0)
> [   22.928615] eth0: XTemac: Not able to set the speed to 100 (status:
0x0)
> [   32.901449] eth0: XTemac: Not able to set the speed to 10 (status:
0x0)
> [   32.907976] eth0: XTemac: could not negotiate speed
> [   33.921626] IP-Config: Complete:
> [   33.924635]       device=3Deth0, addr=3D192.168.0.223,
mask=3D255.255.255.0, gw=3D192.168.0.1,
> [   33.932418]      host=3DLM200, domain=3D, nis-domain=3D(none),
> [   33.937715]      bootserver=3D192.168.0.141,
rootserver=3D192.168.0.141, rootpath=3D
> [   33.946230] Looking up port of RPC 100003/2 on 192.168.0.141
> [   34.916694] eth0: XTemac: PHY Link carrier lost.
>=20
> My TEMAC core version is 3.00.a and low level code I'm using is
working in u-boot wi
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
