Return-Path: <B31939@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe001.messaging.microsoft.com [216.32.180.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 322BE2C0356
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 13:10:41 +1000 (EST)
Received: from mail183-va3 (localhost [127.0.0.1])	by
 mail183-va3-R.bigfish.com (Postfix) with ESMTP id 3E1CDE01FD	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 03:10:37 +0000 (UTC)
Received: from VA3EHSMHS031.bigfish.com (unknown [10.7.14.251])	by
 mail183-va3.bigfish.com (Postfix) with ESMTP id D913A1000A2	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 03:09:49 +0000 (UTC)
Message-ID: <51BFCF99.1010608@freescale.com>
Date: Tue, 18 Jun 2013 11:10:17 +0800
From: Lian Minghuan-b31939 <B31939@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 5/5] powerpc/fsl_msi: add 'msiregs' kernel parameter
References: <1371514692.9073.12@snotra>
In-Reply-To: <1371514692.9073.12@snotra>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: Minghuan Lian <Minghuan.Lian@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Zang Roy-R61911 <r61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Scott,

please see my comments inline.

On 06/18/2013 08:18 AM, Scott Wood wrote:
> On 06/17/2013 12:36:50 AM, Lian Minghuan-b31939 wrote:
>> Hi Scott,
>>
>> please see my comments inline.
>>
>> On 06/15/2013 06:13 AM, Scott Wood wrote:
>>> On 06/14/2013 02:15:59 AM, Minghuan Lian wrote:
>>>> 1. Only MSIIR1 can index 16 MSI registers, but when using MSIIR1
>>>> the IRQs of a register are not continuous. for example, the first
>>>> register irq values are 0x0, 0x10, 0x20, 0x30 ... 0x1f0. So it
>>>> is hard to use 'msi-available-ranges' property to indicate the
>>>> available ranges and 'msi-available-ranges' property has been
>>>> removed from dts node, so this patch removes the related code.
>>>>
>>>> 2. Add 'msiregs' kernel parameter instead of 'msi-available-ranges'
>>>> functionality.
>>>
>>> The reason we used a device tree property was because this is for 
>>> virtualization and AMP scenarios where this instance of Linux does 
>>> not own all of the MSI registers.
>>>
>>> I don't see any reasonable way to partition an MPIC v4.3 MSI group 
>>> -- but there are more groups, so it's not that bad. What's the use 
>>> case for this patch?
>>>
>> [Minghuan] I do not known any case about this patch. I add 'msiregs' 
>> just for achieving "msi-available-ranges" functionality. I do not 
>> want to remove partition functionality when updating to mpic4.3, 
>> although I do not see virtualization and AMP cases on T4(KVM does not 
>> need this functionality).
>
> Such functionality does not work on mpic v4.3.  There are conflicting 
> requirements of contiguous MSIs (because PCI devices can use them that 
> way) and the inability to partition a single register (because they 
> all go to the same MPIC interrupt).
>
> Keep msi-available-ranges as is for older hardware, and just ignore it 
> (with a warning printed) if it's present on MPIC v4.3.
>
[Minghuan] Thanks for your guidance.
But 'msireg' should be remained or removed?  if remaining 'msiregs', it 
should be for all mpic or only for mpic v4.3?

> -Scott
