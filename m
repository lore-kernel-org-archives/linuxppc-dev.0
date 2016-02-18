Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8D5E21A0467
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 14:32:30 +1100 (AEDT)
Message-ID: <1455766350.22981.15.camel@neuling.org>
Subject: Re: [PATCH 2/2] powerpc: Add POWER9 cputable entry
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 18 Feb 2016 14:32:30 +1100
In-Reply-To: <1455707394.4450.4.camel@ellerman.id.au>
References: <1455685668-30198-1-git-send-email-mikey@neuling.org>
 <1455685668-30198-2-git-send-email-mikey@neuling.org>
 <1455707394.4450.4.camel@ellerman.id.au>
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

On Wed, 2016-02-17 at 22:09 +1100, Michael Ellerman wrote:
> On Wed, 2016-02-17 at 16:07 +1100, Michael Neuling wrote:
>=20
> > Add a cputable entry for POWER9.  More code is required to actually
> > boot and run on a POWER9 but this gets the base piece in which we
> > can
> > start building on.
> >=20
> > Copies over from POWER8 except for:
> > - Adds a new CPU_FTR_ARCH_30 bit to start hanging new architecture
>=20
> ARCH thirty?
>=20
> Would CPU_FTR_ARCH_3 read better?
>=20
> Or CPU_FTR_ARCH_3_00 ?

The actual architecture book used to say 2.07 but now says just 3.0.
Hence why I picked 30 vs 207.

That being said, I don't really care what we call it.

>=20
> > diff --git a/arch/powerpc/include/asm/cputable.h
> > b/arch/powerpc/include/asm/cputable.h
> > index a47e175..7fb238c 100644
> > --- a/arch/powerpc/include/asm/cputable.h
> > +++ b/arch/powerpc/include/asm/cputable.h
> > @@ -171,7 +171,7 @@ enum {
> >  #define CPU_FTR_ARCH_201		LONG_ASM_CONST(0x000000020
> > 0000000)
> >  #define CPU_FTR_ARCH_206		LONG_ASM_CONST(0x000000040
> > 0000000)
> >  #define CPU_FTR_ARCH_207S		LONG_ASM_CONST(0x00000008
> > 00000000)
> > -/* Free					LONG_ASM_CONST(0x00
> > 00001000000000) */
> > +#define CPU_FTR_ARCH_30			LONG_ASM_CONST(0x00
> > 00001000000000)
> >  #define CPU_FTR_MMCRA			LONG_ASM_CONST(0x0000
> > 002000000000)
> >  #define CPU_FTR_CTRL			LONG_ASM_CONST(0x00000
> > 04000000000)
> >  #define CPU_FTR_SMT			LONG_ASM_CONST(0x000000
> > 8000000000)
> > @@ -447,6 +447,16 @@ enum {
> >  	    CPU_FTR_ARCH_207S | CPU_FTR_TM_COMP | CPU_FTR_SUBCORE)
> >  #define CPU_FTRS_POWER8E (CPU_FTRS_POWER8 | CPU_FTR_PMAO_BUG)
> >  #define CPU_FTRS_POWER8_DD1 (CPU_FTRS_POWER8 & ~CPU_FTR_DBELL)
> > +#define CPU_FTRS_POWER9 (CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
> > +	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL |
> > CPU_FTR_ARCH_206 |\
> > +	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
> > +	    CPU_FTR_COHERENT_ICACHE | \
> > +	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
> > +	    CPU_FTR_DSCR | CPU_FTR_SAO  | \
> > +	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB |
> > CPU_FTR_POPCNTD | \
> > +	    CPU_FTR_ICSWX | CPU_FTR_CFAR | CPU_FTR_HVMODE |
> > CPU_FTR_VMX_COPY | \
> > +	    CPU_FTR_DBELL | CPU_FTR_HAS_PPR | CPU_FTR_DAWR | \
> > +	    CPU_FTR_ARCH_207S | CPU_FTR_TM_COMP | CPU_FTR_ARCH_30)
> >  #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
> >  	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
> >  	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
> > @@ -465,7 +475,7 @@ enum {
> >  	    (CPU_FTRS_POWER4 | CPU_FTRS_PPC970 | CPU_FTRS_POWER5 |
> > \
> >  	     CPU_FTRS_POWER6 | CPU_FTRS_POWER7 | CPU_FTRS_POWER8E
> > | \
> >  	     CPU_FTRS_POWER8 | CPU_FTRS_POWER8_DD1 | CPU_FTRS_CELL
> > | \
> > -	     CPU_FTRS_PA6T | CPU_FTR_VSX)
> > +	     CPU_FTRS_PA6T | CPU_FTR_VSX | CPU_FTRS_POWER9)
> >  #endif
>=20
> That's you adding it to CPU_FTRS_POSSIBLE I think.
>=20
> But you forgot to add it to CPU_FTRS_ALWAYS.

