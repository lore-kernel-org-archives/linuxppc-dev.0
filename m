Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sCYkq5tL4zDr0d
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Aug 2016 21:52:19 +1000 (AEST)
Date: Mon, 15 Aug 2016 20:58:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH kernel 05/15] powerpc/iommu: Stop using @current in
 mm_iommu_xxx
Message-ID: <20160815105815.GB27484@voom.fritz.box>
References: <1470213656-1042-1-git-send-email-aik@ozlabs.ru>
 <1470213656-1042-6-git-send-email-aik@ozlabs.ru>
 <20160812025724.GH16493@voom.fritz.box>
 <64b108a7-f950-c784-c078-538ffdee0cd5@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="vGgW1X5XWziG23Ko"
In-Reply-To: <64b108a7-f950-c784-c078-538ffdee0cd5@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 12, 2016 at 02:56:59PM +1000, Alexey Kardashevskiy wrote:
> On 12/08/16 12:57, David Gibson wrote:
> > On Wed, Aug 03, 2016 at 06:40:46PM +1000, Alexey Kardashevskiy wrote:
> >> In some situations the userspace memory context may live longer than
> >> the userspace process itself so if we need to do proper memory context
> >> cleanup, we better cache @mm and use it later when the process is gone
> >> (@current or @current->mm are NULL).
> >>
> >> This changes mm_iommu_xxx API to receive mm_struct instead of using one
> >> from @current.
> >>
> >> This is needed by the following patch to do proper cleanup in time.
> >> This depends on "powerpc/powernv/ioda: Fix endianness when reading TCE=
s"
> >> to do proper cleanup via tce_iommu_clear() patch.
> >>
> >> To keep API consistent, this replaces mm_context_t with mm_struct;
> >> we stick to mm_struct as mm_iommu_adjust_locked_vm() helper needs
> >> access to &mm->mmap_sem.
> >>
> >> This should cause no behavioral change.
> >>
> >> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >> ---
> >>  arch/powerpc/include/asm/mmu_context.h | 20 +++++++------
> >>  arch/powerpc/kernel/setup-common.c     |  2 +-
> >>  arch/powerpc/mm/mmu_context_book3s64.c |  4 +--
> >>  arch/powerpc/mm/mmu_context_iommu.c    | 54 ++++++++++++++-----------=
---------
> >>  drivers/vfio/vfio_iommu_spapr_tce.c    | 41 ++++++++++++++++----------
> >>  5 files changed, 62 insertions(+), 59 deletions(-)
> >>
> >> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/inc=
lude/asm/mmu_context.h
> >> index 9d2cd0c..b85cc7b 100644
> >> --- a/arch/powerpc/include/asm/mmu_context.h
> >> +++ b/arch/powerpc/include/asm/mmu_context.h
> >> @@ -18,16 +18,18 @@ extern void destroy_context(struct mm_struct *mm);
> >>  #ifdef CONFIG_SPAPR_TCE_IOMMU
> >>  struct mm_iommu_table_group_mem_t;
> >> =20
> >> -extern bool mm_iommu_preregistered(void);
> >> -extern long mm_iommu_get(unsigned long ua, unsigned long entries,
> >> +extern bool mm_iommu_preregistered(struct mm_struct *mm);
> >> +extern long mm_iommu_get(struct mm_struct *mm,
> >> +		unsigned long ua, unsigned long entries,
> >>  		struct mm_iommu_table_group_mem_t **pmem);
> >> -extern long mm_iommu_put(struct mm_iommu_table_group_mem_t *mem);
> >> -extern void mm_iommu_init(mm_context_t *ctx);
> >> -extern void mm_iommu_cleanup(mm_context_t *ctx);
> >> -extern struct mm_iommu_table_group_mem_t *mm_iommu_lookup(unsigned lo=
ng ua,
> >> -		unsigned long size);
> >> -extern struct mm_iommu_table_group_mem_t *mm_iommu_find(unsigned long=
 ua,
> >> -		unsigned long entries);
> >> +extern long mm_iommu_put(struct mm_struct *mm,
> >> +		struct mm_iommu_table_group_mem_t *mem);
> >> +extern void mm_iommu_init(struct mm_struct *mm);
> >> +extern void mm_iommu_cleanup(struct mm_struct *mm);
> >> +extern struct mm_iommu_table_group_mem_t *mm_iommu_lookup(struct mm_s=
truct *mm,
> >> +		unsigned long ua, unsigned long size);
> >> +extern struct mm_iommu_table_group_mem_t *mm_iommu_find(struct mm_str=
uct *mm,
> >> +		unsigned long ua, unsigned long entries);
> >>  extern long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem,
> >>  		unsigned long ua, unsigned long *hpa);
> >>  extern long mm_iommu_mapped_inc(struct mm_iommu_table_group_mem_t *me=
m);
> >> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/=
setup-common.c
> >> index 714b4ba..e90b68a 100644
> >> --- a/arch/powerpc/kernel/setup-common.c
> >> +++ b/arch/powerpc/kernel/setup-common.c
> >> @@ -905,7 +905,7 @@ void __init setup_arch(char **cmdline_p)
> >>  	init_mm.context.pte_frag =3D NULL;
> >>  #endif
> >>  #ifdef CONFIG_SPAPR_TCE_IOMMU
> >> -	mm_iommu_init(&init_mm.context);
> >> +	mm_iommu_init(&init_mm);
> >>  #endif
> >>  	irqstack_early_init();
> >>  	exc_lvl_early_init();
> >> diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/=
mmu_context_book3s64.c
> >> index b114f8b..ad82735 100644
> >> --- a/arch/powerpc/mm/mmu_context_book3s64.c
> >> +++ b/arch/powerpc/mm/mmu_context_book3s64.c
> >> @@ -115,7 +115,7 @@ int init_new_context(struct task_struct *tsk, stru=
ct mm_struct *mm)
> >>  	mm->context.pte_frag =3D NULL;
> >>  #endif
> >>  #ifdef CONFIG_SPAPR_TCE_IOMMU
> >> -	mm_iommu_init(&mm->context);
> >> +	mm_iommu_init(mm);
> >>  #endif
> >>  	return 0;
> >>  }
> >> @@ -160,7 +160,7 @@ static inline void destroy_pagetable_page(struct m=
m_struct *mm)
> >>  void destroy_context(struct mm_struct *mm)
> >>  {
> >>  #ifdef CONFIG_SPAPR_TCE_IOMMU
> >> -	mm_iommu_cleanup(&mm->context);
> >> +	mm_iommu_cleanup(mm);
> >>  #endif
> >> =20
> >>  #ifdef CONFIG_PPC_ICSWX
> >> diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu=
_context_iommu.c
> >> index da6a216..ee6685b 100644
> >> --- a/arch/powerpc/mm/mmu_context_iommu.c
> >> +++ b/arch/powerpc/mm/mmu_context_iommu.c
> >> @@ -53,7 +53,7 @@ static long mm_iommu_adjust_locked_vm(struct mm_stru=
ct *mm,
> >>  	}
> >> =20
> >>  	pr_debug("[%d] RLIMIT_MEMLOCK HASH64 %c%ld %ld/%ld\n",
> >> -			current->pid,
> >> +			current ? current->pid : 0,
> >>  			incr ? '+' : '-',
> >>  			npages << PAGE_SHIFT,
> >>  			mm->locked_vm << PAGE_SHIFT,
> >> @@ -63,28 +63,22 @@ static long mm_iommu_adjust_locked_vm(struct mm_st=
ruct *mm,
> >>  	return ret;
> >>  }
> >> =20
> >> -bool mm_iommu_preregistered(void)
> >> +bool mm_iommu_preregistered(struct mm_struct *mm)
> >>  {
> >> -	if (!current || !current->mm)
> >> -		return false;
> >> -
> >> -	return !list_empty(&current->mm->context.iommu_group_mem_list);
> >> +	return !list_empty(&mm->context.iommu_group_mem_list);
> >>  }
> >>  EXPORT_SYMBOL_GPL(mm_iommu_preregistered);
> >> =20
> >> -long mm_iommu_get(unsigned long ua, unsigned long entries,
> >> +long mm_iommu_get(struct mm_struct *mm, unsigned long ua, unsigned lo=
ng entries,
> >>  		struct mm_iommu_table_group_mem_t **pmem)
> >>  {
> >>  	struct mm_iommu_table_group_mem_t *mem;
> >>  	long i, j, ret =3D 0, locked_entries =3D 0;
> >>  	struct page *page =3D NULL;
> >> =20
> >> -	if (!current || !current->mm)
> >> -		return -ESRCH; /* process exited */
> >> -
> >>  	mutex_lock(&mem_list_mutex);
> >> =20
> >> -	list_for_each_entry_rcu(mem, &current->mm->context.iommu_group_mem_l=
ist,
> >> +	list_for_each_entry_rcu(mem, &mm->context.iommu_group_mem_list,
> >>  			next) {
> >>  		if ((mem->ua =3D=3D ua) && (mem->entries =3D=3D entries)) {
> >>  			++mem->used;
> >> @@ -102,7 +96,7 @@ long mm_iommu_get(unsigned long ua, unsigned long e=
ntries,
> >> =20
> >>  	}
> >> =20
> >> -	ret =3D mm_iommu_adjust_locked_vm(current->mm, entries, true);
> >> +	ret =3D mm_iommu_adjust_locked_vm(mm, entries, true);
> >>  	if (ret)
> >>  		goto unlock_exit;
> >> =20
> >> @@ -142,11 +136,11 @@ long mm_iommu_get(unsigned long ua, unsigned lon=
g entries,
> >>  	mem->entries =3D entries;
> >>  	*pmem =3D mem;
> >> =20
> >> -	list_add_rcu(&mem->next, &current->mm->context.iommu_group_mem_list);
> >> +	list_add_rcu(&mem->next, &mm->context.iommu_group_mem_list);
> >> =20
> >>  unlock_exit:
> >>  	if (locked_entries && ret)
> >> -		mm_iommu_adjust_locked_vm(current->mm, locked_entries, false);
> >> +		mm_iommu_adjust_locked_vm(mm, locked_entries, false);
> >> =20
> >>  	mutex_unlock(&mem_list_mutex);
> >> =20
> >> @@ -191,16 +185,13 @@ static void mm_iommu_free(struct rcu_head *head)
> >>  static void mm_iommu_release(struct mm_iommu_table_group_mem_t *mem)
> >>  {
> >>  	list_del_rcu(&mem->next);
> >> -	mm_iommu_adjust_locked_vm(current->mm, mem->entries, false);
> >=20
> > AFAICT, you've moved this call from _release() to _put().  Won't that c=
ause a
> > behavioural change?
>=20
>=20
> mm_iommu_put() calls mm_iommu_adjust_locked_vm() right after
> m_iommu_release() so no, it does not look so.

Ah, I guess not.  It seems a bit arbitrary in the context of the rest
of the changes, though.

> >>  	call_rcu(&mem->rcu, mm_iommu_free);
> >>  }
> >> =20
> >> -long mm_iommu_put(struct mm_iommu_table_group_mem_t *mem)
> >> +long mm_iommu_put(struct mm_struct *mm, struct mm_iommu_table_group_m=
em_t *mem)
> >>  {
> >>  	long ret =3D 0;
> >> =20
> >> -	if (!current || !current->mm)
> >> -		return -ESRCH; /* process exited */
> >> =20
> >>  	mutex_lock(&mem_list_mutex);
> >> =20
> >> @@ -224,6 +215,8 @@ long mm_iommu_put(struct mm_iommu_table_group_mem_=
t *mem)
> >>  	/* @mapped became 0 so now mappings are disabled, release the region=
 */
> >>  	mm_iommu_release(mem);
> >> =20
> >> +	mm_iommu_adjust_locked_vm(mm, mem->entries, false);
> >> +
> >>  unlock_exit:
> >>  	mutex_unlock(&mem_list_mutex);
> >> =20
> >> @@ -231,14 +224,12 @@ unlock_exit:
> >>  }
> >>  EXPORT_SYMBOL_GPL(mm_iommu_put);
> >> =20
> >> -struct mm_iommu_table_group_mem_t *mm_iommu_lookup(unsigned long ua,
> >> -		unsigned long size)
> >> +struct mm_iommu_table_group_mem_t *mm_iommu_lookup(struct mm_struct *=
mm,
> >> +		unsigned long ua, unsigned long size)
> >>  {
> >>  	struct mm_iommu_table_group_mem_t *mem, *ret =3D NULL;
> >> =20
> >> -	list_for_each_entry_rcu(mem,
> >> -			&current->mm->context.iommu_group_mem_list,
> >> -			next) {
> >> +	list_for_each_entry_rcu(mem, &mm->context.iommu_group_mem_list, next=
) {
> >>  		if ((mem->ua <=3D ua) &&
> >>  				(ua + size <=3D mem->ua +
> >>  				 (mem->entries << PAGE_SHIFT))) {
> >> @@ -251,14 +242,12 @@ struct mm_iommu_table_group_mem_t *mm_iommu_look=
up(unsigned long ua,
> >>  }
> >>  EXPORT_SYMBOL_GPL(mm_iommu_lookup);
> >> =20
> >> -struct mm_iommu_table_group_mem_t *mm_iommu_find(unsigned long ua,
> >> -		unsigned long entries)
> >> +struct mm_iommu_table_group_mem_t *mm_iommu_find(struct mm_struct *mm,
> >> +		unsigned long ua, unsigned long entries)
> >>  {
> >>  	struct mm_iommu_table_group_mem_t *mem, *ret =3D NULL;
> >> =20
> >> -	list_for_each_entry_rcu(mem,
> >> -			&current->mm->context.iommu_group_mem_list,
> >> -			next) {
> >> +	list_for_each_entry_rcu(mem, &mm->context.iommu_group_mem_list, next=
) {
> >>  		if ((mem->ua =3D=3D ua) && (mem->entries =3D=3D entries)) {
> >>  			ret =3D mem;
> >>  			break;
> >> @@ -300,16 +289,17 @@ void mm_iommu_mapped_dec(struct mm_iommu_table_g=
roup_mem_t *mem)
> >>  }
> >>  EXPORT_SYMBOL_GPL(mm_iommu_mapped_dec);
> >> =20
> >> -void mm_iommu_init(mm_context_t *ctx)
> >> +void mm_iommu_init(struct mm_struct *mm)
> >>  {
> >> -	INIT_LIST_HEAD_RCU(&ctx->iommu_group_mem_list);
> >> +	INIT_LIST_HEAD_RCU(&mm->context.iommu_group_mem_list);
> >>  }
> >> =20
> >> -void mm_iommu_cleanup(mm_context_t *ctx)
> >> +void mm_iommu_cleanup(struct mm_struct *mm)
> >>  {
> >>  	struct mm_iommu_table_group_mem_t *mem, *tmp;
> >> =20
> >> -	list_for_each_entry_safe(mem, tmp, &ctx->iommu_group_mem_list, next)=
 {
> >> +	list_for_each_entry_safe(mem, tmp, &mm->context.iommu_group_mem_list,
> >> +			next) {
> >>  		list_del_rcu(&mem->next);
> >>  		mm_iommu_do_free(mem);
> >>  	}
> >> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_i=
ommu_spapr_tce.c
> >> index 80378dd..9752e77 100644
> >> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> >> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> >> @@ -98,6 +98,7 @@ struct tce_container {
> >>  	bool enabled;
> >>  	bool v2;
> >>  	unsigned long locked_pages;
> >> +	struct mm_struct *mm;
> >>  	struct iommu_table *tables[IOMMU_TABLE_GROUP_MAX_TABLES];
> >>  	struct list_head group_list;
> >>  };
> >> @@ -110,11 +111,11 @@ static long tce_iommu_unregister_pages(struct tc=
e_container *container,
> >>  	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK))
> >>  		return -EINVAL;
> >> =20
> >> -	mem =3D mm_iommu_find(vaddr, size >> PAGE_SHIFT);
> >> +	mem =3D mm_iommu_find(container->mm, vaddr, size >> PAGE_SHIFT);
> >>  	if (!mem)
> >>  		return -ENOENT;
> >> =20
> >> -	return mm_iommu_put(mem);
> >> +	return mm_iommu_put(container->mm, mem);
> >>  }
> >> =20
> >>  static long tce_iommu_register_pages(struct tce_container *container,
> >> @@ -128,10 +129,17 @@ static long tce_iommu_register_pages(struct tce_=
container *container,
> >>  			((vaddr + size) < vaddr))
> >>  		return -EINVAL;
> >> =20
> >> -	r<et =3D mm_iommu_get(vaddr, entries, &mem);
> >> +	if (!container->mm) {
> >> +		if (!current->mm)
> >> +			return -ESRCH; /* process exited */
> >=20
> > Can this ever happen?  Surely the ioctl() path shouldn't be called
> > after the process mm has been cleaned up?  i.e. should this be a
> > WARN_ON().
>=20
> Not sure with SMP (one thread doing ioctl(), another - exiting QEMU) if it
> is not that impossible but it is quite hard to trigger this check.

I'm pretty sure the mm can't be cleaned up until all threads have
definitely stopped executing.

> >> +
> >> +		atomic_inc(&current->mm->mm_count);
> >=20
> > What balances this atomic_inc()?  Is it the mmdrop() added to
> > tce_iommu_release()?
>=20
> Yes. Surprisingly there is no mmget(), there is mmget_not_zero() but it is
> for mm->mm_users.

Ok.

> >=20
> >> +		container->mm =3D current->mm;
> >> +	}
> >=20
> > Surely you need an error (or else a BUG_ON()) if current->mm !=3D
> > container->mm !=3D NULL.  I believe VFIO already assumes the container
> > is owned only by a single mm, but it looks like you should verify that =
here.
>=20
> I am not sure I really want to enforce it, do I? Who knows what kind of a
> crazy person would create a container, pin pages and fork() that userspace
> tool which may not be QEMU but something custom using DPDK or something.
>=20
> What harm can not having this BUG_ON() cause?

Hrm.  Well, if nothing else it lets one process lock (or unlock) pages
in an essentially unrelated process, which is pretty weird.  I don't
see any obvious way it will cause more serious problems.  But, as a
general rule it makes debugging easier if you check / enforce required
assumptions at the earliest possible point.

> >=20
> >> +
> >> +	ret =3D mm_iommu_get(container->mm, vaddr, entries, &mem);
> >>  	if (ret)
> >>  		return ret;
> >> -
> >>  	container->enabled =3D true;
> >> =20
> >>  	return 0;
> >> @@ -354,6 +362,8 @@ static void tce_iommu_release(void *iommu_data)
> >>  		tce_iommu_free_table(tbl);
> >>  	}
> >> =20
> >> +	if (container->mm)
> >> +		mmdrop(container->mm);
> >>  	tce_iommu_disable(container);
> >>  	mutex_destroy(&container->lock);
> >> =20
> >> @@ -369,13 +379,14 @@ static void tce_iommu_unuse_page(struct tce_cont=
ainer *container,
> >>  	put_page(page);
> >>  }
> >> =20
> >> -static int tce_iommu_prereg_ua_to_hpa(unsigned long tce, unsigned lon=
g size,
> >> +static int tce_iommu_prereg_ua_to_hpa(struct tce_container *container,
> >> +		unsigned long tce, unsigned long size,
> >>  		unsigned long *phpa, struct mm_iommu_table_group_mem_t **pmem)
> >>  {
> >>  	long ret =3D 0;
> >>  	struct mm_iommu_table_group_mem_t *mem;
> >> =20
> >> -	mem =3D mm_iommu_lookup(tce, size);
> >> +	mem =3D mm_iommu_lookup(container->mm, tce, size);
> >>  	if (!mem)
> >>  		return -EINVAL;
> >> =20
> >> @@ -388,18 +399,18 @@ static int tce_iommu_prereg_ua_to_hpa(unsigned l=
ong tce, unsigned long size,
> >>  	return 0;
> >>  }
> >> =20
> >> -static void tce_iommu_unuse_page_v2(struct iommu_table *tbl,
> >> -		unsigned long entry)
> >> +static void tce_iommu_unuse_page_v2(struct tce_container *container,
> >> +		struct iommu_table *tbl, unsigned long entry)
> >>  {
> >>  	struct mm_iommu_table_group_mem_t *mem =3D NULL;
> >>  	int ret;
> >>  	unsigned long hpa =3D 0;
> >>  	unsigned long *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
> >> =20
> >> -	if (!pua || !current || !current->mm)
> >> +	if (!pua)
> >>  		return;
> >> =20
> >> -	ret =3D tce_iommu_prereg_ua_to_hpa(*pua, IOMMU_PAGE_SIZE(tbl),
> >> +	ret =3D tce_iommu_prereg_ua_to_hpa(container, *pua, IOMMU_PAGE_SIZE(=
tbl),
> >>  			&hpa, &mem);
> >>  	if (ret)
> >>  		pr_debug("%s: tce %lx at #%lx was not cached, ret=3D%d\n",
> >> @@ -429,7 +440,7 @@ static int tce_iommu_clear(struct tce_container *c=
ontainer,
> >>  			continue;
> >> =20
> >>  		if (container->v2) {
> >> -			tce_iommu_unuse_page_v2(tbl, entry);
> >> +			tce_iommu_unuse_page_v2(container, tbl, entry);
> >>  			continue;
> >>  		}
> >> =20
> >> @@ -514,8 +525,8 @@ static long tce_iommu_build_v2(struct tce_containe=
r *container,
> >>  		unsigned long *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl,
> >>  				entry + i);
> >> =20
> >> -		ret =3D tce_iommu_prereg_ua_to_hpa(tce, IOMMU_PAGE_SIZE(tbl),
> >> -				&hpa, &mem);
> >> +		ret =3D tce_iommu_prereg_ua_to_hpa(container,
> >> +				tce, IOMMU_PAGE_SIZE(tbl), &hpa, &mem);
> >>  		if (ret)
> >>  			break;
> >> =20
> >> @@ -536,7 +547,7 @@ static long tce_iommu_build_v2(struct tce_containe=
r *container,
> >>  		ret =3D iommu_tce_xchg(tbl, entry + i, &hpa, &dirtmp);
> >>  		if (ret) {
> >>  			/* dirtmp cannot be DMA_NONE here */
> >> -			tce_iommu_unuse_page_v2(tbl, entry + i);
> >> +			tce_iommu_unuse_page_v2(container, tbl, entry + i);
> >>  			pr_err("iommu_tce: %s failed ioba=3D%lx, tce=3D%lx, ret=3D%ld\n",
> >>  					__func__, entry << tbl->it_page_shift,
> >>  					tce, ret);
> >> @@ -544,7 +555,7 @@ static long tce_iommu_build_v2(struct tce_containe=
r *container,
> >>  		}
> >> =20
> >>  		if (dirtmp !=3D DMA_NONE)
> >> -			tce_iommu_unuse_page_v2(tbl, entry + i);
> >> +			tce_iommu_unuse_page_v2(container, tbl, entry + i);
> >> =20
> >>  		*pua =3D tce;
> >> =20
> >=20
>=20
>=20




--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vGgW1X5XWziG23Ko
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXsaBGAAoJEGw4ysog2bOSPnAP/iMD5M1VUzpbLDV4w2w9Jibl
wYcEPeDQz1qu7fg0grxR1pz1okmmZb9eqrSxLIbrik86xcq2by+u0ic0sVI4FiKh
qhNuzZ+AP24CBUY98yS4dvR1XB7LHbuc0bbXgmSqLDM25Hq1YFpOoD3KGxexJrmF
cZvKBU1TArmTDUBUuZ4GOFNvasxeL+ozRToqcXn8XtO6NtXGtY/eLeAbFBOeMSd6
C3PXWb0Os8OpYewtYlra8MZ62/DibNZ6kJm6SKywrDjgdzHePbOsYFEylGUdvSm2
q8QKXZ9d9rnjl2tKEIrP6a1g/5w5vq65j+u0jgLUI99WkgvUY/qzSyWKTVhn+Vl3
w40SlBj5L7fLzMjD4/G7HA5pwUyCcBMavMdAT3chjrqibWiS824/iGbarJDnFNfD
fs2vJvxzpcTkFImx3PaNU69eec9hZUiQLqyJtGXcd/dckKPt/I7B9XodOLMbigPt
RtAopr3Zva8ctj2fZ8SEyosLcdWsgUWZZODYW+OJQy3+IVcEGgUshV8gG2OMGcsa
DhXmHucE0EvKeZR1VektmXs1pFpyJf7I3kouQoi+9Uze1wIu2PAu8ah8l0z0TbJf
j0ws4LfLGXPDelslSLvvd+lo8seLJeuYniLOUejGAUBa+P8x8N81l2/SWBIcnWbg
QRSpEaV7lP417LuawnXH
=ngQl
-----END PGP SIGNATURE-----

--vGgW1X5XWziG23Ko--
