Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 6/7] Remove the global dma_direct_offset
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <1e7b4eed15ca7723dd904b056d85b09873b70e8c.1200894155.git.michael@ellerman.id.au>
References: <2949748ba6ad7e14f0768ac3889267e42c050d7a.1200894155.git.michael@ellerman.id.au>
	<1e7b4eed15ca7723dd904b056d85b09873b70e8c.1200894155.git.michael@ellerman.id.au>
Content-Type: text/plain
Date: Mon, 21 Jan 2008 17:21:57 +1100
Message-Id: <1200896517.7222.115.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>,
	cbe-oss-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2008-01-21 at 16:42 +1100, Michael Ellerman wrote:
> We no longer need the global dma_direct_offset, update the comment to
> reflect the new reality.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  arch/powerpc/kernel/dma_64.c      |    7 ++++---
>  include/asm-powerpc/dma-mapping.h |    2 --
>  2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/dma_64.c b/arch/powerpc/kernel/dma_64.c
> index a2d076d..72fdc06 100644
> --- a/arch/powerpc/kernel/dma_64.c
> +++ b/arch/powerpc/kernel/dma_64.c
> @@ -112,10 +112,11 @@ EXPORT_SYMBOL(dma_iommu_ops);
>  /*
>   * Generic direct DMA implementation
>   *
> - * This implementation supports a global offset that can be applied if
> - * the address at which memory is visible to devices is not 0.
> + * This implementation supports a per-device offset that can be applied if
> + * the address at which memory is visible to devices is not 0. Platform code
> + * can set archdata.dma_data to an unsigned long holding the offset. By
> + * default the offset is zero.
>   */
> -unsigned long dma_direct_offset;
>  
>  static unsigned long get_dma_direct_offset(struct device *dev)
>  {
> diff --git a/include/asm-powerpc/dma-mapping.h b/include/asm-powerpc/dma-mapping.h
> index e974876..5eea6db 100644
> --- a/include/asm-powerpc/dma-mapping.h
> +++ b/include/asm-powerpc/dma-mapping.h
> @@ -189,8 +189,6 @@ static inline void dma_unmap_sg(struct device *dev, struct scatterlist *sg,
>  extern struct dma_mapping_ops dma_iommu_ops;
>  extern struct dma_mapping_ops dma_direct_ops;
>  
> -extern unsigned long dma_direct_offset;
> -
>  #else /* CONFIG_PPC64 */
>  
>  #define dma_supported(dev, mask)	(1)
