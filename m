Return-Path: <jcrigby@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.244])
	by ozlabs.org (Postfix) with ESMTP id 2CC82DDF1B
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Jul 2007 23:28:59 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so463703anc
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 05 Jul 2007 06:28:58 -0700 (PDT)
Message-ID: <4b73d43f0707050628qd9db2afu3b63dd654be32646@mail.gmail.com>
Date: Thu, 5 Jul 2007 07:28:58 -0600
From: "John Rigby" <jcrigby@gmail.com>
To: "=?ISO-8859-1?Q?K=E1ri_Dav=ED=F0sson?=" <kari.davidsson@marel.is>
Subject: Re: OF devices and non OF devices
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB020D3DE8@is-hdq-exchange.marel.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_136332_19808847.1183642138434"
References: <4b73d43f0707030931v42aefc72x2598546e48ae87e8@mail.gmail.com>
	<DD39B5C3F4963040ADC9768BE7E430CB020D3DE8@is-hdq-exchange.marel.net>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_136332_19808847.1183642138434
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

kd,

Ok, obviously It doesn't work the way I thought.  Hopefully someone who doe=
s
understand this will comment.

John

On 7/4/07, K=E1ri Dav=ED=F0sson <kari.davidsson@marel.is> wrote:
>
> John, thank you for your answare.
>
> Enabling CONFIG_FSL_SOC only enabled the execution of the init function
> (fsl_i2c_init())
> of the fsl-i2c driver (i2c-mpc.c). The .probe function of the driver was
> never called
> until I converted the driver to the OF model and added the .match_table t=
o
> the driver structure.
>
> Then I get the .probe function (fsl_i2c_probe()) called and the i2c bus
> set up.
>
> Similar thing happens for the i2c device PCF8563 i.e., the init functin o=
f
> the driver (pcf8563_init())
> is called the driver is registered with the kernel, but the .probe
> (pcf8563_probe()) is never called.
>
> The driver pcf8563 has _NO_ exported structures or functions so I
> basically have no handle on it
> that I can utilize in board specific setup.
>
> The way I suspect this is supposed to work is that from the board settup
> files I would do
> rtc_dev =3D platform_device_register_simple("pcf8563", -1, NULL, 0);
> which should later trigger the calling of the pcf8563_probe() function.
>
> This is doing things in the same way as the fsl i2c code, i.e.
> i2c_dev =3D platform_device_register_simple("i2c", i, r, 2);
> which by the way does not work untill I have converted the fsl_i2c (
> i2c-mpc.c) driver to the OF structure.
>
> So still the method of gluing together the OF drivers and non OF drivers
> eludes me.
>
> rg
> kd
>
> P.S. I did check the 2.6.21-RC7-git3 and found that the i2c-mpc.c and the
> rtc-pcf85763.c are basically the same
> as what I am working with in 2.6.20+
> ________________________________
>
> From: John Rigby [mailto:jcrigby@gmail.com]
> Sent: 3. j=FAl=ED 2007 16:31
> To: K=E1ri Dav=ED=F0sson
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: OF devices and non OF devices
>
>
> One place to find binding between OF devices and non OF devices is in
> arch/powerpc/sysdev/fsl_soc.c
> The typical pattern is:
>     if of_find_compatible_node "of-device-name"
>         platform_device_register_simple ""platform-device-name"
>         platform_device_add_data ...
>
>
>
> On 7/3/07, K=E1ri Dav=ED=F0sson <kari.davidsson@marel.is> wrote:
>
>         Hi,
>
>         I am attempting to get some non OF devices working for an mpc 520=
0
> board, in particular
>         PCF8563 RTC.
>
>         This device has an non OF device interface which I believe is
> correct. After all it should work
>         on non OF platforms.
>
>         I have managed to get the board to run the i2c initialization (an=
d
> probe) for the fsl-mpc i2c driver by
>         converting the fsl-mpc i2c driver to OF driver (I found some patc=
h
> here that I based this work on).
>
>
> fsl-i2c is one of the devices handled by fsl_soc.c so you shouldn't need
> to change anything to
> make it work in the latest kernel.  CONFIG_FSL_SOC was only added to
> lite5200_defconfig recently so
> that may explain why it's not on in your kernel.
>
>
>
>         Since the PCF8563 driver is not OF driver only its initaliziation
> code is run but the .probe function
>         of the driver is never run. Basically (as far as I can understand=
)
> the .probe is never run because the
>         driver is not an OF driver.
>
>         I could convert the PCF8563 driver to OF driver and make it work
> for our puposes but I feel this is
>         1) Wrong
>         2) therefore wasted work.
>
>
> Since the driver must run on non OF platforms then it should not be
> converted.  You just need to add a platform_device_register somewhere.
> I don't think fsl_soc.c is  the right place since it is not part of an
> freescale SOC.
> You could probably put it in a board specific startup routine.
>
>
>
>         What seems to elude me is some glue that glues together the OF
> part of the driver space to the non OF part
>         of the driver space.
>
>         Any hints or pointers on where to find this glue?
>
>         Regards,
>         kd
>
>         P.S. Kernel is post 2.6.20.
>
>         --
>         K=E1ri Dav=ED=F0sson                   | kari.davidsson@marel.is
>         Hugb=FAna=F0arger=F0                   | www.marel.com
>         Tel: 563-8156 Fax: +354 563 8001
>         Iceland
>         _______________________________________________
>         Linuxppc-embedded mailing list
>         Linuxppc-embedded@ozlabs.org
>         https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

