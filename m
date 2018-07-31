Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41g0q6016JzF14l
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 01:34:25 +1000 (AEST)
Subject: [PATCH] powerpc/pasemi: Seach for PCI root bus by compatible property
To: Michael Ellerman <mpe@ellerman.id.au>,
 Darren Stevens <darren@stevens-zone.net>, linuxppc-dev@lists.ozlabs.org
Cc: Olof Johansson <olof@lixom.net>
References: <4c4cb2b4391.4d23d508@auth.smtp.1and1.co.uk>
 <8736vzhb6h.fsf@concordia.ellerman.id.au>
 <87zhy7fw7f.fsf@concordia.ellerman.id.au>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <fde71219-5e0e-cc12-a31f-258ce547f471@xenosoft.de>
Date: Tue, 31 Jul 2018 17:34:09 +0200
MIME-Version: 1.0
In-Reply-To: <87zhy7fw7f.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Just for info: I tested it on my Nemo board today and it works.

-- Christian

On 31 July 2018 at 2:04PM, Michael Ellerman wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
>> Darren Stevens <darren@stevens-zone.net> writes:
>>
>>> Pasemi arch code finds the root of the PCI-e bus by searching the
>>> device-tree for a node called 'pxp'. But the root bus has a
>>> compatible property of 'pasemi,rootbus' so search for that instead.
>>>
>>> Signed-off-by: Darren Stevens <darren@stevens-zone.net>
>>> ---
>>>
>>> This works on the Amigaone X1000, I don't know if this method of
>>> finding the pci bus was there bcause of earlier firmwares.
>> Does anyone have another pasemi board they can test this on?
>>
>> The last time I plugged mine in it popped the power supply and took out
>> power to half the office :) - I haven't had a chance to try it since.
> I actually I remembered I have a device tree lying around from an electra.
>
> It has:
>
>    [I] home:pxp@0,80000000(7)(I)> lsprop name compatible
>    name             "pxp"
>    compatible       "pasemi,rootbus"
>                     "pa-pxp"
>
>
> So it looks like the patch would work fine on it at least.
>
> cheers
>
>>> diff --git a/arch/powerpc/platforms/pasemi/pci.c b/arch/powerpc/platforms/pasemi/pci.c
>>> index c7c8607..be62380 100644
>>> --- a/arch/powerpc/platforms/pasemi/pci.c
>>> +++ b/arch/powerpc/platforms/pasemi/pci.c
>>> @@ -216,6 +216,7 @@ static int __init pas_add_bridge(struct device_node *dev)
>>>   void __init pas_pci_init(void)
>>>   {
>>>      struct device_node *np, *root;
>>> +   int res;
>>>   
>>>      root = of_find_node_by_path("/");
>>>      if (!root) {
>>> @@ -226,11 +227,11 @@ void __init pas_pci_init(void)
>>>   
>>>      pci_set_flags(PCI_SCAN_ALL_PCIE_DEVS);
>>>   
>>> -   for (np = NULL; (np = of_get_next_child(root, np)) != NULL;)
>>> -       if (np->name && !strcmp(np->name, "pxp") && !pas_add_bridge(np))
>>> -           of_node_get(np);
>>> -
>>> -   of_node_put(root);
>>> +   np = of_find_compatible_node(root, NULL, "pasemi,rootbus");
>>> +   if (np) {
>>> +       res = pas_add_bridge(np);
>>> +       of_node_put(np);
>>> +   }
>>>   }
>>>   
>>>   void __iomem *pasemi_pci_getcfgaddr(struct pci_dev *dev, int offset)
