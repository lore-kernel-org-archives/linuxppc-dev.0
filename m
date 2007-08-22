Return-Path: <npiggin@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AE518DDECA
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Aug 2007 13:55:44 +1000 (EST)
Date: Wed, 22 Aug 2007 05:55:39 +0200
From: Nick Piggin <npiggin@suse.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 1/2] powerpc: rmb fix
Message-ID: <20070822035539.GB26374@wotan.suse.de>
References: <20070821021143.GB2909@wotan.suse.de>
	<46CB37D4.2080609@austin.ibm.com>
	<d9f43b5c31fde5851a7af1d0f36eb134@kernel.crashing.org>
	<20070822011651.GA6799@wotan.suse.de>
	<dfbba0a8b6a15d1b563bdfcadc49e8eb@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <dfbba0a8b6a15d1b563bdfcadc49e8eb@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 22, 2007 at 05:29:50AM +0200, Segher Boessenkool wrote:
> >>>If this isn't causing any problems maybe there
> >>>is some loigic we are overlooking?
> >>
> >>The I/O accessor functions enforce the necessary ordering
> >>already I believe.
> >
> >Ah, it looks like you might be right, IO should appear to go in-order, 
> >in
> >which case the rmb() would simply need to order cacheable loads. 
> >Interesting
> >way to do things... are drivers simply not up to scratch enough to 
> >allow
> >out of order IO?
> 
> The powerpc kernel needs to have full sync insns in every I/O
> accessor in order to enforce all the ordering rules Linux demands.
> It's a bloody shame, but the alternative would be to make the
> barriers lots more expensive.  A third alternative would be to

Well lots more expensive compared to what you have now. But what
you have now is like having those expensive barriers between
*every* io access.


> have barrier ops that do not order everything, but just A vs. B
> for various choices of A and B (coherent accesses, MMIO accesses,
> etc.)
 
The non-smp_ variant is supposed to order everything, AFAIK. Maybe
you could get more fancy and have PIO vs MMIO etc etc. but it looks
like this whole area is in a pretty sticky state anyway so let's
not think about that.


> >Anyway, this raises another question -- if IO accessors have the right
> >ordering, why is wmb() not an lwsync as well? There appears to be many
> >more wmb() calls than rmb()...
> 
> Input MMIO accessors are {sync, load, stall pipeline until load came 
> back}.
> That's a full ordering on both sides.
> 
> Output MMIO on the other hand is done with {sync, store}.  Now since
> wmb() has to order MMIO writes vs. main memory writes, we need a full
> sync here.  On some (most, all?) CPUs an eieio is actually enough btw.
> The barrier insn could be put at the end of all MMIO write ops too,
> but I believe that would be more expensive (in execution time; in code
> size it definitely would be, of course).

Ah, that explains why wmb() is a sync. Doesn't seem like a very good
idea though, if the rationale of having fully ordered IO accessors was
because drivers didn't have enough barriers in them.
