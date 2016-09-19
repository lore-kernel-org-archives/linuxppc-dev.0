Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3scwDy1qPCzDsdl
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 15:58:58 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8J5wtpC081717
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 01:58:55 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25h1u70a5a-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 01:58:55 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 19 Sep 2016 15:58:43 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 78F372BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 15:58:40 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8J5wec31638734
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 15:58:40 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8J5wdic017690
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 15:58:40 +1000
Subject: Re: [PATCH 10/13] powerpc: Add "bitmask" paramater to MASKABLE_*
 macros
To: Nicholas Piggin <npiggin@gmail.com>
References: <1473944523-624-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1473944523-624-11-git-send-email-maddy@linux.vnet.ibm.com>
 <20160916210344.5689fbd8@roar.ozlabs.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Mon, 19 Sep 2016 11:28:38 +0530
MIME-Version: 1.0
In-Reply-To: <20160916210344.5689fbd8@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <b96bbfdf-6124-c53e-caec-8e7ecab33622@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Friday 16 September 2016 04:33 PM, Nicholas Piggin wrote:
> On Thu, 15 Sep 2016 18:32:00 +0530
> Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:
>
>> Make it explicit the interrupt masking supported
>> by a gievn interrupt handler. Patch correspondingly
>> extends the MASKABLE_* macros with an addition's parameter.
>> "bitmask" parameter is passed to SOFTEN_TEST macro to decide
>> on masking the interrupt.
>>
>> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/include/asm/exception-64s.h | 62 ++++++++++++++++----------------
>>   arch/powerpc/kernel/exceptions-64s.S     | 36 ++++++++++++-------
>>   2 files changed, 54 insertions(+), 44 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
>> index 1eea4ab75607..41be0c2d7658 100644
>> --- a/arch/powerpc/include/asm/exception-64s.h
>> +++ b/arch/powerpc/include/asm/exception-64s.h
>> @@ -179,9 +179,9 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
>>    * checking of the interrupt maskable level in the SOFTEN_TEST.
>>    * Intended to be used in MASKABLE_EXCPETION_* macros.
>>    */
>> -#define __EXCEPTION_PROLOG_1(area, extra, vec)				\
>> +#define __EXCEPTION_PROLOG_1(area, extra, vec, bitmask)			\
>>   	__EXCEPTION_PROLOG_1_PRE(area);					\
>> -	extra(vec);							\
>> +	extra(vec, bitmask);						\
>>   	__EXCEPTION_PROLOG_1_POST(area);
>>   
>>   /*
> Is __EXCEPTION_PROLOG_1 now for maskable exceptions, and EXCEPTION_PROLOG_1
> for unmaskable? Does it make sense to rename __EXCEPTION_PROLOG_1 to
> MASKABLE_EXCEPTION_PROLOG_1? Reducing the mystery underscores in this file would
> be nice!

Yes. That is true. Will make the changes.

Maddy

>
> This worked out nicely with mask bit being passed in by the exception handlers.
> Very neat.

Thanks.

> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
>
