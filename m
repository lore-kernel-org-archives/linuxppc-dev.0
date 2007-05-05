Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id DADCDDDED5
	for <linuxppc-dev@ozlabs.org>; Sat,  5 May 2007 21:08:14 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/4] Add support for 750CL Holly board
Date: Sat, 5 May 2007 13:08:11 +0200
References: <1178302414.3026.202.camel@zod.rchland.ibm.com>
	<200705042144.31194.arnd@arndb.de>
	<1178308913.3026.238.camel@zod.rchland.ibm.com>
In-Reply-To: <1178308913.3026.238.camel@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200705051308.11457.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 04 May 2007, Josh Boyer wrote:
>=20
> > If it's an IBM product, it should come with a product code like 123-456=
7,
> > which fits in here, instead of just listing the CPU.
>=20
> Erm... why? =A0There are other boards that don't do this as well...

We did it on the Cell blade because we were asked to do it by
the people responsible for the hardware, who were following
their rules. I assumed that the same rules apply here as well,
but maybe they are specific to the server line.

> > > --- linux-2.6.orig/drivers/net/tsi108_eth.h
> > > +++ linux-2.6/drivers/net/tsi108_eth.h
> > > @@ -49,7 +49,11 @@
> > > =A0 */
> > > =A0#define PHY_MV88E=A0=A01=A0=A0=A0=A0=A0=A0=A0/* Marvel 88Exxxx PHY=
 */
> > > =A0#define PHY_BCM54XX=A0=A0=A0=A0=A0=A0=A0=A02=A0=A0=A0=A0=A0=A0=A0/=
* Broardcom BCM54xx PHY */
> > > +#if defined(CONFIG_HOLLY)
> > > +#define TSI108_PHY_TYPE PHY_BCM54XX
> > > +#else
> > > =A0#define TSI108_PHY_TYPE=A0=A0=A0=A0PHY_MV88E
> > > +#endif
> > > =A0
> >=20
> > this breaks multiplatform setups.
>=20
> I know. =A0Looking for a better suggestions. =A0Kumar suggested a Kconfig
> option at least, which is what I'm going to go with unless someone has a
> better idea...

A Kconfig option won't help at all. The phy should come as a device node
below the ethernet device. When probing the device, look at the
"compatible" and "reg" properties in there.

	Arnd <><