------=_Part_136332_19808847.1183642138434
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

kd,<br><br>Ok, obviously It doesn&#39;t work the way I thought.&nbsp; Hopef=
ully someone who does<br>understand this will comment.<br><br>John<br><br><=
div><span class=3D"gmail_quote">On 7/4/07, <b class=3D"gmail_sendername">K=
=E1ri Dav=ED=F0sson
</b> &lt;<a href=3D"mailto:kari.davidsson@marel.is">kari.davidsson@marel.is=
</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"border-lef=
t: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1=
ex;">
John, thank you for your answare.<br><br>Enabling CONFIG_FSL_SOC only enabl=
ed the execution of the init function (fsl_i2c_init())<br>of the fsl-i2c dr=
iver (i2c-mpc.c). The .probe function of the driver was never called<br>
until I converted the driver to the OF model and added the .match_table to =
the driver structure.<br><br>Then I get the .probe function (fsl_i2c_probe(=
)) called and the i2c bus set up.<br><br>Similar thing happens for the i2c =
device PCF8563=20
i.e., the init functin of the driver (pcf8563_init())<br>is called the driv=
er is registered with the kernel, but the .probe (pcf8563_probe()) is never=
 called.<br><br>The driver pcf8563 has _NO_ exported structures or function=
s so I basically have no handle on it
<br>that I can utilize in board specific setup.<br><br>The way I suspect th=
is is supposed to work is that from the board settup files I would do<br>rt=
c_dev =3D platform_device_register_simple(&quot;pcf8563&quot;, -1, NULL, 0)=
;
<br>which should later trigger the calling of the pcf8563_probe() function.=
<br><br>This is doing things in the same way as the fsl i2c code, i.e.<br>i=
2c_dev =3D platform_device_register_simple(&quot;i2c&quot;, i, r, 2);<br>
which by the way does not work untill I have converted the fsl_i2c (i2c-mpc=
.c) driver to the OF structure.<br><br>So still the method of gluing togeth=
er the OF drivers and non OF drivers eludes me.<br><br>rg<br>kd<br><br>
P.S. I did check the 2.6.21-RC7-git3 and found that the i2c-mpc.c and the r=
tc-pcf85763.c are basically the same<br>as what I am working with in 2.6.20=
+<br>________________________________<br><br>From: John Rigby [mailto:<a hr=
ef=3D"mailto:jcrigby@gmail.com">
jcrigby@gmail.com</a>]<br>Sent: 3. j=FAl=ED 2007 16:31<br>To: K=E1ri Dav=ED=
=F0sson<br>Cc: <a href=3D"mailto:linuxppc-embedded@ozlabs.org">linuxppc-emb=
edded@ozlabs.org</a><br>Subject: Re: OF devices and non OF devices<br><br><=
br>One place to find binding between OF devices and non OF devices is in ar=
ch/powerpc/sysdev/fsl_soc.c
<br>The typical pattern is:<br>&nbsp;&nbsp;&nbsp;&nbsp;if of_find_compatibl=
e_node &quot;of-device-name&quot;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;platform_device_register_simple &quot;&quot;platform-device-name&=
quot;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;platform_device_ad=
d_data ...<br><br><br>
<br>On 7/3/07, K=E1ri Dav=ED=F0sson &lt;<a href=3D"mailto:kari.davidsson@ma=
rel.is">kari.davidsson@marel.is</a>&gt; wrote:<br><br>&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;Hi,<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;I am attempting to get some non OF devices working for an mpc 52=
00 board, in particular
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;PCF8563 RTC.<br><br>&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;This device has an non OF devi=
ce interface which I believe is correct. After all it should work<br>&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;on non OF platforms.<br><br>&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I have managed to get the board =
to run the i2c initialization (and probe) for the fsl-mpc i2c driver by
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;converting the fsl-mpc =
i2c driver to OF driver (I found some patch here that I based this work on)=
.<br><br><br>fsl-i2c is one of the devices handled by fsl_soc.c so you shou=
ldn&#39;t need to change anything to
<br>make it work in the latest kernel.&nbsp;&nbsp;CONFIG_FSL_SOC was only a=
dded to lite5200_defconfig recently so<br>that may explain why it&#39;s not=
 on in your kernel.<br><br><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;Since the PCF8563 driver is not OF driver only its initaliziation c=
