Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 920F6B6FC3
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2012 14:00:02 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 27 Jun 2012 22:00:00 -0600
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
 [9.17.195.107])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 66804C40009
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2012 03:59:56 +0000 (WET)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5S3xvjr191812
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 21:59:57 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5S3xtUE025137
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 21:59:56 -0600
Date: Thu, 28 Jun 2012 11:59:53 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH V4 1/2] PCI: pcibus address to resource converting take
 bus directly
Message-ID: <20120628035953.GA1637@shangw>
References: <1340808525-24996-1-git-send-email-shangw@linux.vnet.ibm.com>
 <CAErSpo4u6HKdVqaaiL5=GSWRXiVfyfJ7EsnkAwGz6KvKrqaM=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAErSpo4u6HKdVqaaiL5=GSWRXiVfyfJ7EsnkAwGz6KvKrqaM=w@mail.gmail.com>
Cc: linux-pci@vger.kernel.org, yinghai@kernel.org,
 Gavin Shan <shangw@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> For allocating resource under bus path, we do have dev pass along,
>> and we could just use bus instead. Also, we'd like to make function
>> find_pci_host_bridge() global so that some platforms (e.g. PPC) can
>> access the pci host bridge directly.
>
>This patch appears to have multiple unrelated changes:
>
>  - change "struct pci_bus *bus" to "struct pci_bus *root_bus"
>  - change find_pci_host_bridge() argument from dev to bus
>  - fiddle with pcibios_bus_to_resource() and pcibios_resource_to_bus()
>

Leave those questions to Yinghai.

>These should be split out to make your patches easier to review.
>

I will split it for easy review :-)

>What's the rationale for preferring the pci_bus over the pci_dev?
>

We probablly need retrieve the pci_host_bridge through pci_bus
and pci_dev. When converting pci_dev to pci_host_bridge, we can
simply pass "pci_dev->bus".

Thanks,
Gavin

>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>> ---
>>  drivers/pci/host-bridge.c |   34 +++++++++++++++++++++-------------
>>  include/linux/pci.h       |    4 ++++
>>  2 files changed, 25 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
>> index a68dc61..4ccf477 100644
>> --- a/drivers/pci/host-bridge.c
>> +++ b/drivers/pci/host-bridge.c
>> @@ -9,22 +9,19 @@
>>
>>  #include "pci.h"
>>
>> -static struct pci_bus *find_pci_root_bus(struct pci_dev *dev)
>> +static struct pci_bus *find_pci_root_bus(struct pci_bus *bus)
>>  {
>> -       struct pci_bus *bus;
>> -
>> -       bus = dev->bus;
>>        while (bus->parent)
>>                bus = bus->parent;
>>
>>        return bus;
>>  }
>>
>> -static struct pci_host_bridge *find_pci_host_bridge(struct pci_dev *dev)
>> +struct pci_host_bridge *find_pci_host_bridge(struct pci_bus *bus)
>>  {
>> -       struct pci_bus *bus = find_pci_root_bus(dev);
>> +       struct pci_bus *root_bus = find_pci_root_bus(bus);
>>
>> -       return to_pci_host_bridge(bus->bridge);
>> +       return to_pci_host_bridge(root_bus->bridge);
>>  }
>>
>>  void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
>> @@ -40,10 +37,11 @@ static bool resource_contains(struct resource *res1, struct resource *res2)
>>        return res1->start <= res2->start && res1->end >= res2->end;
>>  }
>>
>> -void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
>> -                            struct resource *res)
>> +void __pcibios_resource_to_bus(struct pci_bus *bus,
>> +                                     struct pci_bus_region *region,
>> +                                     struct resource *res)
>>  {
>> -       struct pci_host_bridge *bridge = find_pci_host_bridge(dev);
>> +       struct pci_host_bridge *bridge = find_pci_host_bridge(bus);
>>        struct pci_host_bridge_window *window;
>>        resource_size_t offset = 0;
>>
>> @@ -60,6 +58,11 @@ void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
>>        region->start = res->start - offset;
>>        region->end = res->end - offset;
>>  }
>> +void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
>> +                            struct resource *res)
>> +{
>> +       __pcibios_resource_to_bus(dev->bus, region, res);
>> +}
>>  EXPORT_SYMBOL(pcibios_resource_to_bus);
>>
>>  static bool region_contains(struct pci_bus_region *region1,
>> @@ -68,10 +71,10 @@ static bool region_contains(struct pci_bus_region *region1,
>>        return region1->start <= region2->start && region1->end >= region2->end;
>>  }
>>
>> -void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
>> -                            struct pci_bus_region *region)
>> +static void __pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,
>> +                                     struct pci_bus_region *region)
>>  {
>> -       struct pci_host_bridge *bridge = find_pci_host_bridge(dev);
>> +       struct pci_host_bridge *bridge = find_pci_host_bridge(bus);
>>        struct pci_host_bridge_window *window;
>>        resource_size_t offset = 0;
>>
>> @@ -93,4 +96,9 @@ void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
>>        res->start = region->start + offset;
>>        res->end = region->end + offset;
>>  }
>> +void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
>> +                            struct pci_bus_region *region)
>> +{
>> +       __pcibios_bus_to_resource(dev->bus, res, region);
>> +}
>>  EXPORT_SYMBOL(pcibios_bus_to_resource);
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index fefb4e1..2b559f1 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -385,6 +385,7 @@ struct pci_host_bridge {
>>  };
>>
>>  #define        to_pci_host_bridge(n) container_of(n, struct pci_host_bridge, dev)
>> +struct pci_host_bridge *find_pci_host_bridge(struct pci_bus *bus);
>>  void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
>>                     void (*release_fn)(struct pci_host_bridge *),
>>                     void *release_data);
>> @@ -657,6 +658,9 @@ void pci_fixup_cardbus(struct pci_bus *);
>>
>>  /* Generic PCI functions used internally */
>>
>> +void __pcibios_resource_to_bus(struct pci_bus *bus,
>> +                              struct pci_bus_region *region,
>> +                              struct resource *res);
>>  void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
>>                             struct resource *res);
>>  void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
>> --
>> 1.7.9.5
>>
>
