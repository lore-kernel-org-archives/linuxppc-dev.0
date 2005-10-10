Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9946F684C5
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Oct 2005 08:21:04 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
In-Reply-To: <20051010200739.GA14317@suse.de>
References: <20051010200739.GA14317@suse.de>
Content-Type: text/plain
Date: Tue, 11 Oct 2005 08:17:40 +1000
Message-Id: <1128982661.17365.170.camel@gaston>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Add modalias to macio sysfs attributes
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-10-10 at 22:07 +0200, Olaf Hering wrote:
> Provide a "compatible" entry in /sys/bus/macio/devices/*/
> This can be used to load drivers via the modules.alias file.
> 
> Author: <schab@suse.de>
> Signed-off-by: Olaf Hering <olh@suse.de>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> --- linux-2.6.13-rc7/drivers/macintosh/macio_sysfs.c.~1~	2005-08-26 16:32:13.000000000 +0200
> +++ linux-2.6.13-rc7/drivers/macintosh/macio_sysfs.c	2005-08-27 11:58:47.000000000 +0200
> @@ -39,6 +39,31 @@ compatible_show (struct device *dev, str
>  	return length;
>  }
>  
> +static ssize_t modalias_show (struct device *dev, struct device_attribute *attr,
> +			      char *buf)
> +{
> +	struct of_device *of;
> +	char *compat;
> +	int cplen;
> +	int length;
> +
> +	of = &to_macio_device (dev)->ofdev;
> +	compat = (char *) get_property (of->node, "compatible", &cplen);
> +	if (!compat) compat = "", cplen = 1;
> +	length = sprintf (buf, "of:N%sT%s", of->node->name, of->node->type);
> +	buf += length;
> +	while (cplen > 0) {
> +		int l;
> +		length += sprintf (buf, "C%s", compat);
> +		buf += length;
> +		l = strlen (compat) + 1;
> +		compat += l;
> +		cplen -= l;
> +	}
> +
> +	return length;
> +}
> +
>  macio_config_of_attr (name, "%s\n");
>  macio_config_of_attr (type, "%s\n");
>  
> @@ -46,5 +71,6 @@ struct device_attribute macio_dev_attrs[
>  	__ATTR_RO(name),
>  	__ATTR_RO(type),
>  	__ATTR_RO(compatible),
> +	__ATTR_RO(modalias),
>  	__ATTR_NULL
>  };
