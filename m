Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9Xg748WQzDr5p
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 14:57:07 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id y134so872822pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 21:57:07 -0700 (PDT)
Subject: Re: [PATCH kernel 05/15] powerpc/iommu: Stop using @current in
 mm_iommu_xxx
To: David Gibson <david@gibson.dropbear.id.au>
References: <1470213656-1042-1-git-send-email-aik@ozlabs.ru>
 <1470213656-1042-6-git-send-email-aik@ozlabs.ru>
 <20160812025724.GH16493@voom.fritz.box>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <64b108a7-f950-c784-c078-538ffdee0cd5@ozlabs.ru>
Date: Fri, 12 Aug 2016 14:56:59 +1000
MIME-Version: 1.0
In-Reply-To: <20160812025724.GH16493@voom.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IFgqBaU2gEDn3RHu9grCGcwgEeD8sculV"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IFgqBaU2gEDn3RHu9grCGcwgEeD8sculV
Content-Type: multipart/mixed; boundary="a10BWS7Vu6gl88VkdUsFtdmKOFodtedCi"
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>
Message-ID: <64b108a7-f950-c784-c078-538ffdee0cd5@ozlabs.ru>
Subject: Re: [PATCH kernel 05/15] powerpc/iommu: Stop using @current in
 mm_iommu_xxx
References: <1470213656-1042-1-git-send-email-aik@ozlabs.ru>
 <1470213656-1042-6-git-send-email-aik@ozlabs.ru>
 <20160812025724.GH16493@voom.fritz.box>
In-Reply-To: <20160812025724.GH16493@voom.fritz.box>

--a10BWS7Vu6gl88VkdUsFtdmKOFodtedCi
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: quoted-printable

On 12/08/16 12:57, David Gibson wrote:
> On Wed, Aug 03, 2016 at 06:40:46PM +1000, Alexey Kardashevskiy wrote:
>> In some situations the userspace memory context may live longer than
>> the userspace process itself so if we need to do proper memory context=

>> cleanup, we better cache @mm and use it later when the process is gone=

>> (@current or @current->mm are NULL).
>>
>> This changes mm_iommu_xxx API to receive mm_struct instead of using on=
e
>> from @current.
>>
>> This is needed by the following patch to do proper cleanup in time.
>> This depends on "powerpc/powernv/ioda: Fix endianness when reading TCE=
s"
>> to do proper cleanup via tce_iommu_clear() patch.
>>
>> To keep API consistent, this replaces mm_context_t with mm_struct;
>> we stick to mm_struct as mm_iommu_adjust_locked_vm() helper needs
>> access to &mm->mmap_sem.
>>
>> This should cause no behavioral change.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>  arch/powerpc/include/asm/mmu_context.h | 20 +++++++------
>>  arch/powerpc/kernel/setup-common.c     |  2 +-
>>  arch/powerpc/mm/mmu_context_book3s64.c |  4 +--
>>  arch/powerpc/mm/mmu_context_iommu.c    | 54 ++++++++++++++-----------=
---------
>>  drivers/vfio/vfio_iommu_spapr_tce.c    | 41 ++++++++++++++++---------=
-
>>  5 files changed, 62 insertions(+), 59 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/inc=
lude/asm/mmu_context.h
>> index 9d2cd0c..b85cc7b 100644
>> --- a/arch/powerpc/include/asm/mmu_context.h
>> +++ b/arch/powerpc/include/asm/mmu_context.h
>> @@ -18,16 +18,18 @@ extern void destroy_context(struct mm_struct *mm);=

