Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y5xxg4ZbCzDqps
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Oct 2017 22:43:34 +1100 (AEDT)
Date: Tue, 3 Oct 2017 13:43:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
 Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>,
 linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
 linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-xtensa@linux-xtensa.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Robin Murphy <robin.murphy@arm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 07/11] powerpc: make dma_cache_sync a no-op
Message-ID: <20171003114330.GA24592@lst.de>
References: <20171003104311.10058-1-hch@lst.de>
 <20171003104311.10058-8-hch@lst.de>
 <670a0571-1a36-51a3-db52-64bc61184c35@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <670a0571-1a36-51a3-db52-64bc61184c35@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 03, 2017 at 01:24:57PM +0200, Christophe LEROY wrote:
>> powerpc does not implement DMA_ATTR_NON_CONSISTENT allocations, so it
>> doesn't make any sense to do any work in dma_cache_sync given that it
>> must be a no-op when dma_alloc_attrs returns coherent memory.
> What about arch/powerpc/mm/dma-noncoherent.c ?
>
> Powerpc 8xx doesn't have coherent memory.

It doesn't implement the DMA_ATTR_NON_CONSISTENT interface either,
so if it really doesn't have a way to provide dma coherent allocation
(although the code in __dma_alloc_coherent suggests it does provide
dma coherent allocations) I have no idea how it could ever have
worked.
