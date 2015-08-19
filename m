Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BB2E01A0514
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2015 23:54:51 +1000 (AEST)
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 10E02140783
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2015 23:54:50 +1000 (AEST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 19 Aug 2015 19:24:48 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 8A3B0394004E
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2015 19:24:46 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7JDsPhJ58589366
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2015 19:24:27 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7JDsNr1012835
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2015 19:24:24 +0530
Message-ID: <55D48A8E.1010408@linux.vnet.ibm.com>
Date: Wed, 19 Aug 2015 19:24:22 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
CC: linuxppc-dev@ozlabs.org, mikey@neuling.org
Subject: Re: [V3] powerpc/irq: Enable some more exceptions in /proc/interrupts
 interface
References: <20150804095726.66D4A1402E2@ozlabs.org>
 <55C35FF4.9050001@linux.vnet.ibm.com>
 <1439520749.2056.4.camel@ellerman.id.au>
In-Reply-To: <1439520749.2056.4.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/14/2015 08:22 AM, Michael Ellerman wrote:
> On Thu, 2015-08-06 at 18:54 +0530, Anshuman Khandual wrote:
>> On 08/04/2015 03:27 PM, Michael Ellerman wrote:
>>> On Mon, 2015-13-07 at 08:16:06 UTC, Anshuman Khandual wrote:
>>>> This patch enables facility unavailable exceptions for generic facility,
>>>> FPU, ALTIVEC and VSX in /proc/interrupts listing by incrementing their
>>>> newly added IRQ statistical counters as and when these exceptions happen.
>>>> This also adds couple of helper functions which will be called from within
>>>> the interrupt handler context to update their statistics. Similarly this
>>>> patch also enables alignment and program check exceptions as well.
>>>
>>> ...
>>>
>>>> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
>>>> index 0a0399c2..a86180c 100644
>>>> --- a/arch/powerpc/kernel/exceptions-64s.S
>>>> +++ b/arch/powerpc/kernel/exceptions-64s.S
>>>> @@ -1158,6 +1158,7 @@ BEGIN_FTR_SECTION
>>>>  END_FTR_SECTION_IFSET(CPU_FTR_TM)
>>>>  #endif
>>>>  	bl	load_up_fpu
>>>> +	bl	fpu_unav_exceptions_count
>>>
>>> Is it safe to call C code here?
>>
>> Hmm, is it not ? I had that question but was not really sure. Dont
>> understand the difference between 'fast_exception_return' and
>> 'ret_from_except' completely.
> 
> If you're "not really sure" it's correct, please say so in the change log!

Yeah I should have written that up some where after the commit
message (after "---"). Its my bad, will take care of this next
time around.

> 
> I'd rather you didn't send me patches with possibly subtle bugs in core code.

Michael, I understand your concern. I was just trying to add
new entries in there which would help us. Wondering whats our
plan for this patch, if we change it as I had proposed earlier,
will it be good enough.
