Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 93DEC2C00FD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 May 2013 10:03:34 +1000 (EST)
Message-ID: <1367884994.29496.28.camel@pasglop>
Subject: Re: [PATCH] kvm/ppc/booke64: Hard disable interrupts when entering
 the guest
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Tue, 07 May 2013 10:03:14 +1000
In-Reply-To: <1367884418.3398.10@snotra>
References: <1367884418.3398.10@snotra>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: kvm@vger.kernel.org, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, Mihai Caraman <mihai.caraman@freescale.com>,
 Paul Mackerras <paulus@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-05-06 at 18:53 -0500, Scott Wood wrote:
> 
> > Ie. The last stage of entry will hard enable, so they should be
> > soft-enabled too... if not, latency trackers will consider the whole
> > guest periods as "interrupt disabled"...
> 
> OK... I guess we already have that problem on 32-bit as well?

32-bit doesn't do lazy disable, so the situation is a lot easier there.

> > Now, kvmppc_lazy_ee_enable() seems to be clearly bogus to me. It will
> > unconditionally set soft_enabled and clear irq_happened from a
> > soft-disabled state, thus potentially losing a pending event.
> > 
> > Book3S "HV" seems to be keeping interrupts fully enabled all the way
> > until the asm hard disables, which would be fine except that I'm  
> > worried
> > we are racy vs. need_resched & signals.
> > 
> > One thing you may be able to do is call prep_irq_for_idle(). This will
> > tell you if something happened, giving you a chance to abort/re-enable
> > before you go the guest.
> 
> As long as we go straight from IRQs fully enabled to hard-disabled,  
> before we check for signals and such, I don't think we need that (and  
> using it would raise the question of what to do on 32-bit).

Except that you have to mark them as "soft enabled" before you enter the
guest with interrupts on...

But yes, I see your point. If interrupts are fully enabled and you call
hard_irq_disable(), there should be no chance for anything to mess
around with irq_happened.

However if you set soft-enabled later on before the rfid that returns to
the guest and sets EE, you *must* also clear PACA_IRQ_HARD_DIS in
irq_happened. If you get that out of sync bad things will happen later
on...

To be sure all is well, you might want to
WARN_ON(get_paca()->irq_happened == PACA_IRQ_HARD_DIS); (with a comment
explaining why so).

Another problem is that hard_irq_disable() doesn't call
trace_hardirqs_off()... We might want to fix that:

static inline void hard_irq_disable(void)
{
	__hard_irq_disable();
	if (get_paca()->soft_enabled)
		trace_hardirqs_off();
	get_paca()->soft_enabled = 0;
	get_paca()->irq_happened |= PACA_IRQ_HARD_DIS;
}

> What if we just take this patch, and add trace_hardirqs_on() just  
> before entering the guest?

You still want to set soft_enabled I'd say ... though I can see how you
may get away without it as long as you call trace_hardirqs_off() right
on the way back from the guest, but beware some lockdep bits will choke
if they ever spot the discrepancy between the traced irq state and
soft_enabled. I'd recommend you just keep it in sync.

>   This would be similar to what the 32-bit  
> non-KVM exception return code does (except it would be in C code).   
> Perhaps we could set soft_enabled as well, but then we'd have to clear  
> it again before calling kvmppc_restart_interrupt() -- since the KVM  
> exception handlers don't actually care about soft_enabled (it would  
> just be for consistency), I'd rather just leave soft_enabled off.
> 
> We also don't want PACA_IRQ_HARD_DIS to be cleared the way  
> prep_irq_for_idle() does, because that's what lets the  
> local_irq_enable() do the hard-enabling after we exit the guest.

Then set it again. Don't leave the kernel in a state where soft_enabled
is 1 and irq_happened is non-zero. It might work in the specific KVM
case we are looking at now because we know we are coming back via KVM
exit and putting things right again but it's fragile, somebody will come
back and break it, etc...

If necessary, create (or improve existing) helpers that do the right
state adjustement. The cost of a couple of byte stores is negligible,
I'd rather you make sure everything remains in sync at all times.

Cheers,
Ben.
