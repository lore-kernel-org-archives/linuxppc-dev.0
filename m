Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 195A02C008C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2013 00:54:31 +1100 (EST)
Subject: Re: [PATCH 08/17] powerpc: Add FP/VSX and VMX register load functions
 for transactional memory
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1360729895-304-9-git-send-email-mikey@neuling.org>
Date: Wed, 13 Feb 2013 07:54:19 -0600
Message-Id: <0233B491-CB0D-4B0C-9859-8B486D3C3314@kernel.crashing.org>
References: <1360729895-304-1-git-send-email-mikey@neuling.org>
 <1360729895-304-9-git-send-email-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org, Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 12, 2013, at 10:31 PM, Michael Neuling wrote:

> This adds functions to restore the state of the FP/VSX registers from
> what's stored in the thread_struct.  Two version for FP/VSX are =
required
> since one restores them from transactional/checkpoint side of the
> thread_struct and the other from the speculated side.
>=20
> Similar functions are added for VMX registers.
>=20
> Signed-off-by: Matt Evans <matt@ozlabs.org>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
> arch/powerpc/kernel/fpu.S    |   54 =
++++++++++++++++++++++++++++++++++++++++++
> arch/powerpc/kernel/vector.S |   51 =
+++++++++++++++++++++++++++++++++++++++
> 2 files changed, 105 insertions(+)
>=20
> diff --git a/arch/powerpc/kernel/fpu.S b/arch/powerpc/kernel/fpu.S
> index adb1551..0441ba6 100644
> --- a/arch/powerpc/kernel/fpu.S
> +++ b/arch/powerpc/kernel/fpu.S
> @@ -62,6 +62,60 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX);			=
		\
> 	__REST_32FPVSRS_TRANSACT(n,__REG_##c,__REG_##base)
> #define SAVE_32FPVSRS(n,c,base) =
__SAVE_32FPVSRS(n,__REG_##c,__REG_##base)
>=20
> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> +/*
> + * Wrapper to call load_up_fpu from C.
> + * void do_load_up_fpu(struct pt_regs *regs);
> + */
> +_GLOBAL(do_load_up_fpu)
> +	mflr	r0
> +	std	r0, 16(r1)
> +	stdu	r1, -112(r1)
> +
> +	subi	r6, r3, STACK_FRAME_OVERHEAD
> +	/* load_up_fpu expects r12=3DMSR, r13=3DPACA, and returns
> +	 * with r12 =3D new MSR.
> +	 */
> +	ld	r12,_MSR(r6)
> +	GET_PACA(r13)
> +
> +	bl	load_up_fpu
> +	std	r12,_MSR(r6)
> +
> +	ld	r0, 112+16(r1)
> +	addi	r1, r1, 112
> +	mtlr	r0
> +	blr
> +
> +
> +/* void do_load_up_fpu(struct thread_struct *thread)

Comment is wrong, should be void do_load_up_transact_fpu(...)

> + *
> + * This is similar to load_up_fpu but for the transactional version =
of the FP
> + * register set.  It doesn't mess with the task MSR or valid flags.
> + * Furthermore, we don't do lazy FP with TM currently.
> + */
> +_GLOBAL(do_load_up_transact_fpu)
> +	mfmsr	r6
> +	ori	r5,r6,MSR_FP
> +#ifdef CONFIG_VSX
> +BEGIN_FTR_SECTION
> +	oris	r5,r5,MSR_VSX@h
> +END_FTR_SECTION_IFSET(CPU_FTR_VSX)
> +#endif
> +	SYNC
> +	MTMSRD(r5)
> +
> +	lfd	fr0,THREAD_TRANSACT_FPSCR(r3)
> +	MTFSF_L(fr0)
> +	REST_32FPVSRS_TRANSACT(0, R4, R3)
> +
> +	/* FP/VSX off again */
> +	MTMSRD(r6)
> +	SYNC
> +
> +	blr
> +#endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
> +
> /*
>  * This task wants to use the FPU now.
>  * On UP, disable FP for the task which had the FPU previously,
> diff --git a/arch/powerpc/kernel/vector.S =
b/arch/powerpc/kernel/vector.S
> index e830289..7112a24 100644
> --- a/arch/powerpc/kernel/vector.S
> +++ b/arch/powerpc/kernel/vector.S
> @@ -7,6 +7,57 @@
> #include <asm/page.h>
> #include <asm/ptrace.h>
>=20
> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> +/*
> + * Wrapper to call load_up_altivec from C.
> + * void do_load_up_altivec(struct pt_regs *regs);
> + */
> +_GLOBAL(do_load_up_altivec)
> +	mflr	r0
> +	std	r0, 16(r1)
> +	stdu	r1, -112(r1)
> +
> +	subi	r6, r3, STACK_FRAME_OVERHEAD
> +	/* load_up_altivec expects r12=3DMSR, r13=3DPACA, and returns
> +	 * with r12 =3D new MSR.
> +	 */
> +	ld	r12,_MSR(r6)
> +	GET_PACA(r13)
> +	bl	load_up_altivec
> +	std	r12,_MSR(r6)
> +
> +	ld	r0, 112+16(r1)
> +	addi	r1, r1, 112
> +	mtlr	r0
> +	blr
> +
> +/* void do_load_up_altivec(struct thread_struct *thread)

comment wrong.

> + *
> + * This is similar to load_up_altivec but for the transactional =
version of the
> + * vector regs.  It doesn't mess with the task MSR or valid flags.
> + * Furthermore, VEC laziness is not supported with TM currently.
> + */
> +_GLOBAL(do_load_up_transact_altivec)
> +	mfmsr	r6
> +	oris	r5,r6,MSR_VEC@h
> +	MTMSRD(r5)
> +	isync
> +
> +	li	r4,1
> +	stw	r4,THREAD_USED_VR(r3)
> +
> +	li	r10,THREAD_TRANSACT_VSCR
> +	lvx	vr0,r10,r3
> +	mtvscr	vr0
> +	REST_32VRS_TRANSACT(0,r4,r3)
> +
> +	/* Disable VEC again. */
> +	MTMSRD(r6)
> +	isync
> +
> +	blr
> +#endif
> +
> /*
>  * load_up_altivec(unused, unused, tsk)
>  * Disable VMX for the task which had it previously,
> --=20
> 1.7.10.4
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
