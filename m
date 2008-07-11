Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de",
	Issuer "StartCom Class 1 Primary Intermediate Server CA" (not
	verified)) by ozlabs.org (Postfix) with ESMTPS id E9F6CDDE10
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jul 2008 05:11:13 +1000 (EST)
Message-ID: <4877B046.8070206@scram.de>
Date: Fri, 11 Jul 2008 21:11:02 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] of/i2c: don't pass -1 to irq_dispose_mapping, otherwise
	kernel will oops
References: <20080711174859.GA24260@polina.dev.rtsoft.ru>
In-Reply-To: <20080711174859.GA24260@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Anton,

> diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
> index b2ccdcb..95a24de 100644
> --- a/drivers/of/of_i2c.c
> +++ b/drivers/of/of_i2c.c
> @@ -93,10 +93,8 @@ void of_register_i2c_devices(struct i2c_adapter *adap,
>  		if (info.irq == NO_IRQ)
>  			info.irq = -1;
>  
> -		if (of_find_i2c_driver(node, &info) < 0) {
> -			irq_dispose_mapping(info.irq);
> -			continue;
> -		}
> +		if (of_find_i2c_driver(node, &info) < 0)
> +			goto err;
>  
>  		info.addr = *addr;
>  
> @@ -107,9 +105,12 @@ void of_register_i2c_devices(struct i2c_adapter *adap,
>  			printk(KERN_ERR
>  			       "of-i2c: Failed to load driver for %s\n",
>  			       info.type);
> -			irq_dispose_mapping(info.irq);
> -			continue;
> +			goto err;
>  		}
> +		continue;
> +err:
> +		if (info.irq > 0)
> +			irq_dispose_mapping(info.irq);

Shouldn't this be:
		if (info.irq != NO_IRQ)

>  	}
>  }
>  EXPORT_SYMBOL(of_register_i2c_devices);

Thanks,
Jochen
