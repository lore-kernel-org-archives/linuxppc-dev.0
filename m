Return-Path: <frey_simon@yahoo.fr>
Received: from web26007.mail.ukl.yahoo.com (web26007.mail.ukl.yahoo.com
	[217.12.10.218]) by ozlabs.org (Postfix) with SMTP id BCE10DDEDF
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2008 23:54:38 +1000 (EST)
Date: Tue, 17 Jun 2008 13:54:36 +0000 (GMT)
From: Simon Frey <frey_simon@yahoo.fr>
Subject: RE: XLLTemac with SGDMA working on virtex4FX ?
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <408159.8740.qm@web26007.mail.ukl.yahoo.com>
Reply-To: frey_simon@yahoo.fr
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,


So, i'm using a Avnet Virtex 4 fx12 mini module.=20
I solved my ethernet speed negotiation problem using the kernel option MARV=
ELL_..._MII or other PHY.
It work fine, my rootfs is on nfs server.
But the speed isn't great. I takes serverals ms (2 to 4 ms) to answer a pin=
g request (packet size is irrelevant).

My Hardware :
i use the xps_ll_temac connected to a mpmc sdma input through local link

Address Map for Processor ppc405_0
  (0b0100000000-0b0111111111) ppc405_0=09
  (0000000000-0x03ffffff) DDR_SDRAM_32Mx16=09ppc405_0_dplb1
  (0000000000-0x03ffffff) DDR_SDRAM_32Mx16=09ppc405_0_iplb1
  (0x06000000-0x06003fff) xps_bram_if_cntlr_1=09plb
  (0x44a00000-0x44a00fff) ppc405_0_iocm_cntlr=09ppc405_0_iocm
  (0x81400000-0x8140ffff) FLASH_READY=09plb
  (0x81800000-0x8180ffff) xps_intc_0=09plb
  (0x81c00000-0x81c0ffff) TriMode_MAC_GMII=09plb
  (0x83e00000-0x83e0ffff) RS232=09plb
  (0x84600000-0x8460ffff) DDR_SDRAM_32Mx16=09plb
  (0xbe308000-0xbe308fff) ppc405_0_docm_cntlr=09ppc405_0_docm
  (0xffc00000-0xffffffff) FLASH_2Mx16=09plb


John, on which base have you started to make your driver ?
Can you share your work and experiences ? What should be do ?

Thanks,
Simon


--- En date de=A0: Ven 13.6.08, John Linn <John.Linn@xilinx.com> a =E9crit=
=A0:

