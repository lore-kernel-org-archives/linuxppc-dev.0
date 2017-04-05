Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vyZN774kwzDqH6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Apr 2017 15:36:55 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v355YJZ9129850
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Apr 2017 01:36:52 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29mc5kd3ka-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Apr 2017 01:36:52 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 5 Apr 2017 15:36:50 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v355aeiM45154384
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Apr 2017 15:36:48 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v355aFWw022044
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Apr 2017 15:36:16 +1000
Subject: Re: [RFC PATCH] powerpc/mm/hugetlb: Add support for 1G huge pages
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1491314625-15307-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Wed, 5 Apr 2017 11:05:57 +0530
MIME-Version: 1.0
In-Reply-To: <1491314625-15307-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <d0f14ff7-fce7-e39d-d921-14485aef2ead@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/04/2017 07:33 PM, Aneesh Kumar K.V wrote:
> This patch adds support for gigantic pages in ppc64. We also updates
> gigantic_page_supported helper such that arch can override it.

Seems like only radix based 1GB is considered as gigantic page in this
implementation. What about the existing 16GB pages support ? IIUC they
are still supported currently as gigantic pages (as defined in generic
HugeTLB) if the platform gives us reserved memory areas during boot.
Can you explain how this is going to be different ?

> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/hugetlb.h | 9 +++++++++
>  arch/powerpc/mm/hugetlbpage.c                | 7 +++++--
>  arch/powerpc/platforms/Kconfig.cputype       | 1 +
>  mm/hugetlb.c                                 | 4 ++++
>  4 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/hugetlb.h b/arch/powerpc/include/asm/book3s/64/hugetlb.h
> index 6666cd366596..a994d069fdaf 100644
> --- a/arch/powerpc/include/asm/book3s/64/hugetlb.h
> +++ b/arch/powerpc/include/asm/book3s/64/hugetlb.h
> @@ -50,4 +50,13 @@ static inline pte_t arch_make_huge_pte(pte_t entry, struct vm_area_struct *vma,
>  	else
>  		return entry;
>  }
> +
> +#define gigantic_page_supported gigantic_page_supported
> +static inline bool gigantic_page_supported(void)
> +{
> +	if (radix_enabled())
> +		return true;
> +	return false;
> +}

POWER8 (non radix MMU) cannot have 16GB gigantic HugeTLB pages ?

> +
>  #endif
> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
> index a4f33de4008e..80f6d2ed551a 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -763,8 +763,11 @@ static int __init add_huge_page_size(unsigned long long size)
>  	 * Hash: 16M and 16G
>  	 */
>  	if (radix_enabled()) {
> -		if (mmu_psize != MMU_PAGE_2M)
> -			return -EINVAL;
> +		if (mmu_psize != MMU_PAGE_2M) {
> +			if (cpu_has_feature(CPU_FTR_POWER9_DD1) ||
> +			    (mmu_psize != MMU_PAGE_1G))
> +				return -EINVAL;
> +		}

The comment above this code block needs to be updated as well for
this new page size addition. I understand that this code block
was added to protect against wrong device tree supplied page size
values but wondering dont we require one such check for normal page
sizes as well (non HugeTLB) ? But anyways, thats a different topic.
