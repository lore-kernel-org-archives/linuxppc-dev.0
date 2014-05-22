Return-Path: <sivasakthi7@outlook.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CDADF1A0088
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 07:51:15 +1000 (EST)
Received: from sam.nabble.com (sam.nabble.com [216.139.236.26])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5060C140080
 for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2014 07:51:14 +1000 (EST)
Received: from tom.nabble.com ([192.168.236.105])
 by sam.nabble.com with esmtp (Exim 4.72)
 (envelope-from <sivasakthi7@outlook.com>) id 1WnatN-0006g4-39
 for linuxppc-dev@ozlabs.org; Thu, 22 May 2014 14:51:13 -0700
Date: Thu, 22 May 2014 14:51:13 -0700 (PDT)
From: shiva7 <sivasakthi7@outlook.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <1400795473087-82590.post@n7.nabble.com>
In-Reply-To: <20131023084002.GA8325@iris.ozlabs.ibm.com>
References: <20131023084002.GA8325@iris.ozlabs.ibm.com>
Subject: Re: [PATCH] powerpc: Don't corrupt user registers on 32-bit
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras wrote
> Commit de79f7b9f6 ("powerpc: Put FP/VSX and VR state into structures")
> modified load_up_fpu() and load_up_altivec() in such a way that they
> now use r7 and r8.  Unfortunately, the callers of these functions on
> 32-bit machines then return to userspace via fast_exception_return,
> which doesn't restore all of the volatile GPRs, but only r1, r3 -- r6
> and r9 -- r12.  This was causing userspace segfaults and other
> userspace misbehaviour on 32-bit machines.
> 
> This fixes the problem by changing the register usage of load_up_fpu()
> and load_up_altivec() to avoid using r7 and r8 and instead use r6 and
> r10.  This also adds comments to those functions saying which registers
> may be used.
> 
> Signed-off-by: Paul Mackerras &lt;

> paulus@

> &gt;
> ---
>  arch/powerpc/kernel/fpu.S    | 14 ++++++++------
>  arch/powerpc/kernel/vector.S | 15 +++++++++------
>  2 files changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/fpu.S b/arch/powerpc/kernel/fpu.S
> index 4dca05e..f7f5b8b 100644
> --- a/arch/powerpc/kernel/fpu.S
> +++ b/arch/powerpc/kernel/fpu.S
> @@ -106,6 +106,8 @@ _GLOBAL(store_fp_state)
>   * and save its floating-point registers in its thread_struct.
>   * Load up this task's FP registers from its thread_struct,
>   * enable the FPU for the current task and return to the task.
> + * Note that on 32-bit this can only use registers that will be
> + * restored by fast_exception_return, i.e. r3 - r6, r10 and r11.
>   */
>  _GLOBAL(load_up_fpu)
>  	mfmsr	r5
> @@ -131,10 +133,10 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
>  	beq	1f
>  	toreal(r4)
>  	addi	r4,r4,THREAD		/* want last_task_used_math->thread */
> -	addi	r8,r4,THREAD_FPSTATE
> -	SAVE_32FPVSRS(0, R5, R8)
> +	addi	r10,r4,THREAD_FPSTATE
> +	SAVE_32FPVSRS(0, R5, R10)
>  	mffs	fr0
> -	stfd	fr0,FPSTATE_FPSCR(r8)
> +	stfd	fr0,FPSTATE_FPSCR(r10)
>  	PPC_LL	r5,PT_REGS(r4)
>  	toreal(r5)
>  	PPC_LL	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
> @@ -157,10 +159,10 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
>  	or	r12,r12,r4
>  	std	r12,_MSR(r1)
>  #endif
> -	addi	r7,r5,THREAD_FPSTATE
> -	lfd	fr0,FPSTATE_FPSCR(r7)
> +	addi	r10,r5,THREAD_FPSTATE
> +	lfd	fr0,FPSTATE_FPSCR(r10)
>  	MTFSF_L(fr0)
> -	REST_32FPVSRS(0, R4, R7)
> +	REST_32FPVSRS(0, R4, R10)
>  #ifndef CONFIG_SMP
>  	subi	r4,r5,THREAD
>  	fromreal(r4)
> diff --git a/arch/powerpc/kernel/vector.S b/arch/powerpc/kernel/vector.S
> index eacda4e..0458a9a 100644
> --- a/arch/powerpc/kernel/vector.S
> +++ b/arch/powerpc/kernel/vector.S
> @@ -64,6 +64,9 @@ _GLOBAL(store_vr_state)
>   * Enables the VMX for use in the kernel on return.
>   * On SMP we know the VMX is free, since we give it up every
>   * switch (ie, no lazy save of the vector registers).
> + *
> + * Note that on 32-bit this can only use registers that will be
> + * restored by fast_exception_return, i.e. r3 - r6, r10 and r11.
>   */
>  _GLOBAL(load_up_altivec)
>  	mfmsr	r5			/* grab the current MSR */
> @@ -89,11 +92,11 @@ _GLOBAL(load_up_altivec)
>  	/* Save VMX state to last_task_used_altivec's THREAD struct */
>  	toreal(r4)
>  	addi	r4,r4,THREAD
> -	addi	r7,r4,THREAD_VRSTATE
> -	SAVE_32VRS(0,r5,r7)
> +	addi	r6,r4,THREAD_VRSTATE
> +	SAVE_32VRS(0,r5,r6)
>  	mfvscr	vr0
>  	li	r10,VRSTATE_VSCR
> -	stvx	vr0,r10,r7
> +	stvx	vr0,r10,r6
>  	/* Disable VMX for last_task_used_altivec */
>  	PPC_LL	r5,PT_REGS(r4)
>  	toreal(r5)
> @@ -125,13 +128,13 @@ _GLOBAL(load_up_altivec)
>  	oris	r12,r12,MSR_VEC@h
>  	std	r12,_MSR(r1)
>  #endif
> -	addi	r7,r5,THREAD_VRSTATE
> +	addi	r6,r5,THREAD_VRSTATE
>  	li	r4,1
>  	li	r10,VRSTATE_VSCR
>  	stw	r4,THREAD_USED_VR(r5)
> -	lvx	vr0,r10,r7
> +	lvx	vr0,r10,r6
>  	mtvscr	vr0
> -	REST_32VRS(0,r4,r7)
> +	REST_32VRS(0,r4,r6)
>  #ifndef CONFIG_SMP
>  	/* Update last_task_used_altivec to 'current' */
>  	subi	r4,r5,THREAD		/* Back to 'current' */
> -- 
> 1.8.4.rc3
> 
> _______________________________________________
> Linuxppc-dev mailing list

> Linuxppc-dev@.ozlabs

> https://lists.ozlabs.org/listinfo/linuxppc-dev


By any chance, same corruption is happening for DEBUG_DEBUG exception ?
because I could see similar SEGV but dont have any code/program to prove it
:(



--
View this message in context: http://linuxppc.10917.n7.nabble.com/PATCH-powerpc-Don-t-corrupt-user-registers-on-32-bit-tp77443p82590.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
