Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wT4dr0J7nzDqK1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 May 2017 18:50:39 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4I8ccxe145809
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 May 2017 04:50:32 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2agsckc0vt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 May 2017 04:50:32 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 18 May 2017 04:50:32 -0400
Subject: Re: [PATCH v3 2/2] powerpc/mm/hugetlb: Add support for 1G huge pages
To: Michael Ellerman <mpe@ellerman.id.au>, akpm@linux-foundation.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <1494995292-4443-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1494995292-4443-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <87fug2loze.fsf@concordia.ellerman.id.au>
 <852b601c-a044-0445-e97d-d17d76ec1154@linux.vnet.ibm.com>
 <877f1elfga.fsf@concordia.ellerman.id.au>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 18 May 2017 14:20:24 +0530
MIME-Version: 1.0
In-Reply-To: <877f1elfga.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <cbaa3bca-64a6-d18d-381c-55e137782f5f@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Thursday 18 May 2017 02:17 PM, Michael Ellerman wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
> 
>> On Thursday 18 May 2017 10:51 AM, Michael Ellerman wrote:
>>> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
>>>
>>>> POWER9 supports hugepages of size 2M and 1G in radix MMU mode. This patch
>>>> enables the usage of 1G page size for hugetlbfs. This also update the helper
>>>> such we can do 1G page allocation at runtime.
>>>>
>>>> We still don't enable 1G page size on DD1 version. This is to avoid doing
>>>> workaround mentioned in commit: 6d3a0379ebdc8 (powerpc/mm: Add
>>>> radix__tlb_flush_pte_p9_dd1()
>>>>
>>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>>>> ---
>>>>    arch/powerpc/include/asm/book3s/64/hugetlb.h | 10 ++++++++++
>>>>    arch/powerpc/mm/hugetlbpage.c                |  7 +++++--
>>>>    arch/powerpc/platforms/Kconfig.cputype       |  1 +
>>>>    3 files changed, 16 insertions(+), 2 deletions(-)
>>>
>>> I think this patch is OK, but it's very confusing because it doesn't
>>> mention that it's only talking about *generic* gigantic page support.
>>
>> What you mean by generic gigantic page ? what is supported here is the
>> gigantic page with size 1G alone ?
> 
> What about 16G pages on pseries.
> 
> And all the other gigantic page sizes that Book3E supports?
> 

None of that is supported w.r.t runtime allocation of hugepages. ie, we 
cannot echo nr_hugepages w.r.t them.  For 16GB i am not sure it make 
sense, because we will rarely get such large contiguous region. W.r.t 
page size supported for Book3E, may be we can. But I don't have a 
facility to test those. Hence didn't include that.

-aneesh
