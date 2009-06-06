Return-Path: <jcrigby@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E4E18B70A0
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  7 Jun 2009 08:27:15 +1000 (EST)
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.237])
	by ozlabs.org (Postfix) with ESMTP id 291F0DDD0C
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Jun 2009 08:27:14 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f9so900636rvb.9
	for <linuxppc-dev@ozlabs.org>; Sat, 06 Jun 2009 15:27:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090606221618.701E0832E416@gemini.denx.de>
References: <1241641262-5202-1-git-send-email-wd@denx.de>
	<1241641262-5202-6-git-send-email-wd@denx.de>
	<4b73d43f0905071909v6e6e8b2el9eb6d4a1b9038f45@mail.gmail.com>
	<20090606221618.701E0832E416@gemini.denx.de>
Date: Sat, 6 Jun 2009 16:27:13 -0600
Message-ID: <4b73d43f0906061527p7ca1b301ybcfc576870a168d5@mail.gmail.com>
Subject: Re: [PATCH 05/04] *** NOT FOR RELEASE *** HACK *** Work around MII
	clock issue ***
From: John Rigby <jcrigby@gmail.com>
To: Wolfgang Denk <wd@denx.de>
Content-Type: multipart/alternative; boundary=000e0cd14690bccee8046bb582b5
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--000e0cd14690bccee8046bb582b5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

I noticed the latest BSP from Freescale has this patch:

From: Chen Hongjun <Hong-jun.chen@freecale.com>
Date: Thu, 16 Apr 2009 20:22:52 +0800
Subject: [PATCH] Fixed FEC bug for bluestone board.

Signed-off-by: Chen Hongjun <Hong-jun.chen@freecale.com>
---
 drivers/net/fs_enet/mii-fec.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/fs_enet/mii-fec.c b/drivers/net/fs_enet/mii-fec.c
