Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id F03C2DE186
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 01:21:56 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC fs_enet: Convert MII bitbang driver to use GPIO lib
Date: Tue, 22 Apr 2008 17:21:49 +0200
References: <200804161640.42693.laurentp@cse-semaphore.com>
	<200804221055.09038.laurentp@cse-semaphore.com>
	<20080422150844.GA15474@ld0162-tx32.am.freescale.net>
In-Reply-To: <20080422150844.GA15474@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7754085.EtRBLvCEaQ";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200804221721.51461.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart7754085.EtRBLvCEaQ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 22 April 2008 17:08, Scott Wood wrote:
> On Tue, Apr 22, 2008 at 10:55:06AM +0200, Laurent Pinchart wrote:
> > On Monday 21 April 2008 19:56, Scott Wood wrote:
> > > The memory-constrained platform I had in mind was 8xx, which doesn't =
use
> > > bitbanged MDIO.  It might nice to keep the gpiolib bit separate to av=
oid
> > > situations such as ep8248e where mdiobb would be the only thing
> > > requiring a gpiolib binding, though -- but it shouldn't be two separa=
te
> > > bitbang drivers, just the existing bitbang driver plus some glue code
> > > that binds it to gpiolib.
> >=20
> > I would be fine with that if the glue code wasn't 90% of the whole driv=
er.=20
> > There is really little (not to say nothing) that can be shared between =
the=20
> > two drivers.
>=20
> I think we're thinking of a different pair of drivers...  I thought you
> were talking about duplicating drivers/net/phy/mdio-bitbang.c, not
> drivers/net/fs_enet/mii-bitbang.c.

I don't plan to touch drivers/net/phy/mdio-bitbang.c at all, it does its jo=
b=20
well enough.

As the openfirmware + gpio + mdio driver might benefit non-powerpc platform=
s,=20
I plan to create a new driver (probably drivers/net/phy/mdio-ofgpio.c) that=
=20
mostly ports drivers/net/fs_enet/mii-bitbang.c to the gpiolib (this replace=
s=20
around 90% of the code).

If both drivers/net/fs_enet/mii-bitbang.c and drivers/net/phy/mdio-ofgpio.c=
=20
must live together, I'll have a problem in=20
drivers/net/fs_enet/fs_enet-main.c. The net device probing code searches th=
e=20
device tree for an associated PHY, and creates a PHY id from the PHY node. =
As=20
the id will be generated from different bus ids in the two mdio drivers (th=
e=20
bus number is the register address for drivers/net/fs_enet/mii-bitbang.c, a=
nd=20
is the gpio index for drivers/net/phy/mdio-ofgpio.c), things will break.

Any idea regarding how to get rid of that fs_enet/mii-bitbang hardcoded=20
dependency ?

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart7754085.EtRBLvCEaQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBIDgKP8y9gWxC9vpcRApzFAKCfVzy5Qq41QGki7X0HrrgTs17O/wCfZZDM
eIDyQoYpoiBhUGzDmRvOadI=
=YuPM
-----END PGP SIGNATURE-----

--nextPart7754085.EtRBLvCEaQ--
