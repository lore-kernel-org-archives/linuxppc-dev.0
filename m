Return-Path: <randy.dunlap@oracle.com>
Received: from agminet01.oracle.com (agminet01.oracle.com [141.146.126.228])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B3D7BDDEC1
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Dec 2007 11:42:14 +1100 (EST)
Date: Tue, 11 Dec 2007 16:40:39 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] Introduce driver_create/remove_dir
Message-Id: <20071211164039.013f4393.randy.dunlap@oracle.com>
In-Reply-To: <20071212105633.725496cb.sfr@canb.auug.org.au>
References: <20071205093054.GA23229@kroah.com>
	<1196853031.6759.7.camel@concordia>
	<20071205214103.GA7074@kroah.com>
	<1196912898.14754.13.camel@concordia>
	<20071212105633.725496cb.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	David Gibson <dwg@au1.ibm.com>, linuxppc-dev@ozlabs.org,
	"Kyle A. Lucke" <klucke@us.ibm.com>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 12 Dec 2007 10:56:33 +1100 Stephen Rothwell wrote:

> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/base/driver.c      |   24 ++++++++++++++++++++++++
>  drivers/net/iseries_veth.c |   15 +++++++--------
>  include/linux/device.h     |    3 +++
>  3 files changed, 34 insertions(+), 8 deletions(-)
> 
> 
> diff --git a/drivers/base/driver.c b/drivers/base/driver.c
> index eb11475..6527a91 100644
> --- a/drivers/base/driver.c
> +++ b/drivers/base/driver.c
> @@ -91,6 +91,30 @@ struct device * driver_find_device(struct device_driver *drv,
>  EXPORT_SYMBOL_GPL(driver_find_device);
>  
>  /**
> + *	driver_create_dir - create a subdirectory for a driver.
> + *	@drv:	driver.
> + *	@kobj:	the kobject we are creating the directory for.
> + */
> +int __must_check driver_create_dir(struct device_driver *drv,
> +			struct kobject *kobj)
> +{
> +	kobj->parent = &drv->kobj;
> +	return kobject_add(kobj);
> +}
> +EXPORT_SYMBOL_GPL(driver_create_dir);
> +
> +/**
> + *	driver_remove_dir - remove a subdirectory for a driver.
> + *	@drv:	driver.
> + *	@attr:	driver attribute descriptor.

Second arg below is @kobj.


> + */
> +void driver_remove_dir(struct device_driver *drv, struct kobject *kobj)
> +{
> +	kobject_del(kobj);
> +}
> +EXPORT_SYMBOL_GPL(driver_remove_dir);
> +
> +/**
>   *	driver_create_file - create sysfs file for driver.
>   *	@drv:	driver.
>   *	@attr:	driver attribute descriptor.


---
~Randy