ode is run but the .probe function
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;of the driver is never =
run. Basically (as far as I can understand) the .probe is never run because=
 the<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;driver is not an OF=
 driver.<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I could con=
vert the PCF8563 driver to OF driver and make it work for our puposes but I=
 feel this is
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1) Wrong<br>&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2) therefore wasted work.<br><br><br>S=
ince the driver must run on non OF platforms then it should not be converte=
d.&nbsp;&nbsp;You just need to add a platform_device_register somewhere.<br=
>I don&#39;t think fsl_soc.c is&nbsp;&nbsp;the right place since it is not =
part of an freescale SOC.
<br>You could probably put it in a board specific startup routine.<br><br><=
br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;What seems to elude =
me is some glue that glues together the OF part of the driver space to the =
non OF part<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;of the drive=
r space.
<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Any hints or pointe=
rs on where to find this glue?<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;Regards,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kd<b=
r><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;P.S. Kernel is post 2=
.6.20.<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;--<br>&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K=E1ri Dav=ED=F0sson&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; | <a href=3D"mailto:kari.davidsson@marel.is">
kari.davidsson@marel.is</a><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;Hugb=FAna=F0arger=F0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | <a href=3D"http=
://www.marel.com">www.marel.com</a><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;Tel: 563-8156 Fax: +354 563 8001<br>&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;Iceland<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;_______________________________________________
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Linuxppc-embedded maili=
ng list<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href=3D"mailt=
o:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a><br>&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href=3D"https://ozlabs.org/mail=
man/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxpp=
c-embedded
</a><br><br><br><br>_______________________________________________<br>Linu=
xppc-embedded mailing list<br><a href=3D"mailto:Linuxppc-embedded@ozlabs.or=
g">Linuxppc-embedded@ozlabs.org</a><br><a href=3D"https://ozlabs.org/mailma=
n/listinfo/linuxppc-embedded">
https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br></blockquote><=
/div><br>

------=_Part_136332_19808847.1183642138434--
