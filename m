Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3F80F1A045B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Aug 2014 19:15:06 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 11 Aug 2014 19:15:04 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id F1EB53578047
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Aug 2014 19:15:01 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s7B9Fhdr16449552
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Aug 2014 19:15:43 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7B9F0Yc031020
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Aug 2014 19:15:01 +1000
Date: Mon, 11 Aug 2014 19:14:59 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] powerpc/powernv: Remove duplicate check in
 tce_iommu_bus_notifier()
Message-ID: <20140811091459.GA2928@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1407309017-13870-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1407309017-13870-2-git-send-email-gwshan@linux.vnet.ibm.com>
 <1407726718.4508.60.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1407726718.4508.60.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 11, 2014 at 01:11:58PM +1000, Benjamin Herrenschmidt wrote:
>On Wed, 2014-08-06 at 17:10 +1000, Gavin Shan wrote:
>> The called function iommu_del_device() checks if the device has
>> attached IOMMU group, we needn't check it again in the parent
>> function call tce_iommu_bus_notifier().
>
>The patch does more than that... it also refactors the function, which
>it should either not do or document.
>

Ben, please drop PATCH[2/2] for now.

Thanks,
Gavin

>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/platforms/powernv/pci.c | 13 +++++++------
>>  1 file changed, 7 insertions(+), 6 deletions(-)
>> 
>> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
>> index f91a4e5..b562b0d 100644
>> --- a/arch/powerpc/platforms/powernv/pci.c
>> +++ b/arch/powerpc/platforms/powernv/pci.c
>> @@ -820,17 +820,18 @@ static int tce_iommu_bus_notifier(struct notifier_block *nb,
>>  		unsigned long action, void *data)
>>  {
>>  	struct device *dev = data;
>> +	int ret = 0;
>>  
>>  	switch (action) {
>>  	case BUS_NOTIFY_ADD_DEVICE:
>> -		return iommu_add_device(dev);
>> +		ret = iommu_add_device(dev);
>> +		break;
>>  	case BUS_NOTIFY_DEL_DEVICE:
>> -		if (dev->iommu_group)
>> -			iommu_del_device(dev);
>> -		return 0;
>> -	default:
>> -		return 0;
>> +		iommu_del_device(dev);
>> +		break;
>>  	}
>> +
>> +	return ret;
>>  }
>>  
>>  static struct notifier_block tce_iommu_bus_nb = {
>
>
