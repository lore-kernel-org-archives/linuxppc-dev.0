Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyNJL0brNzDr3l
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 23:03:13 +1000 (AEST)
Message-ID: <1498654976.3651.42.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/powernv: Rework local TLB flush for boot and
 MCE on POWER9
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Nicholas Piggin
 <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, "Gautham R .
 Shenoy" <ego@linux.vnet.ibm.com>
Date: Wed, 28 Jun 2017 08:02:56 -0500
In-Reply-To: <87k23wvn78.fsf@skywalker.in.ibm.com>
References: <20170606054247.24914-1-npiggin@gmail.com>
 <87k23wvn78.fsf@skywalker.in.ibm.com>
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

On Wed, 2017-06-28 at 08:21 +0530, Aneesh Kumar K.V wrote:
> 
> 
> I am not sure the new location of flushing the tlb is correct/perfect. For ex:
> may be we should do it before htab_initialize() so that we start with
> all everything flushed ? But otherwise

Doesn't matter as long as you do it before you turn on MSR:DR/IR

> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> 
> 
> > 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  arch/powerpc/include/asm/book3s/64/tlbflush-hash.h |  1 +
> >  .../powerpc/include/asm/book3s/64/tlbflush-radix.h |  3 +
> >  arch/powerpc/include/asm/book3s/64/tlbflush.h      | 34 +++++++++
> >  arch/powerpc/include/asm/cputable.h                | 12 ----
> >  arch/powerpc/kernel/cpu_setup_power.S              | 43 ------------
> >  arch/powerpc/kernel/cputable.c                     | 14 ----
> >  arch/powerpc/kernel/dt_cpu_ftrs.c                  | 42 -----------
> >  arch/powerpc/kernel/mce_power.c                    | 61 +---------------
> >  arch/powerpc/kvm/book3s_hv_ras.c                   |  6 +-
> >  arch/powerpc/mm/hash_native_64.c                   | 82 ++++++++++++++++++++++
> >  arch/powerpc/mm/hash_utils_64.c                    |  4 ++
> >  arch/powerpc/mm/pgtable-radix.c                    |  4 ++
> >  arch/powerpc/mm/tlb-radix.c                        | 57 +++++++++++++++
> >  13 files changed, 189 insertions(+), 174 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
> > index 2f6373144e2c..c02ece27fd7b 100644
> > --- a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
> > +++ b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
> > @@ -50,6 +50,7 @@ static inline void arch_leave_lazy_mmu_mode(void)
> > 
> >  #define arch_flush_lazy_mmu_mode()      do {} while (0)
> > 
> > +extern void hash__tlbiel_all(unsigned int action);
> > 
> >  extern void flush_hash_page(unsigned long vpn, real_pte_t pte, int psize,
> >  			    int ssize, unsigned long flags);
> > diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
> > index cc7fbde4f53c..e7b767a3b2fa 100644
> > --- a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
> > +++ b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
> > @@ -10,6 +10,8 @@ static inline int mmu_get_ap(int psize)
> >  	return mmu_psize_defs[psize].ap;
> >  }
> > 
> > +extern void radix__tlbiel_all(unsigned int action);
> > +
> >  extern void radix__flush_hugetlb_tlb_range(struct vm_area_struct *vma,
> >  					   unsigned long start, unsigned long end);
> >  extern void radix__flush_tlb_range_psize(struct mm_struct *mm, unsigned long start,
> > @@ -44,4 +46,5 @@ extern void radix__flush_tlb_lpid(unsigned long lpid);
> >  extern void radix__flush_tlb_all(void);
> >  extern void radix__flush_tlb_pte_p9_dd1(unsigned long old_pte, struct mm_struct *mm,
> >  					unsigned long address);
> > +
> >  #endif
> > diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush.h b/arch/powerpc/include/asm/book3s/64/tlbflush.h
> > index 72b925f97bab..a6f3a210d4de 100644
> > --- a/arch/powerpc/include/asm/book3s/64/tlbflush.h
> > +++ b/arch/powerpc/include/asm/book3s/64/tlbflush.h
> > @@ -7,6 +7,40 @@
> >  #include <asm/book3s/64/tlbflush-hash.h>
> >  #include <asm/book3s/64/tlbflush-radix.h>
> > 
> > +/* TLB flush actions. Used as argument to tlbiel_all() */
> > +enum {
> > +	TLB_INVAL_SCOPE_GLOBAL = 0,	/* invalidate all TLBs */
> > +	TLB_INVAL_SCOPE_LPID = 1,	/* invalidate TLBs for current LPID */
> > +};
> > +
> > +static inline void tlbiel_all(void)
> > +{
> > +	/*
> > +	 * This is used for host machine check and bootup.
> > +	 *
> > +	 * This could be reimplemented more robustly without using the
> > +	 * radix_is_enabled(), cpu_feature(), etc. calls. However these
> > +	 * should be set up before relocation starts to be used at boot,
> > +	 * so we shouldn't see TLB machine checks before then.
> > +	 */
> > +	if (radix_enabled())
> > +		radix__tlbiel_all(TLB_INVAL_SCOPE_GLOBAL);
> > +	else
> > +		hash__tlbiel_all(TLB_INVAL_SCOPE_GLOBAL);
> > +}
> > +
> > +static inline void tlbiel_all_lpid(bool radix)
> > +{
> > +	/*
> > +	 * This is used for guest machine check.
> > +	 */
> > +	if (radix)
> > +		radix__tlbiel_all(TLB_INVAL_SCOPE_LPID);
> > +	else
> > +		hash__tlbiel_all(TLB_INVAL_SCOPE_LPID);
> > +}
> > +
> > +
> >  #define __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
> >  static inline void flush_pmd_tlb_range(struct vm_area_struct *vma,
> >  				       unsigned long start, unsigned long end)
> > diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
> > index c2d509584a98..808a5aa4bcf2 100644
> > --- a/arch/powerpc/include/asm/cputable.h
> > +++ b/arch/powerpc/include/asm/cputable.h
> > @@ -106,12 +106,6 @@ struct cpu_spec {
> >  	 * called in real mode to handle SLB and TLB errors.
> >  	 */
> >  	long		(*machine_check_early)(struct pt_regs *regs);
> > -
> > -	/*
> > -	 * Processor specific routine to flush tlbs.
> > -	 */
> > -	void		(*flush_tlb)(unsigned int action);
> > -
> >  };
> > 
> >  extern struct cpu_spec		*cur_cpu_spec;
> > @@ -132,12 +126,6 @@ extern void cpu_feature_keys_init(void);
> >  static inline void cpu_feature_keys_init(void) { }
> >  #endif
> > 
> > -/* TLB flush actions. Used as argument to cpu_spec.flush_tlb() hook */
> > -enum {
> > -	TLB_INVAL_SCOPE_GLOBAL = 0,	/* invalidate all TLBs */
> > -	TLB_INVAL_SCOPE_LPID = 1,	/* invalidate TLBs for current LPID */
> > -};
> > -
> >  #endif /* __ASSEMBLY__ */
> > 
> >  /* CPU kernel features */
> > diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cpu_setup_power.S
> > index 10cb2896b2ae..730ade48329b 100644
> > --- a/arch/powerpc/kernel/cpu_setup_power.S
> > +++ b/arch/powerpc/kernel/cpu_setup_power.S
> > @@ -31,7 +31,6 @@ _GLOBAL(__setup_cpu_power7)
> >  	mfspr	r3,SPRN_LPCR
> >  	li	r4,(LPCR_LPES1 >> LPCR_LPES_SH)
> >  	bl	__init_LPCR_ISA206
> > -	bl	__init_tlb_power7
> >  	mtlr	r11
> >  	blr
> > 
> > @@ -45,7 +44,6 @@ _GLOBAL(__restore_cpu_power7)
> >  	mfspr	r3,SPRN_LPCR
> >  	li	r4,(LPCR_LPES1 >> LPCR_LPES_SH)
> >  	bl	__init_LPCR_ISA206
> > -	bl	__init_tlb_power7
> >  	mtlr	r11
> >  	blr
> > 
> > @@ -64,7 +62,6 @@ _GLOBAL(__setup_cpu_power8)
> >  	li	r4,0 /* LPES = 0 */
> >  	bl	__init_LPCR_ISA206
> >  	bl	__init_HFSCR
> > -	bl	__init_tlb_power8
> >  	bl	__init_PMU_HV
> >  	bl	__init_PMU_HV_ISA207
> >  	mtlr	r11
> > @@ -86,7 +83,6 @@ _GLOBAL(__restore_cpu_power8)
> >  	li	r4,0 /* LPES = 0 */
> >  	bl	__init_LPCR_ISA206
> >  	bl	__init_HFSCR
> > -	bl	__init_tlb_power8
> >  	bl	__init_PMU_HV
> >  	bl	__init_PMU_HV_ISA207
> >  	mtlr	r11
> > @@ -110,7 +106,6 @@ _GLOBAL(__setup_cpu_power9)
> >  	li	r4,0 /* LPES = 0 */
> >  	bl	__init_LPCR_ISA300
> >  	bl	__init_HFSCR
> > -	bl	__init_tlb_power9
> >  	bl	__init_PMU_HV
> >  	mtlr	r11
> >  	blr
> > @@ -134,7 +129,6 @@ _GLOBAL(__restore_cpu_power9)
> >  	li	r4,0 /* LPES = 0 */
> >  	bl	__init_LPCR_ISA300
> >  	bl	__init_HFSCR
> > -	bl	__init_tlb_power9
> >  	bl	__init_PMU_HV
> >  	mtlr	r11
> >  	blr
> > @@ -192,43 +186,6 @@ __init_HFSCR:
> >  	mtspr	SPRN_HFSCR,r3
> >  	blr
> > 
> > -/*
> > - * Clear the TLB using the specified IS form of tlbiel instruction
> > - * (invalidate by congruence class). P7 has 128 CCs., P8 has 512.
> > - */
> > -__init_tlb_power7:
> > -	li	r6,POWER7_TLB_SETS
> > -	mtctr	r6
> > -	li	r7,0xc00	/* IS field = 0b11 */
> > -	ptesync
> > -2:	tlbiel	r7
> > -	addi	r7,r7,0x1000
> > -	bdnz	2b
> > -	ptesync
> > -1:	blr
> > -
> > -__init_tlb_power8:
> > -	li	r6,POWER8_TLB_SETS
> > -	mtctr	r6
> > -	li	r7,0xc00	/* IS field = 0b11 */
> > -	ptesync
> > -2:	tlbiel	r7
> > -	addi	r7,r7,0x1000
> > -	bdnz	2b
> > -	ptesync
> > -1:	blr
> > -
> > -__init_tlb_power9:
> > -	li	r6,POWER9_TLB_SETS_HASH
> > -	mtctr	r6
> > -	li	r7,0xc00	/* IS field = 0b11 */
> > -	ptesync
> > -2:	tlbiel	r7
> > -	addi	r7,r7,0x1000
> > -	bdnz	2b
> > -	ptesync
> > -1:	blr
> > -
> >  __init_PMU_HV:
> >  	li	r5,0
> >  	mtspr	SPRN_MMCRC,r5
> > diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
> > index 6f849832a669..d0a3eea6365d 100644
> > --- a/arch/powerpc/kernel/cputable.c
> > +++ b/arch/powerpc/kernel/cputable.c
> > @@ -74,9 +74,6 @@ extern void __setup_cpu_power8(unsigned long offset, struct cpu_spec* spec);
> >  extern void __restore_cpu_power8(void);
> >  extern void __setup_cpu_power9(unsigned long offset, struct cpu_spec* spec);
> >  extern void __restore_cpu_power9(void);
> > -extern void __flush_tlb_power7(unsigned int action);
> > -extern void __flush_tlb_power8(unsigned int action);
> > -extern void __flush_tlb_power9(unsigned int action);
> >  extern long __machine_check_early_realmode_p7(struct pt_regs *regs);
> >  extern long __machine_check_early_realmode_p8(struct pt_regs *regs);
> >  extern long __machine_check_early_realmode_p9(struct pt_regs *regs);
> > @@ -368,7 +365,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
> >  		.oprofile_cpu_type	= "ppc64/ibm-compat-v1",
> >  		.cpu_setup		= __setup_cpu_power7,
> >  		.cpu_restore		= __restore_cpu_power7,
> > -		.flush_tlb		= __flush_tlb_power7,
> >  		.machine_check_early	= __machine_check_early_realmode_p7,
> >  		.platform		= "power7",
> >  	},
> > @@ -386,7 +382,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
> >  		.oprofile_cpu_type	= "ppc64/ibm-compat-v1",
> >  		.cpu_setup		= __setup_cpu_power8,
> >  		.cpu_restore		= __restore_cpu_power8,
> > -		.flush_tlb		= __flush_tlb_power8,
> >  		.machine_check_early	= __machine_check_early_realmode_p8,
> >  		.platform		= "power8",
> >  	},
> > @@ -404,7 +399,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
> >  		.oprofile_cpu_type	= "ppc64/ibm-compat-v1",
> >  		.cpu_setup		= __setup_cpu_power9,
> >  		.cpu_restore		= __restore_cpu_power9,
> > -		.flush_tlb		= __flush_tlb_power9,
> >  		.platform		= "power9",
> >  	},
> >  	{	/* Power7 */
> > @@ -423,7 +417,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
> >  		.oprofile_type		= PPC_OPROFILE_POWER4,
> >  		.cpu_setup		= __setup_cpu_power7,
> >  		.cpu_restore		= __restore_cpu_power7,
> > -		.flush_tlb		= __flush_tlb_power7,
> >  		.machine_check_early	= __machine_check_early_realmode_p7,
> >  		.platform		= "power7",
> >  	},
> > @@ -443,7 +436,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
> >  		.oprofile_type		= PPC_OPROFILE_POWER4,
> >  		.cpu_setup		= __setup_cpu_power7,
> >  		.cpu_restore		= __restore_cpu_power7,
> > -		.flush_tlb		= __flush_tlb_power7,
> >  		.machine_check_early	= __machine_check_early_realmode_p7,
> >  		.platform		= "power7+",
> >  	},
> > @@ -463,7 +455,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
> >  		.oprofile_type		= PPC_OPROFILE_INVALID,
> >  		.cpu_setup		= __setup_cpu_power8,
> >  		.cpu_restore		= __restore_cpu_power8,
> > -		.flush_tlb		= __flush_tlb_power8,
> >  		.machine_check_early	= __machine_check_early_realmode_p8,
> >  		.platform		= "power8",
> >  	},
> > @@ -483,7 +474,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
> >  		.oprofile_type		= PPC_OPROFILE_INVALID,
> >  		.cpu_setup		= __setup_cpu_power8,
> >  		.cpu_restore		= __restore_cpu_power8,
> > -		.flush_tlb		= __flush_tlb_power8,
> >  		.machine_check_early	= __machine_check_early_realmode_p8,
> >  		.platform		= "power8",
> >  	},
> > @@ -503,7 +493,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
> >  		.oprofile_type		= PPC_OPROFILE_INVALID,
> >  		.cpu_setup		= __setup_cpu_power8,
> >  		.cpu_restore		= __restore_cpu_power8,
> > -		.flush_tlb		= __flush_tlb_power8,
> >  		.machine_check_early	= __machine_check_early_realmode_p8,
> >  		.platform		= "power8",
> >  	},
> > @@ -523,7 +512,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
> >  		.oprofile_type		= PPC_OPROFILE_INVALID,
> >  		.cpu_setup		= __setup_cpu_power8,
> >  		.cpu_restore		= __restore_cpu_power8,
> > -		.flush_tlb		= __flush_tlb_power8,
> >  		.machine_check_early	= __machine_check_early_realmode_p8,
> >  		.platform		= "power8",
> >  	},
> > @@ -543,7 +531,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
> >  		.oprofile_type		= PPC_OPROFILE_INVALID,
> >  		.cpu_setup		= __setup_cpu_power9,
> >  		.cpu_restore		= __restore_cpu_power9,
> > -		.flush_tlb		= __flush_tlb_power9,
> >  		.machine_check_early	= __machine_check_early_realmode_p9,
> >  		.platform		= "power9",
> >  	},
> > @@ -563,7 +550,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
> >  		.oprofile_type		= PPC_OPROFILE_INVALID,
> >  		.cpu_setup		= __setup_cpu_power9,
> >  		.cpu_restore		= __restore_cpu_power9,
> > -		.flush_tlb		= __flush_tlb_power9,
> >  		.machine_check_early	= __machine_check_early_realmode_p9,
> >  		.platform		= "power9",
> >  	},
> > diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
> > index fcc7588a96d6..030448914a5d 100644
> > --- a/arch/powerpc/kernel/dt_cpu_ftrs.c
> > +++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
> > @@ -76,8 +76,6 @@ struct dt_cpu_feature {
> >   * Set up the base CPU
> >   */
> > 
> > -extern void __flush_tlb_power8(unsigned int action);
> > -extern void __flush_tlb_power9(unsigned int action);
> >  extern long __machine_check_early_realmode_p8(struct pt_regs *regs);
> >  extern long __machine_check_early_realmode_p9(struct pt_regs *regs);
> > 
> > @@ -91,39 +89,6 @@ static struct {
> > 
> >  static void (*init_pmu_registers)(void);
> > 
> > -static void cpufeatures_flush_tlb(void)
> > -{
> > -	unsigned long rb;
> > -	unsigned int i, num_sets;
> > -
> > -	/*
> > -	 * This is a temporary measure to keep equivalent TLB flush as the
> > -	 * cputable based setup code.
> > -	 */
> > -	switch (PVR_VER(mfspr(SPRN_PVR))) {
> > -	case PVR_POWER8:
> > -	case PVR_POWER8E:
> > -	case PVR_POWER8NVL:
> > -		num_sets = POWER8_TLB_SETS;
> > -		break;
> > -	case PVR_POWER9:
> > -		num_sets = POWER9_TLB_SETS_HASH;
> > -		break;
> > -	default:
> > -		num_sets = 1;
> > -		pr_err("unknown CPU version for boot TLB flush\n");
> > -		break;
> > -	}
> > -
> > -	asm volatile("ptesync" : : : "memory");
> > -	rb = TLBIEL_INVAL_SET;
> > -	for (i = 0; i < num_sets; i++) {
> > -		asm volatile("tlbiel %0" : : "r" (rb));
> > -		rb += 1 << TLBIEL_INVAL_SET_SHIFT;
> > -	}
> > -	asm volatile("ptesync" : : : "memory");
> > -}
> > -
> >  static void __restore_cpu_cpufeatures(void)
> >  {
> >  	/*
> > @@ -148,8 +113,6 @@ static void __restore_cpu_cpufeatures(void)
> > 
> >  	if (init_pmu_registers)
> >  		init_pmu_registers();
> > -
> > -	cpufeatures_flush_tlb();
> >  }
> > 
> >  static char dt_cpu_name[64];
> > @@ -168,7 +131,6 @@ static struct cpu_spec __initdata base_cpu_spec = {
> >  	.oprofile_type		= PPC_OPROFILE_INVALID,
> >  	.cpu_setup		= NULL,
> >  	.cpu_restore		= __restore_cpu_cpufeatures,
> > -	.flush_tlb		= NULL,
> >  	.machine_check_early	= NULL,
> >  	.platform		= NULL,
> >  };
> > @@ -423,7 +385,6 @@ static void init_pmu_power8(void)
> >  static int __init feat_enable_mce_power8(struct dt_cpu_feature *f)
> >  {
> >  	cur_cpu_spec->platform = "power8";
> > -	cur_cpu_spec->flush_tlb = __flush_tlb_power8;
> >  	cur_cpu_spec->machine_check_early = __machine_check_early_realmode_p8;
> > 
> >  	return 1;
> > @@ -462,7 +423,6 @@ static void init_pmu_power9(void)
> >  static int __init feat_enable_mce_power9(struct dt_cpu_feature *f)
> >  {
> >  	cur_cpu_spec->platform = "power9";
> > -	cur_cpu_spec->flush_tlb = __flush_tlb_power9;
> >  	cur_cpu_spec->machine_check_early = __machine_check_early_realmode_p9;
> > 
> >  	return 1;
> > @@ -750,8 +710,6 @@ static void __init cpufeatures_setup_finished(void)
> >  	system_registers.hfscr = mfspr(SPRN_HFSCR);
> >  	system_registers.fscr = mfspr(SPRN_FSCR);
> > 
> > -	cpufeatures_flush_tlb();
> > -
> >  	pr_info("final cpu/mmu features = 0x%016lx 0x%08x\n",
> >  		cur_cpu_spec->cpu_features, cur_cpu_spec->mmu_features);
> >  }
> > diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
> > index f913139bb0c2..840f5e0e41f9 100644
> > --- a/arch/powerpc/kernel/mce_power.c
> > +++ b/arch/powerpc/kernel/mce_power.c
> > @@ -28,61 +28,6 @@
> >  #include <asm/mce.h>
> >  #include <asm/machdep.h>
> > 
> > -static void flush_tlb_206(unsigned int num_sets, unsigned int action)
> > -{
> > -	unsigned long rb;
> > -	unsigned int i;
> > -
> > -	switch (action) {
> > -	case TLB_INVAL_SCOPE_GLOBAL:
> > -		rb = TLBIEL_INVAL_SET;
> > -		break;
> > -	case TLB_INVAL_SCOPE_LPID:
> > -		rb = TLBIEL_INVAL_SET_LPID;
> > -		break;
> > -	default:
> > -		BUG();
> > -		break;
> > -	}
> > -
> > -	asm volatile("ptesync" : : : "memory");
> > -	for (i = 0; i < num_sets; i++) {
> > -		asm volatile("tlbiel %0" : : "r" (rb));
> > -		rb += 1 << TLBIEL_INVAL_SET_SHIFT;
> > -	}
> > -	asm volatile("ptesync" : : : "memory");
> > -}
> > -
> > -/*
> > - * Generic routines to flush TLB on POWER processors. These routines
> > - * are used as flush_tlb hook in the cpu_spec.
> > - *
> > - * action => TLB_INVAL_SCOPE_GLOBAL:  Invalidate all TLBs.
> > - *	     TLB_INVAL_SCOPE_LPID: Invalidate TLB for current LPID.
> > - */
> > -void __flush_tlb_power7(unsigned int action)
> > -{
> > -	flush_tlb_206(POWER7_TLB_SETS, action);
> > -}
> > -
> > -void __flush_tlb_power8(unsigned int action)
> > -{
> > -	flush_tlb_206(POWER8_TLB_SETS, action);
> > -}
> > -
> > -void __flush_tlb_power9(unsigned int action)
> > -{
> > -	unsigned int num_sets;
> > -
> > -	if (radix_enabled())
> > -		num_sets = POWER9_TLB_SETS_RADIX;
> > -	else
> > -		num_sets = POWER9_TLB_SETS_HASH;
> > -
> > -	flush_tlb_206(num_sets, action);
> > -}
> > -
> > -
> >  /* flush SLBs and reload */
> >  #ifdef CONFIG_PPC_STD_MMU_64
> >  static void flush_and_reload_slb(void)
> > @@ -142,10 +87,8 @@ static int mce_flush(int what)
> >  		return 1;
> >  	}
> >  	if (what == MCE_FLUSH_TLB) {
> > -		if (cur_cpu_spec && cur_cpu_spec->flush_tlb) {
> > -			cur_cpu_spec->flush_tlb(TLB_INVAL_SCOPE_GLOBAL);
> > -			return 1;
> > -		}
> > +		tlbiel_all();
> > +		return 1;
> >  	}
> > 
> >  	return 0;
> > diff --git a/arch/powerpc/kvm/book3s_hv_ras.c b/arch/powerpc/kvm/book3s_hv_ras.c
> > index 7ef0993214f3..9a8bf0e13064 100644
> > --- a/arch/powerpc/kvm/book3s_hv_ras.c
> > +++ b/arch/powerpc/kvm/book3s_hv_ras.c
> > @@ -87,8 +87,7 @@ static long kvmppc_realmode_mc_power7(struct kvm_vcpu *vcpu)
> >  				   DSISR_MC_SLB_PARITY | DSISR_MC_DERAT_MULTI);
> >  		}
> >  		if (dsisr & DSISR_MC_TLB_MULTI) {
> > -			if (cur_cpu_spec && cur_cpu_spec->flush_tlb)
> > -				cur_cpu_spec->flush_tlb(TLB_INVAL_SCOPE_LPID);
> > +			tlbiel_all_lpid(vcpu->kvm->arch.radix);
> >  			dsisr &= ~DSISR_MC_TLB_MULTI;
> >  		}
> >  		/* Any other errors we don't understand? */
> > @@ -105,8 +104,7 @@ static long kvmppc_realmode_mc_power7(struct kvm_vcpu *vcpu)
> >  		reload_slb(vcpu);
> >  		break;
> >  	case SRR1_MC_IFETCH_TLBMULTI:
> > -		if (cur_cpu_spec && cur_cpu_spec->flush_tlb)
> > -			cur_cpu_spec->flush_tlb(TLB_INVAL_SCOPE_LPID);
> > +		tlbiel_all_lpid(vcpu->kvm->arch.radix);
> >  		break;
> >  	default:
> >  		handled = 0;
> > diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
> > index 65bb8f33b399..5e79c04db4fa 100644
> > --- a/arch/powerpc/mm/hash_native_64.c
> > +++ b/arch/powerpc/mm/hash_native_64.c
> > @@ -45,6 +45,88 @@
> > 
> >  DEFINE_RAW_SPINLOCK(native_tlbie_lock);
> > 
> > +static inline void __tlbiel_all_isa206(unsigned int set, unsigned int is)
> > +{
> > +	unsigned long rb;
> > +
> > +	rb = (set << PPC_BITLSHIFT(51)) | (is << PPC_BITLSHIFT(53));
> > +
> > +	asm volatile("tlbiel %0" : : "r" (rb));
> > +}
> > +
> > +static inline void __tlbiel_all_isa300(unsigned int set, unsigned int is,
> > +					unsigned int ric, unsigned int prs)
> > +{
> > +	unsigned int r = 0; /* hash format */
> > +	unsigned long rb;
> > +	unsigned long rs = 0;
> > +
> > +	rb = (set << PPC_BITLSHIFT(51)) | (is << PPC_BITLSHIFT(53));
> > +
> > +	asm volatile(PPC_TLBIEL(%0, %4, %3, %2, %1)
> > +		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
> > +}
> > +
> > +static void tlbiel_all_isa206(unsigned int num_sets, unsigned int is)
> > +{
> > +	unsigned int set;
> > +
> > +	asm volatile("ptesync": : :"memory");
> > +
> > +	for (set = 0; set < num_sets; set++)
> > +		__tlbiel_all_isa206(set, is);
> > +
> > +	asm volatile("ptesync": : :"memory");
> > +}
> > +
> > +static void tlbiel_all_isa300(unsigned int num_sets, unsigned int is)
> > +{
> > +	unsigned int set;
> > +
> > +	asm volatile("ptesync": : :"memory");
> > +
> > +	/*
> > +	 * Flush the first set of the TLB, and any caching of partition table
> > +	 * entries. Then flush the remaining sets of the TLB. Hash mode uses
> > +	 * partition scoped TLB translations.
> > +	 */
> > +	__tlbiel_all_isa300(0, is, 2, 0);
> > +	for (set = 1; set < num_sets; set++)
> > +		__tlbiel_all_isa300(set, is, 0, 0);
> > +
> > +	/* Flush process table entries */
> > +	__tlbiel_all_isa300(0, is, 2, 1);
> > +
> > +	asm volatile("ptesync": : :"memory");
> > +}
> > +
> > +void hash__tlbiel_all(unsigned int action)
> > +{
> > +	unsigned int is;
> > +
> > +	switch (action) {
> > +	case TLB_INVAL_SCOPE_GLOBAL:
> > +		is = 3;
> > +		break;
> > +	case TLB_INVAL_SCOPE_LPID:
> > +		is = 2;
> > +		break;
> > +	default:
> > +		BUG();
> > +	}
> > +
> > +	if (cpu_has_feature(CPU_FTR_ARCH_300))
> > +		tlbiel_all_isa300(POWER9_TLB_SETS_HASH, is);
> > +	else if (cpu_has_feature(CPU_FTR_ARCH_207S))
> > +		tlbiel_all_isa206(POWER8_TLB_SETS, is);
> > +	else if (cpu_has_feature(CPU_FTR_ARCH_206))
> > +		tlbiel_all_isa206(POWER7_TLB_SETS, is);
> > +	else
> > +		WARN(1, "%s called on pre-POWER7 CPU\n", __func__);
> > +
> > +	asm volatile(PPC_INVALIDATE_ERAT "; isync" : : :"memory");
> > +}
> > +
> >  static inline void __tlbie(unsigned long vpn, int psize, int apsize, int ssize)
> >  {
> >  	unsigned long va;
> > diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> > index f2095ce9d4b0..abe3db5ab554 100644
> > --- a/arch/powerpc/mm/hash_utils_64.c
> > +++ b/arch/powerpc/mm/hash_utils_64.c
> > @@ -1044,6 +1044,8 @@ void __init hash__early_init_mmu(void)
> >  	pr_info("Initializing hash mmu with SLB\n");
> >  	/* Initialize SLB management */
> >  	slb_initialize();
> > +
> > +	tlbiel_all();
> >  }
> > 
> >  #ifdef CONFIG_SMP
> > @@ -1063,6 +1065,8 @@ void hash__early_init_mmu_secondary(void)
> >  	}
> >  	/* Initialize SLB */
> >  	slb_initialize();
> > +
> > +	tlbiel_all();
> >  }
> >  #endif /* CONFIG_SMP */
> > 
> > diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
> > index c28165d8970b..a326904ca4e2 100644
> > --- a/arch/powerpc/mm/pgtable-radix.c
> > +++ b/arch/powerpc/mm/pgtable-radix.c
> > @@ -426,6 +426,8 @@ void __init radix__early_init_mmu(void)
> > 
> >  	radix_init_iamr();
> >  	radix_init_pgtable();
> > +
> > +	tlbiel_all();
> >  }
> > 
> >  void radix__early_init_mmu_secondary(void)
> > @@ -447,6 +449,8 @@ void radix__early_init_mmu_secondary(void)
> >  		radix_init_amor();
> >  	}
> >  	radix_init_iamr();
> > +
> > +	tlbiel_all();
> >  }
> > 
> >  void radix__mmu_cleanup_all(void)
> > diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
> > index 02e71402fdd3..63c12c784e25 100644
> > --- a/arch/powerpc/mm/tlb-radix.c
> > +++ b/arch/powerpc/mm/tlb-radix.c
> > @@ -22,6 +22,63 @@
> >  #define RIC_FLUSH_PWC 1
> >  #define RIC_FLUSH_ALL 2
> > 
> > +static inline void __tlbiel_all_isa300(unsigned int set, unsigned int is,
> > +					unsigned int ric, unsigned int prs)
> > +{
> > +	unsigned int r = 1; /* radix format */
> > +	unsigned long rb;
> > +	unsigned long rs = 0;
> > +
> > +	rb = (set << PPC_BITLSHIFT(51)) | (is << PPC_BITLSHIFT(53));
> > +
> > +	asm volatile(PPC_TLBIEL(%0, %4, %3, %2, %1)
> > +		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
> > +}
> > +
> > +static void tlbiel_all_isa300(unsigned int num_sets, unsigned int is)
> > +{
> > +	unsigned int set;
> > +
> > +	asm volatile("ptesync": : :"memory");
> > +
> > +	/*
> > +	 * Flush the first set of the TLB, and the entire Page Walk Cache.
> > +	 * Then flush the remaining sets of the TLB.
> > +	 */
> > +	__tlbiel_all_isa300(0, is, RIC_FLUSH_ALL, 1);
> > +	for (set = 1; set < num_sets; set++)
> > +		__tlbiel_all_isa300(set, is, RIC_FLUSH_TLB, 1);
> > +
> > +	/* Do the same for partitioned scoped entries. */
> > +	__tlbiel_all_isa300(0, is, RIC_FLUSH_ALL, 0);
> > +	for (set = 1; set < num_sets; set++)
> > +		__tlbiel_all_isa300(set, is, RIC_FLUSH_TLB, 0);
> > +
> > +	asm volatile("ptesync": : :"memory");
> > +}
> > +
> > +void radix__tlbiel_all(unsigned int action)
> > +{
> > +	unsigned int is;
> > +
> > +	switch (action) {
> > +	case TLB_INVAL_SCOPE_GLOBAL:
> > +		is = 3;
> > +		break;
> > +	case TLB_INVAL_SCOPE_LPID:
> > +		is = 2;
> > +		break;
> > +	default:
> > +		BUG();
> > +	}
> > +
> > +	if (cpu_has_feature(CPU_FTR_ARCH_300))
> > +		tlbiel_all_isa300(POWER9_TLB_SETS_RADIX, is);
> > +	else
> > +		WARN(1, "%s called on pre-POWER9 CPU\n", __func__);
> > +	asm volatile(PPC_INVALIDATE_ERAT "; isync" : : :"memory");
> > +}
> > +
> >  static inline void __tlbiel_pid(unsigned long pid, int set,
> >  				unsigned long ric)
> >  {
> > -- 
> > 2.11.0
