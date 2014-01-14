Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 91CEA2C0092
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Jan 2014 07:17:49 +1100 (EST)
Message-ID: <1389730655.6933.22.camel@pasglop>
Subject: Re: [PATCH v2] Move precessing of MCE queued event out from syscall
 exit path.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hugh Dickins <hughd@google.com>
Date: Wed, 15 Jan 2014 07:17:35 +1100
In-Reply-To: <alpine.LSU.2.11.1401141135240.3762@eggly.anvils>
References: <20140114101450.32385.65506.stgit@mars.in.ibm.com>
 <alpine.LSU.2.11.1401141135240.3762@eggly.anvils>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-01-14 at 11:48 -0800, Hugh Dickins wrote:
> On Tue, 14 Jan 2014, Mahesh J Salgaonkar wrote:
> > From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> > 
> > Huge Dickins reported an issue that b5ff4211a829
> > "powerpc/book3s: Queue up and process delayed MCE events" breaks the
> > PowerMac G5 boot. This patch fixes it by moving the mce even processing
> > away from syscall exit, which was wrong to do that in first place, and
> > using irq work framework to delay processing of mce event.
> > 
> > Reported-by: Hugh Dickins <hughd@google.com
> > Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> This version also boots and runs fine for me on the G5
> (but of course, I'm probably not testing delayed MCE events at all).

Thanks Hugh !

Cheers,
Ben.

> Hugh
> 
> > ---
> >  arch/powerpc/include/asm/mce.h |    1 -
> >  arch/powerpc/kernel/entry_64.S |    5 -----
> >  arch/powerpc/kernel/mce.c      |   13 ++++++++++---
> >  3 files changed, 10 insertions(+), 9 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/mce.h b/arch/powerpc/include/asm/mce.h
> > index 2257d1e..f97d8cb 100644
> > --- a/arch/powerpc/include/asm/mce.h
> > +++ b/arch/powerpc/include/asm/mce.h
> > @@ -192,7 +192,6 @@ extern void save_mce_event(struct pt_regs *regs, long handled,
> >  extern int get_mce_event(struct machine_check_event *mce, bool release);
> >  extern void release_mce_event(void);
> >  extern void machine_check_queue_event(void);
> > -extern void machine_check_process_queued_event(void);
> >  extern void machine_check_print_event_info(struct machine_check_event *evt);
> >  extern uint64_t get_mce_fault_addr(struct machine_check_event *evt);
> >  
> > diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> > index 770d6d6..bbfb029 100644
> > --- a/arch/powerpc/kernel/entry_64.S
> > +++ b/arch/powerpc/kernel/entry_64.S
> > @@ -184,11 +184,6 @@ syscall_exit:
> >  	bl	.do_show_syscall_exit
> >  	ld	r3,RESULT(r1)
> >  #endif
> > -#ifdef CONFIG_PPC_BOOK3S_64
> > -BEGIN_FTR_SECTION
> > -	bl	.machine_check_process_queued_event
> > -END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
> > -#endif
> >  	CURRENT_THREAD_INFO(r12, r1)
> >  
> >  	ld	r8,_MSR(r1)
> > diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
> > index d6edf2b..a7fd4cb 100644
> > --- a/arch/powerpc/kernel/mce.c
> > +++ b/arch/powerpc/kernel/mce.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/ptrace.h>
> >  #include <linux/percpu.h>
> >  #include <linux/export.h>
> > +#include <linux/irq_work.h>
> >  #include <asm/mce.h>
> >  
> >  static DEFINE_PER_CPU(int, mce_nest_count);
> > @@ -35,6 +36,11 @@ static DEFINE_PER_CPU(struct machine_check_event[MAX_MC_EVT], mce_event);
> >  static DEFINE_PER_CPU(int, mce_queue_count);
> >  static DEFINE_PER_CPU(struct machine_check_event[MAX_MC_EVT], mce_event_queue);
> >  
> > +static void machine_check_process_queued_event(struct irq_work *work);
> > +struct irq_work mce_event_process_work = {
> > +        .func = machine_check_process_queued_event,
> > +};
> > +
> >  static void mce_set_error_info(struct machine_check_event *mce,
> >  			       struct mce_error_info *mce_err)
> >  {
> > @@ -185,17 +191,19 @@ void machine_check_queue_event(void)
> >  		return;
> >  	}
> >  	__get_cpu_var(mce_event_queue[index]) = evt;
> > +
> > +	/* Queue irq work to process this event later. */
> > +	irq_work_queue(&mce_event_process_work);
> >  }
> >  
> >  /*
> >   * process pending MCE event from the mce event queue. This function will be
> >   * called during syscall exit.
> >   */
> > -void machine_check_process_queued_event(void)
> > +static void machine_check_process_queued_event(struct irq_work *work)
> >  {
> >  	int index;
> >  
> > -	preempt_disable();
> >  	/*
> >  	 * For now just print it to console.
> >  	 * TODO: log this error event to FSP or nvram.
> > @@ -206,7 +214,6 @@ void machine_check_process_queued_event(void)
> >  				&__get_cpu_var(mce_event_queue[index]));
> >  		__get_cpu_var(mce_queue_count)--;
> >  	}
> > -	preempt_enable();
> >  }
> >  
> >  void machine_check_print_event_info(struct machine_check_event *evt)
> > 
> > 
