Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5A5411A1D69
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 09:25:37 +1000 (AEST)
Date: Thu, 6 Aug 2015 18:25:06 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] powerpc32: optimise csum_partial() loop
Message-ID: <20150806232506.GB22196@gate.crashing.org>
References: <cover.1435655733.git.christophe.leroy@c-s.fr>
 <67cf476f657e87b2ea586951a57ae3ba3c1e3c0c.1435655733.git.christophe.leroy@c-s.fr>
 <20150806003059.GD18479@gate.crashing.org>
 <1438828301.2097.126.camel@freescale.com>
 <20150806043938.GE18479@gate.crashing.org>
 <1438901145.2097.170.camel@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1438901145.2097.170.camel@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 06, 2015 at 05:45:45PM -0500, Scott Wood wrote:
> > The original loop was already optimal, as the comment said.
> 
> The comment says that bdnz has zero overhead.  That doesn't mean the adde 
> won't stall waiting for the load result.

adde is execution serialising on those cores; it *always* stalls,
that is, it won't run until it is next to complete.

> > The new code adds extra instructions and a mispredicted branch.
> 
> Outside the main loop.

Sure, I never said it was super-bad or anything.

> >   You also might get less overlap between the loads and adde (I didn't check
> > if there is any originally): those instructions are no longer
> > interleaved.
> >
> > I think it is a stupid idea to optimise code for all 32-bit PowerPC
> > CPUs based on solely what is best for a particularly simple, slow
> > implementation; and that is what this patch is doing.
> 
> The simple and slow implementation is the one that needs optimizations the 
> most.

And, on the other hand, optimising for atypical (mostly) in-order
single-issue chips without branch folding, hurts performance on
other chips the most.  Well, dual-issue in-order might be worse :-P

> If this makes performance non-negligibly worse on other 32-bit chips, and is 
> an important improvement on 8xx, then we can use an ifdef since 8xx already 
> requires its own kernel build.  I'd prefer to see a benchmark showing that it 
> actually does make things worse on those chips, though.

And I'd like to see a benchmark that shows it *does not* hurt performance
on most chips, and does improve things on 8xx, and by how much.  But it
isn't *me* who has to show that, it is not my patch.

If these csum routines actually matter for performance that much, there
really *should* be chip-specific implementations.


Segher
