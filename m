Return-Path: <arjanvandeven@gmail.com>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
 [209.85.213.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 633C51007D5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2012 01:31:23 +1100 (EST)
Received: by yhr47 with SMTP id 47so2933yhr.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2012 06:31:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4F3A2DFB.5000209@linux.vnet.ibm.com>
References: <20120130205444.22f5e26a@infradead.org>
 <20120131125232.GD4408@elte.hu>
 <20120131054155.371e8307@infradead.org>
 <20120131143130.GF13676@elte.hu>
 <20120131072216.1ce78e50@infradead.org>
 <20120131161207.GA18357@elte.hu>
 <20120131082439.575978c0@infradead.org>
 <4F3A1891.8060001@linux.vnet.ibm.com>
 <4F3A2DFB.5000209@linux.vnet.ibm.com>
Date: Tue, 14 Feb 2012 06:31:16 -0800
Message-ID: <CADyApD0o4UYsTkqf2H2yJZ-d05NAyRAEc6z+m1gJEogc=cZLqQ@mail.gmail.com>
Subject: Re: smp: Start up non-boot CPUs asynchronously
From: Arjan van de Ven <arjanvandeven@gmail.com>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Content-Type: multipart/alternative; boundary=001636c5c1529b32e404b8ed7268
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, mikey@neuling.org,
 Peter Zijlstra <a.p.zijlstra@chello.nl>, gregkh@linuxfoundation.org,
 Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
 Milton Miller <miltonm@bga.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Arjan van de Ven <arjan@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Arjan van de Ven <arjan@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001636c5c1529b32e404b8ed7268
Content-Type: text/plain; charset=UTF-8

one coments; will comment more when I get to work

On Tue, Feb 14, 2012 at 1:48 AM, Srivatsa S. Bhat

7. And whichever code between smp_init() and async_synchronize_full() didn't
>
> care about CPU hotplug till today but depended on all cpus being online
> must
> suddenly start worrying about CPU Hotplug. They must register a cpu
> notifier
> and handle callbacks etc etc.. Or if they are not worth that complexity,
> they
> should atleast be redesigned or moved around - like the print statements
> that
> tell how many cpus came up, for example.
>
>
frankly, such code HAS to worry about cpus going online and offline even
today; the firmware, at least on X86, can start taking cores offline/online
once ACPI is initialized....
(as controlled by a data center manager from outside the box, usually done
based on thermal or power conditions on a datacenter level).
Now, no doubt that we have bugs in this space, since this only happened
very rarely before.

Question is what to do from a longer term strategy:
Either we declare the number of online CPUs invariant during a certain
phase of the boot (and make ACPI and co honor this as well somehow)
or
We decide to go about fixing these (maybe with the help of lockdep?)

In addition to this, the reality is that the whole "bring cpus up" sequence
needs to be changed; the current one is very messy and requires the hotplug
lock for the whole bring up of each individual cpu... which is a very
unfortunate design; a much better design would be to only take the lock for
the actual registration of the newly brought up CPU to the kernel, while
running the physical bringup without the global lock.
If/when that change gets made, we can do the physical bring up in parallel
(with each other, but also with the rest of the kernel boot), and do the
registration en-mass at some convenient time in the boot, potentially late.

--001636c5c1529b32e404b8ed7268
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

one coments; will comment more when I get to work<br><br><div class=3D"gmai=
l_quote">On Tue, Feb 14, 2012 at 1:48 AM, Srivatsa S. Bhat=C2=A0</div><div =
class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">7. And whichever=
 code between smp_init() and async_synchronize_full() didn&#39;t<blockquote=
 class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc soli=
d;padding-left:1ex">

care about CPU hotplug till today but depended on all cpus being online mus=
t<br>
suddenly start worrying about CPU Hotplug. They must register a cpu notifie=
r<br>
and handle callbacks etc etc.. Or if they are not worth that complexity, th=
ey<br>
should atleast be redesigned or moved around - like the print statements th=
at<br>
tell how many cpus came up, for example.<br><br></blockquote><div><br></div=
><div>frankly, such code HAS to worry about cpus going online and offline e=
ven today; the firmware, at least on X86, can start taking cores offline/on=
line once ACPI is initialized....</div>
<div>(as controlled by a data center manager from outside the box, usually =
done based on thermal or power conditions on a datacenter level).</div><div=
>Now, no doubt that we have bugs in this space, since this only happened ve=
ry rarely before.</div>
<div><br></div><div>Question is what to do from a longer term strategy:</di=
v><div>Either we declare the number of online CPUs invariant during a certa=
in phase of the boot (and make ACPI and co honor this as well somehow)</div=
>
<div>or</div><div>We decide to go about fixing these (maybe with the help o=
f lockdep?)</div><div><br></div><div>In addition to this, the reality is th=
at the whole &quot;bring cpus up&quot; sequence needs to be changed; the cu=
rrent one is very messy and requires the hotplug lock for the whole bring u=
p of each individual cpu... which is a very unfortunate design; a much bett=
er design would be to only take the lock for the actual registration of the=
 newly brought up CPU to the kernel, while running the physical bringup wit=
hout the global lock.</div>
<div>If/when that change gets made, we can do the physical bring up in para=
llel (with each other, but also with the rest of the kernel boot), and do t=
he registration en-mass at some convenient time in the boot, potentially la=
te.</div>
<div><br></div><div>=C2=A0</div></div>

--001636c5c1529b32e404b8ed7268--
