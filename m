Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNF9j5Tl1zDvtQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 16:57:29 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAM5s16q013451
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 00:57:27 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26vb43tu91-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 00:57:27 -0500
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 21 Nov 2016 22:57:26 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 1/6] powerpc/mm: update ptep_set_access_flag to not do
 full mm tlb flush
In-Reply-To: <229327ef-bafe-75c5-79d9-2bece549ea38@gmail.com>
References: <20161121183322.14585-1-aneesh.kumar@linux.vnet.ibm.com>
 <229327ef-bafe-75c5-79d9-2bece549ea38@gmail.com>
Date: Tue, 22 Nov 2016 11:27:19 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87a8cshxa8.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Balbir Singh <bsingharora@gmail.com> writes:

> On 22/11/16 05:33, Aneesh Kumar K.V wrote:
>> When we are updating pte, we just need to flush the tlb mapping for
>> that pte. Right now we do a full mm flush because we don't track page
>> size. Update the interface to track the page size and use that to
>> do the right tlb flush.
>> 
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/book3s/32/pgtable.h |  4 +++-
>>  arch/powerpc/include/asm/book3s/64/pgtable.h |  7 +++++--
>>  arch/powerpc/include/asm/book3s/64/radix.h   | 14 +++++++-------
>>  arch/powerpc/include/asm/nohash/32/pgtable.h |  4 +++-
>>  arch/powerpc/include/asm/nohash/64/pgtable.h |  4 +++-
>>  arch/powerpc/mm/pgtable-book3s64.c           |  3 ++-
>>  arch/powerpc/mm/pgtable-radix.c              | 16 ++++++++++++++++
>>  arch/powerpc/mm/pgtable.c                    | 10 ++++++++--
>>  arch/powerpc/mm/tlb-radix.c                  | 15 ---------------
>>  9 files changed, 47 insertions(+), 30 deletions(-)
>> 
>> diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
>> index 6b8b2d57fdc8..0713626e9189 100644
>> --- a/arch/powerpc/include/asm/book3s/32/pgtable.h
>> +++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
>> @@ -224,7 +224,9 @@ static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
>>  
>>  
>>  static inline void __ptep_set_access_flags(struct mm_struct *mm,
>> -					   pte_t *ptep, pte_t entry)
>> +					   pte_t *ptep, pte_t entry,
>> +					   unsigned long address,
>> +					   unsigned long pg_sz)
>
> I wonder if the change can be limited in scope by passing the struct vma instead
> of struct mm as the first argument and not passing pg_sz (I don't like that
> name at all, page_size if we decide to do it, please). Then extract the mm from
> vma->mm
>

https://lkml.kernel.org/r/20161114152020.4608-1-aneesh.kumar@linux.vnet.ibm.com

That patch series go on top of this series. The idea of splitting this
into two is to make it easy to backport this series if needed to older
kernels.


-aneesh
