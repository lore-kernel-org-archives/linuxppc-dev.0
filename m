Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id D8994679A6
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Aug 2006 16:01:58 +1000 (EST)
Date: Sat, 5 Aug 2006 00:56:39 -0500
From: Milton Miller <miltonm@bga.com>
To: mikey@neuling.org, paulus@samba.org, linuxppc-dev@ozlabs.org,
Subject: Re: [PATCH] SLB shadow buffer
Message-Id: <111547573996b8b45671.846930886.miltonm@bga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri Aug  4 2006 12:53:19 AM CDT, Michael Neuling wrote:
> This adds a shadow buffer for the SLBs and regsiters it with PHYP.
> Only the bolted SLB entries (first 3) are saved.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> 
> 
> Index: linux-2.6-ozlabs/arch/powerpc/kernel/entry_64.S
> ===================================================================
> --- linux-2.6-ozlabs.orig/arch/powerpc/kernel/entry_64.S
> +++ linux-2.6-ozlabs/arch/powerpc/kernel/entry_64.S
> @@ -323,6 +323,10 @@ _GLOBAL(ret_from_fork)
>   * The code which creates the new task context is in 'copy_thread'
>   * in arch/powerpc/kernel/process.c 
>   */
> +#define SHADOW_SLB_BOLTED_LAST_ESID \
> +		(SLBSHADOW_SAVEAREA + 0x10*(SLB_NUM_BOLTED-1))
> +#define SHADOW_SLB_BOLTED_LAST_VSID \
> +		(SLBSHADOW_SAVEAREA + 0x10*(SLB_NUM_BOLTED-1) + 8)

It's not because it's the last one but that it's the one with the stack.

>  	.align	7
>  _GLOBAL(_switch)
>  	mflr	r0
> @@ -375,6 +379,14 @@ BEGIN_FTR_SECTION
>  	ld	r7,KSP_VSID(r4)	/* Get new stack's VSID */
>  	oris	r0,r6,(SLB_ESID_V)@h
>  	ori	r0,r0,(SLB_NUM_BOLTED-1)@l
> +
> +	/* Update the last bolted SLB */
> +	ld	r9,PACA_SLBSHADOWPTR(r13)
> + 	li	r12,0
> +  	std     r12,SHADOW_SLB_BOLTED_LAST_ESID(r9) /* Clear ESID */
> +	std     r7,SHADOW_SLB_BOLTED_LAST_VSID(r9)  /* Save VSID */
> + 	std     r0,SHADOW_SLB_BOLTED_LAST_ESID(r9)  /* Save ESID */
> +

Tabs not spaces please

>  	slbie	r6
>  	slbie	r6		/* Workaround POWER5 < DD2.1 issue */
>  	slbmte	r7,r0
> Index: linux-2.6-ozlabs/arch/powerpc/kernel/paca.c
> ===================================================================
> --- linux-2.6-ozlabs.orig/arch/powerpc/kernel/paca.c
> +++ linux-2.6-ozlabs/arch/powerpc/kernel/paca.c
> @@ -17,6 +17,7 @@
>  #include <asm/lppaca.h>
>  #include <asm/iseries/it_lp_reg_save.h>
>  #include <asm/paca.h>
> +#include <asm/mmu.h>
>  
>  
>  /* This symbol is provided by the linker - let it fill in the paca
> @@ -45,6 +46,17 @@ struct lppaca lppaca[] = {
>  	},
>  };
>  
> +/*
> + * 3 persistent SLBs are registered here.  The buffer will be zero
> + * initially, hence will all be invaild until we actually write them.
> + */
> +struct slb_shadow_buffer slb_shadow_buffer[] = {
> +	[0 ... (NR_CPUS-1)] = {
> +		.persistent = SLB_NUM_BOLTED,
> +		.buffer_length = sizeof(struct slb_shadow_buffer),
> +	},
> +};

How about making this per-cpu and setting the paca pointer at runtime?
It would save NR_CPUS-1 cachelines of data.   Otherwise, put  in
cacheline_aligned will potentially save some space.

> +
>  /* The Paca is an array with one entry per processor.  Each contains an
>   * lppaca, which contains the information shared between the
>   * hypervisor and Linux.
> @@ -59,7 +71,8 @@ struct lppaca lppaca[] = {
>  	.lock_token = 0x8000,						    \
>  	.paca_index = (number),		/* Paca Index */		    \
>  	.kernel_toc = (unsigned long)(&__toc_start) + 0x8000UL,		    \
> -	.hw_cpu_id = 0xffff,
> +	.hw_cpu_id = 0xffff,						    \
> +	.slb_shadow_buffer_ptr = &slb_shadow_buffer[number]

