Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 38D86B70B3
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Mar 2011 12:02:52 +1100 (EST)
Subject: Re: [PATCH v4 2/2] add icswx support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Tseng-Hui (Frank) Lin" <thlin@linux.vnet.ibm.com>
In-Reply-To: <1299086454.28840.10.camel@flin.austin.ibm.com>
References: <1299086454.28840.10.camel@flin.austin.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 04 Mar 2011 12:02:40 +1100
Message-ID: <1299200560.8833.869.camel@pasglop>
Mime-Version: 1.0
Cc: tsenglin@us.ibm.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-03-02 at 11:20 -0600, Tseng-Hui (Frank) Lin wrote:

> +#define CPU_FTR_ICSWX                  LONG_ASM_CONST(0x1000000000000000)

Do we want a userspace visible feature as well ? Or some other way to
inform userspace that we support icswx ?
 
> index acac35d..b0c2549 100644
> --- a/arch/powerpc/include/asm/mmu-hash64.h
> +++ b/arch/powerpc/include/asm/mmu-hash64.h
> @@ -409,6 +409,14 @@ static inline void subpage_prot_init_new_context(struct mm_struct *mm) { }
>  
>  typedef unsigned long mm_context_id_t;
>  
> +#ifdef CONFIG_ICSWX

CONFIG_PPC_ICSWX please.

> +/*
> + * Use forward declearation to avoid including linux/spinlock_types.h
> + * which breaks kernel build.
> + */
> +struct spinlock;
> +#endif /* CONFIG_ICSWX */
> +

Yuck. Instead put all your fields into a structure called something
like struct copro_data, make that a fwd declaration and stick a pointer
to it in the mm_context.

It then only need to be allocated for processes that try to use copros,
and the definition of that structure can remain local to whatever header
you have dedicated for that.

