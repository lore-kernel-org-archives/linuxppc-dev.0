Return-Path: <dmytro.bablinyuk@rftechnology.com.au>
Received: from fep08.mfe.bur.connect.com.au (fep08.mfe.bur.connect.com.au
	[203.63.86.28]) by ozlabs.org (Postfix) with ESMTP id 9909867C04
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Dec 2006 13:47:11 +1100 (EST)
Received: from [192.168.1.100] (cor12-ppp739.hay.dsl.connect.net.au
	[61.68.66.231])
	by fep08.mfe.bur.connect.com.au (Postfix) with ESMTP id 39E34F9E6
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Dec 2006 13:47:11 +1100 (EST)
Message-ID: <457E1884.6050501@rftechnology.com.au>
Date: Tue, 12 Dec 2006 13:48:36 +1100
From: Dmytro Bablinyuk <dmytro.bablinyuk@rftechnology.com.au>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: MPC8272: Edge triggered IRQ
References: <457E0D11.1010802@rftechnology.com.au>
In-Reply-To: <457E0D11.1010802@rftechnology.com.au>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Found solution:

immap->im_intctl.ic_siexr |= (1 << (14 - (irq - SIU_INT_IRQ1)));

Makes it trigger on falling edge

Dmytro Bablinyuk wrote:
> I have pretty simple code that I did a long time ago
> 
> irqreturn_t irq_handler(int irq, void *dev_id, struct pt_regs *regs)
> {
>   ..
>  return IRQ_HANDLED;
> }
> 
> 
> request_irq(irq,
>             &irq_handler,
>             SA_INTERRUPT,
>             "irq handler",
>              NULL);
> 
> That code runs on MPC8272 and 2.6.18 kernel.
> It triggers IRQ on low level (I thought it was falling edge by default).
> So, as long as I have input low level I have hundreds of calls. Pretty
> much it keeps calling IRQ handling routine.
> How do I make it to trigger on falling edge?
