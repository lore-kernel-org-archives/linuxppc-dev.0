Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 7FD4BDE7C5
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 03:44:48 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: OF compatible MTD platform RAM driver ?
Date: Tue, 25 Mar 2008 17:44:42 +0100
References: <200803101606.39184.laurentp@cse-semaphore.com>
	<200803251651.42608.laurentp@cse-semaphore.com>
	<47E926FB.3030900@ru.mvista.com>
In-Reply-To: <47E926FB.3030900@ru.mvista.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6354502.gbtd3JDiyu";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200803251744.46001.laurentp@cse-semaphore.com>
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

--nextPart6354502.gbtd3JDiyu
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 25 March 2008 17:23, Sergei Shtylyov wrote:
> Laurent Pinchart wrote:
>=20
> >>>We're talking about a very specific type of RAM, used for permanent=20
storage=20
> >>>with a battery backup. The RAM is really meant to be used as an MTD=20
device=20
> >>>and as such I think it makes sense to describe it as an mtd-compatible=
=20
device=20
> >>>on the local bus.
>=20
> >>>What about the following definition for the RAM node ?
>=20
> >>>        nvram@2,0000 {
>=20
> >>    Note that there's a OF "device_type" of "nvram", so your (generic)=
=20
device=20
> >>name seems to add some mess. (IIRC, that OF device type didn't actually=
=20
> >>represent a "real" device, and only served to provide access to NVRAM f=
or=20
OF).
>=20
> > Ok.
>=20
>     Well, I might have gone too far here -- it should be a real device=20
> (spec'ed in Device Support Extensions recommended practice). It's just th=
at=20
> the spec didn't mention "reg" property, only "#bytes" (the device capacit=
y).=20
> So, it may be worth considering...

The nvram device descrived in the Device Support Extensions is probably mea=
nt=20
to describe the kind of nvram found in RTC chips. That memory isn't directl=
y=20
accessible. As the spec doesn't mention this explicitely we could still reu=
se=20
the nvram device type for direct-mapped battery-backed ram. I have no stron=
g=20
opinion for or against that.

> >>>                compatible =3D "mtd,ram";
>=20
> >>    The part before comma should be a company name or a stock ticker. W=
hat=20
did=20
> >>you mean here?
>=20
> > I didn't know that. Let's say I meant "mtd-ram" :-)
>=20
> >>>                reg =3D <2 0x0000 0x00100000>;
> >>>                bank-width =3D <2>;
> >>>        };
>=20
> >>>Or should the node have a device-type property of either 'ram' or 'rom=
'=20
with=20
> >>>the compatible property just referencing MTD ?
>=20
> >>    The "device_type" properties are not required and their further=20
creation=20
> >>has been discouraged on liunxppc-dev.
>=20
> > What about
>=20
> > 	mtdram@2,0000 {
> > 		compatible =3D "mtd-ram";
> > 		reg =3D <2 0x0000 0x00100000>;
> > 		bank-width =3D <2>;
> > 	};
>=20
> > ROMs could use "mtd-rom" for their compatible property.
>=20
>     Heh, there was a whole company against mentioning "mtd" when we start=
ed=20
> working on this (of course, the first idea was to call the flash device t=
ype=20
> "mtd"). I don't think "mtd" looks good here -- I'd suggest "flash-ram" (i=
f=20
> this is just a linearly mapped NVRAM).

I'm fine with "flash-ram" (even thought it looks a bit weird). I'll prepare=
 a=20
patch.

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=E9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart6354502.gbtd3JDiyu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBH6Sv98y9gWxC9vpcRAgtPAJ0aSONVtY/c6F6WnCCXr3Uqp9OwNwCg0Ewb
xNaWaFOYIQ80bBYRfFL85Rs=
=iULb
-----END PGP SIGNATURE-----

--nextPart6354502.gbtd3JDiyu--
