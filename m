Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tFMtH21h9zDvmv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 12:35:19 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id i88so383553pfk.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 17:35:19 -0800 (PST)
Date: Fri, 11 Nov 2016 12:35:07 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: Alistair Popple <alistair@popple.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/3] powerpc: add struct smp_ops_t.cause_nmi_ipi operation
Message-ID: <20161111123507.7c52f246@roar.ozlabs.ibm.com>
In-Reply-To: <2375478.VYA2BGbrTl@new-mexico>
References: <20161108140125.21455-1-npiggin@gmail.com>
 <20161108140125.21455-3-npiggin@gmail.com>
 <2375478.VYA2BGbrTl@new-mexico>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 11 Nov 2016 12:00:14 +1100
Alistair Popple <alistair@popple.id.au> wrote:

> On Wed, 9 Nov 2016 01:01:24 AM Nicholas Piggin wrote:
> > Allow platforms to provide an NMI IPI, and wire that to the NMI
> > system.
> > ---
> >  arch/powerpc/include/asm/smp.h            |  5 +++++
> >  arch/powerpc/kernel/smp.c                 | 21 ++++++++++++++++-----
> >  arch/powerpc/platforms/85xx/smp.c         |  1 +
> >  arch/powerpc/platforms/86xx/mpc86xx_smp.c |  1 +
> >  arch/powerpc/platforms/chrp/smp.c         |  1 +
> >  arch/powerpc/platforms/powermac/smp.c     |  1 +
> >  arch/powerpc/platforms/powernv/smp.c      |  1 +
> >  arch/powerpc/platforms/pseries/smp.c      |  1 +
> >  8 files changed, 27 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
> > index 055918d..15521c1 100644
> > --- a/arch/powerpc/include/asm/smp.h
> > +++ b/arch/powerpc/include/asm/smp.h
> > @@ -37,11 +37,15 @@ extern int cpu_to_chip_id(int cpu);
> >  
> >  #ifdef CONFIG_SMP
> >  
> > +#define SMP_OP_NMI_TYPE_SAFE	1
> > +#define SMP_OP_NMI_TYPE_HARD	2
> > +
> >  struct smp_ops_t {
> >  	void  (*message_pass)(int cpu, int msg);
> >  #ifdef CONFIG_PPC_SMP_MUXED_IPI
> >  	void  (*cause_ipi)(int cpu, unsigned long data);
> >  #endif
> > +	int   (*cause_nmi_ipi)(int cpu, int type);
> >  	void  (*probe)(void);
> >  	int   (*kick_cpu)(int nr);
> >  	void  (*setup_cpu)(int nr);
> > @@ -53,6 +57,7 @@ struct smp_ops_t {
> >  	int   (*cpu_bootable)(unsigned int nr);
> >  };
> >  
> > +extern int smp_handle_nmi_ipi(struct pt_regs *regs);
> >  extern void smp_send_debugger_break(void);
> >  extern void start_secondary_resume(void);
> >  extern void smp_generic_give_timebase(void);
> > diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> > index 959d9dc..b3133e9 100644
> > --- a/arch/powerpc/kernel/smp.c
> > +++ b/arch/powerpc/kernel/smp.c
> > @@ -425,8 +425,10 @@ int smp_handle_nmi_ipi(struct pt_regs *regs)
> >  	return ret;
> >  }
> >  
> > -static void do_smp_send_nmi_ipi(int cpu)
> > +static void do_smp_send_nmi_ipi(int cpu, int type)
> >  {
> > +	if (smp_ops->cause_nmi_ipi && smp_ops->cause_nmi_ipi(cpu, type))
> > +		return;
> >  	do_message_pass(cpu, PPC_MSG_NMI_IPI_SAFE);
> >  }
> >  
> > @@ -453,9 +455,6 @@ int smp_send_nmi_ipi(int cpu, int function, void *data,
> >  	if (unlikely(!smp_ops))
> >  		return 0;
> >  
> > -	/* Have no real NMI capability yet */
> > -	safe_udelay += hard_udelay;
> > -
> >  	get_online_cpus();
> >  
> >  	/* Take the nmi_ipi_busy count/lock with interrupts hard disabled */
> > @@ -482,7 +481,7 @@ int smp_send_nmi_ipi(int cpu, int function, void *data,
> >  
> >  	if (safe_udelay) {
> >  		for_each_cpu(c, &nmi_ipi_pending_mask)
> > -			do_smp_send_nmi_ipi(c);
> > +			do_smp_send_nmi_ipi(c, SMP_OP_NMI_TYPE_SAFE);
> >  
> >  		do {
> >  			safe_udelay--;
> > @@ -492,6 +491,18 @@ int smp_send_nmi_ipi(int cpu, int function, void *data,
> >  		} while (safe_udelay);
> >  	}
> >  
> > +	if (hard_udelay) {  
> 
> So if the "safe" NMI fails we go onto the one that might break your system? 
> Why would the safe NMI fail? Does it only fail when other CPUs are stuck with 
> interrupts turned off?

Yes. I don't *really* know if this is worth the added complexity, mind you.
But in theory it's nice to be able to resume after debugger.

> Or are there other cases? I'm just wondering how safe 
> it is - is there a chance that the safe one might corrupt state we're 
> interested in debugging?

Yes, that's a possibility for sure. For example in the case where we saw two
CPUs sharing the same stack, the doorbell interrupt would have tried to use
the shared stack and got into even more problems. When we switch system reset
interrupt to using a dedicated NMI stack, it will become quite minimal and
uninvasive path to crashdump.

So for crashes/crashdumps, I think we definitely do just want to do the
"hard" NMI immediately. We have no real possibility to recover in that case.

> I'm fairly confident we can make the hard NMI reliable (although perhaps not 
> as good as the safe variant) so the safe one may not be worth it if there's a 
> risk we loose debug state.

Okay. Well so far the 3 main users are debugger, crashdump, and stop cpu.

stop and crashdump never have to recover.

debugger has the option to recover, which does work for the most part. Maybe
we are happy to just say it should not run on production systems because it
could cause a crash in rare cases?

> > +		for_each_cpu(c, &nmi_ipi_pending_mask)  
> 
> Doesn't the H_CALL support a flag for all but self? For PowerNV/OPAL I was 
> looking to implement this as well and on bare-metal it is (perhaps marginally) 
> more efficient to loop through the CPUs in firmware.
> 
> Of course the issue with that is that I'm not sure firmware is aware of 
> cpu_online_mask so ALLBUTSELF would reset all CPUs, not just online ones. Not 
> sure if that would be an issue?

Yes the hcall does support all and allbutself. I don't actually know if it
would be a problem for offline CPUs to get system resets. The powernv platform
can probably add a system_reset handler, so it could test the online mask and
avoid calling to the IPI handler if the CPU is not online AFAIKS.

On the other hand, I wonder if simpler is better. Would there be any significant
benefit for this in a crash/debug situation?

Thanks,
Nick
