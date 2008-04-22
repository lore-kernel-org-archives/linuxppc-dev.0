Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 54F6ADE2F0
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 01:55:18 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC fs_enet: Convert MII bitbang driver to use GPIO lib
Date: Tue, 22 Apr 2008 17:55:13 +0200
References: <200804161640.42693.laurentp@cse-semaphore.com>
	<200804221721.51461.laurentp@cse-semaphore.com>
	<20080422153652.GF15474@ld0162-tx32.am.freescale.net>
In-Reply-To: <20080422153652.GF15474@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart302224798.BdsxPmyOVS";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200804221755.16419.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart302224798.BdsxPmyOVS
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 22 April 2008 17:36, Scott Wood wrote:
> On Tue, Apr 22, 2008 at 05:21:49PM +0200, Laurent Pinchart wrote:
> > As the openfirmware + gpio + mdio driver might benefit non-powerpc
> > platforms, I plan to create a new driver (probably
> > drivers/net/phy/mdio-ofgpio.c) that mostly ports
> > drivers/net/fs_enet/mii-bitbang.c to the gpiolib (this replaces around =
90%
> > of the code).=20
> >=20
> > If both drivers/net/fs_enet/mii-bitbang.c and
> > drivers/net/phy/mdio-ofgpio.c must live together,=20
>=20
> The only reason I can see for that would be if the gpiolib version
> doesn't work on arch/ppc -- but that's not going to be a problem for very
> much longer.

Didn't you mention platforms such as ep8248e as well, where mdiobb would be=
=20
the only gpiolib user ?

> > I'll have a problem in drivers/net/fs_enet/fs_enet-main.c. The net
> > device probing code searches the device tree for an associated PHY, and
> > creates a PHY id from the PHY node. As the id will be generated from
> > different bus ids in the two mdio drivers (the bus number is the
> > register address for drivers/net/fs_enet/mii-bitbang.c, and is the gpio
> > index for drivers/net/phy/mdio-ofgpio.c), things will break.
> >=20
> > Any idea regarding how to get rid of that fs_enet/mii-bitbang hardcoded=
=20
> > dependency ?
>=20
> If mii-bitbang is only used on arch/ppc, then #ifdef CONFIG_PPC_MERGE
> should do it.

Ok.

> It'd be nice to be able to give phylib an OF node rather than a string,
> though...

Doesn't phylib have non-OF users ?

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart302224798.BdsxPmyOVS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBIDgpk8y9gWxC9vpcRAtnxAKCwMCFAZ3dgPenUhBPlK7nmteGShwCg3rFg
4zTbqvIzFgPWrlejeiXYSp0=
=iaMS
-----END PGP SIGNATURE-----

--nextPart302224798.BdsxPmyOVS--
