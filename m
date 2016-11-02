Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t7sqw1LbKzDvN8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Nov 2016 13:44:12 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id y68so311714pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Nov 2016 19:44:12 -0700 (PDT)
Subject: Re: [PATCH kernel v4 4/4] powerpc/mm/iommu, vfio/spapr: Put pages on
 VFIO container shutdown
To: David Gibson <david@gibson.dropbear.id.au>
References: <1477291990-2872-1-git-send-email-aik@ozlabs.ru>
 <1477291990-2872-5-git-send-email-aik@ozlabs.ru>
 <20161025044414.GW11052@umbus.fritz.box>
 <9f5fda35-be4d-12d1-e027-d8576cc8e8fe@ozlabs.ru>
 <20161031031318.GM18226@umbus.fritz.box>
 <baf7960d-dbd2-efc8-5574-6a575f2714c6@ozlabs.ru>
 <20161031042347.GN18226@umbus.fritz.box>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <d03177f8-231e-cef7-d518-e33bea5a1cfb@ozlabs.ru>
Date: Wed, 2 Nov 2016 13:44:03 +1100
MIME-Version: 1.0
In-Reply-To: <20161031042347.GN18226@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jbsxELP2wMnqi06OnwFqEjhKWpjSaGwTG"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jbsxELP2wMnqi06OnwFqEjhKWpjSaGwTG
Content-Type: multipart/mixed; boundary="3735FHx5jgQksA09pHmNHGE0Xrd7BcV8e";
 protected-headers="v1"
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>
Message-ID: <d03177f8-231e-cef7-d518-e33bea5a1cfb@ozlabs.ru>
Subject: Re: [PATCH kernel v4 4/4] powerpc/mm/iommu, vfio/spapr: Put pages on
 VFIO container shutdown
References: <1477291990-2872-1-git-send-email-aik@ozlabs.ru>
 <1477291990-2872-5-git-send-email-aik@ozlabs.ru>
 <20161025044414.GW11052@umbus.fritz.box>
 <9f5fda35-be4d-12d1-e027-d8576cc8e8fe@ozlabs.ru>
 <20161031031318.GM18226@umbus.fritz.box>
 <baf7960d-dbd2-efc8-5574-6a575f2714c6@ozlabs.ru>
 <20161031042347.GN18226@umbus.fritz.box>
In-Reply-To: <20161031042347.GN18226@umbus.fritz.box>

--3735FHx5jgQksA09pHmNHGE0Xrd7BcV8e
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: quoted-printable

On 31/10/16 15:23, David Gibson wrote:
> On Mon, Oct 31, 2016 at 03:13:21PM +1100, Alexey Kardashevskiy wrote:
>> On 31/10/16 14:13, David Gibson wrote:
>>> On Tue, Oct 25, 2016 at 03:55:56PM +1100, Alexey Kardashevskiy wrote:=

>>>> On 25/10/16 15:44, David Gibson wrote:
>>>>> On Mon, Oct 24, 2016 at 05:53:10PM +1100, Alexey Kardashevskiy wrot=
e:
>>>>>> At the moment the userspace tool is expected to request pinning of=

>>>>>> the entire guest RAM when VFIO IOMMU SPAPR v2 driver is present.
>>>>>> When the userspace process finishes, all the pinned pages need to
>>>>>> be put; this is done as a part of the userspace memory context (MM=
)
>>>>>> destruction which happens on the very last mmdrop().
>>>>>>
>>>>>> This approach has a problem that a MM of the userspace process
>>>>>> may live longer than the userspace process itself as kernel thread=
s
>>>>>> use userspace process MMs which was runnning on a CPU where
>>>>>> the kernel thread was scheduled to. If this happened, the MM remai=
ns
>>>>>> referenced until this exact kernel thread wakes up again
>>>>>> and releases the very last reference to the MM, on an idle system =
this
>>>>>> can take even hours.
>>>>>>
>>>>>> This moves preregistered regions tracking from MM to VFIO; instead=
s of
>>>>>> using mm_iommu_table_group_mem_t::used, tce_container::prereg_list=
 is
>>>>>> added so each container releases regions which it has pre-register=
ed.
>>>>>>
>>>>>> This changes the userspace interface to return EBUSY if a memory
>>>>>> region is already registered in a container. However it should not=

>>>>>> have any practical effect as the only userspace tool available now=

