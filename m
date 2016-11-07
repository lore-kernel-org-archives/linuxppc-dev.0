Return-Path: <kda@linux-powerpc.org>
Received: from mail-yb0-x244.google.com (mail-yb0-x244.google.com
 [IPv6:2607:f8b0:4002:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tC0y75cDqzDvQF
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Nov 2016 16:15:27 +1100 (AEDT)
Received: by mail-yb0-x244.google.com with SMTP id h184so960565ybb.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 Nov 2016 21:15:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161107023147.GA14131@in.ibm.com>
References: <1478257718-14923-1-git-send-email-kda@linux-powerpc.org>
 <20161107023147.GA14131@in.ibm.com>
From: Denis Kirjanov <kda@linux-powerpc.org>
Date: Mon, 7 Nov 2016 08:15:24 +0300
Message-ID: <CAOJe8K2sU02tz0TBaiVGJfpen1kmovd6P=3+GpZ0cijoGoap7A@mail.gmail.com>
Subject: Re: [PATCH v2] ppc: cpufreq: disable preemption while checking CPU
 throttling state
To: "ego@linux.vnet.ibm.com" <ego@linux.vnet.ibm.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: multipart/alternative; boundary=001a1142f16c7f40de0540af1cb8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a1142f16c7f40de0540af1cb8
Content-Type: text/plain; charset=UTF-8

On Monday, November 7, 2016, Gautham R Shenoy <ego@linux.vnet.ibm.com>
wrote:

> Hi Denis,
>
> On Fri, Nov 04, 2016 at 07:08:38AM -0400, Denis Kirjanov wrote:
>
> You can provide the config option with which this bug was found in the
> change log. I suppose you had enabled CONFIG_DEBUG_PREEMPT.
>
>
that's why I put the comment


> >     [   67.700897] BUG: using smp_processor_id() in preemptible
> [00000000] code: cat/7343
> >     [   67.700988] caller is .powernv_cpufreq_throttle_check+0x2c/0x710
> >     [   67.700998] CPU: 13 PID: 7343 Comm: cat Not tainted
> 4.8.0-rc5-dirty #1
> >     [   67.701038] Call Trace:
> >     [   67.701066] [c0000007d25b75b0] [c000000000971378]
> .dump_stack+0xe4/0x150 (unreliable)
> >     [   67.701153] [c0000007d25b7640] [c0000000005162e4]
> .check_preemption_disabled+0x134/0x150
> >     [   67.701238] [c0000007d25b76e0] [c0000000007b63ac]
> .powernv_cpufreq_throttle_check+0x2c/0x710
> >     [   67.701322] [c0000007d25b7790] [c0000000007b6d18]
> .powernv_cpufreq_target_index+0x288/0x360
> >     [   67.701407] [c0000007d25b7870] [c0000000007acee4]
> .__cpufreq_driver_target+0x394/0x8c0
> >     [   67.701491] [c0000007d25b7920] [c0000000007b22ac]
> .cpufreq_set+0x7c/0xd0
> >     [   67.701565] [c0000007d25b79b0] [c0000000007adf50]
> .store_scaling_setspeed+0x80/0xc0
> >     [   67.701650] [c0000007d25b7a40] [c0000000007ae270]
> .store+0xa0/0x100
> >     [   67.701723] [c0000007d25b7ae0] [c0000000003566e8]
> .sysfs_kf_write+0x88/0xb0
> >     [   67.701796] [c0000007d25b7b70] [c0000000003553b8]
> .kernfs_fop_write+0x178/0x260
> >     [   67.701881] [c0000007d25b7c10] [c0000000002ac3cc]
> .__vfs_write+0x3c/0x1c0
> >     [   67.701954] [c0000007d25b7cf0] [c0000000002ad584]
> .vfs_write+0xc4/0x230
> >     [   67.702027] [c0000007d25b7d90] [c0000000002aeef8]
> .SyS_write+0x58/0x100
> >     [   67.702101] [c0000007d25b7e30] [c00000000000bfec]
> system_call+0x38/0xfc
> >
> > Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org <javascript:;>>
> >
> > v2:  wrap powernv_cpufreq_throttle_check()
> > as suggested by Gautham R Shenoy
>
> Looks good otherwise.
>
> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com <javascript:;>>
>
> > ---
> >  drivers/cpufreq/powernv-cpufreq.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/powernv-cpufreq.c
> b/drivers/cpufreq/powernv-cpufreq.c
> > index d3ffde8..112e0e2 100644
> > --- a/drivers/cpufreq/powernv-cpufreq.c
> > +++ b/drivers/cpufreq/powernv-cpufreq.c
> > @@ -647,8 +647,15 @@ static int powernv_cpufreq_target_index(struct
> cpufreq_policy *policy,
> >       if (unlikely(rebooting) && new_index != get_nominal_index())
> >               return 0;
> >
> > -     if (!throttled)
> > +     if (!throttled) {
> > +             /*
> > +              * we don't want to be preempted while
> > +              * checking if the CPU frequency has been throttled
> > +              */
> > +             preempt_disable();
> >               powernv_cpufreq_throttle_check(NULL);
> > +             preempt_enable();
> > +    }
> >
> >       cur_msec = jiffies_to_msecs(get_jiffies_64());
> >
> > --
> > 1.8.3.1
> >
>
>

--001a1142f16c7f40de0540af1cb8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><br>On Monday, November 7, 2016, Gautham R Shenoy &lt;<a href=3D"mailto=
:ego@linux.vnet.ibm.com">ego@linux.vnet.ibm.com</a>&gt; wrote:<br><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">Hi Denis,<br>
<br>
On Fri, Nov 04, 2016 at 07:08:38AM -0400, Denis Kirjanov wrote:<br>
<br>
You can provide the config option with which this bug was found in the<br>
change log. I suppose you had enabled CONFIG_DEBUG_PREEMPT.<br>
<br></blockquote><div><br></div>that&#39;s why I put the comment=C2=A0<br><=
div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex">
&gt;=C2=A0 =C2=A0 =C2=A0[=C2=A0 =C2=A067.700897] BUG: using smp_processor_i=
d() in preemptible [00000000] code: cat/7343<br>
&gt;=C2=A0 =C2=A0 =C2=A0[=C2=A0 =C2=A067.700988] caller is .powernv_cpufreq=
_throttle_<wbr>check+0x2c/0x710<br>
&gt;=C2=A0 =C2=A0 =C2=A0[=C2=A0 =C2=A067.700998] CPU: 13 PID: 7343 Comm: ca=
t Not tainted 4.8.0-rc5-dirty #1<br>
&gt;=C2=A0 =C2=A0 =C2=A0[=C2=A0 =C2=A067.701038] Call Trace:<br>
&gt;=C2=A0 =C2=A0 =C2=A0[=C2=A0 =C2=A067.701066] [c0000007d25b75b0] [c00000=
0000971378] .dump_stack+0xe4/0x150 (unreliable)<br>
&gt;=C2=A0 =C2=A0 =C2=A0[=C2=A0 =C2=A067.701153] [c0000007d25b7640] [c00000=
00005162e4] .check_preemption_disabled+<wbr>0x134/0x150<br>
&gt;=C2=A0 =C2=A0 =C2=A0[=C2=A0 =C2=A067.701238] [c0000007d25b76e0] [c00000=
00007b63ac] .powernv_cpufreq_throttle_<wbr>check+0x2c/0x710<br>
&gt;=C2=A0 =C2=A0 =C2=A0[=C2=A0 =C2=A067.701322] [c0000007d25b7790] [c00000=
00007b6d18] .powernv_cpufreq_target_index+<wbr>0x288/0x360<br>
&gt;=C2=A0 =C2=A0 =C2=A0[=C2=A0 =C2=A067.701407] [c0000007d25b7870] [c00000=
00007acee4] .__cpufreq_driver_target+<wbr>0x394/0x8c0<br>
&gt;=C2=A0 =C2=A0 =C2=A0[=C2=A0 =C2=A067.701491] [c0000007d25b7920] [c00000=
00007b22ac] .cpufreq_set+0x7c/0xd0<br>
&gt;=C2=A0 =C2=A0 =C2=A0[=C2=A0 =C2=A067.701565] [c0000007d25b79b0] [c00000=
00007adf50] .store_scaling_setspeed+0x80/<wbr>0xc0<br>
&gt;=C2=A0 =C2=A0 =C2=A0[=C2=A0 =C2=A067.701650] [c0000007d25b7a40] [c00000=
00007ae270] .store+0xa0/0x100<br>
&gt;=C2=A0 =C2=A0 =C2=A0[=C2=A0 =C2=A067.701723] [c0000007d25b7ae0] [c00000=
00003566e8] .sysfs_kf_write+0x88/0xb0<br>
&gt;=C2=A0 =C2=A0 =C2=A0[=C2=A0 =C2=A067.701796] [c0000007d25b7b70] [c00000=
00003553b8] .kernfs_fop_write+0x178/0x260<br>
&gt;=C2=A0 =C2=A0 =C2=A0[=C2=A0 =C2=A067.701881] [c0000007d25b7c10] [c00000=
00002ac3cc] .__vfs_write+0x3c/0x1c0<br>
&gt;=C2=A0 =C2=A0 =C2=A0[=C2=A0 =C2=A067.701954] [c0000007d25b7cf0] [c00000=
00002ad584] .vfs_write+0xc4/0x230<br>
&gt;=C2=A0 =C2=A0 =C2=A0[=C2=A0 =C2=A067.702027] [c0000007d25b7d90] [c00000=
00002aeef8] .SyS_write+0x58/0x100<br>
&gt;=C2=A0 =C2=A0 =C2=A0[=C2=A0 =C2=A067.702101] [c0000007d25b7e30] [c00000=
000000bfec] system_call+0x38/0xfc<br>
&gt;<br>
&gt; Signed-off-by: Denis Kirjanov &lt;<a href=3D"javascript:;" onclick=3D"=
_e(event, &#39;cvml&#39;, &#39;kda@linux-powerpc.org&#39;)">kda@linux-power=
pc.org</a>&gt;<br>
&gt;<br>
&gt; v2:=C2=A0 wrap powernv_cpufreq_throttle_<wbr>check()<br>
&gt; as suggested by Gautham R Shenoy<br>
<br>
Looks good otherwise.<br>
<br>
Reviewed-by: Gautham R. Shenoy &lt;<a href=3D"javascript:;" onclick=3D"_e(e=
vent, &#39;cvml&#39;, &#39;ego@linux.vnet.ibm.com&#39;)">ego@linux.vnet.ibm=
.com</a>&gt;<br>
<br>
&gt; ---<br>
&gt;=C2=A0 drivers/cpufreq/powernv-<wbr>cpufreq.c | 9 ++++++++-<br>
&gt;=C2=A0 1 file changed, 8 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/cpufreq/powernv-<wbr>cpufreq.c b/drivers/cpufreq/=
powernv-<wbr>cpufreq.c<br>
&gt; index d3ffde8..112e0e2 100644<br>
&gt; --- a/drivers/cpufreq/powernv-<wbr>cpufreq.c<br>
&gt; +++ b/drivers/cpufreq/powernv-<wbr>cpufreq.c<br>
&gt; @@ -647,8 +647,15 @@ static int powernv_cpufreq_target_index(<wbr>stru=
ct cpufreq_policy *policy,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely(rebooting) &amp;&amp; new_index=
 !=3D get_nominal_index())<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (!throttled)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!throttled) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * we don&#39;t want =
to be preempted while<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * checking if the CP=
U frequency has been throttled<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0preempt_disable();<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0powernv_cpufreq_=
throttle_<wbr>check(NULL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0preempt_enable();<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0cur_msec =3D jiffies_to_msecs(get_jiffies_<w=
br>64());<br>
&gt;<br>
&gt; --<br>
&gt; 1.8.3.1<br>
&gt;<br>
<br>
</blockquote>

--001a1142f16c7f40de0540af1cb8--
