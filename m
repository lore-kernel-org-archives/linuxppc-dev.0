Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7B13F681BB
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jan 2006 10:18:28 +1100 (EST)
Subject: Re: AGPGART driver for ArticiaS - ioremap() problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <19548.1137399114@www099.gmx.net>
References: <1137367531.4823.42.camel@localhost.localdomain>
	<19548.1137399114@www099.gmx.net>
Content-Type: text/plain
Date: Tue, 17 Jan 2006 10:18:15 +1100
Message-Id: <1137453496.4823.61.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Ah, okay. So at least the approach to use the Uninorth code was a step in
> the right direction. But that requires changes in the DRI and X server code,
> right?

Not you shouldn't... there are 2 different things here. One is how you
access the GART table itself. One is how you access the AGP memory (the
memory that is bound to the GART).

I'm not 100% sure what of the 2 above cases triggered an error with
ioremap, I'm not sure what approach should be used, because i don't know
what your chipset does. I would need more infos about the hw there. But
the basic idea is:

 - For the GART table, you don't need to ioremap it (which is generally
a way to have it non-cacheable I suppose). You can just flush cache
entries after populating them (see uninorth_insert_memory(), it flushes
first the pages that are being inserted in the GART as AGP memory is not
cacheable neither, and at the end of the function, flushes the GART
entry proper).

 - The AGP aperture itself. The main issue there is wether your chipset
makes the AGP aperture visible to the CPU or not. The Apple UniNorth one
doesn't for example, it;'s only visible to the graphic chip. That is why
the uninorth driver sets cant_use_aperture to 1. That forces the DRM to
generate AGP mappings by using the real memory pages and putting them
together into a virtual mapping instead of doing a direct mapping of the
AGP aperture on the bus. Most x86 chipsets however _can_, thus a simple
remapping of pages is enough.

Ben.
