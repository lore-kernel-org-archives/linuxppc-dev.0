Return-Path: <John.Linn@xilinx.com>
Received: from outbound1-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id ED5E2DDF41
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 Apr 2008 03:53:42 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Subject: RE: xilinx Ml405 NFS mount problem
Date: Tue, 1 Apr 2008 10:53:26 -0600
In-Reply-To: <1207068618.4830.60.camel@PisteOff>
References: <BAY138-W7044A57F2CF37F5DB50F6B2F50@phx.gbl>
	<20080401142910.5BFD038005F@mail141-dub.bigfish.com>
	<BAY138-W40E4E945BA6E40EABEE811B2F50@phx.gbl>
	<1207068618.4830.60.camel@PisteOff>
From: "John Linn" <John.Linn@xilinx.com>
To: "Robert Woodworth" <rwoodworth@securics.com>,
	"MingLiu" <eemingliu@hotmail.com>
Message-Id: <20080401165329.D31E3AA008E@mail29-dub.bigfish.com>
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

Now that you say that, I have been running TCP with my NFS mount as I'm =
mounting across a corporate network.

I am also using the latest LL TEMAC with EDK 10.1.

Thanks,
John

-----Original Message-----
From: Robert Woodworth [mailto:rwoodworth@securics.com]=20
Sent: Tuesday, April 01, 2008 10:50 AM
To: MingLiu
Cc: John Linn; linuxppc-embedded@ozlabs.org
Subject: RE: xilinx Ml405 NFS mount problem

I think you may be suffering from the latest LL_TEMAC packet loss
problem.  (NFS/UDP really does not like packet loss)


Let me guess. =20
You are using a base system from "Base System Builder Wizard"?
EDK 9.2i. Default syntheses/P&R options.

I have seen a massive packet loss problems on my ML403 and two other
boards I have with an FX60.

This is probably a hardware problem.
Xilinx has acknowledged an LL_TEMAC problem to me but has not provided a
fix.  I have heard that things are better with EDK/ISE-10.1 but I have
not tested it.


The vendor of one of my boards (Pico) has fixed the problem on the FX60
by highly constraining the timing of the LL_TEMAC in map/PR.  On my
ML403 I used similar constraints and it fixed the problem, but only if
the device is plugged into a GigE switch.  The problem is still there
with the same .bit file on a 100-T switch.=20


Are you on a GigE switch?



Rob.






