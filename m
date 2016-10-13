Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3svg7D2YK1zDsyG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 17:00:08 +1100 (AEDT)
Received: by mail-pa0-x242.google.com with SMTP id os4so229924pac.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Oct 2016 23:00:08 -0700 (PDT)
Subject: Re: [PATCH kernel v2 1/2] powerpc/iommu: Stop using @current in
 mm_iommu_xxx
To: David Gibson <david@gibson.dropbear.id.au>
References: <1476248308-41754-1-git-send-email-aik@ozlabs.ru>
 <1476248308-41754-2-git-send-email-aik@ozlabs.ru>
 <20161013022501.GJ18039@umbus.fritz.box>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <50c19483-d4ff-86fd-bbd2-cf635dee493b@ozlabs.ru>
Date: Thu, 13 Oct 2016 17:00:01 +1100
MIME-Version: 1.0
In-Reply-To: <20161013022501.GJ18039@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="QD8Rkd4J928TmlICcDgR9ga5MBMhk2xMF"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QD8Rkd4J928TmlICcDgR9ga5MBMhk2xMF
Content-Type: multipart/mixed; boundary="w6uJn5XwdfMkp99TTxPalx9gbXi8Rok4j";
 protected-headers="v1"
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>
Message-ID: <50c19483-d4ff-86fd-bbd2-cf635dee493b@ozlabs.ru>
Subject: Re: [PATCH kernel v2 1/2] powerpc/iommu: Stop using @current in
 mm_iommu_xxx
References: <1476248308-41754-1-git-send-email-aik@ozlabs.ru>
 <1476248308-41754-2-git-send-email-aik@ozlabs.ru>
 <20161013022501.GJ18039@umbus.fritz.box>
In-Reply-To: <20161013022501.GJ18039@umbus.fritz.box>

--w6uJn5XwdfMkp99TTxPalx9gbXi8Rok4j
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: quoted-printable

On 13/10/16 13:25, David Gibson wrote:
> On Wed, Oct 12, 2016 at 03:58:27PM +1100, Alexey Kardashevskiy wrote:
>> In some situations the userspace memory context may live longer than
>> the userspace process itself so if we need to do proper memory context=

>> cleanup, we better cache @mm and use it later when the process is gone=

>> (@current or @current->mm are NULL).
>>
>> This changes mm_iommu_xxx API to receive mm_struct instead of using on=
e
>> from @current.
>>
>> This references and caches MM once per container so we do not depend
>> on @current pointing to a valid task descriptor anymore.
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
>> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
>> Acked-by: Balbir Singh <bsingharora@gmail.com>
>> ---
>> Changes:
>> v2:
>> * added BUG_ON(container->mm && (container->mm !=3D current->mm)) in
>> tce_iommu_register_pages()
>> * added note about containers referencing MM
>> ---
>>  arch/powerpc/include/asm/mmu_context.h | 20 +++++++------
>>  arch/powerpc/kernel/setup-common.c     |  2 +-
>>  arch/powerpc/mm/mmu_context_book3s64.c |  4 +--
>>  arch/powerpc/mm/mmu_context_iommu.c    | 55 ++++++++++++++-----------=
---------
>>  drivers/vfio/vfio_iommu_spapr_tce.c    | 41 ++++++++++++++++---------=

>>  5 files changed, 63 insertions(+), 59 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/inc=
lude/asm/mmu_context.h
>> index 5c45114..b9e3f0a 100644
>> --- a/arch/powerpc/include/asm/mmu_context.h
>> +++ b/arch/powerpc/include/asm/mmu_context.h
>> @@ -19,16 +19,18 @@ extern void destroy_context(struct mm_struct *mm);=