>>>>>> does register memory region once per container anyway.
>>>>>>
>>>>>> As tce_iommu_register_pages/tce_iommu_unregister_pages are called
>>>>>> under container->lock, this does not need additional locking.
>>>>>>
>>>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>>>> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
>>>>>
>>>>> On the grounds that this leaves things in a better state than befor=
e:
>>>>>
>>>>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>>>>>
>>>>> On the other hand the implementation is kind of clunky, with the wa=
y
>>>>> it keeps the mm-level and vfio-level lists of regions in parallel.
>>>>> With this change, does the mm-level list actually serve any purpose=
 at
>>>>> all, or could it all be moved into the vfio-level list?
>>>>
>>>>
>>>> The mm-level list allows not having gup() called for each container =
(minor
>>>> thing, I suppose) and it also tracks a number of active mappings whi=
ch will
>>>> become useful when we add in-kernel real-mode TCE acceleration as
>>>> vfio-level code cannot run in realmode.
>>>
>>> Hm, ok.  So, if two different containers pre-register the same region=

>>> of memory, IIUC in the proposed code, the region will get one entry i=
n
>>> the mm level list, and that entry will be referenced in the lists for=

>>> both containers.  Yes?
>>
>> Yes.
>>
>>
>>> What happens if two different containers try to pre-register
>>> different, but overlapping, mm regions?
>>
>> The second container will fail to preregister memory - mm_iommu_get() =
will
>> return -EINVAL.
>=20
> Um.. yeah.. that's not really ok.  Prohibiting overlapping
> registrations on the same container is reasonable enough.  Having a
> container not be able to register memory because some completely
> different container has registered something overlapping is getting
> very ugly.

I am lost here. Does this mean the patches cannot go upstream?

Also how would I implement overlapping if we are not teaching KVM about
VFIO containers? The mm list has a counter of how many times each memory
region was mapped via TCE (and this prevents unregistration), and if we
want overlapping regions - a "mapped" counter of which one would I update=

in real mode (where I only have a user address and a LIOBN)?



>=20
>> I am wondering what happens to the series now.
>>
>> Alex, could you please have a look and comment? Thanks.
>>
>>
>>
>>>
>>>>
>>>>
>>>>
>>>>>
>>>>>> ---
>>>>>> Changes:
>>>>>> v4:
>>>>>> * changed tce_iommu_register_pages() to call mm_iommu_find() first=
 and
