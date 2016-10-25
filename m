Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t30tF3fb1zDvhL
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 15:44:21 +1100 (AEDT)
Date: Tue, 25 Oct 2016 15:44:14 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH kernel v4 4/4] powerpc/mm/iommu, vfio/spapr: Put pages on
 VFIO container shutdown
Message-ID: <20161025044414.GW11052@umbus.fritz.box>
References: <1477291990-2872-1-git-send-email-aik@ozlabs.ru>
 <1477291990-2872-5-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="1J4USyVh4Jt5OGCL"
In-Reply-To: <1477291990-2872-5-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--1J4USyVh4Jt5OGCL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 24, 2016 at 05:53:10PM +1100, Alexey Kardashevskiy wrote:
> At the moment the userspace tool is expected to request pinning of
> the entire guest RAM when VFIO IOMMU SPAPR v2 driver is present.
> When the userspace process finishes, all the pinned pages need to
> be put; this is done as a part of the userspace memory context (MM)
> destruction which happens on the very last mmdrop().
>=20
> This approach has a problem that a MM of the userspace process
> may live longer than the userspace process itself as kernel threads
> use userspace process MMs which was runnning on a CPU where
> the kernel thread was scheduled to. If this happened, the MM remains
> referenced until this exact kernel thread wakes up again
> and releases the very last reference to the MM, on an idle system this
> can take even hours.
>=20
> This moves preregistered regions tracking from MM to VFIO; insteads of
> using mm_iommu_table_group_mem_t::used, tce_container::prereg_list is
> added so each container releases regions which it has pre-registered.
>=20
> This changes the userspace interface to return EBUSY if a memory
> region is already registered in a container. However it should not
> have any practical effect as the only userspace tool available now
> does register memory region once per container anyway.
>=20
> As tce_iommu_register_pages/tce_iommu_unregister_pages are called
> under container->lock, this does not need additional locking.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

On the grounds that this leaves things in a better state than before:

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

On the other hand the implementation is kind of clunky, with the way
it keeps the mm-level and vfio-level lists of regions in parallel.
With this change, does the mm-level list actually serve any purpose at
all, or could it all be moved into the vfio-level list?

