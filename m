Return-Path: <bjorn.helgaas@gmail.com>
Received: from mail-io0-x241.google.com (mail-io0-x241.google.com
 [IPv6:2607:f8b0:4001:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yRKkG2qY7zDr4B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Nov 2017 05:33:58 +1100 (AEDT)
Received: by mail-io0-x241.google.com with SMTP id h70so889421ioi.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Oct 2017 11:33:57 -0700 (PDT)
MIME-Version: 1.0
Reply-To: bjorn@helgaas.com
In-Reply-To: <1509462750.10233.134.camel@linux.intel.com>
References: <20171013165250.25370-1-andriy.shevchenko@linux.intel.com>
 <1509462750.10233.134.camel@linux.intel.com>
From: Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date: Tue, 31 Oct 2017 13:33:54 -0500
Message-ID: <CABhMZUV0me+PG8daQ8iOzcSEJBQMD4=JGbMp7sVm_5CujwZ4eQ@mail.gmail.com>
Subject: Re: [PATCH v1] powerpc/pci: convert to use for_each_pci_bridge()
 helper
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 31, 2017 at 10:12 AM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Fri, 2017-10-13 at 19:52 +0300, Andy Shevchenko wrote:
>> ...which makes code slightly cleaner.
>
> +Cc: Bjorn
>
> Perhaps it makes sense to pass this through PCI if no one objects?

Fine with me, but I only apply things that appear on the
linux-pci@vger.kernel.org mailing list.

>> Requires: d43f59ce6c50 ("PCI: Add for_each_pci_bridge() helper")
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>>  arch/powerpc/kernel/pci-hotplug.c | 7 ++-----
>>  arch/powerpc/kernel/pci_of_scan.c | 7 ++-----
>>  2 files changed, 4 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/pci-hotplug.c
>> b/arch/powerpc/kernel/pci-hotplug.c
>> index 2d71269e7dc1..741f47295188 100644
>> --- a/arch/powerpc/kernel/pci-hotplug.c
>> +++ b/arch/powerpc/kernel/pci-hotplug.c
>> @@ -134,11 +134,8 @@ void pci_hp_add_devices(struct pci_bus *bus)
>>               pcibios_setup_bus_devices(bus);
>>               max = bus->busn_res.start;
>>               for (pass = 0; pass < 2; pass++) {
>> -                     list_for_each_entry(dev, &bus->devices,
>> bus_list) {
>> -                             if (pci_is_bridge(dev))
>> -                                     max = pci_scan_bridge(bus,
>> dev,
>> -                                                           max,
>> pass);
>> -                     }
>> +                     for_each_pci_bridge(dev, bus)
>> +                             max = pci_scan_bridge(bus, dev, max,
>> pass);
>>               }
>>       }
>>       pcibios_finish_adding_to_bus(bus);
>> diff --git a/arch/powerpc/kernel/pci_of_scan.c
>> b/arch/powerpc/kernel/pci_of_scan.c
>> index 0d790f8432d2..8bdaa2a6fa62 100644
>> --- a/arch/powerpc/kernel/pci_of_scan.c
>> +++ b/arch/powerpc/kernel/pci_of_scan.c
>> @@ -369,11 +369,8 @@ static void __of_scan_bus(struct device_node
>> *node, struct pci_bus *bus,
>>       pcibios_setup_bus_devices(bus);
>>
>>       /* Now scan child busses */
>> -     list_for_each_entry(dev, &bus->devices, bus_list) {
>> -             if (pci_is_bridge(dev)) {
>> -                     of_scan_pci_bridge(dev);
>> -             }
>> -     }
>> +     for_each_pci_bridge(dev, bus)
>> +             of_scan_pci_bridge(dev);
>>  }
>>
>>  /**
>
> --
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Intel Finland Oy
