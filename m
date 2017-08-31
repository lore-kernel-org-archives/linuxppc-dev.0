Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjkhf4lhwzDqGZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Sep 2017 00:07:14 +1000 (AEST)
Date: Thu, 31 Aug 2017 16:06:53 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Christoph Hellwig <hch@lst.de>
cc: iommu@lists.linux-foundation.org,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Michal Simek <monstr@monstr.eu>,
 David Howells <dhowells@redhat.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 x86@kernel.org, linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/12] x86: make dma_cache_sync a no-op
In-Reply-To: <20170827161032.22772-5-hch@lst.de>
Message-ID: <alpine.DEB.2.20.1708311606340.1874@nanos>
References: <20170827161032.22772-1-hch@lst.de>
 <20170827161032.22772-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 27 Aug 2017, Christoph Hellwig wrote:

> x86 does not implement DMA_ATTR_NON_CONSISTENT allocations, so it doesn't
> make any sense to do any work in dma_cache_sync given that it must be a
> no-op when dma_alloc_attrs returns coherent memory.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

> ---
>  arch/x86/include/asm/dma-mapping.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/dma-mapping.h b/arch/x86/include/asm/dma-mapping.h
> index 398c79889f5c..04877267ad18 100644
> --- a/arch/x86/include/asm/dma-mapping.h
> +++ b/arch/x86/include/asm/dma-mapping.h
> @@ -70,7 +70,6 @@ static inline void
>  dma_cache_sync(struct device *dev, void *vaddr, size_t size,
>  	enum dma_data_direction dir)
>  {
> -	flush_write_buffers();
>  }
>  
>  static inline unsigned long dma_alloc_coherent_mask(struct device *dev,
> -- 
> 2.11.0
> 
> 
