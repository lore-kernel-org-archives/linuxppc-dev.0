Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.21])
	by ozlabs.org (Postfix) with SMTP id B2ECC681BD
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jan 2006 06:41:03 +1100 (EST)
Date: Wed, 18 Jan 2006 20:40:54 +0100 (MET)
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
MIME-Version: 1.0
References: <1137533072.4823.92.camel@localhost.localdomain>
Subject: Re: AGPGART driver for ArticiaS - ioremap() problem
Message-ID: <14295.1137613254@www12.gmx.net>
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > That's the problem: we don't have the datasheet for the ArticiaS. :-( 
> > But the driver initializes correctly with the Uninorth code now and
> > with the DRI/DRM code changed. (The code in drm_vm.c checks for Apple's
> > PCI vendor ID. Therefore I just added a check for MAI's PCI vendor ID.)
> > But the X server freezes after the login screen is displayed (IIRC the
> > mouse still works, but the keyboard is dead!?).
> 
> That check is only necessary because Apple bridge puts the AGP aperture
> at bus address 0. This is probably not the case for you. You may not
> have that right. Check what you put in agp_bridge->gart_bus_addr
Hmm, I'm not sure what value agp_bridge->gart_bus_addr should have. The BIOS
doesn't setup it and the VIA AGPGART driver even reads it out from the
northbridge's registers! Where does the value for agp_bridge->gart_bus_addr
come from? For now it is set to 0x0, which would require the modification in
drm_vm.c!?

> > >  - The AGP aperture itself. The main issue there is wether your
> > > chipset makes the AGP aperture visible to the CPU or not. The Apple
> > > UniNorth one doesn't for example, it;'s only visible to the graphic
> > > chip. That is why the uninorth driver sets cant_use_aperture to 1.
> > > That forces the DRM to generate AGP mappings by using the real memory 
> > > pages and putting them together into a virtual mapping instead of
> > > doing a direct mapping of the AGP aperture on the bus. Most x86
> > > chipsets however _can_, thus a simple remapping of pages is enough.
> 
> > Good question! How would I have to modify the Uninorth driver to use a
> > direct mapping of the AGP aperture on the bus?
> 
> Don't set cant_use_aperture to 1 :)
:) The driver seems to work better with cant_use_aperture set to 1, so I
leave it as it is. BTW: What's the meaning of needs_scratch_page?

Thanks for your support!

Gerhard

-- 
10 GB Mailbox, 100 FreeSMS/Monat http://www.gmx.net/de/go/topmail
+++ GMX - die erste Adresse für Mail, Message, More +++