Trailing , (yeah, still have to add the \ )

>  
>  #ifdef CONFIG_PPC_ISERIES
>  #define PACA_INIT_ISERIES(number)					    \
> Index: linux-2.6-ozlabs/arch/powerpc/mm/slb.c
> ===================================================================
> --- linux-2.6-ozlabs.orig/arch/powerpc/mm/slb.c
> +++ linux-2.6-ozlabs/arch/powerpc/mm/slb.c
> @@ -22,6 +22,8 @@
>  #include <asm/paca.h>
>  #include <asm/cputable.h>
>  #include <asm/cacheflush.h>
> +#include <asm/smp.h>
> +#include <linux/compiler.h>
>  
>  #ifdef DEBUG
>  #define DBG(fmt...) udbg_printf(fmt)
> @@ -50,9 +52,29 @@ static inline unsigned long mk_vsid_data
>  	return (get_kernel_vsid(ea) << SLB_VSID_SHIFT) | flags;
>  }
>  
> +static inline void slb_shadow_update(unsigned long esid, unsigned long vsid,
> +				     unsigned long entry)
> +{
> +	/* Clear the ESID first so the entry is not valid while we are
> +	 * updating it.  Then write the VSID before the real ESID. */

Multi-line comments get the  */ on it's own line

> +	get_slb_shadow_buffer()->save_area[2*entry] = 0;
> +	barrier();
> +	get_slb_shadow_buffer()->save_area[2*entry+1] =	vsid;
> +	barrier();
> +	get_slb_shadow_buffer()->save_area[2*entry] = esid;
> +
> +}

This 2* seems magic.  How about an array of structs?

> +
>  static inline void create_slbe(unsigned long ea, unsigned long flags,
>  			       unsigned long entry)

Should we rename to create_shadowed_slbe?

