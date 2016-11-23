Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tP4WC70YJzDwHF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 01:30:30 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uANET0LM109162
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 09:30:29 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26w917prqn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 09:30:28 -0500
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 23 Nov 2016 09:30:27 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 3/7] powerpc/mm/hugetlb: Handle hugepage size supported
 by hash config
In-Reply-To: <11917d34-3bb8-1d79-2753-ead02ebe7ce3@gmail.com>
References: <20161123111003.459-1-aneesh.kumar@linux.vnet.ibm.com>
 <20161123111003.459-3-aneesh.kumar@linux.vnet.ibm.com>
 <11917d34-3bb8-1d79-2753-ead02ebe7ce3@gmail.com>
Date: Wed, 23 Nov 2016 20:00:21 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87vavegtfm.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Balbir Singh <bsingharora@gmail.com> writes:

> On 23/11/16 22:09, Aneesh Kumar K.V wrote:
>> W.r.t hash page table config, we support 16MB and 16GB as the hugepage
>> size. Update the hstate_get_psize to handle 16M and 16G.
>> 
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/book3s/64/hugetlb.h | 4 ++++
>>  1 file changed, 4 insertions(+)
>> 
>> diff --git a/arch/powerpc/include/asm/book3s/64/hugetlb.h b/arch/powerpc/include/asm/book3s/64/hugetlb.h
>> index 499268045306..d9c283f95e05 100644
>> --- a/arch/powerpc/include/asm/book3s/64/hugetlb.h
>> +++ b/arch/powerpc/include/asm/book3s/64/hugetlb.h
>> @@ -21,6 +21,10 @@ static inline int hstate_get_psize(struct hstate *hstate)
>>  		return MMU_PAGE_2M;
>>  	else if (shift == mmu_psize_defs[MMU_PAGE_1G].shift)
>>  		return MMU_PAGE_1G;
>> +	else if (shift == mmu_psize_defs[MMU_PAGE_16M].shift)
>> +		return MMU_PAGE_16M;
>> +	else if (shift == mmu_psize_defs[MMU_PAGE_16G].shift)
>> +		return MMU_PAGE_16G;
>>  	else {
>>  		WARN(1, "Wrong huge page shift\n");
>>  		return mmu_virtual_psize;
>> 
>
> Is this related to this patch series? Radix can't do these sizes
>

The code returns the psize (the index value of the page size ) from hstate.
It doesn't make any verification. I added the hash details here because
this header is now suppose to contain generic functions not radix
specific one.

-aneesh
