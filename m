Return-Path: <yoni.l@slyde-tech.com>
Received: from smtpin.livedns.co.il (smtpin.livedns.co.il [62.219.78.209])
	by ozlabs.org (Postfix) with ESMTP id 945DDDDDFC
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 31 Jul 2007 23:53:37 +1000 (EST)
From: "Yoni Levin" <yoni.l@slyde-tech.com>
To: "'Scott Wood'" <scottwood@freescale.com>
Subject: RE: interrupts in mpc8313
Date: Tue, 31 Jul 2007 16:53:20 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <46AF3A9C.4090007@freescale.com>
Message-ID: <DD658DAB65814DF6A223A007EC5735FE.MAI@mail.livedns.co.il>
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

All I had to do was to add :
irq_create_mapping(NULL,71)
and yes it not the exact code , I work with 2 computers...
thanks.


-----Original Message-----
From: Scott Wood [mailto:scottwood@freescale.com] 
Sent: Tuesday, July 31, 2007 4:35 PM
To: Yoni Levin
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: interrupts in mpc8313

Yoni Levin wrote:
> I tried to use the function request_irq :
> 
>  
> 
> Ret=Request_irq(71,interrupt_handler,SA_INTERUPT,"dma_irq",NULL);

arch/ppc or arch/powerpc?

If the latter, you need to translate the hardware IRQ into a virtual 
IRQ.  The easiest way to do this is to put the DMA node into the device 
tree and use of_irq_to_resource().

Plus, this obviously isn't the exact code you're running, as the 
spelling and capitalization errors would keep it from compiling.

-Scott
