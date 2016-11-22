Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNHKh0B8LzDvgk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 18:34:32 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id i88so859480pfk.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 23:34:31 -0800 (PST)
Subject: Re: [PATCH kernel v5 5/6] vfio/spapr: Reference mm in tce_container
To: David Gibson <david@gibson.dropbear.id.au>
References: <1478867537-27893-1-git-send-email-aik@ozlabs.ru>
 <1478867537-27893-6-git-send-email-aik@ozlabs.ru>
 <7bf695fa-502a-80b1-85be-79f0aff55366@ozlabs.ru>
 <20161122023801.GA28479@umbus.fritz.box>
 <323bdb70-0a4d-48b9-18a9-990b550bb85a@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <9e20c926-c600-dedd-7e71-f8585ebe554b@ozlabs.ru>
Date: Tue, 22 Nov 2016 18:34:25 +1100
MIME-Version: 1.0
In-Reply-To: <323bdb70-0a4d-48b9-18a9-990b550bb85a@ozlabs.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="f0HCNcmaISDfRTqXENk7TIiVTsD8gtKgG"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--f0HCNcmaISDfRTqXENk7TIiVTsD8gtKgG
Content-Type: multipart/mixed; boundary="uUFGEJr2AP6uA6AGo3ekT6ciadna0UHLN";
 protected-headers="v1"
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org
Message-ID: <9e20c926-c600-dedd-7e71-f8585ebe554b@ozlabs.ru>
Subject: Re: [PATCH kernel v5 5/6] vfio/spapr: Reference mm in tce_container
References: <1478867537-27893-1-git-send-email-aik@ozlabs.ru>
 <1478867537-27893-6-git-send-email-aik@ozlabs.ru>
 <7bf695fa-502a-80b1-85be-79f0aff55366@ozlabs.ru>
 <20161122023801.GA28479@umbus.fritz.box>
 <323bdb70-0a4d-48b9-18a9-990b550bb85a@ozlabs.ru>
In-Reply-To: <323bdb70-0a4d-48b9-18a9-990b550bb85a@ozlabs.ru>

--uUFGEJr2AP6uA6AGo3ekT6ciadna0UHLN
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: quoted-printable

On 22/11/16 14:49, Alexey Kardashevskiy wrote:
> On 22/11/16 13:38, David Gibson wrote:
>> On Thu, Nov 17, 2016 at 06:39:41PM +1100, Alexey Kardashevskiy wrote:
>>> On 11/11/16 23:32, Alexey Kardashevskiy wrote:
>>>> In some situations the userspace memory context may live longer than=

>>>> the userspace process itself so if we need to do proper memory conte=
xt
>>>> cleanup, we better have tce_container take a reference to mm_struct =
and
>>>> use it later when the process is gone (@current or @current->mm is N=
ULL).
>>>>
>>>> This references mm and stores the pointer in the container; this is =
done
>>>> in a new helper - tce_iommu_mm_set() - when one of the following hap=
pens:
>>>> - a container is enabled (IOMMU v1);
>>>> - a first attempt to pre-register memory is made (IOMMU v2);
>>>> - a DMA window is created (IOMMU v2).
>>>> The @mm stays referenced till the container is destroyed.
>>>>
>>>> This replaces current->mm with container->mm everywhere except debug=

