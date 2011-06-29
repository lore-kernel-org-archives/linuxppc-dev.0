Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1AE78B6F5A
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Jun 2011 11:06:45 +1000 (EST)
Subject: Re: [PATCH] powerpc/timebase_read: don't return time older than
	cycle_last
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20110628190807.53a2c289@schlenkerla.am.freescale.net>
References: <20110627215613.GA13676@schlenkerla.am.freescale.net>
	<1309221943.32158.412.camel@pasglop>
	<20110628111420.15052d9f@schlenkerla.am.freescale.net>
	<1309303508.32158.473.camel@pasglop>
	<20110628190807.53a2c289@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 29 Jun 2011 11:06:36 +1000
Message-ID: <1309309596.32158.487.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> > Ok two things. One is first fix the comments then to stop mentioning
> > "TSC" :-)
> 
> Doh, sorry...
> 
> > Second is, I still don't think it's right. There's an expectation on
> > powerpc that the timebase works properly. If not, you have a userspace
> > visible breakage.
> 
> As the changelog notes, this isn't a full enforement of monotonicity, it's
> a way to avoid specific problems where the generic kernel timekeeping code
> blows up if it goes backwards.  Fixing userspace reads to be fully
> monotonic would be nice too, but it's a separate issue from the kernel
> throwing a timer into the distant future because the timebase went
> backwards one tick.

I don't think we ever want to "fix" userspace... how would you "fix" the
vDSO gettimeofday implementation for example since the vDSO has no
storage ?

> > There's no such thing as "a small drift". We assume no
> > difference is visible to software, period.
> 
> On what do we base this assumption, and what does making the assumption
> buy us?

We base this assumption on what I believe is an architectural
requirement tho of course it's not worded very explicitely, and probably
just "derived" from the architecture statement that the timebase can
always be used as a monotonic source of time.

It has always been the assumption of Linux/ppc port that the timebase
cannot be observed going backward accross the SMP fabric.

They -MUST- be sourced from the same clock (not drift) and the initial
synchronization must be "good enough" to make it impossible to observe
it going backward.

What it does buy us is a lot of complexity avoided in the time keeping
code and the ability to have things like vDSO
gettimeofday/clock_gettime, ie, a very fast path to reliably timestamp
things (which is among others a serious benefit for networking).

> Will smp-tbsync.c always converge on perfect sync (it has a limit on how
> long it will try, and the only indication it failed is a pr_debug)?  Will
> the timebase always increment on all cores at the same time, including on
> emulated hardware?

smp-tbsync.c is and has always been a "workaround" for broken HW.
Anybody with half a clue should follow the recommendation of the
architecture (this one is actually spelled out, but as a recommendation
only) to have a TB enable pin and use it to perform a perfect sync at
boot time.

> We had a bug in U-Boot's timebase sync where the boot core would sometimes
> be one tick faster than the other cores.

It's scary to think that your cores TBs seem to be soured from different
clock sources... ie even if you fix uBoot, can you guarantee they won't
drift ? I hope so ... I would consider that an unfixable architecture
violation and I am not at this stage keen on implementing the necessary
"workarounds" in Linux (the userspace case is nasty, really nasty).

PowerPC always prided itself on having a "sane" time base mechanism
unlike x86, please don't tell me that you guys are now breaking that
assumption.
 
> It's been fixed, but there are
> probably people still running the old U-Boot.  It seems like the kind of
> thing where defensive robustness is called for, like timing out instead of
> hanging if a hardware register never flips the bit we're waiting for.

No, you'll just "hide" the problem from the kernel and horrible &
unexplainable things will happen in userspace. At the VERY LEAST you
must warn very loudly if you detect this is happening.

> > We make hard assumptions here and in various places actually.
> 
> Are there any in the kernel that this doesn't cover?

Check gtod implementation, I'm not sure whether that's enough at this
stage or not for it, and then there's the vDSO of course. Not sure
what's up with sched_clock() and whether that has similar constraints.
 
> > So if you want to do that test, I would require that you also add a
> > warning, of the _rate_limited or _once, kind, indicating to the user
> > that something's badly wrong.
> 
> OK.

Cheers,
Ben.
