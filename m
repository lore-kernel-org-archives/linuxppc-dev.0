Return-Path: <johaahn@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.177])
	by ozlabs.org (Postfix) with ESMTP id AD176DE0F3
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jun 2008 03:14:33 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id z59so1660425pyg.27
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 10:14:31 -0700 (PDT)
Message-ID: <7e0dd21a0806131014g85094c6i2d06014c9296d97@mail.gmail.com>
Date: Fri, 13 Jun 2008 19:14:30 +0200
From: "Johann Baudy" <johaahn@gmail.com>
To: frey_simon@yahoo.fr
Subject: Re: XLLTemac with SGDMA working on virtex4FX ?
In-Reply-To: <642239.87879.qm@web26005.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_9450_7653642.1213377270686"
References: <20080613155234.95FD91200050@mail113-sin.bigfish.com>
	<642239.87879.qm@web26005.mail.ukl.yahoo.com>
Cc: linuxppc-dev@ozlabs.org, John Linn <John.Linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_9450_7653642.1213377270686
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Simon,

With EDK10.1, xps_ll_temac, ARCH=3Dpowerpc, I've reached ~17Mo/s with netpe=
rf
(UDP) and ~30 Mo/s in raw packet mode.

Are you using Xilinx evaluation board? If not pay attention to the PHY
controller. (you may not use MARVELL_88E1111_PHY define)

To check if you have some issues with checksum offload, you can use
Wireshark (network analyzer). With this tool you will see your frames and i=
f
they are sent properly.

Best regards,
--=20
RT System Engineer - IXWAVES
Johann Baudy









On Fri, Jun 13, 2008 at 6:43 PM, Simon Frey <frey_simon@yahoo.fr> wrote:

>
> Hi John,
>
> I found a driver in the uboot ml from Yoshio Kashiwagi (Thanks :)
>
> link:
>
> http://www.nabble.com/Xilinx-PowerPC-XPS_LL_TEMAC-driver-td16893860.html#=
a16908888
>
> i didn't know how it works but it uses memcpy on tx and NetReceive() from
> uboot net.c ...
>
> I have to achieve an average speed of 20 MB/s. I hope it works ! Have you
> got some facts ?
>
> So, i don't know what i should do. I thought that xilinx drivers suppots
> there hw ! Should i try to integrate xilinx EDK generated drivers into xl=
nx
> kernel tree ? and how ?
> My computer and the temac are connected to a 1Gb switch and the led is
> blinking when the temac send something but not the led of my computer! as=
 if
