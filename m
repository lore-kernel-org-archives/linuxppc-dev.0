Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5C3D9DDE41
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 16:14:12 +1000 (EST)
Subject: Re: [PATCH] synchronize_irq needs a barrier
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Maxim Levitsky <maximlevitsky@gmail.com>
In-Reply-To: <200710200806.41562.maximlevitsky@gmail.com>
References: <1192670742.12879.5.camel@pasglop>
	<200710200736.22129.maximlevitsky@gmail.com>
	<1192859184.6745.8.camel@pasglop>
	<200710200806.41562.maximlevitsky@gmail.com>
Content-Type: text/plain
Date: Sat, 20 Oct 2007 16:13:31 +1000
Message-Id: <1192860811.6745.11.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	akpm <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sat, 2007-10-20 at 08:06 +0200, Maxim Levitsky wrote:

> 	/* Disable interrupts, DMA, and rest of the chip*/
> 	saa_writel(SAA7134_IRQ1, 0);
> 	saa_writel(SAA7134_IRQ2, 0);
> 	saa_writel(SAA7134_MAIN_CTRL, 0);
	
> 	dev->insuspend = 1;
> 	synchronize_irq(pci_dev->irq);
> 
> 	/* ACK pending interrupts just in case*/
> 	saa_writel(SAA7134_IRQ_REPORT,saa_readl(SAA7134_IRQ_REPORT));
> 
> 	......
> This should be bullet-proof.

Hopefully :-)

Cheers,
Ben.
