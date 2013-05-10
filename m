Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0659A2C00D2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 May 2013 14:40:21 +1000 (EST)
Message-ID: <518C7A28.4000903@windriver.com>
Date: Fri, 10 May 2013 12:40:08 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Bhushan Bharat-R65777 <R65777@freescale.com>
Subject: Re: [PATCH v2 3/4] kvm/ppc: Call trace_hardirqs_on before entry
References: <1368155384-11035-1-git-send-email-scottwood@freescale.com>
 <1368155384-11035-4-git-send-email-scottwood@freescale.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0700F4FF@039-SN2MPN1-011.039d.mgd.msft.net>
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D0700F4FF@039-SN2MPN1-011.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Alexander Graf <agraf@suse.de>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/10/2013 11:34 AM, Bhushan Bharat-R65777 wrote:
>
>
>> -----Original Message-----
>> From: kvm-owner@vger.kernel.org [mailto:kvm-owner@vger.kernel.org] On Behalf Of
>> Scott Wood
>> Sent: Friday, May 10, 2013 8:40 AM
>> To: Alexander Graf; Benjamin Herrenschmidt
>> Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
>> Wood Scott-B07421
>> Subject: [PATCH v2 3/4] kvm/ppc: Call trace_hardirqs_on before entry
>>
>> Currently this is only being done on 64-bit.  Rather than just move it
>> out of the 64-bit ifdef, move it to kvm_lazy_ee_enable() so that it is
>> consistent with lazy ee state, and so that we don't track more host
>> code as interrupts-enabled than necessary.
>>
>> Rename kvm_lazy_ee_enable() to kvm_fix_ee_before_entry() to reflect
>> that this function now has a role on 32-bit as well.
>>
>> Signed-off-by: Scott Wood <scottwood@freescale.com>
>> ---
>>   arch/powerpc/include/asm/kvm_ppc.h |   11 ++++++++---
>>   arch/powerpc/kvm/book3s_pr.c       |    4 ++--
>>   arch/powerpc/kvm/booke.c           |    4 ++--
>>   arch/powerpc/kvm/powerpc.c         |    2 --
>>   4 files changed, 12 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/kvm_ppc.h
>> b/arch/powerpc/include/asm/kvm_ppc.h
>> index a5287fe..6885846 100644
>> --- a/arch/powerpc/include/asm/kvm_ppc.h
>> +++ b/arch/powerpc/include/asm/kvm_ppc.h
>> @@ -394,10 +394,15 @@ static inline void kvmppc_mmu_flush_icache(pfn_t pfn)
>>   	}
>>   }
>>
>> -/* Please call after prepare_to_enter. This function puts the lazy ee state
>> -   back to normal mode, without actually enabling interrupts. */
>> -static inline void kvmppc_lazy_ee_enable(void)
>> +/*
>> + * Please call after prepare_to_enter. This function puts the lazy ee and irq
>> + * disabled tracking state back to normal mode, without actually enabling
>> + * interrupts.
>> + */
>> +static inline void kvmppc_fix_ee_before_entry(void)
>>   {
>> +	trace_hardirqs_on();
>> +
>>   #ifdef CONFIG_PPC64
>>   	/* Only need to enable IRQs by hard enabling them after this */
>>   	local_paca->irq_happened = 0;
>> diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
>> index bdc40b8..0b97ce4 100644
>> --- a/arch/powerpc/kvm/book3s_pr.c
>> +++ b/arch/powerpc/kvm/book3s_pr.c
>> @@ -890,7 +890,7 @@ program_interrupt:
>>   			local_irq_enable();
>>   			r = s;
>>   		} else {
>> -			kvmppc_lazy_ee_enable();
>> +			kvmppc_fix_ee_before_entry();
>>   		}
>>   	}
>>
>> @@ -1161,7 +1161,7 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct
>> kvm_vcpu *vcpu)
>>   	if (vcpu->arch.shared->msr & MSR_FP)
>>   		kvmppc_handle_ext(vcpu, BOOK3S_INTERRUPT_FP_UNAVAIL, MSR_FP);
>>
>> -	kvmppc_lazy_ee_enable();
>> +	kvmppc_fix_ee_before_entry();
>>
>>   	ret = __kvmppc_vcpu_run(kvm_run, vcpu);
>>
>> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
>> index 705fc5c..eb89b83 100644
>> --- a/arch/powerpc/kvm/booke.c
>> +++ b/arch/powerpc/kvm/booke.c
>> @@ -673,7 +673,7 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu
>> *vcpu)
>>   		ret = s;
>>   		goto out;
>>   	}
>> -	kvmppc_lazy_ee_enable();
>> +	kvmppc_fix_ee_before_entry();
>
> local_irq_disable() is called before kvmppc_prepare_to_enter().

In patch 4, we call hard_irq_disable() once enter kvmppc_prepare_to_enter().

Tiejun

> Now we put the irq_happend and soft_enabled back to previous state without checking for any interrupt happened in between. If any interrupt happens in between, will not that be lost?
>
> -Bharat
>
>>
>>   	kvm_guest_enter();
>>
>> @@ -1154,7 +1154,7 @@ int kvmppc_handle_exit(struct kvm_run *run, struct
>> kvm_vcpu *vcpu,
>>   			local_irq_enable();
>>   			r = (s << 2) | RESUME_HOST | (r & RESUME_FLAG_NV);
>>   		} else {
>> -			kvmppc_lazy_ee_enable();
>> +			kvmppc_fix_ee_before_entry();
>>   		}
>>   	}
>>
>> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
>> index 6316ee3..4e05f8c 100644
>> --- a/arch/powerpc/kvm/powerpc.c
>> +++ b/arch/powerpc/kvm/powerpc.c
>> @@ -117,8 +117,6 @@ int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
>>   			kvm_guest_exit();
>>   			continue;
>>   		}
>> -
>> -		trace_hardirqs_on();
>>   #endif
>>
>>   		kvm_guest_enter();
>> --
>> 1.7.10.4
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe kvm" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
>
