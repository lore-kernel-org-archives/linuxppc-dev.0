Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 7/8] Split out the ioid fetching/checking logic
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <aa11f5302486ba8b922828b78af1f124b38c9671.1201616038.git.michael@ellerman.id.au>
References: <56662c291890f09835ef7251f9b86f70fbee3ad2.1201616038.git.michael@ellerman.id.au>
	<aa11f5302486ba8b922828b78af1f124b38c9671.1201616038.git.michael@ellerman.id.au>
Content-Type: text/plain
Date: Tue, 05 Feb 2008 11:27:15 +1100
Message-Id: <1202171235.7079.42.camel@pasglop>
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
> Split out the ioid fetching and checking logic so we can use it elsewhere
> in a subsequent patch.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  arch/powerpc/platforms/cell/iommu.c |   23 +++++++++++++++++------
>  1 files changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
> index 7779dbf..3baade1 100644
> --- a/arch/powerpc/platforms/cell/iommu.c
> +++ b/arch/powerpc/platforms/cell/iommu.c
> @@ -443,25 +443,36 @@ static struct iommu_window *find_window(struct cbe_iommu *iommu,
>  }
>  #endif
>  
> +static inline u32 cell_iommu_get_ioid(struct device_node *np)
> +{
> +	const u32 *ioid;
> +
> +	ioid = of_get_property(np, "ioid", NULL);
> +	if (ioid == NULL) {
> +		printk(KERN_WARNING "iommu: missing ioid for %s using 0\n",
> +		       np->full_name);
> +		return 0;
> +	}
> +
> +	return *ioid;
> +}
> +
>  static struct iommu_window * __init
>  cell_iommu_setup_window(struct cbe_iommu *iommu, struct device_node *np,
>  			unsigned long offset, unsigned long size,
>  			unsigned long pte_offset)
>  {
>  	struct iommu_window *window;
> -	const unsigned int *ioid;
> +	u32 ioid;
>  
> -	ioid = of_get_property(np, "ioid", NULL);
> -	if (ioid == NULL)
> -		printk(KERN_WARNING "iommu: missing ioid for %s using 0\n",
> -		       np->full_name);
> +	ioid = cell_iommu_get_ioid(np);
>  
>  	window = kmalloc_node(sizeof(*window), GFP_KERNEL, iommu->nid);
>  	BUG_ON(window == NULL);
>  
>  	window->offset = offset;
>  	window->size = size;
> -	window->ioid = ioid ? *ioid : 0;
> +	window->ioid = ioid;
>  	window->iommu = iommu;
>  	window->pte_offset = pte_offset;
>  
