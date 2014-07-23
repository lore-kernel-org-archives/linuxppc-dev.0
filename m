Return-Path: <Laurentiu.Tudor@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0244.outbound.protection.outlook.com [207.46.163.244])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6963F1A01C5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 19:48:39 +1000 (EST)
Message-ID: <53CF8195.40209@freescale.com>
Date: Wed, 23 Jul 2014 12:34:13 +0300
From: Tudor Laurentiu <b10716@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] Add support for hardware threads on e6500.
References: <20140718214022.GA18530@home.buserror.net>
In-Reply-To: <20140718214022.GA18530@home.buserror.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/19/2014 12:40 AM, Scott Wood wrote:
> From: Andy Fleming <afleming@freescale.com>
>
> The general idea is that each core will release all of its
> threads into the secondary thread startup code, which will
> eventually wait in the secondary core holding area, for the
> appropriate bit in the PACA to be set. The kick_cpu function
> pointer will set that bit in the PACA, and thus "release"
> the core/thread to boot. We also need to do a few things that
> U-Boot normally does for CPUs (like enable branch prediction).
>
> Signed-off-by: Andy Fleming <afleming@freescale.com>
> [scottwood@freescale.com: various changes, including only enabling
>   threads if Linux wants to kick them]
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>   arch/powerpc/include/asm/cputable.h   |  2 +-
>   arch/powerpc/include/asm/ppc-opcode.h |  9 ++++++++
>   arch/powerpc/include/asm/reg_booke.h  | 27 ++++++++++++++++++++++
>   arch/powerpc/kernel/head_64.S         | 22 ++++++++++++++++++
>   arch/powerpc/kernel/prom.c            | 10 ++++-----
>   arch/powerpc/kernel/setup-common.c    |  6 +++--
>   arch/powerpc/kernel/setup_64.c        |  6 ++++-
>   arch/powerpc/platforms/85xx/smp.c     | 42 +++++++++++++++++++++++++++++++++++
>   8 files changed, 114 insertions(+), 10 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
> index bc23477..e91dec8 100644
> --- a/arch/powerpc/include/asm/cputable.h
> +++ b/arch/powerpc/include/asm/cputable.h
> @@ -396,7 +396,7 @@ extern const char *powerpc_base_platform;
>   	    CPU_FTR_L2CSR | CPU_FTR_LWSYNC | CPU_FTR_NOEXECUTE | \
>   	    CPU_FTR_DBELL | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
>   	    CPU_FTR_DEBUG_LVL_EXC | CPU_FTR_EMB_HV | CPU_FTR_ALTIVEC_COMP | \
> -	    CPU_FTR_CELL_TB_BUG)
> +	    CPU_FTR_CELL_TB_BUG | CPU_FTR_SMT)
>   #define CPU_FTRS_GENERIC_32	(CPU_FTR_COMMON | CPU_FTR_NODSISRALIGN)
>
>   /* 64-bit CPUs */
> diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
> index 3132bb9..e316dad 100644
> --- a/arch/powerpc/include/asm/ppc-opcode.h
> +++ b/arch/powerpc/include/asm/ppc-opcode.h
> @@ -150,8 +150,10 @@
>   #define PPC_INST_MCRXR_MASK		0xfc0007fe
>   #define PPC_INST_MFSPR_PVR		0x7c1f42a6
>   #define PPC_INST_MFSPR_PVR_MASK		0xfc1fffff
> +#define PPC_INST_MFTMR			0x7c0002dc
>   #define PPC_INST_MSGSND			0x7c00019c
>   #define PPC_INST_MSGSNDP		0x7c00011c
> +#define PPC_INST_MTTMR			0x7c0003dc
>   #define PPC_INST_NOP			0x60000000
>   #define PPC_INST_POPCNTB		0x7c0000f4
>   #define PPC_INST_POPCNTB_MASK		0xfc0007fe
> @@ -369,4 +371,11 @@
>   #define TABORT(r)		stringify_in_c(.long PPC_INST_TABORT \
>   					       | __PPC_RA(r))
>
> +/* book3e thread control instructions */
> +#define TMRN(x)			((((x) & 0x1f) << 16) | (((x) & 0x3e0) << 6))
> +#define MTTMR(tmr, r)		stringify_in_c(.long PPC_INST_MTTMR | \
> +					       TMRN(tmr) | ___PPC_RS(r))
> +#define MFTMR(tmr, r)		stringify_in_c(.long PPC_INST_MFTMR | \
> +					       TMRN(tmr) | ___PPC_RT(r))
> +
>   #endif /* _ASM_POWERPC_PPC_OPCODE_H */
> diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
> index 6148292..cc5f395 100644
> --- a/arch/powerpc/include/asm/reg_booke.h
> +++ b/arch/powerpc/include/asm/reg_booke.h
> @@ -15,6 +15,8 @@
>   #ifndef __ASM_POWERPC_REG_BOOKE_H__
>   #define __ASM_POWERPC_REG_BOOKE_H__
>
> +#include <asm/ppc-opcode.h>
> +
>   /* Machine State Register (MSR) Fields */
>   #define MSR_GS		(1<<28) /* Guest state */
>   #define MSR_UCLE	(1<<26)	/* User-mode cache lock enable */
> @@ -598,6 +600,13 @@
>   /* Bit definitions for L1CSR2. */
>   #define L1CSR2_DCWS	0x40000000	/* Data Cache write shadow */
>
> +/* Bit definitions for BUCSR. */
> +#define BUCSR_STAC_EN	0x01000000	/* Segment Target Address Cache */
> +#define BUCSR_LS_EN	0x00400000	/* Link Stack */
> +#define BUCSR_BBFI	0x00000200	/* Branch Buffer flash invalidate */
> +#define BUCSR_BPEN	0x00000001	/* Branch prediction enable */
> +#define BUCSR_INIT	(BUCSR_STAC_EN | BUCSR_LS_EN | BUCSR_BBFI | BUCSR_BPEN)
> +
>   /* Bit definitions for L2CSR0. */
>   #define L2CSR0_L2E	0x80000000	/* L2 Cache Enable */
>   #define L2CSR0_L2PE	0x40000000	/* L2 Cache Parity/ECC Enable */
> @@ -721,5 +730,23 @@
>   #define MMUBE1_VBE4		0x00000002
>   #define MMUBE1_VBE5		0x00000001
>
> +#define TMRN_IMSR0	0x120	/* Initial MSR Register 0 (e6500) */
> +#define TMRN_IMSR1	0x121	/* Initial MSR Register 1 (e6500) */
> +#define TMRN_INIA0	0x140	/* Next Instruction Address Register 0 */
> +#define TMRN_INIA1	0x141	/* Next Instruction Address Register 1 */
> +#define SPRN_TENSR	0x1b5	/* Thread Enable Status Register */
> +#define SPRN_TENS	0x1b6	/* Thread Enable Set Register */
> +#define SPRN_TENC	0x1b7	/* Thread Enable Clear Register */
> +
> +#define TEN_THREAD(x)	(1 << (x))
> +
> +#ifndef __ASSEMBLY__
> +#define mftmr(rn)	({unsigned long rval; \
> +			asm volatile(MFTMR(rn, %0) : "=r" (rval)); rval;})
> +#define mttmr(rn, v)	asm volatile(MTTMR(rn, %0) : \
> +				     : "r" ((unsigned long)(v)) \
> +				     : "memory")
> +#endif /* !__ASSEMBLY__ */
> +
>   #endif /* __ASM_POWERPC_REG_BOOKE_H__ */
>   #endif /* __KERNEL__ */
> diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
> index a95145d..36ff6f0 100644
> --- a/arch/powerpc/kernel/head_64.S
> +++ b/arch/powerpc/kernel/head_64.S
> @@ -180,6 +180,28 @@ exception_marker:
>   #include "exceptions-64s.S"
>   #endif
>
> +#ifdef CONFIG_PPC_BOOK3E
> +_GLOBAL(fsl_secondary_thread_init)
> +	/* Enable branch prediction */
> +	lis     r3,BUCSR_INIT@h
> +	ori     r3,r3,BUCSR_INIT@l
> +	mtspr   SPRN_BUCSR,r3
> +	isync
> +
> +	/*
> +	 * Fix PIR to match the linear numbering in the device tree.
> +	 *
> +	 * On e6500, the reset value of PIR uses the low three bits for
> +	 * the thread within a core, and the upper bits for the core
> +	 * number.  There are two threads per core, so shift everything
> +	 * but the low bit right by two bits so that the cpu numbering is
> +	 * continuous.
> +	 */
> +	mfspr	r3, SPRN_PIR
> +	rlwimi	r3, r3, 30, 2, 30
> +	mtspr	SPRN_PIR, r3
> +#endif
> +
>   _GLOBAL(generic_secondary_thread_init)
>   	mr	r24,r3
>
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index 613a860..0448b1e 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -309,12 +309,10 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
>
>   	/* Get physical cpuid */
>   	intserv = of_get_flat_dt_prop(node, "ibm,ppc-interrupt-server#s", &len);
> -	if (intserv) {
> -		nthreads = len / sizeof(int);
> -	} else {
> -		intserv = of_get_flat_dt_prop(node, "reg", NULL);
> -		nthreads = 1;
> -	}
> +	if (!intserv)
> +		intserv = of_get_flat_dt_prop(node, "reg", &len);
> +
> +	nthreads = len / sizeof(int);
>
>   	/*
>   	 * Now see if any of these threads match our boot cpu.
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> index e5b022c..1b0e260 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -456,18 +456,20 @@ void __init smp_setup_cpu_maps(void)
>   		intserv = of_get_property(dn, "ibm,ppc-interrupt-server#s",
>   				&len);
>   		if (intserv) {
> -			nthreads = len / sizeof(int);
>   			DBG("    ibm,ppc-interrupt-server#s -> %d threads\n",
>   			    nthreads);
>   		} else {
>   			DBG("    no ibm,ppc-interrupt-server#s -> 1 thread\n");
> -			intserv = of_get_property(dn, "reg", NULL);
> +			intserv = of_get_property(dn, "reg", &len);
>   			if (!intserv) {
>   				cpu_be = cpu_to_be32(cpu);
>   				intserv = &cpu_be;	/* assume logical == phys */
> +				len = 4;
>   			}
>   		}
>
> +		nthreads = len / sizeof(int);
> +
>   		for (j = 0; j < nthreads && cpu < nr_cpu_ids; j++) {
>   			bool avail;
>
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> index ee082d7..6d06947 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -507,7 +507,11 @@ void __init setup_system(void)
>   	check_smt_enabled();
>   	setup_tlb_core_data();
>
> -#ifdef CONFIG_SMP
> +	/*
> +	 * Freescale Book3e parts spin in a loop provided by firmware,
> +	 * so smp_release_cpus() does nothing for them
> +	 */
> +#if defined(CONFIG_SMP) && !defined(CONFIG_PPC_FSL_BOOK3E)
>   	/* Release secondary cpus out of their spinloops at 0x60 now that
>   	 * we can map physical -> logical CPU ids
>   	 */
> diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
> index ba093f5..d7111d9 100644
> --- a/arch/powerpc/platforms/85xx/smp.c
> +++ b/arch/powerpc/platforms/85xx/smp.c
> @@ -28,6 +28,7 @@
>   #include <asm/dbell.h>
>   #include <asm/fsl_guts.h>
>   #include <asm/code-patching.h>
> +#include <asm/cputhreads.h>
>
>   #include <sysdev/fsl_soc.h>
>   #include <sysdev/mpic.h>
> @@ -168,6 +169,22 @@ static inline u32 read_spin_table_addr_l(void *spin_table)
>   	return in_be32(&((struct epapr_spin_table *)spin_table)->addr_l);
>   }
>
> +static void wake_hw_thread(void *info)
> +{
> +	void fsl_secondary_thread_init(void);
> +	unsigned long imsr1, inia1;
> +	int nr = *(const int *)info;
> +
> +	imsr1 = (u32)MSR_KERNEL;
> +	inia1 = *(unsigned long *)fsl_secondary_thread_init;
> +
> +	mttmr(TMRN_IMSR1, imsr1);
> +	mttmr(TMRN_INIA1, inia1);
> +	mtspr(SPRN_TENS, TEN_THREAD(1));
> +
> +	smp_generic_kick_cpu(nr);
> +}

This needs to be wrapped in an #ifdef CONFIG_PPC64 / #endif otherwise 
you get:

arch/powerpc/platforms/85xx/smp.c:172:13: error: 'wake_hw_thread' 
defined but not used

---
Best Regards, Laurentiu
