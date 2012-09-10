Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D8ABF2C0088
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2012 08:14:57 +1000 (EST)
Message-ID: <1347315255.11820.45.camel@pasglop>
Subject: Re: [RFC patch powerpc,trace] Avoid suspicious RCU usage reporting
 for some tracepoints
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Steven Rostedt <rostedt@goodmis.org>
Date: Tue, 11 Sep 2012 08:14:15 +1000
In-Reply-To: <1347285742.10751.6.camel@gandalf.local.home>
References: <1347253133.2725.45.camel@ThinkPad-T420>
 <1347253812.2385.148.camel@pasglop>
 <1347285742.10751.6.camel@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Anton Blanchard <anton@au1.ibm.com>, Paul Mackerras <paulus@samba.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>,
 Li Zhong <zhong@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-09-10 at 10:02 -0400, Steven Rostedt wrote:
> I agree too. I'm a bit concerned about the lack of coverage the
> irq_enter() and irq_exit() have in the timer interrupt:
> 
> 	may_hard_irq_enable();
> 
> 	trace_timer_interrupt_entry(regs);
> 
> 	__get_cpu_var(irq_stat).timer_irqs++;
> 
> #if defined(CONFIG_PPC32) && defined(CONFIG_PMAC)
> 	if (atomic_read(&ppc_n_lost_interrupts) != 0)
> 		do_IRQ(regs);
> #endif
> 
> 	old_regs = set_irq_regs(regs);
> 	irq_enter();
> 
> 
> I'm guessing that call to do_IRQ() has to do with lazy irq handling?

Not exactly. may_hard_irq_enable() does, it will hard-enable interrupts
(while keeping them soft-disabled) if there isn't a recorded "level"
interrupt pending already (in which case it's pointless, we'll just be
interrupted again and re-disable).

The do_IRQ() hack is an old hack for ancient 32-bit powermacs who could
lose interrupts, it's a sideband mechanism we have to re-emit them,
which nowadays could probably be replaced with something more modern,
it's just that nobody ever wants to touch that code.

> Anyway, there may be a reason to have the tracepoint before this call,
> but I'm not sure it really is that important. It should probably be best
> to move it after the irq_enter(). There's side-effects with calling
> things from interrupt context outside of irq_enter/exit().

Cheers,
Ben.
