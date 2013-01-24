Return-Path: <tomasz.figa@gmail.com>
Received: from mail-ee0-f45.google.com (mail-ee0-f45.google.com [74.125.83.45])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5002C2C007E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2013 06:00:10 +1100 (EST)
Received: by mail-ee0-f45.google.com with SMTP id b57so4693148eek.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jan 2013 11:00:07 -0800 (PST)
From: Tomasz Figa <tomasz.figa@gmail.com>
To: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/PATCH 24/32] usb: gadget: s3c-hsotg: let udc-core manage
 gadget->dev
Date: Thu, 24 Jan 2013 20:00:05 +0100
Message-ID: <5963888.Uco7z1jaqo@flatron>
In-Reply-To: <1359042370-4358-25-git-send-email-balbi@ti.com>
References: <1359042370-4358-1-git-send-email-balbi@ti.com>
 <1359042370-4358-25-git-send-email-balbi@ti.com>
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

On Thursday 24 of January 2013 17:46:02 Felipe Balbi wrote:
> By simply setting a flag, we can drop some
> boilerplate code.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/usb/gadget/s3c-hsotg.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
> 
> diff --git a/drivers/usb/gadget/s3c-hsotg.c
> b/drivers/usb/gadget/s3c-hsotg.c index 833d85b..bd8292d 100644
> --- a/drivers/usb/gadget/s3c-hsotg.c
> +++ b/drivers/usb/gadget/s3c-hsotg.c
> @@ -3552,17 +3552,13 @@ static int s3c_hsotg_probe(struct
> platform_device *pdev)
> 
>  	dev_info(dev, "regs %p, irq %d\n", hsotg->regs, hsotg->irq);
> 
> -	device_initialize(&hsotg->gadget.dev);
> -
> -	dev_set_name(&hsotg->gadget.dev, "gadget");
> -
>  	hsotg->gadget.max_speed = USB_SPEED_HIGH;
>  	hsotg->gadget.ops = &s3c_hsotg_gadget_ops;
>  	hsotg->gadget.name = dev_name(dev);
> -
>  	hsotg->gadget.dev.parent = dev;
>  	hsotg->gadget.dev.dma_mask = dev->dma_mask;
>  	hsotg->gadget.dev.release = s3c_hsotg_release;
> +	hsotg->gadget.register_my_device = true;
> 
>  	/* reset the system */
> 
> @@ -3643,12 +3639,6 @@ static int s3c_hsotg_probe(struct platform_device
> *pdev)
> 
>  	s3c_hsotg_phy_disable(hsotg);
> 
> -	ret = device_add(&hsotg->gadget.dev);
> -	if (ret) {
> -		put_device(&hsotg->gadget.dev);
> -		goto err_ep_mem;
> -	}
> -
>  	ret = usb_add_gadget_udc(&pdev->dev, &hsotg->gadget);
>  	if (ret)
>  		goto err_ep_mem;
> @@ -3687,10 +3677,8 @@ static int s3c_hsotg_remove(struct
> platform_device *pdev) }
> 
>  	s3c_hsotg_phy_disable(hsotg);
> -
>  	clk_disable_unprepare(hsotg->clk);
> 
> -	device_unregister(&hsotg->gadget.dev);
>  	return 0;
>  }

Looks good.

Reviewed-by: Tomasz Figa <tomasz.figa@gmail.com>

Best regards,
Tomasz Figa
