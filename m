Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH linux-next] powerpc/powermac: Add missing of_node_put
From: Michael Ellerman <michael@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20081207164333.78b69d16.sfr@canb.auug.org.au>
References: <200812021445.18670.npalix@diku.dk>
	<20081206163449.60757c4a.akpm@linux-foundation.org>
	<18747.13668.304923.709761@cargo.ozlabs.ibm.com>
	<20081207164333.78b69d16.sfr@canb.auug.org.au>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-sShMn4szOhljCE+rqAJ6"
Date: Mon, 08 Dec 2008 10:58:18 +1100
Message-Id: <1228694298.21407.4.camel@localhost>
Mime-Version: 1.0
Cc: Nicolas Palix <npalix@diku.dk>, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Julia Lawall <julia@diku.dk>, Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-sShMn4szOhljCE+rqAJ6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2008-12-07 at 16:43 +1100, Stephen Rothwell wrote:
> Hi Paul,
>=20
> On Sun, 7 Dec 2008 13:31:00 +1100 Paul Mackerras <paulus@samba.org> wrote=
:
> >
> > I'm really in two minds about applying any of the of_node_put patches
> > that only affect powermacs.  The reference counts only matter on
> > platforms where we update the OF device tree at runtime, which is
> > currently only IBM pSeries machines.  Since we don't have any hotplug
> > on powermacs, and never will have, the OF device tree is completely
> > static and we don't actually need refcounts on the nodes at all, so
> > who cares if they're a bit higher than they might be?
> >=20
> > In particular, the VIA whose node we're looking for here is built-in
> > on the motherboard, and there can never be more than one, and it can
> > never be removed.
>=20
> I my mind it is about consistent use of the API and good examples for
> people to copy.  Also, in about a year you will be presented with the
> same set of patches when a new pair of eyes looks at the same code and
> notices the discrepancy ...

what-he-said++

Allowing the ref counting to be broken in one part of the code is just
asking for it to be broken everywhere.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-sShMn4szOhljCE+rqAJ6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkk8YxoACgkQdSjSd0sB4dLZNQCgyF3wpfe6bGtBVSwpMA+aeuHZ
fPYAoIcOJVfxjbYD+Y2o+zFlXfymVLTz
=g47Z
-----END PGP SIGNATURE-----

--=-sShMn4szOhljCE+rqAJ6--
