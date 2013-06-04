Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe001.messaging.microsoft.com [216.32.180.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4D20A2C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jun 2013 08:00:04 +1000 (EST)
Date: Tue, 4 Jun 2013 16:59:46 -0500
From: Scott Wood <scottwood@freescale.com>
To: LEROY Christophe <christophe.leroy@c-s.fr>
Subject: Re: Handling of IRQ in MPC8xx GPIO
Message-ID: <20130604215946.GA21467@home.buserror.net>
References: <201302211632.r1LGWaRr025445@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <201302211632.r1LGWaRr025445@localhost.localdomain>
Cc: Marcelo Tosatti <marcelo@kvack.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 21, 2013 at 06:32:36AM -0000, LEROY Christophe wrote:
> This patch allows the use IRQ to notify the change of GPIO status on the MPC8xx
> CPM IO ports. This then allows to associate IRQs to GPIOs in the Device Tree. Ex:
> 	CPM1_PIO_C: gpio-controller@960 {
> 		#gpio-cells = <2>;
> 		compatible = "fsl,cpm1-pario-bank-c";
> 		reg = <0x960 0x10>;
> 		interrupts = <255 255 255 255 1 2 6 9 10 11 14 15 23 24 26 31>;
> 		interrupt-parent = <&CPM_PIC>;
> 		gpio-controller;
> 	};
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
[snip]
> @@ -581,6 +588,30 @@
>  	spin_unlock_irqrestore(&cpm1_gc->lock, flags);
>  }
>  
> +static int __cpm1_gpio16_to_irq(struct of_mm_gpio_chip *mm_gc,
> +		unsigned int gpio)
> +{
> +	struct cpm1_gpio16_chip *cpm1_gc = to_cpm1_gpio16_chip(mm_gc);
> +
> +	return cpm1_gc->irq[gpio] ? cpm1_gc->irq[gpio] : -ENXIO;
> +}

If it's an internal function, why not just pass in cpm1_gc?

Or just open-code it, as it's a one-liner and you don't use it anywhere
else.

Or fix the gpio layer to use 0 to mean "no irq" rather than -ENXIO... :-)

> diff -ur linux-3.7.9/kernel/irq/irqdomain.c linux/kernel/irq/irqdomain.c
> --- linux-3.7.9/kernel/irq/irqdomain.c	2013-02-17 19:53:32.000000000 +0100
> +++ linux/kernel/irq/irqdomain.c	2012-12-13 19:52:38.000000000 +0100
> @@ -763,7 +763,8 @@
>  	BUG_ON(domain->revmap_type != IRQ_DOMAIN_MAP_LINEAR);
>  
>  	/* Check revmap bounds; complain if exceeded */
> -	if (WARN_ON(hwirq >= domain->revmap_data.linear.size))
> +	/* 255 is a trick to allow UNDEF value in DTS */
> +	if (hwirq == 255 || WARN_ON(hwirq >= domain->revmap_data.linear.size))
>  		return 0;

NACK.  Besides the hackishness of it, 255 is valid for some interrupt
controllers.

If you need for a way to leave holes in an "interrupts" property, propose
something non-hacky on devicetree-discuss@lists.ozlabs.org.

Or, do what some other devices do, and have a different property that
indicates which pins are connected, and only include those in the
"interrupts" property.  See
Documentation/devicetree/bindings/powerpc/fsl/mpic-msgr.txt and
mpic-msgr-receive-mask as an example.

-Scott
