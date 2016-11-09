Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tD6tX4PcVzDvPj
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2016 11:46:12 +1100 (AEDT)
Date: Wed, 9 Nov 2016 11:46:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH kernel v4 3/4] vfio/spapr: Reference mm in tce_container
Message-ID: <20161109004603.GA28688@umbus.fritz.box>
References: <1477291990-2872-1-git-send-email-aik@ozlabs.ru>
 <1477291990-2872-4-git-send-email-aik@ozlabs.ru>
 <20161108152519.7bfadf32@t450s.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+9kyDs7IugQ0lHaC"
In-Reply-To: <20161108152519.7bfadf32@t450s.home>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--+9kyDs7IugQ0lHaC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 08, 2016 at 03:25:19PM -0700, Alex Williamson wrote:
> On Mon, 24 Oct 2016 17:53:09 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>=20
> > In some situations the userspace memory context may live longer than
> > the userspace process itself so if we need to do proper memory context
> > cleanup, we better have tce_container take a reference to mm_struct and
> > use it later when the process is gone (@current or @current->mm is NULL=
).
> >=20
> > This references mm and stores the pointer in the container; this is done
> > when a container is just created so checking for !current->mm in other
> > places becomes pointless.
> >=20
> > This replaces current->mm with container->mm everywhere except debug
> > prints.
> >=20
> > This adds a check that current->mm is the same as the one stored in
> > the container to prevent userspace from making changes to a memory
> > context of other processes; in order to add this check,
> > VFIO_CHECK_EXTENSION is moved out of the switch(cmd) as it is
> > quite special anyway - it is the only ioctl() called when neither
> > container nor container->mm is initialized.
> >=20
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > ---
> > Changes:
> > v4:
> > * added check for container->mm!=3Dcurrent->mm in tce_iommu_ioctl()
> > for all ioctls and removed other redundand checks
> > ---
> >  drivers/vfio/vfio_iommu_spapr_tce.c | 131 ++++++++++++++++++----------=
--------
> >  1 file changed, 66 insertions(+), 65 deletions(-)
> >=20
> > diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_io=
mmu_spapr_tce.c
> > index d0c38b2..81ab93f 100644
> > --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> > +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> > @@ -31,49 +31,46 @@
> >  static void tce_iommu_detach_group(void *iommu_data,
> >  		struct iommu_group *iommu_group);
> > =20
> > -static long try_increment_locked_vm(long npages)
> > +static long try_increment_locked_vm(struct mm_struct *mm, long npages)
> >  {
> >  	long ret =3D 0, locked, lock_limit;
> > =20
> > -	if (!current || !current->mm)
> > -		return -ESRCH; /* process exited */
> > -
> >  	if (!npages)
> >  		return 0;
> > =20
> > -	down_write(&current->mm->mmap_sem);
> > -	locked =3D current->mm->locked_vm + npages;
> > +	down_write(&mm->mmap_sem);
> > +	locked =3D mm->locked_vm + npages;
> >  	lock_limit =3D rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> >  	if (locked > lock_limit && !capable(CAP_IPC_LOCK))
> >  		ret =3D -ENOMEM;
> >  	else
> > -		current->mm->locked_vm +=3D npages;
> > +		mm->locked_vm +=3D npages;
> > =20
> >  	pr_debug("[%d] RLIMIT_MEMLOCK +%ld %ld/%ld%s\n", current->pid,
> >  			npages << PAGE_SHIFT,
> > -			current->mm->locked_vm << PAGE_SHIFT,
> > +			mm->locked_vm << PAGE_SHIFT,
> >  			rlimit(RLIMIT_MEMLOCK),
> >  			ret ? " - exceeded" : "");
> > =20
> > -	up_write(&current->mm->mmap_sem);
> > +	up_write(&mm->mmap_sem);
> > =20
> >  	return ret;
> >  }
> > =20
> > -static void decrement_locked_vm(long npages)
> > +static void decrement_locked_vm(struct mm_struct *mm, long npages)
> >  {
> > -	if (!current || !current->mm || !npages)
> > -		return; /* process exited */
> > +	if (!npages)
> > +		return;
> > =20
> > -	down_write(&current->mm->mmap_sem);
> > -	if (WARN_ON_ONCE(npages > current->mm->locked_vm))
> > -		npages =3D current->mm->locked_vm;
> > -	current->mm->locked_vm -=3D npages;
> > +	down_write(&mm->mmap_sem);
> > +	if (WARN_ON_ONCE(npages > mm->locked_vm))
> > +		npages =3D mm->locked_vm;
> > +	mm->locked_vm -=3D npages;
> >  	pr_debug("[%d] RLIMIT_MEMLOCK -%ld %ld/%ld\n", current->pid,
> >  			npages << PAGE_SHIFT,
> > -			current->mm->locked_vm << PAGE_SHIFT,
> > +			mm->locked_vm << PAGE_SHIFT,
> >  			rlimit(RLIMIT_MEMLOCK));
> > -	up_write(&current->mm->mmap_sem);
> > +	up_write(&mm->mmap_sem);
> >  }
> > =20
> >  /*
> > @@ -98,6 +95,7 @@ struct tce_container {
> >  	bool enabled;
> >  	bool v2;
> >  	unsigned long locked_pages;
> > +	struct mm_struct *mm;
> >  	struct iommu_table *tables[IOMMU_TABLE_GROUP_MAX_TABLES];
> >  	struct list_head group_list;
> >  };
> > @@ -107,17 +105,14 @@ static long tce_iommu_unregister_pages(struct tce=
_container *container,
> >  {
> >  	struct mm_iommu_table_group_mem_t *mem;
> > =20
> > -	if (!current || !current->mm)
> > -		return -ESRCH; /* process exited */
> > -
> >  	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK))
> >  		return -EINVAL;
> > =20
> > -	mem =3D mm_iommu_find(current->mm, vaddr, size >> PAGE_SHIFT);
> > +	mem =3D mm_iommu_find(container->mm, vaddr, size >> PAGE_SHIFT);
> >  	if (!mem)
> >  		return -ENOENT;
> > =20
> > -	return mm_iommu_put(current->mm, mem);
> > +	return mm_iommu_put(container->mm, mem);
> >  }
> > =20
> >  static long tce_iommu_register_pages(struct tce_container *container,
> > @@ -127,14 +122,11 @@ static long tce_iommu_register_pages(struct tce_c=
ontainer *container,
> >  	struct mm_iommu_table_group_mem_t *mem =3D NULL;
> >  	unsigned long entries =3D size >> PAGE_SHIFT;
> > =20
> > -	if (!current || !current->mm)
> > -		return -ESRCH; /* process exited */
> > -
> >  	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK) ||
> >  			((vaddr + size) < vaddr))
> >  		return -EINVAL;
> > =20
> > -	ret =3D mm_iommu_get(current->mm, vaddr, entries, &mem);
> > +	ret =3D mm_iommu_get(container->mm, vaddr, entries, &mem);
> >  	if (ret)
> >  		return ret;
> > =20
> > @@ -143,7 +135,8 @@ static long tce_iommu_register_pages(struct tce_con=
tainer *container,
> >  	return 0;
> >  }
> > =20
> > -static long tce_iommu_userspace_view_alloc(struct iommu_table *tbl)
> > +static long tce_iommu_userspace_view_alloc(struct iommu_table *tbl,
> > +		struct mm_struct *mm)
> >  {
> >  	unsigned long cb =3D _ALIGN_UP(sizeof(tbl->it_userspace[0]) *
> >  			tbl->it_size, PAGE_SIZE);
> > @@ -152,13 +145,13 @@ static long tce_iommu_userspace_view_alloc(struct=
 iommu_table *tbl)
> > =20
> >  	BUG_ON(tbl->it_userspace);
> > =20
> > -	ret =3D try_increment_locked_vm(cb >> PAGE_SHIFT);
> > +	ret =3D try_increment_locked_vm(mm, cb >> PAGE_SHIFT);
> >  	if (ret)
> >  		return ret;
> > =20
> >  	uas =3D vzalloc(cb);
> >  	if (!uas) {
> > -		decrement_locked_vm(cb >> PAGE_SHIFT);
> > +		decrement_locked_vm(mm, cb >> PAGE_SHIFT);
> >  		return -ENOMEM;
> >  	}
> >  	tbl->it_userspace =3D uas;
> > @@ -166,7 +159,8 @@ static long tce_iommu_userspace_view_alloc(struct i=
ommu_table *tbl)
> >  	return 0;
> >  }
> > =20
> > -static void tce_iommu_userspace_view_free(struct iommu_table *tbl)
> > +static void tce_iommu_userspace_view_free(struct iommu_table *tbl,
> > +		struct mm_struct *mm)
> >  {
> >  	unsigned long cb =3D _ALIGN_UP(sizeof(tbl->it_userspace[0]) *
> >  			tbl->it_size, PAGE_SIZE);
> > @@ -176,7 +170,7 @@ static void tce_iommu_userspace_view_free(struct io=
mmu_table *tbl)
> > =20
> >  	vfree(tbl->it_userspace);
> >  	tbl->it_userspace =3D NULL;
> > -	decrement_locked_vm(cb >> PAGE_SHIFT);
> > +	decrement_locked_vm(mm, cb >> PAGE_SHIFT);
> >  }
> > =20
> >  static bool tce_page_is_contained(struct page *page, unsigned page_shi=
ft)
> > @@ -236,9 +230,6 @@ static int tce_iommu_enable(struct tce_container *c=
ontainer)
> >  	struct iommu_table_group *table_group;
> >  	struct tce_iommu_group *tcegrp;
> > =20
> > -	if (!current->mm)
> > -		return -ESRCH; /* process exited */
> > -
> >  	if (container->enabled)
> >  		return -EBUSY;
> > =20
> > @@ -284,7 +275,7 @@ static int tce_iommu_enable(struct tce_container *c=
ontainer)
> >  		return -EPERM;
> > =20
> >  	locked =3D table_group->tce32_size >> PAGE_SHIFT;
> > -	ret =3D try_increment_locked_vm(locked);
> > +	ret =3D try_increment_locked_vm(container->mm, locked);
> >  	if (ret)
> >  		return ret;
> > =20
> > @@ -302,10 +293,7 @@ static void tce_iommu_disable(struct tce_container=
 *container)
