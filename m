Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 11AC3681B8
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jan 2006 08:24:42 +1100 (EST)
Subject: Re: AGPGART driver for ArticiaS - ioremap() problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <2557.1137487077@www21.gmx.net>
References: <1137453496.4823.61.camel@localhost.localdomain>
	<2557.1137487077@www21.gmx.net>
Content-Type: text/plain
Date: Wed, 18 Jan 2006 08:24:31 +1100
Message-Id: <1137533072.4823.92.camel@localhost.localdomain>
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


> That's the problem: we don't have the datasheet for the ArticiaS. :-( 
> But the driver initializes correctly with the Uninorth code now and with the
> DRI/DRM code changed. (The code in drm_vm.c checks for Apple's PCI vendor
> ID. Therefore I just added a check for MAI's PCI vendor ID.) But the X
> server freezes after the login screen is displayed (IIRC the mouse still
> works, but the keyboard is dead!?).

That check is only necessary because Apple bridge puts the AGP aperture
at bus address 0. This is probably not the case for you. You may not
have that right. Check what you put in agp_bridge->gart_bus_addr

> BTW: A "agp_special_page" is reserved in init.c. Is this page necessary for
> the DRI/DRM drivers to work with the Uninorth driver? I enabled this code
> snipped for the AmigaONE too to be on the safe side. :-)

It's, I think, still used by the r128 one, but it's not a very good
workaround.

> There may be another problem: it seems that it is not possible to flush the 
> TLB cache of the ArticiaS with a specific register setting. At least MAI
> didn't specify a bit for this purpose in the code. I have to do some reverse
> engineering here. :-)

Hrm... You definitely need a way to flush it

> >  - The AGP aperture itself. The main issue there is wether your chipset
> > makes the AGP aperture visible to the CPU or not. The Apple UniNorth one
> > doesn't for example, it;'s only visible to the graphic chip. That is why
> > the uninorth driver sets cant_use_aperture to 1. That forces the DRM to
> > generate AGP mappings by using the real memory pages and putting them
> > together into a virtual mapping instead of doing a direct mapping of the
> > AGP aperture on the bus. Most x86 chipsets however _can_, thus a simple
> > remapping of pages is enough.

> Good question! How would I have to modify the Uninorth driver to use a
> direct mapping of the AGP aperture on the bus?

Don't set cant_use_aperture to 1 :)

Ben.
