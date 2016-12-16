Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tfwty5MKXzDw64
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 14:35:38 +1100 (AEDT)
Date: Fri, 16 Dec 2016 11:40:20 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel 4/9] powerpc/mmu: Add real mode support for IOMMU
 preregistered memory
Message-ID: <20161216004020.GA12146@umbus.fritz.box>
References: <20161208081956.26221-1-aik@ozlabs.ru>
 <20161208081956.26221-5-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
In-Reply-To: <20161208081956.26221-5-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 08, 2016 at 07:19:51PM +1100, Alexey Kardashevskiy wrote:
> This makes mm_iommu_lookup() able to work in realmode by replacing
> list_for_each_entry_rcu() (which can do debug stuff which can fail in
> real mode) with list_for_each_entry_lockless().
>=20
> This adds realmode version of mm_iommu_ua_to_hpa() which adds
> explicit vmalloc'd-to-linear address conversion.
> Unlike mm_iommu_ua_to_hpa(), mm_iommu_ua_to_hpa_rm() can fail.
>=20
> This changes mm_iommu_preregistered() to receive @mm as in real mode
> @current does not always have a correct pointer.
>=20
> This adds realmode version of mm_iommu_lookup() which receives @mm
> (for the same reason as for mm_iommu_preregistered()) and uses
> lockless version of list_for_each_entry_rcu().
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/include/asm/mmu_context.h |  4 ++++
>  arch/powerpc/mm/mmu_context_iommu.c    | 39 ++++++++++++++++++++++++++++=
++++++
>  2 files changed, 43 insertions(+)
>=20
> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/includ=
e/asm/mmu_context.h
> index b9e3f0aca261..c70c8272523d 100644
> --- a/arch/powerpc/include/asm/mmu_context.h
> +++ b/arch/powerpc/include/asm/mmu_context.h
> @@ -29,10 +29,14 @@ extern void mm_iommu_init(struct mm_struct *mm);
>  extern void mm_iommu_cleanup(struct mm_struct *mm);
>  extern struct mm_iommu_table_group_mem_t *mm_iommu_lookup(struct mm_stru=
ct *mm,
>  		unsigned long ua, unsigned long size);
> +extern struct mm_iommu_table_group_mem_t *mm_iommu_lookup_rm(
> +		struct mm_struct *mm, unsigned long ua, unsigned long size);
>  extern struct mm_iommu_table_group_mem_t *mm_iommu_find(struct mm_struct=
 *mm,
>  		unsigned long ua, unsigned long entries);
>  extern long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem,
>  		unsigned long ua, unsigned long *hpa);
> +extern long mm_iommu_ua_to_hpa_rm(struct mm_iommu_table_group_mem_t *mem,
> +		unsigned long ua, unsigned long *hpa);
>  extern long mm_iommu_mapped_inc(struct mm_iommu_table_group_mem_t *mem);
>  extern void mm_iommu_mapped_dec(struct mm_iommu_table_group_mem_t *mem);
>  #endif
> diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_co=
ntext_iommu.c
> index 104bad029ce9..631d32f5937b 100644
> --- a/arch/powerpc/mm/mmu_context_iommu.c
> +++ b/arch/powerpc/mm/mmu_context_iommu.c
> @@ -314,6 +314,25 @@ struct mm_iommu_table_group_mem_t *mm_iommu_lookup(s=
truct mm_struct *mm,
>  }
>  EXPORT_SYMBOL_GPL(mm_iommu_lookup);
> =20
> +struct mm_iommu_table_group_mem_t *mm_iommu_lookup_rm(struct mm_struct *=
mm,
> +		unsigned long ua, unsigned long size)
> +{
> +	struct mm_iommu_table_group_mem_t *mem, *ret =3D NULL;
> +
> +	list_for_each_entry_lockless(mem, &mm->context.iommu_group_mem_list,
> +			next) {
> +		if ((mem->ua <=3D ua) &&
> +				(ua + size <=3D mem->ua +
> +				 (mem->entries << PAGE_SHIFT))) {
> +			ret =3D mem;
> +			break;
> +		}
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(mm_iommu_lookup_rm);
> +
>  struct mm_iommu_table_group_mem_t *mm_iommu_find(struct mm_struct *mm,
>  		unsigned long ua, unsigned long entries)
>  {
> @@ -345,6 +364,26 @@ long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_=
mem_t *mem,
>  }
>  EXPORT_SYMBOL_GPL(mm_iommu_ua_to_hpa);
> =20
> +long mm_iommu_ua_to_hpa_rm(struct mm_iommu_table_group_mem_t *mem,
> +		unsigned long ua, unsigned long *hpa)
> +{
> +	const long entry =3D (ua - mem->ua) >> PAGE_SHIFT;
> +	void *va =3D &mem->hpas[entry];
> +	unsigned long *pa;
> +
> +	if (entry >=3D mem->entries)
> +		return -EFAULT;
> +
> +	pa =3D (void *) vmalloc_to_phys(va);
> +	if (!pa)
> +		return -EFAULT;
> +
> +	*hpa =3D *pa | (ua & ~PAGE_MASK);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(mm_iommu_ua_to_hpa_rm);
> +
>  long mm_iommu_mapped_inc(struct mm_iommu_table_group_mem_t *mem)
>  {
>  	if (atomic64_inc_not_zero(&mem->mapped))

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYUzfvAAoJEGw4ysog2bOSebgQAL/G5wO6xUJkihD47VuAKTD2
lXttSaENxmttOrwYFcjjQZYzixNGgRI4HFuXcDVyd3kWhd5gyueaAvAg06vmrrNS
J7htGFXyHgXiJok3iGyWqcVMIXvU4nTO0BBpYjhqVuwoRFhhzhpLoJxeqWQHS1S1
lcyJ9xVH50/9m9JlpcmuPane4YDlTrMNgnbYUHF0pIYbhbTKLrSLwePaqDM2A2Zy
7hO7YKpVvI10UZr9TOmbDDVH1uch3lcteJp0fhuOIY8LGTk8tqWqs2Y2QzuLh3w1
jLOg7yuN0e6NwBRYILlP6j18gG+Oghc6+IkDz9CowAzBPn2Z2P5gyp36Y0Io5CiG
MtZopFNSaSs7vo596xO0PdM6cdxvdxdRenNLx2TTtCq6kZayj/qimYxzCZrIXXcI
SOrwSbEoepna2f3ILpM86kcrwL11aI6SsOmZKOrCtigtq2j9fh5cVnlSYv+WmBou
J4sQYks51F7E6NZqccomO0umgNHmViqzuEpDmlHXvQuVphQBp+jNyqNnrA75LmRw
VG+f1VAqV6M8F/dxKcctt9HJU2iVkNW7H9jOi0vcyeMPFNMbqgY2UTi2EIJ2J4LG
p0tp/va/zf8gJa0vITvc0iJbRqx1LYQuM5u+0HRdDdQqGDjNOGaHtHPYotcOWQ2c
65hkaRpDKlEnxeiUh1yn
=lENI
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
