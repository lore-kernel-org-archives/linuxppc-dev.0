Return-Path: <mla@apm.com>
Received: from exprod5og101.obsmtp.com (exprod5og101.obsmtp.com [64.18.0.141])
 by ozlabs.org (Postfix) with SMTP id 5C2DF2C0096
 for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2012 14:24:09 +1100 (EST)
Received: by mail-ia0-f198.google.com with SMTP id l29so48020iag.9
 for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2012 20:24:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <508060FD.3040202@gmail.com>
References: <507EF5AD.5070203__24977.4320669987$1350497770$gmane$org@gmail.com>
 <50802F4C.3000309__36526.1883860969$1350578085$gmane$org@gmail.com>
 <50804020.30505@gmail.com> <1350587006.2476.12.camel@pasglop>
 <508060FD.3040202@gmail.com>
From: Mai La <mla@apm.com>
Date: Fri, 19 Oct 2012 10:16:07 +0700
Message-ID: <CAJ0-vuiccVbFk8=0TXO=Ak_a-0_yr55E2hs-GRVXLuKLNYjfCQ@mail.gmail.com>
Subject: Re: ELDK 4.2/kilauea/3.5+ kernel broken
To: Robert Berger <robert.karl.berger@gmail.com>
Content-Type: multipart/alternative; boundary=14dae934061ff758b604cc60edb0
Cc: wd@denx.de, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--14dae934061ff758b604cc60edb0
Content-Type: text/plain; charset=ISO-8859-1

Hi,

My patch was:

@@ -150,12 +157,11 @@ static int ppc4xx_setup_pcieh_hw(struct
platform_device *dev,
        if (!sdr_addr)
                return -1;

-       SDR0_WRITE(sdr_addr, (u64)res.start >> 32);      /*HIGH addr */
-       SDR0_WRITE(sdr_addr + 1, res.start & 0xFFFFFFFF); /* Low addr */
-
+       mtdcri(SDR0, *sdr_addr, upper_32_bits(res.start));      /*HIGH addr
*/
+       mtdcri(SDR0, *sdr_addr + 1, lower_32_bits(res.start));  /* Low addr
*/

        msi->msi_dev = of_find_node_by_name(NULL, "ppc4xx-msi");
-       if (msi->msi_dev)
+       if (!msi->msi_dev)
                return -ENODEV;

        msi->msi_regs = of_iomap(msi->msi_dev, 0);


1. The first few lines: change from SDR0_WRITE to mtdcri since the old one
cause crash. I use ELDK 4.2.

2. The second one should mean that: if not find any node then return error.
So it should be "!msi->msi_dev"

Regards,
Mai La.


On Fri, Oct 19, 2012 at 3:05 AM, Robert Berger <robert.karl.berger@gmail.com
> wrote:

> Hi,
>
> On 10/18/2012 10:03 PM, Benjamin Herrenschmidt wrote:
> > On Thu, 2012-10-18 at 20:45 +0300, Robert Berger wrote:
> >> -       mtdcri(SDR0, *sdr_addr, upper_32_bits(res.start));      /*HIGH
> addr */
> >> -       mtdcri(SDR0, *sdr_addr + 1, lower_32_bits(res.start));  /* Low
> addr */
> >> +       SDR0_WRITE(sdr_addr, (u64)res.start >> 32);      /*HIGH addr */
> >> +       SDR0_WRITE(sdr_addr + 1, res.start & 0xFFFFFFFF); /* Low addr */
> >> +
> >>
> >>         msi->msi_dev = of_find_node_by_name(NULL, "ppc4xx-msi");
> >> -       if (!msi->msi_dev)
> >> +       if (msi->msi_dev)
> >>                 return -ENODEV;
> >
> > The above changes look bad. The first one is stupid, the second one is
> clearly broken.
> >
> > The diff us from good to bad right ? Looks like somebody added a very
> busted patch.
>
> this (from 3.6) does not work:
>
> -       mtdcri(SDR0, *sdr_addr, upper_32_bits(res.start));      /*HIGH
> addr */
> -       mtdcri(SDR0, *sdr_addr + 1, lower_32_bits(res.start));  /* Low
> addr */
>
> The good old file (which works) is this:
>
> +       SDR0_WRITE(sdr_addr, (u64)res.start >> 32);      /*HIGH addr */
> +       SDR0_WRITE(sdr_addr + 1, res.start & 0xFFFFFFFF); /* Low addr */
> +
>
> >
> > If I look at the code in current upstream, I see:
> >
> >       mtdcri(SDR0, *sdr_addr, upper_32_bits(res.start));      /*HIGH
> addr */
> >       mtdcri(SDR0, *sdr_addr + 1, lower_32_bits(res.start));  /* Low
> addr */
> >
> >       msi->msi_dev = of_find_node_by_name(NULL, "ppc4xx-msi");
> >       if (!msi->msi_dev)
> >               return -ENODEV;
> >
> >
> > Which looks correct. So this might be something specific to ELDK ?
>
> I will be on the road from tomorrow for a week or so, but maybe I can
> isolate the exact lines which break it. I can also try a newer compiler
> to see if this changes anything.
>
> Is there someone out there with a kilauea board who can boot a 3.6.
> mainline kernel with a default config with a rootfs over nfs?
>
> >
> > Cheers,
> > Ben.
> >
> >
>
> Regards,
>
> Robert
>

--14dae934061ff758b604cc60edb0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>My patch was:<br><br>@@ -150,12 +157,11 @@ static int ppc4xx_set=
up_pcieh_hw(struct platform_device *dev,<br>=A0=A0=A0=A0=A0=A0=A0 if (!sdr_=
addr)<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -1;<br><br>-=
=A0=A0=A0=A0=A0=A0 SDR0_WRITE(sdr_addr, (u64)res.start &gt;&gt; 32);=A0=A0=
=A0=A0=A0 /*HIGH addr */<br>

-=A0=A0=A0=A0=A0=A0 SDR0_WRITE(sdr_addr + 1, res.start &amp; 0xFFFFFFFF); /=
* Low addr */<br>-<br>+=A0=A0=A0=A0=A0=A0 mtdcri(SDR0, *sdr_addr, upper_32_=
bits(res.start));=A0=A0=A0=A0=A0 /*HIGH addr */<br>+=A0=A0=A0=A0=A0=A0 mtdc=
ri(SDR0, *sdr_addr + 1, lower_32_bits(res.start));=A0 /* Low addr */<br>

<br>=A0=A0=A0=A0=A0=A0=A0 msi-&gt;msi_dev =3D of_find_node_by_name(NULL, &q=
uot;ppc4xx-msi&quot;);<br>-=A0=A0=A0=A0=A0=A0 if (msi-&gt;msi_dev)<br>+=A0=
=A0=A0=A0=A0=A0 if (!msi-&gt;msi_dev)<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 return -ENODEV;<br><br>=A0=A0=A0=A0=A0=A0=A0 msi-&gt;msi_regs =
=3D of_iomap(msi-&gt;msi_dev, 0);<br>

<br><br>1. The first few lines: change from SDR0_WRITE to mtdcri since the =
old one cause crash. I use ELDK 4.2.<br><br>2. The second one should mean t=
hat: if not find any node then return error. So it should be &quot;!msi-&gt=
;msi_dev&quot;<br>

<br>Regards,<br>Mai La.<br><br><br><div class=3D"gmail_quote">On Fri, Oct 1=
9, 2012 at 3:05 AM, Robert Berger <span dir=3D"ltr">&lt;<a href=3D"mailto:r=
obert.karl.berger@gmail.com" target=3D"_blank">robert.karl.berger@gmail.com=
</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi,<br>
<div class=3D"im"><br>
On 10/18/2012 10:03 PM, Benjamin Herrenschmidt wrote:<br>
&gt; On Thu, 2012-10-18 at 20:45 +0300, Robert Berger wrote:<br>
&gt;&gt; - =A0 =A0 =A0 mtdcri(SDR0, *sdr_addr, upper_32_bits(res.start)); =
=A0 =A0 =A0/*HIGH addr */<br>
&gt;&gt; - =A0 =A0 =A0 mtdcri(SDR0, *sdr_addr + 1, lower_32_bits(res.start)=
); =A0/* Low addr */<br>
&gt;&gt; + =A0 =A0 =A0 SDR0_WRITE(sdr_addr, (u64)res.start &gt;&gt; 32); =
=A0 =A0 =A0/*HIGH addr */<br>
&gt;&gt; + =A0 =A0 =A0 SDR0_WRITE(sdr_addr + 1, res.start &amp; 0xFFFFFFFF)=
; /* Low addr */<br>
&gt;&gt; +<br>
&gt;&gt;<br>
&gt;&gt; =A0 =A0 =A0 =A0 msi-&gt;msi_dev =3D of_find_node_by_name(NULL, &qu=
ot;ppc4xx-msi&quot;);<br>
&gt;&gt; - =A0 =A0 =A0 if (!msi-&gt;msi_dev)<br>
&gt;&gt; + =A0 =A0 =A0 if (msi-&gt;msi_dev)<br>
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;<br>
&gt;<br>
&gt; The above changes look bad. The first one is stupid, the second one is=
 clearly broken.<br>
&gt;<br>
&gt; The diff us from good to bad right ? Looks like somebody added a very =
busted patch.<br>
<br>
</div>this (from 3.6) does not work:<br>
<div class=3D"im"><br>
- =A0 =A0 =A0 mtdcri(SDR0, *sdr_addr, upper_32_bits(res.start)); =A0 =A0 =
=A0/*HIGH<br>
addr */<br>
- =A0 =A0 =A0 mtdcri(SDR0, *sdr_addr + 1, lower_32_bits(res.start)); =A0/* =
Low<br>
addr */<br>
<br>
</div>The good old file (which works) is this:<br>
<div class=3D"im"><br>
+ =A0 =A0 =A0 SDR0_WRITE(sdr_addr, (u64)res.start &gt;&gt; 32); =A0 =A0 =A0=
/*HIGH addr */<br>
+ =A0 =A0 =A0 SDR0_WRITE(sdr_addr + 1, res.start &amp; 0xFFFFFFFF); /* Low =
addr */<br>
+<br>
<br>
&gt;<br>
</div><div class=3D"im">&gt; If I look at the code in current upstream, I s=
ee:<br>
&gt;<br>
&gt; =A0 =A0 =A0 mtdcri(SDR0, *sdr_addr, upper_32_bits(res.start)); =A0 =A0=
 =A0/*HIGH addr */<br>
&gt; =A0 =A0 =A0 mtdcri(SDR0, *sdr_addr + 1, lower_32_bits(res.start)); =A0=
/* Low addr */<br>
&gt;<br>
&gt; =A0 =A0 =A0 msi-&gt;msi_dev =3D of_find_node_by_name(NULL, &quot;ppc4x=
x-msi&quot;);<br>
&gt; =A0 =A0 =A0 if (!msi-&gt;msi_dev)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;<br>
&gt;<br>
&gt;<br>
&gt; Which looks correct. So this might be something specific to ELDK ?<br>
<br>
</div>I will be on the road from tomorrow for a week or so, but maybe I can=
<br>
isolate the exact lines which break it. I can also try a newer compiler<br>
to see if this changes anything.<br>
<br>
Is there someone out there with a kilauea board who can boot a 3.6.<br>
mainline kernel with a default config with a rootfs over nfs?<br>
<br>
&gt;<br>
&gt; Cheers,<br>
&gt; Ben.<br>
&gt;<br>
&gt;<br>
<br>
Regards,<br>
<br>
Robert<br>
</blockquote></div><br>

--14dae934061ff758b604cc60edb0--