> ---
> Changes:
> v4:
> * changed tce_iommu_register_pages() to call mm_iommu_find() first and
> avoid calling mm_iommu_put() if memory is preregistered already
>=20
> v3:
> * moved tce_iommu_prereg_free() call out of list_for_each_entry()
>=20
> v2:
> * updated commit log
> ---
>  arch/powerpc/mm/mmu_context_book3s64.c |  4 ---
>  arch/powerpc/mm/mmu_context_iommu.c    | 11 -------
>  drivers/vfio/vfio_iommu_spapr_tce.c    | 58 ++++++++++++++++++++++++++++=
+++++-
>  3 files changed, 57 insertions(+), 16 deletions(-)
>=20
> diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu=
_context_book3s64.c
> index ad82735..1a07969 100644
> --- a/arch/powerpc/mm/mmu_context_book3s64.c
> +++ b/arch/powerpc/mm/mmu_context_book3s64.c
> @@ -159,10 +159,6 @@ static inline void destroy_pagetable_page(struct mm_=
struct *mm)
> =20
>  void destroy_context(struct mm_struct *mm)
>  {
> -#ifdef CONFIG_SPAPR_TCE_IOMMU
> -	mm_iommu_cleanup(mm);
> -#endif
> -
>  #ifdef CONFIG_PPC_ICSWX
>  	drop_cop(mm->context.acop, mm);
>  	kfree(mm->context.cop_lockp);
> diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_co=
ntext_iommu.c
> index 4c6db09..104bad0 100644
> --- a/arch/powerpc/mm/mmu_context_iommu.c
> +++ b/arch/powerpc/mm/mmu_context_iommu.c
> @@ -365,14 +365,3 @@ void mm_iommu_init(struct mm_struct *mm)
>  {
>  	INIT_LIST_HEAD_RCU(&mm->context.iommu_group_mem_list);
>  }
> -
> -void mm_iommu_cleanup(struct mm_struct *mm)
> -{
> -	struct mm_iommu_table_group_mem_t *mem, *tmp;
> -
> -	list_for_each_entry_safe(mem, tmp, &mm->context.iommu_group_mem_list,
> -			next) {
> -		list_del_rcu(&mem->next);
> -		mm_iommu_do_free(mem);
> -	}
> -}
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iomm=
u_spapr_tce.c
> index 81ab93f..001a488 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -86,6 +86,15 @@ struct tce_iommu_group {
>  };
> =20
>  /*
> + * A container needs to remember which preregistered region  it has
> + * referenced to do proper cleanup at the userspace process exit.
> + */
> +struct tce_iommu_prereg {
> +	struct list_head next;
> +	struct mm_iommu_table_group_mem_t *mem;
> +};
> +
> +/*
>   * The container descriptor supports only a single group per container.
>   * Required by the API as the container is not supplied with the IOMMU g=
roup
>   * at the moment of initialization.
> @@ -98,12 +107,27 @@ struct tce_container {
>  	struct mm_struct *mm;
>  	struct iommu_table *tables[IOMMU_TABLE_GROUP_MAX_TABLES];
>  	struct list_head group_list;
> +	struct list_head prereg_list;
>  };
> =20
> +static long tce_iommu_prereg_free(struct tce_container *container,
> +		struct tce_iommu_prereg *tcemem)
> +{
> +	long ret;
> +
> +	list_del(&tcemem->next);
> +	ret =3D mm_iommu_put(container->mm, tcemem->mem);
> +	kfree(tcemem);
> +
> +	return ret;
> +}
> +
>  static long tce_iommu_unregister_pages(struct tce_container *container,
>  		__u64 vaddr, __u64 size)
>  {
>  	struct mm_iommu_table_group_mem_t *mem;
> +	struct tce_iommu_prereg *tcemem;
> +	bool found =3D false;
> =20
>  	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK))
>  		return -EINVAL;
> @@ -112,7 +136,17 @@ static long tce_iommu_unregister_pages(struct tce_co=
ntainer *container,
>  	if (!mem)
>  		return -ENOENT;
> =20
> -	return mm_iommu_put(container->mm, mem);
> +	list_for_each_entry(tcemem, &container->prereg_list, next) {
> +		if (tcemem->mem =3D=3D mem) {
> +			found =3D true;
> +			break;
> +		}
> +	}
> +
> +	if (!found)
> +		return -ENOENT;
> +
> +	return tce_iommu_prereg_free(container, tcemem);
>  }
> =20
>  static long tce_iommu_register_pages(struct tce_container *container,
> @@ -120,16 +154,29 @@ static long tce_iommu_register_pages(struct tce_con=
tainer *container,
>  {
>  	long ret =3D 0;
>  	struct mm_iommu_table_group_mem_t *mem =3D NULL;
> +	struct tce_iommu_prereg *tcemem;
>  	unsigned long entries =3D size >> PAGE_SHIFT;
> =20
>  	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK) ||
>  			((vaddr + size) < vaddr))
>  		return -EINVAL;
> =20
> +	mem =3D mm_iommu_find(container->mm, vaddr, entries);
> +	if (mem) {
> +		list_for_each_entry(tcemem, &container->prereg_list, next) {
> +			if (tcemem->mem =3D=3D mem)
> +				return -EBUSY;
> +		}
> +	}
> +
>  	ret =3D mm_iommu_get(container->mm, vaddr, entries, &mem);
>  	if (ret)
>  		return ret;
> =20
> +	tcemem =3D kzalloc(sizeof(*tcemem), GFP_KERNEL);
> +	tcemem->mem =3D mem;
> +	list_add(&tcemem->next, &container->prereg_list);
> +
>  	container->enabled =3D true;
> =20
>  	return 0;
> @@ -311,6 +358,7 @@ static void *tce_iommu_open(unsigned long arg)
> =20
>  	mutex_init(&container->lock);
>  	INIT_LIST_HEAD_RCU(&container->group_list);
> +	INIT_LIST_HEAD_RCU(&container->prereg_list);
> =20
>  	container->v2 =3D arg =3D=3D VFIO_SPAPR_TCE_v2_IOMMU;
> =20
> @@ -353,6 +401,14 @@ static void tce_iommu_release(void *iommu_data)
>  		tce_iommu_free_table(container, tbl);
>  	}
> =20
> +	while (!list_empty(&container->prereg_list)) {
> +		struct tce_iommu_prereg *tcemem;
> +
> +		tcemem =3D list_first_entry(&container->prereg_list,
> +				struct tce_iommu_prereg, next);
> +		tce_iommu_prereg_free(container, tcemem);
> +	}
> +
>  	tce_iommu_disable(container);
>  	mmdrop(container->mm);
>  	mutex_destroy(&container->lock);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1J4USyVh4Jt5OGCL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYDuMeAAoJEGw4ysog2bOS1doQAISB+Xh3g/9iDHVcRhyEiIlE
CXYSvTSU7GSG9ABvhDHlv2lIAQuqxcXtNyMJ04ZAhYKLXE7dimddceOVQOvmHLiz
tMmcEY4h7bP8eToGG7CZH1tAKtmy1qnN4SoM2TAvCK/6BsHWDZfIiGZNtfVLsAOv
LVTHgkUOXqvxeFuLdZVcZUj0TUo3GAZu6xwYG6gWWfvSmQ/zW//NeBZIa4L94zKf
rtWRe14H9fW/rnyKpp+DOLterdhO07wT3KDBHTT5zJUUrOkx+sxlOospEbbaMYe3
8LRPN5ZSBGz3/wR6f3PxgwpQaELNBIbvtWeOmUx+uyGA5aQ/8q2JqReb5OXbYw7i
gYBb60l1eziO0SrK7WEVJkvHzGAXAQFMS2zb12GP2KNnAfCKFCLVs9JW+exUe7ox
BEnQPbZr66XjB2yc5h1gZ9zsrYg35zjnEXyqdL01YAS1qM5gFWiPVm50iz7soyE8
k8+/1UGAKvKQOC1Dm/0nPy/6x/KflisRB1jBjs8L1c5hIoPImzUKPdBzW+7Sdhpc
82k+TEVWeuLUHodJRUncKPk6dWMo1Xd7usLyIhd0PRUtVoTpAnCRYh9agvzZq+lN
vCUvhHQo+x5IXBjM7N30dsmtnRMxV2FEfn5MJP4IeqgYfrxsHPD4XZOaNqS0uwhF
l5zqWgKZCuaseT1iJ9eM
=CeZc
-----END PGP SIGNATURE-----

--1J4USyVh4Jt5OGCL--
