Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNBLf1LsTzDvqn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 14:50:01 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id i88so444762pfk.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 19:50:01 -0800 (PST)
Subject: Re: [PATCH kernel v5 5/6] vfio/spapr: Reference mm in tce_container
To: David Gibson <david@gibson.dropbear.id.au>
References: <1478867537-27893-1-git-send-email-aik@ozlabs.ru>
 <1478867537-27893-6-git-send-email-aik@ozlabs.ru>
 <7bf695fa-502a-80b1-85be-79f0aff55366@ozlabs.ru>
 <20161122023801.GA28479@umbus.fritz.box>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <323bdb70-0a4d-48b9-18a9-990b550bb85a@ozlabs.ru>
Date: Tue, 22 Nov 2016 14:49:53 +1100
MIME-Version: 1.0
In-Reply-To: <20161122023801.GA28479@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vk8FJCD5o3S1bOOleBNn6WqMaQOFDbijE"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vk8FJCD5o3S1bOOleBNn6WqMaQOFDbijE
Content-Type: multipart/mixed; boundary="60kct7EgUGEjnNG8Sjf3xfjafoDQVhmBO";
 protected-headers="v1"
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org
Message-ID: <323bdb70-0a4d-48b9-18a9-990b550bb85a@ozlabs.ru>
Subject: Re: [PATCH kernel v5 5/6] vfio/spapr: Reference mm in tce_container
References: <1478867537-27893-1-git-send-email-aik@ozlabs.ru>
 <1478867537-27893-6-git-send-email-aik@ozlabs.ru>
 <7bf695fa-502a-80b1-85be-79f0aff55366@ozlabs.ru>
 <20161122023801.GA28479@umbus.fritz.box>
In-Reply-To: <20161122023801.GA28479@umbus.fritz.box>

--60kct7EgUGEjnNG8Sjf3xfjafoDQVhmBO
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: quoted-printable

