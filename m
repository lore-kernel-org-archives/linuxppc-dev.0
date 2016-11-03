Return-Path: <kirjanov@gmail.com>
Received: from mail-ua0-x236.google.com (mail-ua0-x236.google.com
 [IPv6:2607:f8b0:400c:c08::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t8p261r1YzDt3H
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2016 01:56:14 +1100 (AEDT)
Received: by mail-ua0-x236.google.com with SMTP id 20so41364499uak.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Nov 2016 07:56:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20161103144333.GA28138@in.ibm.com>
References: <1478172041-9067-1-git-send-email-kda@linux-powerpc.org>
 <20161103144333.GA28138@in.ibm.com>
From: Denis Kirjanov <kirjanov@gmail.com>
Date: Thu, 3 Nov 2016 17:56:10 +0300
Message-ID: <CAHj3AVk95P3_oz--y58ND_Tq8d68u6fcXgg8mVh1PHCLFbuKGg@mail.gmail.com>
Subject: Re: [PATCH] ppc: cpufreq: Use get_cpu()/put_cpu() instead of
 smp_processor_id() to avoid the oops
To: "ego@linux.vnet.ibm.com" <ego@linux.vnet.ibm.com>
Cc: Denis Kirjanov <kda@linux-powerpc.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Content-Type: multipart/alternative; boundary=001a113e4b9a21dbd3054066c2e0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a113e4b9a21dbd3054066c2e0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thursday, November 3, 2016, Gautham R Shenoy <ego@linux.vnet.ibm.com>
wrote:

> Hi Denis,
>
> On Thu, Nov 03, 2016 at 07:20:41AM -0400, Denis Kirjanov wrote:
> > [   67.700897] BUG: using smp_processor_id() in preemptible [00000000]
> code: cat/7343
> > [   67.700988] caller is .powernv_cpufreq_throttle_check+0x2c/0x710
> > [   67.700998] CPU: 13 PID: 7343 Comm: cat Not tainted 4.8.0-rc5-dirty =
#1
> > [   67.701038] Call Trace:
> > [   67.701066] [c0000007d25b75b0] [c000000000971378]
> .dump_stack+0xe4/0x150 (unreliable)
> > [   67.701153] [c0000007d25b7640] [c0000000005162e4]
> .check_preemption_disabled+0x134/0x150
> > [   67.701238] [c0000007d25b76e0] [c0000000007b63ac]
> .powernv_cpufreq_throttle_check+0x2c/0x710
> > [   67.701322] [c0000007d25b7790] [c0000000007b6d18]
> .powernv_cpufreq_target_index+0x288/0x360
> > [   67.701407] [c0000007d25b7870] [c0000000007acee4]
> .__cpufreq_driver_target+0x394/0x8c0
> > [   67.701491] [c0000007d25b7920] [c0000000007b22ac]
> .cpufreq_set+0x7c/0xd0
> > [   67.701565] [c0000007d25b79b0] [c0000000007adf50]
> .store_scaling_setspeed+0x80/0xc0
> > [   67.701650] [c0000007d25b7a40] [c0000000007ae270] .store+0xa0/0x100
> > [   67.701723] [c0000007d25b7ae0] [c0000000003566e8]
> .sysfs_kf_write+0x88/0xb0
> > [   67.701796] [c0000007d25b7b70] [c0000000003553b8]
> .kernfs_fop_write+0x178/0x260
> > [   67.701881] [c0000007d25b7c10] [c0000000002ac3cc]
> .__vfs_write+0x3c/0x1c0
> > [   67.701954] [c0000007d25b7cf0] [c0000000002ad584]
> .vfs_write+0xc4/0x230
> > [   67.702027] [c0000007d25b7d90] [c0000000002aeef8]
> .SyS_write+0x58/0x100
> > [   67.702101] [c0000007d25b7e30] [c00000000000bfec]
> system_call+0x38/0xfc
> >
> > Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org <javascript:;>>
>
>
> Thanks for looking into this!
> > ---
> >  drivers/cpufreq/powernv-cpufreq.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/powernv-cpufreq.c
> b/drivers/cpufreq/powernv-cpufreq.c
> > index d3ffde8..4cd91a3 100644
> > --- a/drivers/cpufreq/powernv-cpufreq.c
> > +++ b/drivers/cpufreq/powernv-cpufreq.c
> > @@ -475,7 +475,7 @@ static inline unsigned int get_nominal_index(void)
> >  static void powernv_cpufreq_throttle_check(void *data)
>
> The powernv_cpufreq_throttle_check() checks if the frequency on any of
> the CPUs on this chip has been throttled. Hence it needs to be
> executed without preemption on a CPU on the particular chip.
>
> It is called in two places currently:
>
> a) powernv_cpufreq_work_fn where
> it is called via smp_call_function_any() which will ensure that the
> function will be executed without preempted.
>
> b) from powernv_cpufreq_target_index: Here it should be nested within
> the preempt_disable() preempt_enable() calls. It currently is not.
>
> So, I would suggest fixing b) instead of locally fixing
> smp_processor_id() to get_cpu()/put_cpu().


