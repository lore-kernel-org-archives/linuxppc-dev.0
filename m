Return-Path: <aik@ozlabs.ru>
Received: from mail-ie0-x22e.google.com (mail-ie0-x22e.google.com
 [IPv6:2607:f8b0:4001:c03::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CA4702C02A0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2013 21:06:27 +1100 (EST)
Received: by mail-ie0-f174.google.com with SMTP id k10so3261623iea.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Mar 2013 02:06:22 -0800 (PST)
Message-ID: <51307DCE.1050506@ozlabs.ru>
Date: Fri, 01 Mar 2013 21:07:10 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Sethi Varun-B16395 <B16395@freescale.com>
Subject: Re: [PATCH 1/6 v8] iommu/fsl: Store iommu domain information pointer
 in archdata.
References: <1361191939-21260-1-git-send-email-Varun.Sethi@freescale.com>
 <1361191939-21260-2-git-send-email-Varun.Sethi@freescale.com>
 <20130227113045.GH26252@8bytes.org>
 <C5ECD7A89D1DC44195F34B25E172658D3C26F6@039-SN2MPN1-013.039d.mgd.msft.net>
 <BAB98EA5-5324-4FB2-97C2-A28A96C569DC@kernel.crashing.org>
 <51300367.6080300@ozlabs.ru>
 <C5ECD7A89D1DC44195F34B25E172658D3C802F@039-SN2MPN1-013.039d.mgd.msft.net>
In-Reply-To: <C5ECD7A89D1DC44195F34B25E172658D3C802F@039-SN2MPN1-013.039d.mgd.msft.net>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Alex Williamson <alex.williamson@redhat.com>, Joerg Roedel <joro@8bytes.org>,
 "linux-kernel@vger.kernel.org list" <linux-kernel@vger.kernel.org>,
 Yoder Stuart-B08248 <B08248@freescale.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

btw the device struct already has a pointer to its iommu_group, and the 
iommu_group struct itself has a pointer void *iommu_data which you could 
use for anything you want (iommu_group_get_iommudata(), 
iommu_group_set_iommudata()).

By design you are expected to add iommu groups to a domain but not devices 
so I am not so sure that you really need a pointer to domain in the device 
struct.


On 01/03/13 19:55, Sethi Varun-B16395 wrote:
> Thanks for the clarification Alexey.
>
> Kumar,
> We are using this new field (for PAMU) to store the iommu domain (for iommu API) information for a device.
>
> Regards
> Varun
>
>> -----Original Message-----
>> From: Alexey Kardashevskiy [mailto:aik@ozlabs.ru]
>> Sent: Friday, March 01, 2013 6:55 AM
>> To: Kumar Gala
>> Cc: Sethi Varun-B16395; Benjamin Herrenschmidt; iommu@lists.linux-
>> foundation.org; linuxppc-dev@lists.ozlabs.org list; linux-
>> kernel@vger.kernel.org list; Wood Scott-B07421; Yoder Stuart-B08248;
>> Joerg Roedel; Paul Mackerras; David Gibson; Alex Williamson
>> Subject: Re: [PATCH 1/6 v8] iommu/fsl: Store iommu domain information
>> pointer in archdata.
>>
>> Hi!
>>
>> On POWERNV we use only the part of IOMMU API which handles devices and
>> groups. We do not use IOMMU domains as VFIO containers do everything we
>> need for VFIO and we do not implement iommu_ops as it is not very
>> relevant to our architecture (does not give dma window properties, etc).
>>
>> So your work does not overlap with my work :)
>>
>>
>> On 01/03/13 02:51, Kumar Gala wrote:
>>>
>>> On Feb 27, 2013, at 6:04 AM, Sethi Varun-B16395 wrote:
>>>
>>>> Hi Kumar,Ben,
>>>> I am implementing the Freescale PAMU (IOMMU) driver using the Linux
>> IOMMU API. In this particular patch, I have added a new field to
>> dev_archdata structure to store the dma domain information.
>>>> This field is updated whenever we attach a device to an iommu domain.
>>>>
>>>> Regards
>>>> Varun
>>>
>>> Would be good to see if this overlaps with Alexey's work for IOMMU
>> driver for powernv.
>>>
>>> - k
>>>
>>>>
>>>>> -----Original Message-----
>>>>> From: Joerg Roedel [mailto:joro@8bytes.org]
>>>>> Sent: Wednesday, February 27, 2013 5:01 PM
>>>>> To: Sethi Varun-B16395
>>>>> Cc: iommu@lists.linux-foundation.org; linuxppc-dev@lists.ozlabs.org;
>>>>> linux-kernel@vger.kernel.org; Wood Scott-B07421; Yoder Stuart-B08248
>>>>> Subject: Re: [PATCH 1/6 v8] iommu/fsl: Store iommu domain
>>>>> information pointer in archdata.
>>>>>
>>>>> On Mon, Feb 18, 2013 at 06:22:14PM +0530, Varun Sethi wrote:
>>>>>> Add a new field in the device (powerpc) archdata structure for
>>>>>> storing iommu domain information pointer. This pointer is stored
>>>>>> when the device is attached to a particular domain.
>>>>>>
>>>>>>
>>>>>> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
>>>>>> ---
>>>>>> - no change.
>>>>>> arch/powerpc/include/asm/device.h |    4 ++++
>>>>>> 1 files changed, 4 insertions(+), 0 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/powerpc/include/asm/device.h
>>>>>> b/arch/powerpc/include/asm/device.h
>>>>>> index 77e97dd..6dc79fe 100644
>>>>>> --- a/arch/powerpc/include/asm/device.h
>>>>>> +++ b/arch/powerpc/include/asm/device.h
>>>>>> @@ -28,6 +28,10 @@ struct dev_archdata {
>>>>>> 		void		*iommu_table_base;
>>>>>> 	} dma_data;
>>>>>>
>>>>>> +	/* IOMMU domain information pointer. This would be set
>>>>>> +	 * when this device is attached to an iommu_domain.
>>>>>> +	 */
>>>>>> +	void			*iommu_domain;
>>>>>
>>>>> Please Cc the PowerPC Maintainers on this, so that they can have a
>>>>> look at it. This also must be put this into an #ifdef
>> CONFIG_IOMMU_API.


-- 
Alexey