OK, thanks, I'll fix

>=20
> > diff --git a/arch/powerpc/include/asm/mmu-hash64.h
> > b/arch/powerpc/include/asm/mmu-hash64.h
> > index 7352d3f..e36dc90 100644
> > --- a/arch/powerpc/include/asm/mmu-hash64.h
> > +++ b/arch/powerpc/include/asm/mmu-hash64.h
> > @@ -114,6 +114,7 @@
> > =20
> >  #define POWER7_TLB_SETS		128	/* # sets in
> > POWER7 TLB */
> >  #define POWER8_TLB_SETS		512	/* # sets in
> > POWER8 TLB */
> > +#define POWER9_TLB_SETS_HASH	256	/* # sets in POWER9
> > TLB Hash mode */
> > =20
> >  #ifndef __ASSEMBLY__
> > =20
> > diff --git a/arch/powerpc/include/asm/mmu.h
> > b/arch/powerpc/include/asm/mmu.h
> > index 3d5abfe..54d4650 100644
> > --- a/arch/powerpc/include/asm/mmu.h
> > +++ b/arch/powerpc/include/asm/mmu.h
> > @@ -97,6 +97,7 @@
> >  #define MMU_FTRS_POWER6		MMU_FTRS_POWER4 |
> > MMU_FTR_LOCKLESS_TLBIE
> >  #define MMU_FTRS_POWER7		MMU_FTRS_POWER4 |
> > MMU_FTR_LOCKLESS_TLBIE
> >  #define MMU_FTRS_POWER8		MMU_FTRS_POWER4 |
> > MMU_FTR_LOCKLESS_TLBIE
> > +#define MMU_FTRS_POWER9		MMU_FTRS_POWER4 |
> > MMU_FTR_LOCKLESS_TLBIE
> >  #define MMU_FTRS_CELL		MMU_FTRS_DEFAULT_HPTE_ARCH_V2
> > | \
> >  				MMU_FTR_CI_LARGE_PAGE
> >  #define MMU_FTRS_PA6T		MMU_FTRS_DEFAULT_HPTE_ARCH_V2
> > | \
> > diff --git a/arch/powerpc/kernel/cpu_setup_power.S
> > b/arch/powerpc/kernel/cpu_setup_power.S
> > index 9c9b741..1785480 100644
> > --- a/arch/powerpc/kernel/cpu_setup_power.S
> > +++ b/arch/powerpc/kernel/cpu_setup_power.S
> > @@ -83,6 +83,43 @@ _GLOBAL(__restore_cpu_power8)
> >  	mtlr	r11
> >  	blr
> > =20
> > +_GLOBAL(__setup_cpu_power9)
> > +	mflr	r11
> > +	bl	__init_FSCR
> > +	bl	__init_PMU
>=20
> You might be better off leaving the PMU alone until we have a P9
> perf implementation?

ok, I'll drop this bit.