Ok, I'll send the v2 then.

Thanks!

>
> >  {
> >       struct chip *chip;
> > -     unsigned int cpu =3D smp_processor_id();
> > +     int cpu;
> >       unsigned long pmsr;
> >       int pmsr_pmax;
> >       unsigned int pmsr_pmax_idx;
> > @@ -491,9 +491,11 @@ static void powernv_cpufreq_throttle_check(void
> *data)
> >                       goto next;
> >               chip->throttled =3D true;
> >               if (pmsr_pmax_idx > powernv_pstate_info.nominal) {
> > +                     cpu =3D get_cpu();
> >                       pr_warn_once("CPU %d on Chip %u has Pmax(%d)
> reduced below nominal frequency(%d)\n",
> >                                    cpu, chip->id, pmsr_pmax,
> >                                    idx_to_pstate(powernv_pstate_
> info.nominal));
> > +                     put_cpu();
> >                       chip->throttle_sub_turbo++;
> >               } else {
> >                       chip->throttle_turbo++;
> > --
> > 1.8.3.1
> >
>
> --
> Thanks and Regards
> gautham.
>
>

--=20
Regards / Mit besten Gr=C3=BC=C3=9Fen,
Denis

--001a113e4b9a21dbd3054066c2e0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><br>On Thursday, November 3, 2016, Gautham R Shenoy &lt;<a href=3D"mail=
to:ego@linux.vnet.ibm.com">ego@linux.vnet.ibm.com</a>&gt; wrote:<br><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">Hi Denis,<br>
<br>
On Thu, Nov 03, 2016 at 07:20:41AM -0400, Denis Kirjanov wrote:<br>
&gt; [=C2=A0 =C2=A067.700897] BUG: using smp_processor_id() in preemptible =
[00000000] code: cat/7343<br>
&gt; [=C2=A0 =C2=A067.700988] caller is .powernv_cpufreq_throttle_<wbr>chec=
k+0x2c/0x710<br>
&gt; [=C2=A0 =C2=A067.700998] CPU: 13 PID: 7343 Comm: cat Not tainted 4.8.0=
-rc5-dirty #1<br>
&gt; [=C2=A0 =C2=A067.701038] Call Trace:<br>
&gt; [=C2=A0 =C2=A067.701066] [c0000007d25b75b0] [c000000000971378] .dump_s=
tack+0xe4/0x150 (unreliable)<br>
&gt; [=C2=A0 =C2=A067.701153] [c0000007d25b7640] [c0000000005162e4] .check_=
preemption_disabled+<wbr>0x134/0x150<br>
&gt; [=C2=A0 =C2=A067.701238] [c0000007d25b76e0] [c0000000007b63ac] .powern=
v_cpufreq_throttle_<wbr>check+0x2c/0x710<br>
&gt; [=C2=A0 =C2=A067.701322] [c0000007d25b7790] [c0000000007b6d18] .powern=
v_cpufreq_target_index+<wbr>0x288/0x360<br>
&gt; [=C2=A0 =C2=A067.701407] [c0000007d25b7870] [c0000000007acee4] .__cpuf=
req_driver_target+<wbr>0x394/0x8c0<br>
&gt; [=C2=A0 =C2=A067.701491] [c0000007d25b7920] [c0000000007b22ac] .cpufre=
q_set+0x7c/0xd0<br>
&gt; [=C2=A0 =C2=A067.701565] [c0000007d25b79b0] [c0000000007adf50] .store_=
scaling_setspeed+0x80/<wbr>0xc0<br>
&gt; [=C2=A0 =C2=A067.701650] [c0000007d25b7a40] [c0000000007ae270] .store+=
0xa0/0x100<br>
&gt; [=C2=A0 =C2=A067.701723] [c0000007d25b7ae0] [c0000000003566e8] .sysfs_=
kf_write+0x88/0xb0<br>
&gt; [=C2=A0 =C2=A067.701796] [c0000007d25b7b70] [c0000000003553b8] .kernfs=
_fop_write+0x178/0x260<br>
&gt; [=C2=A0 =C2=A067.701881] [c0000007d25b7c10] [c0000000002ac3cc] .__vfs_=
write+0x3c/0x1c0<br>
&gt; [=C2=A0 =C2=A067.701954] [c0000007d25b7cf0] [c0000000002ad584] .vfs_wr=
ite+0xc4/0x230<br>
&gt; [=C2=A0 =C2=A067.702027] [c0000007d25b7d90] [c0000000002aeef8] .SyS_wr=
ite+0x58/0x100<br>
&gt; [=C2=A0 =C2=A067.702101] [c0000007d25b7e30] [c00000000000bfec] system_=
call+0x38/0xfc<br>
&gt;<br>
&gt; Signed-off-by: Denis Kirjanov &lt;<a href=3D"javascript:;" onclick=3D"=
_e(event, &#39;cvml&#39;, &#39;kda@linux-powerpc.org&#39;)">kda@linux-power=
pc.org</a>&gt;<br>
<br>
<br>
Thanks for looking into this!<br>
&gt; ---<br>
&gt;=C2=A0 drivers/cpufreq/powernv-<wbr>cpufreq.c | 4 +++-<br>
&gt;=C2=A0 1 file changed, 3 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/cpufreq/powernv-<wbr>cpufreq.c b/drivers/cpufreq/=
powernv-<wbr>cpufreq.c<br>
&gt; index d3ffde8..4cd91a3 100644<br>
&gt; --- a/drivers/cpufreq/powernv-<wbr>cpufreq.c<br>
&gt; +++ b/drivers/cpufreq/powernv-<wbr>cpufreq.c<br>
&gt; @@ -475,7 +475,7 @@ static inline unsigned int get_nominal_index(void)=
<br>
&gt;=C2=A0 static void powernv_cpufreq_throttle_<wbr>check(void *data)<br>
<br>
The powernv_cpufreq_throttle_<wbr>check() checks if the frequency on any of=
<br>
the CPUs on this chip has been throttled. Hence it needs to be<br>
executed without preemption on a CPU on the particular chip.<br>
<br>
It is called in two places currently:<br>
<br>
a) powernv_cpufreq_work_fn where<br>
it is called via smp_call_function_any() which will ensure that the<br>
function will be executed without preempted.<br>
<br>
b) from powernv_cpufreq_target_index: Here it should be nested within<br>
the preempt_disable() preempt_enable() calls. It currently is not.<br>
<br>
So, I would suggest fixing b) instead of locally fixing<br>
smp_processor_id() to get_cpu()/put_cpu().</blockquote><div><br></div><div>=
Ok, I&#39;ll send the v2 then.</div><div><br></div><div>Thanks!=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct chip *chip;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0unsigned int cpu =3D smp_processor_id();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int cpu;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long pmsr;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int pmsr_pmax;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int pmsr_pmax_idx;<br>
&gt; @@ -491,9 +491,11 @@ static void powernv_cpufreq_throttle_<wbr>check(v=
oid *data)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0goto next;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0chip-&gt;throttl=
ed =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (pmsr_pmax_id=
x &gt; powernv_pstate_info.nominal) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0cpu =3D get_cpu();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0pr_warn_once(&quot;CPU %d on Chip %u has Pmax(%d) reduced belo=
w nominal frequency(%d)\n&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu, chip-&gt;id, p=
msr_pmax,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 idx_to_pstate(power=
nv_pstate_<wbr>info.nominal));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0put_cpu();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0chip-&gt;throttle_sub_turbo++;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0chip-&gt;throttle_turbo++;<br>
&gt; --<br>
&gt; 1.8.3.1<br>
&gt;<br>
<br>
--<br>
Thanks and Regards<br>
gautham.<br>
<br>
</blockquote><br><br>-- <br>Regards / Mit besten Gr=C3=BC=C3=9Fen,<br>Denis=
<br><br>

--001a113e4b9a21dbd3054066c2e0--
