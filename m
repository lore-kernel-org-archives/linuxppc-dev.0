Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 858A01A0010
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jul 2014 08:35:54 +1000 (EST)
Message-ID: <53B5DAC6.6050403@suse.de>
Date: Fri, 04 Jul 2014 00:35:50 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>,
 Caraman Mihai Claudiu-B02008 <mihai.caraman@freescale.com>
Subject: Re: [PATCH 1/6 v2] KVM: PPC: Book3E: Use common defines for
 SPE/FP/AltiVec int numbers
References: <1404142497-6430-1-git-send-email-mihai.caraman@freescale.com>	
 <1404142497-6430-2-git-send-email-mihai.caraman@freescale.com>	
 <53B54AAD.4040609@suse.de>	
 <2399bd1f8fde430a945311ff27c3f5c3@BY2PR03MB508.namprd03.prod.outlook.com>	
 <1404425722.21434.93.camel@snotra.buserror.net>
 <1404426684.21434.102.camel@snotra.buserror.net>
In-Reply-To: <1404426684.21434.102.camel@snotra.buserror.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 04.07.14 00:31, Scott Wood wrote:
> On Thu, 2014-07-03 at 17:15 -0500, Scott Wood wrote:
>> On Thu, 2014-07-03 at 10:25 -0500, Caraman Mihai Claudiu-B02008 wrote:
>>>> -----Original Message-----
>>>> From: Alexander Graf [mailto:agraf@suse.de]
>>>> Sent: Thursday, July 03, 2014 3:21 PM
>>>> To: Caraman Mihai Claudiu-B02008; kvm-ppc@vger.kernel.org
>>>> Cc: kvm@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
>>>> Subject: Re: [PATCH 1/6 v2] KVM: PPC: Book3E: Use common defines for
>>>> SPE/FP/AltiVec int numbers
>>>>
>>>>
>>>> On 30.06.14 17:34, Mihai Caraman wrote:
>>>>> Use common BOOKE_IRQPRIO and BOOKE_INTERRUPT defines for SPE/FP/AltiVec
>>>>> which share the same interrupt numbers.
>>>>>
>>>>> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
>>>>> ---
>>>>> v2:
>>>>>    - remove outdated definitions
>>>>>
>>>>>    arch/powerpc/include/asm/kvm_asm.h    |  8 --------
>>>>>    arch/powerpc/kvm/booke.c              | 17 +++++++++--------
>>>>>    arch/powerpc/kvm/booke.h              |  4 ++--
>>>>>    arch/powerpc/kvm/booke_interrupts.S   |  9 +++++----
>>>>>    arch/powerpc/kvm/bookehv_interrupts.S |  4 ++--
>>>>>    arch/powerpc/kvm/e500.c               | 10 ++++++----
>>>>>    arch/powerpc/kvm/e500_emulate.c       | 10 ++++++----
>>>>>    7 files changed, 30 insertions(+), 32 deletions(-)
>>>>>
>>>>> diff --git a/arch/powerpc/include/asm/kvm_asm.h
>>>> b/arch/powerpc/include/asm/kvm_asm.h
>>>>> index 9601741..c94fd33 100644
>>>>> --- a/arch/powerpc/include/asm/kvm_asm.h
>>>>> +++ b/arch/powerpc/include/asm/kvm_asm.h
>>>>> @@ -56,14 +56,6 @@
>>>>>    /* E500 */
>>>>>    #define BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL 32
>>>>>    #define BOOKE_INTERRUPT_SPE_FP_DATA_ALTIVEC_ASSIST 33
>>>>> -/*
>>>>> - * TODO: Unify 32-bit and 64-bit kernel exception handlers to use same
>>>> defines
>>>>> - */
>>>>> -#define BOOKE_INTERRUPT_SPE_UNAVAIL
>>>> BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL
>>>>> -#define BOOKE_INTERRUPT_SPE_FP_DATA
>>>> BOOKE_INTERRUPT_SPE_FP_DATA_ALTIVEC_ASSIST
>>>>> -#define BOOKE_INTERRUPT_ALTIVEC_UNAVAIL
>>>> BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL
>>>>> -#define BOOKE_INTERRUPT_ALTIVEC_ASSIST \
>>>>> -				BOOKE_INTERRUPT_SPE_FP_DATA_ALTIVEC_ASSIST
>>>> I think I'd prefer to keep them separate.
>>> What is the reason from changing your mind from ver 1? Do you want to have
>>> different defines with same values (we specifically mapped them to the
>>> hardware interrupt numbers). We already upstreamed the necessary changes
>>> in the kernel. Scott, please share your opinion here.
>> I don't like hiding the fact that they're the same number, which could
>> lead to wrong code in the absence of ifdefs that strictly mutually
>> exclude SPE and Altivec code -- there was an instance of this with
>> MSR_VEC versus MSR_SPE in a previous patchset.
> That said, if you want to enforce that mutual exclusion in a way that is
> clear, I won't object too loudly -- but the code does look pretty
> similar between the two (as well as between the two IVORs).

Yes, I want to make sure we have 2 separate code paths for SPE and 
Altivec. No code sharing at all unless it's very generically possible.

Also, which code does look pretty similar? The fact that we deflect 
interrupts back into the guest? That's mostly boilerplate.


Alex
