Return-Path: <baolin.wang@linaro.org>
Received: from mail-yh0-f44.google.com (mail-yh0-f44.google.com
 [209.85.213.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F38091A0008
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 00:16:09 +1000 (AEST)
Received: by yhom41 with SMTP id m41so2420302yho.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 07:16:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2293496.0Ycckx2zYU@wuerfel>
References: <1431342518-29362-1-git-send-email-baolin.wang@linaro.org>
 <2293496.0Ycckx2zYU@wuerfel>
Date: Tue, 12 May 2015 22:16:07 +0800
Message-ID: <CAMz4kuLeoPsV_HHv+6Rjr-3pQbC+scFEZSz=OJ+2rUxD6uhLkA@mail.gmail.com>
Subject: Re: [PATCH v3 00/22] Convert the posix_clock_operations and k_clock
 structure to ready for 2038
From: Baolin Wang <baolin.wang@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
Content-Type: multipart/alternative; boundary=001a11397a0cb606ab0515e3221e
Cc: Xunlei Pang <pang.xunlei@linaro.org>, peterz@infradead.org,
 =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
 heiko.carstens@de.ibm.com, paulus@samba.org, cl@linux.com,
 Heena Sirwani <heenasirwani@gmail.com>, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, y2038 Mailman List <y2038@lists.linaro.org>,
 rafael.j.wysocki@intel.com, Andrew Hunter <ahh@google.com>,
 Paul Turner <pjt@google.com>, riel@redhat.com,
 Richard Cochran <richardcochran@gmail.com>, tj@kernel.org,
 John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
 rth@twiddle.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, schwidefsky@de.ibm.com, linux390@de.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a11397a0cb606ab0515e3221e
Content-Type: text/plain; charset=UTF-8

On 12 May 2015 at 17:39, Arnd Bergmann <arnd@arndb.de> wrote:

> On Monday 11 May 2015 19:08:38 Baolin Wang wrote:
> > This patch series changes the 32-bit time type (timespec/itimerspec) to
> the 64-bit one
> > (timespec64/itimerspec64), since 32-bit time types will break in the
> year 2038.
> >
> > This patch series introduces new methods with timespec64/itimerspec64
> type,
> > and removes the old ones with timespec/itimerspec type for
> posix_clock_operations
> > and k_clock structure.
> >
> > Also introduces some new functions with timespec64/itimerspec64 type,
> like current_kernel_time64(),
> > hrtimer_get_res64(), cputime_to_timespec64() and timespec64_to_cputime().
> >
> > Changes since v2:
> >       -Split the syscall conversion patch into small some patches.
> >
> >
> > Baolin Wang (22):
> >   linux/time64.h:Introduce the 'struct itimerspec64' for 64bit
> >   timekeeping:Introduce the current_kernel_time64() function with
> >     timespec64 type
> >   time/hrtimer:Introduce hrtimer_get_res64() with timespec64 type for
> >     getting the timer resolution
> >   posix-timers:Split out the guts of the syscall and change the
> >     implementation for timer_gettime
> >   posix-timers:Convert to the 64bit methods for the timer_gettime
> >     syscall function
>
> I have two more very general comments about the series:
>
> a) something has gone wrong with your submission in v2 and v3 but was
>    working earlier: normally all emails should be sent by git-send-email
>    as replies to the [patch 00/22] mail. This is the default, and it
>    is enabled by the '--thread --no-chain-reply' options. Please try
>    to get this to work again.
>
> b) it would be better to have a little shorter subject lines, to avoid
>    line-wrapping in the list above. Here are some examples what you could
>    use to replace the lines above:
>
>    timekeeping: introduce struct itimerspec64
>    timekeeping: introduce current_kernel_time64()
>    hrtimer: introduce hrtimer_get_res64()
>    posix-timers: split up sys_timer_gettime()
>    posix-timers: convert timer_gettime() to timespec64
>
>    In general, try to come up with the shortest description that
>    uniquely describes what your patch does, and move any details into
>    the longer patch description.
>
>         Arnd
>

OK, i'll fix these in next patch series.Thanks for your comments.


-- 
Baolin.wang
Best Regards

