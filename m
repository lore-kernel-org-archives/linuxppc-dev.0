Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4CA5DDDDFA
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2008 19:05:18 +1100 (EST)
Subject: Re: [PATCH 3/8] Remove unused pte_offset variable
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <180c3c87682d05b1d58e50df77f99478f98d9b30.1204097262.git.michael@ellerman.id.au>
References: <4108415683edeb799fd4880a8dba3e9f27a34415.1204097262.git.michael@ellerman.id.au>
	<180c3c87682d05b1d58e50df77f99478f98d9b30.1204097262.git.michael@ellerman.id.au>
Content-Type: text/plain
Date: Wed, 27 Feb 2008 19:04:51 +1100
Message-Id: <1204099491.15052.227.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-02-27 at 18:28 +1100, Michael Ellerman wrote:
> The cell IOMMU code no longer needs to save the pte_offset variable
> separately, it is incorporated into tbl->it_offset.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---

Do this work on spider ?

There is a subtle difference with spider is that the 0x80000000 you give
to devices disappears when reaching the iommu (so isn't to be catered
in the iommu offset).

It's a bit like the offset you have to add to the direct mapping on
axon, in fact (the 0x8000060000000000 or so ...)

Ben.

>  arch/powerpc/platforms/cell/iommu.c |    5 +----
>  1 files changed, 1 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
> index 4e75919..555d264 100644
> --- a/arch/powerpc/platforms/cell/iommu.c
> +++ b/arch/powerpc/platforms/cell/iommu.c
> @@ -123,7 +123,6 @@ struct iommu_window {
>  	struct cbe_iommu *iommu;
>  	unsigned long offset;
>  	unsigned long size;
> -	unsigned long pte_offset;
>  	unsigned int ioid;
>  	struct iommu_table table;
>  };
> @@ -475,13 +474,11 @@ cell_iommu_setup_window(struct cbe_iommu *iommu, struct device_node *np,
>  	window->size = size;
>  	window->ioid = ioid;
>  	window->iommu = iommu;
> -	window->pte_offset = pte_offset;
>  
>  	window->table.it_blocksize = 16;
>  	window->table.it_base = (unsigned long)iommu->ptab;
>  	window->table.it_index = iommu->nid;
> -	window->table.it_offset = (offset >> IOMMU_PAGE_SHIFT) +
> -		window->pte_offset;
> +	window->table.it_offset = (offset >> IOMMU_PAGE_SHIFT) + pte_offset;
>  	window->table.it_size = size >> IOMMU_PAGE_SHIFT;
>  
>  	iommu_init_table(&window->table, iommu->nid);
