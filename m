Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qZfnG3NYFzDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Mar 2016 18:45:06 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qZfnG22GXz9sdb
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Mar 2016 18:45:06 +1100 (AEDT)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Wed, 30 Mar 2016 17:45:05 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 77BCA2BB0063
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Mar 2016 18:45:01 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2U7iqBd66584590
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Mar 2016 18:45:01 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2U7iRdp018775
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Mar 2016 18:44:27 +1100
Subject: Re: [v2] ppc64/book3s: fix branching to out of line handlers in
 relocation kernel
To: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
References: <3qZT2T1R7fz9sDC@ozlabs.org> <56FB7CB8.1010801@linux.vnet.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>, Paul Mackerras <paulus@samba.org>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Message-ID: <56FB83C1.7070306@linux.vnet.ibm.com>
Date: Wed, 30 Mar 2016 13:14:01 +0530
MIME-Version: 1.0
In-Reply-To: <56FB7CB8.1010801@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 03/30/2016 12:44 PM, Hari Bathini wrote:
>
>
> On 03/30/2016 05:55 AM, Michael Ellerman wrote:
>> On Tue, 2016-29-03 at 18:34:37 UTC, Hari Bathini wrote:
>>> diff --git a/arch/powerpc/kernel/exceptions-64s.S 
>>> b/arch/powerpc/kernel/exceptions-64s.S
>>> index 7716ceb..e598580 100644
>>> --- a/arch/powerpc/kernel/exceptions-64s.S
>>> +++ b/arch/powerpc/kernel/exceptions-64s.S
>>> @@ -764,8 +764,8 @@ kvmppc_skip_Hinterrupt:
>>>   #endif
>>>     /*
>>> - * Code from here down to __end_handlers is invoked from the
>>> - * exception prologs above.  Because the prologs assemble the
>>> + * Code from here down to end of out of line handlers is invoked from
>>> + * the exception prologs above.  Because the prologs assemble the
>> I think it would be better to just replace __end_handlers with 
>> __end_interrupts,
>> that way it's entirely clear what location you're talking about.
>>
>>> @@ -953,11 +953,6 @@ hv_facility_unavailable_relon_trampoline:
>>>   #endif
>>>       STD_RELON_EXCEPTION_PSERIES(0x5700, 0x1700, altivec_assist)
>>>   -    /* Other future vectors */
>>> -    .align    7
>>> -    .globl    __end_interrupts
>>> -__end_interrupts:
>>> -
>>>       .align    7
>>>   system_call_entry:
>>>       b    system_call_common
>>> @@ -1230,10 +1225,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
>>>       STD_EXCEPTION_COMMON(0xf60, facility_unavailable, 
>>> facility_unavailable_exception)
>>>       STD_EXCEPTION_COMMON(0xf80, hv_facility_unavailable, 
>>> facility_unavailable_exception)
>>>   -    .align    7
>>> -    .globl    __end_handlers
>>> -__end_handlers:
>>> -
>> Sorry I wasn't clear in my last mail, please do this as a separate 
>> cleanup patch
>> after this patch.
>
> ok..
>
>>> @@ -1244,6 +1235,16 @@ __end_handlers:
>>>       STD_RELON_EXCEPTION_PSERIES_OOL(0xf60, facility_unavailable)
>>>       STD_RELON_EXCEPTION_HV_OOL(0xf80, hv_facility_unavailable)
>>>   +    /* FIXME: For now, let us move the __end_interrupts marker 
>>> down past
>> Why is it FIXME?
>>
>> In general I don't want to merge code that adds a FIXME unless there 
>> is some
>> very good reason.
>>
>> AFAICS this is a permanent solution isn't it?
>
> Except for a few short interrupt vectors like 0x4f00, 04f20, etc., all 
> other
> vectors defined till __end_interrupts marker ensure that 
> LOAD_HANDLER() is
> used for branching to labels like system_call_entry, 
> data_access_common, etc.
> that are currently not copied to real 0 in relocation case.
>
> So, we are forced to move the __end_interrupts marker down only to handle
> space constraint in the short vectors. So, I added the FIXME to remind 
> the
> scope for improvement in the code. But after thinking over again now, 
> moving
> the marker down makes us copy an additional 1~2 KB along with the 
> 21~22 KB
> that we are copying already. So, not much of an improvement to lose 
> sleep over
> or to add a FIXME, I guess. Your thoughts?
>

Alternatively, how about moving the OOLs handlers that can't be branched 
with LOAD_HANDLER
under __end_interrupts. This way we won't be copying more than a few 
absolutely needed handlers.

STD_RELON_EXCEPTION_HV_OOL(0xe40, emulation_assist)
.
.
STD_RELON_EXCEPTION_HV_OOL(0xf80, hv_facility_unavailable)


We can leave __end_handlers marker to indicate code that should be part 
of the
first 64K of kernel image.

Thanks
Hari

> Also, FIXME is the reason, why I did not replace __end_handlers with
> __end_interrupts in the comment earlier.
>
>>> +     * the out-of-line handlers, to make sure we also copy OOL 
>>> handlers
>>> +     * to real adress 0x100 when running a relocatable kernel. This 
>>> helps
>> It doesn't "help" it's 100% required.
>
> Yep. Will change the wording.
> Thanks for the review!
>
> - Hari
>
>>> +     * in cases where interrupt vectors are not long enough (like 
>>> 0x4f00,
>>> +     * 0x4f20, etc.) to branch out to OOL handlers with 
>>> LOAD_HANDLER().
>>> +     */
>>> +    .align    7
>>> +    .globl    __end_interrupts
>>> +__end_interrupts:
>>> +
>>>   #if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
>>>   /*
>>>    * Data area reserved for FWNMI option.
>>
>> cheers
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
