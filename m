Return-Path: <Zubair.Kakakhel@imgtec.com>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by lists.ozlabs.org (Postfix) with ESMTP id 3tMrl22f7qzDvj6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 01:36:30 +1100 (AEDT)
Subject: Re: [Patch v7 6/7] irqchip: xilinx: Try to fall back if
 xlnx,kind-of-intr not provided
To: Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner <tglx@linutronix.de>
References: <20161114121351.10924-1-Zubair.Kakakhel@imgtec.com>
 <20161114121351.10924-7-Zubair.Kakakhel@imgtec.com>
 <alpine.DEB.2.20.1611181426430.3615@nanos>
 <7f07be12-fb2e-e8ad-e0e6-52c58542470a@imgtec.com>
 <dc6b4246-80fa-af8a-49ad-cddb66be1a65@arm.com>
CC: <monstr@monstr.eu>, <jason@lakedaemon.net>,
 <linux-kernel@vger.kernel.org>, <michal.simek@xilinx.com>,
 <linuxppc-dev@lists.ozlabs.org>, <mpe@ellerman.id.au>
From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Message-ID: <5eb4a971-4b23-ccd5-0f25-c60c88a1b7a1@imgtec.com>
Date: Mon, 21 Nov 2016 14:36:26 +0000
MIME-Version: 1.0
In-Reply-To: <dc6b4246-80fa-af8a-49ad-cddb66be1a65@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On 11/21/2016 02:17 PM, Marc Zyngier wrote:
> On 21/11/16 14:05, Zubair Lutfullah Kakakhel wrote:
>> Hi,
>>
>> On 11/18/2016 01:29 PM, Thomas Gleixner wrote:
>>> On Mon, 14 Nov 2016, Zubair Lutfullah Kakakhel wrote:
>>>
>>>> The powerpc dts file does not have the xlnx,kind-of-intr property.
>>>> Instead of erroring out, give a warning instead. And attempt to
>>>> continue to probe the interrupt controller while assuming
>>>> kind-of-intr is 0x0 as a fall back.
>>>
>>> This is broken, really. On multiplatform kernels this will try to probe the
>>> chip no matter what.
>>
>> I'm not sure I understand why this driver will probe on multi-platform kernels
>> if the compatible string isn't in the DT?
>>
>>>
>>> Powerpc already has:
>>>
>>> static const struct of_device_id xilinx_intc_match[] __initconst = {
>>>        { .compatible = "xlnx,opb-intc-1.00.c", },
>>>        { .compatible = "xlnx,xps-intc-1.00.a", },
>>>        {}
>>> };
>>>
>>> Unless I'm missing something important, then adding those compatible
>>> strings to the driver will just keep stuff working as expected instead of
>>> adding unsafe and broken heuristics.
>>>
>>
>> The last two lines of the driver already specify the compatible strings.
>>
>> "
>> IRQCHIP_DECLARE(xilinx_intc_xps, "xlnx,xps-intc-1.00.a", xilinx_intc_of_init);
>> IRQCHIP_DECLARE(xilinx_intc_opb, "xlnx,opb-intc-1.00.c", xilinx_intc_of_init);
>> "
>
> Is PPC actually using this infrastructure? It predates the whole
> IRQCHIP_DECLARE business by about a decade. You seem to have tested it
> using QEMU, so I assume it "just works", but I'd feel more reassured it
> you stated so...

I didn't realize that it could have been an issue.
I simply included <linux/irqchip.h> and called irqchip_init() in the platform code
instead of the previous initialization. Patch 7/7 in this series does that.

And yes I tested it on QEMU. And it does look like it 'just works'.
Without this patch, the UART driver would revert to polling and there would be various
error messages about no irq domain found. With this patch, the 'no irq domain found'
messages disappeared and the uart driver did get an irq.

Regards,
ZubairLK

>
> Thanks,
>
> 	M.
>
