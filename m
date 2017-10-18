Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yGxJH6pvtzDrF7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 13:45:51 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9I2iZPK142550
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 22:45:48 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dnsgfk1f8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 22:45:48 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 17 Oct 2017 22:45:48 -0400
Subject: Re: [PATCH] powerpc/mm/radix: Drop unneeded NULL check
To: Nicholas Piggin <npiggin@gmail.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
References: <20171016071100.8497-1-aneesh.kumar@linux.vnet.ibm.com>
 <20171017215339.16354330@roar.ozlabs.ibm.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 18 Oct 2017 08:15:38 +0530
MIME-Version: 1.0
In-Reply-To: <20171017215339.16354330@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <7ae94938-e4d8-6fc4-c631-14bb490fbead@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 10/17/2017 05:24 PM, Nicholas Piggin wrote:
> On Mon, 16 Oct 2017 12:41:00 +0530
> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:
> 
>> @@ -175,10 +175,9 @@ void radix__local_flush_tlb_page(struct vm_area_struct *vma, unsigned long vmadd
>>   #ifdef CONFIG_HUGETLB_PAGE
>>   	/* need the return fix for nohash.c */
>>   	if (vma && is_vm_hugetlb_page(vma))
>> -		return __local_flush_hugetlb_page(vma, vmaddr);
>> +		return radix__local_flush_hugetlb_page(vma, vmaddr);
>>   #endif
>> -	radix__local_flush_tlb_page_psize(vma ? vma->vm_mm : NULL, vmaddr,
>> -					  mmu_virtual_psize);
>> +	radix__local_flush_tlb_page_psize(vma->vm_mm, vmaddr, mmu_virtual_psize);
>>   }
>>   EXPORT_SYMBOL(radix__local_flush_tlb_page);
>>   
> 
> Missed the other NULL pointer check in this hunk.
> 
>> @@ -247,10 +246,9 @@ void radix__flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
>>   {
>>   #ifdef CONFIG_HUGETLB_PAGE
>>   	if (vma && is_vm_hugetlb_page(vma))
>> -		return flush_hugetlb_page(vma, vmaddr);
>> +		return radix__flush_hugetlb_page(vma, vmaddr);
>>   #endif
>> -	radix__flush_tlb_page_psize(vma ? vma->vm_mm : NULL, vmaddr,
>> -				    mmu_virtual_psize);
>> +	radix__flush_tlb_page_psize(vma->vm_mm, vmaddr, mmu_virtual_psize);
>>   }
>>   EXPORT_SYMBOL(radix__flush_tlb_page);
>>   
> 
> And another one.
> 

Didn't get that. We should not find vma NULL here. Hence i removed that 
vma == NULL check. Are you suggesting that this is not correct?

-aneesh
