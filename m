Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D1F00B7D1E
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Apr 2010 08:50:56 +1000 (EST)
Subject: Re: [PATCH] add icswx support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mike Kravetz <kravetz@us.ibm.com>
In-Reply-To: <20100429171118.GB3411@monkey.beaverton.ibm.com>
References: <1272060275.6329.13.camel@flin.austin.ibm.com>
	<20100429171118.GB3411@monkey.beaverton.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 30 Apr 2010 08:50:48 +1000
Message-ID: <1272581448.24542.181.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org,
	"Tseng-Hui \(Frank\) Lin" <thlin@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-04-29 at 10:11 -0700, Mike Kravetz wrote:
> On Fri, Apr 23, 2010 at 05:04:35PM -0500, Tseng-Hui (Frank) Lin wrote:
> > Add Power7 icswx co-processor instruction support.
> 
> Silly question perhaps, but
> 
> Do we want this code to be enabled/exist for all processors?  I don't
> see any checks for Power7 processors.  Or, will it be the responsibility
> of the caller to ensure that they are running on P7?

Well, this is a good point, there should be at least a CPU feature here,
especially since some of that code needs to be called from the context
switch routine (though that bit seems to be missing at the moment).

Cheers,
Ben.

> -- 
> Mike
> 
> 
> > Signed-off-by: Sonny Rao <sonnyrao@linux.vnet.ibm.com>
> > Signed-off-by: Tseng-Hui (Frank) Lin <thlin@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/include/asm/mmu-hash64.h  |    3 +
> >  arch/powerpc/include/asm/mmu_context.h |    4 ++
> >  arch/powerpc/include/asm/reg.h         |    3 +
> >  arch/powerpc/mm/mmu_context_hash64.c   |   79
> > ++++++++++++++++++++++++++++++++
> >  4 files changed, 89 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/mmu-hash64.h
> > b/arch/powerpc/include/asm/mmu-hash64.h
> > index 2102b21..ba5727d 100644
> > --- a/arch/powerpc/include/asm/mmu-hash64.h
> > +++ b/arch/powerpc/include/asm/mmu-hash64.h
> > @@ -421,6 +421,9 @@ typedef struct {
> >  #ifdef CONFIG_PPC_SUBPAGE_PROT
> >  	struct subpage_prot_table spt;
> >  #endif /* CONFIG_PPC_SUBPAGE_PROT */
> > +	unsigned long acop;
> > +#define HASH64_MAX_PID (0xFFFF)
> > +	unsigned int pid;
> >  } mm_context_t;
> > 
> > 
> > diff --git a/arch/powerpc/include/asm/mmu_context.h
> > b/arch/powerpc/include/asm/mmu_context.h
> > index 26383e0..d6c8841 100644
> > --- a/arch/powerpc/include/asm/mmu_context.h
> > +++ b/arch/powerpc/include/asm/mmu_context.h
> > @@ -78,6 +78,10 @@ static inline void switch_mm(struct mm_struct *prev,
> > struct mm_struct *next,
> > 
> >  #define deactivate_mm(tsk,mm)	do { } while (0)
> > 
> > +extern void switch_cop(struct mm_struct *next);
> > +extern int  use_cop(unsigned long acop, struct task_struct *task);
> > +extern void disuse_cop(unsigned long acop, struct mm_struct *mm);
> > +
> >  /*
> >   * After we have set current->mm to a new value, this activates
> >   * the context for the new mm so we see the new mappings.
> > diff --git a/arch/powerpc/include/asm/reg.h
> > b/arch/powerpc/include/asm/reg.h
> > index 5572e86..30503f8 100644
> > --- a/arch/powerpc/include/asm/reg.h
> > +++ b/arch/powerpc/include/asm/reg.h
> > @@ -516,6 +516,9 @@
> >  #define SPRN_SIAR	780
> >  #define SPRN_SDAR	781
> > 
> > +#define SPRN_ACOP	 31
> > +#define SPRN_PID	 48
> > +
> >  #define SPRN_PA6T_MMCR0 795
> >  #define   PA6T_MMCR0_EN0	0x0000000000000001UL
> >  #define   PA6T_MMCR0_EN1	0x0000000000000002UL
> > diff --git a/arch/powerpc/mm/mmu_context_hash64.c
> > b/arch/powerpc/mm/mmu_context_hash64.c
> > index 2535828..d0a79f6 100644
> > --- a/arch/powerpc/mm/mmu_context_hash64.c
> > +++ b/arch/powerpc/mm/mmu_context_hash64.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/mm.h>
> >  #include <linux/spinlock.h>
> >  #include <linux/idr.h>
> > +#include <linux/percpu.h>
> >  #include <linux/module.h>
> >  #include <linux/gfp.h>
> > 
> > @@ -25,6 +26,82 @@
> > 
> >  static DEFINE_SPINLOCK(mmu_context_lock);
> >  static DEFINE_IDA(mmu_context_ida);
> > +static DEFINE_IDA(cop_ida);
> > +
> > +/* Lazy switch the ACOP register */
> > +static DEFINE_PER_CPU(unsigned long, acop_reg);
> > +
> > +void switch_cop(struct mm_struct *next)
> > +{
> > +	mtspr(SPRN_PID, next->context.pid);
> > +	if (next->context.pid &&
> > +	    __get_cpu_var(acop_reg) != next->context.acop) {
> > +		mtspr(SPRN_ACOP, next->context.acop);
> > +		__get_cpu_var(acop_reg) = next->context.acop;
> > +	}
> > +}
> > +
> > +int use_cop(unsigned long acop, struct task_struct *task)
> > +{
> > +	int pid;
> > +	int err;
> > +	struct mm_struct *mm = get_task_mm(task);
> > +
> > +	if (!mm)
> > +		return -EINVAL;
> > +
> > +	if (!mm->context.pid) {
> > +		if (!ida_pre_get(&cop_ida, GFP_KERNEL))
> > +			return -ENOMEM;
> > +again:
> > +		spin_lock(&mmu_context_lock);
> > +		err = ida_get_new_above(&cop_ida, 1, &pid);
> > +		spin_unlock(&mmu_context_lock);
> > +
> > +		if (err == -EAGAIN)
> > +			goto again;
> > +		else if (err)
> > +			return err;
> > +
> > +		if (pid > HASH64_MAX_PID) {
> > +			spin_lock(&mmu_context_lock);
> > +			ida_remove(&cop_ida, pid);
> > +			spin_unlock(&mmu_context_lock);
> > +			return -EBUSY;
> > +		}
> > +		mm->context.pid = pid;
> > +		mtspr(SPRN_PID,  mm->context.pid);
> > +	}
> > +	mm->context.acop |= acop;
> > +
> > +	get_cpu_var(acop_reg) = mm->context.acop;
> > +	mtspr(SPRN_ACOP, mm->context.acop);
> > +	put_cpu_var(acop_reg);
> > +
> > +	return mm->context.pid;
> > +}
> > +EXPORT_SYMBOL(use_cop);
> > +
> > +void disuse_cop(unsigned long acop, struct mm_struct *mm)
> > +{
> > +	if (WARN_ON(!mm))
> > +		return;
> > +
> > +	mm->context.acop &= ~acop;
> > +	if (!mm->context.acop) {
> > +		spin_lock(&mmu_context_lock);
> > +		ida_remove(&cop_ida, mm->context.pid);
> > +		spin_unlock(&mmu_context_lock);
> > +		mm->context.pid = 0;
> > +		mtspr(SPRN_PID, 0);
> > +	} else {
> > +		get_cpu_var(acop_reg) = mm->context.acop;
> > +		mtspr(SPRN_ACOP, mm->context.acop);
> > +		put_cpu_var(acop_reg);
> > +	}
> > +	mmput(mm);
> > +}
> > +EXPORT_SYMBOL(disuse_cop);
> > 
> >  /*
> >   * The proto-VSID space has 2^35 - 1 segments available for user
> > mappings.
> > @@ -94,6 +171,8 @@ EXPORT_SYMBOL_GPL(__destroy_context);
> >  void destroy_context(struct mm_struct *mm)
> >  {
> >  	__destroy_context(mm->context.id);
> > +	if (mm->context.pid)
> > +		ida_remove(&cop_ida, mm->context.pid);
> >  	subpage_prot_free(mm);
> >  	mm->context.id = NO_CONTEXT;
> >  }
> > 
> > 
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
