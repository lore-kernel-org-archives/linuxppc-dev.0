Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tZNLm2QGtzDw5q
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Dec 2016 04:55:28 +1100 (AEDT)
Date: Thu, 8 Dec 2016 10:55:24 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel 9/9] KVM: PPC: Add in-kernel acceleration for VFIO
Message-ID: <20161208105524.40e437a8@t450s.home>
In-Reply-To: <20161208081956.26221-10-aik@ozlabs.ru>
References: <20161208081956.26221-1-aik@ozlabs.ru>
 <20161208081956.26221-10-aik@ozlabs.ru>
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

On Thu,  8 Dec 2016 19:19:56 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> This allows the host kernel to handle H_PUT_TCE, H_PUT_TCE_INDIRECT
> and H_STUFF_TCE requests targeted an IOMMU TCE table used for VFIO
> without passing them to user space which saves time on switching
> to user space and back.
> 
> This adds H_PUT_TCE/H_PUT_TCE_INDIRECT/H_STUFF_TCE handlers to KVM.
> KVM tries to handle a TCE request in the real mode, if failed
> it passes the request to the virtual mode to complete the operation.
> If it a virtual mode handler fails, the request is passed to
> the user space; this is not expected to happen though.
> 
> To avoid dealing with page use counters (which is tricky in real mode),
> this only accelerates SPAPR TCE IOMMU v2 clients which are required
> to pre-register the userspace memory. The very first TCE request will
> be handled in the VFIO SPAPR TCE driver anyway as the userspace view
> of the TCE table (iommu_table::it_userspace) is not allocated till
> the very first mapping happens and we cannot call vmalloc in real mode.
> 
> This adds new attribute - KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE - to
> the VFIO KVM device. It takes a VFIO group fd and SPAPR TCE table fd
> and associates a physical IOMMU table with the SPAPR TCE table (which
> is a guest view of the hardware IOMMU table). The iommu_table object
> is referenced so we do not have to retrieve in real mode when hypercall
> happens.
> 
> This does not implement the UNSET counterpart as there is no use for it -
> once the acceleration is enabled, the existing userspace won't
> disable it unless a VFIO container is detroyed so this adds necessary
> cleanup to the KVM_DEV_VFIO_GROUP_DEL handler.
> 
> This uses the kvm->lock mutex to protect against a race between
> the VFIO KVM device's kvm_vfio_destroy() and SPAPR TCE table fd's
> release() callback.
> 
> This advertises the new KVM_CAP_SPAPR_TCE_VFIO capability to the user
> space.
> 
> This finally makes use of vfio_external_user_iommu_id() which was
> introduced quite some time ago and was considered for removal.
> 
> Tests show that this patch increases transmission speed from 220MB/s
> to 750..1020MB/s on 10Gb network (Chelsea CXGB3 10Gb ethernet card).
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  Documentation/virtual/kvm/devices/vfio.txt |  21 +-
>  arch/powerpc/include/asm/kvm_host.h        |   8 +
>  arch/powerpc/include/asm/kvm_ppc.h         |   5 +
>  include/uapi/linux/kvm.h                   |   8 +
>  arch/powerpc/kvm/book3s_64_vio.c           | 302 +++++++++++++++++++++++++++++
>  arch/powerpc/kvm/book3s_64_vio_hv.c        | 178 +++++++++++++++++
>  arch/powerpc/kvm/powerpc.c                 |   2 +
>  virt/kvm/vfio.c                            | 108 +++++++++++
>  8 files changed, 630 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/virtual/kvm/devices/vfio.txt b/Documentation/virtual/kvm/devices/vfio.txt
> index ef51740c67ca..ddb5a6512ab3 100644
> --- a/Documentation/virtual/kvm/devices/vfio.txt
> +++ b/Documentation/virtual/kvm/devices/vfio.txt
> @@ -16,7 +16,24 @@ Groups:
>  
>  KVM_DEV_VFIO_GROUP attributes:
>    KVM_DEV_VFIO_GROUP_ADD: Add a VFIO group to VFIO-KVM device tracking
> +	kvm_device_attr.addr points to an int32_t file descriptor
> +	for the VFIO group.
>    KVM_DEV_VFIO_GROUP_DEL: Remove a VFIO group from VFIO-KVM device tracking
> +	kvm_device_attr.addr points to an int32_t file descriptor
> +	for the VFIO group.
> +  KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE: attaches a guest visible TCE table
> +	allocated by sPAPR KVM.
> +	kvm_device_attr.addr points to a struct:
>  
> -For each, kvm_device_attr.addr points to an int32_t file descriptor
> -for the VFIO group.
> +	struct kvm_vfio_spapr_tce {
> +		__u32	argsz;
> +		__s32	groupfd;
> +		__s32	tablefd;
> +		__u8	pad[4];
> +	};
> +
> +	where
> +	@argsz is the size of kvm_vfio_spapr_tce_liobn;
> +	@groupfd is a file descriptor for a VFIO group;
> +	@tablefd is a file descriptor for a TCE table allocated via
> +		KVM_CREATE_SPAPR_TCE.
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
> index 28350a294b1e..94774503c70d 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -191,6 +191,13 @@ struct kvmppc_pginfo {
>  	atomic_t refcnt;
>  };
>  
> +struct kvmppc_spapr_tce_iommu_table {
> +	struct rcu_head rcu;
> +	struct list_head next;
> +	struct iommu_table *tbl;
> +	atomic_t refs;
> +};
> +
>  struct kvmppc_spapr_tce_table {
>  	struct list_head list;
>  	struct kvm *kvm;
> @@ -199,6 +206,7 @@ struct kvmppc_spapr_tce_table {
>  	u32 page_shift;
>  	u64 offset;		/* in pages */
>  	u64 size;		/* window size in pages */
> +	struct list_head iommu_tables;
>  	struct page *pages[0];
>  };
>  
> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
> index 0a21c8503974..17b947a0060d 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -163,6 +163,11 @@ extern long kvmppc_prepare_vrma(struct kvm *kvm,
>  extern void kvmppc_map_vrma(struct kvm_vcpu *vcpu,
>  			struct kvm_memory_slot *memslot, unsigned long porder);
>  extern int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu);
> +extern long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm,
> +				int tablefd,
> +				struct iommu_group *grp);
> +extern void kvm_spapr_tce_detach_iommu_group(struct kvm *kvm,
> +				struct iommu_group *grp);
>  
>  extern long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>  				struct kvm_create_spapr_tce_64 *args);
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 810f74317987..9e4025724e28 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1068,6 +1068,7 @@ struct kvm_device_attr {
>  #define  KVM_DEV_VFIO_GROUP			1
>  #define   KVM_DEV_VFIO_GROUP_ADD			1
>  #define   KVM_DEV_VFIO_GROUP_DEL			2
> +#define   KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE		3
>  
>  enum kvm_device_type {
>  	KVM_DEV_TYPE_FSL_MPIC_20	= 1,
> @@ -1089,6 +1090,13 @@ enum kvm_device_type {
>  	KVM_DEV_TYPE_MAX,
>  };
>  
> +struct kvm_vfio_spapr_tce {
> +	__u32	argsz;
> +	__s32	groupfd;
> +	__s32	tablefd;
> +	__u8	pad[4];
> +};

I assume you're implementing argsz and padding for future expansion,
but it doesn't really work.  Presumably argsz would be set to 16, so
the only way that the kernel will ever know something has changed would
be to make it bigger, so the padding bytes are really reserved, and
then it's not clear why we have padding at all.  If you replaced the
padding with a __u32 flags, then we could actually have some room to
architect expansion, but as it is we might as well drop both argsz and
padding.

> +
>  /*
>   * ioctls for VM fds
>   */
...
> --- a/virt/kvm/vfio.c
> +++ b/virt/kvm/vfio.c
> @@ -20,6 +20,10 @@
>  #include <linux/vfio.h>
>  #include "vfio.h"
>  
> +#ifdef CONFIG_SPAPR_TCE_IOMMU
> +#include <asm/kvm_ppc.h>
> +#endif
> +
>  struct kvm_vfio_group {
>  	struct list_head node;
>  	struct vfio_group *vfio_group;
> @@ -76,6 +80,22 @@ static bool kvm_vfio_group_is_coherent(struct vfio_group *vfio_group)
>  	return ret > 0;
>  }
>  
> +static int kvm_vfio_external_user_iommu_id(struct vfio_group *vfio_group)
> +{
> +	int (*fn)(struct vfio_group *);
> +	int ret = -1;
> +
> +	fn = symbol_get(vfio_external_user_iommu_id);
> +	if (!fn)
> +		return ret;
> +
> +	ret = fn(vfio_group);
> +
> +	symbol_put(vfio_external_user_iommu_id);
> +
> +	return ret;
> +}
> +
>  /*
>   * Groups can use the same or different IOMMU domains.  If the same then
>   * adding a new group may change the coherency of groups we've previously
> @@ -110,6 +130,22 @@ static void kvm_vfio_update_coherency(struct kvm_device *dev)
>  	mutex_unlock(&kv->lock);
>  }
>  
> +#ifdef CONFIG_SPAPR_TCE_IOMMU
> +static void kvm_vfio_spapr_detach_iommu_group(struct kvm *kvm,
> +		struct vfio_group *vfio_group)
> +{
> +	int group_id;
> +	struct iommu_group *grp;
> +
> +	group_id = kvm_vfio_external_user_iommu_id(vfio_group);
> +	grp = iommu_group_get_by_id(group_id);
> +	if (grp) {
> +		kvm_spapr_tce_detach_iommu_group(kvm, grp);
> +		iommu_group_put(grp);
> +	}
> +}
> +#endif


I wonder if you could use the new vfio group notifier to avoid tainting
this code with SPAPR_TCE #ifdefs.  Thanks,

Alex
