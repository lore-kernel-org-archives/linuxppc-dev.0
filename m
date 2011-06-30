Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8DA9BB6F57
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Jun 2011 10:29:42 +1000 (EST)
Subject: Re: [PATCH] powerpc/timebase_read: don't return time older than
	cycle_last
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20110629141940.2c930411@schlenkerla.am.freescale.net>
References: <20110627215613.GA13676@schlenkerla.am.freescale.net>
	<1309221943.32158.412.camel@pasglop>
	<20110628111420.15052d9f@schlenkerla.am.freescale.net>
	<1309303508.32158.473.camel@pasglop>
	<20110628190807.53a2c289@schlenkerla.am.freescale.net>
	<1309309596.32158.487.camel@pasglop>
	<20110629141940.2c930411@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 30 Jun 2011 10:29:31 +1000
Message-ID: <1309393771.14501.201.camel@pasglop>
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

On Wed, 2011-06-29 at 14:19 -0500, Scott Wood wrote:
> On Wed, 29 Jun 2011 11:06:36 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > I don't think we ever want to "fix" userspace... how would you "fix" the
> > vDSO gettimeofday implementation for example since the vDSO has no
> > storage ?
> 
> Hmm... I guess you could at least make the libc interface monotonic, though
> that wouldn't help if multiple processes are doing some shared memory
> communication.
> 
> Ideally, anything that uses timestamps should be robust against small jumps
> backwards (i.e. not blow it up into some huge jump forward or similar
> breakage), because reality just isn't perfect.  Especially if you're writing
> userspace code that could run on all sorts of hardware.

Well, powerpc hardware so far has been "perfect" in that regard and I'm
unwilling to bend on that one without throwing a lot of shame at your
face for screwing up :-)

Point is, it's an assumption made by Linux, but also a pile of userspace
code, and I wouldn't be surprised if it extends way beyond just glibc.

So even if it's not spelled out in the PPC_AS (tho it is in PAPR), we
can define it as a Linux requirement :-)
 
> > We base this assumption on what I believe is an architectural
> > requirement tho of course it's not worded very explicitely, and probably
> > just "derived" from the architecture statement that the timebase can
> > always be used as a monotonic source of time.
> 
> Is it making any statement about monotonicity across CPUs?

I think PAPR does actually, I suspect it's been mostly implied and never
written down from a more generic arch perspective.

> > smp-tbsync.c is and has always been a "workaround" for broken HW.
> 
> As is this (or for broken firmware, or broken emulation).
> 
> > Anybody with half a clue should follow the recommendation of the
> > architecture (this one is actually spelled out, but as a recommendation
> > only) to have a TB enable pin and use it to perform a perfect sync at
> > boot time.
> 
> Where in the ISA is this?

In the TB chapter of 2.06

> Closest I see from a quick scan is "There must be a method for getting all
> Time Bases in the system to start incrementing with values that are
> identical or almost identical." (7.2 S, 9.2.1 E).  Note the "almost".
> 
> And while we do provide this beginning with the e500mc-based chips, e500v2
> isn't dead yet.  Kexec is also currently breaking the boot sync, requiring
> smp-tbsync -- though ideally kexec could be reworked to not need to
> physically reset the core.

Right, fixable :-)

> > > We had a bug in U-Boot's timebase sync where the boot core would sometimes
> > > be one tick faster than the other cores.
> > 
> > It's scary to think that your cores TBs seem to be soured from different
> > clock sources...
> 
> They're not.  We use the boot core's timebase for a while, then disable it,
> reset it to zero, and enable all the timebases at once.  The bug was a
> missing readback to ensure that it was stopped before it was reset, so
> sometimes it would tick up to 1 on the boot core after reset, before being
> enabled again.  This resulted in the boot core's timebase always reading
> one greater than the other cores'.
> 
> It can also be an issue when running on simulated hardware.

Ok.

> > ie even if you fix uBoot, can you guarantee they won't
> > drift ? I hope so ...
> 
> It shouldn't drift even with the old U-boot -- it's just a constant offset.

That's easier to fix.

> > I would consider that an unfixable architecture
> > violation and I am not at this stage keen on implementing the necessary
> > "workarounds" in Linux (the userspace case is nasty, really nasty).
> > 
> > PowerPC always prided itself on having a "sane" time base mechanism
> > unlike x86, please don't tell me that you guys are now breaking that
> > assumption.
> 
> If you mean "are we introducing new chips that have timebase problems", no.
> 
> I'm questioning whether the assumption was ever fully valid under all
> circumstances.

I think it was, and regardless, the majority of code out there was
written with that assumption.

> > > It's been fixed, but there are
> > > probably people still running the old U-Boot.  It seems like the kind of
> > > thing where defensive robustness is called for, like timing out instead of
> > > hanging if a hardware register never flips the bit we're waiting for.
> > 
> > No, you'll just "hide" the problem from the kernel and horrible &
> > unexplainable things will happen in userspace. At the VERY LEAST you
> > must warn very loudly if you detect this is happening.
> 
> A warning message is OK.
> 
> The current situation hides it as well, since it appears to work fine
> until you hit the race, and suddenly things get stuck and it takes a lot of
> digging to find out why.

Yes but you can't hide it completely, so you can't "contain" the damage.

> > > > We make hard assumptions here and in various places actually.
> > > 
> > > Are there any in the kernel that this doesn't cover?
> > 
> > Check gtod implementation, I'm not sure whether that's enough at this
> > stage or not for it, and then there's the vDSO of course.
> 
> I think the in-kernel gtod is OK after this patch (it breaks if it reads a
> timestamp that is less than cycle_last).
> 
> The 32-bit vdso looks OK as is since it doesn't convert to nsec until after
> adding to xtime.  Userspace will still see time go backwards a bit if the
> timebase does, but it shouldn't get a wildly wrong answer.

But it might calculate one. There's no such thing as a "small problem"
here. If userspace sees the time go backward, even by 1ns, horrible
unpredictable things will happen.

It's either fully correct or not correct at all, and our userspace makes
the assumption that it's always fully correct.

>   The 64-bit vdso
> uses srdi instead of sradi, and does so before adding to the upper
> half of xtime, so if the race is hit the returned time will be too high by
> 2^32 seconds.
> 
> The problem in the in-kernel gettimeofday that causes it to be sensitive to
> times less than cycles_last appears to be the same thing --
> clocksource_cyc2ns() does an unsigned shift, even though it claims to be
> returning a signed result.
> 
> > Not sure what's up with sched_clock() and whether that has similar constraints.
> 
> sched_clock() should be OK as long as the timestamp is always greater than
> boot_tb, and hopefully any timebase skew is less than the delay from when
> boot_tb is set to when secondary cores start up.
> 
> Delay loops could end early if they use unsigned comparisons, but only if
> the timebase skew is greater than the time it takes to move a thread from
> one cpu to another.

Cheers,
Ben.
