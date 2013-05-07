Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 152242C017C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 May 2013 20:22:48 +1000 (EST)
Message-ID: <5188D5F0.8000007@windriver.com>
Date: Tue, 7 May 2013 18:22:40 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [v1][KVM][PATCH 1/1] kvm:ppc: enable doorbell exception with
 E500MC
References: <1367808836-28635-1-git-send-email-tiejun.chen@windriver.com>
 <5187C521.2070904@suse.de> <518859F5.7020503@windriver.com>
In-Reply-To: <518859F5.7020503@windriver.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/07/2013 09:33 AM, tiejun.chen wrote:
> On 05/06/2013 10:58 PM, Alexander Graf wrote:
>> On 05/06/2013 04:53 AM, Tiejun Chen wrote:
>>> Actually E500MC also support doorbell exception, and CONFIG_PPC_E500MC
>>> can cover BOOK3E/BOOK3E_64 as well.
>>>
>>> Signed-off-by: Tiejun Chen<tiejun.chen@windriver.com>
>>> ---
>>>   arch/powerpc/kvm/booke.c |    2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
>>> index 1020119..dc1f590 100644
>>> --- a/arch/powerpc/kvm/booke.c
>>> +++ b/arch/powerpc/kvm/booke.c
>>> @@ -795,7 +795,7 @@ static void kvmppc_restart_interrupt(struct kvm_vcpu *vcpu,
>>>           kvmppc_fill_pt_regs(&regs);
>>>           timer_interrupt(&regs);
>>>           break;
>>> -#if defined(CONFIG_PPC_FSL_BOOK3E) || defined(CONFIG_PPC_BOOK3E_64)
>>> +#if defined(CONFIG_PPC_E500MC)
>>
>> I suppose you mean CONFIG_KVM_E500MC here? Why didn't this work for you before?
>
> This works for me.
>
> Here I just mean currently CONFIG_PPC_E500MC is always selected no matter what
> CONFIG_PPC_FSL_BOOK3E or CONFIG_PPC_BOOK3E_64 is enabled. And especially, this
> is already in the arch/powerpc/kvm/booke.c file, so I think one #ifdef
> (CONFIG_PPC_E500MC) is enough and also makes sense.
>
>> The ifdef above should cover the same range of CPUs.
>
> Or furthermore, the #ifdef CONFIG_PPC_DOORBELL is reasonable to cover this.
>

I think this may be better so I send next version with this. So please take a 
look at.

Tiejun
