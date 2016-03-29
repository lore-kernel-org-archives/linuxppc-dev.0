Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qYzb83LvvzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 16:19:00 +1100 (AEDT)
Message-ID: <1459228740.8173.10.camel@ellerman.id.au>
Subject: Re: [PATCH 5/6] powerpc/livepatch: Add livepatch stack to struct
 thread_info
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@ozlabs.org
Cc: duwe@lst.de, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, pmladek@suse.com, jeyu@redhat.com,
 jkosina@suse.cz,  live-patching@vger.kernel.org, mbenes@suse.cz
Date: Tue, 29 Mar 2016 16:19:00 +1100
In-Reply-To: <56F9C531.3090703@gmail.com>
References: <1458817445-5855-1-git-send-email-mpe@ellerman.id.au>
 <1458817445-5855-5-git-send-email-mpe@ellerman.id.au>
 <56F9C531.3090703@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-03-29 at 10:58 +1100, Balbir Singh wrote:
> On 24/03/16 22:04, Michael Ellerman wrote:
> > diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> > index 290559df1e8b..3cb46a3b1de7 100644
> > --- a/arch/powerpc/kernel/irq.c
> > +++ b/arch/powerpc/kernel/irq.c
> > @@ -66,6 +66,7 @@
> >  #include <asm/udbg.h>
> >  #include <asm/smp.h>
> >  #include <asm/debug.h>
> > +#include <asm/livepatch.h>
> >  
> >  #ifdef CONFIG_PPC64
> >  #include <asm/paca.h>
> > @@ -607,10 +608,12 @@ void irq_ctx_init(void)
> >  		memset((void *)softirq_ctx[i], 0, THREAD_SIZE);
> >  		tp = softirq_ctx[i];
> >  		tp->cpu = i;
> > +		klp_init_thread_info(tp);

> At this point ti->livepatch_sp points to the next CPUs thread_info for softirq_ctx?

Sorry I'm not sure what you mean.

None of this relates to the current CPUs thread info.

> > diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> > index 3807fb05b6de..1b6cabb8e715 100644
> > --- a/arch/powerpc/kernel/setup_64.c
> > +++ b/arch/powerpc/kernel/setup_64.c
> > @@ -69,6 +69,7 @@
> >  #include <asm/kvm_ppc.h>
> >  #include <asm/hugetlb.h>
> >  #include <asm/epapr_hcalls.h>
> > +#include <asm/livepatch.h>
> >  
> >  #ifdef DEBUG
> >  #define DBG(fmt...) udbg_printf(fmt)
> > @@ -667,16 +668,16 @@ static void __init emergency_stack_init(void)
> >  	limit = min(safe_stack_limit(), ppc64_rma_size);
> >  
> >  	for_each_possible_cpu(i) {
> > -		unsigned long sp;
> > -		sp  = memblock_alloc_base(THREAD_SIZE, THREAD_SIZE, limit);
> > -		sp += THREAD_SIZE;
> > -		paca[i].emergency_sp = __va(sp);
> > +		struct thread_info *ti;
> > +		ti = __va(memblock_alloc_base(THREAD_SIZE, THREAD_SIZE, limit));
> > +		klp_init_thread_info(ti);
> > +		paca[i].emergency_sp = (void *)ti + THREAD_SIZE;
>  
> Does emergency_sp still end up 128 byte aligned after this?

It should end up THREAD_SIZE aligned as before, due to the memblock_alloc_base().

> >  #ifdef CONFIG_PPC_BOOK3S_64
> >  		/* emergency stack for machine check exception handling. */
> > -		sp  = memblock_alloc_base(THREAD_SIZE, THREAD_SIZE, limit);
> > -		sp += THREAD_SIZE;
> > -		paca[i].mc_emergency_sp = __va(sp);
> > +		ti = __va(memblock_alloc_base(THREAD_SIZE, THREAD_SIZE, limit));
> > +		klp_init_thread_info(ti);

> Do we care about live-patching in this context? Are we mixing per-thread and per-cpu contexts?

Well we probably don't want to be doing live patching when we're on the
emergency stacks. But we have no control over whether that happens so we have
to support it.

cheers
