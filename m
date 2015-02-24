Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3D6661A000B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2015 10:05:23 +1100 (AEDT)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0107.outbound.protection.outlook.com [157.56.111.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4929D140083
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2015 10:05:21 +1100 (AEDT)
Message-ID: <1424819106.4698.32.camel@freescale.com>
Subject: Re: [PATCH 2/3] powerpc/dma: Support 32-bit coherent mask with
 64-bit dma_mask
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 24 Feb 2015 17:05:06 -0600
In-Reply-To: <1424810457.12891.49.camel@kernel.crashing.org>
References: <1424421330.27448.42.camel@kernel.crashing.org>
 <1424810077.4698.30.camel@freescale.com>
 <1424810457.12891.49.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@au1.ibm.com>, Brian J
 King <bjking1@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-02-25 at 07:40 +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2015-02-24 at 14:34 -0600, Scott Wood wrote:
> > On Fri, 2015-02-20 at 19:35 +1100, Benjamin Herrenschmidt wrote:
> > >  static u64 dma_direct_get_required_mask(struct device *dev)
> > > diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> > > index f146ef0..a7f15e2 100644
> > > --- a/arch/powerpc/mm/mem.c
> > > +++ b/arch/powerpc/mm/mem.c
> > > @@ -277,6 +277,11 @@ int dma_pfn_limit_to_zone(u64 pfn_limit)
> > >  	return -EPERM;
> > >  }
> > >  
> > > +u64 dma_get_zone_limit(int zone)
> > > +{
> > > +	return max_zone_pfns[zone] << PAGE_SHIFT;
> > > +}
> > 
> > If you must do this in terms of bytes rather than pfn, cast to u64
> > before shifting -- and even then the result will be PAGE_SIZE - 1 too
> > small.
> 
> Do we have RAM above what a unsigned long can hold ? I think I'll just
> make it a pfn and respin...

Yes, we can have over 4 GiB RAM on 32-bit.

-Scott
