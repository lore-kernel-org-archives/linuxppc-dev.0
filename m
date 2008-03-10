Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0F7A8DDE10
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Mar 2008 20:13:53 +1100 (EST)
In-Reply-To: <47D4EFC1.1050403@tiscali.nl>
References: <47D47B11.1000303@tiscali.nl>	
	<20080310084633.5246ecfe@paperstreet.colino.net>
	<1205136413.8621.3.camel@pasglop> <47D4EFC1.1050403@tiscali.nl>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <64d5b5e6dfd0d1820d21db323ef88e25@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: ADT746X: logical-bitwise & confusion in set_max_duty_at_crit()
Date: Mon, 10 Mar 2008 10:13:34 +0100
To: Roel Kluin <12o3l@tiscali.nl>
Cc: Colin Leroy <colin@colino.net>, lkml <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> diff --git a/drivers/hwmon/adt7473.c b/drivers/hwmon/adt7473.c
> index 9587869..8ea7da2 100644
> --- a/drivers/hwmon/adt7473.c
> +++ b/drivers/hwmon/adt7473.c
> @@ -570,7 +570,7 @@ static ssize_t set_max_duty_at_crit(struct device 
> *dev,
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct adt7473_data *data = i2c_get_clientdata(client);
>  	int temp = simple_strtol(buf, NULL, 10);
> -	temp = temp && 0xFF;
> +	temp &= 0xFF;
>
>  	mutex_lock(&data->lock);
>  	data->max_duty_at_overheat = temp;

The & 0xff here is bogus anyway; temp is only ever used as an u8,
so just declare it as that, or do proper overflow/underflow checking
on it.  The patch will need testing on hardware too, since it changes
behaviour (it should be a bugfix, but who knows).


Segher