>  typedef struct {
>  	mm_context_id_t id;
>  	u16 user_psize;		/* page size index */
> @@ -423,6 +431,11 @@ typedef struct {
>  #ifdef CONFIG_PPC_SUBPAGE_PROT
>  	struct subpage_prot_table spt;
>  #endif /* CONFIG_PPC_SUBPAGE_PROT */
> +#ifdef CONFIG_ICSWX
> +	struct spinlock *cop_lockp; /* guard acop and cop_pid */
> +	unsigned long acop;	/* mask of enabled coprocessor types */
> +	unsigned int cop_pid;	/* pid value used with coprocessors */
> +#endif /* CONFIG_ICSWX */
>  } mm_context_t;
>  
> 
> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
> index 81fb412..fe0a09a 100644
> --- a/arch/powerpc/include/asm/mmu_context.h
> +++ b/arch/powerpc/include/asm/mmu_context.h
> @@ -32,6 +32,12 @@ extern void __destroy_context(unsigned long context_id);
>  extern void mmu_context_init(void);
>  #endif
>  
> +#ifdef CONFIG_ICSWX
> +extern void switch_cop(struct mm_struct *next);
> +extern int use_cop(unsigned long acop, struct mm_struct *mm);
> +extern void drop_cop(unsigned long acop, struct mm_struct *mm);
> +#endif /* CONFIG_ICSWX */

No need to ifdef declarations.

  .../...

> +
> +#ifdef CONFIG_ICSWX_LAZY_SWITCH
> +static DEFINE_PER_CPU(unsigned long, acop_reg);
> +#define mtspr_acop(val) \
> +	if (__get_cpu_var(acop_reg) != val) { \
> +		get_cpu_var(acop_reg) = val; \
> +		mtspr(SPRN_ACOP, val); \
> +		put_cpu_var(acop_reg); \
> +	}

Why get/put games here since you did a __get in the first place ?
Doesn't make much sense. This is all inside context switch anyways so
you just do __ always and don't bother with put.

> +#else
> +#define mtspr_acop(val) mtspr(SPRN_ACOP, val)
> +#endif /* CONFIG_ICSWX_LAZY_SWITCH */

I'm not sure I totally get the point of having an ifdef here. Can't you
make it unconditional ? Or do you expect distros to turn that off in
which case what's the point ?

> +#define COP_PID_NONE 0
> +#define COP_PID_MIN (COP_PID_NONE + 1)
> +#define COP_PID_MAX (0xFFFF)
> +
> +static DEFINE_SPINLOCK(mmu_context_acop_lock);
> +static DEFINE_IDA(cop_ida);
> +
> +void switch_cop(struct mm_struct *next)
> +{
> +	mtspr(SPRN_PID, next->context.cop_pid);
> +	mtspr_acop(next->context.acop);
> +}

s/mtspr_acop/set_cpu_acop() instead.

> +static int new_cop_pid(struct ida *ida, int min_id, int max_id,
> +		       spinlock_t *lock)
> +{
> +	int index;
> +	int err;
> +
> +again:
> +	if (!ida_pre_get(ida, GFP_KERNEL))
> +		return -ENOMEM;
> +
> +	spin_lock(lock);
> +	err = ida_get_new_above(ida, min_id, &index);
> +	spin_unlock(lock);
> +
> +	if (err == -EAGAIN)
> +		goto again;
> +	else if (err)
> +		return err;
> +
> +	if (index > max_id) {
> +		spin_lock(lock);
> +		ida_remove(ida, index);
> +		spin_unlock(lock);
> +		return -ENOMEM;
> +	}
> +
> +	return index;
> +}
> +
> +/*
> + * Start using a coprocessor.
> + * @acop: mask of coprocessor to be used.
> + * @mm: The mm the coprocessor to associate with. Most likely current mm.
> + *
> + * Return a positive PID if successful. Negative errno otherwise.
> + * The returned PID will be fed to the coprocessor to determine if an
> + * icswx transaction is authenticated.
> + */
> +int use_cop(unsigned long acop, struct mm_struct *mm)
> +{
> +	int cop_pid;
> +
> +	if (!cpu_has_feature(CPU_FTR_ICSWX))
> +		return -ENODEV;
> +
> +	if (!mm || !acop)
> +		return -EINVAL;
> +
> +	spin_lock(mm->context.cop_lockp);
> +	if (mm->context.cop_pid == COP_PID_NONE) {

new_cop_pid goes GFP_KERNEL allocs no ? It even goes at great length to
drop the mmu_context_acop_lock while doing ide_pre_get() ... but you
call the whole thing with the mm->context.cop_lockp held. So that's all
wrong. You need to drop the lock, allocate a PID, take the lock again,
check if somebody came in and gave you a PID already, if yes, release
the PID you allocated.

Another option is to use a mutex since none of that is in the context
switch path right ?

Also do you ever call use_cop for a non-current mm ?
> +		cop_pid = new_cop_pid(&cop_ida, COP_PID_MIN, COP_PID_MAX,
> +				      &mmu_context_acop_lock);
> +		if (cop_pid < 0) {
> +			spin_unlock(mm->context.cop_lockp);
> +			return cop_pid;
> +		}
> +		mm->context.cop_pid = cop_pid;
> +		if (mm == current->active_mm)
> +			mtspr(SPRN_PID,  mm->context.cop_pid);
> +	}
> +	mm->context.acop |= acop;
> +	if (mm == current->active_mm)
> +		mtspr_acop(mm->context.acop);
> +	spin_unlock(mm->context.cop_lockp);
> +	return mm->context.cop_pid;
> +}
> +EXPORT_SYMBOL_GPL(use_cop);
> +
> +/*
> + * Stop using a coprocessor.
> + * @acop: mask of coprocessor to be stopped.
> + * @mm: The mm the coprocessor associated with.
> + */
> +void drop_cop(unsigned long acop, struct mm_struct *mm)
> +{
> +	if (WARN_ON(!mm))
> +		return;
> +
> +	spin_lock(mm->context.cop_lockp);
> +	mm->context.acop &= ~acop;
> +	if (mm == current->active_mm)
> +		mtspr_acop(mm->context.acop);
> +	if ((!mm->context.acop) && (mm->context.cop_pid != COP_PID_NONE)) {
> +		spin_lock(&mmu_context_acop_lock);
> +		ida_remove(&cop_ida, mm->context.cop_pid);
> +		spin_unlock(&mmu_context_acop_lock);
> +		mm->context.cop_pid = COP_PID_NONE;
> +		if (mm == current->active_mm)
> +			mtspr(SPRN_PID, mm->context.cop_pid);
> +	}
> +	spin_unlock(mm->context.cop_lockp);
> +}
> +EXPORT_SYMBOL_GPL(drop_cop);
> +
> +#endif /* CONFIG_ICSWX */
> +
>  static DEFINE_SPINLOCK(mmu_context_lock);
>  static DEFINE_IDA(mmu_context_ida);
>  
> @@ -79,6 +245,12 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
>  		slice_set_user_psize(mm, mmu_virtual_psize);
>  	subpage_prot_init_new_context(mm);
>  	mm->context.id = index;
> +#ifdef CONFIG_ICSWX
> +	mm->context.cop_lockp = kmalloc(sizeof(spinlock_t), GFP_KERNEL);
> +	if (! mm->context.cop_lockp)
> +		return -ENOMEM;
> +	spin_lock_init(mm->context.cop_lockp);
> +#endif /* CONFIG_ICSWX */
>  
>  	return 0;
>  }

