Return-Path: <karim.eshapa@gmail.com>
Received: from mail-ua0-x242.google.com (mail-ua0-x242.google.com
 [IPv6:2607:f8b0:400c:c08::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wwb515K2tzDr13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jun 2017 01:02:13 +1000 (AEST)
Received: by mail-ua0-x242.google.com with SMTP id g40so8614604uaa.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Jun 2017 08:02:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170625024939.3adaysgmblwhyeyf@home.buserror.net>
References: <1493971556-14918-1-git-send-email-karim.eshapa@gmail.com>
 <20170625024939.3adaysgmblwhyeyf@home.buserror.net>
From: karim eshapa <karim.eshapa@gmail.com>
Date: Sun, 25 Jun 2017 17:02:09 +0200
Message-ID: <CABf4As8ggQEH5_R0UoH1t_ZigWc0E3_f1p_VJjpb64UMvwCMjA@mail.gmail.com>
Subject: Re: drivers:soc:fsl:qbman:qman.c: Change a comment for an entry check
 inside drain_mr_fqrni function
To: Scott Wood <oss@buserror.net>
Cc: roy.pledge@nxp.com, linux-kernel@vger.kernel.org, claudiu.manoil@nxp.com,
 Colin King <colin.king@canonical.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/alternative; boundary="001a113d19826450ee0552ca1eeb"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a113d19826450ee0552ca1eeb
Content-Type: text/plain; charset="UTF-8"

>Do you mean "sufficient" here rather than "efficient"?  It's far less
>inefficient than what the code was previously doing, but still...

Yes, I'm gonna send a new fix for the comment patch and
change the subject of the previous patch soc/qman

Thanks,
Karim


On 25 June 2017 at 04:49, Scott Wood <oss@buserror.net> wrote:

> On Fri, May 05, 2017 at 10:05:56AM +0200, Karim Eshapa wrote:
> > Change the comment for an entry check inside function
> > drain_mr_fqrni() with sleep for sufficient period
> > of time instead of long time proccessor cycles.
> >
> > Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>
> > ---
> >  drivers/soc/fsl/qbman/qman.c | 25 +++++++++++++------------
> >  1 file changed, 13 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
> > index 18d391e..636a7d7 100644
> > --- a/drivers/soc/fsl/qbman/qman.c
> > +++ b/drivers/soc/fsl/qbman/qman.c
> > @@ -1071,18 +1071,19 @@ static int drain_mr_fqrni(struct qm_portal *p)
> >       msg = qm_mr_current(p);
> >       if (!msg) {
> >               /*
> > -              * if MR was full and h/w had other FQRNI entries to
> produce, we
> > -              * need to allow it time to produce those entries once the
> > -              * existing entries are consumed. A worst-case situation
> > -              * (fully-loaded system) means h/w sequencers may have to
> do 3-4
> > -              * other things before servicing the portal's MR pump,
> each of
> > -              * which (if slow) may take ~50 qman cycles (which is ~200
> > -              * processor cycles). So rounding up and then multiplying
> this
> > -              * worst-case estimate by a factor of 10, just to be
> > -              * ultra-paranoid, goes as high as 10,000 cycles. NB, we
> consume
> > -              * one entry at a time, so h/w has an opportunity to
> produce new
> > -              * entries well before the ring has been fully consumed, so
> > -              * we're being *really* paranoid here.
> > +              * if MR was full and h/w had other FQRNI entries to
> > +              * produce, we need to allow it time to produce those
> > +              * entries once the existing entries are consumed.
> > +              * A worst-case situation (fully-loaded system) means
> > +              * h/w sequencers may have to do 3-4 other things
> > +              * before servicing the portal's MR pump, each of
> > +              * which (if slow) may take ~50 qman cycles
> > +              * (which is ~200 processor cycles). So sleep with
> > +              * 1 ms would be very efficient, after this period
> > +              * we can check if there is something produced.
> > +              * NB, we consume one entry at a time, so h/w has
> > +              * an opportunity to produce new entries well before
> > +              * the ring has been fully consumed.
>
> Do you mean "sufficient" here rather than "efficient"?  It's far less
> inefficient than what the code was previously doing, but still...
>
> Otherwise, looks good.
>
> -Scott
>

--001a113d19826450ee0552ca1eeb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div>&gt;Do you mean &quot;sufficient&quot;=
 here rather than &quot;efficient&quot;?=C2=A0 It&#39;s far less<br>
&gt;inefficient than what the code was previously doing, but still...<br>
<br></div>Yes, I&#39;m gonna send a new fix for the comment patch and<br></=
div>change the subject of the previous patch soc/qman<br><br></div>Thanks,<=
br></div>Karim<br><div><div><div><div><div><br></div></div></div></div></di=
v></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On 25 Jun=
e 2017 at 04:49, Scott Wood <span dir=3D"ltr">&lt;<a href=3D"mailto:oss@bus=
error.net" target=3D"_blank">oss@buserror.net</a>&gt;</span> wrote:<br><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On Fri, =
May 05, 2017 at 10:05:56AM +0200, Karim Eshapa wrote:<br>
&gt; Change the comment for an entry check inside function<br>
&gt; drain_mr_fqrni() with sleep for sufficient period<br>
&gt; of time instead of long time proccessor cycles.<br>
&gt;<br>
&gt; Signed-off-by: Karim Eshapa &lt;<a href=3D"mailto:karim.eshapa@gmail.c=
om">karim.eshapa@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/soc/fsl/qbman/qman.c | 25 +++++++++++++------------<br>
&gt;=C2=A0 1 file changed, 13 insertions(+), 12 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman=
.c<br>
&gt; index 18d391e..636a7d7 100644<br>
&gt; --- a/drivers/soc/fsl/qbman/qman.c<br>
&gt; +++ b/drivers/soc/fsl/qbman/qman.c<br>
&gt; @@ -1071,18 +1071,19 @@ static int drain_mr_fqrni(struct qm_portal *p)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0msg =3D qm_mr_current(p);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!msg) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * if MR was full and=
 h/w had other FQRNI entries to produce, we<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * need to allow it t=
ime to produce those entries once the<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * existing entries a=
re consumed. A worst-case situation<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * (fully-loaded syst=
em) means h/w sequencers may have to do 3-4<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * other things befor=
e servicing the portal&#39;s MR pump, each of<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * which (if slow) ma=
y take ~50 qman cycles (which is ~200<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * processor cycles).=
 So rounding up and then multiplying this<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * worst-case estimat=
e by a factor of 10, just to be<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * ultra-paranoid, go=
es as high as 10,000 cycles. NB, we consume<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * one entry at a tim=
e, so h/w has an opportunity to produce new<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * entries well befor=
e the ring has been fully consumed, so<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * we&#39;re being *r=
eally* paranoid here.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * if MR was full and=
 h/w had other FQRNI entries to<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * produce, we need t=
o allow it time to produce those<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * entries once the e=
xisting entries are consumed.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * A worst-case situa=
tion (fully-loaded system) means<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * h/w sequencers may=
 have to do 3-4 other things<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * before servicing t=
he portal&#39;s MR pump, each of<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * which (if slow) ma=
y take ~50 qman cycles<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * (which is ~200 pro=
cessor cycles). So sleep with<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 1 ms would be very=
 efficient, after this period<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * we can check if th=
ere is something produced.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * NB, we consume one=
 entry at a time, so h/w has<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * an opportunity to =
produce new entries well before<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * the ring has been =
fully consumed.<br>
<br>
</div></div>Do you mean &quot;sufficient&quot; here rather than &quot;effic=
ient&quot;?=C2=A0 It&#39;s far less<br>
inefficient than what the code was previously doing, but still...<br>
<br>
Otherwise, looks good.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
-Scott<br>
</font></span></blockquote></div><br></div>

--001a113d19826450ee0552ca1eeb--
