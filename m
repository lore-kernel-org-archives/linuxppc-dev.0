Return-Path: <aik@ozlabs.ru>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tjG9s6L22zDwdq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 09:41:37 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id b1so9630217pgc.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 14:41:37 -0800 (PST)
Subject: Re: [PATCH kernel v2 10/11] vfio: Check for unregistered notifiers
 when group is actually released
To: Alex Williamson <alex.williamson@redhat.com>,
 Jike Song <jike.song@intel.com>
References: <20161218012900.18142-1-aik@ozlabs.ru>
 <20161218012900.18142-11-aik@ozlabs.ru> <5857B941.2060805@intel.com>
 <20161219092805.1887ea5d@t450s.home>
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson
 <david@gibson.dropbear.id.au>, Paul Mackerras <paulus@samba.org>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <533b7e4c-8c3a-5c37-4c25-66bdbd265ec5@ozlabs.ru>
Date: Tue, 20 Dec 2016 09:41:29 +1100
MIME-Version: 1.0
In-Reply-To: <20161219092805.1887ea5d@t450s.home>
Content-Type: text/plain; charset=koi8-r
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 20/12/16 03:28, Alex Williamson wrote:
> On Mon, 19 Dec 2016 18:41:05 +0800
> Jike Song <jike.song@intel.com> wrote:
> 
>> On 12/18/2016 09:28 AM, Alexey Kardashevskiy wrote:
>>> This moves a check for unregistered notifiers from fops release
>>> callback to the place where the group will actually be released.
>>>
>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>> ---
>>>
>>> This is going to be used in the following patch in cleanup
>>> path. Since the next patch is RFC, this one might not be needed.  
> 
> Alexey, this is intended to be a bug fix, it should be sent separately,
> not buried in an unrelated patch series.

Well, I was pretty unsure this is a correct fix and I was sure that it
would make sense without the context which is quite weird :)

> 
>> I didn't find any use in the following patch 11/11, did you mean
>> something else?
>>
>> BTW the warning in vfio_group_release seems too late, the user
>> should actually unregister everything by close()?
> 
> The thing is, it's not the user that registered the notifiers, it's the
> vendor driver.  The vendor driver should know via the device release to
> unregister the notifier, which we're counting on to happen before the
> group release.  Can we rely on that ordering even in the case where a
> user is SIGKILL'd?
> 
>>> ---
>>>  drivers/vfio/vfio.c | 5 ++---
>>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
>>> index 6b9a98508939..083b581e87c0 100644
>>> --- a/drivers/vfio/vfio.c
>>> +++ b/drivers/vfio/vfio.c
>>> @@ -403,6 +403,8 @@ static void vfio_group_release(struct kref *kref)
>>>  	struct iommu_group *iommu_group = group->iommu_group;
>>>  
>>>  	WARN_ON(!list_empty(&group->device_list));
>>> +	/* Any user didn't unregister? */
>>> +	WARN_ON(group->notifier.head);
> 
> Even if this is a bug, this is the wrong fix.  This is when the group
> is being destroyed.  Yes, it would be a bug to still have any notifiers
> here, but the intention is to make sure there are no notifiers when the
> group is idle and unused.

Out of curiosity - vendor drivers are supposed to hold a group file open,
not just reference vfio_grop/iommu_group objects?



> 
>>>  
>>>  	list_for_each_entry_safe(unbound, tmp,
>>>  				 &group->unbound_list, unbound_next) {
>>> @@ -1584,9 +1586,6 @@ static int vfio_group_fops_release(struct inode *inode, struct file *filep)
>>>  
>>>  	filep->private_data = NULL;
>>>  
>>> -	/* Any user didn't unregister? */
>>> -	WARN_ON(group->notifier.head);
>>> -
>>>  	vfio_group_try_dissolve_container(group);
>>>  
>>>  	atomic_dec(&group->opened);
>>>   
> 


-- 
Alexey
