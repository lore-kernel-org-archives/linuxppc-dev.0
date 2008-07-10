Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0F72CDDE23
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 21:49:19 +1000 (EST)
Date: Thu, 10 Jul 2008 13:49:06 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH] powerpc: i2c-ibm_iic register child nodes
Message-ID: <20080710134906.6e419fcd@hyperion.delvare>
In-Reply-To: <20080708144609.14bae1de@lappy.seanm.ca>
References: <20080708144609.14bae1de@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Linux I2C <i2c@lm-sensors.org>,
	Ben Dooks <ben-linux@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Sean,

On Tue, 8 Jul 2008 14:46:09 -0400, Sean MacLennan wrote:
> This patch completes the conversion of the IBM IIC driver to an
> of-platform driver.
> 
> It removes the index from the IBM IIC driver and makes it an unnumbered
> driver. It then calls of_register_i2c_devices to properly register all
> the child nodes in the DTS.
> 
> Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
> ---
> 
> diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
> index 070f078..651f2f1 100644
> --- a/drivers/i2c/busses/i2c-ibm_iic.c
> +++ b/drivers/i2c/busses/i2c-ibm_iic.c
> @@ -43,6 +43,7 @@
>  #include <linux/i2c.h>
>  #include <linux/i2c-id.h>
>  #include <linux/of_platform.h>
> +#include <linux/of_i2c.h>
>  
>  #include "i2c-ibm_iic.h"
>  
> @@ -696,7 +697,7 @@ static int __devinit iic_probe(struct of_device *ofdev,
>  	struct device_node *np = ofdev->node;
>  	struct ibm_iic_private *dev;
>  	struct i2c_adapter *adap;
> -	const u32 *indexp, *freq;
> +	const u32 *freq;
>  	int ret;
>  
>  	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> @@ -707,14 +708,6 @@ static int __devinit iic_probe(struct of_device *ofdev,
>  
>  	dev_set_drvdata(&ofdev->dev, dev);
>  
> -	indexp = of_get_property(np, "index", NULL);
> -	if (!indexp) {
> -		dev_err(&ofdev->dev, "no index specified\n");
> -		ret = -EINVAL;
> -		goto error_cleanup;
> -	}
> -	dev->idx = *indexp;
> -
>  	dev->vaddr = of_iomap(np, 0);
>  	if (dev->vaddr == NULL) {
>  		dev_err(&ofdev->dev, "failed to iomap device\n");
> @@ -757,14 +750,16 @@ static int __devinit iic_probe(struct of_device *ofdev,
>  	adap->class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
>  	adap->algo = &iic_algo;
>  	adap->timeout = 1;
> -	adap->nr = dev->idx;
>  
> -	ret = i2c_add_numbered_adapter(adap);
> +	ret = i2c_add_adapter(adap);
>  	if (ret  < 0) {
>  		dev_err(&ofdev->dev, "failed to register i2c adapter\n");
>  		goto error_cleanup;
>  	}
>  
> +	/* Now register all the child nodes */
> +	of_register_i2c_devices(adap, np);
> +
>  	dev_info(&ofdev->dev, "using %s mode\n",
>  		 dev->fast_mode ? "fast (400 kHz)" : "standard (100 kHz)");
>  

Looks OK. As I already have patches touching
drivers/i2c/busses/i2c-ibm_iic.c in my tree, I'm taking this patch
also. I will push it upstream during the 2.6.27 merge window.

Thanks,
-- 
Jean Delvare
