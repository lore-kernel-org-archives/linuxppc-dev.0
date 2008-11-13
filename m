Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 1/4] Add helpers for finding a device node which as a
	certain property
From: Michael Ellerman <michael@ellerman.id.au>
To: David Miller <davem@davemloft.net>
In-Reply-To: <1226558945.7856.27.camel@localhost>
References: <2743c30c538d24a0befee055bd6e0fcd746d0e82.1226550015.git.michael@ellerman.id.au>
	<20081112.224648.106631825.davem@davemloft.net>
	<1226558945.7856.27.camel@localhost>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-DLlZ9TGH5DAAL+VVSUbb"
Date: Thu, 13 Nov 2008 18:11:43 +1100
Message-Id: <1226560303.7856.38.camel@localhost>
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


--=-DLlZ9TGH5DAAL+VVSUbb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-11-13 at 17:49 +1100, Michael Ellerman wrote:
> On Wed, 2008-11-12 at 22:46 -0800, David Miller wrote:
> > From: Michael Ellerman <michael@ellerman.id.au>
> > Date: Thu, 13 Nov 2008 15:20:35 +1100 (EST)
> >=20
> > > +	np =3D from ? from->allnext : allnodes;
> > > +	for (; np; np =3D np->allnext) {
> > > +		for (pp =3D np->properties; pp !=3D 0; pp =3D pp->next) {
> > > +			if (of_prop_cmp(pp->name, prop_name) =3D=3D 0) {
> > > +				goto out;
> > > +			}
> > > +		}
> > > +	}
> >=20
> > We're starting to duplicate a lot of code in this file.
>=20
> Agreed.
>=20
> > Perhaps split out the locked section of of_find_proeprty() into
> > a __of_find_property() and use that here and in of_find_property()
> > as well?
>=20
> Yeah I thought about it, but decided it wasn't worth it. But I'll try it
> and see how the sizes end up.

With my compiler (4.3.1) it just gets inlined and actually makes the
text 8 bytes larger. We might be using different CFLAGs to sparc though.

I didn't think it made the source significantly clearer to split out the
of_find_property() logic, especially seeing as we don't need the lenp
behaviour in of_find_node_with_property().

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-DLlZ9TGH5DAAL+VVSUbb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkb0y8ACgkQdSjSd0sB4dIMGQCgkUTDhemvw5qsmUMOTb8hAh1K
BZkAn0OqhLkslzu/sNHpVILcTyHwNYg8
=hJcB
-----END PGP SIGNATURE-----

--=-DLlZ9TGH5DAAL+VVSUbb--
