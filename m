Return-Path: <jcrigby@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by ozlabs.org (Postfix) with ESMTP id C5500DDE3D
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  4 Jul 2007 02:31:01 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so360417anc
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 03 Jul 2007 09:31:00 -0700 (PDT)
Message-ID: <4b73d43f0707030931v42aefc72x2598546e48ae87e8@mail.gmail.com>
Date: Tue, 3 Jul 2007 10:31:00 -0600
From: "John Rigby" <jcrigby@gmail.com>
To: "=?ISO-8859-1?Q?K=E1ri_Dav=ED=F0sson?=" <kari.davidsson@marel.is>
Subject: Re: OF devices and non OF devices
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB020D3B9D@is-hdq-exchange.marel.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_113345_11808954.1183480260155"
References: <DD39B5C3F4963040ADC9768BE7E430CB020D3B9D@is-hdq-exchange.marel.net>
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

------=_Part_113345_11808954.1183480260155
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

One place to find binding between OF devices and non OF devices is in
arch/powerpc/sysdev/fsl_soc.c
The typical pattern is:
    if of_find_compatible_node "of-device-name"
        platform_device_register_simple ""platform-device-name"
        platform_device_add_data ...


On 7/3/07, K=E1ri Dav=ED=F0sson <kari.davidsson@marel.is> wrote:
>
> Hi,
>
> I am attempting to get some non OF devices working for an mpc 5200 board,
> in particular
> PCF8563 RTC.
>
> This device has an non OF device interface which I believe is correct.
> After all it should work
> on non OF platforms.
>
> I have managed to get the board to run the i2c initialization (and probe)
> for the fsl-mpc i2c driver by
> converting the fsl-mpc i2c driver to OF driver (I found some patch here
> that I based this work on).


fsl-i2c is one of the devices handled by fsl_soc.c so you shouldn't need to
change anything to
make it work in the latest kernel.  CONFIG_FSL_SOC was only added to
lite5200_defconfig recently so
that may explain why it's not on in your kernel.

Since the PCF8563 driver is not OF driver only its initaliziation code is
> run but the .probe function
> of the driver is never run. Basically (as far as I can understand) the
> .probe is never run because the
> driver is not an OF driver.
>
> I could convert the PCF8563 driver to OF driver and make it work for our
> puposes but I feel this is
> 1) Wrong
> 2) therefore wasted work.


Since the driver must run on non OF platforms then it should not be
converted.  You just need to add a platform_device_register somewhere.
I don't think fsl_soc.c is  the right place since it is not part of an
freescale SOC.
You could probably put it in a board specific startup routine.

What seems to elude me is some glue that glues together the OF part of the
> driver space to the non OF part
> of the driver space.
>
> Any hints or pointers on where to find this glue?
>
> Regards,
> kd
>
> P.S. Kernel is post 2.6.20.
>
> --
> K=E1ri Dav=ED=F0sson                   | kari.davidsson@marel.is
> Hugb=FAna=F0arger=F0                   | www.marel.com
> Tel: 563-8156 Fax: +354 563 8001
> Iceland
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

------=_Part_113345_11808954.1183480260155
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

One place to find binding between OF devices and non OF devices is in arch/=
powerpc/sysdev/fsl_soc.c<br>The typical pattern is:<br>&nbsp;&nbsp;&nbsp; i=
f of_find_compatible_node &quot;of-device-name&quot;<br>&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; platform_device_register_simple &quot;&quot;platfor=
m-device-name&quot;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; platform_device_add_data ...=
<br><br>&nbsp; <br><div><span class=3D"gmail_quote">On 7/3/07, <b class=3D"=
gmail_sendername">K=E1ri Dav=ED=F0sson</b> &lt;<a href=3D"mailto:kari.david=
sson@marel.is">kari.davidsson@marel.is</a>&gt; wrote:
</span><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rg=
b(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi,<br><br=
>I am attempting to get some non OF devices working for an mpc 5200 board, =
in particular
<br>PCF8563 RTC.<br><br>This device has an non OF device interface which I =
believe is correct. After all it should work<br>on non OF platforms.<br><br=
>I have managed to get the board to run the i2c initialization (and probe) =
for the fsl-mpc i2c driver by
<br>converting the fsl-mpc i2c driver to OF driver (I found some patch here=
 that I based this work on).</blockquote><div><br>fsl-i2c is one of the dev=
ices handled by fsl_soc.c so you shouldn&#39;t need to change anything to
<br>make it work in the latest kernel.&nbsp; CONFIG_FSL_SOC was only added =
to lite5200_defconfig recently so <br>that may explain why it&#39;s not on =
in your kernel.<br></div><br><blockquote class=3D"gmail_quote" style=3D"bor=
der-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-=
left: 1ex;">
Since the PCF8563 driver is not OF driver only its initaliziation code is r=
un but the .probe function<br>of the driver is never run. Basically (as far=
 as I can understand) the .probe is never run because the<br>driver is not =
an OF driver.
<br><br>I could convert the PCF8563 driver to OF driver and make it work fo=
r our puposes but I feel this is<br>1) Wrong<br>2) therefore wasted work.</=
blockquote><div><br>Since the driver must run on non OF platforms then it s=
hould not be converted.&nbsp; You just need to add a platform_device_regist=
er somewhere.
<br>I don&#39;t think fsl_soc.c is&nbsp; the right place since it is not pa=
rt of an freescale SOC.<br>You could probably put it in a board specific st=
artup routine.<br></div><br><blockquote class=3D"gmail_quote" style=3D"bord=
er-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-l=
eft: 1ex;">
What seems to elude me is some glue that glues together the OF part of the =
driver space to the non OF part<br>of the driver space.<br><br>Any hints or=
 pointers on where to find this glue?<br><br>Regards,<br>kd<br><br>P.S. Ker=
nel is post=20
2.6.20.<br><br>--<br>K=E1ri Dav=ED=F0sson&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
| <a href=3D"mailto:kari.davidsson@marel.is">kari.davidsson@marel.is</a><br=
>Hugb=FAna=F0arger=F0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | <a href=3D"http://=
www.marel.com">www.marel.com</a><br>Tel: 563-8156 Fax: +354 563 8001
<br>Iceland<br>_______________________________________________<br>Linuxppc-=
embedded mailing list<br><a href=3D"mailto:Linuxppc-embedded@ozlabs.org">Li=
nuxppc-embedded@ozlabs.org</a><br><a href=3D"https://ozlabs.org/mailman/lis=
tinfo/linuxppc-embedded">
https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br></blockquote><=
/div><br>

------=_Part_113345_11808954.1183480260155--
