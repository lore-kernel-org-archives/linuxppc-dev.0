Return-Path: <npiggin@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4FEA3DDE3E
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2007 12:47:29 +1000 (EST)
Date: Fri, 24 Aug 2007 04:47:23 +0200
From: Nick Piggin <npiggin@suse.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 1/2] powerpc: rmb fix
Message-ID: <20070824024723.GA6989@wotan.suse.de>
References: <20070821021143.GB2909@wotan.suse.de>
	<46CB37D4.2080609@austin.ibm.com>
	<d9f43b5c31fde5851a7af1d0f36eb134@kernel.crashing.org>
	<20070822011651.GA6799@wotan.suse.de>
	<dfbba0a8b6a15d1b563bdfcadc49e8eb@kernel.crashing.org>
	<20070822035539.GB26374@wotan.suse.de>
	<7dc0bb83644f4cd44b4810a99d0003a1@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7dc0bb83644f4cd44b4810a99d0003a1@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 23, 2007 at 07:57:20PM +0200, Segher Boessenkool wrote:
> >>The powerpc kernel needs to have full sync insns in every I/O
> >>accessor in order to enforce all the ordering rules Linux demands.
> >>It's a bloody shame, but the alternative would be to make the
> >>barriers lots more expensive.  A third alternative would be to
> >
> >Well lots more expensive compared to what you have now. But what
> >you have now is like having those expensive barriers between
> >*every* io access.
> 
> Yeah.  But I/O reads are very expensive anyway, and the barriers
> are used for more than just I/O ordering.

rmb() should only be used when IO ordering matters. smp_rmb() is
for regular ordering.

So doesn't the fact IO reads are very expensive anyway lend more
weight _to have_ the full IO ordering in rmb()?


> I/O writes are a different thing; ideally, they would use only
> eieio, if anything at all.

For IO to IO ordering, yes eieio would be ideal. I don't know that
there is really such a primitive for that in Linux. io_wmb().

 
> Maybe the tradeoff isn't optimal.  The I/O primitives didn't have
> all those "sync"s in there before, they got added because some bad
> interaction with spinlocks was discovered, if my memory isn't failing
> me.

I think it may have been because IO ops are pretty strongly ordered
on x86, and it was thought that a fair amount of code was relying on
that. So the old primitives were made quite strongly ordered, and
new ones were added to avoid the overhead. Unfortunately, you can't
actually use the unordered ones unless you have working barrier
instructions. Hence why I think rmb() should be an IO barrier.

But I'm not pushing this too hard. You guys all know the gory ppc
details better than I, so I'll just leave it with you to work out
whether it is the right thing to do.


> >>have barrier ops that do not order everything, but just A vs. B
> >>for various choices of A and B (coherent accesses, MMIO accesses,
> >>etc.)
> >
> >The non-smp_ variant is supposed to order everything, AFAIK. Maybe
> >you could get more fancy and have PIO vs MMIO etc etc. but it looks
> >like this whole area is in a pretty sticky state anyway so let's
> >not think about that.
> 
> *Thinking* about it is fun.  Trying to get the code merged would be
> a different thing ;-)

;)
