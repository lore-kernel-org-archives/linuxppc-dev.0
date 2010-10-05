Return-Path: <bastiaan.nijkamp@gmail.com>
Received: from mail-qy0-f172.google.com (mail-qy0-f172.google.com
	[209.85.216.172]) by ozlabs.org (Postfix) with ESMTP id 4237EB6EE9
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Oct 2010 19:56:58 +1100 (EST)
Received: by qyk5 with SMTP id 5so274176qyk.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 05 Oct 2010 01:56:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <0CE8B6BE3C4AD74AB97D9D29BD24E552013B97E8@CORPEXCH1.na.ads.idt.com>
References: <0CE8B6BE3C4AD74AB97D9D29BD24E552013B97E8@CORPEXCH1.na.ads.idt.com>
From: Bastiaan Nijkamp <bastiaan.nijkamp@gmail.com>
Date: Tue, 5 Oct 2010 10:56:33 +0200
Message-ID: <AANLkTimCiHWRR-kVuT0ift3CH63Xk_XcaXS22qmVh6fr@mail.gmail.com>
Subject: Re: Serial RapidIO Maintaintance read causes lock up
To: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
Content-Type: multipart/alternative; boundary=00c09f9b0b52abe31b0491dad747
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--00c09f9b0b52abe31b0491dad747
Content-Type: text/plain; charset=ISO-8859-1

Hi Alex,

Thanks for your advice. We are trying to make a board-to-board connection
without any additional hardware (eg. a switch). The boards use a 50-pin,
right-angle MEC8-125-02-L-D-RA1 connector from SAMTEC and are connected
trough a EEDP-016-12.00-RA1-RA2-2 cross cable from SAMTEC. I hope this
information is sufficient since there is not much one can find about it on
Google. In addition, you can see a picture of the board including the
connector in the datasheet located at
http://www.windriver.com/products/product-notes/SBC8548E-product-note.pdf.
It is the connector on the left side of the PCI-EX slot.

We have tried your suggestion but the situation does not change other than
the lane-mode being set to single lane 0, it still locks up when trying to
generate a maintenance transaction. I still think it is memory related since
the lock up occurs when accessing the maintenance window. Although all
memory related settings seems to be alright.

The kernel output is as follows:

Setting up RapidIO peer-to-peer network /soc8548@e0000000/rapidio@c0000
fsl-of-rio e00c0000.rapidio: Of-device full name
/soc8548@e0000000/rapidio@c0000
fsl-of-rio e00c0000.rapidio: Regs: [mem 0xe00c0000-0xe00dffff]
fsl-of-rio e00c0000.rapidio: LAW start 0x00000000c0000000, size
0x0000000010000000.
fsl-of-rio e00c0000.rapidio: pwirq: 48, bellirq: 50, txirq: 53, rxirq 54
fsl-of-rio e00c0000.rapidio: DeviceID is 0x0
fsl-of-rio e00c0000.rapidio: Configured as HOST
fsl-of-rio e00c0000.rapidio: Overriding RIO_PORT setting to single lane 0
fsl-of-rio e00c0000.rapidio: RapidIO PHY type: serial
fsl-of-rio e00c0000.rapidio: Hardware port width: 4
fsl-of-rio e00c0000.rapidio: Training connection status: Single-lane 0
fsl-of-rio e00c0000.rapidio: RapidIO Common Transport System size: 256
fsl-of-rio e00c0000.rapidio: LAW start 0x00000000c0000000, RIO Maintainance
Window Size 0x400000,New Main Start: 0xd1080000
RIO: enumerate master port 0, RIO0 mport
fsl_rio_config_read: index 0 destid 255 hopcount 0 offset 00000068 len 4
fsl_rio_config_read: Passed IS_ALIGNED.
fsl_rio_config_read: Passed 'out_be32_1'
fsl_rio_config_read: Passed 'out_be32_2'
fsl_rio_config_read: len is 4
fsl_rio_config_read: triggering '__fsl_read_rio_config'
fsl_rio_config_read: going to request to read data at d108006

