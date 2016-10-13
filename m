Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3svf7w6djtzDsxn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 16:15:40 +1100 (AEDT)
Date: Thu, 13 Oct 2016 13:25:01 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH kernel v2 1/2] powerpc/iommu: Stop using @current in
 mm_iommu_xxx
Message-ID: <20161013022501.GJ18039@umbus.fritz.box>
References: <1476248308-41754-1-git-send-email-aik@ozlabs.ru>
 <1476248308-41754-2-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KjX7LgAomYr70Ka9"
In-Reply-To: <1476248308-41754-2-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--KjX7LgAomYr70Ka9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 12, 2016 at 03:58:27PM +1100, Alexey Kardashevskiy wrote:
> In some situations the userspace memory context may live longer than
> the userspace process itself so if we need to do proper memory context
> cleanup, we better cache @mm and use it later when the process is gone
> (@current or @current->mm are NULL).
>=20
> This changes mm_iommu_xxx API to receive mm_struct instead of using one
> from @current.
>=20
> This references and caches MM once per container so we do not depend
> on @current pointing to a valid task descriptor anymore.
>=20
> This is needed by the following patch to do proper cleanup in time.
> This depends on "powerpc/powernv/ioda: Fix endianness when reading TCEs"
> to do proper cleanup via tce_iommu_clear() patch.
>=20
> To keep API consistent, this replaces mm_context_t with mm_struct;
> we stick to mm_struct as mm_iommu_adjust_locked_vm() helper needs
> access to &mm->mmap_sem.
>=20
> This should cause no behavioral change.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> Acked-by: Balbir Singh <bsingharora@gmail.com>
> ---
> Changes:
> v2:
> * added BUG_ON(container->mm && (container->mm !=3D current->mm)) in
> tce_iommu_register_pages()
> * added note about containers referencing MM
> ---
>  arch/powerpc/include/asm/mmu_context.h | 20 +++++++------
>  arch/powerpc/kernel/setup-common.c     |  2 +-
>  arch/powerpc/mm/mmu_context_book3s64.c |  4 +--
>  arch/powerpc/mm/mmu_context_iommu.c    | 55 ++++++++++++++--------------=
------
>  drivers/vfio/vfio_iommu_spapr_tce.c    | 41 ++++++++++++++++---------
>  5 files changed, 63 insertions(+), 59 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/includ=
e/asm/mmu_context.h
> index 5c45114..b9e3f0a 100644
> --- a/arch/powerpc/include/asm/mmu_context.h
> +++ b/arch/powerpc/include/asm/mmu_context.h
> @@ -19,16 +19,18 @@ extern void destroy_context(struct mm_struct *mm);
>  struct mm_iommu_table_group_mem_t;
> =20
>  extern int isolate_lru_page(struct page *page);	/* from internal.h */
> -extern bool mm_iommu_preregistered(void);
> -extern long mm_iommu_get(unsigned long ua, unsigned long entries,
> +extern bool mm_iommu_preregistered(struct mm_struct *mm);
> +extern long mm_iommu_get(struct mm_struct *mm,
> +		unsigned long ua, unsigned long entries,
>  		struct mm_iommu_table_group_mem_t **pmem);
> -extern long mm_iommu_put(struct mm_iommu_table_group_mem_t *mem);
> -extern void mm_iommu_init(mm_context_t *ctx);
> -extern void mm_iommu_cleanup(mm_context_t *ctx);
> -extern struct mm_iommu_table_group_mem_t *mm_iommu_lookup(unsigned long =
ua,
> -		unsigned long size);
> -extern struct mm_iommu_table_group_mem_t *mm_iommu_find(unsigned long ua,
> -		unsigned long entries);
> +extern long mm_iommu_put(struct mm_struct *mm,
> +		struct mm_iommu_table_group_mem_t *mem);
> +extern void mm_iommu_init(struct mm_struct *mm);
> +extern void mm_iommu_cleanup(struct mm_struct *mm);
> +extern struct mm_iommu_table_group_mem_t *mm_iommu_lookup(struct mm_stru=
ct *mm,
> +		unsigned long ua, unsigned long size);
> +extern struct mm_iommu_table_group_mem_t *mm_iommu_find(struct mm_struct=
 *mm,
> +		unsigned long ua, unsigned long entries);
>  extern long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem,
>  		unsigned long ua, unsigned long *hpa);
>  extern long mm_iommu_mapped_inc(struct mm_iommu_table_group_mem_t *mem);
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/set=
up-common.c
> index dba265c..942cf49 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -906,7 +906,7 @@ void __init setup_arch(char **cmdline_p)
>  	init_mm.context.pte_frag =3D NULL;
>  #endif
>  #ifdef CONFIG_SPAPR_TCE_IOMMU
> -	mm_iommu_init(&init_mm.context);
> +	mm_iommu_init(&init_mm);
>  #endif
>  	irqstack_early_init();
>  	exc_lvl_early_init();
> diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu=
_context_book3s64.c
> index b114f8b..ad82735 100644
> --- a/arch/powerpc/mm/mmu_context_book3s64.c
> +++ b/arch/powerpc/mm/mmu_context_book3s64.c
> @@ -115,7 +115,7 @@ int init_new_context(struct task_struct *tsk, struct =
mm_struct *mm)
>  	mm->context.pte_frag =3D NULL;
>  #endif
>  #ifdef CONFIG_SPAPR_TCE_IOMMU
> -	mm_iommu_init(&mm->context);
> +	mm_iommu_init(mm);
>  #endif
>  	return 0;
>  }
> @@ -160,7 +160,7 @@ static inline void destroy_pagetable_page(struct mm_s=
truct *mm)
>  void destroy_context(struct mm_struct *mm)
>  {
>  #ifdef CONFIG_SPAPR_TCE_IOMMU
> -	mm_iommu_cleanup(&mm->context);
> +	mm_iommu_cleanup(mm);
>  #endif
> =20
>  #ifdef CONFIG_PPC_ICSWX
> diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_co=
ntext_iommu.c
> index e0f1c33..4c6db09 100644
> --- a/arch/powerpc/mm/mmu_context_iommu.c
> +++ b/arch/powerpc/mm/mmu_context_iommu.c
> @@ -56,7 +56,7 @@ static long mm_iommu_adjust_locked_vm(struct mm_struct =
*mm,
>  	}
> =20
>  	pr_debug("[%d] RLIMIT_MEMLOCK HASH64 %c%ld %ld/%ld\n",
> -			current->pid,
> +			current ? current->pid : 0,
>  			incr ? '+' : '-',
>  			npages << PAGE_SHIFT,
>  			mm->locked_vm << PAGE_SHIFT,
> @@ -66,12 +66,9 @@ static long mm_iommu_adjust_locked_vm(struct mm_struct=
 *mm,
>  	return ret;
>  }
> =20
> -bool mm_iommu_preregistered(void)
> +bool mm_iommu_preregistered(struct mm_struct *mm)
>  {
> -	if (!current || !current->mm)
> -		return false;
> -
> -	return !list_empty(&current->mm->context.iommu_group_mem_list);
> +	return !list_empty(&mm->context.iommu_group_mem_list);
>  }
>  EXPORT_SYMBOL_GPL(mm_iommu_preregistered);
> =20
> @@ -124,19 +121,16 @@ static int mm_iommu_move_page_from_cma(struct page =
*page)
>  	return 0;
>  }
> =20
> -long mm_iommu_get(unsigned long ua, unsigned long entries,
> +long mm_iommu_get(struct mm_struct *mm, unsigned long ua, unsigned long =
entries,
>  		struct mm_iommu_table_group_mem_t **pmem)
>  {
>  	struct mm_iommu_table_group_mem_t *mem;
>  	long i, j, ret =3D 0, locked_entries =3D 0;
>  	struct page *page =3D NULL;
> =20
> -	if (!current || !current->mm)
> -		return -ESRCH; /* process exited */
> -
>  	mutex_lock(&mem_list_mutex);
> =20
> -	list_for_each_entry_rcu(mem, &current->mm->context.iommu_group_mem_list,
> +	list_for_each_entry_rcu(mem, &mm->context.iommu_group_mem_list,
>  			next) {
>  		if ((mem->ua =3D=3D ua) && (mem->entries =3D=3D entries)) {
>  			++mem->used;
> @@ -154,7 +148,7 @@ long mm_iommu_get(unsigned long ua, unsigned long ent=
ries,
> =20
>  	}
> =20
> -	ret =3D mm_iommu_adjust_locked_vm(current->mm, entries, true);
> +	ret =3D mm_iommu_adjust_locked_vm(mm, entries, true);
>  	if (ret)
>  		goto unlock_exit;
> =20
> @@ -215,11 +209,11 @@ long mm_iommu_get(unsigned long ua, unsigned long e=
ntries,
>  	mem->entries =3D entries;
>  	*pmem =3D mem;
> =20
> -	list_add_rcu(&mem->next, &current->mm->context.iommu_group_mem_list);
> +	list_add_rcu(&mem->next, &mm->context.iommu_group_mem_list);
> =20
>  unlock_exit:
>  	if (locked_entries && ret)
> -		mm_iommu_adjust_locked_vm(current->mm, locked_entries, false);
> +		mm_iommu_adjust_locked_vm(mm, locked_entries, false);
> =20
>  	mutex_unlock(&mem_list_mutex);
> =20
> @@ -264,17 +258,13 @@ static void mm_iommu_free(struct rcu_head *head)
>  static void mm_iommu_release(struct mm_iommu_table_group_mem_t *mem)
>  {
>  	list_del_rcu(&mem->next);
> -	mm_iommu_adjust_locked_vm(current->mm, mem->entries, false);
>  	call_rcu(&mem->rcu, mm_iommu_free);
>  }
> =20
> -long mm_iommu_put(struct mm_iommu_table_group_mem_t *mem)
> +long mm_iommu_put(struct mm_struct *mm, struct mm_iommu_table_group_mem_=
t *mem)
>  {
>  	long ret =3D 0;
> =20
> -	if (!current || !current->mm)
> -		return -ESRCH; /* process exited */
> -
>  	mutex_lock(&mem_list_mutex);
> =20
>  	if (mem->used =3D=3D 0) {
> @@ -297,6 +287,8 @@ long mm_iommu_put(struct mm_iommu_table_group_mem_t *=
mem)
>  	/* @mapped became 0 so now mappings are disabled, release the region */
>  	mm_iommu_release(mem);
> =20
> +	mm_iommu_adjust_locked_vm(mm, mem->entries, false);
> +
>  unlock_exit:
>  	mutex_unlock(&mem_list_mutex);
> =20
> @@ -304,14 +296,12 @@ long mm_iommu_put(struct mm_iommu_table_group_mem_t=
 *mem)
>  }
>  EXPORT_SYMBOL_GPL(mm_iommu_put);
> =20
> -struct mm_iommu_table_group_mem_t *mm_iommu_lookup(unsigned long ua,
> -		unsigned long size)
> +struct mm_iommu_table_group_mem_t *mm_iommu_lookup(struct mm_struct *mm,
> +		unsigned long ua, unsigned long size)
>  {
>  	struct mm_iommu_table_group_mem_t *mem, *ret =3D NULL;
> =20
> -	list_for_each_entry_rcu(mem,
> -			&current->mm->context.iommu_group_mem_list,
> -			next) {
> +	list_for_each_entry_rcu(mem, &mm->context.iommu_group_mem_list, next) {
>  		if ((mem->ua <=3D ua) &&
>  				(ua + size <=3D mem->ua +
>  				 (mem->entries << PAGE_SHIFT))) {
> @@ -324,14 +314,12 @@ struct mm_iommu_table_group_mem_t *mm_iommu_lookup(=
unsigned long ua,
>  }
>  EXPORT_SYMBOL_GPL(mm_iommu_lookup);
> =20
> -struct mm_iommu_table_group_mem_t *mm_iommu_find(unsigned long ua,
> -		unsigned long entries)
> +struct mm_iommu_table_group_mem_t *mm_iommu_find(struct mm_struct *mm,
> +		unsigned long ua, unsigned long entries)
>  {
>  	struct mm_iommu_table_group_mem_t *mem, *ret =3D NULL;
> =20
> -	list_for_each_entry_rcu(mem,
> -			&current->mm->context.iommu_group_mem_list,
> -			next) {
> +	list_for_each_entry_rcu(mem, &mm->context.iommu_group_mem_list, next) {
>  		if ((mem->ua =3D=3D ua) && (mem->entries =3D=3D entries)) {
>  			ret =3D mem;
>  			break;
> @@ -373,16 +361,17 @@ void mm_iommu_mapped_dec(struct mm_iommu_table_grou=
p_mem_t *mem)
>  }
>  EXPORT_SYMBOL_GPL(mm_iommu_mapped_dec);
> =20
> -void mm_iommu_init(mm_context_t *ctx)
> +void mm_iommu_init(struct mm_struct *mm)
>  {
> -	INIT_LIST_HEAD_RCU(&ctx->iommu_group_mem_list);
> +	INIT_LIST_HEAD_RCU(&mm->context.iommu_group_mem_list);
>  }
> =20
> -void mm_iommu_cleanup(mm_context_t *ctx)
> +void mm_iommu_cleanup(struct mm_struct *mm)
>  {
>  	struct mm_iommu_table_group_mem_t *mem, *tmp;
> =20
> -	list_for_each_entry_safe(mem, tmp, &ctx->iommu_group_mem_list, next) {
> +	list_for_each_entry_safe(mem, tmp, &mm->context.iommu_group_mem_list,
> +			next) {
>  		list_del_rcu(&mem->next);
>  		mm_iommu_do_free(mem);
>  	}
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iomm=
u_spapr_tce.c
> index 80378dd..3d2a65c 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -98,6 +98,7 @@ struct tce_container {
>  	bool enabled;
>  	bool v2;
>  	unsigned long locked_pages;
> +	struct mm_struct *mm;
>  	struct iommu_table *tables[IOMMU_TABLE_GROUP_MAX_TABLES];
>  	struct list_head group_list;
>  };
> @@ -110,11 +111,11 @@ static long tce_iommu_unregister_pages(struct tce_c=
ontainer *container,
>  	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK))
>  		return -EINVAL;
> =20
> -	mem =3D mm_iommu_find(vaddr, size >> PAGE_SHIFT);
> +	mem =3D mm_iommu_find(container->mm, vaddr, size >> PAGE_SHIFT);
>  	if (!mem)
>  		return -ENOENT;
> =20
> -	return mm_iommu_put(mem);
> +	return mm_iommu_put(container->mm, mem);
>  }
> =20
>  static long tce_iommu_register_pages(struct tce_container *container,
> @@ -128,7 +129,16 @@ static long tce_iommu_register_pages(struct tce_cont=
ainer *container,
>  			((vaddr + size) < vaddr))
>  		return -EINVAL;
> =20
> -	ret =3D mm_iommu_get(vaddr, entries, &mem);
> +	if (!container->mm) {
> +		if (!current->mm)
> +			return -ESRCH; /* process exited */

You're only verifying current->mm if container->mm is not set.  If
container->mm has been populated, then the process exits, previously
the mm_iommu_get() would have silently failed.  Now, you will register
pages against the stale mm.

I don't see anything obvious bad that would happen because of that,
but is it what you intended?

> +		atomic_inc(&current->mm->mm_count);
> +		BUG_ON(container->mm && (container->mm !=3D current->mm));

What prevents the container fd being passed to another process (via
fork() or a unix domain socket)?  Without that, this allows the user
to BUG() the system.

> +		container->mm =3D current->mm;
> +	}
> +
> +	ret =3D mm_iommu_get(container->mm, vaddr, entries, &mem);
>  	if (ret)
>  		return ret;
> =20
> @@ -354,6 +364,8 @@ static void tce_iommu_release(void *iommu_data)
>  		tce_iommu_free_table(tbl);
>  	}
> =20
> +	if (container->mm)
> +		mmdrop(container->mm);
>  	tce_iommu_disable(container);
>  	mutex_destroy(&container->lock);
> =20
> @@ -369,13 +381,14 @@ static void tce_iommu_unuse_page(struct tce_contain=
er *container,
>  	put_page(page);
>  }
> =20
> -static int tce_iommu_prereg_ua_to_hpa(unsigned long tce, unsigned long s=
ize,
> +static int tce_iommu_prereg_ua_to_hpa(struct tce_container *container,
> +		unsigned long tce, unsigned long size,
>  		unsigned long *phpa, struct mm_iommu_table_group_mem_t **pmem)
>  {
>  	long ret =3D 0;
>  	struct mm_iommu_table_group_mem_t *mem;
> =20
> -	mem =3D mm_iommu_lookup(tce, size);
> +	mem =3D mm_iommu_lookup(container->mm, tce, size);

Couldn't this be called before container->mm is populated if the user
does a MAP_DMA before any REGISTER_MEMORY calls?  That would calls a
NULL dereference in mm_iommu_lookup(), I think.

>  	if (!mem)
>  		return -EINVAL;
> =20
> @@ -388,18 +401,18 @@ static int tce_iommu_prereg_ua_to_hpa(unsigned long=
 tce, unsigned long size,
>  	return 0;
>  }
> =20
> -static void tce_iommu_unuse_page_v2(struct iommu_table *tbl,
> -		unsigned long entry)
> +static void tce_iommu_unuse_page_v2(struct tce_container *container,
> +		struct iommu_table *tbl, unsigned long entry)
>  {
>  	struct mm_iommu_table_group_mem_t *mem =3D NULL;
>  	int ret;
>  	unsigned long hpa =3D 0;
>  	unsigned long *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
> =20
> -	if (!pua || !current || !current->mm)
> +	if (!pua)
>  		return;
> =20
> -	ret =3D tce_iommu_prereg_ua_to_hpa(*pua, IOMMU_PAGE_SIZE(tbl),
> +	ret =3D tce_iommu_prereg_ua_to_hpa(container, *pua, IOMMU_PAGE_SIZE(tbl=
),
>  			&hpa, &mem);
>  	if (ret)
>  		pr_debug("%s: tce %lx at #%lx was not cached, ret=3D%d\n",
> @@ -429,7 +442,7 @@ static int tce_iommu_clear(struct tce_container *cont=
ainer,
>  			continue;
> =20
>  		if (container->v2) {
> -			tce_iommu_unuse_page_v2(tbl, entry);
> +			tce_iommu_unuse_page_v2(container, tbl, entry);
>  			continue;
>  		}
> =20
> @@ -514,8 +527,8 @@ static long tce_iommu_build_v2(struct tce_container *=
container,
>  		unsigned long *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl,
>  				entry + i);
> =20
> -		ret =3D tce_iommu_prereg_ua_to_hpa(tce, IOMMU_PAGE_SIZE(tbl),
> -				&hpa, &mem);
> +		ret =3D tce_iommu_prereg_ua_to_hpa(container,
> +				tce, IOMMU_PAGE_SIZE(tbl), &hpa, &mem);
>  		if (ret)
>  			break;
> =20
> @@ -536,7 +549,7 @@ static long tce_iommu_build_v2(struct tce_container *=
container,
>  		ret =3D iommu_tce_xchg(tbl, entry + i, &hpa, &dirtmp);
>  		if (ret) {
>  			/* dirtmp cannot be DMA_NONE here */
> -			tce_iommu_unuse_page_v2(tbl, entry + i);
> +			tce_iommu_unuse_page_v2(container, tbl, entry + i);
>  			pr_err("iommu_tce: %s failed ioba=3D%lx, tce=3D%lx, ret=3D%ld\n",
>  					__func__, entry << tbl->it_page_shift,
>  					tce, ret);
> @@ -544,7 +557,7 @@ static long tce_iommu_build_v2(struct tce_container *=
container,
>  		}
> =20
>  		if (dirtmp !=3D DMA_NONE)
> -			tce_iommu_unuse_page_v2(tbl, entry + i);
> +			tce_iommu_unuse_page_v2(container, tbl, entry + i);
> =20
>  		*pua =3D tce;
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--KjX7LgAomYr70Ka9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX/vB6AAoJEGw4ysog2bOSrzgQAI+0eA8qwVnWtJ0ImeqSH6tj
2Nh479eJlzUhCG9AcTxUckIoj+hmKx+zeg2S+b6/X6pO1/JtogenGLg5qSVtTJ7j
U3XFf45KPRYQGhrPSXe9fhuS9dLCDL31Tku6kZ3Zs5bfCNYJuT0fN6Uzwfjer7QC
WRmBZq5UjZrJ5alAO+jrqlA/c95XDRk3QZ4O3Jk7srFnQ6rrz/D33lzF8UHjn13R
/b1NlfIEDJi+oPflrS7l2VldljCyIrFDnAZtq6OxmfynilKVi2YbleZgZJ351pxL
EP7qTLyE4bNKHOEItQ+KmCg95nlkTypMNjMScrfNI//YGh9002f6clVO7EIuKMj1
ENW7pOSbtnVgoGZ2yLD2HFUf0+guP/OrmQqcr4iJFhwZsNZ/uZlsQbfDM22GKEqX
3ZaENpxx+7V2HJcBp9vK4RL/MzRkG3cwVjVKRsdci/V2zfaCbhAaQ4jatBjbyg4u
fH4u7HtacOYi7msIYYgl2EJoYmWj28mzkrryUqOSoSwtxgbFBxQW73PJ/P3AHo7n
2rtUsrkQLpXc2LOX4y/ej5RFAw0UYlelOKmgSkTAvuiOpeseXWa4GTiQK38/u9MR
pEhtC238kRnNE38oenmDjGab9IA0ybpaUi4ynm7djyHQWo7m5qwh38z/KcP5fBZF
oYzoMcJlARshkwELhcHY
=jyUu
-----END PGP SIGNATURE-----

--KjX7LgAomYr70Ka9--
