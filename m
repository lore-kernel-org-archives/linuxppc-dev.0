Return-Path: <mikey@neuling.org>
Received: from localhost.localdomain (localhost [127.0.0.1])
	by ozlabs.org (Postfix) with ESMTP id DEBE0B6EE8
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Nov 2010 08:11:24 +1100 (EST)
From: Michael Neuling <mikey@neuling.org>
To: "Tseng-Hui (Frank) Lin" <thlin@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] add icswx support
In-reply-to: <1287547340.14049.25.camel@flin.austin.ibm.com>
References: <1287547340.14049.25.camel@flin.austin.ibm.com>
Date: Tue, 02 Nov 2010 08:11:24 +1100
Message-ID: <25208.1288645884@neuling.org>
Cc: tsenglin@us.ibm.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In message <1287547340.14049.25.camel@flin.austin.ibm.com> you wrote:
> icswx is a PowerPC co-processor instruction to send data to a
> co-processor. On Book-S processors the LPAR_ID and process ID (PID) of
> the owning process are registered in the window context of the
> co-processor at initial time. When the icswx instruction is executed,
> the L2 generates a cop-reg transaction on PowerBus. The transaction has
> no address and the processor does not perform an MMU access to
> authenticate the transaction. The coprocessor compares the LPAR_ID and
> the PID included in the transaction and the LPAR_ID and PID held in the
> window context to determine if the process is authorized to generate the
> transaction.
> 
> The OS needs to assign a 16-bit PID for the process. This cop-PID needs
> to be updated during context switch. The cop-PID needs to be destroyed
> when the context is destroyed.
> 
> Change log from v2:
> - Make the code a CPU feature and return -NODEV if CPU doesn't have
>   icswx co-processor instruction.
> - Change the goto loop in use_cop() into a do-while loop.
> - Change context destroy code into a new destroy_context_acop() function
>   and #define it based on CONFIG_ICSWX.
> - Remove mmput() from drop_cop().
> - Fix some TAB/space problems.
> 
> Signed-off-by: Sonny Rao <sonnyrao@linux.vnet.ibm.com>
> Signed-off-by: Tseng-Hui (Frank) Lin <thlin@linux.vnet.ibm.com>

This is white space munged again. 

Mikey

