Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D616A6893F
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jan 2006 10:09:24 +1100 (EST)
Subject: Re: AGPGART driver for ArticiaS - ioremap() problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <14295.1137613254@www12.gmx.net>
References: <1137533072.4823.92.camel@localhost.localdomain>
	<14295.1137613254@www12.gmx.net>
Content-Type: text/plain
Date: Thu, 19 Jan 2006 10:09:11 +1100
Message-Id: <1137625752.4823.157.camel@localhost.localdomain>
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

On Wed, 2006-01-18 at 20:40 +0100, Gerhard Pircher wrote:
> > > That's the problem: we don't have the datasheet for the ArticiaS. :-( 
> > > But the driver initializes correctly with the Uninorth code now and
> > > with the DRI/DRM code changed. (The code in drm_vm.c checks for Apple's
> > > PCI vendor ID. Therefore I just added a check for MAI's PCI vendor ID.)
> > > But the X server freezes after the login screen is displayed (IIRC the
> > > mouse still works, but the keyboard is dead!?).
> > 
> > That check is only necessary because Apple bridge puts the AGP aperture
> > at bus address 0. This is probably not the case for you. You may not
> > have that right. Check what you put in agp_bridge->gart_bus_addr

> Hmm, I'm not sure what value agp_bridge->gart_bus_addr should have. The BIOS
> doesn't setup it and the VIA AGPGART driver even reads it out from the
> northbridge's registers! Where does the value for agp_bridge->gart_bus_addr
> come from? For now it is set to 0x0, which would require the modification in
> drm_vm.c!?

Well... this is where you AGP aperture will be in bus space.. you'd
rather know what to do with it to do a driver...

> :) The driver seems to work better with cant_use_aperture set to 1, so I
> leave it as it is. BTW: What's the meaning of needs_scratch_page?

Well, set to 1 would mean the aperture isn't accessible on the CPU
space. It might seem to work better either because indeed that is the
case... or simply because you put it in a wrong place (ie 0 !) There
must be a chipset register somewhere that tells you where the aperture
is no ?

Ben.
