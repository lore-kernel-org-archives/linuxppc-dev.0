Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D69F1A060E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 05:44:31 +1000 (AEST)
Date: Wed, 20 May 2015 12:44:28 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH V5 2/3] powerpc/mm: Use generic version of pmdp_clear_flush
Message-Id: <20150520124428.9bab9007d7d589ec4b615ee6@linux-foundation.org>
In-Reply-To: <1431704550-19937-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1431704550-19937-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1431704550-19937-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: aarcange@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 paulus@samba.org, schwidefsky@de.ibm.com, linuxppc-dev@lists.ozlabs.org,
 kirill.shutemov@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 15 May 2015 21:12:29 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:

> Also move the pmd_trans_huge check to generic code.
> 
> ...
>
> --- a/include/asm-generic/pgtable.h
> +++ b/include/asm-generic/pgtable.h
> @@ -196,7 +196,12 @@ static inline pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
>  					unsigned long address,
>  					pmd_t *pmdp)
>  {
> -	return pmdp_clear_flush(vma, address, pmdp);
> +	pmd_t pmd;
> +	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
> +	VM_BUG_ON(pmd_trans_huge(*pmdp));
> +	pmd = pmdp_get_and_clear(vma->vm_mm, address, pmdp);
> +	flush_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
> +	return pmd;
>  }

x86_64 allmodconfig:

In file included from ./arch/x86/include/asm/pgtable.h:878,
                 from include/linux/mm.h:53,
                 from include/linux/suspend.h:8,
                 from arch/x86/kernel/asm-offsets.c:12:
include/asm-generic/pgtable.h: In function 'pmdp_collapse_flush':
include/asm-generic/pgtable.h:199: error: 'HPAGE_PMD_MASK' undeclared (first use in this function)
include/asm-generic/pgtable.h:199: error: (Each undeclared identifier is reported only once
include/asm-generic/pgtable.h:199: error: for each function it appears in.)
include/asm-generic/pgtable.h:202: error: implicit declaration of function 'flush_tlb_range'
include/asm-generic/pgtable.h:202: error: 'HPAGE_PMD_SIZE' undeclared (first use in this function)


Including linux/huge_mm.h doesn't work.  A suitable fix would be to
move this into a .c file.
