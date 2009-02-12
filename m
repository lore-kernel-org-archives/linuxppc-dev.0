Return-Path: <jhautbois@gmail.com>
Received: from mail-bw0-f168.google.com (mail-bw0-f168.google.com
	[209.85.218.168]) by ozlabs.org (Postfix) with ESMTP id 5A3A1DDDB9
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 01:27:02 +1100 (EST)
Received: by bwz12 with SMTP id 12so1870300bwz.9
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 06:27:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <49942D68.7080706@vastech.co.za>
References: <8cad0aa0902120123p27cfe32fg6bf08d458178c937@mail.gmail.com>
	<49940265.1020700@vastech.co.za>
	<8cad0aa0902120310g44a3bf3cla4ffa94ea9bf5dc6@mail.gmail.com>
	<20090212133037.GA3651@yookeroo.seuss>
	<8cad0aa0902120536p3303322cvf9a7307391d195b9@mail.gmail.com>
	<49942D68.7080706@vastech.co.za>
Date: Thu, 12 Feb 2009 15:26:58 +0100
Message-ID: <8cad0aa0902120626v733011a5u669fc30096565d86@mail.gmail.com>
Subject: Re: [MPC8272ADS]Problem adding flash partitions inside the device
	tree
From: Jean-Michel Hautbois <jhautbois@gmail.com>
To: Pieter <phenning@vastech.co.za>
Content-Type: multipart/alternative; boundary=0016e6d376615091340462b9837b
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0016e6d376615091340462b9837b
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

2009/2/12 Pieter <phenning@vastech.co.za>

