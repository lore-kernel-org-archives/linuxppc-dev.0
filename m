Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tXs6Q6jXbzDvxY
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Dec 2016 17:24:30 +1100 (AEDT)
Date: Tue, 6 Dec 2016 17:09:07 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] KVM: PPC: Book3S: Change interrupt call to reduce
 scratch space use on HV
Message-ID: <20161206060907.GA25458@fergus.ozlabs.ibm.com>
References: <20161201071812.23258-1-npiggin@gmail.com>
 <20161201071812.23258-2-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161201071812.23258-2-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 01, 2016 at 06:18:10PM +1100, Nicholas Piggin wrote:
> Change the calling convention to put the trap number together with
> CR in two halves of r12, which frees up HSTATE_SCRATCH2 in the HV
> handler, and r9 free.

Cute idea!  Some comments below...

> The 64-bit PR handler entry translates the calling convention back
> to match the previous call convention (i.e., shared with 32-bit), for
> simplicity.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/include/asm/exception-64s.h | 28 +++++++++++++++-------------
>  arch/powerpc/kvm/book3s_hv_rmhandlers.S  | 15 +++++++--------
>  arch/powerpc/kvm/book3s_segment.S        | 27 ++++++++++++++++++++-------
>  3 files changed, 42 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
> index 9a3eee6..bc8fc45 100644
> --- a/arch/powerpc/include/asm/exception-64s.h
> +++ b/arch/powerpc/include/asm/exception-64s.h
> @@ -233,7 +233,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
>  
>  #endif
>  
> -#define __KVM_HANDLER_PROLOG(area, n)					\
> +#define __KVM_HANDLER(area, h, n)					\
>  	BEGIN_FTR_SECTION_NESTED(947)					\
>  	ld	r10,area+EX_CFAR(r13);					\
>  	std	r10,HSTATE_CFAR(r13);					\
> @@ -243,30 +243,32 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
>  	std	r10,HSTATE_PPR(r13);					\
>  	END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,948);	\
>  	ld	r10,area+EX_R10(r13);					\
> -	stw	r9,HSTATE_SCRATCH1(r13);				\
> -	ld	r9,area+EX_R9(r13);					\
>  	std	r12,HSTATE_SCRATCH0(r13);				\
> -
> -#define __KVM_HANDLER(area, h, n)					\
> -	__KVM_HANDLER_PROLOG(area, n)					\
> -	li	r12,n;							\
> +	li	r12,(n);						\
> +	sldi	r12,r12,32;						\
> +	or	r12,r12,r9;						\

Did you consider doing it the other way around, i.e. with r12
containing (cr << 32) | trap?  That would save 1 instruction in each
handler:

+	sldi	r12,r9,32;						\
+	ori	r12,r12,(n);						\

> +	ld	r9,area+EX_R9(r13);					\
> +	std	r9,HSTATE_SCRATCH1(r13);				\

Why not put this std in kvmppc_interrupt[_hv] rather than in each
handler?

>  	b	kvmppc_interrupt
>  
>  #define __KVM_HANDLER_SKIP(area, h, n)					\
>  	cmpwi	r10,KVM_GUEST_MODE_SKIP;				\
> -	ld	r10,area+EX_R10(r13);					\
>  	beq	89f;							\
> -	stw	r9,HSTATE_SCRATCH1(r13);				\
>  	BEGIN_FTR_SECTION_NESTED(948)					\
> -	ld	r9,area+EX_PPR(r13);					\
> -	std	r9,HSTATE_PPR(r13);					\
> +	ld	r10,area+EX_PPR(r13);					\
> +	std	r10,HSTATE_PPR(r13);					\
>  	END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,948);	\
> -	ld	r9,area+EX_R9(r13);					\
> +	ld	r10,area+EX_R10(r13);					\
>  	std	r12,HSTATE_SCRATCH0(r13);				\
> -	li	r12,n;							\
> +	li	r12,(n);						\
> +	sldi	r12,r12,32;						\
> +	or	r12,r12,r9;						\
> +	ld	r9,area+EX_R9(r13);					\
> +	std	r9,HSTATE_SCRATCH1(r13);				\

Same comment again, of course.

>  	b	kvmppc_interrupt;					\
>  89:	mtocrf	0x80,r9;						\
>  	ld	r9,area+EX_R9(r13);					\
> +	ld	r10,area+EX_R10(r13);					\
>  	b	kvmppc_skip_##h##interrupt
>  
>  #ifdef CONFIG_KVM_BOOK3S_64_HANDLER
> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> index c3c1d1b..0536c73 100644
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -1043,19 +1043,18 @@ hdec_soon:
>  kvmppc_interrupt_hv:
>  	/*
>  	 * Register contents:
> -	 * R12		= interrupt vector
> +	 * R12		= (interrupt vector << 32) | guest CR
>  	 * R13		= PACA
> -	 * guest CR, R12 saved in shadow VCPU SCRATCH1/0
> +	 * R9		= unused
> +	 * guest R12, R9 saved in shadow VCPU SCRATCH0/1 respectively
>  	 * guest R13 saved in SPRN_SCRATCH0
>  	 */
> -	std	r9, HSTATE_SCRATCH2(r13)
> -
>  	lbz	r9, HSTATE_IN_GUEST(r13)
>  	cmpwi	r9, KVM_GUEST_MODE_HOST_HV
>  	beq	kvmppc_bad_host_intr
>  #ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
>  	cmpwi	r9, KVM_GUEST_MODE_GUEST
> -	ld	r9, HSTATE_SCRATCH2(r13)
> +	ld	r9, HSTATE_SCRATCH1(r13)
>  	beq	kvmppc_interrupt_pr
>  #endif
>  	/* We're now back in the host but in guest MMU context */
> @@ -1075,14 +1074,13 @@ kvmppc_interrupt_hv:
>  	std	r6, VCPU_GPR(R6)(r9)
>  	std	r7, VCPU_GPR(R7)(r9)
>  	std	r8, VCPU_GPR(R8)(r9)
> -	ld	r0, HSTATE_SCRATCH2(r13)
> +	ld	r0, HSTATE_SCRATCH1(r13)
>  	std	r0, VCPU_GPR(R9)(r9)
>  	std	r10, VCPU_GPR(R10)(r9)
>  	std	r11, VCPU_GPR(R11)(r9)
>  	ld	r3, HSTATE_SCRATCH0(r13)
> -	lwz	r4, HSTATE_SCRATCH1(r13)
>  	std	r3, VCPU_GPR(R12)(r9)
> -	stw	r4, VCPU_CR(r9)
> +	stw	r12, VCPU_CR(r9)	/* CR is in the low half of r12 */

This would then need to be srdi r4, r12, 32; stw r4, VCPU_CR(r9)

>  BEGIN_FTR_SECTION
>  	ld	r3, HSTATE_CFAR(r13)
>  	std	r3, VCPU_CFAR(r9)
> @@ -1100,6 +1098,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
>  	mfspr	r11, SPRN_SRR1
>  	std	r10, VCPU_SRR0(r9)
>  	std	r11, VCPU_SRR1(r9)
> +	srdi	r12, r12, 32		/* trap is in the high half of r12 */

and this would become clrldi r12,r12,32 though arguably that's not
totally necessary since we always do cmpwi/stw/lwz on r12 (but I'd
feel safer with the clrldi in place).

Cheers,
Paul.
