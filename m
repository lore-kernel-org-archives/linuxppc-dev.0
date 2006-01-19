Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.21])
	by ozlabs.org (Postfix) with SMTP id B444368A38
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jan 2006 19:50:45 +1100 (EST)
Date: Thu, 19 Jan 2006 09:50:43 +0100 (MET)
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
MIME-Version: 1.0
References: <1137625752.4823.157.camel@localhost.localdomain>
Subject: Re: AGPGART driver for ArticiaS - ioremap() problem
Message-ID: <11282.1137660643@www31.gmx.net>
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

> > Hmm, I'm not sure what value agp_bridge->gart_bus_addr should have. The
> > BIOS doesn't setup it and the VIA AGPGART driver even reads it out from
> > the northbridge's registers! Where does the value for
> > agp_bridge->gart_bus_addr come from? For now it is set to 0x0, which
> > would require the modification in drm_vm.c!?
> 
> Well... this is where you AGP aperture will be in bus space.. you'd
> rather know what to do with it to do a driver...
I'm afraid so. :)

> > :) The driver seems to work better with cant_use_aperture set to 1, so
> > I leave it as it is. BTW: What's the meaning of needs_scratch_page?
> 
> Well, set to 1 would mean the aperture isn't accessible on the CPU
> space. It might seem to work better either because indeed that is the
> case... or simply because you put it in a wrong place (ie 0 !) There
> must be a chipset register somewhere that tells you where the aperture
> is no ?
I set the AGP aperture base register and agp_bridge->gart_bus_addr to
0x01000000 (>=16MB) (trial and error :-) and it seems to work with
cant_use_aperture=1 (and without the modification in drm_vm.c). Even the X
server maps all the data to this address and displays a login screen.
Unfortunately it always freezes in. I guess this is due to the missing GART
flush functionality. So I have to get this working first.

Thanks!

Gerhard

-- 
Lust, ein paar Euro nebenbei zu verdienen? Ohne Kosten, ohne Risiko!
Satte Provisionen für GMX Partner: http://www.gmx.net/de/go/partner
