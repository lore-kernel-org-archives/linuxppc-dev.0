Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNlw43cNpzDvnF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 13:02:28 +1100 (AEDT)
Date: Wed, 23 Nov 2016 12:36:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org
Subject: Re: [PATCH kernel v5 5/6] vfio/spapr: Reference mm in tce_container
Message-ID: <20161123013655.GI28479@umbus.fritz.box>
References: <1478867537-27893-1-git-send-email-aik@ozlabs.ru>
 <1478867537-27893-6-git-send-email-aik@ozlabs.ru>
 <7bf695fa-502a-80b1-85be-79f0aff55366@ozlabs.ru>
 <20161122023801.GA28479@umbus.fritz.box>
 <323bdb70-0a4d-48b9-18a9-990b550bb85a@ozlabs.ru>
 <9e20c926-c600-dedd-7e71-f8585ebe554b@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fckbADODYWZD5TdN"
In-Reply-To: <9e20c926-c600-dedd-7e71-f8585ebe554b@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--fckbADODYWZD5TdN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 22, 2016 at 06:34:25PM +1100, Alexey Kardashevskiy wrote:
> On 22/11/16 14:49, Alexey Kardashevskiy wrote:
> > On 22/11/16 13:38, David Gibson wrote:
> >> On Thu, Nov 17, 2016 at 06:39:41PM +1100, Alexey Kardashevskiy wrote:
> >>> On 11/11/16 23:32, Alexey Kardashevskiy wrote:
> >>>> In some situations the userspace memory context may live longer than
> >>>> the userspace process itself so if we need to do proper memory conte=
xt
> >>>> cleanup, we better have tce_container take a reference to mm_struct =
and
> >>>> use it later when the process is gone (@current or @current->mm is N=
ULL).
> >>>>
> >>>> This references mm and stores the pointer in the container; this is =
done
> >>>> in a new helper - tce_iommu_mm_set() - when one of the following hap=
pens:
> >>>> - a container is enabled (IOMMU v1);
> >>>> - a first attempt to pre-register memory is made (IOMMU v2);
> >>>> - a DMA window is created (IOMMU v2).
> >>>> The @mm stays referenced till the container is destroyed.
> >>>>
> >>>> This replaces current->mm with container->mm everywhere except debug
> >>>> prints.
> >>>>
> >>>> This adds a check that current->mm is the same as the one stored in
> >>>> the container to prevent userspace from making changes to a memory
> >>>> context of other processes.
> >>>>
> >>>> DMA map/unmap ioctls() do not check for @mm as they already check
> >>>> for @enabled which is set after tce_iommu_mm_set() is called.
> >>>>
> >>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>>> ---
> >>>> Changes:
> >>>> v5:
> >>>> * postpone referencing of mm
> >>>>
> >>>> v4:
> >>>> * added check for container->mm!=3Dcurrent->mm in tce_iommu_ioctl()
> >>>> for all ioctls and removed other redundand checks
> >>>> ---
> >>>>  drivers/vfio/vfio_iommu_spapr_tce.c | 159 ++++++++++++++++++++++---=
-----------
> >>>>  1 file changed, 99 insertions(+), 60 deletions(-)
> >>>>
> >>>> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio=
_iommu_spapr_tce.c
> >>>> index 1c02498..9a81a7e 100644
> >>>> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> >>>> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> >>>> @@ -31,49 +31,49 @@
> >>>>  static void tce_iommu_detach_group(void *iommu_data,
> >>>>  		struct iommu_group *iommu_group);
> >>>> =20
> >>>> -static long try_increment_locked_vm(long npages)
> >>>> +static long try_increment_locked_vm(struct mm_struct *mm, long npag=
es)
> >>>>  {
> >>>>  	long ret =3D 0, locked, lock_limit;
> >>>> =20
> >>>> -	if (!current || !current->mm)
> >>>> -		return -ESRCH; /* process exited */
> >>>> +	if (!mm)
> >>>> +		return -EPERM;
> >>>> =20
> >>>>  	if (!npages)
> >>>>  		return 0;
> >>>> =20
> >>>> -	down_write(&current->mm->mmap_sem);
> >>>> -	locked =3D current->mm->locked_vm + npages;
> >>>> +	down_write(&mm->mmap_sem);
> >>>> +	locked =3D mm->locked_vm + npages;
> >>>>  	lock_limit =3D rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> >>>>  	if (locked > lock_limit && !capable(CAP_IPC_LOCK))
> >>>
> >>>
> >>>
> >>> Oh boy. Now it seems I have to reference a task, not just mm (which I=
 may
> >>> not have to reference at all after all as the task reference should k=
eep mm
> >>> alive) as I missed the fact capable() and rlimit() are working with
> >>> @current.
> >>
> >> Sorry, what?  I'm not seeing how a task reference comes into this.
> >=20
> > I reference @mm to make sure that just one mm uses a container. If mm
> > changes, I return an error, sanity check.
> >=20
> > The code also increments locked_vm in mm. But it looks at the current t=
ask
> > if there is room for increments and for CAP_IPC_LOCK.
> >=20
> > So, the options are:
> > 1. I do not reference the current task, and if mm changes, then the mm
> > sanity check won't let me proceed to the code which tries using current=
 OR
> > 2. reference a task when I reference mm and do that sanity check not ju=
st
> > for mm but also for current task.
> >=20
> > Makes sense?
>=20
> I had a chat with Nick and now I think that having mm referenced and
> checked should be enough and I do not need to reference the task as
> multiple threads within the same mm are allowed to ioctl() to vfio and
> supposedly they will have same limits and capabilities and if they do not,
> we'll just fail and that's it, I cannot see any harm from this approach,
> can you?

Yeah, that sounds sane to me.  If the different threads in the mm
somehow have different caps /  limits, we could get some weird results
depending on which thread attempts to do the mapping, but it shouldn't
actually be harmful.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--fckbADODYWZD5TdN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYNPK2AAoJEGw4ysog2bOS7Q0QAL5vg13pmhwsdH4elHt4PAve
8DnuwYfLjk9nFaBSyV8u96oc7ce9jLJcKwLmz+1/TJ91Sk/TubP9uEIiIdvbO0di
5axRc62t76sFwH93Nh/KWOpnMCT/vUhqC2+RHnXeNa2kPuI9Q4h3B7ECyDL+SW8F
97TCDl4wYwT0sDvRr5fJ+XC7Q8AnXo8GYpNQ+PSOHsIGTvWi8U/Oo+jFednk+26D
74Ou2uQ7w6Ego/oUTjlHlwrN/s+s7fdyAfAuxA13+YSTNh2JALEh3Aa1YzEovQXg
0eZQWaehdNeElhsTCDCgCdTo+05l+iU/CZ6mfirHqAUy8DEOdgkcTD9W/WfGo4Hw
qjUnMi6XyDJu7uBF9fqKHw3eJOmwbb41/ZuCes4QXVVMk2OQ3I+ZFO/gdyc/W8BY
XDdg5wGj9uGOkB8qKEmCglcyaOYn8xUHQw/6j8To35Rmm9NWwykGNDTbMTX3hvtc
fHhQrGs6p5OTru1C+Oi+V7LM+B6cUiiYlFRqQ14bQUAIKafjvBbq5hSSE7qd8nQy
MMtODh60CyrNmCGP+OCnuR8vt5IVGpxomW4UxWYymFvHXS0jG8EgjF8i1nD1eLEz
2DZmvNFUKolLDlOscRc25j5IjOe4JTy5UWsNgujAXQfVnBNBRZgrGICdBOyuBZbc
tgrMBvHg0kMp8ZS9KwFN
=cL4h
-----END PGP SIGNATURE-----

--fckbADODYWZD5TdN--
