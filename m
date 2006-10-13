Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id A81FA67C46
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Oct 2006 02:55:45 +1000 (EST)
Date: Fri, 13 Oct 2006 11:54:57 -0500
From: Olof Johansson <olof@lixom.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/5] powerpc: consolidate feature fixup code
Message-ID: <20061013115457.7b36a7c3@localhost.localdomain>
In-Reply-To: <1160726663.4792.222.camel@localhost.localdomain>
References: <1160726663.4792.222.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 13 Oct 2006 18:04:22 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> There are currently two versions of the functions for applying the
> feature fixups, one for CPU features and one for firmware features. In
> addition, they are both in assembly and with separate implementations
> for 32 and 64 bits. identify_cpu() is also implemented in assembly and
> separately for 32 and 64 bits.
> 
> This patch replaces them with a pair of C functions. The call sites are
> slightly moved on ppc64 as well to be called from C instead of from
> assembly, though it's a very small change, and thus shouldn't cause any
> problem.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> 
> Index: linux-cell/arch/powerpc/kernel/head_64.S
> ===================================================================
> --- linux-cell.orig/arch/powerpc/kernel/head_64.S	2006-10-13 16:04:10.000000000 +1000
> +++ linux-cell/arch/powerpc/kernel/head_64.S	2006-10-13 16:43:05.000000000 +1000
> @@ -1580,11 +1580,6 @@ _STATIC(__start_initialization_iSeries)
>  	li	r0,0
>  	stdu	r0,-STACK_FRAME_OVERHEAD(r1)
>  
> -	LOAD_REG_IMMEDIATE(r3,cpu_specs)
> -	LOAD_REG_IMMEDIATE(r4,cur_cpu_spec)
> -	li	r5,0
> -	bl	.identify_cpu
> -
>  	LOAD_REG_IMMEDIATE(r2,__toc_start)
>  	addi	r2,r2,0x4000
>  	addi	r2,r2,0x4000
> @@ -1964,13 +1959,6 @@ _STATIC(start_here_multiplatform)
>  	addi	r2,r2,0x4000
>  	add	r2,r2,r26
>  
> -	LOAD_REG_IMMEDIATE(r3, cpu_specs)
> -	add	r3,r3,r26
> -	LOAD_REG_IMMEDIATE(r4,cur_cpu_spec)
> -	add	r4,r4,r26
> -	mr	r5,r26
> -	bl	.identify_cpu
> -
>  	/* Do very early kernel initializations, including initial hash table,
>  	 * stab and slb setup before we turn on relocation.	*/
>  
> @@ -2000,13 +1988,6 @@ _STATIC(start_here_common)
>  	li	r0,0
>  	stdu	r0,-STACK_FRAME_OVERHEAD(r1)
>  
> -	/* Apply the CPUs-specific fixups (nop out sections not relevant
> -	 * to this CPU
> -	 */
> -	li	r3,0
> -	bl	.do_cpu_ftr_fixups
> -	bl	.do_fw_ftr_fixups
> -
>  	/* ptr to current */
>  	LOAD_REG_IMMEDIATE(r4, init_task)
>  	std	r4,PACACURRENT(r13)
> Index: linux-cell/arch/powerpc/kernel/misc_64.S
> ===================================================================
> --- linux-cell.orig/arch/powerpc/kernel/misc_64.S	2006-10-13 16:04:10.000000000 +1000
> +++ linux-cell/arch/powerpc/kernel/misc_64.S	2006-10-13 16:40:14.000000000 +1000
> @@ -246,130 +246,6 @@ _GLOBAL(__flush_dcache_icache)
>  	isync
>  	blr
>  
> -/*
> - * identify_cpu and calls setup_cpu
> - * In:	r3 = base of the cpu_specs array
> - *	r4 = address of cur_cpu_spec
> - *	r5 = relocation offset
> - */
> -_GLOBAL(identify_cpu)
> -	mfpvr	r7
> -1:
> -	lwz	r8,CPU_SPEC_PVR_MASK(r3)
> -	and	r8,r8,r7
> -	lwz	r9,CPU_SPEC_PVR_VALUE(r3)
> -	cmplw	0,r9,r8
> -	beq	1f
> -	addi	r3,r3,CPU_SPEC_ENTRY_SIZE
> -	b	1b
> -1:
> -	sub	r0,r3,r5
> -	std	r0,0(r4)
> -	ld	r4,CPU_SPEC_SETUP(r3)
> -	cmpdi	0,r4,0
> -	add	r4,r4,r5
> -	beqlr
> -	ld	r4,0(r4)
> -	add	r4,r4,r5
> -	mtctr	r4
> -	/* Calling convention for cpu setup is r3=offset, r4=cur_cpu_spec */
> -	mr	r4,r3
> -	mr	r3,r5
> -	bctr
> -
> -/*
> - * do_cpu_ftr_fixups - goes through the list of CPU feature fixups
> - * and writes nop's over sections of code that don't apply for this cpu.
> - * r3 = data offset (not changed)
> - */
> -_GLOBAL(do_cpu_ftr_fixups)
> -	/* Get CPU 0 features */
> -	LOAD_REG_IMMEDIATE(r6,cur_cpu_spec)
> -	sub	r6,r6,r3
> -	ld	r4,0(r6)
> -	sub	r4,r4,r3
> -	ld	r4,CPU_SPEC_FEATURES(r4)
> -	/* Get the fixup table */
> -	LOAD_REG_IMMEDIATE(r6,__start___ftr_fixup)
> -	sub	r6,r6,r3
> -	LOAD_REG_IMMEDIATE(r7,__stop___ftr_fixup)
> -	sub	r7,r7,r3
> -	/* Do the fixup */
> -1:	cmpld	r6,r7
> -	bgelr
> -	addi	r6,r6,32
> -	ld	r8,-32(r6)	/* mask */
> -	and	r8,r8,r4
> -	ld	r9,-24(r6)	/* value */
> -	cmpld	r8,r9
> -	beq	1b
> -	ld	r8,-16(r6)	/* section begin */
> -	ld	r9,-8(r6)	/* section end */
> -	subf.	r9,r8,r9
> -	beq	1b
> -	/* write nops over the section of code */
> -	/* todo: if large section, add a branch at the start of it */
> -	srwi	r9,r9,2
> -	mtctr	r9
> -	sub	r8,r8,r3
> -	lis	r0,0x60000000@h	/* nop */
> -3:	stw	r0,0(r8)
> -	andi.	r10,r4,CPU_FTR_SPLIT_ID_CACHE@l
> -	beq	2f
> -	dcbst	0,r8		/* suboptimal, but simpler */
> -	sync
> -	icbi	0,r8
> -2:	addi	r8,r8,4
> -	bdnz	3b
> -	sync			/* additional sync needed on g4 */
> -	isync
> -	b	1b
> -
> -/*
> - * do_fw_ftr_fixups - goes through the list of firmware feature fixups
> - * and writes nop's over sections of code that don't apply for this firmware.
> - * r3 = data offset (not changed)
> - */
> -_GLOBAL(do_fw_ftr_fixups)
> -	/* Get firmware features */
> -	LOAD_REG_IMMEDIATE(r6,powerpc_firmware_features)
> -	sub	r6,r6,r3
> -	ld	r4,0(r6)
> -	/* Get the fixup table */
> -	LOAD_REG_IMMEDIATE(r6,__start___fw_ftr_fixup)
> -	sub	r6,r6,r3
> -	LOAD_REG_IMMEDIATE(r7,__stop___fw_ftr_fixup)
> -	sub	r7,r7,r3
> -	/* Do the fixup */
> -1:	cmpld	r6,r7
> -	bgelr
> -	addi	r6,r6,32
> -	ld	r8,-32(r6)	/* mask */
> -	and	r8,r8,r4
> -	ld	r9,-24(r6)	/* value */
> -	cmpld	r8,r9
> -	beq	1b
> -	ld	r8,-16(r6)	/* section begin */
> -	ld	r9,-8(r6)	/* section end */
> -	subf.	r9,r8,r9
> -	beq	1b
> -	/* write nops over the section of code */
> -	/* todo: if large section, add a branch at the start of it */
> -	srwi	r9,r9,2
> -	mtctr	r9
> -	sub	r8,r8,r3
> -	lis	r0,0x60000000@h	/* nop */
> -3:	stw	r0,0(r8)
> -BEGIN_FTR_SECTION
> -	dcbst	0,r8		/* suboptimal, but simpler */
> -	sync
> -	icbi	0,r8
> -END_FTR_SECTION_IFSET(CPU_FTR_SPLIT_ID_CACHE)
> -	addi	r8,r8,4
> -	bdnz	3b
> -	sync			/* additional sync needed on g4 */
> -	isync
> -	b	1b
>  
>  #if defined(CONFIG_PPC_PMAC) || defined(CONFIG_PPC_MAPLE)
>  /*
> Index: linux-cell/arch/powerpc/kernel/setup-common.c
> ===================================================================
> --- linux-cell.orig/arch/powerpc/kernel/setup-common.c	2006-10-13 16:04:10.000000000 +1000
> +++ linux-cell/arch/powerpc/kernel/setup-common.c	2006-10-13 16:39:03.000000000 +1000
> @@ -520,3 +520,39 @@ void __init setup_panic(void)
>  {
>  	atomic_notifier_chain_register(&panic_notifier_list, &ppc_panic_block);
>  }
> +
> +void do_feature_fixups(unsigned long offset, unsigned long value,
> +		       void *fixup_start, void *fixup_end)
> +{
> +	struct fixup_entry {
> +		unsigned long	mask;
> +		unsigned long	value;
> +		unsigned int	*start;
> +		unsigned int	*end;
> +	} *fcur, *fend;
> +
> +	fcur = fixup_start;
> +	fend = fixup_end;
> +
> +	for (; fcur < fend; fcur++) {
> +		unsigned int *pstart, *pend, *p;
> +
> +		if ((value & fcur->mask) == fcur->value)
> +			continue;
> +
> +		/* These PTRRELOCs will disappear once the new scheme for
> +		 * modules and vdso is implemented
> +		 */
> +		pstart = PTRRELOC(fcur->start);
> +		pend = PTRRELOC(fcur->end);
> +
> +		for (p = pstart; p < pend; p++) {
> +			*p = 0x60000000u;
> +			asm volatile ("dcbst 0, %0" : : "r" (p));
> +		}
> +		asm volatile ("sync" : : : "memory");
> +		for (p = pstart; p < pend; p++)
> +			asm volatile ("icbi 0,%0" : : "r" (p));
> +		asm volatile ("sync; isync" : : : "memory");

