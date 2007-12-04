Return-Path: <Tony.Li@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 442E2DDE05
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 20:20:38 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	lB49KWKu029486
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Dec 2007 02:20:33 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id lB49KVK2028899
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Dec 2007 03:20:32 -0600 (CST)
Subject: Re: [PATCH] Add IPIC MSI interrupt support
From: Li Li <r64360@freescale.com>
To: benh@kernel.crashing.org
In-Reply-To: <1196754717.13230.286.camel@pasglop>
References: <1196394519.29683.8.camel@Guyver>
	<1196654521.13554.32.camel@concordia>
	<1196672870.14353.21.camel@Guyver>
	<1196746689.20158.4.camel@concordia>
	<1196754717.13230.286.camel@pasglop>
Content-Type: text/plain
Date: Tue, 04 Dec 2007 17:10:10 +0800
Message-Id: <1196759410.28693.5.camel@Guyver>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Gala Kumar <kumar.gala@freescale.com>, Li Tony <Tony.Li@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Yes. According to the PCI spec, a PCI device can request multi MSI
interrupts and require that interrupts are consecutive.
But it is ok if only allocate one to it.
Anyway, the hwirq should be allocated from bitmap instead of increment
by hand.

I will correct this and resend the patch.

- Tony

On Tue, 2007-12-04 at 15:51 +0800, Benjamin Herrenschmidt wrote:
> > I'm not sure what you mean? For MSI there is only one MSI per
> device, 
> > but this code is used also for MSI-X which supports > 1 MSI per
> device.
> 
> Or more specifically, for MSI, -linux- supports only one per device
> (in 
> theory, it's possible to have multiple MSI non-X but it's a mess).
> 
> > Either way we shouldn't be incrementing hwirq by hand, it's
> reassigned 
> > at the top of the loop. I think that's left over from old code that 
> > allocated nvec hwirqs in a block and then created virq mappings for
> each 
> > one, whereas the new code allocates each hwirq separately. 
> > 
> > cheers 
> > 
> > _______________________________________________ 
> > Linuxppc-dev mailing list 
> > Linuxppc-dev@ozlabs.org 
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
