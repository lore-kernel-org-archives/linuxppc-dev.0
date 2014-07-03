Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7718E1A0004
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jul 2014 01:30:46 +1000 (EST)
Message-ID: <53B57722.9020205@suse.de>
Date: Thu, 03 Jul 2014 17:30:42 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: "mihai.caraman@freescale.com" <mihai.caraman@freescale.com>,
 Scott Wood <scottwood@freescale.com>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
Subject: Re: [PATCH 1/6 v2] KVM: PPC: Book3E: Use common defines for
 SPE/FP/AltiVec int numbers
References: <1404142497-6430-1-git-send-email-mihai.caraman@freescale.com>
 <1404142497-6430-2-git-send-email-mihai.caraman@freescale.com>
 <53B54AAD.4040609@suse.de>
 <2399bd1f8fde430a945311ff27c3f5c3@BY2PR03MB508.namprd03.prod.outlook.com>
In-Reply-To: <2399bd1f8fde430a945311ff27c3f5c3@BY2PR03MB508.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 03.07.14 17:25, mihai.caraman@freescale.com wrote:
>> -----Original Message-----
>> From: Alexander Graf [mailto:agraf@suse.de]
>> Sent: Thursday, July 03, 2014 3:21 PM
>> To: Caraman Mihai Claudiu-B02008; kvm-ppc@vger.kernel.org
>> Cc: kvm@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
>> Subject: Re: [PATCH 1/6 v2] KVM: PPC: Book3E: Use common defines for
>> SPE/FP/AltiVec int numbers
>>
>>
>> On 30.06.14 17:34, Mihai Caraman wrote:
>>> Use common BOOKE_IRQPRIO and BOOKE_INTERRUPT defines for SPE/FP/AltiVec
>>> which share the same interrupt numbers.
>>>
>>> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
>>> ---
>>> v2:
>>>    - remove outdated definitions
>>>
>>>    arch/powerpc/include/asm/kvm_asm.h    |  8 --------
>>>    arch/powerpc/kvm/booke.c              | 17 +++++++++--------
>>>    arch/powerpc/kvm/booke.h              |  4 ++--
>>>    arch/powerpc/kvm/booke_interrupts.S   |  9 +++++----
>>>    arch/powerpc/kvm/bookehv_interrupts.S |  4 ++--
>>>    arch/powerpc/kvm/e500.c               | 10 ++++++----
>>>    arch/powerpc/kvm/e500_emulate.c       | 10 ++++++----
>>>    7 files changed, 30 insertions(+), 32 deletions(-)
>>>
>>> diff --git a/arch/powerpc/include/asm/kvm_asm.h
>> b/arch/powerpc/include/asm/kvm_asm.h
>>> index 9601741..c94fd33 100644
>>> --- a/arch/powerpc/include/asm/kvm_asm.h
>>> +++ b/arch/powerpc/include/asm/kvm_asm.h
>>> @@ -56,14 +56,6 @@
>>>    /* E500 */
>>>    #define BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL 32
>>>    #define BOOKE_INTERRUPT_SPE_FP_DATA_ALTIVEC_ASSIST 33
>>> -/*
>>> - * TODO: Unify 32-bit and 64-bit kernel exception handlers to use same
>> defines
>>> - */
>>> -#define BOOKE_INTERRUPT_SPE_UNAVAIL
>> BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL
>>> -#define BOOKE_INTERRUPT_SPE_FP_DATA
>> BOOKE_INTERRUPT_SPE_FP_DATA_ALTIVEC_ASSIST
>>> -#define BOOKE_INTERRUPT_ALTIVEC_UNAVAIL
>> BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL
>>> -#define BOOKE_INTERRUPT_ALTIVEC_ASSIST \
>>> -				BOOKE_INTERRUPT_SPE_FP_DATA_ALTIVEC_ASSIST
>> I think I'd prefer to keep them separate.
> What is the reason from changing your mind from ver 1? Do you want to have

Uh, mind to point me to an email where I said I like the approach? :)

> different defines with same values (we specifically mapped them to the
> hardware interrupt numbers). We already upstreamed the necessary changes

Yes, I think that'd end up the most readable flow of things.

> in the kernel. Scott, please share your opinion here.

I'm not going to be religious about it, but names like 
"BOOKE_IRQPRIO_SPE_FP_DATA_ALTIVEC_ASSIST" are

   1) too long
   2) too ambiguous

It just means the code gets harder to read. Any way we can take to 
simplify the code flow is a win IMHO. And if I don't even remotely have 
to consider SPE when reading an Altivec path, I think that's a good 
thing :).


Alex
