Return-Path: <amurray@embedded-bits.co.uk>
Received: from mail-yh0-f46.google.com (mail-yh0-f46.google.com
 [209.85.213.46])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E6C5C2C023F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2014 01:12:07 +1100 (EST)
Received: by mail-yh0-f46.google.com with SMTP id v1so6887103yhn.33
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 06:12:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1393334743.1282.8.camel@pasglop>
References: <1393309931-20405-1-git-send-email-amurray@embedded-bits.co.uk>
 <1393334743.1282.8.camel@pasglop>
Date: Tue, 25 Feb 2014 14:12:03 +0000
Message-ID: <CAPcvp5EomG243_8_bYoWRJH2EbwfhWSEkSjXOzABcmXhNMtvgQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc/pci: Use of_pci_range_parser helper in
 pci_process_bridge_OF_ranges
From: Andrew Murray <amurray@embedded-bits.co.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 bhelgass@google.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 25 February 2014 13:25, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2014-02-25 at 06:32 +0000, Andrew Murray wrote:
>> This patch updates the implementation of pci_process_bridge_OF_ranges to use
>> the of_pci_range_parser helpers.
>>
>> Signed-off-by: Andrew Murray <amurray@embedded-bits.co.uk>
>> ---
>> I've verified that this builds, however I have no hardware to test this.
>> ---
>
> Thanks. A cursory review looks good but I need to spend a bit more time
> making sure our various special cases are handled properly.
>
> It's tracked on patchwork so unless you have an update to the patch,
> it won't be lost, but it might take a little while before I get to
> actually merge it.

Thanks for the response - Yes it's easy to screw this stuff up.

Please note that some of the special cases are handled by the parser
helper e.g. consumption of contiguous ranges, assignment to 'struct
resource', etc.

It should also be pointed out that this is now once again very similar
to the Microblaze implementation.

Thanks,

Andrew Murray

