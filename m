Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8E690DDF81
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Dec 2008 08:04:15 +1100 (EST)
Subject: Re: [PATCH 15/16] powerpc/mm: Rework usage of
	_PAGE_COHERENT/NO_CACHE/GUARDED
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <8F38D1CB-D389-4065-A309-3126B6D482DB@freescale.com>
References: <20081215054611.3C3C1474E1@ozlabs.org>
	<8F38D1CB-D389-4065-A309-3126B6D482DB@freescale.com>
Content-Type: text/plain
Date: Tue, 16 Dec 2008 08:01:50 +1100
Message-Id: <1229374910.26324.124.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > -#ifdef CONFIG_44x
> > -#define _PAGE_BASE	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_GUARDED)
> > +#if defined(CONFIG_SMP) || defined(CONFIG_PPC_STD_MMU)
> > +#define _PAGE_BASE	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_COHERENT)
> > #else
> > #define _PAGE_BASE	(_PAGE_PRESENT | _PAGE_ACCESSED)
> > #endif
> > +#define _PAGE_BASE_NC	(_PAGE_PRESENT | _PAGE_ACCESSED)
> > +
> > #define _PAGE_WRENABLE	(_PAGE_RW | _PAGE_DIRTY | _PAGE_HWWRITE)
> > #define _PAGE_KERNEL	(_PAGE_BASE | _PAGE_SHARED | _PAGE_WRENABLE)
> > +#define _PAGE_KERNEL_NC	(_PAGE_BASE_NC | _PAGE_SHARED |  
> > _PAGE_WRENABLE | _PAGE_NO_CACHE)
> 
> Either _BASE_NC should have _PAGE_NO_CACHE set or you need a different  
> name here for _PAGE_KERNEL_NC

Not sure what you mean.. _PAGE_KERNEL_NC has no cache in it, and
_BASE_NC doesn't ... oh well.. because it's the base type used by
KERNEL_NC :-) I agree it's not the clearest, I can just move
_PAGE_NO_CACHE to _PAGE_BASE_NC, that will make it clearer I suppose,
but I don't see anything being actually incorrect, or do I miss
something ?

> I think we should do:
> 
> #define _PAGE_KERNEL_NC	(_PAGE_BASE_NC | _PAGE_SHARED | _PAGE_WRENABLE)
> #define _PAGE_IO	(_PAGE_KERNEL_NC | _PAGE_NO_CACHE | _PAGE_GUARDED)

I don't understand.... _PAGE_KERNEL_NC is supposedly non caccheable, I
should probably move _PAGE_NO_CACHE to _PAGE_BASE_NC...

> > +#define _PAGE_CACHE_CTL	(_PAGE_COHERENT | _PAGE_COHERENT |  
> > _PAGE_COHERENT | \
> > + 			 _PAGE_WRITETHRU)
> 
> we like coherent so much we set it thrice?

Nice :-) Yeah, it should be _COHERENT, _GUARDED, _NO_CACHE and
_WRITETHRU, I'll fix that.

Cheers,
Ben.
