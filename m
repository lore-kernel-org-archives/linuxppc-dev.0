Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: fix call to subpage_protection()
From: Michael Ellerman <michael@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <25179.1290111882@neuling.org>
References: <1289418856.2983.23.camel@localhost>
	<1289426817.2147.1403.camel@pasglop>
	<1289520464.4752.12.camel@localhost>
	<17075.1289877977@neuling.org> <1289958663.3028.175.camel@localhost>
	<27638.1289959435@neuling.org> <1290020404.2974.15.camel@localhost>
	<13149.1290047579@neuling.org> <1290082861.22575.6.camel@concordia>
	<25179.1290111882@neuling.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-WqUVHjzaz66NAXNgtIFw"
Date: Fri, 19 Nov 2010 08:53:03 +1100
Message-ID: <1290117183.29105.4.camel@concordia>
Mime-Version: 1.0
Cc: Jim Keniston <jkenisto@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
	David Gibson <david@gibson.dropbear.id.au>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-WqUVHjzaz66NAXNgtIFw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2010-11-19 at 07:24 +1100, Michael Neuling wrote:
> > On Thu, 2010-11-18 at 13:32 +1100, Michael Neuling wrote:
> > > In:=3D20
> > >   powerpc/mm: Fix pgtable cache cleanup with CONFIG_PPC_SUBPAGE_PROT
> > >   commit d28513bc7f675d28b479db666d572e078ecf182d
> > >   Author: David Gibson <david@gibson.dropbear.id.au>
> > >=3D20
> > > subpage_protection() was changed to to take an mm rather a pgdir but =
it
> > > didn't change calling site in hashpage_preload().  The change wasn't
> > > noticed at compile time since hashpage_preload() used a void* as the
> > > parameter to subpage_protection().
> > ...=3D20
> > >=3D20
> > > diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_u=
tils=3D
> > _64.c
> > > index 83f534d..5e95844 100644
> > > --- a/arch/powerpc/mm/hash_utils_64.c
> > > +++ b/arch/powerpc/mm/hash_utils_64.c
> > > @@ -1123,7 +1123,7 @@ void hash_preload(struct mm_struct *mm, unsigne=
d lo=3D
> > ng ea,
> > >  	else
> > >  #endif /* CONFIG_PPC_HAS_HASH_64K */
> > >  		rc =3D3D __hash_page_4K(ea, access, vsid, ptep, trap, local, ssiz
> e,
> > > -				    subpage_protection(pgdir, ea));
> > > +				    subpage_protection(mm, ea));
> >=20
> > Type checking is fun :)
> >=20
> > This is stable material no?
>=20
> Yes.  In the bit you snipped was a:
>=20
>   cc: stable@kernel.org (only 2.6.33 and newer)

Oh right, I thought you actually had to send it to them :D

> Fortunately it's not in 2.6.32 so the bug missed the distros.

Phew.

cheers



--=-WqUVHjzaz66NAXNgtIFw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkzloDoACgkQdSjSd0sB4dIZIACgyhzZrlyn07GHyzkRbABeuyDt
D8YAoKBdP2dWHz06HL6kF8RR9T1miND4
=0Xus
-----END PGP SIGNATURE-----

--=-WqUVHjzaz66NAXNgtIFw--
