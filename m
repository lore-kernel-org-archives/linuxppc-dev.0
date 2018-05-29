Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40vxy232mxzDqGD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 12:10:01 +1000 (AEST)
Received: by mail-pl0-x241.google.com with SMTP id bi12-v6so8024912plb.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 May 2018 19:10:01 -0700 (PDT)
Date: Tue, 29 May 2018 12:09:50 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm/hugetlb: Use the correct page size when
 flushing hugepage tlb
Message-ID: <20180529120950.547e3a6c@roar.ozlabs.ibm.com>
In-Reply-To: <87y3g3454r.fsf@concordia.ellerman.id.au>
References: <20180522091209.9084-1-aneesh.kumar@linux.ibm.com>
 <87y3g3454r.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 29 May 2018 11:33:56 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> 
> > We used wrong page size (mmu_virtual_psize) when doing a tlbflush after
> > pte update. This patch update the flush to use hugetlb page size.
> > The page size is derived from hugetlb hstate.  
> 
> This sounds bad. Or is it not for some reason?

It's not all that bad because the flush is mostly superfluous (one of
my tlbie optimisation patches gets rid of it except for accelerators).

> 
> Either way a Fixes tag would be nice. Maybe:
> 
>   Fixes: b3603e174fc8 ("powerpc/mm: update radix__ptep_set_access_flag to not do full mm tlb flush")
> 
> I think this is only a problem on Radix, but the change log doesn't say.

huge_ptep_set_access_flags->ptep_set_access_flags->flush_tlb_page->

void radix__flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
{
#ifdef CONFIG_HUGETLB_PAGE
        if (is_vm_hugetlb_page(vma))
                return radix__flush_hugetlb_page(vma, vmaddr);
#endif
        radix__flush_tlb_page_psize(vma->vm_mm, vmaddr, mmu_virtual_psize);
}

So I'm still not sure how the size is going wrong here. What am I
missig?

Thanks,
Nick
