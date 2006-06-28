Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] Assume we're on cpu 0 in early boot
From: Michael Ellerman <michael@ellerman.id.au>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17569.56937.308576.848377@cargo.ozlabs.ibm.com>
References: <787248AD-2E47-454E-9F56-7E5350A9F184@watson.ibm.com>
	<20060627040036.469B767B28@ozlabs.org>
	<17569.56937.308576.848377@cargo.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-pDX4r7yvrP50LtLOfzJn"
Date: Wed, 28 Jun 2006 12:11:20 +1000
Message-Id: <1151460680.12350.8.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-pDX4r7yvrP50LtLOfzJn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-06-28 at 11:42 +1000, Paul Mackerras wrote:
> Michael Ellerman writes:
>=20
> > There's a small period early in boot where we don't know which cpu we'r=
e
> > running on. That's ok, except that it means we have no paca, or more
> > correctly that our paca pointer points somewhere random.
> >=20
> > So that we can safely call things like smp_processor_id(), we need a pa=
ca,
> > so just assume we're on cpu 0. No code should _write_ to the paca befor=
e
> > we've set the correct one up.
>=20
> OK, but why not just do a setup_paca(0) at the start of early_setup(),
> in C code?  You can also remove the redundant paca setting in
> start_here_common() in head_64.S.

Yep, duh. New patch RSN.

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-pDX4r7yvrP50LtLOfzJn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEoeVHdSjSd0sB4dIRAvI2AKCWNOZXNMp3Rp2RCnvlqcCK++WnhwCfWjhP
OqSgpJX0ObJ3rqyj4yi6Spg=
=SgSV
-----END PGP SIGNATURE-----

--=-pDX4r7yvrP50LtLOfzJn--
