Return-Path: <sfr@canb.auug.org.au>
Date: Sat, 24 Sep 2005 10:48:27 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Mackerras <paulus@samba.org>
Message-Id: <20050924104827.114939ca.sfr@canb.auug.org.au>
In-Reply-To: <17204.38908.767118.59625@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.61.0509231408170.3791@nylon.am.freescale.net>
	<17204.38908.767118.59625@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sat__24_Sep_2005_10_48_27_+1000_PAIeZo_aRsMgMX1F"
Cc: michael@ellerman.id.au, linuxppc-dev@ozlabs.org, arnd@arndb.de,
	galak@freescale.com, linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: merged asm/cputable.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sat__24_Sep_2005_10_48_27_+1000_PAIeZo_aRsMgMX1F
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 24 Sep 2005 10:04:12 +1000 Paul Mackerras <paulus@samba.org> wrote:
>
> Kumar Gala writes:
>=20
> > +#ifdef __powerpc64__
> > +extern struct cpu_spec		*cur_cpu_spec;
> > +#else /* __powerpc64__ */
> > +extern struct cpu_spec		*cur_cpu_spec[];
> > +#endif /* __powerpc64__ */
>=20
> I would like to see this unified - it makes no sense for them to be
> different.  We are unlikely to support asymmetric multiprocessing any
> time soon, so let's go with the single cur_cpu_spec pointer (a la
> ppc64).

Michael Ellerman also has a patch that makes this a struct (i.e. not a
pointer) which allows us to mark the array of cpuspec's that we test
against at boot time as __init.  Maybe he could do the ppc32 single
cpu_spec as part of that.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__24_Sep_2005_10_48_27_+1000_PAIeZo_aRsMgMX1F
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDNKJgFdBgD/zoJvwRAjQ8AJ4x6xsrXt9AvVM7VVqYOW6kCH6XlACbB0/E
JBKMV4oPAnfWBR+6u8ds1Bc=
=pJtX
-----END PGP SIGNATURE-----

--Signature=_Sat__24_Sep_2005_10_48_27_+1000_PAIeZo_aRsMgMX1F--
