Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 89B13DDE25
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 02:29:30 +1000 (EST)
Date: Fri, 2 May 2008 18:29:17 +0200
From: Jean Delvare <khali@linux-fr.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH] mpc i2c driver, compare to NO_IRQ instead of zero
Message-ID: <20080502182917.41dc560e@hyperion.delvare>
In-Reply-To: <9e4733910805020902ga4f05b3nfd2221511ec2ebba@mail.gmail.com>
References: <20080121200740.13800.20524.stgit@terra.home>
	<20080219174221.5b18cba8@hyperion.delvare>
	<9e4733910805020723p7900c132j872893113f9d739e@mail.gmail.com>
	<20080502164610.277ec04b@hyperion.delvare>
	<9e4733910805020902ga4f05b3nfd2221511ec2ebba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Jon,

On Fri, 2 May 2008 12:02:27 -0400, Jon Smirl wrote:
> New version with your fix.
> 
> diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
> index bbe787b..b141057 100644
> --- a/drivers/i2c/busses/i2c-mpc.c
> +++ b/drivers/i2c/busses/i2c-mpc.c
> @@ -99,7 +99,7 @@ static int i2c_wait(struct mpc_i2c *i2c, unsigned
> timeout, int writing)

Long lines folded, patch doesn't apply...

>  	u32 x;
>  	int result = 0;
> 
> -	if (i2c->irq == 0)
> +	if (i2c->irq == NO_IRQ)
>  	{
>  		while (!(readb(i2c->base + MPC_I2C_SR) & CSR_MIF)) {
>  			schedule();
> @@ -329,10 +329,9 @@ static int fsl_i2c_probe(struct platform_device *pdev)
>  		return -ENOMEM;
> 
>  	i2c->irq = platform_get_irq(pdev, 0);
> -	if (i2c->irq < 0) {
> -		result = -ENXIO;
> -		goto fail_get_irq;
> -	}
> +	if (i2c->irq < 0)
> +		i2c->irq = NO_IRQ; /* Use polling */
> +

After this change, label fail_get_irq is unused so you should remove
it. gcc should have told you, didn't it?

>  	i2c->flags = pdata->device_flags;
>  	init_waitqueue_head(&i2c->queue);
> 
> @@ -344,7 +343,7 @@ static int fsl_i2c_probe(struct platform_device *pdev)
>  		goto fail_map;
>  	}
> 
> -	if (i2c->irq != 0)
> +	if (i2c->irq != NO_IRQ)
>  		if ((result = request_irq(i2c->irq, mpc_i2c_isr,
>  					  IRQF_SHARED, "i2c-mpc", i2c)) < 0) {
>  			printk(KERN_ERR
> @@ -367,7 +366,7 @@ static int fsl_i2c_probe(struct platform_device *pdev)
>  	return result;
> 
>        fail_add:
> -	if (i2c->irq != 0)
> +	if (i2c->irq != NO_IRQ)
>  		free_irq(i2c->irq, i2c);
>        fail_irq:
>  	iounmap(i2c->base);
> @@ -384,7 +383,7 @@ static int fsl_i2c_remove(struct platform_device *pdev)
>  	i2c_del_adapter(&i2c->adap);
>  	platform_set_drvdata(pdev, NULL);
> 
> -	if (i2c->irq != 0)
> +	if (i2c->irq != NO_IRQ)
>  		free_irq(i2c->irq, i2c);
> 
>  	iounmap(i2c->base);
> 
> 


-- 
Jean Delvare
