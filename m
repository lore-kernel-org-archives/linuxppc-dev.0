Return-Path: <jcrigby@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.171])
	by ozlabs.org (Postfix) with ESMTP id 9214EDDF7A
	for <linuxppc-dev@ozlabs.org>; Fri,  8 May 2009 12:49:24 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so935487wfg.15
	for <linuxppc-dev@ozlabs.org>; Thu, 07 May 2009 19:49:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <fa686aa40905061407v2bac38e9k3ee8d68c0c58e692@mail.gmail.com>
References: <1241640919-4650-1-git-send-email-wd@denx.de>
	<1241640919-4650-12-git-send-email-wd@denx.de>
	<fa686aa40905061407v2bac38e9k3ee8d68c0c58e692@mail.gmail.com>
Date: Thu, 7 May 2009 20:49:23 -0600
Message-ID: <4b73d43f0905071949r5b8f16f8n18d70771720cfb15@mail.gmail.com>
Subject: Re: [PATCH 11/12] mpc5121: Added MPC512x DMA driver.
From: John Rigby <jcrigby@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Content-Type: multipart/alternative; boundary=001636ed643113312804695dadd5
Cc: linuxppc-dev@ozlabs.org, Wolfgang Denk <wd@denx.de>,
	Piotr Ziecik <kosmo@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--001636ed643113312804695dadd5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Wed, May 6, 2009 at 3:07 PM, Grant Likely <grant.likely@secretlab.ca>wrote:

