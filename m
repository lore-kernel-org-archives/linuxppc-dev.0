Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t0SXG44tHzDvYL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 12:19:58 +1100 (AEDT)
Date: Fri, 21 Oct 2016 11:29:33 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org
Subject: Re: [PATCH kernel v3 4/4] powerpc/mm/iommu, vfio/spapr: Put pages on
 VFIO container shutdown
Message-ID: <20161021002933.GU11140@umbus.fritz.box>
References: <1476932630-45323-1-git-send-email-aik@ozlabs.ru>
 <1476932630-45323-5-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UC+RhZhEc8lcmajv"
In-Reply-To: <1476932630-45323-5-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--UC+RhZhEc8lcmajv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 20, 2016 at 02:03:50PM +1100, Alexey Kardashevskiy wrote:
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
> v3:
> * moved tce_iommu_prereg_free() call out of list_for_each_entry()
>=20
> v2:
> * updated commit log
> ---
>  arch/powerpc/mm/mmu_context_book3s64.c |  4 ---
>  arch/powerpc/mm/mmu_context_iommu.c    | 11 --------
>  drivers/vfio/vfio_iommu_spapr_tce.c    | 49 ++++++++++++++++++++++++++++=
+++++-
>  3 files changed, 48 insertions(+), 16 deletions(-)
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
> index 6b0b121..3e2f757 100644
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
>  	if (!current || !current->mm)
>  		return -ESRCH; /* process exited */
> @@ -115,7 +139,17 @@ static long tce_iommu_unregister_pages(struct tce_co=
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
> @@ -123,6 +157,7 @@ static long tce_iommu_register_pages(struct tce_conta=
iner *container,
>  {
>  	long ret =3D 0;
>  	struct mm_iommu_table_group_mem_t *mem =3D NULL;
> +	struct tce_iommu_prereg *tcemem;
>  	unsigned long entries =3D size >> PAGE_SHIFT;
> =20
>  	if (!current || !current->mm)
> @@ -136,6 +171,17 @@ static long tce_iommu_register_pages(struct tce_cont=
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

Wouldn't it make more sense to do this duplicate check before the
mm_iommu_get(), so you don't have to roll it back on this error path.

> +
> +	tcemem =3D kzalloc(sizeof(*tcemem), GFP_KERNEL);
> +	tcemem->mem =3D mem;
> +	list_add(&tcemem->next, &container->prereg_list);
> +
>  	container->enabled =3D true;
> =20
>  	return 0;
> @@ -320,6 +366,7 @@ static void *tce_iommu_open(unsigned long arg)
> =20
>  	mutex_init(&container->lock);
>  	INIT_LIST_HEAD_RCU(&container->group_list);
> +	INIT_LIST_HEAD_RCU(&container->prereg_list);
> =20
>  	container->v2 =3D arg =3D=3D VFIO_SPAPR_TCE_v2_IOMMU;
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--UC+RhZhEc8lcmajv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYCWFtAAoJEGw4ysog2bOS/2IQANMNAToWced9yAMy8ZvUOaLV
YiEPB4vEsNlTiEQ/u1mhHaMb738YNEM8VI+QsLMNP40XB7Ys0mR0Me1q2hyxqmqd
nnsAy7734KH4Xe+kdY96FAFaPSfmS6m0uiriAwqrjo5r6Aw8Flg68XVdbgu+6kOI
3mkFJDprg4gwPGwO6za8yFQsO17qFlGzDvZl2IYd+0BVXKjy9nTmMaQyqceqRRci
HjLu8j9ofoytw1CGYvIwiXHqPZowfCHGptVCFGzarUYKj3GCO75fE+c/QUJKn6/4
/3LYcVq3OYuQqGjoOpGK2L34o8/I6UTITA/BhljhZodysdHfNN5lj3P5HH0v3KeN
3rjfWPtYPobf7eLxgKytM2vxf/2GklepQdUA4qJyTTntzN9dPwZydSSepVy1BkOW
XFSealHpsEWFB0jJPSCtCdcbvoYwD91esgkSZzg8h8u68eSzKSsV2RPMIVubFF0V
QUBILoJEiRGfdHyv+6k97koGpwZHNee5bn+7sP71LweCrTuYTjWFUdi2GpAsDU6l
3xViGviH20kzWMVfm0SMbFhrKuGfEEoanp2UeSaSTIQUW0M65M8NQdPIWnd9vfvS
dtYyroAbxMJmIgj4qKkC2Y0jWyeWWHprUi1OFlUT//R2ftwYhWh+WcnU+MiLV+5A
Zb0ZhmSaUXshV2o4vHX0
=Pm0c
-----END PGP SIGNATURE-----

--UC+RhZhEc8lcmajv--
