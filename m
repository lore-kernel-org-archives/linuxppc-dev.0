Return-Path: <pku.leo@gmail.com>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
 [209.85.213.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 26EA72C0081
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Aug 2012 14:20:44 +1000 (EST)
Received: by yenr13 with SMTP id r13so3049724yen.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Aug 2012 21:20:41 -0700 (PDT)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <501FDE40.1060906@freescale.com>
References: <1343988851-884-1-git-send-email-B38951@freescale.com>
 <1343988851-884-4-git-send-email-B38951@freescale.com>
 <501BFC0E.6070708@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5D01A36D0A@039-SN1MPN1-002.039d.mgd.msft.net>
 <501FDE40.1060906@freescale.com>
Date: Tue, 7 Aug 2012 12:20:41 +0800
Message-ID: <CADRPPNTqnEt3xE8Et1cbK=GwfemgA3-dF7aH2cTNppCddKJ6DA@mail.gmail.com>
Subject: Re: [PATCH V5 3/3] powerpc/fsl-pci: Unify pci/pcie initialization code
From: Li Yang <leoli@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>,
 Jia Hongtao-B38951 <B38951@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 6, 2012 at 11:09 PM, Scott Wood <scottwood@freescale.com> wrote:
> On 08/05/2012 10:07 PM, Jia Hongtao-B38951 wrote:
>>
>>
>>> -----Original Message-----
>>> From: Wood Scott-B07421
>>> Sent: Saturday, August 04, 2012 12:28 AM
>>> To: Jia Hongtao-B38951
>>> Cc: linuxppc-dev@lists.ozlabs.org; galak@kernel.crashing.org; Li Yang-
>>> R58472; Wood Scott-B07421
>>> Subject: Re: [PATCH V5 3/3] powerpc/fsl-pci: Unify pci/pcie
>>> initialization code
>>>
>>> On 08/03/2012 05:14 AM, Jia Hongtao wrote:
>>>> -void __devinit fsl_pci_init(void)
>>>> +/* Checkout if PCI contains ISA node */
>>>> +static int of_pci_has_isa(struct device_node *pci_node)
>>>> +{
>>>> +   struct device_node *np;
>>>> +   int ret = 0;
>>>> +
>>>> +   if (!pci_node)
>>>> +           return 0;
>>>> +
>>>> +   read_lock(&devtree_lock);
>>>> +   np = pci_node->allnext;
>>>> +
>>>> +   /* Only scan the children of PCI node */
>>>> +   for (; np != pci_node->sibling; np = np->allnext) {
>>>> +           if (np->type && (of_node_cmp(np->type, "isa") == 0)
>>>> +               && of_node_get(np)) {
>>>> +                   ret = 1;
>>>> +                   break;
>>>> +           }
>>>> +   }
>>>> +
>>>> +   of_node_put(pci_node);
>>>> +   read_unlock(&devtree_lock);
>>>> +
>>>> +   return ret;
>>>> +}
>>>
>>> Why do you keep insisting on substituting your ISA search code here?
>>> What advantages does it have over the code that is already there?  It
>>> unnecessarily digs into the internals of the tree representation.
>>>
>>
>> I want ISA search is done from probe.
>
> Too bad.  You're breaking the case where there's no ISA node.
>

We can also take care of special cases with our approach if needed.
But it's not correct to assume the first PCI controller is the primary
one if there is no ISA node.  Your approach is still a band-aid to me.
 We can come back to this issue when we do find a proper solution.

>> Also this way is more efficient due
>> to we just search the children of PCI.
>
> It is not more efficient, because you're doing the search for every PCIe
> bus rather than once.  Not that it matters in this context.

We end up scanning at most a few PCI nodes instead of the whole device
tree for the primary.

>
>>>> +
>>>> +static int __devinit fsl_pci_probe(struct platform_device *pdev)
>>>>  {
>>>>     int ret;
>>>> -   struct device_node *node;
>>>>     struct pci_controller *hose;
>>>> -   dma_addr_t max = 0xffffffff;
>>>> +   int is_primary = 0;
>>>>
>>>> -   /* Callers can specify the primary bus using other means. */
>>>>     if (!fsl_pci_primary) {
>>>> -           /* If a PCI host bridge contains an ISA node, it's primary.
>>> */
>>>> -           node = of_find_node_by_type(NULL, "isa");
>>>> -           while ((fsl_pci_primary = of_get_parent(node))) {
>>>> -                   of_node_put(node);
>>>> -                   node = fsl_pci_primary;
>>>> -
>>>> -                   if (of_match_node(pci_ids, node))
>>>> -                           break;
>>>> -           }
>>>> +           is_primary = of_pci_has_isa(pdev->dev.of_node);
>>>> +           if (is_primary)
>>>> +                   fsl_pci_primary = pdev->dev.of_node;
>>>>     }
>>>
>>> As I explained before, this has to be done globally, not from the probe
>>> function, so we can assign a default primary bus if there isn't any ISA.
>>>  There are bugs in the Linux PPC PCI code relating to not having any
>>> primary bus.
>>>
>>> -Scott
>>
>> In my way of searching ISA you can also assign a default primary bus in board
>> specific files.
>
> That was meant for when the board file had an alternate way of searching
> for the primary bus (e.g. look for i8259), not as a replacement for the
> mechanism that guarantees there's a primary bus.
>
> You are causing a regression in the qemu_e500.c platform.

Can we fix the qemu device tree to address the problem if we do make
it a rule to use the ISA node to indicate the primary bus?

- Leo