> Jean-Michel Hautbois wrote:
> > 2009/2/12 David Gibson <david@gibson.dropbear.id.au
> > <mailto:david@gibson.dropbear.id.au>>
> >
> >     On Thu, Feb 12, 2009 at 12:10:58PM +0100, Jean-Michel Hautbois wrote:
> >     > 2009/2/12 Pieter <phenning@vastech.co.za
> >     <mailto:phenning@vastech.co.za>>
> >     >
> >     > > Jean-Michel Hautbois wrote:
> >     > > > Warning (reg_format): "reg" property in
> >     > > > /localbus@f0010100/flash@0,0/partition@ff800000 has invalid
> >     length (8
> >     > > > JM
> >     > > You are missing some definitions, The #address-cells and
> >     #size-cells = <1>;
> >     > > tis is a snippet of teh dts i defined for my board.
> >     > >
> >     > >        flash@0,0 {
> >     > >            #address-cells = <1>;
> >     > >            #size-cells = <1>;
> >     > >            compatible = "cfi-flash";
> >     > >            reg = <0x0 0x0 0x08000000>;
> >     > >             bank-width = <4>;
> >     > >            device-width = <1>;
> >     > >
> >     > >             /* set flash partition to correspond tu mtd parts in
> >     > > u-boot*/
> >     > >            /*     0xf8000000 */
> >     > >            partition@0x0 {
> >     > >                label = "factory-image";
> >     > >                reg = <0x00000000 0x01000000>;
> >     > >            };
> >     > >            /*     0xf9000000 */
> >     > >            partition@0x01000000 {
> >     > >                label = "app-image-1";
> >     > >                reg = <0x01000000 0x01000000>;
> >     > >            };
> >     > > cheers pieter
> >     > >
> >     >
> >     > Hi do have these definitions, at a higher level:
> >
> >     The address-cells and size-cells definitions are not inherited.  They
> >     cover only the immediate children of the node where they appear.
> >     Otherwise the default values apply (address-cells == 2, size-cells ==
> >     1), which are not right for your case.
> >
> >     --
> >     David Gibson                    | I'll have my music baroque, and
> >     my code
> >     david AT gibson.dropbear.id.au <http://gibson.dropbear.id.au>  |
> >     minimalist, thank you.  NOT _the_ _other_
> >                                    | _way_ _around_!
> >     http://www.ozlabs.org/~dgibson <http://www.ozlabs.org/%7Edgibson> <
> http://www.ozlabs.org/%7Edgibson>
> >
> > OK, so, after having tested, I can't see any changes when booting.
> > I do not have more mtd in /proc/mtd.
> >
> > JM
> have you defined the following in your kernel  config
>
> CONFIG_MTD_PHYSMAP_OF=y
> CONFIG_MTD_PARTITIONS=y
> CONFIG_MTD_OF_PARTS=y
>
> cheers pieter
>

I didn't have CONFIG_MTD_OF_PARTS=y.

Know, I have this output:

 Found: Intel I28F016S3
fe000000.flash: Found 4 x8 devices at 0x0 in 32-bit bank
fe000000.flash: Found an alias at 0x800000 for the chip at 0x0
fe000000.flash: Found an alias at 0x1000000 for the chip at 0x0
fe000000.flash: Found an alias at 0x1800000 for the chip at 0x0
erase region 0: offset=0x0,size=0x40000,blocks=32
RedBoot partition parsing not available
Creating 3 MTD partitions on "fe000000.flash":
0x0000ff800000-0x0000ffc00000 : "kernel"
mtd: partition "kernel" is out of reach -- disabled
mtd: Giving out device 0 to kernel
0x0000ffc00000-0x0000fff00000 : "user"
mtd: partition "sofrel" is out of reach -- disabled
mtd: Giving out device 1 to user
0x0000fff00000-0x000100000000 : "u-boot"
mtd: partition "u-boot" is out of reach -- disabled
mtd: Giving out device 2 to u-boot

I think that the problem is in the reg part, but I can't understand why.
Isn't it the RAM mpping of my MTD that is the first address ?

Thanks agains,
Regards,
JM

--0016e6d376615091340462b9837b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">2009/2/12 Pieter <span dir=3D"ltr">&lt;<a href=
=3D"mailto:phenning@vastech.co.za">phenning@vastech.co.za</a>&gt;</span><br=
><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204,=
 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class=3D"Ih2E3d">Jean-Michel Hautbois wrote:<br>
&gt; 2009/2/12 David Gibson &lt;<a href=3D"mailto:david@gibson.dropbear.id.=
au">david@gibson.dropbear.id.au</a><br>
</div>&gt; &lt;mailto:<a href=3D"mailto:david@gibson.dropbear.id.au">david@=
gibson.dropbear.id.au</a>&gt;&gt;<br>
<div class=3D"Ih2E3d">&gt;<br>
&gt; &nbsp; &nbsp; On Thu, Feb 12, 2009 at 12:10:58PM +0100, Jean-Michel Ha=
utbois wrote:<br>
&gt; &nbsp; &nbsp; &gt; 2009/2/12 Pieter &lt;<a href=3D"mailto:phenning@vas=
tech.co.za">phenning@vastech.co.za</a><br>
</div>&gt; &nbsp; &nbsp; &lt;mailto:<a href=3D"mailto:phenning@vastech.co.z=
a">phenning@vastech.co.za</a>&gt;&gt;<br>
<div><div></div><div class=3D"Wj3C7c">&gt; &nbsp; &nbsp; &gt;<br>
&gt; &nbsp; &nbsp; &gt; &gt; Jean-Michel Hautbois wrote:<br>
&gt; &nbsp; &nbsp; &gt; &gt; &gt; Warning (reg_format): &quot;reg&quot; pro=
perty in<br>
&gt; &nbsp; &nbsp; &gt; &gt; &gt; /localbus@f0010100/flash@0,0/partition@ff=
800000 has invalid<br>
&gt; &nbsp; &nbsp; length (8<br>
&gt; &nbsp; &nbsp; &gt; &gt; &gt; JM<br>
&gt; &nbsp; &nbsp; &gt; &gt; You are missing some definitions, The #address=
-cells and<br>
&gt; &nbsp; &nbsp; #size-cells =3D &lt;1&gt;;<br>
&gt; &nbsp; &nbsp; &gt; &gt; tis is a snippet of teh dts i defined for my b=
oard.<br>
&gt; &nbsp; &nbsp; &gt; &gt;<br>
&gt; &nbsp; &nbsp; &gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp;flash@0,0 {<br>
&gt; &nbsp; &nbsp; &gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#addr=
ess-cells =3D &lt;1&gt;;<br>
&gt; &nbsp; &nbsp; &gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#size=
-cells =3D &lt;1&gt;;<br>
&gt; &nbsp; &nbsp; &gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;compa=
tible =3D &quot;cfi-flash&quot;;<br>
&gt; &nbsp; &nbsp; &gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;reg =
=3D &lt;0x0 0x0 0x08000000&gt;;<br>
&gt; &nbsp; &nbsp; &gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; bank=
-width =3D &lt;4&gt;;<br>
&gt; &nbsp; &nbsp; &gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;devic=
e-width =3D &lt;1&gt;;<br>
&gt; &nbsp; &nbsp; &gt; &gt;<br>
&gt; &nbsp; &nbsp; &gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /* s=
et flash partition to correspond tu mtd parts in<br>
&gt; &nbsp; &nbsp; &gt; &gt; u-boot*/<br>
&gt; &nbsp; &nbsp; &gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* &n=
bsp; &nbsp; 0xf8000000 */<br>
&gt; &nbsp; &nbsp; &gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;parti=
tion@0x0 {<br>
&gt; &nbsp; &nbsp; &gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;label =3D &quot;factory-image&quot;;<br>
&gt; &nbsp; &nbsp; &gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;reg =3D &lt;0x00000000 0x01000000&gt;;<br>
&gt; &nbsp; &nbsp; &gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;};<br=
>
&gt; &nbsp; &nbsp; &gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* &n=
bsp; &nbsp; 0xf9000000 */<br>
&gt; &nbsp; &nbsp; &gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;parti=
tion@0x01000000 {<br>
&gt; &nbsp; &nbsp; &gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;label =3D &quot;app-image-1&quot;;<br>
&gt; &nbsp; &nbsp; &gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;reg =3D &lt;0x01000000 0x01000000&gt;;<br>
&gt; &nbsp; &nbsp; &gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;};<br=
>
&gt; &nbsp; &nbsp; &gt; &gt; cheers pieter<br>
&gt; &nbsp; &nbsp; &gt; &gt;<br>
&gt; &nbsp; &nbsp; &gt;<br>
&gt; &nbsp; &nbsp; &gt; Hi do have these definitions, at a higher level:<br=
>
&gt;<br>
&gt; &nbsp; &nbsp; The address-cells and size-cells definitions are not inh=
erited. &nbsp;They<br>
&gt; &nbsp; &nbsp; cover only the immediate children of the node where they=
 appear.<br>
&gt; &nbsp; &nbsp; Otherwise the default values apply (address-cells =3D=3D=
 2, size-cells =3D=3D<br>
&gt; &nbsp; &nbsp; 1), which are not right for your case.<br>
&gt;<br>
&gt; &nbsp; &nbsp; --<br>
&gt; &nbsp; &nbsp; David Gibson &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp;| I&#39;ll have my music baroque, and<br>
&gt; &nbsp; &nbsp; my code<br>
</div></div>&gt; &nbsp; &nbsp; david AT <a href=3D"http://gibson.dropbear.i=
d.au" target=3D"_blank">gibson.dropbear.id.au</a> &lt;<a href=3D"http://gib=
son.dropbear.id.au" target=3D"_blank">http://gibson.dropbear.id.au</a>&gt; =
&nbsp;|<br>
<div class=3D"Ih2E3d">&gt; &nbsp; &nbsp; minimalist, thank you. &nbsp;NOT _=
the_ _other_<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| _way_ _around_!<br=
>
</div>&gt; &nbsp; &nbsp; <a href=3D"http://www.ozlabs.org/%7Edgibson" targe=
t=3D"_blank">http://www.ozlabs.org/~dgibson</a> &lt;<a href=3D"http://www.o=
zlabs.org/%7Edgibson" target=3D"_blank">http://www.ozlabs.org/%7Edgibson</a=
>&gt;<br>
<div class=3D"Ih2E3d">&gt;<br>
&gt; OK, so, after having tested, I can&#39;t see any changes when booting.=
<br>
&gt; I do not have more mtd in /proc/mtd.<br>
&gt;<br>
&gt; JM<br>
</div>have you defined the following in your kernel &nbsp;config<br>
<br>
CONFIG_MTD_PHYSMAP_OF=3Dy<br>
CONFIG_MTD_PARTITIONS=3Dy<br>
CONFIG_MTD_OF_PARTS=3Dy<br>
<br>
cheers pieter<br>
</blockquote><div><br>I didn&#39;t have CONFIG_MTD_OF_PARTS=3Dy.<br><br>Kno=
w, I have this output:<br><br>&nbsp;Found: Intel I28F016S3<br>fe000000.flas=
h: Found 4 x8 devices at 0x0 in 32-bit bank<br>fe000000.flash: Found an ali=
as at 0x800000 for the chip at 0x0<br>
fe000000.flash: Found an alias at 0x1000000 for the chip at 0x0<br>fe000000=
.flash: Found an alias at 0x1800000 for the chip at 0x0<br>erase region 0: =
offset=3D0x0,size=3D0x40000,blocks=3D32<br>RedBoot partition parsing not av=
ailable<br>
Creating 3 MTD partitions on &quot;fe000000.flash&quot;:<br>0x0000ff800000-=
0x0000ffc00000 : &quot;kernel&quot;<br>mtd: partition &quot;kernel&quot; is=
 out of reach -- disabled<br>mtd: Giving out device 0 to kernel<br>0x0000ff=
c00000-0x0000fff00000 : &quot;user&quot;<br>
mtd: partition &quot;sofrel&quot; is out of reach -- disabled<br>mtd: Givin=
g out device 1 to user<br>0x0000fff00000-0x000100000000 : &quot;u-boot&quot=
;<br>mtd: partition &quot;u-boot&quot; is out of reach -- disabled<br>mtd: =
Giving out device 2 to u-boot</div>
</div><br>I think that the problem is in the reg part, but I can&#39;t unde=
rstand why.<br>Isn&#39;t it the RAM mpping of my MTD that is the first addr=
ess ?<br><br>Thanks agains,<br>Regards,<br>JM<br>

--0016e6d376615091340462b9837b--
