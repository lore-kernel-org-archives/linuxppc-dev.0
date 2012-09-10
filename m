Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
 [71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id 7B3072C008E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2012 00:02:26 +1000 (EST)
Message-ID: <1347285742.10751.6.camel@gandalf.local.home>
Subject: Re: [RFC patch powerpc,trace] Avoid suspicious RCU usage reporting
 for some tracepoints
From: Steven Rostedt <rostedt@goodmis.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 10 Sep 2012 10:02:22 -0400
In-Reply-To: <1347253812.2385.148.camel@pasglop>
References: <1347253133.2725.45.camel@ThinkPad-T420>
 <1347253812.2385.148.camel@pasglop>
Content-Type: text/plain; charset="ISO-8859-15"
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

On Mon, 2012-09-10 at 15:10 +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2012-09-10 at 12:58 +0800, Li Zhong wrote:
> > There are a few tracepoints in the interrupt code path, which is before
> > irq_enter(), or after irq_exit(), like
> > trace_irq_entry()/trace_irq_exit() in do_IRQ(),
> > trace_timer_interrupt_entry()/trace_timer_interrupt_exit() in
> > timer_interrupt(). 
> > 
> > If the interrupt is from idle(), and because tracepoint contains RCU
> > read-side critical section, we could see following suspicious RCU usage
> > reported:
> 
>  .../...
> 
> > This is because the RCU usage in interrupt context should be used in
> > area marked by rcu_irq_enter()/rcu_irq_exit(), called in
> > irq_enter()/irq_exit() respectively. 
> > 
> > Could we add a new tracepoint trace_***_rcuirq, like trace_***_rcuidle
> > to avoid the report? like the code attached below.
> > 
> > Or could we just move these tracepoints inside the
> > irq_enter()/irq_exit() area? (Seems not good for the timer_interrupt
> > case). 
> 
> I'd say just move them in. Anton, any objection ?
> 

I agree too. I'm a bit concerned about the lack of coverage the
irq_enter() and irq_exit() have in the timer interrupt:

	may_hard_irq_enable();

	trace_timer_interrupt_entry(regs);

	__get_cpu_var(irq_stat).timer_irqs++;

#if defined(CONFIG_PPC32) && defined(CONFIG_PMAC)
	if (atomic_read(&ppc_n_lost_interrupts) != 0)
		do_IRQ(regs);
#endif

	old_regs = set_irq_regs(regs);
	irq_enter();


I'm guessing that call to do_IRQ() has to do with lazy irq handling?

Anyway, there may be a reason to have the tracepoint before this call,
but I'm not sure it really is that important. It should probably be best
to move it after the irq_enter(). There's side-effects with calling
things from interrupt context outside of irq_enter/exit().

-- Steve
