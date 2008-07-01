Return-Path: <khali@linux-fr.org>
Date: Tue, 1 Jul 2008 17:05:44 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH 2/2] Add the of_find_i2c_device_by_node function, V4
Message-ID: <20080701170544.72051418@hyperion.delvare>
In-Reply-To: <20080630230128.12482.79570.stgit@terra>
References: <20080630230126.12482.87927.stgit@terra>
	<20080630230128.12482.79570.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Jon,

On Mon, 30 Jun 2008 19:01:28 -0400, Jon Smirl wrote:
> Add the of_find_i2c_device_by_node function. This allows you to
> follow a reference in the device to an i2c device node and then
> locate the linux device instantiated by the device tree. Example
> use, an i2s codec controlled by i2c.
> ---
> 
>  drivers/i2c/i2c-core.c |    2 +-
>  drivers/of/of_i2c.c    |   37 ++++++++++++++++++++++++++-----------
>  include/linux/i2c.h    |    3 +++
>  include/linux/of_i2c.h |    2 ++
>  4 files changed, 32 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index d0175f4..e3abe1b 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -208,7 +208,7 @@ static struct device_attribute i2c_dev_attrs[] = {
>  	{ },
>  };
>  
> -static struct bus_type i2c_bus_type = {
> +struct bus_type i2c_bus_type = {
>  	.name		= "i2c",
>  	.dev_attrs	= i2c_dev_attrs,
>  	.match		= i2c_device_match,

What if i2c-core is built as a module? Don't you need to export the
symbol then?

> diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
> index 715a444..ca69a16 100644
> --- a/drivers/of/of_i2c.c
> +++ b/drivers/of/of_i2c.c
> @@ -75,7 +75,7 @@ static int of_find_i2c_driver(struct device_node *node,
>  void of_register_i2c_devices(struct i2c_adapter *adap,
>  			     struct device_node *adap_node)
>  {
> -	void *result;
> +	struct i2c_client *i2c_dev;
>  	struct device_node *node;
>  
>  	for_each_child_of_node(adap_node, node) {
> @@ -90,29 +90,44 @@ void of_register_i2c_devices(struct i2c_adapter *adap,
>  			continue;
>  		}
>  
> -		info.irq = irq_of_parse_and_map(node, 0);
> -		if (info.irq == NO_IRQ)
> -			info.irq = -1;
> -
> -		if (of_find_i2c_driver(node, &info) < 0) {
> -			irq_dispose_mapping(info.irq);
> +		if (of_find_i2c_driver(node, &info) < 0)
>  			continue;
> -		}
>  
> +		info.irq = irq_of_parse_and_map(node, 0);
>  		info.addr = *addr;
>  
> -		request_module(info.type);
> +		request_module("%s", info.type);

A separate fix for this issue was already sent by Maximilian Attems a
few days go:
http://lists.lm-sensors.org/pipermail/i2c/2008-June/004030.html

>  
> -		result = i2c_new_device(adap, &info);
> -		if (result == NULL) {
> +		i2c_dev = i2c_new_device(adap, &info);
> +		if (i2c_dev == NULL) {
>  			printk(KERN_ERR
>  			       "of-i2c: Failed to load driver for %s\n",
>  			       info.type);
>  			irq_dispose_mapping(info.irq);
>  			continue;
>  		}
> +		
> +		i2c_dev->dev.archdata.of_node = of_node_get(node);
>  	}
>  }
>  EXPORT_SYMBOL(of_register_i2c_devices);
>  
> +static int of_dev_node_match(struct device *dev, void *data)
> +{
> +        return dev->archdata.of_node == data;
> +}
> +
> +struct i2c_client *of_find_i2c_device_by_node(struct device_node *node)
> +{
> +	struct device *dev;
> +	
> +	dev = bus_find_device(&i2c_bus_type, NULL, node, 
> +					 of_dev_node_match);
> +	if (!dev)
> +		return NULL;
> +		
> +	return to_i2c_client(dev);
> +}
> +EXPORT_SYMBOL(of_find_i2c_device_by_node);
> +
>  MODULE_LICENSE("GPL");
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index fb9af6a..186b22d 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -92,6 +92,9 @@ extern s32 i2c_smbus_read_i2c_block_data(struct i2c_client * client,
>  extern s32 i2c_smbus_write_i2c_block_data(struct i2c_client * client,
>  					  u8 command, u8 length,
>  					  const u8 *values);
> +					  
> +/* Base of the i2c bus */
> +extern struct bus_type i2c_bus_type; 
>  
>  /*
>   * A driver is capable of handling one or more physical devices present on
> diff --git a/include/linux/of_i2c.h b/include/linux/of_i2c.h
> index bd2a870..17d5897 100644
> --- a/include/linux/of_i2c.h
> +++ b/include/linux/of_i2c.h
> @@ -16,5 +16,7 @@
>  
>  void of_register_i2c_devices(struct i2c_adapter *adap,
>  			     struct device_node *adap_node);
> +struct i2c_client *of_find_i2c_device_by_node(struct device_node *node);
> +			     
>  
>  #endif /* __LINUX_OF_I2C_H */

I'm fine with this patch. In particular, exporting i2c_bus_type is OK.
It was un-exported only because it had no user left, but it can be
exported again if needed.

I'm not the one to push this upstream though, as the patch is
essentially an openfirmware patch. That would be something for Jochen
Friedrich and Paul Mackerras I guess. Would be nice to have a
MAINTAINERS entry for OF...

-- 
Jean Delvare
