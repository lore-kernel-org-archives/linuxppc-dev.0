Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f221.google.com (mail-gx0-f221.google.com
	[209.85.217.221]) by ozlabs.org (Postfix) with ESMTP id D68D3B7D4C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 20 May 2010 02:52:24 +1000 (EST)
Received: by gxk21 with SMTP id 21so994380gxk.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 May 2010 09:52:21 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <201003191849.03717.temerkhanov@cifronik.ru>
References: <201003191847.55823.temerkhanov@cifronik.ru>
	<201003191849.03717.temerkhanov@cifronik.ru>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 19 May 2010 10:52:01 -0600
Message-ID: <AANLkTil1Gbg7tED2MgheQjFpZIJMjS-qqmQ7Gu2Vbh5f@mail.gmail.com>
Subject: Re: [PATCH] [RFC] Xilinx Virtex 4 FX Soft FPU support
To: Sergey Temerkhanov <temerkhanov@cifronik.ru>
Content-Type: text/plain; charset=KOI8-R
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 19, 2010 at 9:49 AM, Sergey Temerkhanov
<temerkhanov@cifronik.ru> wrote:
> The patch.
>
> Regards, Resgey Temerkhanov

Hi Sergey.  Comments below.

> diff -r 9d9ac97e095d .config
> --- a/.config	Thu Feb 25 21:23:42 2010 +0300
> +++ b/.config	Thu Feb 25 21:49:02 2010 +0300

.config changes should not appear in your patch file.

> diff -r 9d9ac97e095d arch/powerpc/include/asm/ppc_asm.h
> --- a/arch/powerpc/include/asm/ppc_asm.h	Thu Feb 25 21:23:42 2010 +0300
> +++ b/arch/powerpc/include/asm/ppc_asm.h	Thu Feb 25 21:49:02 2010 +0300
> @@ -85,13 +85,23 @@
>  #define REST_8GPRS(n, base)	REST_4GPRS(n, base); REST_4GPRS(n+4, base)
>  #define REST_10GPRS(n, base)	REST_8GPRS(n, base); REST_2GPRS(n+8, base)
>
> -#define SAVE_FPR(n, base)	stfd	n,THREAD_FPR0+8*TS_FPRWIDTH*(n)(base)
> +
> +#ifdef CONFIG_XILINX_FPU
> +#define stfr stfs
> +#define lfr lfs
> +#else
> +#define stfr stfd
> +#define lfr lfd
> +#endif

the stfr/lfr redirect is a little weird.  Why not simply:

> +
> +#ifdef CONFIG_XILINX_FPU
> +#define SAVE_FPR(n, base)	stfs	n,THREAD_FPR0+8*TS_FPRWIDTH*(n)(base)
> +#define REST_FPR(n, base)	lfs	n,THREAD_FPR0+8*TS_FPRWIDTH*(n)(base)
> +#else
> +#define SAVE_FPR(n, base)	stfd	n,THREAD_FPR0+8*TS_FPRWIDTH*(n)(base)
> +#define REST_FPR(n, base)	lfd	n,THREAD_FPR0+8*TS_FPRWIDTH*(n)(base)
> +#endif

A comment here describing that only single precision works with the
XILINX 405 FPU wouldn't go amiss either.

> diff -r 9d9ac97e095d arch/powerpc/kernel/fpu.S
> --- a/arch/powerpc/kernel/fpu.S	Thu Feb 25 21:23:42 2010 +0300
> +++ b/arch/powerpc/kernel/fpu.S	Thu Feb 25 21:49:02 2010 +0300
> @@ -57,6 +57,9 @@
>  _GLOBAL(load_up_fpu)
>  	mfmsr	r5
>  	ori	r5,r5,MSR_FP
> +#ifdef CONFIG_XILINX_FPU
> +	oris r5,r5,MSR_VEC@h
> +#endif

So AltiVec is being enabled here, but double precision is not
supported?  What instructions are supported?

Also, please stick with the same whitespace convention used in the
lines above (tab indent instead of a space).  Again, a comment would
not go amiss.