> > =20
> >  	container->enabled =3D false;
> > =20
> > -	if (!current->mm)
> > -		return;
> > -
> > -	decrement_locked_vm(container->locked_pages);
> > +	decrement_locked_vm(container->mm, container->locked_pages);
> >  }
> > =20
> >  static void *tce_iommu_open(unsigned long arg)
> > @@ -326,13 +314,18 @@ static void *tce_iommu_open(unsigned long arg)
> > =20
> >  	container->v2 =3D arg =3D=3D VFIO_SPAPR_TCE_v2_IOMMU;
> > =20
> > +	/* current->mm cannot be NULL in this context */
> > +	container->mm =3D current->mm;
> > +	atomic_inc(&container->mm->mm_count);
>=20
> Are you sure you wouldn't rather do this on the actual
> preregistration?  The advise I gave to Kirti for mdev was that it's
> currently possible to have a configuration where a privileged user
> opens a container, adds a group, sets the iommu, and then passes the
> file descriptors to another user.  We can then set an mm once mappings,
> or preregistration occurs, and from there require that the unmapping mm
> matches the mapping mm, or that both of those match the preregistration
> mm.  I'm not sure I see any reason to impose that current->mm that
> performs this operation is the only one that's allowed to perform those
> later tasks.
>=20
> > +
> >  	return container;
> >  }
> > =20
> >  static int tce_iommu_clear(struct tce_container *container,
> >  		struct iommu_table *tbl,
> >  		unsigned long entry, unsigned long pages);
> > -static void tce_iommu_free_table(struct iommu_table *tbl);
> > +static void tce_iommu_free_table(struct tce_container *container,
> > +		struct iommu_table *tbl);
> > =20
> >  static void tce_iommu_release(void *iommu_data)
> >  {
> > @@ -357,10 +350,11 @@ static void tce_iommu_release(void *iommu_data)
> >  			continue;
> > =20
> >  		tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
> > -		tce_iommu_free_table(tbl);
> > +		tce_iommu_free_table(container, tbl);
> >  	}
> > =20
> >  	tce_iommu_disable(container);
> > +	mmdrop(container->mm);
>=20
> I imagine you'd still do this here, just:
>=20
> 	if (container->mm)
> 		mmdrop(container->mm);
>=20
> Of course you'd need to check how many places you'd need similar
> tests, maybe some of the current->mm tests would be converted to
> container->mm rather than dropped.  Thanks,