> the switch does not his job ! invalid frames ? is possible ? (i should ha=
ve
> a break...)
>
> best regards,
>
> Simon
>
>
>
> --- En date de : Ven 13.6.08, John Linn <John.Linn@xilinx.com> a =E9crit =
:
>
> > De: John Linn <John.Linn@xilinx.com>
> > Objet: RE: XLLTemac with SGDMA working on virtex4FX ?
> > =C0: "Simon Frey" <frey_simon@yahoo.fr>, linuxppc-dev@ozlabs.org
> > Date: Vendredi 13 Juin 2008, 17h52
> > Hi Simon,
> >
> > I have not done testing of this driver with checksum
> > offload.  I do test
> > the driver in an automated test, but not in checksum
> > offload mode, I
> > need to add that test.
> >
> > I did receive the following patch and applied it to the Git
> > server so I
> > think Johann did some testing with checksum offload.  That
> > may have been
> > with arch/ppc rather than arch/powerpc, not sure.
> >
> > I noticed that you have uboot working with LL TEMAC and it
> > must be using
> > DMA SG as it's running on the same h/w. I just got thru
> > hacking together
> > a rough polled mode LL TEMAC driver to support uboot and
> > it's working,
> > but not cleaned up.  Just curious on your experience in
> > that area.
> >
> > Thanks,
> > John Linn
> > Linux Development & Strategy
> >
> > Xilinx is looking for embedded Linux developers....
> >
> > ******************* the patch text I applied
> > ******************************
> >
> > From: John Linn [john.linn@xilinx.com]
> > Sent: Friday, April 04, 2008 10:25 AM
> > To: git
> > Cc: John Linn; Johann Baudy
> > Subject: [PATCH] Xilinx: LL TEMAC: Fix checksum offload
> >
> > The LL TEMAC is generating the wrong checksum when TX
> > hardware checksum
> > is enabled. This is mainly due to two issues:
> > - CHECKSUM_COMPLETE can only be used on RX PATH,
> > CHECKSUM_PARTIAL must
> > be used instead.
> > - Checksum index offsets are being calculated wrong.
> >
> > Signed-off-by: Johann Baudy <johaahn@gmail.com>
> > Signed-off-by: John Linn <john.linn@xilinx.com>
> >
> > -----Original Message-----
> > From: linuxppc-dev-bounces+john.linn=3Dxilinx.com@ozlabs.org
> > [mailto:linuxppc-dev-bounces+john.linn<linuxppc-dev-bounces%2Bjohn.linn=
>
> =3Dxilinx.com@ozlabs.org]
> > On Behalf
> > Of Simon Frey
> > Sent: Friday, June 13, 2008 8:46 AM
> > To: linuxppc-dev@ozlabs.org
> > Subject: XLLTemac with SGDMA working on virtex4FX ?
> >
> > Hi all,
> >
> > does anyone have working driver for xps_ll_temac unsing sg
> > dma and
> > checksum offload on rx and tx ??
> >
> > I use the xlnx kernel with ARCH=3Dpowerpc  and a device tree
> > generated
> > with the gen_mhs_devtree under EDK 10.1
> >
> > I don't know what's wrong but i can't get or
> > send anything  even the
> > speed is only 10 Mb/s !
> >
> > that's what i get when the kernel starts...
> >
> > ## Starting application at 0x004007d0 ...
> > Using Xilinx Virtex machine description
> > Linux version 2.6.25-xlnx (simon@linux) (gcc version 4.2.2)
> > #11 PREEMPT
> > Fri Jun 13 15:51:29 CEST 2008
> > Zone PFN ranges:
> >   DMA             0 ->    16384
> >   Normal      16384 ->    16384
> > Movable zone start PFN for each node
> > early_node_map[1] active PFN ranges
> >     0:        0 ->    16384
> > Built 1 zonelists in Zone order, mobility grouping on.
> > Total pages:
> > 16256
> > Kernel command line: console=3DttyS0,115200 ip=3Ddhcp
> > Xilinx intc at 0x81800000 mapped to 0xfdfff000
> > PID hash table entries: 256 (order: 8, 1024 bytes)
> > clocksource: timebase mult[1400000] shift[22] registered
> > Console: colour dummy device 80x25
> > Dentry cache hash table entries: 8192 (order: 3, 32768
> > bytes)
> > Inode-cache hash table entries: 4096 (order: 2, 16384
> > bytes)
> > Memory: 61704k/65536k available (2892k kernel code, 3768k
> > reserved, 112k
> > data, 141k bss, 144k init)
> > Mount-cache hash table entries: 512
> > net_namespace: 536 bytes
> > NET: Registered protocol family 16
> > NET: Registered protocol family 2
> > IP route cache hash table entries: 1024 (order: 0, 4096
> > bytes)
> > TCP established hash table entries: 2048 (order: 2, 16384
> > bytes)
> > TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
> > TCP: Hash tables configured (established 2048 bind 2048)
> > TCP reno registered
> > Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> > io scheduler noop registered
> > io scheduler anticipatory registered
> > io scheduler deadline registered
> > io scheduler cfq registered (default)
> > Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ
> > sharing
> > disabled
> > 83e00000.serial: ttyS0 at MMIO 0x83e00003 (irq =3D 16) is a
> > 16550A
> > console [ttyS0] enabled
> > brd: module loaded
> > loop: module loaded
> > Device Tree Probing 'ethernet'
> > xilinx_lltemac 81c00000.ethernet: MAC address is now  0:
> > a:35: 0:22: 1
> > xilinx_lltemac 81c00000.ethernet: XLlTemac: using DMA mode.
> > XLlTemac: Dma base address: phy: 0x84600100, virt:
> > 0xc5010100
> > XLlTemac: buffer descriptor size: 32768 (0x8000)
> > XLlTemac: Allocating DMA descriptors with
> > kmalloc<6>XLlTemac:
> > (buffer_descriptor_init) phy: 0x3868000, virt: 0xc3868000,
> > size: 0x8000
> > XTemac: PHY detected at address 4.
> > xilinx_lltemac 81c00000.ethernet: eth0: Xilinx TEMAC at
> > 0x81C00000
> > mapped to 0xC500E000, irq=3D17
> > mice: PS/2 mouse device common for all mice
> > TCP cubic registered
> > NET: Registered protocol family 1
> > NET: Registered protocol family 17
> > RPC: Registered udp transport module.
> > RPC: Registered tcp transport module.
> > eth0: XLlTemac: Options: 0x3fa
> > eth0: XLlTemac: allocating interrupt 19 for dma mode tx.
> > eth0: XLlTemac: allocating interrupt 18 for dma mode rx.
> > eth0: XLlTemac: speed set to 10Mb/s
> > eth0: XLlTemac: Send Threshold =3D 240, Receive Threshold =3D
> > 40
> > eth0: XLlTemac: Send Wait bound =3D 254, Receive Wait bound =3D
> > 254
> > Sending DHCP requests ...... timed out!
> > IP-Config: Reopening network devices...
> > eth0: XLlTemac: Options: 0x3fa
> >
> >
> >
> >
> > I can see the led blinking on my switch but don't see
> > nothing using
> > wireshak !!!
> >
> >
> > Finaly, i know the the temac works because i can use it
> > with uboot !!!
> > even
> > at speed 1000.
> >
> > In:    serial
> > Out:   serial
> > Err:   serial
> > U-Boot relocated to 03fcf000
> > ### main_loop entered: bootdelay=3D3
> >
> > ### main_loop: bootcmd=3D"loooaadd %addr"
> > Press Enter within 3 seconds to stop autoboot
> > Unknown command 'loooaadd' - try 'help'
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
> > #################################################################
> >
> > ########################################################
> > done
> > Bytes transferred =3D 1772215 (1b0ab7 hex)
> > =3D>
> >
> >
> > so if someone already had that problem...
> >
> > Thanks in advance
> >
> > Simon
> >
> >
> >
> >
> > _______________________________________________________________________=
_
> > _____
> > Envoyez avec Yahoo! Mail. Une boite mail plus intelligente
> > http://mail.yahoo.fr
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
> >
> >
> > This email and any attachments are intended for the sole
> > use of the named recipient(s) and contain(s) confidential
> > information that may be proprietary, privileged or
> > copyrighted under applicable law. If you are not the
> > intended recipient, do not read, copy, or forward this
> > email message or any attachments. Delete this email message
> > and any attachments immediately.
> >
> >
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
>
>
>  ________________________________________________________________________=
_____
> Envoyez avec Yahoo! Mail. Une boite mail plus intelligente
> http://mail.yahoo.fr
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



