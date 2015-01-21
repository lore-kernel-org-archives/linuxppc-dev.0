Return-Path: <B43198@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0119.outbound.protection.outlook.com [157.56.110.119])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 52CE41A0D97
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 20:49:50 +1100 (AEDT)
Message-ID: <54BF72D1.3000302@freescale.com>
Date: Wed, 21 Jan 2015 11:35:13 +0200
From: Purcareata Bogdan <b43198@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc/mpic: Add DT option to skip readback after EOI
References: <1421236622-29366-1-git-send-email-bogdan.purcareata@freescale.com>
 <1421258312.4961.133.camel@freescale.com>
In-Reply-To: <1421258312.4961.133.camel@freescale.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 14.01.2015 19:58, Scott Wood wrote:
> On Wed, 2015-01-14 at 11:57 +0000, Bogdan Purcareata wrote:
>> The readback is necessary in order to handle PCI posted
>> writes,
>
> That is unclear.

I'm going to try an venture a different explanation here.

I found a good explanation in Writing PCI Drivers [1] as to why it's 
necessary that a read is performed before returning from an EOI write:

"A good example of such a case is when a driver’s Interrupt Service 
Routine (ISR) is dealing with the Interrupt Request Register (IRR) on a 
card. Clearing a bit in the register indicates that the interrupt has 
been serviced. This is done by posting a write to the register. If the 
driver posts this write and exits its ISR, it could get interrupted 
again immediately because the write hadn’t yet reached the bit in the 
IRR to tell it to stop trying to interrupt. One solution to this 
potential problem is to make sure to read back the value in the IRR 
before exiting from the ISR. Most drivers do this anyway so they can 
handle multiple interrupts in the same ISR visit."

This is designed to work for legacy line interrupts. I understand MSI 
has its way to order writes on the bus, and also it won't send another 
MSI, signaling a new interrupt, unless there's a state change in the IRR 
on the card. When using line interrupts, the line stays asserted as long 
as IRR is set, so the MPIC could trigger an additional interrupt if the 
EOI write is posted and the ISR bit is cleared.

>
>>   or when the MPIC is handling interrupts in a loop
>> (ppc_md.get_irq).
>
> I'm questioning this one as well -- if reading WHOAMI is sufficient to
> sync with the EOI, why wouldn't reading INTACK work as well?

I think I'm going to drop this part of the description. However, I don't 
think reading INTACK is good, since it has some additional side effects 
- interrupt pending register is cleared for edge-sensitive interrupts, 
the in-service register is updated, and the int output signal from the 
MPIC is negated. This is available for Freescale SoCs. This also 
signifies entering the processing cycle of a new interrupt.

Normally, the readback should be done on the EOI register - this is 
stated in the OpenPIC specification and actually was the initial 
implementation of the driver. However, this can't be done since, at 
least for Freescale SoCs, the EOI register is write only.

However, in the light of the above explanation related to PCI posted 
writes, I don't see how performing a readback on the WHOAMI register, 
which is specific to the MPIC, would have any effect in synchronizing 
with the PCI device registers. I guess it's related to the bus 
interconnect on the SoC.

>>   Newer MPIC versions don't require this readback. Leave the option
>> configurable using a device tree entry.
>>
>> This saves a MMIO trap per interrupt.
>>
>> Signed-off-by: Scott Wood <scottwood@freescale.com>
>> Signed-off-by: Bogdan Purcareata <bogdan.purcareata@freescale.com>
>
> You should note changes (e.g. with a [] note between signoffs) if it
> differs from the original...

Will do, sorry for omitting this.

>
> -Scott

[1] http://h21007.www2.hp.com/portal/download/files/unprot/ddk/ddg/chap8.pdf

Best regards,
Bogdan P.
