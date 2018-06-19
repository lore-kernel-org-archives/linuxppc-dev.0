Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4197yR4FBhzF0fX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 23:26:06 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5JDNvhA112100
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 09:26:04 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2jpyquys58-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 09:26:03 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Tue, 19 Jun 2018 07:26:03 -0600
Subject: Re: [PATCH] powerpc/mm/hash/4k: Free hugetlb page table caches
 correctly.
To: Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org
References: <20180614103152.7344-1-aneesh.kumar@linux.ibm.com>
 <87o9g7xby7.fsf@concordia.ellerman.id.au>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Tue, 19 Jun 2018 18:55:55 +0530
MIME-Version: 1.0
In-Reply-To: <87o9g7xby7.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <0a99a24e-8859-b853-6902-78e5ee06dee6@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/19/2018 04:47 PM, Michael Ellerman wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> 
>> With 4k page size for hugetlb we allocate hugepage directories from its on slab
>> cache. With patch 0c4d26802 ("powerpc/book3s64/mm: Simplify the rcu callback for page table free")
>> we missed to free these allocated hugepd tables.
>>
>> Update pgtable_free to handle hugetlb hugepd directory table.
>>
>> Fixes:  0c4d26802 ("powerpc/book3s64/mm: Simplify the rcu callback for page table free")
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>>   arch/powerpc/include/asm/book3s/32/pgalloc.h  |  1 +
>>   .../include/asm/book3s/64/pgtable-4k.h        | 21 +++++++++++++++++++
>>   .../include/asm/book3s/64/pgtable-64k.h       |  9 ++++++++
>>   arch/powerpc/include/asm/book3s/64/pgtable.h  |  5 +++++
>>   arch/powerpc/include/asm/nohash/32/pgalloc.h  |  1 +
>>   arch/powerpc/include/asm/nohash/64/pgalloc.h  |  1 +
>>   arch/powerpc/mm/hugetlbpage.c                 |  3 ++-
>>   arch/powerpc/mm/pgtable-book3s64.c            | 12 +++++++++++
> 
> Fails with 4K=y HUGETLBFS=n:
> 
>    arch/powerpc/mm/pgtable-book3s64.c:415:16: error: ‘H_16M_CACHE_INDEX’ undeclared (first use in this function); did you mean ‘H_PUD_CACHE_INDEX’?
> 
> ...
> 
>> diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
>> index c1f4ca45c93a..468c3d83a2aa 100644
>> --- a/arch/powerpc/mm/pgtable-book3s64.c
>> +++ b/arch/powerpc/mm/pgtable-book3s64.c
>> @@ -409,6 +409,18 @@ static inline void pgtable_free(void *table, int index)
>>   	case PUD_INDEX:
>>   		kmem_cache_free(PGT_CACHE(PUD_CACHE_INDEX), table);
>>   		break;
>> +#ifdef CONFIG_PPC_4K_PAGES
>> +		/* 16M hugepd directory at pud level */
>> +	case HTLB_16M_INDEX:
>> +		BUILD_BUG_ON(H_16M_CACHE_INDEX <= 0);
>> +		kmem_cache_free(PGT_CACHE(H_16M_CACHE_INDEX), table);
>> +		break;
>> +		/* 16G hugepd directory at the pgd level */
>> +	case HTLB_16G_INDEX:
>> +		BUILD_BUG_ON(H_16G_CACHE_INDEX <= 0);
>> +		kmem_cache_free(PGT_CACHE(H_16G_CACHE_INDEX), table);
>> +		break;
>> +#endif
> 
> Because this isn't protected by CONFIG_HUGETLBFS.
> 
> I assume this is correct?
> 
> diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
> index 468c3d83a2aa..9b7007fd075e 100644
> --- a/arch/powerpc/mm/pgtable-book3s64.c
> +++ b/arch/powerpc/mm/pgtable-book3s64.c
> @@ -409,7 +409,7 @@ static inline void pgtable_free(void *table, int index)
>   	case PUD_INDEX:
>   		kmem_cache_free(PGT_CACHE(PUD_CACHE_INDEX), table);
>   		break;
> -#ifdef CONFIG_PPC_4K_PAGES
> +#if defined(CONFIG_PPC_4K_PAGES) && defined (CONFIG_HUGETLBFS)
>   		/* 16M hugepd directory at pud level */
>   	case HTLB_16M_INDEX:
>   		BUILD_BUG_ON(H_16M_CACHE_INDEX <= 0);
> 
> 
> cheers
> 

Sorry missed that. Can we use #ifdef CONFIG_HUGETLB_PAGE ? That is what 
we use to protect that in pgtable-4k.h

-aneesh

-aneesh
