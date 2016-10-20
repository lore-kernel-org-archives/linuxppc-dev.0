Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t0QQZ3sNJzDvYB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 10:44:54 +1100 (AEDT)
Date: Fri, 21 Oct 2016 10:18:05 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org
Subject: Re: [PATCH kernel v3 2/4] powerpc/iommu: Stop using @current in
 mm_iommu_xxx
Message-ID: <20161020231805.GQ11140@umbus.fritz.box>
References: <1476932630-45323-1-git-send-email-aik@ozlabs.ru>
 <1476932630-45323-3-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mzmkN2k+aDjaU9Rr"
In-Reply-To: <1476932630-45323-3-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--mzmkN2k+aDjaU9Rr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 20, 2016 at 02:03:48PM +1100, Alexey Kardashevskiy wrote:
> This changes mm_iommu_xxx helpers to take mm_struct as a parameter
> instead of getting it from @current which in some situations may
> not have a valid reference to mm.
>=20
> This changes helpers to receive @mm and moves all references to @current
> to the caller, including checks for !current and !current->mm;
> checks in mm_iommu_preregistered() are removed as there is no caller
> yet.
>=20
> This moves the mm_iommu_adjust_locked_vm() call to the caller as
> it receives mm_iommu_table_group_mem_t but it needs mm.
>=20
> This should cause no behavioral change.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/include/asm/mmu_context.h | 16 ++++++------
>  arch/powerpc/mm/mmu_context_iommu.c    | 46 +++++++++++++---------------=
------
>  drivers/vfio/vfio_iommu_spapr_tce.c    | 14 ++++++++---
>  3 files changed, 36 insertions(+), 40 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/includ=
e/asm/mmu_context.h
> index 424844b..b9e3f0a 100644
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
> +extern long mm_iommu_put(struct mm_struct *mm,
> +		struct mm_iommu_table_group_mem_t *mem);
>  extern void mm_iommu_init(struct mm_struct *mm);
>  extern void mm_iommu_cleanup(struct mm_struct *mm);
> -extern struct mm_iommu_table_group_mem_t *mm_iommu_lookup(unsigned long =
ua,
> -		unsigned long size);
> -extern struct mm_iommu_table_group_mem_t *mm_iommu_find(unsigned long ua,
> -		unsigned long entries);
> +extern struct mm_iommu_table_group_mem_t *mm_iommu_lookup(struct mm_stru=
ct *mm,
> +		unsigned long ua, unsigned long size);
> +extern struct mm_iommu_table_group_mem_t *mm_iommu_find(struct mm_struct=
 *mm,
> +		unsigned long ua, unsigned long entries);
>  extern long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem,
>  		unsigned long ua, unsigned long *hpa);
>  extern long mm_iommu_mapped_inc(struct mm_iommu_table_group_mem_t *mem);
> diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_co=
ntext_iommu.c
> index ad2e575..4c6db09 100644
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
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iomm=
u_spapr_tce.c
> index 80378dd..d0c38b2 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -107,14 +107,17 @@ static long tce_iommu_unregister_pages(struct tce_c=
ontainer *container,
>  {
>  	struct mm_iommu_table_group_mem_t *mem;
> =20
> +	if (!current || !current->mm)
> +		return -ESRCH; /* process exited */
> +
>  	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK))
>  		return -EINVAL;
> =20
> -	mem =3D mm_iommu_find(vaddr, size >> PAGE_SHIFT);
> +	mem =3D mm_iommu_find(current->mm, vaddr, size >> PAGE_SHIFT);
>  	if (!mem)
>  		return -ENOENT;
> =20
> -	return mm_iommu_put(mem);
> +	return mm_iommu_put(current->mm, mem);
>  }
> =20
>  static long tce_iommu_register_pages(struct tce_container *container,
> @@ -124,11 +127,14 @@ static long tce_iommu_register_pages(struct tce_con=
tainer *container,
>  	struct mm_iommu_table_group_mem_t *mem =3D NULL;
>  	unsigned long entries =3D size >> PAGE_SHIFT;
> =20
> +	if (!current || !current->mm)
> +		return -ESRCH; /* process exited */
> +
>  	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK) ||
>  			((vaddr + size) < vaddr))
>  		return -EINVAL;
> =20
> -	ret =3D mm_iommu_get(vaddr, entries, &mem);
> +	ret =3D mm_iommu_get(current->mm, vaddr, entries, &mem);
>  	if (ret)
>  		return ret;
> =20
> @@ -375,7 +381,7 @@ static int tce_iommu_prereg_ua_to_hpa(unsigned long t=
ce, unsigned long size,
>  	long ret =3D 0;
>  	struct mm_iommu_table_group_mem_t *mem;
> =20
> -	mem =3D mm_iommu_lookup(tce, size);
> +	mem =3D mm_iommu_lookup(current->mm, tce, size);
>  	if (!mem)
>  		return -EINVAL;
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mzmkN2k+aDjaU9Rr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYCVCtAAoJEGw4ysog2bOSkNMQANRpnWjzpkn9Q+U7TjiCduo7
2lLfwCtxIE/LzRMDdadX6ztOwGhdW5ZgDKxHuZys70giLzL3UmZHksh92qffquZp
VDpssvXBJz8tKFjv4uCXVVgDEH/qLsixzi/RFccbACA5sRy3eflivS/5qm1ZumyB
kFCXO4l1rUuF6ca3gzxywA3XpQi4bBveiWPkQ3gXX6fn/t94izkknUR14gcLOn6h
xOF+WO6gw5Ow2lU6DsWse/Vzd0eD32qTlVh94l5ZyiWKBp2BVh+ME1QS4es7mIb5
q3tFbahD+LH/rwDyUHWynxeUHeOC3fkAKXAcn5YBP0h9jU3Dku6oE6m8VpNM6N8h
wmKt4ucR9ldufh8ifVxEXWraCHalxnDYy6Yj8dp4FRgxwVhaf7bb/bfK3BJm9TdN
IR6/S9NA5uwoqocAHfi7qEml51TSlpc/U0WTddo4rBKowJktPSVvdF32Cyqwtwgo
0NS63T2wpe9tIYqwcp6oYyiNds4h06qghFIq5r4hHxzqLFQSjnTtIAHqKl33E4PK
7DVrvsJ9ufCILq07rGmQxlu8eFoLfh/DD+TfzATrio//sST73Rc2Dgi8AlBhRtez
OHYVDw2E2kF+A/FBvB9cd2+G/4BQfyjDl7jaemGlFL2Dvr/exBpDBhNjFKmh45gA
8JoK7mQ7sjAjYEmCxhPv
=giy4
-----END PGP SIGNATURE-----

--mzmkN2k+aDjaU9Rr--
