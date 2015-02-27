Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2A4F21A0061
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2015 14:39:30 +1100 (AEDT)
Message-ID: <1425008369.26070.6.camel@ellerman.id.au>
Subject: Re: [3/3] powerpc/dma: Remove ZONE_DMA completely
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 27 Feb 2015 14:39:29 +1100
In-Reply-To: <20150226063844.4C8A31400EA@ozlabs.org>
References: <20150226063844.4C8A31400EA@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, Anton Blanchard <anton@au1.ibm.com>,
 linuxppc dev list <linuxppc-dev@lists.ozlabs.org>,
 Brian J King <bjking1@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-02-26 at 17:38 +1100, Michael Ellerman wrote:
> On Fri, 2015-20-02 at 08:35:44 UTC, Benjamin Herrenschmidt wrote:
> > diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
> > index e24e0ae..6306d4e 100644
> > --- a/arch/powerpc/kernel/dma.c
> > +++ b/arch/powerpc/kernel/dma.c
> > @@ -63,16 +63,8 @@ void *dma_direct_alloc_coherent(struct device *dev, size_t size,
> >  		return NULL;
> >  	}
> >  
> > -	switch (zone) {
> > -	case ZONE_DMA:
> > -		flag |= GFP_DMA;
> > -		break;
> > -#ifdef CONFIG_ZONE_DMA32
> > -	case ZONE_DMA32:
> > +	if (zone == ZONE_DMA32)
> >  		flag |= GFP_DMA32;
> > -		break;
> > -#endif
> > -	};
> 
> You still need the ifdef, else eg. ppc6xx_defconfig:
> 
>   arch/powerpc/kernel/dma.c:66:14: error: 'ZONE_DMA32' undeclared (first use in this function)

And the rest :)

  http://kisskb.ellerman.id.au/kisskb/head/8505/

  Successful:	45% 49/109

cheers
