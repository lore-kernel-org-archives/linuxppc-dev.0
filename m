Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3922B67B59
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Jun 2005 06:57:53 +1000 (EST)
Date: Wed, 29 Jun 2005 12:54:45 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Guillaume Autran <gautran@mrv.com>, '@logos.cnet
Message-ID: <20050629155445.GA3560@logos.cnet>
References: <20050625145318.GA32117@logos.cnet>
	<f14f5f5aebd45879c39c6ce69f29c004@embeddededge.com>
	<20050626143004.GA5198@logos.cnet>
	<20050627133930.GA9109@logos.cnet>
	<f5d1cb54913dd31385d15fe1f2e5b12d@embeddededge.com>
	<1119940208.5133.204.camel@gaston> <42C153E1.3060004@mrv.com>
	<1120018530.5133.241.camel@gaston> <42C2BF03.9000402@mrv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <42C2BF03.9000402@mrv.com>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] 8xx: get_mmu_context() for (very) FEW_CONTEXTS
	and	KERNEL_PREEMPT race/starvation issue
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Guillaume,

On Wed, Jun 29, 2005 at 11:32:19AM -0400, Guillaume Autran wrote:
> 
> Benjamin Herrenschmidt wrote:
> 
> >On Tue, 2005-06-28 at 09:42 -0400, Guillaume Autran wrote:
> > 
> >
> >>Hi,
> >>
> >>I happen to notice a race condition in the mmu_context code for the 8xx 
> >>with very few context (16 MMU contexts) and kernel preemption enable. It 
> >>is hard to reproduce has it shows only when many processes are 
> >>created/destroy and the system is doing a lot of IRQ processing.
> >>
> >>In short, one process is trying to steal a context that is in the 
> >>process of being freed (mm->context == NO_CONTEXT) but not completely 
> >>freed (nr_free_contexts == 0).
> >>The steal_context() function does not do anything and the process stays 
> >>in the loop forever.
> >>
> >>Anyway, I got a patch that fixes this part. Does not seem to affect 
> >>scheduling latency at all.
> >>
> >>Comments are appreciated.
> >>   
> >>
> >
> >Your patch seems to do a hell lot more than fixing this race ... What
> >about just calling preempt_disable() in destroy_context() instead ?
> > 
> >
> I'm still a bit confused with "kernel preemption". One thing for sure is 
> that disabling kernel preemption does indeed fix my problem.
> So, my question is, what if a task in the middle of being schedule gets 
> preempted by an IRQ handler, where will this task restart execution ? 
> Back at the beginning of schedule or where it left of ?

Execution is resumed exactly where it has been interrupted.

> The idea behind my patch was to get rid of that nr_free_contexts counter 
> that is (I thing) redundant with the context_map.

Apparently its there to avoid the spinlock exactly on !FEW_CONTEXTS machines.

I suppose that what happens is that get_mmu_context() gets preempted after stealing
a context (so nr_free_contexts = 0), but before setting next_mmu_context to the 
next entry

next_mmu_context = (ctx + 1) & LAST_CONTEXT;

So if the now running higher prio tasks calls switch_mm() (which is likely to happen)
it loops forever on atomic_dec_if_positive(&nr_free_contexts), while steal_context()
sees "mm->context == CONTEXT".

I think that you should try "preempt_disable()/preempt_enable" pair at entry and 
exit of get_mmu_context() - I suppose around destroy_context() is not enough (you 
can try that also).

spinlock ends up calling preempt_disable().
