Return-Path: <npiggin@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 1587BB7D42
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Feb 2010 21:41:59 +1100 (EST)
Date: Wed, 17 Feb 2010 21:41:53 +1100
From: Nick Piggin <npiggin@suse.de>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 6/6] powerpc: Use lwsync for acquire barrier if CPU
	supports it
Message-ID: <20100217104153.GA7952@laptop>
References: <20100210105728.GA3399@kryten> <20100210110236.GB3399@kryten>
	<20100210110306.GC3399@kryten> <20100210110406.GD3399@kryten>
	<20100210110719.GE3399@kryten> <20100210111025.GF3399@kryten>
	<20100211070914.GB6735@laptop> <20100217094314.GC24270@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100217094314.GC24270@kryten>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 17, 2010 at 08:43:14PM +1100, Anton Blanchard wrote:
>  
> Hi Nick,
> 
> > Ah, good to see this one come back. I also tested tbench over localhost
> > btw which actually did show some speedup on the G5. 
> > 
> > BTW. this was the last thing left:
> > http://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg29738.html
> > 
> > Don't know if you took a look at that again, but maybe it's worth
> > looking at. Hmm, we do actually seem to be growing number of smp_mb*
> > calls in core kernel too.
> 
> Interesting idea! I do worry we will get a late night visit from the
> architecture police. From memory they want the complete larx, stcwx, bne,
> isync sequence to guarantee an acquire barrier.

Yes I suppose the branch can be executed "non speculatively" before the 
lwsync is completed. Wheras the larx/stcwx will have to complete before
the branch outcome can be known. I suppose probably not worthwhile
avoiding the full IO sync by adding yet more crap to make this work.

Thanks for putting my mind to rest though :)

I'd still be interested to know how expensive the full sync is when you
have a lot of IOs in flight.

Question, are you going to do the hint and isync->lwsync thing for
userspace as well? Too bad the kernel doesn't export synchronisation
primitives to userspace...
