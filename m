Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 57C93DE0B2
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 22:10:39 +1000 (EST)
Received: from jdelvare.pck.nerim.net ([62.212.121.182] helo=hyperion.delvare)
	by services.gcu-squad.org (GCU Mailer Daemon) with esmtpsa id
	1LwcN1-0004Jx-3y (TLSv1:AES256-SHA:256)
	(envelope-from <khali@linux-fr.org>)
	for linuxppc-dev@ozlabs.org; Wed, 22 Apr 2009 15:20:11 +0200
Date: Wed, 22 Apr 2009 14:10:28 +0200
From: Jean Delvare <khali@linux-fr.org>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] therm_adt746x: Convert to a new-style i2c driver
Message-ID: <20090422141028.638658ad@hyperion.delvare>
In-Reply-To: <20090416225927.4254efc5@hyperion.delvare>
References: <20090416225927.4254efc5@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 16 Apr 2009 22:59:27 +0200, Jean Delvare wrote:
> The legacy i2c binding model is going away soon, so convert the ppc
> therm_adt746x driver to the new model or it will break.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> ---
> Can someone please test this patch for me? I could only build-test it.
> 
> Remember that you need this patch applied:
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=935298696f469c0e07c73be687bd055878074ce0

Any tester for this patch, please?

> 
> Thanks.
> 
>  drivers/macintosh/therm_adt746x.c |   84 ++++++++++++++++++-------------------
>  1 file changed, 42 insertions(+), 42 deletions(-)
> 
> --- linux-2.6.30-rc2.orig/drivers/macintosh/therm_adt746x.c	2009-04-16 21:06:31.000000000 +0200
> +++ linux-2.6.30-rc2/drivers/macintosh/therm_adt746x.c	2009-04-16 21:37:05.000000000 +0200
> @@ -71,7 +71,7 @@ MODULE_PARM_DESC(verbose,"Verbose log op
>  		 "(default 0)");
>  
>  struct thermostat {
> -	struct i2c_client	clt;
> +	struct i2c_client	*clt;
>  	u8			temps[3];
>  	u8			cached_temp[3];
>  	u8			initial_limits[3];
> @@ -86,9 +86,6 @@ static struct of_device * of_dev;
>  static struct thermostat* thermostat;
>  static struct task_struct *thread_therm = NULL;
>  
> -static int attach_one_thermostat(struct i2c_adapter *adapter, int addr,
> -				 int busno);
> -
>  static void write_both_fan_speed(struct thermostat *th, int speed);
>  static void write_fan_speed(struct thermostat *th, int speed, int fan);
>  
> @@ -100,7 +97,7 @@ write_reg(struct thermostat* th, int reg
>  	
>  	tmp[0] = reg;
>  	tmp[1] = data;
> -	rc = i2c_master_send(&th->clt, (const char *)tmp, 2);
> +	rc = i2c_master_send(th->clt, (const char *)tmp, 2);
>  	if (rc < 0)
>  		return rc;
>  	if (rc != 2)
> @@ -115,12 +112,12 @@ read_reg(struct thermostat* th, int reg)
>  	int rc;
>  
>  	reg_addr = (u8)reg;
> -	rc = i2c_master_send(&th->clt, &reg_addr, 1);
> +	rc = i2c_master_send(th->clt, &reg_addr, 1);
>  	if (rc < 0)
>  		return rc;
>  	if (rc != 1)
>  		return -ENODEV;
> -	rc = i2c_master_recv(&th->clt, (char *)&data, 1);
> +	rc = i2c_master_recv(th->clt, (char *)&data, 1);
>  	if (rc < 0)
>  		return rc;
>  	return data;
> @@ -130,26 +127,36 @@ static int
>  attach_thermostat(struct i2c_adapter *adapter)
>  {
>  	unsigned long bus_no;
> +	struct i2c_board_info info;
> +	struct i2c_client *client;
>  
>  	if (strncmp(adapter->name, "uni-n", 5))
>  		return -ENODEV;
>  	bus_no = simple_strtoul(adapter->name + 6, NULL, 10);
>  	if (bus_no != therm_bus)
>  		return -ENODEV;
> -	return attach_one_thermostat(adapter, therm_address, bus_no);
> +
> +	memset(&info, 0, sizeof(struct i2c_board_info));
> +	strlcpy(info.type, "therm_adt746x", I2C_NAME_SIZE);
> +	info.addr = therm_address;
> +	client = i2c_new_device(adapter, &info);
> +	if (!client)
> +		return -ENODEV;
> +
> +	/*
> +	 * Let i2c-core delete that device on driver removal.
> +	 * This is safe because i2c-core holds the core_lock mutex for us.
> +	 */
> +	list_add_tail(&client->detected, &client->driver->clients);
> +	return 0;
>  }
>  
>  static int
> -detach_thermostat(struct i2c_adapter *adapter)
> +remove_thermostat(struct i2c_client *client)
>  {
> -	struct thermostat* th;
> +	struct thermostat *th = i2c_get_clientdata(client);
>  	int i;
>  	
> -	if (thermostat == NULL)
> -		return 0;
> -
> -	th = thermostat;
> -
>  	if (thread_therm != NULL) {
>  		kthread_stop(thread_therm);
>  	}
> @@ -165,8 +172,6 @@ detach_thermostat(struct i2c_adapter *ad
>  
>  	write_both_fan_speed(th, -1);
>  
> -	i2c_detach_client(&th->clt);
> -
>  	thermostat = NULL;
>  
>  	kfree(th);
> @@ -174,14 +179,6 @@ detach_thermostat(struct i2c_adapter *ad
>  	return 0;
>  }
>  
> -static struct i2c_driver thermostat_driver = {  
> -	.driver = {
> -		.name	= "therm_adt746x",
> -	},
> -	.attach_adapter	= attach_thermostat,
> -	.detach_adapter	= detach_thermostat,
> -};
> -
>  static int read_fan_speed(struct thermostat *th, u8 addr)
>  {
>  	u8 tmp[2];
> @@ -369,8 +366,8 @@ static void set_limit(struct thermostat
>  		th->limits[i] = default_limits_local[i] + limit_adjust;
>  }
>  
> -static int attach_one_thermostat(struct i2c_adapter *adapter, int addr,
> -				 int busno)
> +static int probe_thermostat(struct i2c_client *client,
> +			    const struct i2c_device_id *id)
>  {
>  	struct thermostat* th;
>  	int rc;
> @@ -383,16 +380,12 @@ static int attach_one_thermostat(struct
>  	if (!th)
>  		return -ENOMEM;
>  
> -	th->clt.addr = addr;
> -	th->clt.adapter = adapter;
> -	th->clt.driver = &thermostat_driver;
> -	strcpy(th->clt.name, "thermostat");
> +	i2c_set_clientdata(client, th);
> +	th->clt = client;
>  
>  	rc = read_reg(th, 0);
>  	if (rc < 0) {
> -		printk(KERN_ERR "adt746x: Thermostat failed to read config "
> -				"from bus %d !\n",
> -				busno);
> +		dev_err(&client->dev, "Thermostat failed to read config!\n");
>  		kfree(th);
>  		return -ENODEV;
>  	}
> @@ -421,14 +414,6 @@ static int attach_one_thermostat(struct
>  
>  	thermostat = th;
>  
> -	if (i2c_attach_client(&th->clt)) {
> -		printk(KERN_INFO "adt746x: Thermostat failed to attach "
> -				 "client !\n");
> -		thermostat = NULL;
> -		kfree(th);
> -		return -ENODEV;
> -	}
> -
>  	/* be sure to really write fan speed the first time */
>  	th->last_speed[0] = -2;
>  	th->last_speed[1] = -2;
> @@ -454,6 +439,21 @@ static int attach_one_thermostat(struct
>  	return 0;
>  }
>  
> +static const struct i2c_device_id therm_adt746x_id[] = {
> +	{ "therm_adt746x", 0 },
> +	{ }
> +};
> +
> +static struct i2c_driver thermostat_driver = {
> +	.driver = {
> +		.name	= "therm_adt746x",
> +	},
> +	.attach_adapter	= attach_thermostat,
> +	.probe = probe_thermostat,
> +	.remove = remove_thermostat,
> +	.id_table = therm_adt746x_id,
> +};
> +
>  /* 
>   * Now, unfortunately, sysfs doesn't give us a nice void * we could
>   * pass around to the attribute functions, so we don't really have
> 


-- 
Jean Delvare
