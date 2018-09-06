Return-Path: <mhocko@kernel.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 425gVw4D3mzF3S1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2018 22:54:00 +1000 (AEST)
Date: Thu, 6 Sep 2018 14:53:56 +0200
From: Michal Hocko <mhocko@kernel.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: akpm@linux-foundation.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 mpe@ellerman.id.au, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH V2 4/4] powerpc/mm/iommu: Allow migration of cma
 allocated pages during mm_iommu_get
Message-ID: <20180906125356.GX14951@dhcp22.suse.cz>
References: <20180906054342.25094-1-aneesh.kumar@linux.ibm.com>
 <20180906054342.25094-4-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180906054342.25094-4-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu 06-09-18 11:13:42, Aneesh Kumar K.V wrote:
> Current code doesn't do page migration if the page allocated is a compound page.
> With HugeTLB migration support, we can end up allocating hugetlb pages from
> CMA region. Also THP pages can be allocated from CMA region. This patch updates
> the code to handle compound pages correctly.
> 
> This use the new helper get_user_pages_cma_migrate. It does one get_user_pages
> with right count, instead of doing one get_user_pages per page. That avoids
> reading page table multiple times.
> 
> The patch also convert the hpas member of mm_iommu_table_group_mem_t to a union.
> We use the same storage location to store pointers to struct page. We cannot
> update alll the code path use struct page *, because we access hpas in real mode
> and we can't do that struct page * to pfn conversion in real mode.

I am not fmailiar with this code so bear with me. I am completely
missing the purpose of this patch. The changelog doesn't really explain
that AFAICS. I can only guess that you do not want to establish long
pins on CMA pages, right? So whenever you are about to pin a page that
is in CMA you migrate it away to a different !__GFP_MOVABLE page, right?
If that is the case then how do you handle pins which are already in
zone_movable? I do not see any specific check for those.

Btw. why is this a proper thing to do? Problems with longterm pins are
not only for CMA/ZONE_MOVABLE pages. Pinned pages are not reclaimable as
well so there is a risk of OOMs if there are too many of them. We have
discussed approaches that would allow to force pin invalidation/revocation
at LSF/MM. Isn't that a more appropriate solution to the problem you are
seeing?
-- 
Michal Hocko
SUSE Labs
