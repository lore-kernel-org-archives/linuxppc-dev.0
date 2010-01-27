Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Dynamically allocate pacas
From: Michael Ellerman <michael@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <4389.1264575576@neuling.org>
References: <c22a0fd3d76675813ce5f1596d80614aee80ed24.1264568410.git.michael@ellerman.id.au>
	<4389.1264575576@neuling.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-1nSLQA4e0MaAXqtFY904"
Date: Thu, 28 Jan 2010 09:47:25 +1100
Message-ID: <1264632445.6352.6.camel@concordia>
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


--=-1nSLQA4e0MaAXqtFY904
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2010-01-27 at 17:29 +1030, Michael Neuling wrote:
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
> <snip>
>=20
> > --- a/arch/powerpc/kernel/setup-common.c
> > +++ b/arch/powerpc/kernel/setup-common.c
> > @@ -493,6 +493,8 @@ void __init smp_setup_cpu_maps(void)
> >  	 * here will have to be reworked
> >  	 */
> >  	cpu_init_thread_core_maps(nthreads);
> > +
> > +	free_unused_pacas();
>=20
> This is still barfing for me on 32bit.

Darn, what config? I built at least one :)

> Putting an #include <asm/paca.h> at the top of setup-common.c fixes it.

Gah, I saw it was coming via somewhere else but decided not to add it,
wrong decision :)

cheers

--=-1nSLQA4e0MaAXqtFY904
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAktgwnkACgkQdSjSd0sB4dL+XgCgyWwhljyQ+UvA6n2gIq64atka
IK0AoJ7iBYAEH+RAoMxmhYBi0MmF7BFq
=i8YG
-----END PGP SIGNATURE-----

--=-1nSLQA4e0MaAXqtFY904--
