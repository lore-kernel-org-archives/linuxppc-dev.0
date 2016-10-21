Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t0SXG4fNnzDvYW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 12:19:58 +1100 (AEDT)
Date: Fri, 21 Oct 2016 11:25:27 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org
Subject: Re: [PATCH kernel v3 3/4] vfio/spapr: Cache mm in tce_container
Message-ID: <20161021002527.GT11140@umbus.fritz.box>
References: <1476932630-45323-1-git-send-email-aik@ozlabs.ru>
 <1476932630-45323-4-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FT/vNgDLxVq4t/AU"
In-Reply-To: <1476932630-45323-4-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--FT/vNgDLxVq4t/AU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 20, 2016 at 02:03:49PM +1100, Alexey Kardashevskiy wrote:
> In some situations the userspace memory context may live longer than
> the userspace process itself so if we need to do proper memory context
> cleanup, we better cache @mm and use it later when the process is gone
> (@current or @current->mm is NULL).
>=20
> This references mm and stores the pointer in the container; this is done
> when a container is just created so checking for !current->mm in other
> places becomes pointless.
>=20
> This replaces current->mm with container->mm everywhere except debug
> prints.
>=20
> This adds a check that current->mm is the same as the one stored in
> the container to prevent userspace from registering memory in other
> processes.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  drivers/vfio/vfio_iommu_spapr_tce.c | 127 ++++++++++++++++++++----------=
------
>  1 file changed, 71 insertions(+), 56 deletions(-)
>=20
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iomm=
u_spapr_tce.c
> index d0c38b2..6b0b121 100644
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
> +	if (!mm || !npages)
>  		return; /* process exited */
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
> @@ -113,11 +111,11 @@ static long tce_iommu_unregister_pages(struct tce_c=
ontainer *container,
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
> @@ -134,7 +132,7 @@ static long tce_iommu_register_pages(struct tce_conta=
iner *container,
>  			((vaddr + size) < vaddr))
>  		return -EINVAL;
> =20
> -	ret =3D mm_iommu_get(current->mm, vaddr, entries, &mem);
> +	ret =3D mm_iommu_get(container->mm, vaddr, entries, &mem);
>  	if (ret)
>  		return ret;
> =20
> @@ -143,7 +141,8 @@ static long tce_iommu_register_pages(struct tce_conta=
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
> @@ -152,13 +151,13 @@ static long tce_iommu_userspace_view_alloc(struct i=
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
> @@ -166,7 +165,8 @@ static long tce_iommu_userspace_view_alloc(struct iom=
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
> @@ -176,7 +176,7 @@ static void tce_iommu_userspace_view_free(struct iomm=
u_table *tbl)
> =20
>  	vfree(tbl->it_userspace);
>  	tbl->it_userspace =3D NULL;
> -	decrement_locked_vm(cb >> PAGE_SHIFT);
> +	decrement_locked_vm(mm, cb >> PAGE_SHIFT);
>  }
> =20
>  static bool tce_page_is_contained(struct page *page, unsigned page_shift)
> @@ -236,9 +236,6 @@ static int tce_iommu_enable(struct tce_container *con=
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
> @@ -284,7 +281,7 @@ static int tce_iommu_enable(struct tce_container *con=
tainer)
>  		return -EPERM;
> =20
>  	locked =3D table_group->tce32_size >> PAGE_SHIFT;
> -	ret =3D try_increment_locked_vm(locked);
> +	ret =3D try_increment_locked_vm(container->mm, locked);
>  	if (ret)
>  		return ret;
> =20
> @@ -302,10 +299,7 @@ static void tce_iommu_disable(struct tce_container *=
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
> @@ -317,6 +311,9 @@ static void *tce_iommu_open(unsigned long arg)
>  		return ERR_PTR(-EINVAL);
>  	}
> =20
> +	if (!current->mm)
> +		return ERR_PTR(-ESRCH); /* process exited */
> +
>  	container =3D kzalloc(sizeof(*container), GFP_KERNEL);
>  	if (!container)
>  		return ERR_PTR(-ENOMEM);
> @@ -326,13 +323,17 @@ static void *tce_iommu_open(unsigned long arg)
> =20
>  	container->v2 =3D arg =3D=3D VFIO_SPAPR_TCE_v2_IOMMU;
> =20
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
> @@ -357,10 +358,19 @@ static void tce_iommu_release(void *iommu_data)
>  			continue;
> =20
>  		tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
> -		tce_iommu_free_table(tbl);
> +		tce_iommu_free_table(container, tbl);
> +	}
> +
> +	while (!list_empty(&container->prereg_list)) {

Uuh.. I think this breaks bisection.  The container->prereg_list is
only added in the next patch.

> +		struct tce_iommu_prereg *tcemem;
> +
> +		tcemem =3D list_first_entry(&container->prereg_list,
> +				struct tce_iommu_prereg, next);
> +		tce_iommu_prereg_free(container, tcemem);
>  	}
> =20
>  	tce_iommu_disable(container);
> +	mmdrop(container->mm);
>  	mutex_destroy(&container->lock);
> =20
>  	kfree(container);
> @@ -375,13 +385,14 @@ static void tce_iommu_unuse_page(struct tce_contain=
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
> @@ -394,18 +405,18 @@ static int tce_iommu_prereg_ua_to_hpa(unsigned long=
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
> @@ -435,7 +446,7 @@ static int tce_iommu_clear(struct tce_container *cont=
ainer,
>  			continue;
> =20
>  		if (container->v2) {
> -			tce_iommu_unuse_page_v2(tbl, entry);
> +			tce_iommu_unuse_page_v2(container, tbl, entry);
>  			continue;
>  		}
> =20
> @@ -515,13 +526,16 @@ static long tce_iommu_build_v2(struct tce_container=
 *container,
>  	unsigned long hpa;
>  	enum dma_data_direction dirtmp;
> =20
> +	if (container->mm !=3D current->mm)
> +		return -ESRCH;
> +
>  	for (i =3D 0; i < pages; ++i) {
>  		struct mm_iommu_table_group_mem_t *mem =3D NULL;
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
> @@ -542,7 +556,7 @@ static long tce_iommu_build_v2(struct tce_container *=
container,
>  		ret =3D iommu_tce_xchg(tbl, entry + i, &hpa, &dirtmp);
>  		if (ret) {
>  			/* dirtmp cannot be DMA_NONE here */
> -			tce_iommu_unuse_page_v2(tbl, entry + i);
> +			tce_iommu_unuse_page_v2(container, tbl, entry + i);
>  			pr_err("iommu_tce: %s failed ioba=3D%lx, tce=3D%lx, ret=3D%ld\n",
>  					__func__, entry << tbl->it_page_shift,
>  					tce, ret);
> @@ -550,7 +564,7 @@ static long tce_iommu_build_v2(struct tce_container *=
container,
>  		}
> =20
>  		if (dirtmp !=3D DMA_NONE)
> -			tce_iommu_unuse_page_v2(tbl, entry + i);
> +			tce_iommu_unuse_page_v2(container, tbl, entry + i);
> =20
>  		*pua =3D tce;
> =20
> @@ -578,7 +592,7 @@ static long tce_iommu_create_table(struct tce_contain=
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
> @@ -589,24 +603,25 @@ static long tce_iommu_create_table(struct tce_conta=
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
> @@ -669,7 +684,7 @@ static long tce_iommu_create_window(struct tce_contai=
ner *container,
>  		table_group =3D iommu_group_get_iommudata(tcegrp->grp);
>  		table_group->ops->unset_window(table_group, num);
>  	}
> -	tce_iommu_free_table(tbl);
> +	tce_iommu_free_table(container, tbl);
> =20
>  	return ret;
>  }
> @@ -707,7 +722,7 @@ static long tce_iommu_remove_window(struct tce_contai=
ner *container,
> =20
>  	/* Free table */
>  	tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
> -	tce_iommu_free_table(tbl);
> +	tce_iommu_free_table(container, tbl);
>  	container->tables[num] =3D NULL;
> =20
>  	return 0;
> @@ -1049,7 +1064,7 @@ static void tce_iommu_release_ownership(struct tce_=
container *container,
>  			continue;
> =20
>  		tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
> -		tce_iommu_userspace_view_free(tbl);
> +		tce_iommu_userspace_view_free(tbl, container->mm);
>  		if (tbl->it_map)
>  			iommu_release_ownership(tbl);
> =20
> @@ -1068,7 +1083,7 @@ static int tce_iommu_take_ownership(struct tce_cont=
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

--FT/vNgDLxVq4t/AU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYCWB3AAoJEGw4ysog2bOSIbUP/13OY5so6Cc52HmCsWzE+q/h
JBTgK0U/37X+v+ao6EnwP9MdW39O7FjQux4iU+ZLeEYx17hLo2sTnUcrW99ZunOR
YNLtiUem9XFg/DljfJfz2mxJBP9uZxN2L7Hs7ZT5tmEgsmqWA7XpttjmH5Ke0C6l
rW48zYR/g2HVPYh/UdatsHmeOgKGg6hcSlKkrXeZ7VcZmcZf1nE/eoUSRtvOdsIt
F8hFxsv99vu5KX1bt3VXUVRv+k4uNvqfSgUSVCPBirC8/bCo6HDrqfsWc35q9BWb
q4R1aLWkcD2zslWEW8QI58oyahJSfzhRa8Re7uwYveleJqrwrH2mCNURaaqL7fUp
Jo27PydTUe3ZjLcM/1ZF6zOnDt3lHsvNym5kUkFR46cK9oBzFkPmcBjMOopb8Vhr
yZcLu3HMbbS/5mkhzniAvT/0vcw6Vr2H6gJZPD+RMoyDHRqFRmaCimkOjsW4d4J6
oYcOruGv9RTiyqJYfvGVvaBY21kLEr5o68gPAJmzVWlPktvBC+yDJ8LBnguS/r4R
8Zn28BVyM6azGQ0ljB2LxBB34Asgm+nCYNcK9KlcnqNFZdASSrxTHurSshxHJGE5
zncedCsKegrsnfoGctGDsjQUlpb3wwXNAwvRFf2YY6b17hPdFgcWR8ZwXa5oeaaG
iYUrM7h/gIhsQ/+5u+n6
=yKkX
-----END PGP SIGNATURE-----

--FT/vNgDLxVq4t/AU--
