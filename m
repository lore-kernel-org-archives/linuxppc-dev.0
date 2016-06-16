Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rVjYG4vWDzDqk9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 22:36:18 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5GCYGOR067602
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 08:36:16 -0400
Received: from e06smtp16.uk.ibm.com (e06smtp16.uk.ibm.com [195.75.94.112])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23kr61a7ky-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 08:36:16 -0400
Received: from localhost
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Thu, 16 Jun 2016 13:36:13 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2D9DE2190063
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 13:35:42 +0100 (BST)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5GCaAda33816802
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 12:36:10 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5GCaAlt000949
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 06:36:10 -0600
Subject: Re: [PATCH] cxl: Make vPHB device node match adapter's
To: Ian Munsie <imunsie@au1.ibm.com>
References: <1466001736-3074-1-git-send-email-fbarrat@linux.vnet.ibm.com>
 <1466027386-sup-9561@x230.ozlabs.ibm.com>
Cc: mikey <mikey@neuling.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Thu, 16 Jun 2016 14:36:09 +0200
MIME-Version: 1.0
In-Reply-To: <1466027386-sup-9561@x230.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <57629D39.8030802@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks, Ian. Here is a hopefully better commit message:

cxl: Make vPHB device node match adapter's

On bare-metal, when a device is attached to the cxl card, lsvpd shows
a location code such as (with cxlflash):
     # lsvpd -l sg22
     ...
     *YL U78CB.001.WZS0073-P1-C33-B0-T0-L0
which makes it hard to easily identify the cxl adapter owning the
flash device, since in this example C33 refers to a P8 processor.

lsvpd looks in the parent devices until it finds a location code, so the
device node for the vPHB ends up being used.

By reusing the device node of the adapter for the vPHB, lsvpd shows:
     # lsvpd -l sg16
     ...
     *YL U78C9.001.WZS09XA-P1-C7-B1-T0-L3
where C7 is the PCI slot of the cxl adapter.

On powerVM, the vPHB was already using the adapter device node, so
there's no change there.

Tested by cxlflash on bare-metal and powerVM.

Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>






Le 15/06/2016 23:53, Ian Munsie a écrit :
> This could probably use a description in the commit message, perhaps
> including output showing the before/after difference this makes to
> lsvpd, but otherwise it looks fine to me.
>
> @Mikey - this look OK to you?
>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>
>
> Excerpts from Frederic Barrat's message of 2016-06-15 16:42:16 +0200:
>> Tested by cxlflash on bare-metal and powerVM.
>>
>> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
>> ---
>>   drivers/misc/cxl/vphb.c | 21 ++++++++++-----------
>>   1 file changed, 10 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
>> index cdc7723..012b6aa 100644
>> --- a/drivers/misc/cxl/vphb.c
>> +++ b/drivers/misc/cxl/vphb.c
>> @@ -208,20 +208,19 @@ static struct pci_controller_ops cxl_pci_controller_ops =
>>
>>   int cxl_pci_vphb_add(struct cxl_afu *afu)
>>   {
>> -    struct pci_dev *phys_dev;
>> -    struct pci_controller *phb, *phys_phb;
>> +    struct pci_controller *phb;
>>       struct device_node *vphb_dn;
>>       struct device *parent;
>>
>> -    if (cpu_has_feature(CPU_FTR_HVMODE)) {
>> -        phys_dev = to_pci_dev(afu->adapter->dev.parent);
>> -        phys_phb = pci_bus_to_host(phys_dev->bus);
>> -        vphb_dn = phys_phb->dn;
>> -        parent = &phys_dev->dev;
>> -    } else {
>> -        vphb_dn = afu->adapter->dev.parent->of_node;
>> -        parent = afu->adapter->dev.parent;
>> -    }
>> +    /* The parent device is the adapter. Reuse the device node of
>> +     * the adapter.
>> +     * We don't seem to care what device node is used for the vPHB,
>> +     * but tools such as lsvpd walk up the device parents looking
>> +     * for a valid location code, so we might as well show devices
>> +     * attached to the adapter as being located on that adapter.
>> +     */
>> +    parent = afu->adapter->dev.parent;
>> +    vphb_dn = parent->of_node;
>>
>>       /* Alloc and setup PHB data structure */
>>       phb = pcibios_alloc_controller(vphb_dn);