> De: John Linn <John.Linn@xilinx.com>
> Objet: RE: XLLTemac with SGDMA working on virtex4FX ?
> =C0: frey_simon@yahoo.fr, linuxppc-dev@ozlabs.org
> Date: Vendredi 13 Juin 2008, 21h46
> Hi Simon,
>=20
> See my comments in-line below.
>=20
> Thanks,
> John
>=20
>=20
> -----Original Message-----
> From: Simon Frey [mailto:frey_simon@yahoo.fr]=20
> Sent: Friday, June 13, 2008 10:43 AM
> To: John Linn; linuxppc-dev@ozlabs.org
> Subject: RE: XLLTemac with SGDMA working on virtex4FX ?
>=20
>=20
> Hi John,
>=20
> I found a driver in the uboot ml from Yoshio Kashiwagi
> (Thanks :)
>=20
> link:
> http://www.nabble.com/Xilinx-PowerPC-XPS_LL_TEMAC-driver-td16893860.html#=
a16908888
>=20
> i didn't know how it works but it uses memcpy on tx and
> NetReceive() from uboot net.c ...
>=20
> I have to achieve an average speed of 20 MB/s. I hope it
> works ! Have you got some facts ?
>=20
> ******** John's response follows *********
>=20
> My hacked on driver uses DMA SG in a polled mode and does
> not do any copies. But I have not idea what the performance
> is as it is not finished. It is functioning, but needs more
> work.  It's still too early to tell performance and
> I'm diverted right now on other work.
>=20
> *********************************
>=20
> So, i don't know what i should do. I thought that
> xilinx drivers suppots there hw ! Should i try to integrate
> xilinx EDK generated drivers into xlnx kernel tree ? and how
> ?
> My computer and the temac are connected to a 1Gb switch and
> the led is blinking when the temac send something but not
> the led of my computer! as if the switch does not his job !
> invalid frames ? is possible ? (i should have a break...)
>=20
> ******** John's response follows *********
>=20
> The Xilinx drivers in the Embedded Development Kit for
> standalone operation and commercial Linux have full test
> coverage with the Xilinx hardware. The Xilinx Git server is
> a less mature initiative and we don't yet have full test
> coverage. We plan to continue increasing our test coverage
> thru our automated testing so that the open source drivers
> have better test coverage also.=20
>=20
> Have you tested this system configuration without checksum
> offload to make sure the system configuration is ok?  The
> default configuration of the kernel in the Git tree,
> ml405_defconfig and ml507-defconfig, is setup to give users
> a baseline using a reference bitstream on the
> http://git.xilinx.com site.
>=20
> *********************************
>=20
> best regards,
>=20
> Simon
>=20
>=20
>=20
> --- En date de=A0: Ven 13.6.08, John Linn
> <John.Linn@xilinx.com> a =E9crit=A0:
>=20
> > De: John Linn <John.Linn@xilinx.com>
> > Objet: RE: XLLTemac with SGDMA working on virtex4FX ?
> > =C0: "Simon Frey"
> <frey_simon@yahoo.fr>, linuxppc-dev@ozlabs.org
> > Date: Vendredi 13 Juin 2008, 17h52
> > Hi Simon,
> >=20
> > I have not done testing of this driver with checksum
> > offload.  I do test
> > the driver in an automated test, but not in checksum
> > offload mode, I
> > need to add that test.=20
> >=20
> > I did receive the following patch and applied it to
> the Git
> > server so I
> > think Johann did some testing with checksum offload.=20
> That
> > may have been
> > with arch/ppc rather than arch/powerpc, not sure.
> >=20
> > I noticed that you have uboot working with LL TEMAC
> and it
> > must be using
> > DMA SG as it's running on the same h/w. I just got
> thru
> > hacking together
> > a rough polled mode LL TEMAC driver to support uboot
> and
> > it's working,
> > but not cleaned up.  Just curious on your experience
> in
> > that area.
> >=20
> > Thanks,
> > John Linn
> > Linux Development & Strategy
> >=20
> > Xilinx is looking for embedded Linux developers....
> >=20
> > ******************* the patch text I applied
> > ******************************
> >=20
> > From: John Linn [john.linn@xilinx.com]
> > Sent: Friday, April 04, 2008 10:25 AM
> > To: git
> > Cc: John Linn; Johann Baudy
> > Subject: [PATCH] Xilinx: LL TEMAC: Fix checksum
> offload
> >=20
> > The LL TEMAC is generating the wrong checksum when TX
> > hardware checksum
> > is enabled. This is mainly due to two issues:
> > - CHECKSUM_COMPLETE can only be used on RX PATH,
> > CHECKSUM_PARTIAL must
> > be used instead.
> > - Checksum index offsets are being calculated wrong.
> >=20
> > Signed-off-by: Johann Baudy <johaahn@gmail.com>
> > Signed-off-by: John Linn <john.linn@xilinx.com>
> >=20
> > -----Original Message-----
> > From:
> linuxppc-dev-bounces+john.linn=3Dxilinx.com@ozlabs.org
> >
> [mailto:linuxppc-dev-bounces+john.linn=3Dxilinx.com@ozlabs.org]
> > On Behalf
> > Of Simon Frey
> > Sent: Friday, June 13, 2008 8:46 AM
> > To: linuxppc-dev@ozlabs.org
> > Subject: XLLTemac with SGDMA working on virtex4FX ?
> >=20
> > Hi all,
> >=20
> > does anyone have working driver for xps_ll_temac
> unsing sg
> > dma and
> > checksum offload on rx and tx ??
> >=20
> > I use the xlnx kernel with ARCH=3Dpowerpc  and a device
> tree
> > generated
> > with the gen_mhs_devtree under EDK 10.1
> >=20
> > I don't know what's wrong but i can't get
> or
> > send anything  even the
> > speed is only 10 Mb/s !
> >=20
> > that's what i get when the kernel starts...
> >=20
> > ## Starting application at 0x004007d0 ...
> > Using Xilinx Virtex machine description
> > Linux version 2.6.25-xlnx (simon@linux) (gcc version
> 4.2.2)
> > #11 PREEMPT
> > Fri Jun 13 15:51:29 CEST 2008
> > Zone PFN ranges:
> >   DMA             0 ->    16384
> >   Normal      16384 ->    16384
> > Movable zone start PFN for each node
> > early_node_map[1] active PFN ranges
> >     0:        0 ->    16384
> > Built 1 zonelists in Zone order, mobility grouping on.
>=20
> > Total pages:
> > 16256
> > Kernel command line: console=3DttyS0,115200 ip=3Ddhcp
> > Xilinx intc at 0x81800000 mapped to 0xfdfff000
> > PID hash table entries: 256 (order: 8, 1024 bytes)
> > clocksource: timebase mult[1400000] shift[22]
> registered
> > Console: colour dummy device 80x25
> > Dentry cache hash table entries: 8192 (order: 3, 32768
> > bytes)
> > Inode-cache hash table entries: 4096 (order: 2, 16384
> > bytes)
> > Memory: 61704k/65536k available (2892k kernel code,
> 3768k
> > reserved, 112k
> > data, 141k bss, 144k init)
> > Mount-cache hash table entries: 512
> > net_namespace: 536 bytes
> > NET: Registered protocol family 16
> > NET: Registered protocol family 2
> > IP route cache hash table entries: 1024 (order: 0,
> 4096
> > bytes)
> > TCP established hash table entries: 2048 (order: 2,
> 16384
> > bytes)
> > TCP bind hash table entries: 2048 (order: 1, 8192
> bytes)
> > TCP: Hash tables configured (established 2048 bind
> 2048)
> > TCP reno registered
> > Installing knfsd (copyright (C) 1996
> okir@monad.swb.de).
> > io scheduler noop registered
> > io scheduler anticipatory registered
> > io scheduler deadline registered
> > io scheduler cfq registered (default)
> > Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports,
> IRQ
> > sharing
> > disabled
> > 83e00000.serial: ttyS0 at MMIO 0x83e00003 (irq =3D 16)
> is a
> > 16550A
> > console [ttyS0] enabled
> > brd: module loaded
> > loop: module loaded
> > Device Tree Probing 'ethernet'
> > xilinx_lltemac 81c00000.ethernet: MAC address is now=20
> 0:
> > a:35: 0:22: 1
> > xilinx_lltemac 81c00000.ethernet: XLlTemac: using DMA
> mode.
> > XLlTemac: Dma base address: phy: 0x84600100, virt:
> > 0xc5010100
> > XLlTemac: buffer descriptor size: 32768 (0x8000)
> > XLlTemac: Allocating DMA descriptors with
> > kmalloc<6>XLlTemac:
> > (buffer_descriptor_init) phy: 0x3868000, virt:
> 0xc3868000,
> > size: 0x8000
> > XTemac: PHY detected at address 4.
> > xilinx_lltemac 81c00000.ethernet: eth0: Xilinx TEMAC
> at
> > 0x81C00000
> > mapped to 0xC500E000, irq=3D17
> > mice: PS/2 mouse device common for all mice
> > TCP cubic registered
> > NET: Registered protocol family 1
> > NET: Registered protocol family 17
> > RPC: Registered udp transport module.
> > RPC: Registered tcp transport module.
> > eth0: XLlTemac: Options: 0x3fa
> > eth0: XLlTemac: allocating interrupt 19 for dma mode
> tx.
> > eth0: XLlTemac: allocating interrupt 18 for dma mode
> rx.
> > eth0: XLlTemac: speed set to 10Mb/s
> > eth0: XLlTemac: Send Threshold =3D 240, Receive
> Threshold =3D
> > 40
> > eth0: XLlTemac: Send Wait bound =3D 254, Receive Wait
> bound =3D
> > 254
> > Sending DHCP requests ...... timed out!
> > IP-Config: Reopening network devices...
> > eth0: XLlTemac: Options: 0x3fa
> >=20
> >=20
> >=20
> >=20
> > I can see the led blinking on my switch but don't
> see
> > nothing using
> > wireshak !!!
> >=20
> >=20
> > Finaly, i know the the temac works because i can use
> it
> > with uboot !!!
> > even=20
> > at speed 1000.
> >=20
> > In:    serial
> > Out:   serial
> > Err:   serial
> > U-Boot relocated to 03fcf000
> > ### main_loop entered: bootdelay=3D3
> >=20
> > ### main_loop: bootcmd=3D"loooaadd %addr"
> > Press Enter within 3 seconds to stop autoboot
> > Unknown command 'loooaadd' - try
> 'help'
> > =3D> setenv bootfile zImage.virtex
> > =3D> tftp 40000
> > eth0: Xilinx XPS LocalLink Tri-Mode Ether MAC #0 at
> > 0x81C00000.
> > 1000BASE-T/FD
> > TFTP from server 192.168.1.100; our IP address is
> > 192.168.1.200
> > Filename 'zImage.virtex'.
> > Load address: 0x40000
> > Loading:
> >
> #################################################################
> >        =20
> >
> ########################################################
> > done
> > Bytes transferred =3D 1772215 (1b0ab7 hex)
> > =3D>
> >=20
> >=20
> > so if someone already had that problem...=20
> >=20
> > Thanks in advance=20
> >=20
> > Simon
> >=20
> >=20
> >=20
> > =20
> >
> ________________________________________________________________________
> > _____=20
> > Envoyez avec Yahoo! Mail. Une boite mail plus
> intelligente
> > http://mail.yahoo.fr
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
> >=20
> >=20
> > This email and any attachments are intended for the
> sole
> > use of the named recipient(s) and contain(s)
> confidential
> > information that may be proprietary, privileged or
> > copyrighted under applicable law. If you are not the
> > intended recipient, do not read, copy, or forward this
> > email message or any attachments. Delete this email
> message
> > and any attachments immediately.
> >=20
> >=20
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
>=20
>=20
>     =20
> _________________________________________________________________________=
____
>=20
> Envoyez avec Yahoo! Mail. Une boite mail plus intelligente
> http://mail.yahoo.fr
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