>=20
> > +	bl	__init_hvmode_206
> > +	mtlr	r11
> > +	beqlr
> > +	li	r0,0
> > +	mtspr	SPRN_LPID,r0
> > +	mfspr	r3,SPRN_LPCR
> > +	ori	r3, r3, LPCR_PECEDH
> > +	bl	__init_LPCR
> > +	bl	__init_HFSCR
> > +	bl	__init_tlb_power9
> > +	bl	__init_PMU_HV
> > +	mtlr	r11
> > +	blr
> > +
> > +_GLOBAL(__restore_cpu_power9)
> > +	mflr	r11
> > +	bl	__init_FSCR
> > +	bl	__init_PMU
> > +	mfmsr	r3
> > +	rldicl.	r0,r3,4,63
> > +	mtlr	r11
> > +	beqlr
> > +	li	r0,0
> > +	mtspr	SPRN_LPID,r0
> > +	mfspr   r3,SPRN_LPCR
> > +	ori	r3, r3, LPCR_PECEDH
> > +	bl	__init_LPCR
> > +	bl	__init_HFSCR
> > +	bl	__init_tlb_power9
> > +	bl	__init_PMU_HV
> > +	mtlr	r11
> > +	blr
> > +
> >  __init_hvmode_206:
> >  	/* Disable CPU_FTR_HVMODE and exit if MSR:HV is not set */
> >  	mfmsr	r3
> > @@ -160,6 +197,17 @@ __init_tlb_power8:
> >  	ptesync
> >  1:	blr
> > =20
> > +__init_tlb_power9:
> > +	li	r6,256
>=20
> POWER9_TLB_SETS_HASH ?

yep and we need to do that for others here too.

>=20
> > +	mtctr	r6
> > +	li	r7,0xc00	/* IS field =3D 0b11 */
> > +	ptesync
> > +2:	tlbiel	r7
> > +	addi	r7,r7,0x1000
> > +	bdnz	2b
> > +	ptesync
> > +1:	blr
> > +
> >  __init_PMU_HV:
> >  	li	r5,0
> >  	mtspr	SPRN_MMCRC,r5
> > diff --git a/arch/powerpc/kernel/cputable.c
> > b/arch/powerpc/kernel/cputable.c
> > index 7d80bfd..a4e31fa 100644
> > --- a/arch/powerpc/kernel/cputable.c
> > +++ b/arch/powerpc/kernel/cputable.c
> > @@ -70,9 +70,12 @@ extern void __setup_cpu_power7(unsigned long
> > offset, struct cpu_spec* spec);
> >  extern void __restore_cpu_power7(void);
> >  extern void __setup_cpu_power8(unsigned long offset, struct
> > cpu_spec* spec);
> >  extern void __restore_cpu_power8(void);
> > +extern void __setup_cpu_power9(unsigned long offset, struct
> > cpu_spec* spec);
> > +extern void __restore_cpu_power9(void);
> >  extern void __restore_cpu_a2(void);
> >  extern void __flush_tlb_power7(unsigned int action);
> >  extern void __flush_tlb_power8(unsigned int action);
> > +extern void __flush_tlb_power9(unsigned int action);
> >  extern long __machine_check_early_realmode_p7(struct pt_regs
> > *regs);
> >  extern long __machine_check_early_realmode_p8(struct pt_regs
> > *regs);
> >  #endif /* CONFIG_PPC64 */
> > @@ -116,6 +119,19 @@ extern void __restore_cpu_e6500(void);
> >  #define COMMON_USER_PA6T	(COMMON_USER_PPC64 |
> > PPC_FEATURE_PA6T |\
> >  				 PPC_FEATURE_TRUE_LE | \
> >  				 PPC_FEATURE_HAS_ALTIVEC_COMP)
> > +#define COMMON_USER_POWER9	(COMMON_USER_PPC64 |
> > PPC_FEATURE_ARCH_2_06 |\
> > +				 PPC_FEATURE_SMT |
> > PPC_FEATURE_ICACHE_SNOOP | \
> > +				 PPC_FEATURE_TRUE_LE | \
> > +				 PPC_FEATURE_PSERIES_PERFMON_COMPA
> > T)
>=20
> That looks like it's =3D=3D COMMON_USER_POWER8.

Ok, I'll change

>=20
> > +#define COMMON_USER2_POWER9	(PPC_FEATURE2_ARCH_2_07 | \
> > +				 PPC_FEATURE2_HTM_COMP | \
> > +				 PPC_FEATURE2_HTM_NOSC_COMP | \
> > +				 PPC_FEATURE2_DSCR | \
> > +				 PPC_FEATURE2_ISEL |
> > PPC_FEATURE2_TAR | \
> > +				 PPC_FEATURE2_VEC_CRYPTO | \
> > +				 PPC_FEATURE2_ARCH_3_00 | \
> > +				 PPC_FEATURE2_HAS_IEEE128)
>=20
> And this could be COMMON_USER_POWER8 + ARCH_3 + HAS_IEEE128 I think?

