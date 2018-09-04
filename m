Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4249wB70FRzF3CC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Sep 2018 12:37:14 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w842TbLg027671
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Sep 2018 22:37:07 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2m97x4hc04-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Sep 2018 22:37:07 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Mon, 3 Sep 2018 22:37:06 -0400
Subject: Re: [RFC PATCH 0/3] Add support for compound page migration in
 mm_iommu_get
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, David Gibson <david@gibson.dropbear.id.au>,
 Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org
References: <20180903163733.27965-1-aneesh.kumar@linux.ibm.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Tue, 4 Sep 2018 08:06:52 +0530
MIME-Version: 1.0
In-Reply-To: <20180903163733.27965-1-aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <9b0dd963-2231-3da9-302a-f9f7c66f4175@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/03/2018 10:07 PM, Aneesh Kumar K.V wrote:
> This patch series add support for migrating compound pages if we find them in the
> CMA area before taking long term page reference for VFIO.

We now call lru_add_drain_all instead of lru_add_drain() which means we 
now have higher chances of isolate_lru_page succeeding. The patch also 
migrate all the pages in one call, instead of one page at a time.


> 
> Testing:
> * TODO: test with hugetlb backed guest ram.
> * Testing done with a code change as below
> 
> -		if (is_migrate_cma_page(pages[i]) && migrate_allow) {
> +		if (migrate_allow) {
> 
> ...
> +	migrate_allow = false;
> 
> 
> Aneesh Kumar K.V (3):
>    mm: Export alloc_migrate_huge_page
>    powerpc/mm/iommu: Allow large IOMMU page size only for hugetlb backing
>    powerpc/mm/iommu: Allow migration of cma allocated pages during
>      mm_iommu_get
> 
>   arch/powerpc/mm/mmu_context_iommu.c | 209 +++++++++++++++++-----------
>   include/linux/hugetlb.h             |   2 +
>   mm/hugetlb.c                        |   4 +-
>   3 files changed, 128 insertions(+), 87 deletions(-)
> 
