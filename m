Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 1BDEDB70F5
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Sep 2010 15:22:04 +1000 (EST)
Message-ID: <4C89C0C9.6090007@windriver.com>
Date: Fri, 10 Sep 2010 13:23:21 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Ravi Gupta <dceravigupta@gmail.com>
Subject: Re: pci_request_regions() failure
References: <AANLkTim5kasMWC6u-mhQyCRiPv1w7BCg7o-mBfy28DfS@mail.gmail.com>	<4C85CCD6.3020504@windriver.com>	<AANLkTi=bDOtCxW9VuXrSyAiCLoFCvWoskORpc_1ebDe7@mail.gmail.com>	<4C8604E1.4080908@windriver.com>	<AANLkTimLO+xf2Z1zoQfZ8bfB-b--Uu701afr7zg+1r6k@mail.gmail.com>	<4C88AF1E.8010608@windriver.com>
	<AANLkTik1gWKO6vif+HgtM-j_5EUMJGwKRf+saRgK4TZg@mail.gmail.com>
In-Reply-To: <AANLkTik1gWKO6vif+HgtM-j_5EUMJGwKRf+saRgK4TZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ravi Gupta wrote:
> Hi Tiejun,
> 
> Thanks for the reply.
> 
> Omm.
>> Often we always disable this pref windows so please disable this window.
>> Try use
>> the following ways to clear PCI_PREF_MEMORY_BASE and PCI_PREF_MEMORY_LIMIT.
>> ------
>>        pci_write_config_word(dev, PCI_PREF_MEMORY_BASE, 0);
>>        pci_write_config_word(dev, PCI_PREF_MEMORY_LIMIT, 0);
>>
>>
> I have a little confusion about what you said. You said I should disable
> prefetched window corresponds to PCI Bridge to [bus 02-ff], the dmesgs shows
> that it is already disabled.
> 
> pci 0001:01:00.0: PCI bridge to [bus 02-ff]
> pci 0001:01:00.0:   bridge window [io  0x0000-0x0000] (disabled)
> pci 0001:01:00.0:   bridge window [mem 0x00000000-0x000fffff] (disabled)
> *pci 0001:01:00.0:   bridge window [mem 0x00000000-0x000fffff pref]
> (disabled)*

Sorry I miss this line.

> 
> Is it something that I am not getting right or you have miss read something?
> If it is problem with me, then what should be the O/P in case when I disable
> the prefetch window (by issuing pci_write_config_word(dev,
> PCI_PREF_MEMORY_BASE, 0); and pci_write_config_word(dev,
> PCI_PREF_MEMORY_LIMIT, 0); function calls)? And also, I will be really
> thankful to you if you also tell me the function in which I should place
> there function calls as I am new to linux device driver programming.

Firstly I think we'd better print the BAR0 and BAR1 on the probe function of
your device driver because you have to make sure if a8000000-a803ffff is
assigned to BAR0 and 0xa8040000-0xa807ffff for BAR1 as we expect.

u32 value;
pci_read_config_word(pdev, PCI_BASE_ADDRESS_0, &value); printk...
pci_read_config_word(pdev, PCI_BASE_ADDRESS_1, &value); printk....

And you can print this pci_resource_start(pdev, bar), pci_resource_len(pdev,
bar) from the function, __pci_request_region, on the file drivers/pci/pci.c.
Please check this as well.

And currently we have to debug this so on the function, __pci_assign_resource,
from the file drivers/pci/setup-res.c, we can force skipping temporarily
pci_bus_alloc_resource for bus 0001:01 since that will call pci_update_resource
for bus 0001:01.

static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
                                 int resno)
{
        struct resource *res = dev->resource + resno;
        resource_size_t size, min, align;
        int ret;

        size = resource_size(res);
        min = (res->flags & IORESOURCE_IO) ? PCIBIOS_MIN_IO : PCIBIOS_MIN_MEM;
        align = pci_resource_alignment(dev, res);
-------
	if (bus->number == 0x01) {
		ret = -ENOMEM
		return ret;
	}
-------

I means we don't want to assign resource as the below line on the log.
------
pci 0001:01:00.0: BAR 8: assigned [mem 0xa8000000-0xa80fffff]

I expect the following output:
------
pci 0001:01:00.0: BAR 8: can't assign mem pref (size 0x100000)

Best Regards
Tiejun

> 
> Regards,
> Ravi
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