OK, I'll change

>=20
> > @@ -499,6 +515,26 @@ static struct cpu_spec __initdata cpu_specs[]
> > =3D {
> >  		.machine_check_early	=3D
> > __machine_check_early_realmode_p8,
> >  		.platform		=3D "power8",
> >  	},
> > +	{	/*  Hacked up Power9 */
>=20
> Still hacked up?

That was a screwup on my part.. I'll remove it.

>=20
> > +		.pvr_mask		=3D 0xffff0000,
> > +		.pvr_value		=3D 0x004e0000,
> > +		.cpu_name		=3D "POWER9 (raw)",
> > +		.cpu_features		=3D CPU_FTRS_POWER9,
> > +		.cpu_user_features	=3D COMMON_USER_POWER9,
> > +		.cpu_user_features2	=3D COMMON_USER2_POWER9,
> > +		.mmu_features		=3D MMU_FTRS_POWER9,
> > +		.icache_bsize		=3D 128,
> > +		.dcache_bsize		=3D 128,
> > +		.num_pmcs		=3D 6,
> > +		.pmc_type		=3D PPC_PMC_IBM,
> > +		.oprofile_cpu_type	=3D "ppc64/power8",
>=20
> Not true. Probably better to rename it to power9 for now, or leave
> all the PMU
> stuff empty.

Ok

>=20
> > +		.oprofile_type		=3D
> > PPC_OPROFILE_INVALID,
> > +		.cpu_setup		=3D __setup_cpu_power9,
> > +		.cpu_restore		=3D
> > __restore_cpu_power9,
> > +		.flush_tlb		=3D __flush_tlb_power9,
> > +		.machine_check_early	=3D
> > __machine_check_early_realmode_p8,
>=20
> If we think that works we should rename it as a separate patch.

ok

>=20
> > +		.platform		=3D "power9",
> > +	},
> >  	{	/* Cell Broadband Engine */
> >  		.pvr_mask		=3D 0xffff0000,
> >  		.pvr_value		=3D 0x00700000,
> > diff --git a/arch/powerpc/kernel/mce_power.c
> > b/arch/powerpc/kernel/mce_power.c
> > index 2c647b1..9131b95 100644
> > --- a/arch/powerpc/kernel/mce_power.c
> > +++ b/arch/powerpc/kernel/mce_power.c
> > @@ -54,7 +54,7 @@ static void flush_tlb_206(unsigned int num_sets,
> > unsigned int action)
> >  }
> > =20
> >  /*
> > - * Generic routine to flush TLB on power7. This routine is used as
> > + * Generic routine to flush TLB on power*. This routine is used as
>=20
> That looks bogus. This is still the version for power7 isn't it?

The comment is repeated for power7 and power8.  I thought it was
pointless to add another identical comment on the power9 version, so I
was trying to consolidate them. =20

I probably need to reword it a bit more though.

>=20
> >   * flush_tlb hook in cpu_spec for Power7 processor.
> >   *
> >   * action =3D> TLB_INVAL_SCOPE_GLOBAL:  Invalidate all TLBs.
> > @@ -65,18 +65,17 @@ void __flush_tlb_power7(unsigned int action)
> >  	flush_tlb_206(POWER7_TLB_SETS, action);
> >  }
> > =20
> > -/*
> > - * Generic routine to flush TLB on power8. This routine is used as
> > - * flush_tlb hook in cpu_spec for power8 processor.
> > - *
> > - * action =3D> TLB_INVAL_SCOPE_GLOBAL:  Invalidate all TLBs.
> > - *	     TLB_INVAL_SCOPE_LPID: Invalidate TLB for current
> > LPID.
> > - */
>=20
> It's a bit verbose but still correct AFAICS.

See above.

>=20
> >  void __flush_tlb_power8(unsigned int action)
> >  {
> >  	flush_tlb_206(POWER8_TLB_SETS, action);
> >  }
> > =20
> > +void __flush_tlb_power9(unsigned int action)
> > +{
> > +	flush_tlb_206(POWER9_TLB_SETS_HASH, action);
> > +}
> > +
> > +
> >  /* flush SLBs and reload */
> >  static void flush_and_reload_slb(void)
> >  {
>=20
> cheers
>=20
