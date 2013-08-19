Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 58DE72C0191
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 11:29:56 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Mon, 19 Aug 2013 06:50:55 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id C634D394004D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 06:59:38 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7J1VHSF32833562
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 07:01:18 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r7J1Tkvd003747
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 06:59:47 +0530
Date: Mon, 19 Aug 2013 09:29:45 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH 2/2] powerpc/iommu: check dev->iommu_group before remove
 a device from iommu_group
Message-ID: <20130819012945.GA8342@weiyang.vnet.ibm.com>
References: <1376647687-20550-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1376647687-20550-3-git-send-email-weiyang@linux.vnet.ibm.com>
 <520DFBC8.4040509@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <520DFBC8.4040509@ozlabs.ru>
Cc: paulus@au1.ibm.com, benh@au1.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 16, 2013 at 08:15:36PM +1000, Alexey Kardashevskiy wrote:
>On 08/16/2013 08:08 PM, Wei Yang wrote:
>> ---
>>  arch/powerpc/kernel/iommu.c |    3 ++-
>>  1 files changed, 2 insertions(+), 1 deletions(-)
>> 
>> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
>> index b20ff17..5abf7c3 100644
>> --- a/arch/powerpc/kernel/iommu.c
>> +++ b/arch/powerpc/kernel/iommu.c
>> @@ -1149,7 +1149,8 @@ static int iommu_bus_notifier(struct notifier_block *nb,
>>  	case BUS_NOTIFY_ADD_DEVICE:
>>  		return iommu_add_device(dev);
>>  	case BUS_NOTIFY_DEL_DEVICE:
>> -		iommu_del_device(dev);
>> +		if (dev->iommu_group)
>> +			iommu_del_device(dev);
>>  		return 0;
>>  	default:
>>  		return 0;
>> 
>
>This one seems redundant, no?

Sorry for the late.

Yes, these two patches have the same purpose to guard the system, while in two
different places.  One is in powernv platform, the other is in the generic iommu 
driver.

The one in powernv platform is used to correct the original logic.

The one in generic iommu driver is to keep system safe in case other platform to
call iommu_group_remove_device() without the check.

>
>
>-- 
>Alexey

-- 
Richard Yang
Help you, Help me
