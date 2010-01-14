Return-Path: <michael@ellerman.id.au>
Subject: Re: [RFC/PATCH] powerpc: Dynamically allocate pacas
From: Michael Ellerman <michael@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <23306.1263428782@neuling.org>
References: <39fb8f1aeab9940b86c940b9a5f8e6bd41ec316c.1263368253.git.michael@ellerman.id.au>
	<23306.1263428782@neuling.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-/SCGIRTdp5oMrkExwKbj"
Date: Thu, 14 Jan 2010 11:30:42 +1100
Message-ID: <1263429042.8733.13.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-/SCGIRTdp5oMrkExwKbj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2010-01-14 at 11:26 +1100, Michael Neuling wrote:
> > On 64-bit kernels we currently have a 512 byte struct paca_struct for
> > each cpu (usually just called "the paca"). Currently they are staticall=
y
> > allocated, which means a kernel built for a large number of cpus will
> > waste a lot of space if it's booted on a machine with few cpus.
> >=20
> > We can avoid that by only allocating the number of pacas we need at
> > boot. However this is complicated by the fact that we need to access
> > the paca before we know how many cpus there are in the system.
> >=20
> > The solution is to dynamically allocate enough space for NR_CPUS pacas,
> > but then later in boot when we know how many cpus we have, we free any
> > unused pacas.
> >=20
> > Lightly booted on Legacy iSeries & pSeries LPAR.
> >=20
> > Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
>=20
> Nice!
>=20
> <snip>
>=20
> > +	lmb_free(__pa(paca) + new_size, paca_size - new_size);
>=20
> You didn't explicitly mention this above but this depends on your
> lmb_free patch...

Ah yes, good point :)

> FYI boots bare metal

Sweet! Thanks for testing.

cheers


--=-/SCGIRTdp5oMrkExwKbj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAktOZa4ACgkQdSjSd0sB4dLF2wCglcfI8XdLHPlK+NkMBdrExOXe
6I8An2dY5EMuM+yac5hiL6bZP9WRoZvM
=rb4X
-----END PGP SIGNATURE-----

--=-/SCGIRTdp5oMrkExwKbj--
