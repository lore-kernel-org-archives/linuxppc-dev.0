Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F1F6DB7D53
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 17:06:44 +1000 (EST)
Subject: Re: [PATCH RESEND 3/3] i2c/ibm-iic: drop NO_IRQ
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wolfram Sang <w.sang@pengutronix.de>
In-Reply-To: <1270167421-5205-4-git-send-email-w.sang@pengutronix.de>
References: <1270167421-5205-1-git-send-email-w.sang@pengutronix.de>
	<1270167421-5205-4-git-send-email-w.sang@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 27 Apr 2010 17:06:14 +1000
Message-ID: <1272351974.24542.9.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org,
	Ben Dooks <ben-linux@fluff.org>, Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-04-02 at 02:17 +0200, Wolfram Sang wrote:
> Drop NO_IRQ as 0 is the preferred way to describe 'no irq'
> (http://lkml.org/lkml/2005/11/21/221). This change is safe, as the driver is
> only used on powerpc, where NO_IRQ is 0 anyhow.

Oops... forgot those. Applied, will show up in -next soon.

Cheers,
Ben.

> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> Cc: Sean MacLennan <smaclennan@pikatech.com>
> Cc: Ben Dooks <ben-linux@fluff.org>
> ---
>  drivers/i2c/busses/i2c-ibm_iic.c |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
> index b1bc6e2..2bef534 100644
> --- a/drivers/i2c/busses/i2c-ibm_iic.c
> +++ b/drivers/i2c/busses/i2c-ibm_iic.c
> @@ -668,12 +668,12 @@ static int __devinit iic_request_irq(struct of_device *ofdev,
>  	int irq;
>  
>  	if (iic_force_poll)
> -		return NO_IRQ;
> +		return 0;
>  
>  	irq = irq_of_parse_and_map(np, 0);
> -	if (irq == NO_IRQ) {
> +	if (!irq) {
>  		dev_err(&ofdev->dev, "irq_of_parse_and_map failed\n");
> -		return NO_IRQ;
> +		return 0;
>  	}
>  
>  	/* Disable interrupts until we finish initialization, assumes
> @@ -683,7 +683,7 @@ static int __devinit iic_request_irq(struct of_device *ofdev,
>  	if (request_irq(irq, iic_handler, 0, "IBM IIC", dev)) {
>  		dev_err(&ofdev->dev, "request_irq %d failed\n", irq);
>  		/* Fallback to the polling mode */
> -		return NO_IRQ;
> +		return 0;
>  	}
>  
>  	return irq;
> @@ -719,7 +719,7 @@ static int __devinit iic_probe(struct of_device *ofdev,
>  	init_waitqueue_head(&dev->wq);
>  
>  	dev->irq = iic_request_irq(ofdev, dev);
> -	if (dev->irq == NO_IRQ)
> +	if (!dev->irq)
>  		dev_warn(&ofdev->dev, "using polling mode\n");
>  
>  	/* Board specific settings */
> @@ -766,7 +766,7 @@ static int __devinit iic_probe(struct of_device *ofdev,
>  	return 0;
>  
>  error_cleanup:
> -	if (dev->irq != NO_IRQ) {
> +	if (dev->irq) {
>  		iic_interrupt_mode(dev, 0);
>  		free_irq(dev->irq, dev);
>  	}
> @@ -790,7 +790,7 @@ static int __devexit iic_remove(struct of_device *ofdev)
>  
>  	i2c_del_adapter(&dev->adap);
>  
> -	if (dev->irq != NO_IRQ) {
> +	if (dev->irq) {
>  		iic_interrupt_mode(dev, 0);
>  		free_irq(dev->irq, dev);
>  	}
