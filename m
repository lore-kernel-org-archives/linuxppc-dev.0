Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9378B2C008E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2012 03:23:58 +1000 (EST)
Message-ID: <50102B98.4000801@freescale.com>
Date: Wed, 25 Jul 2012 12:23:36 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jia Hongtao-B38951 <B38951@freescale.com>
Subject: Re: [PATCH 1/6] powerpc/fsl-pci: Unify pci/pcie initialization code
References: <1343125210-16720-1-git-send-email-B38951@freescale.com>
 <500EECA3.3050806@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5D01A27578@039-SN1MPN1-002.039d.mgd.msft.net>
In-Reply-To: <412C8208B4A0464FA894C5F0C278CD5D01A27578@039-SN1MPN1-002.039d.mgd.msft.net>
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

On 07/24/2012 09:35 PM, Jia Hongtao-B38951 wrote:
> 
> 
>> -----Original Message-----
>> From: Wood Scott-B07421
>> Sent: Wednesday, July 25, 2012 2:43 AM
>> To: Jia Hongtao-B38951
>> Cc: linuxppc-dev@lists.ozlabs.org; galak@kernel.crashing.org; Wood Scott-
>> B07421; Li Yang-R58472
>> Subject: Re: [PATCH 1/6] powerpc/fsl-pci: Unify pci/pcie initialization
>> code
>>
>> On 07/24/2012 05:20 AM, Jia Hongtao wrote:
>>> We unified the Freescale pci/pcie initialization by changing the
>> fsl_pci
>>> to a platform driver.
>>>
>>> In previous version pci/pcie initialization is in platform code which
>>> Initialize pci bridge base on EP/RC or host/agent settings.
>>
>> The previous version of what?  This patch, or the PCI code?  What
>> changed in this patch since the last time you sent it, and where is the
>> version number?
>>
>>> +#if defined(CONFIG_FSL_SOC_BOOKE) || defined(CONFIG_PPC_86xx)
>>> +static const struct of_device_id pci_ids[] = {
>>> +	{ .compatible = "fsl,mpc8540-pci", },
>>> +	{ .compatible = "fsl,mpc8548-pcie", },
>>> +	{ .compatible = "fsl,mpc8641-pcie", },
>>> +	{ .compatible = "fsl,p1022-pcie", },
>>> +	{ .compatible = "fsl,p1010-pcie", },
>>> +	{ .compatible = "fsl,p1023-pcie", },
>>> +	{ .compatible = "fsl,p4080-pcie", },
>>> +	{ .compatible = "fsl,qoriq-pcie-v2.3", },
>>> +	{ .compatible = "fsl,qoriq-pcie-v2.2", },
>>> +	{},
>>> +};
>>
>> Again, please base this on the latest tree, which has my PCI patches.
>> This table already exists in this file.  And you're still missing
>> fsl,mpc8610-pci.
> 
> Sorry fsl,mpc8610-pci will be added.

To what?  The table is already there in Linus's tree, with
fsl,mpc8610-pci.  You don't need to add it again.

>> It's too late for swiotlb here.  Again, please don't break something in
>> one patch and then fix it in a later patch.  Use "git rebase -i" to edit
>> your patchset into a reviewable, bisectable form.
>>
>> -Scott
> 
> Yes, bisectable requirement is sort of reasonable. 
> 
> But I check the SubmittingPatches Doc and it says "If one patch depends on
> another patch in order for a change to be complete, that is OK. Simply
> note 'this patch depends on patch X' in your patch description". In my
> opinion swiotlb is a whole functional patch so I separate them. Maybe
> I should add depends description in the next patch.

That's not what that means.  What it means is that if someone else has
already posted a patch, and your patch is supposed to go on top of that
patch, you should mention that.

> About all this patch set Leo and I insist to make it as a platform driver
> which is architectural better. I didn't base this patch set on the latest
> tree and it's unapplicable just because I want to show the whole idea of
> this patchset. If the idea is ok for upstream I will rebase the patch set.

If that's the case, you should label it as an [RFC PATCH] (stands for
Request For Comments), and mention under the --- line any known issues,
such as that it doesn't apply to the current tree.

But it would be a lot easier to comment on it if it were based on the
current code, rather than having to speculate what you'd do when you rebase.

-Scott
