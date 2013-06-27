Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id B2FFF2C007C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 01:44:17 +1000 (EST)
Message-ID: <1372347850.30572.659.camel@ul30vt.home>
Subject: Re: [PATCH v2] vfio: add external user support
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu, 27 Jun 2013 09:44:10 -0600
In-Reply-To: <1372317260-6438-1-git-send-email-aik@ozlabs.ru>
References: <20130627164752.657c165ec4492e5248945a51@canb.auug.org.au>
 <1372317260-6438-1-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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

On Thu, 2013-06-27 at 17:14 +1000, Alexey Kardashevskiy wrote:
> VFIO is designed to be used via ioctls on file descriptors
> returned by VFIO.
> 
> However in some situations support for an external user is required.
> The first user is KVM on PPC64 (SPAPR TCE protocol) which is going to
> use the existing VFIO groups for exclusive access in real/virtual mode
> in the host kernel to avoid passing map/unmap requests to the user
> space which would made things pretty slow.
> 
> The proposed protocol includes:
> 
> 1. do normal VFIO init stuff such as opening a new container, attaching
> group(s) to it, setting an IOMMU driver for a container. When IOMMU is
> set for a container, all groups in it are considered ready to use by
> an external user.
> 
> 2. pass a fd of the group we want to accelerate to KVM. KVM calls
> vfio_group_iommu_id_from_file() to verify if the group is initialized
> and IOMMU is set for it. The current TCE IOMMU driver marks the whole
> IOMMU table as busy when IOMMU is set for a container what this prevents
> other DMA users from allocating from it so it is safe to pass the group
> to the user space.
> 
> 3. KVM increases the container users counter via
> vfio_group_add_external_user(). This prevents the VFIO group from
> being disposed prior to exiting KVM.
> 
> 4. When KVM is finished and doing cleanup, it releases the group file
> and decrements the container users counter. Everything gets released.
> 
> 5. KVM also keeps the group file as otherwise its fd might have been
> closed at the moment of KVM finish so vfio_group_del_external_user()
> call will not be possible.

This is the wrong order in my mind.  An external user has no business
checking or maintaining any state of a group until it calls
add_external_user().  Only after that call is successful can the user
assume the filep to group relationship is static and get the iommu_id.
Any use of the "external user" API should start with "add" and end with
"del".

> The "vfio: Limit group opens" patch is also required for the consistency.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> 
> v1->v2: added definitions to vfio.h :)
> Should not compile but compiled. Hm.
> 
> ---
>  drivers/vfio/vfio.c  |   54 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/vfio.h |    7 +++++++
>  2 files changed, 61 insertions(+)
> 
> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> index c488da5..40875d2 100644
> --- a/drivers/vfio/vfio.c
> +++ b/drivers/vfio/vfio.c
> @@ -1370,6 +1370,60 @@ static const struct file_operations vfio_device_fops = {
>  };
>  
>  /**
> + * External user API, exported by symbols to be linked dynamically.
> + */
> +
> +/* Allows an external user (for example, KVM) to lock an IOMMU group */
> +int vfio_group_add_external_user(struct file *filep)
> +{
> +	struct vfio_group *group = filep->private_data;
> +
> +	if (filep->f_op != &vfio_group_fops)
> +		return -EINVAL;
> +
> +	if (!atomic_inc_not_zero(&group->container_users))
> +		return -EINVAL;

This is the place where I was suggesting we need tests to match
get_device_fd.  It's not clear what the external user is holding if the
group has no iommu or is not viable here.


if (!group->container->iommu_driver || !vfio_group_viable(group)) {
	vfio_group_try_dissolve_container(group);
	return -EINVAL;
}

> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(vfio_group_add_external_user);
> +
> +/* Allows an external user (for example, KVM) to unlock an IOMMU group */
> +void vfio_group_del_external_user(struct file *filep)
> +{
> +	struct vfio_group *group = filep->private_data;
> +
> +	if (WARN_ON(filep->f_op != &vfio_group_fops))
> +		return;

How about we make this return int so we can return 0/-EINVAL and the
caller can decide the severity of the response?

> +
> +	vfio_group_try_dissolve_container(group);
> +}
> +EXPORT_SYMBOL_GPL(vfio_group_del_external_user);
> +
> +/*
> + * Checks if a group for the specified file can be used by
> + * an external user and returns the IOMMU ID if external use is possible.
> + */
> +int vfio_group_iommu_id_from_file(struct file *filep)

Let's name this in a way that makes it clear that it's part of the
external_user API.  vfio_group_external_user_iommu_id?

> +{
> +	int ret;
> +	struct vfio_group *group = filep->private_data;
> +
> +	if (WARN_ON(filep->f_op != &vfio_group_fops))
> +		return -EINVAL;

This one probably doesn't deserve a WARN_ON either, let the caller
blowup if it wants.

> +
> +	if (0 == atomic_read(&group->container_users) ||
> +			!group->container->iommu_driver ||
> +			!vfio_group_viable(group))
> +		return -EINVAL;

The above test just becomes a weak test that the caller is  correctly
using the API since we should be enforcing these tests when the external
user is added.  It doesn't hurt to leave them, but it's not very
convincing that the caller is the one holding anything.

> +	ret = iommu_group_id(group->iommu_group);

The 'ret' variable isn't needed.
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(vfio_group_iommu_id_from_file);
> +
> +/**
>   * Module/class support
>   */
>  static char *vfio_devnode(struct device *dev, umode_t *mode)
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index ac8d488..7ee6575 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -90,4 +90,11 @@ extern void vfio_unregister_iommu_driver(
>  	TYPE tmp;						\
>  	offsetof(TYPE, MEMBER) + sizeof(tmp.MEMBER); })		\
>  
> +/*
> + * External user API
> + */
> +int vfio_group_add_external_user(struct file *filep);
> +void vfio_group_del_external_user(struct file *filep);
> +int vfio_group_iommu_id_from_file(struct file *filep);
> +

As Stephen noted, let's use extern here.  Also, please add some
additional text about the general purpose of this API and how to use it.
A generalized version of your commit log after fixes would be great.
Thanks,

Alex
