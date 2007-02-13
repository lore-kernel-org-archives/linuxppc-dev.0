Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 4/16] powerpc: Allow duplicate lmb_reserve() calls
From: Michael Ellerman <michael@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <21160.1171350320@neuling.org>
References: <20070213061024.82D45DDD0D@ozlabs.org>
	<21160.1171350320@neuling.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-C2Cd0Wezofai9FVTAp9Q"
Date: Tue, 13 Feb 2007 19:48:56 +1100
Message-Id: <1171356536.18083.9.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-C2Cd0Wezofai9FVTAp9Q
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-02-13 at 18:05 +1100, Michael Neuling wrote:
> > At present calling lmb_reserve() (and hence lmb_add_region()) twice
> > for exactly the same memory region will cause strange behaviour.
> >=20
> > This makes life difficult when booting from a flat device tree with
> > memory reserve map.  Which regions are automatically reserved by the
> > kernel has changed over time, so it's quite possible a newer kernel
> > could attempt to auto-reserve a region which is also explicitly listed
> > in the device tree's reserve map, leading to trouble.
> >=20
> > This patch avoids the problem by making lmb_reserve() ignore a call to
> > reserve a previously reserved region.  It also removes a now redundant
> > test designed to avoid one specific case of the problem noted above.
> >=20
> > At present, this patch deals only with duplicate reservations of an
> > identical region.  Attempting to reserve two different, but
> > overlapping regions will still cause problems.  I might post another
> > patch later dealing with this case, but I'm avoiding it now since it
> > is substantially more complicated to deal with, less likely to occur
> > and more likely to indicate a genuine bug elsewhere if it does occur.
> >=20
> > Signed-off-by: David Gibson <dwg@au1.ibm.com>
> > ---
> >=20
> >=20
> >  arch/powerpc/kernel/prom.c |    3 ---
> >  arch/powerpc/mm/lmb.c      |    4 ++++
> >  2 files changed, 4 insertions(+), 3 deletions(-)
> >=20
> > Index: working-2.6/arch/powerpc/mm/lmb.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- working-2.6.orig/arch/powerpc/mm/lmb.c	2007-02-06 16:21:02.00000000=
0 +
> 1100
> > +++ working-2.6/arch/powerpc/mm/lmb.c	2007-02-06 16:22:32.000000000 +11=
00
> > @@ -146,6 +146,10 @@ static long __init lmb_add_region(struct
> >  		unsigned long rgnbase =3D rgn->region[i].base;
> >  		unsigned long rgnsize =3D rgn->region[i].size;
> > =20
> > +		if ((rgnbase =3D=3D base) && (rgnsize =3D=3D size))
> > +			/* Already have this region, so we're done */
> > +			return 0;
>=20
> This might indicate that two things actually want to use the same memory
> region.  How about we print a warning?

It'd be nice, but it'll spit out lots of spurious warnings for exactly
the reason David describes - things that used to be in the reserve map
are now auto reserved.

What we probably should warn for is overlapping, but not duplicated
regions - I can't think if any reason that _doesn't_ indicate a bug.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-C2Cd0Wezofai9FVTAp9Q
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBF0Xt4dSjSd0sB4dIRAtaIAJ4vtxb0T3TTJSIBjhMQtl8T0MK9AwCdFc31
NvCYBcqKnT5YYIiEjaUoPHY=
=mXz0
-----END PGP SIGNATURE-----

--=-C2Cd0Wezofai9FVTAp9Q--