>
> Cheers,
> Ben.
>
>>  arch/powerpc/kernel/pci-common.c | 88 +++++++++++++---------------------------
>>  1 file changed, 29 insertions(+), 59 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
>> index d9476c1..a05fe18 100644
>> --- a/arch/powerpc/kernel/pci-common.c
>> +++ b/arch/powerpc/kernel/pci-common.c
>> @@ -666,60 +666,36 @@ void pci_resource_to_user(const struct pci_dev *dev, int bar,
>>  void pci_process_bridge_OF_ranges(struct pci_controller *hose,
>>                                 struct device_node *dev, int primary)
>>  {
>> -     const __be32 *ranges;
>> -     int rlen;
>> -     int pna = of_n_addr_cells(dev);
>> -     int np = pna + 5;
>>       int memno = 0;
>> -     u32 pci_space;
>> -     unsigned long long pci_addr, cpu_addr, pci_next, cpu_next, size;
>>       struct resource *res;
>> +     struct of_pci_range range;
>> +     struct of_pci_range_parser parser;
>>
>>       printk(KERN_INFO "PCI host bridge %s %s ranges:\n",
>>              dev->full_name, primary ? "(primary)" : "");
>>
>> -     /* Get ranges property */
>> -     ranges = of_get_property(dev, "ranges", &rlen);
>> -     if (ranges == NULL)
>> +     /* Check for ranges property */
>> +     if (of_pci_range_parser_init(&parser, dev))
>>               return;
>>
>>       /* Parse it */
>> -     while ((rlen -= np * 4) >= 0) {
>> -             /* Read next ranges element */
>> -             pci_space = of_read_number(ranges, 1);
>> -             pci_addr = of_read_number(ranges + 1, 2);
>> -             cpu_addr = of_translate_address(dev, ranges + 3);
>> -             size = of_read_number(ranges + pna + 3, 2);
>> -             ranges += np;
>> -
>> +     for_each_of_pci_range(&parser, &range) {
>>               /* If we failed translation or got a zero-sized region
>>                * (some FW try to feed us with non sensical zero sized regions
>>                * such as power3 which look like some kind of attempt at exposing
>>                * the VGA memory hole)
>>                */
>> -             if (cpu_addr == OF_BAD_ADDR || size == 0)
>> +             if (range.cpu_addr == OF_BAD_ADDR || range.size == 0)
>>                       continue;
>>
>> -             /* Now consume following elements while they are contiguous */
>> -             for (; rlen >= np * sizeof(u32);
>> -                  ranges += np, rlen -= np * 4) {
>> -                     if (of_read_number(ranges, 1) != pci_space)
>> -                             break;
>> -                     pci_next = of_read_number(ranges + 1, 2);
>> -                     cpu_next = of_translate_address(dev, ranges + 3);
>> -                     if (pci_next != pci_addr + size ||
>> -                         cpu_next != cpu_addr + size)
>> -                             break;
>> -                     size += of_read_number(ranges + pna + 3, 2);
>> -             }
>> -
>>               /* Act based on address space type */
>>               res = NULL;
>> -             switch ((pci_space >> 24) & 0x3) {
>> -             case 1:         /* PCI IO space */
>> +             switch (range.flags & IORESOURCE_TYPE_BITS) {
>> +             case IORESOURCE_IO:
>>                       printk(KERN_INFO
>>                              "  IO 0x%016llx..0x%016llx -> 0x%016llx\n",
>> -                            cpu_addr, cpu_addr + size - 1, pci_addr);
>> +                            range.cpu_addr, range.cpu_addr + range.size - 1,
>> +                            range.pci_addr);
>>
>>                       /* We support only one IO range */
>>                       if (hose->pci_io_size) {
>> @@ -729,11 +705,12 @@ void pci_process_bridge_OF_ranges(struct pci_controller *hose,
>>                       }
>>  #ifdef CONFIG_PPC32
>>                       /* On 32 bits, limit I/O space to 16MB */
>> -                     if (size > 0x01000000)
>> -                             size = 0x01000000;
>> +                     if (range.size > 0x01000000)
>> +                             range.size = 0x01000000;
>>
>>                       /* 32 bits needs to map IOs here */
>> -                     hose->io_base_virt = ioremap(cpu_addr, size);
>> +                     hose->io_base_virt = ioremap(range.cpu_addr,
>> +                                             range.size);
>>
>>                       /* Expect trouble if pci_addr is not 0 */
>>                       if (primary)
>> @@ -743,20 +720,20 @@ void pci_process_bridge_OF_ranges(struct pci_controller *hose,
>>                       /* pci_io_size and io_base_phys always represent IO
>>                        * space starting at 0 so we factor in pci_addr
>>                        */
>> -                     hose->pci_io_size = pci_addr + size;
>> -                     hose->io_base_phys = cpu_addr - pci_addr;
>> +                     hose->pci_io_size = range.pci_addr + range.size;
>> +                     hose->io_base_phys = range.cpu_addr - range.pci_addr;
>>
>>                       /* Build resource */
>>                       res = &hose->io_resource;
>> -                     res->flags = IORESOURCE_IO;
>> -                     res->start = pci_addr;
>> +                     range.cpu_addr = range.pci_addr;
>>                       break;
>> -             case 2:         /* PCI Memory space */
>> -             case 3:         /* PCI 64 bits Memory space */
>> +             case IORESOURCE_MEM:
>>                       printk(KERN_INFO
>>                              " MEM 0x%016llx..0x%016llx -> 0x%016llx %s\n",
>> -                            cpu_addr, cpu_addr + size - 1, pci_addr,
>> -                            (pci_space & 0x40000000) ? "Prefetch" : "");
>> +                            range.cpu_addr, range.cpu_addr + range.size - 1,
>> +                            range.pci_addr,
>> +                            (range.pci_space & 0x40000000) ?
>> +                            "Prefetch" : "");
>>
>>                       /* We support only 3 memory ranges */
>>                       if (memno >= 3) {
>> @@ -765,28 +742,21 @@ void pci_process_bridge_OF_ranges(struct pci_controller *hose,
>>                               continue;
>>                       }
>>                       /* Handles ISA memory hole space here */
>> -                     if (pci_addr == 0) {
>> +                     if (range.pci_addr == 0) {
>>                               if (primary || isa_mem_base == 0)
>> -                                     isa_mem_base = cpu_addr;
>> -                             hose->isa_mem_phys = cpu_addr;
>> -                             hose->isa_mem_size = size;
>> +                                     isa_mem_base = range.cpu_addr;
>> +                             hose->isa_mem_phys = range.cpu_addr;
>> +                             hose->isa_mem_size = range.size;
>>                       }
>>
>>                       /* Build resource */
>> -                     hose->mem_offset[memno] = cpu_addr - pci_addr;
>> +                     hose->mem_offset[memno] = range.cpu_addr -
>> +                                                     range.pci_addr;
>>                       res = &hose->mem_resources[memno++];
>> -                     res->flags = IORESOURCE_MEM;
>> -                     if (pci_space & 0x40000000)
>> -                             res->flags |= IORESOURCE_PREFETCH;
>> -                     res->start = cpu_addr;
>>                       break;
>>               }
>>               if (res != NULL) {
>> -                     res->name = dev->full_name;
>> -                     res->end = res->start + size - 1;
>> -                     res->parent = NULL;
>> -                     res->sibling = NULL;
>> -                     res->child = NULL;
>> +                     of_pci_range_to_resource(&range, dev, res);
>>               }
>>       }
>>  }
>
>



-- 
Andrew Murray, Director
Embedded Bits Limited
www.embedded-bits.co.uk

Embedded Bits Limited is a company registered in England and Wales
with company number 08178608 and VAT number 140658911. Registered
office: Embedded Bits Limited c/o InTouch Accounting Ltd. Bristol and
West House Post Office Road Bournemouth Dorset BH1 1BL
