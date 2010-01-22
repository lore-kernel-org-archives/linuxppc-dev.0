Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [RFC/PATCH] powerpc: Dynamically allocate pacas
In-reply-to: <39fb8f1aeab9940b86c940b9a5f8e6bd41ec316c.1263368253.git.michael@ellerman.id.au>
References: <39fb8f1aeab9940b86c940b9a5f8e6bd41ec316c.1263368253.git.michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Date: Fri, 22 Jan 2010 16:19:48 +1300
Message-ID: <31712.1264130388@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



In message <39fb8f1aeab9940b86c940b9a5f8e6bd41ec316c.1263368253.git.michael=
@ell
erman.id.au> you wrote:
> On 64-bit kernels we currently have a 512 byte struct paca_struct for
> each cpu (usually just called "the paca"). Currently they are statically
> allocated, which means a kernel built for a large number of cpus will
> waste a lot of space if it's booted on a machine with few cpus.
>=20
> We can avoid that by only allocating the number of pacas we need at
> boot. However this is complicated by the fact that we need to access
> the paca before we know how many cpus there are in the system.
>=20
> The solution is to dynamically allocate enough space for NR_CPUS pacas,
> but then later in boot when we know how many cpus we have, we free any
> unused pacas.
>=20
> Lightly booted on Legacy iSeries & pSeries LPAR.