Right, as you've implied here, the advantage of locking the mm on open
is simplicity - open always happens, and it always happens before
anything else, so there's no conditionals about whether we have or
haven't set the mm yet.

That said, you have just described a plausible use case where it's
useful to have one mm open the container, then another one use it, so
it might be worth adding that ability.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--+9kyDs7IugQ0lHaC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYInHLAAoJEGw4ysog2bOSjnMQAM04YokOjrgI+EX1mWu8BzNq
XC4UZeYkNnhn6svxveektRVvKucyu/KhudnE9iFRfVRu7g14o5EZBsHeHLK1AW06
wjn4dqbMlfjln79YnwO16hTe1dATpXZD0FvlZkYhB4DNtLunajybSYLkGixJRCUn
3C3VfvJ6nzOAYELPO/YAq8U04PUUIj++VAoKf6cpmGDhKRJAxINNLr++02o87PHU
UuN8+0hFHE8EO5p1fAK7+C48hrVwJqnNActrFx6MmQInv58A2ifdFrsi8biXBIhP
S9O95N4rVwfyniVwgYKrhA3AwlTiYsMJWjtxsSghdM/3ROvLIv/bAX69ZHXKGYGN
3aKQGPlfo1nM81zDAlkh4phs3CxG0Gwmfs+KnwM7sgYkw64p9HotIh3RMgnSHeak
XTcZEVQdN1ZV60zvs6JswIHev46czs9IXoV1HG4RscgQOUiOZQJSbCFQwUzvKwAT
23YA+5ahhOzlWIS6uNn/cnAVVtjHojZuMa8PNF6SVXbJgYl0u/BiwtxcCAYtDUsU
L3UT7XraHW8os/zddKlgvETkKHfr5oGLhMyZ0/pu8XsVj+lWWWXgL5c0s54DI/mX
xtrjklS5HSe7jJIKiDU/PYfg4G28BJigU/NGyd0m3vcj13H5+4+HH8tCoZMvJBEo
OXguzgjfIFa+j3hsqpnv
=GEfg
-----END PGP SIGNATURE-----

--+9kyDs7IugQ0lHaC--
