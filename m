Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8EF461A001D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2016 15:31:10 +1100 (AEDT)
Date: Wed, 3 Feb 2016 15:31:59 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Cc: paulus@samba.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
 aik@ozlabs.ru, lvivier@redhat.com, thuth@redhat.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFCv2 4/9] arch/powerpc: Clean up memory hotplug failure paths
Message-ID: <20160203043159.GG15080@voom.fritz.box>
References: <1454045043-25545-1-git-send-email-david@gibson.dropbear.id.au>
 <1454045043-25545-5-git-send-email-david@gibson.dropbear.id.au>
 <56B0C577.1030809@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="4eRLI4hEmsdu6Npr"
In-Reply-To: <56B0C577.1030809@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--4eRLI4hEmsdu6Npr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 02, 2016 at 09:04:23AM -0600, Nathan Fontenot wrote:
> On 01/28/2016 11:23 PM, David Gibson wrote:
> > This makes a number of cleanups to handling of mapping failures during
> > memory hotplug on Power:
> >=20
> > For errors creating the linear mapping for the hot-added region:
> >   * This is now reported with EFAULT which is more appropriate than the
> >     previous EINVAL (the failure is unlikely to be related to the
> >     function's parameters)
> >   * An error in this path now prints a warning message, rather than just
> >     silently failing to add the extra memory.
> >   * Previously a failure here could result in the region being partially
> >     mapped.  We now clean up any partial mapping before failing.
> >=20
> > For errors creating the vmemmap for the hot-added region:
> >    * This is now reported with EFAULT instead of causing a BUG() - this
> >      could happen for external reason (e.g. full hash table) so it's be=
tter
> >      to handle this non-fatally
> >    * An error message is also printed, so the failure won't be silent
> >    * As above a failure could cause a partially mapped region, we now
> >      clean this up.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  arch/powerpc/mm/hash_utils_64.c | 13 ++++++++++---
> >  arch/powerpc/mm/init_64.c       | 38 ++++++++++++++++++++++++++-------=
-----
> >  arch/powerpc/mm/mem.c           | 10 ++++++++--
> >  3 files changed, 44 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_uti=
ls_64.c
> > index 0737eae..e88a86e 100644
> > --- a/arch/powerpc/mm/hash_utils_64.c
> > +++ b/arch/powerpc/mm/hash_utils_64.c
> > @@ -635,9 +635,16 @@ static unsigned long __init htab_get_table_size(vo=
id)
> >  #ifdef CONFIG_MEMORY_HOTPLUG
> >  int create_section_mapping(unsigned long start, unsigned long end)
> >  {
> > -	return htab_bolt_mapping(start, end, __pa(start),
> > -				 pgprot_val(PAGE_KERNEL), mmu_linear_psize,
> > -				 mmu_kernel_ssize);
> > +	int rc =3D htab_bolt_mapping(start, end, __pa(start),
> > +				   pgprot_val(PAGE_KERNEL), mmu_linear_psize,
> > +				   mmu_kernel_ssize);
> > +
> > +	if (rc < 0) {
> > +		int rc2 =3D htab_remove_mapping(start, end, mmu_linear_psize,
> > +					      mmu_kernel_ssize);
> > +		BUG_ON(rc2 && (rc2 !=3D -ENOENT));
> > +	}
> > +	return rc;
> >  }
> > =20
>=20
> <-- snip -->
>=20
> >  #ifdef CONFIG_MEMORY_HOTPLUG
> > @@ -217,15 +219,20 @@ static void vmemmap_remove_mapping(unsigned long =
start,
> >  }
> >  #endif
> >  #else /* CONFIG_PPC_BOOK3E */
> > -static void __meminit vmemmap_create_mapping(unsigned long start,
> > -					     unsigned long page_size,
> > -					     unsigned long phys)
> > +static int __meminit vmemmap_create_mapping(unsigned long start,
> > +					    unsigned long page_size,
> > +					    unsigned long phys)
> >  {
> > -	int  mapped =3D htab_bolt_mapping(start, start + page_size, phys,
> > -					pgprot_val(PAGE_KERNEL),
> > -					mmu_vmemmap_psize,
> > -					mmu_kernel_ssize);
> > -	BUG_ON(mapped < 0);
> > +	int rc =3D htab_bolt_mapping(start, start + page_size, phys,
> > +				   pgprot_val(PAGE_KERNEL),
> > +				   mmu_vmemmap_psize, mmu_kernel_ssize);
> > +	if (rc < 0) {
> > +		int rc2 =3D htab_remove_mapping(start, start + page_size,
> > +					      mmu_vmemmap_psize,
> > +					      mmu_kernel_ssize);
> > +		BUG_ON(rc2 && (rc2 !=3D -ENOENT));
> > +	}
> > +	return rc;
> >  }
> > =20
>=20
> If I'm reading this correctly it appears that create_section_mapping() and
> vmemmap_create_mapping() for !PPC_BOOK3E are identical. Any reason to not
> have one routine, perhaps just have vmemmap_create_mapping() just call
> create_section_mapping()?

Not really, apart from documenting what they're used for.  They're
both fairly trivial wrappers around htab_bolt_mapping().  I think
cleaning this up is outside the scope of this series though.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4eRLI4hEmsdu6Npr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWsYK/AAoJEGw4ysog2bOS4q0QAL7b52kBvtS6pSb6zua4eF5B
M1pM6eLYxWkNj9YHGjxdSaAI7ntLhPxrtbn5VcfWSv+jYNDm2Mnuu993lcMZgV4I
xf2wMIKhcy4Jay/n9MRCiO0FlbeYckg7QwKMJhjt+HTN11Mwh3Dpek3hMVN3QFjZ
1XS7n7L3DvbLCINnCQ+DUwqG/TOQWDNugWQ/C5xdjlYc+PmDxGMYl63bmVXqMHip
M2CsdqbtvvWOTOJ5UZiLoVnFpB1kFJZm4nX/fVP65Dl5V4hwl01WkheouD3tbdrJ
mKnLBi3g4geCOmZneMjvgiuZw4Es70sKlGeWNcmAXHC/b3E27R7Q5lBPbS3qne8t
CLZcSW/FOnbpkCrML2rmaxwyxCgQpetOHYf984ZPJ1XwSr3UdN7oHZcz+/AEZNBw
swDEfjXJmTT43KjGAV+eSwplcYZ577NfaCO1//FUyzg5tgVglVsxLlpBtOtpysDI
h+wUem8EUvJNQGU0gFBQppA1pOMcBYMQp7quYKlsJXzP3PgkGWyQK6KNWrMYbONh
Wj6LKwOR08KxVcXaWBWeyzjIvelysldJ7+Zaselu7klEV9wSYHB5IQyWgkPV7eYy
DwyapstTDbh4hEDRxcNxRNA2r/hLeOKuTxk05EKBMIj6e72uC2GS/tUgibBkGkDx
LheQMIzvQUE/RoUtJafX
=mY//
-----END PGP SIGNATURE-----

--4eRLI4hEmsdu6Npr--
