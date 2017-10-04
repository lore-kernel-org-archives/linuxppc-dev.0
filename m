Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y6Tb54h7pzDql4
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Oct 2017 19:29:20 +1100 (AEDT)
Subject: Re: [PATCH 07/11] powerpc: make dma_cache_sync a no-op
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, Chris Zankel <chris@zankel.net>,
 Michal Simek <monstr@monstr.eu>, linux-ia64@vger.kernel.org,
 linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 David Howells <dhowells@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Robin Murphy <robin.murphy@arm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
References: <20171003104311.10058-1-hch@lst.de>
 <20171003104311.10058-8-hch@lst.de>
 <670a0571-1a36-51a3-db52-64bc61184c35@c-s.fr> <20171003114330.GA24592@lst.de>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <fd0ccac1-51dc-1eff-f1ac-63f9df282de2@c-s.fr>
Date: Wed, 4 Oct 2017 10:29:13 +0200
MIME-Version: 1.0
In-Reply-To: <20171003114330.GA24592@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 03/10/2017 à 13:43, Christoph Hellwig a écrit :
> On Tue, Oct 03, 2017 at 01:24:57PM +0200, Christophe LEROY wrote:
>>> powerpc does not implement DMA_ATTR_NON_CONSISTENT allocations, so it
>>> doesn't make any sense to do any work in dma_cache_sync given that it
>>> must be a no-op when dma_alloc_attrs returns coherent memory.
>> What about arch/powerpc/mm/dma-noncoherent.c ?
>>
>> Powerpc 8xx doesn't have coherent memory.
> 
> It doesn't implement the DMA_ATTR_NON_CONSISTENT interface either,
> so if it really doesn't have a way to provide dma coherent allocation
> (although the code in __dma_alloc_coherent suggests it does provide
> dma coherent allocations) I have no idea how it could ever have
> worked.
> 

Yes indeed it provides coherent memory by allocation non cached memory.

And drivers aiming at using non coherent memory do it by using kmalloc() 
with GFP_DMA then dma_map_single().
Then they use dma_sync_single_for_xxx(), which calls __dma_sync() on the 
8xx and is a nop on other powerpcs.

Christophe
