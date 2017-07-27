Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJH710GlPzDrLF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 02:12:12 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6RG7hpo031353
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 12:12:11 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2byjkxjvax-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 12:12:10 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 27 Jul 2017 10:12:10 -0600
Subject: Re: [PATCH v3 1/3] mm/hugetlb: Allow arch to override and call the
 weak function
To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
References: <20170727061828.11406-1-aneesh.kumar@linux.vnet.ibm.com>
 <20170727152556.s4uw5cuvdf36hodl@oracle.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 27 Jul 2017 21:42:04 +0530
MIME-Version: 1.0
In-Reply-To: <20170727152556.s4uw5cuvdf36hodl@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <da6a497b-e65c-b0db-3dab-83aa300a75ca@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 07/27/2017 08:55 PM, Liam R. Howlett wrote:
> * Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com> [170727 02:18]:
>> For ppc64, we want to call this function when we are not running as guest.
>> Also, if we failed to allocate hugepages, let the user know.
>>
> [...]
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index bc48ee783dd9..a3a7a7e6339e 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -2083,7 +2083,9 @@ struct page *alloc_huge_page_noerr(struct vm_area_struct *vma,
>>   	return page;
>>   }
>>   
>> -int __weak alloc_bootmem_huge_page(struct hstate *h)
>> +int alloc_bootmem_huge_page(struct hstate *h)
>> +	__attribute__ ((weak, alias("__alloc_bootmem_huge_page")));
>> +int __alloc_bootmem_huge_page(struct hstate *h)
>>   {
>>   	struct huge_bootmem_page *m;
>>   	int nr_nodes, node;
>> @@ -2104,6 +2106,7 @@ int __weak alloc_bootmem_huge_page(struct hstate *h)
>>   			goto found;
>>   		}
>>   	}
>> +	pr_info("Failed to allocate hugepage of size %ld\n", huge_page_size(h));
>>   	return 0;
>>   
>>   found:
> 
> There is already a call to warn the user in the
> hugetlb_hstate_alloc_pages function.  If you look there, you will see
> that the huge_page_size was translated into a more user friendly format
> and the count prior to the failure is included.  What call path are you
> trying to cover?  Also, you may want your print to be a pr_warn since it
> is a failure?
> 

Sorry I missed that in the recent kernel. I wrote the above before the 
mentioned changes was done. I will drop the pr_info from the patch.

Thanks
-aneesh