> 
> ---
>  arch/powerpc/include/asm/cputable.h    |    4 +-
>  arch/powerpc/include/asm/mmu-hash64.h  |    5 ++
>  arch/powerpc/include/asm/mmu_context.h |    6 ++
>  arch/powerpc/include/asm/reg.h         |   11 +++
>  arch/powerpc/include/asm/reg_booke.h   |    3 -
>  arch/powerpc/mm/mmu_context_hash64.c   |  109
> ++++++++++++++++++++++++++++++++
>  arch/powerpc/platforms/Kconfig.cputype |   17 +++++
>  7 files changed, 151 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/cputable.h
> b/arch/powerpc/include/asm/cputable.h
> index 3a40a99..bbb4e2c 100644
> --- a/arch/powerpc/include/asm/cputable.h
> +++ b/arch/powerpc/include/asm/cputable.h
> @@ -198,6 +198,7 @@ extern const char *powerpc_base_platform;
>  #define CPU_FTR_CP_USE_DCBTZ		LONG_ASM_CONST(0x0040000000000000)
>  #define CPU_FTR_UNALIGNED_LD_STD	LONG_ASM_CONST(0x0080000000000000)
>  #define CPU_FTR_ASYM_SMT		LONG_ASM_CONST(0x0100000000000000)
> +#define CPU_FTR_ICSWX			LONG_ASM_CONST(0x02000000000000
00)
>  
>  #ifndef __ASSEMBLY__
>  
> @@ -413,7 +414,8 @@ extern const char *powerpc_base_platform;
>  	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
>  	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE | \
>  	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
> -	    CPU_FTR_DSCR | CPU_FTR_SAO  | CPU_FTR_ASYM_SMT)
> +	    CPU_FTR_DSCR | CPU_FTR_SAO  | CPU_FTR_ASYM_SMT | \
> +	    CPU_FTR_ICSWX)
>  #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
>  	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
>  	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
> diff --git a/arch/powerpc/include/asm/mmu-hash64.h
> b/arch/powerpc/include/asm/mmu-hash64.h
> index acac35d..6c1ab90 100644
> --- a/arch/powerpc/include/asm/mmu-hash64.h
> +++ b/arch/powerpc/include/asm/mmu-hash64.h
> @@ -423,6 +423,11 @@ typedef struct {
>  #ifdef CONFIG_PPC_SUBPAGE_PROT
>  	struct subpage_prot_table spt;
>  #endif /* CONFIG_PPC_SUBPAGE_PROT */
> +#ifdef CONFIG_ICSWX
> +	unsigned long acop;	/* mask of enabled coprocessor types */
> +#define HASH64_MAX_PID (0xFFFF)
> +	unsigned int acop_pid;	/* pid value used with coprocessors */
> +#endif /* CONFIG_ICSWX */
>  } mm_context_t;
>  
>  
> diff --git a/arch/powerpc/include/asm/mmu_context.h
> b/arch/powerpc/include/asm/mmu_context.h
> index 81fb412..88118de 100644
> --- a/arch/powerpc/include/asm/mmu_context.h
> +++ b/arch/powerpc/include/asm/mmu_context.h
> @@ -80,6 +80,12 @@ static inline void switch_mm(struct mm_struct *prev,
> struct mm_struct *next,
>  
>  #define deactivate_mm(tsk,mm)	do { } while (0)
>  
> +#ifdef CONFIG_ICSWX
> +extern void switch_cop(struct mm_struct *next);
> +extern int use_cop(unsigned long acop, struct mm_struct *mm);
> +extern void drop_cop(unsigned long acop, struct mm_struct *mm);
> +#endif /* CONFIG_ICSWX */
> +
>  /*
>   * After we have set current->mm to a new value, this activates
>   * the context for the new mm so we see the new mappings.
> diff --git a/arch/powerpc/include/asm/reg.h
> b/arch/powerpc/include/asm/reg.h
> index ff0005eec..b86d876 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -170,8 +170,19 @@
>  #define SPEFSCR_FRMC 	0x00000003	/* Embedded FP rounding mode co
ntrol
> */
>  
>  /* Special Purpose Registers (SPRNs)*/
> +
> +#ifdef CONFIG_40x
> +#define SPRN_PID	0x3B1	/* Process ID */
> +#else
> +#define SPRN_PID	0x030	/* Process ID */
> +#ifdef CONFIG_BOOKE
> +#define SPRN_PID0	SPRN_PID/* Process ID Register 0 */
> +#endif
> +#endif
> +
>  #define SPRN_CTR	0x009	/* Count Register */
>  #define SPRN_DSCR	0x11
> +#define SPRN_ACOP	0x1F	/* Available Coprocessor Register */
>  #define SPRN_CTRLF	0x088
>  #define SPRN_CTRLT	0x098
>  #define   CTRL_CT	0xc0000000	/* current thread */
> diff --git a/arch/powerpc/include/asm/reg_booke.h
> b/arch/powerpc/include/asm/reg_booke.h
> index 667a498..5b0c781 100644
> --- a/arch/powerpc/include/asm/reg_booke.h
> +++ b/arch/powerpc/include/asm/reg_booke.h
> @@ -150,8 +150,6 @@
>   * or IBM 40x.
>   */
>  #ifdef CONFIG_BOOKE
> -#define SPRN_PID	0x030	/* Process ID */
> -#define SPRN_PID0	SPRN_PID/* Process ID Register 0 */
>  #define SPRN_CSRR0	0x03A	/* Critical Save and Restore Register 0 */
>  #define SPRN_CSRR1	0x03B	/* Critical Save and Restore Register 1 */
>  #define SPRN_DEAR	0x03D	/* Data Error Address Register */
> @@ -168,7 +166,6 @@
>  #define SPRN_TCR	0x154	/* Timer Control Register */
>  #endif /* Book E */
>  #ifdef CONFIG_40x
> -#define SPRN_PID	0x3B1	/* Process ID */
>  #define SPRN_DBCR1	0x3BD	/* Debug Control Register 1 */		
>  #define SPRN_ESR	0x3D4	/* Exception Syndrome Register */
>  #define SPRN_DEAR	0x3D5	/* Data Error Address Register */
> diff --git a/arch/powerpc/mm/mmu_context_hash64.c
> b/arch/powerpc/mm/mmu_context_hash64.c
> index 2535828..6ef6ce2 100644
> --- a/arch/powerpc/mm/mmu_context_hash64.c
> +++ b/arch/powerpc/mm/mmu_context_hash64.c
> @@ -18,6 +18,7 @@
>  #include <linux/mm.h>
>  #include <linux/spinlock.h>
>  #include <linux/idr.h>
> +#include <linux/percpu.h>
>  #include <linux/module.h>
>  #include <linux/gfp.h>
>  
> @@ -26,6 +27,113 @@
>  static DEFINE_SPINLOCK(mmu_context_lock);
>  static DEFINE_IDA(mmu_context_ida);
>  
> +#ifdef CONFIG_ICSWX
> +static DEFINE_SPINLOCK(mmu_context_acop_lock);
> +static DEFINE_IDA(cop_ida);
> +
> +/* Lazy switch the ACOP register */
> +static DEFINE_PER_CPU(unsigned long, acop_reg);
> +
> +void switch_cop(struct mm_struct *next)
> +{
> +	if (!cpu_has_feature(CPU_FTR_ICSWX))
> +		return;
> +
> +	mtspr(SPRN_PID, next->context.acop_pid);
> +	if (next->context.acop_pid &&
> +	    __get_cpu_var(acop_reg) != next->context.acop) {
> +		mtspr(SPRN_ACOP, next->context.acop);
> +		__get_cpu_var(acop_reg) = next->context.acop;
> +	}
> +}
> +EXPORT_SYMBOL(switch_cop);
> +
> +int use_cop(unsigned long acop, struct mm_struct *mm)
> +{
> +	int acop_pid;
> +	int err;
> +
> +	if (!cpu_has_feature(CPU_FTR_ICSWX))
> +		return -ENODEV;
> +
> +	if (!mm)
> +		return -EINVAL;
> +
> +	if (!mm->context.acop_pid) {
> +		if (!ida_pre_get(&cop_ida, GFP_KERNEL))
> +			return -ENOMEM;
> +		do {
> +			spin_lock(&mmu_context_acop_lock);
> +			err = ida_get_new_above(&cop_ida, 1, &acop_pid);
> +			spin_unlock(&mmu_context_acop_lock);
> +		} while (err == -EAGAIN);
> +
> +		if (err)
> +			return err;
> +
> +		if (acop_pid > HASH64_MAX_PID) {
> +			spin_lock(&mmu_context_acop_lock);
> +			ida_remove(&cop_ida, acop_pid);
> +			spin_unlock(&mmu_context_acop_lock);
> +			return -EBUSY;
> +		}
> +		mm->context.acop_pid = acop_pid;
> +		if (mm == current->active_mm)
> +			mtspr(SPRN_PID,  mm->context.acop_pid);
> +	}
> +	spin_lock(&mmu_context_acop_lock);
> +	mm->context.acop |= acop;
> +	spin_unlock(&mmu_context_acop_lock);
> +
> +	get_cpu_var(acop_reg) = mm->context.acop;
> +	if (mm == current->active_mm)
> +		mtspr(SPRN_ACOP, mm->context.acop);
> +	put_cpu_var(acop_reg);
> +
> +	return mm->context.acop_pid;
> +}
> +EXPORT_SYMBOL(use_cop);
> +
> +void drop_cop(unsigned long acop, struct mm_struct *mm)
> +{
> +	if (!cpu_has_feature(CPU_FTR_ICSWX))
> +		return;
> +
> +	if (WARN_ON(!mm))
> +		return;
> +
> +	spin_lock(&mmu_context_acop_lock);
> +	mm->context.acop &= ~acop;
> +	spin_unlock(&mmu_context_acop_lock);
> +	if (!mm->context.acop) {
> +		spin_lock(&mmu_context_acop_lock);
> +		ida_remove(&cop_ida, mm->context.acop_pid);
> +		spin_unlock(&mmu_context_acop_lock);
> +		mm->context.acop_pid = 0;
> +		if (mm == current->active_mm)
> +			mtspr(SPRN_PID, mm->context.acop_pid);
> +	} else {
> +		get_cpu_var(acop_reg) = mm->context.acop;
> +		if (mm == current->active_mm)
> +			mtspr(SPRN_ACOP, mm->context.acop);
> +		put_cpu_var(acop_reg);
> +	}
> +}
> +EXPORT_SYMBOL(drop_cop);
> +
> +static void destroy_context_acop(struct mm_struct *mm)
> +{
> +	if (mm->context.acop_pid) {
> +		spin_lock(&mmu_context_acop_lock);
> +		ida_remove(&cop_ida, mm->context.acop_pid);
> +		spin_unlock(&mmu_context_acop_lock);
> +	}
> +}
> +
> +#else
> +#define destroy_context_acop(mm)
> +#endif /* CONFIG_ICSWX */
> +
>  /*
>   * The proto-VSID space has 2^35 - 1 segments available for user
> mappings.
>   * Each segment contains 2^28 bytes.  Each context maps 2^44 bytes,
> @@ -93,6 +201,7 @@ EXPORT_SYMBOL_GPL(__destroy_context);
>  
>  void destroy_context(struct mm_struct *mm)
>  {
> +	destroy_context_acop(mm);
>  	__destroy_context(mm->context.id);
>  	subpage_prot_free(mm);
>  	mm->context.id = NO_CONTEXT;
> diff --git a/arch/powerpc/platforms/Kconfig.cputype
> b/arch/powerpc/platforms/Kconfig.cputype
> index d361f81..7678e29 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -220,6 +220,23 @@ config VSX
>  
>  	  If in doubt, say Y here.
>  
> +config ICSWX
> +	bool "Support for PowerPC icswx co-processor instruction"
> +	depends on POWER4
> +	default n
> +	---help---
> +
> +	  Enabling this option to turn on the PowerPC icswx co-processor
> +	  instruction support for POWER7 or newer processors.
> +	  This option is only useful if you have a processor that supports
> +	  icswx co-processor instruction. It does not have any effect on
> +	  processors without icswx co-processor instruction.
> +
> +	  This support slightly increases kernel memory usage.
> +
> +	  Say N if you do not have a PowerPC processor supporting icswx
> +	  instruction and a PowerPC co-processor.
> +
>  config SPE
>  	bool "SPE Support"
>  	depends on E200 || (E500 && !PPC_E500MC)
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
