Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qQmPh4k5PzDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 22:30:48 +1100 (AEDT)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Thu, 17 Mar 2016 21:30:47 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 80A512BB005A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 22:30:45 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2HBUbta49807438
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 22:30:45 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2HBUCYf026318
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 22:30:13 +1100
Subject: Re: [RFC PATCH v4 5/7] vfio-pci: Allow to mmap sub-page MMIO BARs if
 the mmio page is exclusive
To: Alex Williamson <alex.williamson@redhat.com>
References: <1457336918-3893-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1457336918-3893-6-git-send-email-xyjxie@linux.vnet.ibm.com>
 <20160316103034.48666ae0@t450s.home>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-doc@vger.kernel.org, bhelgaas@google.com, corbet@lwn.net,
 aik@ozlabs.ru, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, warrier@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Message-ID: <56EA9532.2050902@linux.vnet.ibm.com>
Date: Thu, 17 Mar 2016 19:29:54 +0800
MIME-Version: 1.0
In-Reply-To: <20160316103034.48666ae0@t450s.home>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/3/17 0:30, Alex Williamson wrote:
> On Mon,  7 Mar 2016 15:48:36 +0800
> Yongji Xie <xyjxie@linux.vnet.ibm.com> wrote:
>
>> Current vfio-pci implementation disallows to mmap
>> sub-page(size < PAGE_SIZE) MMIO BARs because these BARs' mmio
>> page may be shared with other BARs.
>>
>> But we should allow to mmap these sub-page MMIO BARs if PCI
>> resource allocator can make sure these BARs' mmio page will
>> not be shared with other BARs.
>>
>> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
>> ---
>>   drivers/vfio/pci/vfio_pci.c |    7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
>> index 1ce1d36..49d7a69 100644
>> --- a/drivers/vfio/pci/vfio_pci.c
>> +++ b/drivers/vfio/pci/vfio_pci.c
>> @@ -589,7 +589,8 @@ static long vfio_pci_ioctl(void *device_data,
>>   				     VFIO_REGION_INFO_FLAG_WRITE;
>>   			if (IS_ENABLED(CONFIG_VFIO_PCI_MMAP) &&
>>   			    pci_resource_flags(pdev, info.index) &
>> -			    IORESOURCE_MEM && info.size >= PAGE_SIZE) {
>> +			    IORESOURCE_MEM && !pci_resources_share_page(pdev,
>> +			    info.index)) {
> this would be a preferable line wrap:
>
>                              IORESOURCE_MEM &&
>                              !pci_resources_share_page(pdev, info.index)) {

OK. I'll fix it.

Thanks,
Yongji Xie
