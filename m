Return-Path: <srs0=7hay=gy=linux.vnet.ibm.com=prvs=06312cd2c6=mahesh@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [103.22.144.68])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40FnFf5jfnzF29M
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Apr 2018 21:40:06 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40FnFf50Fyz8vj0
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Apr 2018 21:40:06 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40FnFf1Nspz9s21
 for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2018 21:40:05 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w33BdGDo130052
 for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2018 07:40:03 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2h470ww5m1-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 03 Apr 2018 07:40:02 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 3 Apr 2018 12:40:01 +0100
Subject: Re: [PATCH v3 4/7] powerpc/fadump: exclude memory holes while
 reserving memory in second kernel.
To: Hari Bathini <hbathini@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>, kernelfans@gmail.com,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Ananth Narayan <ananth@in.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
References: <152265046485.23251.1392824827444770657.stgit@jupiter.in.ibm.com>
 <152265062142.23251.2863873644423472277.stgit@jupiter.in.ibm.com>
 <04e18a87-2882-b656-8fed-800c6d0bc835@linux.vnet.ibm.com>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Tue, 3 Apr 2018 17:09:54 +0530
MIME-Version: 1.0
In-Reply-To: <04e18a87-2882-b656-8fed-800c6d0bc835@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <ef184979-b14d-28a8-5fc0-febeb4d72ac4@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/03/2018 03:21 PM, Hari Bathini wrote:
> 
> 
> On Monday 02 April 2018 12:00 PM, Mahesh J Salgaonkar wrote:
>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>
>> The second kernel, during early boot after the crash, reserves rest of
>> the memory above boot memory size to make sure it does not touch any
>> of the
>> dump memory area. It uses memblock_reserve() that reserves the specified
>> memory region irrespective of memory holes present within that region.
>> There are chances where previous kernel would have hot removed some of
>> its memory leaving memory holes behind. In such cases fadump kernel
>> reports
>> incorrect number of reserved pages through arch_reserved_kernel_pages()
>> hook causing kernel to hang or panic.
>>
>> Fix this by excluding memory holes while reserving rest of the memory
>> above boot memory size during second kernel boot after crash.
>>
>> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/kernel/fadump.c |   17 ++++++++++++++++-
>>   1 file changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
>> index 011f1aa7abab..a497e9fb93fe 100644
>> --- a/arch/powerpc/kernel/fadump.c
>> +++ b/arch/powerpc/kernel/fadump.c
>> @@ -433,6 +433,21 @@ static inline unsigned long
>> get_fadump_metadata_base(
>>       return be64_to_cpu(fdm->metadata_region.source_address);
>>   }
>>
>> +static void fadump_memblock_reserve(unsigned long base, unsigned long
>> size)
>> +{
>> +    struct memblock_region *reg;
>> +    unsigned long start, end;
>> +
>> +    for_each_memblock(memory, reg) {
>> +        start = max(base, (unsigned long)reg->base);
>> +        end = reg->base + reg->size;
>> +        end = min(base + size, end);
>> +
>> +        if (start < end)
>> +            memblock_reserve(start, end - start);
>> +    }
>> +}
>> +
>>   int __init fadump_reserve_mem(void)
>>   {
>>       unsigned long base, size, memory_boundary;
>> @@ -487,7 +502,7 @@ int __init fadump_reserve_mem(void)
>>            */
>>           base = fw_dump.boot_memory_size;
>>           size = memory_boundary - base;
>> -        memblock_reserve(base, size);
>> +        fadump_memblock_reserve(base, size);
>>           printk(KERN_INFO "Reserved %ldMB of memory at %ldMB "
> 
> Mahesh, you may want to change this print as well as it would be
> misleading in case of
> holes in the memory.

Yeah, may be we can just move that printk also inside
fadump_memblock_reserve().

Thanks,
-Mahesh.

> 
> Thanks
> Hari
> 
>>                   "for saving crash dump\n",
>>                   (unsigned long)(size >> 20),
>>
> 
