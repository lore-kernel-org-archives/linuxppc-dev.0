Return-Path: <B02008@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E2EB92C00E7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2012 04:15:13 +1000 (EST)
From: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
To: Alexander Graf <agraf@suse.de>
Subject: RE: [Qemu-ppc] [RFC PATCH 12/17] PowerPC: booke64: Add DO_KVM
 kernel hooks
Date: Wed, 4 Jul 2012 18:15:03 +0000
Message-ID: <300B73AA675FCE4A93EB4FC1D42459FF15A82E@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
 <1340627195-11544-13-git-send-email-mihai.caraman@freescale.com>
 <1B2CBB56-7180-4A73-8E51-6538A725F710@suse.de>
 <300B73AA675FCE4A93EB4FC1D42459FF15A6C6@039-SN2MPN1-013.039d.mgd.msft.net>,
 <2526CB9E-4B5A-40EA-9CFC-DFCA4B09F375@suse.de>
In-Reply-To: <2526CB9E-4B5A-40EA-9CFC-DFCA4B09F375@suse.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "qemu-ppc@nongnu.org List" <qemu-ppc@nongnu.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, KVM list <kvm@vger.kernel.org>,
 "<kvm-ppc@vger.kernel.org>" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>________________________________________=0A=
>From: Alexander Graf [agraf@suse.de]=0A=
>Sent: Wednesday, July 04, 2012 6:45 PM=0A=
>To: Caraman Mihai Claudiu-B02008=0A=
>Cc: <kvm-ppc@vger.kernel.org>; KVM list; linuxppc-dev; qemu-ppc@nongnu.org=
 List; Benjamin Herrenschmidt=0A=
>Subject: Re: [Qemu-ppc] [RFC PATCH 12/17] PowerPC: booke64: Add DO_KVM ker=
nel hooks=0A=
>=0A=
>On 04.07.2012, at 17:27, Caraman Mihai Claudiu-B02008 wrote:=0A=
>=0A=
>>> -----Original Message-----=0A=
>>> From: Alexander Graf [mailto:agraf@suse.de]=0A=
>>> Sent: Wednesday, July 04, 2012 5:30 PM=0A=
>>> To: Caraman Mihai Claudiu-B02008=0A=
>>> Cc: <kvm-ppc@vger.kernel.org>; KVM list; linuxppc-dev; qemu-=0A=
>>> ppc@nongnu.org List; Benjamin Herrenschmidt=0A=
>>> Subject: Re: [Qemu-ppc] [RFC PATCH 12/17] PowerPC: booke64: Add DO_KVM=
=0A=
>>> kernel hooks=0A=
>>>=0A=
>>>=0A=
>>> On 25.06.2012, at 14:26, Mihai Caraman wrote:=0A=
>>>=0A=
>>>> Hook DO_KVM macro to 64-bit booke in a optimal way similar to 32-bit=
=0A=
>>> booke=0A=
>>>> see head_fsl_booke.S file. Extend interrupt handlers' parameter list=
=0A=
>>> with=0A=
>>>> interrupt vector numbers to accomodate the macro. Rework Guest Doorbel=
l=0A=
>>>> handler to use the proper GSRRx save/restore registers.=0A=
>>>> Only the bolted version of tlb miss handers is addressed now.=0A=
>>>>=0A=
>>>> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>=0A=
>>>> ---=0A=
>>>> arch/powerpc/kernel/exceptions-64e.S |  114 ++++++++++++++++++++++++--=
-=0A=
>>> -------=0A=
>>>> arch/powerpc/mm/tlb_low_64e.S        |   14 +++-=0A=
>>>> 2 files changed, 92 insertions(+), 36 deletions(-)=0A=
>>>>=0A=
>>>> diff --git a/arch/powerpc/kernel/exceptions-64e.S=0A=
>>> b/arch/powerpc/kernel/exceptions-64e.S=0A=
>>>> index 06f7aec..a60f81f 100644=0A=
>>>> --- a/arch/powerpc/kernel/exceptions-64e.S=0A=
>>>> +++ b/arch/powerpc/kernel/exceptions-64e.S=0A=
>>>> @@ -25,6 +25,8 @@=0A=
>>>> #include <asm/ppc-opcode.h>=0A=
>>>> #include <asm/mmu.h>=0A=
>>>> #include <asm/hw_irq.h>=0A=
>>>> +#include <asm/kvm_asm.h>=0A=
>>>> +#include <asm/kvm_booke_hv_asm.h>=0A=
>>>>=0A=
>>>> /* XXX This will ultimately add space for a special exception save=0A=
>>>> *     structure used to save things like SRR0/SRR1, SPRGs, MAS, etc...=
=0A=
>>>> @@ -34,13 +36,24 @@=0A=
>>>> */=0A=
>>>> #define     SPECIAL_EXC_FRAME_SIZE  INT_FRAME_SIZE=0A=
>>>>=0A=
>>>> +#ifdef CONFIG_KVM_BOOKE_HV=0A=
>>>> +#define KVM_BOOKE_HV_MFSPR(reg, spr)                               \=
=0A=
>>>> +   BEGIN_FTR_SECTION                                       \=0A=
>>>> +           mfspr   reg, spr;                               \=0A=
>>>> +   END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)=0A=
>>>> +#else=0A=
>>>> +#define KVM_BOOKE_HV_MFSPR(reg, spr)=0A=
>>>> +#endif=0A=
>>>=0A=
>>> Bleks - this is ugly.=0A=
>>=0A=
>> I agree :) But I opted to keep the optimizations done for 32-bit.=0A=
>>=0A=
>>> Do we really need to open-code the #ifdef here?=0A=
>>=0A=
>> 32-bit implementation fortunately use asm macros, we can't nest defines.=
=0A=
>>=0A=
>>> Can't the feature section code determine that the feature is disabled a=
nd=0A=
>>> just always not include the code?=0A=
>>=0A=
>> CPU_FTR_EMB_HV is set even if KVM is not configured.=0A=
>=0A=
>I don't get the point then. Why not have the whole DO_KVM masked under FTR=
_SECTION_IFSET(CPU_FTR_EMB_HV)? Are there book3s_64 implementations without=
 HV? =0A=
