Return-Path: <khali@linux-fr.org>
Received: from kraid.nerim.net (smtp-102-tuesday.nerim.net [62.4.16.102])
	by ozlabs.org (Postfix) with ESMTP id 7440EDDE35
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 02:10:23 +1100 (EST)
Date: Tue, 19 Feb 2008 16:10:20 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] Convert pfc8563 i2c driver from old style to new style
Message-ID: <20080219161020.61f7ec10@hyperion.delvare>
In-Reply-To: <20080121200901.15517.30253.stgit@terra.home>
References: <20080121200901.15517.30253.stgit@terra.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Alessandro Zummo <alessandro.zummo@towertech.it>,
	i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Jon,

On Mon, 21 Jan 2008 15:09:01 -0500, Jon Smirl wrote:
> Convert pfc8563 i2c driver from old style to new style.
> 
> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
> ---
> 
>  drivers/rtc/rtc-pcf8563.c |  107 +++++++++++----------------------------------
>  1 files changed, 27 insertions(+), 80 deletions(-)

Preliminary note: this driver belongs to the RTC subsystem, so it will
be up to Alessandro Zummo (Cc'd) to push this patch upstream... when it
is ready to go there.

I am also adding Clemens Koller to Cc. Clemens, as you sent patches to
the pcf8563 driver, I guess that you are using this driver. Please let
us know on which architecture and whether the platform code was already
updated to instantiate the pcf8563 (or rtc8564) device. Right now it
seems that only two ixp4xx platforms have been updated to do so
(dsmg600 and nas100d). I am worried that the conversion to a new-style
driver could break some systems, although that should be fairly easy to
fix.

Review:

> diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
> index b3317fc..8eff549 100644
> --- a/drivers/rtc/rtc-pcf8563.c
> +++ b/drivers/rtc/rtc-pcf8563.c
> @@ -25,10 +25,6 @@
>   * located at 0x51 will pass the validation routine due to
>   * the way the registers are implemented.
>   */
> -static const unsigned short normal_i2c[] = { I2C_CLIENT_END };
> -
> -/* Module parameters */
> -I2C_CLIENT_INSMOD;

The comment above can probably go away as well now, it no longer makes
sense without the normal_i2c declaration.

>  
>  #define PCF8563_REG_ST1		0x00 /* status */
>  #define PCF8563_REG_ST2		0x01
> @@ -72,9 +68,6 @@ struct pcf8563 {
>  	int c_polarity;	/* 0: MO_C=1 means 19xx, otherwise MO_C=1 means 20xx */
>  };
>  
> -static int pcf8563_probe(struct i2c_adapter *adapter, int address, int kind);
> -static int pcf8563_detach(struct i2c_client *client);
> -
>  /*
>   * In the routines that deal directly with the pcf8563 hardware, we use
>   * rtc_time -- month 0-11, hour 0-23, yr = calendar year-epoch.
> @@ -257,98 +250,52 @@ static const struct rtc_class_ops pcf8563_rtc_ops = {
>  	.set_time	= pcf8563_rtc_set_time,
>  };
>  
> -static int pcf8563_attach(struct i2c_adapter *adapter)
> +static int pcf8563_remove(struct i2c_client *client)
>  {
> -	return i2c_probe(adapter, &addr_data, pcf8563_probe);
> +	struct rtc_device *rtc = i2c_get_clientdata(client);
> +
> +	if (rtc)
> +		rtc_device_unregister(rtc);
> +
> +	return 0;
>  }

Moving this function where pcf8563_detach() was would result in a
smaller, more readable patch.

>  
> +static struct i2c_device_id pcf8563_id[] = {

This structure and all the surrounding infrastructure don't exist yet,
so you can't use this. This part of the code will be added later to all
the new-style i2c device drivers at once, you don't have to worry about
this.

> +	{"pcf8563", 0},
> +	{"rtc8564", 0},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(i2c, pcf8563_id);
> +
> +static int pcf8563_probe(struct i2c_client *client, const struct i2c_device_id *id);
> +
>  static struct i2c_driver pcf8563_driver = {
>  	.driver		= {
> -		.name	= "pcf8563",
> +		.name	= "rtc-pcf8563",
>  	},
>  	.id		= I2C_DRIVERID_PCF8563,

It's probably the right time to get rid of I2C_DRIVERID_PCF8563 (here
and in <include/i2c-id.h>).

> -	.attach_adapter = &pcf8563_attach,
> -	.detach_client	= &pcf8563_detach,
> +	.probe = &pcf8563_probe,
> +	.remove = &pcf8563_remove,

Use tabs before the equal sign to be consistent with the rest of the
structure declaration.

> +	.id_table	= pcf8563_id,
>  };
>  
> -static int pcf8563_probe(struct i2c_adapter *adapter, int address, int kind)
> +static int pcf8563_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  {
> -	struct pcf8563 *pcf8563;
> -	struct i2c_client *client;
> +	int result;
>  	struct rtc_device *rtc;
>  
> -	int err = 0;
> -
> -	dev_dbg(&adapter->dev, "%s\n", __FUNCTION__);
> -
> -	if (!i2c_check_functionality(adapter, I2C_FUNC_I2C)) {
> -		err = -ENODEV;
> -		goto exit;
> -	}
> -
> -	if (!(pcf8563 = kzalloc(sizeof(struct pcf8563), GFP_KERNEL))) {
> -		err = -ENOMEM;
> -		goto exit;
> -	}

So you no longer allocate a struct pcf8563. How are
pcf8563_get_datetime() and pcf8563_set_datetime() supposed to work?
Both do:
	struct pcf8563 *pcf8563 = container_of(client, struct pcf8563, client);

While I agree that struct pcf8563 must no longer contain a struct
i2c_client for a new-style driver, there's still c_polarity which needs
to be carried around and handled.

You did not actually test your patch, did you?

I think that you will have to add a
	struct rtc_device *rtc;
to struct pcf8563, as you can't set the client data to both the struct
rtc_device address and the struct pcf8563 address. This is what the
pcf8583 driver does for example.

> -
> -	client = &pcf8563->client;
> -	client->addr = address;
> -	client->driver = &pcf8563_driver;
> -	client->adapter	= adapter;
> -
> -	strlcpy(client->name, pcf8563_driver.driver.name, I2C_NAME_SIZE);
> -
> -	/* Verify the chip is really an PCF8563 */
> -	if (kind < 0) {
> -		if (pcf8563_validate_client(client) < 0) {
> -			err = -ENODEV;
> -			goto exit_kfree;
> -		}
> -	}
> -
> -	/* Inform the i2c layer */
> -	if ((err = i2c_attach_client(client)))
> -		goto exit_kfree;
> -
> -	dev_info(&client->dev, "chip found, driver version " DRV_VERSION "\n");
> +	result = pcf8563_validate_client(client);
> +	if (result)
> +		return result;

The pcf8563_validate_client() function could probably go away for a
smaller driver and shorter initialization time. New-style i2c drivers
don't really need to detect what chip they are attaching to, they
should be able to trust the platform code.

>  
>  	rtc = rtc_device_register(pcf8563_driver.driver.name, &client->dev,
>  				&pcf8563_rtc_ops, THIS_MODULE);
> -
> -	if (IS_ERR(rtc)) {
> -		err = PTR_ERR(rtc);
> -		goto exit_detach;
> -	}
> +	if (IS_ERR(rtc))
> +		return PTR_ERR(rtc);
>  
>  	i2c_set_clientdata(client, rtc);
>  
>  	return 0;
> -
> -exit_detach:
> -	i2c_detach_client(client);
> -
> -exit_kfree:
> -	kfree(pcf8563);
> -
> -exit:
> -	return err;
> -}
> -
> -static int pcf8563_detach(struct i2c_client *client)
> -{
> -	struct pcf8563 *pcf8563 = container_of(client, struct pcf8563, client);
> -	int err;
> -	struct rtc_device *rtc = i2c_get_clientdata(client);
> -
> -	if (rtc)
> -		rtc_device_unregister(rtc);
> -
> -	if ((err = i2c_detach_client(client)))
> -		return err;
> -
> -	kfree(pcf8563);
> -
> -	return 0;
>  }
>  
>  static int __init pcf8563_init(void)

-- 
Jean Delvare
