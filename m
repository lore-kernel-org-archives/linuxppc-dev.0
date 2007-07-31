Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BB057DDDD5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 31 Jul 2007 23:35:35 +1000 (EST)
Message-ID: <46AF3A9C.4090007@freescale.com>
Date: Tue, 31 Jul 2007 08:35:24 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Yoni Levin <yoni.l@slyde-tech.com>
Subject: Re: interrupts in mpc8313
References: <1A95C6D899744E16A71AFFB2CF1C11B1.MAI@mail.livedns.co.il>
In-Reply-To: <1A95C6D899744E16A71AFFB2CF1C11B1.MAI@mail.livedns.co.il>
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
