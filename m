Return-Path: <eranian@hpl.hp.com>
Received: from madara.hpl.hp.com (madara.hpl.hp.com [192.6.19.124])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1D151DDF1B
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2007 20:18:13 +1100 (EST)
Date: Mon, 26 Nov 2007 00:55:13 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: Sonny Rao <sonny@burdell.org>
Subject: Re: perfmon2 needs hard_irq_disable() for powerpc
Message-ID: <20071126085513.GB16663@frankl.hpl.hp.com>
References: <20071126074438.GA27499@kevlar.boston.burdell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071126074438.GA27499@kevlar.boston.burdell.org>
Cc: mikey@neuling.org, miltonm@bga.com, dwg@au1.ibm.com,
	linuxppc-dev@ozlabs.org, paulus@samba.org, anton@samba.org,
	cjashfor@us.ibm.com, perfmon2-devel@lists.sourceforge.net
Reply-To: eranian@hpl.hp.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Sonny,

On Mon, Nov 26, 2007 at 02:44:38AM -0500, Sonny Rao wrote:
> Hi, I've been reading through the perfmon2 patch for 2.6.23 and it
> dawned on me that in the powerpc architecture we have the notion of
> lazy-disabling of interrupts where we don't actually disable
> interrupts unless we see one come in and then turn them off.  I believe
> a notable exception is the performance monitor interrupt which we
> allow to break into our critical sections.  This is desirable because
> we want to profile those sections  and right now, no in-kernel user of
> the performance monitor interrupt in powerpc does any synchronization
> across cpus inside the interrupt handler (oprofile seems to use
> per-cpu buffers/state for everything).  We use hard_irq_disable() when
> we _really_ have to disable interrupts because we're switching out the
> kernel stack, etc. 
> 
> Perfmon2 is more demanding in its synchronization requirements and it
> uses spin_lock_irqsave() in the generic arch-neutral code in several
> places, I think this will break on powerpc the way we're handling
> things now.
> 
We use spinlocks to serialize access to the perfmon context. The irq masking
is here to avoid a race between a user calling into perfmon and a counter
interrupt. 

Allowing PMU interrupts in critical sections is useful, yet it gets
complicated very quickly because of locking issues, including within
the perfmon code. For instance, a consequence of a interrupt could be
that a SIGIO message is posted. If counter interrupts were allowed in the
signal code, then we could potentially get dedlock situations.

>From what you are saying it seems on powerpc, there may be a way to
differentiate interrupts and thus possibly allow a less restrictive
locking policy.

> I'm copying a few people to solicit opinions on how best to deal with
> this.  I think it's desirable to keep the property of letting us
> profile critical sections in the kernel wherever possible. So we would
> need to add hard_irq_disable/enable calls to the generic code, but want to
> check with you guys first.   
> 
I am open to suggestions. If we can enable monitoring in critical sections
and still avoid races and dealocks, at least on powerpc, then I'll be happy
to allow this.

Thanks.

-- 

-Stephane
