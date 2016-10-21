Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t0SXG3FspzDvYG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 12:19:58 +1100 (AEDT)
Date: Fri, 21 Oct 2016 11:21:34 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org
Subject: Re: [PATCH kernel v3 3/4] vfio/spapr: Cache mm in tce_container
Message-ID: <20161021002134.GS11140@umbus.fritz.box>
References: <1476932630-45323-1-git-send-email-aik@ozlabs.ru>
 <1476932630-45323-4-git-send-email-aik@ozlabs.ru>
 <20161020183121.073f01ac@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="szdyR02yM8NCQUEm"
In-Reply-To: <20161020183121.073f01ac@roar.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--szdyR02yM8NCQUEm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 20, 2016 at 06:31:21PM +1100, Nicholas Piggin wrote:
> On Thu, 20 Oct 2016 14:03:49 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>=20
> > In some situations the userspace memory context may live longer than
> > the userspace process itself so if we need to do proper memory context
> > cleanup, we better cache @mm and use it later when the process is gone
> > (@current or @current->mm is NULL).
> >=20
> > This references mm and stores the pointer in the container; this is done
> > when a container is just created so checking for !current->mm in other
> > places becomes pointless.
> >=20
> > This replaces current->mm with container->mm everywhere except debug
> > prints.
> >=20
> > This adds a check that current->mm is the same as the one stored in
> > the container to prevent userspace from registering memory in other
> > processes.
> >=20
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > ---
> >  drivers/vfio/vfio_iommu_spapr_tce.c | 127 ++++++++++++++++++++--------=
--------
> >  1 file changed, 71 insertions(+), 56 deletions(-)
> >=20
> > diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_io=
mmu_spapr_tce.c
> > index d0c38b2..6b0b121 100644
> > --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> > +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> > @@ -31,49 +31,46 @@
>=20
> Does it make sense to move the rest of these hunks into patch 2?
> I think they're similarly just moving the mm reference into callers.
>=20
>=20
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
> > +	if (!mm || !npages)
> >  		return; /* process exited */
>=20
> I know you're trying to be defensive and change as little logic as possib=
le,
> but some cases should be an error, and I think some of the "process exite=
d"
> comments were wrong anyway.
>=20
> Maybe pull the !mm test into the caller and make it WARN_ON?
>=20
>=20
> > @@ -317,6 +311,9 @@ static void *tce_iommu_open(unsigned long arg)
> >  		return ERR_PTR(-EINVAL);
> >  	}
> > =20
> > +	if (!current->mm)
> > +		return ERR_PTR(-ESRCH); /* process exited */
>=20
> A userspace thread in the kernel can't have its mm disappear, unless you
> are actually in the exit code. !current->mm is more like a test for a ker=
nel
> thread.
>=20
>=20
> > +
> >  	container =3D kzalloc(sizeof(*container), GFP_KERNEL);
> >  	if (!container)
> >  		return ERR_PTR(-ENOMEM);
> > @@ -326,13 +323,17 @@ static void *tce_iommu_open(unsigned long arg)
> > =20
> >  	container->v2 =3D arg =3D=3D VFIO_SPAPR_TCE_v2_IOMMU;
> > =20
> > +	container->mm =3D current->mm;
> > +	atomic_inc(&container->mm->mm_count);
> > +
> >  	return container;
>=20
> It's a nitpick if you respin the patch, but I guess it would better be
> described as a reference than a cache of the object. "have tce_container
> take a reference to mm_struct".
>=20
>=20
> > @@ -515,13 +526,16 @@ static long tce_iommu_build_v2(struct tce_contain=
er *container,
> >  	unsigned long hpa;
> >  	enum dma_data_direction dirtmp;
> > =20
> > +	if (container->mm !=3D current->mm)
> > +		return -ESRCH;
>=20
> Good, is this condition now enforced on all entrypoints that use
> container->mm (except the final teardown)? (The mlock/rlimit stuff,
> as we talked about before, doesn't make sense if not).

Right.  I don't know that it's actually dangerous, but i think it
would be needlessly weird for one process to be able to manipulate
another process's mm via the container fd.  So all the entry points
that are directly called from userspace (basically, the ioctl()s)
should verify that current->mm matches container->mm (except the one
which initiallizes container->mm, obviously).

One other concern.  If I follow the logic correctly, if a process
created a container, passed the fd to another process then exited, the
container fd held by the other process would keep the original
process's mm alive indefinitely.  I'm not sure if that's a problem.
Nick?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--szdyR02yM8NCQUEm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYCV+MAAoJEGw4ysog2bOSpZ4QALLcaaN6egLZ79FM/l+efqSV
jiKcj60oYDB66yVAO5ENeluea2Fhs7Kpl6AKSq7qmdqGW4WswjidGpZmC0Y2nkTo
9x3kFckKflxFWPrwXIdHID8bjcvlO8iljgGHmnW2d5nwvCdGbWC8PPMTljp9QEMk
jkeY0yGH0qqgNjKr9TMqJd97cRVt+/sgt+CGfrWd8X2PBqnFNuSmgMpzO2gudRzJ
5CUmlmlvsfqeL8r0SLGENHeKaP+Ob9h52wtTOv7fzSJG2lGpRJgSGis62TGT1Ljy
ZXRIIMPJD4XU8A/ZrhO7o/3K282U9ystXtjAtRCyP5SCNtBt4FsKm0GTMQd+58Yv
MdT3bA0NayvFTkpzr/zWXgZ/et/fBnMr2J32SPaiRUTG3RI16LFN3dp+P8L4b+nK
CwxVcCDKcdYLyBWvx2v7kuDpGjJ31+ZWxjJ28bH099KZeb2wUtuGiYFgxKK8sBLD
hb89+gdpUGy1Un4FZo2oJVUPMYK8CZ3udhXjWiLED3KNUPHlKVnApVIMpK7s7SyP
0M02jnP0CdoCSzjyVoz9Cd91v0vkaLXNJ+u3ssLQc2GffHfTjhDgOZFMBgGiruab
4xALF1DGLRknUKBiv4CXjgbmTcYDwQj/w2uhyXK+bWZ91YkgISZKEfpr+FCb9TQL
N24nJc9LiSmQV1AhLEpC
=xuQq
-----END PGP SIGNATURE-----

--szdyR02yM8NCQUEm--
