Return-Path: <sebastien.chretien.enseirb@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.234])
	by ozlabs.org (Postfix) with ESMTP id 7D5D8DE084
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 22:15:26 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so382960rvb.9
	for <linuxppc-dev@ozlabs.org>; Thu, 07 Aug 2008 05:15:25 -0700 (PDT)
Message-ID: <319b0ac50808070515o7a28cf34ue190dd3dba0ee157@mail.gmail.com>
Date: Thu, 7 Aug 2008 14:15:24 +0200
From: "=?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?="
	<sebastien.chretien.enseirb@gmail.com>
To: "Juergen Beisert" <j.beisert@pengutronix.de>
Subject: Re: Powerpc and ioremap
In-Reply-To: <200808071223.11156.j.beisert@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_12157_31353981.1218111324996"
References: <319b0ac50808070254x27606b48sb15fb4ee6105c6c6@mail.gmail.com>
	<200808071223.11156.j.beisert@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_12157_31353981.1218111324996
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Thanks for your answer.
But it doesn't work.
I think ioremap create a kernel panic. But I can't see because i have no
UART ready.
Is there a way in order to trace the failure ?

2008/8/7, Juergen Beisert <j.beisert@pengutronix.de>:
>
> Am Donnerstag, 7. August 2008 11:54 schrieb S=E9bastien Chr=E9tien:
>
> > Hello,
> >
> > I am trying to port linux on my Powerpc Board. I have used Linux 2.6.26
> and
> > gcc 3.4.5.
> > I have used Uboot 1.2.
> > Linux seems running from _start to udbg_early_init(). That's why I
> > develloped a udbg_driver.
> > It must write in a register which is located at 0x2001b044. So I wrote =
:
> >
> > void __iomem *p;
> > p=3Dioremap(0x2001b044,4);
> > iowrite32('O',p);
> > iowrite32('K',p);
>
>
> try
>
> p=3Dioremap(0x2001b000, 0x1000);
> iowrite32('O',p + 0x44);
> iowrite32('K',p + 0x44);
>
> instead.
>
> jbe
>
> --
>   Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
>   Pengutronix - Linux Solutions for Science and Industry
>    Handelsregister:  Amtsgericht Hildesheim, HRA 2686
>      Hannoversche Str. 2, 31134 Hildesheim, Germany
>    Phone: +49-5121-206917-7 |  Fax: +49-5121-206917-9
>

------=_Part_12157_31353981.1218111324996
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Thanks for your answer.<br>
But it doesn&#39;t work.<br>
I think ioremap create a kernel panic. But I can&#39;t see because i have n=
o UART ready. <br>
Is there a way in order to trace the failure ?<br><br><div><span class=3D"g=
mail_quote">2008/8/7, Juergen Beisert &lt;<a href=3D"mailto:j.beisert@pengu=
tronix.de">j.beisert@pengutronix.de</a>&gt;:</span><blockquote class=3D"gma=
il_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0=
pt 0pt 0.8ex; padding-left: 1ex;">
Am Donnerstag, 7. August 2008 11:54 schrieb S=E9bastien Chr=E9tien:<br> <br=
>&gt; Hello,<br> &gt;<br> &gt; I am trying to port linux on my Powerpc Boar=
d. I have used Linux 2.6.26 and<br> &gt; gcc <a href=3D"http://3.4.5.">3.4.=
5.</a><br>
 &gt; I have used Uboot 1.2.<br> &gt; Linux seems running from _start to ud=
bg_early_init(). That&#39;s why I<br> &gt; develloped a udbg_driver.<br> &g=
t; It must write in a register which is located at 0x2001b044. So I wrote :=
<br>
 &gt;<br> &gt; void __iomem *p;<br> &gt; p=3Dioremap(0x2001b044,4);<br> &gt=
; iowrite32(&#39;O&#39;,p);<br> &gt; iowrite32(&#39;K&#39;,p);<br> <br> <br=
>try<br> <br> p=3Dioremap(0x2001b000, 0x1000);<br> iowrite32(&#39;O&#39;,p =
+ 0x44);<br>
 iowrite32(&#39;K&#39;,p + 0x44);<br> <br> instead.<br> <br> jbe<br> <br>--=
<br>&nbsp;&nbsp;Dipl.-Ing. Juergen Beisert | <a href=3D"http://www.pengutro=
nix.de">http://www.pengutronix.de</a><br>&nbsp;&nbsp;Pengutronix - Linux So=
lutions for Science and Industry<br>
&nbsp;&nbsp; Handelsregister:&nbsp;&nbsp;Amtsgericht Hildesheim, HRA 2686<b=
r>&nbsp;&nbsp;&nbsp;&nbsp; Hannoversche Str. 2, 31134 Hildesheim, Germany<b=
r>&nbsp;&nbsp; Phone: +49-5121-206917-7 |&nbsp;&nbsp;Fax: +49-5121-206917-9=
<br> </blockquote></div><br>

------=_Part_12157_31353981.1218111324996--
