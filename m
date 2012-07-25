Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 71B1F2C0092
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2012 03:26:05 +1000 (EST)
Message-ID: <50102C27.8040004@freescale.com>
Date: Wed, 25 Jul 2012 12:25:59 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jia Hongtao-B38951 <B38951@freescale.com>
Subject: Re: [PATCH 3/6] powerpc/fsl-pci: Determine primary bus by looking
 for ISA node
References: <1343125210-16720-1-git-send-email-B38951@freescale.com>
 <1343125210-16720-3-git-send-email-B38951@freescale.com>
 <500EEDD9.8050507@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5D01A275B4@039-SN1MPN1-002.039d.mgd.msft.net>
In-Reply-To: <412C8208B4A0464FA894C5F0C278CD5D01A275B4@039-SN1MPN1-002.039d.mgd.msft.net>
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

On 07/24/2012 09:42 PM, Jia Hongtao-B38951 wrote:
> 
> 
>> -----Original Message-----
>> From: Wood Scott-B07421
>> Sent: Wednesday, July 25, 2012 2:48 AM
>> To: Jia Hongtao-B38951
>> Cc: linuxppc-dev@lists.ozlabs.org; galak@kernel.crashing.org; Wood Scott-
>> B07421; Li Yang-R58472
>> Subject: Re: [PATCH 3/6] powerpc/fsl-pci: Determine primary bus by
>> looking for ISA node
>>
>> On 07/24/2012 05:20 AM, Jia Hongtao wrote:
>>> PCI host bridge is primary bus if it contains an ISA node. But not all
>> boards
>>> fit this rule. Device tree should be updated for all these boards.
>>>
>>> Signed-off-by: Jia Hongtao <B38951@freescale.com>
>>> Signed-off-by: Li Yang <leoli@freescale.com>
>>> ---
>>>  arch/powerpc/include/asm/pci-bridge.h |    1 +
>>>  arch/powerpc/sysdev/fsl_pci.c         |   31 ++++++++++++++++++++++++-
>> ------
>>>  arch/powerpc/sysdev/fsl_pci.h         |   12 +++++++++++-
>>>  3 files changed, 36 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/arch/powerpc/include/asm/pci-bridge.h
>> b/arch/powerpc/include/asm/pci-bridge.h
>>> index ac39e6a..b48fa7f 100644
>>> --- a/arch/powerpc/include/asm/pci-bridge.h
>>> +++ b/arch/powerpc/include/asm/pci-bridge.h
>>> @@ -20,6 +20,7 @@ struct device_node;
>>>  struct pci_controller {
>>>  	struct pci_bus *bus;
>>>  	char is_dynamic;
>>> +	int is_primary;
>>>  #ifdef CONFIG_PPC64
>>>  	int node;
>>>  #endif
>>> diff --git a/arch/powerpc/sysdev/fsl_pci.c
>> b/arch/powerpc/sysdev/fsl_pci.c
>>> index 99a3e78..2a369be 100644
>>> --- a/arch/powerpc/sysdev/fsl_pci.c
>>> +++ b/arch/powerpc/sysdev/fsl_pci.c
>>> @@ -453,6 +453,7 @@ int __init fsl_add_bridge(struct device_node *dev,
>> int is_primary)
>>>
>>>  	hose->first_busno = bus_range ? bus_range[0] : 0x0;
>>>  	hose->last_busno = bus_range ? bus_range[1] : 0xff;
>>> +	hose->is_primary = is_primary;
>>>
>>>  	setup_indirect_pci(hose, rsrc.start, rsrc.start + 0x4,
>>>  		PPC_INDIRECT_TYPE_BIG_ENDIAN);
>>> @@ -932,18 +933,34 @@ void pci_check_swiotlb(void)
>>>  }
>>>  #endif
>>>
>>> -int primary_phb_addr;
>>> +/*
>>> + * Recursively scan all the children nodes of parent and find out if
>> there
>>> + * is "isa" node. Return 1 if parent has isa node otherwise return 0.
>>> + */
>>> +int has_isa_node(struct device_node *parent)
>>> +{
>>> +	static int result;
>>> +	struct device_node *cur_child;
>>> +
>>> +	cur_child = NULL;
>>> +	result = 0;
>>> +	while (!result && (cur_child = of_get_next_child(parent,
>> cur_child))) {
>>> +		/* Get "isa" node and return 1 */
>>> +		if (of_node_cmp(cur_child->type, "isa") == 0)
>>> +			return result = 1;
>>> +		has_isa_node(cur_child);
>>> +	}
>>> +
>>> +	return result;
>>> +}
>>
>> Why are you reimplementing this?  It's already in Linus's tree.  See
>> fsl_pci_init().
>>
>> Plus, your version is recursive which is unacceptable in kernel code
>> with a small stack (outside of a few rare examples where the depth has a
>> small fixed upper bound), and once it finds an ISA node, it returns 1
>> forever, regardless of what node you pass in in the future.
>>
>> -Scott
> 
> About recursion I will do some more investigation.
> If it finds ISA it returns 1. But for next PCI node it will return 0 if
> no ISA is found (note that I set result to 0 at the beginning).

Sorry, I misread that as an initializer.  Still, it's awkward (why not
just use a return value?) and non-thread-safe (may not matter here, but
it's a bad habit), and it's still an unacceptable use of recursion, and
still a reimplementation of functionality that already exists. :-)

-Scott
