Return-Path: <bhelgaas@google.com>
Received: from mail-yb0-x243.google.com (mail-yb0-x243.google.com
 [IPv6:2607:f8b0:4002:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yn9zY6xR1zDr8J
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Nov 2017 06:47:20 +1100 (AEDT)
Received: by mail-yb0-x243.google.com with SMTP id i206so1791085ybc.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Nov 2017 11:47:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4cfe3cc0-7fe3-9774-7d20-1b7fcb7aa910@xenosoft.de>
References: <f3513294-6da0-456f-0f98-1f8c3bac90c9@xenosoft.de>
 <87tvxl15qx.fsf@concordia.ellerman.id.au>
 <4cfe3cc0-7fe3-9774-7d20-1b7fcb7aa910@xenosoft.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 29 Nov 2017 13:46:57 -0600
Message-ID: <CAErSpo55Q8Q=5p6_+uu7ahnw+53ibVDNRXxrzRV9QnUr_9EUfw@mail.gmail.com>
Subject: Re: [PATCH] SB600 for the Nemo board has non-zero devices on non-root
 bus
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 29, 2017 at 1:28 PM, Christian Zigotzky
<chzigotzky@xenosoft.de> wrote:
> On 23 November 2017 2:31PM, Michael Ellerman wrote:
>>
>> Hi Christian,
>>
>> Thanks for your patch.
>>
>> Christian Zigotzky <chzigotzky@xenosoft.de> writes:
>>>
>>> Hi All,
>>>
>>> Just a small patch for the P.A. Semi Nemo board:
>>>
>>> -----
>>>
>>> diff -rupN a/drivers/pci/probe.c b/drivers/pci/probe.c
>>> --- a/drivers/pci/probe.c    2017-11-16 08:18:40.504012010 +0100
>>> +++ b/drivers/pci/probe.c    2017-11-16 08:17:22.044368405 +0100
>>> @@ -2219,6 +2219,8 @@ static int only_one_child(struct pci_bus
>>
>> As this is a patch to the PCI code I can't merge it via the powerpc
>> tree. You would need to send it to linux-pci@vger.kernel.org.
>>
>>>        if (!parent || !pci_is_pcie(parent))
>>>            return 0;
>>> +    #ifndef CONFIG_PPC_PASEMI_NEMO
>>> +    // SB600 for the Nemo board has non-zero devices on non-root bus.
>>>        if (pci_pcie_type(parent) == PCI_EXP_TYPE_ROOT_PORT)
>>>            return 1;
>>>
>>> @@ -2231,6 +2233,7 @@ static int only_one_child(struct pci_bus
>>>        if (parent->has_secondary_link &&
>>>            !pci_has_flag(PCI_SCAN_ALL_PCIE_DEVS))
>>>            return 1;
>>> +    #endif
>>
>> But the PCI maintainer is not going to accept a patch like this, which
>> adds a platform specific #ifdef in core code like this.
>>
>> If you look at the rest of that file I don't think you'll find a single
>> #ifdef other than for generic configuration symbols.
>>
>> Are you sure the PCI_SCAN_ALL_PCIE_DEVS logic doesn't work for you? It
>> sounds like it was added for exactly this problem.
>>
>> cheers
>>
> Hi Michael,
>
> Thanks for your reply. Sorry for my late answer. I removed the patch above
> from the RC1 and compiled the RC1 again. Unfortunately without the patch,
> the kernel doesn't recognize any drives and partitions. Do you have another
> idea?

What happens if you boot RC1 with "pci=pcie_scan_all"?  If that works,
we do have some quirks that set that automatically, and we might be
able to add another one for the Nemo.

Can you collect the complete "lspci -vv" and dmesg output for this
system?  I'm curious about why it is special.

Bjorn
