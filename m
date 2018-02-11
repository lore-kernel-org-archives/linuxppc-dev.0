Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zfk3V0SHJzF0j3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 09:28:37 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1BMNfmZ069243
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Feb 2018 17:28:35 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g2eqcv745-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Feb 2018 17:28:35 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Sun, 11 Feb 2018 22:28:33 -0000
Date: Sun, 11 Feb 2018 14:28:25 -0800
From: Ram Pai <linuxram@us.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V2 2/4] powerpc/mm/hash64: Allocate larger PMD table if
 hugetlb config is enabled.
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20180211150009.21297-1-aneesh.kumar@linux.vnet.ibm.com>
 <20180211150009.21297-2-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180211150009.21297-2-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20180211222825.GE5559@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Feb 11, 2018 at 08:30:07PM +0530, Aneesh Kumar K.V wrote:
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/hash-64k.h | 2 +-
>  arch/powerpc/include/asm/book3s/64/hash.h     | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> index c08b3b032ec0..ee440fb3d240 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> @@ -140,7 +140,7 @@ static inline int hash__remap_4k_pfn(struct vm_area_struct *vma, unsigned long a
>  }
> 
>  #define H_PTE_TABLE_SIZE	PTE_FRAG_SIZE
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +#if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined (CONFIG_HUGETLB_PAGE)
>  #define H_PMD_TABLE_SIZE	((sizeof(pmd_t) << PMD_INDEX_SIZE) + \
>  				 (sizeof(unsigned long) << PMD_INDEX_SIZE))
>  #else
> diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
> index 234f141fb151..0851c328bea6 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash.h
> @@ -23,7 +23,8 @@
>  				 H_PUD_INDEX_SIZE + H_PGD_INDEX_SIZE + PAGE_SHIFT)
>  #define H_PGTABLE_RANGE		(ASM_CONST(1) << H_PGTABLE_EADDR_SIZE)
> 
> -#if defined(CONFIG_TRANSPARENT_HUGEPAGE) &&  defined(CONFIG_PPC_64K_PAGES)
> +#if (defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLB_PAGE)) && \
> +	defined(CONFIG_PPC_64K_PAGES)
>  /*
>   * only with hash 64k we need to use the second half of pmd page table
>   * to store pointer to deposited pgtable_t

A small nitpick.  the definition of  H_PMD_CACHE_INDEX and
H_PUD_CACHE_INDEX (introduced in the previous patch)
can be nested under #ifdef CONFIG_PPC_64K_PAGES


Reviewed-by: Ram Pai <linuxram@us.ibm.com>
