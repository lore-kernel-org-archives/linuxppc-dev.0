Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tCZmN6dcqzDvZ7
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2016 14:39:00 +1100 (AEDT)
Date: Tue, 8 Nov 2016 14:33:44 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH kernel v4 3/4] vfio/spapr: Reference mm in tce_container
Message-ID: <20161108033344.GJ28688@umbus.fritz.box>
References: <1477291990-2872-1-git-send-email-aik@ozlabs.ru>
 <1477291990-2872-4-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="F4+N/OgRSdC8YnqX"
In-Reply-To: <1477291990-2872-4-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--F4+N/OgRSdC8YnqX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 24, 2016 at 05:53:09PM +1100, Alexey Kardashevskiy wrote:
> In some situations the userspace memory context may live longer than
> the userspace process itself so if we need to do proper memory context
> cleanup, we better have tce_container take a reference to mm_struct and
> use it later when the process is gone (@current or @current->mm is NULL).
>=20
> This references mm and stores the pointer in the container; this is done
> when a container is just created so checking for !current->mm in other
> places becomes pointless.
>=20
> This replaces current->mm with container->mm everywhere except debug
> prints.
>=20
> This adds a check that current->mm is the same as the one stored in
> the container to prevent userspace from making changes to a memory
> context of other processes; in order to add this check,
> VFIO_CHECK_EXTENSION is moved out of the switch(cmd) as it is
> quite special anyway - it is the only ioctl() called when neither
> container nor container->mm is initialized.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> Changes:
> v4:
> * added check for container->mm!=3Dcurrent->mm in tce_iommu_ioctl()
> for all ioctls and removed other redundand checks
> ---
>  drivers/vfio/vfio_iommu_spapr_tce.c | 131 ++++++++++++++++++------------=
------
>  1 file changed, 66 insertions(+), 65 deletions(-)
>=20
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iomm=
u_spapr_tce.c
> index d0c38b2..81ab93f 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -31,49 +31,46 @@
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
> -
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
> +	if (!npages)
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
> @@ -98,6 +95,7 @@ struct tce_container {
>  	bool enabled;
>  	bool v2;
>  	unsigned long locked_pages;
> +	struct mm_struct *mm;
>  	struct iommu_table *tables[IOMMU_TABLE_GROUP_MAX_TABLES];
>  	struct list_head group_list;
>  };
> @@ -107,17 +105,14 @@ static long tce_iommu_unregister_pages(struct tce_c=
ontainer *container,
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
> @@ -127,14 +122,11 @@ static long tce_iommu_register_pages(struct tce_con=
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
> @@ -143,7 +135,8 @@ static long tce_iommu_register_pages(struct tce_conta=
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
> @@ -152,13 +145,13 @@ static long tce_iommu_userspace_view_alloc(struct i=
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
> @@ -166,7 +159,8 @@ static long tce_iommu_userspace_view_alloc(struct iom=
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
> @@ -176,7 +170,7 @@ static void tce_iommu_userspace_view_free(struct iomm=
u_table *tbl)
> =20
>  	vfree(tbl->it_userspace);
>  	tbl->it_userspace =3D NULL;
> -	decrement_locked_vm(cb >> PAGE_SHIFT);
> +	decrement_locked_vm(mm, cb >> PAGE_SHIFT);
>  }
> =20
>  static bool tce_page_is_contained(struct page *page, unsigned page_shift)
> @@ -236,9 +230,6 @@ static int tce_iommu_enable(struct tce_container *con=
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
> @@ -284,7 +275,7 @@ static int tce_iommu_enable(struct tce_container *con=
tainer)
>  		return -EPERM;
> =20
>  	locked =3D table_group->tce32_size >> PAGE_SHIFT;
> -	ret =3D try_increment_locked_vm(locked);
> +	ret =3D try_increment_locked_vm(container->mm, locked);
>  	if (ret)
>  		return ret;
> =20
> @@ -302,10 +293,7 @@ static void tce_iommu_disable(struct tce_container *=
container)
> =20
>  	container->enabled =3D false;
> =20
> -	if (!current->mm)
> -		return;
> -
> -	decrement_locked_vm(container->locked_pages);
> +	decrement_locked_vm(container->mm, container->locked_pages);
>  }
> =20
>  static void *tce_iommu_open(unsigned long arg)
> @@ -326,13 +314,18 @@ static void *tce_iommu_open(unsigned long arg)
> =20
>  	container->v2 =3D arg =3D=3D VFIO_SPAPR_TCE_v2_IOMMU;
> =20
> +	/* current->mm cannot be NULL in this context */
> +	container->mm =3D current->mm;
> +	atomic_inc(&container->mm->mm_count);
> +
>  	return container;
>  }
> =20
>  static int tce_iommu_clear(struct tce_container *container,
>  		struct iommu_table *tbl,
>  		unsigned long entry, unsigned long pages);
> -static void tce_iommu_free_table(struct iommu_table *tbl);
> +static void tce_iommu_free_table(struct tce_container *container,
> +		struct iommu_table *tbl);
> =20
>  static void tce_iommu_release(void *iommu_data)
>  {
> @@ -357,10 +350,11 @@ static void tce_iommu_release(void *iommu_data)
>  			continue;
> =20
>  		tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
> -		tce_iommu_free_table(tbl);
> +		tce_iommu_free_table(container, tbl);
>  	}
> =20
>  	tce_iommu_disable(container);
> +	mmdrop(container->mm);
>  	mutex_destroy(&container->lock);
> =20
>  	kfree(container);
> @@ -375,13 +369,14 @@ static void tce_iommu_unuse_page(struct tce_contain=
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
> @@ -394,18 +389,18 @@ static int tce_iommu_prereg_ua_to_hpa(unsigned long=
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
> @@ -435,7 +430,7 @@ static int tce_iommu_clear(struct tce_container *cont=
ainer,
>  			continue;
> =20
>  		if (container->v2) {
> -			tce_iommu_unuse_page_v2(tbl, entry);
> +			tce_iommu_unuse_page_v2(container, tbl, entry);
>  			continue;
>  		}
> =20
> @@ -520,8 +515,8 @@ static long tce_iommu_build_v2(struct tce_container *=
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
> @@ -542,7 +537,7 @@ static long tce_iommu_build_v2(struct tce_container *=
container,
>  		ret =3D iommu_tce_xchg(tbl, entry + i, &hpa, &dirtmp);
>  		if (ret) {
>  			/* dirtmp cannot be DMA_NONE here */
> -			tce_iommu_unuse_page_v2(tbl, entry + i);
> +			tce_iommu_unuse_page_v2(container, tbl, entry + i);
>  			pr_err("iommu_tce: %s failed ioba=3D%lx, tce=3D%lx, ret=3D%ld\n",
>  					__func__, entry << tbl->it_page_shift,
>  					tce, ret);
> @@ -550,7 +545,7 @@ static long tce_iommu_build_v2(struct tce_container *=
container,
>  		}
> =20
>  		if (dirtmp !=3D DMA_NONE)
> -			tce_iommu_unuse_page_v2(tbl, entry + i);
> +			tce_iommu_unuse_page_v2(container, tbl, entry + i);
> =20
>  		*pua =3D tce;
> =20
> @@ -578,7 +573,7 @@ static long tce_iommu_create_table(struct tce_contain=
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
> @@ -589,24 +584,25 @@ static long tce_iommu_create_table(struct tce_conta=
iner *container,
>  	WARN_ON(!ret && ((*ptbl)->it_allocated_size !=3D table_size));
> =20
>  	if (!ret && container->v2) {
> -		ret =3D tce_iommu_userspace_view_alloc(*ptbl);
> +		ret =3D tce_iommu_userspace_view_alloc(*ptbl, container->mm);
>  		if (ret)
>  			(*ptbl)->it_ops->free(*ptbl);
>  	}
> =20
>  	if (ret)
> -		decrement_locked_vm(table_size >> PAGE_SHIFT);
> +		decrement_locked_vm(container->mm, table_size >> PAGE_SHIFT);
> =20
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
> @@ -669,7 +665,7 @@ static long tce_iommu_create_window(struct tce_contai=
ner *container,
>  		table_group =3D iommu_group_get_iommudata(tcegrp->grp);
>  		table_group->ops->unset_window(table_group, num);
>  	}
> -	tce_iommu_free_table(tbl);
> +	tce_iommu_free_table(container, tbl);
> =20
>  	return ret;
>  }
> @@ -707,7 +703,7 @@ static long tce_iommu_remove_window(struct tce_contai=
ner *container,
> =20
>  	/* Free table */
>  	tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
> -	tce_iommu_free_table(tbl);
> +	tce_iommu_free_table(container, tbl);
>  	container->tables[num] =3D NULL;
> =20
>  	return 0;
> @@ -720,8 +716,7 @@ static long tce_iommu_ioctl(void *iommu_data,
>  	unsigned long minsz, ddwsz;
>  	long ret;
> =20
> -	switch (cmd) {
> -	case VFIO_CHECK_EXTENSION:
> +	if (cmd =3D=3D VFIO_CHECK_EXTENSION) {
>  		switch (arg) {
>  		case VFIO_SPAPR_TCE_IOMMU:
>  		case VFIO_SPAPR_TCE_v2_IOMMU:
> @@ -733,7 +728,13 @@ static long tce_iommu_ioctl(void *iommu_data,
>  		}
> =20
>  		return (ret < 0) ? 0 : ret;
> +	}
> =20
> +	/* tce_iommu_open() initializes container->mm so it can't be NULL here =
*/
> +	if (container->mm !=3D current->mm)
> +		return -ESRCH;
> +
> +	switch (cmd) {
>  	case VFIO_IOMMU_SPAPR_TCE_GET_INFO: {
>  		struct vfio_iommu_spapr_tce_info info;
>  		struct tce_iommu_group *tcegrp;
> @@ -1049,7 +1050,7 @@ static void tce_iommu_release_ownership(struct tce_=
container *container,
>  			continue;
> =20
>  		tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
> -		tce_iommu_userspace_view_free(tbl);
> +		tce_iommu_userspace_view_free(tbl, container->mm);
>  		if (tbl->it_map)
>  			iommu_release_ownership(tbl);
> =20
> @@ -1068,7 +1069,7 @@ static int tce_iommu_take_ownership(struct tce_cont=
ainer *container,
>  		if (!tbl || !tbl->it_map)
>  			continue;
> =20
> -		rc =3D tce_iommu_userspace_view_alloc(tbl);
> +		rc =3D tce_iommu_userspace_view_alloc(tbl, container->mm);
>  		if (!rc)
>  			rc =3D iommu_take_ownership(tbl);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--F4+N/OgRSdC8YnqX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYIUeYAAoJEGw4ysog2bOSkrYP/0TbajkYLkw5UBi5f6erzqGY
U2pK92QR9H5SSDSIO5qeK+5d+0AzZoQeLwsq9Pacg3PObLxAXEJw/qYJAhvKVA5l
Y2Far/itZhQ8DXXtUd0Q/diog60IVpTWR88vwjMrGtknVhSqXYo04rSFJCU2htZ9
rmwjDcFMON9nSI/RbarnyacDTqqtwui0dxNDQOW9MGiSQOc1evqcXmG5pg8ZbpID
Shb009P6Sma8VbXQ2nqn+k2gYGVlkoLq/9HSXwxTjVMJvFsEAuGKA1EU4+hkifl9
ohQqRdHCG2lqfLP2baY3qx/DgNt4l5JRBBfSPAM1Lc+ftxcP0QoKrULKHEn1/rQz
GWlv7GXDQcl+PDp/iDzRlMWxuKwV530lWzO+WwWMxt+XbfuCGVt534AH+XzcMQ0r
dzHMdrToVD2eI9EWXq3/7JXiSdP8SPxb4Z7hGUefJ9KV+CzvtMFocqwKj+wnu26G
SAbqdrnd6Fvz28jOB9W6fHynE5mFLlDuEZGyo56NZ9brEs8bJpjfJ/egDla9/wqd
xScFvbRRJVHVppWfSw16wn7kyM1x2tFUtQ0HqAewQncfAjwCy0sYmfa5Kn19O7UN
m2lAYamjXGyqqjSMlEVbsOHbU8Ungi2O6Zmf49tlQCXgiaahRbEla7tavldICVfz
dEZymahJhLDhmHw9Rm25
=MZ8z
-----END PGP SIGNATURE-----

--F4+N/OgRSdC8YnqX--
