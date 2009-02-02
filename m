Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 773FADDF08
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Feb 2009 04:29:20 +1100 (EST)
Date: Mon, 2 Feb 2009 18:29:09 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH] i2c: i2c-ibm_iic message can be confusing
Message-ID: <20090202182909.2cea69a3@hyperion.delvare>
In-Reply-To: <20090202120159.2478d7af@lappy.seanm.ca>
References: <20090202120159.2478d7af@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, ben-linux@fluff.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2 Feb 2009 12:01:59 -0500, Sean MacLennan wrote:
> This is a trivial patch that does not need to be in 2.6.29. While
> tracking down an EEPROM problem, I found the messages confusing... it
> looked like the EEPROM was being started before the I2C driver!
> 
> Here is an example:
> 
> at24 0-0052: 512 byte 24c04 EEPROM (writable)
> ibm-iic ef600700.i2c: using standard (100 kHz) mode
> ad7414 0-004a: chip found
> 
> It looks like the at24 starts first, then the i2c driver, then the
> ad7414. By moving the message to after the of scan, we always get the
> driver, then the devices.
> 
> Cheers,
>    Sean
> 
> Print the i2c driver message before scanning for devices so that the
> logs show the driver, then the devices. Currently you can get
> device(s), driver, device(s).
> 
> Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
> ---
> diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
> index 88f0db7..7fc0729 100644
> --- a/drivers/i2c/busses/i2c-ibm_iic.c
> +++ b/drivers/i2c/busses/i2c-ibm_iic.c
> @@ -756,12 +756,12 @@ static int __devinit iic_probe(struct of_device *ofdev,
>  		goto error_cleanup;
>  	}
>  
> -	/* Now register all the child nodes */
> -	of_register_i2c_devices(adap, np);
> -
>  	dev_info(&ofdev->dev, "using %s mode\n",
>  		 dev->fast_mode ? "fast (400 kHz)" : "standard (100 kHz)");
>  
> +	/* Now register all the child nodes */
> +	of_register_i2c_devices(adap, np);
> +
>  	return 0;
>  
>  error_cleanup:

Indeed.

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare
