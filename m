Return-Path: <tnt@246tNt.com>
Received: from outmx036.isp.belgacom.be (outmx036.isp.belgacom.be
	[195.238.6.173])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 824F7DDE18
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2007 03:05:27 +1000 (EST)
Received: from outmx036.isp.belgacom.be (localhost.localdomain [127.0.0.1])
	by outmx036.isp.belgacom.be (8.13.4/8.13.4/Debian-3sarge3) with ESMTP
	id l32H5JSU019685
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Apr 2007 19:05:21 +0200
Message-ID: <461137B8.9000404@246tNt.com>
Date: Mon, 02 Apr 2007 19:04:56 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH] add modalias file for of_devices to sysfs
References: <20070402124547.GA11415@aepfle.de>
In-Reply-To: <20070402124547.GA11415@aepfle.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Paul Mackeras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In my patch to "unify" the uevent generation, I've made a separate
function that generate
the modalias string especially so that we don't repeat the same piece of
code twice.

It's prototype is :

+static ssize_t of_device_get_modalias(struct of_device *ofdev,
+					char *str, ssize_t len)

So the modalias_show can be shortened to

return of_device_get_modalias(to_of_device(dev), buf, PAGE_SIZE);


Of course that depends on Paulus merging my patches ...

    Sylvain


Olaf Hering wrote:
> modalias files are supposed to be there for every node.
> They allow module autoloading, and it is possible to match required kernel modules.
> Tested on Efika:
>
> 	==> /sys/devices/f0000000.builtin/f0003a00.ata/devspec <==
> 	/builtin@F0000000/ata@F0003A00
>
> 	==> /sys/devices/f0000000.builtin/f0003a00.ata/modalias <==
> 	of:NataTataCmpc5200b-ataCmpc5200-ata
>
> Also add a newline to the 'devspec' file output.
>
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
>
> ---
>  arch/powerpc/kernel/of_device.c   |   47 ++++++++++++++++++++++++++++----------
>  arch/powerpc/kernel/of_platform.c |    3 ++
>  2 files changed, 38 insertions(+), 12 deletions(-)
>
> Index: b/arch/powerpc/kernel/of_device.c
> ===================================================================
> --- a/arch/powerpc/kernel/of_device.c
> +++ b/arch/powerpc/kernel/of_device.c
> @@ -72,16 +72,47 @@ void of_dev_put(struct of_device *dev)
>  		put_device(&dev->dev);
>  }
>  
> -static ssize_t dev_show_devspec(struct device *dev,
> +static ssize_t devspec_show(struct device *dev,
>  				struct device_attribute *attr, char *buf)
>  {
>  	struct of_device *ofdev;
>  
>  	ofdev = to_of_device(dev);
> -	return sprintf(buf, "%s", ofdev->node->full_name);
> +	return sprintf(buf, "%s\n", ofdev->node->full_name);
>  }
>  
> -static DEVICE_ATTR(devspec, S_IRUGO, dev_show_devspec, NULL);
> +static ssize_t modalias_show (struct device *dev, struct device_attribute *attr,
> +			      char *buf)
> +{
> +	struct of_device *ofdev;
> +	const char *compat;
> +	int cplen;
> +	int length;
> +
> +	ofdev = to_of_device(dev);
> +	compat = get_property(ofdev->node, "compatible", &cplen);
> +	if (!compat) compat = "", cplen = 1;
> +	length = sprintf (buf, "of:N%sT%s", ofdev->node->name, ofdev->node->type);
> +	buf += length;
> +	while (cplen > 0) {
> +		int l;
> +		l = sprintf (buf, "C%s", compat);
> +		length += l;
> +		buf += l;
> +		l = strlen (compat) + 1;
> +		compat += l;
> +		cplen -= l;
> +	}
> +	length += sprintf (buf, "\n");
> +
> +	return length;
> +}
> +
> +struct device_attribute of_platform_device_attrs[] = {
> +	__ATTR_RO(devspec),
> +	__ATTR_RO(modalias),
> +	__ATTR_NULL
> +};
>  
>  /**
>   * of_release_dev - free an of device structure when all users of it are finished.
> @@ -101,21 +132,13 @@ void of_release_dev(struct device *dev)
>  
>  int of_device_register(struct of_device *ofdev)
>  {
> -	int rc;
> -
>  	BUG_ON(ofdev->node == NULL);
>  
> -	rc = device_register(&ofdev->dev);
> -	if (rc)
> -		return rc;
> -
> -	return device_create_file(&ofdev->dev, &dev_attr_devspec);
> +	return device_register(&ofdev->dev);
>  }
>  
>  void of_device_unregister(struct of_device *ofdev)
>  {
> -	device_remove_file(&ofdev->dev, &dev_attr_devspec);
> -
>  	device_unregister(&ofdev->dev);
>  }
>  
> Index: b/arch/powerpc/kernel/of_platform.c
> ===================================================================
> --- a/arch/powerpc/kernel/of_platform.c
> +++ b/arch/powerpc/kernel/of_platform.c
> @@ -130,6 +130,8 @@ static int of_platform_device_resume(str
>  	return error;
>  }
>  
> +extern struct device_attribute of_platform_device_attrs[];
> +
>  struct bus_type of_platform_bus_type = {
>         .name	= "of_platform",
>         .match	= of_platform_bus_match,
> @@ -137,6 +139,7 @@ struct bus_type of_platform_bus_type = {
>         .remove	= of_platform_device_remove,
>         .suspend	= of_platform_device_suspend,
>         .resume	= of_platform_device_resume,
> +       .dev_attrs = of_platform_device_attrs,
>  };
>  EXPORT_SYMBOL(of_platform_bus_type);
>  
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
>   
