Return-Path: <albert_herranz@yahoo.es>
Received: from smtp140.mail.ukl.yahoo.com (smtp140.mail.ukl.yahoo.com
	[77.238.184.71]) by ozlabs.org (Postfix) with SMTP id D9BF6100809
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 Nov 2009 04:27:57 +1100 (EST)
Message-ID: <4B0D691B.1080108@yahoo.es>
Date: Wed, 25 Nov 2009 18:27:55 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 16/19] powerpc: wii: hollywood interrupt controller
	support
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-8-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-9-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-11-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-12-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-13-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-14-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-15-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-16-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-17-git-se! nd-email-albert_herranz@yahoo.es>
	<97D41F17-CF79-4AA1-B9E6-1F979A11B77E@kernel.crashing.org>
In-Reply-To: <97D41F17-CF79-4AA1-B9E6-1F979A11B77E@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
>> +config HLWD_PIC
> 
> Are vowels too expensive?  :-)
> 

Heh, you work/worked for IBM. Look at what they did with the CLI in the AS/400...

I thought here that hollywood is a rather large prefix and there is also a board called holly. So I came up with hlwd :)

>> +static void hlwd_pic_ack(unsigned int virq)
>> +{
>> +    int irq = virq_to_hw(virq);
>> +    void __iomem *io_base = get_irq_chip_data(virq);
>> +
>> +    set_bit(irq, io_base + HW_BROADWAY_ICR);
>> +}
> 
> Same issue as with Flipper here.
> 

See my comments on the previous message.

>> +    __asm__ __volatile__("cntlzw %0,%1" : "=r"(irq) : "r"(irq_status));
>> +    return irq_linear_revmap(h, 31 - irq);
> 
> And here.
> 

Ditto.

>> +static void __hlwd_quiesce(void __iomem *io_base)
>> +{
>> +    /* mask and ack all IRQs */
>> +    out_be32(io_base + HW_BROADWAY_IMR, 0);
>> +    out_be32(io_base + HW_BROADWAY_ICR, ~0);
>> +}
> 
> I would write 0xffffffff instead, it's clearer and slightly
> more robust.
> 

Ok.

>> +void hlwd_pic_probe(void)
>> +{
>> +    struct irq_host *host;
>> +    struct device_node *np;
>> +    const u32 *interrupts;
>> +    int cascade_virq;
>> +
>> +    for_each_compatible_node(np, NULL, "nintendo,hollywood-pic") {
>> +        interrupts = of_get_property(np, "interrupts", NULL);
>> +        if (interrupts) {
>> +            host = hlwd_pic_init(np);
>> +            BUG_ON(!host);
>> +            cascade_virq = irq_of_parse_and_map(np, 0);
>> +            set_irq_data(cascade_virq, host);
>> +            set_irq_chained_handler(cascade_virq,
>> +                        hlwd_pic_irq_cascade);
> 
> break;  here?  You do not handle more than one hollywood-pic elsewhere
> (which of course is fine).

Yup, thanks. I'll stop after the first pic.

Cheers,
Albert
