Return-Path: <robin.murphy@arm.com>
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3xWpNR3prlzDqDy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Aug 2017 20:18:47 +1000 (AEST)
Subject: Re: [PATCH 2/2] of: Restrict DMA configuration
To: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Stefan Wahren <stefan.wahren@i2se.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?=
 <afaerber@suse.de>, Hans Verkuil <hverkuil@xs4all.nl>,
 Johan Hovold <johan@kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <0819179085df6c41c70e83a2c5c138b95c0386b3.1502468875.git.robin.murphy@arm.com>
 <82633e62b64e28dc18bc466319065b92faf2414f.1502468875.git.robin.murphy@arm.com>
 <CAL_JsqKW7nhkCDu4eEDCgdC87b0MLH1UFO8LvaH22BcJMBsY7w@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <6819c6ae-e898-3293-d8b0-7a80108d7628@arm.com>
Date: Tue, 15 Aug 2017 11:18:39 +0100
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKW7nhkCDu4eEDCgdC87b0MLH1UFO8LvaH22BcJMBsY7w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 14/08/17 21:08, Rob Herring wrote:
> +linuxppc-dev
> 
> On Fri, Aug 11, 2017 at 11:29 AM, Robin Murphy <robin.murphy@arm.com> wrote:
>> Moving DMA configuration to happen later at driver probe time had the
>> unnoticed side-effect that we now perform DMA configuration for *every*
>> device represented in DT, rather than only those explicitly created by
>> the of_platform and PCI code.
>>
>> As Christoph points out, this is not really the best thing to do. Whilst
>> there may well be other DMA-capable buses that can benefit from having
>> their children automatically configured after the bridge has probed,
>> there are also plenty of others like USB, MDIO, etc. that definitely do
>> not support DMA and should not be indiscriminately processed.
>>
>> The good news is that DT already gives us the ammunition to do the right
>> thing - anything lacking a "dma-ranges" property should be considered
>> not to have a mapping of DMA address space from its children to its
>> parent, thus anything for which of_dma_get_range() does not succeed does
>> not need DMA configuration.
>>
>> The bad news is that strictly enforcing that would likely break just
>> about every FDT platform out there, since most authors have either not
>> considered the property at all or have mistakenly assumed that omitting
>> "dma-ranges" is equivalent to including the empty property. Thus we have
>> little choice but to special-case platform, AMBA and PCI devices so they
>> continue to receive configuration unconditionally as before. At least
>> anything new will have to get it right in future...
> 
> By "anything new", you mean new buses, not new platforms, right?
> What's a platform bus device today could be a different kernel bus
> type tomorrow with no DT change. So this isn't really enforceable.

Indeed, it would be virtually impossible to do anything on a
per-platform basis, but I think per-bus is a workable compromise - if
someone changes their hypothetical bus driver in a way that would affect
deployed DTs that can't be updated, at worst they can still add their
new bus type to the special case list at the same time.

> I don't completely agree that omitting dma-ranges is wrong and that
> new DTs have to have dma-ranges simply because there is much precedent
> of DTs with dma-ranges omitted (just go look at PPC). If a bus has no
> bus to cpu address translation nor size restrictions, then no
> dma-ranges should be allowed.

Sure, I agree that that genie is never going back in the bottle, but
people seem to manage to get empty "ranges" right to differentiate
between memory-mapped vs. non-memory-mapped buses, so it would be nice
to encourage getting the other direction right as well.

For the immediate issue at hand, I guess the alternative plan of attack
would be to stick a flag in struct bus_type for the bus drivers
themselves to opt into generic DMA configuration. That at least keeps
everything within the kernel (and come to think of it probably works
neatly for modular bus types as well).

Robin.

> Of course, DT standards can and do
> evolve and we could decide to be stricter here, but that hasn't
> happened. If it does, then we need to make that clear in the spec and
> enforce it.
> 
> Rob
> 
> 
>>
>> Fixes: 09515ef5ddad ("of/acpi: Configure dma operations at probe time for platform/amba/pci bus devices")
>> Reported-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>  drivers/of/device.c | 48 ++++++++++++++++++++++++++++++++----------------
>>  1 file changed, 32 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/of/device.c b/drivers/of/device.c
>> index e0a28ea341fe..04c4c952dc57 100644
>> --- a/drivers/of/device.c
>> +++ b/drivers/of/device.c
>> @@ -9,6 +9,9 @@
>>  #include <linux/module.h>
>>  #include <linux/mod_devicetable.h>
>>  #include <linux/slab.h>
>> +#include <linux/pci.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/amba/bus.h>
>>
>>  #include <asm/errno.h>
>>  #include "of_private.h"
>> @@ -84,31 +87,28 @@ int of_device_add(struct platform_device *ofdev)
>>   */
>>  int of_dma_configure(struct device *dev, struct device_node *np)
>>  {
>> -       u64 dma_addr, paddr, size;
>> +       u64 dma_addr, paddr, size = 0;
>>         int ret;
>>         bool coherent;
>>         unsigned long offset;
>>         const struct iommu_ops *iommu;
>>         u64 mask;
>>
>> -       /*
>> -        * Set default coherent_dma_mask to 32 bit.  Drivers are expected to
>> -        * setup the correct supported mask.
>> -        */
>> -       if (!dev->coherent_dma_mask)
>> -               dev->coherent_dma_mask = DMA_BIT_MASK(32);
>> -
>> -       /*
>> -        * Set it to coherent_dma_mask by default if the architecture
>> -        * code has not set it.
>> -        */
>> -       if (!dev->dma_mask)
>> -               dev->dma_mask = &dev->coherent_dma_mask;
>> -
>>         ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
>>         if (ret < 0) {
>> +               /*
>> +                * For legacy reasons, we have to assume some devices need
>> +                * DMA configuration regardless of whether "dma-ranges" is
>> +                * correctly specified or not.
>> +                */
>> +               if (!dev_is_pci(dev) &&
>> +#ifdef CONFIG_ARM_AMBA
>> +                   dev->bus != &amba_bustype &&
>> +#endif
>> +                   dev->bus != &platform_bus_type)
>> +                       return ret == -ENODEV ? 0 : ret;
>> +
>>                 dma_addr = offset = 0;
>> -               size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
>>         } else {
>>                 offset = PFN_DOWN(paddr - dma_addr);
>>
>> @@ -129,6 +129,22 @@ int of_dma_configure(struct device *dev, struct device_node *np)
>>                 dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", offset);
>>         }
>>
>> +       /*
>> +        * Set default coherent_dma_mask to 32 bit.  Drivers are expected to
>> +        * setup the correct supported mask.
>> +        */
>> +       if (!dev->coherent_dma_mask)
>> +               dev->coherent_dma_mask = DMA_BIT_MASK(32);
>> +       /*
>> +        * Set it to coherent_dma_mask by default if the architecture
>> +        * code has not set it.
>> +        */
>> +       if (!dev->dma_mask)
>> +               dev->dma_mask = &dev->coherent_dma_mask;
>> +
>> +       if (!size)
>> +               size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
>> +
>>         dev->dma_pfn_offset = offset;
>>
>>         /*
>> --
>> 2.13.4.dirty
>>
