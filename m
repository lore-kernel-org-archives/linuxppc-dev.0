Return-Path: <michael@ellerman.id.au>
Subject: Re: [POWERPC] mark BUG() as noreturn
From: Michael Ellerman <michael@ellerman.id.au>
To: Jimi Xenidis <jimix@watson.ibm.com>
In-Reply-To: <135B477D-5DF8-48E9-94FD-A114A4526177@watson.ibm.com>
References: <20060905120817.e52857ee.sfr@canb.auug.org.au>
	<20060918153853.f4332d2a.sfr@canb.auug.org.au>
	<20060920221558.1322b8b4.sfr@canb.auug.org.au>
	<1158768096.19375.6.camel@basalt.austin.ibm.com>
	<20060921100315.89d74f6f.sfr@canb.auug.org.au>
	<1158798041.7062.4.camel@localhost.localdomain>
	<20060921145522.366a3b03.sfr@canb.auug.org.au>
	<135B477D-5DF8-48E9-94FD-A114A4526177@watson.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-h1jieasavAye7lqXzOlN"
Date: Fri, 22 Sep 2006 10:54:05 +1000
Message-Id: <1158886446.8109.2.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, paulus@samba.org,
	Hollis Blanchard <hollisb@us.ibm.com>, ppc-dev <linuxppc-dev@ozlabs.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-h1jieasavAye7lqXzOlN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-09-21 at 08:18 -0400, Jimi Xenidis wrote:
> On Sep 21, 2006, at 12:55 AM, Stephen Rothwell wrote:
>=20
> > From an idea from Michael Ellerman.
> >
> > We finish the BUG() macro with a call to a function marked with =20
> > attribute
> > "noreturn" so that the compiler will know that BUG() and BUG_ON()
> > (with a constant, non-zero argument) will not return.
>=20
> But BUG() _can_ return, if I have a probe, xmon or kgdb configured it =20
> is possible  to play with the state of the world and try to continue/=20
> recover, (xmon "x" command).  IMHO, this is a powerful debugging =20
> scenario.

Hmm, ok I hadn't thought of that. Personally I've never tried to recover
from a BUG(), do people really do that much?

> Why are we concerned with the performance of this anyway?

Not so much the performance, more that it gives the compiler more
information about what's happening and allows it to elide code in some
circumstances - but it's not _that_ important.

Having it configurable might be an option, dunno.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-h1jieasavAye7lqXzOlN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBFEzQtdSjSd0sB4dIRAgpxAKC9pbKXB1NXuCv9eXDhqeX8kaFurgCcDaSk
4nKgYjBJQwhbvYyzDP4w/qo=
=2fmp
-----END PGP SIGNATURE-----

--=-h1jieasavAye7lqXzOlN--
