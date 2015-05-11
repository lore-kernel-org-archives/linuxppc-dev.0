Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DC3B61A0010
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 08:40:19 +1000 (AEST)
Date: Mon, 11 May 2015 15:40:15 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH V3] mm/thp: Split out pmd collpase flush into a separate
 functions
Message-Id: <20150511154015.956459466f1ca96fc84723b7@linux-foundation.org>
In-Reply-To: <1431326370-24247-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1431326370-24247-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: aarcange@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 kirill.shutemov@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 11 May 2015 12:09:30 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:

> Architectures like ppc64 [1] need to do special things while clearing
> pmd before a collapse. For them this operation is largely different
> from a normal hugepage pte clear. Hence add a separate function
> to clear pmd before collapse. After this patch pmdp_* functions
> operate only on hugepage pte, and not on regular pmd_t values
> pointing to page table.
> 
> [1] ppc64 needs to invalidate all the normal page pte mappings we
> already have inserted in the hardware hash page table. But before
> doing that we need to make sure there are no parallel hash page
> table insert going on. So we need to do a kick_all_cpus_sync()
> before flushing the older hash table entries. By moving this to
> a separate function we capture these details and mention how it
> is different from a hugepage pte clear.
> 
> This patch is a cleanup and only does code movement for clarity.
> There should not be any change in functionality.
> 
> ...
>
> +#ifndef pmd_collapse_flush
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +static inline pmd_t pmd_collapse_flush(struct vm_area_struct *vma,
> +				       unsigned long address,
> +				       pmd_t *pmdp)
> +{
> +	return pmdp_clear_flush(vma, address, pmdp);
> +}
> +#else
> +static inline pmd_t pmd_collapse_flush(struct vm_area_struct *vma,
> +				       unsigned long address,
> +				       pmd_t *pmdp)
> +{
> +	BUILD_BUG();
> +	return __pmd(0);
> +}
> +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */

You want

#define pmd_collapse_flush pmd_collapse_flush

here, just in case a later header file performs the same test.

> +#endif
> +
