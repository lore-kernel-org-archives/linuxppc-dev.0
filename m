Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yn9Yz3RWVzDr3x
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Nov 2017 06:28:38 +1100 (AEDT)
Subject: [PATCH] SB600 for the Nemo board has non-zero devices on non-root bus
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Bjorn Helgaas <bhelgaas@google.com>
References: <f3513294-6da0-456f-0f98-1f8c3bac90c9@xenosoft.de>
 <87tvxl15qx.fsf@concordia.ellerman.id.au>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <4cfe3cc0-7fe3-9774-7d20-1b7fcb7aa910@xenosoft.de>
Date: Wed, 29 Nov 2017 20:28:25 +0100
MIME-Version: 1.0
In-Reply-To: <87tvxl15qx.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 23 November 2017 2:31PM, Michael Ellerman wrote:
> Hi Christian,
>
> Thanks for your patch.
>
> Christian Zigotzky <chzigotzky@xenosoft.de> writes:
>> Hi All,
>>
>> Just a small patch for the P.A. Semi Nemo board:
>>
>> -----
>>
>> diff -rupN a/drivers/pci/probe.c b/drivers/pci/probe.c
>> --- a/drivers/pci/probe.c    2017-11-16 08:18:40.504012010 +0100
>> +++ b/drivers/pci/probe.c    2017-11-16 08:17:22.044368405 +0100
>> @@ -2219,6 +2219,8 @@ static int only_one_child(struct pci_bus
> As this is a patch to the PCI code I can't merge it via the powerpc
> tree. You would need to send it to linux-pci@vger.kernel.org.
>
>>        if (!parent || !pci_is_pcie(parent))
>>            return 0;
>> +    #ifndef CONFIG_PPC_PASEMI_NEMO
>> +    // SB600 for the Nemo board has non-zero devices on non-root bus.
>>        if (pci_pcie_type(parent) == PCI_EXP_TYPE_ROOT_PORT)
>>            return 1;
>>
>> @@ -2231,6 +2233,7 @@ static int only_one_child(struct pci_bus
>>        if (parent->has_secondary_link &&
>>            !pci_has_flag(PCI_SCAN_ALL_PCIE_DEVS))
>>            return 1;
>> +    #endif
> But the PCI maintainer is not going to accept a patch like this, which
> adds a platform specific #ifdef in core code like this.
>
> If you look at the rest of that file I don't think you'll find a single
> #ifdef other than for generic configuration symbols.
>
> Are you sure the PCI_SCAN_ALL_PCIE_DEVS logic doesn't work for you? It
> sounds like it was added for exactly this problem.
>
> cheers
>
Hi Michael,

Thanks for your reply. Sorry for my late answer. I removed the patch 
above from the RC1 and compiled the RC1 again. Unfortunately without the 
patch, the kernel doesn't recognize any drives and partitions. Do you 
have another idea?

Thanks,
Christian
