Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5233F1A02A5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Nov 2014 01:22:17 +1100 (AEDT)
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
 (envelope-from <linux@roeck-us.net>) id 1Xm1TO-001PwG-7A
 for linuxppc-dev@lists.ozlabs.org; Wed, 05 Nov 2014 14:22:10 +0000
Date: Wed, 5 Nov 2014 06:21:49 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] hwmon: (ibmpowernv) Use platform 'id_table' to probe
 the device
Message-ID: <20141105142149.GA23212@roeck-us.net>
References: <20141105110848.6183.55611.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141105110848.6183.55611.stgit@localhost.localdomain>
Cc: benh@au1.ibm.com, michaele@au1.ibm.com, linux-kernel@vger.kernel.org,
 lm-sensors@lm-sensors.org, linuxppc-dev@lists.ozlabs.org, jdelvare@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 05, 2014 at 04:45:14PM +0530, Neelesh Gupta wrote:
> The current driver probe() function assumes the sensor device to be
> alwary present and gets executed every time if the driver is loaded,
> but the appropriate hardware could not be present.
> 
> So, move the platform device creation as part of platform init code
> and use the 'id_table' to check if the device present or not.
> 
> Signed-off-by: Neelesh Gupta <neelegup@linux.vnet.ibm.com>

Looks good. We'll need an ack from one of the powerpc maintainers to proceed.

Guenter

