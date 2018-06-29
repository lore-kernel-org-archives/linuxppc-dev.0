Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41H3Fh3KDpzF1Mm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 14:14:48 +1000 (AEST)
Date: Fri, 29 Jun 2018 14:12:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH kernel v2 2/2] KVM: PPC: Check if IOMMU page is contained
 in the pinned physical page
Message-ID: <20180629041241.GC3422@umbus.fritz.box>
References: <20180626055926.27703-1-aik@ozlabs.ru>
 <20180626055926.27703-3-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="yLVHuoLXiP9kZBkt"
In-Reply-To: <20180626055926.27703-3-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--yLVHuoLXiP9kZBkt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 26, 2018 at 03:59:26PM +1000, Alexey Kardashevskiy wrote:
> We already have a check in drivers/vfio/vfio_iommu_spapr_tce.c that
> an IOMMU page is contained in the physical page so the PCI hardware won't
> get access to unassigned host memory.
>=20
> However we do not have this check in KVM fastpath (H_PUT_TCE accelerated
> code) so the user space can pin memory backed with 64k pages and create
> a hardware TCE table with a bigger page size. We were lucky so far and
> did not hit this yet as the very first time the mapping happens
> we do not have tbl::it_userspace allocated yet and fall back to
> the userspace which in turn calls VFIO IOMMU driver and that fails
> because of the check in vfio_iommu_spapr_tce.c which is really
> sustainable solution.
>=20
> This stores the smallest preregistered page size in the preregistered
> region descriptor and changes the mm_iommu_xxx API to check this against
> the IOMMU page size.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v2:
> * explicitly check for compound pages before calling compound_order()
>=20
> ---
> The bug is: run QEMU _without_ hugepages (no -mempath) and tell it to
> advertise 16MB pages to the guest; a typical pseries guest will use 16MB
> for IOMMU pages without checking the mmu pagesize and this will fail
> at https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dhw/vfio/common.c;h=3Df=
b396cf00ac40eb35967a04c9cc798ca896eed57;hb=3Drefs/heads/master#l256
>=20
> With the change, mapping will fail in KVM and the guest will print:
>=20
> mlx5_core 0000:00:00.0: ibm,create-pe-dma-window(2027) 0 8000000 20000000=
 18 1f returned 0 (liobn =3D 0x80000001 starting addr =3D 8000000 0)
> mlx5_core 0000:00:00.0: created tce table LIOBN 0x80000001 for /pci@80000=
0020000000/ethernet@0
> mlx5_core 0000:00:00.0: failed to map direct window for
> /pci@800000020000000/ethernet@0: -1

[snip]
> @@ -124,7 +125,7 @@ long mm_iommu_get(struct mm_struct *mm, unsigned long=
 ua, unsigned long entries,
>  		struct mm_iommu_table_group_mem_t **pmem)
>  {
>  	struct mm_iommu_table_group_mem_t *mem;
> -	long i, j, ret =3D 0, locked_entries =3D 0;
> +	long i, j, ret =3D 0, locked_entries =3D 0, pageshift;
>  	struct page *page =3D NULL;
> =20
>  	mutex_lock(&mem_list_mutex);
> @@ -166,6 +167,8 @@ long mm_iommu_get(struct mm_struct *mm, unsigned long=
 ua, unsigned long entries,
>  		goto unlock_exit;
>  	}
> =20
> +	mem->pageshift =3D 30; /* start from 1G pages - the biggest we have */

What about 16G pages on an HPT system?

>  	for (i =3D 0; i < entries; ++i) {
>  		if (1 !=3D get_user_pages_fast(ua + (i << PAGE_SHIFT),
>  					1/* pages */, 1/* iswrite */, &page)) {
> @@ -199,6 +202,11 @@ long mm_iommu_get(struct mm_struct *mm, unsigned lon=
g ua, unsigned long entries,
>  			}
>  		}
>  populate:
> +		pageshift =3D PAGE_SHIFT;
> +		if (PageCompound(page))
> +			pageshift +=3D compound_order(compound_head(page));
> +		mem->pageshift =3D min_t(unsigned int, mem->pageshift, pageshift);

Why not make mem->pageshift and pageshift local the same type to avoid
the min_t() ?

> +
>  		mem->hpas[i] =3D page_to_pfn(page) << PAGE_SHIFT;
>  	}
> =20
> @@ -349,7 +357,7 @@ struct mm_iommu_table_group_mem_t *mm_iommu_find(stru=
ct mm_struct *mm,
>  EXPORT_SYMBOL_GPL(mm_iommu_find);
> =20
>  long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem,
> -		unsigned long ua, unsigned long *hpa)
> +		unsigned long ua, unsigned int pageshift, unsigned long *hpa)
>  {
>  	const long entry =3D (ua - mem->ua) >> PAGE_SHIFT;
>  	u64 *va =3D &mem->hpas[entry];
> @@ -357,6 +365,9 @@ long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_m=
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
> @@ -364,7 +375,7 @@ long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_m=
em_t *mem,
>  EXPORT_SYMBOL_GPL(mm_iommu_ua_to_hpa);
> =20
>  long mm_iommu_ua_to_hpa_rm(struct mm_iommu_table_group_mem_t *mem,
> -		unsigned long ua, unsigned long *hpa)
> +		unsigned long ua, unsigned int pageshift, unsigned long *hpa)
>  {
>  	const long entry =3D (ua - mem->ua) >> PAGE_SHIFT;
>  	void *va =3D &mem->hpas[entry];
> @@ -373,6 +384,9 @@ long mm_iommu_ua_to_hpa_rm(struct mm_iommu_table_grou=
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

--yLVHuoLXiP9kZBkt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls1sbYACgkQbDjKyiDZ
s5L/GhAA24MSAXrEJ7rqnbtQb5FggbNxk4TruncbEiOJPivgEk0WSZ2yGHzYjmSC
zqH4QbHqElAfEfq/8ZlnnhVxChYsiL9/Z2rkUAKOobGk8uRIzVw/WjnsTF7G6vOu
hgD6TnAcS7GIdB7cCncISDTs/4wseFxlxOsnkApB+dFsjBnfxFTit7GbT6yIzbwm
wWcTcQs0fKMVlGVg2GW1QPt20Lt6NsQ+E6fH2f/Tz6iBFwWHNW7M1JdvJHcWiwBz
kjKulmJ7TcraswxCj7slUDzCpFBBePelTTZEImRjA4zJGCSBC8xYEuRUokXZYc2S
nmhaI6CoLaD1X65LHnWEmmAFc7aS5clgp6ty7xxjpLeT8laB0GNzBejy8o6kfuZo
7aVmLcScxkwC9aje7cNXQP1DES+/n6IDTgz5F5KIa18wtzNRrwvSciHPLR2QBoxm
nljSV6ftbN7OPzB/oI3X9xNJoH1/eS0qlHbOjFbup0K1cKQC4nElq+AicAFZAjA+
ML/56xVD4dT30+hI21PEdQJZRfI1UR5rZvEpby3D81xXB0ChqrCR26mjgMIWo3mK
wZQoOpebp2QP0u/GKwe+Ph+NkZn41UDan0FadCLrfc9hIZYlUUyGbQtHixAFhTrP
IQIu+BuYcBfPBEwh+Ph+euAW/NIzd4dkvZ1+wIVyApJFgzrVn3E=
=bRDr
-----END PGP SIGNATURE-----

--yLVHuoLXiP9kZBkt--