>>>> prints.
>>>>
>>>> This adds a check that current->mm is the same as the one stored in
>>>> the container to prevent userspace from making changes to a memory
>>>> context of other processes.
>>>>
>>>> DMA map/unmap ioctls() do not check for @mm as they already check
>>>> for @enabled which is set after tce_iommu_mm_set() is called.
>>>>
>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>> ---
>>>> Changes:
>>>> v5:
>>>> * postpone referencing of mm
>>>>
>>>> v4:
>>>> * added check for container->mm!=3Dcurrent->mm in tce_iommu_ioctl()
>>>> for all ioctls and removed other redundand checks
>>>> ---
>>>>  drivers/vfio/vfio_iommu_spapr_tce.c | 159 ++++++++++++++++++++++---=
-----------
>>>>  1 file changed, 99 insertions(+), 60 deletions(-)
>>>>
>>>> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio=
_iommu_spapr_tce.c
>>>> index 1c02498..9a81a7e 100644
>>>> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
>>>> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
>>>> @@ -31,49 +31,49 @@
>>>>  static void tce_iommu_detach_group(void *iommu_data,
>>>>  		struct iommu_group *iommu_group);
>>>> =20
>>>> -static long try_increment_locked_vm(long npages)
>>>> +static long try_increment_locked_vm(struct mm_struct *mm, long npag=
es)
>>>>  {
>>>>  	long ret =3D 0, locked, lock_limit;
>>>> =20
>>>> -	if (!current || !current->mm)
>>>> -		return -ESRCH; /* process exited */
>>>> +	if (!mm)
>>>> +		return -EPERM;
>>>> =20
>>>>  	if (!npages)
>>>>  		return 0;
>>>> =20
>>>> -	down_write(&current->mm->mmap_sem);
>>>> -	locked =3D current->mm->locked_vm + npages;
>>>> +	down_write(&mm->mmap_sem);
>>>> +	locked =3D mm->locked_vm + npages;
>>>>  	lock_limit =3D rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
>>>>  	if (locked > lock_limit && !capable(CAP_IPC_LOCK))
>>>
>>>
>>>
>>> Oh boy. Now it seems I have to reference a task, not just mm (which I=
 may
>>> not have to reference at all after all as the task reference should k=
eep mm
>>> alive) as I missed the fact capable() and rlimit() are working with
>>> @current.
>>
>> Sorry, what?  I'm not seeing how a task reference comes into this.
>=20
> I reference @mm to make sure that just one mm uses a container. If mm
> changes, I return an error, sanity check.
>=20
> The code also increments locked_vm in mm. But it looks at the current t=
ask
> if there is room for increments and for CAP_IPC_LOCK.
>=20
> So, the options are:
> 1. I do not reference the current task, and if mm changes, then the mm
> sanity check won't let me proceed to the code which tries using current=
 OR
> 2. reference a task when I reference mm and do that sanity check not ju=
st
> for mm but also for current task.
>=20
> Makes sense?

I had a chat with Nick and now I think that having mm referenced and
checked should be enough and I do not need to reference the task as
multiple threads within the same mm are allowed to ioctl() to vfio and
supposedly they will have same limits and capabilities and if they do not=
,
we'll just fail and that's it, I cannot see any harm from this approach,
can you?


>=20
>=20
>>
>>>
>>>
>>> Alex,
>>>
>>> Is there anything else I should fix before posting v6? Thanks.
>>>
>>>
>>>
>>
>=20
>=20


--=20
Alexey


--uUFGEJr2AP6uA6AGo3ekT6ciadna0UHLN--

--f0HCNcmaISDfRTqXENk7TIiVTsD8gtKgG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJYM/UBDhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC5F6MP/0/V
r1FwGqrM9NclkkrNL64ObABKdlvqHqmahA0x5FKnqCuXWeuwZ6p1pxS43tHydJ5b
rpkaL0xy9V+J6dwner9dBmWVZmYmYqWKuva3Bqt97ZR2cS1hiNK0sT/YW6TmPYhY
smENguiHZpBXUJzQ3Uqj5LR2RfpCkey07waSmQIHLY0wtP6MBfMFiiODjADFWCKH
5QWNqAP6L/jdq+01fmApCmvg8YJ2RpmWY9Tj4ejlfcTDlr6JBov+EcicjQeY0Nsm
XfGmSHhyBTuMEhDRKl7thSgeUeGnvzxbZChRL1CYnoCgdz7zCGSBwG4/km3LE7Fl
zsvmzTzE60JToxlhxGAg03amhEN/tU9ZIFHUaCR9k/t4uYMwq2s4NGQsHG7gDI4J
LYzjCY9tACK12hCbA3kbIJHEciwxxf0wqqWI8mXivdC6XKV0sgUmnAl/S4peRqL5
yc+mdGdBG4cLLZ84bGSJRj3JJ2/vt9es1irLkmMViD7fzwdMHk0sNsSSv2M7d97H
SK/XbaTapuZJYvS/u86zHgKm11LGhiA2RQUUM4ndcLlDEDtdg3u+EwHR8vzElS04
o3TuEVLGVIVkK+QGGIEv/bM4fdhvihj2UF+MgO0YbW+/Q3NychGGdF5tmL8gCaZf
UZ1Av7o3QAwAFa1EJv6UcmpQ8PyecP11E7tIpgiy
=lQIM
-----END PGP SIGNATURE-----

--f0HCNcmaISDfRTqXENk7TIiVTsD8gtKgG--
