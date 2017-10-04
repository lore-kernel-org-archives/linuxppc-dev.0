Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.192])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y6VFt1GMmzDqls
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Oct 2017 19:59:29 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Christoph Hellwig' <hch@lst.de>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
CC: Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
 "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, "Max
 Filippov" <jcmvbkbc@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, "Robin
 Murphy" <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [PATCH 04/11] ia64: make dma_cache_sync a no-op
Date: Wed, 4 Oct 2017 08:59:24 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD0089626@AcuExch.aculab.com>
References: <20171003104311.10058-1-hch@lst.de>
 <20171003104311.10058-5-hch@lst.de>
In-Reply-To: <20171003104311.10058-5-hch@lst.de>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Christoph Hellwig
> Sent: 03 October 2017 11:43
>
> ia64 does not implement DMA_ATTR_NON_CONSISTENT allocations, so it doesn'=
t
> make any sense to do any work in dma_cache_sync given that it must be a
> no-op when dma_alloc_attrs returns coherent memory.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/ia64/include/asm/dma-mapping.h | 5 -----
>  1 file changed, 5 deletions(-)
>=20
> diff --git a/arch/ia64/include/asm/dma-mapping.h b/arch/ia64/include/asm/=
dma-mapping.h
> index 3ce5ab4339f3..99dfc1aa9d3c 100644
> --- a/arch/ia64/include/asm/dma-mapping.h
> +++ b/arch/ia64/include/asm/dma-mapping.h
> @@ -48,11 +48,6 @@ static inline void
>  dma_cache_sync (struct device *dev, void *vaddr, size_t size,
>  	enum dma_data_direction dir)
>  {
> -	/*
> -	 * IA-64 is cache-coherent, so this is mostly a no-op.  However, we do =
need to
> -	 * ensure that dma_cache_sync() enforces order, hence the mb().
> -	 */
> -	mb();
>  }

Are you sure about this one?
It looks as though you are doing a mechanical change for all architectures.
Some of them are probably stranger than you realise.

Even with cache coherent memory any cpu 'store/write buffer' may not
be snooped by dma reads.

Something needs to flush the store buffer between the last cpu write
to the dma buffer and the write (probably a device register) that
tells the device it can read the memory.

My guess from the comment is that dma_cache_synch() is expected to
include that barrier - and it might not be anywhere else.

	David
