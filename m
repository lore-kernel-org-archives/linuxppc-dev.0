Return-Path: <thlin@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 95C7DB7D43
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 07:57:10 +1000 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o3RLoqxo024086
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 15:50:52 -0600
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id o3RLuqGu076012
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 15:56:52 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o3RLupwQ006609
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 15:56:51 -0600
Subject: Re: [PATCH] add icswx support
From: "Tseng-Hui (Frank) Lin" <thlin@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1272070551.2330.213.camel@pasglop>
References: <1272060275.6329.13.camel@flin.austin.ibm.com>
	<1272070551.2330.213.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 27 Apr 2010 16:56:50 -0500
Message-ID: <1272405410.6329.16.camel@flin.austin.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2010-04-24 at 10:55 +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2010-04-23 at 17:04 -0500, Tseng-Hui (Frank) Lin wrote:
> > Add Power7 icswx co-processor instruction support.
> 
> Please provide a -much- more detailed explanation of what it is, what it
> does and why it requires hooking into the MMU context switch code. _I_
> know these things but nobody else on the list does which limits the
> ability of people to review your patch.
>

icswx is a PowerPC co-processor instruction to send data to a 
co-processor. On Book-S processors the LPAR_ID and process ID (PID) of 
the owning process are registered in the window context of the
co-processor at initial time. When the icswx instruction is executed,
the L2 generates a cop-reg transaction on PowerBus. The transaction has
no address and the processor does not perform an MMU access to 
authenticate the transaction. The coprocessor compares the LPAR_ID and
the PID included in the transaction and the LPAR_ID and PID held in the
window context to determine if the process is authorized to generate the
transaction.

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
> 
> Please add a comment as to what those two fields are about, something
> like acop; /* mask of enabled coprocessor types */ and pid /* pid
> value used with coprocessors */ or something like that.
> 
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
>               ^ remove that space
> > +extern void disuse_cop(unsigned long acop, struct mm_struct *mm);
> 
> I'd prefer "drop" or "forget" :-)
> 
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
> 
> Remove the definition of SPRN_PID from reg_booke.h to avoid a double
> definition then.
> 
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
> 
> The above doesn't appear to be called anywhere ?
> 
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
> 
> Shouldn't the above be ?
> 
> 	if (mm == current->active_mm)
> 		mtspr(....)
> 
> > +	}
> > +	mm->context.acop |= acop;
> 
> Locking ?
> 
> > +	get_cpu_var(acop_reg) = mm->context.acop;
> > +	mtspr(SPRN_ACOP, mm->context.acop);
> 
> Same comment about testing for current.
> 
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
> 
> Shouldn't the above need some kind of locking if multiple threads hit it
> with different "acop" values ?
> 
> > +	if (!mm->context.acop) {
> > +		spin_lock(&mmu_context_lock);
> > +		ida_remove(&cop_ida, mm->context.pid);
> > +		spin_unlock(&mmu_context_lock);
> > +		mm->context.pid = 0;
> > +		mtspr(SPRN_PID, 0);
> 
> Same comment about current.
> 
> > +	} else {
> > +		get_cpu_var(acop_reg) = mm->context.acop;
> > +		mtspr(SPRN_ACOP, mm->context.acop);
> 
> Same comment.
> 
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
> 
> Cheers,
> Ben.
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
