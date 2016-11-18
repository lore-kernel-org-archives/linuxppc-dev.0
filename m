Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKy8S6KsdzDw2b
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 23:33:28 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/4] powerpc/mm: Rename hugetlb-radix.h to hugetlb.h
In-Reply-To: <20161114151128.2146-2-aneesh.kumar@linux.vnet.ibm.com>
References: <20161114151128.2146-1-aneesh.kumar@linux.vnet.ibm.com>
 <20161114151128.2146-2-aneesh.kumar@linux.vnet.ibm.com>
Date: Fri, 18 Nov 2016 23:33:27 +1100
Message-ID: <874m350xyg.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> We will start moving some book3s specific hugetlb functions there.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/{hugetlb-radix.h => hugetlb.h} | 8 ++++++--
>  arch/powerpc/include/asm/hugetlb.h                                | 2 +-
>  2 files changed, 7 insertions(+), 3 deletions(-)
>  rename arch/powerpc/include/asm/book3s/64/{hugetlb-radix.h => hugetlb.h} (78%)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/hugetlb-radix.h b/arch/powerpc/include/asm/book3s/64/hugetlb.h
> similarity index 78%
> rename from arch/powerpc/include/asm/book3s/64/hugetlb-radix.h
> rename to arch/powerpc/include/asm/book3s/64/hugetlb.h
> index c45189aa7476..d9c283f95e05 100644
> --- a/arch/powerpc/include/asm/book3s/64/hugetlb-radix.h
> +++ b/arch/powerpc/include/asm/book3s/64/hugetlb.h
> @@ -1,5 +1,5 @@
> -#ifndef _ASM_POWERPC_BOOK3S_64_HUGETLB_RADIX_H
> -#define _ASM_POWERPC_BOOK3S_64_HUGETLB_RADIX_H
> +#ifndef _ASM_POWERPC_BOOK3S_64_HUGETLB_H
> +#define _ASM_POWERPC_BOOK3S_64_HUGETLB_H
>  /*
>   * For radix we want generic code to handle hugetlb. But then if we want
>   * both hash and radix to be enabled together we need to workaround the
> @@ -21,6 +21,10 @@ static inline int hstate_get_psize(struct hstate *hstate)
>  		return MMU_PAGE_2M;
>  	else if (shift == mmu_psize_defs[MMU_PAGE_1G].shift)
>  		return MMU_PAGE_1G;
> +	else if (shift == mmu_psize_defs[MMU_PAGE_16M].shift)
> +		return MMU_PAGE_16M;
> +	else if (shift == mmu_psize_defs[MMU_PAGE_16G].shift)
> +		return MMU_PAGE_16G;

That's not just a rename?

cheers
