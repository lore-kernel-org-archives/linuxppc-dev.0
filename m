Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1BDA1B7D1D
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Apr 2010 15:45:35 +1100 (EST)
Subject: Re: spin_lock_irqsave and multi-core
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: gshan <Gavin.Shan@alcatel-lucent.com>
In-Reply-To: <4BB4109E.8020607@alcatel-lucent.com>
References: <4BB3FE05.6040800@alcatel-lucent.com>
	<1270089545.7101.84.camel@pasglop>
	<4BB407F6.3070106@alcatel-lucent.com>
	<1270090589.7101.86.camel@pasglop>
	<4BB4109E.8020607@alcatel-lucent.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 01 Apr 2010 15:45:25 +1100
Message-ID: <1270097125.7101.110.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-04-01 at 11:18 +0800, gshan wrote:
> I agree with you. Actually, I can disable the individual interrupt via
> disable_irq_sync() to make sure
> system cooherence. 

This is also a very heavy hammer and not recommended at all. In most
case, you don't need that either. Also don't forget that if your system
has shared interrupts, you'll also disable whoever else interrupt you
are sharing with. You also cannot call that within a spinlock region for
example.

You don't normally need any of that if you use spinlocks properly, but
again, without more understanding of what your driver is trying to do,
it's hard to explain properly what you should do.

Normally tho, you synchronize your interrupt handler with your other
driver parts using simply a spinlock. You take it with spin_lock/unlock
from the interrupt handler and you use spin_lock_irqsave/restore from
the non-irq path. You don't normally need more. You only need the
irqsave/restore in fact on one CPU because it's goal is purely to avoid
a spin deadlock if your interrupt happens on that same CPU at the same
time.

Only if you want to disable interrupts for an extended period of time
should you consider using disable_irq_* and even then, as I mentioned,
it has drawbacks and is generally not recommended.

Alternatively, most devices have the ability to disable interrupt
emission on the device itself using some kind of MMIO register (though
you still need to synchronize things properly in your driver as the
interrupt might have already been emitted and on its way to the
processor when you whack that register.

But again, without more detailed knowledge of what you driver is
actually doing, it's hard to give you more precise advice.

Cheers,
Ben.

> It's just my concern when reading kernel source. 
> Anyway, thanks a lot
> for your kindly answer.
> 
> 
