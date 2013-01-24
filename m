Return-Path: <tomasz.figa@gmail.com>
Received: from mail-ee0-f41.google.com (mail-ee0-f41.google.com [74.125.83.41])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D1CD42C0085
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2013 05:57:51 +1100 (EST)
Received: by mail-ee0-f41.google.com with SMTP id c13so4939435eek.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jan 2013 10:57:48 -0800 (PST)
From: Tomasz Figa <tomasz.figa@gmail.com>
To: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/PATCH 01/32] usb: gadget: udc-core: allow udc class register
 gadget device
Date: Thu, 24 Jan 2013 19:57:46 +0100
Message-ID: <1398457.8gfxIXvJd7@flatron>
In-Reply-To: <1359042370-4358-2-git-send-email-balbi@ti.com>
References: <1359042370-4358-1-git-send-email-balbi@ti.com>
 <1359042370-4358-2-git-send-email-balbi@ti.com>
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

On Thursday 24 of January 2013 17:45:39 Felipe Balbi wrote:
> Currently all UDC drivers are calling
> device_register() before calling
> usb_add_gadget_udc(). In order to avoid
> code duplication, we can allow udc-core.c
> register that device.
> 
> However that would become a really large patch,
> so to cope with the meanwhile and allow us
> to write bite-sized patches, we're adding
> a flag which will be set by UDC driver once
> it removes the code for registering the
> gadget device.
> 
> Once all are converted, the new flag will
> be removed.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/usb/gadget/udc-core.c | 23 +++++++++++++++++++----
>  include/linux/usb/gadget.h    |  4 ++++
>  2 files changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc-core.c
> b/drivers/usb/gadget/udc-core.c index 2a9cd36..9195054 100644
> --- a/drivers/usb/gadget/udc-core.c
> +++ b/drivers/usb/gadget/udc-core.c
> @@ -173,6 +173,14 @@ int usb_add_gadget_udc(struct device *parent,
> struct usb_gadget *gadget) if (!udc)
>  		goto err1;
> 
> +	if (gadget->register_my_device) {
> +		dev_set_name(&gadget->dev, "gadget");
> +
> +		ret = device_register(&gadget->dev);
> +		if (ret)
> +			goto err2;
> +	}
> +
>  	device_initialize(&udc->dev);
>  	udc->dev.release = usb_udc_release;
>  	udc->dev.class = udc_class;
> @@ -180,7 +188,7 @@ int usb_add_gadget_udc(struct device *parent, struct
> usb_gadget *gadget) udc->dev.parent = parent;
>  	ret = dev_set_name(&udc->dev, "%s", kobject_name(&parent->kobj));
>  	if (ret)
> -		goto err2;
> +		goto err3;

Just a nitpick: If you are at changing labels of error path, wouldn't it 
be better to give them some meaningful names? Like err_del_unlock, 
err_put_udc, err_put_gadget, err_ret.

Otherwise looks good. Nice idea.

Reviewed-by: Tomasz Figa <tomasz.figa@gmail.com>

Best regards,
Tomasz Figa

>  	udc->gadget = gadget;
> 
> @@ -189,18 +197,22 @@ int usb_add_gadget_udc(struct device *parent,
> struct usb_gadget *gadget)
> 
>  	ret = device_add(&udc->dev);
>  	if (ret)
> -		goto err3;
> +		goto err4;
> 
>  	mutex_unlock(&udc_lock);
> 
>  	return 0;
> -err3:
> +
> +err4:
>  	list_del(&udc->list);
>  	mutex_unlock(&udc_lock);
> 
> -err2:
> +err3:
>  	put_device(&udc->dev);
> 
> +err2:
> +	if (gadget->register_my_device)
> +		put_device(&gadget->dev);
>  err1:
>  	return ret;
>  }
> @@ -254,6 +266,9 @@ found:
> 
>  	kobject_uevent(&udc->dev.kobj, KOBJ_REMOVE);
>  	device_unregister(&udc->dev);
> +
> +	if (gadget->register_my_device)
> +		device_unregister(&gadget->dev);
>  }
>  EXPORT_SYMBOL_GPL(usb_del_gadget_udc);
> 
> diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
> index 2e297e8..fcd9ef8 100644
> --- a/include/linux/usb/gadget.h
> +++ b/include/linux/usb/gadget.h
> @@ -494,6 +494,9 @@ struct usb_gadget_ops {
>   *	only supports HNP on a different root port.
>   * @b_hnp_enable: OTG device feature flag, indicating that the A-Host
>   *	enabled HNP support.
> + * @register_my_device: Flag telling udc-core that UDC driver didn't
> + *	register the gadget device to the driver model. Temporary until
> + *	all UDC drivers are fixed up properly.
>   * @name: Identifies the controller hardware type.  Used in diagnostics
> *	and sometimes configuration.
>   * @dev: Driver model state for this abstract device.
> @@ -531,6 +534,7 @@ struct usb_gadget {
>  	unsigned			b_hnp_enable:1;
>  	unsigned			a_hnp_support:1;
>  	unsigned			a_alt_hnp_support:1;
> +	unsigned			register_my_device:1;
>  	const char			*name;
>  	struct device			dev;
>  	unsigned			out_epnum;
