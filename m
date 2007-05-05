Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id DC73EDDE49
	for <linuxppc-dev@ozlabs.org>; Sun,  6 May 2007 00:40:11 +1000 (EST)
Date: Sat, 5 May 2007 09:41:49 -0500
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/4] Add support for 750CL Holly board
Message-ID: <20070505144149.GB21503@lixom.net>
References: <1178302414.3026.202.camel@zod.rchland.ibm.com>
	<200705042144.31194.arnd@arndb.de>
	<1178308913.3026.238.camel@zod.rchland.ibm.com>
	<200705051308.11457.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200705051308.11457.arnd@arndb.de>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, May 05, 2007 at 01:08:11PM +0200, Arnd Bergmann wrote:
> On Friday 04 May 2007, Josh Boyer wrote:
> > 
> > > If it's an IBM product, it should come with a product code like 123-4567,
> > > which fits in here, instead of just listing the CPU.
> > 
> > Erm... why? ?There are other boards that don't do this as well...
> 
> We did it on the Cell blade because we were asked to do it by
> the people responsible for the hardware, who were following
> their rules. I assumed that the same rules apply here as well,
> but maybe they are specific to the server line.
> 
> > > > --- linux-2.6.orig/drivers/net/tsi108_eth.h
> > > > +++ linux-2.6/drivers/net/tsi108_eth.h
> > > > @@ -49,7 +49,11 @@
> > > > ? */
> > > > ?#define PHY_MV88E??1???????/* Marvel 88Exxxx PHY */
> > > > ?#define PHY_BCM54XX????????2???????/* Broardcom BCM54xx PHY */
> > > > +#if defined(CONFIG_HOLLY)
> > > > +#define TSI108_PHY_TYPE PHY_BCM54XX
> > > > +#else
> > > > ?#define TSI108_PHY_TYPE????PHY_MV88E
> > > > +#endif
> > > > ?
> > > 
> > > this breaks multiplatform setups.
> > 
> > I know. ?Looking for a better suggestions. ?Kumar suggested a Kconfig
> > option at least, which is what I'm going to go with unless someone has a
> > better idea...
> 
> A Kconfig option won't help at all. The phy should come as a device node
> below the ethernet device. When probing the device, look at the
> "compatible" and "reg" properties in there.

In a perfect world, yes, but does it need to hold up the rest of the
code being merged if it's changed later? It's just used to blast a few
values at init time now, I'm suspecting to set things such as LED settings
(but I can't verify since I don't have any broadcom datasheets).

Even better long-term would be to have a phylib driver for the TSI and
autoprobe the model. Neither should have to hold up a board port merge
in my opinion.


-Olof
