Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BDFF7DE198
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 17:30:49 +1000 (EST)
Subject: Re: [PATCH] windfarm: Convert to a new-style i2c drivers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jean Delvare <khali@linux-fr.org>
In-Reply-To: <20090416185615.2f7914ca@hyperion.delvare>
References: <20090416185615.2f7914ca@hyperion.delvare>
Content-Type: text/plain
Date: Fri, 17 Apr 2009 09:30:39 +0200
Message-Id: <1239953439.7443.37.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-04-16 at 18:56 +0200, Jean Delvare wrote:
> The legacy i2c binding model is going away soon, so convert the
> macintosh windfarm drivers to the new model or they will break.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> ---
> Can someone please test this patch for me? I could only build-test it.

Thanks a lot for doing this. I'll be unable to test for a couple more
weeks as I'm on vacation and travelling though with a bit of luck,
Paulus will give it a go :-)

(Paul: windfarm_pm81 can be tested on the iMac G5 on my desk).

Cheers,
Ben.

> Remember that you need this patch applied:
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=935298696f469c0e07c73be687bd055878074ce0
> 
> Thanks.
> 
>  drivers/macintosh/windfarm_lm75_sensor.c    |  131 +++++++++++++++------------
>  drivers/macintosh/windfarm_max6690_sensor.c |  103 ++++++++++++---------
>  drivers/macintosh/windfarm_smu_sat.c        |  109 ++++++++++++----------
>  3 files changed, 198 insertions(+), 145 deletions(-)
> 
> --- linux-2.6.30-rc2.orig/drivers/macintosh/windfarm_lm75_sensor.c	2009-04-16 11:15:00.000000000 +0200
> +++ linux-2.6.30-rc2/drivers/macintosh/windfarm_lm75_sensor.c	2009-04-16 11:23:17.000000000 +0200
> @@ -37,34 +37,22 @@
>  struct wf_lm75_sensor {
>  	int			ds1775 : 1;
>  	int			inited : 1;
> -	struct 	i2c_client	i2c;
> +	struct 	i2c_client	*i2c;
>  	struct 	wf_sensor	sens;
>  };
>  #define wf_to_lm75(c) container_of(c, struct wf_lm75_sensor, sens)
> -#define i2c_to_lm75(c) container_of(c, struct wf_lm75_sensor, i2c)
> -
> -static int wf_lm75_attach(struct i2c_adapter *adapter);
> -static int wf_lm75_detach(struct i2c_client *client);
> -
> -static struct i2c_driver wf_lm75_driver = {
> -	.driver = {
> -		.name	= "wf_lm75",
> -	},
> -	.attach_adapter	= wf_lm75_attach,
> -	.detach_client	= wf_lm75_detach,
> -};
>  
>  static int wf_lm75_get(struct wf_sensor *sr, s32 *value)
>  {
>  	struct wf_lm75_sensor *lm = wf_to_lm75(sr);
>  	s32 data;
>  
> -	if (lm->i2c.adapter == NULL)
> +	if (lm->i2c == NULL)
>  		return -ENODEV;
>  
>  	/* Init chip if necessary */
>  	if (!lm->inited) {
> -		u8 cfg_new, cfg = (u8)i2c_smbus_read_byte_data(&lm->i2c, 1);
> +		u8 cfg_new, cfg = (u8)i2c_smbus_read_byte_data(lm->i2c, 1);
>  
>  		DBG("wf_lm75: Initializing %s, cfg was: %02x\n",
>  		    sr->name, cfg);
> @@ -73,7 +61,7 @@ static int wf_lm75_get(struct wf_sensor
>  		 * the firmware for now
>  		 */
>  		cfg_new = cfg & ~0x01;
> -		i2c_smbus_write_byte_data(&lm->i2c, 1, cfg_new);
> +		i2c_smbus_write_byte_data(lm->i2c, 1, cfg_new);
>  		lm->inited = 1;
>  
>  		/* If we just powered it up, let's wait 200 ms */
> @@ -81,7 +69,7 @@ static int wf_lm75_get(struct wf_sensor
>  	}
>  
>  	/* Read temperature register */
> -	data = (s32)le16_to_cpu(i2c_smbus_read_word_data(&lm->i2c, 0));
> +	data = (s32)le16_to_cpu(i2c_smbus_read_word_data(lm->i2c, 0));
>  	data <<= 8;
>  	*value = data;
>  
> @@ -92,12 +80,6 @@ static void wf_lm75_release(struct wf_se
>  {
>  	struct wf_lm75_sensor *lm = wf_to_lm75(sr);
>  
> -	/* check if client is registered and detach from i2c */
> -	if (lm->i2c.adapter) {
> -		i2c_detach_client(&lm->i2c);
> -		lm->i2c.adapter = NULL;
> -	}
> -
>  	kfree(lm);
>  }
>  
> @@ -107,59 +89,77 @@ static struct wf_sensor_ops wf_lm75_ops
>  	.owner		= THIS_MODULE,
>  };
>  
> -static struct wf_lm75_sensor *wf_lm75_create(struct i2c_adapter *adapter,
> -					     u8 addr, int ds1775,
> -					     const char *loc)
> +static int wf_lm75_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
>  {
>  	struct wf_lm75_sensor *lm;
>  	int rc;
>  
> -	DBG("wf_lm75: creating  %s device at address 0x%02x\n",
> -	    ds1775 ? "ds1775" : "lm75", addr);
> -
>  	lm = kzalloc(sizeof(struct wf_lm75_sensor), GFP_KERNEL);
>  	if (lm == NULL)
> -		return NULL;
> +		return -ENODEV;
> +
> +	lm->inited = 0;
> +	lm->ds1775 = id->driver_data;
> +	lm->i2c = client;
> +	lm->sens.name = client->dev.platform_data;
> +	lm->sens.ops = &wf_lm75_ops;
> +	i2c_set_clientdata(client, lm);
> +
> +	rc = wf_register_sensor(&lm->sens);
> +	if (rc) {
> +		i2c_set_clientdata(client, NULL);
> +		kfree(lm);
> +	}
> +
> +	return rc;
> +}
> +
> +static struct i2c_client *wf_lm75_create(struct i2c_adapter *adapter,
> +					     u8 addr, int ds1775,
> +					     const char *loc)
> +{
> +	struct i2c_board_info info;
> +	struct i2c_client *client;
> +	char *name;
> +
> +	DBG("wf_lm75: creating  %s device at address 0x%02x\n",
> +	    ds1775 ? "ds1775" : "lm75", addr);
>  
>  	/* Usual rant about sensor names not beeing very consistent in
>  	 * the device-tree, oh well ...
>  	 * Add more entries below as you deal with more setups
>  	 */
>  	if (!strcmp(loc, "Hard drive") || !strcmp(loc, "DRIVE BAY"))
> -		lm->sens.name = "hd-temp";
> +		name = "hd-temp";
>  	else if (!strcmp(loc, "Incoming Air Temp"))
> -		lm->sens.name = "incoming-air-temp";
> +		name = "incoming-air-temp";
>  	else if (!strcmp(loc, "ODD Temp"))
> -		lm->sens.name = "optical-drive-temp";
> +		name = "optical-drive-temp";
>  	else if (!strcmp(loc, "HD Temp"))
> -		lm->sens.name = "hard-drive-temp";
> +		name = "hard-drive-temp";
>  	else
>  		goto fail;
>  
> -	lm->inited = 0;
> -	lm->sens.ops = &wf_lm75_ops;
> -	lm->ds1775 = ds1775;
> -	lm->i2c.addr = (addr >> 1) & 0x7f;
> -	lm->i2c.adapter = adapter;
> -	lm->i2c.driver = &wf_lm75_driver;
> -	strncpy(lm->i2c.name, lm->sens.name, I2C_NAME_SIZE-1);
> -
> -	rc = i2c_attach_client(&lm->i2c);
> -	if (rc) {
> -		printk(KERN_ERR "windfarm: failed to attach %s %s to i2c,"
> -		       " err %d\n", ds1775 ? "ds1775" : "lm75",
> -		       lm->i2c.name, rc);
> -		goto fail;
> -	}
> -
> -	if (wf_register_sensor(&lm->sens)) {
> -		i2c_detach_client(&lm->i2c);
> +	memset(&info, 0, sizeof(struct i2c_board_info));
> +	info.addr = (addr >> 1) & 0x7f;
> +	info.platform_data = name;
> +	strlcpy(info.type, ds1775 ? "wf_ds1775" : "wf_lm75", I2C_NAME_SIZE);
> +
> +	client = i2c_new_device(adapter, &info);
> +	if (client == NULL) {
> +		printk(KERN_ERR "windfarm: failed to attach %s %s to i2c\n",
> +		       ds1775 ? "ds1775" : "lm75", name);
>  		goto fail;
>  	}
>  
> -	return lm;
> +	/*
> +	 * Let i2c-core delete that device on driver removal.
> +	 * This is safe because i2c-core holds the core_lock mutex for us.
> +	 */
> +	list_add_tail(&client->detected, &client->driver->clients);
> +	return client;
>   fail:
> -	kfree(lm);
>  	return NULL;
>  }
>  
> @@ -202,21 +202,38 @@ static int wf_lm75_attach(struct i2c_ada
>  	return 0;
>  }
>  
> -static int wf_lm75_detach(struct i2c_client *client)
> +static int wf_lm75_remove(struct i2c_client *client)
>  {
> -	struct wf_lm75_sensor *lm = i2c_to_lm75(client);
> +	struct wf_lm75_sensor *lm = i2c_get_clientdata(client);
>  
>  	DBG("wf_lm75: i2c detatch called for %s\n", lm->sens.name);
>  
>  	/* Mark client detached */
> -	lm->i2c.adapter = NULL;
> +	lm->i2c = NULL;
>  
>  	/* release sensor */
>  	wf_unregister_sensor(&lm->sens);
>  
> +	i2c_set_clientdata(client, NULL);
>  	return 0;
>  }
>  
> +static const struct i2c_device_id wf_lm75_id[] = {
> +	{ "wf_lm75", 0 },
> +	{ "wf_ds1775", 1 },
> +	{ }
> +};
> +
> +static struct i2c_driver wf_lm75_driver = {
> +	.driver = {
> +		.name	= "wf_lm75",
> +	},
> +	.attach_adapter	= wf_lm75_attach,
> +	.probe		= wf_lm75_probe,
> +	.remove		= wf_lm75_remove,
> +	.id_table	= wf_lm75_id,
> +};
> +
>  static int __init wf_lm75_sensor_init(void)
>  {
>  	/* Don't register on old machines that use therm_pm72 for now */
> --- linux-2.6.30-rc2.orig/drivers/macintosh/windfarm_max6690_sensor.c	2009-04-16 17:45:07.000000000 +0200
> +++ linux-2.6.30-rc2/drivers/macintosh/windfarm_max6690_sensor.c	2009-04-16 17:45:13.000000000 +0200
> @@ -26,34 +26,22 @@
>  #define MAX6690_EXTERNAL_TEMP	1
>  
>  struct wf_6690_sensor {
> -	struct i2c_client	i2c;
> +	struct i2c_client	*i2c;
>  	struct wf_sensor	sens;
>  };
>  
>  #define wf_to_6690(x)	container_of((x), struct wf_6690_sensor, sens)
> -#define i2c_to_6690(x)	container_of((x), struct wf_6690_sensor, i2c)
> -
> -static int wf_max6690_attach(struct i2c_adapter *adapter);
> -static int wf_max6690_detach(struct i2c_client *client);
> -
> -static struct i2c_driver wf_max6690_driver = {
> -	.driver = {
> -		.name		= "wf_max6690",
> -	},
> -	.attach_adapter	= wf_max6690_attach,
> -	.detach_client	= wf_max6690_detach,
> -};
>  
>  static int wf_max6690_get(struct wf_sensor *sr, s32 *value)
>  {
>  	struct wf_6690_sensor *max = wf_to_6690(sr);
>  	s32 data;
>  
> -	if (max->i2c.adapter == NULL)
> +	if (max->i2c == NULL)
>  		return -ENODEV;
>  
>  	/* chip gets initialized by firmware */
> -	data = i2c_smbus_read_byte_data(&max->i2c, MAX6690_EXTERNAL_TEMP);
> +	data = i2c_smbus_read_byte_data(max->i2c, MAX6690_EXTERNAL_TEMP);
>  	if (data < 0)
>  		return data;
>  	*value = data << 16;
> @@ -64,10 +52,6 @@ static void wf_max6690_release(struct wf
>  {
>  	struct wf_6690_sensor *max = wf_to_6690(sr);
>  
> -	if (max->i2c.adapter) {
> -		i2c_detach_client(&max->i2c);
> -		max->i2c.adapter = NULL;
> -	}
>  	kfree(max);
>  }
>  
> @@ -77,19 +61,40 @@ static struct wf_sensor_ops wf_max6690_o
>  	.owner		= THIS_MODULE,
>  };
>  
> -static void wf_max6690_create(struct i2c_adapter *adapter, u8 addr,
> -			      const char *loc)
> +static int wf_max6690_probe(struct i2c_client *client,
> +			    const struct i2c_device_id *id)
>  {
>  	struct wf_6690_sensor *max;
> -	char *name;
> +	int rc;
>  
>  	max = kzalloc(sizeof(struct wf_6690_sensor), GFP_KERNEL);
>  	if (max == NULL) {
> -		printk(KERN_ERR "windfarm: Couldn't create MAX6690 sensor %s: "
> -		       "no memory\n", loc);
> -		return;
> +		printk(KERN_ERR "windfarm: Couldn't create MAX6690 sensor: "
> +		       "no memory\n");
> +		return -ENOMEM;
> +	}
> +
> +	max->i2c = client;
> +	max->sens.name = client->dev.platform_data;
> +	max->sens.ops = &wf_max6690_ops;
> +	i2c_set_clientdata(client, max);
> +
> +	rc = wf_register_sensor(&max->sens);
> +	if (rc) {
> +		i2c_set_clientdata(client, NULL);
> +		kfree(max);
>  	}
>  
> +	return rc;
> +}
> +
> +static struct i2c_client *wf_max6690_create(struct i2c_adapter *adapter,
> +					    u8 addr, const char *loc)
> +{
> +	struct i2c_board_info info;
> +	struct i2c_client *client;
> +	char *name;
> +
>  	if (!strcmp(loc, "BACKSIDE"))
>  		name = "backside-temp";
>  	else if (!strcmp(loc, "NB Ambient"))
> @@ -99,27 +104,26 @@ static void wf_max6690_create(struct i2c
>  	else
>  		goto fail;
>  
> -	max->sens.ops = &wf_max6690_ops;
> -	max->sens.name = name;
> -	max->i2c.addr = addr >> 1;
> -	max->i2c.adapter = adapter;
> -	max->i2c.driver = &wf_max6690_driver;
> -	strncpy(max->i2c.name, name, I2C_NAME_SIZE-1);
> +	memset(&info, 0, sizeof(struct i2c_board_info));
> +	info.addr = addr >> 1;
> +	info.platform_data = name;
> +	strlcpy(info.type, "wf_max6690", I2C_NAME_SIZE);
>  
> -	if (i2c_attach_client(&max->i2c)) {
> +	client = i2c_new_device(adapter, &info);
> +	if (client == NULL) {
>  		printk(KERN_ERR "windfarm: failed to attach MAX6690 sensor\n");
>  		goto fail;
>  	}
>  
> -	if (wf_register_sensor(&max->sens)) {
> -		i2c_detach_client(&max->i2c);
> -		goto fail;
> -	}
> -
> -	return;
> +	/*
> +	 * Let i2c-core delete that device on driver removal.
> +	 * This is safe because i2c-core holds the core_lock mutex for us.
> +	 */
> +	list_add_tail(&client->detected, &client->driver->clients);
> +	return client;
>  
>   fail:
> -	kfree(max);
> +	return NULL;
>  }
>  
>  static int wf_max6690_attach(struct i2c_adapter *adapter)
> @@ -154,16 +158,31 @@ static int wf_max6690_attach(struct i2c_
>  	return 0;
>  }
>  
> -static int wf_max6690_detach(struct i2c_client *client)
> +static int wf_max6690_remove(struct i2c_client *client)
>  {
> -	struct wf_6690_sensor *max = i2c_to_6690(client);
> +	struct wf_6690_sensor *max = i2c_get_clientdata(client);
>  
> -	max->i2c.adapter = NULL;
> +	max->i2c = NULL;
>  	wf_unregister_sensor(&max->sens);
>  
>  	return 0;
>  }
>  
> +static const struct i2c_device_id wf_max6690_id[] = {
> +	{ "wf_max6690", 0 },
> +	{ }
> +};
> +
> +static struct i2c_driver wf_max6690_driver = {
> +	.driver = {
> +		.name		= "wf_max6690",
> +	},
> +	.attach_adapter	= wf_max6690_attach,
> +	.probe		= wf_max6690_probe,
> +	.remove		= wf_max6690_remove,
> +	.id_table	= wf_max6690_id,
> +};
> +
>  static int __init wf_max6690_sensor_init(void)
>  {
>  	/* Don't register on old machines that use therm_pm72 for now */
> --- linux-2.6.30-rc2.orig/drivers/macintosh/windfarm_smu_sat.c	2009-04-16 17:45:06.000000000 +0200
> +++ linux-2.6.30-rc2/drivers/macintosh/windfarm_smu_sat.c	2009-04-16 18:13:07.000000000 +0200
> @@ -39,7 +39,7 @@ struct wf_sat {
>  	struct mutex		mutex;
>  	unsigned long		last_read; /* jiffies when cache last updated */
>  	u8			cache[16];
> -	struct i2c_client	i2c;
> +	struct i2c_client	*i2c;
>  	struct device_node	*node;
>  };
>  
> @@ -54,18 +54,6 @@ struct wf_sat_sensor {
>  };
>  
>  #define wf_to_sat(c)	container_of(c, struct wf_sat_sensor, sens)
> -#define i2c_to_sat(c)	container_of(c, struct wf_sat, i2c)
> -
> -static int wf_sat_attach(struct i2c_adapter *adapter);
> -static int wf_sat_detach(struct i2c_client *client);
> -
> -static struct i2c_driver wf_sat_driver = {
> -	.driver = {
> -		.name		= "wf_smu_sat",
> -	},
> -	.attach_adapter	= wf_sat_attach,
> -	.detach_client	= wf_sat_detach,
> -};
>  
>  struct smu_sdbp_header *smu_sat_get_sdb_partition(unsigned int sat_id, int id,
>  						  unsigned int *size)
> @@ -81,13 +69,13 @@ struct smu_sdbp_header *smu_sat_get_sdb_
>  	if (sat_id > 1 || (sat = sats[sat_id]) == NULL)
>  		return NULL;
>  
> -	err = i2c_smbus_write_word_data(&sat->i2c, 8, id << 8);
> +	err = i2c_smbus_write_word_data(sat->i2c, 8, id << 8);
>  	if (err) {
>  		printk(KERN_ERR "smu_sat_get_sdb_part wr error %d\n", err);
>  		return NULL;
>  	}
>  
> -	err = i2c_smbus_read_word_data(&sat->i2c, 9);
> +	err = i2c_smbus_read_word_data(sat->i2c, 9);
>  	if (err < 0) {
>  		printk(KERN_ERR "smu_sat_get_sdb_part rd len error\n");
>  		return NULL;
> @@ -105,7 +93,7 @@ struct smu_sdbp_header *smu_sat_get_sdb_
>  		return NULL;
>  
>  	for (i = 0; i < len; i += 4) {
> -		err = i2c_smbus_read_i2c_block_data(&sat->i2c, 0xa, 4, data);
> +		err = i2c_smbus_read_i2c_block_data(sat->i2c, 0xa, 4, data);
>  		if (err < 0) {
>  			printk(KERN_ERR "smu_sat_get_sdb_part rd err %d\n",
>  			       err);
> @@ -138,7 +126,7 @@ static int wf_sat_read_cache(struct wf_s
>  {
>  	int err;
>  
> -	err = i2c_smbus_read_i2c_block_data(&sat->i2c, 0x3f, 16, sat->cache);
> +	err = i2c_smbus_read_i2c_block_data(sat->i2c, 0x3f, 16, sat->cache);
>  	if (err < 0)
>  		return err;
>  	sat->last_read = jiffies;
> @@ -161,7 +149,7 @@ static int wf_sat_get(struct wf_sensor *
>  	int i, err;
>  	s32 val;
>  
> -	if (sat->i2c.adapter == NULL)
> +	if (sat->i2c == NULL)
>  		return -ENODEV;
>  
>  	mutex_lock(&sat->mutex);
> @@ -193,10 +181,6 @@ static void wf_sat_release(struct wf_sen
>  	struct wf_sat *sat = sens->sat;
>  
>  	if (atomic_dec_and_test(&sat->refcnt)) {
> -		if (sat->i2c.adapter) {
> -			i2c_detach_client(&sat->i2c);
> -			sat->i2c.adapter = NULL;
> -		}
>  		if (sat->nr >= 0)
>  			sats[sat->nr] = NULL;
>  		kfree(sat);
> @@ -212,38 +196,58 @@ static struct wf_sensor_ops wf_sat_ops =
>  
>  static void wf_sat_create(struct i2c_adapter *adapter, struct device_node *dev)
>  {
> +	struct i2c_board_info info;
> +	struct i2c_client *client;
> +	const u32 *reg;
> +	u8 addr;
> +
> +	reg = of_get_property(dev, "reg", NULL);
> +	if (reg == NULL)
> +		return;
> +	addr = *reg;
> +	DBG(KERN_DEBUG "wf_sat: creating sat at address %x\n", addr);
> +
> +	memset(&info, 0, sizeof(struct i2c_board_info));
> +	info.addr = (addr >> 1) & 0x7f;
> +	info.platform_data = dev;
> +	strlcpy(info.type, "wf_sat", I2C_NAME_SIZE);
> +
> +	client = i2c_new_device(adapter, &info);
> +	if (client == NULL) {
> +		printk(KERN_ERR "windfarm: failed to attach smu-sat to i2c\n");
> +		return;
> +	}
> +
> +	/*
> +	 * Let i2c-core delete that device on driver removal.
> +	 * This is safe because i2c-core holds the core_lock mutex for us.
> +	 */
> +	list_add_tail(&client->detected, &client->driver->clients);
> +}
> +
> +static int wf_sat_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	struct device_node *dev = client->dev.platform_data;
>  	struct wf_sat *sat;
>  	struct wf_sat_sensor *sens;
>  	const u32 *reg;
>  	const char *loc, *type;
> -	u8 addr, chip, core;
> +	u8 chip, core;
>  	struct device_node *child;
>  	int shift, cpu, index;
>  	char *name;
>  	int vsens[2], isens[2];
>  
> -	reg = of_get_property(dev, "reg", NULL);
> -	if (reg == NULL)
> -		return;
> -	addr = *reg;
> -	DBG(KERN_DEBUG "wf_sat: creating sat at address %x\n", addr);
> -
>  	sat = kzalloc(sizeof(struct wf_sat), GFP_KERNEL);
>  	if (sat == NULL)
> -		return;
> +		return -ENOMEM;
>  	sat->nr = -1;
>  	sat->node = of_node_get(dev);
>  	atomic_set(&sat->refcnt, 0);
>  	mutex_init(&sat->mutex);
> -	sat->i2c.addr = (addr >> 1) & 0x7f;
> -	sat->i2c.adapter = adapter;
> -	sat->i2c.driver = &wf_sat_driver;
> -	strncpy(sat->i2c.name, "smu-sat", I2C_NAME_SIZE-1);
> -
> -	if (i2c_attach_client(&sat->i2c)) {
> -		printk(KERN_ERR "windfarm: failed to attach smu-sat to i2c\n");
> -		goto fail;
> -	}
> +	sat->i2c = client;
> +	i2c_set_clientdata(client, sat);
>  
>  	vsens[0] = vsens[1] = -1;
>  	isens[0] = isens[1] = -1;
> @@ -344,10 +348,7 @@ static void wf_sat_create(struct i2c_ada
>  	if (sat->nr >= 0)
>  		sats[sat->nr] = sat;
>  
> -	return;
> -
> - fail:
> -	kfree(sat);
> +	return 0;
>  }
>  
>  static int wf_sat_attach(struct i2c_adapter *adapter)
> @@ -366,16 +367,32 @@ static int wf_sat_attach(struct i2c_adap
>  	return 0;
>  }
>  
> -static int wf_sat_detach(struct i2c_client *client)
> +static int wf_sat_remove(struct i2c_client *client)
>  {
> -	struct wf_sat *sat = i2c_to_sat(client);
> +	struct wf_sat *sat = i2c_get_clientdata(client);
>  
>  	/* XXX TODO */
>  
> -	sat->i2c.adapter = NULL;
> +	sat->i2c = NULL;
> +	i2c_set_clientdata(client, NULL);
>  	return 0;
>  }
>  
> +static const struct i2c_device_id wf_sat_id[] = {
> +	{ "wf_sat", 0 },
> +	{ }
> +};
> +
> +static struct i2c_driver wf_sat_driver = {
> +	.driver = {
> +		.name		= "wf_smu_sat",
> +	},
> +	.attach_adapter	= wf_sat_attach,
> +	.probe		= wf_sat_probe,
> +	.remove		= wf_sat_remove,
> +	.id_table	= wf_sat_id,
> +};
> +
>  static int __init sat_sensors_init(void)
>  {
>  	return i2c_add_driver(&wf_sat_driver);
> 
> 
