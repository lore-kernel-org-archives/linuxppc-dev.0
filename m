Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rz7wg30RLzDqTy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 16:47:47 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6Q6Xlr5125772
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 02:47:44 -0400
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24c4rqn7hk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 02:47:44 -0400
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 26 Jul 2016 12:17:41 +0530
Received: from d28relay06.in.ibm.com (d28relay06.in.ibm.com [9.184.220.150])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id A47E939400A6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 12:16:56 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6Q6krKO41418816
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 12:16:53 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6Q6kmeJ022486
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 12:16:51 +0530
Subject: Re: [RFC PATCH 7/9] powerpc: Add support to mask perf interrupts
To: Nicholas Piggin <npiggin@gmail.com>
References: <1469458342-26233-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1469458342-26233-8-git-send-email-maddy@linux.vnet.ibm.com>
 <20160726154605.4822815a@roar.ozlabs.ibm.com>
 <e3b4f82e-3899-749c-84a4-3ed821de35a2@linux.vnet.ibm.com>
 <20160726163013.68a9f0d3@roar.ozlabs.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Tue, 26 Jul 2016 12:16:32 +0530
MIME-Version: 1.0
In-Reply-To: <20160726163013.68a9f0d3@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <3f389d4b-42e2-09c1-4c56-9c01373ea569@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tuesday 26 July 2016 12:00 PM, Nicholas Piggin wrote:
> On Tue, 26 Jul 2016 11:55:51 +0530
> Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:
>
>> On Tuesday 26 July 2016 11:16 AM, Nicholas Piggin wrote:
>>> On Mon, 25 Jul 2016 20:22:20 +0530
>>> Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:
>>>   
>>>> To support masking of the PMI interrupts, couple of new interrupt
>>>> handler macros are added MASKABLE_EXCEPTION_PSERIES_OOL and
>>>> MASKABLE_RELON_EXCEPTION_PSERIES_OOL. These are needed to include
>>>> the SOFTEN_TEST and implement the support at both host and guest
>>>> kernel.
>>>>
>>>> Couple of new irq #defs "PACA_IRQ_PMI" and "SOFTEN_VALUE_0xf0*"
>>>> added to use in the exception code to check for PMI interrupts.
>>>>
>>>> __SOFTEN_TEST macro is modified to support the PMI interrupt.
>>>> Present __SOFTEN_TEST code loads the soft_enabled from paca and
>>>> check to call masked_interrupt handler code. To support both
>>>> current behaviour and PMI masking, these changes are added,
>>>>
>>>> 1) Current LR register content are saved in R11
>>>> 2) "bge" branch operation is changed to "bgel".
>>>> 3) restore R11 to LR
>>>>
>>>> Reason:
>>>>
>>>> To retain PMI as NMI behaviour for flag state of 1, we save the LR
>>>> regsiter value in R11 and branch to "masked_interrupt" handler with
>>>> LR update. And in "masked_interrupt" handler, we check for the
>>>> "SOFTEN_VALUE_*" value in R10 for PMI and branch back with "blr" if
>>>> PMI.
>>>>
>>>> To mask PMI for a flag >1 value, masked_interrupt vaoid's the above
>>>> check and continue to execute the masked_interrupt code and
>>>> disabled MSR[EE] and updated the irq_happend with PMI info.
>>>>
>>>> Finally, saving of R11 is moved before calling SOFTEN_TEST in the
>>>> __EXCEPTION_PROLOG_1 macro to support saving of LR values in
>>>> SOFTEN_TEST.
>>>>
>>>> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
>>>> ---
>>>>    arch/powerpc/include/asm/exception-64s.h | 22
>>>> ++++++++++++++++++++-- arch/powerpc/include/asm/hw_irq.h        |
>>>> 1 + arch/powerpc/kernel/exceptions-64s.S     | 27
>>>> ++++++++++++++++++++++++--- 3 files changed, 45 insertions(+), 5
>>>> deletions(-)
>>>>
>>>> diff --git a/arch/powerpc/include/asm/exception-64s.h
>>>> b/arch/powerpc/include/asm/exception-64s.h index
>>>> 44d3f539d8a5..c951b7ab5108 100644 ---
>>>> a/arch/powerpc/include/asm/exception-64s.h +++
>>>> b/arch/powerpc/include/asm/exception-64s.h @@ -166,8 +166,8 @@
>>>> END_FTR_SECTION_NESTED(ftr,ftr,943)
>>>> OPT_SAVE_REG_TO_PACA(area+EX_CFAR, r10, CPU_FTR_CFAR);
>>>> \ SAVE_CTR(r10, area);
>>>> \ mfcr
>>>> r9;							\
>>>> -
>>>> extra(vec);
>>>> \ std
>>>> r11,area+EX_R11(r13);					\
>>>> +
>>>> extra(vec);
>>>> \ std
>>>> r12,area+EX_R12(r13);					\
>>>> GET_SCRATCH0(r10);						\
>>>> std	r10,area+EX_R13(r13) @@ -403,12 +403,17 @@
>>>> label##_relon_hv:						\
>>>> #define SOFTEN_VALUE_0xe82	PACA_IRQ_DBELL #define
>>>> SOFTEN_VALUE_0xe60	PACA_IRQ_HMI #define
>>>> SOFTEN_VALUE_0xe62	PACA_IRQ_HMI +#define
>>>> SOFTEN_VALUE_0xf01	PACA_IRQ_PMI +#define
>>>> SOFTEN_VALUE_0xf00	PACA_IRQ_PMI
>>> #define __SOFTEN_TEST(h,
>>>> vec)						\ lbz
>>>> r10,PACASOFTIRQEN(r13);					\
>>>> cmpwi
>>>> r10,LAZY_INTERRUPT_DISABLED;				\
>>>> li
>>>> r10,SOFTEN_VALUE_##vec;					\
>>>> -	bge	masked_##h##interrupt
>>> At which point, can't we pass in the interrupt level we want to mask
>>> for to SOFTEN_TEST, and avoid all this extra code changes?
>> IIUC, we do pass the interrupt info to SOFTEN_TEST. Incase of
>> PMU interrupt we will have the value as PACA_IRQ_PMI.
>>
>>
>>>
>>> PMU masked interrupt will compare with SOFTEN_LEVEL_PMU, existing
>>> interrupts will compare with SOFTEN_LEVEL_EE (or whatever suitable
>>> names there are).
>>>
>>>   
>>>> +	mflr
>>>> r11;							\
>>>> +	bgel
>>>> masked_##h##interrupt;					\
>>>> +	mtlr	r11;
>>> This might corrupt return prediction when masked_interrupt does
>>> not
>> Hmm this is a valid point.
>>
>>> return. I guess that's uncommon case though.
>> No, it is. kernel mostly use irq_disable with (1) today and only in
>> specific case
>> we disable all the interrupts. So we are going to return almost
>> always when irqs are
>> soft diabled.
>>
>> Since we need to support the PMIs as NMI when irq disable level is 1,
>> we need to skip masked_interrupt.
>>
>> As you mentioned if we have a separate macro (SOFTEN_TEST_PMU),
>> these can be avoided, but then it is code replication and we may need
>> to change some more macros. But this interesting, let me work on this.
> I would really prefer to do that, even if it means a little more code.
>
> Another option is to give an additional parameter to the MASKABLE
> variants of the exception handlers, which you can pass in the
> "mask level" into. I think it's not a bad idea to make it explicit
> even for the existing ones so it's clear which level they are masked
> at.

Issue here is that mask_interrupt function is not part of the
interrupt vector code (__EXCEPTION_PROLOG_1). So incase of PMI,
if we enter the mask_interrupt function, we need to know where
to return to continue incase of NMI.

Maddy
>
> Thanks,
> Nick
>
