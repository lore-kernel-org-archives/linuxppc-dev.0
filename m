Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9B8C8B6F71
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Jun 2011 07:40:42 +1000 (EST)
Subject: Re: [PATCH 2/5] hugetlb: add phys addr to struct huge_bootmem_page
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Becky Bruce <beckyb@kernel.crashing.org>
In-Reply-To: <13092910103675-git-send-email-beckyb@kernel.crashing.org>
References: <1309290888309-git-send-email-beckyb@kernel.crashing.org>
	<13092909493748-git-send-email-beckyb@kernel.crashing.org>
	<13092910103675-git-send-email-beckyb@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 29 Jun 2011 07:39:26 +1000
Message-ID: <1309297166.32158.461.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	wli@holomorphy.com, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-06-28 at 14:54 -0500, Becky Bruce wrote:
>  struct page *alloc_huge_page_node(struct hstate *h, int nid);
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 6402458..2db81ea 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1105,8 +1105,14 @@ static void __init
> gather_bootmem_prealloc(void)
>         struct huge_bootmem_page *m;
>  
>         list_for_each_entry(m, &huge_boot_pages, list) {
> -               struct page *page = virt_to_page(m);
>                 struct hstate *h = m->hstate;
> +#ifdef CONFIG_HIGHMEM
> +               struct page *page = pfn_to_page(m->phys >>
> PAGE_SHIFT);
> +               free_bootmem_late((unsigned long)m,
> +                                 sizeof(struct huge_bootmem_page));
> +#else
> +               struct page *page = virt_to_page(m);
> +#endif
>                 __ClearPageReserved(page);

Why do you add free_bootmem_late() in the highmem case and not the
normal case ?

Cheers,
Ben.
