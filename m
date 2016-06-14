Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rTLVJ3YBFzDqgP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 17:14:00 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5E7Dfkk083510
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 03:13:58 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23gbhfrb3c-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 03:13:58 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 14 Jun 2016 01:13:57 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, benh@kernel.crashing.org,
 paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [V2, 08/10] powerpc/mm: Clear top 16 bits of va only on older cpus
In-Reply-To: <3rTHSj5DMRz9t0G@ozlabs.org>
References: <3rTHSj5DMRz9t0G@ozlabs.org>
Date: Tue, 14 Jun 2016 12:43:52 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <878ty8utsf.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> On Thu, 2016-09-06 at 06:19:15 UTC, "Aneesh Kumar K.V" wrote:
>> Updated patch below. MMU_FTRS_POWER4 is inherited by others, hence don't
>> update that.
>> 
>> >From 4ed66fd24dc4f976969cc34aca8df2ddbc69fe61 Mon Sep 17 00:00:00 2001
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>> Date: Sat, 4 Jun 2016 19:58:26 +0530
>> Subject: [PATCH] powerpc/mm: Clear top 16 bits of va only on older cpus
>> 
>> As per ISA, we need to do this only for architecture version 2.02 and
>> earlier. This continued to work even for 2.07. But let's not do this for
>> anything after 2.02
>
> What are the practical effects of this?


For ISA 3.0 we require these top bits to be not cleared. I have updated
the commit message to reflect that.

>
>> diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
>> index e53ebebff474..fa314b1d667e 100644
>> --- a/arch/powerpc/include/asm/mmu.h
>> +++ b/arch/powerpc/include/asm/mmu.h
>> @@ -24,6 +24,11 @@
>>  /*
>>   * This is individual features
>>   */
>> +/*
>> + * We need to clear top 16bits of va (from the remaining 64 bits )in
>> + * tlbie* instructions
>> + */
>> +#define MMU_FTR_TLBIE_CROP_VA		ASM_CONST(0x00008000)
>>  
>>  /* Enable use of high BAT registers */
>>  #define MMU_FTR_USE_HIGH_BATS		ASM_CONST(0x00010000)
>> @@ -124,7 +129,7 @@ enum {
>>  		MMU_FTR_USE_TLBRSRV | MMU_FTR_USE_PAIRED_MAS |
>>  		MMU_FTR_NO_SLBIE_B | MMU_FTR_16M_PAGE | MMU_FTR_TLBIEL |
>>  		MMU_FTR_LOCKLESS_TLBIE | MMU_FTR_CI_LARGE_PAGE |
>> -		MMU_FTR_1T_SEGMENT |
>> +		MMU_FTR_1T_SEGMENT | MMU_FTR_TLBIE_CROP_VA |
>>  #ifdef CONFIG_PPC_RADIX_MMU
>>  		MMU_FTR_RADIX |
>>  #endif
>> diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
>> index eeeacf6235a3..d8a0f7ca74e1 100644
>> --- a/arch/powerpc/kernel/cputable.c
>> +++ b/arch/powerpc/kernel/cputable.c
>> @@ -137,7 +137,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
>>  		.cpu_name		= "POWER4 (gp)",
>>  		.cpu_features		= CPU_FTRS_POWER4,
>>  		.cpu_user_features	= COMMON_USER_POWER4,
>> -		.mmu_features		= MMU_FTRS_POWER4,
>> +		.mmu_features		= MMU_FTRS_POWER4 | MMU_FTR_TLBIE_CROP_VA,
>>  		.icache_bsize		= 128,
>>  		.dcache_bsize		= 128,
>>  		.num_pmcs		= 8,
>> @@ -152,7 +152,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
>>  		.cpu_name		= "POWER4+ (gq)",
>>  		.cpu_features		= CPU_FTRS_POWER4,
>>  		.cpu_user_features	= COMMON_USER_POWER4,
>> -		.mmu_features		= MMU_FTRS_POWER4,
>> +		.mmu_features		= MMU_FTRS_POWER4 | MMU_FTR_TLBIE_CROP_VA,
>>  		.icache_bsize		= 128,
>>  		.dcache_bsize		= 128,
>>  		.num_pmcs		= 8,
>> @@ -168,7 +168,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
>>  		.cpu_features		= CPU_FTRS_PPC970,
>>  		.cpu_user_features	= COMMON_USER_POWER4 |
>>  			PPC_FEATURE_HAS_ALTIVEC_COMP,
>> -		.mmu_features		= MMU_FTRS_PPC970,
>> +		.mmu_features		= MMU_FTRS_PPC970 | MMU_FTR_TLBIE_CROP_VA,
>
> Please add it to MMU_FTRS_PPC970, rather than at every usage.
>

Done

-aneesh
