Return-Path: <a.hajda@samsung.com>
Received: from mailout4.w1.samsung.com (mailout4.w1.samsung.com
 [210.118.77.14]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EA31C1A0001
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 21:46:31 +1100 (AEDT)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NF800A1TDL7EW60@mailout4.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Tue, 18 Nov 2014 10:39:07 +0000 (GMT)
Message-id: <546B2123.7060406@samsung.com>
Date: Tue, 18 Nov 2014 11:36:19 +0100
From: Andrzej Hajda <a.hajda@samsung.com>
MIME-version: 1.0
To: Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] of/platform: Move platform devices under
 /sys/devices/platform
References: <1415097920-30014-1-git-send-email-grant.likely@linaro.org>
In-reply-to: <1415097920-30014-1-git-send-email-grant.likely@linaro.org>
Content-type: text/plain; charset=windows-1252
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/04/2014 11:45 AM, Grant Likely wrote:
> Currently the devices created by drivers/of/platform.c get created at
> the root of /sys/devices. This goes against the typical pattern for
> sysfs where the top level /sys/devices structure contains categories of
> devices, and the structure of devices is placed below that. To fix this,
> make the code in drivers/of/platform.c follow the drivers/base/platform.c
> behaviour, and use &platform_bus as the default parent for all new
> platform_devices and amba_devices.
> 
> This change has been discussed for a long time, but nobody has actually
> acted on it. Userspace code that expects to find devices under a fixed
> /sys/devices/... path will be affected. It isn't /supposed/ to do that,
> but if anyone complains then I'll add a default-off workaround option to
> put them back into the root.

One of side effects of this change is that platform drivers registering
other platform drivers or devices in their probe callback can deadlock
due to double device_lock on platform device. This is for example case
of exynos_drm driver[1]. I guess it could/should be fixed in exynos_drm.
Anyway it can affect other drivers as well. At least grep shows few
possible candidates:

$ git grep -p platform_driver_register | grep -A1 -P '_probe\(struct
platform_device'

drivers/gpu/drm/exynos/exynos_drm_drv.c=static int
exynos_drm_platform_probe(struct platform_device *pdev)
drivers/gpu/drm/exynos/exynos_drm_drv.c:	ret =
platform_driver_register(&fimd_driver);
--
drivers/gpu/drm/sti/sti_drm_drv.c=static int
sti_drm_platform_probe(struct platform_device *pdev)
drivers/gpu/drm/sti/sti_drm_drv.c:
platform_driver_register(&sti_drm_master_driver);
--
drivers/mtd/nand/atmel_nand.c=static int atmel_nand_probe(struct
platform_device *pdev)
drivers/mtd/nand/atmel_nand.c:	res =
platform_driver_register(&atmel_nand_nfc_driver);


[1]: http://permalink.gmane.org/gmane.comp.video.dri.devel/117727

Regards
Andrzej


> 
> Signed-off-by: Grant Likely <grant.likely@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  drivers/of/platform.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 3b64d0bf5bba..7c6771986c06 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -138,7 +138,7 @@ struct platform_device *of_device_alloc(struct device_node *np,
>  	}
>  
>  	dev->dev.of_node = of_node_get(np);
> -	dev->dev.parent = parent;
> +	dev->dev.parent = parent ? : &platform_bus;
>  
>  	if (bus_id)
>  		dev_set_name(&dev->dev, "%s", bus_id);
> @@ -291,7 +291,7 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
>  
>  	/* setup generic device info */
>  	dev->dev.of_node = of_node_get(node);
> -	dev->dev.parent = parent;
> +	dev->dev.parent = parent ? : &platform_bus;
>  	dev->dev.platform_data = platform_data;
>  	if (bus_id)
>  		dev_set_name(&dev->dev, "%s", bus_id);
> 
