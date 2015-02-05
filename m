Return-Path: <aik@ozlabs.ru>
Received: from mail-pd0-f182.google.com (mail-pd0-f182.google.com
 [209.85.192.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 03A4E1A00B0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Feb 2015 15:59:01 +1100 (AEDT)
Received: by pdbfl12 with SMTP id fl12so5349566pdb.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Feb 2015 20:58:59 -0800 (PST)
Message-ID: <54D2F86A.3040501@ozlabs.ru>
Date: Thu, 05 Feb 2015 15:58:18 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v3 08/24] powerpc/spapr: vfio: Switch from iommu_table
 to new powerpc_iommu
References: <1422523325-1389-1-git-send-email-aik@ozlabs.ru>	
 <1422523325-1389-9-git-send-email-aik@ozlabs.ru>
 <1422922365.22865.448.camel@redhat.com> <54D21F67.70307@suse.de>
In-Reply-To: <54D21F67.70307@suse.de>
Content-Type: text/plain; charset=koi8-r
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Alexander Gordeev <agordeev@redhat.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/05/2015 12:32 AM, Alexander Graf wrote:
> 
> 
> On 03.02.15 01:12, Alex Williamson wrote:
>> On Thu, 2015-01-29 at 20:21 +1100, Alexey Kardashevskiy wrote:
>>> Modern IBM POWERPC systems support multiple (currently two) TCE tables
>>> per IOMMU group (a.k.a. PE). This adds a powerpc_iommu container
>>> for TCE tables. Right now just one table is supported.
>>>
>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>> ---
>>>  arch/powerpc/include/asm/iommu.h            |  18 ++--
>>>  arch/powerpc/kernel/eeh.c                   |   2 +-
>>>  arch/powerpc/kernel/iommu.c                 |  34 ++++----
>>>  arch/powerpc/platforms/powernv/pci-ioda.c   |  37 +++++---
>>>  arch/powerpc/platforms/powernv/pci-p5ioc2.c |  16 ++--
>>>  arch/powerpc/platforms/powernv/pci.c        |   2 +-
>>>  arch/powerpc/platforms/powernv/pci.h        |   4 +-
>>>  arch/powerpc/platforms/pseries/iommu.c      |   9 +-
>>>  drivers/vfio/vfio_iommu_spapr_tce.c         | 131 ++++++++++++++++++++--------
>>>  9 files changed, 170 insertions(+), 83 deletions(-)
>> [snip]
>>> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
>>> index 29d5708..28909e1 100644
>>> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
>>> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
>>> @@ -84,7 +84,7 @@ static void decrement_locked_vm(long npages)
>>>   */
>>>  struct tce_container {
>>>  	struct mutex lock;
>>> -	struct iommu_table *tbl;
>>> +	struct iommu_group *grp;
>>>  	bool enabled;
>>>  };
>>>  
>>> @@ -104,16 +104,40 @@ static bool tce_check_page_size(struct page *page, unsigned page_shift)
>>>  	return false;
>>>  }
>>>  
>>> +static struct iommu_table *spapr_tce_find_table(
>>> +		struct tce_container *container,
>>> +		phys_addr_t ioba)
>>> +{
>>> +	long i;
>>> +	struct iommu_table *ret = NULL;
>>> +	struct powerpc_iommu *iommu = iommu_group_get_iommudata(container->grp);
>>> +
>>> +	mutex_lock(&container->lock);
>>> +	for (i = 0; i < POWERPC_IOMMU_MAX_TABLES; ++i) {
>>> +		struct iommu_table *tbl = &iommu->tables[i];
>>> +		unsigned long entry = ioba >> tbl->it_page_shift;
>>> +		unsigned long start = tbl->it_offset;
>>> +		unsigned long end = start + tbl->it_size;
>>> +
>>> +		if ((start <= entry) && (entry < end)) {
>>> +			ret = tbl;
>>> +			break;
>>> +		}
>>> +	}
>>> +	mutex_unlock(&container->lock);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>>  static int tce_iommu_enable(struct tce_container *container)
>>>  {
>>>  	int ret = 0;
>>> +	struct powerpc_iommu *iommu;
>>> +	struct iommu_table *tbl;
>>>  
>>> -	if (!container->tbl)
>>> +	if (!container->grp)
>>>  		return -ENXIO;
>>>  
>>> -	if (!current->mm)
>>> -		return -ESRCH; /* process exited */
>>> -
>>>  	if (container->enabled)
>>>  		return -EBUSY;
>>>  
>>> @@ -142,7 +166,12 @@ static int tce_iommu_enable(struct tce_container *container)
>>>  	 * as this information is only available from KVM and VFIO is
>>>  	 * KVM agnostic.
>>>  	 */
>>> -	ret = try_increment_locked_vm(IOMMU_TABLE_PAGES(container->tbl));
>>> +	iommu = iommu_group_get_iommudata(container->grp);
>>> +	if (!iommu)
>>> +		return -EFAULT;
>>> +
>>> +	tbl = &iommu->tables[0];
>>
>>
>> There should probably be a comment somewhere documenting that tables[0]
>> is the small window and presumably [1] will be the DDW.
> 
> Rather than a comment, how about an enum?


[0] could be DDW if the guest decides to remove the default window and
create one huge in its place - older guests (sles11sp3) did that (but they
could not cope with the huge window starting from zero), newer guests do
not try removing the default window but they might want to do this later.

So I am not so sure what kind of comment would be good here...



-- 
Alexey
