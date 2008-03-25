Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 1E557DDFCC
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 02:51:46 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: OF compatible MTD platform RAM driver ?
Date: Tue, 25 Mar 2008 16:51:31 +0100
References: <200803101606.39184.laurentp@cse-semaphore.com>
	<200803251536.17795.laurentp@cse-semaphore.com>
	<47E91A5B.1060406@ru.mvista.com>
In-Reply-To: <47E91A5B.1060406@ru.mvista.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1509009.ud9OxWemcf";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200803251651.42608.laurentp@cse-semaphore.com>
Cc: ben@simtec.co.uk, linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1509009.ud9OxWemcf
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Sergei,

On Tuesday 25 March 2008 16:29, Sergei Shtylyov wrote:
> Hello.
>=20
> Laurent Pinchart wrote:
>=20
> >>>>>here is the sram entry in our dts:
>=20
> >>>>Except that your implementation of it is not good.
>=20
> >>>>You're relying on the old obsolete flash binding with the "probe-type"
> >>>>field.  The solution should be adapted to the new approach which uses
> >>>>values in the "compatible" field to indicate various sorts of flash
> >>>>device.
>=20
> >>>What "compatible" values should I use for ROM and RAM mappings ?
>=20
> >>That I'm not so sure of.  We'll need to find some consensus.
>=20
> >>There may be existing IEEE1275 bindings for roms, which we should
> >>investigate.
>=20
> > Do you (or someone else here) have access to the IEEE1275 specification=
 ? Is=20
>=20
>     Yeah, and I can point you to it -- see the documantation section on=20
> http://www.openbios.org/...

Thanks a lot for the pointer.

> > there any ROM binding in there ?
>=20
>     No. We initially called the flash devices that physmap_of driver=20
> controlled "rom" (I mean the "device_type" property) -- now this is obsol=
eted.
>=20
> >>Arguably RAM should be represented by a memory node, but=20
> >>that's going to get messy for this sort of application.
>=20
>     Note that the OF "memory" type nodes do *not* represent RAM devices.
>=20
> > We're talking about a very specific type of RAM, used for permanent sto=
rage=20
> > with a battery backup. The RAM is really meant to be used as an MTD dev=
ice=20
> > and as such I think it makes sense to describe it as an mtd-compatible =
device=20
> > on the local bus.
>=20
> > What about the following definition for the RAM node ?
>=20
> >         nvram@2,0000 {
>=20
>     Note that there's a OF "device_type" of "nvram", so your (generic) de=
vice=20
> name seems to add some mess. (IIRC, that OF device type didn't actually=20
> represent a "real" device, and only served to provide access to NVRAM for=
 OF).

Ok.

> >                 compatible =3D "mtd,ram";
>=20
>     The part before comma should be a company name or a stock ticker. Wha=
t did=20
> you mean here?

I didn't know that. Let's say I meant "mtd-ram" :-)

> >                 reg =3D <2 0x0000 0x00100000>;
> >                 bank-width =3D <2>;
> >         };
>=20
> > Or should the node have a device-type property of either 'ram' or 'rom'=
 with=20
> > the compatible property just referencing MTD ?
>=20
>     The "device_type" properties are not required and their further creat=
ion=20
> has been discouraged on liunxppc-dev.

What about

	mtdram@2,0000 {
		compatible =3D "mtd-ram";
		reg =3D <2 0x0000 0x00100000>;
		bank-width =3D <2>;
	};

ROMs could use "mtd-rom" for their compatible property.

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=E9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1509009.ud9OxWemcf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBH6R+O8y9gWxC9vpcRAjmRAJ9PZj/+KY8fFg6/bfI8me5ivje06QCguR7E
1UoOb0cvvpX5p70BhGuAXaw=
=iahI
-----END PGP SIGNATURE-----

--nextPart1509009.ud9OxWemcf--
