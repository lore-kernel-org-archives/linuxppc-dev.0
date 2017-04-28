Return-Path: <pmladek@suse.com>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wDtfG089rzDqBP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Apr 2017 22:38:45 +1000 (AEST)
Date: Fri, 28 Apr 2017 14:38:38 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Russell King <rmk+kernel@arm.linux.org.uk>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 Jiri Kosina <jkosina@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Chris Metcalf <cmetcalf@ezchip.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 adi-buildroot-devel@lists.sourceforge.net,
 linux-cris-kernel@axis.com, linux-mips@linux-mips.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 Jan Kara <jack@suse.cz>, Ralf Baechle <ralf@linux-mips.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 David Miller <davem@davemloft.net>
Subject: Re: [PATCH v5 1/4] printk/nmi: generic solution for safe printk in NMI
Message-ID: <20170428123838.GZ3452@pathway.suse.cz>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
 <1461239325-22779-2-git-send-email-pmladek@suse.com>
 <20170419131341.76bc7634@gandalf.local.home>
 <20170420033112.GB542@jagdpanzerIV.localdomain>
 <20170420131154.GL3452@pathway.suse.cz>
 <20170428012530.GA383@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170428012530.GA383@jagdpanzerIV.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri 2017-04-28 10:25:30, Sergey Senozhatsky wrote:
> 
> On (04/20/17 15:11), Petr Mladek wrote:
> [..]
> >  void printk_nmi_enter(void)
> >  {
> > -	this_cpu_or(printk_context, PRINTK_NMI_CONTEXT_MASK);
> > +	/*
> > +	 * The size of the extra per-CPU buffer is limited. Use it
> > +	 * only when really needed.
> > +	 */
> > +	if (this_cpu_read(printk_context) & PRINTK_SAFE_CONTEXT_MASK ||
> > +	    raw_spin_is_locked(&logbuf_lock)) {
> 
> can we please have && here?

OK, it sounds reasonable after all.

> [..]
> > diff --git a/lib/nmi_backtrace.c b/lib/nmi_backtrace.c
> > index 4e8a30d1c22f..0bc0a3535a8a 100644
> > --- a/lib/nmi_backtrace.c
> > +++ b/lib/nmi_backtrace.c
> > @@ -86,9 +86,11 @@ void nmi_trigger_cpumask_backtrace(const cpumask_t *mask,
> >  
> >  bool nmi_cpu_backtrace(struct pt_regs *regs)
> >  {
> > +	static arch_spinlock_t lock = __ARCH_SPIN_LOCK_UNLOCKED;
> >  	int cpu = smp_processor_id();
> >  
> >  	if (cpumask_test_cpu(cpu, to_cpumask(backtrace_mask))) {
> > +		arch_spin_lock(&lock);
> >  		if (regs && cpu_in_idle(instruction_pointer(regs))) {
> >  			pr_warn("NMI backtrace for cpu %d skipped: idling at pc %#lx\n",
> >  				cpu, instruction_pointer(regs));
> > @@ -99,6 +101,7 @@ bool nmi_cpu_backtrace(struct pt_regs *regs)
> >  			else
> >  				dump_stack();
> >  		}
> > +		arch_spin_unlock(&lock);
> >  		cpumask_clear_cpu(cpu, to_cpumask(backtrace_mask));
> >  		return true;
> >  	}
> 
> can the nmi_backtrace part be a patch on its own?

I would prefer to keep it in the same patch. The backtrace from
all CPUs is completely unusable when all CPUs push to the global
log buffer in parallel. Single patch might safe hair of some
poor bisectors.

Best Regards,
Petr
