Return-Path: <csdncannon@gmail.com>
Received: from mail-pw0-f42.google.com (mail-pw0-f42.google.com
	[209.85.160.42]) by ozlabs.org (Postfix) with ESMTP id 8D9B1B7D1F
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Apr 2010 20:57:57 +1000 (EST)
Received: by pwi8 with SMTP id 8so6308275pwi.15
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Apr 2010 03:57:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100421194419.3edf2c80.kim.phillips@freescale.com>
References: <43c137a81003241941p84cba56y3e02e40cb22623e2@mail.gmail.com>
	<o2y43c137a81004092014z1511cecdxb7154825dc07b49f@mail.gmail.com>
	<20100421194419.3edf2c80.kim.phillips@freescale.com>
Date: Fri, 23 Apr 2010 18:57:55 +0800
Message-ID: <k2k43c137a81004230357qb67aa161v2ce6290d8d545906@mail.gmail.com>
Subject: Re: Continual reading from the PowerPc time base register is not
	stable
From: Csdncannon <csdncannon@gmail.com>
To: Kim Phillips <kim.phillips@freescale.com>
Content-Type: multipart/alternative; boundary=000e0cd1b2eeaf660f0484e54c70
Cc: linuxppc-dev@ozlabs.org, zhouminggang@hotmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--000e0cd1b2eeaf660f0484e54c70
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Kim
      The isync is not needed, when I only added the long long cast, the
problem can never reproduced.

      And I found after Linux started, I ran the "gettime" test code in the
background, if I ran our software application, the gettime could fail
sometimes, and even after killing our software application, the gettime
still failed, if I didn't run our software application after Linux started,
the gettime never fail . I checked out that there is no NTP damone nor cron
tasks running behind, but our software application has the mechanism like
NTP to synchronize time with other boards in our system, the problem is I
cannot figure out why gettime still failed after killing our software
application. Maybe there is a timer running for this proprietary NTP
implementation, even after killing software application?

Thanks
Gino

2010/4/22 Kim Phillips <kim.phillips@freescale.com>

> On Sat, 10 Apr 2010 11:14:09 +0800
> Csdncannon <csdncannon@gmail.com> wrote:
>
> > Sorry, I attached the wrong log, this attachment is the right one.
> >
> > 2010/3/25 Csdncannon <csdncannon@gmail.com>
> >
> > >          In my program, the value of the 64-bit time base register is
> read
> > > out, and you will find the later value is even smaller than the earli=
er
> > > value from the log =93log_timebase=94. While the kernel depends on th=
e
> accuracy
> > > of the timebase for the compensation of the lost PIT interrupt, the
> negative
> > > value between two continual timebase reading will bring to the jump o=
f
> the
> > > jiffies. And this timebase problem will bring to the instability of t=
he
> > > gettimeofday system call.
> > >
> > >          Do you have any idea about this problem, thanks for your any
> > > advice. Attached is the code and log.
>
> Hi, has this been resolved yet?
>
> I took an 8377 rdb board, and let it run timebase.c (with the isync &
> long long casts) all weekend, and have failed to reproduce the issue.
> That was on linux 2.6.33, and I've got another machine running the same
> thing under 2.6.28 for the last couple of hours, still unable to
> reproduce the issue.
>
> Can you please answer the "custom board or FSL reference board"
> question, try duplicating with a newer kernel version, discuss other
> time sources that may be running on your system (RTC_DRV, ntp service),
> post a .config, ...
>
> Kim
>

--000e0cd1b2eeaf660f0484e54c70
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Kim<br>=A0=A0=A0=A0=A0 The isync is not needed, when I only added the lo=
ng long cast, the problem can never reproduced.<br><br>=A0=A0=A0=A0=A0 And =
I found after Linux started, I ran the &quot;gettime&quot; test code in the=
 background, if I ran our software application, the gettime could fail some=
times, and even after killing our software application, the gettime still f=
ailed, if I didn&#39;t run our software application after Linux started, th=
e gettime never fail . I checked out that there is no NTP damone nor cron t=
asks running behind, but our software application has the mechanism like NT=
P to synchronize time with other boards in our system, the problem is I can=
not figure out why gettime still failed after killing our software applicat=
ion. Maybe there is a timer running for this proprietary NTP implementation=
, even after killing software application?<br>
<br>Thanks<br>Gino<br><br><div class=3D"gmail_quote">2010/4/22 Kim Phillips=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:kim.phillips@freescale.com">kim.ph=
illips@freescale.com</a>&gt;</span><br><blockquote class=3D"gmail_quote" st=
yle=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204)=
; padding-left: 1ex;">
<div><div></div><div class=3D"h5">On Sat, 10 Apr 2010 11:14:09 +0800<br>
Csdncannon &lt;<a href=3D"mailto:csdncannon@gmail.com">csdncannon@gmail.com=
</a>&gt; wrote:<br>
<br>
&gt; Sorry, I attached the wrong log, this attachment is the right one.<br>
&gt;<br>
&gt; 2010/3/25 Csdncannon &lt;<a href=3D"mailto:csdncannon@gmail.com">csdnc=
annon@gmail.com</a>&gt;<br>
&gt;<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0In my program, the value of the 64-bit time ba=
se register is read<br>
&gt; &gt; out, and you will find the later value is even smaller than the e=
arlier<br>
&gt; &gt; value from the log =93log_timebase=94. While the kernel depends o=
n the accuracy<br>
&gt; &gt; of the timebase for the compensation of the lost PIT interrupt, t=
he negative<br>
&gt; &gt; value between two continual timebase reading will bring to the ju=
mp of the<br>
&gt; &gt; jiffies. And this timebase problem will bring to the instability =
of the<br>
&gt; &gt; gettimeofday system call.<br>
&gt; &gt;<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0Do you have any idea about this problem, thank=
s for your any<br>
&gt; &gt; advice. Attached is the code and log.<br>
<br>
</div></div>Hi, has this been resolved yet?<br>
<br>
I took an 8377 rdb board, and let it run timebase.c (with the isync &amp;<b=
r>
long long casts) all weekend, and have failed to reproduce the issue.<br>
That was on linux 2.6.33, and I&#39;ve got another machine running the same=
<br>
thing under 2.6.28 for the last couple of hours, still unable to<br>
reproduce the issue.<br>
<br>
Can you please answer the &quot;custom board or FSL reference board&quot;<b=
r>
question, try duplicating with a newer kernel version, discuss other<br>
time sources that may be running on your system (RTC_DRV, ntp service),<br>
post a .config, ...<br>
<font color=3D"#888888"><br>
Kim<br>
</font></blockquote></div><br>

--000e0cd1b2eeaf660f0484e54c70--
