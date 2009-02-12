Return-Path: <jhautbois@gmail.com>
Received: from mail-fx0-f11.google.com (mail-fx0-f11.google.com
	[209.85.220.11]) by ozlabs.org (Postfix) with ESMTP id DA1CCDDDDF
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 22:11:11 +1100 (EST)
Received: by fxm4 with SMTP id 4so2759443fxm.9
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 03:11:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <49940265.1020700@vastech.co.za>
References: <8cad0aa0902120123p27cfe32fg6bf08d458178c937@mail.gmail.com>
	<49940265.1020700@vastech.co.za>
Date: Thu, 12 Feb 2009 12:10:58 +0100
Message-ID: <8cad0aa0902120310g44a3bf3cla4ffa94ea9bf5dc6@mail.gmail.com>
Subject: Re: [MPC8272ADS]Problem adding flash partitions inside the device
	tree
From: Jean-Michel Hautbois <jhautbois@gmail.com>
To: Pieter <phenning@vastech.co.za>
Content-Type: multipart/alternative; boundary=001636c5b1fa64dd530462b6c67f
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--001636c5b1fa64dd530462b6c67f
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

2009/2/12 Pieter <phenning@vastech.co.za>

> Jean-Michel Hautbois wrote:
> > Warning (reg_format): "reg" property in
> > /localbus@f0010100/flash@0,0/partition@ff800000 has invalid length (8
> > JM
> You are missing some definitions, The #address-cells and #size-cells = <1>;
> tis is a snippet of teh dts i defined for my board.
>
>        flash@0,0 {
>            #address-cells = <1>;
>            #size-cells = <1>;
>            compatible = "cfi-flash";
>            reg = <0x0 0x0 0x08000000>;
>             bank-width = <4>;
>            device-width = <1>;
>
>             /* set flash partition to correspond tu mtd parts in
> u-boot*/
>            /*     0xf8000000 */
>            partition@0x0 {
>                label = "factory-image";
>                reg = <0x00000000 0x01000000>;
>            };
>            /*     0xf9000000 */
>            partition@0x01000000 {
>                label = "app-image-1";
>                reg = <0x01000000 0x01000000>;
>            };
> cheers pieter
>

Hi do have these definitions, at a higher level:
 localbus@f0010100 {
                compatible = "fsl,mpc8272-localbus",
                             "fsl,pq2-localbus";
                #address-cells = <2>;
                #size-cells = <1>;
                reg = <0xf0010100 0x40>;

                ranges = <0x0 0x0 0xfe000000 0x2000000
                          0x1 0x0 0xf4500000 0x8000
                          0x3 0x0 0xf8200000 0x8000>;

                flash@0,0 {
etc.

Regards,
JM

--001636c5b1fa64dd530462b6c67f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">2009/2/12 Pieter <span dir=3D"ltr">&lt;<a href=
=3D"mailto:phenning@vastech.co.za" target=3D"_blank">phenning@vastech.co.za=
</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"border-left: =
1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;=
">

<div><div><div class=3D"Ih2E3d">Jean-Michel Hautbois wrote:<br>
&gt; Warning (reg_format): &quot;reg&quot; property in<br>
&gt; /localbus@f0010100/flash@0,0/partition@ff800000 has invalid length (8<=
br></div>
&gt; JM<br>
</div></div><div class=3D"Ih2E3d">You are missing some definitions, The #ad=
dress-cells and #size-cells =3D &lt;1&gt;;<br>
tis is a snippet of teh dts i defined for my board.<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp;flash@0,0 {<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#address-cells =3D &lt;1&gt;;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#size-cells =3D &lt;1&gt;;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;compatible =3D &quot;cfi-flash&qu=
ot;;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;reg =3D &lt;0x0 0x0 0x08000000&gt=
;;<br>
<div> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;bank-width =3D &lt;4&gt;;<br=
>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;device-width =3D &lt;1&gt;;<br>
<br>
</div> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* set flash partition to c=
orrespond tu mtd parts in<br>
u-boot*/<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* &nbsp; &nbsp; 0xf8000000 */<br=
>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;partition@0x0 {<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;label =3D &quot;fac=
tory-image&quot;;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;reg =3D &lt;0x00000=
000 0x01000000&gt;;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;};<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* &nbsp; &nbsp; 0xf9000000 */<br=
>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;partition@0x01000000 {<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;label =3D &quot;app=
-image-1&quot;;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;reg =3D &lt;0x01000=
000 0x01000000&gt;;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;};<br>
cheers pieter</div></blockquote><div><br>Hi do have these definitions, at a=
 higher level:<br>&nbsp;localbus@f0010100 {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible =
=3D &quot;fsl,mpc8272-localbus&quot;,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;fsl,pq2-l=
ocalbus&quot;;<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; #address-cells =3D &lt;2&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #size-cell=
s =3D &lt;1&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D &lt;0xf0010100 0x40&gt;;<br><br=
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; ranges =3D &lt;0x0 0x0 0xfe000000 0x2000000<br>&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1 0x0 0x=
f4500000 0x8000<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 0x3 0x0 0xf8200000 0x8000&gt;;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flash@0,0 {<br>etc.<=
br></div></div><br>Regards,<br><font color=3D"#888888">JM</font><br>

--001636c5b1fa64dd530462b6c67f--
