Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <Pine.LNX.4.61.0509091501510.8000@nylon.am.freescale.net>
References: <Pine.LNX.4.61.0509091501510.8000@nylon.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F0F2A9CC-F204-407C-A9FA-A60818D09DAB@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 14 Sep 2005 10:41:26 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH] powerpc: Merged ppc_asm.h   
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul,

What's the status of applying this to your tree?

http://patchwork.ozlabs.org/linuxppc/patch?id=2330

- kumar

On Sep 9, 2005, at 3:02 PM, Gala Kumar K.-galak wrote:

> Merged ppc_asm.h between ppc32 & ppc64.  The majority of the file is
> common between the two architectures excluding how a single GPR is
> saved/restored and which GPRs are non-volatile.
>
> Additionally, moved the ASM_CONST macro used on ppc64 into ppc_asm.h.
>
> Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
>
> ---
> commit ba0d4d2e26509b73b7daed0c203f481d0bb06ea0
> tree fa78f19160a9174f1fec441c4f3351962c75dad4
> parent bbe4b1a6e25818f03d09f3260345bfa4442acca0
> author Kumar K. Gala <kumar.gala@freescale.com> Fri, 09 Sep 2005
> 15:01:18 -0500
> committer Kumar K. Gala <kumar.gala@freescale.com> Fri, 09 Sep 2005
> 15:01:18 -0500
>
>  arch/ppc/kernel/head.S           |    6 -
>  arch/ppc/kernel/head_fsl_booke.S |    6 -
>  include/asm-powerpc/ppc_asm.h    |  437
> ++++++++++++++++++++++++++++++++++++++
>  include/asm-ppc/ppc_asm.h        |  350  
> ------------------------------
>  include/asm-ppc64/cputable.h     |    2
>  include/asm-ppc64/mmu.h          |    1
>  include/asm-ppc64/page.h         |    8 -
>  include/asm-ppc64/ppc_asm.h      |  242 ---------------------
>  8 files changed, 446 insertions(+), 606 deletions(-)
>
> diff --git a/arch/ppc/kernel/head.S b/arch/ppc/kernel/head.S
> --- a/arch/ppc/kernel/head.S
> +++ b/arch/ppc/kernel/head.S
> @@ -804,7 +804,7 @@ load_up_altivec:
>      beq    1f
>      add    r4,r4,r6
>      addi    r4,r4,THREAD    /* want THREAD of last_task_used_altivec
> */
> -    SAVE_32VR(0,r10,r4)
> +    SAVE_32VRS(0,r10,r4)
>      mfvscr    vr0
>      li    r10,THREAD_VSCR
>      stvx    vr0,r10,r4
> @@ -824,7 +824,7 @@ load_up_altivec:
>      stw    r4,THREAD_USED_VR(r5)
>      lvx    vr0,r10,r5
>      mtvscr    vr0
> -    REST_32VR(0,r10,r5)
> +    REST_32VRS(0,r10,r5)
>  #ifndef CONFIG_SMP
>      subi    r4,r5,THREAD
>      sub    r4,r4,r6
> @@ -870,7 +870,7 @@ giveup_altivec:
>      addi    r3,r3,THREAD        /* want THREAD of task */
>      lwz    r5,PT_REGS(r3)
>      cmpwi    0,r5,0
> -    SAVE_32VR(0, r4, r3)
> +    SAVE_32VRS(0, r4, r3)
>      mfvscr    vr0
>      li    r4,THREAD_VSCR
>      stvx    vr0,r4,r3
> diff --git a/arch/ppc/kernel/head_fsl_booke.S
> b/arch/ppc/kernel/head_fsl_booke.S
> --- a/arch/ppc/kernel/head_fsl_booke.S
> +++ b/arch/ppc/kernel/head_fsl_booke.S
> @@ -853,7 +853,7 @@ load_up_spe:
>      cmpi    0,r4,0
>      beq    1f
>      addi    r4,r4,THREAD    /* want THREAD of last_task_used_spe */
> -    SAVE_32EVR(0,r10,r4)
> +    SAVE_32EVRS(0,r10,r4)
>         evxor    evr10, evr10, evr10    /* clear out evr10 */
>      evmwumiaa evr10, evr10, evr10    /* evr10 <- ACC = 0 * 0 + ACC */
>      li    r5,THREAD_ACC
> @@ -873,7 +873,7 @@ load_up_spe:
>      stw    r4,THREAD_USED_SPE(r5)
>      evlddx    evr4,r10,r5
>      evmra    evr4,evr4
> -    REST_32EVR(0,r10,r5)
> +    REST_32EVRS(0,r10,r5)
>  #ifndef CONFIG_SMP
>      subi    r4,r5,THREAD
>      stw    r4,last_task_used_spe@l(r3)
> @@ -963,7 +963,7 @@ _GLOBAL(giveup_spe)
>      addi    r3,r3,THREAD        /* want THREAD of task */
>      lwz    r5,PT_REGS(r3)
>      cmpi    0,r5,0
> -    SAVE_32EVR(0, r4, r3)
> +    SAVE_32EVRS(0, r4, r3)
>         evxor    evr6, evr6, evr6    /* clear out evr6 */
>      evmwumiaa evr6, evr6, evr6    /* evr6 <- ACC = 0 * 0 + ACC */
>      li    r4,THREAD_ACC
> diff --git a/include/asm-powerpc/ppc_asm.h
> b/include/asm-powerpc/ppc_asm.h
> new file mode 100644
> --- /dev/null
> +++ b/include/asm-powerpc/ppc_asm.h
> @@ -0,0 +1,437 @@
> +/*
> + * Copyright (C) 1995-1999 Gary Thomas, Paul Mackerras, Cort Dougan.
> + */
> +
> +#ifndef _ASM_POWERPC_PPC_ASM_H
> +#define _ASM_POWERPC_PPC_ASM_H
> +
> +#ifdef __ASSEMBLY__
> +
> +/*
> + * Macros for storing registers into and loading registers from
> + * exception frames.
> + */
> +#ifdef __powerpc64__
> +#define SAVE_GPR(n, base)    std    n,GPR0+8*(n)(base)
> +#define REST_GPR(n, base)    ld    n,GPR0+8*(n)(base)
> +#define SAVE_NVGPRS(base)    SAVE_8GPRS(14, base); SAVE_10GPRS(22,
> base)
> +#define REST_NVGPRS(base)    REST_8GPRS(14, base); REST_10GPRS(22,
> base)
> +#else
> +#define SAVE_GPR(n, base)    stw    n,GPR0+4*(n)(base)
> +#define REST_GPR(n, base)    lwz    n,GPR0+4*(n)(base)
> +#define SAVE_NVGPRS(base)    SAVE_GPR(13, base); SAVE_8GPRS(14,
> base); \
> +                SAVE_10GPRS(22, base)
> +#define REST_NVGPRS(base)    REST_GPR(13, base); REST_8GPRS(14,
> base); \
> +                REST_10GPRS(22, base)
> +#endif
> +
> +
> +#define SAVE_2GPRS(n, base)    SAVE_GPR(n, base); SAVE_GPR(n+1, base)
> +#define SAVE_4GPRS(n, base)    SAVE_2GPRS(n, base); SAVE_2GPRS(n+2,
> base)
> +#define SAVE_8GPRS(n, base)    SAVE_4GPRS(n, base); SAVE_4GPRS(n+4,
> base)
> +#define SAVE_10GPRS(n, base)    SAVE_8GPRS(n, base); SAVE_2GPRS(n+8,
> base)
> +#define REST_2GPRS(n, base)    REST_GPR(n, base); REST_GPR(n+1, base)
> +#define REST_4GPRS(n, base)    REST_2GPRS(n, base); REST_2GPRS(n+2,
> base)
> +#define REST_8GPRS(n, base)    REST_4GPRS(n, base); REST_4GPRS(n+4,
> base)
> +#define REST_10GPRS(n, base)    REST_8GPRS(n, base); REST_2GPRS(n+8,
> base)
> +
> +#define SAVE_FPR(n, base)    stfd    n,THREAD_FPR0+8*(n)(base)
> +#define SAVE_2FPRS(n, base)    SAVE_FPR(n, base); SAVE_FPR(n+1, base)
> +#define SAVE_4FPRS(n, base)    SAVE_2FPRS(n, base); SAVE_2FPRS(n+2,
> base)
> +#define SAVE_8FPRS(n, base)    SAVE_4FPRS(n, base); SAVE_4FPRS(n+4,
> base)
> +#define SAVE_16FPRS(n, base)    SAVE_8FPRS(n, base); SAVE_8FPRS(n+8,
> base)
> +#define SAVE_32FPRS(n, base)    SAVE_16FPRS(n, base); SAVE_16FPRS(n 
> +16,
> base)
> +#define REST_FPR(n, base)    lfd    n,THREAD_FPR0+8*(n)(base)
> +#define REST_2FPRS(n, base)    REST_FPR(n, base); REST_FPR(n+1, base)
> +#define REST_4FPRS(n, base)    REST_2FPRS(n, base); REST_2FPRS(n+2,
> base)
> +#define REST_8FPRS(n, base)    REST_4FPRS(n, base); REST_4FPRS(n+4,
> base)
> +#define REST_16FPRS(n, base)    REST_8FPRS(n, base); REST_8FPRS(n+8,
> base)
> +#define REST_32FPRS(n, base)    REST_16FPRS(n, base); REST_16FPRS(n 
> +16,
> base)
> +
> +#define SAVE_VR(n,b,base)    li b,THREAD_VR0+(16*(n));  stvx n,b,base
> +#define SAVE_2VRS(n,b,base)    SAVE_VR(n,b,base); SAVE_VR(n+1,b,base)
> +#define SAVE_4VRS(n,b,base)    SAVE_2VRS(n,b,base);
> SAVE_2VRS(n+2,b,base)
> +#define SAVE_8VRS(n,b,base)    SAVE_4VRS(n,b,base);
> SAVE_4VRS(n+4,b,base)
> +#define SAVE_16VRS(n,b,base)    SAVE_8VRS(n,b,base);
> SAVE_8VRS(n+8,b,base)
> +#define SAVE_32VRS(n,b,base)    SAVE_16VRS(n,b,base);
> SAVE_16VRS(n+16,b,base)
> +#define REST_VR(n,b,base)    li b,THREAD_VR0+(16*(n)); lvx n,b,base
> +#define REST_2VRS(n,b,base)    REST_VR(n,b,base); REST_VR(n+1,b,base)
> +#define REST_4VRS(n,b,base)    REST_2VRS(n,b,base);
> REST_2VRS(n+2,b,base)
> +#define REST_8VRS(n,b,base)    REST_4VRS(n,b,base);
> REST_4VRS(n+4,b,base)
> +#define REST_16VRS(n,b,base)    REST_8VRS(n,b,base);
> REST_8VRS(n+8,b,base)
> +#define REST_32VRS(n,b,base)    REST_16VRS(n,b,base);
> REST_16VRS(n+16,b,base)
> +
> +#define SAVE_EVR(n,s,base)    evmergehi s,s,n; stw
> s,THREAD_EVR0+4*(n)(base)
> +#define SAVE_2EVRS(n,s,base)    SAVE_EVR(n,s,base); SAVE_EVR(n 
> +1,s,base)
> +#define SAVE_4EVRS(n,s,base)    SAVE_2EVRS(n,s,base);
> SAVE_2EVRS(n+2,s,base)
> +#define SAVE_8EVRS(n,s,base)    SAVE_4EVRS(n,s,base);
> SAVE_4EVRS(n+4,s,base)
> +#define SAVE_16EVRS(n,s,base)    SAVE_8EVRS(n,s,base);
> SAVE_8EVRS(n+8,s,base)
> +#define SAVE_32EVRS(n,s,base)    SAVE_16EVRS(n,s,base);
> SAVE_16EVRS(n+16,s,base)
> +#define REST_EVR(n,s,base)    lwz s,THREAD_EVR0+4*(n)(base);  
> evmergelo
> n,s,n
> +#define REST_2EVRS(n,s,base)    REST_EVR(n,s,base); REST_EVR(n 
> +1,s,base)
> +#define REST_4EVRS(n,s,base)    REST_2EVRS(n,s,base);
> REST_2EVRS(n+2,s,base)
> +#define REST_8EVRS(n,s,base)    REST_4EVRS(n,s,base);
> REST_4EVRS(n+4,s,base)
> +#define REST_16EVRS(n,s,base)    REST_8EVRS(n,s,base);
> REST_8EVRS(n+8,s,base)
> +#define REST_32EVRS(n,s,base)    REST_16EVRS(n,s,base);
> REST_16EVRS(n+16,s,base)
> +
> +/* Macros to adjust thread priority for Iseries hardware  
> multithreading
> */
> +#define HMT_LOW        or 1,1,1
> +#define HMT_MEDIUM    or 2,2,2
> +#define HMT_HIGH    or 3,3,3
> +
> +/* handle instructions that older assemblers may not know */
> +#define RFCI        .long 0x4c000066    /* rfci instruction */
> +#define RFDI        .long 0x4c00004e    /* rfdi instruction */
> +#define RFMCI        .long 0x4c00004c    /* rfmci instruction */
> +
> +/*
> + * LOADADDR( rn, name )
> + *   loads the address of 'name' into 'rn'
> + *
> + * LOADBASE( rn, name )
> + *   loads the address (less the low 16 bits) of 'name' into 'rn'
> + *   suitable for base+disp addressing
> + */
> +#ifdef __powerpc64__
> +#define LOADADDR(rn,name) \
> +    lis    rn,name##@highest;    \
> +    ori    rn,rn,name##@higher;    \
> +    rldicr    rn,rn,32,31;        \
> +    oris    rn,rn,name##@h;        \
> +    ori    rn,rn,name##@l
> +
> +#define LOADBASE(rn,name) \
> +    lis    rn,name@highest;    \
> +    ori    rn,rn,name@higher;    \
> +    rldicr    rn,rn,32,31;        \
> +    oris    rn,rn,name@ha
> +
> +
> +#define SET_REG_TO_CONST(reg, value)                 \
> +    lis     reg,(((value)>>48)&0xFFFF);             \
> +    ori     reg,reg,(((value)>>32)&0xFFFF);         \
> +    rldicr  reg,reg,32,31;                          \
> +    oris    reg,reg,(((value)>>16)&0xFFFF);         \
> +    ori     reg,reg,((value)&0xFFFF);
> +
> +#define SET_REG_TO_LABEL(reg, label)                 \
> +    lis     reg,(label)@highest;                    \
> +    ori     reg,reg,(label)@higher;                 \
> +    rldicr  reg,reg,32,31;                          \
> +    oris    reg,reg,(label)@h;                      \
> +    ori     reg,reg,(label)@l;
> +#endif
> +
> +/* various errata or part fixups */
> +#ifdef CONFIG_PPC601_SYNC_FIX
> +#define SYNC                \
> +BEGIN_FTR_SECTION            \
> +    sync;                \
> +    isync;                \
> +END_FTR_SECTION_IFSET(CPU_FTR_601)
> +#define SYNC_601            \
> +BEGIN_FTR_SECTION            \
> +    sync;                \
> +END_FTR_SECTION_IFSET(CPU_FTR_601)
> +#define ISYNC_601            \
> +BEGIN_FTR_SECTION            \
> +    isync;                \
> +END_FTR_SECTION_IFSET(CPU_FTR_601)
> +#else
> +#define    SYNC
> +#define SYNC_601
> +#define ISYNC_601
> +#endif
> +
> +
> +#ifndef CONFIG_SMP
> +#define TLBSYNC
> +#else /* CONFIG_SMP */
> +/* tlbsync is not implemented on 601 */
> +#define TLBSYNC                \
> +BEGIN_FTR_SECTION            \
> +    tlbsync;            \
> +    sync;                \
> +END_FTR_SECTION_IFCLR(CPU_FTR_601)
> +#endif
> +
> +
> +/*
> + * This instruction is not implemented on the PPC 603 or 601;  
> however,
> on
> + * the 403GCX and 405GP tlbia IS defined and tlbie is not.
> + * All of these instructions exist in the 8xx, they have magical
> powers,
> + * and they must be used.
> + */
> +
> +#if !defined(CONFIG_4xx) && !defined(CONFIG_8xx)
> +#define tlbia                    \
> +    li    r4,1024;            \
> +    mtctr    r4;                \
> +    lis    r4,KERNELBASE@h;        \
> +0:    tlbie    r4;                \
> +    addi    r4,r4,0x1000;            \
> +    bdnz    0b
> +#endif
> +
> +
> +#ifdef CONFIG_IBM405_ERR77
> +#define PPC405_ERR77(ra,rb)    dcbt    ra, rb;
> +#define    PPC405_ERR77_SYNC    sync;
> +#else
> +#define PPC405_ERR77(ra,rb)
> +#define PPC405_ERR77_SYNC
> +#endif
> +
> +
> +#ifdef CONFIG_IBM440EP_ERR42
> +#define PPC440EP_ERR42 isync
> +#else
> +#define PPC440EP_ERR42
> +#endif
> +
> +
> +#if defined(CONFIG_BOOKE)
> +#define tophys(rd,rs)                \
> +    addis    rd,rs,0
> +
> +#define tovirt(rd,rs)                \
> +    addis    rd,rs,0
> +
> +#elif defined(CONFIG_PPC64)
> +/* PPPBBB - DRENG  If KERNELBASE is always 0xC0...,
> + * Then we can easily do this with one asm insn. -Peter
> + */
> +#define tophys(rd,rs)                           \
> +        lis     rd,((KERNELBASE>>48)&0xFFFF);   \
> +        rldicr  rd,rd,32,31;                    \
> +        sub     rd,rs,rd
> +
> +#define tovirt(rd,rs)                           \
> +        lis     rd,((KERNELBASE>>48)&0xFFFF);   \
> +        rldicr  rd,rd,32,31;                    \
> +        add     rd,rs,rd
> +#else
> +/*
> + * On APUS (Amiga PowerPC cpu upgrade board), we don't know the
> + * physical base address of RAM at compile time.
> + */
> +#define tophys(rd,rs)                \
> +0:    addis    rd,rs,-KERNELBASE@h;        \
> +    .section ".vtop_fixup","aw";        \
> +    .align  1;                \
> +    .long   0b;                \
> +    .previous
> +
> +#define tovirt(rd,rs)                \
> +0:    addis    rd,rs,KERNELBASE@h;        \
> +    .section ".ptov_fixup","aw";        \
> +    .align  1;                \
> +    .long   0b;                \
> +    .previous
> +#endif
> +
> +/*
> + * On 64-bit cpus, we use the rfid instruction instead of rfi, but
> + * we then have to make sure we preserve the top 32 bits except for
> + * the 64-bit mode bit, which we clear.
> + */
> +#if defined(CONFIG_PPC64BRIDGE)
> +#define    FIX_SRR1(ra, rb)    \
> +    mr    rb,ra;        \
> +    mfmsr    ra;        \
> +    clrldi    ra,ra,1;        /* turn off 64-bit mode */ \
> +    rldimi    ra,rb,0,32
> +#define    RFI        .long    0x4c000024    /* rfid
> instruction */
> +#define MTMSRD(r)    .long    (0x7c000164 + ((r) << 21))    /*
> mtmsrd */
> +#define CLR_TOP32(r)    rlwinm    (r),(r),0,0,31    /* clear top  
> 32 bits */
> +#elif defined(CONFIG_PPC64)
> +/* Insert the high 32 bits of the MSR into what will be the new
> +   MSR (via SRR1 and rfid)  This preserves the MSR.SF and MSR.ISF
> +   bits. */
> +
> +#define FIX_SRR1(ra, rb)    \
> +    mr    rb,ra;        \
> +    mfmsr    ra;        \
> +    rldimi    ra,rb,0,32
> +
> +#define CLR_TOP32(r)    rlwinm    (r),(r),0,0,31    /* clear top  
> 32 bits */
> +
> +#else
> +#define FIX_SRR1(ra, rb)
> +#ifndef CONFIG_40x
> +#define    RFI        rfi
> +#else
> +#define RFI        rfi; b .    /* Prevent prefetch past rfi */
> +#endif
> +#define MTMSRD(r)    mtmsr    r
> +#define CLR_TOP32(r)
> +#endif
> +
> +/* The boring bits... */
> +
> +/* Condition Register Bit Fields */
> +
> +#define    cr0    0
> +#define    cr1    1
> +#define    cr2    2
> +#define    cr3    3
> +#define    cr4    4
> +#define    cr5    5
> +#define    cr6    6
> +#define    cr7    7
> +
> +
> +/* General Purpose Registers (GPRs) */
> +
> +#define    r0    0
> +#define    r1    1
> +#define    r2    2
> +#define    r3    3
> +#define    r4    4
> +#define    r5    5
> +#define    r6    6
> +#define    r7    7
> +#define    r8    8
> +#define    r9    9
> +#define    r10    10
> +#define    r11    11
> +#define    r12    12
> +#define    r13    13
> +#define    r14    14
> +#define    r15    15
> +#define    r16    16
> +#define    r17    17
> +#define    r18    18
> +#define    r19    19
> +#define    r20    20
> +#define    r21    21
> +#define    r22    22
> +#define    r23    23
> +#define    r24    24
> +#define    r25    25
> +#define    r26    26
> +#define    r27    27
> +#define    r28    28
> +#define    r29    29
> +#define    r30    30
> +#define    r31    31
> +
> +
> +/* Floating Point Registers (FPRs) */
> +
> +#define    fr0    0
> +#define    fr1    1
> +#define    fr2    2
> +#define    fr3    3
> +#define    fr4    4
> +#define    fr5    5
> +#define    fr6    6
> +#define    fr7    7
> +#define    fr8    8
> +#define    fr9    9
> +#define    fr10    10
> +#define    fr11    11
> +#define    fr12    12
> +#define    fr13    13
> +#define    fr14    14
> +#define    fr15    15
> +#define    fr16    16
> +#define    fr17    17
> +#define    fr18    18
> +#define    fr19    19
> +#define    fr20    20
> +#define    fr21    21
> +#define    fr22    22
> +#define    fr23    23
> +#define    fr24    24
> +#define    fr25    25
> +#define    fr26    26
> +#define    fr27    27
> +#define    fr28    28
> +#define    fr29    29
> +#define    fr30    30
> +#define    fr31    31
> +
> +/* AltiVec Registers (VPRs) */
> +
> +#define    vr0    0
> +#define    vr1    1
> +#define    vr2    2
> +#define    vr3    3
> +#define    vr4    4
> +#define    vr5    5
> +#define    vr6    6
> +#define    vr7    7
> +#define    vr8    8
> +#define    vr9    9
> +#define    vr10    10
> +#define    vr11    11
> +#define    vr12    12
> +#define    vr13    13
> +#define    vr14    14
> +#define    vr15    15
> +#define    vr16    16
> +#define    vr17    17
> +#define    vr18    18
> +#define    vr19    19
> +#define    vr20    20
> +#define    vr21    21
> +#define    vr22    22
> +#define    vr23    23
> +#define    vr24    24
> +#define    vr25    25
> +#define    vr26    26
> +#define    vr27    27
> +#define    vr28    28
> +#define    vr29    29
> +#define    vr30    30
> +#define    vr31    31
> +
> +/* SPE Registers (EVPRs) */
> +
> +#define    evr0    0
> +#define    evr1    1
> +#define    evr2    2
> +#define    evr3    3
> +#define    evr4    4
> +#define    evr5    5
> +#define    evr6    6
> +#define    evr7    7
> +#define    evr8    8
> +#define    evr9    9
> +#define    evr10    10
> +#define    evr11    11
> +#define    evr12    12
> +#define    evr13    13
> +#define    evr14    14
> +#define    evr15    15
> +#define    evr16    16
> +#define    evr17    17
> +#define    evr18    18
> +#define    evr19    19
> +#define    evr20    20
> +#define    evr21    21
> +#define    evr22    22
> +#define    evr23    23
> +#define    evr24    24
> +#define    evr25    25
> +#define    evr26    26
> +#define    evr27    27
> +#define    evr28    28
> +#define    evr29    29
> +#define    evr30    30
> +#define    evr31    31
> +
> +/* some stab codes */
> +#define N_FUN    36
> +#define N_RSYM    64
> +#define N_SLINE    68
> +#define N_SO    100
> +
> +#define ASM_CONST(x) x
> +#else
> +  #define __ASM_CONST(x) x##UL
> +  #define ASM_CONST(x) __ASM_CONST(x)
> +#endif /*  __ASSEMBLY__ */
> +
> +#endif /* _ASM_POWERPC_PPC_ASM_H */
> diff --git a/include/asm-ppc/ppc_asm.h b/include/asm-ppc/ppc_asm.h
> deleted file mode 100644
> --- a/include/asm-ppc/ppc_asm.h
> +++ /dev/null
> @@ -1,350 +0,0 @@
> -/*
> - * include/asm-ppc/ppc_asm.h
> - *
> - * Definitions used by various bits of low-level assembly code on
> PowerPC.
> - *
> - * Copyright (C) 1995-1999 Gary Thomas, Paul Mackerras, Cort Dougan.
> - *
> - *  This program is free software; you can redistribute it and/or
> - *  modify it under the terms of the GNU General Public License
> - *  as published by the Free Software Foundation; either version
> - *  2 of the License, or (at your option) any later version.
> - */
> -
> -#include <linux/config.h>
> -
> -/*
> - * Macros for storing registers into and loading registers from
> - * exception frames.
> - */
> -#define SAVE_GPR(n, base)    stw    n,GPR0+4*(n)(base)
> -#define SAVE_2GPRS(n, base)    SAVE_GPR(n, base); SAVE_GPR(n+1, base)
> -#define SAVE_4GPRS(n, base)    SAVE_2GPRS(n, base); SAVE_2GPRS(n+2,
> base)
> -#define SAVE_8GPRS(n, base)    SAVE_4GPRS(n, base); SAVE_4GPRS(n+4,
> base)
> -#define SAVE_10GPRS(n, base)    SAVE_8GPRS(n, base); SAVE_2GPRS(n+8,
> base)
> -#define REST_GPR(n, base)    lwz    n,GPR0+4*(n)(base)
> -#define REST_2GPRS(n, base)    REST_GPR(n, base); REST_GPR(n+1, base)
> -#define REST_4GPRS(n, base)    REST_2GPRS(n, base); REST_2GPRS(n+2,
> base)
> -#define REST_8GPRS(n, base)    REST_4GPRS(n, base); REST_4GPRS(n+4,
> base)
> -#define REST_10GPRS(n, base)    REST_8GPRS(n, base); REST_2GPRS(n+8,
> base)
> -
> -#define SAVE_NVGPRS(base)    SAVE_GPR(13, base); SAVE_8GPRS(14,
> base); \
> -                SAVE_10GPRS(22, base)
> -#define REST_NVGPRS(base)    REST_GPR(13, base); REST_8GPRS(14,
> base); \
> -                REST_10GPRS(22, base)
> -
> -#define SAVE_FPR(n, base)    stfd    n,THREAD_FPR0+8*(n)(base)
> -#define SAVE_2FPRS(n, base)    SAVE_FPR(n, base); SAVE_FPR(n+1, base)
> -#define SAVE_4FPRS(n, base)    SAVE_2FPRS(n, base); SAVE_2FPRS(n+2,
> base)
> -#define SAVE_8FPRS(n, base)    SAVE_4FPRS(n, base); SAVE_4FPRS(n+4,
> base)
> -#define SAVE_16FPRS(n, base)    SAVE_8FPRS(n, base); SAVE_8FPRS(n+8,
> base)
> -#define SAVE_32FPRS(n, base)    SAVE_16FPRS(n, base); SAVE_16FPRS(n 
> +16,
> base)
> -#define REST_FPR(n, base)    lfd    n,THREAD_FPR0+8*(n)(base)
> -#define REST_2FPRS(n, base)    REST_FPR(n, base); REST_FPR(n+1, base)
> -#define REST_4FPRS(n, base)    REST_2FPRS(n, base); REST_2FPRS(n+2,
> base)
> -#define REST_8FPRS(n, base)    REST_4FPRS(n, base); REST_4FPRS(n+4,
> base)
> -#define REST_16FPRS(n, base)    REST_8FPRS(n, base); REST_8FPRS(n+8,
> base)
> -#define REST_32FPRS(n, base)    REST_16FPRS(n, base); REST_16FPRS(n 
> +16,
> base)
> -
> -#define SAVE_VR(n,b,base)    li b,THREAD_VR0+(16*(n));  stvx n,b,base
> -#define SAVE_2VR(n,b,base)    SAVE_VR(n,b,base); SAVE_VR(n+1,b,base)
> -#define SAVE_4VR(n,b,base)    SAVE_2VR(n,b,base); SAVE_2VR(n 
> +2,b,base)
> -#define SAVE_8VR(n,b,base)    SAVE_4VR(n,b,base); SAVE_4VR(n 
> +4,b,base)
> -#define SAVE_16VR(n,b,base)    SAVE_8VR(n,b,base); SAVE_8VR(n 
> +8,b,base)
> -#define SAVE_32VR(n,b,base)    SAVE_16VR(n,b,base);
> SAVE_16VR(n+16,b,base)
> -#define REST_VR(n,b,base)    li b,THREAD_VR0+(16*(n)); lvx n,b,base
> -#define REST_2VR(n,b,base)    REST_VR(n,b,base); REST_VR(n+1,b,base)
> -#define REST_4VR(n,b,base)    REST_2VR(n,b,base); REST_2VR(n 
> +2,b,base)
> -#define REST_8VR(n,b,base)    REST_4VR(n,b,base); REST_4VR(n 
> +4,b,base)
> -#define REST_16VR(n,b,base)    REST_8VR(n,b,base); REST_8VR(n 
> +8,b,base)
> -#define REST_32VR(n,b,base)    REST_16VR(n,b,base);
> REST_16VR(n+16,b,base)
> -
> -#define SAVE_EVR(n,s,base)    evmergehi s,s,n; stw
> s,THREAD_EVR0+4*(n)(base)
> -#define SAVE_2EVR(n,s,base)    SAVE_EVR(n,s,base); SAVE_EVR(n 
> +1,s,base)
> -#define SAVE_4EVR(n,s,base)    SAVE_2EVR(n,s,base);
> SAVE_2EVR(n+2,s,base)
> -#define SAVE_8EVR(n,s,base)    SAVE_4EVR(n,s,base);
> SAVE_4EVR(n+4,s,base)
> -#define SAVE_16EVR(n,s,base)    SAVE_8EVR(n,s,base);
> SAVE_8EVR(n+8,s,base)
> -#define SAVE_32EVR(n,s,base)    SAVE_16EVR(n,s,base);
> SAVE_16EVR(n+16,s,base)
> -
> -#define REST_EVR(n,s,base)    lwz s,THREAD_EVR0+4*(n)(base);  
> evmergelo
> n,s,n
> -#define REST_2EVR(n,s,base)    REST_EVR(n,s,base); REST_EVR(n 
> +1,s,base)
> -#define REST_4EVR(n,s,base)    REST_2EVR(n,s,base);
> REST_2EVR(n+2,s,base)
> -#define REST_8EVR(n,s,base)    REST_4EVR(n,s,base);
> REST_4EVR(n+4,s,base)
> -#define REST_16EVR(n,s,base)    REST_8EVR(n,s,base);
> REST_8EVR(n+8,s,base)
> -#define REST_32EVR(n,s,base)    REST_16EVR(n,s,base);
> REST_16EVR(n+16,s,base)
> -
> -#ifdef CONFIG_PPC601_SYNC_FIX
> -#define SYNC                \
> -BEGIN_FTR_SECTION            \
> -    sync;                \
> -    isync;                \
> -END_FTR_SECTION_IFSET(CPU_FTR_601)
> -#define SYNC_601            \
> -BEGIN_FTR_SECTION            \
> -    sync;                \
> -END_FTR_SECTION_IFSET(CPU_FTR_601)
> -#define ISYNC_601            \
> -BEGIN_FTR_SECTION            \
> -    isync;                \
> -END_FTR_SECTION_IFSET(CPU_FTR_601)
> -#else
> -#define    SYNC
> -#define SYNC_601
> -#define ISYNC_601
> -#endif
> -
> -#ifndef CONFIG_SMP
> -#define TLBSYNC
> -#else /* CONFIG_SMP */
> -/* tlbsync is not implemented on 601 */
> -#define TLBSYNC                \
> -BEGIN_FTR_SECTION            \
> -    tlbsync;            \
> -    sync;                \
> -END_FTR_SECTION_IFCLR(CPU_FTR_601)
> -#endif
> -
> -/*
> - * This instruction is not implemented on the PPC 603 or 601;  
> however,
> on
> - * the 403GCX and 405GP tlbia IS defined and tlbie is not.
> - * All of these instructions exist in the 8xx, they have magical
> powers,
> - * and they must be used.
> - */
> -
> -#if !defined(CONFIG_4xx) && !defined(CONFIG_8xx)
> -#define tlbia                    \
> -    li    r4,1024;            \
> -    mtctr    r4;                \
> -    lis    r4,KERNELBASE@h;        \
> -0:    tlbie    r4;                \
> -    addi    r4,r4,0x1000;            \
> -    bdnz    0b
> -#endif
> -
> -#ifdef CONFIG_BOOKE
> -#define tophys(rd,rs)                \
> -    addis    rd,rs,0
> -
> -#define tovirt(rd,rs)                \
> -    addis    rd,rs,0
> -
> -#else  /* CONFIG_BOOKE */
> -/*
> - * On APUS (Amiga PowerPC cpu upgrade board), we don't know the
> - * physical base address of RAM at compile time.
> - */
> -#define tophys(rd,rs)                \
> -0:    addis    rd,rs,-KERNELBASE@h;        \
> -    .section ".vtop_fixup","aw";        \
> -    .align  1;                \
> -    .long   0b;                \
> -    .previous
> -
> -#define tovirt(rd,rs)                \
> -0:    addis    rd,rs,KERNELBASE@h;        \
> -    .section ".ptov_fixup","aw";        \
> -    .align  1;                \
> -    .long   0b;                \
> -    .previous
> -#endif  /* CONFIG_BOOKE */
> -
> -/*
> - * On 64-bit cpus, we use the rfid instruction instead of rfi, but
> - * we then have to make sure we preserve the top 32 bits except for
> - * the 64-bit mode bit, which we clear.
> - */
> -#ifdef CONFIG_PPC64BRIDGE
> -#define    FIX_SRR1(ra, rb)    \
> -    mr    rb,ra;        \
> -    mfmsr    ra;        \
> -    clrldi    ra,ra,1;        /* turn off 64-bit mode */ \
> -    rldimi    ra,rb,0,32
> -#define    RFI        .long    0x4c000024    /* rfid
> instruction */
> -#define MTMSRD(r)    .long    (0x7c000164 + ((r) << 21))    /*
> mtmsrd */
> -#define CLR_TOP32(r)    rlwinm    (r),(r),0,0,31    /* clear top  
> 32 bits */
> -
> -#else
> -#define FIX_SRR1(ra, rb)
> -#ifndef CONFIG_40x
> -#define    RFI        rfi
> -#else
> -#define RFI        rfi; b .    /* Prevent prefetch past rfi */
> -#endif
> -#define MTMSRD(r)    mtmsr    r
> -#define CLR_TOP32(r)
> -#endif /* CONFIG_PPC64BRIDGE */
> -
> -#define RFCI        .long 0x4c000066    /* rfci instruction */
> -#define RFDI        .long 0x4c00004e    /* rfdi instruction */
> -#define RFMCI        .long 0x4c00004c    /* rfmci instruction */
> -
> -#ifdef CONFIG_IBM405_ERR77
> -#define PPC405_ERR77(ra,rb)    dcbt    ra, rb;
> -#define    PPC405_ERR77_SYNC    sync;
> -#else
> -#define PPC405_ERR77(ra,rb)
> -#define PPC405_ERR77_SYNC
> -#endif
> -
> -#ifdef CONFIG_IBM440EP_ERR42
> -#define PPC440EP_ERR42 isync
> -#else
> -#define PPC440EP_ERR42
> -#endif
> -
> -/* The boring bits... */
> -
> -/* Condition Register Bit Fields */
> -
> -#define    cr0    0
> -#define    cr1    1
> -#define    cr2    2
> -#define    cr3    3
> -#define    cr4    4
> -#define    cr5    5
> -#define    cr6    6
> -#define    cr7    7
> -
> -
> -/* General Purpose Registers (GPRs) */
> -
> -#define    r0    0
> -#define    r1    1
> -#define    r2    2
> -#define    r3    3
> -#define    r4    4
> -#define    r5    5
> -#define    r6    6
> -#define    r7    7
> -#define    r8    8
> -#define    r9    9
> -#define    r10    10
> -#define    r11    11
> -#define    r12    12
> -#define    r13    13
> -#define    r14    14
> -#define    r15    15
> -#define    r16    16
> -#define    r17    17
> -#define    r18    18
> -#define    r19    19
> -#define    r20    20
> -#define    r21    21
> -#define    r22    22
> -#define    r23    23
> -#define    r24    24
> -#define    r25    25
> -#define    r26    26
> -#define    r27    27
> -#define    r28    28
> -#define    r29    29
> -#define    r30    30
> -#define    r31    31
> -
> -
> -/* Floating Point Registers (FPRs) */
> -
> -#define    fr0    0
> -#define    fr1    1
> -#define    fr2    2
> -#define    fr3    3
> -#define    fr4    4
> -#define    fr5    5
> -#define    fr6    6
> -#define    fr7    7
> -#define    fr8    8
> -#define    fr9    9
> -#define    fr10    10
> -#define    fr11    11
> -#define    fr12    12
> -#define    fr13    13
> -#define    fr14    14
> -#define    fr15    15
> -#define    fr16    16
> -#define    fr17    17
> -#define    fr18    18
> -#define    fr19    19
> -#define    fr20    20
> -#define    fr21    21
> -#define    fr22    22
> -#define    fr23    23
> -#define    fr24    24
> -#define    fr25    25
> -#define    fr26    26
> -#define    fr27    27
> -#define    fr28    28
> -#define    fr29    29
> -#define    fr30    30
> -#define    fr31    31
> -
> -#define    vr0    0
> -#define    vr1    1
> -#define    vr2    2
> -#define    vr3    3
> -#define    vr4    4
> -#define    vr5    5
> -#define    vr6    6
> -#define    vr7    7
> -#define    vr8    8
> -#define    vr9    9
> -#define    vr10    10
> -#define    vr11    11
> -#define    vr12    12
> -#define    vr13    13
> -#define    vr14    14
> -#define    vr15    15
> -#define    vr16    16
> -#define    vr17    17
> -#define    vr18    18
> -#define    vr19    19
> -#define    vr20    20
> -#define    vr21    21
> -#define    vr22    22
> -#define    vr23    23
> -#define    vr24    24
> -#define    vr25    25
> -#define    vr26    26
> -#define    vr27    27
> -#define    vr28    28
> -#define    vr29    29
> -#define    vr30    30
> -#define    vr31    31
> -
> -#define    evr0    0
> -#define    evr1    1
> -#define    evr2    2
> -#define    evr3    3
> -#define    evr4    4
> -#define    evr5    5
> -#define    evr6    6
> -#define    evr7    7
> -#define    evr8    8
> -#define    evr9    9
> -#define    evr10    10
> -#define    evr11    11
> -#define    evr12    12
> -#define    evr13    13
> -#define    evr14    14
> -#define    evr15    15
> -#define    evr16    16
> -#define    evr17    17
> -#define    evr18    18
> -#define    evr19    19
> -#define    evr20    20
> -#define    evr21    21
> -#define    evr22    22
> -#define    evr23    23
> -#define    evr24    24
> -#define    evr25    25
> -#define    evr26    26
> -#define    evr27    27
> -#define    evr28    28
> -#define    evr29    29
> -#define    evr30    30
> -#define    evr31    31
> -
> -/* some stab codes */
> -#define N_FUN    36
> -#define N_RSYM    64
> -#define N_SLINE    68
> -#define N_SO    100
> diff --git a/include/asm-ppc64/cputable.h b/include/asm-ppc64/ 
> cputable.h
> --- a/include/asm-ppc64/cputable.h
> +++ b/include/asm-ppc64/cputable.h
> @@ -16,7 +16,7 @@
>  #define __ASM_PPC_CPUTABLE_H
>
>  #include <linux/config.h>
> -#include <asm/page.h> /* for ASM_CONST */
> +#include <asm/ppc_asm.h> /* for ASM_CONST */
>
>  /* Exposed to userland CPU features - Must match ppc32 definitions */
>  #define PPC_FEATURE_32            0x80000000
> diff --git a/include/asm-ppc64/mmu.h b/include/asm-ppc64/mmu.h
> --- a/include/asm-ppc64/mmu.h
> +++ b/include/asm-ppc64/mmu.h
> @@ -14,6 +14,7 @@
>  #define _PPC64_MMU_H_
>
>  #include <linux/config.h>
> +#include <asm/ppc_asm.h> /* for ASM_CONST */
>  #include <asm/page.h>
>
>  /*
> diff --git a/include/asm-ppc64/page.h b/include/asm-ppc64/page.h
> --- a/include/asm-ppc64/page.h
> +++ b/include/asm-ppc64/page.h
> @@ -11,13 +11,7 @@
>   */
>
>  #include <linux/config.h>
> -
> -#ifdef __ASSEMBLY__
> -  #define ASM_CONST(x) x
> -#else
> -  #define __ASM_CONST(x) x##UL
> -  #define ASM_CONST(x) __ASM_CONST(x)
> -#endif
> +#include <asm/ppc_asm.h> /* for ASM_CONST */
>
>  /* PAGE_SHIFT determines the page size */
>  #define PAGE_SHIFT    12
> diff --git a/include/asm-ppc64/ppc_asm.h b/include/asm-ppc64/ppc_asm.h
> deleted file mode 100644
> --- a/include/asm-ppc64/ppc_asm.h
> +++ /dev/null
> @@ -1,242 +0,0 @@
> -/*
> - * arch/ppc64/kernel/ppc_asm.h
> - *
> - * Definitions used by various bits of low-level assembly code on
> PowerPC.
> - *
> - * Copyright (C) 1995-1999 Gary Thomas, Paul Mackerras, Cort Dougan.
> - *
> - *  This program is free software; you can redistribute it and/or
> - *  modify it under the terms of the GNU General Public License
> - *  as published by the Free Software Foundation; either version
> - *  2 of the License, or (at your option) any later version.
> - */
> -
> -#ifndef _PPC64_PPC_ASM_H
> -#define _PPC64_PPC_ASM_H
> -/*
> - * Macros for storing registers into and loading registers from
> - * exception frames.
> - */
> -#define SAVE_GPR(n, base)    std    n,GPR0+8*(n)(base)
> -#define SAVE_2GPRS(n, base)    SAVE_GPR(n, base); SAVE_GPR(n+1, base)
> -#define SAVE_4GPRS(n, base)    SAVE_2GPRS(n, base); SAVE_2GPRS(n+2,
> base)
> -#define SAVE_8GPRS(n, base)    SAVE_4GPRS(n, base); SAVE_4GPRS(n+4,
> base)
> -#define SAVE_10GPRS(n, base)    SAVE_8GPRS(n, base); SAVE_2GPRS(n+8,
> base)
> -#define REST_GPR(n, base)    ld    n,GPR0+8*(n)(base)
> -#define REST_2GPRS(n, base)    REST_GPR(n, base); REST_GPR(n+1, base)
> -#define REST_4GPRS(n, base)    REST_2GPRS(n, base); REST_2GPRS(n+2,
> base)
> -#define REST_8GPRS(n, base)    REST_4GPRS(n, base); REST_4GPRS(n+4,
> base)
> -#define REST_10GPRS(n, base)    REST_8GPRS(n, base); REST_2GPRS(n+8,
> base)
> -
> -#define SAVE_NVGPRS(base)    SAVE_8GPRS(14, base); SAVE_10GPRS(22,
> base)
> -#define REST_NVGPRS(base)    REST_8GPRS(14, base); REST_10GPRS(22,
> base)
> -
> -#define SAVE_FPR(n, base)    stfd    n,THREAD_FPR0+8*(n)(base)
> -#define SAVE_2FPRS(n, base)    SAVE_FPR(n, base); SAVE_FPR(n+1, base)
> -#define SAVE_4FPRS(n, base)    SAVE_2FPRS(n, base); SAVE_2FPRS(n+2,
> base)
> -#define SAVE_8FPRS(n, base)    SAVE_4FPRS(n, base); SAVE_4FPRS(n+4,
> base)
> -#define SAVE_16FPRS(n, base)    SAVE_8FPRS(n, base); SAVE_8FPRS(n+8,
> base)
> -#define SAVE_32FPRS(n, base)    SAVE_16FPRS(n, base); SAVE_16FPRS(n 
> +16,
> base)
> -#define REST_FPR(n, base)    lfd    n,THREAD_FPR0+8*(n)(base)
> -#define REST_2FPRS(n, base)    REST_FPR(n, base); REST_FPR(n+1, base)
> -#define REST_4FPRS(n, base)    REST_2FPRS(n, base); REST_2FPRS(n+2,
> base)
> -#define REST_8FPRS(n, base)    REST_4FPRS(n, base); REST_4FPRS(n+4,
> base)
> -#define REST_16FPRS(n, base)    REST_8FPRS(n, base); REST_8FPRS(n+8,
> base)
> -#define REST_32FPRS(n, base)    REST_16FPRS(n, base); REST_16FPRS(n 
> +16,
> base)
> -
> -#define SAVE_VR(n,b,base)    li b,THREAD_VR0+(16*(n));  stvx n,b,base
> -#define SAVE_2VRS(n,b,base)    SAVE_VR(n,b,base); SAVE_VR(n+1,b,base)
> -#define SAVE_4VRS(n,b,base)    SAVE_2VRS(n,b,base);
> SAVE_2VRS(n+2,b,base)
> -#define SAVE_8VRS(n,b,base)    SAVE_4VRS(n,b,base);
> SAVE_4VRS(n+4,b,base)
> -#define SAVE_16VRS(n,b,base)    SAVE_8VRS(n,b,base);
> SAVE_8VRS(n+8,b,base)
> -#define SAVE_32VRS(n,b,base)    SAVE_16VRS(n,b,base);
> SAVE_16VRS(n+16,b,base)
> -#define REST_VR(n,b,base)    li b,THREAD_VR0+(16*(n)); lvx n,b,base
> -#define REST_2VRS(n,b,base)    REST_VR(n,b,base); REST_VR(n+1,b,base)
> -#define REST_4VRS(n,b,base)    REST_2VRS(n,b,base);
> REST_2VRS(n+2,b,base)
> -#define REST_8VRS(n,b,base)    REST_4VRS(n,b,base);
> REST_4VRS(n+4,b,base)
> -#define REST_16VRS(n,b,base)    REST_8VRS(n,b,base);
> REST_8VRS(n+8,b,base)
> -#define REST_32VRS(n,b,base)    REST_16VRS(n,b,base);
> REST_16VRS(n+16,b,base)
> -
> -/* Macros to adjust thread priority for Iseries hardware  
> multithreading
> */
> -#define HMT_LOW        or 1,1,1
> -#define HMT_MEDIUM    or 2,2,2
> -#define HMT_HIGH    or 3,3,3
> -
> -/* Insert the high 32 bits of the MSR into what will be the new
> -   MSR (via SRR1 and rfid)  This preserves the MSR.SF and MSR.ISF
> -   bits. */
> -
> -#define FIX_SRR1(ra, rb)    \
> -    mr    rb,ra;        \
> -    mfmsr    ra;        \
> -    rldimi    ra,rb,0,32
> -
> -#define CLR_TOP32(r)    rlwinm    (r),(r),0,0,31    /* clear top  
> 32 bits */
> -
> -/*
> - * LOADADDR( rn, name )
> - *   loads the address of 'name' into 'rn'
> - *
> - * LOADBASE( rn, name )
> - *   loads the address (less the low 16 bits) of 'name' into 'rn'
> - *   suitable for base+disp addressing
> - */
> -#define LOADADDR(rn,name) \
> -    lis    rn,name##@highest;    \
> -    ori    rn,rn,name##@higher;    \
> -    rldicr    rn,rn,32,31;        \
> -    oris    rn,rn,name##@h;        \
> -    ori    rn,rn,name##@l
> -
> -#define LOADBASE(rn,name) \
> -    lis    rn,name@highest;    \
> -    ori    rn,rn,name@higher;    \
> -    rldicr    rn,rn,32,31;        \
> -    oris    rn,rn,name@ha
> -
> -
> -#define SET_REG_TO_CONST(reg, value)                 \
> -    lis     reg,(((value)>>48)&0xFFFF);             \
> -    ori     reg,reg,(((value)>>32)&0xFFFF);         \
> -    rldicr  reg,reg,32,31;                          \
> -    oris    reg,reg,(((value)>>16)&0xFFFF);         \
> -    ori     reg,reg,((value)&0xFFFF);
> -
> -#define SET_REG_TO_LABEL(reg, label)                 \
> -    lis     reg,(label)@highest;                    \
> -    ori     reg,reg,(label)@higher;                 \
> -    rldicr  reg,reg,32,31;                          \
> -    oris    reg,reg,(label)@h;                      \
> -    ori     reg,reg,(label)@l;
> -
> -
> -/* PPPBBB - DRENG  If KERNELBASE is always 0xC0...,
> - * Then we can easily do this with one asm insn. -Peter
> - */
> -#define tophys(rd,rs)                           \
> -        lis     rd,((KERNELBASE>>48)&0xFFFF);   \
> -        rldicr  rd,rd,32,31;                    \
> -        sub     rd,rs,rd
> -
> -#define tovirt(rd,rs)                           \
> -        lis     rd,((KERNELBASE>>48)&0xFFFF);   \
> -        rldicr  rd,rd,32,31;                    \
> -        add     rd,rs,rd
> -
> -/* Condition Register Bit Fields */
> -
> -#define    cr0    0
> -#define    cr1    1
> -#define    cr2    2
> -#define    cr3    3
> -#define    cr4    4
> -#define    cr5    5
> -#define    cr6    6
> -#define    cr7    7
> -
> -
> -/* General Purpose Registers (GPRs) */
> -
> -#define    r0    0
> -#define    r1    1
> -#define    r2    2
> -#define    r3    3
> -#define    r4    4
> -#define    r5    5
> -#define    r6    6
> -#define    r7    7
> -#define    r8    8
> -#define    r9    9
> -#define    r10    10
> -#define    r11    11
> -#define    r12    12
> -#define    r13    13
> -#define    r14    14
> -#define    r15    15
> -#define    r16    16
> -#define    r17    17
> -#define    r18    18
> -#define    r19    19
> -#define    r20    20
> -#define    r21    21
> -#define    r22    22
> -#define    r23    23
> -#define    r24    24
> -#define    r25    25
> -#define    r26    26
> -#define    r27    27
> -#define    r28    28
> -#define    r29    29
> -#define    r30    30
> -#define    r31    31
> -
> -
> -/* Floating Point Registers (FPRs) */
> -
> -#define    fr0    0
> -#define    fr1    1
> -#define    fr2    2
> -#define    fr3    3
> -#define    fr4    4
> -#define    fr5    5
> -#define    fr6    6
> -#define    fr7    7
> -#define    fr8    8
> -#define    fr9    9
> -#define    fr10    10
> -#define    fr11    11
> -#define    fr12    12
> -#define    fr13    13
> -#define    fr14    14
> -#define    fr15    15
> -#define    fr16    16
> -#define    fr17    17
> -#define    fr18    18
> -#define    fr19    19
> -#define    fr20    20
> -#define    fr21    21
> -#define    fr22    22
> -#define    fr23    23
> -#define    fr24    24
> -#define    fr25    25
> -#define    fr26    26
> -#define    fr27    27
> -#define    fr28    28
> -#define    fr29    29
> -#define    fr30    30
> -#define    fr31    31
> -
> -#define    vr0    0
> -#define    vr1    1
> -#define    vr2    2
> -#define    vr3    3
> -#define    vr4    4
> -#define    vr5    5
> -#define    vr6    6
> -#define    vr7    7
> -#define    vr8    8
> -#define    vr9    9
> -#define    vr10    10
> -#define    vr11    11
> -#define    vr12    12
> -#define    vr13    13
> -#define    vr14    14
> -#define    vr15    15
> -#define    vr16    16
> -#define    vr17    17
> -#define    vr18    18
> -#define    vr19    19
> -#define    vr20    20
> -#define    vr21    21
> -#define    vr22    22
> -#define    vr23    23
> -#define    vr24    24
> -#define    vr25    25
> -#define    vr26    26
> -#define    vr27    27
> -#define    vr28    28
> -#define    vr29    29
> -#define    vr30    30
> -#define    vr31    31
> -
> -#endif /* _PPC64_PPC_ASM_H */
> _______________________________________________
> Linuxppc64-dev mailing list
> Linuxppc64-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc64-dev
>
