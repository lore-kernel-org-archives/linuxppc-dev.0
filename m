Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 49F8A68A03
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jan 2006 09:09:27 +1100 (EST)
Subject: Re: AGPGART driver for ArticiaS - ioremap() problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <15255.1137667967@www31.gmx.net>
References: <1137664796.4823.214.camel@localhost.localdomain>
	<15255.1137667967@www31.gmx.net>
Content-Type: text/plain
Date: Fri, 20 Jan 2006 09:09:13 +1100
Message-Id: <1137708554.12998.31.camel@localhost.localdomain>
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

On Thu, 2006-01-19 at 11:52 +0100, Gerhard Pircher wrote:
> > > I set the AGP aperture base register and agp_bridge->gart_bus_addr to
> > > 0x01000000 (>=16MB) (trial and error :-) and it seems to work with
> > > cant_use_aperture=1 
> > 
> > Makes sense, since this value is right in the middle of your RAM :) What
> > does the firmware sets the base register too ?
> I did a readout of all AGP related registers and the base register was set
> to 0x0, so the firmware doesn't set it up at all.
> 
> > Can't you try to allocate some resource in the PCI area that isn't
> > already occupied instead ?
> I though the GART base address should be in memory space!?

Euh... I was talking about the aperture base, not the GART base... (One
is the address one the bus where the AGP area will be visible, the other
is where the GART will be in memory, that is the table that contains the
mapping between AGP pages and memory pages).

> Sorry for this dumb question: how can I allocate a resource in the PCI area?
> I'm not yet familiar with the whole Linux PCI/MM API. :) With something like
> pci_alloc_consistent()?

Nope... look at drivers/pci/setup-res.c how it does for allocating new
resources for PCI devices.

> > (and without the modification in drm_vm.c). Even the X
> > > server maps all the data to this address and displays a login screen.
> > > Unfortunately it always freezes in. I guess this is due to the missing
> > > GART flush functionality. So I have to get this working first.
> > 
> > Yah, that would be pretty bad...
> Indeed! :)
> 
> Gerhard
> 
