Return-Path: <B10716@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 58A581007D3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jan 2012 00:18:29 +1100 (EST)
Message-ID: <4F181815.7000704@freescale.com>
Date: Thu, 19 Jan 2012 15:18:13 +0200
From: Tudor Laurentiu <Laurentiu.Tudor@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/booke64: Configurable lazy interrupt disabling
References: <1326897306-3924-1-git-send-email-Laurentiu.Tudor@freescale.com>
 <1326921026.26116.34.camel@pasglop>
In-Reply-To: <1326921026.26116.34.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

On 01/18/2012 11:10 PM, Benjamin Herrenschmidt wrote:
> On Wed, 2012-01-18 at 16:35 +0200, Laurentiu Tudor wrote:
>> This patch adds a menuconfig option that allows controlling
>> the lazy interrupt disabling feature implemented by this
>> commit:
>>
>> commit d04c56f73c30a5e593202ecfcf25ed43d42363a2
>> Author: Paul Mackerras
>> Date:   Wed Oct 4 16:47:49 2006 +1000
>>
>>      [POWERPC] Lazy interrupt disabling for 64-bit machines
>>
>> The code in 'powerpc/include/asm/hw_irq.h' was rearranged and
>> cleaned-up a bit in order to reduce the number of needed #ifdef's.
>
> It's still nasty.

Yep, there is still room for improvement. Perhaps trimming some of those 
various interrupt enable/disable functions & macros. However I don't 
think I have enough experience to do this ... so, any suggestions are 
welcomed.

> Do you have numbers showing that it's worth disabling
> on BookE ?

On fsl's p5020 there should be some performance gains because disabling 
"lazy ee" allows enabling the "external proxy" feature.
The thing is I can't prove this because I have no idea what benchmark to 
run. Let me know if you guys know of any relevant benchmark I could try.

---
Best Regards, Laurentiu
