Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 15DE92C00CD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 May 2013 15:31:43 +1000 (EST)
Message-ID: <518C8634.6010004@windriver.com>
Date: Fri, 10 May 2013 13:31:32 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Bhushan Bharat-R65777 <R65777@freescale.com>
Subject: Re: [PATCH v2 4/4] kvm/ppc: IRQ disabling cleanup
References: <1368155384-11035-1-git-send-email-scottwood@freescale.com>
 <1368155384-11035-5-git-send-email-scottwood@freescale.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0700F859@039-SN2MPN1-011.039d.mgd.msft.net>
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D0700F859@039-SN2MPN1-011.039d.mgd.msft.net>
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

>> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
>> index 4e05f8c..f8659aa 100644
>> --- a/arch/powerpc/kvm/powerpc.c
>> +++ b/arch/powerpc/kvm/powerpc.c
>> @@ -64,12 +64,14 @@ int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
>>   {
>>   	int r = 1;
>>
>> -	WARN_ON_ONCE(!irqs_disabled());
>> +	WARN_ON(irqs_disabled());
>> +	hard_irq_disable();
>
> Here we hard disable in kvmppc_prepare_to_enter(), so my comment in other patch about interrupt loss is no more valid.
>
> So here
>    MSR.EE = 0
>    local_paca->soft_enabled = 0
>    local_paca->irq_happened |= PACA_IRQ_HARD_DIS;
>
>> +
>>   	while (true) {
>>   		if (need_resched()) {
>>   			local_irq_enable();
>
> This will make the state:
>    MSR.EE = 1
>    local_paca->soft_enabled = 1
>    local_paca->irq_happened = PACA_IRQ_HARD_DIS;  //same as before

Why is this same the above state? local_irq_enable() can call 
__check_irq_replay() to clear PACA_IRQ_HARD_DIS.

>
> Is that a valid state where interrupts are fully enabled and irq_happend in not 0?
>
>>   			cond_resched();
>> -			local_irq_disable();
>> +			hard_irq_disable();
>>   			continue;
>>   		}
>>
>> @@ -95,7 +97,7 @@ int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
>>   			local_irq_enable();
>>   			trace_kvm_check_requests(vcpu);
>>   			r = kvmppc_core_check_requests(vcpu);
>> -			local_irq_disable();
>> +			hard_irq_disable();
>>   			if (r > 0)
>>   				continue;
>>   			break;
>> @@ -108,21 +110,14 @@ int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
>>   		}
>>
>>   #ifdef CONFIG_PPC64
>> -		/* lazy EE magic */
>> -		hard_irq_disable();
>> -		if (lazy_irq_pending()) {
>> -			/* Got an interrupt in between, try again */
>> -			local_irq_enable();
>> -			local_irq_disable();
>> -			kvm_guest_exit();
>> -			continue;
>> -		}
>> +		WARN_ON(lazy_irq_pending());
>>   #endif
>>
>>   		kvm_guest_enter();
>> -		break;
>> +		return r;
>>   	}
>>
>> +	local_irq_enable();
>>   	return r;
>>   }
>
>
> int kvmppc_core_prepare_to_enter(struct kvm_vcpu *vcpu)
> {
>          int r = 0;
>          WARN_ON_ONCE(!irqs_disabled());
>
>          kvmppc_core_check_exceptions(vcpu);
>
>          if (vcpu->requests) {
>                  /* Exception delivery raised request; start over */
>                  return 1;
>          }
>
>          if (vcpu->arch.shared->msr & MSR_WE) {
>                  local_irq_enable();
>                  kvm_vcpu_block(vcpu);
>                  clear_bit(KVM_REQ_UNHALT, &vcpu->requests);
>                  local_irq_disable();
> ^^^
> We do not require hard_irq_disable() here?

Between kvmppc_core_prepare_to_enter() and kvmppc_prepare_to_enter(), as I 
recall Scott had some discussions with Ben earlier.

Tiejun

>
