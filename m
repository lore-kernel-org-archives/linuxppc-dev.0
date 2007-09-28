Return-Path: <dgibson@ozlabs.org>
Date: Fri, 28 Sep 2007 15:22:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: libfdt: libfdt_env.h must be included first
Message-ID: <20070928052225.GC25743@localhost.localdomain>
References: <20070928045206.GA25743@localhost.localdomain>
	<20070928151322.a9dee5d9.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
In-Reply-To: <20070928151322.a9dee5d9.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 28, 2007 at 03:13:22PM +1000, Stephen Rothwell wrote:
> On Fri, 28 Sep 2007 14:52:06 +1000 David Gibson <david@gibson.dropbear.id=
=2Eau> wrote:
> >
> > libfdt.h currently includes fdt.h, then libfdt_env.h.  This is
> > incorrect, because depending on the environment into which libfdt is
> > embedded, libfdt_env.h may be needed to define datatypes used in
> > fdt.h.  This patch corrects the problem.
>=20
> So why doesn't fdt.h include libfdt_env.h, then?

Because libfdt_env.h is specifically for libfdt, whereas fdt.h
contains passive structures only, related to the flat tree structure
but without reference to any particular code for handling it.

Basically, fdt.h includes no other headers as a compromise to make it
more easily usable in various contexts.  In fact the only thing it
needs is the C99 fixed-width integer types, but I want it to be also
usable in contexts which don't have a <stdint.h> (e.g. the kernel
bootwrapper).

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG/I+RaILKxv3ab8YRAuGyAJ96W8qxPTqKFWfwUEXmJERnkeWEyQCdHjLb
M4CG1Vz8aAThHmSszLhdHR0=
=FqKl
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
