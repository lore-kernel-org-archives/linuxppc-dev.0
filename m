Return-Path: <vneethv@gmail.com>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4FDE3B6F8D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 21 Sep 2011 17:02:54 +1000 (EST)
Received: by bkbzu17 with SMTP id zu17so1202687bkb.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 21 Sep 2011 00:02:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4E73816C.6000304@freescale.com>
References: <CAFbQSaD-c=QqSsq__VtBEcMCJabnBi4AP4KunDNV7u7xXAuaTw@mail.gmail.com>
	<4E73816C.6000304@freescale.com>
From: Vineeth <vneethv@gmail.com>
Date: Wed, 21 Sep 2011 12:26:00 +0530
Message-ID: <CAFbQSaBcdLCoVY471mVLAyM=eYDSN77=DODPasMaAEm6pRm7jQ@mail.gmail.com>
Subject: Re: Timer interrupt on Linux 3.0.3
To: Scott Wood <scottwood@freescale.com>
Content-Type: multipart/alternative; boundary=0015174be13e02c02d04ad6e2a26
Cc: linuxppc-dev@lists.ozlabs.org, linux-embedded@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0015174be13e02c02d04ad6e2a26
Content-Type: text/plain; charset=ISO-8859-1

>> What was the issue?  You really should try to make this work rather than
>> hack around it.

what we found was the decrementer is not generating an exception when it
becomes 0. and the timebase registers are not getting incremented too. The
exceptions are enabled in MSR registers.

we are using embedded60x port of linux3.0.3; we've written the dts file with
proper clock-frequency/timebase-frequency values.

Do you think we might've missed some configuration in the timer perspective
?


On Fri, Sep 16, 2011 at 10:33 PM, Scott Wood <scottwood@freescale.com>wrote:

> On 09/16/2011 06:43 AM, Vineeth wrote:
> > Hi,
> >
> > We are porting Linux on MPC7410 based board. As there was some issue
> > with the processor DECrementer and timebase registers,
>
> What was the issue?  You really should try to make this work rather than
> hack around it.
>
> > lately we moved to Linux 3.0.3. What we found was even without a proper
> > timer, the kernel with initramfs worked (except the calls like
> > sleep,delay ofcourse); Is there any major difference in the scheduler ?
> > or the way context switch happens ? is it not depended on the timer
> > interrupt or the timer ??
>
> If your timer is broken then you won't get timeslice expiration, but
> basic scheduling should still work.  Most scheduling (depending on type
> of load, of course) will be triggered by processes blocking or being
> woken up by I/O, not timeslice expiration.
>
> -Scott
>
>

--0015174be13e02c02d04ad6e2a26
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

&gt;&gt; What was the issue? =A0You really should try to make this work rat=
her than<br>&gt;&gt; hack around it.<br><br>what we found was the decrement=
er is not generating an exception when it becomes 0. and the timebase regis=
ters are not getting incremented too. The exceptions are enabled in MSR reg=
isters.<br>

<br>we are using embedded60x port of linux3.0.3; we&#39;ve written the dts =
file with proper clock-frequency/timebase-frequency values.<br><br>Do you t=
hink we might&#39;ve missed some configuration in the timer perspective ?<b=
r>

<br><br><div class=3D"gmail_quote">On Fri, Sep 16, 2011 at 10:33 PM, Scott =
Wood <span dir=3D"ltr">&lt;<a href=3D"mailto:scottwood@freescale.com">scott=
wood@freescale.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;"=
>

<div class=3D"im">On 09/16/2011 06:43 AM, Vineeth wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; We are porting Linux on MPC7410 based board. As there was some issue<b=
r>
&gt; with the processor DECrementer and timebase registers,<br>
<br>
</div>What was the issue? =A0You really should try to make this work rather=
 than<br>
hack around it.<br>
<div class=3D"im"><br>
&gt; lately we moved to Linux 3.0.3. What we found was even without a prope=
r<br>
&gt; timer, the kernel with initramfs worked (except the calls like<br>
&gt; sleep,delay ofcourse); Is there any major difference in the scheduler =
?<br>
&gt; or the way context switch happens ? is it not depended on the timer<br=
>
&gt; interrupt or the timer ??<br>
<br>
</div>If your timer is broken then you won&#39;t get timeslice expiration, =
but<br>
basic scheduling should still work. =A0Most scheduling (depending on type<b=
r>
of load, of course) will be triggered by processes blocking or being<br>
woken up by I/O, not timeslice expiration.<br>
<font color=3D"#888888"><br>
-Scott<br>
<br>
</font></blockquote></div><br>

--0015174be13e02c02d04ad6e2a26--
