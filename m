Return-Path: <liuj97@gmail.com>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
 [209.85.220.45])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 82DD32C0091
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 May 2013 01:08:00 +1000 (EST)
Received: by mail-pa0-f45.google.com with SMTP id lj1so1593331pab.32
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2013 08:07:58 -0700 (PDT)
Message-ID: <5193A4C7.1040607@gmail.com>
Date: Wed, 15 May 2013 23:07:51 +0800
From: Liu Jiang <liuj97@gmail.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH v2, part 2 09/18] PCI, PPC: use hotplug-safe iterators
 to walk PCI buses
References: <1368550322-1045-1-git-send-email-jiang.liu@huawei.com>
 <1368550322-1045-9-git-send-email-jiang.liu@huawei.com>
 <1368574202.31689.54.camel@pasglop>
In-Reply-To: <1368574202.31689.54.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Toshi Kani <toshi.kani@hp.com>, Jiang Liu <jiang.liu@huawei.com>,
 Myron Stowe <myron.stowe@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rjw@sisk.pl>,
 Gu Zheng <guz.fnst@cn.fujitsu.com>, Yijing Wang <wangyijing@huawei.com>,
 Bill Pemberton <wfp5p@virginia.edu>, Paul Mackerras <paulus@samba.org>,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Yinghai Lu <yinghai@kernel.org>, Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/15/2013 07:30 AM, Benjamin Herrenschmidt wrote:
> On Wed, 2013-05-15 at 00:51 +0800, Jiang Liu wrote:
>> Enhance PPC architecture specific code to use hotplug-safe iterators
>> to walk PCI buses.
> I was about to ack it but then I saw:
>
>> diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
>> index 51a133a..a41c6dd 100644
>> --- a/arch/powerpc/kernel/pci_64.c
>> +++ b/arch/powerpc/kernel/pci_64.c
>> @@ -208,7 +208,6 @@ long sys_pciconfig_iobase(long which, unsigned long in_bus,
>>   			  unsigned long in_devfn)
>>   {
>>   	struct pci_controller* hose;
>> -	struct list_head *ln;
>>   	struct pci_bus *bus = NULL;
>>   	struct device_node *hose_node;
>>   
>> @@ -229,18 +228,16 @@ long sys_pciconfig_iobase(long which, unsigned long in_bus,
>>   	/* That syscall isn't quite compatible with PCI domains, but it's
>>   	 * used on pre-domains setup. We return the first match
>>   	 */
>> -
>> -	for (ln = pci_root_buses.next; ln != &pci_root_buses; ln = ln->next) {
>> -		bus = pci_bus_b(ln);
>> -		if (in_bus >= bus->number && in_bus <= bus->busn_res.end)
>> +	for_each_pci_root_bus(bus)
>> +		if (in_bus >= bus->number && in_bus <= bus->busn_res.end &&
>> +		    bus->dev.of_node)
>>   			break;
>> -		bus = NULL;
>> -	}
>> -	if (bus == NULL || bus->dev.of_node == NULL)
>> +	if (bus == NULL)
>>   		return -ENODEV;
> You just removed the NULL check for the of_node field...
Hi Benjamin,
     Thanks for review.
     I just moved the "bus->dev.of_node == NULL" into the above 
for_each_pci_root_bus()
loop:)
     Will send you another version according to your suggestion to use 
pci_bus_to_host()
to simplify the code.
Regards!
Gerry

>   
>>   	hose_node = bus->dev.of_node;
>>   	hose = PCI_DN(hose_node)->phb;
> Which is dereferrenced here.	
>
>> +	pci_bus_put(bus);
> On the other hand, the whole thing can probably be using
> pci_bus_to_host() instead.... the above code is bitrotted.
>
>>   	switch (which) {
>>   	case IOBASE_BRIDGE_NUMBER:
>   
> Cheeers,
> Ben.
>
>
