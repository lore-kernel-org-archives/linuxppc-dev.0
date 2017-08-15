Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWtPs5lkGzDqY1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Aug 2017 23:20:17 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 1/3] mm/hugetlb: Allow arch to override and call the
 weak function
In-Reply-To: <20170728050127.28338-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20170728050127.28338-1-aneesh.kumar@linux.vnet.ibm.com>
Date: Tue, 15 Aug 2017 23:20:16 +1000
Message-ID: <87lgmlt1bj.fsf@concordia.ellerman.id.au>
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

> When running in guest mode ppc64 supports a different mechanism for hugetlb
> allocation/reservation. The LPAR management application called HMC can
> be used to reserve a set of hugepages and we pass the details of
> reserved pages via device tree to the guest. (more details in
> htab_dt_scan_hugepage_blocks()) . We do the memblock_reserve of the range
> and later in the boot sequence, we add the reserved range to huge_boot_pages.
>
> But to enable 16G hugetlb on baremetal config (when we are not running as guest)
> we want to do memblock reservation during boot. Generic code already does this
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  include/linux/hugetlb.h | 1 +
>  mm/hugetlb.c            | 4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)

I'm planning to take this and the rest of the series in the powerpc
tree. Unless someone on linux-mm yells at me :)

cheers

> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 0ed8e41aaf11..8bbbd37ab105 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -358,6 +358,7 @@ int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
>  			pgoff_t idx);
>  
>  /* arch callback */
> +int __init __alloc_bootmem_huge_page(struct hstate *h);
>  int __init alloc_bootmem_huge_page(struct hstate *h);
>  
>  void __init hugetlb_bad_size(void);
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index bc48ee783dd9..b97e6494d74d 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2083,7 +2083,9 @@ struct page *alloc_huge_page_noerr(struct vm_area_struct *vma,
>  	return page;
>  }
>  
> -int __weak alloc_bootmem_huge_page(struct hstate *h)
> +int alloc_bootmem_huge_page(struct hstate *h)
> +	__attribute__ ((weak, alias("__alloc_bootmem_huge_page")));
> +int __alloc_bootmem_huge_page(struct hstate *h)
>  {
>  	struct huge_bootmem_page *m;
>  	int nr_nodes, node;
> -- 
> 2.13.3
