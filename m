Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41TVWT2pHQzF36c
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jul 2018 14:17:57 +1000 (AEST)
Date: Mon, 16 Jul 2018 14:17:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Paul Mackerras <paulus@ozlabs.org>, Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH kernel v6 2/2] KVM: PPC: Check if IOMMU page is contained
 in the pinned physical page
Message-ID: <20180716041750.GG2599@umbus.fritz.box>
References: <20180711110044.15939-1-aik@ozlabs.ru>
 <20180711110044.15939-3-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9Iq5ULCa7nGtWwZS"
In-Reply-To: <20180711110044.15939-3-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--9Iq5ULCa7nGtWwZS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 11, 2018 at 09:00:44PM +1000, Alexey Kardashevskiy wrote:
> A VM which has:
>  - a DMA capable device passed through to it (eg. network card);
>  - running a malicious kernel that ignores H_PUT_TCE failure;
>  - capability of using IOMMU pages bigger that physical pages
> can create an IOMMU mapping that exposes (for example) 16MB of
> the host physical memory to the device when only 64K was allocated to the=
 VM.
>=20
> The remaining 16MB - 64K will be some other content of host memory, possi=
bly
> including pages of the VM, but also pages of host kernel memory, host
> programs or other VMs.
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
> the IOMMU page size.
>=20
> This calculates maximum page size as a minimum of the natural region
> alignment and compound page size. For the page shift this uses the shift
> returned by find_linux_pte() which indicates how the page is mapped to
> the current userspace - if the page is huge and this is not a zero, then
> it is a leaf pte and the page is mapped within the range.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> Changes:
> v6:
> * replaced hugetlbfs with pageshift from find_linux_pte()
>=20
> v5:
> * only consider compound pages from hugetlbfs
>=20
> v4:
> * reimplemented max pageshift calculation
>=20
> v3:
> * fixed upper limit for the page size
> * added checks that we don't register parts of a huge page
>=20
> v2:
> * explicitely check for compound pages before calling compound_order()
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
> mlx5_core 0000:00:00.0: failed to map direct window for /pci@800000020000=
000/ethernet@0: -1
> ---
>  arch/powerpc/include/asm/mmu_context.h |  4 ++--
>  arch/powerpc/kvm/book3s_64_vio.c       |  2 +-
>  arch/powerpc/kvm/book3s_64_vio_hv.c    |  6 ++++--
>  arch/powerpc/mm/mmu_context_iommu.c    | 39 ++++++++++++++++++++++++++++=
++++--
>  drivers/vfio/vfio_iommu_spapr_tce.c    |  2 +-
>  5 files changed, 45 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/includ=
e/asm/mmu_context.h
> index 896efa5..79d570c 100644
> --- a/arch/powerpc/include/asm/mmu_context.h
> +++ b/arch/powerpc/include/asm/mmu_context.h
> @@ -35,9 +35,9 @@ extern struct mm_iommu_table_group_mem_t *mm_iommu_look=
up_rm(
>  extern struct mm_iommu_table_group_mem_t *mm_iommu_find(struct mm_struct=
 *mm,
>  		unsigned long ua, unsigned long entries);
>  extern long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem,
> -		unsigned long ua, unsigned long *hpa);
> +		unsigned long ua, unsigned int pageshift, unsigned long *hpa);
>  extern long mm_iommu_ua_to_hpa_rm(struct mm_iommu_table_group_mem_t *mem,
> -		unsigned long ua, unsigned long *hpa);
> +		unsigned long ua, unsigned int pageshift, unsigned long *hpa);
>  extern long mm_iommu_mapped_inc(struct mm_iommu_table_group_mem_t *mem);
>  extern void mm_iommu_mapped_dec(struct mm_iommu_table_group_mem_t *mem);
>  #endif
> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_6=
4_vio.c
> index d066e37..8c456fa 100644
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -449,7 +449,7 @@ long kvmppc_tce_iommu_do_map(struct kvm *kvm, struct =
iommu_table *tbl,
>  		/* This only handles v2 IOMMU type, v1 is handled via ioctl() */
>  		return H_TOO_HARD;
> =20
> -	if (WARN_ON_ONCE(mm_iommu_ua_to_hpa(mem, ua, &hpa)))
> +	if (WARN_ON_ONCE(mm_iommu_ua_to_hpa(mem, ua, tbl->it_page_shift, &hpa)))
>  		return H_HARDWARE;
> =20
>  	if (mm_iommu_mapped_inc(mem))
> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3=
s_64_vio_hv.c
> index 925fc31..5b298f5 100644
> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> @@ -279,7 +279,8 @@ static long kvmppc_rm_tce_iommu_do_map(struct kvm *kv=
m, struct iommu_table *tbl,
>  	if (!mem)
>  		return H_TOO_HARD;
> =20
> -	if (WARN_ON_ONCE_RM(mm_iommu_ua_to_hpa_rm(mem, ua, &hpa)))
> +	if (WARN_ON_ONCE_RM(mm_iommu_ua_to_hpa_rm(mem, ua, tbl->it_page_shift,
> +			&hpa)))
>  		return H_HARDWARE;
> =20
>  	pua =3D (void *) vmalloc_to_phys(pua);
> @@ -469,7 +470,8 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vc=
pu,
> =20
>  		mem =3D mm_iommu_lookup_rm(vcpu->kvm->mm, ua, IOMMU_PAGE_SIZE_4K);
>  		if (mem)
> -			prereg =3D mm_iommu_ua_to_hpa_rm(mem, ua, &tces) =3D=3D 0;
> +			prereg =3D mm_iommu_ua_to_hpa_rm(mem, ua,
> +					IOMMU_PAGE_SHIFT_4K, &tces) =3D=3D 0;
>  	}
> =20
>  	if (!prereg) {
> diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_co=
ntext_iommu.c
> index abb4364..0bb53a7 100644
> --- a/arch/powerpc/mm/mmu_context_iommu.c
> +++ b/arch/powerpc/mm/mmu_context_iommu.c
> @@ -19,6 +19,7 @@
>  #include <linux/hugetlb.h>
>  #include <linux/swap.h>
>  #include <asm/mmu_context.h>
> +#include <asm/pte-walk.h>
> =20
>  static DEFINE_MUTEX(mem_list_mutex);
> =20
> @@ -27,6 +28,7 @@ struct mm_iommu_table_group_mem_t {
>  	struct rcu_head rcu;
>  	unsigned long used;
>  	atomic64_t mapped;
> +	unsigned int pageshift;
>  	u64 ua;			/* userspace address */
>  	u64 entries;		/* number of entries in hpas[] */
>  	u64 *hpas;		/* vmalloc'ed */
> @@ -125,6 +127,8 @@ long mm_iommu_get(struct mm_struct *mm, unsigned long=
 ua, unsigned long entries,
>  {
>  	struct mm_iommu_table_group_mem_t *mem;
>  	long i, j, ret =3D 0, locked_entries =3D 0;
> +	unsigned int pageshift;
> +	unsigned long flags;
>  	struct page *page =3D NULL;
> =20
>  	mutex_lock(&mem_list_mutex);
> @@ -159,6 +163,12 @@ long mm_iommu_get(struct mm_struct *mm, unsigned lon=
g ua, unsigned long entries,
>  		goto unlock_exit;
>  	}
> =20
> +	/*
> +	 * For a starting point for a maximum page size calculation
> +	 * we use @ua and @entries natural alignment to allow IOMMU pages
> +	 * smaller than huge pages but still bigger than PAGE_SIZE.
> +	 */
> +	mem->pageshift =3D __ffs(ua | (entries << PAGE_SHIFT));
>  	mem->hpas =3D vzalloc(array_size(entries, sizeof(mem->hpas[0])));
>  	if (!mem->hpas) {
>  		kfree(mem);
> @@ -199,6 +209,25 @@ long mm_iommu_get(struct mm_struct *mm, unsigned lon=
g ua, unsigned long entries,
>  			}
>  		}
>  populate:
> +		pageshift =3D PAGE_SHIFT;
> +		if (PageCompound(page)) {
> +			pte_t *pte;
> +			struct page *head =3D compound_head(page);
> +			unsigned int compshift =3D compound_order(head);
> +
> +			local_irq_save(flags); /* disables as well */
> +			pte =3D find_linux_pte(mm->pgd, ua, NULL, &pageshift);
> +			local_irq_restore(flags);
> +			if (!pte) {
> +				ret =3D -EFAULT;
> +				goto unlock_exit;
> +			}
> +			/* Double check it is still the same pinned page */
> +			if (pte_page(*pte) =3D=3D head && pageshift =3D=3D compshift)
> +				pageshift =3D max_t(unsigned int, pageshift,
> +						PAGE_SHIFT);
> +		}
> +		mem->pageshift =3D min(mem->pageshift, pageshift);
>  		mem->hpas[i] =3D page_to_pfn(page) << PAGE_SHIFT;
>  	}
> =20
> @@ -349,7 +378,7 @@ struct mm_iommu_table_group_mem_t *mm_iommu_find(stru=
ct mm_struct *mm,
>  EXPORT_SYMBOL_GPL(mm_iommu_find);
> =20
>  long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem,
> -		unsigned long ua, unsigned long *hpa)
> +		unsigned long ua, unsigned int pageshift, unsigned long *hpa)
>  {
>  	const long entry =3D (ua - mem->ua) >> PAGE_SHIFT;
>  	u64 *va =3D &mem->hpas[entry];
> @@ -357,6 +386,9 @@ long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_m=
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
> @@ -364,7 +396,7 @@ long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_m=
em_t *mem,
>  EXPORT_SYMBOL_GPL(mm_iommu_ua_to_hpa);
> =20
>  long mm_iommu_ua_to_hpa_rm(struct mm_iommu_table_group_mem_t *mem,
> -		unsigned long ua, unsigned long *hpa)
> +		unsigned long ua, unsigned int pageshift, unsigned long *hpa)
>  {
>  	const long entry =3D (ua - mem->ua) >> PAGE_SHIFT;
>  	void *va =3D &mem->hpas[entry];
> @@ -373,6 +405,9 @@ long mm_iommu_ua_to_hpa_rm(struct mm_iommu_table_grou=
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

--9Iq5ULCa7nGtWwZS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltMHGwACgkQbDjKyiDZ
s5Kw9Q/9Fi3hks3U++TpAqdgG4JjxShitutxGFkCWQIvX4XTImW73LnSz/KmJLlj
2WlnwMEWt+t/hF3xsGyI3Tov9OhynZHcdc9PzKPWeLojRr9fTFK99wVwr+LqbBdD
OhtmQYY9OfJON3EJ4faknmTN6RTDv8ddG3yqbL/qyMtPVEPl4AFmnqCvXazQoCcr
9yhpjQuRnp+rqj6gmv1nq8A3Oa9TgRK9C9DBeunagTTfnDtWSShhn7sb0JkQkjHh
xUrLV2wbmq+6QGVyipssiTaC7m4ybDhvXr3qclNxAZtJ/KvU8p73C3OkkZmetOXq
WYAhQekf+yAaOJcLqNusiroryqTPabkyDVmKnvCHS05Q1VeDhS+ei7UDxrCyHc/r
TSpMggJHoDM0cw1e1BNyDKbejq+5dWwegSTNdJ/dO73fKejxkVJwj+YTWDt733d/
+QL3/f6X30lPI3GV3QlEspGwkSIRgUFkowA1FR2YldOIQbnhFc9fB3TvzAvEXjVQ
e1GnXXhgYD9JK9RjhCmkmMmQcgBQkE+1Lob/x6pWkKtSpvUsLJBWvtsKb21oa6EM
Y8AhrgHU37w/xbcTzCtXolmlp1O2ABfjv0utiWZgxzNJ/tmUkUGTfKkqUrEAIpTh
t48CjAqGnJQdiAi8ZpXP/8fokncpKz1QSKbi/3O1DRg7ndz/8m8=
=eIyI
-----END PGP SIGNATURE-----

--9Iq5ULCa7nGtWwZS--
