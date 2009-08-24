Return-Path: <afleming@gmail.com>
Received: from mail-gx0-f211.google.com (mail-gx0-f211.google.com
	[209.85.217.211])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 93FA0B7B3E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 25 Aug 2009 09:32:21 +1000 (EST)
Received: by gxk7 with SMTP id 7so3607978gxk.8
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 24 Aug 2009 16:32:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <200908241810.54239.to-fleischer@t-online.de>
References: <200908241810.54239.to-fleischer@t-online.de>
Date: Mon, 24 Aug 2009 18:32:18 -0500
Message-ID: <2acbd3e40908241632j7e9da3f7o7e11aa672838b9a5@mail.gmail.com>
Subject: Re: gianfar.c: Unwanted VLAN tagging on TX frames
From: Andy Fleming <afleming@gmail.com>
To: Torsten Fleischer <to-fleischer@t-online.de>
Content-Type: multipart/alternative; boundary=000e0cd5c764f48ab90471eba05f
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--000e0cd5c764f48ab90471eba05f
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Mon, Aug 24, 2009 at 11:10 AM, Torsten Fleischer <
to-fleischer@t-online.de> wrote:

> Hello everyone,
>
> I have the Freescale's MPC8313erdb eval board and run the latest stable
> linux
> kernel version (linux-2.6.30.5).
>
> After creating a VLAN device (e.g. eth0.2) a VLAN tag is also inserted into
> frames that don't relate to a VLAN device. This is the case for frames that
> are directly sent through a standard ethernet interface (e.g. eth0).
>
> When creating a VLAN device the gianfar driver enables the  hardware
> supported
> VLAN tagging on TX frames. This is done by setting the VLINS bit of the
> TCTRL
> register inside the function gianfar_vlan_rx_register().
> The problem is that every outgoing frame will be tagged.  For frames from
> an
> interface like eth0 the VLN bit of the FCB isn't set. Therefore the eTSEC
> uses
> the content of the Default VLAN control word register (DFVLAN) to tag the
> frame. As long as this register will not be modified after a reset of the
> controller the outgoing frames will be tagged with VID = 0 (priority tagged
> frames).
>
> The following patch solves this problem.
>
> diff -uprN linux-2.6.30.5_orig//drivers/net/gianfar.c
> linux-2.6.30.5/drivers/net/gianfar.c
> --- linux-2.6.30.5_orig//drivers/net/gianfar.c  2009-08-16
> 23:19:38.000000000 +0200
> +++ linux-2.6.30.5/drivers/net/gianfar.c        2009-08-22
> 10:38:28.000000000 +0200
> @@ -1309,6 +1309,7 @@ static int gfar_start_xmit(struct sk_buf
>        u32 bufaddr;
>        unsigned long flags;
>        unsigned int nr_frags, length;
> +       u32 tempval;
>
>        base = priv->tx_bd_base;
>
> @@ -1385,13 +1386,30 @@ static int gfar_start_xmit(struct sk_buf
>                gfar_tx_checksum(skb, fcb);
>        }
>
> -       if (priv->vlgrp && vlan_tx_tag_present(skb)) {
> -               if (unlikely(NULL == fcb)) {
> -                       fcb = gfar_add_fcb(skb);
> -                       lstatus |= BD_LFLAG(TXBD_TOE);
> -               }
> +       if (priv->vlgrp) {
> +               if (vlan_tx_tag_present(skb)) {
> +                       if (unlikely(NULL == fcb)) {
> +                               fcb = gfar_add_fcb(skb);
> +                               lstatus |= BD_LFLAG(TXBD_TOE);
> +                       }
> +
> +                       /* Enable VLAN tag insertion for frames from VLAN
> devices */
> +                       tempval = gfar_read(&priv->regs->tctrl);
> +                       if ( !(tempval & TCTRL_VLINS) ) {
> +                               tempval |= TCTRL_VLINS;
> +                               gfar_write(&priv->regs->tctrl, tempval);
> +                       }
>
> -               gfar_tx_vlan(skb, fcb);
> +                       gfar_tx_vlan(skb, fcb);
> +               }
> +               else {
> +                       /* Disable VLAN tag insertion for frames that are
> not from a VLAN device */
> +                       tempval = gfar_read(&priv->regs->tctrl);
> +                       if ( tempval & TCTRL_VLINS ) {
> +                               tempval &= ~TCTRL_VLINS;
> +                               gfar_write(&priv->regs->tctrl, tempval);
> +                       }
> +               }
>        }



Hmmm....how have you tested this?  This looks like it has a bad race
condition.  The TCTRL register applies to all packets, which means if you
send a packet with VLAN tags, followed by one without, or visa versa,
there's a reasonable chance that the second packet's VLAN tags (or lack
thereof) will take precedence.

Without speaking for the company, I suspect that this is just how the eTSEC
works with VLAN -- all, or nothing.

Andy

--000e0cd5c764f48ab90471eba05f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Mon, Aug 24, 2009 at 11:10 AM, Torste=
n Fleischer <span dir=3D"ltr">&lt;<a href=3D"mailto:to-fleischer@t-online.d=
e">to-fleischer@t-online.de</a>&gt;</span> wrote:<br><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex;">
Hello everyone,<br>
<br>
I have the Freescale&#39;s MPC8313erdb eval board and run the latest stable=
 linux<br>
kernel version (linux-2.6.30.5).<br>
<br>
After creating a VLAN device (e.g. eth0.2) a VLAN tag is also inserted into=
<br>
frames that don&#39;t relate to a VLAN device. This is the case for frames =
that<br>
are directly sent through a standard ethernet interface (e.g. eth0).<br>
<br>
When creating a VLAN device the gianfar driver enables the =A0hardware supp=
orted<br>
VLAN tagging on TX frames. This is done by setting the VLINS bit of the TCT=
RL<br>
register inside the function gianfar_vlan_rx_register().<br>
The problem is that every outgoing frame will be tagged. =A0For frames from=
 an<br>
interface like eth0 the VLN bit of the FCB isn&#39;t set. Therefore the eTS=
EC uses<br>
the content of the Default VLAN control word register (DFVLAN) to tag the<b=
r>
frame. As long as this register will not be modified after a reset of the<b=
r>
controller the outgoing frames will be tagged with VID =3D 0 (priority tagg=
ed<br>
frames).<br>
<br>
The following patch solves this problem.<br>
<br>
diff -uprN linux-2.6.30.5_orig//drivers/net/gianfar.c linux-2.6.30.5/driver=
s/net/gianfar.c<br>
--- linux-2.6.30.5_orig//drivers/net/gianfar.c =A02009-08-16 23:19:38.00000=
0000 +0200<br>
+++ linux-2.6.30.5/drivers/net/gianfar.c =A0 =A0 =A0 =A02009-08-22 10:38:28=
.000000000 +0200<br>
@@ -1309,6 +1309,7 @@ static int gfar_start_xmit(struct sk_buf<br>
 =A0 =A0 =A0 =A0u32 bufaddr;<br>
 =A0 =A0 =A0 =A0unsigned long flags;<br>
 =A0 =A0 =A0 =A0unsigned int nr_frags, length;<br>
+ =A0 =A0 =A0 u32 tempval;<br>
<br>
 =A0 =A0 =A0 =A0base =3D priv-&gt;tx_bd_base;<br>
<br>
@@ -1385,13 +1386,30 @@ static int gfar_start_xmit(struct sk_buf<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gfar_tx_checksum(skb, fcb);<br>
 =A0 =A0 =A0 =A0}<br>
<br>
- =A0 =A0 =A0 if (priv-&gt;vlgrp &amp;&amp; vlan_tx_tag_present(skb)) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (unlikely(NULL =3D=3D fcb)) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fcb =3D gfar_add_fcb(skb);<br=
>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lstatus |=3D BD_LFLAG(TXBD_TO=
E);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 if (priv-&gt;vlgrp) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (vlan_tx_tag_present(skb)) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (unlikely(NULL =3D=3D fcb)=
) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fcb =3D gfar_=
add_fcb(skb);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lstatus |=3D =
BD_LFLAG(TXBD_TOE);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Enable VLAN tag insertion =
for frames from VLAN devices */<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tempval =3D gfar_read(&amp;pr=
iv-&gt;regs-&gt;tctrl);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ( !(tempval &amp; TCTRL_VL=
INS) ) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tempval |=3D =
TCTRL_VLINS;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gfar_write(&a=
mp;priv-&gt;regs-&gt;tctrl, tempval);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 gfar_tx_vlan(skb, fcb);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gfar_tx_vlan(skb, fcb);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 else {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Disable VLAN tag insertion=
 for frames that are not from a VLAN device */<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tempval =3D gfar_read(&amp;pr=
iv-&gt;regs-&gt;tctrl);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ( tempval &amp; TCTRL_VLIN=
S ) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tempval &amp;=
=3D ~TCTRL_VLINS;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gfar_write(&a=
mp;priv-&gt;regs-&gt;tctrl, tempval);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
 =A0 =A0 =A0 =A0}</blockquote><div><br></div><div><br></div><div>Hmmm....ho=
w have you tested this? =A0This looks like it has a bad race condition. =A0=
The TCTRL register applies to all packets, which means if you send a packet=
 with VLAN tags, followed by one without, or visa versa, there&#39;s a reas=
onable chance that the second packet&#39;s VLAN tags (or lack thereof) will=
 take precedence.</div>
<div><br></div><div>Without speaking for the company, I suspect that this i=
s just how the eTSEC works with VLAN -- all, or nothing.</div><div><br></di=
v><div>Andy=A0</div></div><br>

--000e0cd5c764f48ab90471eba05f--
