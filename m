Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xHMk74fB8zDqmS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 14:35:59 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6Q4XJW5053128
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 00:35:56 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bxev3mx6y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 00:35:56 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 26 Jul 2017 14:35:53 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6Q4ZpBc23593192
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 14:35:51 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6Q4Znog004729
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 14:35:50 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Diego Domingos <diegodo@linux.vnet.ibm.com>, linux-mm@kvack.org
Cc: ltc-interlock@lists.linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
 diegodo@linux.vnet.ibm.com
Subject: Re: [ltc-interlock] [PATCH] hugetlb: Fix hot remove for PowerVM
In-Reply-To: <1500997831-19173-1-git-send-email-diegodo@linux.vnet.ibm.com>
References: <1500997831-19173-1-git-send-email-diegodo@linux.vnet.ibm.com>
Date: Wed, 26 Jul 2017 10:05:42 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87r2x324td.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Diego Domingos <diegodo@linux.vnet.ibm.com> writes:

> PowerVM has support for 16G huge pages, so the function
> gigantic_page_supported needs to check if the running system
> is a pseries and check if there are some gigantic page
> registered. Then, we must return true - avoiding Segmentation
> Fault when hot removing memory sections within huge pages.

That is not correct. Those pages are not in zone/buddy. What
gigantic_page_supported checks is whether we can allocate pages runtime.
We scan the zones, check if we have the range that we are looking for
free for allocation, if so we do runtime allocation of those pages. This
may include page migration too. But these pages comes from buddy. We
don't do buddy allocator directly here, because the order of allocation
we are looking is more than max order.

>
> Signed-off-by: Diego Domingos <diegodo@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/hugetlb.h | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/hugetlb.h b/arch/powerpc/include/asm/book3s/64/hugetlb.h
> index 5c28bd6..49e43dd 100644
> --- a/arch/powerpc/include/asm/book3s/64/hugetlb.h
> +++ b/arch/powerpc/include/asm/book3s/64/hugetlb.h
> @@ -1,3 +1,5 @@
> +#include <asm/machdep.h>
> +
>  #ifndef _ASM_POWERPC_BOOK3S_64_HUGETLB_H
>  #define _ASM_POWERPC_BOOK3S_64_HUGETLB_H
>  /*
> @@ -54,9 +56,19 @@ static inline pte_t arch_make_huge_pte(pte_t entry, struct vm_area_struct *vma,
>  #ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
>  static inline bool gigantic_page_supported(void)
>  {
> +        struct hstate *h;
> +
>  	if (radix_enabled())
>  		return true;
> -	return false;
> +
> +        /* PowerVM can support 16GB hugepages (requested at boot time) */
> +        if(machine_is(pseries))
> +            for_each_hstate(h) {
> +                if (hstate_get_psize(h) == MMU_PAGE_16G)
> +                    return true;
> +            }
> +        
> +        return false;
>  }
>  #endif
>
> -- 
> 1.8.3.1
>
> _______________________________________________________
> ltc-interlock mailing list <ltc-interlock@lists.linux.ibm.com>
> To unsubscribe from the list, change your list options
> or if you have forgotten your list password visit:
> https://w3-01.ibm.com/stg/linux/ltc/mailinglists/listinfo/ltc-interlock
