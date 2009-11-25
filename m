Return-Path: <albert_herranz@yahoo.es>
Received: from smtp130.mail.ukl.yahoo.com (smtp130.mail.ukl.yahoo.com
	[77.238.184.61]) by ozlabs.org (Postfix) with SMTP id 301DB1007E4
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 Nov 2009 04:13:46 +1100 (EST)
Message-ID: <4B0D65C5.8090304@yahoo.es>
Date: Wed, 25 Nov 2009 18:13:41 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 11/19] powerpc: gamecube/wii: flipper interrupt
	controller support
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-8-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-9-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-11-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-12-git-send-email-albert_herranz@yahoo.es>
	<8E6E11A2-25F1-4AB8-B42E-58C269018CD2@kernel.crashing.org>
In-Reply-To: <8E6E11A2-25F1-4AB8-B42E-58C269018CD2@kernel.crashing.org>
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
>>  config GAMECUBE_COMMON
>>      bool
>>      select NOT_COHERENT_CACHE
>> +    select FLIPPER_PIC
> 
> Maybe using FLIPPER (or GAMECUBE_FLIPPER) instead of GAMECUBE_COMMON
> is a good name?
> 

I'd prefer to not use a name that implies a specific hardware to describe two (mostly) similar but different hardwares.

>> +#define pr_fmt(fmt) DRV_MODULE_NAME ": " fmt
> 
> Unused
> 

Nope. It is used via the pr_{err,info,...} macros.

>> +/*
>> + * Each interrupt has a corresponding bit in both
>> + * the Interrupt Cause (ICR) and Interrupt Mask (IMR) registers.
>> + *
>> + * Enabling/disabling an interrupt line involves asserting/clearing
>> + * the corresponding bit in IMR. ACK'ing a request simply involves
>> + * asserting the corresponding bit in ICR.
>> + */
> 
>> +static void flipper_pic_ack(unsigned int virq)
>> +{
>> +    int irq = virq_to_hw(virq);
>> +    void __iomem *io_base = get_irq_chip_data(virq);
>> +
>> +    set_bit(irq, io_base + FLIPPER_ICR);
>> +}
> 
> So it should be a simple write instead of an RMW here, right?
> As it is you are ACKing _all_ IRQs as far as I can see.
> 

No, it acks just a single IRQ.
But the simple write idea may work. I need to check if writing 0s causes no harm (which IIRC is true).

>> +unsigned int flipper_pic_get_irq(void)
>> +{
>> +    void __iomem *io_base = flipper_irq_host->host_data;
>> +    int irq;
>> +    u32 irq_status;
>> +
>> +    irq_status = in_be32(io_base + FLIPPER_ICR) &
>> +             in_be32(io_base + FLIPPER_IMR);
>> +    if (irq_status == 0)
>> +        return -1;    /* no more IRQs pending */
>> +
>> +    __asm__ __volatile__("cntlzw %0,%1" : "=r"(irq) : "r"(irq_status));
>> +    return irq_linear_revmap(flipper_irq_host, 31 - irq);
>> +}
> 
> There are generic macros for this kind of thing, no need for asm.  ffs()
> or something.
> 

__ffs() matches exactly that. Thanks.

Cheers,
Albert
