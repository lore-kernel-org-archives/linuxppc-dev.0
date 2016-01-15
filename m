Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3F7201A0050
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 17:25:27 +1100 (AEDT)
Message-ID: <1452839126.25634.43.camel@neuling.org>
Subject: Re: [PATCH V2 8/8] powerpc: Add the ability to save VSX without
 giving it up
From: Michael Neuling <mikey@neuling.org>
To: Cyril Bur <cyrilbur@gmail.com>, linuxppc-dev@ozlabs.org
Date: Fri, 15 Jan 2016 17:25:26 +1100
In-Reply-To: <1452834254-22078-9-git-send-email-cyrilbur@gmail.com>
References: <1452834254-22078-1-git-send-email-cyrilbur@gmail.com>
 <1452834254-22078-9-git-send-email-cyrilbur@gmail.com>
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

On Fri, 2016-01-15 at 16:04 +1100, Cyril Bur wrote:
> This patch adds the ability to be able to save the VSX registers to
> the
> thread struct without giving up (disabling the facility) next time
> the
> process returns to userspace.
>=20
> This patch builds on a previous optimisation for the FPU and VEC
> registers
> in the thread copy path to avoid a possibly pointless reload of VSX
> state.
>=20
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> ---
>  arch/powerpc/include/asm/switch_to.h |  1 -
>  arch/powerpc/kernel/ppc_ksyms.c      |  4 ----
>  arch/powerpc/kernel/process.c        | 23 ++++++++++++++++++-----
>  arch/powerpc/kernel/vector.S         | 17 -----------------
>  4 files changed, 18 insertions(+), 27 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/switch_to.h
> b/arch/powerpc/include/asm/switch_to.h
> index 29dda9d..4dfcd3e 100644
> --- a/arch/powerpc/include/asm/switch_to.h
> +++ b/arch/powerpc/include/asm/switch_to.h
> @@ -52,7 +52,6 @@ static inline void disable_kernel_altivec(void)
>  extern void enable_kernel_vsx(void);
>  extern void flush_vsx_to_thread(struct task_struct *);
>  extern void giveup_vsx(struct task_struct *);
> -extern void __giveup_vsx(struct task_struct *);
>  static inline void disable_kernel_vsx(void)
>  {
>  	msr_check_and_clear(MSR_FP|MSR_VEC|MSR_VSX);
> diff --git a/arch/powerpc/kernel/ppc_ksyms.c
> b/arch/powerpc/kernel/ppc_ksyms.c
> index 41e1607..ef7024da 100644
> --- a/arch/powerpc/kernel/ppc_ksyms.c
> +++ b/arch/powerpc/kernel/ppc_ksyms.c
> @@ -28,10 +28,6 @@ EXPORT_SYMBOL(load_vr_state);
>  EXPORT_SYMBOL(store_vr_state);
>  #endif
> =20
> -#ifdef CONFIG_VSX
> -EXPORT_SYMBOL_GPL(__giveup_vsx);
> -#endif
> -
>  #ifdef CONFIG_EPAPR_PARAVIRT
>  EXPORT_SYMBOL(epapr_hypercall_start);
>  #endif
> diff --git a/arch/powerpc/kernel/process.c
> b/arch/powerpc/kernel/process.c
> index 5566c32..3d907b8 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -252,20 +252,33 @@ EXPORT_SYMBOL_GPL(flush_altivec_to_thread);
>  #endif /* CONFIG_ALTIVEC */
> =20
>  #ifdef CONFIG_VSX
> -void giveup_vsx(struct task_struct *tsk)
> +void __giveup_vsx(struct task_struct *tsk)
>  {
> -	check_if_tm_restore_required(tsk);
> -
> -	msr_check_and_set(MSR_FP|MSR_VEC|MSR_VSX);
>  	if (tsk->thread.regs->msr & MSR_FP)
>  		__giveup_fpu(tsk);
>  	if (tsk->thread.regs->msr & MSR_VEC)
>  		__giveup_altivec(tsk);
> +	tsk->thread.regs->msr &=3D ~MSR_VSX;
> +}
> +
> +void giveup_vsx(struct task_struct *tsk)
> +{
> +	check_if_tm_restore_required(tsk);
> +
> +	msr_check_and_set(MSR_FP|MSR_VEC|MSR_VSX);
>  	__giveup_vsx(tsk);
>  	msr_check_and_clear(MSR_FP|MSR_VEC|MSR_VSX);
>  }
>  EXPORT_SYMBOL(giveup_vsx);
> =20
> +void save_vsx(struct task_struct *tsk)
> +{
> +	if (tsk->thread.regs->msr & MSR_FP)
> +		save_fpu(tsk);
> +	if (tsk->thread.regs->msr & MSR_VEC)
> +		save_altivec(tsk);
> +}
> +
>  void enable_kernel_vsx(void)
>  {
>  	WARN_ON(preemptible());
> @@ -465,7 +478,7 @@ void save_all(struct task_struct *tsk)
>  #endif
>  #ifdef CONFIG_VSX
>  	if (usermsr & MSR_VSX)
> -		__giveup_vsx(tsk);
> +		save_vsx(tsk);

This seems suboptimal.  save_vsx() will call save_fpu() and
save_altivec() again, which you just called earlier in save_all().

save_vsx() is only used here, so could be static.=20

Also, put the #ifdef junk as part of the function so that the caller
doesn't have to deal with it.=20

Mikey

>  #endif
>  #ifdef CONFIG_SPE
>  	if (usermsr & MSR_SPE)
> diff --git a/arch/powerpc/kernel/vector.S
> b/arch/powerpc/kernel/vector.S
> index 51b0c17..1c2e7a3 100644
> --- a/arch/powerpc/kernel/vector.S
> +++ b/arch/powerpc/kernel/vector.S
> @@ -151,23 +151,6 @@ _GLOBAL(load_up_vsx)
>  	std	r12,_MSR(r1)
>  	b	fast_exception_return
> =20
> -/*
> - * __giveup_vsx(tsk)
> - * Disable VSX for the task given as the argument.
> - * Does NOT save vsx registers.
> - */
> -_GLOBAL(__giveup_vsx)
> -	addi	r3,r3,THREAD		/* want THREAD of
> task */
> -	ld	r5,PT_REGS(r3)
> -	cmpdi	0,r5,0
> -	beq	1f
> -	ld	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
> -	lis	r3,MSR_VSX@h
> -	andc	r4,r4,r3		/* disable VSX for
> previous task */
> -	std	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
> -1:
> -	blr
> -
>  #endif /* CONFIG_VSX */
> =20
> =20
