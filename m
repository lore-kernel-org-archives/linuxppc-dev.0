Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id ED4F8DDE16
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 21:48:39 +1000 (EST)
Date: Tue, 8 Apr 2008 15:48:56 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCH 6/8] [POWERPC] sysdev,qe_lib: implement FSL GTM support
Message-ID: <20080408114856.GA22850@polina.dev.rtsoft.ru>
References: <20080311172106.GA4766@localhost.localdomain>
	<20080311172429.GF7727@localhost.localdomain>
	<200804081101.55784.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <200804081101.55784.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 08, 2008 at 11:01:53AM +0200, Laurent Pinchart wrote:
> On Tuesday 11 March 2008 18:24, Anton Vorontsov wrote:
> > GTM stands for General-purpose Timers Module and able to generate
> > timer{1,2,3,4} interrupts.
> > 
> > There are several limitations in this support:
> > 1. Cascaded (32 bit) timers unimplemented (1-2, 3-4).
> >    This is straightforward to implement when needed, two timers should
> >    be marked as "requested" and configured as appropriate.
> > 2. Super-cascaded (64 bit) timers unimplemented (1-2-3-4).
> >    This is also straightforward to implement when needed, all timers
> >    should be marked as "requested" and configured as appropriate.
> > 
> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> 
> [snip]
> 
> > +void gtm_stop_timer_16(struct gtm_timer *tmr)
> > +{
> > +	struct gtm *gtm = tmr->gtm;
> > +	int num = tmr - &gtm->timers[0];
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&gtm->lock, flags);
> > +
> > +	setbits8(tmr->gtcfr, GTCFR_STP(num));
> 
> Shouldn't we clear the timer events with
> 
> out_be16(tmr->gtevr, 0xFFFF);

Yeah.

> here ? Otherwise the timer interrupt could still fire after the timer is 
> stopped. This introduces a race condition in drivers that blindly re-arm the 
> timer in the interrupt handler. I've been bitten by this while porting your 
> FHCI USB driver to a CPM2 platform.

Thanks, will fix.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
