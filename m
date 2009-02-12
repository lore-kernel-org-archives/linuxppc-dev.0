Return-Path: <jhautbois@gmail.com>
Received: from mail-bw0-f168.google.com (mail-bw0-f168.google.com
	[209.85.218.168]) by ozlabs.org (Postfix) with ESMTP id 20A13DDDF9
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 00:36:41 +1100 (EST)
Received: by bwz12 with SMTP id 12so1812182bwz.9
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 05:36:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20090212133037.GA3651@yookeroo.seuss>
References: <8cad0aa0902120123p27cfe32fg6bf08d458178c937@mail.gmail.com>
	<49940265.1020700@vastech.co.za>
	<8cad0aa0902120310g44a3bf3cla4ffa94ea9bf5dc6@mail.gmail.com>
	<20090212133037.GA3651@yookeroo.seuss>
Date: Thu, 12 Feb 2009 14:36:39 +0100
Message-ID: <8cad0aa0902120536p3303322cvf9a7307391d195b9@mail.gmail.com>
Subject: Re: [MPC8272ADS]Problem adding flash partitions inside the device
	tree
From: Jean-Michel Hautbois <jhautbois@gmail.com>
To: Jean-Michel Hautbois <jhautbois@gmail.com>, Pieter <phenning@vastech.co.za>,
	linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=0016e6d3766160406b0462b8cf92
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0016e6d3766160406b0462b8cf92
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

2009/2/12 David Gibson <david@gibson.dropbear.id.au>

> On Thu, Feb 12, 2009 at 12:10:58PM +0100, Jean-Michel Hautbois wrote:
> > 2009/2/12 Pieter <phenning@vastech.co.za>
> >
> > > Jean-Michel Hautbois wrote:
> > > > Warning (reg_format): "reg" property in
> > > > /localbus@f0010100/flash@0,0/partition@ff800000 has invalid length
> (8
> > > > JM
> > > You are missing some definitions, The #address-cells and #size-cells =
> <1>;
> > > tis is a snippet of teh dts i defined for my board.
> > >
> > >        flash@0,0 {
> > >            #address-cells = <1>;
> > >            #size-cells = <1>;
> > >            compatible = "cfi-flash";
> > >            reg = <0x0 0x0 0x08000000>;
> > >             bank-width = <4>;
> > >            device-width = <1>;
> > >
> > >             /* set flash partition to correspond tu mtd parts in
> > > u-boot*/
> > >            /*     0xf8000000 */
> > >            partition@0x0 {
> > >                label = "factory-image";
> > >                reg = <0x00000000 0x01000000>;
> > >            };
> > >            /*     0xf9000000 */
> > >            partition@0x01000000 {
> > >                label = "app-image-1";
> > >                reg = <0x01000000 0x01000000>;
> > >            };
> > > cheers pieter
> > >
> >
> > Hi do have these definitions, at a higher level:
>
> The address-cells and size-cells definitions are not inherited.  They
> cover only the immediate children of the node where they appear.
> Otherwise the default values apply (address-cells == 2, size-cells ==
> 1), which are not right for your case.
>
> --
> David Gibson                    | I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au  | minimalist, thank you.  NOT _the_
> _other_
>                                | _way_ _around_!
> http://www.ozlabs.org/~dgibson <http://www.ozlabs.org/%7Edgibson>
>
OK, so, after having tested, I can't see any changes when booting.
I do not have more mtd in /proc/mtd.

JM

--0016e6d3766160406b0462b8cf92
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">2009/2/12 David Gibson <span dir=3D"ltr">&lt;<a =
href=3D"mailto:david@gibson.dropbear.id.au">david@gibson.dropbear.id.au</a>=
&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px =
solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div><div></div><div class=3D"Wj3C7c">On Thu, Feb 12, 2009 at 12:10:58PM +0=
100, Jean-Michel Hautbois wrote:<br>
&gt; 2009/2/12 Pieter &lt;<a href=3D"mailto:phenning@vastech.co.za">phennin=
g@vastech.co.za</a>&gt;<br>
&gt;<br>
&gt; &gt; Jean-Michel Hautbois wrote:<br>
&gt; &gt; &gt; Warning (reg_format): &quot;reg&quot; property in<br>
&gt; &gt; &gt; /localbus@f0010100/flash@0,0/partition@ff800000 has invalid =
length (8<br>
&gt; &gt; &gt; JM<br>
&gt; &gt; You are missing some definitions, The #address-cells and #size-ce=
lls =3D &lt;1&gt;;<br>
&gt; &gt; tis is a snippet of teh dts i defined for my board.<br>
&gt; &gt;<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp;flash@0,0 {<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#address-cells =3D &lt;1=
&gt;;<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#size-cells =3D &lt;1&gt=
;;<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;compatible =3D &quot;cfi=
-flash&quot;;<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;reg =3D &lt;0x0 0x0 0x08=
000000&gt;;<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; bank-width =3D &lt;4&gt=
;;<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;device-width =3D &lt;1&g=
t;;<br>
&gt; &gt;<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /* set flash partition =
to correspond tu mtd parts in<br>
&gt; &gt; u-boot*/<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* &nbsp; &nbsp; 0xf8000=
000 */<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;partition@0x0 {<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;label =3D =
&quot;factory-image&quot;;<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;reg =3D &l=
t;0x00000000 0x01000000&gt;;<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;};<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* &nbsp; &nbsp; 0xf9000=
000 */<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;partition@0x01000000 {<b=
r>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;label =3D =
&quot;app-image-1&quot;;<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;reg =3D &l=
t;0x01000000 0x01000000&gt;;<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;};<br>
&gt; &gt; cheers pieter<br>
&gt; &gt;<br>
&gt;<br>
&gt; Hi do have these definitions, at a higher level:<br>
<br>
</div></div>The address-cells and size-cells definitions are not inherited.=
 &nbsp;They<br>
cover only the immediate children of the node where they appear.<br>
Otherwise the default values apply (address-cells =3D=3D 2, size-cells =3D=
=3D<br>
1), which are not right for your case.<br>
<font color=3D"#888888"><br>
--<br>
David Gibson &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp;| I&#39;ll have my music baroque, and my code<br>
david AT <a href=3D"http://gibson.dropbear.id.au" target=3D"_blank">gibson.=
dropbear.id.au</a> &nbsp;| minimalist, thank you. &nbsp;NOT _the_ _other_<b=
r>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| _way_ _around_!<br>
<a href=3D"http://www.ozlabs.org/%7Edgibson" target=3D"_blank">http://www.o=
zlabs.org/~dgibson</a><br>
</font></blockquote></div>OK, so, after having tested, I can&#39;t see any =
changes when booting.<br>I do not have more mtd in /proc/mtd.<br><br>JM<br>

--0016e6d3766160406b0462b8cf92--
