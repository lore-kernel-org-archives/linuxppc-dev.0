Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tL1Pk252TzDvQC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Nov 2016 02:00:10 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAIEwXMd053688
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 10:00:08 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26t2tukas4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 10:00:07 -0500
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 18 Nov 2016 10:00:06 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, benh@kernel.crashing.org,
 paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/4] powerpc/mm: Rename hugetlb-radix.h to hugetlb.h
In-Reply-To: <874m350xyg.fsf@concordia.ellerman.id.au>
References: <20161114151128.2146-1-aneesh.kumar@linux.vnet.ibm.com>
 <20161114151128.2146-2-aneesh.kumar@linux.vnet.ibm.com>
 <874m350xyg.fsf@concordia.ellerman.id.au>
Date: Fri, 18 Nov 2016 20:30:00 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87mvgwn89b.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
>
>> We will start moving some book3s specific hugetlb functions there.
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/book3s/64/{hugetlb-radix.h => hugetlb.h} | 8 ++++++--
>>  arch/powerpc/include/asm/hugetlb.h                                | 2 +-
>>  2 files changed, 7 insertions(+), 3 deletions(-)
>>  rename arch/powerpc/include/asm/book3s/64/{hugetlb-radix.h => hugetlb.h} (78%)
>>
>> diff --git a/arch/powerpc/include/asm/book3s/64/hugetlb-radix.h b/arch/powerpc/include/asm/book3s/64/hugetlb.h
>> similarity index 78%
>> rename from arch/powerpc/include/asm/book3s/64/hugetlb-radix.h
>> rename to arch/powerpc/include/asm/book3s/64/hugetlb.h
>> index c45189aa7476..d9c283f95e05 100644
>> --- a/arch/powerpc/include/asm/book3s/64/hugetlb-radix.h
>> +++ b/arch/powerpc/include/asm/book3s/64/hugetlb.h
>> @@ -1,5 +1,5 @@
>> -#ifndef _ASM_POWERPC_BOOK3S_64_HUGETLB_RADIX_H
>> -#define _ASM_POWERPC_BOOK3S_64_HUGETLB_RADIX_H
>> +#ifndef _ASM_POWERPC_BOOK3S_64_HUGETLB_H
>> +#define _ASM_POWERPC_BOOK3S_64_HUGETLB_H
>>  /*
>>   * For radix we want generic code to handle hugetlb. But then if we want
>>   * both hash and radix to be enabled together we need to workaround the
>> @@ -21,6 +21,10 @@ static inline int hstate_get_psize(struct hstate *hstate)
>>  		return MMU_PAGE_2M;
>>  	else if (shift == mmu_psize_defs[MMU_PAGE_1G].shift)
>>  		return MMU_PAGE_1G;
>> +	else if (shift == mmu_psize_defs[MMU_PAGE_16M].shift)
>> +		return MMU_PAGE_16M;
>> +	else if (shift == mmu_psize_defs[MMU_PAGE_16G].shift)
>> +		return MMU_PAGE_16G;
>
> That's not just a rename?

In a way it is, because now it need to handle the new hugepage shift
supported by hash. 

I can split that to two patch if that makes explains it better.

-aneesh
