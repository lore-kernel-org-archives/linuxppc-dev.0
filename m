Return-Path: <khali@linux-fr.org>
Received: from mallaury.nerim.net (smtp-102-tuesday.noc.nerim.net
	[62.4.17.102]) by ozlabs.org (Postfix) with ESMTP id 9B93ADE2C8
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 03:42:23 +1100 (EST)
Date: Tue, 19 Feb 2008 17:42:21 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] mpc i2c driver, compare to NO_IRQ instead of zero
Message-ID: <20080219174221.5b18cba8@hyperion.delvare>
In-Reply-To: <20080121200740.13800.20524.stgit@terra.home>
References: <20080121200740.13800.20524.stgit@terra.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Jon,

On Mon, 21 Jan 2008 15:07:40 -0500, Jon Smirl wrote:
> Alter the mpc i2c driver to use the NO_IRQ symbol instead of
> the constant zero when checking for valid interrupts. NO_IRQ=-1
> on ppc and NO_IRQ=0 on powerpc so the checks against zero are
> not correct.

Using NO_IRQ sounds good, just one question:

> 
> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
> ---
> 
>  drivers/i2c/busses/i2c-mpc.c |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
> 
> diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
> index bbe787b..d20959d 100644
> --- a/drivers/i2c/busses/i2c-mpc.c
> +++ b/drivers/i2c/busses/i2c-mpc.c
> @@ -99,7 +99,7 @@ static int i2c_wait(struct mpc_i2c *i2c, unsigned timeout, int writing)
>  	u32 x;
>  	int result = 0;
>  
> -	if (i2c->irq == 0)
> +	if (i2c->irq == NO_IRQ)
>  	{
>  		while (!(readb(i2c->base + MPC_I2C_SR) & CSR_MIF)) {
>  			schedule();
> @@ -329,7 +329,7 @@ static int fsl_i2c_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	i2c->irq = platform_get_irq(pdev, 0);
> -	if (i2c->irq < 0) {
> +	if (i2c->irq < NO_IRQ) {

I am skeptical about this one. Can platform_get_irq() really return
NO_IRQ? I thought that the IRQ resource would be plain missing if the
device has no IRQ, so I would expect:

 	i2c->irq = platform_get_irq(pdev, 0);
	if (i2c->irq < 0)
		i2c->irq = NO_IRQ; /* Use polling */

Testing against NO_IRQ suggests that devices with no IRQ would still
have an IRQ resource defined and explicitly set to NO_IRQ. Sounds weird
to me. Can you please clarify this point?

For what it's worth, no other kernel driver checks for irq < NO_IRQ.
They all check for irq < 0 after calling platform_get_irq().

>  		result = -ENXIO;
>  		goto fail_get_irq;
>  	}
> @@ -344,7 +344,7 @@ static int fsl_i2c_probe(struct platform_device *pdev)
>  		goto fail_map;
>  	}
>  
> -	if (i2c->irq != 0)
> +	if (i2c->irq != NO_IRQ)
>  		if ((result = request_irq(i2c->irq, mpc_i2c_isr,
>  					  IRQF_SHARED, "i2c-mpc", i2c)) < 0) {
>  			printk(KERN_ERR
> @@ -367,7 +367,7 @@ static int fsl_i2c_probe(struct platform_device *pdev)
>  	return result;
>  
>        fail_add:
> -	if (i2c->irq != 0)
> +	if (i2c->irq != NO_IRQ)
>  		free_irq(i2c->irq, i2c);
>        fail_irq:
>  	iounmap(i2c->base);
> @@ -384,7 +384,7 @@ static int fsl_i2c_remove(struct platform_device *pdev)
>  	i2c_del_adapter(&i2c->adap);
>  	platform_set_drvdata(pdev, NULL);
>  
> -	if (i2c->irq != 0)
> +	if (i2c->irq != NO_IRQ)
>  		free_irq(i2c->irq, i2c);
>  
>  	iounmap(i2c->base);

The rest looks good.

-- 
Jean Delvare
