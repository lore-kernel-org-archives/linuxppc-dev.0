Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B6679DDD07
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Aug 2007 01:19:17 +1000 (EST)
Message-ID: <46B1F5E1.6000301@freescale.com>
Date: Thu, 02 Aug 2007 10:18:57 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Yoni Levin <yoni.l@slyde-tech.com>
Subject: Re: GPIO interrupts on mpc8313e
References: <9299F00F70CC4A0EBD33A4EB9E95D9D2.MAI@mail.livedns.co.il>
In-Reply-To: <9299F00F70CC4A0EBD33A4EB9E95D9D2.MAI@mail.livedns.co.il>
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Yoni Levin wrote:
> Yes, I removed the flag (0) and nothing change in both cases the request_irq
> return 0 which is good.
> Then I added enable_irq and I recived :
> 
> Unbalanced enable for IRQ 74

Yeah, sorry, I misremembered what IRQF_DISABLED does.  As Domen pointed 
out, you need to pass myirq, not 74, to request_irq().

> void CreateGPIOHandler()
> {
> 
> 	unsigned int myirq=irq_create_mapping(NULL,74);
> 	enable_irq(74);
> 	printk("myirq is : %d \n",myirq);
> 	int ret;
> 
> 	ret=- request_irq(74, GPIOinterrupt_handler,0, "GPIO", NULL);
> 	printk("ret is : %d \n",ret);
> 	
> 
> }

Even if IRQF_DISABLED did do what I thought it did (I was thinking of 
IRQ_NOAUTOEN, which is apparently an ARM-only thing), you should never 
call enable_irq() before request_irq(), or without previously disabling 
it (either explicitly or via IRQ_NOAUTOEN).

-Scott
