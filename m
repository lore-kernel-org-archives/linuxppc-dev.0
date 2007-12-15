Return-Path: <b07421@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5BC0ADDDEE
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Dec 2007 14:51:24 +1100 (EST)
Date: Fri, 14 Dec 2007 21:48:57 -0600
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v2 2/4] mpc8313erdb: Add NAND to device tree,
	and call of_platform_bus_probe().
Message-ID: <20071215034857.GA20533@ld0162-tx32.am.freescale.net>
References: <20071214185826.GB10584@loki.buserror.net>
	<20071215015543.GD6935@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071215015543.GD6935@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Dec 15, 2007 at 12:55:43PM +1100, David Gibson wrote:
> > +		// CS0 and CS1 are swapped when
> > +		// booting from nand, but the
> > +		// addresses are the same.
> 
> Should the bootwrapper have some kind of fixup to poke in the correct
> chipselect values based on the state?
> 
> Or should we have a function to fill in the elbc's ranges property
> based on the bridge control registers, as we do for the ebc on 4xx.

We could, though I'm inclined to be lazy about it since nothing really
cares (well, the elbc nand code *does* care which chip select it's on,
but it figures it out by matching the address in the localbus registers).

-Scott
