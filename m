Return-Path: <srs0=x7fg=5g=gmail.com=sjitindarsingh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wdcmf5RKwzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Jun 2017 16:26:10 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wdcmf4bb4z8sXB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Jun 2017 16:26:10 +1000 (AEST)
Message-ID: <1496298363.4414.4.camel@gmail.com>
Subject: Re: [PATCH V3 2/2] KVM: PPC: Book3S HV: Enable guests to use large
 decrementer mode on POWER9
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org
Cc: kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org
Date: Thu, 01 Jun 2017 16:26:03 +1000
In-Reply-To: <20170529101218.GC13938@fergus.ozlabs.ibm.com>
References: <20170529101113.GA13938@fergus.ozlabs.ibm.com>
 <20170529101218.GC13938@fergus.ozlabs.ibm.com>
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

On Mon, 2017-05-29 at 20:12 +1000, Paul Mackerras wrote:
> This allows userspace (e.g. QEMU) to enable large decrementer mode
> for
> the guest when running on a POWER9 host, by setting the LPCR_LD bit
> in
> the guest LPCR value.  With this, the guest exit code saves 64 bits
> of
> the guest DEC value on exit.  Other places that use the guest DEC
> value check the LPCR_LD bit in the guest LPCR value, and if it is
> set,
> omit the 32-bit sign extension that would otherwise be done.
> 
> This doesn't change the DEC emulation used by PR KVM because PR KVM
> is not supported on POWER9 yet.
> 
> This is partly based on an earlier patch by Oliver O'Halloran.
> 
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>

Tested with a hacked up qemu and upstream guest/host (with these
patches).

Tested-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

> ---
>  arch/powerpc/include/asm/kvm_host.h     |  2 +-
>  arch/powerpc/kvm/book3s_hv.c            |  6 ++++++
>  arch/powerpc/kvm/book3s_hv_rmhandlers.S | 29
> ++++++++++++++++++++++++-----
>  arch/powerpc/kvm/emulate.c              |  4 ++--
>  4 files changed, 33 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/kvm_host.h
> b/arch/powerpc/include/asm/kvm_host.h
> index 9c51ac4..3f879c8 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -579,7 +579,7 @@ struct kvm_vcpu_arch {
>  	ulong mcsrr0;
>  	ulong mcsrr1;
>  	ulong mcsr;
> -	u32 dec;
> +	ulong dec;
>  #ifdef CONFIG_BOOKE
>  	u32 decar;
>  #endif
> diff --git a/arch/powerpc/kvm/book3s_hv.c
> b/arch/powerpc/kvm/book3s_hv.c
> index 42b7a4f..9b2eb66 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -1143,6 +1143,12 @@ static void kvmppc_set_lpcr(struct kvm_vcpu
> *vcpu, u64 new_lpcr,
>  	mask = LPCR_DPFD | LPCR_ILE | LPCR_TC;
>  	if (cpu_has_feature(CPU_FTR_ARCH_207S))
>  		mask |= LPCR_AIL;
> +	/*
> +	 * On POWER9, allow userspace to enable large decrementer
> for the
> +	 * guest, whether or not the host has it enabled.
> +	 */
> +	if (cpu_has_feature(CPU_FTR_ARCH_300))
> +		mask |= LPCR_LD;
>  
>  	/* Broken 32-bit version of LPCR must not clear top bits */
>  	if (preserve_top32)
> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> index e390b38..3c901b5 100644
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -920,7 +920,7 @@ ALT_FTR_SECTION_END_IFCLR(CPU_FTR_ARCH_300)
>  	mftb	r7
>  	subf	r3,r7,r8
>  	mtspr	SPRN_DEC,r3
> -	stw	r3,VCPU_DEC(r4)
> +	std	r3,VCPU_DEC(r4)
>  
>  	ld	r5, VCPU_SPRG0(r4)
>  	ld	r6, VCPU_SPRG1(r4)
> @@ -1032,7 +1032,13 @@ kvmppc_cede_reentry:		/* r4 =
> vcpu, r13 = paca */
>  	li	r0, BOOK3S_INTERRUPT_EXTERNAL
>  	bne	cr1, 12f
>  	mfspr	r0, SPRN_DEC
> -	cmpwi	r0, 0
> +BEGIN_FTR_SECTION
> +	/* On POWER9 check whether the guest has large decrementer
> enabled */
> +	andis.	r8, r8, LPCR_LD@h
> +	bne	15f
> +END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
> +	extsw	r0, r0
> +15:	cmpdi	r0, 0
>  	li	r0, BOOK3S_INTERRUPT_DECREMENTER
>  	bge	5f
>  
> @@ -1459,12 +1465,18 @@ mc_cont:
>  	mtspr	SPRN_SPURR,r4
>  
>  	/* Save DEC */
> +	ld	r3, HSTATE_KVM_VCORE(r13)
>  	mfspr	r5,SPRN_DEC
>  	mftb	r6
> +	/* On P9, if the guest has large decr enabled, don't sign
> extend */
> +BEGIN_FTR_SECTION
> +	ld	r4, VCORE_LPCR(r3)
> +	andis.	r4, r4, LPCR_LD@h
> +	bne	16f
> +END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
>  	extsw	r5,r5
> -	add	r5,r5,r6
> +16:	add	r5,r5,r6
>  	/* r5 is a guest timebase value here, convert to host TB */
> -	ld	r3,HSTATE_KVM_VCORE(r13)
>  	ld	r4,VCORE_TB_OFFSET(r3)
>  	subf	r5,r4,r5
>  	std	r5,VCPU_DEC_EXPIRES(r9)
> @@ -2376,8 +2388,15 @@ END_FTR_SECTION_IFSET(CPU_FTR_TM)
>  	mfspr	r3, SPRN_DEC
>  	mfspr	r4, SPRN_HDEC
>  	mftb	r5
> +BEGIN_FTR_SECTION
> +	/* On P9 check whether the guest has large decrementer mode
> enabled */
> +	ld	r6, HSTATE_KVM_VCORE(r13)
> +	ld	r6, VCORE_LPCR(r6)
> +	andis.	r6, r6, LPCR_LD@h
> +	bne	68f
> +END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
>  	extsw	r3, r3
> -	EXTEND_HDEC(r4)
> +68:	EXTEND_HDEC(r4)
>  	cmpd	r3, r4
>  	ble	67f
>  	mtspr	SPRN_DEC, r4
> diff --git a/arch/powerpc/kvm/emulate.c b/arch/powerpc/kvm/emulate.c
> index c873ffe..4d8b4d6 100644
> --- a/arch/powerpc/kvm/emulate.c
> +++ b/arch/powerpc/kvm/emulate.c
> @@ -39,7 +39,7 @@ void kvmppc_emulate_dec(struct kvm_vcpu *vcpu)
>  	unsigned long dec_nsec;
>  	unsigned long long dec_time;
>  
> -	pr_debug("mtDEC: %x\n", vcpu->arch.dec);
> +	pr_debug("mtDEC: %lx\n", vcpu->arch.dec);
>  	hrtimer_try_to_cancel(&vcpu->arch.dec_timer);
>  
>  #ifdef CONFIG_PPC_BOOK3S
> @@ -109,7 +109,7 @@ static int kvmppc_emulate_mtspr(struct kvm_vcpu
> *vcpu, int sprn, int rs)
>  	case SPRN_TBWU: break;
>  
>  	case SPRN_DEC:
> -		vcpu->arch.dec = spr_val;
> +		vcpu->arch.dec = (u32) spr_val;
>  		kvmppc_emulate_dec(vcpu);
>  		break;
>  