>>  #ifdef CONFIG_SPAPR_TCE_IOMMU
>>  struct mm_iommu_table_group_mem_t;
>> =20
>> -extern bool mm_iommu_preregistered(void);
>> -extern long mm_iommu_get(unsigned long ua, unsigned long entries,
>> +extern bool mm_iommu_preregistered(struct mm_struct *mm);
>> +extern long mm_iommu_get(struct mm_struct *mm,
>> +		unsigned long ua, unsigned long entries,
>>  		struct mm_iommu_table_group_mem_t **pmem);
>> -extern long mm_iommu_put(struct mm_iommu_table_group_mem_t *mem);
>> -extern void mm_iommu_init(mm_context_t *ctx);
>> -extern void mm_iommu_cleanup(mm_context_t *ctx);
>> -extern struct mm_iommu_table_group_mem_t *mm_iommu_lookup(unsigned lo=
ng ua,
>> -		unsigned long size);
>> -extern struct mm_iommu_table_group_mem_t *mm_iommu_find(unsigned long=
 ua,
>> -		unsigned long entries);
>> +extern long mm_iommu_put(struct mm_struct *mm,
>> +		struct mm_iommu_table_group_mem_t *mem);
>> +extern void mm_iommu_init(struct mm_struct *mm);
>> +extern void mm_iommu_cleanup(struct mm_struct *mm);
>> +extern struct mm_iommu_table_group_mem_t *mm_iommu_lookup(struct mm_s=
truct *mm,
>> +		unsigned long ua, unsigned long size);
>> +extern struct mm_iommu_table_group_mem_t *mm_iommu_find(struct mm_str=
uct *mm,
>> +		unsigned long ua, unsigned long entries);
>>  extern long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem=
,
>>  		unsigned long ua, unsigned long *hpa);
>>  extern long mm_iommu_mapped_inc(struct mm_iommu_table_group_mem_t *me=
m);
>> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/=
setup-common.c
>> index 714b4ba..e90b68a 100644
>> --- a/arch/powerpc/kernel/setup-common.c
>> +++ b/arch/powerpc/kernel/setup-common.c
>> @@ -905,7 +905,7 @@ void __init setup_arch(char **cmdline_p)
>>  	init_mm.context.pte_frag =3D NULL;
>>  #endif
>>  #ifdef CONFIG_SPAPR_TCE_IOMMU
>> -	mm_iommu_init(&init_mm.context);
>> +	mm_iommu_init(&init_mm);
>>  #endif
>>  	irqstack_early_init();
>>  	exc_lvl_early_init();
>> diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/=
mmu_context_book3s64.c
>> index b114f8b..ad82735 100644
>> --- a/arch/powerpc/mm/mmu_context_book3s64.c
>> +++ b/arch/powerpc/mm/mmu_context_book3s64.c
>> @@ -115,7 +115,7 @@ int init_new_context(struct task_struct *tsk, stru=
ct mm_struct *mm)
>>  	mm->context.pte_frag =3D NULL;
>>  #endif
>>  #ifdef CONFIG_SPAPR_TCE_IOMMU
>> -	mm_iommu_init(&mm->context);
>> +	mm_iommu_init(mm);
>>  #endif
>>  	return 0;
>>  }
>> @@ -160,7 +160,7 @@ static inline void destroy_pagetable_page(struct m=
m_struct *mm)
>>  void destroy_context(struct mm_struct *mm)
>>  {
>>  #ifdef CONFIG_SPAPR_TCE_IOMMU
>> -	mm_iommu_cleanup(&mm->context);
>> +	mm_iommu_cleanup(mm);
>>  #endif
>> =20
>>  #ifdef CONFIG_PPC_ICSWX
>> diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu=
_context_iommu.c
>> index da6a216..ee6685b 100644
>> --- a/arch/powerpc/mm/mmu_context_iommu.c
>> +++ b/arch/powerpc/mm/mmu_context_iommu.c
>> @@ -53,7 +53,7 @@ static long mm_iommu_adjust_locked_vm(struct mm_stru=
ct *mm,
>>  	}
>> =20
>>  	pr_debug("[%d] RLIMIT_MEMLOCK HASH64 %c%ld %ld/%ld\n",
>> -			current->pid,
>> +			current ? current->pid : 0,
>>  			incr ? '+' : '-',
>>  			npages << PAGE_SHIFT,
>>  			mm->locked_vm << PAGE_SHIFT,
>> @@ -63,28 +63,22 @@ static long mm_iommu_adjust_locked_vm(struct mm_st=
ruct *mm,
>>  	return ret;
>>  }
>> =20
>> -bool mm_iommu_preregistered(void)
>> +bool mm_iommu_preregistered(struct mm_struct *mm)
>>  {
>> -	if (!current || !current->mm)
>> -		return false;
>> -
>> -	return !list_empty(&current->mm->context.iommu_group_mem_list);
>> +	return !list_empty(&mm->context.iommu_group_mem_list);
>>  }
>>  EXPORT_SYMBOL_GPL(mm_iommu_preregistered);
>> =20
>> -long mm_iommu_get(unsigned long ua, unsigned long entries,
>> +long mm_iommu_get(struct mm_struct *mm, unsigned long ua, unsigned lo=
ng entries,
>>  		struct mm_iommu_table_group_mem_t **pmem)
>>  {
>>  	struct mm_iommu_table_group_mem_t *mem;
>>  	long i, j, ret =3D 0, locked_entries =3D 0;
>>  	struct page *page =3D NULL;
>> =20
>> -	if (!current || !current->mm)
>> -		return -ESRCH; /* process exited */
>> -
>>  	mutex_lock(&mem_list_mutex);
>> =20
>> -	list_for_each_entry_rcu(mem, &current->mm->context.iommu_group_mem_l=
ist,
>> +	list_for_each_entry_rcu(mem, &mm->context.iommu_group_mem_list,
>>  			next) {
>>  		if ((mem->ua =3D=3D ua) && (mem->entries =3D=3D entries)) {
>>  			++mem->used;
>> @@ -102,7 +96,7 @@ long mm_iommu_get(unsigned long ua, unsigned long e=
ntries,
>> =20
>>  	}
>> =20
>> -	ret =3D mm_iommu_adjust_locked_vm(current->mm, entries, true);
>> +	ret =3D mm_iommu_adjust_locked_vm(mm, entries, true);
>>  	if (ret)
>>  		goto unlock_exit;
>> =20
>> @@ -142,11 +136,11 @@ long mm_iommu_get(unsigned long ua, unsigned lon=
g entries,
>>  	mem->entries =3D entries;
>>  	*pmem =3D mem;
>> =20
>> -	list_add_rcu(&mem->next, &current->mm->context.iommu_group_mem_list)=
;
>> +	list_add_rcu(&mem->next, &mm->context.iommu_group_mem_list);
>> =20
>>  unlock_exit:
>>  	if (locked_entries && ret)
>> -		mm_iommu_adjust_locked_vm(current->mm, locked_entries, false);
>> +		mm_iommu_adjust_locked_vm(mm, locked_entries, false);
>> =20
>>  	mutex_unlock(&mem_list_mutex);
>> =20
>> @@ -191,16 +185,13 @@ static void mm_iommu_free(struct rcu_head *head)=

>>  static void mm_iommu_release(struct mm_iommu_table_group_mem_t *mem)
>>  {
>>  	list_del_rcu(&mem->next);
>> -	mm_iommu_adjust_locked_vm(current->mm, mem->entries, false);
>=20
> AFAICT, you've moved this call from _release() to _put().  Won't that c=
ause a
> behavioural change?


mm_iommu_put() calls mm_iommu_adjust_locked_vm() right after
m_iommu_release() so no, it does not look so.



>>  	call_rcu(&mem->rcu, mm_iommu_free);
>>  }
>> =20
>> -long mm_iommu_put(struct mm_iommu_table_group_mem_t *mem)
>> +long mm_iommu_put(struct mm_struct *mm, struct mm_iommu_table_group_m=
em_t *mem)
>>  {
>>  	long ret =3D 0;
>> =20
>> -	if (!current || !current->mm)
>> -		return -ESRCH; /* process exited */
>> =20
>>  	mutex_lock(&mem_list_mutex);
>> =20
>> @@ -224,6 +215,8 @@ long mm_iommu_put(struct mm_iommu_table_group_mem_=
t *mem)
>>  	/* @mapped became 0 so now mappings are disabled, release the region=
 */
>>  	mm_iommu_release(mem);
>> =20
>> +	mm_iommu_adjust_locked_vm(mm, mem->entries, false);
>> +
>>  unlock_exit:
>>  	mutex_unlock(&mem_list_mutex);
>> =20
>> @@ -231,14 +224,12 @@ unlock_exit:
>>  }
>>  EXPORT_SYMBOL_GPL(mm_iommu_put);
>> =20
>> -struct mm_iommu_table_group_mem_t *mm_iommu_lookup(unsigned long ua,
>> -		unsigned long size)
>> +struct mm_iommu_table_group_mem_t *mm_iommu_lookup(struct mm_struct *=
mm,
>> +		unsigned long ua, unsigned long size)
>>  {
>>  	struct mm_iommu_table_group_mem_t *mem, *ret =3D NULL;
>> =20
>> -	list_for_each_entry_rcu(mem,
>> -			&current->mm->context.iommu_group_mem_list,
>> -			next) {
>> +	list_for_each_entry_rcu(mem, &mm->context.iommu_group_mem_list, next=
) {
>>  		if ((mem->ua <=3D ua) &&
>>  				(ua + size <=3D mem->ua +
>>  				 (mem->entries << PAGE_SHIFT))) {
>> @@ -251,14 +242,12 @@ struct mm_iommu_table_group_mem_t *mm_iommu_look=
up(unsigned long ua,
>>  }
>>  EXPORT_SYMBOL_GPL(mm_iommu_lookup);
>> =20
>> -struct mm_iommu_table_group_mem_t *mm_iommu_find(unsigned long ua,
>> -		unsigned long entries)
>> +struct mm_iommu_table_group_mem_t *mm_iommu_find(struct mm_struct *mm=
,
>> +		unsigned long ua, unsigned long entries)
>>  {
>>  	struct mm_iommu_table_group_mem_t *mem, *ret =3D NULL;
>> =20
>> -	list_for_each_entry_rcu(mem,
>> -			&current->mm->context.iommu_group_mem_list,
>> -			next) {
>> +	list_for_each_entry_rcu(mem, &mm->context.iommu_group_mem_list, next=
) {
>>  		if ((mem->ua =3D=3D ua) && (mem->entries =3D=3D entries)) {
>>  			ret =3D mem;
>>  			break;
>> @@ -300,16 +289,17 @@ void mm_iommu_mapped_dec(struct mm_iommu_table_g=
roup_mem_t *mem)
>>  }
>>  EXPORT_SYMBOL_GPL(mm_iommu_mapped_dec);
>> =20
>> -void mm_iommu_init(mm_context_t *ctx)
>> +void mm_iommu_init(struct mm_struct *mm)
>>  {
>> -	INIT_LIST_HEAD_RCU(&ctx->iommu_group_mem_list);
>> +	INIT_LIST_HEAD_RCU(&mm->context.iommu_group_mem_list);
>>  }
>> =20
>> -void mm_iommu_cleanup(mm_context_t *ctx)
>> +void mm_iommu_cleanup(struct mm_struct *mm)
>>  {
>>  	struct mm_iommu_table_group_mem_t *mem, *tmp;
>> =20
>> -	list_for_each_entry_safe(mem, tmp, &ctx->iommu_group_mem_list, next)=
 {
>> +	list_for_each_entry_safe(mem, tmp, &mm->context.iommu_group_mem_list=
,
>> +			next) {
>>  		list_del_rcu(&mem->next);
>>  		mm_iommu_do_free(mem);
>>  	}
>> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_i=
ommu_spapr_tce.c
>> index 80378dd..9752e77 100644
>> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
>> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
>> @@ -98,6 +98,7 @@ struct tce_container {
>>  	bool enabled;
>>  	bool v2;
>>  	unsigned long locked_pages;
>> +	struct mm_struct *mm;
>>  	struct iommu_table *tables[IOMMU_TABLE_GROUP_MAX_TABLES];
>>  	struct list_head group_list;
>>  };
>> @@ -110,11 +111,11 @@ static long tce_iommu_unregister_pages(struct tc=
e_container *container,
>>  	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK))
>>  		return -EINVAL;
>> =20
>> -	mem =3D mm_iommu_find(vaddr, size >> PAGE_SHIFT);
>> +	mem =3D mm_iommu_find(container->mm, vaddr, size >> PAGE_SHIFT);
>>  	if (!mem)
>>  		return -ENOENT;
>> =20
>> -	return mm_iommu_put(mem);
>> +	return mm_iommu_put(container->mm, mem);
>>  }
>> =20
>>  static long tce_iommu_register_pages(struct tce_container *container,=

>> @@ -128,10 +129,17 @@ static long tce_iommu_register_pages(struct tce_=
container *container,
>>  			((vaddr + size) < vaddr))
>>  		return -EINVAL;
>> =20
>> -	r<et =3D mm_iommu_get(vaddr, entries, &mem);
>> +	if (!container->mm) {
>> +		if (!current->mm)
>> +			return -ESRCH; /* process exited */
>=20
> Can this ever happen?  Surely the ioctl() path shouldn't be called
> after the process mm has been cleaned up?  i.e. should this be a
> WARN_ON().

Not sure with SMP (one thread doing ioctl(), another - exiting QEMU) if i=
t
is not that impossible but it is quite hard to trigger this check.


>=20
>> +
>> +		atomic_inc(&current->mm->mm_count);
>=20
> What balances this atomic_inc()?  Is it the mmdrop() added to
> tce_iommu_release()?

Yes. Surprisingly there is no mmget(), there is mmget_not_zero() but it i=
s
for mm->mm_users.

>=20
>> +		container->mm =3D current->mm;
>> +	}
>=20
> Surely you need an error (or else a BUG_ON()) if current->mm !=3D
> container->mm !=3D NULL.  I believe VFIO already assumes the container
> is owned only by a single mm, but it looks like you should verify that =
here.

I am not sure I really want to enforce it, do I? Who knows what kind of a=

crazy person would create a container, pin pages and fork() that userspac=
e
tool which may not be QEMU but something custom using DPDK or something.

What harm can not having this BUG_ON() cause?


>=20
>> +
>> +	ret =3D mm_iommu_get(container->mm, vaddr, entries, &mem);
>>  	if (ret)
>>  		return ret;
>> -
>>  	container->enabled =3D true;
>> =20
>>  	return 0;
>> @@ -354,6 +362,8 @@ static void tce_iommu_release(void *iommu_data)
>>  		tce_iommu_free_table(tbl);
>>  	}
>> =20
>> +	if (container->mm)
>> +		mmdrop(container->mm);
>>  	tce_iommu_disable(container);
>>  	mutex_destroy(&container->lock);
>> =20
>> @@ -369,13 +379,14 @@ static void tce_iommu_unuse_page(struct tce_cont=
ainer *container,
>>  	put_page(page);
>>  }
>> =20
>> -static int tce_iommu_prereg_ua_to_hpa(unsigned long tce, unsigned lon=
g size,
>> +static int tce_iommu_prereg_ua_to_hpa(struct tce_container *container=
,
>> +		unsigned long tce, unsigned long size,
>>  		unsigned long *phpa, struct mm_iommu_table_group_mem_t **pmem)
>>  {
>>  	long ret =3D 0;
>>  	struct mm_iommu_table_group_mem_t *mem;
>> =20
>> -	mem =3D mm_iommu_lookup(tce, size);
>> +	mem =3D mm_iommu_lookup(container->mm, tce, size);
>>  	if (!mem)
>>  		return -EINVAL;
>> =20
>> @@ -388,18 +399,18 @@ static int tce_iommu_prereg_ua_to_hpa(unsigned l=
ong tce, unsigned long size,
>>  	return 0;
>>  }
>> =20
>> -static void tce_iommu_unuse_page_v2(struct iommu_table *tbl,
>> -		unsigned long entry)
>> +static void tce_iommu_unuse_page_v2(struct tce_container *container,
>> +		struct iommu_table *tbl, unsigned long entry)
>>  {
>>  	struct mm_iommu_table_group_mem_t *mem =3D NULL;
>>  	int ret;
>>  	unsigned long hpa =3D 0;
>>  	unsigned long *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
>> =20
>> -	if (!pua || !current || !current->mm)
>> +	if (!pua)
>>  		return;
>> =20
>> -	ret =3D tce_iommu_prereg_ua_to_hpa(*pua, IOMMU_PAGE_SIZE(tbl),
>> +	ret =3D tce_iommu_prereg_ua_to_hpa(container, *pua, IOMMU_PAGE_SIZE(=
tbl),
>>  			&hpa, &mem);
>>  	if (ret)
>>  		pr_debug("%s: tce %lx at #%lx was not cached, ret=3D%d\n",
>> @@ -429,7 +440,7 @@ static int tce_iommu_clear(struct tce_container *c=
ontainer,
>>  			continue;
>> =20
>>  		if (container->v2) {
>> -			tce_iommu_unuse_page_v2(tbl, entry);
>> +			tce_iommu_unuse_page_v2(container, tbl, entry);
>>  			continue;
>>  		}
>> =20
>> @@ -514,8 +525,8 @@ static long tce_iommu_build_v2(struct tce_containe=
r *container,
>>  		unsigned long *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl,
>>  				entry + i);
>> =20
>> -		ret =3D tce_iommu_prereg_ua_to_hpa(tce, IOMMU_PAGE_SIZE(tbl),
>> -				&hpa, &mem);
>> +		ret =3D tce_iommu_prereg_ua_to_hpa(container,
>> +				tce, IOMMU_PAGE_SIZE(tbl), &hpa, &mem);
>>  		if (ret)
>>  			break;
>> =20
>> @@ -536,7 +547,7 @@ static long tce_iommu_build_v2(struct tce_containe=
r *container,
>>  		ret =3D iommu_tce_xchg(tbl, entry + i, &hpa, &dirtmp);
>>  		if (ret) {
>>  			/* dirtmp cannot be DMA_NONE here */
>> -			tce_iommu_unuse_page_v2(tbl, entry + i);
>> +			tce_iommu_unuse_page_v2(container, tbl, entry + i);
>>  			pr_err("iommu_tce: %s failed ioba=3D%lx, tce=3D%lx, ret=3D%ld\n",
>>  					__func__, entry << tbl->it_page_shift,
>>  					tce, ret);
>> @@ -544,7 +555,7 @@ static long tce_iommu_build_v2(struct tce_containe=
r *container,
>>  		}
>> =20
>>  		if (dirtmp !=3D DMA_NONE)
>> -			tce_iommu_unuse_page_v2(tbl, entry + i);
>> +			tce_iommu_unuse_page_v2(container, tbl, entry + i);
>> =20
>>  		*pua =3D tce;
>> =20
>=20


--=20
Alexey


--a10BWS7Vu6gl88VkdUsFtdmKOFodtedCi--

--IFgqBaU2gEDn3RHu9grCGcwgEeD8sculV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXrVcbAAoJEIYTPdgrwSC550QP/1M4Cqr1djn7MTnTrYt5kjxt
P1Z8SW5Gvd5XUM6B/ITnjJHi6RoD53isNWVyfGquk0wBG9xlEqKchsveCoISv4kp
ekMGyrIswPKV5W9me16vSi58omnmlqTpfKfC7O21g8ubBm6yAzn6bEfOs3lgVWqw
xEvgYN8SYlZbw8a/jFZjZZ9CvkSvRk8Rv7xauMsfO8cXdeYJ+Ji3IcpFIhnUSh4g
AGpacombGrrmTqvdDPHTSGZKoVe6AmhOH4o7wwwGAzpDYgvaakkMhVhV/P4MJpYV
Fe9k8ae5HfyHt2T3z0PEpHBQBXwodYcgSn/mXTLqdFtgszbfjJlenkus+kgpmnDB
uVoh0pWF6ZT/qi/FpFJUUvSA/kZe2OmX7e7UIKJHRENTW8oHmzWP+mGg8EO9VKNY
oW7np0vd2x7WqSuxbp49mKSbD1nwgbDPPgTiYOyNrDAKSC5e4IvUy/OMWHuHcRXG
Q3tBL7lAeetOjmNfat9tyromRjHZ0LZAcWMHEAw0wmBU7WJ6bS0enhoGTtLr9hZV
Uscbs87zJjaJoD61Yscu8P40YsCtIzI5HUgxYb56ZL5zZXWg2QYzOP2QwhBkwa7j
AmB4lHj15836bQzNtvE0bC7oU61n04ieNdO0iSuhcc7X0qWhFLbwUkjgHgsicd7/
IHt11kukoBgcURcClcKE
=MG1X
-----END PGP SIGNATURE-----

--IFgqBaU2gEDn3RHu9grCGcwgEeD8sculV--
