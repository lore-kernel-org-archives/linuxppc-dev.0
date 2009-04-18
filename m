Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id C3597DDFD2
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Apr 2009 10:36:04 +1000 (EST)
Date: Fri, 17 Apr 2009 20:36:00 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: ben-linux@fluff.org
Subject: Re: [PATCH] i2c: i2c-ibm_iic message can be confusing
Message-ID: <20090417203600.1d0c5cf0@lappy.seanm.ca>
In-Reply-To: <20090202120159.2478d7af@lappy.seanm.ca>
References: <20090202120159.2478d7af@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Jean Delvare <khali@linux-fr.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Any update on the status of this patch? This patch was acked by Jean.

The patchwork entry is http://patchwork.ozlabs.org/patch/21576/ and the
original patch message is below.

Cheers,
   Sean

On Mon, 2 Feb 2009 12:01:59 -0500
Sean MacLennan <smaclennan@pikatech.com> wrote:

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
> diff --git a/drivers/i2c/busses/i2c-ibm_iic.c
> b/drivers/i2c/busses/i2c-ibm_iic.c index 88f0db7..7fc0729 100644
> --- a/drivers/i2c/busses/i2c-ibm_iic.c
> +++ b/drivers/i2c/busses/i2c-ibm_iic.c
> @@ -756,12 +756,12 @@ static int __devinit iic_probe(struct of_device
> *ofdev, goto error_cleanup;
>  	}
>  
> -	/* Now register all the child nodes */
> -	of_register_i2c_devices(adap, np);
> -
>  	dev_info(&ofdev->dev, "using %s mode\n",
>  		 dev->fast_mode ? "fast (400 kHz)" : "standard (100
> kHz)"); 
> +	/* Now register all the child nodes */
> +	of_register_i2c_devices(adap, np);
> +
>  	return 0;
>  
>  error_cleanup:
>  