Regards,
Bastiaan
2010/10/4 Bounine, Alexandre <Alexandre.Bounine@idt.com>

> Hi Bastiaan,
>
> Are you trying board-to-board connection?
> I am not familiar with WRS SBC8548 board - which type of connector they
> use for SRIO?
>
> Assuming that all configuration is correct,
> I would recommend first to try setting up x1 link mode at the lowest
> link speed.
> The x4 mode may present challenges in some cases.
>
> For quick test you may just add port width override into fsl_rio.c
> like shown below (ugly but sometimes it helps ;) ):
>
> @@ -1461,10 +1461,16 @@ int fsl_rio_setup(struct platform_device *dev)
>        rio_register_mport(port);
>
>        priv->regs_win = ioremap(regs.start, regs.end - regs.start + 1);
>        rio_regs_win = priv->regs_win;
>
> +dev_info(&dev->dev, "Overriding RIO_PORT setting to single lane 0\n");
> +out_be32(priv->regs_win + 0x15C, in_be32(priv->regs_win + 0x15C) |
> 0x800000);
> +out_be32(priv->regs_win + 0x15C, in_be32(priv->regs_win + 0x15C) |
> 0x2000000);
> +out_be32(priv->regs_win + 0x15C, in_be32(priv->regs_win + 0x15C) &
> ~0x800000);
> +msleep(100);
> +
>        /* Probe the master port phy type */
>        ccsr = in_be32(priv->regs_win + RIO_CCSR);
>        port->phy_type = (ccsr & 1) ? RIO_PHY_SERIAL : RIO_PHY_PARALLEL;
>        dev_info(&dev->dev, "RapidIO PHY type: %s\n",
>                        (port->phy_type == RIO_PHY_PARALLEL) ?
> "parallel" :
>
>
> Let me know what happens.
> Please keep me in the CC: list next time when posting RapidIO questions
> to the linuxppc-dev or kernel mailing lists.
>
> Regards,
>
> Alex.
>
>

--00c09f9b0b52abe31b0491dad747
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p><br>Hi Alex,</p>
<p>Thanks for your advice. We are trying to make a board-to-board connectio=
n without any additional hardware (eg. a switch). The boards use a 50-pin, =
right-angle MEC8-125-02-L-D-RA1 connector from SAMTEC and are connected tro=
ugh a EEDP-016-12.00-RA1-RA2-2 cross cable from SAMTEC. I hope this informa=
tion is sufficient since there is not much one can find about it on Google.=
 In addition, you can see a picture of the board including the connector in=
 the datasheet located at <a href=3D"http://www.windriver.com/products/prod=
uct-notes/SBC8548E-product-note.pdf">http://www.windriver.com/products/prod=
uct-notes/SBC8548E-product-note.pdf</a>. It is the connector on the left si=
de of the PCI-EX slot.</p>


<p>We have tried your suggestion but the situation does not change other th=
an the lane-mode being set to single lane 0, it still locks up when trying =
to generate a maintenance transaction. I still think it is memory related s=
ince the lock up occurs when accessing the maintenance window. Although all=
 memory related settings seems to be alright.</p>


<p>The kernel output is as follows:</p>
<p>Setting up RapidIO peer-to-peer network <a>/soc8548@e0000000/rapidio@c00=
00</a><br>fsl-of-rio e00c0000.rapidio: Of-device full name <a>/soc8548@e000=
0000/rapidio@c0000</a><br>fsl-of-rio e00c0000.rapidio: Regs: [mem 0xe00c000=
0-0xe00dffff]<br>

fsl-of-rio e00c0000.rapidio: LAW start 0x00000000c0000000, size 0x000000001=
0000000.<br>fsl-of-rio e00c0000.rapidio: pwirq: 48, bellirq: 50, txirq: 53,=
 rxirq 54<br>fsl-of-rio e00c0000.rapidio: DeviceID is 0x0<br>fsl-of-rio e00=
c0000.rapidio: Configured as HOST<br>

fsl-of-rio e00c0000.rapidio: Overriding RIO_PORT setting to single lane 0<b=
r>fsl-of-rio e00c0000.rapidio: RapidIO PHY type: serial<br>fsl-of-rio e00c0=
000.rapidio: Hardware port width: 4<br>fsl-of-rio e00c0000.rapidio: Trainin=
g connection status: Single-lane 0<br>

fsl-of-rio e00c0000.rapidio: RapidIO Common Transport System size: 256<br>f=
sl-of-rio e00c0000.rapidio: LAW start 0x00000000c0000000, RIO Maintainance =
Window Size 0x400000,New Main Start: 0xd1080000<br>RIO: enumerate master po=
rt 0, RIO0 mport<br>

fsl_rio_config_read: index 0 destid 255 hopcount 0 offset 00000068 len 4<br=
>fsl_rio_config_read: Passed IS_ALIGNED.<br>fsl_rio_config_read: Passed &#3=
9;out_be32_1&#39;<br>fsl_rio_config_read: Passed &#39;out_be32_2&#39;<br>

fsl_rio_config_read: len is 4<br>fsl_rio_config_read: triggering &#39;__fsl=
_read_rio_config&#39;<br>fsl_rio_config_read: going to request to read data=
 at d108006</p>
<p>Regards,<br>Bastiaan</p>
<div class=3D"gmail_quote">2010/10/4 Bounine, Alexandre <span dir=3D"ltr">&=
lt;<a href=3D"mailto:Alexandre.Bounine@idt.com">Alexandre.Bounine@idt.com</=
a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hi Bastiaan,<br><br>Are you tryi=
ng board-to-board connection?<br>I am not familiar with WRS SBC8548 board -=
 which type of connector they<br>

use for SRIO?<br><br>Assuming that all configuration is correct,<br>I would=
 recommend first to try setting up x1 link mode at the lowest<br>link speed=
.<br>The x4 mode may present challenges in some cases.<br><br>For quick tes=
t you may just add port width override into fsl_rio.c<br>

like shown below (ugly but sometimes it helps ;) ):<br><br>@@ -1461,10 +146=
1,16 @@ int fsl_rio_setup(struct platform_device *dev)<br>=A0 =A0 =A0 =A0ri=
o_register_mport(port);<br><br>=A0 =A0 =A0 =A0priv-&gt;regs_win =3D ioremap=
(regs.start, regs.end - regs.start + 1);<br>