This is broken on 32bit CPUs.  Dies at compile time with
mpc86xx_defconfig.  No paca on 32bit :-(

/home/mikey/src/linux-2.6-ozlabs/arch/powerpc/kernel/prom.c: In function =
=E2=80=98early_init_devtree=E2=80=99:
/home/mikey/src/linux-2.6-ozlabs/arch/powerpc/kernel/prom.c:1227: error: im=
plicit declaration of function =E2=80=98allocate_pacas=E2=80=99
make[2]: *** [arch/powerpc/kernel/prom.o] Error 1
make[2]: *** Waiting for unfinished jobs....
/home/mikey/src/linux-2.6-ozlabs/arch/powerpc/kernel/setup-common.c: In fun=
ction =E2=80=98smp_setup_cpu_maps=E2=80=99:
/home/mikey/src/linux-2.6-ozlabs/arch/powerpc/kernel/setup-common.c:497: er=
ror: implicit declaration of function =E2=80=98free_unused_pacas=E2=80=99
make[2]: *** [arch/powerpc/kernel/setup-common.o] Error 1
make[1]: *** [arch/powerpc/kernel] Error 2
make[1]: *** Waiting for unfinished jobs....

Mikey

>=20
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
>  arch/powerpc/include/asm/paca.h            |    8 ++-
>  arch/powerpc/kernel/head_64.S              |    6 +-
>  arch/powerpc/kernel/paca.c                 |   93 +++++++++++++++++++++-=
----
--
>  arch/powerpc/kernel/prom.c                 |    2 +
>  arch/powerpc/kernel/setup-common.c         |    2 +
>  arch/powerpc/kernel/setup_64.c             |   12 ++--
>  arch/powerpc/platforms/iseries/exception.S |   25 +++++---
>  7 files changed, 106 insertions(+), 42 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/p=
aca.
h
> index 5e9b4ef..41e0f17 100644
> --- a/arch/powerpc/include/asm/paca.h
> +++ b/arch/powerpc/include/asm/paca.h
> @@ -14,6 +14,7 @@
>  #define _ASM_POWERPC_PACA_H
>  #ifdef __KERNEL__
>=20=20
> +#include <linux/init.h>
>  #include <asm/types.h>
>  #include <asm/lppaca.h>
>  #include <asm/mmu.h>
> @@ -140,8 +141,11 @@ struct paca_struct {
>  #endif
>  };
>=20=20
> -extern struct paca_struct paca[];
> -extern void initialise_pacas(void);
> +extern struct paca_struct *paca;
> +extern __initdata struct paca_struct boot_paca;
> +extern void allocate_pacas(void);
> +extern void initialise_paca(struct paca_struct *new_paca, int cpu);
> +extern void free_unused_pacas(void);
>=20=20
>  #endif /* __KERNEL__ */
>  #endif /* _ASM_POWERPC_PACA_H */
> diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
> index 9258074..b24b700 100644
> --- a/arch/powerpc/kernel/head_64.S
> +++ b/arch/powerpc/kernel/head_64.S
> @@ -219,7 +219,8 @@ generic_secondary_common_init:
>  	 * physical cpu id in r24, we need to search the pacas to find
>  	 * which logical id maps to our physical one.
>  	 */
> -	LOAD_REG_ADDR(r13, paca)	/* Get base vaddr of paca array	 */
> +	LOAD_REG_ADDR(r13, paca)	/* Load paca pointer		 */
> +	ld	r13,0(r13)		/* Get base vaddr of paca array	 */
>  	li	r5,0			/* logical cpu id                */
>  1:	lhz	r6,PACAHWCPUID(r13)	/* Load HW procid from paca      */
>  	cmpw	r6,r24			/* Compare to our id             */
> @@ -536,7 +537,8 @@ _GLOBAL(pmac_secondary_start)
>  	mtmsrd	r3			/* RI on */
>=20=20
>  	/* Set up a paca value for this processor. */
> -	LOAD_REG_ADDR(r4,paca)		/* Get base vaddr of paca array	*/
> +	LOAD_REG_ADDR(r4,paca)		/* Load paca pointer		*/
> +	ld	r4,0(r4)		/* Get base vaddr of paca array	*/
>  	mulli	r13,r24,PACA_SIZE	/* Calculate vaddr of right paca */
>  	add	r13,r13,r4		/* for this processor.		*/
>  	mtspr	SPRN_SPRG_PACA,r13	/* Save vaddr of paca in an SPRG*/
> diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
> index d16b1ea..0c40c6f 100644
> --- a/arch/powerpc/kernel/paca.c
> +++ b/arch/powerpc/kernel/paca.c
> @@ -9,11 +9,15 @@
>=20=20
>  #include <linux/threads.h>
>  #include <linux/module.h>
> +#include <linux/lmb.h>
>=20=20
> +#include <asm/firmware.h>
>  #include <asm/lppaca.h>
>  #include <asm/paca.h>
>  #include <asm/sections.h>
>  #include <asm/pgtable.h>
> +#include <asm/iseries/lpar_map.h>
> +#include <asm/iseries/hv_types.h>
>=20=20
>  /* This symbol is provided by the linker - let it fill in the paca
>   * field correctly */
> @@ -70,37 +74,82 @@ struct slb_shadow slb_shadow[] __cacheline_aligned =
=3D {
>   * processors.  The processor VPD array needs one entry per physical
>   * processor (not thread).
>   */
> -struct paca_struct paca[NR_CPUS];
> +struct paca_struct *paca;
>  EXPORT_SYMBOL(paca);
>=20=20
> -void __init initialise_pacas(void)
> -{
> -	int cpu;
> +struct paca_struct boot_paca;
>=20=20
> -	/* The TOC register (GPR2) points 32kB into the TOC, so that 64kB
> -	 * of the TOC can be addressed using a single machine instruction.
> -	 */
> +void __init initialise_paca(struct paca_struct *new_paca, int cpu)
> +{
> +       /* The TOC register (GPR2) points 32kB into the TOC, so that 64kB
> +	* of the TOC can be addressed using a single machine instruction.
> +	*/
>  	unsigned long kernel_toc =3D (unsigned long)(&__toc_start) + 0x8000UL;
>=20=20
> -	/* Can't use for_each_*_cpu, as they aren't functional yet */
> -	for (cpu =3D 0; cpu < NR_CPUS; cpu++) {
> -		struct paca_struct *new_paca =3D &paca[cpu];
> -
>  #ifdef CONFIG_PPC_BOOK3S
> -		new_paca->lppaca_ptr =3D &lppaca[cpu];
> +	new_paca->lppaca_ptr =3D &lppaca[cpu];
>  #else
> -		new_paca->kernel_pgd =3D swapper_pg_dir;
> +	new_paca->kernel_pgd =3D swapper_pg_dir;
>  #endif
> -		new_paca->lock_token =3D 0x8000;
> -		new_paca->paca_index =3D cpu;
> -		new_paca->kernel_toc =3D kernel_toc;
> -		new_paca->kernelbase =3D (unsigned long) _stext;
> -		new_paca->kernel_msr =3D MSR_KERNEL;
> -		new_paca->hw_cpu_id =3D 0xffff;
> -		new_paca->__current =3D &init_task;
> +	new_paca->lock_token =3D 0x8000;
> +	new_paca->paca_index =3D cpu;
> +	new_paca->kernel_toc =3D kernel_toc;
> +	new_paca->kernelbase =3D (unsigned long) _stext;
> +	new_paca->kernel_msr =3D MSR_KERNEL;
> +	new_paca->hw_cpu_id =3D 0xffff;
> +	new_paca->__current =3D &init_task;
>  #ifdef CONFIG_PPC_STD_MMU_64
> -		new_paca->slb_shadow_ptr =3D &slb_shadow[cpu];
> +	new_paca->slb_shadow_ptr =3D &slb_shadow[cpu];
>  #endif /* CONFIG_PPC_STD_MMU_64 */
> +}
> +
> +static int __initdata paca_size;
> +
> +void __init allocate_pacas(void)
> +{
> +	int nr_cpus, cpu, limit;
> +
> +	/*
> +	 * We can't take SLB misses on the paca, and we want to access them
> +	 * in real mode, so allocate them within the RMA and also within
> +	 * the first segment. On iSeries they must be within the area mapped
> +	 * by the HV, which is HvPagesToMap * HVPAGESIZE bytes.
> +	 */
> +	limit =3D min(0x10000000ULL, lmb.rmo_size);
> +	if (firmware_has_feature(FW_FEATURE_ISERIES))
> +		limit =3D min(limit, HvPagesToMap * HVPAGESIZE);
> +
> +	nr_cpus =3D NR_CPUS;
> +	/* On iSeries we know we can never have more than 64 cpus */
> +	if (firmware_has_feature(FW_FEATURE_ISERIES))
> +		nr_cpus =3D min(64, nr_cpus);
> +
> +	paca_size =3D PAGE_ALIGN(sizeof(struct paca_struct) * nr_cpus);
> +
> +	paca =3D __va(lmb_alloc_base(paca_size, PAGE_SIZE, limit));
> +	memset(paca, 0, paca_size);
> +
> +	printk(KERN_DEBUG "Allocated %u bytes for %d pacas at %p\n",
> +		paca_size, nr_cpus, paca);
> +
> +	/* Can't use for_each_*_cpu, as they aren't functional yet */
> +	for (cpu =3D 0; cpu < nr_cpus; cpu++)
> +		initialise_paca(&paca[cpu], cpu);
> +}
> +
> +void __init free_unused_pacas(void)
> +{
> +	int new_size;
> +
> +	new_size =3D PAGE_ALIGN(sizeof(struct paca_struct) * num_possible_cpus(=
))
;
> +
> +	if (new_size >=3D paca_size)
> +		return;
> +
> +	lmb_free(__pa(paca) + new_size, paca_size - new_size);
> +
> +	printk(KERN_DEBUG "Freed %u bytes for unused pacas\n",
> +		paca_size - new_size);
>=20=20
> -	}
> +	paca_size =3D new_size;
>  }
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index 4ec3008..50c3c55 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -1224,6 +1224,8 @@ void __init early_init_devtree(void *params)
>  	 * FIXME .. and the initrd too? */
>  	move_device_tree();
>=20=20
> +	allocate_pacas();
> +
>  	DBG("Scanning CPUs ...\n");
>=20=20
>  	/* Retreive CPU related informations from the flat tree
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/set=
up-c
ommon.c
> index 03dd6a2..5df0f6a 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -493,6 +493,8 @@ void __init smp_setup_cpu_maps(void)
>  	 * here will have to be reworked
>  	 */
>  	cpu_init_thread_core_maps(nthreads);
> +
> +	free_unused_pacas();
>  }
>  #endif /* CONFIG_SMP */
>=20=20
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_6=
4.c
> index 6568406..6354739 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -144,9 +144,9 @@ early_param("smt-enabled", early_smt_enabled);
>  #endif /* CONFIG_SMP */
>=20=20
>  /* Put the paca pointer into r13 and SPRG_PACA */
> -void __init setup_paca(int cpu)
> +static void __init setup_paca(struct paca_struct *new_paca)
>  {
> -	local_paca =3D &paca[cpu];
> +	local_paca =3D new_paca;
>  	mtspr(SPRN_SPRG_PACA, local_paca);
>  #ifdef CONFIG_PPC_BOOK3E
>  	mtspr(SPRN_SPRG_TLB_EXFRAME, local_paca->extlb);
> @@ -176,14 +176,12 @@ void __init early_setup(unsigned long dt_ptr)
>  {
>  	/* -------- printk is _NOT_ safe to use here ! ------- */
>=20=20
> -	/* Fill in any unititialised pacas */
> -	initialise_pacas();
> -
>  	/* Identify CPU type */
>  	identify_cpu(0, mfspr(SPRN_PVR));
>=20=20
>  	/* Assume we're on cpu 0 for now. Don't write to the paca yet! */
> -	setup_paca(0);
> +	initialise_paca(&boot_paca, 0);
> +	setup_paca(&boot_paca);
>=20=20
>  	/* Initialize lockdep early or else spinlocks will blow */
>  	lockdep_init();
> @@ -203,7 +201,7 @@ void __init early_setup(unsigned long dt_ptr)
>  	early_init_devtree(__va(dt_ptr));
>=20=20
>  	/* Now we know the logical id of our boot cpu, setup the paca. */
> -	setup_paca(boot_cpuid);
> +	setup_paca(&paca[boot_cpuid]);
>=20=20
>  	/* Fix up paca fields required for the boot cpu */
>  	get_paca()->cpu_start =3D 1;
> diff --git a/arch/powerpc/platforms/iseries/exception.S b/arch/powerpc/pl=
atfo
rms/iseries/exception.S
> index 5369653..fba5bf9 100644
> --- a/arch/powerpc/platforms/iseries/exception.S
> +++ b/arch/powerpc/platforms/iseries/exception.S
> @@ -43,17 +43,14 @@ system_reset_iSeries:
>  	LOAD_REG_ADDR(r23, alpaca)
>  	li	r0,ALPACA_SIZE
>  	sub	r23,r13,r23
> -	divdu	r23,r23,r0		/* r23 has cpu number */
> -	LOAD_REG_ADDR(r13, paca)
> -	mulli	r0,r23,PACA_SIZE
> -	add	r13,r13,r0
> -	mtspr	SPRN_SPRG_PACA,r13	/* Save it away for the future */
> -	mfmsr	r24
> -	ori	r24,r24,MSR_RI
> -	mtmsrd	r24			/* RI on */
> -	mr	r24,r23
> +	divdu	r24,r23,r0		/* r24 has cpu number */
>  	cmpwi	0,r24,0			/* Are we processor 0? */
>  	bne	1f
> +	LOAD_REG_ADDR(r13, boot_paca)
> +	mtspr	SPRN_SPRG_PACA,r13	/* Save it away for the future */
> +	mfmsr	r23
> +	ori	r23,r23,MSR_RI
> +	mtmsrd	r23			/* RI on */
>  	b	.__start_initialization_iSeries	/* Start up the first processor
 */
>  1:	mfspr	r4,SPRN_CTRLF
>  	li	r5,CTRL_RUNLATCH	/* Turn off the run light */
> @@ -86,6 +83,16 @@ system_reset_iSeries:
>  #endif
>=20=20
>  2:
> +	/* Load our paca now that it's been allocated */
> +	LOAD_REG_ADDR(r13, paca)
> +	ld	r13,0(r13)
> +	mulli	r0,r24,PACA_SIZE
> +	add	r13,r13,r0
> +	mtspr	SPRN_SPRG_PACA,r13	/* Save it away for the future */
> +	mfmsr	r23
> +	ori	r23,r23,MSR_RI
> +	mtmsrd	r23			/* RI on */
> +
>  	HMT_LOW
>  #ifdef CONFIG_SMP
>  	lbz	r23,PACAPROCSTART(r13)	/* Test if this processor
> --=20
> 1.6.3.3
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>=20
