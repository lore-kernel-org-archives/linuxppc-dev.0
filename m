Return-Path: <maximlevitsky@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id EF4A1DDE1A
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 16:07:25 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so807841uge
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 23:07:24 -0700 (PDT)
From: Maxim Levitsky <maximlevitsky@gmail.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] synchronize_irq needs a barrier
Date: Sat, 20 Oct 2007 08:06:41 +0200
References: <1192670742.12879.5.camel@pasglop>
	<200710200736.22129.maximlevitsky@gmail.com>
	<1192859184.6745.8.camel@pasglop>
In-Reply-To: <1192859184.6745.8.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200710200806.41562.maximlevitsky@gmail.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	akpm <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 20 October 2007 07:46:24 Benjamin Herrenschmidt wrote:
> 
> > I probably need to add this synchronize_irq() logic in dmfe.c too, but I probably do it later,
> > I think I am overestimating this race, since most drivers don't do dev->insuspend checks in IRQ handler.
> > Maybe even just use free_irq() after all....
> 
> Most drivers are probably underestimating the race :-)
> 
> free_irq() would work provided that you did the masking on chip before
> (and unmask only after request_irq on the way back in). But it's a bit
> like using a 10 tons truck to crush an ant... 
Agreed.

So, I will add synchronize_irq() to both saa7134, and dmfe, the two drivers that their .suspend/.resume 
routines were written by me.

I already added a synchronize_irq()  plus few more fixes to the driver , but those patches are still in v4l tree.

I now has this:

	saa_writel(SAA7134_IRQ1, 0);
	saa_writel(SAA7134_IRQ2, 0);
	saa_writel(SAA7134_MAIN_CTRL, 0);

	synchronize_irq(pci_dev->irq);
	dev->insuspend = 1;

and I will probably need (with the synchronize_irq patch applied)


	/* Disable interrupts, DMA, and rest of the chip*/
	saa_writel(SAA7134_IRQ1, 0);
	saa_writel(SAA7134_IRQ2, 0);
	saa_writel(SAA7134_MAIN_CTRL, 0);
	
	dev->insuspend = 1;
	synchronize_irq(pci_dev->irq);

	/* ACK pending interrupts just in case*/
	saa_writel(SAA7134_IRQ_REPORT,saa_readl(SAA7134_IRQ_REPORT));

	......
This should be bullet-proof.


> 
> Ben.
> 
> 
> 
Best regards,
	Maxim Levitsky