No, do that on the first time a process tries to use it. No need to add
overhead to every task in the system.

> @@ -93,6 +265,11 @@ EXPORT_SYMBOL_GPL(__destroy_context);
>  
>  void destroy_context(struct mm_struct *mm)
>  {
> +#ifdef CONFIG_ICSWX
> +	drop_cop(mm->context.acop, mm);
> +	kfree(mm->context.cop_lockp);
> +	mm->context.cop_lockp = NULL;
> +#endif /* CONFIG_ICSWX */
>  	__destroy_context(mm->context.id);
>  	subpage_prot_free(mm);
>  	mm->context.id = NO_CONTEXT;
> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
> index 111138c..0007b66 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -226,6 +226,49 @@ config VSX
>  
>  	  If in doubt, say Y here.
>  
> +config ICSWX
> +	bool "Support for PowerPC icswx coprocessor instruction"
> +	depends on POWER4
> +	default n
> +	---help---
> +
> +	  Enabling this option to turn on the PowerPC Initiate Coprocessor
> +	  Store Word (icswx) coprocessor instruction support for POWER7
> +	  or newer processors.
> +
> +	  This option is only useful if you have a processor that supports
> +	  icswx coprocessor instruction. It does not have any effect on
> +	  processors without icswx coprocessor instruction.
> +
> +	  This option slightly increases kernel memory usage.
> +
> +	  Say N if you do not have a PowerPC processor supporting icswx
> +	  instruction and a PowerPC coprocessor.
> +
> +config ICSWX_LAZY_SWITCH
> +	bool "Lazy switching coprocessor type registers at context switching"
> +	depends on ICSWX
> +	default y
> +	---help---
> +
> +	  Coprocessor type register is part of process context. It needs
> +	  to be switched at context switching.
> +
> +	  As most machines have a very small number (most likely <= 1)
> +	  of coprocessors, there is a good chance that the value of the
> +	  coprocessor type register is the same between many processes.
> +	  We do not need to change coprocessor type register at context
> +	  switching unless the task to switch to has a different value.
> +	
> +	  Accessing CPU special purpose registers is far more expensive
> +	  than accessing memory. This option uses a per-CPU variable
> +	  to track the value of coprocessor type register. The variable
> +	  is checked before updating coprocessor type register. The saving
> +	  for one access is small but could turn big with the high
> +	  frequency of context switching.
> +	
> +	  Say Y unless you have multiple coprocessors.
> +
>  config SPE
>  	bool "SPE Support"
>  	depends on E200 || (E500 && !PPC_E500MC)
Ben.
