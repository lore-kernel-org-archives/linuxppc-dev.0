Return-Path: <B07421@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe003.messaging.microsoft.com [213.199.154.141])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 81A8E2C0087
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Aug 2012 03:46:00 +1000 (EST)
Received: from mail78-db3 (localhost [127.0.0.1])	by mail78-db3-R.bigfish.com
 (Postfix) with ESMTP id 95ABB8014D	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,
 15 Aug 2012 17:45:54 +0000 (UTC)
Received: from DB3EHSMHS002.bigfish.com (unknown [10.3.81.235])	by
 mail78-db3.bigfish.com (Postfix) with ESMTP id EFEC120049	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Aug 2012 17:45:52 +0000 (UTC)
Message-ID: <502BE04D.90604@freescale.com>
Date: Wed, 15 Aug 2012 12:45:49 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jia Hongtao-B38951 <B38951@freescale.com>
Subject: Re: [PATCH V5 3/3] powerpc/fsl-pci: Unify pci/pcie initialization code
References: <1343988851-884-1-git-send-email-B38951@freescale.com>
 <1343988851-884-4-git-send-email-B38951@freescale.com>
 <501BFC0E.6070708@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5D01A36D0A@039-SN1MPN1-002.039d.mgd.msft.net>
 <501FDE40.1060906@freescale.com>
 <CADRPPNTqnEt3xE8Et1cbK=GwfemgA3-dF7aH2cTNppCddKJ6DA@mail.gmail.com>
 <50213342.8020600@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5D01A518E4@039-SN1MPN1-002.039d.mgd.msft.net>
 <50228CA5.801@freescale.com>
 <3F366E73-1EED-4DFE-85B3-F37BCCFFFFB5@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5D01A52814@039-SN1MPN1-002.039d.mgd.msft.net>
 <50253004.3010808@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5D01A54908@039-SN1MPN1-002.039d.mgd.msft.net>
In-Reply-To: <412C8208B4A0464FA894C5F0C278CD5D01A54908@039-SN1MPN1-002.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Gala Kumar-B11780 <B11780@freescale.com>,
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

On 08/15/2012 04:22 AM, Jia Hongtao-B38951 wrote:
> 
> 
>> -----Original Message-----
>> From: Wood Scott-B07421
>> Sent: Saturday, August 11, 2012 12:00 AM
>> To: Jia Hongtao-B38951
>> Cc: Gala Kumar-B11780; Wood Scott-B07421; Li Yang-R58472; linuxppc-
>> dev@lists.ozlabs.org
>> Subject: Re: [PATCH V5 3/3] powerpc/fsl-pci: Unify pci/pcie
>> initialization code
>>
>> On 08/10/2012 03:47 AM, Jia Hongtao-B38951 wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Gala Kumar-B11780
>>>> Sent: Thursday, August 09, 2012 3:04 AM
>>>> To: Wood Scott-B07421
>>>> Cc: Jia Hongtao-B38951; Wood Scott-B07421; Li Yang-R58472; linuxppc-
>>>> dev@lists.ozlabs.org
>>>> Subject: Re: [PATCH V5 3/3] powerpc/fsl-pci: Unify pci/pcie
>>>> initialization code
>>>>
>>>>>>>>>>> As I explained before, this has to be done globally, not from
>>>>>>>>>>> the probe function, so we can assign a default primary bus if
>>>>>>>>>>> there
>>>>>>> isn't any ISA.
>>>>>>>>>>> There are bugs in the Linux PPC PCI code relating to not
>>>>>>>>>>> having any primary bus.
>>>>>>>>>>>
>>>>>>>>>>> -Scott
>>>>>>>>>>
>>>>>>>>>> In my way of searching ISA you can also assign a default
>>>>>>>>>> primary bus in board specific files.
>>>>>>>>>
>>>>>>>>> That was meant for when the board file had an alternate way of
>>>>>>>>> searching for the primary bus (e.g. look for i8259), not as a
>>>>>>>>> replacement for the mechanism that guarantees there's a primary
>> bus.
>>>>>>>>>
>>>>>>>>> You are causing a regression in the qemu_e500.c platform.
>>>>>>>>
>>>>>>>> Can we fix the qemu device tree to address the problem if we do
>>>>>>>> make it a rule to use the ISA node to indicate the primary bus?
>>>>>>>
>>>>>>> No.  There is no ISA, and we're not going to lie and say there is.
>>>>>>
>>>>>> But we can assign a default primary for qemu.
>>>>>
>>>>> Not in the device tree.  What other mechanism do you propose?  And
>>>>> why do you want to fix it only for QEMU and not other boards, where
>>>>> things happen to work but not as designed?
>>>>>
>>>>> Kumar, can you speak up here as maintainer so we can stop going back
>>>>> and forth endlessly?
>>>>
>>>> I'd rather we stick with the code that works for this purpose at this
>>>> point.  That would be Scott's current upstream code.  Lets get the
>>>> other aspects of this patchset closed (SWIOTLB, conversion to
>>>> platform driver, PM, etc.).  The primary bus code Scott wrote does
>>>> NOT need to change at this point.
>>>>
>>>> - k
>>>
>>>
>>> I just submitted a new version of PCI patch in which I improve the
>> primary part.
>>> The reasons I want to change the way of primary assignment listed below:
>>>
>>> 1. This approach is functionally equivalent to the Scott's code. In my
>>> approach there might be no primary assigned but it fixed by "quick fix"
>> introduced by Ben.
>>> Please refer to this link:
>>> https://lists.ozlabs.org/pipermail/linuxppc-dev/2012-June/098586.html
>>
>> You might want to get Ben's input as to whether he actually wants to see
>> that "quick fix" applied.
>>
>>> 2. Scott's and my way could not handle the situation that "the primary
>>> is not the first PCI bus detected". I found that only ge_imp3a got
>>> this problem so I fixed it by adding ISA node to its device tree. By
>>> adding this I think the solution is logically completed.
>>
>> How did my approach not handle this case?  As I said, ge_imp3a platform
>> code needs to set fsl_pci_primary manually before PCI init runs.
>>
>> Adding a node to the device tree is not the answer, since that will break
>> compatibility with old device trees.
>>
> 
> I assume that kernel image and dtb image are from the same tree.

That's a bad assumption.  Device trees get forked off for custom boards,
modified by firmware, generated by firmware, etc.

-Scott
