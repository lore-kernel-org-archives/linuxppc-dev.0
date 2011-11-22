Return-Path: <tinamdar@apm.com>
Received: from exprod5og109.obsmtp.com (exprod5og109.obsmtp.com [64.18.0.188])
 by ozlabs.org (Postfix) with SMTP id E90BF1007D1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2011 01:21:12 +1100 (EST)
Received: by mail-yw0-f49.google.com with SMTP id 12so248672ywa.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2011 06:21:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CA+5PVA7BD9jNoV9LrXjk2+UPBW8MSTPkwpYPFj2y-CNkXCrAhA@mail.gmail.com>
References: <1321945877-22802-1-git-send-email-tinamdar@apm.com>
 <CA+5PVA7BD9jNoV9LrXjk2+UPBW8MSTPkwpYPFj2y-CNkXCrAhA@mail.gmail.com>
Date: Tue, 22 Nov 2011 19:45:11 +0530
Message-ID: <CACoXjc=RBpB6eYu1zB-kCcYmsV8rdbzYtdxyBJDLTdt6uu04ig@mail.gmail.com>
Subject: Re: powerpc: dts: Fix canyonlands EMAC interrupt map
From: Tanmay Inamdar <tinamdar@apm.com>
To: Josh Boyer <jwboyer@gmail.com>
Content-Type: multipart/alternative; boundary=f46d042f93886b40fd04b2536ed0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--f46d042f93886b40fd04b2536ed0
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Nov 22, 2011 at 5:00 PM, Josh Boyer <jwboyer@gmail.com> wrote:

> On Tue, Nov 22, 2011 at 2:11 AM, Tanmay Inamdar <tinamdar@apm.com> wrote:
> > Fixing interrupt mapping of EMAC for canyonlands
> >
> > Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
>
> As far as I can tell, your changes aren't really changing anything
> just making it a bit clearer, correct?  If so, do you mind if I change
> the commit log to "clear up" instead of fix?
>

Actually Rob Herring's commit (
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commit;h=dc9372808412edbc653a675a526c2ee6c0c14a91)
breaks the interrupt mapping in EMAC driver.
I am trying to fix this issue by mapping interrupts in different way.

If you think "clear up" is fine, then please go ahead.

Thanks,
Tanmay