You can advance the pointer with L1_CACHE_BYTES/sizeof(int) per
iteration in the second loop here.

> +	}
> +}
> Index: linux-cell/arch/powerpc/kernel/setup.h
> ===================================================================
> --- linux-cell.orig/arch/powerpc/kernel/setup.h	2006-10-13 16:04:10.000000000 +1000
> +++ linux-cell/arch/powerpc/kernel/setup.h	2006-10-13 16:06:24.000000000 +1000
> @@ -1,9 +1,12 @@
>  #ifndef _POWERPC_KERNEL_SETUP_H
>  #define _POWERPC_KERNEL_SETUP_H
>  
> -void check_for_initrd(void);
> -void do_init_bootmem(void);
> -void setup_panic(void);
> +extern void check_for_initrd(void);
> +extern void do_init_bootmem(void);
> +extern void setup_panic(void);
> +extern void do_feature_fixups(unsigned long offset, unsigned long value,
> +			      void *fixup_start, void *fixup_end);
> +
>  extern int do_early_xmon;
>  
>  #endif /* _POWERPC_KERNEL_SETUP_H */
> Index: linux-cell/arch/powerpc/kernel/setup_32.c
> ===================================================================
> --- linux-cell.orig/arch/powerpc/kernel/setup_32.c	2006-10-13 16:04:10.000000000 +1000
> +++ linux-cell/arch/powerpc/kernel/setup_32.c	2006-10-13 16:38:21.000000000 +1000
> @@ -90,7 +90,9 @@ int ucache_bsize;
>   */
>  unsigned long __init early_init(unsigned long dt_ptr)
>  {
> +	extern unsigned int __start___ftr_fixup, __stop___ftr_fixup;
>  	unsigned long offset = reloc_offset();
> +	struct cpu_spec *spec;
>  
>  	/* First zero the BSS -- use memset_io, some platforms don't have
>  	 * caches on yet */
> @@ -100,8 +102,11 @@ unsigned long __init early_init(unsigned
>  	 * Identify the CPU type and fix up code sections
>  	 * that depend on which cpu we have.
>  	 */
> -	identify_cpu(offset, 0);
> -	do_cpu_ftr_fixups(offset);
> +	spec = identify_cpu(offset);
> +
> +	do_feature_fixups(offset, spec->cpu_features,
> +			  PTRRELOC(&__start___ftr_fixup),
> +			  PTRRELOC(&__stop___ftr_fixup));
>  
>  	return KERNELBASE + offset;
>  }
> Index: linux-cell/arch/powerpc/kernel/setup_64.c
> ===================================================================
> --- linux-cell.orig/arch/powerpc/kernel/setup_64.c	2006-10-13 16:04:10.000000000 +1000
> +++ linux-cell/arch/powerpc/kernel/setup_64.c	2006-10-13 16:42:44.000000000 +1000
> @@ -170,6 +170,9 @@ void __init setup_paca(int cpu)
>  
>  void __init early_setup(unsigned long dt_ptr)
>  {
> +	/* Identify CPU type */
> +	identify_cpu(0);
> +
>  	/* Assume we're on cpu 0 for now. Don't write to the paca yet! */
>  	setup_paca(0);
>  
> @@ -346,8 +349,19 @@ static void __init initialize_cache_info
>   */
>  void __init setup_system(void)
>  {
> +	extern unsigned int __start___ftr_fixup, __stop___ftr_fixup;
> +	extern unsigned int __start___fw_ftr_fixup, __stop___fw_ftr_fixup;
> +
>  	DBG(" -> setup_system()\n");
>  
> +	/* Apply the CPUs-specific and firmware specific fixups to kernel
> +	 * text (nop out sections not relevant to this CPU or this firmware)
> +	 */
> +	do_feature_fixups(0, cur_cpu_spec->cpu_features,
> +			  &__start___ftr_fixup, &__stop___ftr_fixup);
> +	do_feature_fixups(0, powerpc_firmware_features,
> +			  &__start___fw_ftr_fixup, &__stop___fw_ftr_fixup);
> +
>  	/*
>  	 * Unflatten the device-tree passed by prom_init or kexec
>  	 */
> Index: linux-cell/arch/powerpc/kernel/cputable.c
> ===================================================================
> --- linux-cell.orig/arch/powerpc/kernel/cputable.c	2006-10-06 13:47:54.000000000 +1000
> +++ linux-cell/arch/powerpc/kernel/cputable.c	2006-10-13 16:47:31.000000000 +1000
> @@ -73,7 +73,7 @@ extern void __restore_cpu_ppc970(void);
>  #define PPC_FEATURE_SPE_COMP	0
>  #endif
>  
> -struct cpu_spec	cpu_specs[] = {
> +static struct cpu_spec cpu_specs[] = {
>  #ifdef CONFIG_PPC64
>  	{	/* Power3 */
>  		.pvr_mask		= 0xffff0000,
> @@ -1152,3 +1152,25 @@ struct cpu_spec	cpu_specs[] = {
>  #endif /* !CLASSIC_PPC */
>  #endif /* CONFIG_PPC32 */
>  };
> +
> +struct cpu_spec *identify_cpu(unsigned long offset)
> +{
> +	struct cpu_spec *s = cpu_specs;
> +	struct cpu_spec **cur = &cur_cpu_spec;
> +	unsigned int pvr = mfspr(SPRN_PVR);
> +	int i;
> +
> +	s = PTRRELOC(s);
> +	cur = PTRRELOC(cur);
> +
> +	if (*cur != NULL)
> +		return PTRRELOC(*cur);
> +
> +	for (i = 0; i < ARRAY_SIZE(cpu_specs); i++,s++)
> +		if ((pvr & s->pvr_mask) == s->pvr_value) {
> +			*cur = cpu_specs + i;
> +			return s;
> +		}
> +	BUG();
> +	return NULL;
> +}
> Index: linux-cell/arch/powerpc/kernel/misc_32.S
> ===================================================================
> --- linux-cell.orig/arch/powerpc/kernel/misc_32.S	2006-10-06 13:47:54.000000000 +1000
> +++ linux-cell/arch/powerpc/kernel/misc_32.S	2006-10-13 16:26:43.000000000 +1000
> @@ -102,80 +102,6 @@ _GLOBAL(reloc_got2)
>  	blr
>  
>  /*
> - * identify_cpu,
> - * called with r3 = data offset and r4 = CPU number
> - * doesn't change r3
> - */
> -_GLOBAL(identify_cpu)
> -	addis	r8,r3,cpu_specs@ha
> -	addi	r8,r8,cpu_specs@l
> -	mfpvr	r7
> -1:
> -	lwz	r5,CPU_SPEC_PVR_MASK(r8)
> -	and	r5,r5,r7
> -	lwz	r6,CPU_SPEC_PVR_VALUE(r8)
> -	cmplw	0,r6,r5
> -	beq	1f
> -	addi	r8,r8,CPU_SPEC_ENTRY_SIZE
> -	b	1b
> -1:
> -	addis	r6,r3,cur_cpu_spec@ha
> -	addi	r6,r6,cur_cpu_spec@l
> -	sub	r8,r8,r3
> -	stw	r8,0(r6)
> -	blr
> -
> -/*
> - * do_cpu_ftr_fixups - goes through the list of CPU feature fixups
> - * and writes nop's over sections of code that don't apply for this cpu.
> - * r3 = data offset (not changed)
> - */
> -_GLOBAL(do_cpu_ftr_fixups)
> -	/* Get CPU 0 features */
> -	addis	r6,r3,cur_cpu_spec@ha
> -	addi	r6,r6,cur_cpu_spec@l
> -	lwz	r4,0(r6)
> -	add	r4,r4,r3
> -	lwz	r4,CPU_SPEC_FEATURES(r4)
> -
> -	/* Get the fixup table */
> -	addis	r6,r3,__start___ftr_fixup@ha
> -	addi	r6,r6,__start___ftr_fixup@l
> -	addis	r7,r3,__stop___ftr_fixup@ha
> -	addi	r7,r7,__stop___ftr_fixup@l
> -
> -	/* Do the fixup */
> -1:	cmplw	0,r6,r7
> -	bgelr
> -	addi	r6,r6,16
> -	lwz	r8,-16(r6)	/* mask */
> -	and	r8,r8,r4
> -	lwz	r9,-12(r6)	/* value */
> -	cmplw	0,r8,r9
> -	beq	1b
> -	lwz	r8,-8(r6)	/* section begin */
> -	lwz	r9,-4(r6)	/* section end */
> -	subf.	r9,r8,r9
> -	beq	1b
> -	/* write nops over the section of code */
> -	/* todo: if large section, add a branch at the start of it */
> -	srwi	r9,r9,2
> -	mtctr	r9
> -	add	r8,r8,r3
> -	lis	r0,0x60000000@h	/* nop */
> -3:	stw	r0,0(r8)
> -	andi.	r10,r4,CPU_FTR_SPLIT_ID_CACHE@l
> -	beq	2f
> -	dcbst	0,r8		/* suboptimal, but simpler */
> -	sync
> -	icbi	0,r8
> -2:	addi	r8,r8,4
> -	bdnz	3b
> -	sync			/* additional sync needed on g4 */
> -	isync
> -	b	1b
> -
> -/*
>   * call_setup_cpu - call the setup_cpu function for this cpu
>   * r3 = data offset, r24 = cpu number
>   *
> Index: linux-cell/include/asm-powerpc/cputable.h
> ===================================================================
> --- linux-cell.orig/include/asm-powerpc/cputable.h	2006-10-13 16:00:28.000000000 +1000
> +++ linux-cell/include/asm-powerpc/cputable.h	2006-10-13 16:19:51.000000000 +1000
> @@ -89,8 +89,7 @@ struct cpu_spec {
>  
>  extern struct cpu_spec		*cur_cpu_spec;
>  
> -extern void identify_cpu(unsigned long offset, unsigned long cpu);
> -extern void do_cpu_ftr_fixups(unsigned long offset);
> +extern struct cpu_spec *identify_cpu(unsigned long offset);
>  
>  #endif /* __ASSEMBLY__ */
>  
> Index: linux-cell/include/asm-powerpc/system.h
> ===================================================================
> --- linux-cell.orig/include/asm-powerpc/system.h	2006-10-06 13:48:24.000000000 +1000
> +++ linux-cell/include/asm-powerpc/system.h	2006-10-13 16:24:45.000000000 +1000
> @@ -378,7 +378,11 @@ extern unsigned long reloc_offset(void);
>  extern unsigned long add_reloc_offset(unsigned long);
>  extern void reloc_got2(unsigned long);
>  
> +#ifdef CONFIG_PPC64
> +#define PTRRELOC(x)	x
> +#else
>  #define PTRRELOC(x)	((typeof(x)) add_reloc_offset((unsigned long)(x)))
> +#endif
>  
>  static inline void create_instruction(unsigned long addr, unsigned int instr)
>  {
> Index: linux-cell/arch/powerpc/platforms/iseries/setup.c
> ===================================================================
> --- linux-cell.orig/arch/powerpc/platforms/iseries/setup.c	2006-10-06 13:47:54.000000000 +1000
> +++ linux-cell/arch/powerpc/platforms/iseries/setup.c	2006-10-13 16:49:14.000000000 +1000
> @@ -694,6 +694,11 @@ void * __init iSeries_early_setup(void)
>  {
>  	unsigned long phys_mem_size;
>  
> +	/* Identify CPU type. This is done again by the common code later
> +	 * on but calling this function multiple times is fine.
> +	 */
> +	identify_cpu(0);
> +
>  	powerpc_firmware_features |= FW_FEATURE_ISERIES;
>  	powerpc_firmware_features |= FW_FEATURE_LPAR;
>  
> 
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
