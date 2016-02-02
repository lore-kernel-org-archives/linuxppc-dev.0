Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4E9A31A0061
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Feb 2016 12:08:31 +1100 (AEDT)
Date: Tue, 2 Feb 2016 12:04:47 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: paulus@samba.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
 aik@ozlabs.ru, lvivier@redhat.com, thuth@redhat.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFCv2 5/9] arch/powerpc: Split hash page table sizing heuristic
 into a helper
Message-ID: <20160202010447.GC15080@voom.fritz.box>
References: <1454045043-25545-1-git-send-email-david@gibson.dropbear.id.au>
 <1454045043-25545-6-git-send-email-david@gibson.dropbear.id.au>
 <56AF0380.3020500@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="mvpLiMfbWzRoNl4x"
In-Reply-To: <56AF0380.3020500@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 01, 2016 at 12:34:32PM +0530, Anshuman Khandual wrote:
> On 01/29/2016 10:53 AM, David Gibson wrote:
> > htab_get_table_size() either retrieve the size of the hash page table (=
HPT)
> > from the device tree - if the HPT size is determined by firmware - or
> > uses a heuristic to determine a good size based on RAM size if the kern=
el
> > is responsible for allocating the HPT.
> >=20
> > To support a PAPR extension allowing resizing of the HPT, we're going to
> > want the memory size -> HPT size logic elsewhere, so split it out into a
> > helper function.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  arch/powerpc/include/asm/mmu-hash64.h |  3 +++
> >  arch/powerpc/mm/hash_utils_64.c       | 30 +++++++++++++++++----------=
---
> >  2 files changed, 20 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/inclu=
de/asm/mmu-hash64.h
> > index 7352d3f..cf070fd 100644
> > --- a/arch/powerpc/include/asm/mmu-hash64.h
> > +++ b/arch/powerpc/include/asm/mmu-hash64.h
> > @@ -607,6 +607,9 @@ static inline unsigned long get_kernel_vsid(unsigne=
d long ea, int ssize)
> >  	context =3D (MAX_USER_CONTEXT) + ((ea >> 60) - 0xc) + 1;
> >  	return get_vsid(context, ea, ssize);
> >  }
> > +
> > +unsigned htab_shift_for_mem_size(unsigned long mem_size);
> > +
> >  #endif /* __ASSEMBLY__ */
> > =20
> >  #endif /* _ASM_POWERPC_MMU_HASH64_H_ */
> > diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_uti=
ls_64.c
> > index e88a86e..d63f7dc 100644
> > --- a/arch/powerpc/mm/hash_utils_64.c
> > +++ b/arch/powerpc/mm/hash_utils_64.c
> > @@ -606,10 +606,24 @@ static int __init htab_dt_scan_pftsize(unsigned l=
ong node,
> >  	return 0;
> >  }
> > =20
> > -static unsigned long __init htab_get_table_size(void)
> > +unsigned htab_shift_for_mem_size(unsigned long mem_size)
> >  {
> > -	unsigned long mem_size, rnd_mem_size, pteg_count, psize;
> > +	unsigned memshift =3D __ilog2(mem_size);
> > +	unsigned pshift =3D mmu_psize_defs[mmu_virtual_psize].shift;
> > +	unsigned pteg_shift;
> > +
> > +	/* round mem_size up to next power of 2 */
> > +	if ((1UL << memshift) < mem_size)
> > +		memshift +=3D 1;
> > +
> > +	/* aim for 2 pages / pteg */
>=20
> While here I guess its a good opportunity to write couple of lines
> about why one PTE group for every two physical pages on the system,

Well, that don't really know, it's just copied from the existing code.

> why minimum (1UL << 11 =3D 2048) number of PTE groups required,

Ok.

> why
> (1U << 7 =3D 128) entries per PTE group

Um.. what?  Because that's how big a PTEG is, I don't think
re-explaining the HPT structure here is useful.

> and also remove the existing
> confusing comments above ? Just a suggestion.

Not sure which comment you mean.

>=20
> > +	pteg_shift =3D memshift - (pshift + 1);
> > +
> > +	return max(pteg_shift + 7, 18U);
> > +}
> > =20
> > +static unsigned long __init htab_get_table_size(void)
> > +{
> >  	/* If hash size isn't already provided by the platform, we try to
> >  	 * retrieve it from the device-tree. If it's not there neither, we
> >  	 * calculate it now based on the total RAM size
> > @@ -619,17 +633,7 @@ static unsigned long __init htab_get_table_size(vo=
id)
> >  	if (ppc64_pft_size)
> >  		return 1UL << ppc64_pft_size;
> > =20
> > -	/* round mem_size up to next power of 2 */
> > -	mem_size =3D memblock_phys_mem_size();
> > -	rnd_mem_size =3D 1UL << __ilog2(mem_size);
> > -	if (rnd_mem_size < mem_size)
> > -		rnd_mem_size <<=3D 1;
> > -
> > -	/* # pages / 2 */
> > -	psize =3D mmu_psize_defs[mmu_virtual_psize].shift;
> > -	pteg_count =3D max(rnd_mem_size >> (psize + 1), 1UL << 11);
> > -
> > -	return pteg_count << 7;
> > +	return htab_shift_for_mem_size(memblock_phys_mem_size());
>=20
> Would it be 1UL << htab_shift_for_mem_size(memblock_phys_mem_size())
> instead ? It was returning the size of the HPT not the shift of HPT
> originally or I am missing something here.

Oops, yes.  That would have broken all non-LPAR platforms.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mvpLiMfbWzRoNl4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWsACvAAoJEGw4ysog2bOSU2UQALHKvuDWfoBhdWJ79NLGVQK2
j7+V8PYa6TTjKl5hsBFtcAQuXjVC9grwwVdOOuJxvlpuatdmYIY8U8P0yB99VcQ2
qdDjdggU/SsUj/JdrOx55fRnzR4DoFcCZQtgiBSErT17576N51XYN1XsQU3afdBO
jYnwLqJZ2K6bjqd7jfodifLJTUEeM3ayv03I/x1wn1fJnF1gevLmgDmHQSjgej2w
7SPZn27mKO/J3TUu4xTVhhSSn/mlNLuhBuvQlLAWAcBj/xFIRXt0LAPHeQtfH2Kg
0qT9fAvLUaiAULY3cM5+rqOv/eeeQ6O/GIqM1trnDtpxzip2jfu+OFzQdUWpWgXG
BiPKlyDB0dgwC5ZM0zpSNNqMapyIgsfzP23OndbbMJpUbMtj2AaEW9pzk84iirQB
Fmyqe3lCYetn10uKbrULcqLjDPklwFzOXa5IktpkuLuZn94u0mi3S0L8R9qEJcMk
ZDsDCOZ9DlGXn5EjrCujWFVz3hGAIk7393ksFp2VRew0Fl0opnZpFhHeZ+hDfTdy
Ap8yWf5T6it4bQcE9RcApnxXn/5CX9Cce1NIZUYU7oA8qwydFfLm3iZ2x5K3Ye40
rFVcCaBKPP+yl3SK+kfZbCeJSgSQCpKJga3nhcXLTAhhh4YW+ZZ3gCLwOpLsgg8i
cyL4dDNWrcyfBqsY04Lz
=FMYh
-----END PGP SIGNATURE-----

--mvpLiMfbWzRoNl4x--