=A0 =A0 =A0 =A0rio_regs_win =3D priv-&gt;regs_win;<br><br>+dev_info(&amp;de=
v-&gt;dev, &quot;Overriding RIO_PORT setting to single lane 0\n&quot;);<br>=
+out_be32(priv-&gt;regs_win + 0x15C, in_be32(priv-&gt;regs_win + 0x15C) |<b=
r>0x800000);<br>

+out_be32(priv-&gt;regs_win + 0x15C, in_be32(priv-&gt;regs_win + 0x15C) |<b=
r>0x2000000);<br>+out_be32(priv-&gt;regs_win + 0x15C, in_be32(priv-&gt;regs=
_win + 0x15C) &amp;<br>~0x800000);<br>+msleep(100);<br>+<br>=A0 =A0 =A0 =A0=
/* Probe the master port phy type */<br>

=A0 =A0 =A0 =A0ccsr =3D in_be32(priv-&gt;regs_win + RIO_CCSR);<br>=A0 =A0 =
=A0 =A0port-&gt;phy_type =3D (ccsr &amp; 1) ? RIO_PHY_SERIAL : RIO_PHY_PARA=
LLEL;<br>=A0 =A0 =A0 =A0dev_info(&amp;dev-&gt;dev, &quot;RapidIO PHY type: =
%s\n&quot;,<br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(port-&gt;phy=
_type =3D=3D RIO_PHY_PARALLEL) ?<br>

&quot;parallel&quot; :<br><br><br>Let me know what happens.<br>Please keep =
me in the CC: list next time when posting RapidIO questions<br>to the linux=
ppc-dev or kernel mailing lists.<br><br>Regards,<br><br>Alex.<br><br></bloc=
kquote>

</div><br>

--00c09f9b0b52abe31b0491dad747--
