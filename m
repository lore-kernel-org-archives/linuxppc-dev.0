Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E66DC1A0006
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2015 07:41:14 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 39EBF14010F
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2015 07:41:13 +1100 (AEDT)
Message-ID: <1424810457.12891.49.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/3] powerpc/dma: Support 32-bit coherent mask with
 64-bit dma_mask
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Wed, 25 Feb 2015 07:40:57 +1100
In-Reply-To: <1424810077.4698.30.camel@freescale.com>
References: <1424421330.27448.42.camel@kernel.crashing.org>
 <1424810077.4698.30.camel@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@au1.ibm.com>,
 Brian J King <bjking1@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-02-24 at 14:34 -0600, Scott Wood wrote:
> On Fri, 2015-02-20 at 19:35 +1100, Benjamin Herrenschmidt wrote:
> > @@ -149,14 +141,13 @@ static void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sg,
> >  
> >  static int dma_direct_dma_supported(struct device *dev, u64 mask)
> >  {
> > -#ifdef CONFIG_PPC64
> > -	/* Could be improved so platforms can set the limit in case
> > -	 * they have limited DMA windows
> > -	 */
> > -	return mask >= get_dma_offset(dev) + (memblock_end_of_DRAM() - 1);
> > -#else
> > -	return 1;
> > +	u64 offset = get_dma_offset(dev);
> > +	u64 limit = offset + memblock_end_of_DRAM() - 1;
> > +
> > +#if defined(CONFIG_ZONE_DMA32)
> > +	limit = offset + dma_get_zone_limit(ZONE_DMA32);
> >  #endif
> > +	return mask >= limit;
> >  }
> 
> I'm confused as to whether dma_supported() is supposed to be testing a
> coherent mask or regular mask...  The above suggests coherent, as does
> the call to dma_supported() in dma_set_coherent_mask(), but if swiotlb
> is used, swiotlb_dma_supported() will only check for a mask that can
> accommodate io_tlb_end, without regard for coherent allocations.

This is confusing indeed, but without the above, dma_set_coherent_mask()
won't work ... so I'm assuming the above. Notice that x86 doesn't even
bother and basically return 1 for anything above a 24 bit mask (appart
from the force_sac case but we can ignore it).

So we probably should fix our swiotlb implementation as well... but
that's orthogonal.

> >  static u64 dma_direct_get_required_mask(struct device *dev)
> > diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> > index f146ef0..a7f15e2 100644
> > --- a/arch/powerpc/mm/mem.c
> > +++ b/arch/powerpc/mm/mem.c
> > @@ -277,6 +277,11 @@ int dma_pfn_limit_to_zone(u64 pfn_limit)
> >  	return -EPERM;
> >  }
> >  
> > +u64 dma_get_zone_limit(int zone)
> > +{
> > +	return max_zone_pfns[zone] << PAGE_SHIFT;
> > +}
> 
> If you must do this in terms of bytes rather than pfn, cast to u64
> before shifting -- and even then the result will be PAGE_SIZE - 1 too
> small.

Do we have RAM above what a unsigned long can hold ? I think I'll just
make it a pfn and respin...

Cheers,
Ben.

> -Scott
> 
