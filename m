Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0F4ED1A0041
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jun 2014 02:53:11 +1000 (EST)
Message-ID: <5390A071.9040006@suse.de>
Date: Thu, 05 Jun 2014 18:53:05 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
Subject: Re: [PATCH 1/4] KVM: PPC: BOOK3S: PR: Emulate virtual timebase
 register
References: <1401970085-14493-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1401970085-14493-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <5390604C.4050704@suse.de> <87wqcvmk3f.fsf@linux.vnet.ibm.com>
In-Reply-To: <87wqcvmk3f.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 05.06.14 17:50, Aneesh Kumar K.V wrote:
> Alexander Graf <agraf@suse.de> writes:
>
>> On 05.06.14 14:08, Aneesh Kumar K.V wrote:
>>> virtual time base register is a per VM, per cpu register that needs
>>> to be saved and restored on vm exit and entry. Writing to VTB is not
>>> allowed in the privileged mode.
>>>
>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>>> ---
>>>    arch/powerpc/include/asm/kvm_host.h |  1 +
>>>    arch/powerpc/include/asm/reg.h      | 15 +++++++++++++++
>>>    arch/powerpc/include/asm/time.h     |  9 +++++++++
>>>    arch/powerpc/kvm/book3s.c           |  6 ++++++
>>>    arch/powerpc/kvm/book3s_emulate.c   |  3 +++
>>>    arch/powerpc/kvm/book3s_hv.c        |  6 ------
>>>    arch/powerpc/kvm/book3s_pr.c        |  3 ++-
>>>    7 files changed, 36 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
>>> index 4a58731a0a72..bd3caeaeebe1 100644
>>> --- a/arch/powerpc/include/asm/kvm_host.h
>>> +++ b/arch/powerpc/include/asm/kvm_host.h
>>> @@ -505,6 +505,7 @@ struct kvm_vcpu_arch {
>>>    #endif
>>>    	/* Time base value when we entered the guest */
>>>    	u64 entry_tb;
>>> +	u64 entry_vtb;
>>>    	u32 tcr;
>>>    	ulong tsr; /* we need to perform set/clr_bits() which requires ulong */
>>>    	u32 ivor[64];
>>> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
>>> index 4852bcf270f3..3e7085d8af90 100644
>>> --- a/arch/powerpc/include/asm/reg.h
>>> +++ b/arch/powerpc/include/asm/reg.h
>>> @@ -25,6 +25,7 @@
>>>    #ifdef CONFIG_8xx
>>>    #include <asm/reg_8xx.h>
>>>    #endif /* CONFIG_8xx */
>>> +#include <asm/bug.h>
>>>    
>>>    #define MSR_SF_LG	63              /* Enable 64 bit mode */
>>>    #define MSR_ISF_LG	61              /* Interrupt 64b mode valid on 630 */
>>> @@ -1193,6 +1194,20 @@
>>>    				     : "r" ((unsigned long)(v)) \
>>>    				     : "memory")
>>>    
>>> +static inline unsigned long mfvtb (void)
>>> +{
>>> +#ifdef CONFIG_PPC_BOOK3S_64
>>> +	if (cpu_has_feature(CPU_FTR_ARCH_207S))
>>> +		return mfspr(SPRN_VTB);
>>> +#endif
>>> +	/*
>>> +	 * The above mfspr will be a no-op on anything before Power8
>>> +	 * That can result in random values returned. We need to
>>> +	 * capture that.
>>> +	 */
>>> +	BUG();
>>> +}
>>> +
>>>    #ifdef __powerpc64__
>>>    #if defined(CONFIG_PPC_CELL) || defined(CONFIG_PPC_FSL_BOOK3E)
>>>    #define mftb()		({unsigned long rval;				\
>>> diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
>>> index 1d428e6007ca..03cbada59d3a 100644
>>> --- a/arch/powerpc/include/asm/time.h
>>> +++ b/arch/powerpc/include/asm/time.h
>>> @@ -102,6 +102,15 @@ static inline u64 get_rtc(void)
>>>    	return (u64)hi * 1000000000 + lo;
>>>    }
>>>    
>>> +static inline u64 get_vtb(void)
>>> +{
>>> +#ifdef CONFIG_PPC_BOOK3S_64
>>> +	if (cpu_has_feature(CPU_FTR_ARCH_207S))
>>> +		return mfvtb();
>>> +#endif
>>> +	return 0;
>>> +}
>>> +
>>>    #ifdef CONFIG_PPC64
>>>    static inline u64 get_tb(void)
>>>    {
>>> diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
>>> index 52c654dbd41a..ae43e4178ecd 100644
>>> --- a/arch/powerpc/kvm/book3s.c
>>> +++ b/arch/powerpc/kvm/book3s.c
>>> @@ -646,6 +646,9 @@ int kvm_vcpu_ioctl_get_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
>>>    		case KVM_REG_PPC_BESCR:
>>>    			val = get_reg_val(reg->id, vcpu->arch.bescr);
>>>    			break;
>>> +		case KVM_REG_PPC_VTB:
>>> +			val = get_reg_val(reg->id, vcpu->arch.vtb);
>>> +			break;
>>>    		default:
>>>    			r = -EINVAL;
>>>    			break;
>>> @@ -750,6 +753,9 @@ int kvm_vcpu_ioctl_set_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
>>>    		case KVM_REG_PPC_BESCR:
>>>    			vcpu->arch.bescr = set_reg_val(reg->id, val);
>>>    			break;
>>> +		case KVM_REG_PPC_VTB:
>>> +			vcpu->arch.vtb = set_reg_val(reg->id, val);
>>> +			break;
>>>    		default:
>>>    			r = -EINVAL;
>>>    			break;
>>> diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
>>> index 3565e775b61b..1bb16a59dcbc 100644
>>> --- a/arch/powerpc/kvm/book3s_emulate.c
>>> +++ b/arch/powerpc/kvm/book3s_emulate.c
>>> @@ -577,6 +577,9 @@ int kvmppc_core_emulate_mfspr_pr(struct kvm_vcpu *vcpu, int sprn, ulong *spr_val
>>>    		 */
>>>    		*spr_val = vcpu->arch.spurr;
>>>    		break;
>>> +	case SPRN_VTB:
>>> +		*spr_val = vcpu->arch.vtb;
>> Doesn't this mean that vtb can be the same 2 when the guest reads it 2
>> times in a row without getting preempted?
>
> But a mfspr will result in VM exit and that would make sure we
> update vcpu->arch.vtb with the correct value.

We only call kvmppc_core_vcpu_put_pr() when we context switch away from 
KVM, so it won't be updated, no?


Alex
