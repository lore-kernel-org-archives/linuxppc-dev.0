Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.21])
	by ozlabs.org (Postfix) with SMTP id 1DA6B689DA
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jan 2006 21:52:48 +1100 (EST)
Date: Thu, 19 Jan 2006 11:52:47 +0100 (MET)
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
MIME-Version: 1.0
References: <1137664796.4823.214.camel@localhost.localdomain>
Subject: Re: AGPGART driver for ArticiaS - ioremap() problem
Message-ID: <15255.1137667967@www31.gmx.net>
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

> > I set the AGP aperture base register and agp_bridge->gart_bus_addr to
> > 0x01000000 (>=16MB) (trial and error :-) and it seems to work with
> > cant_use_aperture=1 
> 
> Makes sense, since this value is right in the middle of your RAM :) What
> does the firmware sets the base register too ?
I did a readout of all AGP related registers and the base register was set
to 0x0, so the firmware doesn't set it up at all.

> Can't you try to allocate some resource in the PCI area that isn't
> already occupied instead ?
I though the GART base address should be in memory space!?
Sorry for this dumb question: how can I allocate a resource in the PCI area?
I'm not yet familiar with the whole Linux PCI/MM API. :) With something like
pci_alloc_consistent()?

> > (and without the modification in drm_vm.c). Even the X
> > server maps all the data to this address and displays a login screen.
> > Unfortunately it always freezes in. I guess this is due to the missing
> > GART flush functionality. So I have to get this working first.
> 
> Yah, that would be pretty bad...
Indeed! :)

Gerhard

-- 
Lust, ein paar Euro nebenbei zu verdienen? Ohne Kosten, ohne Risiko!
Satte Provisionen für GMX Partner: http://www.gmx.net/de/go/partner
