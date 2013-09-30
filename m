Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 3089B2C00CB
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Oct 2013 02:36:40 +1000 (EST)
Message-ID: <5249A894.80304@suse.de>
Date: Mon, 30 Sep 2013 18:36:36 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 06/11] kvm: powerpc: book3s: Add is_hv_enabled to
 kvmppc_ops
References: <1380276233-17095-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1380276233-17095-7-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <9BAA779D-FE0C-4971-992B-57D80F945906@suse.de>
 <87zjqya025.fsf@linux.vnet.ibm.com>
 <F87036DE-6077-4B79-965F-C52F84DD994D@suse.de>
 <87pprqbh96.fsf@linux.vnet.ibm.com> <52498FD9.6060809@suse.de>
 <878uyeb7s4.fsf@linux.vnet.ibm.com>
In-Reply-To: <878uyeb7s4.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/30/2013 06:20 PM, Aneesh Kumar K.V wrote:
> Alexander Graf<agraf@suse.de>  writes:
>
>> On 09/30/2013 02:56 PM, Aneesh Kumar K.V wrote:
>>> Alexander Graf<agraf@suse.de>   writes:
>>>
>>>> On 27.09.2013, at 15:03, Aneesh Kumar K.V wrote:
>>>>
>>>>> Alexander Graf<agraf@suse.de>   writes:
>>>>>
>>>>>
>>>>>>> diff --git a/arch/powerpc/kvm/book3s_segment.S b/arch/powerpc/kvm/book3s_segment.S
>>>>>>> index 1abe478..e0229dd 100644
>>>>>>> --- a/arch/powerpc/kvm/book3s_segment.S
>>>>>>> +++ b/arch/powerpc/kvm/book3s_segment.S
>>>>>>> @@ -161,9 +161,14 @@ kvmppc_handler_trampoline_enter_end:
>>>>>>> .global kvmppc_handler_trampoline_exit
>>>>>>> kvmppc_handler_trampoline_exit:
>>>>>>>
>>>>>>> +#if defined(CONFIG_KVM_BOOK3S_HV)
>>>>>>> +.global kvmppc_interrupt_pr
>>>>>>> +kvmppc_interrupt_pr:
>>>>>>> +	ld	r9, HSTATE_SCRATCH2(r13)
>>>>>>> +#else
>>>>>>> .global kvmppc_interrupt
>>>>>>> kvmppc_interrupt:
>>>>>> Just always call it kvmppc_interrupt_pr and thus share at least that
>>>>>> part of the code :).
>>>>> But if i don't have HV enabled, we don't compile book3s_hv_rmhandlers.S
>>>>> Hence don't have the kvmppc_interrupt symbol defined.
>>>> Ah, because we're always jumping to kvmppc_interrupt. Can we make this
>>>> slightly less magical? How about we always call kvmppc_interrupt_hv
>>>> when CONFIG_KVM_BOOK3S_HV_POSSIBLE and always kvmppc_interrupt_pr when
>>>> CONFIG_KVM_BOOK3S_PR_POSSIBLE and then branch to kvmppc_interrupt_pr
>>>> from kvmppc_interrupt_hv?
>>>>
>>>> IMHO that would make the code flow more obvious.
>>> To make sure I understand you correctly, what you are suggesting is
>>> to update __KVM_HANDLER to call kvmppc_interupt_pr when HV is not
>>> enabled ?
>> Yes, I think that makes the code flow more obvious. Every function
>> always has the same name regardless of config options then.
>>
> Something like this ( btw non tested )

Yes :).


Alex
