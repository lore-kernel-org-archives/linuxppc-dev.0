Return-Path: <Liam.Howlett@Oracle.com>
Received: from aserp1050.oracle.com (aserp1050.oracle.com [141.146.126.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJH2f0gB3zDrKK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 02:08:25 +1000 (AEST)
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by aserp1050.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id
 v6RFQBuI032471
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 15:26:12 GMT
Date: Thu, 27 Jul 2017 11:25:56 -0400
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 1/3] mm/hugetlb: Allow arch to override and call the
 weak function
Message-ID: <20170727152556.s4uw5cuvdf36hodl@oracle.com>
References: <20170727061828.11406-1-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170727061828.11406-1-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com> [170727 02:18]:
> For ppc64, we want to call this function when we are not running as guest.
> Also, if we failed to allocate hugepages, let the user know.
> 
[...]
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index bc48ee783dd9..a3a7a7e6339e 100644
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
> @@ -2104,6 +2106,7 @@ int __weak alloc_bootmem_huge_page(struct hstate *h)
>  			goto found;
>  		}
>  	}
> +	pr_info("Failed to allocate hugepage of size %ld\n", huge_page_size(h));
>  	return 0;
>  
>  found:

There is already a call to warn the user in the
hugetlb_hstate_alloc_pages function.  If you look there, you will see
that the huge_page_size was translated into a more user friendly format
and the count prior to the failure is included.  What call path are you
trying to cover?  Also, you may want your print to be a pr_warn since it
is a failure?

Thanks,
Liam
