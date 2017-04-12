Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2rzH6kMSzDq7h
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 14:48:43 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3C4huXm071608
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 00:48:31 -0400
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29scje22r7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 00:48:30 -0400
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 12 Apr 2017 10:18:27 +0530
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
 by d28relay08.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3C4l46v3932182
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 10:17:04 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
 by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3C4mOcO006620
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 10:18:25 +0530
Subject: Re: [RFC PATCH 6/7] powerpc/hugetlb: Add code to support to follow
 huge page directory entries
To: Michael Ellerman <mpe@ellerman.id.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
References: <1491314675-15787-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1491314675-15787-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <87shlfutp6.fsf@concordia.ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Wed, 12 Apr 2017 10:18:19 +0530
MIME-Version: 1.0
In-Reply-To: <87shlfutp6.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
Message-Id: <84b5c71d-e953-aabd-c7fd-137dcc0ea643@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/11/2017 03:55 PM, Michael Ellerman wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
> 
>> Add follow_huge_pd implementation for ppc64.
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/mm/hugetlbpage.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 42 insertions(+)
>>
>> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
>> index 80f6d2ed551a..9d66d4f810aa 100644
>> --- a/arch/powerpc/mm/hugetlbpage.c
>> +++ b/arch/powerpc/mm/hugetlbpage.c
>> @@ -17,6 +17,8 @@
>>  #include <linux/memblock.h>
>>  #include <linux/bootmem.h>
>>  #include <linux/moduleparam.h>
>> +#include <linux/swap.h>
>> +#include <linux/swapops.h>
>>  #include <asm/pgtable.h>
>>  #include <asm/pgalloc.h>
>>  #include <asm/tlb.h>
>> @@ -618,6 +620,10 @@ void hugetlb_free_pgd_range(struct mmu_gather *tlb,
>>  }
>>  
>>  /*
>> + * 64 bit book3s use generic follow_page_mask
>> + */
>> +#ifndef CONFIG_PPC_BOOK3S_64
> I think it's always easier to follow if you use:
> 
>   #ifdef x
>   ...
>   #else /* !x */
>   ...
>   #endif
> 
> ie. in this case put the Book3S 64 case first and the existing code in the
> #else.

Yeah, it was difficult to read in the first glance.
