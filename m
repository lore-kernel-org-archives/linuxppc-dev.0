Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 017631007D6
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Dec 2011 14:23:26 +1100 (EST)
Message-ID: <1323314600.12793.19.camel@pasglop>
Subject: Re: [PATCH] powerpc: Fix swiotlb ops for ppc64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Date: Thu, 08 Dec 2011 14:23:20 +1100
In-Reply-To: <1323278391-21849-1-git-send-email-galak@kernel.crashing.org>
References: <1323278391-21849-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-12-07 at 11:19 -0600, Kumar Gala wrote:

>  struct dma_map_ops swiotlb_dma_ops = {
> +#ifdef CONFIG_PPC64
> +	.alloc_coherent = swiotlb_alloc_coherent,
> +	.free_coherent = swiotlb_free_coherent,
> +#else
>  	.alloc_coherent = dma_direct_alloc_coherent,
>  	.free_coherent = dma_direct_free_coherent,
> +#endif
>  	.map_sg = swiotlb_map_sg_attrs,
>  	.unmap_sg = swiotlb_unmap_sg_attrs,
>  	.dma_supported = swiotlb_dma_supported,

Do we really need the ifdef ? What happens if we use
swiotlb_alloc_coherent() on ppc32 ? Won't it allocate lowmem, realize
that it doesn't need bouncing and be happy ?

Cheers,
Ben.
