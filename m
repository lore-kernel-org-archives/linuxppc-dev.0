Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9VRc1l28zDr1m
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 13:17:00 +1000 (AEST)
Date: Fri, 12 Aug 2016 13:13:56 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH kernel 06/15] powerpc/mm/iommu: Put pages on process exit
Message-ID: <20160812031356.GI16493@voom.fritz.box>
References: <1470213656-1042-1-git-send-email-aik@ozlabs.ru>
 <1470213656-1042-7-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="a7XSrSxqzVsaECgU"
In-Reply-To: <1470213656-1042-7-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--a7XSrSxqzVsaECgU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 03, 2016 at 06:40:47PM +1000, Alexey Kardashevskiy wrote:
> At the moment VFIO IOMMU SPAPR v2 driver pins all guest RAM pages when
> the userspace starts using VFIO.

This doesn't sound accurate.  Isn't it userspace that decides what
gets pinned, not the VFIO driver?

>When the userspace process finishes,
> all the pinned pages need to be put; this is done as a part of
> the userspace memory context (MM) destruction which happens on
> the very last mmdrop().
>=20
> This approach has a problem that a MM of the userspace process
> may live longer than the userspace process itself as kernel threads
> use userspace process MMs which was runnning on a CPU where
> the kernel thread was scheduled to. If this happened, the MM remains
> referenced until this exact kernel thread wakes up again
> and releases the very last reference to the MM, on an idle system this
> can take even hours.
>=20
> This references and caches MM once per container and adds tracking
> how many times each preregistered area was registered in
> a specific container. This way we do not depend on @current pointing to
> a valid task descriptor.

The handling of @current and refcounting the mm sounds more like its
describing the previous patch.

THe description of counting how many times each prereg area is
registered doesn't seem accurate, since you block multiple
registration with an EBUSY.  Or else it's describing the 'used'
counter in the lower-level mm_iommu_table_group_mem_t tracking,
rather than anything changed by this patch.

> This changes the userspace interface to return EBUSY if memory is
> already registered (mm_iommu_get() used to increment the counter);
> however it should not have any practical effect as the only
> userspace tool available now does register memory area once per
> container anyway.
>=20
> As tce_iommu_register_pages/tce_iommu_unregister_pages are called
> under container->lock, this does not need additional locking.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>=20
> # Conflicts:
> #	arch/powerpc/include/asm/mmu_context.h
> #	arch/powerpc/mm/mmu_context_book3s64.c
> #	arch/powerpc/mm/mmu_context_iommu.c

Looks like some lines to be cleaned up in the message.

> ---
>  arch/powerpc/include/asm/mmu_context.h |  1 -
>  arch/powerpc/mm/mmu_context_book3s64.c |  4 ---
>  arch/powerpc/mm/mmu_context_iommu.c    | 11 -------
>  drivers/vfio/vfio_iommu_spapr_tce.c    | 52 ++++++++++++++++++++++++++++=
+++++-
>  4 files changed, 51 insertions(+), 17 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/includ=
e/asm/mmu_context.h
> index b85cc7b..a4c4ed5 100644
> --- a/arch/powerpc/include/asm/mmu_context.h
> +++ b/arch/powerpc/include/asm/mmu_context.h
> @@ -25,7 +25,6 @@ extern long mm_iommu_get(struct mm_struct *mm,
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
> index ee6685b..10f01fe 100644
> --- a/arch/powerpc/mm/mmu_context_iommu.c
> +++ b/arch/powerpc/mm/mmu_context_iommu.c
> @@ -293,14 +293,3 @@ void mm_iommu_init(struct mm_struct *mm)
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
> index 9752e77..40e71a0 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -89,6 +89,15 @@ struct tce_iommu_group {
>  };
> =20
>  /*
> + * A container needs to remember which preregistered areas and how many =
times
> + * it has referenced to do proper cleanup at the userspace process exit.
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
> @@ -140,6 +169,18 @@ static long tce_iommu_register_pages(struct tce_cont=
ainer *container,
>  	ret =3D mm_iommu_get(container->mm, vaddr, entries, &mem);
>  	if (ret)
>  		return ret;
> +
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
> @@ -325,6 +366,7 @@ static void *tce_iommu_open(unsigned long arg)
> =20
>  	mutex_init(&container->lock);
>  	INIT_LIST_HEAD_RCU(&container->group_list);
> +	INIT_LIST_HEAD_RCU(&container->prereg_list);
> =20
>  	container->v2 =3D arg =3D=3D VFIO_SPAPR_TCE_v2_IOMMU;
> =20
> @@ -362,6 +404,14 @@ static void tce_iommu_release(void *iommu_data)
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

--a7XSrSxqzVsaECgU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXrT70AAoJEGw4ysog2bOSJa0QAK3oYzx/JDpQhCeIFMwWcCIi
L5lejLS5Hs1iqs7hn/dAnjF0HrMtXs7EPenhRB0FWp1NXDv5/JiZXEKXoIr9DZXz
6b8EXSwDeitVd5wnJgTbA/B8DB+GtLrMFk8UBemtinIRc8dTPHwmQubJ7WSYuquq
RBwYsKM9PBtlynoLkDiL1a2ReNMpGhG96ZDFEY1vPOnjZflraujdoflRyOykcxwZ
KpxLhqNFDHMb9k2/7SE5ZLlLCgoxfVEVWt5H/Ya+/yCgdsHLKCfpaZIJjRZ+1e0r
1IvIzET704D88XmFnFBxqhrZrTfx0/UUT+7FSxOEG7A1Zdxy1Q5ENfmwiIVCGWkk
Hr9u2jWk4JHG6OVNx8mkEmHlUULI9y1KtzXtyMJVXX2mzMG4UTcaQGLF8mOFWf0K
xgI43F+GBQM3RbszrEu+I7KY8+0I+rwboIuwxuG+k7jizY/USTnfKeA5F2lo8b2h
1wqY/b4ORAs4E+qqGZkX/C0UqGNh0YiTEdGwSMXC/olAWTHIuHX/3ir+5X7M1XrX
FTTRVEDyhSnw88DJNq5jMnBtFYkhg+lRfthYksT2jsmZxjz1acfPDD+Yz6oYNI/B
8vDkSVI1et3VQy4M2I0Ct8K/N6LxCSTrSroLr8/CfltO+rb5RC30V83iAZpNZzPo
dfFxdVsxlHKRcwptgR5N
=i7q0
-----END PGP SIGNATURE-----

--a7XSrSxqzVsaECgU--
