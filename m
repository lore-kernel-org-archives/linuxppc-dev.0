Return-Path: <B31939@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7C5342C00AF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 12:34:31 +1000 (EST)
Received: from mail121-va3 (localhost [127.0.0.1])	by
 mail121-va3-R.bigfish.com (Postfix) with ESMTP id CB085140162	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 02:34:26 +0000 (UTC)
Received: from VA3EHSMHS021.bigfish.com (unknown [10.7.14.249])	by
 mail121-va3.bigfish.com (Postfix) with ESMTP id A91F11000B4	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 02:34:24 +0000 (UTC)
Message-ID: <51BFC749.3080502@freescale.com>
Date: Tue, 18 Jun 2013 10:34:49 +0800
From: Lian Minghuan-b31939 <B31939@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/5] powerpc/fsl_msi: add MSIIR1 support for MPIC v4.3
References: <1371194159-17332-1-git-send-email-Minghuan.Lian@freescale.com>
 <1371194159-17332-2-git-send-email-Minghuan.Lian@freescale.com>
 <1371247751.2996.16@snotra> <51BE7BB1.1070309@freescale.com>
 <1371514512.9073.11@snotra>
In-Reply-To: <1371514512.9073.11@snotra>
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

Hi Soctt,

please see my comments inline.

On 06/18/2013 08:15 AM, Scott Wood wrote:
> On 06/16/2013 10:00:01 PM, Lian Minghuan-b31939 wrote:
>> Hi Scott,
>>
>> please see my comments inline.
>>
>> On 06/15/2013 06:09 AM, Scott Wood wrote:
>>> On 06/14/2013 02:15:56 AM, Minghuan Lian wrote:
>>>> diff --git a/arch/powerpc/sysdev/fsl_msi.h 
>>>> b/arch/powerpc/sysdev/fsl_msi.h
>>>> index 8225f86..43a9d99 100644
>>>> --- a/arch/powerpc/sysdev/fsl_msi.h
>>>> +++ b/arch/powerpc/sysdev/fsl_msi.h
>>>> @@ -16,7 +16,7 @@
>>>>  #include <linux/of.h>
>>>>  #include <asm/msi_bitmap.h>
>>>>
>>>> -#define NR_MSI_REG        8
>>>> +#define NR_MSI_REG        16
>>>>  #define IRQS_PER_MSI_REG    32
>>>>  #define NR_MSI_IRQS    (NR_MSI_REG * IRQS_PER_MSI_REG)
>>>
>>> I don't see where you update all_avail in fsl_of_msi_probe.
>>>
>>> We should also be bounds-checking the contents of msi-available-ranges.
>>> Currently it looks like we just silently overrun the bitmap if we 
>>> get bad
>>> input from the device tree.
>>>
>> [Minghuan] all_avail definition: static const u32 all_avail[] = { 0, 
>> NR_MSI_IRQS };
>> When changing NR_MSI_REG to 16, NR_MSI_IRQS has been changed to 
>> 16*32, and all_avail also is updated.
>
> That's my point.  It shouldn't change for older hardware.
[Minghaun] the older hardware has 8 registers, mipcv4.3 has 16 
registers. If we do not use 16*32 bitmap to indicate 8*32 irqs.(this way 
just only wastes some memory and has no other harm)
we have two choice I think.
1. Use a variable assigned value 8 or 16 based on compatible, then 
dynamically create bitmap
2. Add a new file for mpic v4.3.
What do you think?
>
>> Before calling fsl_msi_setup_hwirq(), the code has checked 
>> 'msi-available-ranges',  only the interrupts lied in 
>> 'msi-available-ranges' will be initialized by call 
>> fsl_msi_setup_hwirq() , and the corresponding bitmap will be freed. I 
>> moved msi_bitmap_free_hwirqs() to fsl_msi_setup_hwirq(), because the 
>> code would generate different bitmap when using MSIIR or MSIIR1.
>
> And what happens if msi-available-ranges is bad, and refers to 
> non-existent MSIs past the end of the bitmap?
[Minghuan] If msi-available-ranges is bad,  the below code will get error.
virt_msir = irq_of_parse_and_map(dev->dev.of_node, irq_index);
And the related error will be printed out and fsl_msi_setup_hwirq() will 
return error directly. There is no chance to set non-existent MSIs past 
the end of the bitmap.

>
> -Scott
