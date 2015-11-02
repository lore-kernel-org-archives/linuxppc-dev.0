Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C0D2D1A03C6
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Nov 2015 15:58:13 +1100 (AEDT)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 2 Nov 2015 14:58:11 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 5EA512CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Nov 2015 15:58:09 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA24vkpc27394188
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Nov 2015 15:57:55 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA24vZLq002135
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Nov 2015 15:57:36 +1100
Message-ID: <5636ED27.6010707@au1.ibm.com>
Date: Mon, 02 Nov 2015 15:57:11 +1100
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org
CC: imunsie@au1.ibm.com, dja@axtens.net
Subject: Re: [PATCH] cxl: sparse: add __iomem annotations in vphb.c
References: <1446002979-29728-1-git-send-email-andrew.donnellan@au1.ibm.com>
 <6848216.pocJKKsE8F@wuerfel>
In-Reply-To: <6848216.pocJKKsE8F@wuerfel>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 31/10/15 00:07, Arnd Bergmann wrote:
> On Wednesday 28 October 2015 14:29:39 Andrew Donnellan wrote:
>> --- a/drivers/misc/cxl/vphb.c
>> +++ b/drivers/misc/cxl/vphb.c
>> @@ -128,7 +128,7 @@ static int cxl_pcie_config_info(struct pci_bus *bus, unsigned int devfn,
>>                  return PCIBIOS_BAD_REGISTER_NUMBER;
>>          addr = cxl_pcie_cfg_addr(phb, bus->number, devfn, offset);
>>
>> -       *ioaddr = (void *)(addr & ~0x3ULL);
>> +       *ioaddr = (void __iomem *)(addr & ~0x3ULL);
>>          *shift = ((addr & 0x3) * 8);
>>          switch (len) {
>>          case 1:
>
> It would be nice to change the return value of cxl_pcie_cfg_addr to
> 'void __iomem *' as well, and only do the cast (back and forth) inside
> the calculation, to make it clear that the input type is the same as the
> output. Perhaps use a static inline function to wrap it.

That would work, not sure if I'd bother with a wrapper function.

>> @@ -249,7 +249,7 @@ int cxl_pci_vphb_add(struct cxl_afu *afu)
>>          /* Setup the PHB using arch provided callback */
>>          phb->ops = &cxl_pcie_pci_ops;
>>          phb->cfg_addr = afu->afu_desc_mmio + afu->crs_offset;
>> -       phb->cfg_data = (void *)(u64)afu->crs_len;
>> +       phb->cfg_data = (void __iomem *)afu->crs_len;
>>          phb->private_data = afu;
>>          phb->controller_ops = cxl_pci_controller_ops;
>
>
> This needs a comment to explain why this is correct. I've tried to find it
> out by reading the code and could not find any explanation. Also, you
> need to cast to an intermediate (uintptr_t) type, as directly converting
> a u64 to a pointer of any sort is nonportable, and it would be good to
> at least allow compile-testing this code on other architectures.

It's impossible to compile cxl on other architectures given that we 
depend on powerpc- and powernv-specific functions... but in any case, I 
suppose using uintptr_t is more correct.

> I suspect that 'phb->cfg_data' is used in this driver in a way that is
> incompatible with the other uses of the same variable. Maybe you can
> replace it with something like
>
> 	union {
> 		void __iomem *cfg_data;
> 		u64 cxl_cfg_offset;
> 	};
>
> to make it clear that in this driver it is used as an offset rather than
> a pointer.

You're right, I hadn't looked closely at exactly how it was been used.

Ian, thoughts?


Andrew

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
