Return-Path: <tomasz.figa@gmail.com>
Received: from mail-ea0-f179.google.com (mail-ea0-f179.google.com
 [209.85.215.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B9F1D2C009B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2013 05:52:59 +1100 (EST)
Received: by mail-ea0-f179.google.com with SMTP id d12so3200767eaa.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jan 2013 10:52:55 -0800 (PST)
From: Tomasz Figa <tomasz.figa@gmail.com>
To: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/PATCH 32/32] usb: gadget: drop now unnecessary flag
Date: Thu, 24 Jan 2013 19:52:52 +0100
Message-ID: <2268214.yJrDJgELNj@flatron>
In-Reply-To: <1359042370-4358-33-git-send-email-balbi@ti.com>
References: <1359042370-4358-1-git-send-email-balbi@ti.com>
 <1359042370-4358-33-git-send-email-balbi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: kgene.kim@samsung.com, eric.y.miao@gmail.com,
 kuninori.morimoto.gx@renesas.com, alexander.shishkin@linux.intel.com,
 gregkh@linuxfoundation.org, yoshihiro.shimoda.uh@renesas.com,
 Linux USB Mailing List <linux-usb@vger.kernel.org>, nicolas.ferre@atmel.com,
 linux-geode@lists.infradead.org, haojian.zhuang@gmail.com,
 Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
 linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org,
 dahlmann.thomas@arcor.de, linux@arm.linux.org.uk,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Felipe,

On Thursday 24 of January 2013 17:46:10 Felipe Balbi wrote:
> We don't need the ->register_my_device flag
> anymore because all UDC drivers have been
> properly converted.
> 
> Let's remove every history of it.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/usb/chipidea/udc.c             | 1 -
>  drivers/usb/dwc3/gadget.c              | 1 -
>  drivers/usb/gadget/amd5536udc.c        | 1 -
>  drivers/usb/gadget/at91_udc.c          | 1 -
>  drivers/usb/gadget/atmel_usba_udc.c    | 1 -
>  drivers/usb/gadget/bcm63xx_udc.c       | 1 -
>  drivers/usb/gadget/dummy_hcd.c         | 1 -
>  drivers/usb/gadget/fsl_qe_udc.c        | 1 -
>  drivers/usb/gadget/fsl_udc_core.c      | 1 -
>  drivers/usb/gadget/fusb300_udc.c       | 1 -
>  drivers/usb/gadget/goku_udc.c          | 1 -
>  drivers/usb/gadget/imx_udc.c           | 1 -
>  drivers/usb/gadget/lpc32xx_udc.c       | 1 -
>  drivers/usb/gadget/m66592-udc.c        | 1 -
>  drivers/usb/gadget/mv_u3d_core.c       | 1 -
>  drivers/usb/gadget/mv_udc_core.c       | 1 -
>  drivers/usb/gadget/net2272.c           | 1 -
>  drivers/usb/gadget/net2280.c           | 1 -
>  drivers/usb/gadget/omap_udc.c          | 1 -
>  drivers/usb/gadget/pch_udc.c           | 1 -
>  drivers/usb/gadget/pxa25x_udc.c        | 1 -
>  drivers/usb/gadget/pxa27x_udc.c        | 1 -
>  drivers/usb/gadget/r8a66597-udc.c      | 1 -
>  drivers/usb/gadget/s3c-hsotg.c         | 1 -
>  drivers/usb/gadget/s3c-hsudc.c         | 1 -
>  drivers/usb/gadget/s3c2410_udc.c       | 1 -
>  drivers/usb/gadget/udc-core.c          | 3 ---
>  drivers/usb/musb/musb_gadget.c         | 1 -
>  drivers/usb/renesas_usbhs/mod_gadget.c | 1 -
>  include/linux/usb/gadget.h             | 4 ----
>  30 files changed, 35 deletions(-)
> 
[snip]
> diff --git a/drivers/usb/gadget/udc-core.c
> b/drivers/usb/gadget/udc-core.c index 9195054..4ee0efc 100644
> --- a/drivers/usb/gadget/udc-core.c
> +++ b/drivers/usb/gadget/udc-core.c
> @@ -173,7 +173,6 @@ int usb_add_gadget_udc(struct device *parent, struct
> usb_gadget *gadget) if (!udc)
>  		goto err1;
> 
> -	if (gadget->register_my_device) {
>  		dev_set_name(&gadget->dev, "gadget");
> 
>  		ret = device_register(&gadget->dev);
> @@ -211,7 +210,6 @@ err3:
>  	put_device(&udc->dev);
> 
>  err2:
> -	if (gadget->register_my_device)
>  		put_device(&gadget->dev);
>  err1:
>  	return ret;
> @@ -267,7 +265,6 @@ found:
>  	kobject_uevent(&udc->dev.kobj, KOBJ_REMOVE);
>  	device_unregister(&udc->dev);
> 
> -	if (gadget->register_my_device)
>  		device_unregister(&gadget->dev);

Correct me if I am wrong, but doesn't this patch leave us with incorrect 
indentation?

Otherwise looks good.

Best regards,
Tomasz Figa
