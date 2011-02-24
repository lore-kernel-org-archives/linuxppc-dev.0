Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8C021B7103
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 25 Feb 2011 07:43:55 +1100 (EST)
Subject: Re: mpic_alloc: Differences between of_address_to_resource() and
	of_get_property()+of_translate_address()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Moffett, Kyle D" <Kyle.D.Moffett@boeing.com>
In-Reply-To: <031BE41A-C26B-419E-A515-F88C0BF4CA5D@boeing.com>
References: <031BE41A-C26B-419E-A515-F88C0BF4CA5D@boeing.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 25 Feb 2011 07:43:47 +1100
Message-ID: <1298580227.8833.419.camel@pasglop>
Mime-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-02-24 at 11:43 -0600, Moffett, Kyle D wrote:
> Hello everyone,
> 
> I'm currently cleaning up a new P2020 (mpc85xx) board port for submission and I was noticing a lot of commonalities between the various ports.
> 
> In particular, at least 80% of the mpic_alloc() callers seem to do something like this (with more error-checking):
> 
> struct resource r;
> of_address_to_resource(np, 0, &r);
> mpic_alloc(np, r.start, [...]);
> 
> But mpic_alloc() itself seems to have some logic for digging the base address out of OpenFirmware already:
> 
> if (paddr == 0 && !(mpic->flags & MPIC_USES_DCR)) {
>       const u32 *reg = of_get_property(node, "reg", NULL);
>       BUG_ON(reg == NULL);
>       paddr = of_translate_address(node, reg);
>       BUG_ON(paddr == OF_BAD_ADDR);
> }
> 
> As far as I can tell, the code in mpic_alloc() is a very limited form of of_address_to_resource() without a
> lot of the special cases, but I can't tell what the effect of those special cases would be on the boards
> relying on mpic_alloc(np, 0, [...]);

Probably none, ie, it's probably historical and could probably be
converted.

> I'd like to just convert mpic_alloc() to do the of_address_to_resource() internally (instead of the existing logic),
> but I'd be afraid of breaking other systems.
> 
> Any comments/advice?

I think it can be tried :-) The risk should be reasonably low.

Cheers,
Ben.

> Cheers,
> Kyle Moffett
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