--=20
Johann Baudy
johaahn@gmail.com

------=_Part_9450_7653642.1213377270686
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Simon,<br>&nbsp;<br>With EDK10.1, xps_ll_temac, ARCH=3Dpowerpc, I&#39;ve=
 reached ~17Mo/s with netperf (UDP) and ~30 Mo/s in raw packet mode. <br><b=
r>Are you using Xilinx evaluation board? If not pay attention to the PHY co=
ntroller. (you may not use MARVELL_88E1111_PHY define) <br>
<br>To check if you have some issues with checksum offload, you can use Wir=
eshark (network analyzer). With this tool you will see your frames and if t=
hey are sent properly.<br><br>Best regards,<br>
-- <br>
RT System Engineer - IXWAVES<br>
Johann Baudy<br><br><br><br><br><br><br><br><br><br><div class=3D"gmail_quo=
te">On Fri, Jun 13, 2008 at 6:43 PM, Simon Frey &lt;<a href=3D"mailto:frey_=
simon@yahoo.fr">frey_simon@yahoo.fr</a>&gt; wrote:<br><blockquote class=3D"=
gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0p=
t 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>
Hi John,<br>
<br>
I found a driver in the uboot ml from Yoshio Kashiwagi (Thanks :)<br>
<br>
link:<br>
<a href=3D"http://www.nabble.com/Xilinx-PowerPC-XPS_LL_TEMAC-driver-td16893=
860.html#a16908888" target=3D"_blank">http://www.nabble.com/Xilinx-PowerPC-=
XPS_LL_TEMAC-driver-td16893860.html#a16908888</a><br>
<br>
i didn&#39;t know how it works but it uses memcpy on tx and NetReceive() fr=
om uboot net.c ...<br>
<br>
I have to achieve an average speed of 20 MB/s. I hope it works ! Have you g=
ot some facts ?<br>
<br>
So, i don&#39;t know what i should do. I thought that xilinx drivers suppot=
s there hw ! Should i try to integrate xilinx EDK generated drivers into xl=
nx kernel tree ? and how ?<br>
My computer and the temac are connected to a 1Gb switch and the led is blin=
king when the temac send something but not the led of my computer! as if th=
e switch does not his job ! invalid frames ? is possible ? (i should have a=
 break...)<br>

