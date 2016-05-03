Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzYbZ1k8DzDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 18:04:10 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id zy2so956968pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 May 2016 01:04:09 -0700 (PDT)
Subject: Re: [RFC 1/7] powerpc/mm: Make vmemmap_populate accommodate
 ZONE_DEVICE memory
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <1462256966-19321-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1462256966-19321-2-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org, oohall@gmail.com, aneesh.kumar@linux.vnet.ibm.com
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <57285B70.3040905@gmail.com>
Date: Tue, 3 May 2016 18:04:00 +1000
MIME-Version: 1.0
In-Reply-To: <1462256966-19321-2-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 03/05/16 16:29, Anshuman Khandual wrote:
> Change the vmemmap_populate function to detect device memory through
> to_vmemmap_altmap and then call generic the __vmmemap_alloc_block_buf
> function instead of vmemmap_alloc_block as the earlier can allocate
> physical memory from the device range instead of the system RAM.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/init_64.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
> index ba65566..db73708 100644
> --- a/arch/powerpc/mm/init_64.c
> +++ b/arch/powerpc/mm/init_64.c
> @@ -42,6 +42,7 @@
>  #include <linux/memblock.h>
>  #include <linux/hugetlb.h>
>  #include <linux/slab.h>
> +#include <linux/memremap.h>
>  
>  #include <asm/pgalloc.h>
>  #include <asm/page.h>
> @@ -312,6 +313,7 @@ static __meminit void vmemmap_list_populate(unsigned long phys,
>  int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node)
>  {
>  	unsigned long page_size = 1 << mmu_psize_defs[mmu_vmemmap_psize].shift;
> +	unsigned long orig = start;

I would much rather do struct vmem_altmap *altmap = to_vmem_altmap(start);

>  
>  	/* Align to the page size of the linear mapping. */
>  	start = _ALIGN_DOWN(start, page_size);
> @@ -319,13 +321,15 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node)
>  	pr_debug("vmemmap_populate %lx..%lx, node %d\n", start, end, node);
>  
>  	for (; start < end; start += page_size) {
> +		struct vmem_altmap *altmap;
>  		void *p;
>  		int rc;
>  
>  		if (vmemmap_populated(start, page_size))
>  			continue;
>  
> -		p = vmemmap_alloc_block(page_size, node);
> +		altmap = to_vmem_altmap((unsigned long) orig);
> +		p = __vmemmap_alloc_block_buf(page_size, node, altmap);
>  		if (!p)
>  			return -ENOMEM;
>  
> 