>  #ifdef CONFIG_VSX
>  BEGIN_FTR_SECTION
>  	oris	r5,r5,MSR_VSX@h
> @@ -85,6 +88,9 @@
>  	toreal(r5)
>  	PPC_LL	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
>  	li	r10,MSR_FP|MSR_FE0|MSR_FE1
> +#ifdef CONFIG_XILINX_FPU
> +	oris	r10,r10,MSR_VEC@h
> +#endif
>  	andc	r4,r4,r10		/* disable FP for previous task */
>  	PPC_STL	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
>  1:
> @@ -94,6 +100,9 @@
>  	mfspr	r5,SPRN_SPRG3		/* current task's THREAD (phys) */
>  	lwz	r4,THREAD_FPEXC_MODE(r5)
>  	ori	r9,r9,MSR_FP		/* enable FP for current */
> +#ifdef CONFIG_XILINX_FPU
> +	oris	r9,r9,MSR_VEC@h
> +#endif
>  	or	r9,r9,r4
>  #else
>  	ld	r4,PACACURRENT(r13)
> @@ -124,6 +133,9 @@
>  _GLOBAL(giveup_fpu)
>  	mfmsr	r5
>  	ori	r5,r5,MSR_FP
> +#ifdef CONFIG_XILINX_FPU
> +	oris	r5,r5,MSR_VEC@h
> +#endif
>  #ifdef CONFIG_VSX
>  BEGIN_FTR_SECTION
>  	oris	r5,r5,MSR_VSX@h
> @@ -145,6 +157,9 @@
>  	beq	1f
>  	PPC_LL	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
>  	li	r3,MSR_FP|MSR_FE0|MSR_FE1
> +#ifdef CONFIG_XILINX_FPU
> +	oris	r3,r3,MSR_VEC@h
> +#endif
>  #ifdef CONFIG_VSX
>  BEGIN_FTR_SECTION
>  	oris	r3,r3,MSR_VSX@h
> diff -r 9d9ac97e095d arch/powerpc/kernel/head_40x.S
> --- a/arch/powerpc/kernel/head_40x.S	Thu Feb 25 21:23:42 2010 +0300
> +++ b/arch/powerpc/kernel/head_40x.S	Thu Feb 25 21:49:02 2010 +0300
> @@ -420,7 +420,19 @@
>  	addi	r3,r1,STACK_FRAME_OVERHEAD
>  	EXC_XFER_STD(0x700, program_check_exception)
>
> +/* 0x0800 - FPU unavailable Exception */
> +#ifdef CONFIG_PPC_FPU
> +	START_EXCEPTION(0x0800, FloatingPointUnavailable)
> +	NORMAL_EXCEPTION_PROLOG
> +	beq	1f;							      \
> +	bl	load_up_fpu;		/* if from user, just load it up */   \
> +	b	fast_exception_return;					      \
> +1:	addi	r3,r1,STACK_FRAME_OVERHEAD;				      \
> +	EXC_XFER_EE_LITE(0x800, kernel_fp_unavailable_exception)
> +#else
>  	EXCEPTION(0x0800, Trap_08, unknown_exception, EXC_XFER_EE)
> +#endif
> +
>  	EXCEPTION(0x0900, Trap_09, unknown_exception, EXC_XFER_EE)
>  	EXCEPTION(0x0A00, Trap_0A, unknown_exception, EXC_XFER_EE)
>  	EXCEPTION(0x0B00, Trap_0B, unknown_exception, EXC_XFER_EE)
> @@ -432,7 +444,7 @@
>
>  	EXCEPTION(0x0D00, Trap_0D, unknown_exception, EXC_XFER_EE)
>  	EXCEPTION(0x0E00, Trap_0E, unknown_exception, EXC_XFER_EE)
> -	EXCEPTION(0x0F00, Trap_0F, unknown_exception, EXC_XFER_EE)
> +	EXCEPTION(0x0F20, Trap_0F, unknown_exception, EXC_XFER_EE)

Why?

>
>  /* 0x1000 - Programmable Interval Timer (PIT) Exception */
>  	START_EXCEPTION(0x1000, Decrementer)
> @@ -821,8 +833,10 @@
>   * The PowerPC 4xx family of processors do not have an FPU, so this just
>   * returns.
>   */
> +#ifndef CONFIG_PPC_FPU
>  _ENTRY(giveup_fpu)
>  	blr
> +#endif
>
>  /* This is where the main kernel code starts.
>   */
> diff -r 9d9ac97e095d arch/powerpc/platforms/Kconfig.cputype
> --- a/arch/powerpc/platforms/Kconfig.cputype	Thu Feb 25 21:23:42 2010 +0300
> +++ b/arch/powerpc/platforms/Kconfig.cputype	Thu Feb 25 21:49:02 2010 +0300
> @@ -290,4 +290,9 @@
>  config CHECK_CACHE_COHERENCY
>  	bool
>
> +config XILINX_FPU
> +	bool "Xilinx softFPU"
> +	select PPC_FPU
> +	depends on 40x
> +

Should be more specific.  Use something like XILINX_VIRTEX4_405_FPU
(as opposed to Virtex II pro, or the 440 on the Virtex 5.

Also, this looks to be very multiplatform unfriendly, so you'll need
to make sure other 405 board support is not selectable when the Xilinx
FPU is enabled.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
