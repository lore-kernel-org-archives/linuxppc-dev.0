Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rQG8n2GL1zDq60
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 16:48:08 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id ug1so2105939pab.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jun 2016 23:48:08 -0700 (PDT)
Subject: Re: [PATCH kernel 9/9] KVM: PPC: VFIO device: support SPAPR TCE
To: David Gibson <david@gibson.dropbear.id.au>
References: <1457322077-26640-1-git-send-email-aik@ozlabs.ru>
 <1457322077-26640-10-git-send-email-aik@ozlabs.ru>
 <20160309054544.GM22546@voom.fritz.box> <56DFEACC.7030508@ozlabs.ru>
 <20160310052108.GV22546@voom.fritz.box> <56E1FEBE.5090602@ozlabs.ru>
 <20160315060400.GK15272@voom.fritz.box>
 <15389a41428.27cb.1ca38dd7e845b990cd13d431eb58563d@ozlabs.ru>
 <20160321051932.GJ23586@voom.redhat.com> <56F0932F.2050708@ozlabs.ru>
 <20160323030341.GT23586@voom.redhat.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <paulus@samba.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 kvm-ppc <kvm-ppc@vger.kernel.org>, kvm@vger.kernel.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <367698b4-40eb-ec26-5154-b22d672322b7@ozlabs.ru>
