Return-Path: <daniel.lezcano@linaro.org>
Received: from mail-wg0-f46.google.com (mail-wg0-f46.google.com [74.125.82.46])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 883BB2C00B3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2013 19:28:18 +1000 (EST)
Received: by mail-wg0-f46.google.com with SMTP id k13so5692564wgh.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2013 02:28:14 -0700 (PDT)
Message-ID: <51F7872F.30101@linaro.org>
Date: Tue, 30 Jul 2013 11:28:15 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
MIME-Version: 1.0
To: Dongsheng Wang <dongsheng.wang@freescale.com>
Subject: Re: [PATCH] cpuidle: fix unremovable issue for module driver
References: <1375167319-12821-1-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1375167319-12821-1-git-send-email-dongsheng.wang@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: rjw@sisk.pl, linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/30/2013 08:55 AM, Dongsheng Wang wrote:
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
> 
> After __cpuidle_register_device, the cpu incs are added up, but decs
> are not, thus the module refcount is not match. So the module "exit"
> function can not be executed when we do remove operation. Move
> module_put into __cpuidle_register_device to fix it.

Sorry, I still don't get it :/

register->module_get
unregister->module_put

you change it by:

register->module_get
register->module_put
unregister->none

which is wrong.

Can you describe the problem you are facing ? (a bit more than "I can't
unload the module").

> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> 
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index d75040d..e964ada 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -351,11 +351,8 @@ EXPORT_SYMBOL_GPL(cpuidle_disable_device);
>  
>  static void __cpuidle_unregister_device(struct cpuidle_device *dev)
>  {
> -	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
> -
>  	list_del(&dev->device_list);
>  	per_cpu(cpuidle_devices, dev->cpu) = NULL;
> -	module_put(drv->owner);
>  }
>  
>  static int __cpuidle_device_init(struct cpuidle_device *dev)
> @@ -384,6 +381,8 @@ static int __cpuidle_register_device(struct cpuidle_device *dev)
>  	per_cpu(cpuidle_devices, dev->cpu) = dev;
>  	list_add(&dev->device_list, &cpuidle_detected_devices);
>  
> +	module_put(drv->owner);
> +
>  	ret = cpuidle_coupled_register_device(dev);
>  	if (ret) {
>  		__cpuidle_unregister_device(dev);
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
