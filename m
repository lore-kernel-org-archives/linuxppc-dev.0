Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 83743DDE48
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 May 2007 06:16:15 +1000 (EST)
In-Reply-To: <1178892748.9018.13.camel@saruman.qstreams.net>
References: <46434C1E.3020004@cambridgebroadband.com>
	<1178816847.9018.2.camel@saruman.qstreams.net>
	<46443784.3060600@cambridgebroadband.com>
	<1178892748.9018.13.camel@saruman.qstreams.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C873B42C-ABE7-4265-9EF5-15EBA9525324@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 83xx: requesting external interrupts
Date: Fri, 11 May 2007 15:15:02 -0500
To: bwarren@qstreams.com
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 11, 2007, at 9:12 AM, Ben Warren wrote:

> Alex,
>
> On Fri, 2007-05-11 at 10:29 +0100, Alex Zeffertt wrote:
>> Hi,
>>
>> Thanks for your reply Ben, but I think my problem is slightly  
>> different.  It is not
>> that the sense (high/low/rising/falling) of the interrupt is  
>> wrong, but that the
>> kernel will not allow me to register the handler.
>>
>> I've changed my code to:
>>
>>      struct device_node *np = of_find_node_by_type(NULL, "ipic");
>>      struct irq_host *host = irq_find_host(np);
>>      int rc;
>>
>>      unsigned int virq = irq_find_mapping(host, 5);
>>      set_irq_type(virq, IRQ_TYPE_EDGE_FALLING);
>>      rc = request_irq(virq, mpc832xemds_phy_interrupt,  
>> IRQF_SHARED, "pm5384", dev);
>>
>> but the last line still returns a non-zero error code.
>>
>> Is there a new way of requesting to install a handler for external  
>> interrupts?  I
>> can't find any powerpc examples in the kernel tree....
>>
> Sorry, I missed a bit of the implementation.  You need to register the
> IRQs before attempting to attach an ISR. Here's some sample code that
> works for me.  You'll probably need different IRQs, based on what your
> board does:
>
> /* All external IRQs + Generic timer IRQs must be initialized by  
> BSP */
> const int bsp_irqs[] = {48, 17, 18, 19, 20, 21, 22, 23, 90, 78, 84,  
> 72};
>
> Add this to your BSP IRQ init code (void __init xxx_init_IRQs())
>
>
> 	for (i=0;i<sizeof(bsp_irqs)/sizeof(bsp_irqs[0]);i++)
> 		virq = irq_create_mapping(NULL, bsp_irqs[i]);

I assume you're code doesn't look exactly like this.  You'll need to  
use the virq in the request_irq()... its most likely just random luck  
if things are working and you aren't using the virq returned from  
irq_create_mapping()

(Well its more than random luck, its because most 83xx systems only  
have one PIC and this hw_irq # == virq)

- k
