Return-Path: <frey_simon@yahoo.fr>
Received: from web26005.mail.ukl.yahoo.com (web26005.mail.ukl.yahoo.com
	[217.12.10.216]) by ozlabs.org (Postfix) with SMTP id E622DDDF29
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jun 2008 02:43:21 +1000 (EST)
Date: Fri, 13 Jun 2008 16:43:19 +0000 (GMT)
From: Simon Frey <frey_simon@yahoo.fr>
Subject: RE: XLLTemac with SGDMA working on virtex4FX ?
To: John Linn <John.Linn@xilinx.com>, linuxppc-dev@ozlabs.org
In-Reply-To: <20080613155234.95FD91200050@mail113-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <642239.87879.qm@web26005.mail.ukl.yahoo.com>
Reply-To: frey_simon@yahoo.fr
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi John,

I found a driver in the uboot ml from Yoshio Kashiwagi (Thanks :)

link:
http://www.nabble.com/Xilinx-PowerPC-XPS_LL_TEMAC-driver-td16893860.html#a1=
6908888

i didn't know how it works but it uses memcpy on tx and NetReceive() from u=
boot net.c ...

I have to achieve an average speed of 20 MB/s. I hope it works ! Have you g=
ot some facts ?

So, i don't know what i should do. I thought that xilinx drivers suppots th=
ere hw ! Should i try to integrate xilinx EDK generated drivers into xlnx k=
ernel tree ? and how ?
My computer and the temac are connected to a 1Gb switch and the led is blin=
king when the temac send something but not the led of my computer! as if th=
e switch does not his job ! invalid frames ? is possible ? (i should have a=
 break...)

best regards,

Simon



--- En date de=A0: Ven 13.6.08, John Linn <John.Linn@xilinx.com> a =E9crit=
=A0:

> De: John Linn <John.Linn@xilinx.com>
> Objet: RE: XLLTemac with SGDMA working on virtex4FX ?
> =C0: "Simon Frey" <frey_simon@yahoo.fr>, linuxppc-dev@ozlabs.org
> Date: Vendredi 13 Juin 2008, 17h52
> Hi Simon,
>=20
> I have not done testing of this driver with checksum
> offload.  I do test
> the driver in an automated test, but not in checksum
> offload mode, I
> need to add that test.=20
>=20
> I did receive the following patch and applied it to the Git
> server so I
> think Johann did some testing with checksum offload.  That
> may have been
> with arch/ppc rather than arch/powerpc, not sure.
>=20
> I noticed that you have uboot working with LL TEMAC and it
> must be using
> DMA SG as it's running on the same h/w. I just got thru
> hacking together
> a rough polled mode LL TEMAC driver to support uboot and
> it's working,
> but not cleaned up.  Just curious on your experience in
> that area.
>=20
> Thanks,
> John Linn
> Linux Development & Strategy
>=20
> Xilinx is looking for embedded Linux developers....
>=20
> ******************* the patch text I applied
> ******************************
>=20
> From: John Linn [john.linn@xilinx.com]
> Sent: Friday, April 04, 2008 10:25 AM
> To: git
> Cc: John Linn; Johann Baudy
> Subject: [PATCH] Xilinx: LL TEMAC: Fix checksum offload
>=20
> The LL TEMAC is generating the wrong checksum when TX
> hardware checksum
> is enabled. This is mainly due to two issues:
> - CHECKSUM_COMPLETE can only be used on RX PATH,
> CHECKSUM_PARTIAL must
> be used instead.
> - Checksum index offsets are being calculated wrong.
>=20
> Signed-off-by: Johann Baudy <johaahn@gmail.com>
> Signed-off-by: John Linn <john.linn@xilinx.com>
>=20
> -----Original Message-----
> From: linuxppc-dev-bounces+john.linn=3Dxilinx.com@ozlabs.org
> [mailto:linuxppc-dev-bounces+john.linn=3Dxilinx.com@ozlabs.org]
> On Behalf
> Of Simon Frey
> Sent: Friday, June 13, 2008 8:46 AM
> To: linuxppc-dev@ozlabs.org
> Subject: XLLTemac with SGDMA working on virtex4FX ?
>=20
> Hi all,
>=20
> does anyone have working driver for xps_ll_temac unsing sg
> dma and
> checksum offload on rx and tx ??
>=20
> I use the xlnx kernel with ARCH=3Dpowerpc  and a device tree
> generated
> with the gen_mhs_devtree under EDK 10.1
>=20
> I don't know what's wrong but i can't get or
> send anything  even the
> speed is only 10 Mb/s !
>=20
> that's what i get when the kernel starts...
>=20
> ## Starting application at 0x004007d0 ...
> Using Xilinx Virtex machine description
> Linux version 2.6.25-xlnx (simon@linux) (gcc version 4.2.2)
> #11 PREEMPT
> Fri Jun 13 15:51:29 CEST 2008
> Zone PFN ranges:
>   DMA             0 ->    16384
>   Normal      16384 ->    16384
> Movable zone start PFN for each node
> early_node_map[1] active PFN ranges
>     0:        0 ->    16384
> Built 1 zonelists in Zone order, mobility grouping on.=20
> Total pages:
> 16256
> Kernel command line: console=3DttyS0,115200 ip=3Ddhcp
> Xilinx intc at 0x81800000 mapped to 0xfdfff000
> PID hash table entries: 256 (order: 8, 1024 bytes)
> clocksource: timebase mult[1400000] shift[22] registered
> Console: colour dummy device 80x25
> Dentry cache hash table entries: 8192 (order: 3, 32768
> bytes)
> Inode-cache hash table entries: 4096 (order: 2, 16384
> bytes)
> Memory: 61704k/65536k available (2892k kernel code, 3768k
> reserved, 112k
> data, 141k bss, 144k init)
> Mount-cache hash table entries: 512
> net_namespace: 536 bytes
> NET: Registered protocol family 16
> NET: Registered protocol family 2
> IP route cache hash table entries: 1024 (order: 0, 4096
> bytes)
> TCP established hash table entries: 2048 (order: 2, 16384
> bytes)
> TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
> TCP: Hash tables configured (established 2048 bind 2048)
> TCP reno registered
> Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> io scheduler noop registered
> io scheduler anticipatory registered
> io scheduler deadline registered
> io scheduler cfq registered (default)
> Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ
> sharing
> disabled
> 83e00000.serial: ttyS0 at MMIO 0x83e00003 (irq =3D 16) is a
> 16550A
> console [ttyS0] enabled
> brd: module loaded
> loop: module loaded
> Device Tree Probing 'ethernet'
> xilinx_lltemac 81c00000.ethernet: MAC address is now  0:
> a:35: 0:22: 1
> xilinx_lltemac 81c00000.ethernet: XLlTemac: using DMA mode.
> XLlTemac: Dma base address: phy: 0x84600100, virt:
> 0xc5010100
> XLlTemac: buffer descriptor size: 32768 (0x8000)
> XLlTemac: Allocating DMA descriptors with
> kmalloc<6>XLlTemac:
> (buffer_descriptor_init) phy: 0x3868000, virt: 0xc3868000,
> size: 0x8000
> XTemac: PHY detected at address 4.
> xilinx_lltemac 81c00000.ethernet: eth0: Xilinx TEMAC at
> 0x81C00000
> mapped to 0xC500E000, irq=3D17
> mice: PS/2 mouse device common for all mice
> TCP cubic registered
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> RPC: Registered udp transport module.
> RPC: Registered tcp transport module.
> eth0: XLlTemac: Options: 0x3fa
> eth0: XLlTemac: allocating interrupt 19 for dma mode tx.
> eth0: XLlTemac: allocating interrupt 18 for dma mode rx.
> eth0: XLlTemac: speed set to 10Mb/s
> eth0: XLlTemac: Send Threshold =3D 240, Receive Threshold =3D
> 40
> eth0: XLlTemac: Send Wait bound =3D 254, Receive Wait bound =3D
> 254
> Sending DHCP requests ...... timed out!
> IP-Config: Reopening network devices...
> eth0: XLlTemac: Options: 0x3fa
>=20
>=20
>=20
>=20
> I can see the led blinking on my switch but don't see
> nothing using
> wireshak !!!
>=20
>=20
> Finaly, i know the the temac works because i can use it
> with uboot !!!
> even=20
> at speed 1000.
>=20
> In:    serial
> Out:   serial
> Err:   serial
> U-Boot relocated to 03fcf000
> ### main_loop entered: bootdelay=3D3
>=20
> ### main_loop: bootcmd=3D"loooaadd %addr"
> Press Enter within 3 seconds to stop autoboot
> Unknown command 'loooaadd' - try 'help'
> =3D> setenv bootfile zImage.virtex
> =3D> tftp 40000
> eth0: Xilinx XPS LocalLink Tri-Mode Ether MAC #0 at
> 0x81C00000.
> 1000BASE-T/FD
> TFTP from server 192.168.1.100; our IP address is
> 192.168.1.200
> Filename 'zImage.virtex'.
> Load address: 0x40000
> Loading:
> #################################################################
>        =20
> ########################################################
> done
> Bytes transferred =3D 1772215 (1b0ab7 hex)
> =3D>
>=20
>=20
> so if someone already had that problem...=20
>=20
> Thanks in advance=20
>=20
> Simon
>=20
>=20
>=20
> =20
> ________________________________________________________________________
> _____=20
> Envoyez avec Yahoo! Mail. Une boite mail plus intelligente
> http://mail.yahoo.fr
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>=20
>=20
> This email and any attachments are intended for the sole
> use of the named recipient(s) and contain(s) confidential
> information that may be proprietary, privileged or
> copyrighted under applicable law. If you are not the
> intended recipient, do not read, copy, or forward this
> email message or any attachments. Delete this email message
> and any attachments immediately.
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev=0A=0A=0A      __________=
___________________________________________________________________ =0AEnvo=
yez avec Yahoo! Mail. Une boite mail plus intelligente http://mail.yahoo.fr
