Return-Path: <aik@ozlabs.ru>
Received: from mail-pb0-f42.google.com (mail-pb0-f42.google.com
 [209.85.160.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 919752C02FC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 08:57:36 +1000 (EST)
Received: by mail-pb0-f42.google.com with SMTP id un1so1508032pbc.29
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 15:57:35 -0700 (PDT)
Message-ID: <51CCC353.7030905@ozlabs.ru>
Date: Fri, 28 Jun 2013 08:57:23 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v2] vfio: add external user support
References: <20130627164752.657c165ec4492e5248945a51@canb.auug.org.au>
 <1372317260-6438-1-git-send-email-aik@ozlabs.ru>
 <1372347850.30572.659.camel@ul30vt.home>
In-Reply-To: <1372347850.30572.659.camel@ul30vt.home>
Content-Type: text/plain; charset=KOI8-R
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/28/2013 01:44 AM, Alex Williamson wrote:
> On Thu, 2013-06-27 at 17:14 +1000, Alexey Kardashevskiy wrote:
>> VFIO is designed to be used via ioctls on file descriptors
>> returned by VFIO.
>>
>> However in some situations support for an external user is required.
>> The first user is KVM on PPC64 (SPAPR TCE protocol) which is going to
>> use the existing VFIO groups for exclusive access in real/virtual mode
>> in the host kernel to avoid passing map/unmap requests to the user
>> space which would made things pretty slow.
>>
>> The proposed protocol includes:
>>
>> 1. do normal VFIO init stuff such as opening a new container, attaching
>> group(s) to it, setting an IOMMU driver for a container. When IOMMU is
>> set for a container, all groups in it are considered ready to use by
>> an external user.
>>
>> 2. pass a fd of the group we want to accelerate to KVM. KVM calls
>> vfio_group_iommu_id_from_file() to verify if the group is initialized
>> and IOMMU is set for it. The current TCE IOMMU driver marks the whole
>> IOMMU table as busy when IOMMU is set for a container what this prevents
>> other DMA users from allocating from it so it is safe to pass the group
>> to the user space.
>>
>> 3. KVM increases the container users counter via
>> vfio_group_add_external_user(). This prevents the VFIO group from
>> being disposed prior to exiting KVM.
>>
>> 4. When KVM is finished and doing cleanup, it releases the group file
>> and decrements the container users counter. Everything gets released.
>>
>> 5. KVM also keeps the group file as otherwise its fd might have been
>> closed at the moment of KVM finish so vfio_group_del_external_user()
>> call will not be possible.
> 
> This is the wrong order in my mind.  An external user has no business
> checking or maintaining any state of a group until it calls
> add_external_user().  Only after that call is successful can the user
> assume the filep to group relationship is static and get the iommu_id.
> Any use of the "external user" API should start with "add" and end with
> "del".

Yes, this is what I actually do, just wrong commit message, will fix.

> 
>> The "vfio: Limit group opens" patch is also required for the consistency.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>
>> v1->v2: added definitions to vfio.h :)
>> Should not compile but compiled. Hm.
>>
>> ---
>>  drivers/vfio/vfio.c  |   54 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/vfio.h |    7 +++++++
>>  2 files changed, 61 insertions(+)
>>
>> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
>> index c488da5..40875d2 100644
>> --- a/drivers/vfio/vfio.c
>> +++ b/drivers/vfio/vfio.c
>> @@ -1370,6 +1370,60 @@ static const struct file_operations vfio_device_fops = {
>>  };
>>  
>>  /**
>> + * External user API, exported by symbols to be linked dynamically.
>> + */
>> +
>> +/* Allows an external user (for example, KVM) to lock an IOMMU group */
>> +int vfio_group_add_external_user(struct file *filep)
>> +{
>> +	struct vfio_group *group = filep->private_data;
>> +
>> +	if (filep->f_op != &vfio_group_fops)
>> +		return -EINVAL;
>> +
>> +	if (!atomic_inc_not_zero(&group->container_users))
>> +		return -EINVAL;
> 
> This is the place where I was suggesting we need tests to match
> get_device_fd.  It's not clear what the external user is holding if the
> group has no iommu or is not viable here.


In my mind this test must include test for iommu id so I would merge it
with vfio_group_iommu_id_from_file(). Till I check iommu id, I still cannot
use this group so where to put check for iommu/viable does not really
matter (for me).

> 
> 
> if (!group->container->iommu_driver || !vfio_group_viable(group)) {
> 	vfio_group_try_dissolve_container(group);
> 	return -EINVAL;
> }
> 
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(vfio_group_add_external_user);
>> +
>> +/* Allows an external user (for example, KVM) to unlock an IOMMU group */
>> +void vfio_group_del_external_user(struct file *filep)
>> +{
>> +	struct vfio_group *group = filep->private_data;
>> +
>> +	if (WARN_ON(filep->f_op != &vfio_group_fops))
>> +		return;
> 
> How about we make this return int so we can return 0/-EINVAL and the
> caller can decide the severity of the response?

And what can the caller possibly do on !0?


-- 
Alexey
