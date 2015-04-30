Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
 [209.85.220.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 29D641A06CF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 12:29:39 +1000 (AEST)
Received: by pacwv17 with SMTP id wv17so45342740pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 19:29:37 -0700 (PDT)
Message-ID: <5541938A.6050803@ozlabs.ru>
Date: Thu, 30 Apr 2015 12:29:30 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel v9 09/32] vfio: powerpc/spapr: Rework groups
 attaching
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-10-git-send-email-aik@ozlabs.ru>
 <20150429021618.GH32589@voom.redhat.com>
In-Reply-To: <20150429021618.GH32589@voom.redhat.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/29/2015 12:16 PM, David Gibson wrote:
> On Sat, Apr 25, 2015 at 10:14:33PM +1000, Alexey Kardashevskiy wrote:
>> This is to make extended ownership and multiple groups support patches
>> simpler for review.
>>
>> This should cause no behavioural change.
>
> Um.. this doesn't appear to be true.  Previously removing a group from
> an enabled container would fail with EBUSY, now it forces a disable.


This is the original tce_iommu_detach_group() where I cannot find EBUSY you 
are referring to; it did and does enforce disable. What do I miss here?

static void tce_iommu_detach_group(void *iommu_data,
                 struct iommu_group *iommu_group)
{
         struct tce_container *container = iommu_data;
         struct iommu_table *tbl = iommu_group_get_iommudata(iommu_group);

         BUG_ON(!tbl);
         mutex_lock(&container->lock);
         if (tbl != container->tbl) {
                 pr_warn("tce_vfio: detaching group #%u, expected group is 
#%u\n",
                                 iommu_group_id(iommu_group),
                                 iommu_group_id(tbl->it_group));
         } else {
                 if (container->enabled) {
                         pr_warn("tce_vfio: detaching group #%u from 
enabled container, forcing disable\n",
                                         iommu_group_id(tbl->it_group));
                         tce_iommu_disable(container);
                 }

                 /* pr_debug("tce_vfio: detaching group #%u from iommu %p\n",
                                 iommu_group_id(iommu_group), iommu_group); */
                 container->tbl = NULL;
                 tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
                 iommu_release_ownership(tbl);
         }
         mutex_unlock(&container->lock);
}



>
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> [aw: for the vfio related changes]
>> Acked-by: Alex Williamson <alex.williamson@redhat.com>
>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>> ---
>>   drivers/vfio/vfio_iommu_spapr_tce.c | 40 ++++++++++++++++++++++---------------
>>   1 file changed, 24 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
>> index 115d5e6..0fbe03e 100644
>> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
>> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
>> @@ -460,16 +460,21 @@ static int tce_iommu_attach_group(void *iommu_data,
>>   				iommu_group_id(container->tbl->it_group),
>>   				iommu_group_id(iommu_group));
>>   		ret = -EBUSY;
>> -	} else if (container->enabled) {
>> +		goto unlock_exit;
>> +	}
>> +
>> +	if (container->enabled) {
>>   		pr_err("tce_vfio: attaching group #%u to enabled container\n",
>>   				iommu_group_id(iommu_group));
>>   		ret = -EBUSY;
>> -	} else {
>> -		ret = iommu_take_ownership(tbl);
>> -		if (!ret)
>> -			container->tbl = tbl;
>> +		goto unlock_exit;
>>   	}
>>
>> +	ret = iommu_take_ownership(tbl);
>> +	if (!ret)
>> +		container->tbl = tbl;
>> +
>> +unlock_exit:
>>   	mutex_unlock(&container->lock);
>>
>>   	return ret;
>> @@ -487,19 +492,22 @@ static void tce_iommu_detach_group(void *iommu_data,
>>   		pr_warn("tce_vfio: detaching group #%u, expected group is #%u\n",
>>   				iommu_group_id(iommu_group),
>>   				iommu_group_id(tbl->it_group));
>> -	} else {
>> -		if (container->enabled) {
>> -			pr_warn("tce_vfio: detaching group #%u from enabled container, forcing disable\n",
>> -					iommu_group_id(tbl->it_group));
>> -			tce_iommu_disable(container);
>> -		}
>> +		goto unlock_exit;
>> +	}
>>
>> -		/* pr_debug("tce_vfio: detaching group #%u from iommu %p\n",
>> -				iommu_group_id(iommu_group), iommu_group); */
>> -		container->tbl = NULL;
>> -		tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
>> -		iommu_release_ownership(tbl);
>> +	if (container->enabled) {
>> +		pr_warn("tce_vfio: detaching group #%u from enabled container, forcing disable\n",
>> +				iommu_group_id(tbl->it_group));
>> +		tce_iommu_disable(container);
>>   	}
>> +
>> +	/* pr_debug("tce_vfio: detaching group #%u from iommu %p\n",
>> +	   iommu_group_id(iommu_group), iommu_group); */
>> +	container->tbl = NULL;
>> +	tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
>> +	iommu_release_ownership(tbl);
>> +
>> +unlock_exit:
>>   	mutex_unlock(&container->lock);
>>   }
>>
>


-- 
Alexey
