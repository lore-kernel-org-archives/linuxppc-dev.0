Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 6/8] Add support to cell_iommu_setup_page_tables() for
	multiple windows
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <75f9137843ca0bcb81df8274c98a2a21777a35bf.1201616038.git.michael@ellerman.id.au>
References: <56662c291890f09835ef7251f9b86f70fbee3ad2.1201616038.git.michael@ellerman.id.au>
	<75f9137843ca0bcb81df8274c98a2a21777a35bf.1201616038.git.michael@ellerman.id.au>
Content-Type: text/plain
Date: Tue, 05 Feb 2008 11:26:43 +1100
Message-Id: <1202171203.7079.41.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-01-30 at 01:14 +1100, Michael Ellerman wrote:
> Add support to cell_iommu_setup_page_tables() for handling two windows,
> the dynamic window and the fixed window. A fixed window size of 0
> indicates that there is no fixed window at all.
> 
> Currently there are no callers who pass a non-zero fixed window, but the
> upcoming fixed IOMMU mapping patch will change that.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  arch/powerpc/platforms/cell/iommu.c |   15 ++++++++++-----
>  1 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
> index e9769fc..7779dbf 100644
> --- a/arch/powerpc/platforms/cell/iommu.c
> +++ b/arch/powerpc/platforms/cell/iommu.c
> @@ -307,14 +307,19 @@ static int cell_iommu_find_ioc(int nid, unsigned long *base)
>  }
>  
>  static void cell_iommu_setup_page_tables(struct cbe_iommu *iommu,
> -					 unsigned long base, unsigned long size)
> +				unsigned long dbase, unsigned long dsize,
> +				unsigned long fbase, unsigned long fsize)
>  {
>  	struct page *page;
>  	int i;
>  	unsigned long reg, segments, pages_per_segment, ptab_size, stab_size,
> -		      n_pte_pages;
> +		      n_pte_pages, base;
>  
> -	segments = size >> IO_SEGMENT_SHIFT;
> +	base = dbase;
> +	if (fsize != 0)
> +		base = min(fbase, dbase);
> +
> +	segments = max(dbase + dsize, fbase + fsize) >> IO_SEGMENT_SHIFT;
>  	pages_per_segment = 1ull << IO_PAGENO_BITS;
>  
>  	pr_debug("%s: iommu[%d]: segments: %lu, pages per segment: %lu\n",
> @@ -366,7 +371,7 @@ static void cell_iommu_setup_page_tables(struct cbe_iommu *iommu,
>  	}
>  
>  	pr_debug("Setting up IOMMU stab:\n");
> -	for (i = 0; i * (1ul << IO_SEGMENT_SHIFT) < size; i++) {
> +	for (i = base >> IO_SEGMENT_SHIFT; i < segments; i++) {
>  		iommu->stab[i] = reg |
>  			(__pa(iommu->ptab) + n_pte_pages * IOMMU_PAGE_SIZE * i);
>  		pr_debug("\t[%d] 0x%016lx\n", i, iommu->stab[i]);
> @@ -417,7 +422,7 @@ static void cell_iommu_enable_hardware(struct cbe_iommu *iommu)
>  static void cell_iommu_setup_hardware(struct cbe_iommu *iommu,
>  	unsigned long base, unsigned long size)
>  {
> -	cell_iommu_setup_page_tables(iommu, base, size);
> +	cell_iommu_setup_page_tables(iommu, base, size, 0, 0);
>  	cell_iommu_enable_hardware(iommu);
>  }
>  
