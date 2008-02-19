Return-Path: <nickpiggin@yahoo.com.au>
Received: from n18.bullet.mail.mud.yahoo.com (n18.bullet.mail.mud.yahoo.com
	[68.142.201.235]) by ozlabs.org (Postfix) with SMTP id 0AB87DDE18
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 15:31:30 +1100 (EST)
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 1/3] Fix Unlikely(x) == y
Date: Tue, 19 Feb 2008 13:33:53 +1100
References: <47B70A61.9030306@tiscali.nl>
	<20080216094226.1e8eede1@laptopd505.fenrus.org>
	<p731w7axrat.fsf@bingen.suse.de>
In-Reply-To: <p731w7axrat.fsf@bingen.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802191333.53607.nickpiggin@yahoo.com.au>
Cc: Roel Kluin <12o3l@tiscali.nl>, lkml <linux-kernel@vger.kernel.org>,
	Willy Tarreau <w@1wt.eu>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org, Arjan van de Ven <arjan@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 19 February 2008 01:39, Andi Kleen wrote:
> Arjan van de Ven <arjan@infradead.org> writes:
> > you have more faith in the authors knowledge of how his code actually
> > behaves than I think is warranted  :)
>
> iirc there was a mm patch some time ago to keep track of the actual
> unlikely values at runtime and it showed indeed some wrong ones. But the
> far majority of them are probably correct.
>
> > Or faith in that he knows what "unlikely" means.
> > I should write docs about this; but unlikely() means:
> > 1) It happens less than 0.01% of the cases.
> > 2) The compiler couldn't have figured this out by itself
> >    (NULL pointer checks are compiler done already, same for some other
> > conditions) 3) It's a hot codepath where shaving 0.5 cycles (less even on
> > x86) matters (and the author is ok with taking a 500 cycles hit if he's
> > wrong)
>
> One more thing unlikely() does is to move the unlikely code out of line.
> So it should conserve some icache in critical functions, which might
> well be worth some more cycles (don't have numbers though).

I actually once measured context switching performance in the scheduler,
and removing the  unlikely hint for testing RT tasks IIRC gave about 5%
performance drop.

This was on a P4 which is very different from more modern CPUs both in
terms of branch performance characteristics, and icache characteristics.
However, the P4's branch predictor is pretty good, and it should easily
be able to correctly predict the rt_task check if it has enough entries.
So I think much of the savings came from code transformation and movement.
Anyway, it is definitely worthwhile if used correctly.

Actually one thing I don't like about gcc is that I think it still emits
cmovs for likely/unlikely branches, which is silly (the gcc developers
seem to be in love with that instruction). If that goes away, then
branch hints may be even better.

>
> But overall I agree with you that unlikely is in most cases a bad
> idea (and I submitted the original patch introducing it originally @). That
> is because it is often used in situations where gcc's default branch
> prediction heuristics do would make exactly the same decision
>
>            if (unlikely(x == NULL))
>
> is simply totally useless because gcc already assumes all x == NULL
> tests are unlikely. I appended some of the builtin heuristics from
> a recent gcc source so people can see them.
>
> Note in particular the last predictors; assuming branch ending
> with goto, including call, causing early function return or
> returning negative constant are not taken. Just these alone
> are likely 95+% of the unlikelies in the kernel.

Yes, gcc should be able to do pretty good heuristics, considering
the quite good numbers that cold CPU predictors can attain. However
for really performance critical code (or really "never" executed
code), then I think it is OK to have the hints and not have to rely
on gcc heuristics.

>
> -Andi

[snip]

Interesting, thanks!
