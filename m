Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3svf7x34Y6zDsxq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 16:15:41 +1100 (AEDT)
Date: Thu, 13 Oct 2016 13:43:11 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH kernel v2 2/2] powerpc/mm/iommu, vfio/spapr: Put pages on
 VFIO container shutdown
Message-ID: <20161013024311.GK18039@umbus.fritz.box>
References: <1476248308-41754-1-git-send-email-aik@ozlabs.ru>
 <1476248308-41754-3-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Z9t8O/5YJLB6LEUl"
In-Reply-To: <1476248308-41754-3-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Z9t8O/5YJLB6LEUl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 12, 2016 at 03:58:28PM +1100, Alexey Kardashevskiy wrote:
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
> ---
> Changes:
> v2:
> * updated commit log
> ---
>  arch/powerpc/include/asm/mmu_context.h |  1 -
>  arch/powerpc/mm/mmu_context_book3s64.c |  4 ---
>  arch/powerpc/mm/mmu_context_iommu.c    | 11 --------
>  drivers/vfio/vfio_iommu_spapr_tce.c    | 51 ++++++++++++++++++++++++++++=
+++++-
>  4 files changed, 50 insertions(+), 17 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/includ=
e/asm/mmu_context.h
> index b9e3f0a..a6e18b5 100644
> --- a/arch/powerpc/include/asm/mmu_context.h
> +++ b/arch/powerpc/include/asm/mmu_context.h
> @@ -26,7 +26,6 @@ extern long mm_iommu_get(struct mm_struct *mm,
>  extern long mm_iommu_put(struct mm_struct *mm,
>  		struct mm_iommu_table_group_mem_t *mem);
>  extern void mm_iommu_init(struct mm_struct *mm);
> -extern void mm_iommu_cleanup(struct mm_struct *mm);
>  extern struct mm_iommu_table_group_mem_t *mm_iommu_lookup(struct mm_stru=
ct *mm,
>  		unsigned long ua, unsigned long size);
>  extern struct mm_iommu_table_group_mem_t *mm_iommu_find(struct mm_struct=
 *mm,
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
> index 3d2a65c..c8e9796 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -89,6 +89,15 @@ struct tce_iommu_group {
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
> @@ -101,12 +110,26 @@ struct tce_container {
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
> =20
>  	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK))
>  		return -EINVAL;
> @@ -115,7 +138,12 @@ static long tce_iommu_unregister_pages(struct tce_co=
ntainer *container,
>  	if (!mem)
>  		return -ENOENT;
> =20
> -	return mm_iommu_put(container->mm, mem);
> +	list_for_each_entry(tcemem, &container->prereg_list, next) {
> +		if (tcemem->mem =3D=3D mem)
> +			return tce_iommu_prereg_free(container, tcemem);

Hrm.. you're deleting tcemem from the list from within a
list_for_each_entry (without _safe).  It's probably not actually a
use-after-free, because you return before hitting the next loop
iteration, but that's pretty fragile and non-obvious.

I think you'd be better using a break;, then doing the prereg_free()
after the loop.

> +	}
> +
> +	return -ENOENT;
>  }
> =20
>  static long tce_iommu_register_pages(struct tce_container *container,
> @@ -123,6 +151,7 @@ static long tce_iommu_register_pages(struct tce_conta=
iner *container,
>  {
>  	long ret =3D 0;
>  	struct mm_iommu_table_group_mem_t *mem =3D NULL;
> +	struct tce_iommu_prereg *tcemem;
>  	unsigned long entries =3D size >> PAGE_SHIFT;
> =20
>  	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK) ||
> @@ -142,6 +171,17 @@ static long tce_iommu_register_pages(struct tce_cont=
ainer *container,
>  	if (ret)
>  		return ret;
> =20
> +	list_for_each_entry(tcemem, &container->prereg_list, next) {
> +		if (tcemem->mem =3D=3D mem) {
> +			mm_iommu_put(container->mm, mem);
> +			return -EBUSY;
> +		}
> +	}
> +
> +	tcemem =3D kzalloc(sizeof(*tcemem), GFP_KERNEL);
> +	tcemem->mem =3D mem;
> +	list_add(&tcemem->next, &container->prereg_list);
> +
>  	container->enabled =3D true;
> =20
>  	return 0;
> @@ -327,6 +367,7 @@ static void *tce_iommu_open(unsigned long arg)
> =20
>  	mutex_init(&container->lock);
>  	INIT_LIST_HEAD_RCU(&container->group_list);
> +	INIT_LIST_HEAD_RCU(&container->prereg_list);
> =20
>  	container->v2 =3D arg =3D=3D VFIO_SPAPR_TCE_v2_IOMMU;
> =20
> @@ -364,6 +405,14 @@ static void tce_iommu_release(void *iommu_data)
>  		tce_iommu_free_table(tbl);
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
>  	if (container->mm)
>  		mmdrop(container->mm);
>  	tce_iommu_disable(container);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Z9t8O/5YJLB6LEUl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX/vS9AAoJEGw4ysog2bOSIxYP/iGC+ni9prQ6cQk2nKQA9lsJ
32cXQ2vaAB8nwrKgZ+mmJgxZYNX/pYJ6SMuPbqkcEElFt/dvEce6/QoIpnX+TqmK
SJppdfNjzDGHDSM4gpTDLR2hBpzhzNvMlHHcnf+msmkrO3fa5+wMH4vym4qm+5hD
AwYKFI0LPd+9FNYrsQ2TTmgV9eek0IKaYAfBwbtYRJQNFpgg7rAgYEaGEVLqhJPB
6fHBQSn0mcqNKsNYiaXWwD7uyACyvW7PexhGj7INGtENZEjI7wU/dTH3ZwS6PkLO
nCIwtRESquexF7VYiagT4k/ZLzFIZkaT+GMHYS2Do1iu4Jt3kJtDWSVpi1z8xD5j
jR8L76vhvPRzOum4Th9vOh/QEh9TaNl2r5r8KSfdOIQb8KhBCrqUzb5sdFiOf8iX
tYtSdbLlde/xnpxuK+KtJvbG5dbLlTs7GIlnUvBdNtOuS5V62ImyHZnAOuapNliv
ZCWSxxKl/PoNdw+IbeFltH3Q/1LwiInCdQetPNif1IpFBEG6TjyGNHcIZwxu8qjj
QTekSd3NBSatVzG2tnSa947i7ESzLpUfNNyMuS5B6a9UR5DeLHZu8SFyDJdFfarg
Rtbd3pPQWvb9HCm7ebneyvb1oKd78Qu37/+iFrpeYpWyDUVvWauLrlFEJj3xsR1h
kncurqJ3c6J+9l+vD2zz
=I09L
-----END PGP SIGNATURE-----

--Z9t8O/5YJLB6LEUl--
