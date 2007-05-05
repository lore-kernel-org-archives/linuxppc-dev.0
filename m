Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3EAC1DDED0
	for <linuxppc-dev@ozlabs.org>; Sat,  5 May 2007 21:50:08 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l45AmVpP016720
	for <linuxppc-dev@ozlabs.org>; Sat, 5 May 2007 06:48:31 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l45BnxUn510736
	for <linuxppc-dev@ozlabs.org>; Sat, 5 May 2007 07:50:00 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l45Bnxgo007346
	for <linuxppc-dev@ozlabs.org>; Sat, 5 May 2007 07:49:59 -0400
Subject: Re: [PATCH 1/4] Add support for 750CL Holly board
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200705051308.11457.arnd@arndb.de>
References: <1178302414.3026.202.camel@zod.rchland.ibm.com>
	<200705042144.31194.arnd@arndb.de>
	<1178308913.3026.238.camel@zod.rchland.ibm.com>
	<200705051308.11457.arnd@arndb.de>
Content-Type: text/plain
Date: Sat, 05 May 2007 06:44:51 -0500
Message-Id: <1178365491.3393.15.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2007-05-05 at 13:08 +0200, Arnd Bergmann wrote:
> On Friday 04 May 2007, Josh Boyer wrote:
> > 
> > > If it's an IBM product, it should come with a product code like 123-4567,
> > > which fits in here, instead of just listing the CPU.
> > 
> > Erm... why?  There are other boards that don't do this as well...
> 
> We did it on the Cell blade because we were asked to do it by
> the people responsible for the hardware, who were following
> their rules. I assumed that the same rules apply here as well,
> but maybe they are specific to the server line.

I've heard of no such rule from the people I've been working with.  This
is an internal matter though, so I'll do some checking.

> > > > --- linux-2.6.orig/drivers/net/tsi108_eth.h
> > > > +++ linux-2.6/drivers/net/tsi108_eth.h
> > > > @@ -49,7 +49,11 @@
> > > >   */
> > > >  #define PHY_MV88E  1       /* Marvel 88Exxxx PHY */
> > > >  #define PHY_BCM54XX        2       /* Broardcom BCM54xx PHY */
> > > > +#if defined(CONFIG_HOLLY)
> > > > +#define TSI108_PHY_TYPE PHY_BCM54XX
> > > > +#else
> > > >  #define TSI108_PHY_TYPE    PHY_MV88E
> > > > +#endif
> > > >  
> > > 
> > > this breaks multiplatform setups.
> > 
> > I know.  Looking for a better suggestions.  Kumar suggested a Kconfig
> > option at least, which is what I'm going to go with unless someone has a
> > better idea...
> 
> A Kconfig option won't help at all. The phy should come as a device node
> below the ethernet device. When probing the device, look at the
> "compatible" and "reg" properties in there.

A Kconfig option is better than what's currently there, but yes I know
what you mean.  The phys are already part of the device tree, so I think
I'll add a compatible property as you suggested and add that to the
hw_info structure that the ethernet driver uses to init things.

Seems silly to carry this around in a data structure for a single use,
but I don't see another way of doing it while still making the
multiplatform thing happy.

josh
