Return-Path: <tnt@246tNt.com>
Received: from outmx009.isp.belgacom.be (outmx009.isp.belgacom.be
	[195.238.5.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AD9A3DDF2E
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Mar 2007 21:03:28 +1100 (EST)
Received: from outmx009.isp.belgacom.be (localhost [127.0.0.1])
	by outmx009.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l26A352n020609
	for <linuxppc-embedded@ozlabs.org>; Tue, 6 Mar 2007 11:03:06 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <45ED3C29.6020100@246tNt.com>
Date: Tue, 06 Mar 2007 11:02:17 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Domen Puncer <domen.puncer@telargo.com>
Subject: Re: [PATCH] mpc52xx_pic: fix main interrupt masking
References: <20070306095011.GY4397@moe.telargo.com>
In-Reply-To: <20070306095011.GY4397@moe.telargo.com>
Content-Type: text/plain; charset=ISO-8859-1
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

Domen Puncer wrote:
> Fix main interrupt masking.
> Tested with RTC and GPIO_WKUP interrupts.
>
>
> Signed-off-by: Domen Puncer <domen.puncer@telargo.com>
>   
Acked-by: Sylvain Munaut <tnt@246tNt.com>

Damn, I knew I forgot something during the last batch ! That bug had
already been spotted earlier ...

> ---
>  arch/powerpc/platforms/52xx/mpc52xx_pic.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Index: grant.git/arch/powerpc/platforms/52xx/mpc52xx_pic.c
> ===================================================================
> --- grant.git.orig/arch/powerpc/platforms/52xx/mpc52xx_pic.c
> +++ grant.git/arch/powerpc/platforms/52xx/mpc52xx_pic.c
> @@ -128,7 +128,7 @@ static void mpc52xx_main_mask(unsigned i
>  
>  	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
>  
> -	io_be_setbit(&intr->main_mask, 15 - l2irq);
> +	io_be_setbit(&intr->main_mask, 16 - l2irq);
>  }
>  
>  static void mpc52xx_main_unmask(unsigned int virq)
> @@ -141,7 +141,7 @@ static void mpc52xx_main_unmask(unsigned
>  
>  	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
>  
> -	io_be_clrbit(&intr->main_mask, 15 - l2irq);
> +	io_be_clrbit(&intr->main_mask, 16 - l2irq);
>  }
>  
>  static struct irq_chip mpc52xx_main_irqchip = {
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>   