>>>>>> avoid calling mm_iommu_put() if memory is preregistered already
>>>>>>
>>>>>> v3:
>>>>>> * moved tce_iommu_prereg_free() call out of list_for_each_entry()
>>>>>>
>>>>>> v2:
>>>>>> * updated commit log
>>>>>> ---
>>>>>>  arch/powerpc/mm/mmu_context_book3s64.c |  4 ---
>>>>>>  arch/powerpc/mm/mmu_context_iommu.c    | 11 -------
>>>>>>  drivers/vfio/vfio_iommu_spapr_tce.c    | 58 +++++++++++++++++++++=
++++++++++++-
>>>>>>  3 files changed, 57 insertions(+), 16 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc=
/mm/mmu_context_book3s64.c
>>>>>> index ad82735..1a07969 100644
>>>>>> --- a/arch/powerpc/mm/mmu_context_book3s64.c
>>>>>> +++ b/arch/powerpc/mm/mmu_context_book3s64.c
>>>>>> @@ -159,10 +159,6 @@ static inline void destroy_pagetable_page(str=
uct mm_struct *mm)
>>>>>> =20
>>>>>>  void destroy_context(struct mm_struct *mm)
>>>>>>  {
>>>>>> -#ifdef CONFIG_SPAPR_TCE_IOMMU
>>>>>> -	mm_iommu_cleanup(mm);
>>>>>> -#endif
>>>>>> -
>>>>>>  #ifdef CONFIG_PPC_ICSWX
>>>>>>  	drop_cop(mm->context.acop, mm);
>>>>>>  	kfree(mm->context.cop_lockp);
>>>>>> diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm=
/mmu_context_iommu.c
>>>>>> index 4c6db09..104bad0 100644
>>>>>> --- a/arch/powerpc/mm/mmu_context_iommu.c
>>>>>> +++ b/arch/powerpc/mm/mmu_context_iommu.c
>>>>>> @@ -365,14 +365,3 @@ void mm_iommu_init(struct mm_struct *mm)
>>>>>>  {
>>>>>>  	INIT_LIST_HEAD_RCU(&mm->context.iommu_group_mem_list);
>>>>>>  }
>>>>>> -
>>>>>> -void mm_iommu_cleanup(struct mm_struct *mm)
>>>>>> -{
>>>>>> -	struct mm_iommu_table_group_mem_t *mem, *tmp;
>>>>>> -
>>>>>> -	list_for_each_entry_safe(mem, tmp, &mm->context.iommu_group_mem_=
list,
>>>>>> -			next) {
>>>>>> -		list_del_rcu(&mem->next);
>>>>>> -		mm_iommu_do_free(mem);
>>>>>> -	}
>>>>>> -}
>>>>>> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vf=
io_iommu_spapr_tce.c
>>>>>> index 81ab93f..001a488 100644
>>>>>> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
>>>>>> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
>>>>>> @@ -86,6 +86,15 @@ struct tce_iommu_group {
>>>>>>  };
>>>>>> =20
>>>>>>  /*
>>>>>> + * A container needs to remember which preregistered region  it h=
as
>>>>>> + * referenced to do proper cleanup at the userspace process exit.=

>>>>>> + */
>>>>>> +struct tce_iommu_prereg {
>>>>>> +	struct list_head next;
>>>>>> +	struct mm_iommu_table_group_mem_t *mem;
>>>>>> +};
>>>>>> +
>>>>>> +/*
>>>>>>   * The container descriptor supports only a single group per cont=
ainer.
>>>>>>   * Required by the API as the container is not supplied with the =
IOMMU group
>>>>>>   * at the moment of initialization.
>>>>>> @@ -98,12 +107,27 @@ struct tce_container {
>>>>>>  	struct mm_struct *mm;
>>>>>>  	struct iommu_table *tables[IOMMU_TABLE_GROUP_MAX_TABLES];
>>>>>>  	struct list_head group_list;
>>>>>> +	struct list_head prereg_list;
>>>>>>  };
>>>>>> =20
>>>>>> +static long tce_iommu_prereg_free(struct tce_container *container=
,
>>>>>> +		struct tce_iommu_prereg *tcemem)
>>>>>> +{
>>>>>> +	long ret;
>>>>>> +
>>>>>> +	list_del(&tcemem->next);
>>>>>> +	ret =3D mm_iommu_put(container->mm, tcemem->mem);
>>>>>> +	kfree(tcemem);
>>>>>> +
>>>>>> +	return ret;
>>>>>> +}
>>>>>> +
>>>>>>  static long tce_iommu_unregister_pages(struct tce_container *cont=
ainer,
>>>>>>  		__u64 vaddr, __u64 size)
>>>>>>  {
>>>>>>  	struct mm_iommu_table_group_mem_t *mem;
>>>>>> +	struct tce_iommu_prereg *tcemem;
>>>>>> +	bool found =3D false;
>>>>>> =20
>>>>>>  	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK))
>>>>>>  		return -EINVAL;
>>>>>> @@ -112,7 +136,17 @@ static long tce_iommu_unregister_pages(struct=
 tce_container *container,
>>>>>>  	if (!mem)
>>>>>>  		return -ENOENT;
>>>>>> =20
>>>>>> -	return mm_iommu_put(container->mm, mem);
>>>>>> +	list_for_each_entry(tcemem, &container->prereg_list, next) {
>>>>>> +		if (tcemem->mem =3D=3D mem) {
>>>>>> +			found =3D true;
>>>>>> +			break;
>>>>>> +		}
>>>>>> +	}
>>>>>> +
>>>>>> +	if (!found)
>>>>>> +		return -ENOENT;
>>>>>> +
>>>>>> +	return tce_iommu_prereg_free(container, tcemem);
>>>>>>  }
>>>>>> =20
>>>>>>  static long tce_iommu_register_pages(struct tce_container *contai=
ner,
>>>>>> @@ -120,16 +154,29 @@ static long tce_iommu_register_pages(struct =
tce_container *container,
>>>>>>  {
>>>>>>  	long ret =3D 0;
>>>>>>  	struct mm_iommu_table_group_mem_t *mem =3D NULL;
>>>>>> +	struct tce_iommu_prereg *tcemem;
>>>>>>  	unsigned long entries =3D size >> PAGE_SHIFT;
>>>>>> =20
>>>>>>  	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK) ||
>>>>>>  			((vaddr + size) < vaddr))
>>>>>>  		return -EINVAL;
>>>>>> =20
>>>>>> +	mem =3D mm_iommu_find(container->mm, vaddr, entries);
>>>>>> +	if (mem) {
>>>>>> +		list_for_each_entry(tcemem, &container->prereg_list, next) {
>>>>>> +			if (tcemem->mem =3D=3D mem)
>>>>>> +				return -EBUSY;
>>>>>> +		}
>>>>>> +	}
>>>>>> +
>>>>>>  	ret =3D mm_iommu_get(container->mm, vaddr, entries, &mem);
>>>>>>  	if (ret)
>>>>>>  		return ret;
>>>>>> =20
>>>>>> +	tcemem =3D kzalloc(sizeof(*tcemem), GFP_KERNEL);
>>>>>> +	tcemem->mem =3D mem;
>>>>>> +	list_add(&tcemem->next, &container->prereg_list);
>>>>>> +
>>>>>>  	container->enabled =3D true;
>>>>>> =20
>>>>>>  	return 0;
>>>>>> @@ -311,6 +358,7 @@ static void *tce_iommu_open(unsigned long arg)=

>>>>>> =20
>>>>>>  	mutex_init(&container->lock);
>>>>>>  	INIT_LIST_HEAD_RCU(&container->group_list);
>>>>>> +	INIT_LIST_HEAD_RCU(&container->prereg_list);
>>>>>> =20
>>>>>>  	container->v2 =3D arg =3D=3D VFIO_SPAPR_TCE_v2_IOMMU;
>>>>>> =20
>>>>>> @@ -353,6 +401,14 @@ static void tce_iommu_release(void *iommu_dat=
a)
>>>>>>  		tce_iommu_free_table(container, tbl);
>>>>>>  	}
>>>>>> =20
>>>>>> +	while (!list_empty(&container->prereg_list)) {
>>>>>> +		struct tce_iommu_prereg *tcemem;
>>>>>> +
>>>>>> +		tcemem =3D list_first_entry(&container->prereg_list,
>>>>>> +				struct tce_iommu_prereg, next);
>>>>>> +		tce_iommu_prereg_free(container, tcemem);
>>>>>> +	}
>>>>>> +
>>>>>>  	tce_iommu_disable(container);
>>>>>>  	mmdrop(container->mm);
>>>>>>  	mutex_destroy(&container->lock);
>>>>>
>>>>
>>>>
>>>
>>>
>>>
>>>
>>
>>
>=20
>=20
>=20
>=20


--=20
Alexey


--3735FHx5jgQksA09pHmNHGE0Xrd7BcV8e--

--jbsxELP2wMnqi06OnwFqEjhKWpjSaGwTG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJYGVLzDhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC5Gb0P/0R7
/oJFi/hYqXrZF0eLQ1tR552b3zI61JgQd8dHE25SIjWtPwiIAEaJneDiumLj49QB
9uGopeWAjdKGQC4T3Yz+1KMrWLJB/Q2qId/d7AwZbJMIUFWl8bZcbwAm0JyvCDTS
dv6XYd2YkiloqmLywC+Hmp/Y8l0XtYSUSdG9UZX0SjTBWkd14Di0Y/xtL8TcFUvF
3Ej0qX0iOr2FfCVoxXQpwn/omZSEKNtoKYAA3+k9gpYSD849cL92UqR6DuqV6rCS
Pw3CWlEukIIPXJHcjTkoPnhfvWCjd4+FPVznLpDk0M2rVWDjIdQy2R3xQUJaWHgw
gaLwBgs/StDFKpX5t5CbcrcbNJVOWcGaa4JYR+h4J1Bpmbh/18w7rEJI4lupLdY5
cbWgx5G0JZ91c5oMXxs7pBmcY6ZwCTH4rYC6CrLpYLY/dANIKquFJtXsXT/C7mET
2iAtGQT5Jkpt9KCUy8vzhQH38alXvyUhr1e3ZpbbkiywccvEnxMaKlgcAelTEzl0
bjvTxEVORacyC52LZhGWez9CG8LjyWvWmzBV3Jv43nncDmB3nd1lSvY7OuxwnDBr
vRLKpVihAKJtTFTAQ2UtOg1dq+c8ISwbnX2nDB1CbxXQ9dSwu7OS3i4foWl0o/nF
YTrznbvY8oLjQaReyf+lXqVU0PEcoQTkrZH5tyLe
=eW0A
-----END PGP SIGNATURE-----

--jbsxELP2wMnqi06OnwFqEjhKWpjSaGwTG--