>>  struct mm_iommu_table_group_mem_t;
>> =20
>>  extern int isolate_lru_page(struct page *page);	/* from internal.h */=

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
>> index dba265c..942cf49 100644
>> --- a/arch/powerpc/kernel/setup-common.c
>> +++ b/arch/powerpc/kernel/setup-common.c
>> @@ -906,7 +906,7 @@ void __init setup_arch(char **cmdline_p)
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
>> index e0f1c33..4c6db09 100644
>> --- a/arch/powerpc/mm/mmu_context_iommu.c
>> +++ b/arch/powerpc/mm/mmu_context_iommu.c
>> @@ -56,7 +56,7 @@ static long mm_iommu_adjust_locked_vm(struct mm_stru=
ct *mm,
>>  	}
>> =20
>>  	pr_debug("[%d] RLIMIT_MEMLOCK HASH64 %c%ld %ld/%ld\n",
>> -			current->pid,
>> +			current ? current->pid : 0,
>>  			incr ? '+' : '-',
>>  			npages << PAGE_SHIFT,
>>  			mm->locked_vm << PAGE_SHIFT,
>> @@ -66,12 +66,9 @@ static long mm_iommu_adjust_locked_vm(struct mm_str=
uct *mm,
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
>> @@ -124,19 +121,16 @@ static int mm_iommu_move_page_from_cma(struct pa=
ge *page)
>>  	return 0;
>>  }
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
>> @@ -154,7 +148,7 @@ long mm_iommu_get(unsigned long ua, unsigned long =
entries,
>> =20
>>  	}
>> =20
>> -	ret =3D mm_iommu_adjust_locked_vm(current->mm, entries, true);
>> +	ret =3D mm_iommu_adjust_locked_vm(mm, entries, true);
>>  	if (ret)
>>  		goto unlock_exit;
>> =20
>> @@ -215,11 +209,11 @@ long mm_iommu_get(unsigned long ua, unsigned lon=
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
>> @@ -264,17 +258,13 @@ static void mm_iommu_free(struct rcu_head *head)=

>>  static void mm_iommu_release(struct mm_iommu_table_group_mem_t *mem)
>>  {
>>  	list_del_rcu(&mem->next);
>> -	mm_iommu_adjust_locked_vm(current->mm, mem->entries, false);
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
>> -
>>  	mutex_lock(&mem_list_mutex);
>> =20
>>  	if (mem->used =3D=3D 0) {
>> @@ -297,6 +287,8 @@ long mm_iommu_put(struct mm_iommu_table_group_mem_=
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
>> @@ -304,14 +296,12 @@ long mm_iommu_put(struct mm_iommu_table_group_me=
m_t *mem)
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
>> @@ -324,14 +314,12 @@ struct mm_iommu_table_group_mem_t *mm_iommu_look=
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
>> @@ -373,16 +361,17 @@ void mm_iommu_mapped_dec(struct mm_iommu_table_g=
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
>> index 80378dd..3d2a65c 100644
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

>> @@ -128,7 +129,16 @@ static long tce_iommu_register_pages(struct tce_c=
ontainer *container,
>>  			((vaddr + size) < vaddr))
>>  		return -EINVAL;
>> =20
>> -	ret =3D mm_iommu_get(vaddr, entries, &mem);
>> +	if (!container->mm) {
>> +		if (!current->mm)
>> +			return -ESRCH; /* process exited */
>=20
> You're only verifying current->mm if container->mm is not set.  If
> container->mm has been populated, then the process exits, previously
> the mm_iommu_get() would have silently failed.  Now, you will register
> pages against the stale mm.
>=20
> I don't see anything obvious bad that would happen because of that,
> but is it what you intended?

Yes, I want to keep things simple unless they can hurt.


>> +		atomic_inc(&current->mm->mm_count);
>> +		BUG_ON(container->mm && (container->mm !=3D current->mm));
>=20
> What prevents the container fd being passed to another process (via
> fork() or a unix domain socket)?  Without that, this allows the user
> to BUG() the system.


This exact BUG_ON is wrong actually - "if (!container->mm)" means that
BUG_ON will not ever happen.

So. I need a piece of advise what check would make sense here. I'd just
remove BUG_ON and that's it...


--=20
Alexey


--w6uJn5XwdfMkp99TTxPalx9gbXi8Rok4j--

--QD8Rkd4J928TmlICcDgR9ga5MBMhk2xMF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX/yLhAAoJEIYTPdgrwSC5PicQALy1uXLsd59mi8QgqYNa66xY
0j97KywwkMwPfbJuaGhgegTSBkggbSvNWWc2kyjFaIThFDKBeKhnwaAooDJuoGXZ
bS0BhvCx19WzLx0USqnM1qsa5pGmADPHv1lc/0Qf9JxhXvl8w6q0kZa9e/Fc0R/b
Pc+w9UtbIDqb3F913T5PJGiGrCa6iKz6GSNqXaN4IPE3Mv+oU7tHQs0nptJikZyV
a1X153MbJQw3x7l+kD/a7Aba44mtwXwjE13AruuUcv3yHdXDd90pCRSfAkNmS4P7
UmHekFO9Npk+Yad7NRlgND5d7LZsOSXCZttzTzGT/Qcz8hoJWogeV4nzLEGuqdH2
lok6XYq8mRswGptiZ6LGOlCCnsdzIhvdgWcwbgqmUp+BWCUavCIEbem4LFdOxf1Y
sqrLnVTM3C8yv2GFYuOgnRPM+zjOvsWKbZGBO+FWs4z/IlrVWeiwy9D2ls2MN9LW
96z7KZEgivVoXsPhAjWsllTp0yRHI6Qzv1cFuJ32JbLITAbTGTMU5Lpk6qDhQM62
9NH7NXIxmTqe29KiKmHSfjENA+6tPrJ1jh143t/mwAKzl13HNz4cBESWXojPpel9
3z8Pe5yjRicN/9Hm7wMQy/I4sA4v+LUMcyC/sEZimI0KUNGRfGRT5UbOO2fbzo28
IH3CirzUzTUJ+bjIgBC0
=avZD
-----END PGP SIGNATURE-----

--QD8Rkd4J928TmlICcDgR9ga5MBMhk2xMF--
