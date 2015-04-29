Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8BEFE1A0415
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 08:33:18 +1000 (AEST)
Date: Wed, 29 Apr 2015 17:01:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v9 28/32] powerpc/mmu: Add userspace-to-physical
 addresses translation cache
Message-ID: <20150429070149.GY32589@voom.redhat.com>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-29-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="VIFPKPeEU/ajvd6j"
In-Reply-To: <1429964096-11524-29-git-send-email-aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--VIFPKPeEU/ajvd6j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 25, 2015 at 10:14:52PM +1000, Alexey Kardashevskiy wrote:
> We are adding support for DMA memory pre-registration to be used in
> conjunction with VFIO. The idea is that the userspace which is going to
> run a guest may want to pre-register a user space memory region so
> it all gets pinned once and never goes away. Having this done,
> a hypervisor will not have to pin/unpin pages on every DMA map/unmap
> request. This is going to help with multiple pinning of the same memory
> and in-kernel acceleration of DMA requests.
>=20
> This adds a list of memory regions to mm_context_t. Each region consists
> of a header and a list of physical addresses. This adds API to:
> 1. register/unregister memory regions;
> 2. do final cleanup (which puts all pre-registered pages);
> 3. do userspace to physical address translation;
> 4. manage a mapped pages counter; when it is zero, it is safe to
> unregister the region.
>=20
> Multiple registration of the same region is allowed, kref is used to
> track the number of registrations.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v8:
> * s/mm_iommu_table_group_mem_t/struct mm_iommu_table_group_mem_t/
> * fixed error fallback look (s/[i]/[j]/)
> ---
>  arch/powerpc/include/asm/mmu-hash64.h      |   3 +
>  arch/powerpc/include/asm/mmu_context.h     |  17 +++
>  arch/powerpc/mm/Makefile                   |   1 +
>  arch/powerpc/mm/mmu_context_hash64.c       |   6 +
>  arch/powerpc/mm/mmu_context_hash64_iommu.c | 215 +++++++++++++++++++++++=
++++++
>  5 files changed, 242 insertions(+)
>  create mode 100644 arch/powerpc/mm/mmu_context_hash64_iommu.c
>=20
> diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include=
/asm/mmu-hash64.h
> index 1da6a81..a82f534 100644
> --- a/arch/powerpc/include/asm/mmu-hash64.h
> +++ b/arch/powerpc/include/asm/mmu-hash64.h
> @@ -536,6 +536,9 @@ typedef struct {
>  	/* for 4K PTE fragment support */
>  	void *pte_frag;
>  #endif
> +#ifdef CONFIG_SPAPR_TCE_IOMMU
> +	struct list_head iommu_group_mem_list;
> +#endif

Urgh.  I know I'm not one to talk, having done the hugepage crap in
there, but man mm_context_t has grown to a bloated mess from orginally
being just intended as a context ID integer :/.

>  } mm_context_t;
> =20
> =20
> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/includ=
e/asm/mmu_context.h
> index 73382eb..d6116ca 100644
> --- a/arch/powerpc/include/asm/mmu_context.h
> +++ b/arch/powerpc/include/asm/mmu_context.h
> @@ -16,6 +16,23 @@
>   */
>  extern int init_new_context(struct task_struct *tsk, struct mm_struct *m=
m);
>  extern void destroy_context(struct mm_struct *mm);
> +#ifdef CONFIG_SPAPR_TCE_IOMMU
> +struct mm_iommu_table_group_mem_t;
> +
> +extern bool mm_iommu_preregistered(void);
> +extern long mm_iommu_alloc(unsigned long ua, unsigned long entries,
> +		struct mm_iommu_table_group_mem_t **pmem);
> +extern struct mm_iommu_table_group_mem_t *mm_iommu_get(unsigned long ua,
> +		unsigned long entries);
> +extern long mm_iommu_put(struct mm_iommu_table_group_mem_t *mem);
> +extern void mm_iommu_cleanup(mm_context_t *ctx);
> +extern struct mm_iommu_table_group_mem_t *mm_iommu_lookup(unsigned long =
ua,
> +		unsigned long size);
> +extern long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem,
> +		unsigned long ua, unsigned long *hpa);
> +extern long mm_iommu_mapped_update(struct mm_iommu_table_group_mem_t *me=
m,
> +		bool inc);
> +#endif
> =20
>  extern void switch_mmu_context(struct mm_struct *prev, struct mm_struct =
*next);
>  extern void switch_slb(struct task_struct *tsk, struct mm_struct *mm);
> diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
> index 9c8770b..e216704 100644
> --- a/arch/powerpc/mm/Makefile
> +++ b/arch/powerpc/mm/Makefile
> @@ -36,3 +36,4 @@ obj-$(CONFIG_PPC_SUBPAGE_PROT)	+=3D subpage-prot.o
>  obj-$(CONFIG_NOT_COHERENT_CACHE) +=3D dma-noncoherent.o
>  obj-$(CONFIG_HIGHMEM)		+=3D highmem.o
>  obj-$(CONFIG_PPC_COPRO_BASE)	+=3D copro_fault.o
> +obj-$(CONFIG_SPAPR_TCE_IOMMU)	+=3D mmu_context_hash64_iommu.o
> diff --git a/arch/powerpc/mm/mmu_context_hash64.c b/arch/powerpc/mm/mmu_c=
ontext_hash64.c
> index 178876ae..eb3080c 100644
> --- a/arch/powerpc/mm/mmu_context_hash64.c
> +++ b/arch/powerpc/mm/mmu_context_hash64.c
> @@ -89,6 +89,9 @@ int init_new_context(struct task_struct *tsk, struct mm=
_struct *mm)
>  #ifdef CONFIG_PPC_64K_PAGES
>  	mm->context.pte_frag =3D NULL;
>  #endif
> +#ifdef CONFIG_SPAPR_TCE_IOMMU
> +	INIT_LIST_HEAD_RCU(&mm->context.iommu_group_mem_list);
> +#endif
>  	return 0;
>  }
> =20
> @@ -132,6 +135,9 @@ static inline void destroy_pagetable_page(struct mm_s=
truct *mm)
> =20
>  void destroy_context(struct mm_struct *mm)
>  {
> +#ifdef CONFIG_SPAPR_TCE_IOMMU
> +	mm_iommu_cleanup(&mm->context);
> +#endif
> =20
>  #ifdef CONFIG_PPC_ICSWX
>  	drop_cop(mm->context.acop, mm);
> diff --git a/arch/powerpc/mm/mmu_context_hash64_iommu.c b/arch/powerpc/mm=
/mmu_context_hash64_iommu.c
> new file mode 100644
> index 0000000..af7668c
> --- /dev/null
> +++ b/arch/powerpc/mm/mmu_context_hash64_iommu.c
> @@ -0,0 +1,215 @@
> +/*
> + *  IOMMU helpers in MMU context.
> + *
> + *  Copyright (C) 2015 IBM Corp. <aik@ozlabs.ru>
> + *
> + *  This program is free software; you can redistribute it and/or
> + *  modify it under the terms of the GNU General Public License
> + *  as published by the Free Software Foundation; either version
> + *  2 of the License, or (at your option) any later version.
> + *
> + */
> +
> +#include <linux/sched.h>
> +#include <linux/slab.h>
> +#include <linux/rculist.h>
> +#include <linux/vmalloc.h>
> +#include <linux/kref.h>
> +#include <asm/mmu_context.h>
> +
> +struct mm_iommu_table_group_mem_t {
> +	struct list_head next;
> +	struct rcu_head rcu;
> +	struct kref kref;	/* one reference per VFIO container */
> +	atomic_t mapped;	/* number of currently mapped pages */
> +	u64 ua;			/* userspace address */
> +	u64 entries;		/* number of entries in hpas[] */

Maybe 'npages', since this is used to determine the range of user
addresses covered, not just the number of entries in hpas.

> +	u64 *hpas;		/* vmalloc'ed */
> +};
> +
> +bool mm_iommu_preregistered(void)
> +{
> +	if (!current || !current->mm)
> +		return false;
> +
> +	return !list_empty(&current->mm->context.iommu_group_mem_list);
> +}
> +EXPORT_SYMBOL_GPL(mm_iommu_preregistered);
> +
> +long mm_iommu_alloc(unsigned long ua, unsigned long entries,
> +		struct mm_iommu_table_group_mem_t **pmem)
> +{
> +	struct mm_iommu_table_group_mem_t *mem;
> +	long i, j;
> +	struct page *page =3D NULL;
> +
> +	list_for_each_entry_rcu(mem, &current->mm->context.iommu_group_mem_list,
> +			next) {
> +		if ((mem->ua =3D=3D ua) && (mem->entries =3D=3D entries))
> +			return -EBUSY;
> +
> +		/* Overlap? */
> +		if ((mem->ua < (ua + (entries << PAGE_SHIFT))) &&
> +				(ua < (mem->ua + (mem->entries << PAGE_SHIFT))))
> +			return -EINVAL;
> +	}
> +
> +	mem =3D kzalloc(sizeof(*mem), GFP_KERNEL);
> +	if (!mem)
> +		return -ENOMEM;
> +
> +	mem->hpas =3D vzalloc(entries * sizeof(mem->hpas[0]));
> +	if (!mem->hpas) {
> +		kfree(mem);
> +		return -ENOMEM;
> +	}
> +
> +	for (i =3D 0; i < entries; ++i) {
> +		if (1 !=3D get_user_pages_fast(ua + (i << PAGE_SHIFT),
> +					1/* pages */, 1/* iswrite */, &page)) {

Do you really need to call gup() in a loop?  It can do more than one
page at a time..

That might work better if you kept a list of struct page *s instead of
hpas.

> +			for (j =3D 0; j < i; ++j)
> +				put_page(pfn_to_page(
> +						mem->hpas[j] >> PAGE_SHIFT));
> +			vfree(mem->hpas);
> +			kfree(mem);
> +			return -EFAULT;
> +		}
> +
> +		mem->hpas[i] =3D page_to_pfn(page) << PAGE_SHIFT;
> +	}
> +
> +	kref_init(&mem->kref);
> +	atomic_set(&mem->mapped, 0);
> +	mem->ua =3D ua;
> +	mem->entries =3D entries;
> +	*pmem =3D mem;
> +
> +	list_add_rcu(&mem->next, &current->mm->context.iommu_group_mem_list);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(mm_iommu_alloc);
> +
> +static void mm_iommu_unpin(struct mm_iommu_table_group_mem_t *mem)
> +{
> +	long i;
> +	struct page *page =3D NULL;
> +
> +	for (i =3D 0; i < mem->entries; ++i) {
> +		if (!mem->hpas[i])
> +			continue;
> +
> +		page =3D pfn_to_page(mem->hpas[i] >> PAGE_SHIFT);
> +		if (!page)
> +			continue;
> +
> +		put_page(page);
> +		mem->hpas[i] =3D 0;
> +	}
> +}
> +
> +static void mm_iommu_free(struct rcu_head *head)
> +{
> +	struct mm_iommu_table_group_mem_t *mem =3D container_of(head,
> +			struct mm_iommu_table_group_mem_t, rcu);
> +
> +	mm_iommu_unpin(mem);
> +	vfree(mem->hpas);
> +	kfree(mem);
> +}
> +
> +static void mm_iommu_release(struct kref *kref)
> +{
> +	struct mm_iommu_table_group_mem_t *mem =3D container_of(kref,
> +			struct mm_iommu_table_group_mem_t, kref);
> +
> +	list_del_rcu(&mem->next);
> +	call_rcu(&mem->rcu, mm_iommu_free);
> +}
> +
> +struct mm_iommu_table_group_mem_t *mm_iommu_get(unsigned long ua,
> +		unsigned long entries)
> +{
> +	struct mm_iommu_table_group_mem_t *mem;
> +
> +	list_for_each_entry_rcu(mem, &current->mm->context.iommu_group_mem_list,
> +			next) {
> +		if ((mem->ua =3D=3D ua) && (mem->entries =3D=3D entries)) {
> +			kref_get(&mem->kref);
> +			return mem;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(mm_iommu_get);
> +
> +long mm_iommu_put(struct mm_iommu_table_group_mem_t *mem)
> +{
> +	if (atomic_read(&mem->mapped))
> +		return -EBUSY;

What prevents a race between the atomic_read() above and the release below?

> +	kref_put(&mem->kref, mm_iommu_release);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(mm_iommu_put);
> +
> +struct mm_iommu_table_group_mem_t *mm_iommu_lookup(unsigned long ua,
> +		unsigned long size)
> +{
> +	struct mm_iommu_table_group_mem_t *mem, *ret =3D NULL;
> +
> +	list_for_each_entry_rcu(mem,
> +			&current->mm->context.iommu_group_mem_list,
> +			next) {
> +		if ((mem->ua <=3D ua) &&
> +				(ua + size <=3D mem->ua +
> +				 (mem->entries << PAGE_SHIFT))) {
> +			ret =3D mem;
> +			break;
> +		}
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(mm_iommu_lookup);
> +
> +long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem,
> +		unsigned long ua, unsigned long *hpa)

Return type should be int, it's just an error code.

> +{
> +	const long entry =3D (ua - mem->ua) >> PAGE_SHIFT;
> +	u64 *va =3D &mem->hpas[entry];
> +
> +	if (entry >=3D mem->entries)
> +		return -EFAULT;
> +
> +	*hpa =3D *va | (ua & ~PAGE_MASK);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(mm_iommu_ua_to_hpa);
> +
> +long mm_iommu_mapped_update(struct mm_iommu_table_group_mem_t *mem, bool=
 inc)
> +{
> +	long ret =3D 0;
> +
> +	if (inc)
> +		atomic_inc(&mem->mapped);
> +	else
> +		ret =3D atomic_dec_if_positive(&mem->mapped);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(mm_iommu_mapped_update);

I think this would be clearer as separate inc and dec functions.

> +
> +void mm_iommu_cleanup(mm_context_t *ctx)
> +{
> +	while (!list_empty(&ctx->iommu_group_mem_list)) {
> +		struct mm_iommu_table_group_mem_t *mem;
> +
> +		mem =3D list_first_entry(&ctx->iommu_group_mem_list,
> +				struct mm_iommu_table_group_mem_t, next);
> +		mm_iommu_release(&mem->kref);
> +	}
> +}

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VIFPKPeEU/ajvd6j
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVQIHcAAoJEGw4ysog2bOS9wAP/01fJ3mau3bzJFUehfx1RWd3
gi4H14rrbcayUd4Y4BqA7/J/ROH8UUBtd9nZI835AiXgRmvarxhVIVUPK9pVM8yR
/fa6ssskmF+Gw84js6i9Wk0zzP8t0tAHz/yEdZq9ahB7Gh3kTetyqtNzlNGScrvC
vo9ElBH21k5T+OD5JB8UZAi2Wz/wXjhfhvXGDr2Z8mJtl+tMwBy3jcUfnmO3oBZO
AgV5k0MDDfPRWx1i3H1NrOdVeHmgS4MxxBK5aPPGywb64jHgBLvIQLb44v6j+eLH
sYg7xQAD2T1FUpbWgxa2mR/Gz8GDntTkGRajQ1P9i0zoQ1iKB87jjTSP++hRSvZ9
0M6yHDhOCo1U31Hyk7kryQIrBgEJmvOazTA5B9CHO5JkSbG0th7SatTaOMlcwMLY
OLCQQ/odtlfjRGfSfa2tLGiI4Zzc0QcANUskrKaSa8okXApA6ESCzHcR0WhS95Jm
3ANQapoEMo0SnrrezG6uNG9JoZmJv6AvJ5KeQyVkhweskLm/ah7iUuc7TeGt7iyf
YJZSa4twmHjf1ujz2mCSUNN1wdEIzUTRbO8TgJWRoCyiy/ZqjyOZ1u6mg+WLze0g
6D4v/b195V/HHi8jwD6iFOR/ctHccJs9ZwVoY81ZzHAIzB0KFp/h/vZgy1hVuTzg
hKn5wxnblqifd19PREAb
=fEHR
-----END PGP SIGNATURE-----

--VIFPKPeEU/ajvd6j--
