Return-Path: <bwarren@qstreams.com>
Received: from smtp108.biz.mail.re2.yahoo.com (smtp108.biz.mail.re2.yahoo.com
	[206.190.52.47]) by ozlabs.org (Postfix) with SMTP id 14B3BDDE20
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 May 2007 00:12:30 +1000 (EST)
Subject: Re: 83xx: requesting external interrupts
From: Ben Warren <bwarren@qstreams.com>
To: Alex Zeffertt <ajz@cambridgebroadband.com>
In-Reply-To: <46443784.3060600@cambridgebroadband.com>
References: <46434C1E.3020004@cambridgebroadband.com>
	<1178816847.9018.2.camel@saruman.qstreams.net>
	<46443784.3060600@cambridgebroadband.com>
Content-Type: text/plain
Date: Fri, 11 May 2007 10:12:28 -0400
Message-Id: <1178892748.9018.13.camel@saruman.qstreams.net>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Reply-To: bwarren@qstreams.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Alex,

On Fri, 2007-05-11 at 10:29 +0100, Alex Zeffertt wrote:
> Hi,
> 
> Thanks for your reply Ben, but I think my problem is slightly different.  It is not
> that the sense (high/low/rising/falling) of the interrupt is wrong, but that the
> kernel will not allow me to register the handler.
> 
> I've changed my code to:
> 
>      struct device_node *np = of_find_node_by_type(NULL, "ipic");
>      struct irq_host *host = irq_find_host(np);
>      int rc;
> 
>      unsigned int virq = irq_find_mapping(host, 5);
>      set_irq_type(virq, IRQ_TYPE_EDGE_FALLING);
>      rc = request_irq(virq, mpc832xemds_phy_interrupt, IRQF_SHARED, "pm5384", dev);
> 
> but the last line still returns a non-zero error code.
> 
> Is there a new way of requesting to install a handler for external interrupts?  I
> can't find any powerpc examples in the kernel tree....
> 
Sorry, I missed a bit of the implementation.  You need to register the
IRQs before attempting to attach an ISR. Here's some sample code that
works for me.  You'll probably need different IRQs, based on what your
board does:

/* All external IRQs + Generic timer IRQs must be initialized by BSP */
const int bsp_irqs[] = {48, 17, 18, 19, 20, 21, 22, 23, 90, 78, 84, 72};

Add this to your BSP IRQ init code (void __init xxx_init_IRQs())


	for (i=0;i<sizeof(bsp_irqs)/sizeof(bsp_irqs[0]);i++)
		virq = irq_create_mapping(NULL, bsp_irqs[i]);

That should do it.

regards,
Ben
