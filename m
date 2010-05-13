Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] [POWEPC] crashdump: do not fail on null pointer
	dereferencing
From: Michael Ellerman <michael@ellerman.id.au>
To: Vitaly Wool <vitalywool@gmail.com>
In-Reply-To: <AANLkTinTprEzXRIFeJfu6TEvPqj24UBjrrZN3MtZD6LH@mail.gmail.com>
References: <20100511154108.11546.12066.stgit@muvarov>
	<AANLkTinTprEzXRIFeJfu6TEvPqj24UBjrrZN3MtZD6LH@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-liqv3gQEbUwpAcn7Zk0Z"
Date: Thu, 13 May 2010 11:25:02 +1000
Message-ID: <1273713902.25436.6.camel@concordia>
Mime-Version: 1.0
Cc: Maxim Uvarov <muvarov@gmail.com>, uvarov@dev.rtsoft.ru,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-liqv3gQEbUwpAcn7Zk0Z
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2010-05-11 at 18:02 +0200, Vitaly Wool wrote:
> Hi,
>=20
> > diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
> > index 6f4613d..341d8af 100644
> > --- a/arch/powerpc/kernel/crash.c
> > +++ b/arch/powerpc/kernel/crash.c
> > @@ -375,6 +375,9 @@ void default_machine_crash_shutdown(struct pt_regs =
*regs)
> >        for_each_irq(i) {
> >                struct irq_desc *desc =3D irq_to_desc(i);
> >
> > +               if (!desc || !desc->chip || !desc->chip->eoi)
> > +                       continue;
> > +

Actually almost certain that desc will be NULL. When CONFIG_SPARSE_IRQ=3Dy
(the default), irq_desc's are allocated lazily.

cheers

--=-liqv3gQEbUwpAcn7Zk0Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkvrVO4ACgkQdSjSd0sB4dLQDgCeKcryuuD2j9JibByyUj9TdNCh
nQsAoMmHIRfJ7o1c9oLGsbEKEvPVFUyO
=q29b
-----END PGP SIGNATURE-----

--=-liqv3gQEbUwpAcn7Zk0Z--
