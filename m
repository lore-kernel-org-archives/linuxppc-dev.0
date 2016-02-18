Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3B3501A04EA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Feb 2016 01:34:33 +1100 (AEDT)
Message-ID: <1455806072.5284.17.camel@ellerman.id.au>
Subject: Re: [RFC 1/4] powerpc/mm: Rename variable to reflect start address
 of a section
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com
Date: Fri, 19 Feb 2016 01:34:32 +1100
In-Reply-To: <1455711179-20357-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1455711179-20357-1-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-02-17 at 17:42 +0530, Anshuman Khandual wrote:

> The commit (16a05bff1: powerpc: start loop at section start of
> start in vmemmap_populated()) reused 'start' variable to compute
> the starting address of the memory section where the given address
> belongs. Then the same variable is used for iterating over starting
> address of all memory sections before reaching the 'end' address.
> Renaming it as 'section_start' makes the logic more clear.
> 
> Fixes: 16a05bff1 ("powerpc: start loop at section start of start in vmemmap_populated()")

It's not a fix, just a cleanup. Fixes lines should be reserved for actual bug
fixes.

> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/init_64.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
> index 379a6a9..d6b9b4d 100644
> --- a/arch/powerpc/mm/init_64.c
> +++ b/arch/powerpc/mm/init_64.c
> @@ -170,11 +170,15 @@ static unsigned long __meminit vmemmap_section_start(unsigned long page)
>   */
>  static int __meminit vmemmap_populated(unsigned long start, int page_size)
>  {
> -	unsigned long end = start + page_size;
> -	start = (unsigned long)(pfn_to_page(vmemmap_section_start(start)));
> +	unsigned long end, section_start;
>  
> -	for (; start < end; start += (PAGES_PER_SECTION * sizeof(struct page)))
> -		if (pfn_valid(page_to_pfn((struct page *)start)))
> +	end = start + page_size;
> +	section_start = (unsigned long)(pfn_to_page
> +					(vmemmap_section_start(start)));
> +
> +	for (; section_start < end; section_start
> +				+= (PAGES_PER_SECTION * sizeof(struct page)))
> +		if (pfn_valid(page_to_pfn((struct page *)section_start)))
>  			return 1;
>  
>  	return 0;

That's not a big improvement.

But I think this code could be improved. There's a lot of casts, it seems to be
confused about whether it's iterating over addresses or struct pages.

cheers
