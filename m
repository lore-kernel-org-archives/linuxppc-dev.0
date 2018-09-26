Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Kj2j5lKXzF3KF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 12:44:45 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8Q2dRtR035908
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 22:44:44 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mqvmgtkxr-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 22:44:43 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 26 Sep 2018 03:44:41 +0100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 17/22] powerpc/mm: Move pgtable_t into platform headers
In-Reply-To: <2a231be613ff9763f50acc10dea1175675db3ad1.1537892499.git.christophe.leroy@c-s.fr>
References: <cover.1537892498.git.christophe.leroy@c-s.fr>
 <2a231be613ff9763f50acc10dea1175675db3ad1.1537892499.git.christophe.leroy@c-s.fr>
Date: Wed, 26 Sep 2018 08:14:34 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87lg7pgep9.fsf@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> This patch move pgtable_t into platform headers.
>
> It gets rid of the CONFIG_PPC_64K_PAGES case for PPC64
> as nohash/64 doesn't support CONFIG_PPC_64K_PAGES.
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/include/asm/book3s/32/mmu-hash.h |  2 ++
>  arch/powerpc/include/asm/book3s/64/mmu.h      |  9 +++++++++
>  arch/powerpc/include/asm/nohash/32/mmu.h      |  4 ++++
>  arch/powerpc/include/asm/nohash/64/mmu.h      |  4 ++++
>  arch/powerpc/include/asm/page.h               | 14 --------------
>  5 files changed, 19 insertions(+), 14 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/32/mmu-hash.h b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
> index e38c91388c40..5bd26c218b94 100644
> --- a/arch/powerpc/include/asm/book3s/32/mmu-hash.h
> +++ b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
> @@ -42,6 +42,8 @@ struct ppc_bat {
>  	u32 batu;
>  	u32 batl;
>  };
> +
> +typedef struct page *pgtable_t;
>  #endif /* !__ASSEMBLY__ */
>  
>  /*
> diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
> index 9c8c669a6b6a..488e7ed07e96 100644
> --- a/arch/powerpc/include/asm/book3s/64/mmu.h
> +++ b/arch/powerpc/include/asm/book3s/64/mmu.h
> @@ -2,6 +2,8 @@
>  #ifndef _ASM_POWERPC_BOOK3S_64_MMU_H_
>  #define _ASM_POWERPC_BOOK3S_64_MMU_H_
>  
> +#include <asm/page.h>
> +
>  #ifndef __ASSEMBLY__
>  /*
>   * Page size definition
> @@ -24,6 +26,13 @@ struct mmu_psize_def {
>  };
>  extern struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT];
>  
> +/*
> + * For BOOK3s 64 with 4k and 64K linux page size
> + * we want to use pointers, because the page table
> + * actually store pfn
> + */
> +typedef pte_t *pgtable_t;
> +
>  #endif /* __ASSEMBLY__ */
>  
>  /* 64-bit classic hash table MMU */
> diff --git a/arch/powerpc/include/asm/nohash/32/mmu.h b/arch/powerpc/include/asm/nohash/32/mmu.h
> index af0e8b54876a..f61f933a4cd8 100644
> --- a/arch/powerpc/include/asm/nohash/32/mmu.h
> +++ b/arch/powerpc/include/asm/nohash/32/mmu.h
> @@ -16,4 +16,8 @@
>  #include <asm/nohash/32/mmu-8xx.h>
>  #endif
>  
> +#ifndef __ASSEMBLY__
> +typedef struct page *pgtable_t;
> +#endif
> +
>  #endif /* _ASM_POWERPC_NOHASH_32_MMU_H_ */
> diff --git a/arch/powerpc/include/asm/nohash/64/mmu.h b/arch/powerpc/include/asm/nohash/64/mmu.h
> index 87871d027b75..e6585480dfc4 100644
> --- a/arch/powerpc/include/asm/nohash/64/mmu.h
> +++ b/arch/powerpc/include/asm/nohash/64/mmu.h
> @@ -5,4 +5,8 @@
>  /* Freescale Book-E software loaded TLB or Book-3e (ISA 2.06+) MMU */
>  #include <asm/nohash/mmu-book3e.h>
>  
> +#ifndef __ASSEMBLY__
> +typedef struct page *pgtable_t;
> +#endif
> +
>  #endif /* _ASM_POWERPC_NOHASH_64_MMU_H_ */
> diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
> index f6a1265face2..ddfb4b965e5b 100644
> --- a/arch/powerpc/include/asm/page.h
> +++ b/arch/powerpc/include/asm/page.h
> @@ -335,20 +335,6 @@ void arch_free_page(struct page *page, int order);
>  #endif
>  
>  struct vm_area_struct;
> -#ifdef CONFIG_PPC_BOOK3S_64
> -/*
> - * For BOOK3s 64 with 4k and 64K linux page size
> - * we want to use pointers, because the page table
> - * actually store pfn
> - */
> -typedef pte_t *pgtable_t;
> -#else
> -#if defined(CONFIG_PPC_64K_PAGES) && defined(CONFIG_PPC64)
> -typedef pte_t *pgtable_t;
> -#else
> -typedef struct page *pgtable_t;
> -#endif
> -#endif
>  
>  #include <asm-generic/memory_model.h>
>  #endif /* __ASSEMBLY__ */
> -- 
> 2.13.3