> On Wed, May 6, 2009 at 2:15 PM, Wolfgang Denk <wd@denx.de> wrote:
> > From: Piotr Ziecik <kosmo@semihalf.com>
> >
> > This patch adds initial version of MPC512x DMA driver.
> > Only memory to memory transfers are currenly supported.
> >
> > Signed-off-by: Piotr Ziecik <kosmo@semihalf.com>
> > Signed-off-by: Wolfgang Denk <wd@denx.de>
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > Cc: John Rigby <jcrigby@gmail.com>
>
> Don't have time to review this in detail right now, but three quick
> comments:
>
> >  drivers/dma/mpc512x_dma.c                    |  642
> ++++++++++++++++++++++++++
> >  drivers/dma/mpc512x_dma.h                    |  192 ++++++++
>
> It looks to me like these two files should be merged.
>
> > diff --git a/arch/powerpc/boot/dts/mpc5121ads.dts
> b/arch/powerpc/boot/dts/mpc5121ads.dts
> > index c2d9de9..e7f0e09 100644
> > --- a/arch/powerpc/boot/dts/mpc5121ads.dts
> > +++ b/arch/powerpc/boot/dts/mpc5121ads.dts
> > @@ -373,7 +373,7 @@
> >                };
> >
> >                dma@14000 {
> > -                       compatible = "fsl,mpc5121-dma2";
> > +                       compatible = "fsl,mpc512x-dma";
>
> Nack.  Compatible values should not use wildcards.  Be specific.  And
> be specific about what it is compatible to if another part implements
> the same device.

The internal name for the dma module was dma2 that is where the orginal name
came from.  There is a dma2 in some 8xxx but last I looked it is not at all
the same.  I would vote for fsl,mpc5121-dma.

>
>
> >                        reg = <0x14000 0x1800>;
> >                        interrupts = <65 0x8>;
> >                        interrupt-parent = < &ipic >;
> > diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c
> b/arch/powerpc/platforms/512x/mpc512x_shared.c
> > index b776e45..135fd6b 100644
> > --- a/arch/powerpc/platforms/512x/mpc512x_shared.c
> > +++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
> > @@ -95,6 +95,7 @@ void __init mpc512x_init_i2c(void)
> >  static struct of_device_id __initdata of_bus_ids[] = {
> >        { .compatible = "fsl,mpc5121-immr", },
> >        { .compatible = "fsl,mpc5121-localbus", },
> > +       { .compatible = "fsl,mpc5121-dma", },
>
> This doesn't look right either.  Shouldn't the dma device hang off the
> IMMR node?

Yes dma is part of IMMR.

>
>
> g.
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>

--001636ed643113312804695dadd5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Wed, May 6, 2009 at 3:07 PM, Grant Li=
kely <span dir=3D"ltr">&lt;<a href=3D"mailto:grant.likely@secretlab.ca">gra=
nt.likely@secretlab.ca</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_=
quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt =
0pt 0.8ex; padding-left: 1ex;">
<div class=3D"im">On Wed, May 6, 2009 at 2:15 PM, Wolfgang Denk &lt;<a href=
=3D"mailto:wd@denx.de">wd@denx.de</a>&gt; wrote:<br>
&gt; From: Piotr Ziecik &lt;<a href=3D"mailto:kosmo@semihalf.com">kosmo@sem=
ihalf.com</a>&gt;<br>
&gt;<br>
&gt; This patch adds initial version of MPC512x DMA driver.<br>
&gt; Only memory to memory transfers are currenly supported.<br>
&gt;<br>
&gt; Signed-off-by: Piotr Ziecik &lt;<a href=3D"mailto:kosmo@semihalf.com">=
kosmo@semihalf.com</a>&gt;<br>
&gt; Signed-off-by: Wolfgang Denk &lt;<a href=3D"mailto:wd@denx.de">wd@denx=
.de</a>&gt;<br>
&gt; Cc: Grant Likely &lt;<a href=3D"mailto:grant.likely@secretlab.ca">gran=
t.likely@secretlab.ca</a>&gt;<br>
&gt; Cc: John Rigby &lt;<a href=3D"mailto:jcrigby@gmail.com">jcrigby@gmail.=
com</a>&gt;<br>
<br>
</div>Don&#39;t have time to review this in detail right now, but three qui=
ck comments:<br>
<div class=3D"im"><br>
&gt; =A0drivers/dma/mpc512x_dma.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0642 ++++++++++++++++++++++++++<br>
&gt; =A0drivers/dma/mpc512x_dma.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0192 ++++++++<br>
<br>
</div>It looks to me like these two files should be merged.<br>
<div class=3D"im"><br>
&gt; diff --git a/arch/powerpc/boot/dts/mpc5121ads.dts b/arch/powerpc/boot/=
dts/mpc5121ads.dts<br>
&gt; index c2d9de9..e7f0e09 100644<br>
&gt; --- a/arch/powerpc/boot/dts/mpc5121ads.dts<br>
&gt; +++ b/arch/powerpc/boot/dts/mpc5121ads.dts<br>
&gt; @@ -373,7 +373,7 @@<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dma@14000 {<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D &quot;fsl=
,mpc5121-dma2&quot;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D &quot;fsl=
,mpc512x-dma&quot;;<br>
<br>
</div>Nack. =A0Compatible values should not use wildcards. =A0Be specific. =
=A0And<br>
be specific about what it is compatible to if another part implements<br>
the same device.</blockquote><div>The internal name for the dma module was =
dma2 that is where the orginal name came from.=A0 There is a dma2 in some 8=
xxx but last I looked it is not at all the same.=A0 I would vote for fsl,mp=
c5121-dma. <br>
</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb=
(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
<div class=3D"im"><br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D &lt;0x14000 0x1=
800&gt;;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D &lt;65 0=
x8&gt;;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-parent =3D &l=
t; &amp;ipic &gt;;<br>
&gt; diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/power=
pc/platforms/512x/mpc512x_shared.c<br>
&gt; index b776e45..135fd6b 100644<br>
&gt; --- a/arch/powerpc/platforms/512x/mpc512x_shared.c<br>
&gt; +++ b/arch/powerpc/platforms/512x/mpc512x_shared.c<br>
&gt; @@ -95,6 +95,7 @@ void __init mpc512x_init_i2c(void)<br>
&gt; =A0static struct of_device_id __initdata of_bus_ids[] =3D {<br>
&gt; =A0 =A0 =A0 =A0{ .compatible =3D &quot;fsl,mpc5121-immr&quot;, },<br>
&gt; =A0 =A0 =A0 =A0{ .compatible =3D &quot;fsl,mpc5121-localbus&quot;, },<=
br>
&gt; + =A0 =A0 =A0 { .compatible =3D &quot;fsl,mpc5121-dma&quot;, },<br>
<br>
</div>This doesn&#39;t look right either. =A0Shouldn&#39;t the dma device h=
ang off the<br>
IMMR node?</blockquote><div>Yes dma is part of IMMR. <br></div><blockquote =
class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); m=
argin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
<br>
g.<br>
<font color=3D"#888888"><br>
--<br>
Grant Likely, B.Sc., P.Eng.<br>
Secret Lab Technologies Ltd.<br>
</font></blockquote></div><br>

--001636ed643113312804695dadd5--
