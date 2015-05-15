Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E0BD71A042B
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 May 2015 01:54:49 +1000 (AEST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 15 May 2015 21:24:47 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 7DDAAE0057
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 21:27:46 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4FFsjcX53084378
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 21:24:46 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4FFshnF017655
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 21:24:45 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: akpm@linux-foundation.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, kirill.shutemov@linux.intel.com,
 aarcange@redhat.com, schwidefsky@de.ibm.com
Subject: Re: [PATCH V5 1/3] mm/thp: Split out pmd collpase flush into a
 separate functions
In-Reply-To: <1431704550-19937-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1431704550-19937-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1431704550-19937-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Fri, 15 May 2015 21:24:43 +0530
Message-ID: <871tihn8e4.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


 diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
> index 39f1d6a2b04d..acdcaac77d93 100644
> --- a/include/asm-generic/pgtable.h
> +++ b/include/asm-generic/pgtable.h
> @@ -189,6 +189,28 @@ extern void pmdp_splitting_flush(struct vm_area_struct *vma,
>  				 unsigned long address, pmd_t *pmdp);
>  #endif
>
> +#ifndef pmdp_collapse_flush
> +#define pmdp_collapse_flush pmdp_collapse_flush
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +static inline pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
> +					unsigned long address,
> +					pmd_t *pmdp)


extra pmdp_collapse_flush #define here

> +{
> +	return pmdp_clear_flush(vma, address, pmdp);
> +}
> +#define pmdp_collapse_flush pmdp_collapse_flush
> +#else
> +static inline pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
> +					unsigned long address,
> +					pmd_t *pmdp)
> +{
> +	BUILD_BUG();
> +	return *pmdp;
> +}
> +#define pmdp_collapse_flush pmdp_collapse_flush
> +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> +#endif
> +
>  #ifndef __HAVE_ARCH_PGTABLE_DEPOSIT
>  extern void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
>  				       pgtable_t pgtable);

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index acdcaac77d93..2c3ca89e9aee 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -190,7 +190,6 @@ extern void pmdp_splitting_flush(struct vm_area_struct *vma,
 #endif
 
 #ifndef pmdp_collapse_flush
-#define pmdp_collapse_flush pmdp_collapse_flush
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static inline pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
 					unsigned long address,
