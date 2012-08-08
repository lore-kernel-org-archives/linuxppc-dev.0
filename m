Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe001.messaging.microsoft.com [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 485AE2C007F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2012 01:58:41 +1000 (EST)
Received: from mail15-am1 (localhost [127.0.0.1])	by mail15-am1-R.bigfish.com
 (Postfix) with ESMTP id 897864800F6	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Aug 2012 15:58:34 +0000 (UTC)
Received: from AM1EHSMHS016.bigfish.com (unknown [10.3.201.244])	by
 mail15-am1.bigfish.com (Postfix) with ESMTP id C189B2C0044	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2012 15:58:32 +0000 (UTC)
Message-ID: <50228CA5.801@freescale.com>
Date: Wed, 8 Aug 2012 10:58:29 -0500
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
In-Reply-To: <412C8208B4A0464FA894C5F0C278CD5D01A518E4@039-SN1MPN1-002.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Kumar Gala <Kumar.Gala@freescale.com>,
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

On 08/08/2012 04:03 AM, Jia Hongtao-B38951 wrote:
> 
> 
>> -----Original Message-----
>> From: Wood Scott-B07421
>> Sent: Tuesday, August 07, 2012 11:25 PM
>> To: Li Yang-R58472
>> Cc: Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org; Li Yang-R58472; Jia
>> Hongtao-B38951
>> Subject: Re: [PATCH V5 3/3] powerpc/fsl-pci: Unify pci/pcie
>> initialization code
>>
>> On 08/06/2012 11:20 PM, Li Yang wrote:
>>> On Mon, Aug 6, 2012 at 11:09 PM, Scott Wood <scottwood@freescale.com>
>> wrote:
>>>> On 08/05/2012 10:07 PM, Jia Hongtao-B38951 wrote:
>>>>>
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Wood Scott-B07421
>>>>>> Sent: Saturday, August 04, 2012 12:28 AM
>>>>>> To: Jia Hongtao-B38951
>>>>>> Cc: linuxppc-dev@lists.ozlabs.org; galak@kernel.crashing.org; Li
>>>>>> Yang- R58472; Wood Scott-B07421
>>>>>> Subject: Re: [PATCH V5 3/3] powerpc/fsl-pci: Unify pci/pcie
>>>>>> initialization code
>>>>>>
>>>>>> As I explained before, this has to be done globally, not from the
>>>>>> probe function, so we can assign a default primary bus if there
>> isn't any ISA.
>>>>>>  There are bugs in the Linux PPC PCI code relating to not having
>>>>>> any primary bus.
>>>>>>
>>>>>> -Scott
>>>>>
>>>>> In my way of searching ISA you can also assign a default primary bus
>>>>> in board specific files.
>>>>
>>>> That was meant for when the board file had an alternate way of
>>>> searching for the primary bus (e.g. look for i8259), not as a
>>>> replacement for the mechanism that guarantees there's a primary bus.
>>>>
>>>> You are causing a regression in the qemu_e500.c platform.
>>>
>>> Can we fix the qemu device tree to address the problem if we do make
>>> it a rule to use the ISA node to indicate the primary bus?
>>
>> No.  There is no ISA, and we're not going to lie and say there is.
> 
> But we can assign a default primary for qemu.

Not in the device tree.  What other mechanism do you propose?  And why
do you want to fix it only for QEMU and not other boards, where things
happen to work but not as designed?

Kumar, can you speak up here as maintainer so we can stop going back and
forth endlessly?

>> I really don't understand what the problem is with leaving the primary
>> detection code as global.  Either fix the bugs so we don't need a primary,
>> or accept some "impurity" in the workaround.
>>
>> -Scott
> 
> Global detection for primary is ok but we think our way is deeper unified.

So my way works and "is ok", and your way doesn't work but is
theoretically cleaner.

> Is there any problem to fix the bugs?

If you want to fix them, go ahead.  You don't get to rely on the bugs
beign fixed until after they're actually fixed.

> I really don't understand why we have to need a primary bus.

Did you read Ben's e-mail that I posted a link to?

-Scott
