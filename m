Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 967E91A0008
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jun 2014 08:36:15 +1000 (EST)
Message-ID: <5390F0DC.9070103@suse.de>
Date: Fri, 06 Jun 2014 00:36:12 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
Subject: Re: [PATCH 1/4] KVM: PPC: BOOK3S: PR: Emulate virtual timebase
 register
References: <1401970085-14493-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1401970085-14493-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <5390604C.4050704@suse.de> <87wqcvmk3f.fsf@linux.vnet.ibm.com>
 <5390A071.9040006@suse.de> <87sinjqn1g.fsf@linux.vnet.ibm.com>
 <5390EFF6.50504@suse.de>
In-Reply-To: <5390EFF6.50504@suse.de>
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


On 06.06.14 00:32, Alexander Graf wrote:
>
> On 05.06.14 19:33, Aneesh Kumar K.V wrote:
>> Alexander Graf <agraf@suse.de> writes:
>>
>>> On 05.06.14 17:50, Aneesh Kumar K.V wrote:
>>>> Alexander Graf <agraf@suse.de> writes:
>>>>
>>>>> On 05.06.14 14:08, Aneesh Kumar K.V wrote:
>>>>>> virtual time base register is a per VM, per cpu register that needs
>>>>>> to be saved and restored on vm exit and entry. Writing to VTB is not
>>>>>> allowed in the privileged mode.
>>>>>>
>>>>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> .......
>>
>>>>>>                 break;
>>>>>> diff --git a/arch/powerpc/kvm/book3s_emulate.c 
>>>>>> b/arch/powerpc/kvm/book3s_emulate.c
>>>>>> index 3565e775b61b..1bb16a59dcbc 100644
>>>>>> --- a/arch/powerpc/kvm/book3s_emulate.c
>>>>>> +++ b/arch/powerpc/kvm/book3s_emulate.c
>>>>>> @@ -577,6 +577,9 @@ int kvmppc_core_emulate_mfspr_pr(struct 
>>>>>> kvm_vcpu *vcpu, int sprn, ulong *spr_val
>>>>>>              */
>>>>>>             *spr_val = vcpu->arch.spurr;
>>>>>>             break;
>>>>>> +    case SPRN_VTB:
>>>>>> +        *spr_val = vcpu->arch.vtb;
>>>>> Doesn't this mean that vtb can be the same 2 when the guest reads 
>>>>> it 2
>>>>> times in a row without getting preempted?
>>>> But a mfspr will result in VM exit and that would make sure we
>>>> update vcpu->arch.vtb with the correct value.
>>> We only call kvmppc_core_vcpu_put_pr() when we context switch away from
>>> KVM, so it won't be updated, no?
>>>
>>>
>> kvmppc_copy_from_svcpu is also called from VM exit path 
>> (book3s_interrupt.S)
>
> ... where it will run into this code path:
>
>         /*
>          * Maybe we were already preempted and synced the svcpu from
>          * our preempt notifiers. Don't bother touching this svcpu then.
>          */
>         if (!svcpu->in_use)
>                 goto out;

Scratch that. We're always calling this on entry/exit, so you're right.


Alex
