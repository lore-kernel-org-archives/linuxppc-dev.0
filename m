Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ttYzV18ClzDqGS
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2017 13:04:52 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v04242mN091188
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Jan 2017 21:04:50 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27rktsyt96-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Jan 2017 21:04:50 -0500
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 3 Jan 2017 19:04:50 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 Scott Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: fix pgtable pmd cache init
In-Reply-To: <20170103155517.24347-1-npiggin@gmail.com>
References: <20170103155517.24347-1-npiggin@gmail.com>
Date: Wed, 04 Jan 2017 07:34:41 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87eg0j7f7q.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> Commit 9b081e10805cd ("powerpc: port 64 bits pgtable_cache to 32 bits")
> mixed up PMD_INDEX_SIZE and PMD_CACHE_INDEX a couple of times. This
> resulted in 64s/hash/4k configs to panic at boot with a false positive
> error check.
>
> Fix that and simplify error handling by moving the check to the caller.
>
> Fixes: 9b081e10805cd ("powerpc: port 64 bits pgtable_cache to 32 bits")
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Cc: Scott Wood <oss@buserror.net>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

I did another fix here.

https://lkml.kernel.org/r/20161214043349.23677-1-aneesh.kumar@linux.vnet.ibm.com

But this patch makes it much simpler. Hence.

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

There is this hunk in the patch I did.

--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -33,9 +33,9 @@
				 H_PUD_INDEX_SIZE + H_PGD_INDEX_SIZE + PAGE_SHIFT)
 #define H_PGTABLE_RANGE		(ASM_CONST(1) << H_PGTABLE_EADDR_SIZE)

-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE) &&  defined(CONFIG_PPC_64K_PAGES)
 /*
- * only with hash we need to use the second half of pmd page table
+ * only with hash 64k we need to use the second half of pmd page table
  * to store pointer to deposited pgtable_t
  */
 #define H_PMD_CACHE_INDEX	(H_PMD_INDEX_SIZE + 1)

> ---
>  arch/powerpc/mm/hugetlbpage.c |  6 +-----
>  arch/powerpc/mm/init-common.c | 11 +++--------
>  2 files changed, 4 insertions(+), 13 deletions(-)
>
> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
> index 289df38fb7e0..f21f6b907d99 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -810,12 +810,8 @@ static int __init hugetlbpage_init(void)
>  		 * if we have pdshift and shift value same, we don't
>  		 * use pgt cache for hugepd.
>  		 */
> -		if (pdshift > shift) {
> +		if (pdshift > shift)
>  			pgtable_cache_add(pdshift - shift, NULL);
> -			if (!PGT_CACHE(pdshift - shift))
> -				panic("hugetlbpage_init(): could not create "
> -				      "pgtable cache for %d bit pagesize\n", shift);
> -		}
>  #if defined(CONFIG_PPC_FSL_BOOK3E) || defined(CONFIG_PPC_8xx)
>  		else if (!hugepte_cache) {
>  			/*
> diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.c
> index a175cd82ae8c..1a3be5ae1d07 100644
> --- a/arch/powerpc/mm/init-common.c
> +++ b/arch/powerpc/mm/init-common.c
> @@ -80,6 +80,8 @@ void pgtable_cache_add(unsigned shift, void (*ctor)(void *))
>  	new = kmem_cache_create(name, table_size, align, 0, ctor);
>  	kfree(name);
>  	pgtable_cache[shift - 1] = new;
> +	if (!new)
> +		panic("Could not allocate pgtable cache for order %d", shift);
>  	pr_debug("Allocated pgtable cache for order %d\n", shift);
>  }
>
> @@ -88,7 +90,7 @@ void pgtable_cache_init(void)
>  {
>  	pgtable_cache_add(PGD_INDEX_SIZE, pgd_ctor);
>
> -	if (PMD_INDEX_SIZE && !PGT_CACHE(PMD_INDEX_SIZE))
> +	if (PMD_CACHE_INDEX && !PGT_CACHE(PMD_CACHE_INDEX))
>  		pgtable_cache_add(PMD_CACHE_INDEX, pmd_ctor);
>  	/*
>  	 * In all current configs, when the PUD index exists it's the
> @@ -97,11 +99,4 @@ void pgtable_cache_init(void)
>  	 */
>  	if (PUD_INDEX_SIZE && !PGT_CACHE(PUD_INDEX_SIZE))
>  		pgtable_cache_add(PUD_INDEX_SIZE, pud_ctor);
> -
> -	if (!PGT_CACHE(PGD_INDEX_SIZE))
> -		panic("Couldn't allocate pgd cache");
> -	if (PMD_INDEX_SIZE && !PGT_CACHE(PMD_INDEX_SIZE))
> -		panic("Couldn't allocate pmd pgtable caches");
> -	if (PUD_INDEX_SIZE && !PGT_CACHE(PUD_INDEX_SIZE))
> -		panic("Couldn't allocate pud pgtable caches");
>  }
> -- 
> 2.11.0
