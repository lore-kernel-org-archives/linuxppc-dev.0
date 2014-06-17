Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E81E21A02DC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 00:42:12 +1000 (EST)
Message-ID: <53A053BE.1030104@suse.de>
Date: Tue, 17 Jun 2014 16:42:06 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
Subject: Re: [PATCH] powerpc/kvm: support to handle sw breakpoint
References: <1402780097-28827-1-git-send-email-maddy@linux.vnet.ibm.com>
 <53A0022D.5020108@suse.de> <53A0216F.9060504@linux.vnet.ibm.com>
 <53A021B4.9040500@suse.de> <53A022CE.3000704@linux.vnet.ibm.com>
In-Reply-To: <53A022CE.3000704@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 17.06.14 13:13, Madhavan Srinivasan wrote:
> On Tuesday 17 June 2014 04:38 PM, Alexander Graf wrote:
>> On 17.06.14 13:07, Madhavan Srinivasan wrote:
>>> On Tuesday 17 June 2014 02:24 PM, Alexander Graf wrote:
>>>> On 14.06.14 23:08, Madhavan Srinivasan wrote:
>>>>> This patch adds kernel side support for software breakpoint.
>>>>> Design is that, by using an illegal instruction, we trap to hypervisor
>>>>> via Emulation Assistance interrupt, where we check for the illegal
>>>>> instruction
>>>>> and accordingly we return to Host or Guest. Patch mandates use of
>>>>> "abs" instruction
>>>>> (primary opcode 31 and extended opcode 360) as sw breakpoint
>>>>> instruction.
>>>>> Based on PowerISA v2.01, ABS instruction has been dropped from the
>>>>> architecture
>>>>> and treated an illegal instruction.
>>>>>
>>>>> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
>>>>> ---
>>>>>     arch/powerpc/kvm/book3s.c    |  3 ++-
>>>>>     arch/powerpc/kvm/book3s_hv.c | 23 +++++++++++++++++++----
>>>>>     2 files changed, 21 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
>>>>> index c254c27..b40fe5d 100644
>>>>> --- a/arch/powerpc/kvm/book3s.c
>>>>> +++ b/arch/powerpc/kvm/book3s.c
>>>>> @@ -789,7 +789,8 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu
>>>>> *vcpu,
>>>>>     int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
>>>>>                         struct kvm_guest_debug *dbg)
>>>>>     {
>>>>> -    return -EINVAL;
>>>>> +    vcpu->guest_debug = dbg->control;
>>>>> +    return 0;
>>>>>     }
>>>>>       void kvmppc_decrementer_func(unsigned long data)
>>>>> diff --git a/arch/powerpc/kvm/book3s_hv.c
>>>>> b/arch/powerpc/kvm/book3s_hv.c
>>>>> index 7a12edb..688421d 100644
>>>>> --- a/arch/powerpc/kvm/book3s_hv.c
>>>>> +++ b/arch/powerpc/kvm/book3s_hv.c
>>>>> @@ -67,6 +67,14 @@
>>>>>     /* Used as a "null" value for timebase values */
>>>>>     #define TB_NIL    (~(u64)0)
>>>>>     +/*
>>>>> + * SW_BRK_DBG_INT is debug Instruction for supporting Software
>>>>> Breakpoint.
>>>>> + * Instruction mnemonic is ABS, primary opcode is 31 and extended
>>>>> opcode is 360.
>>>>> + * Based on PowerISA v2.01, ABS instruction has been dropped from the
>>>>> architecture
>>>>> + * and treated an illegal instruction.
>>>>> + */
>>>>> +#define SW_BRK_DBG_INT 0x7c0002d0
>>>> The instruction we use to trap needs to get exposed to user space via a
>>>> ONE_REG property.
>>>>
>>> Yes. I got to know about that from Bharat (patchset "ppc debug: Add
>>> debug stub support"). I will change it.

Also please make sure to pick an instruction that preferably looks 
identical regardless of guest endianness. Segher suggested 0x00dddd00. 
Does that trap properly for you?


Alex
