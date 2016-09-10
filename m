Return-Path: <afleming@gmail.com>
Received: from mail-wm0-x234.google.com (mail-wm0-x234.google.com
 [IPv6:2a00:1450:400c:c09::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sWp5z2W51zDsF3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Sep 2016 08:05:11 +1000 (AEST)
Received: by mail-wm0-x234.google.com with SMTP id c131so935077wmh.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Sep 2016 15:05:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <DB5PR0401MB192878019FFA33204D6A3EBD91F90@DB5PR0401MB1928.eurprd04.prod.outlook.com>
References: <1473189119-29458-1-git-send-email-afleming@gmail.com>
 <1473189119-29458-3-git-send-email-afleming@gmail.com>
 <DB5PR0401MB192878019FFA33204D6A3EBD91F90@DB5PR0401MB1928.eurprd04.prod.outlook.com>
From: Andy Fleming <afleming@gmail.com>
Date: Sat, 10 Sep 2016 17:05:07 -0500
Message-ID: <CAKWjMd4PLus4rDr+SXTPewYRy6E8HBKowyqhiv5rqK+JpayMog@mail.gmail.com>
Subject: Re: [PATCH 2/3] corenet: Support gpio power/reset for corenet
To: Scott Wood <scott.wood@nxp.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "aperez@alexperez.com" <aperez@alexperez.com>
Content-Type: multipart/alternative; boundary=001a1134daa2c3bcf8053c2e740c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a1134daa2c3bcf8053c2e740c
Content-Type: text/plain; charset=UTF-8

On Tuesday, September 6, 2016, Scott Wood <scott.wood@nxp.com> wrote:

> On 09/06/2016 02:12 PM, Andy Fleming wrote:
> > Boards can implement power and reset functionality over gpio using
> > these drivers:
> >   drivers/power/reset/gpio-poweroff.c
> >   drivers/power/reset/gpio-restart.c
> >
> > While not all corenet boards use gpio for power/reset, this
> > support can be added without interfering with boards that do not
> > use this functionality.
> >
> > If a board's device tree has the related nodes, they are now probed.
> > Also, gpio-poweroff uses the global pm_power_off callback to implement
> > the shutdown. However, pm_power_off was not invoked when the kernel
> > halted, although that is usually the desired behavior. If the board
> > provides gpio power and reset support, it is reasonable to assume that
> > halting should also power down the system, unless it has chosen to
> > pass those calls on to hypervisor.
>
> Halt and poweroff are not the same thing.  If userspace requests a
> poweroff, then kernel_power_off() will call machine_power_off() which
> will call pm_power_off().
>
> Why do we need anything corenet-specific here?


>
> We don't, but then the board will halt instead of power off when you type
> shutdown -h now. Or if you type poweroff without a high enough run level,
> apparently. I'm amenable to removing the halt code, but there are concerns
> that this will cause the systems to behave unintentionally as intended, in
> that most systems that users interact with shut down when you call shutdown
> -h now. There may be scripts that depend on that behavior (or at least
> assume it). Perhaps I could add a config option?
> CONFIG_TREAT_HALT_AS_POWEROFF? CONFIG_POWEROFF_ON_HALT?


> I'll note that there is one other board that is doing the same thing, but
> they've implemented their own gpio poweroff driver. See
> commit 5611fe48c545a22e62273428ed74c9bfae4a9406. That commit also points
> vaguely in the direction of an answer to your second question...


>
> > @@ -127,6 +137,12 @@ static const struct of_device_id of_device_ids[] = {
> >       {
> >               .name           = "handles",
> >       },
> > +     {
> > +             .name           = "gpio-poweroff",
> > +     },
> > +     {
> > +             .name           = "gpio-restart",
> > +     },
> >       {}
> >  };
> >
>
> I don't see any other platforms doing this.  How do the nodes get probed
> for them?


> The answer is I don't know, but this is a common issue with adding new
> devices to the device tree in embedded powerpc. The only other platforms
> which have gpio-poweroff nodes in their trees are in arch/arm, and none of
> those platforms call the probing function of_platform_bus_probe. I suspect
> they either probe every root node, or they somehow construct the match_id.
> As noted in the above-referenced commit, putting the nodes under the gpio
> bus does not cause them to get probed. This seemed like the best way under
> the current corenet code.
>
> -Scott
>
>

--001a1134daa2c3bcf8053c2e740c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><br>On Tuesday, September 6, 2016, Scott Wood &lt;<a href=3D"mailto:sco=
tt.wood@nxp.com">scott.wood@nxp.com</a>&gt; wrote:<br><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">On 09/06/2016 02:12 PM, Andy Fleming wrote:<br>
&gt; Boards can implement power and reset functionality over gpio using<br>
&gt; these drivers:<br>
&gt;=C2=A0 =C2=A0drivers/power/reset/gpio-<wbr>poweroff.c<br>
&gt;=C2=A0 =C2=A0drivers/power/reset/gpio-<wbr>restart.c<br>
&gt;<br>
&gt; While not all corenet boards use gpio for power/reset, this<br>
&gt; support can be added without interfering with boards that do not<br>
&gt; use this functionality.<br>
&gt;<br>
&gt; If a board&#39;s device tree has the related nodes, they are now probe=
d.<br>
&gt; Also, gpio-poweroff uses the global pm_power_off callback to implement=
<br>
&gt; the shutdown. However, pm_power_off was not invoked when the kernel<br=
>
&gt; halted, although that is usually the desired behavior. If the board<br=
>
&gt; provides gpio power and reset support, it is reasonable to assume that=
<br>
&gt; halting should also power down the system, unless it has chosen to<br>
&gt; pass those calls on to hypervisor.<br>
<br>
Halt and poweroff are not the same thing.=C2=A0 If userspace requests a<br>
poweroff, then kernel_power_off() will call machine_power_off() which<br>
will call pm_power_off().<br>
<br>
Why do we need anything corenet-specific here?</blockquote><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex"><br></blockquote><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br></blockq=
uote><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">We don&#39;t, but then the board will h=
alt instead of power off when you type shutdown -h now. Or if you type powe=
roff without a high enough run level, apparently. I&#39;m amenable to remov=
ing the halt code, but there are concerns that this will cause the systems =
to behave unintentionally as intended, in that most systems that users inte=
ract with shut down when you call shutdown -h now. There may be scripts tha=
t depend on that behavior (or at least assume it). Perhaps I could add a co=
nfig option? CONFIG_TREAT_HALT_AS_POWEROFF? CONFIG_POWEROFF_ON_HALT?</block=
quote><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex"><br></blockquote><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">I&#39;ll note that there is one other board that is doing the sam=
e thing, but they&#39;ve implemented their own gpio poweroff driver. See co=
mmit=C2=A05611fe48c545a22e62273428ed74c9bfae4a9406. That commit also points=
 vaguely in the direction of an answer to your second question...</blockquo=
te><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex"><br></blockquote><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex">
<br>
&gt; @@ -127,6 +137,12 @@ static const struct of_device_id of_device_ids[] =
=3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &quot;handles&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &quot;gpio-poweroff&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0},<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &quot;gpio-restart&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0},<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{}<br>
&gt;=C2=A0 };<br>
&gt;<br>
<br>
I don&#39;t see any other platforms doing this.=C2=A0 How do the nodes get =
probed<br>
for them?</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br></blockquote><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">The answer is I don&#39;t know, but this is a com=
mon issue with adding new devices to the device tree in embedded powerpc. T=
he only other platforms which have gpio-poweroff nodes in their trees are i=
n arch/arm, and none of those platforms call the probing function=C2=A0of_p=
latform_bus_probe. I suspect they either probe every root node, or they som=
ehow construct the match_id. As noted in the above-referenced commit, putti=
ng the nodes under the gpio bus does not cause them to get probed. This see=
med like the best way under the current corenet code.<br>
<br>
-Scott<br>
<br>
</blockquote>

--001a1134daa2c3bcf8053c2e740c--
