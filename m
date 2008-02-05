Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/8] Split out the logic that allocates struct iommus
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <7bef68137a3a6f5e75b0b54db4b8af8705344f42.1201616038.git.michael@ellerman.id.au>
References: <56662c291890f09835ef7251f9b86f70fbee3ad2.1201616038.git.michael@ellerman.id.au>
	<7bef68137a3a6f5e75b0b54db4b8af8705344f42.1201616038.git.michael@ellerman.id.au>
Content-Type: text/plain
Date: Tue, 05 Feb 2008 11:23:51 +1100
Message-Id: <1202171031.7079.36.camel@pasglop>
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


On Wed, 2008-01-30 at 01:13 +1100, Michael Ellerman wrote:
> Split out the logic that allocates a struct iommu into a separate
> function. This can fail however the calling code has never cared - so
> just return if we can't allocate an iommu.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  arch/powerpc/platforms/cell/iommu.c |   20 ++++++++++++++++----
>  1 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
> index 9223559..4f1ca43 100644
> --- a/arch/powerpc/platforms/cell/iommu.c
> +++ b/arch/powerpc/platforms/cell/iommu.c
> @@ -565,10 +565,9 @@ static int __init cell_iommu_get_window(struct device_node *np,
>  	return 0;
>  }
>  
> -static void __init cell_iommu_init_one(struct device_node *np, unsigned long offset)
> +static struct cbe_iommu * __init cell_iommu_alloc(struct device_node *np)
>  {
>  	struct cbe_iommu *iommu;
> -	unsigned long base, size;
>  	int nid, i;
>  
>  	/* Get node ID */
> @@ -576,7 +575,7 @@ static void __init cell_iommu_init_one(struct device_node *np, unsigned long off
>  	if (nid < 0) {
>  		printk(KERN_ERR "iommu: failed to get node for %s\n",
>  		       np->full_name);
> -		return;
> +		return NULL;
>  	}
>  	pr_debug("iommu: setting up iommu for node %d (%s)\n",
>  		 nid, np->full_name);
> @@ -592,7 +591,7 @@ static void __init cell_iommu_init_one(struct device_node *np, unsigned long off
>  	if (cbe_nr_iommus >= NR_IOMMUS) {
>  		printk(KERN_ERR "iommu: too many IOMMUs detected ! (%s)\n",
>  		       np->full_name);
> -		return;
> +		return NULL;
>  	}
>  
>  	/* Init base fields */
> @@ -603,6 +602,19 @@ static void __init cell_iommu_init_one(struct device_node *np, unsigned long off
>  	snprintf(iommu->name, sizeof(iommu->name), "iommu%d", i);
>  	INIT_LIST_HEAD(&iommu->windows);
>  
> +	return iommu;
> +}
> +
> +static void __init cell_iommu_init_one(struct device_node *np,
> +				       unsigned long offset)
> +{
> +	struct cbe_iommu *iommu;
> +	unsigned long base, size;
> +
> +	iommu = cell_iommu_alloc(np);
> +	if (!iommu)
> +		return;
> +
>  	/* Obtain a window for it */
>  	cell_iommu_get_window(np, &base, &size);
>  
