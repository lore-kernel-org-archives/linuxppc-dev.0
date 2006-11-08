Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: force 4k update_flash block and list sizes
From: Michael Ellerman <michael@ellerman.id.au>
To: John Rose <johnrose@austin.ibm.com>
In-Reply-To: <1162960202.14254.3.camel@sinatra.austin.ibm.com>
References: <1162943615.13499.15.camel@sinatra.austin.ibm.com>
	<20286.1162951582@neuling.org>
	<1162960202.14254.3.camel@sinatra.austin.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-RgGkTLd3NrCRXlH+Cqaj"
Date: Wed, 08 Nov 2006 15:41:00 +1100
Message-Id: <1162960860.20271.13.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: External List <linuxppc-dev@ozlabs.org>,
	Michael Neuling <mikey@neuling.org>, Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-RgGkTLd3NrCRXlH+Cqaj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-11-07 at 22:30 -0600, John Rose wrote:
> > kmem_cache_destroy doesn't return anything.
>=20
> Good call!  How's this:
>=20
> The enablement of 64k pages on POWER platforms exposed a quirk in the RTA=
S
> mechanism for updating firmware.  RTAS assumes 4k for flash block and lis=
t
> sizes, and use of any other sizes results in a failure.
>=20
> This patch changes the rtas_flash module to force the use of 4k memory bl=
ock
> and list sizes when preparing and sending a firmware image to RTAS.  It a=
lso
> changes rtas_flash to use a slab cache to ensure 4k alignment of flash bl=
ock
> data.  Such alignment is a documented requirement.

Just being picky .. but why did you decide to use the slab cache? Does
it make the code neater? I would have thought you could guarantee 4k
alignment some other way, and it seems slightly odd to use the slab
cache for something you only do once ..

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-RgGkTLd3NrCRXlH+Cqaj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFUV/cdSjSd0sB4dIRAgBzAJ9UddYsfrpGUFwrVGmKctdQ/QeW/QCgibDA
Bqm4tkKJyMfrSmBmUUMWgHU=
=0638
-----END PGP SIGNATURE-----

--=-RgGkTLd3NrCRXlH+Cqaj--
