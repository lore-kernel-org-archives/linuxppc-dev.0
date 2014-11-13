Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 721A31A010C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Nov 2014 13:39:07 +1100 (AEDT)
Message-ID: <1415846346.28703.1.camel@concordia>
Subject: Re: powerpc: mitigate impact of decrementer reset
From: Michael Ellerman <mpe@ellerman.id.au>
To: Paul Clarke <pc@us.ibm.com>
Date: Thu, 13 Nov 2014 13:39:06 +1100
In-Reply-To: <545A591F.3080400@us.ibm.com>
References: <20141008025210.AF949140144@ozlabs.org>
 <545A591F.3080400@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-11-05 at 11:06 -0600, Paul Clarke wrote:
> Sorry it took me so long to get back to this...
> 
> On 10/07/2014 09:52 PM, Michael Ellerman wrote:
> > On Tue, 2014-07-10 at 19:13:24 UTC, Paul Clarke wrote:
> >> This patch short-circuits the reset of the decrementer, exiting after
> >> the decrementer reset, but before the housekeeping tasks if the only
> >> need for the interrupt is simply to reset it.  After this patch,
> >> the latency spike was measured at about 150 nanoseconds.
> 
> > Thanks for the excellent changelog. But this patch makes me a bit nervous :)
> >
> > Do you know where the latency is coming from? Is it primarily the irq work?
> 
> Yes, it is all under irq_enter (measured at ~10us) and irq_exit (~12us).

Hmm, OK. I actually meant irq_work_run().

AIUI irq_enter/exit() are just state tracking, they shouldn't be actually
running work.

How are you measuring it?

> > If so I'd prefer if we could move the short circuit into __timer_interrupt()
> > itself. That way we'd still have the trace points usable, and it would
> > hopefully result in less duplicated logic.
> 
> But irq_enter and irq_exit are called in timer_interrupt, before 
> __timer_interrupt is called.  I don't see how that helps.  The time 
> spent in __timer_interrupt is minuscule by comparison.

Right, it won't help if it's irq_enter() that is causing the delay. But I was
assuming it was irq_work_run().

> Are you suggesting that irq_enter/exit be moved into __timer_interrupt 
> as well?  (I'm not sure how that would impact the existing call to 
> __timer_interrupt from tick_broadcast_ipi_handler?  And if there is no 
> impact, what's the point of separating timer_interrupt and 
> __timer_interrupt?)

The point is __timer_interrupt() is called from tick_broadcast_ipi_handler(),
which is called from smp_ipi_demux(), from icp_hv_ipi_action(), from
__do_irq(), which has already done irq_enter() (and will do irq_exit()).

cheers
