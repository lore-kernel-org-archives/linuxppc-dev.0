Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tVK6v0zQ9zDw1s
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2016 14:16:07 +1100 (AEDT)
Date: Fri, 2 Dec 2016 14:02:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org
Subject: Re: [PATCH kernel v7 7/7] powerpc/mm/iommu, vfio/spapr: Put pages on
 VFIO container shutdown
Message-ID: <20161202030209.GE31412@umbus.fritz.box>
References: <1480488725-12783-1-git-send-email-aik@ozlabs.ru>
 <1480488725-12783-8-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="M/SuVGWktc5uNpra"
In-Reply-To: <1480488725-12783-8-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--M/SuVGWktc5uNpra
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 30, 2016 at 05:52:05PM +1100, Alexey Kardashevskiy wrote:
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

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> Changes:
> v7:
> * left sanity check in destroy_context()
> * tce_iommu_prereg_free() does not free tce_iommu_prereg struct if
> mm_iommu_put() failed; VFIO SPAPR container release callback now warns
> on an error
>=20
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
>  arch/powerpc/mm/mmu_context_book3s64.c |  4 +--
>  arch/powerpc/mm/mmu_context_iommu.c    | 11 ------
>  drivers/vfio/vfio_iommu_spapr_tce.c    | 61 ++++++++++++++++++++++++++++=
+++++-
>  3 files changed, 61 insertions(+), 15 deletions(-)
>=20
> diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu=
_context_book3s64.c
> index ad82735..73bf6e1 100644
> --- a/arch/powerpc/mm/mmu_context_book3s64.c
> +++ b/arch/powerpc/mm/mmu_context_book3s64.c
> @@ -156,13 +156,11 @@ static inline void destroy_pagetable_page(struct mm=
_struct *mm)
>  }
>  #endif
> =20
> -
>  void destroy_context(struct mm_struct *mm)
>  {
>  #ifdef CONFIG_SPAPR_TCE_IOMMU
> -	mm_iommu_cleanup(mm);
> +	WARN_ON_ONCE(!list_empty(&mm->context.iommu_group_mem_list));
>  #endif
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
> index 4c03c85..c882357 100644
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
> @@ -102,6 +111,7 @@ struct tce_container {
>  	struct mm_struct *mm;
>  	struct iommu_table *tables[IOMMU_TABLE_GROUP_MAX_TABLES];
>  	struct list_head group_list;
> +	struct list_head prereg_list;
>  };
> =20
>  static long tce_iommu_mm_set(struct tce_container *container)
> @@ -118,10 +128,27 @@ static long tce_iommu_mm_set(struct tce_container *=
container)
>  	return 0;
>  }
> =20
> +static long tce_iommu_prereg_free(struct tce_container *container,
> +		struct tce_iommu_prereg *tcemem)
> +{
> +	long ret;
> +
> +	ret =3D mm_iommu_put(container->mm, tcemem->mem);
> +	if (ret)
> +		return ret;
> +
> +	list_del(&tcemem->next);
> +	kfree(tcemem);
> +
> +	return 0;
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
> @@ -130,7 +157,17 @@ static long tce_iommu_unregister_pages(struct tce_co=
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
> @@ -138,16 +175,29 @@ static long tce_iommu_register_pages(struct tce_con=
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
> @@ -334,6 +384,7 @@ static void *tce_iommu_open(unsigned long arg)
> =20
>  	mutex_init(&container->lock);
>  	INIT_LIST_HEAD_RCU(&container->group_list);
> +	INIT_LIST_HEAD_RCU(&container->prereg_list);
> =20
>  	container->v2 =3D arg =3D=3D VFIO_SPAPR_TCE_v2_IOMMU;
> =20
> @@ -372,6 +423,14 @@ static void tce_iommu_release(void *iommu_data)
>  		tce_iommu_free_table(container, tbl);
>  	}
> =20
> +	while (!list_empty(&container->prereg_list)) {
> +		struct tce_iommu_prereg *tcemem;
> +
> +		tcemem =3D list_first_entry(&container->prereg_list,
> +				struct tce_iommu_prereg, next);
> +		WARN_ON_ONCE(tce_iommu_prereg_free(container, tcemem));
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

--M/SuVGWktc5uNpra
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYQOQxAAoJEGw4ysog2bOSOGkP/2gVZDqULDfhsw1rzkZzY7cw
JVQMYocR+RCfGA42BieHb0OwjGhXDYZnZFgZwmYlP94tsk7f3wtPGeg7E6H0X9aE
tUhUb++ALW6/hFGCcTvGBV+vwieofXNNZeXsG4S++KY321IFalnTBZV+Jinjob2U
7gKwtIaHH2lLbhaEFHR6V8Cn3c+faZN5ROPEFDXJFzPBinamsb3gsHaBB2604IYr
RRBw+ZT5EDzv2T9AZOqlPNg9sHDZNi13ORTSMpzqeNQ6n7LJbqQySBTDspKXL+ni
IVhu8feEHWwcIg1nqmwAWzERG6G0OSR/eFX69vP7KxpIgw861PYotwBHdSJoseu6
8Vit4BCt/Hb1aaDtJDUHXAjSaO97SAk0hmvlcV46zfgIOQCUtJuQigqh3tKnhv3J
uFwQPw4n1v6H6kT07il3D53lEGfcvXcZf1+F6XG4ALYmIkLrozVuMGJCkJCD1074
3uacIc8oNsYDdZeRuGABBCPSvKhC5ZdIsEOd8Q5nO8MaP+WjCV25j5KWGjI/72w0
qacGV2JT4MmcJfP2qhAaPlWmSjS2pNWBVWFh4eh1hCW7QhCTp7er6OXJUS12Hm31
lhxNIE+O/a5umWGid1Fp/44DAn1Szp7kiWEUhM6kRb1PS8Py46L+W8R9F3Q47OV6
NDViG7Ms+rpe0Fzw6opm
=F9q/
-----END PGP SIGNATURE-----

--M/SuVGWktc5uNpra--
