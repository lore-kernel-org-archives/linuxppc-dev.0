Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vybdD1cDNzDqH6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Apr 2017 16:33:19 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v356X4Mt079860
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Apr 2017 02:33:08 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29mudfr05b-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Apr 2017 02:33:08 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 5 Apr 2017 02:33:07 -0400
Subject: Re: [RFC PATCH] powerpc/mm/hugetlb: Add support for 1G huge pages
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
References: <1491314625-15307-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <d0f14ff7-fce7-e39d-d921-14485aef2ead@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 5 Apr 2017 12:03:01 +0530
MIME-Version: 1.0
In-Reply-To: <d0f14ff7-fce7-e39d-d921-14485aef2ead@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <5615ed34-1e8a-4f16-102b-4d2c87e77a0a@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 05 April 2017 11:05 AM, Anshuman Khandual wrote:
> On 04/04/2017 07:33 PM, Aneesh Kumar K.V wrote:
>> This patch adds support for gigantic pages in ppc64. We also updates
>> gigantic_page_supported helper such that arch can override it.
>
> Seems like only radix based 1GB is considered as gigantic page in this
> implementation. What about the existing 16GB pages support ? IIUC they
> are still supported currently as gigantic pages (as defined in generic
> HugeTLB) if the platform gives us reserved memory areas during boot.
> Can you explain how this is going to be different ?
>
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/book3s/64/hugetlb.h | 9 +++++++++
>>  arch/powerpc/mm/hugetlbpage.c                | 7 +++++--
>>  arch/powerpc/platforms/Kconfig.cputype       | 1 +
>>  mm/hugetlb.c                                 | 4 ++++
>>  4 files changed, 19 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/book3s/64/hugetlb.h b/arch/powerpc/include/asm/book3s/64/hugetlb.h
>> index 6666cd366596..a994d069fdaf 100644
>> --- a/arch/powerpc/include/asm/book3s/64/hugetlb.h
>> +++ b/arch/powerpc/include/asm/book3s/64/hugetlb.h
>> @@ -50,4 +50,13 @@ static inline pte_t arch_make_huge_pte(pte_t entry, struct vm_area_struct *vma,
>>  	else
>>  		return entry;
>>  }
>> +
>> +#define gigantic_page_supported gigantic_page_supported
>> +static inline bool gigantic_page_supported(void)
>> +{
>> +	if (radix_enabled())
>> +		return true;
>> +	return false;
>> +}
>
> POWER8 (non radix MMU) cannot have 16GB gigantic HugeTLB pages ?

that helper determines whether we can do gigantic page allocation at 
runtime. I doubt we can do that for 16GB pages. Hence this is only 
enabled for 1G radix config


-aneesh
