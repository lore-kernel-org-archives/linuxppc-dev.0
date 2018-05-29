Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wWJG4b3lzDr30
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 10:12:46 +1000 (AEST)
Date: Wed, 30 May 2018 09:40:27 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: wei.guo.simon@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH v4 04/29] KVM: PPC: Book3S PR: Move
 kvmppc_save_tm/kvmppc_restore_tm to separate file
Message-ID: <20180529234027.GA28144@fergus.ozlabs.ibm.com>
References: <1527058932-7434-1-git-send-email-wei.guo.simon@gmail.com>
 <1527058932-7434-5-git-send-email-wei.guo.simon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1527058932-7434-5-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 23, 2018 at 03:01:47PM +0800, wei.guo.simon@gmail.com wrote:
> From: Simon Guo <wei.guo.simon@gmail.com>
> 
> It is a simple patch just for moving kvmppc_save_tm/kvmppc_restore_tm()
> functionalities to tm.S. There is no logic change. The reconstruct of
> those APIs will be done in later patches to improve readability.
> 
> It is for preparation of reusing those APIs on both HV/PR PPC KVM.
> 
> Some slight change during move the functions includes:
> - surrounds some HV KVM specific code with CONFIG_KVM_BOOK3S_HV_POSSIBLE
> for compilation.
> - use _GLOBAL() to define kvmppc_save_tm/kvmppc_restore_tm()
> 
> Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
> ---
>  arch/powerpc/kvm/Makefile               |   3 +
>  arch/powerpc/kvm/book3s_hv_rmhandlers.S | 322 ----------------------------
>  arch/powerpc/kvm/tm.S                   | 363 ++++++++++++++++++++++++++++++++
>  3 files changed, 366 insertions(+), 322 deletions(-)
>  create mode 100644 arch/powerpc/kvm/tm.S
> 
> diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
> index 4b19da8..f872c04 100644
> --- a/arch/powerpc/kvm/Makefile
> +++ b/arch/powerpc/kvm/Makefile
> @@ -63,6 +63,9 @@ kvm-pr-y := \
>  	book3s_64_mmu.o \
>  	book3s_32_mmu.o
>  
> +kvm-book3s_64-builtin-objs-$(CONFIG_KVM_BOOK3S_64_HANDLER) += \
> +	tm.o
> +
>  ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
>  kvm-book3s_64-builtin-objs-$(CONFIG_KVM_BOOK3S_64_HANDLER) += \
>  	book3s_rmhandlers.o
> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> index 5e6e493..4db2b10 100644
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -39,8 +39,6 @@ BEGIN_FTR_SECTION;				\
>  	extsw	reg, reg;			\
>  END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
>  
> -#define VCPU_GPRS_TM(reg) (((reg) * ULONG_SIZE) + VCPU_GPR_TM)
> -
>  /* Values in HSTATE_NAPPING(r13) */
>  #define NAPPING_CEDE	1
>  #define NAPPING_NOVCPU	2
> @@ -3119,326 +3117,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
>  	mr	r4,r31
>  	blr
>  
> -#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> -/*
> - * Save transactional state and TM-related registers.
> - * Called with r9 pointing to the vcpu struct.
> - * This can modify all checkpointed registers, but
> - * restores r1, r2 and r9 (vcpu pointer) before exit.
> - */
> -kvmppc_save_tm:
> -	mflr	r0
> -	std	r0, PPC_LR_STKOFF(r1)
> -	stdu	r1, -PPC_MIN_STKFRM(r1)
> -
> -	/* Turn on TM. */
> -	mfmsr	r8
> -	li	r0, 1
> -	rldimi	r8, r0, MSR_TM_LG, 63-MSR_TM_LG
> -	mtmsrd	r8
> -
> -	ld	r5, VCPU_MSR(r9)
> -	rldicl. r5, r5, 64 - MSR_TS_S_LG, 62
> -	beq	1f	/* TM not active in guest. */
> -
> -	std	r1, HSTATE_HOST_R1(r13)
> -	li	r3, TM_CAUSE_KVM_RESCHED
> -
> -BEGIN_FTR_SECTION
> -	lbz	r0, HSTATE_FAKE_SUSPEND(r13) /* Were we fake suspended? */
> -	cmpwi	r0, 0
> -	beq	3f
> -	rldicl. r8, r8, 64 - MSR_TS_S_LG, 62 /* Did we actually hrfid? */
> -	beq	4f
> -BEGIN_FTR_SECTION_NESTED(96)
> -	bl	pnv_power9_force_smt4_catch
> -END_FTR_SECTION_NESTED(CPU_FTR_P9_TM_XER_SO_BUG, CPU_FTR_P9_TM_XER_SO_BUG, 96)
> -	nop
> -	b	6f
> -3:
> -	/* Emulation of the treclaim instruction needs TEXASR before treclaim */
> -	mfspr	r6, SPRN_TEXASR
> -	std	r6, VCPU_ORIG_TEXASR(r9)
> -6:
> -END_FTR_SECTION_IFSET(CPU_FTR_P9_TM_HV_ASSIST)

It worries me that we now have this TM hypervisor assist stuff in a
place where it could be active with PR KVM.  I think it would be
better to factor out the TM assist code into a separate function which
then calls kvmppc_save_tm if it needs to do an actual treclaim.  I'll
look at doing that.

Paul.
