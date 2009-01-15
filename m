Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 2/4] powerpc: Add ppc_progress() wrapper
From: Michael Ellerman <michael@ellerman.id.au>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18799.7994.553829.470138@cargo.ozlabs.ibm.com>
References: <e3520e2f9806d4f6e4b30587b6d29176e583833d.1232001793.git.michael@ellerman.id.au>
	<3922453a668745466cb291f889d2c067932e4894.1232001793.git.michael@ellerman.id.au>
	<18799.7994.553829.470138@cargo.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-K+2UhrvpjQcTr+MsiAhr"
Date: Fri, 16 Jan 2009 10:09:30 +1100
Message-Id: <1232060970.30268.2.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-K+2UhrvpjQcTr+MsiAhr
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2009-01-15 at 22:34 +1100, Paul Mackerras wrote:
> Michael Ellerman writes:
>=20
> > There's quite a lot of code that does:
> >=20
> > if (ppc_md.progress)
> > 	ppc_md.progress(...)
> >=20
> > So move that idiom into a wrapper. Having a wrapper also allows us
> > to have a fallback to printk if no progress routine is specified.
>=20
> It certainly used to be the case on ppc32 (and may still be) that
> ppc_md.progress was called very very early, in some cases before the
> MMU was set up, so we don't want to call printk from it.  Falling back
> to udbg_printf would be more appropriate.

Except on some platforms udbg_printf() doesn't work. And all the
platforms that care still can and do use udbg_progress().

This just saves us having several implementations of progress that just
call printk().

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-K+2UhrvpjQcTr+MsiAhr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAklvwioACgkQdSjSd0sB4dJdHQCgzHiAgdZr5DiEf7Ye9j7ATqFv
dOsAmwYf+SDsFTs89urIkZmDqqsJYV5H
=kIyz
-----END PGP SIGNATURE-----

--=-K+2UhrvpjQcTr+MsiAhr--
