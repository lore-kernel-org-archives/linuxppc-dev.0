Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id EEFDCDE154
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jun 2008 00:36:19 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: "Mark Ware" <mark.ware@senetas.com>
Subject: Re: CPM2 mii-bitbang: Allowing mdio on port pins other than port C
Date: Wed, 18 Jun 2008 16:36:08 +0200
References: <49B96DF39F2CDD499DA8B9C7753A060D2275FC@stamp.senetas.com>
	<200806161052.53268.laurentp@cse-semaphore.com>
	<49B96DF39F2CDD499DA8B9C7753A060D25B387@stamp.senetas.com>
In-Reply-To: <49B96DF39F2CDD499DA8B9C7753A060D25B387@stamp.senetas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1434910.qYO8vUUxrD";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200806181636.10758.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1434910.qYO8vUUxrD
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Mark,

On Wednesday 18 June 2008 14:21, Mark Ware wrote:
> Hi Laurent,
> > Hi Mark,
> >=20
> > On Monday 16 June 2008 08:19, Mark Ware wrote:
> > > Hello,
> > >=20
> > > I am preparing a board port (from 2.4.18!) for a proprietary board=20
> > > which has it's mdio on a different port than mdc.  The current=20
> > > mii-bitbang driver in fs_enet assumes both pins are=20
> > connected to port=20
> > > C.  I have created a fairly simple patch to make this more=20
> > flexible,=20
> > > but I'm new to device trees and am unsure how best to describe the=20
> > > situation in the dts.
> > >=20
> > > The current mdio node for CPM2 looks something like:
> > >=20
> > > mdio@10d40 {
> > >   device_type =3D "mdio";
> > >   compatible =3D "fsl,cpm2-mdio-bitbang";
> > >   #address-cells =3D <1>;
> > >   #size-cells =3D <0>
> > >   reg =3D <0x10d40 0x14>;
> > >   fsl,mdio-pin =3D <12>;
> > >   fsl,mdc-pin =3D <15>;
> > > }
> > >=20
> > > I have made mdio work on our board by adding a second reg range and=20
> > > using the first one for mdc and the second one for mdio:
> > >=20
> > >   reg =3D <0x10d40 0x14 0x10d60 0x14>;  // mdc=3Dport D, mdio=3Dport A
> > >   fsl,mdio-pin =3D <12>;    		  // PD12
> > >   fsl,mdc-pin =3D <15>;     		  // PC15
> > >=20
> > > The code remains backwards compatible, in that if only one=20
> > reg range=20
> > > is present it is used for both.
> > >=20
> > > Is this a valid (and acceptable) way to extend the reg property?
> >=20
> > It is. Sergej Stepanov submitted similar patches some times=20
> > ago. You can find them at
> >=20
> > http://www.spinics.net/lists/netdev/msg45778.html
> > http://www.spinics.net/lists/netdev/msg47159.html
> >=20
> > > Is their a cleaner way I should look at?
> >=20
> > Using the GPIO lib might be cleaner. Have a look at=20
> > http://www.nabble.com/-PATCH-0-2--MDIO-on-GPIO-support-for-the
> > -fs_enet-driver-ts17468958.html
> > for a patch.
> >=20
>=20
> Thanks for the links.  It looks like I should have been searching in
> netdev not powerpc for this.
>=20
> I will look at Sergej's patch and perhaps submit a merged version, but
> with the GPIO version likely to be merged is there much point?  The GPIO
> lib method appears to be a more generic replacement.

I don't see much reason to use the non-GPIO version (except maybe on very=20
memory constrained platforms to avoid pulling the GPIO lib in the kernel, b=
ut=20
that would help much).

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1434910.qYO8vUUxrD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBIWR1a8y9gWxC9vpcRAkJsAJsEGLfKoNuqgpR31qmj3DC0Pska3ACfaQ2I
StDfQn+sS9UENZpyUNPqIo8=
=ejZg
-----END PGP SIGNATURE-----

--nextPart1434910.qYO8vUUxrD--