index 13a7d66..53d01a8 100644
--- a/drivers/net/fs_enet/mii-fec.c
+++ b/drivers/net/fs_enet/mii-fec.c
@@ -208,7 +208,7 @@ static int __devinit fs_enet_mdio_probe(struct of_device
*ofdev,
        if (!fec->fecp)
                goto out_fec;

-       fec->mii_speed = ((ppc_proc_freq + 4999999) / 5000000) << 1;
+       fec->mii_speed = ((((ppc_proc_freq + 4999999) / 2500000) / 2) &
0x3F) << 1;

        setbits32(&fec->fecp->fec_r_cntrl, FEC_RCNTRL_MII_MODE);
        setbits32(&fec->fecp->fec_ecntrl, FEC_ECNTRL_PINMUX |
-- 
1.5.4


On Sat, Jun 6, 2009 at 4:16 PM, Wolfgang Denk <wd@denx.de> wrote:

> Dear John,
>
> In message <4b73d43f0905071909v6e6e8b2el9eb6d4a1b9038f45@mail.gmail.com>
> you wrote:
> >
> > I think the fec's parent clock is the ipb clock not the ppc core clock.
> > Could that be the problem?
>
> I don't think so.
>
> When debugging, I printed the actual clock frequencies, and they
> looked as expected. And "arch/powerpc/platforms/512x/clock.c" has
> this:
>
> 385 static struct clk fec_clk = {
> 386         .name = "fec_clk",
> 387         .flags = CLK_HAS_CTRL,
> 388         .reg = 0,
> 389         .bit = 13,
> 390         .calc = unity_clk_calc,
> 391         .parent = &ips_clk,
> 392 };
>
> which looks OK to me.
>
> Best regards,
>
> Wolfgang Denk
>
> --
> DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
> The human mind  ordinarily  operates  at  only  ten  percent  of  its
> capacity. The rest is overhead for the operating system.
>

--000e0cd14690bccee8046bb582b5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I noticed the latest BSP from Freescale has this patch:<br><br>From: Chen H=
ongjun &lt;<a href=3D"mailto:Hong-jun.chen@freecale.com">Hong-jun.chen@free=
cale.com</a>&gt;<br>Date: Thu, 16 Apr 2009 20:22:52 +0800<br>Subject: [PATC=
H] Fixed FEC bug for bluestone board.<br>
<br>Signed-off-by: Chen Hongjun &lt;<a href=3D"mailto:Hong-jun.chen@freecal=
e.com">Hong-jun.chen@freecale.com</a>&gt;<br>---<br>=A0drivers/net/fs_enet/=
mii-fec.c |=A0=A0=A0 2 +-<br>=A01 files changed, 1 insertions(+), 1 deletio=
ns(-)<br>
<br>diff --git a/drivers/net/fs_enet/mii-fec.c b/drivers/net/fs_enet/mii-fe=
c.c<br>index 13a7d66..53d01a8 100644<br>--- a/drivers/net/fs_enet/mii-fec.c=
<br>+++ b/drivers/net/fs_enet/mii-fec.c<br>@@ -208,7 +208,7 @@ static int _=
_devinit fs_enet_mdio_probe(struct of_device *ofdev,<br>
=A0=A0=A0=A0=A0=A0=A0 if (!fec-&gt;fecp)<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 goto out_fec;<br>=A0<br>-=A0=A0=A0=A0=A0=A0 fec-&gt;mii_spe=
ed =3D ((ppc_proc_freq + 4999999) / 5000000) &lt;&lt; 1;<br>+=A0=A0=A0=A0=
=A0=A0 fec-&gt;mii_speed =3D ((((ppc_proc_freq + 4999999) / 2500000) / 2) &=
amp; 0x3F) &lt;&lt; 1;<br>
=A0<br>=A0=A0=A0=A0=A0=A0=A0 setbits32(&amp;fec-&gt;fecp-&gt;fec_r_cntrl, F=
EC_RCNTRL_MII_MODE);<br>=A0=A0=A0=A0=A0=A0=A0 setbits32(&amp;fec-&gt;fecp-&=
gt;fec_ecntrl, FEC_ECNTRL_PINMUX |<br>-- <br>1.5.4<br><br><br><div class=3D=
"gmail_quote">On Sat, Jun 6, 2009 at 4:16 PM, Wolfgang Denk <span dir=3D"lt=
r">&lt;<a href=3D"mailto:wd@denx.de">wd@denx.de</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Dear John,<br>
<div class=3D"im"><br>
In message &lt;<a href=3D"mailto:4b73d43f0905071909v6e6e8b2el9eb6d4a1b9038f=
45@mail.gmail.com">4b73d43f0905071909v6e6e8b2el9eb6d4a1b9038f45@mail.gmail.=
com</a>&gt; you wrote:<br>
&gt;<br>
&gt; I think the fec&#39;s parent clock is the ipb clock not the ppc core c=
lock.<br>
&gt; Could that be the problem?<br>
<br>
</div>I don&#39;t think so.<br>
<br>
When debugging, I printed the actual clock frequencies, and they<br>
looked as expected. And &quot;arch/powerpc/platforms/512x/clock.c&quot; has=
<br>
this:<br>
<br>
385 static struct clk fec_clk =3D {<br>
386 =A0 =A0 =A0 =A0 .name =3D &quot;fec_clk&quot;,<br>
387 =A0 =A0 =A0 =A0 .flags =3D CLK_HAS_CTRL,<br>
388 =A0 =A0 =A0 =A0 .reg =3D 0,<br>
389 =A0 =A0 =A0 =A0 .bit =3D 13,<br>
390 =A0 =A0 =A0 =A0 .calc =3D unity_clk_calc,<br>
391 =A0 =A0 =A0 =A0 .parent =3D &amp;ips_clk,<br>
392 };<br>
<br>
which looks OK to me.<br>
<div class=3D"im"><br>
Best regards,<br>
<br>
Wolfgang Denk<br>
<br>
--<br>
DENX Software Engineering GmbH, =A0 =A0 MD: Wolfgang Denk &amp; Detlev Zund=
el<br>
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany<br>
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: <a href=3D"mailt=
o:wd@denx.de">wd@denx.de</a><br>
</div>The human mind =A0ordinarily =A0operates =A0at =A0only =A0ten =A0perc=
ent =A0of =A0its<br>
capacity. The rest is overhead for the operating system.<br>
</blockquote></div><br>

--000e0cd14690bccee8046bb582b5--
