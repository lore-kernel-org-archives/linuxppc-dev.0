Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 585D11A0167
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jan 2016 21:43:17 +1100 (AEDT)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Fri, 29 Jan 2016 20:43:16 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id C570C2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jan 2016 21:43:14 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0TAh8Vc44761212
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jan 2016 21:43:16 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0TAgfed029093
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jan 2016 21:42:42 +1100
Subject: Re: [RFC PATCH v3 5/5] vfio-pci: Allow to mmap MSI-X table if host
 bridge supports filtering of MSIs
To: Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org
References: <1452841574-2781-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1452841574-2781-6-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1454021188.23148.7.camel@redhat.com>
Cc: bhelgaas@google.com, corbet@lwn.net, aik@ozlabs.ru,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 warrier@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Message-ID: <56AB421B.3070004@linux.vnet.ibm.com>
Date: Fri, 29 Jan 2016 18:42:35 +0800
MIME-Version: 1.0
In-Reply-To: <1454021188.23148.7.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/1/29 6:46, Alex Williamson wrote:
> On Fri, 2016-01-15 at 15:06 +0800, Yongji Xie wrote:
>> Current vfio-pci implementation disallows to mmap MSI-X
>> table in case that user get to touch this directly.
>>   
>> But we should allow to mmap these MSI-X tables if the PCI
>> host bridge supports filtering of MSIs.
>>   
>> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
>> ---
>>   drivers/vfio/pci/vfio_pci.c |    6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>   
>> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
>> index 11fd0f0..4d68f6a 100644
>> --- a/drivers/vfio/pci/vfio_pci.c
>> +++ b/drivers/vfio/pci/vfio_pci.c
>> @@ -555,7 +555,8 @@ static long vfio_pci_ioctl(void *device_data,
>>   			    IORESOURCE_MEM && !pci_resources_share_page(pdev,
>>   			    info.index)) {
>>   				info.flags |= VFIO_REGION_INFO_FLAG_MMAP;
>> -				if (info.index == vdev->msix_bar) {
>> +				if (!pci_host_bridge_msi_filtered_enabled(pdev) &&
>> +				    info.index == vdev->msix_bar) {
>>   					ret = msix_sparse_mmap_cap(vdev, &caps);
>>   					if (ret)
>>   						return ret;
>> @@ -967,7 +968,8 @@ static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
>>   	if (phys_len < PAGE_SIZE || req_start + req_len > phys_len)
>>   		return -EINVAL;
>>   
>> -	if (index == vdev->msix_bar) {
>> +	if (!pci_host_bridge_msi_filtered_enabled(pdev) &&
>> +	    index == vdev->msix_bar) {
>>   		/*
>>   		 * Disallow mmaps overlapping the MSI-X table; users don't
>>   		 * get to touch this directly.  We could find somewhere
> What about read()/write() access, why would we allow mmap() but not
> those?
>

Yes, you are right! I miss the MSI-X table check in vfio_pci_bar_rw().
I will fix it in next version. Thanks.

Regards,
Yongji Xie
