Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <200509090623.41889.arnd@arndb.de>
References: <200509090623.41889.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <06F93AF6-7AF8-4320-B9E3-CBF9EA333403@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 14 Sep 2005 14:11:22 -0500
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, pantelis.antoniou@gmail.com,
	linuxppc64-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] powerpc: merge include/asm/cputable.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd,

I not sure I understand what the introduction of the enum's gets us.

- kumar

On Sep 8, 2005, at 11:23 PM, Arnd Bergmann wrote:

> This is an updated version of my old patch that creates a more  
> optimized
> version of cpu_has_feature(). This version actually combines
> asm-ppc/cputable.h and asm-ppc64/cputable.h, which turned out to be
> a lot more work than only the 64 bit version.
>
> The 64 bit parts a relatively straightforward port of my earlier work
> which I tested in a number of configurations. The 32 bit parts are
> not tested at all, all I did was compiling the ppc defconfig with  
> this.
>
> I think it is best if I hand the patch over to Kumar and Becky for
> further testing and cleaning up the remaining bits in the new
> file, as they appear to have invested some thought in it already.
> This version still has a number of #ifdef __powerpc64__ that should
> probably go away in the process.
>
> The patch also relies on having the ASM_CONST() macro in ppc_asm.h,
> as proposed by Kumar Gala, so it won't work on the current git
> head without that change.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> --
>
>  clean-cg/arch/ppc/kernel/cputable.c     |  401 ++++ 
> +----------------------
>  clean-cg/arch/ppc64/Kconfig             |   30 ++
>  clean-cg/arch/ppc64/kernel/cputable.c   |   82 +----
>  clean-cg/include/asm-powerpc/cputable.h |  475 ++++++++++++++++++++ 
> ++++++++++++
>  include/asm-ppc/cputable.h              |  128 --------
>  include/asm-ppc64/cputable.h            |  167 -----------
>
> Index: clean-cg/include/asm-ppc64/cputable.h
> ===================================================================
> --- clean-cg.orig/include/asm-ppc64/cputable.h
> +++ /dev/null
> @@ -1,167 +0,0 @@
> -/*
> - *  include/asm-ppc64/cputable.h
> - *
> - *  Copyright (C) 2001 Ben. Herrenschmidt (benh@kernel.crashing.org)
> - *
> - *  Modifications for ppc64:
> - *      Copyright (C) 2003 Dave Engebretsen <engebret@us.ibm.com>
> - *
> - *  This program is free software; you can redistribute it and/or
> - *  modify it under the terms of the GNU General Public License
> - *  as published by the Free Software Foundation; either version
> - *  2 of the License, or (at your option) any later version.
> - */
> -
> -#ifndef __ASM_PPC_CPUTABLE_H
> -#define __ASM_PPC_CPUTABLE_H
> -
> -#include <linux/config.h>
> -#include <asm/page.h> /* for ASM_CONST */
> -
> -/* Exposed to userland CPU features - Must match ppc32 definitions */
> -#define PPC_FEATURE_32            0x80000000
> -#define PPC_FEATURE_64            0x40000000
> -#define PPC_FEATURE_601_INSTR        0x20000000
> -#define PPC_FEATURE_HAS_ALTIVEC        0x10000000
> -#define PPC_FEATURE_HAS_FPU        0x08000000
> -#define PPC_FEATURE_HAS_MMU        0x04000000
> -#define PPC_FEATURE_HAS_4xxMAC        0x02000000
> -#define PPC_FEATURE_UNIFIED_CACHE    0x01000000
> -
> -#ifdef __KERNEL__
> -
> -#ifndef __ASSEMBLY__
> -
> -/* This structure can grow, it's real size is used by head.S code
> - * via the mkdefs mechanism.
> - */
> -struct cpu_spec;
> -struct op_ppc64_model;
> -
> -typedef    void (*cpu_setup_t)(unsigned long offset, struct  
> cpu_spec* spec);
> -
> -struct cpu_spec {
> -    /* CPU is matched via (PVR & pvr_mask) == pvr_value */
> -    unsigned int    pvr_mask;
> -    unsigned int    pvr_value;
> -
> -    char        *cpu_name;
> -    unsigned long    cpu_features;        /* Kernel features */
> -    unsigned int    cpu_user_features;    /* Userland features */
> -
> -    /* cache line sizes */
> -    unsigned int    icache_bsize;
> -    unsigned int    dcache_bsize;
> -
> -    /* number of performance monitor counters */
> -    unsigned int    num_pmcs;
> -
> -    /* this is called to initialize various CPU bits like L1 cache,
> -     * BHT, SPD, etc... from head.S before branching to  
> identify_machine
> -     */
> -    cpu_setup_t    cpu_setup;
> -
> -    /* Used by oprofile userspace to select the right counters */
> -    char        *oprofile_cpu_type;
> -
> -    /* Processor specific oprofile operations */
> -    struct op_ppc64_model *oprofile_model;
> -};
> -
> -extern struct cpu_spec        cpu_specs[];
> -extern struct cpu_spec        *cur_cpu_spec;
> -
> -static inline unsigned long cpu_has_feature(unsigned long feature)
> -{
> -    return cur_cpu_spec->cpu_features & feature;
> -}
> -
> -#endif /* __ASSEMBLY__ */
> -
> -/* CPU kernel features */
> -
> -/* Retain the 32b definitions for the time being - use bottom half  
> of word */
> -#define CPU_FTR_SPLIT_ID_CACHE        ASM_CONST(0x0000000000000001)
> -#define CPU_FTR_L2CR            ASM_CONST(0x0000000000000002)
> -#define CPU_FTR_SPEC7450        ASM_CONST(0x0000000000000004)
> -#define CPU_FTR_ALTIVEC            ASM_CONST(0x0000000000000008)
> -#define CPU_FTR_TAU            ASM_CONST(0x0000000000000010)
> -#define CPU_FTR_CAN_DOZE        ASM_CONST(0x0000000000000020)
> -#define CPU_FTR_USE_TB            ASM_CONST(0x0000000000000040)
> -#define CPU_FTR_604_PERF_MON        ASM_CONST(0x0000000000000080)
> -#define CPU_FTR_601            ASM_CONST(0x0000000000000100)
> -#define CPU_FTR_HPTE_TABLE        ASM_CONST(0x0000000000000200)
> -#define CPU_FTR_CAN_NAP            ASM_CONST(0x0000000000000400)
> -#define CPU_FTR_L3CR            ASM_CONST(0x0000000000000800)
> -#define CPU_FTR_L3_DISABLE_NAP        ASM_CONST(0x0000000000001000)
> -#define CPU_FTR_NAP_DISABLE_L2_PR    ASM_CONST(0x0000000000002000)
> -#define CPU_FTR_DUAL_PLL_750FX        ASM_CONST(0x0000000000004000)
> -
> -/* Add the 64b processor unique features in the top half of the  
> word */
> -#define CPU_FTR_SLB                   ASM_CONST(0x0000000100000000)
> -#define CPU_FTR_16M_PAGE              ASM_CONST(0x0000000200000000)
> -#define CPU_FTR_TLBIEL                 ASM_CONST(0x0000000400000000)
> -#define CPU_FTR_NOEXECUTE             ASM_CONST(0x0000000800000000)
> -#define CPU_FTR_NODSISRALIGN          ASM_CONST(0x0000001000000000)
> -#define CPU_FTR_IABR              ASM_CONST(0x0000002000000000)
> -#define CPU_FTR_MMCRA              ASM_CONST(0x0000004000000000)
> -/* unused                 ASM_CONST(0x0000008000000000) */
> -#define CPU_FTR_SMT              ASM_CONST(0x0000010000000000)
> -#define CPU_FTR_COHERENT_ICACHE      ASM_CONST(0x0000020000000000)
> -#define CPU_FTR_LOCKLESS_TLBIE        ASM_CONST(0x0000040000000000)
> -#define CPU_FTR_MMCRA_SIHV        ASM_CONST(0x0000080000000000)
> -#define CPU_FTR_CTRL            ASM_CONST(0x0000100000000000)
> -
> -#ifndef __ASSEMBLY__
> -
> -#define COMMON_USER_PPC64    (PPC_FEATURE_32 | PPC_FEATURE_64 | \
> -                     PPC_FEATURE_HAS_FPU | PPC_FEATURE_HAS_MMU)
> -
> -#define CPU_FTR_PPCAS_ARCH_V2_BASE (CPU_FTR_SLB | \
> -                                 CPU_FTR_TLBIEL |  
> CPU_FTR_NOEXECUTE | \
> -                                 CPU_FTR_NODSISRALIGN | CPU_FTR_CTRL)
> -
> -/* iSeries doesn't support large pages */
> -#ifdef CONFIG_PPC_ISERIES
> -#define CPU_FTR_PPCAS_ARCH_V2    (CPU_FTR_PPCAS_ARCH_V2_BASE)
> -#else
> -#define CPU_FTR_PPCAS_ARCH_V2    (CPU_FTR_PPCAS_ARCH_V2_BASE |  
> CPU_FTR_16M_PAGE)
> -#endif /* CONFIG_PPC_ISERIES */
> -
> -#endif /* __ASSEMBLY */
> -
> -#ifdef __ASSEMBLY__
> -
> -#define BEGIN_FTR_SECTION        98:
> -
> -#define END_FTR_SECTION(msk, val)        \
> -99:                        \
> -    .section __ftr_fixup,"a";        \
> -    .align 3;                \
> -    .llong msk;                    \
> -    .llong val;                    \
> -    .llong 98b;                    \
> -    .llong 99b;                     \
> -    .previous
> -
> -#else
> -
> -#define BEGIN_FTR_SECTION        "98:\n"
> -#define END_FTR_SECTION(msk, val)        \
> -"99:\n"                        \
> -"    .section __ftr_fixup,\"a\";\n"        \
> -"    .align 3;\n"                \
> -"    .llong "#msk";\n"            \
> -"    .llong "#val";\n"            \
> -"    .llong 98b;\n"                    \
> -"    .llong 99b;\n"                     \
> -"    .previous\n"
> -
> -#endif /* __ASSEMBLY__ */
> -
> -#define END_FTR_SECTION_IFSET(msk)    END_FTR_SECTION((msk), (msk))
> -#define END_FTR_SECTION_IFCLR(msk)    END_FTR_SECTION((msk), 0)
> -
> -#endif /* __ASM_PPC_CPUTABLE_H */
> -#endif /* __KERNEL__ */
> -
> Index: clean-cg/arch/ppc64/Kconfig
> ===================================================================
> --- clean-cg.orig/arch/ppc64/Kconfig
> +++ clean-cg/arch/ppc64/Kconfig
> @@ -125,6 +125,36 @@ config BPA_IIC
>      bool
>      default y
>
> +config CPU_POWER3
> +    bool
> +    default y
> +    depends on (PPC_ISERIES || PPC_PSERIES) && !POWER4_ONLY
> +
> +config CPU_RS64
> +    bool
> +    default y
> +    depends on (PPC_ISERIES || PPC_PSERIES) && !POWER4_ONLY
> +
> +config CPU_POWER4
> +    bool
> +    default y
> +    depends on PPC_ISERIES || PPC_PSERIES
> +
> +config CPU_PPC970
> +    bool
> +    default y
> +    depends on PPC_PSERIES || PPC_PMAC || PPC_MAPLE
> +
> +config CPU_POWER5
> +    bool
> +    default y
> +    depends on PPC_PSERIES
> +
> +config CPU_CELL
> +    bool
> +    default y
> +    depends on PPC_BPA
> +
>  # VMX is pSeries only for now until somebody writes the iSeries
>  # exception vectors for it
>  config ALTIVEC
> Index: clean-cg/arch/ppc64/kernel/cputable.c
> ===================================================================
> --- clean-cg.orig/arch/ppc64/kernel/cputable.c
> +++ clean-cg/arch/ppc64/kernel/cputable.c
> @@ -37,26 +37,13 @@ extern void __setup_cpu_power4(unsigned
>  extern void __setup_cpu_ppc970(unsigned long offset, struct  
> cpu_spec* spec);
>  extern void __setup_cpu_be(unsigned long offset, struct cpu_spec*  
> spec);
>
> -
> -/* We only set the altivec features if the kernel was compiled  
> with altivec
> - * support
> - */
> -#ifdef CONFIG_ALTIVEC
> -#define CPU_FTR_ALTIVEC_COMP    CPU_FTR_ALTIVEC
> -#define PPC_FEATURE_HAS_ALTIVEC_COMP PPC_FEATURE_HAS_ALTIVEC
> -#else
> -#define CPU_FTR_ALTIVEC_COMP    0
> -#define PPC_FEATURE_HAS_ALTIVEC_COMP    0
> -#endif
> -
>  struct cpu_spec    cpu_specs[] = {
>      {    /* Power3 */
>          .pvr_mask        = 0xffff0000,
>          .pvr_value        = 0x00400000,
>          .cpu_name        = "POWER3 (630)",
> -        .cpu_features        = CPU_FTR_SPLIT_ID_CACHE |
> -            CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE | CPU_FTR_IABR,
> -        .cpu_user_features = COMMON_USER_PPC64,
> +        .cpu_features        = CPU_FTR_POWER3,
> +        .cpu_user_features    = COMMON_USER_PPC64,
>          .icache_bsize        = 128,
>          .dcache_bsize        = 128,
>          .num_pmcs        = 8,
> @@ -70,8 +57,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffff0000,
>          .pvr_value        = 0x00410000,
>          .cpu_name        = "POWER3 (630+)",
> -        .cpu_features        = CPU_FTR_SPLIT_ID_CACHE |
> -            CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE | CPU_FTR_IABR,
> +        .cpu_features        = CPU_FTR_POWER3,
>          .cpu_user_features    = COMMON_USER_PPC64,
>          .icache_bsize        = 128,
>          .dcache_bsize        = 128,
> @@ -86,9 +72,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffff0000,
>          .pvr_value        = 0x00330000,
>          .cpu_name        = "RS64-II (northstar)",
> -        .cpu_features        = CPU_FTR_SPLIT_ID_CACHE |
> -            CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE | CPU_FTR_IABR |
> -            CPU_FTR_MMCRA | CPU_FTR_CTRL,
> +        .cpu_features        = CPU_FTR_RS64,
>          .cpu_user_features    = COMMON_USER_PPC64,
>          .icache_bsize        = 128,
>          .dcache_bsize        = 128,
> @@ -103,9 +87,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffff0000,
>          .pvr_value        = 0x00340000,
>          .cpu_name        = "RS64-III (pulsar)",
> -        .cpu_features        = CPU_FTR_SPLIT_ID_CACHE |
> -            CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE | CPU_FTR_IABR |
> -            CPU_FTR_MMCRA | CPU_FTR_CTRL,
> +        .cpu_features        = CPU_FTR_RS64,
>          .cpu_user_features    = COMMON_USER_PPC64,
>          .icache_bsize        = 128,
>          .dcache_bsize        = 128,
> @@ -120,9 +102,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffff0000,
>          .pvr_value        = 0x00360000,
>          .cpu_name        = "RS64-III (icestar)",
> -        .cpu_features        = CPU_FTR_SPLIT_ID_CACHE |
> -            CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE | CPU_FTR_IABR |
> -            CPU_FTR_MMCRA | CPU_FTR_CTRL,
> +        .cpu_features        = CPU_FTR_RS64,
>          .cpu_user_features    = COMMON_USER_PPC64,
>          .icache_bsize        = 128,
>          .dcache_bsize        = 128,
> @@ -137,9 +117,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffff0000,
>          .pvr_value        = 0x00370000,
>          .cpu_name        = "RS64-IV (sstar)",
> -        .cpu_features        = CPU_FTR_SPLIT_ID_CACHE |
> -            CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE | CPU_FTR_IABR |
> -            CPU_FTR_MMCRA | CPU_FTR_CTRL,
> +        .cpu_features        = CPU_FTR_RS64,
>          .cpu_user_features    = COMMON_USER_PPC64,
>          .icache_bsize        = 128,
>          .dcache_bsize        = 128,
> @@ -154,9 +132,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffff0000,
>          .pvr_value        = 0x00350000,
>          .cpu_name        = "POWER4 (gp)",
> -        .cpu_features        = CPU_FTR_SPLIT_ID_CACHE |
> -            CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE |
> -            CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_MMCRA,
> +        .cpu_features        = CPU_FTR_POWER4,
>          .cpu_user_features    = COMMON_USER_PPC64,
>          .icache_bsize        = 128,
>          .dcache_bsize        = 128,
> @@ -171,9 +147,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffff0000,
>          .pvr_value        = 0x00380000,
>          .cpu_name        = "POWER4+ (gq)",
> -        .cpu_features        = CPU_FTR_SPLIT_ID_CACHE |
> -            CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE |
> -            CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_MMCRA,
> +        .cpu_features        = CPU_FTR_POWER4,
>          .cpu_user_features    = COMMON_USER_PPC64,
>          .icache_bsize        = 128,
>          .dcache_bsize        = 128,
> @@ -188,10 +162,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffff0000,
>          .pvr_value        = 0x00390000,
>          .cpu_name        = "PPC970",
> -        .cpu_features        = CPU_FTR_SPLIT_ID_CACHE |
> -            CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE |
> -            CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_ALTIVEC_COMP |
> -            CPU_FTR_CAN_NAP | CPU_FTR_MMCRA,
> +        .cpu_features        = CPU_FTR_PPC970,
>          .cpu_user_features    = COMMON_USER_PPC64 |
>              PPC_FEATURE_HAS_ALTIVEC_COMP,
>          .icache_bsize        = 128,
> @@ -207,10 +178,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffff0000,
>          .pvr_value        = 0x003c0000,
>          .cpu_name        = "PPC970FX",
> -        .cpu_features        = CPU_FTR_SPLIT_ID_CACHE |
> -            CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE |
> -            CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_ALTIVEC_COMP |
> -            CPU_FTR_CAN_NAP | CPU_FTR_MMCRA,
> +        .cpu_features        = CPU_FTR_PPC970,
>          .cpu_user_features    = COMMON_USER_PPC64 |
>              PPC_FEATURE_HAS_ALTIVEC_COMP,
>          .icache_bsize        = 128,
> @@ -226,10 +194,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffff0000,
>          .pvr_value        = 0x00440000,
>          .cpu_name        = "PPC970MP",
> -        .cpu_features        = CPU_FTR_SPLIT_ID_CACHE |
> -            CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE |
> -            CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_ALTIVEC_COMP |
> -            CPU_FTR_CAN_NAP | CPU_FTR_MMCRA,
> +        .cpu_features        = CPU_FTR_PPC970,
>          .cpu_user_features    = COMMON_USER_PPC64 |
>              PPC_FEATURE_HAS_ALTIVEC_COMP,
>          .icache_bsize        = 128,
> @@ -244,11 +209,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffff0000,
>          .pvr_value        = 0x003a0000,
>          .cpu_name        = "POWER5 (gr)",
> -        .cpu_features        = CPU_FTR_SPLIT_ID_CACHE |
> -            CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE |
> -            CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_MMCRA | CPU_FTR_SMT |
> -            CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE |
> -            CPU_FTR_MMCRA_SIHV,
> +        .cpu_features        = CPU_FTR_POWER5,
>          .cpu_user_features    = COMMON_USER_PPC64,
>          .icache_bsize        = 128,
>          .dcache_bsize        = 128,
> @@ -263,11 +224,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffff0000,
>          .pvr_value        = 0x003b0000,
>          .cpu_name        = "POWER5 (gs)",
> -        .cpu_features        = CPU_FTR_SPLIT_ID_CACHE |
> -            CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE |
> -            CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_MMCRA | CPU_FTR_SMT |
> -            CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE |
> -            CPU_FTR_MMCRA_SIHV,
> +        .cpu_features        = CPU_FTR_POWER5,
>          .cpu_user_features    = COMMON_USER_PPC64,
>          .icache_bsize        = 128,
>          .dcache_bsize        = 128,
> @@ -281,11 +238,8 @@ struct cpu_spec    cpu_specs[] = {
>      {    /* BE DD1.x */
>          .pvr_mask        = 0xffff0000,
>          .pvr_value        = 0x00700000,
> -        .cpu_name        = "Broadband Engine",
> -        .cpu_features        = CPU_FTR_SPLIT_ID_CACHE |
> -            CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE |
> -            CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_ALTIVEC_COMP |
> -            CPU_FTR_SMT,
> +        .cpu_name        = "Cell Broadband Engine",
> +        .cpu_features        = CPU_FTR_CELL,
>          .cpu_user_features    = COMMON_USER_PPC64 |
>              PPC_FEATURE_HAS_ALTIVEC_COMP,
>          .icache_bsize        = 128,
> @@ -296,9 +250,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0x00000000,
>          .pvr_value        = 0x00000000,
>          .cpu_name        = "POWER4 (compatible)",
> -        .cpu_features        = CPU_FTR_SPLIT_ID_CACHE |
> -            CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE |
> -            CPU_FTR_PPCAS_ARCH_V2,
> +        .cpu_features        = CPU_FTR_COMPATIBLE,
>          .cpu_user_features    = COMMON_USER_PPC64,
>          .icache_bsize        = 128,
>          .dcache_bsize        = 128,
> Index: clean-cg/arch/ppc/kernel/cputable.c
> ===================================================================
> --- clean-cg.orig/arch/ppc/kernel/cputable.c
> +++ clean-cg/arch/ppc/kernel/cputable.c
> @@ -42,17 +42,6 @@ extern void __setup_cpu_generic(unsigned
>  #define COMMON_PPC    (PPC_FEATURE_32 | PPC_FEATURE_HAS_FPU | \
>               PPC_FEATURE_HAS_MMU)
>
> -/* We only set the altivec features if the kernel was compiled  
> with altivec
> - * support
> - */
> -#ifdef CONFIG_ALTIVEC
> -#define CPU_FTR_ALTIVEC_COMP        CPU_FTR_ALTIVEC
> -#define PPC_FEATURE_ALTIVEC_COMP        PPC_FEATURE_HAS_ALTIVEC
> -#else
> -#define CPU_FTR_ALTIVEC_COMP        0
> -#define PPC_FEATURE_ALTIVEC_COMP           0
> -#endif
> -
>  /* We only set the spe features if the kernel was compiled with
>   * spe support
>   */
> @@ -62,34 +51,13 @@ extern void __setup_cpu_generic(unsigned
>  #define PPC_FEATURE_SPE_COMP           0
>  #endif
>
> -/* We need to mark all pages as being coherent if we're SMP or we
> - * have a 74[45]x and an MPC107 host bridge.
> - */
> -#if defined(CONFIG_SMP) || defined(CONFIG_MPC10X_BRIDGE)
> -#define CPU_FTR_COMMON                  CPU_FTR_NEED_COHERENT
> -#else
> -#define CPU_FTR_COMMON                  0
> -#endif
> -
> -/* The powersave features NAP & DOZE seems to confuse BDI when
> -   debugging. So if a BDI is used, disable theses
> - */
> -#ifndef CONFIG_BDI_SWITCH
> -#define CPU_FTR_MAYBE_CAN_DOZE    CPU_FTR_CAN_DOZE
> -#define CPU_FTR_MAYBE_CAN_NAP    CPU_FTR_CAN_NAP
> -#else
> -#define CPU_FTR_MAYBE_CAN_DOZE    0
> -#define CPU_FTR_MAYBE_CAN_NAP    0
> -#endif
> -
>  struct cpu_spec    cpu_specs[] = {
>  #if CLASSIC_PPC
>      {     /* 601 */
>          .pvr_mask        = 0xffff0000,
>          .pvr_value        = 0x00010000,
>          .cpu_name        = "601",
> -        .cpu_features        = CPU_FTR_COMMON | CPU_FTR_601 |
> -            CPU_FTR_HPTE_TABLE,
> +        .cpu_features        = CPU_FTR_PPC601,
>          .cpu_user_features     = COMMON_PPC | PPC_FEATURE_601_INSTR |
>              PPC_FEATURE_UNIFIED_CACHE,
>          .icache_bsize        = 32,
> @@ -100,9 +68,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffff0000,
>          .pvr_value        = 0x00030000,
>          .cpu_name        = "603",
> -        .cpu_features        = CPU_FTR_COMMON |
> -            CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE |
> -            CPU_FTR_USE_TB | CPU_FTR_MAYBE_CAN_NAP,
> +        .cpu_features        = CPU_FTR_603,
>          .cpu_user_features    = COMMON_PPC,
>          .icache_bsize        = 32,
>          .dcache_bsize        = 32,
> @@ -112,9 +78,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffff0000,
>          .pvr_value        = 0x00060000,
>          .cpu_name        = "603e",
> -        .cpu_features        = CPU_FTR_COMMON |
> -            CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE |
> -            CPU_FTR_USE_TB | CPU_FTR_MAYBE_CAN_NAP,
> +        .cpu_features        = CPU_FTR_603,
>          .cpu_user_features    = COMMON_PPC,
>          .icache_bsize        = 32,
>          .dcache_bsize        = 32,
> @@ -124,9 +88,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffff0000,
>          .pvr_value        = 0x00070000,
>          .cpu_name        = "603ev",
> -        .cpu_features        = CPU_FTR_COMMON |
> -            CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE |
> -            CPU_FTR_USE_TB | CPU_FTR_MAYBE_CAN_NAP,
> +        .cpu_features        = CPU_FTR_603,
>          .cpu_user_features    = COMMON_PPC,
>          .icache_bsize        = 32,
>          .dcache_bsize        = 32,
> @@ -136,9 +98,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffff0000,
>          .pvr_value        = 0x00040000,
>          .cpu_name        = "604",
> -        .cpu_features        = CPU_FTR_COMMON |
> -            CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
> -            CPU_FTR_604_PERF_MON | CPU_FTR_HPTE_TABLE,
> +        .cpu_features        = CPU_FTR_604,
>          .cpu_user_features    = COMMON_PPC,
>          .icache_bsize        = 32,
>          .dcache_bsize        = 32,
> @@ -149,9 +109,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xfffff000,
>          .pvr_value        = 0x00090000,
>          .cpu_name        = "604e",
> -        .cpu_features        = CPU_FTR_COMMON |
> -            CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
> -            CPU_FTR_604_PERF_MON | CPU_FTR_HPTE_TABLE,
> +        .cpu_features        = CPU_FTR_604,
>          .cpu_user_features    = COMMON_PPC,
>          .icache_bsize        = 32,
>          .dcache_bsize        = 32,
> @@ -162,9 +120,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffff0000,
>          .pvr_value        = 0x00090000,
>          .cpu_name        = "604r",
> -        .cpu_features        = CPU_FTR_COMMON |
> -            CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
> -            CPU_FTR_604_PERF_MON | CPU_FTR_HPTE_TABLE,
> +        .cpu_features        = CPU_FTR_604,
>          .cpu_user_features    = COMMON_PPC,
>          .icache_bsize        = 32,
>          .dcache_bsize        = 32,
> @@ -175,9 +131,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffff0000,
>          .pvr_value        = 0x000a0000,
>          .cpu_name        = "604ev",
> -        .cpu_features        = CPU_FTR_COMMON |
> -            CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
> -            CPU_FTR_604_PERF_MON | CPU_FTR_HPTE_TABLE,
> +        .cpu_features        = CPU_FTR_604,
>          .cpu_user_features    = COMMON_PPC,
>          .icache_bsize        = 32,
>          .dcache_bsize        = 32,
> @@ -188,10 +142,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffffffff,
>          .pvr_value        = 0x00084202,
>          .cpu_name        = "740/750",
> -        .cpu_features        = CPU_FTR_COMMON |
> -            CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE |
> -            CPU_FTR_USE_TB | CPU_FTR_L2CR | CPU_FTR_HPTE_TABLE |
> -            CPU_FTR_MAYBE_CAN_NAP,
> +        .cpu_features        = CPU_FTR_740_NOTAU,
>          .cpu_user_features    = COMMON_PPC,
>          .icache_bsize        = 32,
>          .dcache_bsize        = 32,
> @@ -202,10 +153,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xfffffff0,
>          .pvr_value        = 0x00080100,
>          .cpu_name        = "750CX",
> -        .cpu_features        = CPU_FTR_COMMON |
> -            CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE |
> -            CPU_FTR_USE_TB | CPU_FTR_L2CR | CPU_FTR_TAU |
> -            CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP,
> +        .cpu_features        = CPU_FTR_750,
>          .cpu_user_features    = COMMON_PPC,
>          .icache_bsize        = 32,
>          .dcache_bsize        = 32,
> @@ -216,10 +164,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xfffffff0,
>          .pvr_value        = 0x00082200,
>          .cpu_name        = "750CX",
> -        .cpu_features        = CPU_FTR_COMMON |
> -            CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE |
> -            CPU_FTR_USE_TB | CPU_FTR_L2CR | CPU_FTR_TAU |
> -            CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP,
> +        .cpu_features        = CPU_FTR_750,
>          .cpu_user_features    = COMMON_PPC,
>          .icache_bsize        = 32,
>          .dcache_bsize        = 32,
> @@ -230,10 +175,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xfffffff0,
>          .pvr_value        = 0x00082210,
>          .cpu_name        = "750CXe",
> -        .cpu_features        = CPU_FTR_COMMON |
> -            CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE |
> -            CPU_FTR_USE_TB | CPU_FTR_L2CR | CPU_FTR_TAU |
> -            CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP,
> +        .cpu_features        = CPU_FTR_750,
>          .cpu_user_features    = COMMON_PPC,
>          .icache_bsize        = 32,
>          .dcache_bsize        = 32,
> @@ -244,10 +186,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffffffff,
>          .pvr_value        = 0x00083214,
>          .cpu_name        = "750CXe",
> -        .cpu_features        = CPU_FTR_COMMON |
> -            CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE |
> -            CPU_FTR_USE_TB | CPU_FTR_L2CR | CPU_FTR_TAU |
> -            CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP,
> +        .cpu_features        = CPU_FTR_750,
>          .cpu_user_features    = COMMON_PPC,
>          .icache_bsize        = 32,
>          .dcache_bsize        = 32,
> @@ -258,10 +197,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xfffff000,
>          .pvr_value        = 0x00083000,
>          .cpu_name        = "745/755",
> -        .cpu_features        = CPU_FTR_COMMON |
> -            CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE |
> -            CPU_FTR_USE_TB | CPU_FTR_L2CR | CPU_FTR_TAU |
> -            CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP,
> +        .cpu_features        = CPU_FTR_750,
>          .cpu_user_features    = COMMON_PPC,
>          .icache_bsize        = 32,
>          .dcache_bsize        = 32,
> @@ -272,11 +208,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffffff00,
>          .pvr_value        = 0x70000100,
>          .cpu_name        = "750FX",
> -        .cpu_features        = CPU_FTR_COMMON |
> -            CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE |
> -            CPU_FTR_USE_TB | CPU_FTR_L2CR | CPU_FTR_TAU |
> -            CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP |
> -            CPU_FTR_DUAL_PLL_750FX | CPU_FTR_NO_DPM,
> +        .cpu_features        = CPU_FTR_750FX1,
>          .cpu_user_features    = COMMON_PPC,
>          .icache_bsize        = 32,
>          .dcache_bsize        = 32,
> @@ -287,11 +219,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffffffff,
>          .pvr_value        = 0x70000200,
>          .cpu_name        = "750FX",
> -        .cpu_features        = CPU_FTR_COMMON |
> -            CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE |
> -            CPU_FTR_USE_TB | CPU_FTR_L2CR | CPU_FTR_TAU |
> -            CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP |
> -            CPU_FTR_NO_DPM,
> +        .cpu_features        = CPU_FTR_750FX2,
>          .cpu_user_features    = COMMON_PPC,
>          .icache_bsize        = 32,
>          .dcache_bsize        = 32,
> @@ -302,11 +230,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffff0000,
>          .pvr_value        = 0x70000000,
>          .cpu_name        = "750FX",
> -        .cpu_features        = CPU_FTR_COMMON |
> -            CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE |
> -            CPU_FTR_USE_TB | CPU_FTR_L2CR | CPU_FTR_TAU |
> -            CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP |
> -            CPU_FTR_DUAL_PLL_750FX | CPU_FTR_HAS_HIGH_BATS,
> +        .cpu_features        = CPU_FTR_750FX,
>          .cpu_user_features    = COMMON_PPC,
>          .icache_bsize        = 32,
>          .dcache_bsize        = 32,
> @@ -317,11 +241,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffff0000,
>          .pvr_value        = 0x70020000,
>          .cpu_name        = "750GX",
> -        .cpu_features        = CPU_FTR_SPLIT_ID_CACHE |
> -            CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB |
> -            CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_HPTE_TABLE |
> -            CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_DUAL_PLL_750FX |
> -            CPU_FTR_HAS_HIGH_BATS,
> +        .cpu_features        = CPU_FTR_750GX,
>          .cpu_user_features    = COMMON_PPC,
>          .icache_bsize        = 32,
>          .dcache_bsize        = 32,
> @@ -332,10 +252,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffff0000,
>          .pvr_value        = 0x00080000,
>          .cpu_name        = "740/750",
> -        .cpu_features        = CPU_FTR_COMMON |
> -            CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE |
> -            CPU_FTR_USE_TB | CPU_FTR_L2CR | CPU_FTR_TAU |
> -            CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP,
> +        .cpu_features        = CPU_FTR_740,
>          .cpu_user_features    = COMMON_PPC,
>          .icache_bsize        = 32,
>          .dcache_bsize        = 32,
> @@ -346,11 +263,8 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffffffff,
>          .pvr_value        = 0x000c1101,
>          .cpu_name        = "7400 (1.1)",
> -        .cpu_features        = CPU_FTR_COMMON |
> -            CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE |
> -            CPU_FTR_USE_TB | CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP |
> -            CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP,
> -        .cpu_user_features    = COMMON_PPC |  
> PPC_FEATURE_ALTIVEC_COMP,
> +        .cpu_features        = CPU_FTR_7400_NOTAU,
> +        .cpu_user_features    = COMMON_PPC |  
> PPC_FEATURE_HAS_ALTIVEC_COMP,
>          .icache_bsize        = 32,
>          .dcache_bsize        = 32,
>          .num_pmcs        = 4,
> @@ -360,12 +274,8 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffff0000,
>          .pvr_value        = 0x000c0000,
>          .cpu_name        = "7400",
> -        .cpu_features        = CPU_FTR_COMMON |
> -            CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE |
> -            CPU_FTR_USE_TB | CPU_FTR_L2CR | CPU_FTR_TAU |
> -            CPU_FTR_ALTIVEC_COMP | CPU_FTR_HPTE_TABLE |
> -            CPU_FTR_MAYBE_CAN_NAP,
> -        .cpu_user_features    = COMMON_PPC |  
> PPC_FEATURE_ALTIVEC_COMP,
> +        .cpu_features        = CPU_FTR_7400,
> +        .cpu_user_features    = COMMON_PPC |  
> PPC_FEATURE_HAS_ALTIVEC_COMP,
>          .icache_bsize        = 32,
>          .dcache_bsize        = 32,
>          .num_pmcs        = 4,
> @@ -375,12 +285,8 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffff0000,
>          .pvr_value        = 0x800c0000,
>          .cpu_name        = "7410",
> -        .cpu_features        = CPU_FTR_COMMON |
> -            CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE |
> -            CPU_FTR_USE_TB | CPU_FTR_L2CR | CPU_FTR_TAU |
> -            CPU_FTR_ALTIVEC_COMP | CPU_FTR_HPTE_TABLE |
> -            CPU_FTR_MAYBE_CAN_NAP,
> -        .cpu_user_features    = COMMON_PPC |  
> PPC_FEATURE_ALTIVEC_COMP,
> +        .cpu_features        = CPU_FTR_7400,
> +        .cpu_user_features    = COMMON_PPC |  
> PPC_FEATURE_HAS_ALTIVEC_COMP,
>          .icache_bsize        = 32,
>          .dcache_bsize        = 32,
>          .num_pmcs        = 4,
> @@ -390,12 +296,8 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffffffff,
>          .pvr_value        = 0x80000200,
>          .cpu_name        = "7450",
> -        .cpu_features        = CPU_FTR_COMMON |
> -            CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
> -            CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
> -            CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 |
> -            CPU_FTR_NEED_COHERENT,
> -        .cpu_user_features    = COMMON_PPC |  
> PPC_FEATURE_ALTIVEC_COMP,
> +        .cpu_features        = CPU_FTR_7450_20,
> +        .cpu_user_features    = COMMON_PPC |  
> PPC_FEATURE_HAS_ALTIVEC_COMP,
>          .icache_bsize        = 32,
>          .dcache_bsize        = 32,
>          .num_pmcs        = 6,
> @@ -405,14 +307,8 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffffffff,
>          .pvr_value        = 0x80000201,
>          .cpu_name        = "7450",
> -        .cpu_features        = CPU_FTR_COMMON |
> -            CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
> -            CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR |
> -            CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
> -            CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 |
> -            CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_L3_DISABLE_NAP |
> -            CPU_FTR_NEED_COHERENT,
> -        .cpu_user_features    = COMMON_PPC |  
> PPC_FEATURE_ALTIVEC_COMP,
> +        .cpu_features        = CPU_FTR_7450_21,
> +        .cpu_user_features    = COMMON_PPC |  
> PPC_FEATURE_HAS_ALTIVEC_COMP,
>          .icache_bsize        = 32,
>          .dcache_bsize        = 32,
>          .num_pmcs        = 6,
> @@ -422,13 +318,8 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffff0000,
>          .pvr_value        = 0x80000000,
>          .cpu_name        = "7450",
> -        .cpu_features        = CPU_FTR_COMMON |
> -            CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
> -            CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR |
> -            CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
> -            CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 |
> -            CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_NEED_COHERENT,
> -        .cpu_user_features    = COMMON_PPC |  
> PPC_FEATURE_ALTIVEC_COMP,
> +        .cpu_features        = CPU_FTR_7450_23,
> +        .cpu_user_features    = COMMON_PPC |  
> PPC_FEATURE_HAS_ALTIVEC_COMP,
>          .icache_bsize        = 32,
>          .dcache_bsize        = 32,
>          .num_pmcs        = 6,
> @@ -438,12 +329,8 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffffff00,
>          .pvr_value        = 0x80010100,
>          .cpu_name        = "7455",
> -        .cpu_features        = CPU_FTR_COMMON |
> -            CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
> -            CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
> -            CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 |
> -            CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NEED_COHERENT,
> -        .cpu_user_features    = COMMON_PPC |  
> PPC_FEATURE_ALTIVEC_COMP,
> +        .cpu_features        = CPU_FTR_7455_1,
> +        .cpu_user_features    = COMMON_PPC |  
> PPC_FEATURE_HAS_ALTIVEC_COMP,
>          .icache_bsize        = 32,
>          .dcache_bsize        = 32,
>          .num_pmcs        = 6,
> @@ -453,14 +340,8 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffffffff,
>          .pvr_value        = 0x80010200,
>          .cpu_name        = "7455",
> -        .cpu_features        = CPU_FTR_COMMON |
> -            CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
> -            CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR |
> -            CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
> -            CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 |
> -            CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_L3_DISABLE_NAP |
> -            CPU_FTR_NEED_COHERENT | CPU_FTR_HAS_HIGH_BATS,
> -        .cpu_user_features    = COMMON_PPC |  
> PPC_FEATURE_ALTIVEC_COMP,
> +        .cpu_features        = CPU_FTR_7455_20,
> +        .cpu_user_features    = COMMON_PPC |  
> PPC_FEATURE_HAS_ALTIVEC_COMP,
>          .icache_bsize        = 32,
>          .dcache_bsize        = 32,
>          .num_pmcs        = 6,
> @@ -470,14 +351,8 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffff0000,
>          .pvr_value        = 0x80010000,
>          .cpu_name        = "7455",
> -        .cpu_features        = CPU_FTR_COMMON |
> -            CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
> -            CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR |
> -            CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
> -            CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 |
> -            CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_HAS_HIGH_BATS |
> -            CPU_FTR_NEED_COHERENT,
> -        .cpu_user_features    = COMMON_PPC |  
> PPC_FEATURE_ALTIVEC_COMP,
> +        .cpu_features        = CPU_FTR_7455,
> +        .cpu_user_features    = COMMON_PPC |  
> PPC_FEATURE_HAS_ALTIVEC_COMP,
>          .icache_bsize        = 32,
>          .dcache_bsize        = 32,
>          .num_pmcs        = 6,
> @@ -487,14 +362,8 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffffffff,
>          .pvr_value        = 0x80020100,
>          .cpu_name        = "7447/7457",
> -        .cpu_features        = CPU_FTR_COMMON |
> -            CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
> -            CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR |
> -            CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
> -            CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 |
> -            CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_HAS_HIGH_BATS |
> -            CPU_FTR_NEED_COHERENT | CPU_FTR_NO_BTIC,
> -        .cpu_user_features    = COMMON_PPC |  
> PPC_FEATURE_ALTIVEC_COMP,
> +        .cpu_features        = CPU_FTR_7447_10,
> +        .cpu_user_features    = COMMON_PPC |  
> PPC_FEATURE_HAS_ALTIVEC_COMP,
>          .icache_bsize        = 32,
>          .dcache_bsize        = 32,
>          .num_pmcs        = 6,
> @@ -504,14 +373,8 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffffffff,
>          .pvr_value        = 0x80020101,
>          .cpu_name        = "7447/7457",
> -        .cpu_features        = CPU_FTR_COMMON |
> -            CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
> -            CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR |
> -            CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
> -            CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 |
> -            CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_HAS_HIGH_BATS |
> -            CPU_FTR_NEED_COHERENT | CPU_FTR_NO_BTIC,
> -        .cpu_user_features    = COMMON_PPC |  
> PPC_FEATURE_ALTIVEC_COMP,
> +        .cpu_features        = CPU_FTR_7447_10,
> +        .cpu_user_features    = COMMON_PPC |  
> PPC_FEATURE_HAS_ALTIVEC_COMP,
>          .icache_bsize        = 32,
>          .dcache_bsize        = 32,
>          .num_pmcs        = 6,
> @@ -521,14 +384,8 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffff0000,
>          .pvr_value        = 0x80020000,
>          .cpu_name        = "7447/7457",
> -        .cpu_features        = CPU_FTR_COMMON |
> -            CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
> -            CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR |
> -            CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
> -            CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 |
> -            CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_HAS_HIGH_BATS |
> -            CPU_FTR_NEED_COHERENT,
> -        .cpu_user_features    = COMMON_PPC |  
> PPC_FEATURE_ALTIVEC_COMP,
> +        .cpu_features        = CPU_FTR_7447,
> +        .cpu_user_features    = COMMON_PPC |  
> PPC_FEATURE_HAS_ALTIVEC_COMP,
>          .icache_bsize        = 32,
>          .dcache_bsize        = 32,
>          .num_pmcs        = 6,
> @@ -538,13 +395,8 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffff0000,
>          .pvr_value        = 0x80030000,
>          .cpu_name        = "7447A",
> -        .cpu_features        = CPU_FTR_COMMON |
> -            CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
> -            CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR |
> -            CPU_FTR_ALTIVEC_COMP | CPU_FTR_HPTE_TABLE |
> -            CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
> -            CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NEED_COHERENT,
> -        .cpu_user_features    = COMMON_PPC |  
> PPC_FEATURE_ALTIVEC_COMP,
> +        .cpu_features        = CPU_FTR_7447A,
> +        .cpu_user_features    = COMMON_PPC |  
> PPC_FEATURE_HAS_ALTIVEC_COMP,
>          .icache_bsize        = 32,
>          .dcache_bsize        = 32,
>          .num_pmcs        = 6,
> @@ -554,13 +406,8 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffff0000,
>          .pvr_value        = 0x80040000,
>          .cpu_name        = "7448",
> -        .cpu_features        = CPU_FTR_COMMON |
> -            CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
> -            CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR |
> -            CPU_FTR_ALTIVEC_COMP | CPU_FTR_HPTE_TABLE |
> -            CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
> -            CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NEED_COHERENT,
> -        .cpu_user_features    = COMMON_PPC |  
> PPC_FEATURE_ALTIVEC_COMP,
> +        .cpu_features        = CPU_FTR_7447A,
> +        .cpu_user_features    = COMMON_PPC |  
> PPC_FEATURE_HAS_ALTIVEC_COMP,
>          .icache_bsize        = 32,
>          .dcache_bsize        = 32,
>          .num_pmcs        = 6,
> @@ -570,9 +417,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0x7fff0000,
>          .pvr_value        = 0x00810000,
>          .cpu_name        = "82xx",
> -        .cpu_features        = CPU_FTR_COMMON |
> -            CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE |
> -            CPU_FTR_USE_TB,
> +        .cpu_features        = CPU_FTR_82XX,
>          .cpu_user_features    = COMMON_PPC,
>          .icache_bsize        = 32,
>          .dcache_bsize        = 32,
> @@ -582,9 +427,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0x7fff0000,
>          .pvr_value        = 0x00820000,
>          .cpu_name        = "G2_LE",
> -        .cpu_features        = CPU_FTR_SPLIT_ID_CACHE |
> -            CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB |
> -            CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_HAS_HIGH_BATS,
> +        .cpu_features        = CPU_FTR_G2_LE,
>          .cpu_user_features    = COMMON_PPC,
>          .icache_bsize        = 32,
>          .dcache_bsize        = 32,
> @@ -594,9 +437,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0x7fff0000,
>          .pvr_value        = 0x00830000,
>          .cpu_name        = "e300",
> -        .cpu_features        = CPU_FTR_SPLIT_ID_CACHE |
> -            CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB |
> -            CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_HAS_HIGH_BATS,
> +        .cpu_features        = CPU_FTR_E300,
>          .cpu_user_features    = COMMON_PPC,
>          .icache_bsize        = 32,
>          .dcache_bsize        = 32,
> @@ -606,9 +447,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0x00000000,
>          .pvr_value        = 0x00000000,
>          .cpu_name        = "(generic PPC)",
> -        .cpu_features        = CPU_FTR_COMMON |
> -            CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
> -            CPU_FTR_HPTE_TABLE,
> +        .cpu_features        = CPU_FTR_CLASSIC32,
>          .cpu_user_features    = COMMON_PPC,
>          .icache_bsize        = 32,
>          .dcache_bsize        = 32,
> @@ -620,9 +459,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffff0000,
>          .pvr_value        = 0x00400000,
>          .cpu_name        = "Power3 (630)",
> -        .cpu_features        = CPU_FTR_COMMON |
> -            CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
> -            CPU_FTR_HPTE_TABLE,
> +        .cpu_features        = CPU_FTR_POWER3_32,
>          .cpu_user_features    = COMMON_PPC | PPC_FEATURE_64,
>          .icache_bsize        = 128,
>          .dcache_bsize        = 128,
> @@ -633,9 +470,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffff0000,
>          .pvr_value        = 0x00410000,
>          .cpu_name        = "Power3 (630+)",
> -        .cpu_features        = CPU_FTR_COMMON |
> -            CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
> -            CPU_FTR_HPTE_TABLE,
> +        .cpu_features        = CPU_FTR_POWER3_32,
>          .cpu_user_features    = COMMON_PPC | PPC_FEATURE_64,
>          .icache_bsize        = 128,
>          .dcache_bsize        = 128,
> @@ -646,9 +481,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffff0000,
>          .pvr_value        = 0x00360000,
>          .cpu_name        = "I-star",
> -        .cpu_features        = CPU_FTR_COMMON |
> -            CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
> -            CPU_FTR_HPTE_TABLE,
> +        .cpu_features        = CPU_FTR_POWER3_32,
>          .cpu_user_features    = COMMON_PPC | PPC_FEATURE_64,
>          .icache_bsize        = 128,
>          .dcache_bsize        = 128,
> @@ -659,55 +492,19 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffff0000,
>          .pvr_value        = 0x00370000,
>          .cpu_name        = "S-star",
> -        .cpu_features        = CPU_FTR_COMMON |
> -            CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
> -            CPU_FTR_HPTE_TABLE,
> +        .cpu_features        = CPU_FTR_POWER3_32,
>          .cpu_user_features    = COMMON_PPC | PPC_FEATURE_64,
>          .icache_bsize        = 128,
>          .dcache_bsize        = 128,
>          .num_pmcs        = 8,
>          .cpu_setup        = __setup_cpu_power3
>      },
> -#endif /* CONFIG_PPC64BRIDGE */
> -#ifdef CONFIG_POWER4
> -    {    /* Power4 */
> -        .pvr_mask        = 0xffff0000,
> -        .pvr_value        = 0x00350000,
> -        .cpu_name        = "Power4",
> -        .cpu_features        = CPU_FTR_COMMON |
> -            CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
> -            CPU_FTR_HPTE_TABLE,
> -        .cpu_user_features    = COMMON_PPC | PPC_FEATURE_64,
> -        .icache_bsize        = 128,
> -        .dcache_bsize        = 128,
> -        .num_pmcs        = 8,
> -        .cpu_setup        = __setup_cpu_power4
> -    },
> -    {    /* PPC970 */
> -        .pvr_mask        = 0xffff0000,
> -        .pvr_value        = 0x00390000,
> -        .cpu_name        = "PPC970",
> -        .cpu_features        = CPU_FTR_COMMON |
> -            CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
> -            CPU_FTR_HPTE_TABLE |
> -            CPU_FTR_ALTIVEC_COMP | CPU_FTR_MAYBE_CAN_NAP,
> -        .cpu_user_features    = COMMON_PPC | PPC_FEATURE_64 |
> -            PPC_FEATURE_ALTIVEC_COMP,
> -        .icache_bsize        = 128,
> -        .dcache_bsize        = 128,
> -        .num_pmcs        = 8,
> -        .cpu_setup        = __setup_cpu_ppc970
> -    },
>      {    /* PPC970FX */
>          .pvr_mask        = 0xffff0000,
>          .pvr_value        = 0x003c0000,
>          .cpu_name        = "PPC970FX",
> -        .cpu_features        = CPU_FTR_COMMON |
> -            CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
> -            CPU_FTR_HPTE_TABLE |
> -            CPU_FTR_ALTIVEC_COMP | CPU_FTR_MAYBE_CAN_NAP,
> -        .cpu_user_features    = COMMON_PPC | PPC_FEATURE_64 |
> -            PPC_FEATURE_ALTIVEC_COMP,
> +        .cpu_features        = CPU_FTR_970_32,
> +        .cpu_user_features    = COMMON_PPC | PPC_FEATURE_64 |  
> PPC_FEATURE_HAS_ALTIVEC_COMP,
>          .icache_bsize        = 128,
>          .dcache_bsize        = 128,
>          .num_pmcs        = 8,
> @@ -721,8 +518,7 @@ struct cpu_spec    cpu_specs[] = {
>          .cpu_name        = "8xx",
>          /* CPU_FTR_MAYBE_CAN_DOZE is possible,
>           * if the 8xx code is there.... */
> -        .cpu_features        = CPU_FTR_SPLIT_ID_CACHE |
> -            CPU_FTR_USE_TB,
> +        .cpu_features        = CPU_FTR_8XX,
>          .cpu_user_features    = PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
>          .icache_bsize        = 16,
>          .dcache_bsize        = 16,
> @@ -733,8 +529,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffffff00,
>          .pvr_value        = 0x00200200,
>          .cpu_name        = "403GC",
> -        .cpu_features        = CPU_FTR_SPLIT_ID_CACHE |
> -            CPU_FTR_USE_TB,
> +        .cpu_features        = CPU_FTR_40X,
>          .cpu_user_features    = PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
>          .icache_bsize        = 16,
>          .dcache_bsize        = 16,
> @@ -743,8 +538,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffffff00,
>          .pvr_value        = 0x00201400,
>          .cpu_name        = "403GCX",
> -        .cpu_features        = CPU_FTR_SPLIT_ID_CACHE |
> -            CPU_FTR_USE_TB,
> +        .cpu_features        = CPU_FTR_40X,
>          .cpu_user_features    = PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
>          .icache_bsize        = 16,
>          .dcache_bsize        = 16,
> @@ -753,8 +547,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffff0000,
>          .pvr_value        = 0x00200000,
>          .cpu_name        = "403G ??",
> -        .cpu_features        = CPU_FTR_SPLIT_ID_CACHE |
> -            CPU_FTR_USE_TB,
> +        .cpu_features        = CPU_FTR_40X,
>          .cpu_user_features    = PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
>          .icache_bsize        = 16,
>          .dcache_bsize        = 16,
> @@ -763,8 +556,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffff0000,
>          .pvr_value        = 0x40110000,
>          .cpu_name        = "405GP",
> -        .cpu_features        = CPU_FTR_SPLIT_ID_CACHE |
> -            CPU_FTR_USE_TB,
> +        .cpu_features        = CPU_FTR_40X,
>          .cpu_user_features    = PPC_FEATURE_32 |
>              PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
>          .icache_bsize        = 32,
> @@ -774,8 +566,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffff0000,
>          .pvr_value        = 0x40130000,
>          .cpu_name        = "STB03xxx",
> -        .cpu_features        = CPU_FTR_SPLIT_ID_CACHE |
> -            CPU_FTR_USE_TB,
> +        .cpu_features        = CPU_FTR_40X,
>          .cpu_user_features    = PPC_FEATURE_32 |
>              PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
>          .icache_bsize        = 32,
> @@ -785,8 +576,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffff0000,
>          .pvr_value        = 0x41810000,
>          .cpu_name        = "STB04xxx",
> -        .cpu_features        = CPU_FTR_SPLIT_ID_CACHE |
> -            CPU_FTR_USE_TB,
> +        .cpu_features        = CPU_FTR_40X,
>          .cpu_user_features    = PPC_FEATURE_32 |
>              PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
>          .icache_bsize        = 32,
> @@ -796,8 +586,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffff0000,
>          .pvr_value        = 0x41610000,
>          .cpu_name        = "NP405L",
> -        .cpu_features        = CPU_FTR_SPLIT_ID_CACHE |
> -            CPU_FTR_USE_TB,
> +        .cpu_features        = CPU_FTR_40X,
>          .cpu_user_features    = PPC_FEATURE_32 |
>              PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
>          .icache_bsize        = 32,
> @@ -807,8 +596,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffff0000,
>          .pvr_value        = 0x40B10000,
>          .cpu_name        = "NP4GS3",
> -        .cpu_features        = CPU_FTR_SPLIT_ID_CACHE |
> -            CPU_FTR_USE_TB,
> +        .cpu_features        = CPU_FTR_40X,
>          .cpu_user_features    = PPC_FEATURE_32 |
>              PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
>          .icache_bsize        = 32,
> @@ -818,8 +606,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffff0000,
>          .pvr_value        = 0x41410000,
>          .cpu_name        = "NP405H",
> -        .cpu_features        = CPU_FTR_SPLIT_ID_CACHE |
> -            CPU_FTR_USE_TB,
> +        .cpu_features        = CPU_FTR_40X,
>          .cpu_user_features    = PPC_FEATURE_32 |
>              PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
>          .icache_bsize        = 32,
> @@ -829,8 +616,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffff0000,
>          .pvr_value        = 0x50910000,
>          .cpu_name        = "405GPr",
> -        .cpu_features        = CPU_FTR_SPLIT_ID_CACHE |
> -            CPU_FTR_USE_TB,
> +        .cpu_features        = CPU_FTR_40X,
>          .cpu_user_features    = PPC_FEATURE_32 |
>              PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
>          .icache_bsize        = 32,
> @@ -840,8 +626,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffff0000,
>          .pvr_value        = 0x51510000,
>          .cpu_name        = "STBx25xx",
> -        .cpu_features        = CPU_FTR_SPLIT_ID_CACHE |
> -            CPU_FTR_USE_TB,
> +        .cpu_features        = CPU_FTR_40X,
>          .cpu_user_features    = PPC_FEATURE_32 |
>              PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
>          .icache_bsize        = 32,
> @@ -851,8 +636,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffff0000,
>          .pvr_value        = 0x41F10000,
>          .cpu_name        = "405LP",
> -        .cpu_features        = CPU_FTR_SPLIT_ID_CACHE |
> -            CPU_FTR_USE_TB,
> +        .cpu_features        = CPU_FTR_40X,
>          .cpu_user_features    = PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
>          .icache_bsize        = 32,
>          .dcache_bsize        = 32,
> @@ -861,8 +645,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffff0000,
>          .pvr_value        = 0x20010000,
>          .cpu_name        = "Virtex-II Pro",
> -        .cpu_features        = CPU_FTR_SPLIT_ID_CACHE |
> -            CPU_FTR_USE_TB,
> +        .cpu_features        = CPU_FTR_40X,
>          .cpu_user_features    = PPC_FEATURE_32 |
>              PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
>          .icache_bsize        = 32,
> @@ -872,8 +655,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xffff0000,
>          .pvr_value        = 0x51210000,
>          .cpu_name        = "405EP",
> -        .cpu_features        = CPU_FTR_SPLIT_ID_CACHE |
> -            CPU_FTR_USE_TB,
> +        .cpu_features        = CPU_FTR_40X,
>          .cpu_user_features    = PPC_FEATURE_32 |
>              PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
>          .icache_bsize        = 32,
> @@ -886,8 +668,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xf0000fff,
>          .pvr_value        = 0x40000850,
>          .cpu_name        = "440EP Rev. A",
> -        .cpu_features        = CPU_FTR_SPLIT_ID_CACHE |
> -            CPU_FTR_USE_TB,
> +        .cpu_features        = CPU_FTR_44X,
>          .cpu_user_features    = COMMON_PPC, /* 440EP has an FPU */
>          .icache_bsize        = 32,
>          .dcache_bsize        = 32,
> @@ -896,8 +677,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xf0000fff,
>          .pvr_value        = 0x400008d3,
>          .cpu_name        = "440EP Rev. B",
> -        .cpu_features        = CPU_FTR_SPLIT_ID_CACHE |
> -            CPU_FTR_USE_TB,
> +        .cpu_features        = CPU_FTR_44X,
>          .cpu_user_features    = COMMON_PPC, /* 440EP has an FPU */
>          .icache_bsize        = 32,
>          .dcache_bsize        = 32,
> @@ -906,8 +686,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xf0000fff,
>          .pvr_value        = 0x40000440,
>          .cpu_name        = "440GP Rev. B",
> -        .cpu_features        = CPU_FTR_SPLIT_ID_CACHE |
> -            CPU_FTR_USE_TB,
> +        .cpu_features        = CPU_FTR_44X,
>          .cpu_user_features    = PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
>          .icache_bsize        = 32,
>          .dcache_bsize        = 32,
> @@ -916,8 +695,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xf0000fff,
>          .pvr_value        = 0x40000481,
>          .cpu_name        = "440GP Rev. C",
> -        .cpu_features        = CPU_FTR_SPLIT_ID_CACHE |
> -            CPU_FTR_USE_TB,
> +        .cpu_features        = CPU_FTR_44X,
>          .cpu_user_features    = PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
>          .icache_bsize        = 32,
>          .dcache_bsize        = 32,
> @@ -926,8 +704,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xf0000fff,
>          .pvr_value        = 0x50000850,
>          .cpu_name        = "440GX Rev. A",
> -        .cpu_features        = CPU_FTR_SPLIT_ID_CACHE |
> -            CPU_FTR_USE_TB,
> +        .cpu_features        = CPU_FTR_44X,
>          .cpu_user_features    = PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
>          .icache_bsize        = 32,
>          .dcache_bsize        = 32,
> @@ -936,8 +713,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xf0000fff,
>          .pvr_value        = 0x50000851,
>          .cpu_name        = "440GX Rev. B",
> -        .cpu_features        = CPU_FTR_SPLIT_ID_CACHE |
> -            CPU_FTR_USE_TB,
> +        .cpu_features        = CPU_FTR_44X,
>          .cpu_user_features    = PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
>          .icache_bsize        = 32,
>          .dcache_bsize        = 32,
> @@ -946,8 +722,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xf0000fff,
>          .pvr_value        = 0x50000892,
>          .cpu_name        = "440GX Rev. C",
> -        .cpu_features        = CPU_FTR_SPLIT_ID_CACHE |
> -            CPU_FTR_USE_TB,
> +        .cpu_features        = CPU_FTR_44X,
>          .cpu_user_features    = PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
>          .icache_bsize        = 32,
>          .dcache_bsize        = 32,
> @@ -956,8 +731,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xf0000fff,
>          .pvr_value        = 0x50000894,
>          .cpu_name        = "440GX Rev. F",
> -        .cpu_features        = CPU_FTR_SPLIT_ID_CACHE |
> -            CPU_FTR_USE_TB,
> +        .cpu_features        = CPU_FTR_44X,
>          .cpu_user_features    = PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
>          .icache_bsize        = 32,
>          .dcache_bsize        = 32,
> @@ -966,8 +740,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0xff000fff,
>          .pvr_value        = 0x53000891,
>          .cpu_name        = "440SP Rev. A",
> -        .cpu_features        = CPU_FTR_SPLIT_ID_CACHE |
> -            CPU_FTR_USE_TB,
> +        .cpu_features        = CPU_FTR_44X,
>          .cpu_user_features    = PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
>          .icache_bsize        = 32,
>          .dcache_bsize        = 32,
> @@ -979,7 +752,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_value        = 0x81000000,
>          .cpu_name        = "e200z5",
>          /* xxx - galak: add CPU_FTR_MAYBE_CAN_DOZE */
> -        .cpu_features        = CPU_FTR_USE_TB,
> +        .cpu_features        = CPU_FTR_E200,
>          .cpu_user_features    = PPC_FEATURE_32 |
>              PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_EFP_SINGLE |
>              PPC_FEATURE_UNIFIED_CACHE,
> @@ -990,7 +763,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_value        = 0x81100000,
>          .cpu_name        = "e200z6",
>          /* xxx - galak: add CPU_FTR_MAYBE_CAN_DOZE */
> -        .cpu_features        = CPU_FTR_USE_TB,
> +        .cpu_features        = CPU_FTR_E200,
>          .cpu_user_features    = PPC_FEATURE_32 |
>              PPC_FEATURE_HAS_MMU | PPC_FEATURE_SPE_COMP |
>              PPC_FEATURE_HAS_EFP_SINGLE |
> @@ -1002,8 +775,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_value        = 0x80200000,
>          .cpu_name        = "e500",
>          /* xxx - galak: add CPU_FTR_MAYBE_CAN_DOZE */
> -        .cpu_features        = CPU_FTR_SPLIT_ID_CACHE |
> -            CPU_FTR_USE_TB,
> +        .cpu_features        = CPU_FTR_E500,
>          .cpu_user_features    = PPC_FEATURE_32 |
>              PPC_FEATURE_HAS_MMU | PPC_FEATURE_SPE_COMP |
>              PPC_FEATURE_HAS_EFP_SINGLE,
> @@ -1016,8 +788,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_value        = 0x80210000,
>          .cpu_name        = "e500v2",
>          /* xxx - galak: add CPU_FTR_MAYBE_CAN_DOZE */
> -        .cpu_features        = CPU_FTR_SPLIT_ID_CACHE |
> -            CPU_FTR_USE_TB | CPU_FTR_BIG_PHYS,
> +        .cpu_features        = CPU_FTR_E500_2,
>          .cpu_user_features    = PPC_FEATURE_32 |
>              PPC_FEATURE_HAS_MMU | PPC_FEATURE_SPE_COMP |
>              PPC_FEATURE_HAS_EFP_SINGLE | PPC_FEATURE_HAS_EFP_DOUBLE,
> @@ -1031,7 +802,7 @@ struct cpu_spec    cpu_specs[] = {
>          .pvr_mask        = 0x00000000,
>          .pvr_value        = 0x00000000,
>          .cpu_name        = "(generic PPC)",
> -        .cpu_features        = CPU_FTR_COMMON,
> +        .cpu_features        = CPU_FTR_GENERIC_32,
>          .cpu_user_features    = PPC_FEATURE_32,
>          .icache_bsize        = 32,
>          .dcache_bsize        = 32,
> Index: clean-cg/include/asm-powerpc/cputable.h
> ===================================================================
> --- /dev/null
> +++ clean-cg/include/asm-powerpc/cputable.h
> @@ -0,0 +1,475 @@
> +#ifndef __ASM_POWERPC_CPUTABLE_H
> +#define __ASM_POWERPC_CPUTABLE_H
> +
> +#ifdef __KERNEL__
> +#include <linux/config.h>
> +#include <asm/ppc_asm.h> /* for ASM_CONST */
> +
> +#define PPC_FEATURE_32            0x80000000
> +#define PPC_FEATURE_64            0x40000000
> +#define PPC_FEATURE_601_INSTR        0x20000000
> +#define PPC_FEATURE_HAS_ALTIVEC        0x10000000
> +#define PPC_FEATURE_HAS_FPU        0x08000000
> +#define PPC_FEATURE_HAS_MMU        0x04000000
> +#define PPC_FEATURE_HAS_4xxMAC        0x02000000
> +#define PPC_FEATURE_UNIFIED_CACHE    0x01000000
> +#define PPC_FEATURE_HAS_SPE        0x00800000
> +#define PPC_FEATURE_HAS_EFP_SINGLE    0x00400000
> +#define PPC_FEATURE_HAS_EFP_DOUBLE    0x00200000
> +
> +#ifndef __ASSEMBLY__
> +
> +/* This structure can grow, it's real size is used by head.S code
> + * via the mkdefs mechanism.
> + */
> +struct cpu_spec;
> +struct op_ppc64_model;
> +
> +#ifndef __powerpc64__
> +typedef    void (*cpu_setup_t)(unsigned long offset, int cpu_nr,  
> struct cpu_spec* spec);
> +#else /* __powerpc64__ */
> +typedef    void (*cpu_setup_t)(unsigned long offset, struct  
> cpu_spec* spec);
> +#endif /* __powerpc64__ */
> +
> +struct cpu_spec {
> +    /* CPU is matched via (PVR & pvr_mask) == pvr_value */
> +    unsigned int    pvr_mask;
> +    unsigned int    pvr_value;
> +
> +    char        *cpu_name;
> +    unsigned long    cpu_features;        /* Kernel features */
> +    unsigned int    cpu_user_features;    /* Userland features */
> +
> +    /* cache line sizes */
> +    unsigned int    icache_bsize;
> +    unsigned int    dcache_bsize;
> +
> +    /* number of performance monitor counters */
> +    unsigned int    num_pmcs;
> +
> +    /* this is called to initialize various CPU bits like L1 cache,
> +     * BHT, SPD, etc... from head.S before branching to  
> identify_machine
> +     */
> +    cpu_setup_t    cpu_setup;
> +#ifdef __powerpc64__
> +
> +    /* Used by oprofile userspace to select the right counters */
> +    char        *oprofile_cpu_type;
> +
> +    /* Processor specific oprofile operations */
> +    struct op_ppc64_model *oprofile_model;
> +#endif /* __powerpc64__ */
> +};
> +
> +extern struct cpu_spec        cpu_specs[];
> +
> +#ifndef __powerpc64__
> +extern struct cpu_spec        *cur_cpu_spec[];
> +#else /* __powerpc64__ */
> +extern struct cpu_spec        *cur_cpu_spec;
> +#endif /* __powerpc64__ */
> +
> +#endif /* __ASSEMBLY__ */
> +
> +/* CPU kernel features */
> +
> +/* Retain the 32b definitions all use bottom half of word */
> +#define CPU_FTR_SPLIT_ID_CACHE        ASM_CONST(0x0000000000000001)
> +#define CPU_FTR_L2CR            ASM_CONST(0x0000000000000002)
> +#define CPU_FTR_SPEC7450        ASM_CONST(0x0000000000000004)
> +#define CPU_FTR_ALTIVEC            ASM_CONST(0x0000000000000008)
> +#define CPU_FTR_TAU            ASM_CONST(0x0000000000000010)
> +#define CPU_FTR_CAN_DOZE        ASM_CONST(0x0000000000000020)
> +#define CPU_FTR_USE_TB            ASM_CONST(0x0000000000000040)
> +#define CPU_FTR_604_PERF_MON        ASM_CONST(0x0000000000000080)
> +#define CPU_FTR_601            ASM_CONST(0x0000000000000100)
> +#define CPU_FTR_HPTE_TABLE        ASM_CONST(0x0000000000000200)
> +#define CPU_FTR_CAN_NAP            ASM_CONST(0x0000000000000400)
> +#define CPU_FTR_L3CR            ASM_CONST(0x0000000000000800)
> +#define CPU_FTR_L3_DISABLE_NAP        ASM_CONST(0x0000000000001000)
> +#define CPU_FTR_NAP_DISABLE_L2_PR    ASM_CONST(0x0000000000002000)
> +#define CPU_FTR_DUAL_PLL_750FX        ASM_CONST(0x0000000000004000)
> +#define CPU_FTR_NO_DPM            ASM_CONST(0x0000000000008000)
> +#define CPU_FTR_HAS_HIGH_BATS        ASM_CONST(0x0000000000010000)
> +#define CPU_FTR_NEED_COHERENT        ASM_CONST(0x0000000000020000)
> +#define CPU_FTR_NO_BTIC            ASM_CONST(0x0000000000040000)
> +#define CPU_FTR_BIG_PHYS        ASM_CONST(0x0000000000080000)
> +
> +#ifdef __powerpc64__
> +/* Add the 64b processor unique features in the top half of the  
> word */
> +#define CPU_FTR_SLB                   ASM_CONST(0x0000000100000000)
> +#define CPU_FTR_16M_PAGE              ASM_CONST(0x0000000200000000)
> +#define CPU_FTR_TLBIEL                 ASM_CONST(0x0000000400000000)
> +#define CPU_FTR_NOEXECUTE             ASM_CONST(0x0000000800000000)
> +#define CPU_FTR_NODSISRALIGN          ASM_CONST(0x0000001000000000)
> +#define CPU_FTR_IABR              ASM_CONST(0x0000002000000000)
> +#define CPU_FTR_MMCRA              ASM_CONST(0x0000004000000000)
> +/* unused                 ASM_CONST(0x0000008000000000) */
> +#define CPU_FTR_SMT              ASM_CONST(0x0000010000000000)
> +#define CPU_FTR_COHERENT_ICACHE      ASM_CONST(0x0000020000000000)
> +#define CPU_FTR_LOCKLESS_TLBIE        ASM_CONST(0x0000040000000000)
> +#define CPU_FTR_MMCRA_SIHV        ASM_CONST(0x0000080000000000)
> +#define CPU_FTR_CTRL            ASM_CONST(0x0000100000000000)
> +#endif
> +
> +#ifndef __ASSEMBLY__
> +
> +#define COMMON_USER_PPC64    (PPC_FEATURE_32 | PPC_FEATURE_64 | \
> +                 PPC_FEATURE_HAS_FPU | PPC_FEATURE_HAS_MMU)
> +
> +#define CPU_FTR_PPCAS_ARCH_V2_BASE (CPU_FTR_SLB | \
> +                    CPU_FTR_TLBIEL | CPU_FTR_NOEXECUTE | \
> +                    CPU_FTR_NODSISRALIGN | CPU_FTR_CTRL)
> +
> +/* iSeries doesn't support large pages */
> +#ifdef CONFIG_PPC_ISERIES
> +#define CPU_FTR_PPCAS_ARCH_V2    (CPU_FTR_PPCAS_ARCH_V2_BASE)
> +#else
> +#define CPU_FTR_PPCAS_ARCH_V2    (CPU_FTR_PPCAS_ARCH_V2_BASE |  
> CPU_FTR_16M_PAGE)
> +#endif /* CONFIG_PPC_ISERIES */
> +
> +/* We only set the altivec features if the kernel was compiled  
> with altivec
> + * support
> + */
> +#ifdef CONFIG_ALTIVEC
> +#define CPU_FTR_ALTIVEC_COMP    CPU_FTR_ALTIVEC
> +#define PPC_FEATURE_HAS_ALTIVEC_COMP PPC_FEATURE_HAS_ALTIVEC
> +#else
> +#define CPU_FTR_ALTIVEC_COMP    0
> +#define PPC_FEATURE_HAS_ALTIVEC_COMP    0
> +#endif
> +
> +/* We need to mark all pages as being coherent if we're SMP or we
> + * have a 74[45]x and an MPC107 host bridge.
> + */
> +#if defined(CONFIG_SMP) || defined(CONFIG_MPC10X_BRIDGE)
> +#define CPU_FTR_COMMON                  CPU_FTR_NEED_COHERENT
> +#else
> +#define CPU_FTR_COMMON                  0
> +#endif
> +
> +/* The powersave features NAP & DOZE seems to confuse BDI when
> +   debugging. So if a BDI is used, disable theses
> + */
> +#ifndef CONFIG_BDI_SWITCH
> +#define CPU_FTR_MAYBE_CAN_DOZE    CPU_FTR_CAN_DOZE
> +#define CPU_FTR_MAYBE_CAN_NAP    CPU_FTR_CAN_NAP
> +#else
> +#define CPU_FTR_MAYBE_CAN_DOZE    0
> +#define CPU_FTR_MAYBE_CAN_NAP    0
> +#endif
> +
> +#define CLASSIC_PPC (!defined(CONFIG_8xx) && !defined(CONFIG_4xx)  
> && \
> +             !defined(CONFIG_POWER3) && !defined(CONFIG_POWER4) && \
> +             !defined(CONFIG_BOOKE))
> +
> +enum {
> +    CPU_FTR_PPC601 = CPU_FTR_COMMON | CPU_FTR_601 |  
> CPU_FTR_HPTE_TABLE,
> +    CPU_FTR_603 = CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE |
> +        CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB |
> +        CPU_FTR_MAYBE_CAN_NAP,
> +    CPU_FTR_604 = CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE |
> +        CPU_FTR_USE_TB | CPU_FTR_604_PERF_MON | CPU_FTR_HPTE_TABLE,
> +    CPU_FTR_740_NOTAU = CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE |
> +        CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | CPU_FTR_L2CR |
> +        CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP,
> +    CPU_FTR_740 = CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE |
> +        CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | CPU_FTR_L2CR |
> +        CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP,
> +    CPU_FTR_750 = CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE |
> +        CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | CPU_FTR_L2CR |
> +        CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP,
> +    CPU_FTR_750FX1 = CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE |
> +        CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | CPU_FTR_L2CR |
> +        CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP |
> +        CPU_FTR_DUAL_PLL_750FX | CPU_FTR_NO_DPM,
> +    CPU_FTR_750FX2 = CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE |
> +        CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | CPU_FTR_L2CR |
> +        CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP |
> +        CPU_FTR_NO_DPM,
> +    CPU_FTR_750FX = CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE |
> +        CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | CPU_FTR_L2CR |
> +        CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP |
> +        CPU_FTR_DUAL_PLL_750FX | CPU_FTR_HAS_HIGH_BATS,
> +    CPU_FTR_750GX = CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE |
> +        CPU_FTR_USE_TB | CPU_FTR_L2CR | CPU_FTR_TAU |
> +        CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP |
> +        CPU_FTR_DUAL_PLL_750FX | CPU_FTR_HAS_HIGH_BATS,
> +    CPU_FTR_7400_NOTAU = CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE |
> +        CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | CPU_FTR_L2CR |
> +        CPU_FTR_ALTIVEC_COMP | CPU_FTR_HPTE_TABLE |
> +        CPU_FTR_MAYBE_CAN_NAP,
> +    CPU_FTR_7400 = CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE |
> +        CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | CPU_FTR_L2CR |
> +        CPU_FTR_TAU | CPU_FTR_ALTIVEC_COMP | CPU_FTR_HPTE_TABLE |
> +        CPU_FTR_MAYBE_CAN_NAP,
> +    CPU_FTR_7450_20 = CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE |
> +        CPU_FTR_USE_TB | CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP |
> +        CPU_FTR_L3CR | CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 |
> +        CPU_FTR_NEED_COHERENT,
> +    CPU_FTR_7450_21 = CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE |
> +        CPU_FTR_USE_TB |
> +        CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP |
> +        CPU_FTR_L3CR | CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 |
> +        CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_L3_DISABLE_NAP |
> +        CPU_FTR_NEED_COHERENT,
> +    CPU_FTR_7450_23 = CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE |
> +        CPU_FTR_USE_TB |
> +        CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP |
> +        CPU_FTR_L3CR | CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 |
> +        CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_NEED_COHERENT,
> +    CPU_FTR_7455_1 = CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE |
> +        CPU_FTR_USE_TB |
> +        CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
> +        CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 |  
> CPU_FTR_HAS_HIGH_BATS |
> +        CPU_FTR_NEED_COHERENT,
> +    CPU_FTR_7455_20 = CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE |
> +        CPU_FTR_USE_TB |
> +        CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP |
> +        CPU_FTR_L3CR | CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 |
> +        CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_L3_DISABLE_NAP |
> +        CPU_FTR_NEED_COHERENT | CPU_FTR_HAS_HIGH_BATS,
> +    CPU_FTR_7455 = CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE |
> +        CPU_FTR_USE_TB |
> +        CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP |
> +        CPU_FTR_L3CR | CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 |
> +        CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_HAS_HIGH_BATS |
> +        CPU_FTR_NEED_COHERENT,
> +    CPU_FTR_7447_10 = CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE |
> +        CPU_FTR_USE_TB |
> +        CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP |
> +        CPU_FTR_L3CR | CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 |
> +        CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_HAS_HIGH_BATS |
> +        CPU_FTR_NEED_COHERENT | CPU_FTR_NO_BTIC,
> +    CPU_FTR_7447 = CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE |
> +        CPU_FTR_USE_TB |
> +        CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP |
> +        CPU_FTR_L3CR | CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 |
> +        CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_HAS_HIGH_BATS |
> +        CPU_FTR_NEED_COHERENT,
> +    CPU_FTR_7447A = CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE |
> +        CPU_FTR_USE_TB |
> +        CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP |
> +        CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 |
> +        CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_HAS_HIGH_BATS |
> +        CPU_FTR_NEED_COHERENT,
> +    CPU_FTR_82XX = CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE |
> +        CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB,
> +    CPU_FTR_G2_LE = CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE |
> +        CPU_FTR_USE_TB | CPU_FTR_MAYBE_CAN_NAP |  
> CPU_FTR_HAS_HIGH_BATS,
> +    CPU_FTR_E300 = CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE |
> +        CPU_FTR_USE_TB | CPU_FTR_MAYBE_CAN_NAP |  
> CPU_FTR_HAS_HIGH_BATS,
> +    CPU_FTR_CLASSIC32 = CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE |
> +        CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE,
> +    CPU_FTR_POWER3_32 = CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE |
> +        CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE,
> +    CPU_FTR_POWER4_32 = CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE |
> +        CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE,
> +    CPU_FTR_970_32 = CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE |
> +        CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE | CPU_FTR_ALTIVEC_COMP |
> +        CPU_FTR_MAYBE_CAN_NAP,
> +    CPU_FTR_8XX = CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
> +    CPU_FTR_40X = CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
> +    CPU_FTR_44X = CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
> +    CPU_FTR_E200 = CPU_FTR_USE_TB,
> +    CPU_FTR_E500 = CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
> +    CPU_FTR_E500_2 = CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
> +        CPU_FTR_BIG_PHYS,
> +    CPU_FTR_GENERIC_32 = CPU_FTR_COMMON,
> +#ifdef __powerpc64__
> +    CPU_FTR_POWER3 = CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
> +        CPU_FTR_HPTE_TABLE | CPU_FTR_IABR,
> +    CPU_FTR_RS64 = CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
> +        CPU_FTR_HPTE_TABLE | CPU_FTR_IABR |
> +        CPU_FTR_MMCRA | CPU_FTR_CTRL,
> +    CPU_FTR_POWER4 = CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
> +        CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_MMCRA,
> +    CPU_FTR_PPC970 = CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
> +        CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 |
> +        CPU_FTR_ALTIVEC_COMP | CPU_FTR_CAN_NAP | CPU_FTR_MMCRA,
> +    CPU_FTR_POWER5 = CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
> +        CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 |
> +        CPU_FTR_MMCRA | CPU_FTR_SMT |
> +        CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE |
> +        CPU_FTR_MMCRA_SIHV,
> +    CPU_FTR_CELL = CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
> +        CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 |
> +        CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT,
> +    CPU_FTR_COMPATIBLE = CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
> +        CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2,
> +#endif
> +    CPU_FTR_POSSIBLE =
> +#if CLASSIC_PPC
> +        CPU_FTR_601 | CPU_FTR_603 | CPU_FTR_604 | CPU_FTR_740_NOTAU |
> +        CPU_FTR_740 | CPU_FTR_750 | CPU_FTR_750FX1 |
> +        CPU_FTR_750FX2 | CPU_FTR_750FX | CPU_FTR_750GX |
> +        CPU_FTR_7400_NOTAU | CPU_FTR_7400 | CPU_FTR_7450_20 |
> +        CPU_FTR_7450_21 | CPU_FTR_7450_23 | CPU_FTR_7455_1 |
> +        CPU_FTR_7455_20 | CPU_FTR_7455 | CPU_FTR_7447_10 |
> +        CPU_FTR_7447 | CPU_FTR_7447A | CPU_FTR_82XX |
> +        CPU_FTR_G2_LE | CPU_FTR_E300 | CPU_FTR_CLASSIC32 |
> +#else
> +        CPU_FTR_GENERIC_32 |
> +#endif
> +#ifdef CONFIG_PPC64BRIDGE
> +        CPU_FTR_POWER3_32 |
> +#endif
> +#ifdef CONFIG_POWER4
> +        CPU_FTR_POWER4_32 | CPU_FTR_970_32 |
> +#endif
> +#ifdef CONFIG_8xx
> +        CPU_FTR_8XX |
> +#endif
> +#ifdef CONFIG_40x
> +        CPU_FTR_40X |
> +#endif
> +#ifdef CONFIG_44x
> +        CPU_FTR_44X |
> +#endif
> +#ifdef CONFIG_FSL_BOOKE
> +        CPU_FTR_E200 | CPU_FTR_E500 | CPU_FTR_E500_2 |
> +#endif
> +#ifdef CONFIG_CPU_POWER3
> +        CPU_FTR_POWER3 |
> +#endif
> +#ifdef CONFIG_CPU_RS64
> +        CPU_FTR_RS64 |
> +#endif
> +#ifdef CONFIG_CPU_POWER4
> +        CPU_FTR_POWER4 |
> +#endif
> +#ifdef CONFIG_CPU_PPC970
> +        CPU_FTR_PPC970 |
> +#endif
> +#ifdef CONFIG_CPU_POWER5
> +        CPU_FTR_POWER5 |
> +#endif
> +#ifdef CONFIG_CPU_CELL
> +        CPU_FTR_CELL |
> +#endif
> +        0,
> +    CPU_FTR_ALWAYS =
> +#if CLASSIC_PPC
> +        CPU_FTR_601 & CPU_FTR_603 & CPU_FTR_604 & CPU_FTR_740_NOTAU &
> +        CPU_FTR_740 & CPU_FTR_750 & CPU_FTR_750FX1 &
> +        CPU_FTR_750FX2 & CPU_FTR_750FX & CPU_FTR_750GX &
> +        CPU_FTR_7400_NOTAU & CPU_FTR_7400 & CPU_FTR_7450_20 &
> +        CPU_FTR_7450_21 & CPU_FTR_7450_23 & CPU_FTR_7455_1 &
> +        CPU_FTR_7455_20 & CPU_FTR_7455 & CPU_FTR_7447_10 &
> +        CPU_FTR_7447 & CPU_FTR_7447A & CPU_FTR_82XX &
> +        CPU_FTR_G2_LE & CPU_FTR_E300 & CPU_FTR_CLASSIC32 &
> +#else
> +        CPU_FTR_GENERIC_32 &
> +#endif
> +#ifdef CONFIG_PPC64BRIDGE
> +        CPU_FTR_POWER3_32 &
> +#endif
> +#ifdef CONFIG_POWER4
> +        CPU_FTR_POWER4_32 & CPU_FTR_970_32 &
> +#endif
> +#ifdef CONFIG_8xx
> +        CPU_FTR_8XX &
> +#endif
> +#ifdef CONFIG_40x
> +        CPU_FTR_40X &
> +#endif
> +#ifdef CONFIG_44x
> +        CPU_FTR_44X &
> +#endif
> +#ifdef CONFIG_FSL_BOOKE
> +        CPU_FTR_E200 & CPU_FTR_E500 & CPU_FTR_E500_2 &
> +#endif
> +#ifdef CONFIG_CPU_POWER3
> +        CPU_FTR_POWER3 &
> +#endif
> +#ifdef CONFIG_CPU_RS64
> +        CPU_FTR_RS64 &
> +#endif
> +#ifdef CONFIG_CPU_POWER4
> +        CPU_FTR_POWER4 &
> +#endif
> +#ifdef CONFIG_CPU_PPC970
> +        CPU_FTR_PPC970 &
> +#endif
> +#ifdef CONFIG_CPU_POWER5
> +        CPU_FTR_POWER5 &
> +#endif
> +#ifdef CONFIG_CPU_CELL
> +        CPU_FTR_CELL &
> +#endif
> +        CPU_FTR_POSSIBLE,
> +};
> +
> +static inline int cpu_has_feature(unsigned long feature)
> +{
> +    return (CPU_FTR_ALWAYS & feature) ||
> +           (CPU_FTR_POSSIBLE
> +#ifndef __powerpc64__
> +        & cur_cpu_spec[0]->cpu_features
> +#else
> +        & cur_cpu_spec->cpu_features
> +#endif
> +        & feature);
> +}
> +
> +#endif /* __ASSEMBLY */
> +
> +#ifdef __ASSEMBLY__
> +
> +#define BEGIN_FTR_SECTION        98:
> +
> +#ifndef __powerpc64__
> +#define END_FTR_SECTION(msk, val)        \
> +99:                        \
> +    .section __ftr_fixup,"a";        \
> +    .align 2;                \
> +    .long msk;                \
> +    .long val;                \
> +    .long 98b;                \
> +    .long 99b;                \
> +    .previous
> +#else /* __powerpc64__ */
> +#define END_FTR_SECTION(msk, val)        \
> +99:                        \
> +    .section __ftr_fixup,"a";        \
> +    .align 3;                \
> +    .llong msk;                \
> +    .llong val;                \
> +    .llong 98b;                \
> +    .llong 99b;                 \
> +    .previous
> +#endif /* __powerpc64__ */
> +
> +#else
> +
> +#define BEGIN_FTR_SECTION        "98:\n"
> +
> +#ifndef __powerpc64__
> +#define END_FTR_SECTION(msk, val)        \
> +"99:\n"                        \
> +"    .section __ftr_fixup,\"a\";\n"        \
> +"    .align 2;\n"                \
> +"    .long "#msk";\n"            \
> +"    .long "#val";\n"            \
> +"    .long 98b;\n"                \
> +"    .long 99b;\n"                 \
> +"    .previous\n"
> +#else /* __powerpc64__ */
> +#define END_FTR_SECTION(msk, val)        \
> +"99:\n"                        \
> +"    .section __ftr_fixup,\"a\";\n"        \
> +"    .align 3;\n"                \
> +"    .llong "#msk";\n"            \
> +"    .llong "#val";\n"            \
> +"    .llong 98b;\n"                \
> +"    .llong 99b;\n"                 \
> +"    .previous\n"
> +#endif /* __powerpc64__ */
> +
> +#endif /* __ASSEMBLY__ */
> +
> +#define END_FTR_SECTION_IFSET(msk)    END_FTR_SECTION((msk), (msk))
> +#define END_FTR_SECTION_IFCLR(msk)    END_FTR_SECTION((msk), 0)
> +
> +#endif /* __KERNEL__ */
> +#endif /* __ASM_POWERPC_CPUTABLE_H */
> Index: clean-cg/include/asm-ppc/cputable.h
> ===================================================================
> --- clean-cg.orig/include/asm-ppc/cputable.h
> +++ /dev/null
> @@ -1,128 +0,0 @@
> -/*
> - *  include/asm-ppc/cputable.h
> - *
> - *  Copyright (C) 2001 Ben. Herrenschmidt (benh@kernel.crashing.org)
> - *
> - *  This program is free software; you can redistribute it and/or
> - *  modify it under the terms of the GNU General Public License
> - *  as published by the Free Software Foundation; either version
> - *  2 of the License, or (at your option) any later version.
> - */
> -
> -#ifndef __ASM_PPC_CPUTABLE_H
> -#define __ASM_PPC_CPUTABLE_H
> -
> -/* Exposed to userland CPU features */
> -#define PPC_FEATURE_32            0x80000000
> -#define PPC_FEATURE_64            0x40000000
> -#define PPC_FEATURE_601_INSTR        0x20000000
> -#define PPC_FEATURE_HAS_ALTIVEC        0x10000000
> -#define PPC_FEATURE_HAS_FPU        0x08000000
> -#define PPC_FEATURE_HAS_MMU        0x04000000
> -#define PPC_FEATURE_HAS_4xxMAC        0x02000000
> -#define PPC_FEATURE_UNIFIED_CACHE    0x01000000
> -#define PPC_FEATURE_HAS_SPE        0x00800000
> -#define PPC_FEATURE_HAS_EFP_SINGLE    0x00400000
> -#define PPC_FEATURE_HAS_EFP_DOUBLE    0x00200000
> -
> -#ifdef __KERNEL__
> -
> -#ifndef __ASSEMBLY__
> -
> -/* This structure can grow, it's real size is used by head.S code
> - * via the mkdefs mecanism.
> - */
> -struct cpu_spec;
> -
> -typedef    void (*cpu_setup_t)(unsigned long offset, int cpu_nr,  
> struct cpu_spec* spec);
> -
> -struct cpu_spec {
> -    /* CPU is matched via (PVR & pvr_mask) == pvr_value */
> -    unsigned int    pvr_mask;
> -    unsigned int    pvr_value;
> -
> -    char        *cpu_name;
> -    unsigned int    cpu_features;        /* Kernel features */
> -    unsigned int    cpu_user_features;    /* Userland features */
> -
> -    /* cache line sizes */
> -    unsigned int    icache_bsize;
> -    unsigned int    dcache_bsize;
> -
> -    /* number of performance monitor counters */
> -    unsigned int    num_pmcs;
> -
> -    /* this is called to initialize various CPU bits like L1 cache,
> -     * BHT, SPD, etc... from head.S before branching to  
> identify_machine
> -     */
> -    cpu_setup_t    cpu_setup;
> -};
> -
> -extern struct cpu_spec        cpu_specs[];
> -extern struct cpu_spec        *cur_cpu_spec[];
> -
> -static inline unsigned int cpu_has_feature(unsigned int feature)
> -{
> -    return cur_cpu_spec[0]->cpu_features & feature;
> -}
> -
> -#endif /* __ASSEMBLY__ */
> -
> -/* CPU kernel features */
> -#define CPU_FTR_SPLIT_ID_CACHE        0x00000001
> -#define CPU_FTR_L2CR            0x00000002
> -#define CPU_FTR_SPEC7450        0x00000004
> -#define CPU_FTR_ALTIVEC            0x00000008
> -#define CPU_FTR_TAU            0x00000010
> -#define CPU_FTR_CAN_DOZE        0x00000020
> -#define CPU_FTR_USE_TB            0x00000040
> -#define CPU_FTR_604_PERF_MON        0x00000080
> -#define CPU_FTR_601            0x00000100
> -#define CPU_FTR_HPTE_TABLE        0x00000200
> -#define CPU_FTR_CAN_NAP            0x00000400
> -#define CPU_FTR_L3CR            0x00000800
> -#define CPU_FTR_L3_DISABLE_NAP        0x00001000
> -#define CPU_FTR_NAP_DISABLE_L2_PR    0x00002000
> -#define CPU_FTR_DUAL_PLL_750FX        0x00004000
> -#define CPU_FTR_NO_DPM            0x00008000
> -#define CPU_FTR_HAS_HIGH_BATS        0x00010000
> -#define CPU_FTR_NEED_COHERENT        0x00020000
> -#define CPU_FTR_NO_BTIC            0x00040000
> -#define CPU_FTR_BIG_PHYS        0x00080000
> -
> -#ifdef __ASSEMBLY__
> -
> -#define BEGIN_FTR_SECTION        98:
> -
> -#define END_FTR_SECTION(msk, val)        \
> -99:                        \
> -    .section __ftr_fixup,"a";        \
> -    .align 2;                \
> -    .long msk;                \
> -    .long val;                \
> -    .long 98b;                \
> -    .long 99b;                \
> -    .previous
> -
> -#else
> -
> -#define BEGIN_FTR_SECTION        "98:\n"
> -#define END_FTR_SECTION(msk, val)        \
> -"99:\n"                        \
> -"    .section __ftr_fixup,\"a\";\n"        \
> -"    .align 2;\n"                \
> -"    .long "#msk";\n"            \
> -"    .long "#val";\n"            \
> -"    .long 98b;\n"                    \
> -"    .long 99b;\n"                     \
> -"    .previous\n"
> -
> -
> -#endif /* __ASSEMBLY__ */
> -
> -#define END_FTR_SECTION_IFSET(msk)    END_FTR_SECTION((msk), (msk))
> -#define END_FTR_SECTION_IFCLR(msk)    END_FTR_SECTION((msk), 0)
> -
> -#endif /* __ASM_PPC_CPUTABLE_H */
> -#endif /* __KERNEL__ */
> -
>
