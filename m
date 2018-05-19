Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 40ntmV6FVWzDqDv
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 May 2018 15:25:46 +1000 (AEST)
Date: Sat, 19 May 2018 15:25:39 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Christoph Hellwig <hch@lst.de>
cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Greg Ungerer <gerg@linux-m68k.org>
Subject: Re: [PATCH 1/2] m68k: Set default dma mask for platform devices
In-Reply-To: <20180518090434.GC24436@lst.de>
Message-ID: <alpine.LNX.2.21.1805191408270.23@nippy.intranet>
References: <cc9b01d2b0e12938fe0e9581dd9d650ad3c4159c.1526551115.git.fthain@telegraphics.com.au>
 <20180518090434.GC24436@lst.de>
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

On Fri, 18 May 2018, Christoph Hellwig wrote:

> > This implementation of arch_setup_pdev_archdata() differs from the 
> > powerpc one, in that this one avoids clobbering a device dma mask 
> > which has already been initialized.
> 
> I think your implementation should move into the generic implementation 
> in drivers/base/platform.c instead of being stuck in m68k.
> 
> Also powerpc probably wants fixing, but that's something left to the
> ppc folks..

On powerpc, all platform devices get a dma mask. But they don't do that in 
drivers/base/platform.c, they use arch_setup_pdev_archdata(). Why didn't 
they take the approach you suggest?

How would I support the claim that replacing an empty platform device dma 
mask with 0xffffffff is safe on all architectures and platforms?

Is there no code conditional upon dev.coherent_dma_mask or dev.dma_mask 
that could misbehave? (Didn't I cite an example in the other thread?*)

If you can convince me that it is safe, I'd be happy to submit the patch 
you asked for.

For now, I still think that patching the platform driver was the correct 
patch*.

Maybe the real problem is your commit 205e1b7f51e4 ("dma-mapping: warn 
when there is no coherent_dma_mask"), because it assumes that all dma_ops 
implementations care about coherent_dma_mask.

The dma_map_ops implementations that do use coherent_dma_mask should 
simply fail when it is unset, right?

Would it not be better to revert your patch and fix the dma_map_ops 
failure paths, than to somehow audit all the platform drivers and patch 
drivers/base/platform.c?

Thanks.

* https://lkml.kernel.org/r/alpine.LNX.2.21.1805091804290.72%40nippy.intranet

-- 
