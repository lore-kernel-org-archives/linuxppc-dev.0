Return-Path: <michael@ellerman.id.au>
Subject: Re: lmb_remove_region - bad decrementing...
From: Michael Ellerman <michael@ellerman.id.au>
To: Siva Prasad <sprasad@bivio.net>
In-Reply-To: <D83235F0F3C86D4D889D8B9A0DA8C6D746E786@corpexc01.corp.networkrobots.com>
References: <D83235F0F3C86D4D889D8B9A0DA8C6D746E786@corpexc01.corp.networkrobots.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-izd3mHRaSKy8+J4Eisce"
Date: Tue, 20 Mar 2007 17:12:30 +1100
Message-Id: <1174371150.10827.17.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-izd3mHRaSKy8+J4Eisce
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-03-19 at 13:00 -0700, Siva Prasad wrote:
> Hi,
>=20
> This is based on 2.6.19 kernel.
>=20
> In the file mm/lmb.c, we have function lmb_remove_region. In this
> function we are decrementing the region count even if the condition
> fails and we don't necessarily remove the region.
>=20
> For example ...
>=20
> static void __init lmb_remove_region(struct lmb_region *rgn, unsigned
> long r)
> {
>         unsigned long i;
>=20
>         for (i =3D r; i < rgn->cnt - 1; i++) {
>                 rgn->region[i].base =3D rgn->region[i + 1].base;
>                 rgn->region[i].size =3D rgn->region[i + 1].size;
>         }
>         rgn->cnt--;
> }
>=20
> Shound't the region count be decremented only if r > rgn->cnt -1. When
> we initially setup lmb, cnt will be 1, and as part of other functions,
> this gets called with out even increasing this number. So, region does
> not get removed, but cnt does get decremented by 1.
>=20
> At least a quick fix like this "if (rgn->cnt > 1) rgn->cnt--;" should
> serve for now.
>=20
> Same thing happens at routine lmb_enfore_memory_limit. Actually
> lmb_remove_region gets called from here and the problem starts. So, "i"
> should not be decremented here, if the initial condition fails.
>=20
> What do you guys think?

I agree that's a bug in lmb_remove_region(), but I can't see how it's
ever triggered.

I can't see how lmb_enforce_memory_limit() would hit the bug either. Can
you give more detail?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-izd3mHRaSKy8+J4Eisce
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBF/3tOdSjSd0sB4dIRAmscAJ4wcqOjPATMsYB1oeI4PIDZ82940QCggOGq
9rnSKVSDCrN238vxaB3qHeo=
=r5V5
-----END PGP SIGNATURE-----

--=-izd3mHRaSKy8+J4Eisce--
