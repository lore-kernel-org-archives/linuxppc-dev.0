Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AE349B6F70
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 22 Jul 2011 08:44:32 +1000 (EST)
Date: Thu, 21 Jul 2011 15:44:27 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Becky Bruce <beckyb@kernel.crashing.org>
Subject: Re: [PATCH 2/5] hugetlb: add phys addr to struct huge_bootmem_page
Message-Id: <20110721154427.53e8fd5b.akpm@linux-foundation.org>
In-Reply-To: <13092910103675-git-send-email-beckyb@kernel.crashing.org>
References: <1309290888309-git-send-email-beckyb@kernel.crashing.org>
	<13092909493748-git-send-email-beckyb@kernel.crashing.org>
	<13092910103675-git-send-email-beckyb@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 28 Jun 2011 14:54:45 -0500
Becky Bruce <beckyb@kernel.crashing.org> wrote:

> From: Becky Bruce <beckyb@kernel.crashing.org>
> 
> This is needed on HIGHMEM systems - we don't always have a virtual
> address so store the physical address and map it in as needed.
> 
> Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
> ---
>  include/linux/hugetlb.h |    3 +++
>  mm/hugetlb.c            |    8 +++++++-
>  2 files changed, 10 insertions(+), 1 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 59225ef..19644e0 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -231,6 +231,9 @@ struct hstate {
>  struct huge_bootmem_page {
>  	struct list_head list;
>  	struct hstate *hstate;
> +#ifdef CONFIG_HIGHMEM
> +	phys_addr_t phys;
> +#endif
>  };
>  
>  struct page *alloc_huge_page_node(struct hstate *h, int nid);
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 6402458..2db81ea 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1105,8 +1105,14 @@ static void __init gather_bootmem_prealloc(void)
>  	struct huge_bootmem_page *m;
>  
>  	list_for_each_entry(m, &huge_boot_pages, list) {
> -		struct page *page = virt_to_page(m);
>  		struct hstate *h = m->hstate;
> +#ifdef CONFIG_HIGHMEM
> +		struct page *page = pfn_to_page(m->phys >> PAGE_SHIFT);
> +		free_bootmem_late((unsigned long)m,
> +				  sizeof(struct huge_bootmem_page));
> +#else
> +		struct page *page = virt_to_page(m);
> +#endif
>  		__ClearPageReserved(page);
>  		WARN_ON(page_count(page) != 1);
>  		prep_compound_huge_page(page, h->order);

nit: wrapping both definitions and statements in an ifdef like this is
a bit nasty from a readability and maintainability point of view - it's
inviting people to later make changes which fail to compile when the
config option is flipped.

This is better:

--- a/mm/hugetlb.c~hugetlb-add-phys-addr-to-struct-huge_bootmem_page-fix
+++ a/mm/hugetlb.c
@@ -1106,12 +1106,14 @@ static void __init gather_bootmem_preall
 
 	list_for_each_entry(m, &huge_boot_pages, list) {
 		struct hstate *h = m->hstate;
+		struct page *page;
+
 #ifdef CONFIG_HIGHMEM
-		struct page *page = pfn_to_page(m->phys >> PAGE_SHIFT);
+		page = pfn_to_page(m->phys >> PAGE_SHIFT);
 		free_bootmem_late((unsigned long)m,
 				  sizeof(struct huge_bootmem_page));
 #else
-		struct page *page = virt_to_page(m);
+		page = virt_to_page(m);
 #endif
 		__ClearPageReserved(page);
 		WARN_ON(page_count(page) != 1);
_
