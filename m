Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9DB971A09DD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Feb 2015 00:32:31 +1100 (AEDT)
Message-ID: <54D21F67.70307@suse.de>
Date: Wed, 04 Feb 2015 14:32:23 +0100
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@redhat.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH v3 08/24] powerpc/spapr: vfio: Switch from iommu_table
 to new powerpc_iommu
References: <1422523325-1389-1-git-send-email-aik@ozlabs.ru>	
 <1422523325-1389-9-git-send-email-aik@ozlabs.ru>
 <1422922365.22865.448.camel@redhat.com>
In-Reply-To: <1422922365.22865.448.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
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



On 03.02.15 01:12, Alex Williamson wrote:
> On Thu, 2015-01-29 at 20:21 +1100, Alexey Kardashevskiy wrote:
>> Modern IBM POWERPC systems support multiple (currently two) TCE tables
>> per IOMMU group (a.k.a. PE). This adds a powerpc_iommu container
>> for TCE tables. Right now just one table is supported.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>  arch/powerpc/include/asm/iommu.h            |  18 ++--
>>  arch/powerpc/kernel/eeh.c                   |   2 +-
>>  arch/powerpc/kernel/iommu.c                 |  34 ++++----
>>  arch/powerpc/platforms/powernv/pci-ioda.c   |  37 +++++---
>>  arch/powerpc/platforms/powernv/pci-p5ioc2.c |  16 ++--
>>  arch/powerpc/platforms/powernv/pci.c        |   2 +-
>>  arch/powerpc/platforms/powernv/pci.h        |   4 +-
>>  arch/powerpc/platforms/pseries/iommu.c      |   9 +-
>>  drivers/vfio/vfio_iommu_spapr_tce.c         | 131 ++++++++++++++++++++--------
>>  9 files changed, 170 insertions(+), 83 deletions(-)
> [snip]
>> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
>> index 29d5708..28909e1 100644
>> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
>> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
>> @@ -84,7 +84,7 @@ static void decrement_locked_vm(long npages)
>>   */
>>  struct tce_container {
>>  	struct mutex lock;
>> -	struct iommu_table *tbl;
>> +	struct iommu_group *grp;
>>  	bool enabled;
>>  };
>>  
>> @@ -104,16 +104,40 @@ static bool tce_check_page_size(struct page *page, unsigned page_shift)
>>  	return false;
>>  }
>>  
>> +static struct iommu_table *spapr_tce_find_table(
>> +		struct tce_container *container,
>> +		phys_addr_t ioba)
>> +{
>> +	long i;
>> +	struct iommu_table *ret = NULL;
>> +	struct powerpc_iommu *iommu = iommu_group_get_iommudata(container->grp);
>> +
>> +	mutex_lock(&container->lock);
>> +	for (i = 0; i < POWERPC_IOMMU_MAX_TABLES; ++i) {
>> +		struct iommu_table *tbl = &iommu->tables[i];
>> +		unsigned long entry = ioba >> tbl->it_page_shift;
>> +		unsigned long start = tbl->it_offset;
>> +		unsigned long end = start + tbl->it_size;
>> +
>> +		if ((start <= entry) && (entry < end)) {
>> +			ret = tbl;
>> +			break;
>> +		}
>> +	}
>> +	mutex_unlock(&container->lock);
>> +
>> +	return ret;
>> +}
>> +
>>  static int tce_iommu_enable(struct tce_container *container)
>>  {
>>  	int ret = 0;
>> +	struct powerpc_iommu *iommu;
>> +	struct iommu_table *tbl;
>>  
>> -	if (!container->tbl)
>> +	if (!container->grp)
>>  		return -ENXIO;
>>  
>> -	if (!current->mm)
>> -		return -ESRCH; /* process exited */
>> -
>>  	if (container->enabled)
>>  		return -EBUSY;
>>  
>> @@ -142,7 +166,12 @@ static int tce_iommu_enable(struct tce_container *container)
>>  	 * as this information is only available from KVM and VFIO is
>>  	 * KVM agnostic.
>>  	 */
>> -	ret = try_increment_locked_vm(IOMMU_TABLE_PAGES(container->tbl));
>> +	iommu = iommu_group_get_iommudata(container->grp);
>> +	if (!iommu)
>> +		return -EFAULT;
>> +
>> +	tbl = &iommu->tables[0];
> 
> 
> There should probably be a comment somewhere documenting that tables[0]
> is the small window and presumably [1] will be the DDW.

Rather than a comment, how about an enum?


Alex
