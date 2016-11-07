Return-Path: <Zubair.Kakakhel@imgtec.com>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by lists.ozlabs.org (Postfix) with ESMTP id 3tC76w0GTQzDt3Z
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Nov 2016 20:53:27 +1100 (AEDT)
Subject: Re: [Patch V6 2/6] irqchip: xilinx: Clean up irqdomain argument and
 read/write
To: Thomas Gleixner <tglx@linutronix.de>
References: <1477916207-25157-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1477916207-25157-3-git-send-email-Zubair.Kakakhel@imgtec.com>
 <alpine.DEB.2.20.1610311335380.5011@nanos>
 <fea1e962-1af2-d666-2b0d-55a8e230430c@imgtec.com>
CC: <monstr@monstr.eu>, <jason@lakedaemon.net>, <marc.zyngier@arm.com>,
 <linux-kernel@vger.kernel.org>, <michal.simek@xilinx.com>,
 <linuxppc-dev@lists.ozlabs.org>, <mpe@ellerman.id.au>
From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Message-ID: <a94525f9-1bd1-5d61-59d9-d1643d9cb772@imgtec.com>
Date: Mon, 7 Nov 2016 09:53:23 +0000
MIME-Version: 1.0
In-Reply-To: <fea1e962-1af2-d666-2b0d-55a8e230430c@imgtec.com>
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

On 11/01/2016 11:05 AM, Zubair Lutfullah Kakakhel wrote:
> Hi,
>
> Thanks for the review.
>
> On 10/31/2016 07:51 PM, Thomas Gleixner wrote:
>> On Mon, 31 Oct 2016, Zubair Lutfullah Kakakhel wrote:
>>> The drivers read/write function handling is a bit quirky.
>>
>> Can you please explain in more detail what's quirky and why it should be
>> done differently,
>>
>>> And the irqmask is passed directly to the handler.
>>
>> I can't make any sense out of that sentence.  Which handler? If you talk
>> about the write function, then I don't see a change. So what are you
>> talking about?
>
> Thanks. I'll add more detail in v7 if this patch survives.
>
>>
>>> Add a new irqchip struct to pass to the handler and
>>> cleanup read/write handling.
>>
>> I still don't see what it cleans up. You move the write function pointer
>> into a data structure, which is exposed by another pointer. So you create
>> two levels of indirection in the hotpath. The function prototype is still
>> the same. So all this does is making things slower unless I'm missing
>> something.
>
> I wrote this patch/cleanup based on a review of driver by Marc when I moved the
> driver from arch/microblaze to drivers/irqchip
>
> "Marc Zyngier
>
> ...
>
>>  arch/microblaze/kernel/intc.c   | 196 ----------------------------------------
>>  drivers/irqchip/irq-axi-intc.c  | 196 ++++++++++++++++++++++++++++++++++++++++
>
> ...
>
>> +    /* Yeah, okay, casting the intr_mask to a void* is butt-ugly, but I'm
>> +     * lazy and Michal can clean it up to something nicer when he tests
>> +     * and commits this patch.  ~~gcl */
>> +    root_domain = irq_domain_add_linear(intc, nr_irq, &xintc_irq_domain_ops,
>> +                            (void *)intr_mask);
>
> Since you're now reworking this driver, how about addressing this
> ugliness? You could store the intr_mask together with intc_baseaddr,
> and the read/write functions in a global structure, and pass a
> pointer to it? That would make the code a bit nicer...
> "
>
> https://patchwork.kernel.org/patch/9287933/
>
>>
>>> -static unsigned int (*read_fn)(void __iomem *);
>>> -static void (*write_fn)(u32, void __iomem *);
>>> +struct xintc_irq_chip {
>>> +    void __iomem *base;
>>> +    struct    irq_domain *domain;
>>> +    struct    irq_chip chip;
>>
>> The tabs between struct and the structure name are bogus.
>>
>>> +    u32    intr_mask;
>>> +    unsigned int (*read)(void __iomem *iomem);
>>> +    void (*write)(u32 data, void __iomem *iomem);
>>
>> Please structure that like a table:
>>
>>     void            __iomem *base;
>>     struct irq_domain    *domain;
>>     struct irq_chip        chip;
>>     u32            intr_mask;
>>     unsigned int        (*read)(void __iomem *iomem);
>>     void            (*write)(u32 data, void __iomem *iomem);
>>
>> Can you see how that makes parsing the struct simpler, because the data
>> types are clearly to identify?
>
> That does make it look much better.
>
>>
>>> +static struct xintc_irq_chip *xintc_irqc;
>>>
>>>  static void intc_write32(u32 val, void __iomem *addr)
>>>  {
>>> @@ -54,6 +60,18 @@ static unsigned int intc_read32_be(void __iomem *addr)
>>>      return ioread32be(addr);
>>>  }
>>>
>>> +static inline unsigned int xintc_read(struct xintc_irq_chip *xintc_irqc,
>>> +                         int reg)
>>> +{
>>> +    return xintc_irqc->read(xintc_irqc->base + reg);
>>> +}
>>> +
>>> +static inline void xintc_write(struct xintc_irq_chip *xintc_irqc,
>>> +                     int reg, u32 data)
>>> +{
>>> +    xintc_irqc->write(data, xintc_irqc->base + reg);
>>> +}
>>> +
>>>  static void intc_enable_or_unmask(struct irq_data *d)
>>>  {
>>>      unsigned long mask = 1 << d->hwirq;
>>> @@ -65,21 +83,21 @@ static void intc_enable_or_unmask(struct irq_data *d)
>>>       * acks the irq before calling the interrupt handler
>>>       */
>>>      if (irqd_is_level_type(d))
>>> -        write_fn(mask, intc_baseaddr + IAR);
>>> +        xintc_write(xintc_irqc, IAR, mask);
>>
>> So this whole thing makes only sense, when you want to support multiple
>> instances of that chip and then you need to store the xintc_irqc pointer as
>> irqchip data and retrieve it from there. Unless you do that, this "cleanup"
>> is just churn for nothing with the effect of making things less efficient.
>>
>
> Indeed the driver doesn't support multiple instances of the Xilinx Interrupt controller.
> I don't have a use-case or the hardware for that.
>
> So what would be the recommended course of action?

I'd really appreciate a consensus here.
I'm hoping that these patches can go in v4.10.

Thanks
ZubairLK

>
> Regards,
> ZubairLK
>
>> Thanks,
>>
>>     tglx
>>
