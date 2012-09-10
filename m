Return-Path: <dgibson@ozlabs.org>
Date: Mon, 10 Sep 2012 12:35:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH] powerpc-powernv: added tce_get callback for powernv
 platform
Message-ID: <20120910023554.GP12554@truffula.fritz.box>
References: <1346807975-2323-1-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1346807975-2323-1-git-send-email-aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 05, 2012 at 11:19:35AM +1000, Alexey Kardashevskiy wrote:
> The upcoming VFIO support requires a way to know which
> entry in the TCE map is not empty in order to do cleanup
> at QEMU exit/crash. This patch adds such functionality
> to POWERNV platform code.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Looks good to me.  Ben, do you plan to merge this soon?

> ---
>  arch/powerpc/platforms/powernv/pci.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
> index be3cfc5..05205cf 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -447,6 +447,11 @@ static void pnv_tce_free(struct iommu_table *tbl, long index, long npages)
>  		pnv_tce_invalidate(tbl, tces, tcep - 1);
>  }
>  
> +static unsigned long pnv_tce_get(struct iommu_table *tbl, long index)
> +{
> +	return ((u64 *)tbl->it_base)[index - tbl->it_offset];
> +}
> +
>  void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
>  			       void *tce_mem, u64 tce_size,
>  			       u64 dma_offset)
> @@ -597,6 +602,7 @@ void __init pnv_pci_init(void)
>  	ppc_md.pci_dma_dev_setup = pnv_pci_dma_dev_setup;
>  	ppc_md.tce_build = pnv_tce_build;
>  	ppc_md.tce_free = pnv_tce_free;
> +	ppc_md.tce_get = pnv_tce_get;
>  	ppc_md.pci_probe_mode = pnv_pci_probe_mode;
>  	set_pci_dma_ops(&dma_iommu_ops);
>  

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