> ---
> 
> Changes in v2
> =============
> - Improve readability in error case if 'sensors' not found, also log
>   the using 'pr_err'.
> 
>  arch/powerpc/platforms/powernv/opal-sensor.c |   20 ++++++++
>  drivers/hwmon/ibmpowernv.c                   |   67 +++++++-------------------
>  2 files changed, 39 insertions(+), 48 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/opal-sensor.c b/arch/powerpc/platforms/powernv/opal-sensor.c
> index 10271ad..4ab67ef 100644
> --- a/arch/powerpc/platforms/powernv/opal-sensor.c
> +++ b/arch/powerpc/platforms/powernv/opal-sensor.c
> @@ -20,7 +20,9 @@
>  
>  #include <linux/delay.h>
>  #include <linux/mutex.h>
> +#include <linux/of_platform.h>
>  #include <asm/opal.h>
> +#include <asm/machdep.h>
>  
>  static DEFINE_MUTEX(opal_sensor_mutex);
>  
> @@ -64,3 +66,21 @@ out:
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(opal_get_sensor_data);
> +
> +static __init int opal_sensor_init(void)
> +{
> +	struct platform_device *pdev;
> +	struct device_node *sensor;
> +
> +	sensor = of_find_node_by_path("/ibm,opal/sensors");
> +	if (!sensor) {
> +		pr_err("Opal node 'sensors' not found\n");
> +		return -ENODEV;
> +	}
> +
> +	pdev = of_platform_device_create(sensor, "opal-sensor", NULL);
> +	of_node_put(sensor);
> +
> +	return PTR_ERR_OR_ZERO(pdev);
> +}
> +machine_subsys_initcall(powernv, opal_sensor_init);
> diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
> index 6a30eee..c7577b8 100644
> --- a/drivers/hwmon/ibmpowernv.c
> +++ b/drivers/hwmon/ibmpowernv.c
> @@ -74,9 +74,6 @@ struct platform_data {
>  	u32 sensors_count; /* Total count of sensors from each group */
>  };
>  
> -/* Platform device representing all the ibmpowernv sensors */
> -static struct platform_device *pdevice;
> -
>  static ssize_t show_sensor(struct device *dev, struct device_attribute *devattr,
>  			   char *buf)
>  {
> @@ -99,7 +96,7 @@ static ssize_t show_sensor(struct device *dev, struct device_attribute *devattr,
>  	return sprintf(buf, "%u\n", x);
>  }
>  
> -static int __init get_sensor_index_attr(const char *name, u32 *index,
> +static int get_sensor_index_attr(const char *name, u32 *index,
>  					char *attr)
>  {
>  	char *hash_pos = strchr(name, '#');
> @@ -136,7 +133,7 @@ static int __init get_sensor_index_attr(const char *name, u32 *index,
>   * which need to be mapped as fan2_input, temp1_max respectively before
>   * populating them inside hwmon device class.
>   */
> -static int __init create_hwmon_attr_name(struct device *dev, enum sensors type,
> +static int create_hwmon_attr_name(struct device *dev, enum sensors type,
>  					 const char *node_name,
>  					 char *hwmon_attr_name)
>  {
> @@ -172,7 +169,7 @@ static int __init create_hwmon_attr_name(struct device *dev, enum sensors type,
>  	return 0;
>  }
>  
> -static int __init populate_attr_groups(struct platform_device *pdev)
> +static int populate_attr_groups(struct platform_device *pdev)
>  {
>  	struct platform_data *pdata = platform_get_drvdata(pdev);
>  	const struct attribute_group **pgroups = pdata->attr_groups;
> @@ -180,11 +177,6 @@ static int __init populate_attr_groups(struct platform_device *pdev)
>  	enum sensors type;
>  
>  	opal = of_find_node_by_path("/ibm,opal/sensors");
> -	if (!opal) {
> -		dev_dbg(&pdev->dev, "Opal node 'sensors' not found\n");
> -		return -ENODEV;
> -	}
> -
>  	for_each_child_of_node(opal, np) {
>  		if (np->name == NULL)
>  			continue;
> @@ -221,7 +213,7 @@ static int __init populate_attr_groups(struct platform_device *pdev)
>   * to the name required by the higher 'hwmon' driver like fan1_input, temp1_max
>   * etc..
>   */
> -static int __init create_device_attrs(struct platform_device *pdev)
> +static int create_device_attrs(struct platform_device *pdev)
>  {
>  	struct platform_data *pdata = platform_get_drvdata(pdev);
>  	const struct attribute_group **pgroups = pdata->attr_groups;
> @@ -280,7 +272,7 @@ exit_put_node:
>  	return err;
>  }
>  
> -static int __init ibmpowernv_probe(struct platform_device *pdev)
> +static int ibmpowernv_probe(struct platform_device *pdev)
>  {
>  	struct platform_data *pdata;
>  	struct device *hwmon_dev;
> @@ -309,52 +301,31 @@ static int __init ibmpowernv_probe(struct platform_device *pdev)
>  	return PTR_ERR_OR_ZERO(hwmon_dev);
>  }
>  
> +static const struct platform_device_id opal_sensor_driver_ids[] = {
> +	{
> +		.name = "opal-sensor",
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(platform, opal_sensor_driver_ids);
> +
>  static struct platform_driver ibmpowernv_driver = {
> -	.driver = {
> -		.owner = THIS_MODULE,
> -		.name = DRVNAME,
> +	.probe		= ibmpowernv_probe,
> +	.id_table	= opal_sensor_driver_ids,
> +	.driver		= {
> +		.owner	= THIS_MODULE,
> +		.name	= DRVNAME,
>  	},
>  };
>  
>  static int __init ibmpowernv_init(void)
>  {
> -	int err;
> -
> -	pdevice = platform_device_alloc(DRVNAME, 0);
> -	if (!pdevice) {
> -		pr_err("Device allocation failed\n");
> -		err = -ENOMEM;
> -		goto exit;
> -	}
> -
> -	err = platform_device_add(pdevice);
> -	if (err) {
> -		pr_err("Device addition failed (%d)\n", err);
> -		goto exit_device_put;
> -	}
> -
> -	err = platform_driver_probe(&ibmpowernv_driver, ibmpowernv_probe);
> -	if (err) {
> -		if (err != -ENODEV)
> -			pr_err("Platform driver probe failed (%d)\n", err);
> -
> -		goto exit_device_del;
> -	}
> -
> -	return 0;
> -
> -exit_device_del:
> -	platform_device_del(pdevice);
> -exit_device_put:
> -	platform_device_put(pdevice);
> -exit:
> -	return err;
> +	return platform_driver_register(&ibmpowernv_driver);
>  }
>  
>  static void __exit ibmpowernv_exit(void)
>  {
>  	platform_driver_unregister(&ibmpowernv_driver);
> -	platform_device_unregister(pdevice);
>  }
>  
>  MODULE_AUTHOR("Neelesh Gupta <neelegup@linux.vnet.ibm.com>");
> 