>  {
> +	/* Updating the shadow buffer before writing the SLB ensures
> +	 * we don't get a stale entry here if we get preempted by PHYP
> +	 * between these two statements. */

own line

> +	slb_shadow_update(mk_esid_data(ea, entry),
> +			  mk_vsid_data(ea, flags),
> +			  entry);

Do we need the third line?

> +
>  	asm volatile("slbmte  %0,%1" :
>  		     : "r" (mk_vsid_data(ea, flags)),
>  		       "r" (mk_esid_data(ea, entry))

Hopefully the compiler only calculates these once.

> @@ -77,6 +99,11 @@ void slb_flush_and_rebolt(void)
>  	if ((ksp_esid_data & ESID_MASK) == PAGE_OFFSET)
>  		ksp_esid_data &= ~SLB_ESID_V;
>  
> +	/* Only second entry may change here so only resave that */
> +	slb_shadow_update(ksp_esid_data,
> +			  mk_vsid_data(ksp_esid_data, lflags),
> +			  2);
> +

1) it's the third entry 2) it's the stack slot

>  	/* We need to do this all in asm, so we're sure we don't touch
>  	 * the stack between the slbia and rebolting it. */

own line

>  	asm volatile("isync\n"
> Index: linux-2.6-ozlabs/arch/powerpc/platforms/pseries/lpar.c
> ===================================================================
> --- linux-2.6-ozlabs.orig/arch/powerpc/platforms/pseries/lpar.c
> +++ linux-2.6-ozlabs/arch/powerpc/platforms/pseries/lpar.c
> @@ -254,18 +254,32 @@ out:
>  void vpa_init(int cpu)
>  {
>  	int hwcpu = get_hard_smp_processor_id(cpu);
> -	unsigned long vpa = __pa(&lppaca[cpu]);
> +	unsigned long vpa;

This is used for something  other than vpa, rename.

>  	long ret;
>  
>  	if (cpu_has_feature(CPU_FTR_ALTIVEC))
>  		lppaca[cpu].vmxregs_in_use = 1;
>  
> +	vpa = __pa(&lppaca[cpu]);
>  	ret = register_vpa(hwcpu, vpa);
>  
> -	if (ret)
> +	if (ret) {
>  		printk(KERN_ERR "WARNING: vpa_init: VPA registration for "
>  				"cpu %d (hw %d) of area %lx returns %ld\n",
>  				cpu, hwcpu, vpa, ret);
> +		return;
> +	}
> +	/* PAPR says this feature is SLB-Buffer but firmware never
> +	 * reports that.  All SPLPAR support SLB shadow buffer. */

own line

> +	vpa = __pa(&slb_shadow_buffer[cpu]);
> +	if (firmware_has_feature(FW_FEATURE_SPLPAR)) {
> +		ret = register_slb_shadow(hwcpu, vpa);
> +		if (ret)
> +			printk(KERN_ERR
> +			       "WARNING: vpa_init: SLB shadow buffer "
> +			       "registration for cpu %d (hw %d) of area %lx "
> +			       "returns %ld\n", cpu, hwcpu, vpa, ret);
> +	}
>  }
>  
>  long pSeries_lpar_hpte_insert(unsigned long hpte_group,
...
> Index: linux-2.6-ozlabs/arch/powerpc/platforms/pseries/setup.c
> ===================================================================
> --- linux-2.6-ozlabs.orig/arch/powerpc/platforms/pseries/setup.c
> +++ linux-2.6-ozlabs/arch/powerpc/platforms/pseries/setup.c
> @@ -234,8 +234,16 @@ static void pseries_kexec_cpu_down_xics(
>  {
>  	/* Don't risk a hypervisor call if we're crashing */
>  	if (firmware_has_feature(FW_FEATURE_SPLPAR) && !crash_shutdown) {
> -		unsigned long vpa = __pa(get_lppaca());
> +		unsigned long vpa;

Rename.

>  
> +		vpa = __pa(get_slb_shadow_buffer());
> +		if (unregister_slb_shadow(hard_smp_processor_id(), vpa))
> +			printk("SLB shadow buffer deregistration of "
> +			       "cpu %u (hw_cpu_id %d) failed\n",
> +			       smp_processor_id(),
> +			       hard_smp_processor_id());
> +
> +		vpa = __pa(get_lppaca());
>  		if (unregister_vpa(hard_smp_processor_id(), vpa)) {
>  			printk("VPA deregistration of cpu %u (hw_cpu_id %d) "
>  					"failed\n", smp_processor_id(),


Side comment: this seems like it should be in pseeries/lpar.c, that would
be a seperate cleanup.

> Index: linux-2.6-ozlabs/include/asm-powerpc/lppaca.h
> ===================================================================
> --- linux-2.6-ozlabs.orig/include/asm-powerpc/lppaca.h
> +++ linux-2.6-ozlabs/include/asm-powerpc/lppaca.h
> @@ -28,6 +28,7 @@
>  //
>  //----------------------------------------------------------------------------
>  #include <asm/types.h>
> +#include <asm/mmu.h>
>  
>  /* The Hypervisor barfs if the lppaca crosses a page boundary.  A 1k
>   * alignment is sufficient to prevent this */
> @@ -133,5 +134,19 @@ struct lppaca {
>  
>  extern struct lppaca lppaca[];
>  
> +/* SLB shadow buffer structure as defined in the PAPR.  The save_area
> + * contains adjacent ESID and VSID pairs for each shadowed SLB.  The
> + * ESID is stored in the lower 64bits, then the VSID.  NOTE: This
> + * structure is 0x40 bytes long (with 3 bolted SLBs), but PHYP
> + * complaints if we're not 0x80 (cache line?) aligned.  */

Own line

Less explaination needed with array of structs.

> +struct slb_shadow_buffer {
> +	u32	persistent;		// Number of persistent SLBs	x00-x03
> +	u32	buffer_length;		// Total shadow buffer length	x04-x07
> +	u64	reserved;		// Alignment			x08-x0f
> +	u64     save_area[SLB_NUM_BOLTED * 2];	//			x10-x40
> +} __attribute__((__aligned__(0x80)));
> +
> +extern struct slb_shadow_buffer slb_shadow_buffer[];
> +

Remove buffer from these names? They seem quite long for linux.
 
>  #endif /* __KERNEL__ */
>  #endif /* _ASM_POWERPC_LPPACA_H */
> Index: linux-2.6-ozlabs/include/asm-powerpc/paca.h
> ===================================================================
> --- linux-2.6-ozlabs.orig/include/asm-powerpc/paca.h
> +++ linux-2.6-ozlabs/include/asm-powerpc/paca.h
> @@ -23,6 +23,7 @@
>  register struct paca_struct *local_paca asm("r13");
>  #define get_paca()	local_paca
>  #define get_lppaca()	(get_paca()->lppaca_ptr)
> +#define get_slb_shadow_buffer()	(get_paca()->slb_shadow_buffer_ptr)
>  
>  struct task_struct;
>  
> @@ -98,6 +99,9 @@ struct paca_struct {
>  	u64 user_time;			/* accumulated usermode TB ticks */
>  	u64 system_time;		/* accumulated system TB ticks */
>  	u64 startpurr;			/* PURR/TB value snapshot */
> +
> +	/* Pointer to SLB shadow buffer */
> +	struct slb_shadow_buffer *slb_shadow_buffer_ptr;
>  };

With the long name the comment doesn't add much.

>  
>  extern struct paca_struct paca[];
> 
