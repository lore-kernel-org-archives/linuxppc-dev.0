Return-Path: <vneethv@gmail.com>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4442EB6F75
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 26 Sep 2011 19:12:21 +1000 (EST)
Received: by bkbzu17 with SMTP id zu17so5308830bkb.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 26 Sep 2011 02:12:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAEZ9+qnSXXi5w9BbwyaQWQybCtaCsJ0T5j5ySEjOkpnnYmr7aA@mail.gmail.com>
References: <CAFbQSaD-c=QqSsq__VtBEcMCJabnBi4AP4KunDNV7u7xXAuaTw@mail.gmail.com>
	<4E73816C.6000304@freescale.com>
	<CAFbQSaBcdLCoVY471mVLAyM=eYDSN77=DODPasMaAEm6pRm7jQ@mail.gmail.com>
	<4E7A3DED.9030402@freescale.com>
	<CAEZ9+qnSXXi5w9BbwyaQWQybCtaCsJ0T5j5ySEjOkpnnYmr7aA@mail.gmail.com>
From: Vineeth <vneethv@gmail.com>
Date: Mon, 26 Sep 2011 14:41:56 +0530
Message-ID: <CAFbQSaAoug6Sc-ANFUaE0Y9dQROHcNxtzevj2itiArME4aHR6A@mail.gmail.com>
Subject: Re: Timer interrupt on Linux 3.0.3
To: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
	linux-embedded@vger.kernel.org
Content-Type: multipart/alternative; boundary=0015175cd5fe23524f04add48ed7
Cc: mohanreddykv@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0015175cd5fe23524f04add48ed7
Content-Type: text/plain; charset=ISO-8859-1

Hi,

there's a good news which is pretty bad. Good news is that we identified why
our processor timer not working. its because the TBEN in our board is pulled
LOW. which means the decrementer and the timebase registers wont work.

The board design cannot be changed !!! but we have an MPC107 connected with
our processor. Our plan is to use the timer of MPC107 and register our
timer_interrupt function with this timer interrupt. I think that's the only
workaround left now.

Thanks
Vineeth

On Thu, Sep 22, 2011 at 11:52 AM, MohanReddy koppula <mohanreddykv@gmail.com
> wrote:

> I had the same issue with an MPC885 board. My kernel was 2.6.33. On
> that board decrementer exception was not working. I replaced the
> board, took new board (MPC885 only, just another board) and the same
> kernel worked fine. I don't know how the problem was solved.
>
> -Mohan
>
> On 9/22/11, Scott Wood <scottwood@freescale.com> wrote:
> > On 09/21/2011 01:56 AM, Vineeth wrote:
> >>>> What was the issue?  You really should try to make this work rather
> than
> >>>> hack around it.
> >>
> >> what we found was the decrementer is not generating an exception when it
> >> becomes 0. and the timebase registers are not getting incremented too.
> >
> > Does the decrementer actually tick until it reaches zero, or do it and
> > the timebase never tick?
> >
> > Is the TBEN input to the CPU asserted?
> >
> > -Scott
> >
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
> >
>

--0015175cd5fe23524f04add48ed7
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>there&#39;s a good news which is pretty bad. Good news is that w=
e identified why our processor timer not working. its because the TBEN in o=
ur board is pulled LOW. which means the decrementer and the timebase regist=
ers wont work.<br>

<br>The board design cannot be changed !!! but we have an MPC107 connected =
with our processor. Our plan is to use the timer of MPC107 and register our=
 timer_interrupt function with this timer interrupt. I think that&#39;s the=
 only workaround left now.<br>

<br>Thanks<br>Vineeth<br><br><div class=3D"gmail_quote">On Thu, Sep 22, 201=
1 at 11:52 AM, MohanReddy koppula <span dir=3D"ltr">&lt;<a href=3D"mailto:m=
ohanreddykv@gmail.com">mohanreddykv@gmail.com</a>&gt;</span> wrote:<br><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex;">

I had the same issue with an MPC885 board. My kernel was 2.6.33. On<br>
that board decrementer exception was not working. I replaced the<br>
board, took new board (MPC885 only, just another board) and the same<br>
kernel worked fine. I don&#39;t know how the problem was solved.<br>
<br>
-Mohan<br>
<div><div></div><div class=3D"h5"><br>
On 9/22/11, Scott Wood &lt;<a href=3D"mailto:scottwood@freescale.com">scott=
wood@freescale.com</a>&gt; wrote:<br>
&gt; On 09/21/2011 01:56 AM, Vineeth wrote:<br>
&gt;&gt;&gt;&gt; What was the issue? =A0You really should try to make this =
work rather than<br>
&gt;&gt;&gt;&gt; hack around it.<br>
&gt;&gt;<br>
&gt;&gt; what we found was the decrementer is not generating an exception w=
hen it<br>
&gt;&gt; becomes 0. and the timebase registers are not getting incremented =
too.<br>
&gt;<br>
&gt; Does the decrementer actually tick until it reaches zero, or do it and=
<br>
&gt; the timebase never tick?<br>
&gt;<br>
&gt; Is the TBEN input to the CPU asserted?<br>
&gt;<br>
&gt; -Scott<br>
&gt;<br>
</div></div>&gt; _______________________________________________<br>
&gt; Linuxppc-dev mailing list<br>
&gt; <a href=3D"mailto:Linuxppc-dev@lists.ozlabs.org">Linuxppc-dev@lists.oz=
labs.org</a><br>
&gt; <a href=3D"https://lists.ozlabs.org/listinfo/linuxppc-dev" target=3D"_=
blank">https://lists.ozlabs.org/listinfo/linuxppc-dev</a><br>
&gt;<br>
</blockquote></div><br>

--0015175cd5fe23524f04add48ed7--
