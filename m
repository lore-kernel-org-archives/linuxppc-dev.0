Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 24045DDF6A
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 06:52:30 +1100 (EST)
Subject: Re: [POWERPC 09/18] Remove the global dma_direct_offset
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: arnd@arndb.de
In-Reply-To: <20071218175105.263700000@arndb.de>
References: <20071218174852.112644000@arndb.de>
	<20071218175105.263700000@arndb.de>
Content-Type: text/plain
Date: Wed, 19 Dec 2007 06:52:13 +1100
Message-Id: <1198007533.18908.10.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2007-12-18 at 18:49 +0100, arnd@arndb.de wrote:
> plain text document attachment
> (0019-Remove-the-global-dma_direct_offset.patch)
> We no longer need the global dma_direct_offset, update the comment to
> reflect the new reality.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Ack.

>  arch/powerpc/kernel/dma_64.c      |    7 ++++---
>  include/asm-powerpc/dma-mapping.h |    2 --
>  2 files changed, 4 insertions(+), 5 deletions(-)
> 
> Index: linux-2.6-new/arch/powerpc/kernel/dma_64.c
> ===================================================================
> --- linux-2.6-new.orig/arch/powerpc/kernel/dma_64.c
> +++ linux-2.6-new/arch/powerpc/kernel/dma_64.c
> @@ -112,10 +112,11 @@ EXPORT_SYMBOL(dma_iommu_ops);
>  /*
>   * Generic direct DMA implementation
>   *
> - * This implementation supports a global offset that can be applied if
> - * the address at which memory is visible to devices is not 0.
> + * This implementation supports a per-device offset that can be applied if
> + * the address at which memory is visible to devices is not 0. Platform code
> + * can point archdata.dma_data at an unsigned long holding the offset. By
> + * default no offset is used.
>   */
> -unsigned long dma_direct_offset;
>  
>  static unsigned long get_dma_direct_offset(struct device *dev)
>  {
> Index: linux-2.6-new/include/asm-powerpc/dma-mapping.h
> ===================================================================
> --- linux-2.6-new.orig/include/asm-powerpc/dma-mapping.h
> +++ linux-2.6-new/include/asm-powerpc/dma-mapping.h
> @@ -186,8 +186,6 @@ static inline void dma_unmap_sg(struct d
>  extern struct dma_mapping_ops dma_iommu_ops;
>  extern struct dma_mapping_ops dma_direct_ops;
>  
> -extern unsigned long dma_direct_offset;
> -
>  #else /* CONFIG_PPC64 */
>  
>  #define dma_supported(dev, mask)	(1)
> 
