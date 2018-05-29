Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40vybV6x0vzDqGD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 12:39:02 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4T2Xdb7133114
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 May 2018 22:39:00 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j8sr2quqy-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 May 2018 22:38:59 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Mon, 28 May 2018 22:38:59 -0400
Subject: Re: [PATCH] powerpc/mm/hugetlb: Use the correct page size when
 flushing hugepage tlb
To: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>
Cc: benh@kernel.crashing.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
References: <20180522091209.9084-1-aneesh.kumar@linux.ibm.com>
 <87y3g3454r.fsf@concordia.ellerman.id.au>
 <20180529120950.547e3a6c@roar.ozlabs.ibm.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Tue, 29 May 2018 08:08:51 +0530
MIME-Version: 1.0
In-Reply-To: <20180529120950.547e3a6c@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <174eab41-efb6-20f5-f1a1-aa2fb362f5bb@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/29/2018 07:39 AM, Nicholas Piggin wrote:
> On Tue, 29 May 2018 11:33:56 +1000
> Michael Ellerman <mpe@ellerman.id.au> wrote:
> 
>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>>
>>> We used wrong page size (mmu_virtual_psize) when doing a tlbflush after
>>> pte update. This patch update the flush to use hugetlb page size.
>>> The page size is derived from hugetlb hstate.
>>
>> This sounds bad. Or is it not for some reason?
> 
> It's not all that bad because the flush is mostly superfluous (one of
> my tlbie optimisation patches gets rid of it except for accelerators).
> 
>>
>> Either way a Fixes tag would be nice. Maybe:
>>
>>    Fixes: b3603e174fc8 ("powerpc/mm: update radix__ptep_set_access_flag to not do full mm tlb flush")
>>
>> I think this is only a problem on Radix, but the change log doesn't say.
> 
> huge_ptep_set_access_flags->ptep_set_access_flags->flush_tlb_page->
> 
> void radix__flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
> {
> #ifdef CONFIG_HUGETLB_PAGE
>          if (is_vm_hugetlb_page(vma))
>                  return radix__flush_hugetlb_page(vma, vmaddr);
> #endif
>          radix__flush_tlb_page_psize(vma->vm_mm, vmaddr, mmu_virtual_psize);
> }
> 
> So I'm still not sure how the size is going wrong here. What am I
> missig?
> 

My mistake, I didn't look at the radix expansion. I was looking at 
huge_ptep_clear_flush() where we use flush_hugetlb_page().

-aneesh
