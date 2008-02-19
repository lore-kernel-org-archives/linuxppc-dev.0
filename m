Return-Path: <nickpiggin@yahoo.com.au>
Received: from n10.bullet.mail.mud.yahoo.com (n10.bullet.mail.mud.yahoo.com
	[209.191.125.208]) by ozlabs.org (Postfix) with SMTP id 76306DDF6D
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 09:25:23 +1100 (EST)
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 1/3] Fix Unlikely(x) == y
Date: Wed, 20 Feb 2008 09:25:12 +1100
References: <47B70A61.9030306@tiscali.nl>
	<200802192046.46955.nickpiggin@yahoo.com.au>
	<20080219095702.GA6940@one.firstfloor.org>
In-Reply-To: <20080219095702.GA6940@one.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802200925.13366.nickpiggin@yahoo.com.au>
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

On Tuesday 19 February 2008 20:57, Andi Kleen wrote:
> On Tue, Feb 19, 2008 at 08:46:46PM +1100, Nick Piggin wrote:

> > I think it was just a simple context switch benchmark, but not lmbench
> > (which I found to be a bit too variable). But it was a long time ago...
>
> Do you still have it?
>
> I thought about writing my own but ended up being too lazy for that @)

Had a quick look but couldn't find it. It was just two threads running
and switching to each other with a couple of mutexes or yield. If I
find it, then I'll send it over.


> > > > Actually one thing I don't like about gcc is that I think it still
> > > > emits cmovs for likely/unlikely branches,
> > >
> > > That's -Os.
> >
> > And -O2 and -O3, on the gccs that I'm using, AFAIKS.
>
> Well if it still happens on gcc 4.2 with P4 tuning you should
> perhaps open a gcc PR. They tend to ignore these bugs mostly in
> my experience, but sometimes they act on them.

I'm not sure about P4 tuning... But even IMO it should not on
predictable branches too much for any (especially OOOE) CPU.


> > > > which is silly (the gcc developers
> > >
> > > It depends on the CPU. e.g. on K8 and P6 using CMOV if possible
> > > makes sense. P4 doesn't like it though.
> >
> > If the branch is completely predictable (eg. annotated), then I
> > think branches should be used anyway. Even on well predicted
> > branches, cmov is similar speed on microbenchmarks, but it will
> > increase data hazards I think, so it will probably be worse for
> > some real world situations.
>
> At least the respective optimization manuals say they should be used.
> I presume they only made this recommendation after some extensive
> benchmarking.

What I have seen is that they tell you definitely not to use it for
predictable branches. Eg. the Intel optimization manual says

 Use the setcc and cmov instructions to eliminate unpredictable
 conditional branches where possible. Do not do this for predictable
 branches. Do not use these instructions to eliminate all
 unpredictable conditional branches, because using these instructions
 will incur execution overhead due to executing both paths of a
 conditional branch. In addition, converting conditional branches to
 cmovs or setcc trades control-flow dependence for data dependence
 and restricts the capability of the out-of-order engine.


> > But a likely branch will be _strongly_ predicted to be taken,
> > wheras a lot of the gcc heuristics simply have slightly more or
> > slightly less probability. So it's not just a question of which
> > way is more likely, but also _how_ likely it is to go that way.
>
> Yes, but a lot of the heuristics are pretty strong (>80%) and gcc will
> act on them unless it has a very strong contra cue. And that should
> normally not be the case.

True, but if you know a branch is 99%+, then use of likely/unlikely
can still be a good idea. 80% may not be enough to choose a branch
over a cmov for example.