<br>
best regards,<br>
<br>
Simon<br>
<br>
<br>
<br>
--- En date de&nbsp;: Ven 13.6.08, John Linn &lt;<a href=3D"mailto:John.Lin=
n@xilinx.com">John.Linn@xilinx.com</a>&gt; a =E9crit&nbsp;:<br>
<br>
&gt; De: John Linn &lt;<a href=3D"mailto:John.Linn@xilinx.com">John.Linn@xi=
linx.com</a>&gt;<br>
&gt; Objet: RE: XLLTemac with SGDMA working on virtex4FX ?<br>
&gt; =C0: &quot;Simon Frey&quot; &lt;<a href=3D"mailto:frey_simon@yahoo.fr"=
>frey_simon@yahoo.fr</a>&gt;, <a href=3D"mailto:linuxppc-dev@ozlabs.org">li=
nuxppc-dev@ozlabs.org</a><br>
&gt; Date: Vendredi 13 Juin 2008, 17h52<br>
<div><div></div><div class=3D"Wj3C7c">&gt; Hi Simon,<br>
&gt;<br>
&gt; I have not done testing of this driver with checksum<br>
&gt; offload. &nbsp;I do test<br>
&gt; the driver in an automated test, but not in checksum<br>
&gt; offload mode, I<br>
&gt; need to add that test.<br>
&gt;<br>
&gt; I did receive the following patch and applied it to the Git<br>
&gt; server so I<br>
&gt; think Johann did some testing with checksum offload. &nbsp;That<br>
&gt; may have been<br>
&gt; with arch/ppc rather than arch/powerpc, not sure.<br>
&gt;<br>
&gt; I noticed that you have uboot working with LL TEMAC and it<br>
&gt; must be using<br>
&gt; DMA SG as it&#39;s running on the same h/w. I just got thru<br>
&gt; hacking together<br>
&gt; a rough polled mode LL TEMAC driver to support uboot and<br>
&gt; it&#39;s working,<br>
&gt; but not cleaned up. &nbsp;Just curious on your experience in<br>
&gt; that area.<br>
&gt;<br>
&gt; Thanks,<br>
&gt; John Linn<br>
&gt; Linux Development &amp; Strategy<br>
&gt;<br>
&gt; Xilinx is looking for embedded Linux developers....<br>
&gt;<br>
&gt; ******************* the patch text I applied<br>
&gt; ******************************<br>
&gt;<br>
&gt; From: John Linn [<a href=3D"mailto:john.linn@xilinx.com">john.linn@xil=
inx.com</a>]<br>
&gt; Sent: Friday, April 04, 2008 10:25 AM<br>
&gt; To: git<br>
&gt; Cc: John Linn; Johann Baudy<br>
&gt; Subject: [PATCH] Xilinx: LL TEMAC: Fix checksum offload<br>
&gt;<br>
&gt; The LL TEMAC is generating the wrong checksum when TX<br>
&gt; hardware checksum<br>
&gt; is enabled. This is mainly due to two issues:<br>
&gt; - CHECKSUM_COMPLETE can only be used on RX PATH,<br>
&gt; CHECKSUM_PARTIAL must<br>
&gt; be used instead.<br>
&gt; - Checksum index offsets are being calculated wrong.<br>
&gt;<br>
&gt; Signed-off-by: Johann Baudy &lt;<a href=3D"mailto:johaahn@gmail.com">j=
ohaahn@gmail.com</a>&gt;<br>
&gt; Signed-off-by: John Linn &lt;<a href=3D"mailto:john.linn@xilinx.com">j=
ohn.linn@xilinx.com</a>&gt;<br>
&gt;<br>
&gt; -----Original Message-----<br>
&gt; From: linuxppc-dev-bounces+john.linn=3D<a href=3D"http://xilinx.com" t=
arget=3D"_blank">xilinx.com</a>@<a href=3D"http://ozlabs.org" target=3D"_bl=
ank">ozlabs.org</a><br>
&gt; [mailto:<a href=3D"mailto:linuxppc-dev-bounces%2Bjohn.linn">linuxppc-d=
ev-bounces+john.linn</a>=3D<a href=3D"http://xilinx.com" target=3D"_blank">=
xilinx.com</a>@<a href=3D"http://ozlabs.org" target=3D"_blank">ozlabs.org</=
a>]<br>

