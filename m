Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] cell: fix ras.c compilation
From: Michael Ellerman <michael@ellerman.id.au>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <Pine.LNX.4.64.0811030920310.11062@vixen.sonytel.be>
References: <20081102202157.GA11316@x200.localdomain>
	<Pine.LNX.4.64.0811030920310.11062@vixen.sonytel.be>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-9n5F+S7EloQEELspF+Gu"
Date: Mon, 03 Nov 2008 19:40:02 +1100
Message-Id: <1225701602.3303.1.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Alexey Dobriyan <adobriyan@gmail.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-9n5F+S7EloQEELspF+Gu
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2008-11-03 at 09:20 +0100, Geert Uytterhoeven wrote:
> On Sun, 2 Nov 2008, Alexey Dobriyan wrote:
> > arch/powerpc/platforms/cell/ras.c:299: error: implicit declaration of f=
unction 'crash_shutdown_register'
> >=20
> > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> > ---
> >=20
> >  arch/powerpc/platforms/cell/ras.c |    1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > --- a/arch/powerpc/platforms/cell/ras.c
> > +++ b/arch/powerpc/platforms/cell/ras.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/kexec.h>
> >  #include <linux/crash_dump.h>
> > =20
> > +#include <asm/kexec.h>
>=20
> #include <linux/kexec.h>?

That struck me too. But the generic header only includes the arch one if
CONFIG_KEXEC=3Dy, and this code needs things from asm/kexec.h even when it
=3Dn. So I think this is the best fix.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-9n5F+S7EloQEELspF+Gu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkOuOIACgkQdSjSd0sB4dIFvACgq+U2fHxz40Kpb5Xo1nDEeRdq
mRoAnRYPndJzt5KMUOvrmYNRSCafyFaM
=BZ//
-----END PGP SIGNATURE-----

--=-9n5F+S7EloQEELspF+Gu--
