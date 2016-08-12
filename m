Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9XTd4LsVzDqTs
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 14:48:53 +1000 (AEST)
Date: Fri, 12 Aug 2016 14:02:24 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH kernel 09/15] powerpc/mmu: Add real mode support for
 IOMMU preregistered memory
Message-ID: <20160812040224.GL16493@voom.fritz.box>
References: <1470213656-1042-1-git-send-email-aik@ozlabs.ru>
 <1470213656-1042-10-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="RNGrj7vazCqBHNw7"
In-Reply-To: <1470213656-1042-10-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--RNGrj7vazCqBHNw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 03, 2016 at 06:40:50PM +1000, Alexey Kardashevskiy wrote:
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
> index a4c4ed5..939030c 100644
> --- a/arch/powerpc/include/asm/mmu_context.h
> +++ b/arch/powerpc/include/asm/mmu_context.h
> @@ -27,10 +27,14 @@ extern long mm_iommu_put(struct mm_struct *mm,
>  extern void mm_iommu_init(struct mm_struct *mm);
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
> index 10f01fe..36a906c 100644
> --- a/arch/powerpc/mm/mmu_context_iommu.c
> +++ b/arch/powerpc/mm/mmu_context_iommu.c
> @@ -242,6 +242,25 @@ struct mm_iommu_table_group_mem_t *mm_iommu_lookup(s=
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
> @@ -273,6 +292,26 @@ long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_=
mem_t *mem,
>  }
>  EXPORT_SYMBOL_GPL(mm_iommu_ua_to_hpa);
> =20
> +long mm_iommu_ua_to_hpa_rm(struct mm_iommu_table_group_mem_t *mem,
> +		unsigned long ua, unsigned long *hpa)
> +{
> +	const long entry =3D (ua - mem->ua) >> PAGE_SHIFT;
> +	void *va =3D &mem->hpas[entry];
> +	unsigned long *ra;
> +
> +	if (entry >=3D mem->entries)
> +		return -EFAULT;
> +
> +	ra =3D (void *) vmalloc_to_phys(va);
> +	if (!ra)
> +		return -EFAULT;
> +
> +	*hpa =3D *ra | (ua & ~PAGE_MASK);
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

--RNGrj7vazCqBHNw7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXrUpQAAoJEGw4ysog2bOSxXEP/R7jT2/kOV6v5v8ulOCeelfG
a/WO7YPntgwgL/Cun6hwL+aJvoYPNhjFkv4PznHUroa/+Q2kyv0LbfiUoHLpPKeS
c4U29MiD6uW2zbdnYP8mEmP0GiRVJMY00oU/6GE1s3mFPFQ+G1IOH5blorcfENYy
msf1lTvn4H5WtjUFm1zJCC3DzctTdZL34e3i+B6bGDMc4yKZzqjW00X6M5TNBItI
zWF5aUNFN3vU9EUDm0u00+jzAMvRU+EaKdZZKu3SxfOjNAwDrD1WQa1xWrVvV58t
RfXR5Ifc+G6oq92ZAbqrgmx3IELrOI4fyAJ6ySKhboOnZg73qF0o5Dz7gAdFvRpw
hz1mG85Q2SS7GiygQoVhvn66uSUGskF8juPTgPVWWUwPsYe+11hk3vznoUUwzsN2
pw1gbbVnPmf/kXTSZMrwPIUi+8tr2v3RrGaLGMLEm8b5lZATLBB2RzzqgN0WHO1P
xiFj0xwCC7al1tJ9NoIF1quhdSJKbpQFZZu1uSEd7Dkb8Ll8mczu53wcfBBo/jyI
oQcR8m5tIJionXy2qH7xmX74TjPJ0rMr99YchFp1/KKfjURXFhGlga6mYrcwSkHm
+Ff0tDmHDG1izS+sIrLSjifxw+8imnAuy2o3JflWyrJGB7fBmCwiPDnhZkbkMtup
gutxLLz+iRUBc4MCNdbD
=rMSn
-----END PGP SIGNATURE-----

--RNGrj7vazCqBHNw7--