=0A=
I guess you refer to book3e_64. I don't know all implementations but Embedd=
ed.HV category is optional.=0A=
=0A=
>Can't we just mfspr unconditionally in DO_KVM?=0A=
=0A=
I think Scott should better answer this question, I don't know why he opted=
 for the other approach.=0A=
=0A=
>>>> -/* Guest Doorbell */=0A=
>>>> -   MASKABLE_EXCEPTION(0x2c0, guest_doorbell, .unknown_exception,=0A=
>>> ACK_NONE)=0A=
>>>> +/*=0A=
>>>> + * Guest doorbell interrupt=0A=
>>>> + * This general exception use GSRRx save/restore registers=0A=
>>>> + */=0A=
>>>> +   START_EXCEPTION(guest_doorbell);=0A=
>>>> +   EXCEPTION_PROLOG(0x2c0, BOOKE_INTERRUPT_GUEST_DBELL, GEN,=0A=
>>>> +                    SPRN_GSRR0, SPRN_GSRR1, PROLOG_ADDITION_NONE)=0A=
>>>> +   EXCEPTION_COMMON(0x2c0, PACA_EXGEN, INTS_KEEP)=0A=
>>>> +   addi    r3,r1,STACK_FRAME_OVERHEAD=0A=
>>>> +   bl      .save_nvgprs=0A=
>>>> +   INTS_RESTORE_HARD=0A=
>>>> +   bl      .unknown_exception=0A=
>>>> +   b       .ret_from_except=0A=
>>>=0A=
>>> This is independent of DO_KVM, right?=0A=
>>=0A=
>> Yes, just kvm_handler definitions in bookehv_interrupts.S depends on thi=
s.=0A=
>=0A=
>Then please split it out into a separate patch.=0A=
=0A=
Can you be more precise, are you referring to guest_doorbell exception hand=
ler?=0A=
=0A=
>>>> -.macro tlb_prolog_bolted addr=0A=
>>>> +.macro tlb_prolog_bolted intnum addr=0A=
>>>>     mtspr   SPRN_SPRG_TLB_SCRATCH,r13=0A=
>>>>     mfspr   r13,SPRN_SPRG_PACA=0A=
>>>>     std     r10,PACA_EXTLB+EX_TLB_R10(r13)=0A=
>>>>     mfcr    r10=0A=
>>>>     std     r11,PACA_EXTLB+EX_TLB_R11(r13)=0A=
>>>> +#ifdef CONFIG_KVM_BOOKE_HV=0A=
>>>> +BEGIN_FTR_SECTION=0A=
>>>> +   mfspr   r11, SPRN_SRR1=0A=
>>>> +END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)=0A=
>>>> +#endif=0A=
>>>=0A=
>>> This thing really should vanish behind DO_KVM :)=0A=
>>=0A=
>> Then let's do it first for 32-bit ;)=0A=
>=0A=
>You could #ifdef it in DO_KVM for 64-bit for now. IIRC it's not done on 32=
-bit because the register value is used even beyond DO_KVM there.=0A=
=0A=
Nope, 32-bit code is also guarded by CONFIG_KVM_BOOKE_HV.=0A=
=0A=
-Mike=
