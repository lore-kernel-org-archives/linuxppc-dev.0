Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41MNDG60vwzF2Wm
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jul 2018 15:13:34 +1000 (AEST)
Date: Fri, 6 Jul 2018 15:13:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH kernel v4 2/2] KVM: PPC: Check if IOMMU page is contained
 in the pinned physical page
Message-ID: <20180706051326.GP3450@umbus.fritz.box>
References: <20180705080133.18690-1-aik@ozlabs.ru>
 <20180705080133.18690-3-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6iXXu7NwgEt9u5a7"
In-Reply-To: <20180705080133.18690-3-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--6iXXu7NwgEt9u5a7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 05, 2018 at 06:01:33PM +1000, Alexey Kardashevskiy wrote:
> A VM which has:
>  - a DMA capable device passed through to it (eg. network card);
>  - running a malicious kernel that ignores H_PUT_TCE failure;
>  - capability of using IOMMU pages bigger that physical pages
> can create an IOMMU mapping that exposes (for example) 16MB of
> the host physical memory to the device when only 64K was allocated to
> the VM.
>=20
> The remaining 16MB - 64K will be some other content of host memory,
> possibly including pages of the VM, but also pages of host kernel memory,
> host programs or other VMs.
>=20
> The attacking VM does not control the location of the page it can map,
> and is only allowed to map as many pages as it has pages of RAM.
>=20
> We already have a check in drivers/vfio/vfio_iommu_spapr_tce.c that
> an IOMMU page is contained in the physical page so the PCI hardware won't
> get access to unassigned host memory; however this check is missing in
> the KVM fastpath (H_PUT_TCE accelerated code). We were lucky so far and
> did not hit this yet as the very first time when the mapping happens
> we do not have tbl::it_userspace allocated yet and fall back to
> the userspace which in turn calls VFIO IOMMU driver, this fails and
> the guest does not retry,
>=20
> This stores the smallest preregistered page size in the preregistered
> region descriptor and changes the mm_iommu_xxx API to check this against
> the IOMMU page size. This calculates maximum page size as a minimum of
> the natural region alignment and compound page size.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

It's certainly better than what we have, though a couple of comments
still:

[snip]
> diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_co=
ntext_iommu.c
> index abb4364..11e1029 100644
> --- a/arch/powerpc/mm/mmu_context_iommu.c
> +++ b/arch/powerpc/mm/mmu_context_iommu.c
> @@ -27,6 +27,7 @@ struct mm_iommu_table_group_mem_t {
>  	struct rcu_head rcu;
>  	unsigned long used;
>  	atomic64_t mapped;
> +	unsigned int pageshift;
>  	u64 ua;			/* userspace address */
>  	u64 entries;		/* number of entries in hpas[] */
>  	u64 *hpas;		/* vmalloc'ed */
> @@ -125,7 +126,8 @@ long mm_iommu_get(struct mm_struct *mm, unsigned long=
 ua, unsigned long entries,
>  {
>  	struct mm_iommu_table_group_mem_t *mem;
>  	long i, j, ret =3D 0, locked_entries =3D 0;
> -	struct page *page =3D NULL;
> +	unsigned int pageshift;
> +	struct page *page =3D NULL, *head =3D NULL;
> =20
>  	mutex_lock(&mem_list_mutex);
> =20
> @@ -159,6 +161,7 @@ long mm_iommu_get(struct mm_struct *mm, unsigned long=
 ua, unsigned long entries,
>  		goto unlock_exit;
>  	}
> =20
> +	mem->pageshift =3D __builtin_ctzl(ua | (entries << PAGE_SHIFT));

This could definitely do with a comment saying what this is trying to
calculate.

Explicitly calling a _builtin_ is also kinda horrid.  I wrote my
sample thinking of qemu where there's a standard and widely used
ctz64().  Not sure if there's something else we should be using in kernelsp=
ace.

>  	mem->hpas =3D vzalloc(array_size(entries, sizeof(mem->hpas[0])));
>  	if (!mem->hpas) {
>  		kfree(mem);
> @@ -199,9 +202,17 @@ long mm_iommu_get(struct mm_struct *mm, unsigned lon=
g ua, unsigned long entries,
>  			}
>  		}
>  populate:
> +		pageshift =3D PAGE_SHIFT;
> +		if (PageCompound(page))
> +			pageshift +=3D compound_order(compound_head(page));

So, as I said in reply to the earlier version, I'm not 100% sure there
isn't some way a compound_page could end up mapped unaligned in
userspace (with smaller userspace mappings of a larger underlying
physical page).  A WARN_ON() and fallback to assuming pageshift =3D
PAGE_SHIFT in that case would probably be a good idea.

> +		mem->pageshift =3D min(mem->pageshift, pageshift);
>  		mem->hpas[i] =3D page_to_pfn(page) << PAGE_SHIFT;
>  	}
> =20
> +	/* We have an incomplete huge page, default to PAGE_SHIFT */
> +	if (head)
> +		mem->pageshift =3D PAGE_SHIFT;
> +
>  	atomic64_set(&mem->mapped, 1);
>  	mem->used =3D 1;
>  	mem->ua =3D ua;
> @@ -349,7 +360,7 @@ struct mm_iommu_table_group_mem_t *mm_iommu_find(stru=
ct mm_struct *mm,
>  EXPORT_SYMBOL_GPL(mm_iommu_find);
> =20
>  long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem,
> -		unsigned long ua, unsigned long *hpa)
> +		unsigned long ua, unsigned int pageshift, unsigned long *hpa)
>  {
>  	const long entry =3D (ua - mem->ua) >> PAGE_SHIFT;
>  	u64 *va =3D &mem->hpas[entry];
> @@ -357,6 +368,9 @@ long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_m=
em_t *mem,
>  	if (entry >=3D mem->entries)
>  		return -EFAULT;
> =20
> +	if (pageshift > mem->pageshift)
> +		return -EFAULT;
> +
>  	*hpa =3D *va | (ua & ~PAGE_MASK);
> =20
>  	return 0;
> @@ -364,7 +378,7 @@ long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_m=
em_t *mem,
>  EXPORT_SYMBOL_GPL(mm_iommu_ua_to_hpa);
> =20
>  long mm_iommu_ua_to_hpa_rm(struct mm_iommu_table_group_mem_t *mem,
> -		unsigned long ua, unsigned long *hpa)
> +		unsigned long ua, unsigned int pageshift, unsigned long *hpa)
>  {
>  	const long entry =3D (ua - mem->ua) >> PAGE_SHIFT;
>  	void *va =3D &mem->hpas[entry];
> @@ -373,6 +387,9 @@ long mm_iommu_ua_to_hpa_rm(struct mm_iommu_table_grou=
p_mem_t *mem,
>  	if (entry >=3D mem->entries)
>  		return -EFAULT;
> =20
> +	if (pageshift > mem->pageshift)
> +		return -EFAULT;
> +
>  	pa =3D (void *) vmalloc_to_phys(va);
>  	if (!pa)
>  		return -EFAULT;
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iomm=
u_spapr_tce.c
> index 2da5f05..7cd63b0 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -467,7 +467,7 @@ static int tce_iommu_prereg_ua_to_hpa(struct tce_cont=
ainer *container,
>  	if (!mem)
>  		return -EINVAL;
> =20
> -	ret =3D mm_iommu_ua_to_hpa(mem, tce, phpa);
> +	ret =3D mm_iommu_ua_to_hpa(mem, tce, shift, phpa);
>  	if (ret)
>  		return -EINVAL;
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6iXXu7NwgEt9u5a7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls++nYACgkQbDjKyiDZ
s5L+zRAA0CzrRCYCT67rmrB9tpKPYin6ZoTjMaHxSXTJruvaEaChZrUA91RF4MTs
+S2xGgBnGuz1k6SOTkva6NID73/eGQcPXY0lB/Pwwj+n20S85W6Zf5uizWKaWT0q
s3JdZzGTDBvjw4sA3sYTwBhDvATc8kI1xwSm02FE22uwQ32nuA+GhD6EzXgBbImZ
ONU+Fz9GWvkXHZUHXscwSD3My54pdbWCo2exyVgVjlXRfpSUO3cqO9Z4RF2jUeuY
JpdFgH1ozRZrZzCjWHVNP8bqikXQqL5NgjxUatF/ENxQEST6TS9xUtb8FA0qtHeG
kTD/geaur/6+hUc/Vk4ymNFccaDu6/NLGXASkafv1dubp/BwuDQHfq8OlFsmQB3F
UXqHZy5xfKo1rJWbfYX1G1LAimAThX55mmvwsIiPrjlYc83bYtqqFPasytOLF+cj
+mjykP0+DzSaUNa9iVNYuuoqwJMXssNpvZh/hDE8Xi7g4OHy0UDLY5G1J5G7pu/r
bNboV+MtnKbRPPwkZYTtsr29fNtZfpL6VoVBX9ncu25xc1EMFTXxQzVR2JJoFCjY
FHXNsaF1DRuDSX2+A0vKmxva+SCtIFd8jujGda+ZOklbLlTmQYgrH1/4Ik+Q4iW1
9nW7ozQx7F3pHTyhS3KLSV3vK5tt32NUXwd3T3Uzi33mrGXVLoE=
=7dwh
-----END PGP SIGNATURE-----

--6iXXu7NwgEt9u5a7--