On 22/11/16 13:38, David Gibson wrote:
> On Thu, Nov 17, 2016 at 06:39:41PM +1100, Alexey Kardashevskiy wrote:
>> On 11/11/16 23:32, Alexey Kardashevskiy wrote:
>>> In some situations the userspace memory context may live longer than
>>> the userspace process itself so if we need to do proper memory contex=
t
>>> cleanup, we better have tce_container take a reference to mm_struct a=
nd
>>> use it later when the process is gone (@current or @current->mm is NU=
LL).
>>>
>>> This references mm and stores the pointer in the container; this is d=
one
>>> in a new helper - tce_iommu_mm_set() - when one of the following happ=
ens:
>>> - a container is enabled (IOMMU v1);
>>> - a first attempt to pre-register memory is made (IOMMU v2);
>>> - a DMA window is created (IOMMU v2).
>>> The @mm stays referenced till the container is destroyed.
>>>
>>> This replaces current->mm with container->mm everywhere except debug
>>> prints.
>>>
>>> This adds a check that current->mm is the same as the one stored in
>>> the container to prevent userspace from making changes to a memory
>>> context of other processes.
>>>
>>> DMA map/unmap ioctls() do not check for @mm as they already check
>>> for @enabled which is set after tce_iommu_mm_set() is called.
>>>
>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>> ---
>>> Changes:
>>> v5:
>>> * postpone referencing of mm
>>>
>>> v4:
>>> * added check for container->mm!=3Dcurrent->mm in tce_iommu_ioctl()
>>> for all ioctls and removed other redundand checks
>>> ---
>>>  drivers/vfio/vfio_iommu_spapr_tce.c | 159 ++++++++++++++++++++++----=
----------
>>>  1 file changed, 99 insertions(+), 60 deletions(-)
>>>
>>> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_=
iommu_spapr_tce.c
>>> index 1c02498..9a81a7e 100644
>>> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
>>> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
>>> @@ -31,49 +31,49 @@
>>>  static void tce_iommu_detach_group(void *iommu_data,
>>>  		struct iommu_group *iommu_group);
>>> =20
>>> -static long try_increment_locked_vm(long npages)
>>> +static long try_increment_locked_vm(struct mm_struct *mm, long npage=
s)
>>>  {
>>>  	long ret =3D 0, locked, lock_limit;
>>> =20
>>> -	if (!current || !current->mm)
>>> -		return -ESRCH; /* process exited */
>>> +	if (!mm)
>>> +		return -EPERM;
>>> =20
>>>  	if (!npages)
>>>  		return 0;
>>> =20
>>> -	down_write(&current->mm->mmap_sem);
>>> -	locked =3D current->mm->locked_vm + npages;
>>> +	down_write(&mm->mmap_sem);
>>> +	locked =3D mm->locked_vm + npages;
>>>  	lock_limit =3D rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
>>>  	if (locked > lock_limit && !capable(CAP_IPC_LOCK))
>>
>>
>>
>> Oh boy. Now it seems I have to reference a task, not just mm (which I =
may
>> not have to reference at all after all as the task reference should ke=
ep mm
>> alive) as I missed the fact capable() and rlimit() are working with
>> @current.
>=20
> Sorry, what?  I'm not seeing how a task reference comes into this.

I reference @mm to make sure that just one mm uses a container. If mm
changes, I return an error, sanity check.

The code also increments locked_vm in mm. But it looks at the current tas=
k
if there is room for increments and for CAP_IPC_LOCK.

So, the options are:
1. I do not reference the current task, and if mm changes, then the mm
sanity check won't let me proceed to the code which tries using current O=
R
2. reference a task when I reference mm and do that sanity check not just=

for mm but also for current task.

Makes sense?


>=20
>>
>>
>> Alex,
>>
>> Is there anything else I should fix before posting v6? Thanks.
>>
>>
>>
>=20


--=20
Alexey


--60kct7EgUGEjnNG8Sjf3xfjafoDQVhmBO--

--vk8FJCD5o3S1bOOleBNn6WqMaQOFDbijE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJYM8BiDhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC5zP8QAJPy
8Z1KxVrFvi4N/V895mB0+tPYPgKLoFlWe3o7YQmKGxAFJ5SMph6VVU3W1aJ/RpoS
U1Pybu206hdcOOgfR0ePBQCB6ACauRQTxUoVlhaOYkSRd9OkatFlRpsAhHcGV8IO
Gt/+mi1/qrcN7AaiJG0lKP09N45iGedu45k4UQW7Bh1PTfLv5N8PBxKpZwJud+Mn
XXrmVAWe7yiQwJu+OQ5M2lksUJNtKQuDfnu64FHg5PKSyG1FNCwCgqqXPGcXCnMW
SDgnZX6lJCaD/U5Qm5fv8gh9+E/RHBZqnyBsXOJLmL134275K2lybMenRsdWBpZY
dZE2ky/chHF2La8+2XV6MxmoC8sZgTBvVPW+TkRTbhjFrsgD0yuO18PxrBs5P9WQ
ym5hEhnsvfK1V+siPs921asxskzpKc2QW3Qg3ztlL8+pDTAFjkwfThRSbO+e64oy
XqTCFJE01vwP9uJy+chMNRgsMbVRocnDH5hbLzbXBQpsBHOeDoa7L9o9dDG2wEIt
nyWjqxeKLOAjf6gf2wh23y/Gl6D4+nz/YIyBluAsOlV5a6vT6IzsHPpHd8bbTKjL
B0Q7xSoafTtxo5LfarqYmSq+jeLYK8QTyEYLO5uTBZIUKv53z7RfMEUQ+TYdJ9Xx
BLnkehUcrVASXLlh38pMaLqdVbhJXucffzCujt4D
=tnG3
-----END PGP SIGNATURE-----

--vk8FJCD5o3S1bOOleBNn6WqMaQOFDbijE--
