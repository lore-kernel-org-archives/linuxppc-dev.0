Return-Path: <hongbo.zhang@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8798E2C009F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Dec 2013 20:46:36 +1100 (EST)
Message-ID: <52A985E6.2040403@freescale.com>
Date: Thu, 12 Dec 2013 17:46:14 +0800
From: Hongbo Zhang <hongbo.zhang@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] DTS: DMA: Fix DMA3 interrupts
References: <1385712446-28221-1-git-send-email-hongbo.zhang@freescale.com>	
 <1386357684.7375.124.camel@snotra.buserror.net>	
 <52A6EDE8.5060903@freescale.com>
 <1386700403.10013.109.camel@snotra.buserror.net>
In-Reply-To: <1386700403.10013.109.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 12/11/2013 02:33 AM, Scott Wood wrote:
> On Tue, 2013-12-10 at 18:33 +0800, Hongbo Zhang wrote:
>> Scott,
>> This issue is due to the non-continuous MPIC register, I think there is
>> two ways to fix it.
>>
>> The first one is as what we are discussing, in fact the Bman/Qman DT
>> author had introduced this way, and I had to follow it, it is a trick,
>> adding 208 is a bit ugly I think, and even difficult to explain it to
>> customers etc, but this way changes less codes.
>>
>> The second one is editing MPIC related codes without adding 208 to high
>> interrupts. The point of translate interrupt number to MPIC register
>> address is a so called 'isu' mechanism, we can do like the following
>> example codes, then the tricky adding 208 isn't needed any more.
>>
>> Which one do you prefer?
>> In fact I myself prefer the second, if the idea is acceptable, I will
>> send a patch instead of this one. (and also alone with the internal
>> patch decreasing 208 for the Bman/Qman)
>>
>> void __init corenet_ds_pic_init(void)
>> {
>>       ......
>>
>>       mpic = mpic_alloc(NULL, 0, flags, 0, 512, "OpenPIC");
>>       BUG_ON(mpic == NULL);
>>
>> // Add this start
>>       for (i = 0; i < 17; i++) {
>>           if (i < 11)
>>               addr_off = 0x10000 + 0x20 * 16 * i;
>>           else
>>               addr_off = 0x13000 + 0x20 * 16 * (i - 11);  /* scape the
>> address not for interrupts */
>>           mpic_assign_isu(mpic, i, mpic->paddr + addr_off);
>>       }
>> // Add this end
>>
>>       mpic_init(mpic);
>> }
> NACK
>
> We already have a binding that states that the interrupt number is based
> on the register offset, rather than whatever arbitrary numbers hardware
> documenters decide to use next week.
>
> While I'm not terribly happy with the usability of this, especially now
> that it's not a simple "add 16", redefining the existing binding is not
> OK (and in any case the code above seems obfuscatory).  If we decide to
> do something other than continue with register offset divided by 32,
> then we need to define a new interrupt type (similar to current defined
> types of error interrupt, timer, and IPI) for the new numberspace -- and
> it should be handled when decoding that type of interrupt specifier,
> rather than with the isu mechanism.
>
> -Scott
>
>
Scott,
Thanks for your comments. Since the second way isn't so good, let's 
choose the original one.
But we meet a small accident now.
My patch is based on the http://patchwork.ozlabs.org/patch/291553/, 
which had been superseded, so this thread can be closed now.

And Shenzhou has already sent a complete dma3 dtsi patch including 
correct interrupt numbers, http://patchwork.ozlabs.org/patch/300026/, so 
let's focus on this patch, and I will forward your first comments of my 
patch there.

Thanks.