>
> josh
>
> > ---
> >  arch/powerpc/boot/dts/canyonlands.dts |   16 ++++++----------
> >  1 files changed, 6 insertions(+), 10 deletions(-)
> >
> > diff --git a/arch/powerpc/boot/dts/canyonlands.dts
> b/arch/powerpc/boot/dts/canyonlands.dts
> > index 3dc75de..c76bbcd 100644
> > --- a/arch/powerpc/boot/dts/canyonlands.dts
> > +++ b/arch/powerpc/boot/dts/canyonlands.dts
> > @@ -360,13 +360,11 @@
> >                        EMAC0: ethernet@ef600e00 {
> >                                device_type = "network";
> >                                compatible = "ibm,emac-460ex",
> "ibm,emac4sync";
> > -                               interrupt-parent = <&EMAC0>;
> > -                               interrupts = <0x0 0x1>;
> > -                               #interrupt-cells = <1>;
> > +                               interrupt-parent = <&UIC2>;
> >                                #address-cells = <0>;
> >                                #size-cells = <0>;
> > -                               interrupt-map = </*Status*/ 0x0 &UIC2
> 0x10 0x4
> > -                                                /*Wake*/   0x1 &UIC2
> 0x14 0x4>;
> > +                               interrupts = </*Status*/0x10 0x4
> > +                                               /*Wake*/0x14 0x4>;
> >                                reg = <0xef600e00 0x000000c4>;
> >                                local-mac-address = [000000000000]; /*
> Filled in by U-Boot */
> >                                mal-device = <&MAL0>;
> > @@ -390,13 +388,11 @@
> >                        EMAC1: ethernet@ef600f00 {
> >                                device_type = "network";
> >                                compatible = "ibm,emac-460ex",
> "ibm,emac4sync";
> > -                               interrupt-parent = <&EMAC1>;
> > -                               interrupts = <0x0 0x1>;
> > -                               #interrupt-cells = <1>;
> > +                               interrupt-parent = <&UIC2>;
> >                                #address-cells = <0>;
> >                                #size-cells = <0>;
> > -                               interrupt-map = </*Status*/ 0x0 &UIC2
> 0x11 0x4
> > -                                                /*Wake*/   0x1 &UIC2
> 0x15 0x4>;
> > +                               interrupts = </*Status*/0x11 0x4
> > +                                               /*Wake*/0x15 0x4>;
> >                                reg = <0xef600f00 0x000000c4>;
> >                                local-mac-address = [000000000000]; /*
> Filled in by U-Boot */
> >                                mal-device = <&MAL0>;
> > --
> > 1.6.1.rc3
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>

CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, 
is for the sole use of the intended recipient(s) and contains information 
that is confidential and proprietary to AppliedMicro Corporation or its subsidiaries. 
It is to be used solely for the purpose of furthering the parties' business relationship. 
All unauthorized review, use, disclosure or distribution is prohibited. 
If you are not the intended recipient, please contact the sender by reply e-mail 
and destroy all copies of the original message.

--f46d042f93886b40fd04b2536ed0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><div class=3D"gmail_quote">On Tue, Nov 22, 2011 at 5:00 PM, Josh Boyer =
<span dir=3D"ltr">&lt;<a href=3D"mailto:jwboyer@gmail.com">jwboyer@gmail.co=
m</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
<div class=3D"im">On Tue, Nov 22, 2011 at 2:11 AM, Tanmay Inamdar &lt;<a hr=
ef=3D"mailto:tinamdar@apm.com">tinamdar@apm.com</a>&gt; wrote:<br>
&gt; Fixing interrupt mapping of EMAC for canyonlands<br>
&gt;<br>
&gt; Signed-off-by: Tanmay Inamdar &lt;<a href=3D"mailto:tinamdar@apm.com">=
tinamdar@apm.com</a>&gt;<br>
<br>
</div>As far as I can tell, your changes aren&#39;t really changing anythin=
g<br>
just making it a bit clearer, correct? =A0If so, do you mind if I change<br=
>
the commit log to &quot;clear up&quot; instead of fix?<br></blockquote><div=
><br>Actually Rob Herring&#39;s commit (<a href=3D"http://git.kernel.org/?p=
=3Dlinux/kernel/git/torvalds/linux.git;a=3Dcommit;h=3Ddc9372808412edbc653a6=
75a526c2ee6c0c14a91">http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/l=
inux.git;a=3Dcommit;h=3Ddc9372808412edbc653a675a526c2ee6c0c14a91</a>) break=
s the interrupt mapping in EMAC driver.<br>
I am trying to fix this issue by mapping interrupts in different way.<br><b=
r>If you think &quot;clear up&quot; is fine, then please go ahead.<br><br>T=
hanks,<br>Tanmay<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-lef=
t: 1ex;">

<br>
josh<br>
<div><div></div><div class=3D"h5"><br>
&gt; ---<br>
&gt; =A0arch/powerpc/boot/dts/canyonlands.dts | =A0 16 ++++++----------<br>
&gt; =A01 files changed, 6 insertions(+), 10 deletions(-)<br>
&gt;<br>
&gt; diff --git a/arch/powerpc/boot/dts/canyonlands.dts b/arch/powerpc/boot=
/dts/canyonlands.dts<br>
&gt; index 3dc75de..c76bbcd 100644<br>
&gt; --- a/arch/powerpc/boot/dts/canyonlands.dts<br>
&gt; +++ b/arch/powerpc/boot/dts/canyonlands.dts<br>
&gt; @@ -360,13 +360,11 @@<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EMAC0: ethernet@ef600e0=
0 {<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device_=
type =3D &quot;network&quot;;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compati=
ble =3D &quot;ibm,emac-460ex&quot;, &quot;ibm,emac4sync&quot;;<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrup=
t-parent =3D &lt;&amp;EMAC0&gt;;<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrup=
ts =3D &lt;0x0 0x1&gt;;<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #interru=
pt-cells =3D &lt;1&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrup=
t-parent =3D &lt;&amp;UIC2&gt;;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#addres=
s-cells =3D &lt;0&gt;;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#size-c=
ells =3D &lt;0&gt;;<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrup=
t-map =3D &lt;/*Status*/ 0x0 &amp;UIC2 0x10 0x4<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0/*Wake*/ =A0 0x1 &amp;UIC2 0x14 0x4&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrup=
ts =3D &lt;/*Status*/0x10 0x4<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 /*Wake*/0x14 0x4&gt;;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D=
 &lt;0xef600e00 0x000000c4&gt;;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0local-m=
ac-address =3D [000000000000]; /* Filled in by U-Boot */<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mal-dev=
ice =3D &lt;&amp;MAL0&gt;;<br>
&gt; @@ -390,13 +388,11 @@<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EMAC1: ethernet@ef600f0=
0 {<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device_=
type =3D &quot;network&quot;;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compati=
ble =3D &quot;ibm,emac-460ex&quot;, &quot;ibm,emac4sync&quot;;<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrup=
t-parent =3D &lt;&amp;EMAC1&gt;;<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrup=
ts =3D &lt;0x0 0x1&gt;;<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #interru=
pt-cells =3D &lt;1&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrup=
t-parent =3D &lt;&amp;UIC2&gt;;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#addres=
s-cells =3D &lt;0&gt;;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#size-c=
ells =3D &lt;0&gt;;<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrup=
t-map =3D &lt;/*Status*/ 0x0 &amp;UIC2 0x11 0x4<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0/*Wake*/ =A0 0x1 &amp;UIC2 0x15 0x4&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrup=
ts =3D &lt;/*Status*/0x11 0x4<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 /*Wake*/0x15 0x4&gt;;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D=
 &lt;0xef600f00 0x000000c4&gt;;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0local-m=
ac-address =3D [000000000000]; /* Filled in by U-Boot */<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mal-dev=
ice =3D &lt;&amp;MAL0&gt;;<br>
&gt; --<br>
&gt; 1.6.1.rc3<br>
&gt;<br>
</div></div>&gt; --<br>
&gt; To unsubscribe from this list: send the line &quot;unsubscribe linux-k=
ernel&quot; in<br>
&gt; the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">=
majordomo@vger.kernel.org</a><br>
&gt; More majordomo info at =A0<a href=3D"http://vger.kernel.org/majordomo-=
info.html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a>=
<br>
&gt; Please read the FAQ at =A0<a href=3D"http://www.tux.org/lkml/" target=
=3D"_blank">http://www.tux.org/lkml/</a><br>
&gt;<br>
</blockquote></div><br>

<pre>CONFIDENTIALITY NOTICE: This e-mail message, including any attachmen=
ts, =

is for the sole use of the intended recipient(s) and contains information=
=A0
that is confidential and proprietary to AppliedMicro Corporation or its s=
ubsidiaries. =

It is to be used solely for the purpose of furthering the parties' busine=
ss relationship. =

All unauthorized review, use, disclosure or distribution is prohibited. =

If you are not the intended recipient, please contact the sender by reply=
 e-mail =

and destroy all copies of the original message.
=0D
--f46d042f93886b40fd04b2536ed0--