On Tue, 2008-04-01 at 16:15 +0000, MingLiu wrote:
> Dear John,
> =20
> Thank you for your replying.=20
>=20
> >It=A1=AFs not obvious to me what the problem is as I don=A1=AFt see =
any driver
> failures. Have you >tried using a ramdisk and then seeing if the
> network is working before using NFS root? =20
> =20
> Not yet. I will try it soon. However from the information on the
> LL_TEMAC, it seems everything is fine and it should work.=20
> =20
>=20
>=20
> >And I=A1=AFm assuming you have used the NFS root before so you know =
that
> it=A1=AFs good for sure.
>=20
> =20
>=20
> >I test on the ML405 with NFS root and haven=A1=AFt seen this problem, =
but
> my setup is a little different.  I use DHCP rather than >a static IP,
> but other than that it=A1=AFs similar.
>=20
> =20
>=20
> Yes. I used NFS before. I can make sure my NFS server works well. Also
> in principle, static IP should get a same result as DHCP, I think.=20
>=20
> =20
>=20
> >How long has it been since you pulled from the Xilinx Git tree?
>=20
> =20
>=20
> I just pulled the Xilinx tree quite recently. I am using a latest
> kernel.
>=20
> =20
>=20
> BR=20
>=20
> Ming
>=20
> =20
>=20
>         =20
>        =20
>         And I=A1=AFm assuming you have used the NFS root before so you =
know
>         that it=A1=AFs good for sure.
>        =20
>         =20
>        =20
>         I test on the ML405 with NFS root and haven=A1=AFt seen this
>         problem, but my setup is a little different.  I use DHCP
>         rather than a static IP, but other than that it=A1=AFs =
similar.
>        =20
>         =20
>        =20
>         I=A1=AFm assuming that you accidentally got 2 different =
powerup
>         outputs in the message below as the 1st stops and a 2nd starts
>         in the middle.
>        =20
>         =20
>        =20
>         How long has it been since you pulled from the Xilinx Git
>         tree?
>        =20
>         =20
>        =20
>         Thanks,
>        =20
>         John
>        =20
>         =20
>        =20
>                                       =20
>         ______________________________________________________________
>         From: linuxppc-embedded-bounces
>         +john.linn=3Dxilinx.com@ozlabs.org
>         [mailto:linuxppc-embedded-bounces
>         +john.linn=3Dxilinx.com@ozlabs.org] On Behalf Of MingLiu
>         Sent: Tuesday, April 01, 2008 8:12 AM
>         To: linuxppc-embedded@ozlabs.org
>         Subject: xilinx Ml405 NFS mount problem
>        =20
>        =20
>         =20
>        =20
>         Dear friends,
>        =20
>         I am bringing up my kernel from Xilinx git tree. Unfortunately =
I met some
>         problem when mounting the root file system. Here is the =
information
>         listed. I will appreciate a lot if someone can help me out of =
the trouble.=20
>         Thanks a lot!
>         =20
>         =20
>         loaded at:     00400000 0059F19C
>         board data at: 0059D120 0059D19C
>         relocated to:  004050C8 00405144
>         zimage at:     00405F3F 0059C025
>         avail ram:     005A0000 08000000
>         =20
>         Linux/PPC load: root=3D/dev/nfs
>         ip=3D192.168.0.4:192.168.0.3:192.168.0.3:255.255.255.0 rw
>         nfsroot=3D192.168.0.3:/home/mingliu/ml403_rootfs =
console=3DttyUL0,38400
>         mem=3D32M
>         Uncompressing Linux...done.
>         Now booting the kernel
>         Linux version 2.6.24-rc8-xlnx-g1db182b8-dirty (mingliu@cca01) =
(gcc version
>         3.4.1) #7 Tue Apr 1 14:55:25 CEST 2008
>         Xilinx Generic PowerPC board support package (Xilinx ML405) =
(Virtex-4 FX)
>         Zone PFN ranges:
>           DMA             0 ->     8192
>        =20
>           Normal       8192 ->     8192
>        =20
>           HighMem      8192 ->     8192
>         Movable zone start PFN for each node
>         early_node_map[1] active PFN ranges
>             0:        0 ->     8192
>         Built 1 zonelists in Zone order, mobility grouping on.  Total =
pages: 8128
>         Kernel command line: root=3D/de v/nfs
>         ip=3D192.168.0.4:192.168.0.3:192.168.0.3:255.255.255.0 rw
>         nfsroot=3D192.168.0.3:/home/mingliu/ml403_rootfs =
console=3DttyUL0,38400
>         mem=3D32M
>         Xilinx INTC #0 at 0x81800000 mapped to 0xFDFFF000
>         PID hash table entries: 128 (order: 7, 512 bytes)
>         Console: colour dummy device 80x25
>         Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
>         Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
>         Memory: 28884k available (2552k kernel code, 944k data, 84k =
init, 0k highmem)
>         SLUB: Genslabs=3D11, HWalign=3D32, Order=3D0-1, =
MinObjects=3D4, CPUs=3D1, Nodes=3D1
>         Mount-cache hash table entries: 512
>         net_namespace: 64 bytes
>         NET: Registered protocol family 16
>         Registering device uartlite:0
>         Fixup MAC address for xilinx_lltemac:0
>         Regis tering device xilinx_lltemac:0
>         NET: Registered protocol family 2
>         IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
>         TCP established hash table entries: 1024 (order: 1, 8192 =
bytes)
>         TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
>         TCP: Hash tables configured (established 1024 bind 1024)
>         TCP reno registered
>         sysctl table check failed: /kernel/l2cr .1.31 Missing strategy
>         Call Trace:
>         [c1c0fe50] [c0008b70] show_stack+0x40/0x194 (unreliable)
>         [c1c0fe90] [c003aed4] set_fail+0x68/0x80
>         [c1c0feb0] [c003b4ec] sysctl_check_table+0x600/0x77c
>         [c1c0fef0] [c003b4d4] sysctl_check_table+0x5e8/0x77c
>         [c1c0ff30] [c002605c] register_sysctl_table+0x64/0xb4
>         [c1c0ff50] [c034579c] register_ppc_htab_sysctl+0x18/0x2c
>         [c1c0ff60] [c034482c] kernel_init+0x94/0x2bc
>         [c1c0fff0] [c0004d58] kernel_thread+0x44/0x60
>         Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
>         fuse init (API version 7.9)
>         io scheduler noop registered
>         io scheduler anticipatory registered
>         io scheduler deadline registered
>         io scheduler cfq registered (default)
>         uartlite.0: ttyUL0 at MM IO 0x84000003 (irq =3D 3) is a =
uartlite
>         console [ttyUL0] enabled
>         loop: module loaded
>         nbd: registered device at major 43
>         xilinx_lltemac xilinx_lltemac.0: MAC address is now  0: a:35: =
1: 2: 3
>         xilinx_lltemac xilinx_lltemac.0: XLlTemac: using DMA mode.
>         XLlTemac: Dma base address: phy: 0x84600100, virt: 0xc3008100
>         XLlTemac: buffer descriptor size: 32768 (0x8000)
>         XLlTemac: Allocating DMA descriptors with kmalloc<6>XLlTemac:
>         (buffer_descriptor_init) phy: 0x1d18000, virt: 0xc1d18000, =
size: 0x8000
>         XTemac: PHY detected at address 7.
>         xilinx_lltemac xilinx_lltemac.0: eth0: Xilinx TEMAC at =
0x81C00000 mapped
>         to 0xC3004000, irq=3D2
>         console [netcon0] enabled
>         Linux version 2.6.24-rc8-xlnx-g1db182b8-dirty (mingliu@cca01) =
(gcc version
>         3.4.1) #7 Tue Apr 1 14:55:25 CEST 2008
>        =20
>         Xilinx Generic PowerPC board support package (Xilinx ML405)
>         (Virtex-4 FX)
>        =20
>         Zone PFN ranges:
>           DMA             0 ->     8192
>           Normal       8192 ->     8192
>           HighMem      8192 ->     8192
>         Movable zone start PFN for each node
>         early_node_map[1] active PFN range
>          s
>             0:        0 ->     8192
>         Built 1 zonelists in Zone order, mobility grouping on.  Total =
pages: 8128
>         Kernel command line: root=3D/dev/nfs
>         ip=3D192.168.0.4:192.168.0.3:192.168.0.3:255.255.255.0 rw
>         nfsroot=3D192.168.0.3:/home/mingliu/ml403_rootfs =
console=3DttyUL0,38400
>         mem=3D32M
>         Xilinx INTC #0 at 0x81800000 mapped to 0xFDFFF000
>         PID hash table entries: 128 (order: 7, 512 bytes)
>         Console: colour dummy device 80x25
>         Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
>         Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
>         Memory: 28884k available (2552k kernel code, 944k data, 84k =
init, 0k highmem)
>         SLUB: Genslabs=3D11, HWalign=3D32, Order=3D0-1, =
MinObjects=3D4, CPUs=3D1, Nodes=3D1
>         Mount-cache hash table entries: 512
>         n
>          et_namespace: 64 bytes
>         NET: Registered protocol family 16
>         Registering device uartlite:0
>         Fixup MAC address for xilinx_lltemac:0
>         Registering device xilinx_lltemac:0
>         NET: Registered protocol family 2
>         IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
>         TCP established hash table entries: 1024 (order: 1, 8192 =
bytes)
>         TCP bind hash table entries: 1024
>           (order: 0, 4096 bytes)
>         TCP: Hash tables configured (established 1024 bind 1024)
>         TCP reno registered
>         sysctl table check failed: /kernel/l2cr .1.31 Missing strategy
>         Call Trace:
>         [c1c0fe50] [c0008b70] show_stack+0x40/0x194 (unreliable)
>         [c1c0fe90] [c003aed4] set_fail+0x68/0x80
>         [c1c0feb0] [c003b4ec] sysctl_check_table+0x600/0x77c
>         [c1c0fef0] [c003b4d4] sysctl_c
>          heck_table+0x5e8/0x77c
>         [c1c0ff30] [c002605c] register_sysctl_table+0x64/0xb4
>         [c1c0ff50] [c034579c] register_ppc_htab_sysctl+0x18/0x2c
>         [c1c0ff60] [c034482c] kernel_init+0x94/0x2bc
>         [c1c0fff0] [c0004d58] kernel_thread+0x44/0x60
>         Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
>         fuse init (API version 7.9)
>         io scheduler noop registered<
>          /SPAN>
>         io scheduler anticipatory registered
>         io scheduler deadline registered
>         io scheduler cfq registered (default)
>         uartlite.0: ttyUL0 at MMIO 0x84000003 (irq =3D 3) is a =
uartlite
>         console [ttyUL0] enabled
>         loop: module loaded
>         nbd: registered device at major 43
>         xilinx_lltemac xilinx_lltemac.0: MAC address is now  0: a:35: =
1: 2: 3
>         xilinx_lltemac xilinx_lltemac.0: XLlTemac: using DMA mode.
>         XLlTemac: Dma base address: phy: 0x84600100, virt: 0xc3008100
>         XLlTemac: buffer descriptor size: 32768 (0x8000)
>         XLlTemac: Allocating DMA descriptors with kmalloc<6>XLlTemac:
>         (buffer_descriptor_init) phy: 0x1d18000, virt: 0xc1d18000, =
size: 0x8000
>         XTemac: PHY detected at address 7.
>         xilinx_lltemac xilinx_lltemac.0: eth0: Xilinx TEMAC at =
0x81C00000 mapped
>         <
>          SPAN style=3D"FONT-SIZE: 12pt">to 0xC3004000, irq=3D2
>         console [netcon0] enabled
>         netconsole: network logging started
>         Generic platform RAM MTD, (c) 2004 Simtec Electronics
>         mice: PS/2 mouse device common for all mice
>         TCP cubic registered
>         NET: Registered protocol family 1
>         NET: Registered protocol family 17
>         RPC: Registered udp transport module.
>         RPC: Registered tcp transport module.
>         eth0: XLlTemac: Options: 0x3fa
>         eth0: XLlTemac: allocating interrupt 0 for dma mode tx.
>         eth0: XLlTemac: allocating interrupt 1 for dma mode rx.
>         eth0: XLlTemac: speed set to 1000Mb/s
>         eth0: XLlTemac: Send Threshold =3D 24, Receive Threshold =3D 4
>         eth0: XLlTemac: Send Wait bound =3D 254, Receive Wait bound =
=3D 254
>         IP-Config: Complete:
>         =20
>               device=3Deth0, addr=3D192.168.0.4, mask=3D255.255.255.0, =
gw=3D192.168.0.3,
>              host=3D192.168.0.4, domain=3D, nis-domain=3D(none),
>              bootserver=3D192.168.0.3, rootserver=3D192.168.0.3, =
rootpath=3D
>         Looking up port of RPC 100003/2 on 192.168.0.3
>         rpcbind: server 192.168.0.3 not responding, timed out
>         Root-NFS: Unable to get nfsd port number from server, using =
default
>         Looking up port of RPC 10000
>          5/1 on 192.168.0.3
>         rpcbind: server 192.168.0.3 not responding, timed out
>         Root-NFS: Unable to get mountd port number from server, using =
default
>         mount: server 192.168.0.3 not responding, timed out
>         Root-NFS: Server returned error -5 while mounting =
/home/mingliu/ml403_rootfs
>         VFS: Unable to mount root fs via NFS, trying floppy.
>         VFS: Cannot open root device "nfs" or unknown-block(2,0)
>         Please append a correct "root=3D" boot option; here are=20
>          the available
>         partitions:
>         Kernel panic - not syncing: VFS: Unable to mount root fs on
>         unknown-block(2,0)
>         Rebooting in 180 seconds..
>         =20
>         =20
>         BR
>         Ming
>        =20
>         =20
>        =20
>                                       =20
>         ______________________________________________________________
>         Windows Live =
Writer=A3=AC=D6=A7=B3=D6=C0=EB=CF=DF=D7=AB=D0=B4=B2=A9=BF=CD=C4=DA=C8=DD=A3=
=AC=CB=E6=CA=B1=CB=E6=B5=D8=CF=EB=D0=B4=BE=CD=D0=B4=A1=A3
>         =C1=A2=BC=B4=CA=B9=D3=C3=A3=A1
>        =20
>        =20
>=20
>=20
> ______________________________________________________________________
> =CA=B9=D3=C3=D0=C2=D2=BB=B4=FA Windows Live Messenger =
=C7=E1=CB=C9=BD=BB=C1=F7=BA=CD=B9=B2=CF=ED=A3=A1 =
=C1=A2=BC=B4=CC=E5=D1=E9=A3=A1=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
