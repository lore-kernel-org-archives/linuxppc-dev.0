Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSX8Z0rmwzDvjw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 16:26:22 +1100 (AEDT)
Date: Tue, 29 Nov 2016 16:07:32 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org
Subject: Re: [PATCH kernel v6 7/7] powerpc/mm/iommu, vfio/spapr: Put pages on
 VFIO container shutdown
Message-ID: <20161129050732.GN13307@umbus.fritz.box>
References: <1479966490-8739-1-git-send-email-aik@ozlabs.ru>
 <1479966490-8739-8-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8CNmCRe8Sh4keFKJ"
In-Reply-To: <1479966490-8739-8-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--8CNmCRe8Sh4keFKJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 24, 2016 at 04:48:10PM +1100, Alexey Kardashevskiy wrote:
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

Incidentally, I think this change will also help if we ever had a use
case of a long-lived process that only occasionally (rather than
constantly) uses VFIO.  IIUC, before this change, when the process
shuts down VFIO the locked memory would still be accounted until the
process exits, even if it keeps running for a long time without VFIO.

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

Would it be worth having a WARN_ON() here (or somewhere in the
callchain) to verify that all iommu preregs have been removed by the
time the context is removed?

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
> index b2fb05ac..86c9348 100644
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

So, as a future optimization, you might be able to (sort of) avoid
having both the per-container list and the per-mm list if you put a
private list pointer of some sort into mm_iommu_table_group_mem_t -
i.e. allowing both a list of all the preregs for a whole mm, and a
sub-list of all those for a single container on the same structure.

> +
> +/*
>   * The container descriptor supports only a single group per container.
>   * Required by the API as the container is not supplied with the IOMMU g=
roup
>   * at the moment of initialization.
> @@ -102,6 +111,7 @@ struct tce_container {
>  	struct mm_struct *mm;
>  	struct iommu_table *tables[IOMMU_TABLE_GROUP_MAX_TABLES];
>  	struct list_head group_list;
> +	struct list_head prereg_list;
>  };
> =20
>  static long tce_iommu_mm_set(struct tce_container *container)
> @@ -118,10 +128,24 @@ static long tce_iommu_mm_set(struct tce_container *=
container)
>  	return 0;
>  }
> =20
> +static long tce_iommu_prereg_free(struct tce_container *container,
> +		struct tce_iommu_prereg *tcemem)
> +{
> +	long ret;
> +
> +	list_del(&tcemem->next);
> +	ret =3D mm_iommu_put(container->mm, tcemem->mem);

What happens in the error case here.  ENOENT should never happen, but
IIUC an EBUSY could happen.  If it does the entry will still be in the
per-mm list, but will be removed from the container list which sounds
like it could be bad.

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
> @@ -130,7 +154,17 @@ static long tce_iommu_unregister_pages(struct tce_co=
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
> @@ -138,16 +172,29 @@ static long tce_iommu_register_pages(struct tce_con=
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
> @@ -334,6 +381,7 @@ static void *tce_iommu_open(unsigned long arg)
> =20
>  	mutex_init(&container->lock);
>  	INIT_LIST_HEAD_RCU(&container->group_list);
> +	INIT_LIST_HEAD_RCU(&container->prereg_list);
> =20
>  	container->v2 =3D arg =3D=3D VFIO_SPAPR_TCE_v2_IOMMU;
> =20
> @@ -372,6 +420,14 @@ static void tce_iommu_release(void *iommu_data)
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
>  	if (container->mm)
>  		mmdrop(container->mm);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8CNmCRe8Sh4keFKJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYPQ0RAAoJEGw4ysog2bOSDiQP/36FYc+g/JBxJ3dCVE5ZE+h+
61ssbtE8kudlHSsrQ9BP+9oOL3HQYl3F1DbPCKWQktoe9YOQHZ7091p8f12jOCWF
0+LzOAhxzhDu59RHLQKW6hid2u1VTow+kuk7NbabgmeULwv8vRWnkII/ihUhWdA+
+A65VGl4lw6G7kNEYUcbMg6qJGrPCqJO+GPpVtcN8oogLkOF64Cd21xyS7xquLRX
bCArxAFjJgucOlBwXoixEk0IqrwF97qWSKdzPKFAnNosEZInTnr78/iG5A9F6eKV
fA5V20pfi7ZMDgUQHu2casIk6x+nT/syNFdSdu8lKIMGcWQ/BkIHdbEO+oyPB7Pb
9iFH8pJCwVqj+cAURBTvBy1IXyqh0qwlBdycyxWcNZ8REH1vvR+UuEZ8SvwsLeKw
GGCP1znV+i8qSHh0745n4KOf1GMlFkHaOji397/dxDC4bHKGMSITEY71BMr1oNzL
C3HdGKsSiZH28TIXAacY6oRuaDFFOr5dxdym4zUrEvMebBQzPUvPKkbWyUdHYm43
AnAM/UNcSIC5rN4TXoi3J0gPALK8BlTRl6pqA5azT5NSWHH/qNZDJfqIg1DPp7lo
xvF5mjgiHqdeb2xhbJC9v4/IJ2a3H6KC9T9liBk1n+G5nO09E/GPbEOykOMNniW4
a1uS48C9FPzaG9hapLxS
=A5i5
-----END PGP SIGNATURE-----

--8CNmCRe8Sh4keFKJ--
