Return-Path: <aik@ozlabs.ru>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vy4Y01m3fzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 20:12:52 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id 81so36263021pgh.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Apr 2017 03:12:52 -0700 (PDT)
Subject: Re: [PATCH guest kernel] vfio/powerpc/spapr_tce: Enforce IOMMU type
 compatibility check
To: Alex Williamson <alex.williamson@redhat.com>
References: <20170324064406.17076-1-aik@ozlabs.ru>
 <20170324142905.3129266b@t450s.home>
 <d6909bd7-e861-03b0-cb32-bffaefaf518f@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson
 <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <7e067e71-ecde-6515-0b27-202a1ce4948a@ozlabs.ru>
Date: Tue, 4 Apr 2017 20:12:45 +1000
MIME-Version: 1.0
In-Reply-To: <d6909bd7-e861-03b0-cb32-bffaefaf518f@ozlabs.ru>
Content-Type: text/plain; charset=koi8-r
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 25/03/17 23:25, Alexey Kardashevskiy wrote:
> On 25/03/17 07:29, Alex Williamson wrote:
>> On Fri, 24 Mar 2017 17:44:06 +1100
>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>
>>> The existing SPAPR TCE driver advertises both VFIO_SPAPR_TCE_IOMMU and
>>> VFIO_SPAPR_TCE_v2_IOMMU types to the userspace and the userspace usually
>>> picks the v2.
>>>
>>> Normally the userspace would create a container, attach an IOMMU group
>>> to it and only then set the IOMMU type (which would normally be v2).
>>>
>>> However a specific IOMMU group may not support v2, in other words
>>> it may not implement set_window/unset_window/take_ownership/
>>> release_ownership and such a group should not be attached to
>>> a v2 container.
>>>
>>> This adds extra checks that a new group can do what the selected IOMMU
>>> type suggests. The userspace can then test the return value from
>>> ioctl(VFIO_SET_IOMMU, VFIO_SPAPR_TCE_v2_IOMMU) and try
>>> VFIO_SPAPR_TCE_IOMMU.
>>>
>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>> ---
>>>
>>> This is one of the patches needed to do nested VFIO - for either
>>> second level guest or DPDK running in a guest.
>>> ---
>>>  drivers/vfio/vfio_iommu_spapr_tce.c | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>
>> I'm not sure I understand why you're labeling this "guest kernel", is a
> 
> 
> That is my script :)
> 
>> VM the only case where we can have combinations that only a subset of
>> the groups might support v2?  
> 
> powernv (non-virtualized, and it runs HV KVM) host provides v2-capable
> groups, they all the same, and a pseries host (which normally runs as a
> guest but it can do nested KVM as well - it is called PR KVM) can do only
> v1 (after this patch, without it - no vfio at all).
> 
>> What terrible things happen when such a
>> combination is created?
> 
> There is no mixture at the moment, I just needed a way to tell userspace
> that a group cannot do v2.
> 
>> The fix itself seems sane, but I'm trying to
>> figure out whether it should be marked for stable, should go in for
>> v4.11, or be queued for v4.12.  Thanks,
> 
> No need for stable.


So what is the next step with this patch?


> 
> 
>>
>> Alex
>>
>>> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
>>> index cf3de91fbfe7..a7d811524092 100644
>>> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
>>> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
>>> @@ -1335,8 +1335,16 @@ static int tce_iommu_attach_group(void *iommu_data,
>>>  
>>>  	if (!table_group->ops || !table_group->ops->take_ownership ||
>>>  			!table_group->ops->release_ownership) {
>>> +		if (container->v2) {
>>> +			ret = -EPERM;
>>> +			goto unlock_exit;
>>> +		}
>>>  		ret = tce_iommu_take_ownership(container, table_group);
>>>  	} else {
>>> +		if (!container->v2) {
>>> +			ret = -EPERM;
>>> +			goto unlock_exit;
>>> +		}
>>>  		ret = tce_iommu_take_ownership_ddw(container, table_group);
>>>  		if (!tce_groups_attached(container) && !container->tables[0])
>>>  			container->def_window_pending = true;
>>
> 
> 


-- 
Alexey
