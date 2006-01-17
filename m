Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.21])
	by ozlabs.org (Postfix) with SMTP id 8A86E689AE
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jan 2006 19:37:58 +1100 (EST)
Date: Tue, 17 Jan 2006 09:37:57 +0100 (MET)
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
MIME-Version: 1.0
References: <1137453496.4823.61.camel@localhost.localdomain>
Subject: Re: AGPGART driver for ArticiaS - ioremap() problem
Message-ID: <2557.1137487077@www21.gmx.net>
Content-Type: text/plain; charset="iso-8859-1"
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> --- Urspr¸ngliche Nachricht ---
> Von: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> An: Gerhard Pircher <gerhard_pircher@gmx.net>
> Kopie: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
> Betreff: Re: AGPGART driver for ArticiaS - ioremap() problem
> Datum: Tue, 17 Jan 2006 10:18:15 +1100
> 
> > Ah, okay. So at least the approach to use the Uninorth code was a step
> > in the right direction. But that requires changes in the DRI and X
> > server code, right?
> 
> Not you shouldn't... there are 2 different things here. One is how you
> access the GART table itself. One is how you access the AGP memory (the
> memory that is bound to the GART).
> 
> I'm not 100% sure what of the 2 above cases triggered an error with
> ioremap, I'm not sure what approach should be used, because i don't know
> what your chipset does.
That's the problem: we don't have the datasheet for the ArticiaS. :-( 
But the driver initializes correctly with the Uninorth code now and with the
DRI/DRM code changed. (The code in drm_vm.c checks for Apple's PCI vendor
ID. Therefore I just added a check for MAI's PCI vendor ID.) But the X
server freezes after the login screen is displayed (IIRC the mouse still
works, but the keyboard is dead!?).

BTW: A "agp_special_page" is reserved in init.c. Is this page necessary for
the DRI/DRM drivers to work with the Uninorth driver? I enabled this code
snipped for the AmigaONE too to be on the safe side. :-)

> I would need more infos about the hw there. But the basic idea is:
> 
>  - For the GART table, you don't need to ioremap it (which is generally
> a way to have it non-cacheable I suppose). You can just flush cache
> entries after populating them (see uninorth_insert_memory(), it flushes
> first the pages that are being inserted in the GART as AGP memory is not
> cacheable neither, and at the end of the function, flushes the GART
> entry proper).
There may be another problem: it seems that it is not possible to flush the 
TLB cache of the ArticiaS with a specific register setting. At least MAI
didn't specify a bit for this purpose in the code. I have to do some reverse
engineering here. :-)

>  - The AGP aperture itself. The main issue there is wether your chipset
> makes the AGP aperture visible to the CPU or not. The Apple UniNorth one
> doesn't for example, it;'s only visible to the graphic chip. That is why
> the uninorth driver sets cant_use_aperture to 1. That forces the DRM to
> generate AGP mappings by using the real memory pages and putting them
> together into a virtual mapping instead of doing a direct mapping of the
> AGP aperture on the bus. Most x86 chipsets however _can_, thus a simple
> remapping of pages is enough.
Good question! How would I have to modify the Uninorth driver to use a
direct mapping of the AGP aperture on the bus?

Thanks!

Gerhard

-- 
DSL-Aktion wegen groﬂer Nachfrage bis 28.2.2006 verl‰ngert:
GMX DSL-Flatrate 1 Jahr kostenlos* http://www.gmx.net/de/go/dsl
