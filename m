Return-Path: <danielhb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zc8370HCpzF11d
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Feb 2018 04:49:22 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w17HlB8Q091645
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Feb 2018 12:49:20 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g050xkmh9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Feb 2018 12:49:18 -0500
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <danielhb@linux.vnet.ibm.com>;
 Wed, 7 Feb 2018 12:49:17 -0500
Subject: Re: [PATCH kernel v2] powerpc/mm: Flush radix process translations
 when setting MMU type
To: Laurent Vivier <lvivier@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linuxppc-dev@lists.ozlabs.org
References: <20180201050944.30332-1-aik@ozlabs.ru>
 <fb14f2b5-03a3-c20b-b729-643d6a79504a@redhat.com>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Wed, 7 Feb 2018 15:49:14 -0200
MIME-Version: 1.0
In-Reply-To: <fb14f2b5-03a3-c20b-b729-643d6a79504a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <f30971fd-a4a8-ceb6-bf0a-b293275c8d0b@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 02/07/2018 12:33 PM, Laurent Vivier wrote:
> On 01/02/2018 06:09, Alexey Kardashevskiy wrote:
>> Radix guests do normally invalidate process-scoped translations when
>> a new pid is allocated but migrated guests do not invalidate these so
>> migrated guests crash sometime, especially easy to reproduce with
>> migration happening within first 10 seconds after the guest boot start on
>> the same machine.
>>
>> This adds the "Invalidate process-scoped translations" flush to fix
>> radix guests migration.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>> Changes:
>> v2:
>> * removed PPC_TLBIE_5() from the !(old&PATH_HR) case as it is pointless
>> on hash
>>
>> ---
>>
>>
>> Not so sure that "process-scoped translations" only require flushing
>> at pid allocation and migration.
>>
>> ---
>>   arch/powerpc/mm/pgtable_64.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
>> index c9a623c..d75dd52 100644
>> --- a/arch/powerpc/mm/pgtable_64.c
>> +++ b/arch/powerpc/mm/pgtable_64.c
>> @@ -471,6 +471,8 @@ void mmu_partition_table_set_entry(unsigned int lpid, unsigned long dw0,
>>   	if (old & PATB_HR) {
>>   		asm volatile(PPC_TLBIE_5(%0,%1,2,0,1) : :
>>   			     "r" (TLBIEL_INVAL_SET_LPID), "r" (lpid));
>> +		asm volatile(PPC_TLBIE_5(%0,%1,2,1,1) : :
>> +			     "r" (TLBIEL_INVAL_SET_LPID), "r" (lpid));
>>   		trace_tlbie(lpid, 0, TLBIEL_INVAL_SET_LPID, lpid, 2, 0, 1);
>>   	} else {
>>   		asm volatile(PPC_TLBIE_5(%0,%1,2,0,0) : :
>>
> This patch fixes for me a VM migration crash on POWER9.

Same here.

Tested-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

>
> Tested-by: Laurent Vivier <lvivier@redhat.com>
>
> Thanks,
> Laurent
>
