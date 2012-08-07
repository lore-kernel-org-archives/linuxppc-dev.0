Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8DA6B2C0097
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2012 01:19:44 +1000 (EST)
Message-ID: <50213207.8050000@freescale.com>
Date: Tue, 7 Aug 2012 10:19:35 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jia Hongtao-B38951 <B38951@freescale.com>
Subject: Re: [PATCH V4 3/3] powerpc/fsl-pci: Unify pci/pcie initialization code
References: <1343907741-20589-1-git-send-email-B38951@freescale.com>
 <1343907741-20589-4-git-send-email-B38951@freescale.com>
 <A4B0DB85-7B49-4748-8B94-0E1F1B7B663A@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5D01A35A2F@039-SN1MPN1-002.039d.mgd.msft.net>
 <501BF66C.3070107@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5D01A36CE7@039-SN1MPN1-002.039d.mgd.msft.net>
 <501FDF9B.4030304@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5D01A422A2@039-SN1MPN1-002.039d.mgd.msft.net>
In-Reply-To: <412C8208B4A0464FA894C5F0C278CD5D01A422A2@039-SN1MPN1-002.039d.mgd.msft.net>
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

On 08/07/2012 01:23 AM, Jia Hongtao-B38951 wrote:
>> -----Original Message-----
>> From: Wood Scott-B07421
>> Sent: Monday, August 06, 2012 11:16 PM
>> To: Jia Hongtao-B38951
>> Cc: Wood Scott-B07421; Kumar Gala; linuxppc-dev@lists.ozlabs.org; Li
>> Yang-R58472
>> Subject: Re: [PATCH V4 3/3] powerpc/fsl-pci: Unify pci/pcie
>> initialization code
>>
>> On 08/05/2012 09:39 PM, Jia Hongtao-B38951 wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Wood Scott-B07421
>>>> Sent: Saturday, August 04, 2012 12:04 AM
>>>> To: Jia Hongtao-B38951
>>>> Cc: Kumar Gala; linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421; Li
>>>> Yang-R58472
>>>> Subject: Re: [PATCH V4 3/3] powerpc/fsl-pci: Unify pci/pcie
>>>> initialization code
>>>>
>>>> On 08/02/2012 10:39 PM, Jia Hongtao-B38951 wrote:
>>>>>
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>>>>>> Sent: Thursday, August 02, 2012 8:24 PM
>>>>>> To: Jia Hongtao-B38951
>>>>>> Cc: linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421; Li
>>>>>> Yang-R58472
>>>>>> Subject: Re: [PATCH V4 3/3] powerpc/fsl-pci: Unify pci/pcie
>>>>>> initialization code
>>>>>>
>>>>>> You need to convert all boards to use fsl_pci_init before this patch.
>>>>>> Otherwise we'll end up with PCI getting initialized twice on boards.
>>>>>>
>>>>>> - k
>>>>>
>>>>> If we covert all boards with platform driver in this patch PCI will
>>>>> be initialized only once without converting all boards to use
>>>>> fsl_pci_init first.
>>>>
>>>> Then we'd have to pick apart core changes from board changes when
>>>> reviewing.
>>>>
>>>>> If we convert all boards to use fsl_pci_init before this patch and
>>>>> convert them to use platform driver again after this patch. Then
>>>>> between this patch and next pci will be initialized twice too.
>>>>
>>>> Why?  That one patch should both create the platform driver and
>>>> remove the init from fsl_pci_init() -- except things like primary bus
>>>> detection which has to happen globally.
>>>>
>>>> -Scott
>>>
>>> "One patch both create the platform driver and remove the init from
>>> fsl_pci_init()" means we should create platform driver and applied to
>>> all boards. If so why not just directly convert all boards using
>>> platform driver?
>>
>> Because it's harder to review when you have a bunch of board code in the
>> patch in addition to core changes.
>>
>> Because you might want people to actually test on the boards in question
>> when converting, especially given the change in how primary buses are
>> determined, and that some boards may need to provide their own
>> alternative.
>>
>> -Scott
> 
> But if we separate the core changes and the boards update, between this two
> patches PCI will be initialized twice.

As I said earlier, you can remove the initcall and require boards to
manually call fsl_pci_init() until all boards are converted.

-Scott
