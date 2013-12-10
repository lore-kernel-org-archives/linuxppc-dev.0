Return-Path: <hongbo.zhang@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 403C02C0086
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Dec 2013 21:33:42 +1100 (EST)
Message-ID: <52A6EDE8.5060903@freescale.com>
Date: Tue, 10 Dec 2013 18:33:12 +0800
From: Hongbo Zhang <hongbo.zhang@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] DTS: DMA: Fix DMA3 interrupts
References: <1385712446-28221-1-git-send-email-hongbo.zhang@freescale.com>
 <1386357684.7375.124.camel@snotra.buserror.net>
In-Reply-To: <1386357684.7375.124.camel@snotra.buserror.net>
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

Scott,
This issue is due to the non-continuous MPIC register, I think there is 
two ways to fix it.

The first one is as what we are discussing, in fact the Bman/Qman DT 
author had introduced this way, and I had to follow it, it is a trick, 
adding 208 is a bit ugly I think, and even difficult to explain it to 
customers etc, but this way changes less codes.

The second one is editing MPIC related codes without adding 208 to high 
interrupts. The point of translate interrupt number to MPIC register 
address is a so called 'isu' mechanism, we can do like the following 
example codes, then the tricky adding 208 isn't needed any more.

Which one do you prefer?
In fact I myself prefer the second, if the idea is acceptable, I will 
send a patch instead of this one. (and also alone with the internal 
patch decreasing 208 for the Bman/Qman)

void __init corenet_ds_pic_init(void)
{
     ......

     mpic = mpic_alloc(NULL, 0, flags, 0, 512, "OpenPIC");
     BUG_ON(mpic == NULL);

// Add this start
     for (i = 0; i < 17; i++) {
         if (i < 11)
             addr_off = 0x10000 + 0x20 * 16 * i;
         else
             addr_off = 0x13000 + 0x20 * 16 * (i - 11);  /* scape the 
address not for interrupts */
         mpic_assign_isu(mpic, i, mpic->paddr + addr_off);
     }
// Add this end

     mpic_init(mpic);
}

On 12/07/2013 03:21 AM, Scott Wood wrote:
> On Fri, 2013-11-29 at 16:07 +0800, hongbo.zhang@freescale.com wrote:
>> From: Hongbo Zhang <hongbo.zhang@freescale.com>
>>
>> MPIC registers for internal interrupts is non-continous in address, any
>> internal interrupt number greater than 159 should be added (16+208) to work.
>> 16 is due to external interrupts as usual, 208 is due to the non-continous MPIC
>> register space.
>> Tested on T4240 rev2 with SRIO2 disabled.
>>
>> Signed-off-by: Hongbo Zhang <hongbo.zhang@freescale.com>
>> ---
>>   arch/powerpc/boot/dts/fsl/elo3-dma-2.dtsi |   16 ++++++++--------
>>   1 file changed, 8 insertions(+), 8 deletions(-)
> The FSL MPIC binding should be updated to point out how this works.
>
> Technically it's not a change to the binding itself, since it's defined
> in terms of register offset, but the explanatory text says "So interrupt
> 0 is at offset 0x0, interrupt 1 is at offset 0x20, and so on." which is
> not accurate for these new high interrupt numbers.
>
> -Scott
>
>
>
