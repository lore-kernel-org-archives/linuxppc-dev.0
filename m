Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EC5B7DE410
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 01:37:04 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m3MFarHR010690
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 08:36:54 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m3MFaqqj025397
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 10:36:53 -0500 (CDT)
Date: Tue, 22 Apr 2008 10:36:52 -0500
From: Scott Wood <scottwood@freescale.com>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [RFC fs_enet: Convert MII bitbang driver to use GPIO lib
Message-ID: <20080422153652.GF15474@ld0162-tx32.am.freescale.net>
References: <200804161640.42693.laurentp@cse-semaphore.com>
	<200804221055.09038.laurentp@cse-semaphore.com>
	<20080422150844.GA15474@ld0162-tx32.am.freescale.net>
	<200804221721.51461.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200804221721.51461.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 22, 2008 at 05:21:49PM +0200, Laurent Pinchart wrote:
> As the openfirmware + gpio + mdio driver might benefit non-powerpc platforms, 
> I plan to create a new driver (probably drivers/net/phy/mdio-ofgpio.c) that 
> mostly ports drivers/net/fs_enet/mii-bitbang.c to the gpiolib (this replaces 
> around 90% of the code).
> 
> If both drivers/net/fs_enet/mii-bitbang.c and drivers/net/phy/mdio-ofgpio.c 
> must live together, 

The only reason I can see for that would be if the gpiolib version
doesn't work on arch/ppc -- but that's not going to be a problem for very
much longer.

> I'll have a problem in drivers/net/fs_enet/fs_enet-main.c. The net
> device probing code searches the device tree for an associated PHY, and
> creates a PHY id from the PHY node. As the id will be generated from
> different bus ids in the two mdio drivers (the bus number is the
> register address for drivers/net/fs_enet/mii-bitbang.c, and is the gpio
> index for drivers/net/phy/mdio-ofgpio.c), things will break.
> 
> Any idea regarding how to get rid of that fs_enet/mii-bitbang hardcoded 
> dependency ?

If mii-bitbang is only used on arch/ppc, then #ifdef CONFIG_PPC_MERGE
should do it.

It'd be nice to be able to give phylib an OF node rather than a string,
though...

-Scott
