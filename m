Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9FB762C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Aug 2012 01:10:03 +1000 (EST)
Message-ID: <501FDE40.1060906@freescale.com>
Date: Mon, 6 Aug 2012 10:09:52 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jia Hongtao-B38951 <B38951@freescale.com>
Subject: Re: [PATCH V5 3/3] powerpc/fsl-pci: Unify pci/pcie initialization code
References: <1343988851-884-1-git-send-email-B38951@freescale.com>
 <1343988851-884-4-git-send-email-B38951@freescale.com>
 <501BFC0E.6070708@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5D01A36D0A@039-SN1MPN1-002.039d.mgd.msft.net>
In-Reply-To: <412C8208B4A0464FA894C5F0C278CD5D01A36D0A@039-SN1MPN1-002.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/05/2012 10:07 PM, Jia Hongtao-B38951 wrote:
> 
> 
>> -----Original Message-----
>> From: Wood Scott-B07421
>> Sent: Saturday, August 04, 2012 12:28 AM
>> To: Jia Hongtao-B38951
>> Cc: linuxppc-dev@lists.ozlabs.org; galak@kernel.crashing.org; Li Yang-
>> R58472; Wood Scott-B07421
>> Subject: Re: [PATCH V5 3/3] powerpc/fsl-pci: Unify pci/pcie
>> initialization code
>>
>> On 08/03/2012 05:14 AM, Jia Hongtao wrote:
>>> -void __devinit fsl_pci_init(void)
>>> +/* Checkout if PCI contains ISA node */
>>> +static int of_pci_has_isa(struct device_node *pci_node)
>>> +{
>>> +	struct device_node *np;
>>> +	int ret = 0;
>>> +
>>> +	if (!pci_node)
>>> +		return 0;
>>> +
>>> +	read_lock(&devtree_lock);
>>> +	np = pci_node->allnext;
>>> +
>>> +	/* Only scan the children of PCI node */
>>> +	for (; np != pci_node->sibling; np = np->allnext) {
>>> +		if (np->type && (of_node_cmp(np->type, "isa") == 0)
>>> +		    && of_node_get(np)) {
>>> +			ret = 1;
>>> +			break;
>>> +		}
>>> +	}
>>> +
>>> +	of_node_put(pci_node);
>>> +	read_unlock(&devtree_lock);
>>> +
>>> +	return ret;
>>> +}
>>
>> Why do you keep insisting on substituting your ISA search code here?
>> What advantages does it have over the code that is already there?  It
>> unnecessarily digs into the internals of the tree representation.
>>
> 
> I want ISA search is done from probe.

Too bad.  You're breaking the case where there's no ISA node.

> Also this way is more efficient due
> to we just search the children of PCI.

It is not more efficient, because you're doing the search for every PCIe
bus rather than once.  Not that it matters in this context.

>>> +
>>> +static int __devinit fsl_pci_probe(struct platform_device *pdev)
>>>  {
>>>  	int ret;
>>> -	struct device_node *node;
>>>  	struct pci_controller *hose;
>>> -	dma_addr_t max = 0xffffffff;
>>> +	int is_primary = 0;
>>>
>>> -	/* Callers can specify the primary bus using other means. */
>>>  	if (!fsl_pci_primary) {
>>> -		/* If a PCI host bridge contains an ISA node, it's primary.
>> */
>>> -		node = of_find_node_by_type(NULL, "isa");
>>> -		while ((fsl_pci_primary = of_get_parent(node))) {
>>> -			of_node_put(node);
>>> -			node = fsl_pci_primary;
>>> -
>>> -			if (of_match_node(pci_ids, node))
>>> -				break;
>>> -		}
>>> +		is_primary = of_pci_has_isa(pdev->dev.of_node);
>>> +		if (is_primary)
>>> +			fsl_pci_primary = pdev->dev.of_node;
>>>  	}
>>
>> As I explained before, this has to be done globally, not from the probe
>> function, so we can assign a default primary bus if there isn't any ISA.
>>  There are bugs in the Linux PPC PCI code relating to not having any
>> primary bus.
>>
>> -Scott
> 
> In my way of searching ISA you can also assign a default primary bus in board
> specific files. 

That was meant for when the board file had an alternate way of searching
for the primary bus (e.g. look for i8259), not as a replacement for the
mechanism that guarantees there's a primary bus.

You are causing a regression in the qemu_e500.c platform.

> I read your code and found that if there is no ISA node you will assign the
> first PCI bus scanned as primary. It's not all right. Take ge_imp3a as an
> example: The second PCI bus (9000) is primary not the first one.

Does that board have ISA on it, that isn't described by the device tree?
 If so, before converting to the new init mechanism, the board code will
need to set fsl_pci_primary based on its own knowledge of where that ISA
is.  If it doesn't have ISA, it doesn't matter which one we designate as
primary.

> I doubt that there are bugs if no primary assigned.

Yeah, I just implemented the fallback for fun.  Come on.

It was recently discussed on this list.  PCI under QEMU did not work
without it.

> Like mpc85xx_rdb assigned
> no primary at all. Some other boards has no primary ether like p1022ds, p1021mds,
> p1010rdb, p1023rds, all corenet boards (p2041_rdb, p3041_ds, p4080_ds, p5020_ds,
> p5040_ds). If no primary is a bug then all these boards above are not correctly
> setting up.

Those boards are not being correctly set up.  On real hardware things
work by chance, but not under QEMU.

-Scott
