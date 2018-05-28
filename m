Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40vWHp6S5kzF0mQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 May 2018 19:08:54 +1000 (AEST)
Received: by mail-pl0-x242.google.com with SMTP id u6-v6so6871875pls.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 May 2018 02:08:54 -0700 (PDT)
Date: Mon, 28 May 2018 19:08:43 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm/hugetlb: Use the correct page size when
 flushing hugepage tlb
Message-ID: <20180528190843.3cef2676@roar.ozlabs.ibm.com>
In-Reply-To: <20180522091209.9084-1-aneesh.kumar@linux.ibm.com>
References: <20180522091209.9084-1-aneesh.kumar@linux.ibm.com>
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

On Tue, 22 May 2018 14:42:09 +0530
"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:

> We used wrong page size (mmu_virtual_psize) when doing a tlbflush after
> pte update. This patch update the flush to use hugetlb page size.
> The page size is derived from hugetlb hstate.
> 
> Now that ptep_set_access_flags won't be called for hugetlb remove
> the is_vm_hugetlb_page() check and add the assert of pte lock
> unconditionally.

radix__flush_tlb_page seems to check for a hugepage vma and flush the
right page size in that case. So is there a case where the flush size
actually goes wrong?

I do think if we could make hugetlb flushing always use
flush_hugetlb_page version and take the test out of flush_tlb_page I
think that would be nicer code (I haven't checked if that's feasible
after this patch), but that wouldn't be a bug-fix.

Thanks,
Nick
