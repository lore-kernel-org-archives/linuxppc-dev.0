Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t317r0yNVzDvj7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 15:56:06 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id r16so18384048pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 21:56:06 -0700 (PDT)
Subject: Re: [PATCH kernel v4 4/4] powerpc/mm/iommu, vfio/spapr: Put pages on
 VFIO container shutdown
To: David Gibson <david@gibson.dropbear.id.au>
References: <1477291990-2872-1-git-send-email-aik@ozlabs.ru>
 <1477291990-2872-5-git-send-email-aik@ozlabs.ru>
 <20161025044414.GW11052@umbus.fritz.box>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <9f5fda35-be4d-12d1-e027-d8576cc8e8fe@ozlabs.ru>
Date: Tue, 25 Oct 2016 15:55:56 +1100
MIME-Version: 1.0
In-Reply-To: <20161025044414.GW11052@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KEVVOEQLnSVA73tWheKvVgkjQsArDvh3d"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KEVVOEQLnSVA73tWheKvVgkjQsArDvh3d
Content-Type: multipart/mixed; boundary="OLHnswTgaVqH65V1e0Jjm15KR8ESPwCfa";
 protected-headers="v1"
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>
Message-ID: <9f5fda35-be4d-12d1-e027-d8576cc8e8fe@ozlabs.ru>
Subject: Re: [PATCH kernel v4 4/4] powerpc/mm/iommu, vfio/spapr: Put pages on
 VFIO container shutdown
References: <1477291990-2872-1-git-send-email-aik@ozlabs.ru>
 <1477291990-2872-5-git-send-email-aik@ozlabs.ru>
 <20161025044414.GW11052@umbus.fritz.box>
In-Reply-To: <20161025044414.GW11052@umbus.fritz.box>

--OLHnswTgaVqH65V1e0Jjm15KR8ESPwCfa
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: quoted-printable

On 25/10/16 15:44, David Gibson wrote:
> On Mon, Oct 24, 2016 at 05:53:10PM +1100, Alexey Kardashevskiy wrote:
>> At the moment the userspace tool is expected to request pinning of
>> the entire guest RAM when VFIO IOMMU SPAPR v2 driver is present.
>> When the userspace process finishes, all the pinned pages need to
>> be put; this is done as a part of the userspace memory context (MM)
>> destruction which happens on the very last mmdrop().
>>
>> This approach has a problem that a MM of the userspace process
>> may live longer than the userspace process itself as kernel threads
>> use userspace process MMs which was runnning on a CPU where
>> the kernel thread was scheduled to. If this happened, the MM remains
>> referenced until this exact kernel thread wakes up again
>> and releases the very last reference to the MM, on an idle system this=

>> can take even hours.
>>
>> This moves preregistered regions tracking from MM to VFIO; insteads of=

>> using mm_iommu_table_group_mem_t::used, tce_container::prereg_list is
>> added so each container releases regions which it has pre-registered.
>>
>> This changes the userspace interface to return EBUSY if a memory
>> region is already registered in a container. However it should not
>> have any practical effect as the only userspace tool available now
>> does register memory region once per container anyway.
>>
>> As tce_iommu_register_pages/tce_iommu_unregister_pages are called
>> under container->lock, this does not need additional locking.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
>=20
> On the grounds that this leaves things in a better state than before:
>=20
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> On the other hand the implementation is kind of clunky, with the way
> it keeps the mm-level and vfio-level lists of regions in parallel.
> With this change, does the mm-level list actually serve any purpose at
> all, or could it all be moved into the vfio-level list?


The mm-level list allows not having gup() called for each container (mino=
r
thing, I suppose) and it also tracks a number of active mappings which wi=
ll
become useful when we add in-kernel real-mode TCE acceleration as
vfio-level code cannot run in realmode.



>=20
>> ---
>> Changes:
>> v4:
>> * changed tce_iommu_register_pages() to call mm_iommu_find() first and=