--001a11397a0cb606ab0515e3221e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On 12 May 2015 at 17:39, Arnd Bergmann <span dir=3D"ltr">&lt;<a href=3D=
"mailto:arnd@arndb.de" target=3D"_blank">arnd@arndb.de</a>&gt;</span> wrote=
:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex"><span class=3D"">On Monday 11 May 2015 =
19:08:38 Baolin Wang wrote:<br>
&gt; This patch series changes the 32-bit time type (timespec/itimerspec) t=
o the 64-bit one<br>
&gt; (timespec64/itimerspec64), since 32-bit time types will break in the y=
ear 2038.<br>
&gt;<br>
&gt; This patch series introduces new methods with timespec64/itimerspec64 =
type,<br>
&gt; and removes the old ones with timespec/itimerspec type for posix_clock=
_operations<br>
&gt; and k_clock structure.<br>
&gt;<br>
&gt; Also introduces some new functions with timespec64/itimerspec64 type, =
like current_kernel_time64(),<br>
&gt; hrtimer_get_res64(), cputime_to_timespec64() and timespec64_to_cputime=
().<br>
&gt;<br>
&gt; Changes since v2:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-Split the syscall conversion patch into sma=
ll some patches.<br>
&gt;<br>
&gt;<br>
&gt; Baolin Wang (22):<br>
&gt;=C2=A0 =C2=A0linux/time64.h:Introduce the &#39;struct itimerspec64&#39;=
 for 64bit<br>
&gt;=C2=A0 =C2=A0timekeeping:Introduce the current_kernel_time64() function=
 with<br>
&gt;=C2=A0 =C2=A0 =C2=A0timespec64 type<br>
&gt;=C2=A0 =C2=A0time/hrtimer:Introduce hrtimer_get_res64() with timespec64=
 type for<br>
&gt;=C2=A0 =C2=A0 =C2=A0getting the timer resolution<br>
&gt;=C2=A0 =C2=A0posix-timers:Split out the guts of the syscall and change =
the<br>
&gt;=C2=A0 =C2=A0 =C2=A0implementation for timer_gettime<br>
&gt;=C2=A0 =C2=A0posix-timers:Convert to the 64bit methods for the timer_ge=
ttime<br>
&gt;=C2=A0 =C2=A0 =C2=A0syscall function<br>
<br>
</span>I have two more very general comments about the series:<br>
<br>
a) something has gone wrong with your submission in v2 and v3 but was<br>
=C2=A0 =C2=A0working earlier: normally all emails should be sent by git-sen=
d-email<br>
=C2=A0 =C2=A0as replies to the [patch 00/22] mail. This is the default, and=
 it<br>
=C2=A0 =C2=A0is enabled by the &#39;--thread --no-chain-reply&#39; options.=
 Please try<br>
=C2=A0 =C2=A0to get this to work again.<br>
<br>
b) it would be better to have a little shorter subject lines, to avoid<br>
=C2=A0 =C2=A0line-wrapping in the list above. Here are some examples what y=
ou could<br>
=C2=A0 =C2=A0use to replace the lines above:<br>
<br>
=C2=A0 =C2=A0timekeeping: introduce struct itimerspec64<br>
=C2=A0 =C2=A0timekeeping: introduce current_kernel_time64()<br>
=C2=A0 =C2=A0hrtimer: introduce hrtimer_get_res64()<br>
=C2=A0 =C2=A0posix-timers: split up sys_timer_gettime()<br>
=C2=A0 =C2=A0posix-timers: convert timer_gettime() to timespec64<br>
<br>
=C2=A0 =C2=A0In general, try to come up with the shortest description that<=
br>
=C2=A0 =C2=A0uniquely describes what your patch does, and move any details =
into<br>
=C2=A0 =C2=A0the longer patch description.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Arnd<br>
</font></span></blockquote></div><div class=3D"gmail_extra"><br></div>OK, i=
&#39;ll fix these in next patch series.Thanks for your comments.<br><br cle=
ar=3D"all"><div><br></div>-- <br><div class=3D"gmail_signature"><div dir=3D=
"ltr"><div>Baolin.wang<br></div>Best Regards<br></div></div>
</div></div>

--001a11397a0cb606ab0515e3221e--