Date: Thu, 9 Jun 2016 16:47:59 +1000
MIME-Version: 1.0
In-Reply-To: <20160323030341.GT23586@voom.redhat.com>
Content-Type: text/plain; charset=koi8-r
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 23/03/16 14:03, David Gibson wrote:
> On Tue, Mar 22, 2016 at 11:34:55AM +1100, Alexey Kardashevskiy wrote:
>> Uff, lost cc: list. Added back. Some comments below.
>>
>>
>> On 03/21/2016 04:19 PM, David Gibson wrote:
>>> On Fri, Mar 18, 2016 at 11:12:26PM +1100, Alexey Kardashevskiy wrote:
>>>> On March 15, 2016 17:29:26 David Gibson <david@gibson.dropbear.id.au> wrote:
>>>>
>>>>> On Fri, Mar 11, 2016 at 10:09:50AM +1100, Alexey Kardashevskiy wrote:
>>>>>> On 03/10/2016 04:21 PM, David Gibson wrote:
>>>>>>> On Wed, Mar 09, 2016 at 08:20:12PM +1100, Alexey Kardashevskiy wrote:
>>>>>>>> On 03/09/2016 04:45 PM, David Gibson wrote:
>>>>>>>>> On Mon, Mar 07, 2016 at 02:41:17PM +1100, Alexey Kardashevskiy wrote:
>>>>>>>>>> sPAPR TCE IOMMU is para-virtualized and the guest does map/unmap
>>>>>>>>>> via hypercalls which take a logical bus id (LIOBN) as a target IOMMU
>>>>>>>>>> identifier. LIOBNs are made up, advertised to guest systems and
>>>>>>>>>> linked to IOMMU groups by the user space.
>>>>>>>>>> In order to enable acceleration for IOMMU operations in KVM, we need
>>>>>>>>>> to tell KVM the information about the LIOBN-to-group mapping.
>>>>>>>>>>
>>>>>>>>>> For that, a new KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE_LIOBN parameter
>>>>>>>>>> is added which accepts:
>>>>>>>>>> - a VFIO group fd and IO base address to find the actual hardware
>>>>>>>>>> TCE table;
>>>>>>>>>> - a LIOBN to assign to the found table.
>>>>>>>>>>
>>>>>>>>>> Before notifying KVM about new link, this check the group for being
>>>>>>>>>> registered with KVM device in order to release them at unexpected KVM
>>>>>>>>>> finish.
>>>>>>>>>>
>>>>>>>>>> This advertises the new KVM_CAP_SPAPR_TCE_VFIO capability to the user
>>>>>>>>>> space.
>>>>>>>>>>
>>>>>>>>>> While we are here, this also fixes VFIO KVM device compiling to let it
>>>>>>>>>> link to a KVM module.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>>>>>>>> ---
>>>>>>>>>>  Documentation/virtual/kvm/devices/vfio.txt |  21 +++++-
>>>>>>>>>>  arch/powerpc/kvm/Kconfig                   |   1 +
>>>>>>>>>>  arch/powerpc/kvm/Makefile                  |   5 +-
>>>>>>>>>>  arch/powerpc/kvm/powerpc.c                 |   1 +
>>>>>>>>>>  include/uapi/linux/kvm.h                   |   9 +++
>>>>>>>>>>  virt/kvm/vfio.c                            | 106
>>>>>> +++++++++++++++++++++++++++++
>>>>>>>>>>  6 files changed, 140 insertions(+), 3 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/Documentation/virtual/kvm/devices/vfio.txt
>>>>>> b/Documentation/virtual/kvm/devices/vfio.txt
>>>>>>>>>> index ef51740..c0d3eb7 100644
>>>>>>>>>> --- a/Documentation/virtual/kvm/devices/vfio.txt
>>>>>>>>>> +++ b/Documentation/virtual/kvm/devices/vfio.txt
>>>>>>>>>> @@ -16,7 +16,24 @@ Groups:
>>>>>>>>>>
>>>>>>>>>>  KVM_DEV_VFIO_GROUP attributes:
>>>>>>>>>>    KVM_DEV_VFIO_GROUP_ADD: Add a VFIO group to VFIO-KVM device tracking
>>>>>>>>>> +	kvm_device_attr.addr points to an int32_t file descriptor
>>>>>>>>>> +	for the VFIO group.
>>>>>>>>>
>>>>>>>>> AFAICT these changes are accurate for VFIO as it is already, in which
>>>>>>>>> case it might be clearer to put them in a separate patch.
>>>>>>>>>
>>>>>>>>>>    KVM_DEV_VFIO_GROUP_DEL: Remove a VFIO group from VFIO-KVM device
>>>>>> tracking
>>>>>>>>>> +	kvm_device_attr.addr points to an int32_t file descriptor
>>>>>>>>>> +	for the VFIO group.
>>>>>>>>>>
>>>>>>>>>> -For each, kvm_device_attr.addr points to an int32_t file descriptor
>>>>>>>>>> -for the VFIO group.
>>>>>>>>>> +  KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE_LIOBN: sets a liobn for a VFIO group
>>>>>>>>>> +	kvm_device_attr.addr points to a struct:
>>>>>>>>>> +		struct kvm_vfio_spapr_tce_liobn {
>>>>>>>>>> +			__u32	argsz;
>>>>>>>>>> +			__s32	fd;
>>>>>>>>>> +			__u32	liobn;
>>>>>>>>>> +			__u8	pad[4];
>>>>>>>>>> +			__u64	start_addr;
>>>>>>>>>> +		};
>>>>>>>>>> +		where
>>>>>>>>>> +		@argsz is the size of kvm_vfio_spapr_tce_liobn;
>>>>>>>>>> +		@fd is a file descriptor for a VFIO group;
>>>>>>>>>> +		@liobn is a logical bus id to be associated with the group;
>>>>>>>>>> +		@start_addr is a DMA window offset on the IO (PCI) bus
>>>>>>>>>
>>>>>>>>> For the cause of DDW and multiple windows, I'm assuming you can call
>>>>>>>>> this multiple times with different LIOBNs and the same IOMMU group?
>>>>>>>>
>>>>>>>>
>>>>>>>> Yes. It is called twice per each group (when DDW is activated) - for 32bit
>>>>>>>> and 64bit windows, this is why @start_addr is there.
>>>>>>>>
>>>>>>>>
>>>>>>>>>> diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
>>>>>>>>>> index 1059846..dfa3488 100644
>>>>>>>>>> --- a/arch/powerpc/kvm/Kconfig
>>>>>>>>>> +++ b/arch/powerpc/kvm/Kconfig
>>>>>>>>>> @@ -65,6 +65,7 @@ config KVM_BOOK3S_64
>>>>>>>>>>  	select KVM
>>>>>>>>>>  	select KVM_BOOK3S_PR_POSSIBLE if !KVM_BOOK3S_HV_POSSIBLE
>>>>>>>>>>  	select SPAPR_TCE_IOMMU if IOMMU_SUPPORT
>>>>>>>>>> +	select KVM_VFIO if VFIO
>>>>>>>>>>  	---help---
>>>>>>>>>>  	  Support running unmodified book3s_64 and book3s_32 guest kernels
>>>>>>>>>>  	  in virtual machines on book3s_64 host processors.
>>>>>>>>>> diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
>>>>>>>>>> index 7f7b6d8..71f577c 100644
>>>>>>>>>> --- a/arch/powerpc/kvm/Makefile
>>>>>>>>>> +++ b/arch/powerpc/kvm/Makefile
>>>>>>>>>> @@ -8,7 +8,7 @@ ccflags-y := -Ivirt/kvm -Iarch/powerpc/kvm
>>>>>>>>>>  KVM := ../../../virt/kvm
>>>>>>>>>>
>>>>>>>>>>  common-objs-y = $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o \
>>>>>>>>>> -		$(KVM)/eventfd.o $(KVM)/vfio.o
>>>>>>>>>> +		$(KVM)/eventfd.o
>>>>>>>>>
>>>>>>>>> Please don't disable the VFIO device for the non-book3s case.  I added
>>>>>>>>> it (even though it didn't do anything until now) so that libvirt
>>>>>>>>> wouldn't choke when it finds it's not available.  Obviously the new
>>>>>>>>> ioctl needs to be only for the right IOMMU setup, but the device
>>>>>>>>> itself should be available always.
>>>>>>>>
>>>>>>>> Ah. Ok, I'll fix this. I just wanted to be able to compile kvm as a module.
>>>>>>>>
>>>>>>>>
>>>>>>>>>>  CFLAGS_e500_mmu.o := -I.
>>>>>>>>>>  CFLAGS_e500_mmu_host.o := -I.
>>>>>>>>>> @@ -87,6 +87,9 @@ endif
>>>>>>>>>>  kvm-book3s_64-objs-$(CONFIG_KVM_XICS) += \
>>>>>>>>>>  	book3s_xics.o
>>>>>>>>>>
>>>>>>>>>> +kvm-book3s_64-objs-$(CONFIG_KVM_VFIO) += \
>>>>>>>>>> +	$(KVM)/vfio.o \
>>>>>>>>>> +
>>>>>>>>>>  kvm-book3s_64-module-objs += \
>>>>>>>>>>  	$(KVM)/kvm_main.o \
>>>>>>>>>>  	$(KVM)/eventfd.o \
>>>>>>>>>> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
>>>>>>>>>> index 19aa59b..63f188d 100644
>>>>>>>>>> --- a/arch/powerpc/kvm/powerpc.c
>>>>>>>>>> +++ b/arch/powerpc/kvm/powerpc.c
>>>>>>>>>> @@ -521,6 +521,7 @@ int kvm_vm_ioctl_check_extension(struct kvm
>>>>>> *kvm, long ext)
>>>>>>>>>>  #ifdef CONFIG_PPC_BOOK3S_64
>>>>>>>>>>  	case KVM_CAP_SPAPR_TCE:
>>>>>>>>>>  	case KVM_CAP_SPAPR_TCE_64:
>>>>>>>>>> +	case KVM_CAP_SPAPR_TCE_VFIO:
>>>>>>>>>>  	case KVM_CAP_PPC_ALLOC_HTAB:
>>>>>>>>>>  	case KVM_CAP_PPC_RTAS:
>>>>>>>>>>  	case KVM_CAP_PPC_FIXUP_HCALL:
>>>>>>>>>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>>>>>>>>>> index 080ffbf..f1abbea 100644
>>>>>>>>>> --- a/include/uapi/linux/kvm.h
>>>>>>>>>> +++ b/include/uapi/linux/kvm.h
>>>>>>>>>> @@ -1056,6 +1056,7 @@ struct kvm_device_attr {
>>>>>>>>>>  #define  KVM_DEV_VFIO_GROUP			1
>>>>>>>>>>  #define   KVM_DEV_VFIO_GROUP_ADD			1
>>>>>>>>>>  #define   KVM_DEV_VFIO_GROUP_DEL			2
>>>>>>>>>> +#define   KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE_LIOBN	3
>>>>>>>>>>
>>>>>>>>>>  enum kvm_device_type {
>>>>>>>>>>  	KVM_DEV_TYPE_FSL_MPIC_20	= 1,
>>>>>>>>>> @@ -1075,6 +1076,14 @@ enum kvm_device_type {
>>>>>>>>>>  	KVM_DEV_TYPE_MAX,
>>>>>>>>>>  };
>>>>>>>>>>
>>>>>>>>>> +struct kvm_vfio_spapr_tce_liobn {
>>>>>>>>>> +	__u32	argsz;
>>>>>>>>>> +	__s32	fd;
>>>>>>>>>> +	__u32	liobn;
>>>>>>>>>> +	__u8	pad[4];
>>>>>>>>>> +	__u64	start_addr;
>>>>>>>>>> +};
>>>>>>>>>> +
>>>>>>>>>>  /*
>>>>>>>>>>   * ioctls for VM fds
>>>>>>>>>>   */
>>>>>>>>>> diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
>>>>>>>>>> index 1dd087d..87c771e 100644
>>>>>>>>>> --- a/virt/kvm/vfio.c
>>>>>>>>>> +++ b/virt/kvm/vfio.c
>>>>>>>>>> @@ -20,6 +20,10 @@
>>>>>>>>>>  #include <linux/vfio.h>
>>>>>>>>>>  #include "vfio.h"
>>>>>>>>>>
>>>>>>>>>> +#ifdef CONFIG_SPAPR_TCE_IOMMU
>>>>>>>>>> +#include <asm/kvm_ppc.h>
>>>>>>>>>> +#endif
>>>>>>>>>> +
>>>>>>>>>>  struct kvm_vfio_group {
>>>>>>>>>>  	struct list_head node;
>>>>>>>>>>  	struct vfio_group *vfio_group;
>>>>>>>>>> @@ -60,6 +64,22 @@ static void
>>>>>> kvm_vfio_group_put_external_user(struct vfio_group *vfio_group)
>>>>>>>>>>  	symbol_put(vfio_group_put_external_user);
>>>>>>>>>>  }
>>>>>>>>>>
>>>>>>>>>> +static int kvm_vfio_external_user_iommu_id(struct vfio_group *vfio_group)
>>>>>>>>>> +{
>>>>>>>>>> +	int (*fn)(struct vfio_group *);
>>>>>>>>>> +	int ret = -1;
>>>>>>>>>
>>>>>>>>> Should this be -ESOMETHING?
>>>>>>>>>
>>>>>>>>>> +	fn = symbol_get(vfio_external_user_iommu_id);
>>>>>>>>>> +	if (!fn)
>>>>>>>>>> +		return ret;
>>>>>>>>>> +
>>>>>>>>>> +	ret = fn(vfio_group);
>>>>>>>>>> +
>>>>>>>>>> +	symbol_put(vfio_external_user_iommu_id);
>>>>>>>>>> +
>>>>>>>>>> +	return ret;
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>>  static bool kvm_vfio_group_is_coherent(struct vfio_group *vfio_group)
>>>>>>>>>>  {
>>>>>>>>>>  	long (*fn)(struct vfio_group *, unsigned long);
>>>>>>>>>> @@ -110,6 +130,22 @@ static void kvm_vfio_update_coherency(struct
>>>>>> kvm_device *dev)
>>>>>>>>>>  	mutex_unlock(&kv->lock);
>>>>>>>>>>  }
>>>>>>>>>>
>>>>>>>>>> +#ifdef CONFIG_SPAPR_TCE_IOMMU
>>>>>>>>>> +static void kvm_vfio_spapr_detach_iommu_group(struct kvm *kvm,
>>>>>>>>>> +		struct vfio_group *vfio_group)
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Shouldn't this go in the same patch that introduced the attach
>>>>>>>>> function?
>>>>>>>>
>>>>>>>> Having less patches which touch different maintainers areas is better. I
>>>>>>>> cannot avoid touching both PPC KVM and VFIO in this patch but I can in
>>>>>>>> "[PATCH kernel 6/9] KVM: PPC: Associate IOMMU group with guest view of TCE
>>>>>>>> table".
>>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>> +{
>>>>>>>>>> +	int group_id;
>>>>>>>>>> +	struct iommu_group *grp;
>>>>>>>>>> +
>>>>>>>>>> +	group_id = kvm_vfio_external_user_iommu_id(vfio_group);
>>>>>>>>>> +	grp = iommu_group_get_by_id(group_id);
>>>>>>>>>> +	if (grp) {
>>>>>>>>>> +		kvm_spapr_tce_detach_iommu_group(kvm, grp);
>>>>>>>>>> +		iommu_group_put(grp);
>>>>>>>>>> +	}
>>>>>>>>>> +}
>>>>>>>>>> +#endif
>>>>>>>>>> +
>>>>>>>>>>  static int kvm_vfio_set_group(struct kvm_device *dev, long attr, u64 arg)
>>>>>>>>>>  {
>>>>>>>>>>  	struct kvm_vfio *kv = dev->private;
>>>>>>>>>> @@ -186,6 +222,10 @@ static int kvm_vfio_set_group(struct kvm_device
>>>>>> *dev, long attr, u64 arg)
>>>>>>>>>>  				continue;
>>>>>>>>>>
>>>>>>>>>>  			list_del(&kvg->node);
>>>>>>>>>> +#ifdef CONFIG_SPAPR_TCE_IOMMU
>>>>>>>>>
>>>>>>>>> Better to make a no-op version of the call than have to #ifdef at the
>>>>>>>>> callsite.
>>>>>>>>
>>>>>>>> It is questionable. A x86 reader may decide that
>>>>>>>> KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE_LIOBN is implemented for x86 and get
>>>>>>>> confused.
>>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>> +			kvm_vfio_spapr_detach_iommu_group(dev->kvm,
>>>>>>>>>> +					kvg->vfio_group);
>>>>>>>>>> +#endif
>>>>>>>>>>  			kvm_vfio_group_put_external_user(kvg->vfio_group);
>>>>>>>>>>  			kfree(kvg);
>>>>>>>>>>  			ret = 0;
>>>>>>>>>> @@ -201,6 +241,69 @@ static int kvm_vfio_set_group(struct kvm_device
>>>>>> *dev, long attr, u64 arg)
>>>>>>>>>>  		kvm_vfio_update_coherency(dev);
>>>>>>>>>>
>>>>>>>>>>  		return ret;
>>>>>>>>>> +
>>>>>>>>>> +#ifdef CONFIG_SPAPR_TCE_IOMMU
>>>>>>>>>> +	case KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE_LIOBN: {
>>>>>>>>>> +		struct kvm_vfio_spapr_tce_liobn param;
>>>>>>>>>> +		unsigned long minsz;
>>>>>>>>>> +		struct kvm_vfio *kv = dev->private;
>>>>>>>>>> +		struct vfio_group *vfio_group;
>>>>>>>>>> +		struct kvm_vfio_group *kvg;
>>>>>>>>>> +		struct fd f;
>>>>>>>>>> +
>>>>>>>>>> +		minsz = offsetofend(struct kvm_vfio_spapr_tce_liobn,
>>>>>>>>>> +				start_addr);
>>>>>>>>>> +
>>>>>>>>>> +		if (copy_from_user(&param, (void __user *)arg, minsz))
>>>>>>>>>> +			return -EFAULT;
>>>>>>>>>> +
>>>>>>>>>> +		if (param.argsz < minsz)
>>>>>>>>>> +			return -EINVAL;
>>>>>>>>>> +
>>>>>>>>>> +		f = fdget(param.fd);
>>>>>>>>>> +		if (!f.file)
>>>>>>>>>> +			return -EBADF;
>>>>>>>>>> +
>>>>>>>>>> +		vfio_group = kvm_vfio_group_get_external_user(f.file);
>>>>>>>>>> +		fdput(f);
>>>>>>>>>> +
>>>>>>>>>> +		if (IS_ERR(vfio_group))
>>>>>>>>>> +			return PTR_ERR(vfio_group);
>>>>>>>>>> +
>>>>>>>>>> +		ret = -ENOENT;
>>>>>>>>>
>>>>>>>>> Shouldn't there be some runtime test for the type of the IOMMU?  It's
>>>>>>>>> possible a kernel could be built for a platform supporting multiple
>>>>>>>>> IOMMU types.
>>>>>>>>
>>>>>>>> Well, may make sense but I do not know to test that. The IOMMU type is a
>>>>>>>> VFIO container property, not a group property and here (KVM) we only have
>>>>>>>> groups.
>>>>>>>
>>>>>>> Which, as mentioned previously, is broken.
>>>>>>
>>>>>> Which I am failing to follow you on this.
>>>>>>
>>>>>> What I am trying to achieve here is pretty much referencing a group so it
>>>>>> cannot be reused. Plus LIOBNs.
>>>>>
>>>>> "Plus LIOBNs" is not a trivial change.  You are establishing a linkage
>>>> >from LIOBNs to groups.  But that doesn't make sense; if mapping in one
>>>>> (guest) LIOBN affects a group it must affect all groups in the
>>>>> container.  i.e. LIOBN->container is the natural mapping, *not* LIOBN
>>>>> to group.
>>>>
>>>> I can see your point but i don't see how to proceed now, I'm totally stuck.
>>>> Pass container fd and then implement new api to lock containers somehow and
>>>
>>> I'm not really understanding what the question is about locking containers.
>>>
>>>> enumerate groups when updating TCE table (including real mode)?
>>>
>>> Why do you need to enumerate groups?  The groups within the container
>>> share a TCE table, so can't you just update that once?
>>
>> Well, they share a TCE table but they do not share TCE Kill (TCE cache
>> invalidate) register address, it is still per PE but this does not matter
>> here (pnv_pci_link_table_and_group() does that), just mentioned to complete
>> the picture.
> 
> True, you'll need to enumerate the groups for invalidates.  But you
> need that already, right.
> 
>>>> Plus new API when we remove a group from a container as the result of guest
>>>> PCI hot unplug?
>>>
>>> I assume you mean a kernel internal API, since it shouldn't need
>>> anything else visible to userspace.  Won't this happen naturally?
>>> When the group is removed from the container, it will get its own TCE
>>> table instead of the previously shared one.
>>>
>>>>>> Passing a container fd does not make much
>>>>>> sense here as the VFIO device would walk through groups, reference them and
>>>>>> that is it, there is no locking on VFIO containters and so far there was no
>>>>>> need to teach KVM about containers.
>>>>>>
>>>>>> What do I miss now?
>>>>>
>>>>> Referencing the groups is essentially just a useful side effect.  The
>>>>> important functionality is informing VFIO of the guest LIOBNs; and
>>>>> LIOBNs map to containers, not groups.
>>>>
>>>> No. One liobn maps to one KVM-allocated TCE table, not a container. There
>>>> can be one or many or none containers per liobn.
>>>
>>> Ah, true.
>>
>> So I need to add new kernel API for KVM to get table(s) from VFIO
>> container(s). And invent some locking mechanism to prevent table(s) (or
>> associated container(s)) from going away, like
>> vfio_group_get_external_user/vfio_group_put_external_user but for
>> containers. Correct?
> 
> Well, the container is attached to an fd, so if you get a reference on
> the file* that should do it.

I am still trying to think of how to implement this suggestion.

I need a way to tell KVM about IOMMU groups. vfio-pci driver is not right
interface as it knows nothing about KVM. There is VFIO-KVM device but it
does not have idea about containers.

So I have to:

Wenever a container is created or removed, notify the VFIO-KVM device by
passing there a container fd. ok.

Then VFIO-KVM device needs to tell KVM about what iommu_table belongs to
what LIOBN so the realmode handlers could do the job. The real mode TCE
handlers get LIOBN, find a guest view table and update it. Now I want to
update the hardware table which is iommu_table attached to LIOBN.

I did pass an IOMMU group fd to VFIO-KVM device. You suggested a container fd.

Now VFIO-KVM device needs to extract iommu_table's from the container.
These iommu_table pointers are stored in "struct tce_container" which is
local to drivers/vfio/vfio_iommu_spapr_tce.c and not exported anyhow. So I
cannot export and use that.

The other way to go would be adding API to VFIO to enumerate IOMMU groups
in a container and use iommu_table pointers stored in iommu_table_group of
each group (in fact the very first group will be enough as multiple groups
in a container share the table). Adding vfio_container_get_groups() when
only first one is needed is quite tricky in terms of maintainers approvals.

So what would be the right course of action? Thanks.


-- 
Alexey
