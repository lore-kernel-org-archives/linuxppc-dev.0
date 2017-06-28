Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyJpq3XPnzDr3h
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 20:25:55 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5SAPncf099635
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 06:25:53 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bc8wmw5d4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 06:25:51 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 28 Jun 2017 06:25:39 -0400
Subject: Re: [PATCH] powerpc: Build fix for non SPARSEMEM_VMEMAP config
To: Alexey Kardashevskiy <aik@ozlabs.ru>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
References: <1498630168-26376-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <bb344453-f49d-aff1-8f9c-732b8a40cbfa@ozlabs.ru>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 28 Jun 2017 15:55:32 +0530
MIME-Version: 1.0
In-Reply-To: <bb344453-f49d-aff1-8f9c-732b8a40cbfa@ozlabs.ru>
Content-Type: text/plain; charset=koi8-r; format=flowed
Message-Id: <bb3cb2f5-12dd-0b0d-0b2a-ca5de2d1f6bf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 28 June 2017 12:48 PM, Alexey Kardashevskiy wrote:
> On 28/06/17 16:09, Aneesh Kumar K.V wrote:
>> We can use pfn_to_page in realmode for other configs. Hence remove the
>> CONFIG_FLATMEM ifdef
> 
> 
> For CONFIG_SPARSEMEM and CONFIG_DISCONTIGMEM and others (I am struggling to
> find the full list :) )? Are you sure about that? If I recall correctly, at
> the time realmode_pfn_to_page() could not work for all of them, what changed?


That is one thing I wanted to check. Everything other than 
SPARSEMEM_VMEMMAP should use linear mapping which can work with real 
mode also right ? Or am i missing something ?

> 
>>
>> Fixes: 8e0861fa3c4ed (powerpc: Prepare to support kernel handling of IOMMU map/unmap)
>>
>> Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/mm/init_64.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
>> index ec84b31c6c86..3dd507b4f8cd 100644
>> --- a/arch/powerpc/mm/init_64.c
>> +++ b/arch/powerpc/mm/init_64.c
>> @@ -322,7 +322,7 @@ struct page *realmode_pfn_to_page(unsigned long pfn)
>>   }
>>   EXPORT_SYMBOL_GPL(realmode_pfn_to_page);
>>   
>> -#elif defined(CONFIG_FLATMEM)
>> +#else
> 
> There is also a comment at the #endif with "FLATMEM", needs to be updated.
> 
> 
>>   
>>   struct page *realmode_pfn_to_page(unsigned long pfn)
>>   {
>>
> 
> 
