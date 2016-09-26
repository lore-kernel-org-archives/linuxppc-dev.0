Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sjXvj5101zDrPj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 04:45:05 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3sjXvh6BCnz9sXR
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Sep 2016 04:45:04 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8QIgpXi102893
 for <linuxppc-dev@ozlabs.org>; Mon, 26 Sep 2016 14:45:02 -0400
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25q5mqtjnk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 26 Sep 2016 14:45:02 -0400
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Tue, 27 Sep 2016 00:14:59 +0530
Received: from d28relay07.in.ibm.com (d28relay07.in.ibm.com [9.184.220.158])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id C11B2125805E
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Sep 2016 00:15:17 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay07.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8QIikMk27263136
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Sep 2016 00:14:46 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8QIiuYM017354
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Sep 2016 00:14:56 +0530
Subject: Re: [PATCH v2] powerpc/mm: export current mmu mode info
To: Michael Ellerman <mpe@ellerman.id.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
References: <147456009252.14735.18189822731283851598.stgit@hbathini.in.ibm.com>
 <87y42i7ty4.fsf@concordia.ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Tue, 27 Sep 2016 00:14:55 +0530
MIME-Version: 1.0
In-Reply-To: <87y42i7ty4.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <4586df3a-626d-0124-8dc2-cb658166f14d@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael/Aneesh,

Thanks for reviewing the patch..


On Friday 23 September 2016 04:40 PM, Michael Ellerman wrote:
> Hari Bathini <hbathini@linux.vnet.ibm.com> writes:
>
>> diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
>> index e2fb408..558987c 100644
>> --- a/arch/powerpc/include/asm/mmu.h
>> +++ b/arch/powerpc/include/asm/mmu.h
>> @@ -199,6 +199,21 @@ static inline void mmu_clear_feature(unsigned long feature)
>>   
>>   extern unsigned int __start___mmu_ftr_fixup, __stop___mmu_ftr_fixup;
>>   
>> +/*
>> + * Possible MMU modes
>> + */
>> +#define MMU_MODE_NONE           0
>> +#define MMU_MODE_RADIX          1
>> +#define MMU_MODE_HASH           2
>> +#define MMU_MODE_HASH32         3
>> +#define MMU_MODE_NOHASH         4
>> +#define MMU_MODE_NOHASH32       5
> These are already defined in the same file:
>
> /*
>   * MMU families
>   */
> #define MMU_FTR_HPTE_TABLE		ASM_CONST(0x00000001)
> #define MMU_FTR_TYPE_8xx		ASM_CONST(0x00000002)
> #define MMU_FTR_TYPE_40x		ASM_CONST(0x00000004)
> #define MMU_FTR_TYPE_44x		ASM_CONST(0x00000008)
> #define MMU_FTR_TYPE_FSL_E		ASM_CONST(0x00000010)
> #define MMU_FTR_TYPE_47x		ASM_CONST(0x00000020)
> #define MMU_FTR_TYPE_RADIX		ASM_CONST(0x00000040)
>
> And the values for the current CPU are in cur_cpu_spec->mmu_features.

I primarily tried to introduce this patch as crash tool doesn't have 
access to
offset info (which is needed to access structure member mmu_features) early
in it's initialization process.

> So if you must export anything, make it that value, and hopefully the
> rest of the patch goes away.

On second thought, as long as we can get the vmemmap start address, for 
which
we have a variable already, we can push finding of MMU type for later. I 
may need
no kernel patch in that case. Working on patches for crash & 
makedumpfile tools
accordingly. Will post a v3 only if that doesn't work out..

Thanks
Hari
