Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D10601A09F5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Dec 2014 09:39:03 +1100 (AEDT)
Message-ID: <1417473519.7182.6.camel@kernel.crashing.org>
Subject: Re: [PATCH 02/10] mm: Add p[te|md] protnone helpers for use by NUMA
 balancing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mel Gorman <mgorman@suse.de>
Date: Tue, 02 Dec 2014 09:38:39 +1100
In-Reply-To: <1416578268-19597-3-git-send-email-mgorman@suse.de>
References: <1416578268-19597-1-git-send-email-mgorman@suse.de>
 <1416578268-19597-3-git-send-email-mgorman@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Rik van Riel <riel@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Hugh Dickins <hughd@google.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
 Sasha Levin <sasha.levin@oracle.com>, Dave Jones <davej@redhat.com>,
 LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>,
 Kirill Shutemov <kirill.shutemov@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-11-21 at 13:57 +0000, Mel Gorman wrote:

>  #ifdef CONFIG_NUMA_BALANCING
> +/*
> + * These work without NUMA balancing but the kernel does not care. See the
> + * comment in include/asm-generic/pgtable.h
> + */
> +static inline int pte_protnone(pte_t pte)
> +{
> +	return (pte_val(pte) &
> +		(_PAGE_PRESENT | _PAGE_USER)) == _PAGE_PRESENT;
> +}

I would add a comment clarifying that this only works for user pages,
ie, this accessor will always return "true" for a kernel page on ppc.

> +static inline int pmd_protnone(pmd_t pmd)
> +{
> +	return pte_protnone(pmd_pte(pmd));
> +}
> +
>  static inline int pte_present(pte_t pte)
>  {
>  	return pte_val(pte) & _PAGE_NUMA_MASK;
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index 081d6f4..2e25780 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -502,6 +502,22 @@ static inline int pmd_present(pmd_t pmd)
>  				 _PAGE_NUMA);
>  }
>  
> +#ifdef CONFIG_NUMA_BALANCING
> +/*
> + * These work without NUMA balancing but the kernel does not care. See the
> + * comment in include/asm-generic/pgtable.h
> + */
> +static inline int pte_protnone(pte_t pte)
> +{
> +	return pte_flags(pte) & _PAGE_PROTNONE;
> +}
> +
> +static inline int pmd_protnone(pmd_t pmd)
> +{
> +	return pmd_flags(pmd) & _PAGE_PROTNONE;
> +}
> +#endif /* CONFIG_NUMA_BALANCING */
> +
>  static inline int pmd_none(pmd_t pmd)
>  {
>  	/* Only check low word on 32-bit platforms, since it might be
> diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
> index 177d597..d497d08 100644
> --- a/include/asm-generic/pgtable.h
> +++ b/include/asm-generic/pgtable.h
> @@ -688,6 +688,26 @@ static inline int pmd_trans_unstable(pmd_t *pmd)
>  #endif
>  }
>  
> +#ifndef CONFIG_NUMA_BALANCING
> +/*
> + * Technically a PTE can be PROTNONE even when not doing NUMA balancing but
> + * the only case the kernel cares is for NUMA balancing and is only ever set
> + * when the VMA is accessible. For PROT_NONE VMAs, the PTEs are not marked
> + * _PAGE_PROTNONE so by by default, implement the helper as "always no". It
> + * is the responsibility of the caller to distinguish between PROT_NONE
> + * protections and NUMA hinting fault protections.
> + */
> +static inline int pte_protnone(pte_t pte)
> +{
> +	return 0;
> +}
> +
> +static inline int pmd_protnone(pmd_t pmd)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_NUMA_BALANCING */
> +
>  #ifdef CONFIG_NUMA_BALANCING
>  /*
>   * _PAGE_NUMA distinguishes between an unmapped page table entry, an entry that
