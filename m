Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8cVy1hyTzDqJ5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 02:46:49 +1000 (AEST)
Date: Wed, 10 Aug 2016 10:46:30 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH kernel 14/15] vfio/spapr_tce: Export container API for
 external users
Message-ID: <20160810104630.21ab4bc5@t450s.home>
In-Reply-To: <4d1ea52b-ecb5-5f9b-6cdc-00a73677cc2f@ozlabs.ru>
References: <1470213656-1042-1-git-send-email-aik@ozlabs.ru>
 <1470213656-1042-15-git-send-email-aik@ozlabs.ru>
 <20160808104315.77cf22ec@t450s.home>
 <f338a1d3-438a-9004-9645-87a16b9baf79@ozlabs.ru>
 <20160809061630.50ed5536@t450s.home>
 <4d1ea52b-ecb5-5f9b-6cdc-00a73677cc2f@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 10 Aug 2016 15:37:17 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> On 09/08/16 22:16, Alex Williamson wrote:
> > On Tue, 9 Aug 2016 15:19:39 +1000
> > Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >   
> >> On 09/08/16 02:43, Alex Williamson wrote:  
> >>> On Wed,  3 Aug 2016 18:40:55 +1000
> >>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >>>     
> >>>> This exports helpers which are needed to keep a VFIO container in
> >>>> memory while there are external users such as KVM.
> >>>>
> >>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>>> ---
> >>>>  drivers/vfio/vfio.c                 | 30 ++++++++++++++++++++++++++++++
> >>>>  drivers/vfio/vfio_iommu_spapr_tce.c | 16 +++++++++++++++-
> >>>>  include/linux/vfio.h                |  6 ++++++
> >>>>  3 files changed, 51 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> >>>> index d1d70e0..baf6a9c 100644
> >>>> --- a/drivers/vfio/vfio.c
> >>>> +++ b/drivers/vfio/vfio.c
> >>>> @@ -1729,6 +1729,36 @@ long vfio_external_check_extension(struct vfio_group *group, unsigned long arg)
> >>>>  EXPORT_SYMBOL_GPL(vfio_external_check_extension);
> >>>>  
> >>>>  /**
> >>>> + * External user API for containers, exported by symbols to be linked
> >>>> + * dynamically.
> >>>> + *
> >>>> + */
> >>>> +struct vfio_container *vfio_container_get_ext(struct file *filep)
> >>>> +{
> >>>> +	struct vfio_container *container = filep->private_data;
> >>>> +
> >>>> +	if (filep->f_op != &vfio_fops)
> >>>> +		return ERR_PTR(-EINVAL);
> >>>> +
> >>>> +	vfio_container_get(container);
> >>>> +
> >>>> +	return container;
> >>>> +}
> >>>> +EXPORT_SYMBOL_GPL(vfio_container_get_ext);
> >>>> +
> >>>> +void vfio_container_put_ext(struct vfio_container *container)
> >>>> +{
> >>>> +	vfio_container_put(container);
> >>>> +}
> >>>> +EXPORT_SYMBOL_GPL(vfio_container_put_ext);
> >>>> +
> >>>> +void *vfio_container_get_iommu_data_ext(struct vfio_container *container)
> >>>> +{
> >>>> +	return container->iommu_data;
> >>>> +}
> >>>> +EXPORT_SYMBOL_GPL(vfio_container_get_iommu_data_ext);
> >>>> +
> >>>> +/**
> >>>>   * Sub-module support
> >>>>   */
> >>>>  /*
> >>>> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
> >>>> index 3594ad3..fceea3d 100644
> >>>> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> >>>> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> >>>> @@ -1331,6 +1331,21 @@ const struct vfio_iommu_driver_ops tce_iommu_driver_ops = {
> >>>>  	.detach_group	= tce_iommu_detach_group,
> >>>>  };
> >>>>  
> >>>> +struct iommu_table *vfio_container_spapr_tce_table_get_ext(void *iommu_data,
> >>>> +		u64 offset)
> >>>> +{
> >>>> +	struct tce_container *container = iommu_data;
> >>>> +	struct iommu_table *tbl = NULL;
> >>>> +
> >>>> +	if (tce_iommu_find_table(container, offset, &tbl) < 0)
> >>>> +		return NULL;
> >>>> +
> >>>> +	iommu_table_get(tbl);
> >>>> +
> >>>> +	return tbl;
> >>>> +}
> >>>> +EXPORT_SYMBOL_GPL(vfio_container_spapr_tce_table_get_ext);
> >>>> +
> >>>>  static int __init tce_iommu_init(void)
> >>>>  {
> >>>>  	return vfio_register_iommu_driver(&tce_iommu_driver_ops);
> >>>> @@ -1348,4 +1363,3 @@ MODULE_VERSION(DRIVER_VERSION);
> >>>>  MODULE_LICENSE("GPL v2");
> >>>>  MODULE_AUTHOR(DRIVER_AUTHOR);
> >>>>  MODULE_DESCRIPTION(DRIVER_DESC);
> >>>> -
> >>>> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> >>>> index 0ecae0b..1c2138a 100644
> >>>> --- a/include/linux/vfio.h
> >>>> +++ b/include/linux/vfio.h
> >>>> @@ -91,6 +91,12 @@ extern void vfio_group_put_external_user(struct vfio_group *group);
> >>>>  extern int vfio_external_user_iommu_id(struct vfio_group *group);
> >>>>  extern long vfio_external_check_extension(struct vfio_group *group,
> >>>>  					  unsigned long arg);
> >>>> +extern struct vfio_container *vfio_container_get_ext(struct file *filep);
> >>>> +extern void vfio_container_put_ext(struct vfio_container *container);
> >>>> +extern void *vfio_container_get_iommu_data_ext(
> >>>> +		struct vfio_container *container);
> >>>> +extern struct iommu_table *vfio_container_spapr_tce_table_get_ext(
> >>>> +		void *iommu_data, u64 offset);
> >>>>  
> >>>>  /*
> >>>>   * Sub-module helpers    
> >>>
> >>>
> >>> I think you need to take a closer look of the lifecycle of a container,
> >>> having a reference means the container itself won't go away, but only
> >>> having a group set within that container holds the actual IOMMU
> >>> references.  container->iommu_data is going to be NULL once the
> >>> groups are lost.  Thanks,    
> >>
> >>
> >> Container owns the iommu tables and this is what I care about here, groups
> >> attached or not - this is handled separately via IOMMU group list in a
> >> specific iommu_table struct, these groups get detached from iommu_table
> >> when they are removed from a container.  
> > 
> > The container doesn't own anything, the container is privileged by the
> > groups being attached to it.  When groups are closed, they detach from
> > the container and once the container group list is empty the iommu
> > backend is released and iommu_data is NULL.  A container reference
> > doesn't give you what you're looking for.  It implies nothing about the
> > iommu backend.  
> 
> 
> Well. Backend is a part of a container and since a backend owns tables, a
> container owns them too.

The IOMMU backend is accessed through the container, but that backend
is privileged by the groups it contains.  Once those groups are gone,
the IOMMU backend is released, regardless of whatever reference you
have to the container itself such as you're attempting to do here.  In
that sense, the container does not own those tables.

> The problem I am trying to solve here is when KVM may release the
> iommu_table objects.
> 
> "Set" ioctl() to KVM-spapr-tce-table (or KVM itself, does not really
> matter) makes a link between KVM-spapr-tce-table and container and KVM can
> start using tables (with referencing them).
> 
> First I tried adding an "unset" ioctl to KVM-spapr-tce-table, called it
> from region_del() and this works if QEMU removes a window. However if QEMU
> removes a vfio-pci device, region_del() is not called and KVM does not get
> notified that it can release the iommu_table's because the
> KVM-spapr-tce-table remains alive and does not get destroyed (as it is
> still used by emulated devices or other containers).
> 
> So it was suggested that we could do such "unset" somehow later assuming,
> for example, on every "set" I could check if some of currently attached
> containers are no more used - and this is where being able to know if there
> is no backend helps - KVM remembers a container pointer and can check this
> via vfio_container_get_iommu_data_ext().
> 
> The other option would be changing vfio_container_get_ext() to take a
> callback+opaque which container would call when it destroys iommu_data.
> This looks more intrusive and not very intuitive how to make it right -
> container would have to keep track of all registered external users and
> vfio_container_put_ext() would have to pass the same callback+opaque to
> unregister the exact external user.

I'm not in favor of anything resembling the code above or extensions
beyond it, the container is the wrong place to do this.

> Or I could store container file* in KVM. Then iommu_data would never be
> released until KVM-spapr-tce-table is destroyed.

See above, holding a file pointer to the container doesn't do squat.
The groups that are held by the container empower the IOMMU backend,
references to the container itself don't matter.  Those references will
not maintain the IOMMU data.
 
> Recreating KVM-spapr-tce-table on every vfio-pci hotunplug (closing its fd
> would "unset" container from KVM-spapr-tce-table) is not an option as there
> still may be devices using this KVM-spapr-tce-table.
> 
> What obvious and nice solution am I missing here? Thanks.

The interactions with the IOMMU backend that seem relevant are
vfio_iommu_drivers_ops.{detach_group,release}.  The kvm-vfio pseudo
device is also used to tell kvm about groups as they come and go and
has a way to check extensions, and thus properties of the IOMMU
backend.  All of these are available for your {ab}use.  Thanks,

Alex
