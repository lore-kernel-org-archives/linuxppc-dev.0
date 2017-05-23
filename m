Return-Path: <bsingharora@gmail.com>
Received: from mail-qt0-x242.google.com (mail-qt0-x242.google.com
 [IPv6:2607:f8b0:400d:c0d::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wX99V1jmFzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 May 2017 19:25:18 +1000 (AEST)
Received: by mail-qt0-x242.google.com with SMTP id l39so21473114qtb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 May 2017 02:25:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170523040524.13717-3-oohall@gmail.com>
References: <20170523040524.13717-1-oohall@gmail.com>
 <20170523040524.13717-3-oohall@gmail.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Tue, 23 May 2017 19:25:15 +1000
Message-ID: <CAKTCnzk+8zNDp-fYbrry_RDHfOAHgiB6r8EXScjemWqMuFkdPA@mail.gmail.com>
Subject: Re: [PATCH 3/6] powerpc/vmemmap: Add altmap support
To: "Oliver O'Halloran" <oohall@gmail.com>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 23, 2017 at 2:05 PM, Oliver O'Halloran <oohall@gmail.com> wrote:
> Adds support to powerpc for the altmap feature of ZONE_DEVICE memory. An
> altmap is a driver provided region that is used to provide the backing
> storage for the struct pages of ZONE_DEVICE memory. In situations where
> large amount of ZONE_DEVICE memory is being added to the system the
> altmap reduces pressure on main system memory by allowing the mm/
> metadata to be stored on the device itself rather in main memory.
>
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> ---
>  arch/powerpc/mm/init_64.c | 15 +++++++++++++--
>  arch/powerpc/mm/mem.c     | 16 +++++++++++++---
>  2 files changed, 26 insertions(+), 5 deletions(-)
>
> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
> index 8851e4f5dbab..225fbb8034e6 100644
> --- a/arch/powerpc/mm/init_64.c
> +++ b/arch/powerpc/mm/init_64.c
> @@ -44,6 +44,7 @@
>  #include <linux/slab.h>
>  #include <linux/of_fdt.h>
>  #include <linux/libfdt.h>
> +#include <linux/memremap.h>
>
>  #include <asm/pgalloc.h>
>  #include <asm/page.h>
> @@ -171,13 +172,17 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node)
>         pr_debug("vmemmap_populate %lx..%lx, node %d\n", start, end, node);
>
>         for (; start < end; start += page_size) {
> +               struct vmem_altmap *altmap;
>                 void *p;
>                 int rc;
>
>                 if (vmemmap_populated(start, page_size))
>                         continue;
>
> -               p = vmemmap_alloc_block(page_size, node);
> +               /* altmap lookups only work at section boundaries */
> +               altmap = to_vmem_altmap(SECTION_ALIGN_DOWN(start));
> +
> +               p =  __vmemmap_alloc_block_buf(page_size, node, altmap);
>                 if (!p)
>                         return -ENOMEM;
>
> @@ -242,6 +247,8 @@ void __ref vmemmap_free(unsigned long start, unsigned long end)
>
>         for (; start < end; start += page_size) {
>                 unsigned long nr_pages, addr;
> +               struct vmem_altmap *altmap;
> +               struct page *section_base;
>                 struct page *page;
>
>                 /*
> @@ -257,9 +264,13 @@ void __ref vmemmap_free(unsigned long start, unsigned long end)
>                         continue;
>
>                 page = pfn_to_page(addr >> PAGE_SHIFT);
> +               section_base = pfn_to_page(vmemmap_section_start(start));
>                 nr_pages = 1 << page_order;
>
> -               if (PageReserved(page)) {
> +               altmap = to_vmem_altmap((unsigned long) section_base);
> +               if (altmap) {
> +                       vmem_altmap_free(altmap, nr_pages);
> +               } else if (PageReserved(page)) {
>                         /* allocated from bootmem */
>                         if (page_size < PAGE_SIZE) {
>                                 /*
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index 9ee536ec0739..2c0c16f11eee 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -36,6 +36,7 @@
>  #include <linux/hugetlb.h>
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
> +#include <linux/memremap.h>
>
>  #include <asm/pgalloc.h>
>  #include <asm/prom.h>
> @@ -159,11 +160,20 @@ int arch_remove_memory(u64 start, u64 size)
>  {
>         unsigned long start_pfn = start >> PAGE_SHIFT;
>         unsigned long nr_pages = size >> PAGE_SHIFT;
> -       struct zone *zone;
> +       struct vmem_altmap *altmap;
> +       struct page *page;
>         int ret;
>
> -       zone = page_zone(pfn_to_page(start_pfn));
> -       ret = __remove_pages(zone, start_pfn, nr_pages);
> +       /*
> +        * If we have an altmap then we need to skip over any reserved PFNs
> +        * when querying the zone.
> +        */
> +       page = pfn_to_page(start_pfn);
> +       altmap = to_vmem_altmap((unsigned long) page);
> +       if (altmap)
> +               page += vmem_altmap_offset(altmap);
> +
> +       ret = __remove_pages(page_zone(page), start_pfn, nr_pages);
>         if (ret)
>                 return ret;

Reviewed-by: Balbir Singh <bsingharora@gmail.com>

Balbir
