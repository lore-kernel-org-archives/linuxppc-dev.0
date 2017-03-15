Return-Path: <aik@ozlabs.ru>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vk7P16f7HzDqYX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 10:39:33 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id m5so3809074pgk.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 16:39:33 -0700 (PDT)
Subject: Re: [PATCH kernel v8 10/10] KVM: PPC: VFIO: Add in-kernel
 acceleration for VFIO
To: Alex Williamson <alex.williamson@redhat.com>
References: <20170310035337.22091-1-aik@ozlabs.ru>
 <20170310035337.22091-11-aik@ozlabs.ru> <20170314150527.1c46c3c8@t450s.home>
 <5afcdeee-96f7-f1fd-5f4f-20071f4395a6@ozlabs.ru>
 <20170315103904.4f38c021@t450s.home>
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson
 <david@gibson.dropbear.id.au>, Paul Mackerras <paulus@samba.org>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <604d4c55-1061-f85c-87d3-638ea348b2f7@ozlabs.ru>
Date: Thu, 16 Mar 2017 10:39:25 +1100
MIME-Version: 1.0
In-Reply-To: <20170315103904.4f38c021@t450s.home>
Content-Type: text/plain; charset=koi8-r
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 16/03/17 03:39, Alex Williamson wrote:
> On Thu, 16 Mar 2017 00:21:07 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> 
>> On 15/03/17 08:05, Alex Williamson wrote:
>>> On Fri, 10 Mar 2017 14:53:37 +1100
>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>>   
>>>> This allows the host kernel to handle H_PUT_TCE, H_PUT_TCE_INDIRECT
>>>> and H_STUFF_TCE requests targeted an IOMMU TCE table used for VFIO
>>>> without passing them to user space which saves time on switching
>>>> to user space and back.
>>>>
>>>> This adds H_PUT_TCE/H_PUT_TCE_INDIRECT/H_STUFF_TCE handlers to KVM.
>>>> KVM tries to handle a TCE request in the real mode, if failed
>>>> it passes the request to the virtual mode to complete the operation.
>>>> If it a virtual mode handler fails, the request is passed to
>>>> the user space; this is not expected to happen though.
>>>>
>>>> To avoid dealing with page use counters (which is tricky in real mode),
>>>> this only accelerates SPAPR TCE IOMMU v2 clients which are required
>>>> to pre-register the userspace memory. The very first TCE request will
>>>> be handled in the VFIO SPAPR TCE driver anyway as the userspace view
>>>> of the TCE table (iommu_table::it_userspace) is not allocated till
>>>> the very first mapping happens and we cannot call vmalloc in real mode.
>>>>
>>>> If we fail to update a hardware IOMMU table unexpected reason, we just
>>>> clear it and move on as there is nothing really we can do about it -
>>>> for example, if we hot plug a VFIO device to a guest, existing TCE tables
>>>> will be mirrored automatically to the hardware and there is no interface
>>>> to report to the guest about possible failures.
>>>>
>>>> This adds new attribute - KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE - to
>>>> the VFIO KVM device. It takes a VFIO group fd and SPAPR TCE table fd
>>>> and associates a physical IOMMU table with the SPAPR TCE table (which
>>>> is a guest view of the hardware IOMMU table). The iommu_table object
>>>> is cached and referenced so we do not have to look up for it in real mode.
>>>>
>>>> This does not implement the UNSET counterpart as there is no use for it -
>>>> once the acceleration is enabled, the existing userspace won't
>>>> disable it unless a VFIO container is destroyed; this adds necessary
>>>> cleanup to the KVM_DEV_VFIO_GROUP_DEL handler.
>>>>
>>>> As this creates a descriptor per IOMMU table-LIOBN couple (called
>>>> kvmppc_spapr_tce_iommu_table), it is possible to have several
>>>> descriptors with the same iommu_table (hardware IOMMU table) attached
>>>> to the same LIOBN; we do not remove duplicates though as
>>>> iommu_table_ops::exchange not just update a TCE entry (which is
>>>> shared among IOMMU groups) but also invalidates the TCE cache
>>>> (one per IOMMU group).
>>>>
>>>> This advertises the new KVM_CAP_SPAPR_TCE_VFIO capability to the user
>>>> space.
>>>>
>>>> This adds real mode version of WARN_ON_ONCE() as the generic version
>>>> causes problems with rcu_sched. Since we testing what vmalloc_to_phys()
>>>> returns in the code, this also adds a check for already existing
>>>> vmalloc_to_phys() call in kvmppc_rm_h_put_tce_indirect().
>>>>
>>>> This finally makes use of vfio_external_user_iommu_id() which was
>>>> introduced quite some time ago and was considered for removal.
>>>>
>>>> Tests show that this patch increases transmission speed from 220MB/s
>>>> to 750..1020MB/s on 10Gb network (Chelsea CXGB3 10Gb ethernet card).
>>>>
>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>> ---
>>>> Changes:
>>>> v8:
>>>> * changed all (!pua) checks to return H_TOO_HARD as ioctl() is supposed
>>>> to handle them
>>>> * changed vmalloc_to_phys() callers to return H_HARDWARE
>>>> * changed real mode iommu_tce_xchg_rm() callers to return H_TOO_HARD
>>>> and added a comment about this in the code
>>>> * changed virtual mode iommu_tce_xchg() callers to return H_HARDWARE
>>>> and do WARN_ON
>>>> * added WARN_ON_ONCE_RM(!rmap) in kvmppc_rm_h_put_tce_indirect() to
>>>> have all vmalloc_to_phys() callsites covered
>>>>
>>>> v7:
>>>> * added realmode-friendly WARN_ON_ONCE_RM
>>>>
>>>> v6:
>>>> * changed handling of errors returned by kvmppc_(rm_)tce_iommu_(un)map()
>>>> * moved kvmppc_gpa_to_ua() to TCE validation
>>>>
>>>> v5:
>>>> * changed error codes in multiple places
>>>> * added bunch of WARN_ON() in places which should not really happen
>>>> * adde a check that an iommu table is not attached already to LIOBN
>>>> * dropped explicit calls to iommu_tce_clear_param_check/
>>>> iommu_tce_put_param_check as kvmppc_tce_validate/kvmppc_ioba_validate
>>>> call them anyway (since the previous patch)
>>>> * if we fail to update a hardware IOMMU table for unexpected reason,
>>>> this just clears the entry
>>>>
>>>> v4:
>>>> * added note to the commit log about allowing multiple updates of
>>>> the same IOMMU table;
>>>> * instead of checking for if any memory was preregistered, this
>>>> returns H_TOO_HARD if a specific page was not;
>>>> * fixed comments from v3 about error handling in many places;
>>>> * simplified TCE handlers and merged IOMMU parts inline - for example,
>>>> there used to be kvmppc_h_put_tce_iommu(), now it is merged into
>>>> kvmppc_h_put_tce(); this allows to check IOBA boundaries against
>>>> the first attached table only (makes the code simpler);
>>>>
>>>> v3:
>>>> * simplified not to use VFIO group notifiers
>>>> * reworked cleanup, should be cleaner/simpler now
>>>>
>>>> v2:
>>>> * reworked to use new VFIO notifiers
>>>> * now same iommu_table may appear in the list several times, to be fixed later
>>>> ---
>>>>  Documentation/virtual/kvm/devices/vfio.txt |  22 +-
>>>>  arch/powerpc/include/asm/kvm_host.h        |   8 +
>>>>  arch/powerpc/include/asm/kvm_ppc.h         |   4 +
>>>>  include/uapi/linux/kvm.h                   |   8 +
>>>>  arch/powerpc/kvm/book3s_64_vio.c           | 323 ++++++++++++++++++++++++++++-
>>>>  arch/powerpc/kvm/book3s_64_vio_hv.c        | 201 +++++++++++++++++-
>>>>  arch/powerpc/kvm/powerpc.c                 |   2 +
>>>>  virt/kvm/vfio.c                            |  60 ++++++
>>>>  8 files changed, 623 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/Documentation/virtual/kvm/devices/vfio.txt b/Documentation/virtual/kvm/devices/vfio.txt
>>>> index ef51740c67ca..f95d867168ea 100644
>>>> --- a/Documentation/virtual/kvm/devices/vfio.txt
>>>> +++ b/Documentation/virtual/kvm/devices/vfio.txt
>>>> @@ -16,7 +16,25 @@ Groups:
>>>>  
>>>>  KVM_DEV_VFIO_GROUP attributes:
>>>>    KVM_DEV_VFIO_GROUP_ADD: Add a VFIO group to VFIO-KVM device tracking
>>>> +	kvm_device_attr.addr points to an int32_t file descriptor
>>>> +	for the VFIO group.
>>>>    KVM_DEV_VFIO_GROUP_DEL: Remove a VFIO group from VFIO-KVM device tracking
>>>> +	kvm_device_attr.addr points to an int32_t file descriptor
>>>> +	for the VFIO group.
>>>> +  KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE: attaches a guest visible TCE table
>>>> +	allocated by sPAPR KVM.
>>>> +	kvm_device_attr.addr points to a struct:
>>>>  
>>>> -For each, kvm_device_attr.addr points to an int32_t file descriptor
>>>> -for the VFIO group.
>>>> +	struct kvm_vfio_spapr_tce {
>>>> +		__u32	argsz;
>>>> +		__u32	flags;
>>>> +		__s32	groupfd;
>>>> +		__s32	tablefd;
>>>> +	};
>>>> +
>>>> +	where
>>>> +	@argsz is the size of kvm_vfio_spapr_tce_liobn;  
>>>
>>> kvm_vfio_spapr_tce_liobn does not exist.  s/_liobn//?  
>>
>> Correct.
>>
>>
>>>   
>>>> +	@flags are not supported now, must be zero;  
>>>
>>> We do this argsz/flags thing on vfio ioctls because ioctls are a bit
>>> more of a restricted resource.  We don't want to burn through them so
>>> we make them expandable.  I don't know that we have that restriction
>>> here and the ADD/DEL support certainly doesn't include it.  Maybe this
>>> isn't necessary?  
>>
>>
>> It is not but since I am going to have padding there, I thought I give it a
>> name. Totally pointless and "u8 padding[4]" is better?
> 
> Or since these are not ioctls, we simply consider them to have a very
> specific and limited purpose.  If we have a need to expand on that,
> define a new one that either builds on the existing ones, as
> GROUP_SET_SPAPR_TCE builds on GROUP_ADD, or supersedes them.  For
> ioctls, it's more costly if we abandon one, here it doesn't seem like a
> big deal.  Thanks,

Did you just suggest ditching the extra 4 bytes now? Sorry, I am not
following you here. I am just saying that having 3*u32 while the actual
size is 4*u32 is not good for binary interface.

Also, you have not noticed my other comment about ditching the group
reference or decided to leave it for David to comment? :) Thanks.



-- 
Alexey