>> avoid calling mm_iommu_put() if memory is preregistered already
>>
>> v3:
>> * moved tce_iommu_prereg_free() call out of list_for_each_entry()
>>
>> v2:
>> * updated commit log
>> ---
>>  arch/powerpc/mm/mmu_context_book3s64.c |  4 ---
>>  arch/powerpc/mm/mmu_context_iommu.c    | 11 -------
>>  drivers/vfio/vfio_iommu_spapr_tce.c    | 58 +++++++++++++++++++++++++=
++++++++-
>>  3 files changed, 57 insertions(+), 16 deletions(-)
>>
>> diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/=
mmu_context_book3s64.c
>> index ad82735..1a07969 100644
>> --- a/arch/powerpc/mm/mmu_context_book3s64.c
>> +++ b/arch/powerpc/mm/mmu_context_book3s64.c
>> @@ -159,10 +159,6 @@ static inline void destroy_pagetable_page(struct =
mm_struct *mm)
>> =20
>>  void destroy_context(struct mm_struct *mm)
>>  {
>> -#ifdef CONFIG_SPAPR_TCE_IOMMU
>> -	mm_iommu_cleanup(mm);
>> -#endif
>> -
>>  #ifdef CONFIG_PPC_ICSWX
>>  	drop_cop(mm->context.acop, mm);
>>  	kfree(mm->context.cop_lockp);
>> diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu=
_context_iommu.c
>> index 4c6db09..104bad0 100644
>> --- a/arch/powerpc/mm/mmu_context_iommu.c
>> +++ b/arch/powerpc/mm/mmu_context_iommu.c
>> @@ -365,14 +365,3 @@ void mm_iommu_init(struct mm_struct *mm)
>>  {
>>  	INIT_LIST_HEAD_RCU(&mm->context.iommu_group_mem_list);
>>  }
>> -
>> -void mm_iommu_cleanup(struct mm_struct *mm)
>> -{
>> -	struct mm_iommu_table_group_mem_t *mem, *tmp;
>> -
>> -	list_for_each_entry_safe(mem, tmp, &mm->context.iommu_group_mem_list=
,
>> -			next) {
>> -		list_del_rcu(&mem->next);
>> -		mm_iommu_do_free(mem);
>> -	}
>> -}
>> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_i=
ommu_spapr_tce.c
>> index 81ab93f..001a488 100644
>> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
>> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
>> @@ -86,6 +86,15 @@ struct tce_iommu_group {
>>  };
>> =20
>>  /*
>> + * A container needs to remember which preregistered region  it has
>> + * referenced to do proper cleanup at the userspace process exit.
>> + */
>> +struct tce_iommu_prereg {
>> +	struct list_head next;
>> +	struct mm_iommu_table_group_mem_t *mem;
>> +};
>> +
>> +/*
>>   * The container descriptor supports only a single group per containe=
r.
>>   * Required by the API as the container is not supplied with the IOMM=
U group
>>   * at the moment of initialization.
>> @@ -98,12 +107,27 @@ struct tce_container {
>>  	struct mm_struct *mm;
>>  	struct iommu_table *tables[IOMMU_TABLE_GROUP_MAX_TABLES];
>>  	struct list_head group_list;
>> +	struct list_head prereg_list;
>>  };
>> =20
>> +static long tce_iommu_prereg_free(struct tce_container *container,
>> +		struct tce_iommu_prereg *tcemem)
>> +{
>> +	long ret;
>> +
>> +	list_del(&tcemem->next);
>> +	ret =3D mm_iommu_put(container->mm, tcemem->mem);
>> +	kfree(tcemem);
>> +
>> +	return ret;
>> +}
>> +
>>  static long tce_iommu_unregister_pages(struct tce_container *containe=
r,
>>  		__u64 vaddr, __u64 size)
>>  {
>>  	struct mm_iommu_table_group_mem_t *mem;
>> +	struct tce_iommu_prereg *tcemem;
>> +	bool found =3D false;
>> =20
>>  	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK))
>>  		return -EINVAL;
>> @@ -112,7 +136,17 @@ static long tce_iommu_unregister_pages(struct tce=
_container *container,
>>  	if (!mem)
>>  		return -ENOENT;
>> =20
>> -	return mm_iommu_put(container->mm, mem);
>> +	list_for_each_entry(tcemem, &container->prereg_list, next) {
>> +		if (tcemem->mem =3D=3D mem) {
>> +			found =3D true;
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (!found)
>> +		return -ENOENT;
>> +
>> +	return tce_iommu_prereg_free(container, tcemem);
>>  }
>> =20
>>  static long tce_iommu_register_pages(struct tce_container *container,=

>> @@ -120,16 +154,29 @@ static long tce_iommu_register_pages(struct tce_=
container *container,
>>  {
>>  	long ret =3D 0;
>>  	struct mm_iommu_table_group_mem_t *mem =3D NULL;
>> +	struct tce_iommu_prereg *tcemem;
>>  	unsigned long entries =3D size >> PAGE_SHIFT;
>> =20
>>  	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK) ||
>>  			((vaddr + size) < vaddr))
>>  		return -EINVAL;
>> =20
>> +	mem =3D mm_iommu_find(container->mm, vaddr, entries);
>> +	if (mem) {
>> +		list_for_each_entry(tcemem, &container->prereg_list, next) {
>> +			if (tcemem->mem =3D=3D mem)
>> +				return -EBUSY;
>> +		}
>> +	}
>> +
>>  	ret =3D mm_iommu_get(container->mm, vaddr, entries, &mem);
>>  	if (ret)
>>  		return ret;
>> =20
>> +	tcemem =3D kzalloc(sizeof(*tcemem), GFP_KERNEL);
>> +	tcemem->mem =3D mem;
>> +	list_add(&tcemem->next, &container->prereg_list);
>> +
>>  	container->enabled =3D true;
>> =20
>>  	return 0;
>> @@ -311,6 +358,7 @@ static void *tce_iommu_open(unsigned long arg)
>> =20
>>  	mutex_init(&container->lock);
>>  	INIT_LIST_HEAD_RCU(&container->group_list);
>> +	INIT_LIST_HEAD_RCU(&container->prereg_list);
>> =20
>>  	container->v2 =3D arg =3D=3D VFIO_SPAPR_TCE_v2_IOMMU;
>> =20
>> @@ -353,6 +401,14 @@ static void tce_iommu_release(void *iommu_data)
>>  		tce_iommu_free_table(container, tbl);
>>  	}
>> =20
>> +	while (!list_empty(&container->prereg_list)) {
>> +		struct tce_iommu_prereg *tcemem;
>> +
>> +		tcemem =3D list_first_entry(&container->prereg_list,
>> +				struct tce_iommu_prereg, next);
>> +		tce_iommu_prereg_free(container, tcemem);
>> +	}
>> +
>>  	tce_iommu_disable(container);
>>  	mmdrop(container->mm);
>>  	mutex_destroy(&container->lock);
>=20


--=20
Alexey


--OLHnswTgaVqH65V1e0Jjm15KR8ESPwCfa--

--KEVVOEQLnSVA73tWheKvVgkjQsArDvh3d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJYDuXdDhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC53hYQAJnt
l6VvZUX6DuGZ+Z80g//qOlbIenMk9UkU/jFyULNl42G3eItFow8EACsWA1faggWY
jlnAKdhP8VvC3Dinbq81iofZJf48pxjtb7VaGJDTmHEyKifdoCR4RDbvU07XWlxe
K/Y0b5Q/N4sKo42HlqVXr6zNnrQYQ05Vx5VMftVLlYFfugd1Q63Sl8SzRm3p5P+s
thUXijl3RINlMtdAWBN+ty+qtq9s7Cw2EJK9oRvgN4bqH8riDL5/na0SbcyT9fE+
sO224f2zu+03z3Ose8SE2RVGDurFGpsMttniDKoxEoNEFZZGn3/HItEfjdAQQOQS
hAuuzFnB3ElOHecSih4+9c6IDP+fHqNV60iqCy3Lc6FDw1lR9HqasGXIM0TY4sXN
WQs2ys317BMQb9ER/HjUdjuBENlk8oG7xZX9UgzrJsdz45EbnPV6Oyqd5fCt+hjP
xHI0rBKet8UJMnZAuQOUYFKFFaxia2Gln1YgLlg1u+UhUdb45nU/EvPV+Z4fkO0F
hhd9XMqUD6mj793ZSVRBjt3y/czDwkZYlMAASKdTNWIoY0ZdAf4PwCD24Ad0NsGX
64fbUFCUYKFDq4oVtHOrpx7azZGLlGVZZ/MgN9UbSU+FvI9bg++EnpRAPzDeL5PE
gYEPYtOlsPyB1UCT2jH96xmvrIAbHZ3xBfIVsTcR
=hjCl
-----END PGP SIGNATURE-----

--KEVVOEQLnSVA73tWheKvVgkjQsArDvh3d--
