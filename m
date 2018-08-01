Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41gbTW0CpBzF1HF
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Aug 2018 00:36:15 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christian Zigotzky <chzigotzky@xenosoft.de>,
 Darren Stevens <darren@stevens-zone.net>, linuxppc-dev@lists.ozlabs.org
Cc: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] powerpc/pasemi: Seach for PCI root bus by compatible
 property
In-Reply-To: <fde71219-5e0e-cc12-a31f-258ce547f471@xenosoft.de>
References: <4c4cb2b4391.4d23d508@auth.smtp.1and1.co.uk>
 <8736vzhb6h.fsf@concordia.ellerman.id.au>
 <87zhy7fw7f.fsf@concordia.ellerman.id.au>
 <fde71219-5e0e-cc12-a31f-258ce547f471@xenosoft.de>
Date: Thu, 02 Aug 2018 00:36:13 +1000
Message-ID: <877elaf92a.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christian Zigotzky <chzigotzky@xenosoft.de> writes:

> Just for info: I tested it on my Nemo board today and it works.

Awesome thanks.

That's probably sufficient to merge it, and if it breaks anything we can
always revert it.

cheers

> On 31 July 2018 at 2:04PM, Michael Ellerman wrote:
>> Michael Ellerman <mpe@ellerman.id.au> writes:
>>> Darren Stevens <darren@stevens-zone.net> writes:
>>>
>>>> Pasemi arch code finds the root of the PCI-e bus by searching the
>>>> device-tree for a node called 'pxp'. But the root bus has a
>>>> compatible property of 'pasemi,rootbus' so search for that instead.
>>>>
>>>> Signed-off-by: Darren Stevens <darren@stevens-zone.net>
>>>> ---
>>>>
>>>> This works on the Amigaone X1000, I don't know if this method of
>>>> finding the pci bus was there bcause of earlier firmwares.
>>> Does anyone have another pasemi board they can test this on?
>>>
>>> The last time I plugged mine in it popped the power supply and took out
>>> power to half the office :) - I haven't had a chance to try it since.
>> I actually I remembered I have a device tree lying around from an electra.
>>
>> It has:
>>
>>    [I] home:pxp@0,80000000(7)(I)> lsprop name compatible
>>    name             "pxp"
>>    compatible       "pasemi,rootbus"
>>                     "pa-pxp"
>>
>>
>> So it looks like the patch would work fine on it at least.
>>
>> cheers
>>
>>>> diff --git a/arch/powerpc/platforms/pasemi/pci.c b/arch/powerpc/platforms/pasemi/pci.c
>>>> index c7c8607..be62380 100644
>>>> --- a/arch/powerpc/platforms/pasemi/pci.c
>>>> +++ b/arch/powerpc/platforms/pasemi/pci.c
>>>> @@ -216,6 +216,7 @@ static int __init pas_add_bridge(struct device_node *dev)
>>>>   void __init pas_pci_init(void)
>>>>   {
>>>>      struct device_node *np, *root;
>>>> +   int res;
>>>>   
>>>>      root = of_find_node_by_path("/");
>>>>      if (!root) {
>>>> @@ -226,11 +227,11 @@ void __init pas_pci_init(void)
>>>>   
>>>>      pci_set_flags(PCI_SCAN_ALL_PCIE_DEVS);
>>>>   
>>>> -   for (np = NULL; (np = of_get_next_child(root, np)) != NULL;)
>>>> -       if (np->name && !strcmp(np->name, "pxp") && !pas_add_bridge(np))
>>>> -           of_node_get(np);
>>>> -
>>>> -   of_node_put(root);
>>>> +   np = of_find_compatible_node(root, NULL, "pasemi,rootbus");
>>>> +   if (np) {
>>>> +       res = pas_add_bridge(np);
>>>> +       of_node_put(np);
>>>> +   }
>>>>   }
>>>>   
>>>>   void __iomem *pasemi_pci_getcfgaddr(struct pci_dev *dev, int offset)
