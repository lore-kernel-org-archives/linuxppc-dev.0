Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41MPbp1zxYzDqFG
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jul 2018 16:15:34 +1000 (AEST)
Date: Fri, 6 Jul 2018 16:15:28 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH kernel v4 2/2] KVM: PPC: Check if IOMMU page is contained
 in the pinned physical page
Message-ID: <20180706061528.GR3450@umbus.fritz.box>
References: <20180705080133.18690-1-aik@ozlabs.ru>
 <20180705080133.18690-3-aik@ozlabs.ru>
 <874lhclx8h.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="U5J2I87mWnf1KeOw"
In-Reply-To: <874lhclx8h.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--U5J2I87mWnf1KeOw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 06, 2018 at 04:00:30PM +1000, Michael Ellerman wrote:
> Alexey Kardashevskiy <aik@ozlabs.ru> writes:
>=20
> > diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_=
context_iommu.c
> > index abb4364..11e1029 100644
> > --- a/arch/powerpc/mm/mmu_context_iommu.c
> > +++ b/arch/powerpc/mm/mmu_context_iommu.c
> > @@ -159,6 +161,7 @@ long mm_iommu_get(struct mm_struct *mm, unsigned lo=
ng ua, unsigned long entries,
> >  		goto unlock_exit;
> >  	}
> > =20
> > +	mem->pageshift =3D __builtin_ctzl(ua | (entries << PAGE_SHIFT));
>=20
> __builtin_ctzl(0) is undefined, so are we guaranteed that
> (ua | (entries << PAGE_SHIFT)) is never zero? I couldn't convince
> myself.

We certainly don't need to care about that case, since registering a
zero-length region (entries =3D=3D 0) is no-op.  But maybe we need to
filter it above.

> > @@ -199,9 +202,17 @@ long mm_iommu_get(struct mm_struct *mm, unsigned l=
ong ua, unsigned long entries,
> >  			}
> >  		}
> >  populate:
> > +		pageshift =3D PAGE_SHIFT;
> > +		if (PageCompound(page))
> > +			pageshift +=3D compound_order(compound_head(page));
> > +		mem->pageshift =3D min(mem->pageshift, pageshift);
> >  		mem->hpas[i] =3D page_to_pfn(page) << PAGE_SHIFT;
> >  	}
> > =20
> > +	/* We have an incomplete huge page, default to PAGE_SHIFT */
> > +	if (head)
> > +		mem->pageshift =3D PAGE_SHIFT;
> > +
>=20
> You never set head AFIACS? (other than in the initialiser)

That looks like a leftover from the previous version.

>=20
> cheers
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--U5J2I87mWnf1KeOw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls/CP0ACgkQbDjKyiDZ
s5Ky0w//RqIEhp0lUVry33Myak4z86/4FjOln7Mbf8/TgR+OtpdBUlDzBgDZm9IW
jRNE228Lycm9ZQ5a5ncBjjfLGvQFK38y9U7IVKQoe1l33QlkJaB5C2WReF8hcXQo
L4nXMVnNVYcSjRVP2uNbPrqgRedgEkebryr9+y+cYQ7Rsze9+5GkZW7XyBgJwy9Q
0sQtLonpjOZYxOj3J1S55z9cVZ0raz56Jej8itMfRogvSHSoclKx4fnMQ0As2SBD
oV8uvXYue5Kbb0jvvoNMF6ZtCyvn1pea4TArm9YAbv8GEKWcaPdYNA3X1/4z/za9
zDQB1YWc2EIVk9SKqyfrQl7snIVNO1Jyy4/5s4ZbWw+hLQdQRs3tL77nCposdl5T
WYwiWZlYP/rHnQVXbRYSK5vH2QQMMi/VwuAkAvOHfTyCpYMNW3scCKaMluaPYVDB
3BFHzKicMiuBmE2F90dWtU2+ESiI7uTlBgu4r2N4/5ad9uDSAk5nmahLSeZT13Kt
OElVteM500MY50uF7S9n5GV1NFMhgA6noWiW/nfpQGkgUnJ3h7J6z2iFmDTP0AM5
MiPBx0oAVEOKPBX3vcoffUOaKCuHgIusYod42jCzizgWSastsFsL9xhYEGHYAei4
jXXA/50EpTKfrxklno5kJ/RWYGwtdLcQaMIZJ35QZysUUmu9S4Y=
=tHd1
-----END PGP SIGNATURE-----

--U5J2I87mWnf1KeOw--