&gt; On Behalf<br>
&gt; Of Simon Frey<br>
&gt; Sent: Friday, June 13, 2008 8:46 AM<br>
&gt; To: <a href=3D"mailto:linuxppc-dev@ozlabs.org">linuxppc-dev@ozlabs.org=
</a><br>
&gt; Subject: XLLTemac with SGDMA working on virtex4FX ?<br>
&gt;<br>
&gt; Hi all,<br>
&gt;<br>
&gt; does anyone have working driver for xps_ll_temac unsing sg<br>
&gt; dma and<br>
&gt; checksum offload on rx and tx ??<br>
&gt;<br>
&gt; I use the xlnx kernel with ARCH=3Dpowerpc &nbsp;and a device tree<br>
&gt; generated<br>
&gt; with the gen_mhs_devtree under EDK 10.1<br>
&gt;<br>
&gt; I don&#39;t know what&#39;s wrong but i can&#39;t get or<br>
&gt; send anything &nbsp;even the<br>
&gt; speed is only 10 Mb/s !<br>
&gt;<br>
&gt; that&#39;s what i get when the kernel starts...<br>
&gt;<br>
&gt; ## Starting application at 0x004007d0 ...<br>
&gt; Using Xilinx Virtex machine description<br>
&gt; Linux version 2.6.25-xlnx (simon@linux) (gcc version 4.2.2)<br>
&gt; #11 PREEMPT<br>
&gt; Fri Jun 13 15:51:29 CEST 2008<br>
&gt; Zone PFN ranges:<br>
&gt; &nbsp; DMA &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0 -&gt; &nbsp; &n=
bsp;16384<br>
&gt; &nbsp; Normal &nbsp; &nbsp; &nbsp;16384 -&gt; &nbsp; &nbsp;16384<br>
&gt; Movable zone start PFN for each node<br>
&gt; early_node_map[1] active PFN ranges<br>
&gt; &nbsp; &nbsp; 0: &nbsp; &nbsp; &nbsp; &nbsp;0 -&gt; &nbsp; &nbsp;16384=
<br>
&gt; Built 1 zonelists in Zone order, mobility grouping on.<br>
&gt; Total pages:<br>
&gt; 16256<br>
&gt; Kernel command line: console=3DttyS0,115200 ip=3Ddhcp<br>
&gt; Xilinx intc at 0x81800000 mapped to 0xfdfff000<br>
&gt; PID hash table entries: 256 (order: 8, 1024 bytes)<br>
&gt; clocksource: timebase mult[1400000] shift[22] registered<br>
&gt; Console: colour dummy device 80x25<br>
&gt; Dentry cache hash table entries: 8192 (order: 3, 32768<br>
&gt; bytes)<br>
&gt; Inode-cache hash table entries: 4096 (order: 2, 16384<br>
&gt; bytes)<br>
&gt; Memory: 61704k/65536k available (2892k kernel code, 3768k<br>
&gt; reserved, 112k<br>
&gt; data, 141k bss, 144k init)<br>
&gt; Mount-cache hash table entries: 512<br>
&gt; net_namespace: 536 bytes<br>
&gt; NET: Registered protocol family 16<br>
&gt; NET: Registered protocol family 2<br>
&gt; IP route cache hash table entries: 1024 (order: 0, 4096<br>
&gt; bytes)<br>
&gt; TCP established hash table entries: 2048 (order: 2, 16384<br>
&gt; bytes)<br>
&gt; TCP bind hash table entries: 2048 (order: 1, 8192 bytes)<br>
&gt; TCP: Hash tables configured (established 2048 bind 2048)<br>
&gt; TCP reno registered<br>
&gt; Installing knfsd (copyright (C) 1996 <a href=3D"mailto:okir@monad.swb.=
de">okir@monad.swb.de</a>).<br>
&gt; io scheduler noop registered<br>
&gt; io scheduler anticipatory registered<br>
&gt; io scheduler deadline registered<br>
&gt; io scheduler cfq registered (default)<br>
&gt; Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ<br>
&gt; sharing<br>
&gt; disabled<br>
&gt; 83e00000.serial: ttyS0 at MMIO 0x83e00003 (irq =3D 16) is a<br>
&gt; 16550A<br>
&gt; console [ttyS0] enabled<br>
&gt; brd: module loaded<br>
&gt; loop: module loaded<br>
&gt; Device Tree Probing &#39;ethernet&#39;<br>
&gt; xilinx_lltemac 81c00000.ethernet: MAC address is now &nbsp;0:<br>
&gt; a:35: 0:22: 1<br>
&gt; xilinx_lltemac 81c00000.ethernet: XLlTemac: using DMA mode.<br>
&gt; XLlTemac: Dma base address: phy: 0x84600100, virt:<br>
&gt; 0xc5010100<br>
&gt; XLlTemac: buffer descriptor size: 32768 (0x8000)<br>
&gt; XLlTemac: Allocating DMA descriptors with<br>
&gt; kmalloc&lt;6&gt;XLlTemac:<br>
&gt; (buffer_descriptor_init) phy: 0x3868000, virt: 0xc3868000,<br>
&gt; size: 0x8000<br>
&gt; XTemac: PHY detected at address 4.<br>
&gt; xilinx_lltemac 81c00000.ethernet: eth0: Xilinx TEMAC at<br>
&gt; 0x81C00000<br>
&gt; mapped to 0xC500E000, irq=3D17<br>
&gt; mice: PS/2 mouse device common for all mice<br>
&gt; TCP cubic registered<br>
&gt; NET: Registered protocol family 1<br>
&gt; NET: Registered protocol family 17<br>
&gt; RPC: Registered udp transport module.<br>
&gt; RPC: Registered tcp transport module.<br>
&gt; eth0: XLlTemac: Options: 0x3fa<br>
&gt; eth0: XLlTemac: allocating interrupt 19 for dma mode tx.<br>
&gt; eth0: XLlTemac: allocating interrupt 18 for dma mode rx.<br>
&gt; eth0: XLlTemac: speed set to 10Mb/s<br>
&gt; eth0: XLlTemac: Send Threshold =3D 240, Receive Threshold =3D<br>
&gt; 40<br>
&gt; eth0: XLlTemac: Send Wait bound =3D 254, Receive Wait bound =3D<br>
&gt; 254<br>
&gt; Sending DHCP requests ...... timed out!<br>
&gt; IP-Config: Reopening network devices...<br>
&gt; eth0: XLlTemac: Options: 0x3fa<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; I can see the led blinking on my switch but don&#39;t see<br>
&gt; nothing using<br>
&gt; wireshak !!!<br>
&gt;<br>
&gt;<br>
&gt; Finaly, i know the the temac works because i can use it<br>
&gt; with uboot !!!<br>
&gt; even<br>
&gt; at speed 1000.<br>
&gt;<br>
&gt; In: &nbsp; &nbsp;serial<br>
&gt; Out: &nbsp; serial<br>
&gt; Err: &nbsp; serial<br>
&gt; U-Boot relocated to 03fcf000<br>
&gt; ### main_loop entered: bootdelay=3D3<br>
&gt;<br>
&gt; ### main_loop: bootcmd=3D&quot;loooaadd %addr&quot;<br>
&gt; Press Enter within 3 seconds to stop autoboot<br>
&gt; Unknown command &#39;loooaadd&#39; - try &#39;help&#39;<br>
&gt; =3D&gt; setenv bootfile zImage.virtex<br>
&gt; =3D&gt; tftp 40000<br>
&gt; eth0: Xilinx XPS LocalLink Tri-Mode Ether MAC #0 at<br>
&gt; 0x81C00000.<br>
&gt; 1000BASE-T/FD<br>
&gt; TFTP from server <a href=3D"http://192.168.1.100" target=3D"_blank">19=
2.168.1.100</a>; our IP address is<br>
&gt; <a href=3D"http://192.168.1.200" target=3D"_blank">192.168.1.200</a><b=
r>
&gt; Filename &#39;zImage.virtex&#39;.<br>
&gt; Load address: 0x40000<br>
&gt; Loading:<br>
&gt; #################################################################<br>
&gt;<br>
&gt; ########################################################<br>
&gt; done<br>
&gt; Bytes transferred =3D 1772215 (1b0ab7 hex)<br>
&gt; =3D&gt;<br>
&gt;<br>
&gt;<br>
&gt; so if someone already had that problem...<br>
&gt;<br>
&gt; Thanks in advance<br>
&gt;<br>
&gt; Simon<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; ______________________________________________________________________=
__<br>
&gt; _____<br>
&gt; Envoyez avec Yahoo! Mail. Une boite mail plus intelligente<br>
&gt; <a href=3D"http://mail.yahoo.fr" target=3D"_blank">http://mail.yahoo.f=
r</a><br>
&gt; _______________________________________________<br>
&gt; Linuxppc-dev mailing list<br>
&gt; <a href=3D"mailto:Linuxppc-dev@ozlabs.org">Linuxppc-dev@ozlabs.org</a>=
<br>
&gt; <a href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-dev" target=3D=
"_blank">https://ozlabs.org/mailman/listinfo/linuxppc-dev</a><br>
&gt;<br>
&gt;<br>
&gt; This email and any attachments are intended for the sole<br>
&gt; use of the named recipient(s) and contain(s) confidential<br>
&gt; information that may be proprietary, privileged or<br>
&gt; copyrighted under applicable law. If you are not the<br>
&gt; intended recipient, do not read, copy, or forward this<br>
&gt; email message or any attachments. Delete this email message<br>
&gt; and any attachments immediately.<br>
&gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; Linuxppc-dev mailing list<br>
&gt; <a href=3D"mailto:Linuxppc-dev@ozlabs.org">Linuxppc-dev@ozlabs.org</a>=
<br>
&gt; <a href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-dev" target=3D=
"_blank">https://ozlabs.org/mailman/listinfo/linuxppc-dev</a><br>
<br>
<br>
</div></div> &nbsp; &nbsp; &nbsp;__________________________________________=
___________________________________<br>
<div><div></div><div class=3D"Wj3C7c">Envoyez avec Yahoo! Mail. Une boite m=
ail plus intelligente <a href=3D"http://mail.yahoo.fr" target=3D"_blank">ht=
tp://mail.yahoo.fr</a><br>
_______________________________________________<br>
Linuxppc-dev mailing list<br>
<a href=3D"mailto:Linuxppc-dev@ozlabs.org">Linuxppc-dev@ozlabs.org</a><br>
<a href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-dev" target=3D"_bla=
nk">https://ozlabs.org/mailman/listinfo/linuxppc-dev</a><br>
</div></div></blockquote></div><br><br clear=3D"all"><br>-- <br>Johann Baud=
y<br><a href=3D"mailto:johaahn@gmail.com">johaahn@gmail.com</a>

------=_Part_9450_7653642.1213377270686--
