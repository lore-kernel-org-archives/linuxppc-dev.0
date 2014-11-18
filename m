Return-Path: <glikely@secretlab.ca>
Received: from mail-wi0-f181.google.com (mail-wi0-f181.google.com
 [209.85.212.181])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 97FE01A04EB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Nov 2014 03:10:47 +1100 (AEDT)
Received: by mail-wi0-f181.google.com with SMTP id r20so6732692wiv.14
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 08:10:41 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH] of/platform: Move platform devices
 =?iso-8859-1?Q?under=0D?= /sys/devices/platform
To: Andrzej Hajda <a.hajda@samsung.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
In-Reply-To: <546B2123.7060406@samsung.com>
References: <1415097920-30014-1-git-send-email-grant.likely@linaro.org>
 <546B2123.7060406@samsung.com>
Date: Tue, 18 Nov 2014 16:10:38 +0000
Message-Id: <20141118161038.192B7C40966@trevor.secretlab.ca>
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

On Tue, 18 Nov 2014 11:36:19 +0100
, Andrzej Hajda <a.hajda@samsung.com>
 wrote:
> On 11/04/2014 11:45 AM, Grant Likely wrote:
> > Currently the devices created by drivers/of/platform.c get created at
> > the root of /sys/devices. This goes against the typical pattern for
> > sysfs where the top level /sys/devices structure contains categories of
> > devices, and the structure of devices is placed below that. To fix this,
> > make the code in drivers/of/platform.c follow the drivers/base/platform.c
> > behaviour, and use &platform_bus as the default parent for all new
> > platform_devices and amba_devices.
> > 
> > This change has been discussed for a long time, but nobody has actually
> > acted on it. Userspace code that expects to find devices under a fixed
> > /sys/devices/... path will be affected. It isn't /supposed/ to do that,
> > but if anyone complains then I'll add a default-off workaround option to
> > put them back into the root.
> 
> One of side effects of this change is that platform drivers registering
> other platform drivers or devices in their probe callback can deadlock
> due to double device_lock on platform device. This is for example case
> of exynos_drm driver[1]. I guess it could/should be fixed in exynos_drm.
> Anyway it can affect other drivers as well. At least grep shows few
> possible candidates:

What on earth is that driver doing registering additional drivers in the
probe hook?!? That's madness, and should be treated as a bug.

g.

> 
> $ git grep -p platform_driver_register | grep -A1 -P '_probe\(struct
> platform_device'
> 
> drivers/gpu/drm/exynos/exynos_drm_drv.c=static int
> exynos_drm_platform_probe(struct platform_device *pdev)
> drivers/gpu/drm/exynos/exynos_drm_drv.c:	ret =
> platform_driver_register(&fimd_driver);
> --
> drivers/gpu/drm/sti/sti_drm_drv.c=static int
> sti_drm_platform_probe(struct platform_device *pdev)
> drivers/gpu/drm/sti/sti_drm_drv.c:
> platform_driver_register(&sti_drm_master_driver);
> --
> drivers/mtd/nand/atmel_nand.c=static int atmel_nand_probe(struct
> platform_device *pdev)
> drivers/mtd/nand/atmel_nand.c:	res =
> platform_driver_register(&atmel_nand_nfc_driver);
> 
> 
> [1]: http://permalink.gmane.org/gmane.comp.video.dri.devel/117727
> 
> Regards
> Andrzej
> 
> 
> > 
> > Signed-off-by: Grant Likely <grant.likely@linaro.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > ---
> >  drivers/of/platform.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> > index 3b64d0bf5bba..7c6771986c06 100644
> > --- a/drivers/of/platform.c
> > +++ b/drivers/of/platform.c
> > @@ -138,7 +138,7 @@ struct platform_device *of_device_alloc(struct device_node *np,
> >  	}
> >  
> >  	dev->dev.of_node = of_node_get(np);
> > -	dev->dev.parent = parent;
> > +	dev->dev.parent = parent ? : &platform_bus;
> >  
> >  	if (bus_id)
> >  		dev_set_name(&dev->dev, "%s", bus_id);
> > @@ -291,7 +291,7 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
> >  
> >  	/* setup generic device info */
> >  	dev->dev.of_node = of_node_get(node);
> > -	dev->dev.parent = parent;
> > +	dev->dev.parent = parent ? : &platform_bus;
> >  	dev->dev.platform_data = platform_data;
> >  	if (bus_id)
> >  		dev_set_name(&dev->dev, "%s", bus_id);
> > 
> 
