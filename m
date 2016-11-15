Return-Path: <Zubair.Kakakhel@imgtec.com>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by lists.ozlabs.org (Postfix) with ESMTP id 3tJBxs1Z0pzDvgC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 03:03:12 +1100 (AEDT)
Subject: Re: [Patch v7 3/7] irqchip: xilinx: restructure and use jump label api
To: Michal Simek <michal.simek@xilinx.com>, <monstr@monstr.eu>,
 <tglx@linutronix.de>, <jason@lakedaemon.net>, <marc.zyngier@arm.com>
References: <20161114121351.10924-1-Zubair.Kakakhel@imgtec.com>
 <20161114121351.10924-4-Zubair.Kakakhel@imgtec.com>
 <f60948d3-d283-bb53-268b-9638f686ff35@xilinx.com>
CC: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <mpe@ellerman.id.au>
From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Message-ID: <cccf1577-b979-4034-7dda-5d43850c25a7@imgtec.com>
Date: Tue, 15 Nov 2016 16:03:08 +0000
MIME-Version: 1.0
In-Reply-To: <f60948d3-d283-bb53-268b-9638f686ff35@xilinx.com>
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

On 11/15/2016 12:49 PM, Michal Simek wrote:
> On 14.11.2016 13:13, Zubair Lutfullah Kakakhel wrote:
>> Add a global structure to house various variables.
>> And cleanup read/write handling by using jump label api.
>>
>> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
>>

...

>> @@ -138,59 +136,75 @@ static const struct irq_domain_ops xintc_irq_domain_ops = {
>>  static int __init xilinx_intc_of_init(struct device_node *intc,
>>  					     struct device_node *parent)
>>  {
>> -	u32 nr_irq, intr_mask;
>> +	u32 nr_irq;
>>  	int ret;
>> +	struct xintc_irq_chip *irqc;
>>
>> -	intc_baseaddr = of_iomap(intc, 0);
>> -	BUG_ON(!intc_baseaddr);
>> +	if (xintc_irqc) {
>> +		pr_err("irq-xilinx: Multiple instances aren't supported\n");
>> +		return -EINVAL;
>> +	}
>
> I don't agree with this.
> Pretty long time ago we were added support for multiple instances in
> xilinx private tree.
> You can look here.
>
> https://github.com/Xilinx/linux-xlnx/blob/master/drivers/irqchip/irq-xilinx-intc.c
>
> Not sure if this the latest way how to do it but as you can see
> we were setting up
> irq_set_handler_data(irq, intc);
>
> and then when you need that structure we were calling
> struct intc *local_intc = irq_data_get_irq_chip_data(d);
>
> And that should be it to support multiple instance of this driver.
>
> Based on 5/7 you are describing your interrupt subsystem like this.
>
> Peripherals --> xilinx_intcontroller -> mips_cpu_int controller
> If mips_cpu_int has more than one input you can connect more xilinx intc
> controllers.
> If not you still have an option to connect
> xilinx_intcontroller(up to 32 peripherals) -> xilinx_intcontroller(one
> intc + up to 31 peripherals)  -> mips_cpu_int controller

That configuration in FPGA is technically possible. Although not done/needed in the
way we use the Xilinx Interrupt Controller IP block in MIPSfpga.

This series takes the drivers out of arch code and makes it accessible.
Any further development on the driver would be common to all architectures.
Support for multiple instances would be a 'new feature'.

I say this as this series keeps growing and mutating in terms of its scope
and work.

Would it be possible to ack this so that the restructure out of arch code
can move forward?

Regards,
ZubairLK

>
> Thanks,
> Michal
>
