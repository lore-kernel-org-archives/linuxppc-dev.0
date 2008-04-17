Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 222E2DDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 22:08:49 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH] powerpc: Implement GPIO LIB API on CPM2 Freescale SoC.
Date: Thu, 17 Apr 2008 14:08:43 +0200
References: <200804171148.11593.laurentp@cse-semaphore.com>
	<200804171311.46781.laurentp@cse-semaphore.com>
	<480732C9.9080800@scram.de>
In-Reply-To: <480732C9.9080800@scram.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5814556.xPrFek32Yl";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200804171408.46533.laurentp@cse-semaphore.com>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart5814556.xPrFek32Yl
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 17 April 2008 13:21, Jochen Friedrich wrote:
> Hi Laurent,
>=20
> >> http://patchwork.ozlabs.org/linuxppc/patch?id=3D16282
> >=20
> > The link doesn't seem to be related.
>=20
> http://patchwork.ozlabs.org/linuxppc/patch?id=3D17490 is the correct one.=
=20

Thanks.

> > I'll rework the patch to move CPM2 GPIO support to cpm_common.c. Have y=
ou=20
> > thought about a proper name for the compatible property ?
>=20
> I would leave cpm_init_par_io() in cpm2.c and just move the other parts.
> - for cpm2, the property fsl,cpm2-pario-bank is correct.
> - for cpm1, i'm thinking of something like fsl,cpm1-pario-bank32b and=20
fsl,cpm1-pario-bank32e.

Any preference for common function names ? cpm2_gpio32* might be too=20
CPM2-specific for cpm_common.c. cpm_gpio32* is a bit too generic as it=20
doesn't support port E on the CPM1.

BTW, what's the purpose of the shadow data register in the CPM GPIO chip=20
structure ? As the set operation is protected by a spinlock, the only use I=
=20
can think of is to prevent changing bits in the PDAT register for pins=20
configured as inputs. Is that correct ? If so this should be clearly=20
documented in the code.

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart5814556.xPrFek32Yl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBIBz3O8y9gWxC9vpcRAqsWAJ9QzcWicr24ZImsFiqFeis9ksCgsQCgl9PL
8eTeKfdRaX1MlkkU/h+tJGc=
=shIa
-----END PGP SIGNATURE-----

--nextPart5814556.xPrFek32Yl--
