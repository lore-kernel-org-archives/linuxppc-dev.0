Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0128.outbound.protection.outlook.com [65.55.169.128])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 24BC81A02AF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 08:35:23 +1000 (AEST)
Message-ID: <1432161308.27761.116.camel@freescale.com>
Subject: Re: [PATCH 1/1] KVM: PPC: Book3S: correct width in XER handling
From: Scott Wood <scottwood@freescale.com>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
CC: <kvm-ppc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <paulus@samba.org>, Mihai Caraman <mihai.caraman@freescale.com>
Date: Wed, 20 May 2015 17:35:08 -0500
In-Reply-To: <d0600fe7952351dfd176c97d416a6a351812a78b.1432099563.git.sam.bobroff@au1.ibm.com>
References: <d0600fe7952351dfd176c97d416a6a351812a78b.1432099563.git.sam.bobroff@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-05-20 at 15:26 +1000, Sam Bobroff wrote:
> In 64 bit kernels, the Fixed Point Exception Register (XER) is a 64
> bit field (e.g. in kvm_regs and kvm_vcpu_arch) and in most places it is
> accessed as such.
> 
> This patch corrects places where it is accessed as a 32 bit field by a
> 64 bit kernel.  In some cases this is via a 32 bit load or store
> instruction which, depending on endianness, will cause either the
> lower or upper 32 bits to be missed.  In another case it is cast as a
> u32, causing the upper 32 bits to be cleared.
> 
> This patch corrects those places by extending the access methods to
> 64 bits.
> 
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> ---
> 
>  arch/powerpc/include/asm/kvm_book3s.h   |    4 ++--
>  arch/powerpc/kvm/book3s_hv_rmhandlers.S |    6 +++---
>  arch/powerpc/kvm/book3s_segment.S       |    4 ++--
>  3 files changed, 7 insertions(+), 7 deletions(-)

It's nominally a 64-bit register, but the upper 32 bits are reserved in
ISA 2.06.  Do newer ISAs or certain implementations define things in the
upper 32 bits, or is this just about the asm accesses being wrong on
big-endian?

Also, I see the same issue in the booke code (CCing Mihai).

-Scott

> diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
> index b91e74a..05a875a 100644
> --- a/arch/powerpc/include/asm/kvm_book3s.h
> +++ b/arch/powerpc/include/asm/kvm_book3s.h
> @@ -225,12 +225,12 @@ static inline u32 kvmppc_get_cr(struct kvm_vcpu *vcpu)
>  	return vcpu->arch.cr;
>  }
>  
> -static inline void kvmppc_set_xer(struct kvm_vcpu *vcpu, u32 val)
> +static inline void kvmppc_set_xer(struct kvm_vcpu *vcpu, ulong val)
>  {
>  	vcpu->arch.xer = val;
>  }
>  
> -static inline u32 kvmppc_get_xer(struct kvm_vcpu *vcpu)
> +static inline ulong kvmppc_get_xer(struct kvm_vcpu *vcpu)
>  {
>  	return vcpu->arch.xer;
>  }
> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> index 4d70df2..d75be59 100644
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -870,7 +870,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
>  	blt	hdec_soon
>  
>  	ld	r6, VCPU_CTR(r4)
> -	lwz	r7, VCPU_XER(r4)
> +	ld	r7, VCPU_XER(r4)
>  
>  	mtctr	r6
>  	mtxer	r7
> @@ -1103,7 +1103,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
>  	mfctr	r3
>  	mfxer	r4
>  	std	r3, VCPU_CTR(r9)
> -	stw	r4, VCPU_XER(r9)
> +	std	r4, VCPU_XER(r9)
>  
>  	/* If this is a page table miss then see if it's theirs or ours */
>  	cmpwi	r12, BOOK3S_INTERRUPT_H_DATA_STORAGE
> @@ -1675,7 +1675,7 @@ kvmppc_hdsi:
>  	bl	kvmppc_msr_interrupt
>  fast_interrupt_c_return:
>  6:	ld	r7, VCPU_CTR(r9)
> -	lwz	r8, VCPU_XER(r9)
> +	ld	r8, VCPU_XER(r9)
>  	mtctr	r7
>  	mtxer	r8
>  	mr	r4, r9
> diff --git a/arch/powerpc/kvm/book3s_segment.S b/arch/powerpc/kvm/book3s_segment.S
> index acee37c..ca8f174 100644
> --- a/arch/powerpc/kvm/book3s_segment.S
> +++ b/arch/powerpc/kvm/book3s_segment.S
> @@ -123,7 +123,7 @@ no_dcbz32_on:
>  	PPC_LL	r8, SVCPU_CTR(r3)
>  	PPC_LL	r9, SVCPU_LR(r3)
>  	lwz	r10, SVCPU_CR(r3)
> -	lwz	r11, SVCPU_XER(r3)
> +	PPC_LL	r11, SVCPU_XER(r3)
>  
>  	mtctr	r8
>  	mtlr	r9
> @@ -237,7 +237,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
>  	mfctr	r8
>  	mflr	r9
>  
> -	stw	r5, SVCPU_XER(r13)
> +	PPC_STL	r5, SVCPU_XER(r13)
>  	PPC_STL	r6, SVCPU_FAULT_DAR(r13)
>  	stw	r7, SVCPU_FAULT_DSISR(r13)
>  	PPC_STL	r8, SVCPU_CTR(r13)
