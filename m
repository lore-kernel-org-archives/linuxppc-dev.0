Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BBB13B7080
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 29 Nov 2010 14:04:15 +1100 (EST)
Subject: Re: [PATCH 14/15] ppc64 iommu: use coherent_dma_mask for
	alloc_coherent
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nishanth Aravamudan <nacc@us.ibm.com>
In-Reply-To: <1284573958-8397-15-git-send-email-nacc@us.ibm.com>
References: <1284573958-8397-1-git-send-email-nacc@us.ibm.com>
	<1284573958-8397-15-git-send-email-nacc@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 29 Nov 2010 11:58:16 +1100
Message-ID: <1290992296.32570.215.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-09-15 at 11:05 -0700, Nishanth Aravamudan wrote:
> The IOMMU code has been passing the dma-mask instead of the
> coherent_dma_mask to the iommu allocator.  Coherent allocations should
> be made using the coherent_dma_mask.

Won't that break macio devices too ? afaik, they don't set
coherent_dma_mask. Have you tried booting on a G5 with iommu enabled ?

(It may not be broken, just asking...)

Cheers,
Ben.

> Signed-off-by: Milton Miller <miltonm@bga.com>
> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> ---
> We currently don't check the mask other than to warn when its being set,
> so I don't think this is stable material.
> ---
>  arch/powerpc/kernel/dma-iommu.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
> index 6e54a0f..e755415 100644
> --- a/arch/powerpc/kernel/dma-iommu.c
> +++ b/arch/powerpc/kernel/dma-iommu.c
> @@ -19,7 +19,7 @@ static void *dma_iommu_alloc_coherent(struct device *dev, size_t size,
>  				      dma_addr_t *dma_handle, gfp_t flag)
>  {
>  	return iommu_alloc_coherent(dev, get_iommu_table_base(dev), size,
> -				    dma_handle, device_to_mask(dev), flag,
> +				    dma_handle, dev->coherent_dma_mask, flag,
>  				    dev_to_node(dev));
>  }
>  
