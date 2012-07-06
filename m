Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4115A2C00E7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jul 2012 10:19:53 +1000 (EST)
Message-ID: <4FF62F1F.8050701@freescale.com>
Date: Thu, 5 Jul 2012 19:19:43 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
Subject: Re: [Qemu-ppc] [RFC PATCH 12/17] PowerPC: booke64: Add DO_KVM kernel
 hooks
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
 <1340627195-11544-13-git-send-email-mihai.caraman@freescale.com>
 <1B2CBB56-7180-4A73-8E51-6538A725F710@suse.de>
 <300B73AA675FCE4A93EB4FC1D42459FF15A6C6@039-SN2MPN1-013.039d.mgd.msft.net>,
 <2526CB9E-4B5A-40EA-9CFC-DFCA4B09F375@suse.de>
 <300B73AA675FCE4A93EB4FC1D42459FF15A82E@039-SN2MPN1-013.039d.mgd.msft.net>
In-Reply-To: <300B73AA675FCE4A93EB4FC1D42459FF15A82E@039-SN2MPN1-013.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Cc: KVM list <kvm@vger.kernel.org>, Alexander Graf <agraf@suse.de>,
 "<kvm-ppc@vger.kernel.org>" <kvm-ppc@vger.kernel.org>,
 "qemu-ppc@nongnu.org List" <qemu-ppc@nongnu.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/04/2012 01:15 PM, Caraman Mihai Claudiu-B02008 wrote:
>> ________________________________________
>> From: Alexander Graf [agraf@suse.de]
>> Sent: Wednesday, July 04, 2012 6:45 PM
>> To: Caraman Mihai Claudiu-B02008
>> Cc: <kvm-ppc@vger.kernel.org>; KVM list; linuxppc-dev; qemu-ppc@nongnu.org List; Benjamin Herrenschmidt
>> Subject: Re: [Qemu-ppc] [RFC PATCH 12/17] PowerPC: booke64: Add DO_KVM kernel hooks
>>
>> On 04.07.2012, at 17:27, Caraman Mihai Claudiu-B02008 wrote:
>>
>>>> -----Original Message-----
>>>> From: Alexander Graf [mailto:agraf@suse.de]
>>>> Sent: Wednesday, July 04, 2012 5:30 PM
>>>> To: Caraman Mihai Claudiu-B02008
>>>> Cc: <kvm-ppc@vger.kernel.org>; KVM list; linuxppc-dev; qemu-
>>>> ppc@nongnu.org List; Benjamin Herrenschmidt
>>>> Subject: Re: [Qemu-ppc] [RFC PATCH 12/17] PowerPC: booke64: Add DO_KVM
>>>> kernel hooks
>>>>
>>>>
>>>> On 25.06.2012, at 14:26, Mihai Caraman wrote:
>>>>
>>>>> Hook DO_KVM macro to 64-bit booke in a optimal way similar to 32-bit
>>>> booke
>>>>> see head_fsl_booke.S file. Extend interrupt handlers' parameter list
>>>> with
>>>>> interrupt vector numbers to accomodate the macro. Rework Guest Doorbell
>>>>> handler to use the proper GSRRx save/restore registers.
>>>>> Only the bolted version of tlb miss handers is addressed now.
>>>>>
>>>>> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
>>>>> ---
>>>>> arch/powerpc/kernel/exceptions-64e.S |  114 ++++++++++++++++++++++++---
>>>> -------
>>>>> arch/powerpc/mm/tlb_low_64e.S        |   14 +++-
>>>>> 2 files changed, 92 insertions(+), 36 deletions(-)
>>>>>
>>>>> diff --git a/arch/powerpc/kernel/exceptions-64e.S
>>>> b/arch/powerpc/kernel/exceptions-64e.S
>>>>> index 06f7aec..a60f81f 100644
>>>>> --- a/arch/powerpc/kernel/exceptions-64e.S
>>>>> +++ b/arch/powerpc/kernel/exceptions-64e.S
>>>>> @@ -25,6 +25,8 @@
>>>>> #include <asm/ppc-opcode.h>
>>>>> #include <asm/mmu.h>
>>>>> #include <asm/hw_irq.h>
>>>>> +#include <asm/kvm_asm.h>
>>>>> +#include <asm/kvm_booke_hv_asm.h>
>>>>>
>>>>> /* XXX This will ultimately add space for a special exception save
>>>>> *     structure used to save things like SRR0/SRR1, SPRGs, MAS, etc...
>>>>> @@ -34,13 +36,24 @@
>>>>> */
>>>>> #define     SPECIAL_EXC_FRAME_SIZE  INT_FRAME_SIZE
>>>>>
>>>>> +#ifdef CONFIG_KVM_BOOKE_HV
>>>>> +#define KVM_BOOKE_HV_MFSPR(reg, spr)                               \
>>>>> +   BEGIN_FTR_SECTION                                       \
>>>>> +           mfspr   reg, spr;                               \
>>>>> +   END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
>>>>> +#else
>>>>> +#define KVM_BOOKE_HV_MFSPR(reg, spr)
>>>>> +#endif
>>>>
>>>> Bleks - this is ugly.
>>>
>>> I agree :) But I opted to keep the optimizations done for 32-bit.
>>>
>>>> Do we really need to open-code the #ifdef here?
>>>
>>> 32-bit implementation fortunately use asm macros, we can't nest defines.
>>>
>>>> Can't the feature section code determine that the feature is disabled and
>>>> just always not include the code?
>>>
>>> CPU_FTR_EMB_HV is set even if KVM is not configured.
>>
>> I don't get the point then. Why not have the whole DO_KVM masked under FTR_SECTION_IFSET(CPU_FTR_EMB_HV)? Are there book3s_64 implementations without HV? 
> 
> I guess you refer to book3e_64. I don't know all implementations but Embedded.HV category is optional.
> 
>> Can't we just mfspr unconditionally in DO_KVM?
> 
> I think Scott should better answer this question, I don't know why he opted for the other approach.

That was on 32-bit, where some of DO_KVM's users want SRR1 for their own
purposes.

>>>>> -.macro tlb_prolog_bolted addr
>>>>> +.macro tlb_prolog_bolted intnum addr
>>>>>     mtspr   SPRN_SPRG_TLB_SCRATCH,r13
>>>>>     mfspr   r13,SPRN_SPRG_PACA
>>>>>     std     r10,PACA_EXTLB+EX_TLB_R10(r13)
>>>>>     mfcr    r10
>>>>>     std     r11,PACA_EXTLB+EX_TLB_R11(r13)
>>>>> +#ifdef CONFIG_KVM_BOOKE_HV
>>>>> +BEGIN_FTR_SECTION
>>>>> +   mfspr   r11, SPRN_SRR1
>>>>> +END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
>>>>> +#endif
>>>>
>>>> This thing really should vanish behind DO_KVM :)
>>>
>>> Then let's do it first for 32-bit ;)
>>
>> You could #ifdef it in DO_KVM for 64-bit for now. IIRC it's not done on 32-bit because the register value is used even beyond DO_KVM there.
> 
> Nope, 32-bit code is also guarded by CONFIG_KVM_BOOKE_HV.

Only in the TLB miss handlers, not the normal exception prolog.

-Scott
