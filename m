Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSX8Y6dFszDvjk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 16:26:21 +1100 (AEDT)
Date: Tue, 29 Nov 2016 15:55:23 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org
Subject: Re: [PATCH kernel v6 6/7] vfio/spapr: Reference mm in tce_container
Message-ID: <20161129045523.GM13307@umbus.fritz.box>
References: <1479966490-8739-1-git-send-email-aik@ozlabs.ru>
 <1479966490-8739-7-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="kkcDP0v44wDpNmbp"
In-Reply-To: <1479966490-8739-7-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--kkcDP0v44wDpNmbp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 24, 2016 at 04:48:09PM +1100, Alexey Kardashevskiy wrote:
> In some situations the userspace memory context may live longer than
> the userspace process itself so if we need to do proper memory context
> cleanup, we better have tce_container take a reference to mm_struct and
> use it later when the process is gone (@current or @current->mm is NULL).
>=20
> This references mm and stores the pointer in the container; this is done
> in a new helper - tce_iommu_mm_set() - when one of the following happens:
> - a container is enabled (IOMMU v1);
> - a first attempt to pre-register memory is made (IOMMU v2);
> - a DMA window is created (IOMMU v2).
> The @mm stays referenced till the container is destroyed.
>=20
> This replaces current->mm with container->mm everywhere except debug
> prints.
>=20
> This adds a check that current->mm is the same as the one stored in
> the container to prevent userspace from making changes to a memory
> context of other processes.
>=20
> DMA map/unmap ioctls() do not check for @mm as they already check
> for @enabled which is set after tce_iommu_mm_set() is called.
>=20
> This does not reference a task as multiple threads within the same mm
> are allowed to ioctl() to vfio and supposedly they will have same limits
> and capabilities and if they do not, we'll just fail with no harm made.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v6:
> * updated the commit log about not referencing task
>=20
> v5:
> * postpone referencing of mm
>=20
> v4:
> * added check for container->mm!=3Dcurrent->mm in tce_iommu_ioctl()
> for all ioctls and removed other redundand checks
> ---
>  drivers/vfio/vfio_iommu_spapr_tce.c | 159 ++++++++++++++++++++++--------=
------
>  1 file changed, 99 insertions(+), 60 deletions(-)
>=20
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iomm=
u_spapr_tce.c
> index 88622be..b2fb05ac 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -31,49 +31,49 @@
>  static void tce_iommu_detach_group(void *iommu_data,
>  		struct iommu_group *iommu_group);
> =20
> -static long try_increment_locked_vm(long npages)
> +static long try_increment_locked_vm(struct mm_struct *mm, long npages)
>  {
>  	long ret =3D 0, locked, lock_limit;
> =20
> -	if (!current || !current->mm)
> -		return -ESRCH; /* process exited */
> +	if (!mm)
> +		return -EPERM;

Can this happen in practice, or should it be a WARN_ON?

> =20
>  	if (!npages)
>  		return 0;
> =20
> -	down_write(&current->mm->mmap_sem);
> -	locked =3D current->mm->locked_vm + npages;
> +	down_write(&mm->mmap_sem);
> +	locked =3D mm->locked_vm + npages;
>  	lock_limit =3D rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
>  	if (locked > lock_limit && !capable(CAP_IPC_LOCK))
>  		ret =3D -ENOMEM;
>  	else
> -		current->mm->locked_vm +=3D npages;
> +		mm->locked_vm +=3D npages;
> =20
>  	pr_debug("[%d] RLIMIT_MEMLOCK +%ld %ld/%ld%s\n", current->pid,
>  			npages << PAGE_SHIFT,
> -			current->mm->locked_vm << PAGE_SHIFT,
> +			mm->locked_vm << PAGE_SHIFT,
>  			rlimit(RLIMIT_MEMLOCK),
>  			ret ? " - exceeded" : "");
> =20
> -	up_write(&current->mm->mmap_sem);
> +	up_write(&mm->mmap_sem);
> =20
>  	return ret;
>  }
> =20
> -static void decrement_locked_vm(long npages)
> +static void decrement_locked_vm(struct mm_struct *mm, long npages)
>  {
> -	if (!current || !current->mm || !npages)
> -		return; /* process exited */
> +	if (!mm && !npages)

Do you mean &&, or ||?

> +		return;
> =20
> -	down_write(&current->mm->mmap_sem);
> -	if (WARN_ON_ONCE(npages > current->mm->locked_vm))
> -		npages =3D current->mm->locked_vm;
> -	current->mm->locked_vm -=3D npages;
> +	down_write(&mm->mmap_sem);
> +	if (WARN_ON_ONCE(npages > mm->locked_vm))
> +		npages =3D mm->locked_vm;
> +	mm->locked_vm -=3D npages;
>  	pr_debug("[%d] RLIMIT_MEMLOCK -%ld %ld/%ld\n", current->pid,
>  			npages << PAGE_SHIFT,
> -			current->mm->locked_vm << PAGE_SHIFT,
> +			mm->locked_vm << PAGE_SHIFT,
>  			rlimit(RLIMIT_MEMLOCK));
> -	up_write(&current->mm->mmap_sem);
> +	up_write(&mm->mmap_sem);
>  }
> =20
>  /*
> @@ -99,26 +99,38 @@ struct tce_container {
>  	bool v2;
>  	bool def_window_pending;
>  	unsigned long locked_pages;
> +	struct mm_struct *mm;
>  	struct iommu_table *tables[IOMMU_TABLE_GROUP_MAX_TABLES];
>  	struct list_head group_list;
>  };
> =20
> +static long tce_iommu_mm_set(struct tce_container *container)
> +{
> +	if (container->mm) {
> +		if (container->mm =3D=3D current->mm)
> +			return 0;
> +		return -EPERM;
> +	}
> +	BUG_ON(!current->mm);
> +	container->mm =3D current->mm;
> +	atomic_inc(&container->mm->mm_count);
> +
> +	return 0;
> +}
> +
>  static long tce_iommu_unregister_pages(struct tce_container *container,
>  		__u64 vaddr, __u64 size)
>  {
>  	struct mm_iommu_table_group_mem_t *mem;
> =20
> -	if (!current || !current->mm)
> -		return -ESRCH; /* process exited */
> -
>  	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK))
>  		return -EINVAL;
> =20
> -	mem =3D mm_iommu_find(current->mm, vaddr, size >> PAGE_SHIFT);
> +	mem =3D mm_iommu_find(container->mm, vaddr, size >> PAGE_SHIFT);
>  	if (!mem)
>  		return -ENOENT;
> =20
> -	return mm_iommu_put(current->mm, mem);
> +	return mm_iommu_put(container->mm, mem);
>  }
> =20
>  static long tce_iommu_register_pages(struct tce_container *container,
> @@ -128,14 +140,11 @@ static long tce_iommu_register_pages(struct tce_con=
tainer *container,
>  	struct mm_iommu_table_group_mem_t *mem =3D NULL;
>  	unsigned long entries =3D size >> PAGE_SHIFT;
> =20
> -	if (!current || !current->mm)
> -		return -ESRCH; /* process exited */
> -
>  	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK) ||
>  			((vaddr + size) < vaddr))
>  		return -EINVAL;
> =20
> -	ret =3D mm_iommu_get(current->mm, vaddr, entries, &mem);
> +	ret =3D mm_iommu_get(container->mm, vaddr, entries, &mem);
>  	if (ret)
>  		return ret;
> =20
> @@ -144,7 +153,8 @@ static long tce_iommu_register_pages(struct tce_conta=
iner *container,
>  	return 0;
>  }
> =20
> -static long tce_iommu_userspace_view_alloc(struct iommu_table *tbl)
> +static long tce_iommu_userspace_view_alloc(struct iommu_table *tbl,
> +		struct mm_struct *mm)
>  {
>  	unsigned long cb =3D _ALIGN_UP(sizeof(tbl->it_userspace[0]) *
>  			tbl->it_size, PAGE_SIZE);
> @@ -153,13 +163,13 @@ static long tce_iommu_userspace_view_alloc(struct i=
ommu_table *tbl)
> =20
>  	BUG_ON(tbl->it_userspace);
> =20
> -	ret =3D try_increment_locked_vm(cb >> PAGE_SHIFT);
> +	ret =3D try_increment_locked_vm(mm, cb >> PAGE_SHIFT);
>  	if (ret)
>  		return ret;
> =20
>  	uas =3D vzalloc(cb);
>  	if (!uas) {
> -		decrement_locked_vm(cb >> PAGE_SHIFT);
> +		decrement_locked_vm(mm, cb >> PAGE_SHIFT);
>  		return -ENOMEM;
>  	}
>  	tbl->it_userspace =3D uas;
> @@ -167,7 +177,8 @@ static long tce_iommu_userspace_view_alloc(struct iom=
mu_table *tbl)
>  	return 0;
>  }
> =20
> -static void tce_iommu_userspace_view_free(struct iommu_table *tbl)
> +static void tce_iommu_userspace_view_free(struct iommu_table *tbl,
> +		struct mm_struct *mm)
>  {
>  	unsigned long cb =3D _ALIGN_UP(sizeof(tbl->it_userspace[0]) *
>  			tbl->it_size, PAGE_SIZE);
> @@ -177,7 +188,7 @@ static void tce_iommu_userspace_view_free(struct iomm=
u_table *tbl)
> =20
>  	vfree(tbl->it_userspace);
>  	tbl->it_userspace =3D NULL;
> -	decrement_locked_vm(cb >> PAGE_SHIFT);
> +	decrement_locked_vm(mm, cb >> PAGE_SHIFT);
>  }
> =20
>  static bool tce_page_is_contained(struct page *page, unsigned page_shift)
> @@ -237,9 +248,6 @@ static int tce_iommu_enable(struct tce_container *con=
tainer)
>  	struct iommu_table_group *table_group;
>  	struct tce_iommu_group *tcegrp;
> =20
> -	if (!current->mm)
> -		return -ESRCH; /* process exited */
> -
>  	if (container->enabled)
>  		return -EBUSY;
> =20
> @@ -284,8 +292,12 @@ static int tce_iommu_enable(struct tce_container *co=
ntainer)
>  	if (!table_group->tce32_size)
>  		return -EPERM;
> =20
> +	ret =3D tce_iommu_mm_set(container);
> +	if (ret)
> +		return ret;
> +
>  	locked =3D table_group->tce32_size >> PAGE_SHIFT;
> -	ret =3D try_increment_locked_vm(locked);
> +	ret =3D try_increment_locked_vm(container->mm, locked);
>  	if (ret)
>  		return ret;
> =20
> @@ -303,10 +315,8 @@ static void tce_iommu_disable(struct tce_container *=
container)
> =20
>  	container->enabled =3D false;
> =20
> -	if (!current->mm)
> -		return;
> -
> -	decrement_locked_vm(container->locked_pages);
> +	BUG_ON(!container->mm);
> +	decrement_locked_vm(container->mm, container->locked_pages);
>  }
> =20
>  static void *tce_iommu_open(unsigned long arg)
> @@ -333,7 +343,8 @@ static void *tce_iommu_open(unsigned long arg)
>  static int tce_iommu_clear(struct tce_container *container,
>  		struct iommu_table *tbl,
>  		unsigned long entry, unsigned long pages);
> -static void tce_iommu_free_table(struct iommu_table *tbl);
> +static void tce_iommu_free_table(struct tce_container *container,
> +		struct iommu_table *tbl);
> =20
>  static void tce_iommu_release(void *iommu_data)
>  {
> @@ -358,10 +369,12 @@ static void tce_iommu_release(void *iommu_data)
>  			continue;
> =20
>  		tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
> -		tce_iommu_free_table(tbl);
> +		tce_iommu_free_table(container, tbl);
>  	}
> =20
>  	tce_iommu_disable(container);
> +	if (container->mm)
> +		mmdrop(container->mm);
>  	mutex_destroy(&container->lock);
> =20
>  	kfree(container);
> @@ -376,13 +389,14 @@ static void tce_iommu_unuse_page(struct tce_contain=
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
> -	mem =3D mm_iommu_lookup(current->mm, tce, size);
> +	mem =3D mm_iommu_lookup(container->mm, tce, size);
>  	if (!mem)
>  		return -EINVAL;
> =20
> @@ -395,18 +409,18 @@ static int tce_iommu_prereg_ua_to_hpa(unsigned long=
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
> @@ -436,7 +450,7 @@ static int tce_iommu_clear(struct tce_container *cont=
ainer,
>  			continue;
> =20
>  		if (container->v2) {
> -			tce_iommu_unuse_page_v2(tbl, entry);
> +			tce_iommu_unuse_page_v2(container, tbl, entry);
>  			continue;
>  		}
> =20
> @@ -517,7 +531,7 @@ static long tce_iommu_build_v2(struct tce_container *=
container,
>  	enum dma_data_direction dirtmp;
> =20
>  	if (!tbl->it_userspace) {
> -		ret =3D tce_iommu_userspace_view_alloc(tbl);
> +		ret =3D tce_iommu_userspace_view_alloc(tbl, container->mm);
>  		if (ret)
>  			return ret;
>  	}
> @@ -527,8 +541,8 @@ static long tce_iommu_build_v2(struct tce_container *=
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
> @@ -549,7 +563,7 @@ static long tce_iommu_build_v2(struct tce_container *=
container,
>  		ret =3D iommu_tce_xchg(tbl, entry + i, &hpa, &dirtmp);
>  		if (ret) {
>  			/* dirtmp cannot be DMA_NONE here */
> -			tce_iommu_unuse_page_v2(tbl, entry + i);
> +			tce_iommu_unuse_page_v2(container, tbl, entry + i);
>  			pr_err("iommu_tce: %s failed ioba=3D%lx, tce=3D%lx, ret=3D%ld\n",
>  					__func__, entry << tbl->it_page_shift,
>  					tce, ret);
> @@ -557,7 +571,7 @@ static long tce_iommu_build_v2(struct tce_container *=
container,
>  		}
> =20
>  		if (dirtmp !=3D DMA_NONE)
> -			tce_iommu_unuse_page_v2(tbl, entry + i);
> +			tce_iommu_unuse_page_v2(container, tbl, entry + i);
> =20
>  		*pua =3D tce;
> =20
> @@ -585,7 +599,7 @@ static long tce_iommu_create_table(struct tce_contain=
er *container,
>  	if (!table_size)
>  		return -EINVAL;
> =20
> -	ret =3D try_increment_locked_vm(table_size >> PAGE_SHIFT);
> +	ret =3D try_increment_locked_vm(container->mm, table_size >> PAGE_SHIFT=
);
>  	if (ret)
>  		return ret;
> =20
> @@ -598,13 +612,14 @@ static long tce_iommu_create_table(struct tce_conta=
iner *container,
>  	return ret;
>  }
> =20
> -static void tce_iommu_free_table(struct iommu_table *tbl)
> +static void tce_iommu_free_table(struct tce_container *container,
> +		struct iommu_table *tbl)
>  {
>  	unsigned long pages =3D tbl->it_allocated_size >> PAGE_SHIFT;
> =20
> -	tce_iommu_userspace_view_free(tbl);
> +	tce_iommu_userspace_view_free(tbl, container->mm);
>  	tbl->it_ops->free(tbl);
> -	decrement_locked_vm(pages);
> +	decrement_locked_vm(container->mm, pages);
>  }
> =20
>  static long tce_iommu_create_window(struct tce_container *container,
> @@ -667,7 +682,7 @@ static long tce_iommu_create_window(struct tce_contai=
ner *container,
>  		table_group =3D iommu_group_get_iommudata(tcegrp->grp);
>  		table_group->ops->unset_window(table_group, num);
>  	}
> -	tce_iommu_free_table(tbl);
> +	tce_iommu_free_table(container, tbl);
> =20
>  	return ret;
>  }
> @@ -705,7 +720,7 @@ static long tce_iommu_remove_window(struct tce_contai=
ner *container,
> =20
>  	/* Free table */
>  	tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
> -	tce_iommu_free_table(tbl);
> +	tce_iommu_free_table(container, tbl);
>  	container->tables[num] =3D NULL;
> =20
>  	return 0;
> @@ -760,7 +775,17 @@ static long tce_iommu_ioctl(void *iommu_data,
>  		}
> =20
>  		return (ret < 0) ? 0 : ret;
> +	}
> =20
> +	/*
> +	 * Sanity check to prevent one userspace from manipulating
> +	 * another userspace mm.
> +	 */
> +	BUG_ON(!container);
> +	if (container->mm && container->mm !=3D current->mm)
> +		return -EPERM;
> +
> +	switch (cmd) {
>  	case VFIO_IOMMU_SPAPR_TCE_GET_INFO: {
>  		struct vfio_iommu_spapr_tce_info info;
>  		struct tce_iommu_group *tcegrp;
> @@ -929,6 +954,10 @@ static long tce_iommu_ioctl(void *iommu_data,
>  		minsz =3D offsetofend(struct vfio_iommu_spapr_register_memory,
>  				size);
> =20
> +		ret =3D tce_iommu_mm_set(container);
> +		if (ret)
> +			return ret;
> +
>  		if (copy_from_user(&param, (void __user *)arg, minsz))
>  			return -EFAULT;
> =20
> @@ -952,6 +981,9 @@ static long tce_iommu_ioctl(void *iommu_data,
>  		if (!container->v2)
>  			break;
> =20
> +		if (!container->mm)
> +			return -EPERM;
> +
>  		minsz =3D offsetofend(struct vfio_iommu_spapr_register_memory,
>  				size);
> =20
> @@ -1010,6 +1042,10 @@ static long tce_iommu_ioctl(void *iommu_data,
>  		if (!container->v2)
>  			break;
> =20
> +		ret =3D tce_iommu_mm_set(container);
> +		if (ret)
> +			return ret;
> +
>  		if (!tce_groups_attached(container))
>  			return -ENXIO;
> =20
> @@ -1048,6 +1084,9 @@ static long tce_iommu_ioctl(void *iommu_data,
>  		if (!container->v2)
>  			break;
> =20
> +		if (!container->mm)
> +			return -EPERM;
> +

This is the VFIO_IOMMU_SPAPR_TCE_REMOVE path, isn't it?  In which case
I think this is not quite right.  IIUC it would be correct to create
the container, attach a group, then remove the default window before
creating new windows and starting mapping.  That would cause an EPERM
here because we haven't set the mm yet.

So, I think this needs to be a tce_iommu_mm_set() instead.

>  		if (!tce_groups_attached(container))
>  			return -ENXIO;
> =20
> @@ -1093,7 +1132,7 @@ static void tce_iommu_release_ownership(struct tce_=
container *container,
>  			continue;
> =20
>  		tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
> -		tce_iommu_userspace_view_free(tbl);
> +		tce_iommu_userspace_view_free(tbl, container->mm);
>  		if (tbl->it_map)
>  			iommu_release_ownership(tbl);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--kkcDP0v44wDpNmbp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYPQo4AAoJEGw4ysog2bOSL5wQAOCoio3ehQdJpHWMp9QQ9k+u
DAYgjbJxao1iVqXcZ1RQMpMsAglMJfPTDE7dX55jWMUB5kn5SEIinJHRw1Nh3rWR
nCg3kxjKpk37hFIoMAtaTatomc48WUAZ9eThOhwBdnWHhBBlOxQ1ZJM9GJ6LJSQG
USYueJKX90380hU6nFBcbjqJJCxnd8YnXr42g6XPaaGAsF2CF5gmclH14cQAFc6O
N2fEyAVMFmw/g/OeYMIevDD/XsgDpL4/ZwTeR1Cd0e4TbJFSP6Up7AYjQmdGqN15
pkRGLqBOdZ6TAgjWuEeWM/42gQg/FtDtTsDvIB5Cy2LLFfJ0XQNlUCu915M/sjdi
/2PHwHA9q8xDmoj/WNqiSfCaOINWiqy/6Xu4Q9zNahTcgc6O4kHo14h7UES6tI9j
U9YNTuS7zvLPBFluP1sc2kQfgRdRofcFfCDIZFu7TaLrm+BpfvT5QqXvCuj5Tnhp
yQGpr2yOrDvJWQ64dx/MfOfE4mEbyLNJeQM7A0sdCJ3+Et1S1PPCBqFUeqF64KW9
An/wFjuFnvC5bz3oyNcff9AUJ4cTP353QJbrpxjeYUXmrGbpoSwxdX/5qqC9gqah
SQu3GDRXuby8Rz/5zewVPfXOQ6/+lftE0xltwfuFoje4fzjfWAVB+HQuOEQrGyQc
JgoBqk+xxtDGPWqEF9Nn
=Nw+2
-----END PGP SIGNATURE-----

--kkcDP0v44wDpNmbp--
