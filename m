Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9587ADDDD8
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2007 12:50:55 +1000 (EST)
Subject: Re: [PATCH] fixes for the SLB shadow buffer
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <1158.1186106139@neuling.org>
References: <17055.1185944172@neuling.org>
	<18096.6654.934841.561238@cargo.ozlabs.ibm.com>
	<31580.1185948147@neuling.org>
	<1186004885.22717.50.camel@farscape.rchland.ibm.com>
	<24613.1186034191@neuling.org>
	<1186039870.5495.595.camel@localhost.localdomain>
	<13166.1186045008@neuling.org>
	<1186045096.5495.617.camel@localhost.localdomain>
	<17854.1186045405@neuling.org>
	<1186046080.5495.620.camel@localhost.localdomain>
	<30559.1186046895@neuling.org>  <1158.1186106139@neuling.org>
Content-Type: text/plain
Date: Fri, 03 Aug 2007 12:50:42 +1000
Message-Id: <1186109443.5495.652.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-08-03 at 11:55 +1000, Michael Neuling wrote:
> We sometimes change the vmalloc segment in slb_flush_and_rebolt but we
> never updated with slb shadow buffer.  This fixes it.  Thanks to paulus
> for finding this.
> 
> Also added some write barriers to ensure the shadow buffer is always
> valid.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
> Integrated more comments from people.
> 
>  arch/powerpc/kernel/entry_64.S   |    3 +++
>  arch/powerpc/mm/hash_utils_64.c  |    2 +-
>  arch/powerpc/mm/slb.c            |   28 ++++++++++++++++++----------
>  include/asm-powerpc/mmu-hash64.h |    1 +
>  4 files changed, 23 insertions(+), 11 deletions(-)
> 
> Index: linux-2.6-ozlabs/arch/powerpc/kernel/entry_64.S
> ===================================================================
> --- linux-2.6-ozlabs.orig/arch/powerpc/kernel/entry_64.S
> +++ linux-2.6-ozlabs/arch/powerpc/kernel/entry_64.S
> @@ -389,8 +389,11 @@ BEGIN_FTR_SECTION
>  	ld	r9,PACA_SLBSHADOWPTR(r13)
>  	li	r12,0
>  	std	r12,SLBSHADOW_STACKESID(r9) /* Clear ESID */
> +	eieio
>  	std	r7,SLBSHADOW_STACKVSID(r9)  /* Save VSID */
> +	eieio
>  	std	r0,SLBSHADOW_STACKESID(r9)  /* Save ESID */
> +	eieio
>  
>  	slbie	r6
>  	slbie	r6		/* Workaround POWER5 < DD2.1 issue */
> Index: linux-2.6-ozlabs/arch/powerpc/mm/hash_utils_64.c
> ===================================================================
> --- linux-2.6-ozlabs.orig/arch/powerpc/mm/hash_utils_64.c
> +++ linux-2.6-ozlabs/arch/powerpc/mm/hash_utils_64.c
> @@ -759,7 +759,7 @@ int hash_page(unsigned long ea, unsigned
>  		   mmu_psize_defs[mmu_vmalloc_psize].sllp) {
>  		get_paca()->vmalloc_sllp =
>  			mmu_psize_defs[mmu_vmalloc_psize].sllp;
> -		slb_flush_and_rebolt();
> +		slb_vmalloc_update();
>  	}
>  #endif /* CONFIG_PPC_64K_PAGES */
>  
> Index: linux-2.6-ozlabs/arch/powerpc/mm/slb.c
> ===================================================================
> --- linux-2.6-ozlabs.orig/arch/powerpc/mm/slb.c
> +++ linux-2.6-ozlabs/arch/powerpc/mm/slb.c
> @@ -53,7 +53,8 @@ static inline unsigned long mk_vsid_data
>  	return (get_kernel_vsid(ea) << SLB_VSID_SHIFT) | flags;
>  }
>  
> -static inline void slb_shadow_update(unsigned long esid, unsigned long vsid,
> +static inline void slb_shadow_update(unsigned long ea,
> +				     unsigned long flags,
>  				     unsigned long entry)
>  {
>  	/*
> @@ -61,11 +62,11 @@ static inline void slb_shadow_update(uns
>  	 * updating it.
>  	 */
>  	get_slb_shadow()->save_area[entry].esid = 0;
> -	barrier();
> -	get_slb_shadow()->save_area[entry].vsid = vsid;
> -	barrier();
> -	get_slb_shadow()->save_area[entry].esid = esid;
> -
> +	smp_wmb();
> +	get_slb_shadow()->save_area[entry].vsid = mk_vsid_data(ea, flags);
> +	smp_wmb();
> +	get_slb_shadow()->save_area[entry].esid = mk_esid_data(ea, entry);
> +	smp_wmb();
>  }
>  
>  static inline void create_shadowed_slbe(unsigned long ea, unsigned long flags,
> @@ -76,8 +77,7 @@ static inline void create_shadowed_slbe(
>  	 * we don't get a stale entry here if we get preempted by PHYP
>  	 * between these two statements.
>  	 */
> -	slb_shadow_update(mk_esid_data(ea, entry), mk_vsid_data(ea, flags),
> -			  entry);
> +	slb_shadow_update(ea, flags, entry);
>  
>  	asm volatile("slbmte  %0,%1" :
>  		     : "r" (mk_vsid_data(ea, flags)),
> @@ -104,8 +104,7 @@ void slb_flush_and_rebolt(void)
>  		ksp_esid_data &= ~SLB_ESID_V;
>  
>  	/* Only third entry (stack) may change here so only resave that */
> -	slb_shadow_update(ksp_esid_data,
> -			  mk_vsid_data(ksp_esid_data, lflags), 2);
> +	slb_shadow_update(get_paca()->kstack, lflags, 2);
>  
>  	/* We need to do this all in asm, so we're sure we don't touch
>  	 * the stack between the slbia and rebolting it. */
> @@ -123,6 +122,15 @@ void slb_flush_and_rebolt(void)
>  		     : "memory");
>  }
>  
> +void slb_vmalloc_update(void)
> +{
> +	unsigned long vflags;
> +
> +	vflags = SLB_VSID_KERNEL | mmu_psize_defs[mmu_vmalloc_psize].sllp;
> +	slb_shadow_update(VMALLOC_START, vflags, 1);
> +	slb_flush_and_rebolt();
> +}
> +
>  /* Flush all user entries from the segment table of the current processor. */
>  void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
>  {
> Index: linux-2.6-ozlabs/include/asm-powerpc/mmu-hash64.h
> ===================================================================
> --- linux-2.6-ozlabs.orig/include/asm-powerpc/mmu-hash64.h
> +++ linux-2.6-ozlabs/include/asm-powerpc/mmu-hash64.h
> @@ -262,6 +262,7 @@ extern void slb_initialize(void);
>  extern void slb_flush_and_rebolt(void);
>  extern void stab_initialize(unsigned long stab);
>  
> +extern void slb_vmalloc_update(void);
>  #endif /* __ASSEMBLY__ */
>  
>  /*
