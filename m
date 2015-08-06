Return-Path: <lvivier@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 06C5E1A17F2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 20:16:29 +1000 (AEST)
Subject: Re: [PATCH v3 1/1] KVM: PPC: Book3S: correct width in XER handling
To: agraf@suse.de
References: <edf0cbb1d82070438f6b03f55e35347ef996503d.1432684609.git.sam.bobroff@au1.ibm.com>
 <20150806012541.GA6697@tungsten.ozlabs.ibm.com>
Cc: Sam Bobroff <sam.bobroff@au1.ibm.com>, kvm-ppc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <55C333F9.3010003@redhat.com>
Date: Thu, 6 Aug 2015 12:16:25 +0200
MIME-Version: 1.0
In-Reply-To: <20150806012541.GA6697@tungsten.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I'd also like to see this patch in the mainstream as it fixes a bug
appearing when we switch from vCPU context to hypervisor context (guest
crash).

Laurent

On 06/08/2015 03:25, Sam Bobroff wrote:
> Ping?
> 
> I think I've addressed all the comments in this version. Is there anything else
> I need to look at?
> 
> Cheers,
> Sam.
> 
> On Wed, May 27, 2015 at 09:56:57AM +1000, Sam Bobroff wrote:
>> In 64 bit kernels, the Fixed Point Exception Register (XER) is a 64
>> bit field (e.g. in kvm_regs and kvm_vcpu_arch) and in most places it is
>> accessed as such.
>>
>> This patch corrects places where it is accessed as a 32 bit field by a
>> 64 bit kernel.  In some cases this is via a 32 bit load or store
>> instruction which, depending on endianness, will cause either the
>> lower or upper 32 bits to be missed.  In another case it is cast as a
>> u32, causing the upper 32 bits to be cleared.
>>
>> This patch corrects those places by extending the access methods to
>> 64 bits.
>>
>> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
>> ---
>>
>> v3:
>> Adjust booke set/get xer to match book3s.
>>
>> v2:
>>
>> Also extend kvmppc_book3s_shadow_vcpu.xer to 64 bit.
>>
>>  arch/powerpc/include/asm/kvm_book3s.h     |    4 ++--
>>  arch/powerpc/include/asm/kvm_book3s_asm.h |    2 +-
>>  arch/powerpc/include/asm/kvm_booke.h      |    4 ++--
>>  arch/powerpc/kvm/book3s_hv_rmhandlers.S   |    6 +++---
>>  arch/powerpc/kvm/book3s_segment.S         |    4 ++--
>>  5 files changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
>> index b91e74a..05a875a 100644
>> --- a/arch/powerpc/include/asm/kvm_book3s.h
>> +++ b/arch/powerpc/include/asm/kvm_book3s.h
>> @@ -225,12 +225,12 @@ static inline u32 kvmppc_get_cr(struct kvm_vcpu *vcpu)
>>  	return vcpu->arch.cr;
>>  }
>>  
>> -static inline void kvmppc_set_xer(struct kvm_vcpu *vcpu, u32 val)
>> +static inline void kvmppc_set_xer(struct kvm_vcpu *vcpu, ulong val)
>>  {
>>  	vcpu->arch.xer = val;
>>  }
>>  
>> -static inline u32 kvmppc_get_xer(struct kvm_vcpu *vcpu)
>> +static inline ulong kvmppc_get_xer(struct kvm_vcpu *vcpu)
>>  {
>>  	return vcpu->arch.xer;
>>  }
>> diff --git a/arch/powerpc/include/asm/kvm_book3s_asm.h b/arch/powerpc/include/asm/kvm_book3s_asm.h
>> index 5bdfb5d..c4ccd2d 100644
>> --- a/arch/powerpc/include/asm/kvm_book3s_asm.h
>> +++ b/arch/powerpc/include/asm/kvm_book3s_asm.h
>> @@ -112,7 +112,7 @@ struct kvmppc_book3s_shadow_vcpu {
>>  	bool in_use;
>>  	ulong gpr[14];
>>  	u32 cr;
>> -	u32 xer;
>> +	ulong xer;
>>  	ulong ctr;
>>  	ulong lr;
>>  	ulong pc;
>> diff --git a/arch/powerpc/include/asm/kvm_booke.h b/arch/powerpc/include/asm/kvm_booke.h
>> index 3286f0d..bc6e29e 100644
>> --- a/arch/powerpc/include/asm/kvm_booke.h
>> +++ b/arch/powerpc/include/asm/kvm_booke.h
>> @@ -54,12 +54,12 @@ static inline u32 kvmppc_get_cr(struct kvm_vcpu *vcpu)
>>  	return vcpu->arch.cr;
>>  }
>>  
>> -static inline void kvmppc_set_xer(struct kvm_vcpu *vcpu, u32 val)
>> +static inline void kvmppc_set_xer(struct kvm_vcpu *vcpu, ulong val)
>>  {
>>  	vcpu->arch.xer = val;
>>  }
>>  
>> -static inline u32 kvmppc_get_xer(struct kvm_vcpu *vcpu)
>> +static inline ulong kvmppc_get_xer(struct kvm_vcpu *vcpu)
>>  {
>>  	return vcpu->arch.xer;
>>  }
>> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
>> index 4d70df2..d75be59 100644
>> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
>> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
>> @@ -870,7 +870,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
>>  	blt	hdec_soon
>>  
>>  	ld	r6, VCPU_CTR(r4)
>> -	lwz	r7, VCPU_XER(r4)
>> +	ld	r7, VCPU_XER(r4)
>>  
>>  	mtctr	r6
>>  	mtxer	r7
>> @@ -1103,7 +1103,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
>>  	mfctr	r3
>>  	mfxer	r4
>>  	std	r3, VCPU_CTR(r9)
>> -	stw	r4, VCPU_XER(r9)
>> +	std	r4, VCPU_XER(r9)
>>  
>>  	/* If this is a page table miss then see if it's theirs or ours */
>>  	cmpwi	r12, BOOK3S_INTERRUPT_H_DATA_STORAGE
>> @@ -1675,7 +1675,7 @@ kvmppc_hdsi:
>>  	bl	kvmppc_msr_interrupt
>>  fast_interrupt_c_return:
>>  6:	ld	r7, VCPU_CTR(r9)
>> -	lwz	r8, VCPU_XER(r9)
>> +	ld	r8, VCPU_XER(r9)
>>  	mtctr	r7
>>  	mtxer	r8
>>  	mr	r4, r9
>> diff --git a/arch/powerpc/kvm/book3s_segment.S b/arch/powerpc/kvm/book3s_segment.S
>> index acee37c..ca8f174 100644
>> --- a/arch/powerpc/kvm/book3s_segment.S
>> +++ b/arch/powerpc/kvm/book3s_segment.S
>> @@ -123,7 +123,7 @@ no_dcbz32_on:
>>  	PPC_LL	r8, SVCPU_CTR(r3)
>>  	PPC_LL	r9, SVCPU_LR(r3)
>>  	lwz	r10, SVCPU_CR(r3)
>> -	lwz	r11, SVCPU_XER(r3)
>> +	PPC_LL	r11, SVCPU_XER(r3)
>>  
>>  	mtctr	r8
>>  	mtlr	r9
>> @@ -237,7 +237,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
>>  	mfctr	r8
>>  	mflr	r9
>>  
>> -	stw	r5, SVCPU_XER(r13)
>> +	PPC_STL	r5, SVCPU_XER(r13)
>>  	PPC_STL	r6, SVCPU_FAULT_DAR(r13)
>>  	stw	r7, SVCPU_FAULT_DSISR(r13)
>>  	PPC_STL	r8, SVCPU_CTR(r13)
>> -- 
>> 1.7.10.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
