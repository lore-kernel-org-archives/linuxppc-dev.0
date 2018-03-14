Return-Path: <desnesn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401g7h5m5dzF15q
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2018 05:22:56 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2EIMbRX002696
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 14:22:54 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gq6nex9ej-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 14:22:54 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <desnesn@linux.vnet.ibm.com>;
 Wed, 14 Mar 2018 14:22:52 -0400
Subject: Re: [PATCH 1/2, pci] pci: Addition of PCI_DEV_FLAGS_QUIET_PCI_REALIGN
 attribute to the PCI subsystem
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 ruscur@russell.cc, aik@ozlabs.ru, david@gibson.dropbear.id.au,
 fbarrat@linux.vnet.ibm.com, brking@linux.vnet.ibm.com
References: <20180314163455.15854-1-desnesn@linux.vnet.ibm.com>
 <20180314163455.15854-2-desnesn@linux.vnet.ibm.com>
 <20180314180642.GC179719@bhelgaas-glaptop.roam.corp.google.com>
From: =?UTF-8?Q?Desnes_Augusto_Nunes_do_Ros=c3=a1rio?=
 <desnesn@linux.vnet.ibm.com>
Date: Wed, 14 Mar 2018 15:22:44 -0300
MIME-Version: 1.0
In-Reply-To: <20180314180642.GC179719@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <30c63477-620b-3f8b-82df-fd1e34cd99b8@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Bjorn,

On 03/14/2018 03:06 PM, Bjorn Helgaas wrote:
> On Wed, Mar 14, 2018 at 01:34:54PM -0300, Desnes A. Nunes do Rosario wrote:
>> Add PCI_DEV_FLAGS_QUIET_PCI_REALIGN to pci_dev_flags and use it to
>> silent PCI realignment messages if the flag is turned on by a driver.
>>
>> Signed-off-by: Desnes A. Nunes do Rosario <desnesn@linux.vnet.ibm.com>
>> ---
>>   drivers/pci/pci.c       | 3 ++-
>>   drivers/pci/setup-res.c | 3 ++-
>>   include/linux/pci.h     | 2 ++
>>   3 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 8c71d1a66cdd..be197c944e5f 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -5505,7 +5505,8 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
>>   		return;
>>   	}
>>   
>> -	pci_info(dev, "Disabling memory decoding and releasing memory resources\n");
>> +	if (!(dev->dev_flags & PCI_DEV_FLAGS_QUIET_PCI_REALIGN))
>> +		pci_info(dev, "Disabling memory decoding and releasing memory resources\n");
>>   	pci_read_config_word(dev, PCI_COMMAND, &command);
>>   	command &= ~PCI_COMMAND_MEMORY;
>>   	pci_write_config_word(dev, PCI_COMMAND, command);
>> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
>> index 369d48d6c6f1..00a538def763 100644
>> --- a/drivers/pci/setup-res.c
>> +++ b/drivers/pci/setup-res.c
>> @@ -172,7 +172,8 @@ EXPORT_SYMBOL(pci_claim_resource);
>>   
>>   void pci_disable_bridge_window(struct pci_dev *dev)
>>   {
>> -	pci_info(dev, "disabling bridge mem windows\n");
>> +	if (!(dev->dev_flags & PCI_DEV_FLAGS_QUIET_PCI_REALIGN))
>> +		pci_info(dev, "disabling bridge mem windows\n");
> 
> As far as I'm concerned, we can just remove these messages completely.
> I don't think there's any real value there.

After I found out that this was happening to all PCI devices on powerpc 
due to the __weak
pcibios_default_alignment() interface (necessary for VFIO passthrough 
and performance), I confess that this was my first approach to this 
matter; however I couldn't vouch the need of these messages on other 
architectures.

If there are no further concerns, I definitely prefer sending a second 
version of this patch only eliminating these messages and attesting the 
reason why.

Thank you very much for your review Bjorn,

-- 
Desnes A. Nunes do Rosário
