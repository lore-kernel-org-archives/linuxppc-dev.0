Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 59645B70C1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2012 21:19:16 +1000 (EST)
Message-ID: <1334747941.3143.13.camel@pasglop>
Subject: Re: PowerPC radeon KMS - is it possible?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Date: Wed, 18 Apr 2012 21:19:01 +1000
In-Reply-To: <1334745854.5989.295.camel@thor.local>
References: <BAY163-W54EBB2437ED2068EF5AF5D03F0@phx.gbl>
 <1334730915.5989.265.camel__41553.0639271767$1334731329$gmane$org@thor.local>
 <m2liltbhkp.fsf@igel.home> <1334736133.5989.278.camel@thor.local>
 <1334744414.3143.2.camel@pasglop> <1334745292.5989.291.camel@thor.local>
 <1334745854.5989.295.camel@thor.local>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Andreas Schwab <schwab@linux-m68k.org>,
 o jordan <ojordan12345@hotmail.co.uk>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-04-18 at 12:44 +0200, Michel Dänzer wrote:
> On Mit, 2012-04-18 at 12:34 +0200, Michel Dänzer wrote: 
> > On Mit, 2012-04-18 at 20:20 +1000, Benjamin Herrenschmidt wrote: 
> > > 
> > > I suspect there's a fundamental design issue with apple bridge in that
> > > the CPU to memory path isn't coherent at all with the GPU to memory path
> > > ie. even vs. cache flush instructions (ie buffers in the memory
> > > controllers can still be out of sync).
> > > 
> > > Darwin does some gross hacks to work around that, some of them visible
> > > in the AGP drivers, some burried in the Apple driver, I don't know for
> > > sure. It's possible that they end up mapping all AGP memory as cache
> > > inhibited, but we can't do that because of our linear mapping.
> > 
> > We are doing that though...
> 
> This reminded me, I've been running with the patch below, but I'm not
> sure it makes any difference. Maybe Andreas or Jordan can try it.

It certainly is something we need to do, provided we also know there
will be no subsequent access to that page via a cachable mapping until
it's removed from AGP.

Cheers,
Ben.
> 
> diff --git a/arch/powerpc/include/asm/agp.h b/arch/powerpc/include/asm/agp.h
> index 416e12c..eb34fa5 100644
> --- a/arch/powerpc/include/asm/agp.h
> +++ b/arch/powerpc/include/asm/agp.h
> @@ -2,9 +2,12 @@
>  #define _ASM_POWERPC_AGP_H
>  #ifdef __KERNEL__
>  
> +#include <asm/cacheflush.h>
>  #include <asm/io.h>
>  
> -#define map_page_into_agp(page)
> +#define map_page_into_agp(page)	\
> +	flush_dcache_range((unsigned long)page_address(page), \
> +			   (unsigned long)page_address(page) + PAGE_SIZE)
>  #define unmap_page_from_agp(page)
>  #define flush_agp_cache() mb()
>  
> 
> 
