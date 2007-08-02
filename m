Return-Path: <yoni.l@slyde-tech.com>
Received: from smtpin.livedns.co.il (smtpin.livedns.co.il [62.219.78.209])
	by ozlabs.org (Postfix) with ESMTP id 5CB14DDE49
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Aug 2007 01:39:10 +1000 (EST)
From: "Yoni Levin" <yoni.l@slyde-tech.com>
To: "'Scott Wood'" <scottwood@freescale.com>
Subject: RE: GPIO interrupts on mpc8313e
Date: Thu, 2 Aug 2007 18:38:52 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <46B1F5E1.6000301@freescale.com>
Message-ID: <B6DEC8DD6C474CED998B80706BFC4BCC.MAI@mail.livedns.co.il>
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

myirq=74

-----Original Message-----
From: Scott Wood [mailto:scottwood@freescale.com] 
Sent: Thursday, August 02, 2007 6:19 PM
To: Yoni Levin
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: GPIO interrupts on mpc8313e

Yoni Levin wrote:
> Yes, I removed the flag (0) and nothing change in both cases the
request_irq
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
