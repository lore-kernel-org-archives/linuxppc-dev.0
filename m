Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 33ED9DDE46
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Mar 2007 21:12:48 +1100 (EST)
Subject: Re: [RFC] [patch 4/6 -rt] powerpc 2.6.20-rt8: fix a runtime
	warnings for xmon
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20070307091638.GC1783@elte.hu>
References: <yyi8xe925vg.wl@toshiba.co.jp> <yyi3b4h25jj.wl@toshiba.co.jp>
	<20070307091638.GC1783@elte.hu>
Content-Type: text/plain
Date: Wed, 07 Mar 2007 11:10:59 +0100
Message-Id: <1173262259.9349.40.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-03-07 at 10:16 +0100, Ingo Molnar wrote:
> * Tsutomu OWA <tsutomu.owa@toshiba.co.jp> wrote:
> 
> > @@ -342,6 +342,7 @@ static int xmon_core(struct pt_regs *reg
> >  
> >  	msr = mfmsr();
> >  	mtmsr(msr & ~MSR_EE);	/* disable interrupts */
> > +	preempt_disable();
> 
> i'm not an xmon expert, but maybe it might make more sense to first 
> disable preemption, then interrupts - otherwise you could be preempted 
> right after having disabled these interrupts (and be scheduled to 
> another CPU, etc.). What is the difference between local_irq_save() and 
> the above 'disable interrupts' sequence? If it's not the same and 
> xmon_core() relied on having hardirqs disabled then it might make sense 
> to do a local_irq_save() there, instead of a preempt_disable().

powerpc 64 bits nowadays does lazy HW masking, so local_irq_disable()
will not actually switch MSR_EE off. However, xmon needs that to happen
(though we have a nicer accessor to do it, I suspect some bitrot need
fixing in there, possibly already fixed in .21)

I agree that preempt_disable() should be put before the MSR tweaking
though.

Ben.
