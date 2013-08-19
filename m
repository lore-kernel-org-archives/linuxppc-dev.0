Return-Path: <aik@ozlabs.ru>
Received: from mail-pb0-f50.google.com (mail-pb0-f50.google.com
 [209.85.160.50])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1DC052C00BE
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 11:39:58 +1000 (EST)
Received: by mail-pb0-f50.google.com with SMTP id uo5so4308433pbc.23
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Aug 2013 18:39:55 -0700 (PDT)
Message-ID: <52117765.7010205@ozlabs.ru>
Date: Mon, 19 Aug 2013 11:39:49 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] powerpc/iommu: check dev->iommu_group before remove
 a device from iommu_group
References: <1376647687-20550-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1376647687-20550-3-git-send-email-weiyang@linux.vnet.ibm.com>
 <520DFBC8.4040509@ozlabs.ru> <20130819012945.GA8342@weiyang.vnet.ibm.com>
In-Reply-To: <20130819012945.GA8342@weiyang.vnet.ibm.com>
Content-Type: text/plain; charset=KOI8-R
Cc: paulus@au1.ibm.com, benh@au1.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/19/2013 11:29 AM, Wei Yang wrote:
> On Fri, Aug 16, 2013 at 08:15:36PM +1000, Alexey Kardashevskiy wrote:
>> On 08/16/2013 08:08 PM, Wei Yang wrote:
>>> ---
>>>  arch/powerpc/kernel/iommu.c |    3 ++-
>>>  1 files changed, 2 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
>>> index b20ff17..5abf7c3 100644
>>> --- a/arch/powerpc/kernel/iommu.c
>>> +++ b/arch/powerpc/kernel/iommu.c
>>> @@ -1149,7 +1149,8 @@ static int iommu_bus_notifier(struct notifier_block *nb,
>>>  	case BUS_NOTIFY_ADD_DEVICE:
>>>  		return iommu_add_device(dev);
>>>  	case BUS_NOTIFY_DEL_DEVICE:
>>> -		iommu_del_device(dev);
>>> +		if (dev->iommu_group)
>>> +			iommu_del_device(dev);
>>>  		return 0;
>>>  	default:
>>>  		return 0;
>>>
>>
>> This one seems redundant, no?
> 
> Sorry for the late.
> 
> Yes, these two patches have the same purpose to guard the system, while in two
> different places.  One is in powernv platform, the other is in the generic iommu 
> driver.
> 
> The one in powernv platform is used to correct the original logic.
> 
> The one in generic iommu driver is to keep system safe in case other platform to
> call iommu_group_remove_device() without the check.


But I am moving bus notifier to powernv code (posted a patch last week,
otherwise Freescale's IOMMU conflicted) so this won't be the case.



-- 
Alexey
