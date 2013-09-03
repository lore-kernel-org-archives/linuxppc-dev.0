Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 163EB2C00AF
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Sep 2013 13:15:52 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Tue, 3 Sep 2013 13:12:29 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id CF8652CE8055
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Sep 2013 13:15:46 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r833FZaw10813802
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Sep 2013 13:15:35 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r833Fk5S015355
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Sep 2013 13:15:46 +1000
Date: Tue, 3 Sep 2013 11:15:44 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] iommu: WARN_ON when removing a device with no
 iommu_group associated
Message-ID: <20130903031544.GA16232@weiyang.vnet.ibm.com>
References: <1377222911-12144-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1377228807.25163.33.camel@ul30vt.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1377228807.25163.33.camel@ul30vt.home>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, benh@au1.ibm.com, aik@ozlabs.ru,
 linux-kernel@vger.kernel.org, iommu <iommu@lists.linux-foundation.org>,
 paulus@au1.ibm.com, linuxppc-dev@lists.ozlabs.org
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Any more comments? Or this one is not proper?

On Thu, Aug 22, 2013 at 09:33:27PM -0600, Alex Williamson wrote:
>[+cc iommu]
>
>On Fri, 2013-08-23 at 09:55 +0800, Wei Yang wrote:
>> When removing a device from the system, iommu_group driver will try to
>> disconnect it from its group. While in some cases, one device may not
>> associated with any iommu_group. For example, not enough DMA address space.
>> 
>> In the generic bus notification, it will check dev->iommu_group before calling
>> iommu_group_remove_device(). While in some cases, developers may call
>> iommu_group_remove_device() in a different code path and without check. For
>> those devices with dev->iommu_group set to NULL, kernel will crash.
>> 
>> This patch gives a warning and return when trying to remove a device from an
>> iommu_group with dev->iommu_group set to NULL. This helps to indicate some bad
>> behavior and also guard the kernel.
>> 
>> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>
>Acked-by: Alex Williamson <alex.williamson@redhat.com>
>
>> ---
>>  drivers/iommu/iommu.c |    3 +++
>>  1 files changed, 3 insertions(+), 0 deletions(-)
>> 
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index fbe9ca7..43396f0 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -379,6 +379,9 @@ void iommu_group_remove_device(struct device *dev)
>>  	struct iommu_group *group = dev->iommu_group;
>>  	struct iommu_device *tmp_device, *device = NULL;
>>  
>> +	if (WARN_ON(!group))
>> +		return;
>> +
>>  	/* Pre-notify listeners that a device is being removed. */
>>  	blocking_notifier_call_chain(&group->notifier,
>>  				     IOMMU_GROUP_NOTIFY_DEL_DEVICE, dev);
>
>

-- 
Richard Yang
Help you, Help me
