Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B4CBB1A0655
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 23:24:59 +1000 (AEST)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 816A41401AB
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Aug 2015 23:24:59 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 6 Aug 2015 23:24:59 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 1F7F82BB0059
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Aug 2015 23:24:55 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t76DOfD3327950
 for <linuxppc-dev@ozlabs.org>; Thu, 6 Aug 2015 23:24:50 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t76DOLj6010596
 for <linuxppc-dev@ozlabs.org>; Thu, 6 Aug 2015 23:24:22 +1000
Message-ID: <55C35FF4.9050001@linux.vnet.ibm.com>
Date: Thu, 06 Aug 2015 18:54:04 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
CC: mikey@neuling.org
Subject: Re: [V3] powerpc/irq: Enable some more exceptions in /proc/interrupts
 interface
References: <20150804095726.66D4A1402E2@ozlabs.org>
In-Reply-To: <20150804095726.66D4A1402E2@ozlabs.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/04/2015 03:27 PM, Michael Ellerman wrote:
> On Mon, 2015-13-07 at 08:16:06 UTC, Anshuman Khandual wrote:
>> This patch enables facility unavailable exceptions for generic facility,
>> FPU, ALTIVEC and VSX in /proc/interrupts listing by incrementing their
>> newly added IRQ statistical counters as and when these exceptions happen.
>> This also adds couple of helper functions which will be called from within
>> the interrupt handler context to update their statistics. Similarly this
>> patch also enables alignment and program check exceptions as well.
> 
> ...
> 
>> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
>> index 0a0399c2..a86180c 100644
>> --- a/arch/powerpc/kernel/exceptions-64s.S
>> +++ b/arch/powerpc/kernel/exceptions-64s.S
>> @@ -1158,6 +1158,7 @@ BEGIN_FTR_SECTION
>>  END_FTR_SECTION_IFSET(CPU_FTR_TM)
>>  #endif
>>  	bl	load_up_fpu
>> +	bl	fpu_unav_exceptions_count
> 
> Is it safe to call C code here?

Hmm, is it not ? I had that question but was not really sure. Dont
understand the difference between 'fast_exception_return' and
'ret_from_except' completely. Will converting the following sequence
of code

 	bl	load_up_fpu
+	bl	fpu_unav_exceptions_count
 	b	fast_exception_return

into

 	bl	load_up_fpu
        RECONCILE_IRQ_STATE(r10, r11)
        addi    r3,r1,STACK_FRAME_OVERHEAD
+	bl	fpu_unav_exceptions_count
 	b	ret_from_except

help solve the problem ?
