Return-Path: <npiggin@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8FCDDDDF83
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Mar 2009 20:39:05 +1100 (EST)
Date: Wed, 4 Mar 2009 10:38:59 +0100
From: Nick Piggin <npiggin@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch 1/2] powerpc: optimise smp_mb
Message-ID: <20090304093858.GC27043@wotan.suse.de>
References: <20090219171229.GJ1747@wotan.suse.de>
	<1236139395.6696.9.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1236139395.6696.9.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 04, 2009 at 03:03:15PM +1100, Benjamin Herrenschmidt wrote:
> Allright, sorry for the delay, I had those stored into my "need more
> than half a brain cell for review" list and only got to them today :-)

No problem :)

 
> On Thu, 2009-02-19 at 18:12 +0100, Nick Piggin wrote:
> > Using lwsync, isync sequence in a microbenchmark is 5 times faster on my G5 than
> > using sync for smp_mb. Although it takes more instructions.
> > 
> > Running tbench with 4 clients on my 4 core G5 (20 times) gives the
> > following:
> > 
> > unpatched AVG=920.33 STD=2.36
> >   patched AVG=921.27 STD=2.77
> > 
> > So not a big improvement here, actually it could even be in the noise.
> > But other workloads or systems might see a bigger win, and the patch
> > maybe is interesting or could be improved, so I'll ask for comments. 
> 
> So not a huge objection here, however I have some doubts as to whether
> this will be worthwhile on power5,6,7 since those optimized somewhat the
> behaviour of the full sync. Since anything older than power4 doesn't
> have lwsync, that potentially makes it not worth the pain.

I would be interested to know. Avoiding sync when there *is* outstanding
IO operations happening should be a win? (My test of tbench on localhost
obviously wouldn't generate much MMIO).

I mean, even in the most optimised implementation possible, this sequence
is less constraining than sync.

 
> But I need to measure to be sure... it might be that newer embedded
> processors that support lwsync and SMP (and that are using a different
> pipeline structure) might benefit from this. I'll try to run some tests
> later this week or next week, but ping me in case I forget.

OK I'll ping you next week.

 
> Now what would be worth doing is to also try using a twi;isync sequence
> like we do to order MMIO reads, see if it's any better than cmp/branch

Probably makes sense to use the same pattern.
