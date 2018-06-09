Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 412tS24J0zzDr3y
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Jun 2018 18:56:34 +1000 (AEST)
Date: Sat, 9 Jun 2018 18:53:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH kernel 3/6] KVM: PPC: Make iommu_table::it_userspace big
 endian
Message-ID: <20180609085337.GB2737@umbus.fritz.box>
References: <20180608054633.18659-1-aik@ozlabs.ru>
 <20180608054633.18659-4-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
In-Reply-To: <20180608054633.18659-4-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 08, 2018 at 03:46:30PM +1000, Alexey Kardashevskiy wrote:
> We are going to reuse multilevel TCE code for the userspace copy of
> the TCE table and since it is big endian, let's make the copy big endian
> too.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/include/asm/iommu.h    |  2 +-
>  arch/powerpc/kvm/book3s_64_vio.c    | 11 ++++++-----
>  arch/powerpc/kvm/book3s_64_vio_hv.c | 10 +++++-----
>  drivers/vfio/vfio_iommu_spapr_tce.c | 19 +++++++++----------
>  4 files changed, 21 insertions(+), 21 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/=
iommu.h
> index 20febe0..803ac70 100644
> --- a/arch/powerpc/include/asm/iommu.h
> +++ b/arch/powerpc/include/asm/iommu.h
> @@ -117,7 +117,7 @@ struct iommu_table {
>  	unsigned long *it_map;       /* A simple allocation bitmap for now */
>  	unsigned long  it_page_shift;/* table iommu page size */
>  	struct list_head it_group_list;/* List of iommu_table_group_link */
> -	unsigned long *it_userspace; /* userspace view of the table */
> +	__be64 *it_userspace; /* userspace view of the table */
>  	struct iommu_table_ops *it_ops;
>  	struct kref    it_kref;
>  };
> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_6=
4_vio.c
> index 80ead38..1dbca4b 100644
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -378,19 +378,19 @@ static long kvmppc_tce_iommu_mapped_dec(struct kvm =
*kvm,
>  {
>  	struct mm_iommu_table_group_mem_t *mem =3D NULL;
>  	const unsigned long pgsize =3D 1ULL << tbl->it_page_shift;
> -	unsigned long *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
> +	__be64 *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
> =20
>  	if (!pua)
>  		/* it_userspace allocation might be delayed */
>  		return H_TOO_HARD;
> =20
> -	mem =3D mm_iommu_lookup(kvm->mm, *pua, pgsize);
> +	mem =3D mm_iommu_lookup(kvm->mm, be64_to_cpu(*pua), pgsize);
>  	if (!mem)
>  		return H_TOO_HARD;
> =20
>  	mm_iommu_mapped_dec(mem);
> =20
> -	*pua =3D 0;
> +	*pua =3D cpu_to_be64(0);
> =20
>  	return H_SUCCESS;
>  }
> @@ -437,7 +437,8 @@ long kvmppc_tce_iommu_do_map(struct kvm *kvm, struct =
iommu_table *tbl,
>  		enum dma_data_direction dir)
>  {
>  	long ret;
> -	unsigned long hpa, *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
> +	unsigned long hpa;
> +	__be64 *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
>  	struct mm_iommu_table_group_mem_t *mem;
> =20
>  	if (!pua)
> @@ -464,7 +465,7 @@ long kvmppc_tce_iommu_do_map(struct kvm *kvm, struct =
iommu_table *tbl,
>  	if (dir !=3D DMA_NONE)
>  		kvmppc_tce_iommu_mapped_dec(kvm, tbl, entry);
> =20
> -	*pua =3D ua;
> +	*pua =3D cpu_to_be64(ua);
> =20
>  	return 0;
>  }
> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3=
s_64_vio_hv.c
> index 635f3ca..18109f3 100644
> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> @@ -200,7 +200,7 @@ static long kvmppc_rm_tce_iommu_mapped_dec(struct kvm=
 *kvm,
>  {
>  	struct mm_iommu_table_group_mem_t *mem =3D NULL;
>  	const unsigned long pgsize =3D 1ULL << tbl->it_page_shift;
> -	unsigned long *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
> +	__be64 *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
> =20
>  	if (!pua)
>  		/* it_userspace allocation might be delayed */
> @@ -210,13 +210,13 @@ static long kvmppc_rm_tce_iommu_mapped_dec(struct k=
vm *kvm,
>  	if (WARN_ON_ONCE_RM(!pua))
>  		return H_HARDWARE;
> =20
> -	mem =3D mm_iommu_lookup_rm(kvm->mm, *pua, pgsize);
> +	mem =3D mm_iommu_lookup_rm(kvm->mm, be64_to_cpu(*pua), pgsize);
>  	if (!mem)
>  		return H_TOO_HARD;
> =20
>  	mm_iommu_mapped_dec(mem);
> =20
> -	*pua =3D 0;
> +	*pua =3D cpu_to_be64(0);
> =20
>  	return H_SUCCESS;
>  }
> @@ -268,7 +268,7 @@ static long kvmppc_rm_tce_iommu_do_map(struct kvm *kv=
m, struct iommu_table *tbl,
>  {
>  	long ret;
>  	unsigned long hpa =3D 0;
> -	unsigned long *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
> +	__be64 *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
>  	struct mm_iommu_table_group_mem_t *mem;
> =20
>  	if (!pua)
> @@ -302,7 +302,7 @@ static long kvmppc_rm_tce_iommu_do_map(struct kvm *kv=
m, struct iommu_table *tbl,
>  	if (dir !=3D DMA_NONE)
>  		kvmppc_rm_tce_iommu_mapped_dec(kvm, tbl, entry);
> =20
> -	*pua =3D ua;
> +	*pua =3D cpu_to_be64(ua);
> =20
>  	return 0;
>  }
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iomm=
u_spapr_tce.c
> index 47071f3..81f48114 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -231,7 +231,7 @@ static long tce_iommu_userspace_view_alloc(struct iom=
mu_table *tbl,
>  		decrement_locked_vm(mm, cb >> PAGE_SHIFT);
>  		return -ENOMEM;
>  	}
> -	tbl->it_userspace =3D uas;
> +	tbl->it_userspace =3D (__be64 *) uas;
> =20
>  	return 0;
>  }
> @@ -494,20 +494,20 @@ static void tce_iommu_unuse_page_v2(struct tce_cont=
ainer *container,
>  	struct mm_iommu_table_group_mem_t *mem =3D NULL;
>  	int ret;
>  	unsigned long hpa =3D 0;
> -	unsigned long *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
> +	__be64 *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
> =20
>  	if (!pua)
>  		return;
> =20
> -	ret =3D tce_iommu_prereg_ua_to_hpa(container, *pua, IOMMU_PAGE_SIZE(tbl=
),
> -			&hpa, &mem);
> +	ret =3D tce_iommu_prereg_ua_to_hpa(container, be64_to_cpu(*pua),
> +			IOMMU_PAGE_SIZE(tbl), &hpa, &mem);
>  	if (ret)
> -		pr_debug("%s: tce %lx at #%lx was not cached, ret=3D%d\n",
> -				__func__, *pua, entry, ret);
> +		pr_debug("%s: tce %llx at #%lx was not cached, ret=3D%d\n",
> +				__func__, be64_to_cpu(*pua), entry, ret);
>  	if (mem)
>  		mm_iommu_mapped_dec(mem);
> =20
> -	*pua =3D 0;
> +	*pua =3D cpu_to_be64(0);
>  }
> =20
>  static int tce_iommu_clear(struct tce_container *container,
> @@ -616,8 +616,7 @@ static long tce_iommu_build_v2(struct tce_container *=
container,
> =20
>  	for (i =3D 0; i < pages; ++i) {
>  		struct mm_iommu_table_group_mem_t *mem =3D NULL;
> -		unsigned long *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl,
> -				entry + i);
> +		__be64 *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry + i);
> =20
>  		ret =3D tce_iommu_prereg_ua_to_hpa(container,
>  				tce, IOMMU_PAGE_SIZE(tbl), &hpa, &mem);
> @@ -650,7 +649,7 @@ static long tce_iommu_build_v2(struct tce_container *=
container,
>  		if (dirtmp !=3D DMA_NONE)
>  			tce_iommu_unuse_page_v2(container, tbl, entry + i);
> =20
> -		*pua =3D tce;
> +		*pua =3D cpu_to_be64(tce);
> =20
>  		tce +=3D IOMMU_PAGE_SIZE(tbl);
>  	}

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsblY8ACgkQbDjKyiDZ
s5LZ4RAA5bVL8KZWNfbK3eJwR/MztrbdLUz7hH//UyKppq8qyTvhH6rn1IzYy+kY
+0oG+A0DyL0CVirFcs+6joKzAucHADQJBRYBLgsdzsAQ11R3sjhK0jRWtMEsKs28
hMMlreVmfC6oFe9ymb6vSoaPa8NZhy2XFw+9lQR2OhYqGschSnPwfti6MKJGjrCl
YDooCUXxKjmA8ODMGF5fPROUmkDmenllk6DUX/t72fH64x8eURZ6/XJ9dTE13233
2tYZO/5fVfOhEb+IN2BsQJVLqRyYM+GSEuQJE1h+1EXcNugdbQ+5vzzUUOC+uXWB
t9EPUzCJF+dh+mXdkepZY7gmqek7fmeDJlNyZWNdqn9urB9TMC42K1RxmP1nLGzN
ZL+mztSil5ahZcSlWMLhXlWV3UG4r13vkh2Vshgg032kxqOMAxh7oosDQlpqhj2k
EDJke00RomqQsHRGtxTKw1RDfMe3MK92eQRKIuRKZ8fET9GkU4Z/wsuhztLBbjHY
vvoZiJ6vysvrs6tfPMXHIfAETZYN8WvKofVk6lKxn5jLjQllgpdFGaf9RTH25O5H
KIKlDdsoXgR5zDORCYy9iTkuykNrQghpLSy00vWzFawtJOfE/cMFyX/HIAEDkTzq
IU7ZwU5ITb41qOnA2VQRZfw5oxQNDtn+GgBGNmaIZJPxOrxBqMc=
=rpiM
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
