Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r1CMh13PCzDq5m
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 May 2016 10:29:36 +1000 (AEST)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 6 May 2016 10:29:34 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 4AE832CE8057
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 May 2016 10:29:32 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u460TO9w54657246
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 May 2016 10:29:32 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u460SwI1012211
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 May 2016 10:28:59 +1000
Date: Fri, 6 May 2016 10:28:34 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Rob Herring <robherring2@gmail.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Bjorn Helgaas <bhelgaas@google.com>, dja@axtens.net,
 Alistair Popple <alistair@popple.id.au>
Subject: Re: [PATCH v9 22/22] PCI/hotplug: PowerPC PowerNV PCI hotplug driver
Message-ID: <20160506002834.GA5509@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1462281773-26438-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1462281773-26438-23-git-send-email-gwshan@linux.vnet.ibm.com>
 <CAL_JsqLAYk2S80LNvF2z2ZzPfCWAbpz2LNKK-04OgSkabjWbxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAL_JsqLAYk2S80LNvF2z2ZzPfCWAbpz2LNKK-04OgSkabjWbxQ@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 05, 2016 at 12:04:49PM -0500, Rob Herring wrote:
>On Tue, May 3, 2016 at 8:22 AM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
>> This adds standalone driver to support PCI hotplug for PowerPC PowerNV
>> platform that runs on top of skiboot firmware. The firmware identifies
>> hotpluggable slots and marked their device tree node with proper
>> "ibm,slot-pluggable" and "ibm,reset-by-firmware". The driver scans
>> device tree nodes to create/register PCI hotplug slot accordingly.
>>
>> The PCI slots are organized in fashion of tree, which means one
>> PCI slot might have parent PCI slot and parent PCI slot possibly
>> contains multiple child PCI slots. At the plugging time, the parent
>> PCI slot is populated before its children. The child PCI slots are
>> removed before their parent PCI slot can be removed from the system.
>>
>> If the skiboot firmware doesn't support slot status retrieval, the PCI
>> slot device node shouldn't have property "ibm,reset-by-firmware". In
>> that case, none of valid PCI slots will be detected from device tree.
>> The skiboot firmware doesn't export the capability to access attention
>> LEDs yet and it's something for TBD.
>>
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
>[...]
>
>> +static void pnv_php_handle_poweron(struct pnv_php_slot *php_slot)
>> +{
>> +       void *fdt, *fdt1, *dt;
>> +       int confirm = PNV_PHP_POWER_CONFIRMED_SUCCESS;
>> +       int ret;
>> +
>> +       /* We don't know the FDT blob size. We try to get it through
>> +        * maximal memory chunk and then copy it to another chunk that
>> +        * fits the real size.
>> +        */
>> +       fdt1 = kzalloc(0x10000, GFP_KERNEL);
>> +       if (!fdt1)
>> +               goto error;
>> +
>> +       ret = pnv_pci_get_device_tree(php_slot->dn->phandle, fdt1, 0x10000);
>> +       if (ret)
>> +               goto free_fdt1;
>> +
>> +       fdt = kzalloc(fdt_totalsize(fdt1), GFP_KERNEL);
>> +       if (!fdt)
>> +               goto free_fdt1;
>> +
>> +       /* Unflatten device tree blob */
>> +       memcpy(fdt, fdt1, fdt_totalsize(fdt1));
>
>This is wrong. If the size is greater than 64K, then you will be
>overrunning the fdt1 buffer. You need to fetch the FDT again if it is
>bigger than 64KB.
>

Thanks for review, Rob. Sorry that I don't see how it's a problem. An
errcode is returned from pnv_pci_get_device_tree() if the FDT blob
size is greater than 64K. In this case, memcpy() won't be triggered.
pnv_pci_get_device_tree() relies on firmware implementation which
avoids overrunning the buffer.

On the other hand, it would be reasonable to retry retriving the
FDT blob if 64K buffer isn't enough. Also, kzalloc() can be replaced
with alloc_pages() as 64K is the default page size on PPC64. I will
have something like below until some one has more concerns. As the
size of the allocated buffer will be greater than the real FDT blob
size, some memory (not too much) is wasted. I guess it should be ok.

	struct page *page;
	void *fdt;
	unsigned int order;
	int ret;

	for (order = 0; order < MAX_ORDER; order++) {
		page = alloc_pages(GFP_KERNEL, order);
		if (page) {
			fdt = page_address(page);
			ret = pnv_pci_get_device_tree(php_slot->dn->phandle,
						      fdt, (1 << order) * PAGE_SIZE);
			if (ret) {
				dev_dbg(&php_slot->pdev.dev, "Error %d getting device tree (%d)\n",
					ret, order);
				free_pages(fdt, order);
				continue;
			}
		}
	}

	if (order >= MAX_ORDER) {
		dev_warn(&php_slot->pdev.dev, "Cannot get device tree\n");
		return;
	}

	/* Unflatten the blob without copying it to another allocated buffer */

Thanks,
Gavin

>
>> +       dt = of_fdt_unflatten_tree(fdt, php_slot->dn, NULL);
>> +       if (!dt) {
>> +               dev_warn(&php_slot->pdev->dev, "Cannot unflatten FDT\n");
>> +               goto free_fdt;
>> +       }
>> +
>
